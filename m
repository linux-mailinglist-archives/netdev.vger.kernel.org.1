Return-Path: <netdev+bounces-153550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EC09F8A42
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891AF1892DDF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1BE22339;
	Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c08qQpJa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51953AC
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663169; cv=none; b=ej9IleKUny19sdGCIaTNpacR4eZgr5j8LqtAgdbgVAoPUDh/KuTFRND1K1k5P2qhk5umE17q3n3WTnowXrkbaP7SUxIM7eB7faL/h7MZdcjyFVtLTMlxGr7k/FNYdRKWSKVtIulhF76D5KWsMecjclF5l3i3K2XAIIs5P+E/nuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663169; c=relaxed/simple;
	bh=dcQ+9GqKcZv4R+5wy3DsGsSG+q8Y7zz2A0FDfrIjxyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXqjVi7voVQAfcg95GptnLHuQIbdE8+bVveIZukIo76KSen2y8fE+cfcZ5GdnywrLvoBe5zkfHE7EPgv/Bf+53hPEVVhCA2Yw3HIlnaNA9qwMIkRM4NugKpg//9+leBGsymL0SVex9gTelnco5MoxdJCLC3mb26LjvC7B4xG7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c08qQpJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B43BC4CECE;
	Fri, 20 Dec 2024 02:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663168;
	bh=dcQ+9GqKcZv4R+5wy3DsGsSG+q8Y7zz2A0FDfrIjxyU=;
	h=From:To:Cc:Subject:Date:From;
	b=c08qQpJaOk6ddd1DNeIUUlrXNUxbPrVCUi1TWJvTB0Sdj3CuA1453kh6tht8eu6Xr
	 SpaWXqJ55wHVxBrChkeuBzfaWKndSXk87YqAC8O2uAtAmbUAj5UzI4ZZKq0rzS66nr
	 wBIZaLH7ptZpYiX6O7iBCAeiLSNwEYCOQH9sKyHnArhNaNx7OcVMOVH/pbKSdYDuo4
	 WZ97F2thwD6jYs0jc6HXtw+AYu4LSZWVsAzTY+Cj1sx0/656rge0wltKOBqOqoKR5i
	 rTX4LktnxU3MUcsrlywZNslkJDXn9dxKKG2i5SQsfu6YQCrFmpL9Zi6XKeJps2Y7HX
	 mLOJ4NIMov+dQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/10] eth: fbnic: support basic RSS config and setting channel count
Date: Thu, 19 Dec 2024 18:52:31 -0800
Message-ID: <20241220025241.1522781-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for basic RSS config (indirection table, key get and set),
and changing the number of channels.

  # ./ksft-net-drv/run_kselftest.sh -t drivers/net/hw:rss_ctx.py
  TAP version 13
  1..1
  # timeout set to 0
  # selftests: drivers/net/hw: rss_ctx.py
  # KTAP version 1
  # 1..15
  # ok 1 rss_ctx.test_rss_key_indir
  # ok 2 rss_ctx.test_rss_queue_reconfigure
  # ok 3 rss_ctx.test_rss_resize
  # ok 4 rss_ctx.test_hitless_key_update

  .. the rest of the tests are for additional contexts so they
  get skipped..

The slicing of the patches (and bugs) are mine, but I'm keeping
Alex as the author on the patches where he wrote 100% of the code.

Alexander Duyck (4):
  eth: fbnic: support querying RSS config
  eth: fbnic: support setting RSS configuration
  eth: fbnic: let user control the RSS hash fields
  eth: fbnic: centralize the queue count and NAPI<>queue setting

Jakub Kicinski (6):
  eth: fbnic: reorder ethtool code
  eth: fbnic: don't reset the secondary RSS indir table
  eth: fbnic: store NAPIs in an array instead of the list
  eth: fbnic: add IRQ reuse support
  eth: fbnic: support ring channel get and set while down
  eth: fbnic: support ring channel set while up

 drivers/net/ethernet/meta/fbnic/fbnic.h       |  15 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 551 +++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  53 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  12 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   7 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   7 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 236 ++++----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  16 +-
 9 files changed, 699 insertions(+), 200 deletions(-)

-- 
2.47.1


