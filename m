Return-Path: <netdev+bounces-109335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E2927FFC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DC21F21B0A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C643010A24;
	Fri,  5 Jul 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8CyUo/8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285C10A35
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144807; cv=none; b=GUT/QQaoy/em5Rux/0K40s8gGprQa/IgYPDY6dO8zhbxKbNxbqy1y/trPV8PMbRd5TD3nKxtj5sNjDAzdk6mdm/xsxKMgrXJvMQydH3/1UwIVN711geJGZARsrEJNXLoFRSsMTJMc+yyLJMX1MkNpINvF8jkbO/vZzvAjwG0sVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144807; c=relaxed/simple;
	bh=SMlTRDewueGm14gcrwa9sh/rxK9OOTqdF5oRVH2RT4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRcpet25DiouC0s+twDNQGis4OXOyDwtc3IivGCAacmHZsUrl8UN+oTmRGz1aWFF/6Rs5KYpIQifk3ZJlihtwUJIIZO2klKPGUP3OL16sm7E3YL19utq9jdWnZrBinbTTY2kJq8jrCL3xv9CAw/38nInPdTjWLMk3oD5CD/4YB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8CyUo/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9215C3277B;
	Fri,  5 Jul 2024 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144807;
	bh=SMlTRDewueGm14gcrwa9sh/rxK9OOTqdF5oRVH2RT4g=;
	h=From:To:Cc:Subject:Date:From;
	b=L8CyUo/8qUNWorfHqn7Mo3WE86yAH8ziNpEx0iDqjlrmd7+B8bqIgU1y+wAvnj0JQ
	 G4nHBFaibOI0n8xrrcaQHWRbkdylEZ8HpOjKunAmXKBK9BwjfQ9ioGOzB7S5H1j7sU
	 5jaNSJfLCV3KGwSF6t9rRfeM9fM2uxC7H/KxegHhRk+7KpvTqZiZJBLJKXCSUN9Caq
	 s3IH4v78lwSBz6lKSF1ZFK2bqZCL+CNgqytNA71AKOxt6Q+weGXW7Tv8ppSLIIaNKm
	 kz25pWnOLxsQgWA4eQTps+ohg2ApGJsF8eofSEhikjc2+ES45joiNymEYW28QUJs6s
	 dzGkOePMqACRA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net] bnxt: fix crashes when reducing ring count with active RSS contexts
Date: Thu,  4 Jul 2024 19:00:05 -0700
Message-ID: <20240705020005.681746-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt doesn't check if a ring is used by RSS contexts when reducing
ring count. Core performs a similar check for the drivers for
the main context, but core doesn't know about additional contexts,
so it can't validate them. bnxt_fill_hw_rss_tbl_p5() uses ring
id to index bp->rx_ring[], which without the check may end up
being out of bounds.

  BUG: KASAN: slab-out-of-bounds in __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
  Read of size 2 at addr ffff8881c5809618 by task ethtool/31525
  Call Trace:
  __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
   bnxt_hwrm_vnic_rss_cfg_p5+0xf7/0x460
   __bnxt_setup_vnic_p5+0x12e/0x270
   __bnxt_open_nic+0x2262/0x2f30
   bnxt_open_nic+0x5d/0xf0
   ethnl_set_channels+0x5d4/0xb30
   ethnl_default_set_doit+0x2f1/0x620

Core does track the additional contexts in net-next, so we can
move this validation out of the driver as a follow up there.

Fixes: b3d0083caf9a ("bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
CC: kalesh-anakkur.purayil@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 15 +++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 220d05e2f6fa..80fce0aaad66 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6282,6 +6282,21 @@ static u16 bnxt_get_max_rss_ring(struct bnxt *bp)
 	return max_ring;
 }
 
+u16 bnxt_get_max_rss_ctx_ring(struct bnxt *bp)
+{
+	u16 i, tbl_size, max_ring = 0;
+	struct bnxt_rss_ctx *rss_ctx;
+
+	tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
+
+	list_for_each_entry(rss_ctx, &bp->rss_ctx_list, list) {
+		for (i = 0; i < tbl_size; i++)
+			max_ring = max(max_ring, rss_ctx->rss_indir_tbl[i]);
+	}
+
+	return max_ring;
+}
+
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
 {
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e46bd11e52b0..3c8826875ceb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2814,6 +2814,7 @@ int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 void bnxt_fill_ipv6_mask(__be32 mask[4]);
 int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
 void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
+u16 bnxt_get_max_rss_ctx_ring(struct bnxt *bp);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index bf157f6cc042..4d53ec7adc61 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -961,6 +961,12 @@ static int bnxt_set_channels(struct net_device *dev,
 		return rc;
 	}
 
+	if (req_rx_rings < bp->rx_nr_rings &&
+	    req_rx_rings <= bnxt_get_max_rss_ctx_ring(bp)) {
+		netdev_warn(dev, "Can't deactivate rings used by RSS contexts\n");
+		return -EINVAL;
+	}
+
 	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
 	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
 	    netif_is_rxfh_configured(dev)) {
-- 
2.45.2


