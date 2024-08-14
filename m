Return-Path: <netdev+bounces-118657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE8952603
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B681C21206
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF814A098;
	Wed, 14 Aug 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BRPsYrEa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B663146A7D
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676094; cv=none; b=hSz+Qny3j4m6EJJwPCkvKUG+u5DFJZn4Z4mHKRSXQt43R3WYYQ316DQmQGKRFqIvayaifUyOFul3/M1RhOcZrEj5E6OrpH/d+GAhVGhTWId3OQMWDt1oJeqU4RWfwY2Bbz4A7mZrWQ2CeUNyX6pQYqfEGC1ONkdmHbtV+su7mhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676094; c=relaxed/simple;
	bh=Qd3Jz5aweomGNz0PvBmZearASGSGAJYO21KATcM2rzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMt4bQ1X/LSB4NEqJY3RfgfrgyjqBEM8dtA3FAOUR7lDrrAW68Uo8pmRxJOh9X4NQ6qpMHQtnlVKnWF1RvgXiin2iRzzJNIcJmHhcuo8HI919hfJ2YfLqVigRFViSuZGK3Xv7bClWYb7Zx9C79ME9C1YVLXIDy8/Tgaky2wpCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BRPsYrEa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so233717a91.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723676091; x=1724280891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xFLILCkvgwMBZK9YxmjWYwyBEzoLDTh6kmnJiegN9U=;
        b=BRPsYrEa5x2BHVeArwQnH88oEKxzWCkfFuofa7v+1I6fFpkayFn/qNpISoK8w6290i
         ZFfiRZYkCZRlrrlPYWHK/lGN8cDWCKbxlGhjPlup2qE2Zlw9Pjec/0PWquGuwJhj9IYF
         YevK3zH6pD0buRCCY6HtHIIRBNAxRG3dn0BRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723676091; x=1724280891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xFLILCkvgwMBZK9YxmjWYwyBEzoLDTh6kmnJiegN9U=;
        b=OwqEhuaGPReSid2HhInyQVuGIq5v4k4hPCrbZ8rWEIj+Xmbuae/+oEjIAqEYds03tL
         tvYTfVNpRVC7688iAOP7up71Vev5q+4dvkERKgc5dAsRiPn9Jivi1BygTAStdqEOSPk5
         Qe3y+Fs4cTi4chM6kH8RjxfXOaIKzMbAUBxXx9j2Mfo5gyAf2/uv3c943WSScRYQ1fHV
         Odgkc4KqPiKJEs4GspQBLYHp8TKjIWEgxZhVY1AXAYcwEFa+fWTtxwTDOxw65eSbdJ0t
         zOXzdPGrlvWnXysVfgsdoNv2994RbcYKJGRnfRgQivmWKVzJNFfYD5MS1QlAqNveVUc/
         +Yeg==
X-Gm-Message-State: AOJu0Yy+XTJUzHO0WMrmPACe1ZNUuJXapcxgzMu1R/wYMrC18AqoCUHe
	YS8q91bVjW7R3zH9Uvf5XdxHSiU/1xyQxovG6raGFozZoa/8HBzyNQ1BmPTDVw==
X-Google-Smtp-Source: AGHT+IFTtgt3JceB8mumEwbXktXXTwbRaeb/YN7+qA3zYAZ4lCROTMpjKsmLJzY8qgZ4OK/jLuzGaA==
X-Received: by 2002:a17:90a:c798:b0:2bd:d42b:22dc with SMTP id 98e67ed59e1d1-2d3aabafa62mr4403674a91.43.1723676090426;
        Wed, 14 Aug 2024 15:54:50 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f27b2sm2335258a91.32.2024.08.14.15.54.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2024 15:54:50 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net] bnxt_en: Don't clear ntuple filters and rss contexts during ethtool ops
Date: Wed, 14 Aug 2024 15:54:29 -0700
Message-ID: <20240814225429.199280-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

The driver currently blindly deletes its cache of RSS cotexts and
ntuple filters when the ethtool channel count is changing.  It also
deletes the ntuple filters cache when the default indirection table
is changing.

The core will not allow ethtool channels to drop below any that
have been configured as ntuple destinations since this commit from 2022:

47f3ecf4763d ("ethtool: Fail number of channels change when it conflicts with rxnfc")

So there is absolutely no need to delete the ntuple filters and
RSS contexts when changing ethtool channels.

It is also unnecessary to delete ntuple filters when the default
RSS indirection table is changing.

Remove bnxt_clear_usr_fltrs() and bnxt_clear_rss_ctxis() from the
ethtool ops and change them to static functions.

This bug will cause confusion to the end user and causes failure when
running the rss_ctx.py selftest.

Fixes: 1018319f949c ("bnxt_en: Invalidate user filters when needed")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240725111912.7bc17cf6@kernel.org/
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 --
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e27e1082ee33..04a623b3eee2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5056,7 +5056,7 @@ void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr)
 		list_del_init(&fltr->list);
 }
 
-void bnxt_clear_usr_fltrs(struct bnxt *bp, bool all)
+static void bnxt_clear_usr_fltrs(struct bnxt *bp, bool all)
 {
 	struct bnxt_filter_base *usr_fltr, *tmp;
 
@@ -10248,7 +10248,7 @@ static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
 	}
 }
 
-void bnxt_clear_rss_ctxs(struct bnxt *bp)
+static void bnxt_clear_rss_ctxs(struct bnxt *bp)
 {
 	struct ethtool_rxfh_context *ctx;
 	unsigned long context;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6bbdc718c3a7..059a6f81c1a8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2790,7 +2790,6 @@ void bnxt_set_ring_params(struct bnxt *);
 int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
 void bnxt_insert_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
 void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
-void bnxt_clear_usr_fltrs(struct bnxt *bp, bool all);
 int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
 			    int bmap_size, bool async_only);
 int bnxt_hwrm_func_drv_unrgtr(struct bnxt *bp);
@@ -2842,7 +2841,6 @@ int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			  bool all);
-void bnxt_clear_rss_ctxs(struct bnxt *bp);
 int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9dadc89378f0..4cf9bf8b01b0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -968,9 +968,6 @@ static int bnxt_set_channels(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	bnxt_clear_usr_fltrs(bp, true);
-	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
-		bnxt_clear_rss_ctxs(bp);
 	if (netif_running(dev)) {
 		if (BNXT_PF(bp)) {
 			/* TODO CHIMP_FW: Send message to all VF's
@@ -2000,7 +1997,6 @@ static int bnxt_set_rxfh(struct net_device *dev,
 
 	bnxt_modify_rss(bp, NULL, NULL, rxfh);
 
-	bnxt_clear_usr_fltrs(bp, false);
 	if (netif_running(bp->dev)) {
 		bnxt_close_nic(bp, false, false);
 		rc = bnxt_open_nic(bp, false, false);
-- 
2.30.1


