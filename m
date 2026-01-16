Return-Path: <netdev+bounces-250624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C672D38610
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 939C0301BB43
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F53A1E6D;
	Fri, 16 Jan 2026 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RkM8tTmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB483A1CE2
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592316; cv=none; b=hhsfRqqcrNXJ7cnYrTnPERCDXnBwBBQljfBKXrw8/KFlD/EJgsPgR1rRHCI+VfZmtz52WCTYmkYL0poO6tBX3U/StrgdFss7A3IMuKCx/JAdYzK/TXarF1m3Kl0ps7/qWocAzt+GjJ38yvSAK88WHqvKsa3XGhyAIyCBv1EhxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592316; c=relaxed/simple;
	bh=DqVDdrUmUgnoPczOkA2yjkr17ZFl1olwB/kfFAfs0bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3u6dvRabTXepYe/IPcrtItPo2qXeO6d8kD7SQBdOebKktbONxKUOcoIgoTzvVesscmLslfP9pFV/e4T7ZFAXFZ7H9q+5venUAynGT1Solh7uHCy9TD+tz6+C/33MAuJLEFPMarVTCBw2mppI+F9+GVQRAak1/RdupZOXTVfmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RkM8tTmY; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0fe77d141so16868805ad.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768592309; x=1769197109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMXY0UWdHBq5h06n3Vm0wEYB0m4mnzSYwCLT5X25rYI=;
        b=e0UfwlPxdGO10tKHrfegdvcUq2Uur0erHCD8VY6Zriy2a5XTeI3ASZ20zuamqWBNwz
         HxQYQwV1RUu6/1xZ31wsbcjFv1+UsmRkBQm649D5es++2rD7utjkXl9VEWaXFq49+noL
         vUo9c3SLn8LgXEp/x5vFh7FmTrJCEypsRWkV0ie8h5XbJDgT8oORCbAMdZlSRIrl5XqE
         6OZPMEjGFzrVcMZRgVJ1tA8u7lWYRw5xckSFMAFKgLXWJp3zhkrQd2t0AErplh8rOoZ8
         rEcF8z9/VmclprnwvDQt8OnT9wOx2qm2HcIZpyOxbhx443FGmYFWq9eM7z5w6kDSYvwv
         vVZA==
X-Gm-Message-State: AOJu0YypHEjVbxtXnXeuWbXDSa2wU8Wu+Q9sJiZqLeO7pP2+R5VhiUHs
	2a1O9lkv68/mSWh+J53umjPE9lNPhUoJZnNviRNflAUsjiUJ+HA2NaO9A5iDX9cRGeVfQy0o5Kx
	mMkWHsVtapVB8+iLR4KcDQc+7b0xLmV/W5kMbm3hRHz0cxPirXrOs0Pi0/70ALzo5/Lfizkzhj4
	wsSZ3KLOvCaaK+SOfqdifaQKw8lO3yCg9CEdTuVdWb2JYlM3D+s/FZ2ESbc3K3pM//of5BDqBYm
	L7Dsp7Q1mb5D3VPRA==
X-Gm-Gg: AY/fxX49wz32SDu3EJ7DPTi+nF1NpG9opgNCVevcGVkBV7nRnD84Qo4q6UWsaXTNQWx
	LgqS55glzhgc2WesdqjIkWp/2AMhCW3dQTgzuvjmp7nyGiEeK/x1lfsJWxvPT/o+AKK6GHHLhJl
	gbGtn0gYJ7Ks5XsFiy45OPoi23rDC9KVEmHhPmftsUc8iBSIzkzbEbzIhJ+0CLQF11Qb5UCK0LG
	K/Q3i4l2eSaq2zZY3nOVDCnCKUhlhxGrwUrOSRQM+zVhrpDBdLFE0mC404vZ0UDyhjWVT9at1xi
	iXEUiM5g6LWOoS/bsIxTbFwysHtKEUSLYDUEQKnkPqkqCHlfR8AJLqcoRSt2DC6p8W24zpJikTi
	5+nOZVJ6Fnsk2oHOob8AudXU/+Gmx02QQopzbBLTB7zXeQ/ZV7pYXHp8hYrcq3U/KpcXxJMy9hO
	xspozNqrod3Ak/w5LhyNRBH5ygTydm+/MzMdJUjSk1n9UF3PVf
X-Received: by 2002:a17:902:e850:b0:29e:c2de:4ad with SMTP id d9443c01a7336-2a717551d0cmr40936435ad.24.1768592308388;
        Fri, 16 Jan 2026 11:38:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7193999b3sm4160135ad.43.2026.01.16.11.38.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 11:38:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c38781efcso1877924a91.2
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768592306; x=1769197106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMXY0UWdHBq5h06n3Vm0wEYB0m4mnzSYwCLT5X25rYI=;
        b=RkM8tTmYWlLGdM2EbaSgF0gw21udTKbD5DmpHPqvOAn29xOeaPMHo/wkA5177xfFK4
         YoUxzdwteApgTpUvYFQqZ+16KVgJDmk7nqnS1V4RbCKxtGBAgzmZiI8Ompq6a54LtJnx
         GDMjtJJvKfxMwaL3H0/+Q3NfvTN/34Et4Qi+4=
X-Received: by 2002:a17:90b:3511:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-35272f29b65mr3737660a91.15.1768592306309;
        Fri, 16 Jan 2026 11:38:26 -0800 (PST)
X-Received: by 2002:a17:90b:3511:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-35272f29b65mr3737645a91.15.1768592305887;
        Fri, 16 Jan 2026 11:38:25 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35273121856sm2764909a91.15.2026.01.16.11.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 11:38:25 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v5, net-next 6/8] bng_en: Add support to handle AGG events
Date: Sat, 17 Jan 2026 01:07:30 +0530
Message-ID: <20260116193732.157898-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
References: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add AGG event handling in the RX path to receive packet data
on AGG rings. This enables Jumbo and HDS functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  14 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  17 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   5 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 223 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |   1 +
 5 files changed, 251 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
index cae7b8ece219..d38540f5021a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
@@ -139,6 +139,20 @@ struct rx_cmp_ext {
 	__le32 rx_cmp_timestamp;
 };
 
+#define RX_AGG_CMP_TYPE			GENMASK(5, 0)
+#define RX_AGG_CMP_LEN			GENMASK(31, 16)
+#define RX_AGG_CMP_LEN_SHIFT		16
+#define RX_AGG_CMP_V			BIT(0)
+#define RX_AGG_CMP_AGG_ID		GENMASK(31, 16)
+#define RX_AGG_CMP_AGG_ID_SHIFT		16
+
+struct rx_agg_cmp {
+	__le32 rx_agg_cmp_len_flags_type;
+	u32 rx_agg_cmp_opaque;
+	__le32 rx_agg_cmp_v;
+	__le32 rx_agg_cmp_unused;
+};
+
 #define RX_CMP_L2_ERRORS						\
 	cpu_to_le32(RX_CMPL_ERRORS_BUFFER_ERROR_MASK | RX_CMPL_ERRORS_CRC_ERROR)
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 2c8f8949d500..5b0e326c5056 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -10,6 +10,9 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
+#include <net/netdev_lock.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
@@ -979,9 +982,9 @@ static netmem_ref __bnge_alloc_rx_netmem(struct bnge_net *bn,
 	return netmem;
 }
 
-static u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
-				struct bnge_rx_ring_info *rxr,
-				gfp_t gfp)
+u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
+			 struct bnge_rx_ring_info *rxr,
+			 gfp_t gfp)
 {
 	unsigned int offset;
 	struct page *page;
@@ -1048,7 +1051,7 @@ static int bnge_alloc_one_rx_ring_bufs(struct bnge_net *bn,
 	return 0;
 }
 
-static u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
+u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
 {
 	u16 next, max = rxr->rx_agg_bmap_size;
 
@@ -1058,9 +1061,9 @@ static u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
 	return next;
 }
 
-static int bnge_alloc_rx_netmem(struct bnge_net *bn,
-				struct bnge_rx_ring_info *rxr,
-				u16 prod, gfp_t gfp)
+int bnge_alloc_rx_netmem(struct bnge_net *bn,
+			 struct bnge_rx_ring_info *rxr,
+			 u16 prod, gfp_t gfp)
 {
 	struct bnge_sw_rx_agg_bd *rx_agg_buf;
 	u16 sw_prod = rxr->rx_sw_agg_prod;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index d7cef5c5ba68..ee036ce63655 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -514,4 +514,9 @@ u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
+u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx);
+u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
+			 struct bnge_rx_ring_info *rxr, gfp_t gfp);
+int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+			 u16 prod, gfp_t gfp);
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index dffb8c17babe..d6c8557fcb19 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
+#include <net/tcp.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 #include <linux/if_vlan.h>
@@ -43,6 +44,191 @@ irqreturn_t bnge_msix(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static struct rx_agg_cmp *bnge_get_agg(struct bnge_net *bn,
+				       struct bnge_cp_ring_info *cpr,
+				       u16 cp_cons, u16 curr)
+{
+	struct rx_agg_cmp *agg;
+
+	cp_cons = RING_CMP(bn, ADV_RAW_CMP(cp_cons, curr));
+	agg = (struct rx_agg_cmp *)
+		&cpr->desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
+	return agg;
+}
+
+static void bnge_reuse_rx_agg_bufs(struct bnge_cp_ring_info *cpr, u16 idx,
+				   u16 start, u32 agg_bufs)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct bnge_net *bn = bnapi->bn;
+	struct bnge_rx_ring_info *rxr;
+	u16 prod, sw_prod;
+	u32 i;
+
+	rxr = bnapi->rx_ring;
+	sw_prod = rxr->rx_sw_agg_prod;
+	prod = rxr->rx_agg_prod;
+
+	for (i = 0; i < agg_bufs; i++) {
+		struct bnge_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
+		struct rx_agg_cmp *agg;
+		struct rx_bd *prod_bd;
+		netmem_ref netmem;
+		u16 cons;
+
+		agg = bnge_get_agg(bn, cpr, idx, start + i);
+		cons = agg->rx_agg_cmp_opaque;
+		__clear_bit(cons, rxr->rx_agg_bmap);
+
+		if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
+			sw_prod = bnge_find_next_agg_idx(rxr, sw_prod);
+
+		__set_bit(sw_prod, rxr->rx_agg_bmap);
+		prod_rx_buf = &rxr->rx_agg_buf_ring[sw_prod];
+		cons_rx_buf = &rxr->rx_agg_buf_ring[cons];
+
+		/* It is possible for sw_prod to be equal to cons, so
+		 * set cons_rx_buf->netmem to 0 first.
+		 */
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+		prod_rx_buf->netmem = netmem;
+		prod_rx_buf->offset = cons_rx_buf->offset;
+
+		prod_rx_buf->mapping = cons_rx_buf->mapping;
+
+		prod_bd = &rxr->rx_agg_desc_ring[RX_AGG_RING(bn, prod)]
+					[RX_IDX(prod)];
+
+		prod_bd->rx_bd_haddr = cpu_to_le64(cons_rx_buf->mapping);
+		prod_bd->rx_bd_opaque = sw_prod;
+
+		prod = NEXT_RX_AGG(prod);
+		sw_prod = RING_RX_AGG(bn, NEXT_RX_AGG(sw_prod));
+	}
+	rxr->rx_agg_prod = prod;
+	rxr->rx_sw_agg_prod = sw_prod;
+}
+
+static int bnge_agg_bufs_valid(struct bnge_net *bn,
+			       struct bnge_cp_ring_info *cpr,
+			       u8 agg_bufs, u32 *raw_cons)
+{
+	struct rx_agg_cmp *agg;
+	u16 last;
+
+	*raw_cons = ADV_RAW_CMP(*raw_cons, agg_bufs);
+	last = RING_CMP(bn, *raw_cons);
+	agg = (struct rx_agg_cmp *)
+		&cpr->desc_ring[CP_RING(last)][CP_IDX(last)];
+	return RX_AGG_CMP_VALID(bn, agg, *raw_cons);
+}
+
+static int bnge_discard_rx(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
+			   u32 *raw_cons, void *cmp)
+{
+	u32 tmp_raw_cons = *raw_cons;
+	struct rx_cmp *rxcmp = cmp;
+	u8 cmp_type, agg_bufs = 0;
+
+	cmp_type = RX_CMP_TYPE(rxcmp);
+
+	if (cmp_type == CMP_TYPE_RX_L2_CMP) {
+		agg_bufs = (le32_to_cpu(rxcmp->rx_cmp_misc_v1) &
+			    RX_CMP_AGG_BUFS) >>
+			   RX_CMP_AGG_BUFS_SHIFT;
+	}
+
+	if (agg_bufs) {
+		if (!bnge_agg_bufs_valid(bn, cpr, agg_bufs, &tmp_raw_cons))
+			return -EBUSY;
+	}
+	*raw_cons = tmp_raw_cons;
+	return 0;
+}
+
+static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
+				 struct bnge_cp_ring_info *cpr,
+				 u16 idx, u32 agg_bufs,
+				 struct sk_buff *skb)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct skb_shared_info *shinfo;
+	struct bnge_rx_ring_info *rxr;
+	u32 i, total_frag_len = 0;
+	u16 prod;
+
+	rxr = bnapi->rx_ring;
+	prod = rxr->rx_agg_prod;
+	shinfo = skb_shinfo(skb);
+
+	for (i = 0; i < agg_bufs; i++) {
+		struct bnge_sw_rx_agg_bd *cons_rx_buf;
+		struct rx_agg_cmp *agg;
+		u16 cons, frag_len;
+		netmem_ref netmem;
+
+		agg = bnge_get_agg(bn, cpr, idx, i);
+		cons = agg->rx_agg_cmp_opaque;
+		frag_len = (le32_to_cpu(agg->rx_agg_cmp_len_flags_type) &
+			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
+
+		cons_rx_buf = &rxr->rx_agg_buf_ring[cons];
+		skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
+				       cons_rx_buf->offset,
+				       frag_len, BNGE_RX_PAGE_SIZE);
+		__clear_bit(cons, rxr->rx_agg_bmap);
+
+		/* It is possible for bnge_alloc_rx_netmem() to allocate
+		 * a sw_prod index that equals the cons index, so we
+		 * need to clear the cons entry now.
+		 */
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+
+		if (bnge_alloc_rx_netmem(bn, rxr, prod, GFP_ATOMIC) != 0) {
+			skb->len -= frag_len;
+			skb->data_len -= frag_len;
+			skb->truesize -= BNGE_RX_PAGE_SIZE;
+
+			--shinfo->nr_frags;
+			cons_rx_buf->netmem = netmem;
+
+			/* Update prod since possibly some netmems have been
+			 * allocated already.
+			 */
+			rxr->rx_agg_prod = prod;
+			bnge_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i);
+			return 0;
+		}
+
+		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
+						  BNGE_RX_PAGE_SIZE);
+
+		total_frag_len += frag_len;
+		prod = NEXT_RX_AGG(prod);
+	}
+	rxr->rx_agg_prod = prod;
+	return total_frag_len;
+}
+
+static struct sk_buff *bnge_rx_agg_netmems_skb(struct bnge_net *bn,
+					       struct bnge_cp_ring_info *cpr,
+					       struct sk_buff *skb, u16 idx,
+					       u32 agg_bufs)
+{
+	u32 total_frag_len;
+
+	total_frag_len = __bnge_rx_agg_netmems(bn, cpr, idx, agg_bufs, skb);
+	if (!total_frag_len) {
+		skb_mark_for_recycle(skb);
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+
+	return skb;
+}
+
 static void bnge_sched_reset_rxr(struct bnge_net *bn,
 				 struct bnge_rx_ring_info *rxr)
 {
@@ -219,15 +405,16 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	struct bnge_napi *bnapi = cpr->bnapi;
 	struct net_device *dev = bn->netdev;
 	struct bnge_rx_ring_info *rxr;
+	u32 tmp_raw_cons, flags, misc;
 	struct bnge_sw_rx_bd *rx_buf;
 	struct rx_cmp_ext *rxcmp1;
 	u16 cons, prod, cp_cons;
-	u32 tmp_raw_cons, flags;
 	u8 *data_ptr, cmp_type;
 	struct rx_cmp *rxcmp;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
 	unsigned int len;
+	u8 agg_bufs;
 	void *data;
 	int rc = 0;
 
@@ -256,11 +443,15 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 	cons = rxcmp->rx_cmp_opaque;
 	if (unlikely(cons != rxr->rx_next_cons)) {
+		int rc1 = bnge_discard_rx(bn, cpr, &tmp_raw_cons, rxcmp);
+
 		/* 0xffff is forced error, don't print it */
 		if (rxr->rx_next_cons != 0xffff)
 			netdev_warn(bn->netdev, "RX cons %x != expected cons %x\n",
 				    cons, rxr->rx_next_cons);
 		bnge_sched_reset_rxr(bn, rxr);
+		if (rc1)
+			return rc1;
 		goto next_rx_no_prod_no_len;
 	}
 	rx_buf = &rxr->rx_buf_ring[cons];
@@ -268,11 +459,23 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	data_ptr = rx_buf->data_ptr;
 	prefetch(data_ptr);
 
+	misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
+	agg_bufs = (misc & RX_CMP_AGG_BUFS) >> RX_CMP_AGG_BUFS_SHIFT;
+
+	if (agg_bufs) {
+		if (!bnge_agg_bufs_valid(bn, cpr, agg_bufs, &tmp_raw_cons))
+			return -EBUSY;
+
+		cp_cons = NEXT_CMP(bn, cp_cons);
+		*event |= BNGE_AGG_EVENT;
+	}
 	*event |= BNGE_RX_EVENT;
 
 	rx_buf->data = NULL;
 	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
 		bnge_reuse_rx_data(rxr, cons, data);
+		if (agg_bufs)
+			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs);
 		rc = -EIO;
 		goto next_rx_no_len;
 	}
@@ -284,14 +487,25 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	if (len <= bn->rx_copybreak) {
 		skb = bnge_copy_skb(bnapi, data_ptr, len, dma_addr);
 		bnge_reuse_rx_data(rxr, cons, data);
-		if (!skb)
+		if (!skb) {
+			if (agg_bufs)
+				bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0,
+						       agg_bufs);
 			goto oom_next_rx;
+		}
 	} else {
 		skb = bnge_rx_skb(bn, rxr, cons, data, data_ptr, dma_addr, len);
 		if (!skb)
 			goto oom_next_rx;
 	}
 
+	if (agg_bufs) {
+		skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, cp_cons,
+					      agg_bufs);
+		if (!skb)
+			goto oom_next_rx;
+	}
+
 	if (RX_CMP_HASH_VALID(rxcmp)) {
 		enum pkt_hash_types type;
 
@@ -467,6 +681,11 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 		bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
 		bnapi->events &= ~BNGE_RX_EVENT;
 	}
+
+	if (bnapi->events & BNGE_AGG_EVENT) {
+		bnge_db_write(bn->bd, &rxr->rx_agg_db, rxr->rx_agg_prod);
+		bnapi->events &= ~BNGE_AGG_EVENT;
+	}
 }
 
 static void
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index 32be5eb46870..2a17ff639100 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -107,6 +107,7 @@ static inline void bnge_db_write_relaxed(struct bnge_net *bn,
 #define ADV_RAW_CMP(idx, n)	((idx) + (n))
 #define NEXT_RAW_CMP(idx)	ADV_RAW_CMP(idx, 1)
 #define RING_CMP(bn, idx)	((idx) & (bn)->cp_ring_mask)
+#define NEXT_CMP(bn, idx)	RING_CMP(bn, ADV_RAW_CMP(idx, 1))
 
 #define RX_CMP_ITYPES(rxcmp)					\
 	(le32_to_cpu((rxcmp)->rx_cmp_len_flags_type) & RX_CMP_FLAGS_ITYPES_MASK)
-- 
2.47.3


