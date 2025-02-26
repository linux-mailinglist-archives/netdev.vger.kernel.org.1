Return-Path: <netdev+bounces-169995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFDA46D13
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482131887619
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475F257438;
	Wed, 26 Feb 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8Qti8+0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512325333F
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604218; cv=none; b=SxZrvG+DlQ2JUGP1aR4aNsm6ieXoV7pHhdzhtRiz87JTeVzP5Up+M6Rsv2jHLpmqKphaTtzAdfZ+wUIbUI8WoSLlr++Z4VqX8iewd0OHNyGnImy8QNoXUfWDAOk/OYnawFeuGCUpHZrG4M1ld4Zduvfh1z0yHBWHnrJytG9rOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604218; c=relaxed/simple;
	bh=nBdGbQ7sksHO1rpAE/hUy+rxPb4XSIlU0+wSo+21w5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSn7bINff5VrAXJ/ZIJa/dTn4K9z7nT9plnDJc9G33gsbu0JJNcBFe5HiJEYtxzrdpK3HjfbNsE66THLW+ibB7guPc+cOVPzcY9X9xgP+SEAvjMpmIk6f+CockIhoR0MhfLpt+3AKAL+xBgsv6myQAK6me0wkUKCo5dn+Ex8IQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8Qti8+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12849C4CED6;
	Wed, 26 Feb 2025 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604218;
	bh=nBdGbQ7sksHO1rpAE/hUy+rxPb4XSIlU0+wSo+21w5k=;
	h=From:To:Cc:Subject:Date:From;
	b=p8Qti8+0OaYJFKh3moXMRFY70orkrB/kWXc4AYUmVJfyr192LEeqfrrz7jJGOTQl8
	 pmD9SBm7IKw0eaO+WeCmO/OruhqsZ/CH5wC9qcMQm77ya0AD9YbwfAk2ZfETHH//4u
	 XSIw9FBCs6g0Rwc2I1mK+K+ruum1ouOM1nyobGcdlKDRu4mQPmuFblg8V0gtEQJsOs
	 FlMvlrj+HlCUv73G1YBEJ09AVNiTy2uGQ8g1J9ugtA3BGv264lP7oyXITQA91mwyZb
	 EvSBiIicWd3sGXKK60ptybSdOmR4Ffp5uQwX8Lzl3ibQWLca/juBZ2s7PBqMPuyyPI
	 dJOfVQbYewg0A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/9] eth: bnxt: maintain basic pkt/byte counters in SW
Date: Wed, 26 Feb 2025 13:09:54 -0800
Message-ID: <20250226211003.2790916-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some workloads want to be able to track bandwidth utilization on
the scale of 10s of msecs. bnxt uses HW stats and async stats
updates, with update frequency controlled via ethtool -C.
Updating all HW stats more often than 100 msec is both hard for
the device and consumes PCIe bandwidth. Switch to maintaining
basic Rx / Tx packet and byte counters in SW.

Tested with drivers/net/stats.py:
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Manually tested by comparing the ethtool -S stats (which continues
to show HW stats) with qstats, and total interface stats.
With and without HW-GRO, and with XDP on / off.
Stopping and starting the interface also doesn't corrupt the values. 

Jakub Kicinski (9):
  eth: bnxt: use napi_consume_skb()
  eth: bnxt: don't run xdp programs on fallback traffic
  eth: bnxt: rename ring_err_stats -> ring_drv_stats
  eth: bnxt: snapshot driver stats
  eth: bnxt: don't use ifdef to check for CONFIG_INET in GRO
  eth: bnxt: consolidate the GRO-but-not-really paths in bnxt_gro_skb()
  eth: bnxt: maintain rx pkt/byte stats in SW
  eth: bnxt: maintain tx pkt/byte stats in SW
  eth: bnxt: count xdp xmit packets

 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  31 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 240 ++++++++++++------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  15 ++
 4 files changed, 208 insertions(+), 92 deletions(-)

-- 
2.48.1


