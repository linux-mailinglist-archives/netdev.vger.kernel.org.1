Return-Path: <netdev+bounces-163710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E8A2B6D4
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D946166055
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C510A23A572;
	Thu,  6 Feb 2025 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWk+S3YJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761522FF41
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886019; cv=none; b=AyUcmQGCG7+w3PmThJEIVmXXuPB8K9g+0NaNkD1rko5u2N3gyaL0v7kns0FeAgTf/hvZJo7KHH5mCo4Gg8OBbJBLoWtk+BEdc09FkJGTrjkXwtKho8iMjccc2iPpasz+6vlGAkm3hSJZgfUXAMgnkIIkRIWvt8OR2QeILRcqfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886019; c=relaxed/simple;
	bh=ckUQo5kA5rfDBQFnMtmWsNyxuB3IW3Zdsa/ks0048J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWv0GVW3vjBkHOXRrqLD5olndNdD1PIr64RFZtF7lZUdPEb+uDfYtUCuLk59G5/NdrRBCKCJanu9B+eui6oYmO8FXrG1SoAWZNZZU9rMoYd/z7IwfVNUzArqLWmMntb58QOpLhyTc5PYaTX3Hq7dRzj7kXQn5tHuGNNFUDbTh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWk+S3YJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B854EC4CEDD;
	Thu,  6 Feb 2025 23:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738886019;
	bh=ckUQo5kA5rfDBQFnMtmWsNyxuB3IW3Zdsa/ks0048J8=;
	h=From:To:Cc:Subject:Date:From;
	b=LWk+S3YJWX80EQT/qogv2EWKvFCUNDyAbhGY5SSzca0FmNPoH+gw2A5TOpbqCfGjS
	 4N5a6Byl+JzWVFS7TO0CApNHg0yEjsR9fu5bLnc+n4R3A2UZ/Shnxa1YZmNxaPY0p4
	 6ZvR75S0GcJvK8u+0hMS3JKWorhG9zsCi/4zc2cTaAGqsiZInQ976vMkWwN2sdbSPS
	 v4Mn1OpYF338BIiKWKlR7v4gU1p5xXJMpZaJMKZAJFTp86L+/wMuiqf+5XxDy0nVSy
	 DLHMdfdaFYqAIFd2pgb6uxRwqvqhtB970DhiRBGauj07pvucM9d/6FvPg1pNZhOWZs
	 W8Uq8hsXNVBXg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/7] eth: fbnic: support RSS contexts and ntuple filters
Date: Thu,  6 Feb 2025 15:53:27 -0800
Message-ID: <20250206235334.1425329-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for RSS contexts and ntuple filters in fbnic.
The device has only one context, intended for use by TCP zero-copy Rx.

First two patches add a check we seem to be missing in the core,
to avoid having to copy it to all drivers.

  $ ./drivers/net/hw/rss_ctx.py
  KTAP version 1
  1..16
  ok 1 rss_ctx.test_rss_key_indir
  ok 2 rss_ctx.test_rss_queue_reconfigure
  ok 3 rss_ctx.test_rss_resize
  ok 4 rss_ctx.test_hitless_key_update
  ok 5 rss_ctx.test_rss_context
  # Failed to create context 2, trying to test what we got
  ok 6 rss_ctx.test_rss_context4 # SKIP Tested only 1 contexts, wanted 4
  # Increasing queue count 44 -> 66
  # Failed to create context 2, trying to test what we got
  ok 7 rss_ctx.test_rss_context32 # SKIP Tested only 1 contexts, wanted 32
  # Added only 1 out of 3 contexts
  ok 8 rss_ctx.test_rss_context_dump
  # Driver does not support rss + queue offset
  ok 9 rss_ctx.test_rss_context_queue_reconfigure
  ok 10 rss_ctx.test_rss_context_overlap
  ok 11 rss_ctx.test_rss_context_overlap2 # SKIP Test requires at least 2 contexts, but device only has 1
  ok 12 rss_ctx.test_rss_context_out_of_order # SKIP Test requires at least 4 contexts, but device only has 1
  # Failed to create context 2, trying to test what we got
  ok 13 rss_ctx.test_rss_context4_create_with_cfg # SKIP Tested only 1 contexts, wanted 4
  ok 14 rss_ctx.test_flow_add_context_missing
  ok 15 rss_ctx.test_delete_rss_context_busy
  ok 16 rss_ctx.test_rss_ntuple_addition # SKIP Ntuple filter with RSS and nonzero action not supported
  # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:6 error:0

Alexander Duyck (3):
  eth: fbnic: add IP TCAM programming
  eth: fbnic: support n-tuple filters
  eth: fbnic: support listing tcam content via debugfs

Daniel Zahka (1):
  eth: fbnic: support an additional RSS context

Jakub Kicinski (3):
  net: ethtool: prevent flow steering to RSS contexts which don't exist
  selftests: net-drv: test adding flow rule to invalid RSS context
  selftests: drv-net: rss_ctx: skip tests which need multiple contexts
    cleanly

 drivers/net/ethernet/meta/fbnic/fbnic.h       |   6 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   6 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |  35 +
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 138 ++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 705 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   | 356 ++++++++-
 net/ethtool/ioctl.c                           |  12 +-
 .../selftests/drivers/net/hw/rss_ctx.py       |  46 +-
 9 files changed, 1294 insertions(+), 11 deletions(-)

-- 
2.48.1


