Return-Path: <netdev+bounces-112877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4693B919
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 00:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD91F281627
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C7113B2B0;
	Wed, 24 Jul 2024 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X0R3guBw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C213A412
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859703; cv=none; b=sn83R6UlM9xGSRd8332O17I5K7jfyLnLCd/VPNUK//IhOBT/7zoEm3YmJZYQubkRV2ZxYSp4u2ynBKqP9P/akG3PgmF9U5P2/BzeDW6KCxdnux9kcR/zaNWemLNWaI+EJXm7YeF+8DozXwHrOP/GyA2y2E5bF5IdABEC1wSaXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859703; c=relaxed/simple;
	bh=M8Ukorx5J6tA2bqKe8hDq6AjhiwrMDQDjZnjtyxjB6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPLpRoxpSdlYalC2luBJNzUnu4FTXg2eQCPT6L4qQbIxkZDJpsidu1f9qOd3O1n0RvMbAiGrjYe/OMABWcoP6dZjAi58defzzUti6Urk/9wVQP4eIC8X2UzV6yiMXzPeRPM3UiTuUiGfMInLndCOjWG2nxUY+3WTaZ7fGKKaMg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X0R3guBw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so244550a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721859701; x=1722464501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPHjRkwe9DFAK6Tgj9UFIlxOjXwkibgW9P2pdkgnuVU=;
        b=X0R3guBw6yHvVD9677Mhz459ztwUIbnwkyreT36ASDqujpu8VItOnKtdeM+cDu9uhc
         +/Fy2ov6cLyVExaeA0U4h2Z16KeYciFa7L7kqNftptFz9wfpmYUzmY3l0omlQjLcG+f9
         5SDOm86KMnSmN2H/cXYDS5I380xpk/O3q5DPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859701; x=1722464501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPHjRkwe9DFAK6Tgj9UFIlxOjXwkibgW9P2pdkgnuVU=;
        b=fN28I17urzUbUjQri7pe68UeYuWN6nofUoqZ/PAKgnEowUAOM04g37yy2rmXcIf9sL
         /sRzYiyzmyiK+GJOxW4XxTY6MpCFJBJHMOACdsbX6vgKA7UTdQ8wokExKFaKIm+2+6jc
         Poo2KVYmHfDoKHxvLw6fJZGKEy5kG8nwRS1ehe60iNa0v3f4BZn5u9iCli3oLFB8vOdf
         QwDM16mptv8IjetvHTLXd5ab1EZQ+E8K5FrvAMGBxXTmMjAWgFu+HP+phO+IOxCRqLTI
         jzhvnJLGmjYunhGirGsJUWGTYDVN7mXgFs8HXKZVS4x5f5YErzbgSAPcHD/UXc8g+O1z
         nGrQ==
X-Gm-Message-State: AOJu0Yyp6Je+yuhLA6feLrvFCxO10fkO2C1kjCb2f8AGB6X/AOstbw5t
	DOaF5fueVt+8R2HI0RsSFFtVS5uvitzvAVeSpZZyDreWlDyPulALsaofNY0Ynk1XAuXfia/sxDc
	=
X-Google-Smtp-Source: AGHT+IHsfHs6F9iNK9ezLWh/OuOeekuWla1m+aEA0T0hBtKnjWEv+rgQTCdFtTFGntXofcgxjTKErA==
X-Received: by 2002:a17:90a:fe97:b0:2c9:6f06:8009 with SMTP id 98e67ed59e1d1-2cf2380cbd6mr1123366a91.1.1721859700327;
        Wed, 24 Jul 2024 15:21:40 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c9da78sm161447a91.28.2024.07.24.15.21.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2024 15:21:39 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH] bnxt_en: Fix RSS logic in __bnxt_reserve_rings()
Date: Wed, 24 Jul 2024 15:21:06 -0700
Message-ID: <20240724222106.147744-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

In __bnxt_reserve_rings(), the existing code unconditionally sets the
default RSS indirection table to default if netif_is_rxfh_configured()
returns false.  This used to be correct before we added RSS contexts
support.  For example, if the user is changing the number of ethtool
channels, we will enter this path to reserve the new number of rings.
We will then set the RSS indirection table to default to cover the new
number of rings if netif_is_rxfh_configured() is false.

Now, with RSS contexts support, if the user has added or deleted RSS
contexts, we may now enter this path to reserve the new number of VNICs.
However, netif_is_rxfh_configured() will not return the correct state if
we are still in the middle of set_rxfh().  So the existing code may
set the indirection table of the default RSS context to default by
mistake.

Fix it to check if the reservation of the RX rings is changing.  Only
check netif_is_rxfh_configured() if it is changing.  RX rings will not
change in the middle of set_rxfh() and this will fix the issue.

Fixes: b3d0083caf9a ("bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bb3be33c1bbd..f788f114e430 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7648,8 +7648,8 @@ static int bnxt_get_avail_msix(struct bnxt *bp, int num);
 static int __bnxt_reserve_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_rings hwr = {0};
+	int rx_rings, old_rx_rings, rc;
 	int cp = bp->cp_nr_rings;
-	int rx_rings, rc;
 	int ulp_msix = 0;
 	bool sh = false;
 	int tx_cp;
@@ -7683,6 +7683,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	hwr.grp = bp->rx_nr_rings;
 	hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	hwr.stat = bnxt_get_func_stat_ctxs(bp);
+	old_rx_rings = bp->hw_resc.resv_rx_rings;
 
 	rc = bnxt_hwrm_reserve_rings(bp, &hwr);
 	if (rc)
@@ -7737,7 +7738,8 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (!bnxt_rings_ok(bp, &hwr))
 		return -ENOMEM;
 
-	if (!netif_is_rxfh_configured(bp->dev))
+	if (old_rx_rings != bp->hw_resc.resv_rx_rings &&
+	    !netif_is_rxfh_configured(bp->dev))
 		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
 
 	if (!bnxt_ulp_registered(bp->edev) && BNXT_NEW_RM(bp)) {
-- 
2.30.1


