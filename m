Return-Path: <netdev+bounces-276051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCEzClkk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:35:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFA23B11C6
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3512930BB162
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6F3BED05;
	Tue,  7 Apr 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmJH74S8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADEB37186D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575885; cv=none; b=X15ghRtuKNFH/oyM/orMzX6rTcJ5bxRgBUcE/XB79CZlxxMNjsolJQKj2xC5sMFjj9KQCaIXk+0K6lv6xpkoDZ4VDJh1gWhw7Q3FSzzEMghVRVVcIKuYq1TEthtKWe4VBUVvILvu4MVfBEtP8jaB7nRbLiWVsTUkog5Gqv4XqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575885; c=relaxed/simple;
	bh=MI6bnOYEHtHqTDeXz1FElZRshUqgXpX9D/9pz2itB6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElvP8zZAUKmoMdcEKy4VCHUy+HM5jBad78gx+XGbE0VJHADcTAu+pukgYE0KhuT8XB6KeDIozlLVcqr6o0UVwSuvhM5xMFvIffrA8m9Ndoz8glfrdnRTaTL+snZV4ZNgeOBbijIW2pDweb5i3qC/1H+pXhf4/0SqFaLT0dUo7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmJH74S8; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-471618e20a5so1243989b6e.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575871; x=1776180671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfBFTNeE9B11L9gFDndLHfkmsEzFoXsVljKSbDutFYU=;
        b=LmJH74S8zO4G6XXePC4mgy5GmR/koAk2cMidBq37XL89oEykY6wo4yuZTv+89obJVE
         Lqqc8qbeIDxWvk2NjOwfr0sY3Tarbd5ektZeLpk7yJqRryJaiINe8uzfAkz39s2riKLL
         epp8NK4EaEO9Aszfngs3s/GlD7CRSS9tSQQ4qOLAM8cd5YpSu+wc3t2agtdzRvtDwOBr
         jzwhHtKTt2qa7CdqBAk85IX+R58gcjKoheKioJtrGRuRqtbr3rCTD+/QSI+PFG9z62Y/
         FVfCVHLgqRNEzcQBP6uDZXb1GZz/0p/RuTsg8ObY4tyk7uh0WhfGZsPEqtKnIDs436hS
         Nx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575871; x=1776180671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sfBFTNeE9B11L9gFDndLHfkmsEzFoXsVljKSbDutFYU=;
        b=HCz2ZKP2CRnAkKSGacX7zT07EnWvg9MGkIHnqc1XdNfkfjpO9FW/O0fbj+vmlqsU1x
         DMF+rzo+p7NUYWPSFtzaidcwEzKNVN9dJ7pfFeq+2HRwAp8KZUUsPXsevt9X2pIZGc2w
         rr/8RL9lqCqnAhKGLM5etMlH8rz7rmTKFbUW/ogi/fdcsaqy3O9vb6zg0hPcYfUTTqoI
         oNd+PyauXZPmScSWdOiKQK12dBTVtz25L77fxz85nz6pQP+3IyljUo/6Iy13Ew+kFg/u
         kaZbxSACvHH4OVMIF5KRI0Pj1ugvxYrHKaeagN/m7ALDLfNeSekbhxLS5xXIIkercCY7
         a5+g==
X-Gm-Message-State: AOJu0YxsEy+w1trxSpdNSc1VEuLwgPCyl+wx340ZcdV9H1bCxnqfZCOR
	JbGy7EvnL4GbNetEpQlpkAylYkcUyR+EJcT+rRgVBSreQTPMuyModvRLv61RXq1xU0w=
X-Gm-Gg: AeBDieu4kMOaIHQ/vCsk9k5TvNO46d4SY6j1o4V0IoXxJFvrJDwmyGWU4Po4q49GJJz
	4dfvHTVTqrHKKxM92u6parA35cg1w8hGK3JMdH5Y/SHlssVLS3xj4Gja54aySOd6xlQgjqyN8bh
	QHDICFiIxEorPvtVt7gHeqHGejeKjsqUluKW7zUYb/3sNVP2X+aWQcFwoW7aQ1V8lG8Z31SjYfR
	c+/94t27+onQ6Lztr/OYtrdsvLoRCAboroaRs+FujlX/Ho1uSAibsHM5apW/HMihx/PCyOkLeDr
	5zBZDJLDOmtM7oPMu/997bGeilZB103+2rDXmy8xklgOHoEhCilyl691yFDxiUc9OWBwVysEly7
	MdfLinhXbQwJBnjbItZb/KNmY1ZaUCLh94QQskNqsS+2oBaELWlMzEgMYWsASpy1iZslrivQBsk
	id79f9GqNs96ZpOve38Q==
X-Received: by 2002:a05:6808:13cf:b0:46c:cdf4:1bde with SMTP id 5614622812f47-46ef851ecbamr7734969b6e.10.1775575871099;
        Tue, 07 Apr 2026 08:31:11 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:57::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46ef5bfe815sm8204161b6e.6.2026.04.07.08.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:10 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v6 07/14] bnxt: convert to ndo_set_rx_mode_async
Date: Tue,  7 Apr 2026 08:30:54 -0700
Message-ID: <20260407153101.3694714-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276051-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,fomichev.me:server fail,intel.com:server fail,broadcom.com:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 7CFA23B11C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert bnxt from ndo_set_rx_mode to ndo_set_rx_mode_async.
bnxt_set_rx_mode, bnxt_mc_list_updated and bnxt_uc_list_updated
now take explicit uc/mc list parameters and iterate with
netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.

The bnxt_cfg_rx_mode internal caller passes the real lists under
netif_addr_lock_bh.

BNXT_RX_MASK_SP_EVENT is still used here, next patch converts to
the direct call.

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 +++++++++++++----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fe8b886ff82e..569c7de7c5e4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11035,7 +11035,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 }
 
 static int bnxt_cfg_rx_mode(struct bnxt *);
-static bool bnxt_mc_list_updated(struct bnxt *, u32 *);
+static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
+				 const struct netdev_hw_addr_list *);
 
 static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 {
@@ -11125,7 +11126,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	} else if (bp->dev->flags & IFF_MULTICAST) {
 		u32 mask = 0;
 
-		bnxt_mc_list_updated(bp, &mask);
+		bnxt_mc_list_updated(bp, &mask, &bp->dev->mc);
 		vnic->rx_mask |= mask;
 	}
 
@@ -13523,17 +13524,17 @@ void bnxt_get_ring_drv_stats(struct bnxt *bp,
 		bnxt_get_one_ring_drv_stats(bp, stats, &bp->bnapi[i]->cp_ring);
 }
 
-static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
+static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask,
+				 const struct netdev_hw_addr_list *mc)
 {
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
-	struct net_device *dev = bp->dev;
 	struct netdev_hw_addr *ha;
 	u8 *haddr;
 	int mc_count = 0;
 	bool update = false;
 	int off = 0;
 
-	netdev_for_each_mc_addr(ha, dev) {
+	netdev_hw_addr_list_for_each(ha, mc) {
 		if (mc_count >= BNXT_MAX_MC_ADDRS) {
 			*rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
 			vnic->mc_list_count = 0;
@@ -13557,17 +13558,17 @@ static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
 	return update;
 }
 
-static bool bnxt_uc_list_updated(struct bnxt *bp)
+static bool bnxt_uc_list_updated(struct bnxt *bp,
+				 const struct netdev_hw_addr_list *uc)
 {
-	struct net_device *dev = bp->dev;
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct netdev_hw_addr *ha;
 	int off = 0;
 
-	if (netdev_uc_count(dev) != (vnic->uc_filter_count - 1))
+	if (netdev_hw_addr_list_count(uc) != (vnic->uc_filter_count - 1))
 		return true;
 
-	netdev_for_each_uc_addr(ha, dev) {
+	netdev_hw_addr_list_for_each(ha, uc) {
 		if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
 			return true;
 
@@ -13576,7 +13577,9 @@ static bool bnxt_uc_list_updated(struct bnxt *bp)
 	return false;
 }
 
-static void bnxt_set_rx_mode(struct net_device *dev)
+static void bnxt_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_vnic_info *vnic;
@@ -13597,7 +13600,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 	if (dev->flags & IFF_PROMISC)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 
-	uc_update = bnxt_uc_list_updated(bp);
+	uc_update = bnxt_uc_list_updated(bp, uc);
 
 	if (dev->flags & IFF_BROADCAST)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_BCAST;
@@ -13605,7 +13608,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
 		vnic->mc_list_count = 0;
 	} else if (dev->flags & IFF_MULTICAST) {
-		mc_update = bnxt_mc_list_updated(bp, &mask);
+		mc_update = bnxt_mc_list_updated(bp, &mask, mc);
 	}
 
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
@@ -13624,7 +13627,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	bool uc_update;
 
 	netif_addr_lock_bh(dev);
-	uc_update = bnxt_uc_list_updated(bp);
+	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
 	netif_addr_unlock_bh(dev);
 
 	if (!uc_update)
@@ -15881,7 +15884,7 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_start_xmit		= bnxt_start_xmit,
 	.ndo_stop		= bnxt_close,
 	.ndo_get_stats64	= bnxt_get_stats64,
-	.ndo_set_rx_mode	= bnxt_set_rx_mode,
+	.ndo_set_rx_mode_async	= bnxt_set_rx_mode,
 	.ndo_eth_ioctl		= bnxt_ioctl,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= bnxt_change_mac_addr,
-- 
2.52.0


