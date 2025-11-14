Return-Path: <netdev+bounces-238761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7549C5F250
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3FE94EA389
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F134844B;
	Fri, 14 Nov 2025 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F3xBELxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266D31A041
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150068; cv=none; b=gv2WMqpO9TZo065nGREWv/rqAbxYmgFeo/UI3aEJc4zJXgvrXsJcHPyeKKMH2Lo0ROPyze/9Ktm2cr450pa/hwfwQGOItmF/cAMtzRm9yj9TTPiIfZ0yF6IvX4ZmJzB77K5oWxXf3nes75OjMAeg13cwmB971Bu/3e6s+oEbr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150068; c=relaxed/simple;
	bh=NYDJUIWtUSbv+muyEpx0p03Ze3/KHSxDzZ5Kg4oCPzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptoCq6fEVHKOx1+gvuppGJ4p4ziptGf8NTZlD7O9uVPbyNT5WYwS/+kErudAJKjuHykG0k9XBh2Ft8qRAeG7ra8sk1ABFPN+mo0V4JfofnkTdoD03BpXA0jNCwpGzHmyl1BKZXAFrJtUSEQBgOuzrScETjgY4W9zx5r4YxxtCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F3xBELxR; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4edb6e678ddso28437201cf.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150065; x=1763754865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWkyIjP0rRLLT0GDM2crrnCUx6rSd0T0bWI9ohyR+zk=;
        b=vH3X1BKfJM4HZG3q0xwraSoGMSaUcqJwRKKReIGiM4J5lHXEhPgKUUv+65nYK276Jm
         1WBsAwwRjL6HWK7GYthyHx0qwADgUsI38iD8N98Rsh9X1Zdm8ovm2mlxp9LQCmxh1K+V
         +Rl0NxSQAPpkLTNCP6oMLDj0dRO+6z3iwaFseAZWRk9rErWXIbSq6TKgEoUNfpSZMDKX
         DKxI7lOVjIE1hCO4SjeyE52PHlT/mCE8qoGosT/OsYnn+gLbPJfCSNzyftKAAdsp0R+7
         5ccajbhx7i0zpVmvEYxJsj5IhQnxNpsfB/9jG7Nw3qzn5TVT7vrr1Bmz4o2p5RtqwyK6
         kAgQ==
X-Gm-Message-State: AOJu0YyfEJocrP2QaaZdzJJNUdCCEISZljMXXjDDeFr+4L+P5HNd1mcO
	Rp6OJnwmMdFSkLsaFP74Xl4m5xWJitVjAy9FYPg8cQjNi1QP2JQLLOCH9aA72HcfmdiLM3GyVFf
	+0YF1JK07TjYwk6OI0axLHtjbDfJuO6yB79Ad6+WW7f/lcg+u3ikr9jKAEI7r+wDvNCAlJ2IFEe
	X44mV7okTPSl2FphtyzB+LdZU26TNEWpdpyrp7Uf21i9/FN/c0r3jK+Exbgow53YWnXGQSggaiS
	spdriImHKooosO76A==
X-Gm-Gg: ASbGncvcNzMP4J6E3gWmnA3wSeJN+0k5nmr8MAJJDlk/WpB+td2CXd7H461wTYJaWIc
	w/OHG0DSIEm++X0u+0ZGaf5jeTtmXbXLo8b9UZ7DOqQgHgpnWjKHAJAgQr4DFETaXJA/au+iRPX
	wdWt6qoHntTOPkMQqStooMJpxYEFvNkuAfZphxUa+E2j0jJSf/T2V5M/LzYqJX7DbJCP0YHKXUn
	jHsuXmtfuaP8yArALiRVU9XOqJKJIuPOo+RD9g+PFmQaxNmdLpWS7I9BjTYNNNwQU8spbv7cP3E
	An7qhz4UkZifNs96/tEqoafNKBqCUJZ8nnVs61zfMuQvwfJS57CnM3ing9lbxmzJuJR9mDEVwbo
	pw9ZKh9Kac7V+y1RqBSPtPLSbQ/fUr+aN8IcvVariHkyCfjAaqxzACGvb91Wu57GCX2hpXPsqSW
	yr8dNR9s09MR113SHNu2xwqqd5t8jpFnoKFYQrh+ok
X-Google-Smtp-Source: AGHT+IHeL0ExmM/P09NgSG1f19838D+sco+0Dr+Queu4ClBb2TTGte1u77mjII0WiUT4LkDtU/QoFHWFbIzJ
X-Received: by 2002:a05:622a:54e:b0:4ed:b481:bfeb with SMTP id d75a77b69052e-4edf214a037mr61230881cf.80.1763150064678;
        Fri, 14 Nov 2025 11:54:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8828656bc18sm6465866d6.23.2025.11.14.11.54.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:54:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2956cdcdc17so26375895ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763150063; x=1763754863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWkyIjP0rRLLT0GDM2crrnCUx6rSd0T0bWI9ohyR+zk=;
        b=F3xBELxRtLvPaYcVRiU7EhwX1wRm94UIGFy0tNpTcF9zSsrV091w8IOMfbJ+zh/b/b
         HFhsdGOIe+YJsdhSklHeZ24hguafpqEqwCSB/W+9HeOIv6PHizFi5iy12d3JgBIa3jQj
         0FkD1yTAnovDrtw/NEc/YxQRQlLfrifDKlbCk=
X-Received: by 2002:a17:903:2f88:b0:298:60d5:d272 with SMTP id d9443c01a7336-2986a6d0e55mr42153875ad.17.1763150063098;
        Fri, 14 Nov 2025 11:54:23 -0800 (PST)
X-Received: by 2002:a17:903:2f88:b0:298:60d5:d272 with SMTP id d9443c01a7336-2986a6d0e55mr42153495ad.17.1763150062174;
        Fri, 14 Nov 2025 11:54:22 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea5f9fa4sm3108113a91.0.2025.11.14.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:54:21 -0800 (PST)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v2, net-next 08/12] bng_en: Add support for TPA events
Date: Sat, 15 Nov 2025 01:22:56 +0530
Message-ID: <20251114195312.22863-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Enable TPA functionality in the VNIC and add functions
to handle TPA events, which help in processing LRO/GRO.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  65 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  27 ++
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 431 +++++++++++++++++-
 4 files changed, 515 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index b0e941ad18b..8d5ca057a48 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -1370,3 +1370,68 @@ int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx)
 	req->async_event_cr = cpu_to_le16(idx);
 	return bnge_hwrm_req_send(bd, req);
 }
+
+#define BNGE_DFLT_TUNL_TPA_BMAP				\
+	(VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GRE |	\
+	 VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_IPV4 |	\
+	 VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_IPV6)
+
+static void bnge_hwrm_vnic_update_tunl_tpa(struct bnge_dev *bd,
+					   struct hwrm_vnic_tpa_cfg_input *req)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	u32 tunl_tpa_bmap = BNGE_DFLT_TUNL_TPA_BMAP;
+
+	if (!(bd->fw_cap & BNGE_FW_CAP_VNIC_TUNNEL_TPA))
+		return;
+
+	if (bn->vxlan_port)
+		tunl_tpa_bmap |= VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN;
+	if (bn->vxlan_gpe_port)
+		tunl_tpa_bmap |= VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_VXLAN_GPE;
+	if (bn->nge_port)
+		tunl_tpa_bmap |= VNIC_TPA_CFG_REQ_TNL_TPA_EN_BITMAP_GENEVE;
+
+	req->enables |= cpu_to_le32(VNIC_TPA_CFG_REQ_ENABLES_TNL_TPA_EN);
+	req->tnl_tpa_en_bitmap = cpu_to_le32(tunl_tpa_bmap);
+}
+
+int bnge_hwrm_vnic_set_tpa(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
+			   u32 tpa_flags)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct hwrm_vnic_tpa_cfg_input *req;
+	int rc;
+
+	if (vnic->fw_vnic_id == INVALID_HW_RING_ID)
+		return 0;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_TPA_CFG);
+	if (rc)
+		return rc;
+
+	if (tpa_flags) {
+		u32 flags;
+
+		flags = VNIC_TPA_CFG_REQ_FLAGS_TPA |
+			VNIC_TPA_CFG_REQ_FLAGS_ENCAP_TPA |
+			VNIC_TPA_CFG_REQ_FLAGS_RSC_WND_UPDATE |
+			VNIC_TPA_CFG_REQ_FLAGS_AGG_WITH_ECN |
+			VNIC_TPA_CFG_REQ_FLAGS_AGG_WITH_SAME_GRE_SEQ;
+		if (tpa_flags & BNGE_NET_EN_GRO)
+			flags |= VNIC_TPA_CFG_REQ_FLAGS_GRO;
+
+		req->flags = cpu_to_le32(flags);
+		req->enables =
+			cpu_to_le32(VNIC_TPA_CFG_REQ_ENABLES_MAX_AGG_SEGS |
+				    VNIC_TPA_CFG_REQ_ENABLES_MAX_AGGS |
+				    VNIC_TPA_CFG_REQ_ENABLES_MIN_AGG_LEN);
+		req->max_agg_segs = cpu_to_le16(MAX_TPA_SEGS);
+		req->max_aggs = cpu_to_le16(bn->max_tpa);
+		req->min_agg_len = cpu_to_le32(512);
+		bnge_hwrm_vnic_update_tunl_tpa(bd, req);
+	}
+	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
+
+	return bnge_hwrm_req_send(bd, req);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index b063f62ae06..f947ca66111 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -59,4 +59,6 @@ int bnge_update_link(struct bnge_net *bn, bool chng_link_state);
 int bnge_hwrm_phy_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause);
 int bnge_hwrm_set_pause(struct bnge_net *bn);
+int bnge_hwrm_vnic_set_tpa(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
+			   u32 tpa_flags);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index c6e38bc51d7..4e033271d33 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2273,6 +2273,27 @@ static int bnge_request_irq(struct bnge_net *bn)
 	return rc;
 }
 
+static int bnge_set_tpa(struct bnge_net *bn, bool set_tpa)
+{
+	u32 tpa_flags = 0;
+	int rc, i;
+
+	if (set_tpa)
+		tpa_flags = bn->priv_flags & BNGE_NET_EN_TPA;
+	else if (BNGE_NO_FW_ACCESS(bn->bd))
+		return 0;
+	for (i = 0; i < bn->nr_vnics; i++) {
+		rc = bnge_hwrm_vnic_set_tpa(bn->bd, &bn->vnic_info[i],
+					    tpa_flags);
+		if (rc) {
+			netdev_err(bn->netdev, "hwrm vnic set tpa failure rc for vnic %d: %x\n",
+				   i, rc);
+			return rc;
+		}
+	}
+	return 0;
+}
+
 static int bnge_init_chip(struct bnge_net *bn)
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
@@ -2307,6 +2328,12 @@ static int bnge_init_chip(struct bnge_net *bn)
 	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bnge_hwrm_update_rss_hash_cfg(bn);
 
+	if (bn->priv_flags & BNGE_NET_EN_TPA) {
+		rc = bnge_set_tpa(bn, true);
+		if (rc)
+			goto err_out;
+	}
+
 	/* Filter for default vnic 0 */
 	rc = bnge_hwrm_set_vnic_filter(bn, 0, 0, bn->netdev->dev_addr);
 	if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 581685bb11a..3417cfef92b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -14,6 +14,7 @@
 #include <linux/if.h>
 #include <net/ip.h>
 #include <net/tcp.h>
+#include <net/gro.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 #include <linux/if_vlan.h>
@@ -40,6 +41,15 @@ irqreturn_t bnge_msix(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static struct rx_agg_cmp *bnge_get_tpa_agg(struct bnge_net *bn,
+					   struct bnge_rx_ring_info *rxr,
+					   u16 agg_id, u16 curr)
+{
+	struct bnge_tpa_info *tpa_info = &rxr->rx_tpa[agg_id];
+
+	return &tpa_info->agg_arr[curr];
+}
+
 static struct rx_agg_cmp *bnge_get_agg(struct bnge_net *bn,
 				       struct bnge_cp_ring_info *cpr,
 				       u16 cp_cons, u16 curr)
@@ -53,7 +63,7 @@ static struct rx_agg_cmp *bnge_get_agg(struct bnge_net *bn,
 }
 
 static void bnge_reuse_rx_agg_bufs(struct bnge_cp_ring_info *cpr, u16 idx,
-				   u16 start, u32 agg_bufs)
+				   u16 start, u32 agg_bufs, bool tpa)
 {
 	struct bnge_napi *bnapi = cpr->bnapi;
 	struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
@@ -69,7 +79,10 @@ static void bnge_reuse_rx_agg_bufs(struct bnge_cp_ring_info *cpr, u16 idx,
 		netmem_ref netmem;
 		u16 cons;
 
-		agg = bnge_get_agg(bn, cpr, idx, start + i);
+		if (tpa)
+			agg = bnge_get_tpa_agg(bn, rxr, idx, start + i);
+		else
+			agg = bnge_get_agg(bn, cpr, idx, start + i);
 		cons = agg->rx_agg_cmp_opaque;
 		__clear_bit(cons, rxr->rx_agg_bmap);
 
@@ -129,6 +142,8 @@ static int bnge_discard_rx(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 		agg_bufs = (le32_to_cpu(rxcmp->rx_cmp_misc_v1) &
 			    RX_CMP_AGG_BUFS) >>
 			   RX_CMP_AGG_BUFS_SHIFT;
+	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
+		return 0;
 	}
 
 	if (agg_bufs) {
@@ -141,7 +156,7 @@ static int bnge_discard_rx(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
 				 struct bnge_cp_ring_info *cpr,
-				 u16 idx, u32 agg_bufs,
+				 u16 idx, u32 agg_bufs, bool tpa,
 				 struct sk_buff *skb)
 {
 	struct bnge_napi *bnapi = cpr->bnapi;
@@ -160,7 +175,10 @@ static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
 		u16 cons, frag_len;
 		netmem_ref netmem;
 
-		agg = bnge_get_agg(bn, cpr, idx, i);
+		if (tpa)
+			agg = bnge_get_tpa_agg(bn, rxr, idx, i);
+		else
+			agg = bnge_get_agg(bn, cpr, idx, i);
 		cons = agg->rx_agg_cmp_opaque;
 		frag_len = (le32_to_cpu(agg->rx_agg_cmp_len_flags_type) &
 			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
@@ -189,7 +207,7 @@ static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
 			 * allocated already.
 			 */
 			rxr->rx_agg_prod = prod;
-			bnge_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i);
+			bnge_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i, tpa);
 			return 0;
 		}
 
@@ -206,11 +224,12 @@ static u32 __bnge_rx_agg_netmems(struct bnge_net *bn,
 static struct sk_buff *bnge_rx_agg_netmems_skb(struct bnge_net *bn,
 					       struct bnge_cp_ring_info *cpr,
 					       struct sk_buff *skb, u16 idx,
-					       u32 agg_bufs)
+					       u32 agg_bufs, bool tpa)
 {
 	u32 total_frag_len = 0;
 
-	total_frag_len = __bnge_rx_agg_netmems(bn, cpr, idx, agg_bufs, skb);
+	total_frag_len = __bnge_rx_agg_netmems(bn, cpr, idx, agg_bufs,
+					       tpa, skb);
 	if (!total_frag_len) {
 		skb_mark_for_recycle(skb);
 		dev_kfree_skb(skb);
@@ -226,6 +245,156 @@ static void bnge_sched_reset_rxr(struct bnge_net *bn,
 	rxr->rx_next_cons = 0xffff;
 }
 
+static u16 bnge_tpa_alloc_agg_idx(struct bnge_rx_ring_info *rxr, u16 agg_id)
+{
+	struct bnge_tpa_idx_map *map = rxr->rx_tpa_idx_map;
+	u16 idx = agg_id & MAX_TPA_MASK;
+
+	if (test_bit(idx, map->agg_idx_bmap))
+		idx = find_first_zero_bit(map->agg_idx_bmap,
+					  BNGE_AGG_IDX_BMAP_SIZE);
+	__set_bit(idx, map->agg_idx_bmap);
+	map->agg_id_tbl[agg_id] = idx;
+	return idx;
+}
+
+static void bnge_free_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
+{
+	struct bnge_tpa_idx_map *map = rxr->rx_tpa_idx_map;
+
+	__clear_bit(idx, map->agg_idx_bmap);
+}
+
+static u16 bnge_lookup_agg_idx(struct bnge_rx_ring_info *rxr, u16 agg_id)
+{
+	struct bnge_tpa_idx_map *map = rxr->rx_tpa_idx_map;
+
+	return map->agg_id_tbl[agg_id];
+}
+
+static void bnge_tpa_metadata(struct bnge_tpa_info *tpa_info,
+			      struct rx_tpa_start_cmp *tpa_start,
+			      struct rx_tpa_start_cmp_ext *tpa_start1)
+{
+	tpa_info->cfa_code_valid = 1;
+	tpa_info->cfa_code = TPA_START_CFA_CODE(tpa_start1);
+	tpa_info->vlan_valid = 0;
+	if (tpa_info->flags2 & RX_CMP_FLAGS2_META_FORMAT_VLAN) {
+		tpa_info->vlan_valid = 1;
+		tpa_info->metadata =
+			le32_to_cpu(tpa_start1->rx_tpa_start_cmp_metadata);
+	}
+}
+
+static void bnge_tpa_metadata_v2(struct bnge_tpa_info *tpa_info,
+				 struct rx_tpa_start_cmp *tpa_start,
+				 struct rx_tpa_start_cmp_ext *tpa_start1)
+{
+	tpa_info->vlan_valid = 0;
+	if (TPA_START_VLAN_VALID(tpa_start)) {
+		u32 tpid_sel = TPA_START_VLAN_TPID_SEL(tpa_start);
+		u32 vlan_proto = ETH_P_8021Q;
+
+		tpa_info->vlan_valid = 1;
+		if (tpid_sel == RX_TPA_START_METADATA1_TPID_8021AD)
+			vlan_proto = ETH_P_8021AD;
+		tpa_info->metadata = vlan_proto << 16 |
+				     TPA_START_METADATA0_TCI(tpa_start1);
+	}
+}
+
+static void bnge_tpa_start(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+			   u8 cmp_type, struct rx_tpa_start_cmp *tpa_start,
+			   struct rx_tpa_start_cmp_ext *tpa_start1)
+{
+	struct bnge_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
+	struct bnge_tpa_info *tpa_info;
+	u16 cons, prod, agg_id;
+	struct rx_bd *prod_bd;
+	dma_addr_t mapping;
+
+	agg_id = TPA_START_AGG_ID(tpa_start);
+	agg_id = bnge_tpa_alloc_agg_idx(rxr, agg_id);
+	cons = tpa_start->rx_tpa_start_cmp_opaque;
+	prod = rxr->rx_prod;
+	cons_rx_buf = &rxr->rx_buf_ring[cons];
+	prod_rx_buf = &rxr->rx_buf_ring[RING_RX(bn, prod)];
+	tpa_info = &rxr->rx_tpa[agg_id];
+
+	if (unlikely(cons != rxr->rx_next_cons ||
+		     TPA_START_ERROR(tpa_start))) {
+		netdev_warn(bn->netdev, "TPA cons %x, expected cons %x, error code %x\n",
+			    cons, rxr->rx_next_cons,
+			    TPA_START_ERROR_CODE(tpa_start1));
+		bnge_sched_reset_rxr(bn, rxr);
+		return;
+	}
+	prod_rx_buf->data = tpa_info->data;
+	prod_rx_buf->data_ptr = tpa_info->data_ptr;
+
+	mapping = tpa_info->mapping;
+	prod_rx_buf->mapping = mapping;
+
+	prod_bd = &rxr->rx_desc_ring[RX_RING(bn, prod)][RX_IDX(prod)];
+
+	prod_bd->rx_bd_haddr = cpu_to_le64(mapping);
+
+	tpa_info->data = cons_rx_buf->data;
+	tpa_info->data_ptr = cons_rx_buf->data_ptr;
+	cons_rx_buf->data = NULL;
+	tpa_info->mapping = cons_rx_buf->mapping;
+
+	tpa_info->len =
+		le32_to_cpu(tpa_start->rx_tpa_start_cmp_len_flags_type) >>
+				RX_TPA_START_CMP_LEN_SHIFT;
+	if (likely(TPA_START_HASH_VALID(tpa_start))) {
+		tpa_info->hash_type = PKT_HASH_TYPE_L4;
+		tpa_info->gso_type = SKB_GSO_TCPV4;
+		if (TPA_START_IS_IPV6(tpa_start1))
+			tpa_info->gso_type = SKB_GSO_TCPV6;
+		tpa_info->rss_hash =
+			le32_to_cpu(tpa_start->rx_tpa_start_cmp_rss_hash);
+	} else {
+		tpa_info->hash_type = PKT_HASH_TYPE_NONE;
+		tpa_info->gso_type = 0;
+		netif_warn(bn, rx_err, bn->netdev, "TPA packet without valid hash\n");
+	}
+	tpa_info->flags2 = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_flags2);
+	tpa_info->hdr_info = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_hdr_info);
+	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP)
+		bnge_tpa_metadata(tpa_info, tpa_start, tpa_start1);
+	else
+		bnge_tpa_metadata_v2(tpa_info, tpa_start, tpa_start1);
+	tpa_info->agg_count = 0;
+
+	rxr->rx_prod = NEXT_RX(prod);
+	cons = RING_RX(bn, NEXT_RX(cons));
+	rxr->rx_next_cons = RING_RX(bn, NEXT_RX(cons));
+	cons_rx_buf = &rxr->rx_buf_ring[cons];
+
+	bnge_reuse_rx_data(rxr, cons, cons_rx_buf->data);
+	rxr->rx_prod = NEXT_RX(rxr->rx_prod);
+	cons_rx_buf->data = NULL;
+}
+
+static void bnge_abort_tpa(struct bnge_cp_ring_info *cpr, u16 idx, u32 agg_bufs)
+{
+	if (agg_bufs)
+		bnge_reuse_rx_agg_bufs(cpr, idx, 0, agg_bufs, true);
+}
+
+static void bnge_tpa_agg(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+			 struct rx_agg_cmp *rx_agg)
+{
+	u16 agg_id = TPA_AGG_AGG_ID(rx_agg);
+	struct bnge_tpa_info *tpa_info;
+
+	agg_id = bnge_lookup_agg_idx(rxr, agg_id);
+	tpa_info = &rxr->rx_tpa[agg_id];
+	BUG_ON(tpa_info->agg_count >= MAX_SKB_FRAGS);
+	tpa_info->agg_arr[tpa_info->agg_count++] = *rx_agg;
+}
+
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data)
 {
 	struct bnge_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
@@ -280,6 +449,209 @@ static struct sk_buff *bnge_copy_skb(struct bnge_napi *bnapi, u8 *data,
 	return skb;
 }
 
+#ifdef CONFIG_INET
+static void bnge_gro_tunnel(struct sk_buff *skb, __be16 ip_proto)
+{
+	struct udphdr *uh = NULL;
+
+	if (ip_proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		if (iph->protocol == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	} else {
+		struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
+
+		if (iph->nexthdr == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	}
+	if (uh) {
+		if (uh->check)
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		else
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	}
+}
+
+static struct sk_buff *bnge_gro_func(struct bnge_tpa_info *tpa_info,
+				     int payload_off, int tcp_ts,
+				     struct sk_buff *skb)
+{
+	u16 outer_ip_off, inner_ip_off, inner_mac_off;
+	u32 hdr_info = tpa_info->hdr_info;
+	int iphdr_len, nw_off;
+
+	inner_ip_off = BNGE_TPA_INNER_L3_OFF(hdr_info);
+	inner_mac_off = BNGE_TPA_INNER_L2_OFF(hdr_info);
+	outer_ip_off = BNGE_TPA_OUTER_L3_OFF(hdr_info);
+
+	nw_off = inner_ip_off - ETH_HLEN;
+	skb_set_network_header(skb, nw_off);
+	iphdr_len = (tpa_info->flags2 & RX_TPA_START_CMP_FLAGS2_IP_TYPE) ?
+		     sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+	skb_set_transport_header(skb, nw_off + iphdr_len);
+
+	if (inner_mac_off) { /* tunnel */
+		__be16 proto = *((__be16 *)(skb->data + outer_ip_off -
+					    ETH_HLEN - 2));
+
+		bnge_gro_tunnel(skb, proto);
+	}
+
+	return skb;
+}
+
+static inline struct sk_buff *bnge_gro_skb(struct bnge_net *bn,
+					   struct bnge_tpa_info *tpa_info,
+					   struct rx_tpa_end_cmp *tpa_end,
+					   struct rx_tpa_end_cmp_ext *tpa_end1,
+					   struct sk_buff *skb)
+{
+	int payload_off;
+	u16 segs;
+
+	segs = TPA_END_TPA_SEGS(tpa_end);
+	if (segs == 1)
+		return skb;
+
+	NAPI_GRO_CB(skb)->count = segs;
+	skb_shinfo(skb)->gso_size =
+		le32_to_cpu(tpa_end1->rx_tpa_end_cmp_seg_len);
+	skb_shinfo(skb)->gso_type = tpa_info->gso_type;
+	payload_off = TPA_END_PAYLOAD_OFF(tpa_end1);
+	skb = bnge_gro_func(tpa_info, payload_off,
+			    TPA_END_GRO_TS(tpa_end), skb);
+	if (likely(skb))
+		tcp_gro_complete(skb);
+
+	return skb;
+}
+#endif
+
+static inline struct sk_buff *bnge_tpa_end(struct bnge_net *bn,
+					   struct bnge_cp_ring_info *cpr,
+					   u32 *raw_cons,
+					   struct rx_tpa_end_cmp *tpa_end,
+					   struct rx_tpa_end_cmp_ext *tpa_end1,
+					   u8 *event)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
+	struct net_device *dev = bn->netdev;
+	struct bnge_tpa_info *tpa_info;
+	u8 *data_ptr, agg_bufs;
+	struct sk_buff *skb;
+	u16 idx = 0, agg_id;
+	dma_addr_t mapping;
+	unsigned int len;
+	void *data;
+	bool gro;
+
+	agg_id = TPA_END_AGG_ID(tpa_end);
+	agg_id = bnge_lookup_agg_idx(rxr, agg_id);
+	agg_bufs = TPA_END_AGG_BUFS(tpa_end1);
+	tpa_info = &rxr->rx_tpa[agg_id];
+	if (unlikely(agg_bufs != tpa_info->agg_count)) {
+		netdev_warn(bn->netdev, "TPA end agg_buf %d != expected agg_bufs %d\n",
+			    agg_bufs, tpa_info->agg_count);
+		agg_bufs = tpa_info->agg_count;
+	}
+	tpa_info->agg_count = 0;
+	*event |= BNGE_AGG_EVENT;
+	bnge_free_agg_idx(rxr, agg_id);
+	idx = agg_id;
+	gro = !!(bn->priv_flags & BNGE_NET_EN_GRO);
+	data = tpa_info->data;
+	data_ptr = tpa_info->data_ptr;
+	prefetch(data_ptr);
+	len = tpa_info->len;
+	mapping = tpa_info->mapping;
+
+	if (unlikely(agg_bufs > MAX_SKB_FRAGS || TPA_END_ERRORS(tpa_end1))) {
+		bnge_abort_tpa(cpr, idx, agg_bufs);
+		if (agg_bufs > MAX_SKB_FRAGS)
+			netdev_warn(bn->netdev, "TPA frags %d exceeded MAX_SKB_FRAGS %d\n",
+				    agg_bufs, (int)MAX_SKB_FRAGS);
+		return NULL;
+	}
+
+	if (len <= bn->rx_copybreak) {
+		skb = bnge_copy_skb(bnapi, data_ptr, len, mapping);
+		if (!skb) {
+			bnge_abort_tpa(cpr, idx, agg_bufs);
+			return NULL;
+		}
+	} else {
+		u8 *new_data;
+		dma_addr_t new_mapping;
+
+		new_data = __bnge_alloc_rx_frag(bn, &new_mapping, rxr,
+						GFP_ATOMIC);
+		if (!new_data) {
+			bnge_abort_tpa(cpr, idx, agg_bufs);
+			return NULL;
+		}
+
+		tpa_info->data = new_data;
+		tpa_info->data_ptr = new_data + bn->rx_offset;
+		tpa_info->mapping = new_mapping;
+
+		skb = napi_build_skb(data, bn->rx_buf_size);
+		dma_sync_single_for_cpu(bn->bd->dev, mapping,
+					bn->rx_buf_use_size, bn->rx_dir);
+
+		if (!skb) {
+			page_pool_free_va(rxr->head_pool, data, true);
+			bnge_abort_tpa(cpr, idx, agg_bufs);
+			return NULL;
+		}
+		skb_mark_for_recycle(skb);
+		skb_reserve(skb, bn->rx_offset);
+		skb_put(skb, len);
+	}
+
+	if (agg_bufs) {
+		skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, idx, agg_bufs,
+					      true);
+		/* Page reuse already handled by bnge_rx_agg_netmems_skb(). */
+		if (!skb)
+			return NULL;
+	}
+
+	skb->protocol = eth_type_trans(skb, dev);
+
+	if (tpa_info->hash_type != PKT_HASH_TYPE_NONE)
+		skb_set_hash(skb, tpa_info->rss_hash, tpa_info->hash_type);
+
+	if (tpa_info->vlan_valid &&
+	    (dev->features & BNGE_HW_FEATURE_VLAN_ALL_RX)) {
+		__be16 vlan_proto = htons(tpa_info->metadata >>
+					  RX_CMP_FLAGS2_METADATA_TPID_SFT);
+		u16 vtag = tpa_info->metadata & RX_CMP_FLAGS2_METADATA_TCI_MASK;
+
+		if (eth_type_vlan(vlan_proto)) {
+			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
+		} else {
+			dev_kfree_skb(skb);
+			return NULL;
+		}
+	}
+
+	skb_checksum_none_assert(skb);
+	if (likely(tpa_info->flags2 & RX_TPA_START_CMP_FLAGS2_L4_CS_CALC)) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level =
+			(tpa_info->flags2 & RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3;
+	}
+
+#ifdef CONFIG_INET
+	if (gro)
+		skb = bnge_gro_skb(bn, tpa_info, tpa_end, tpa_end1, skb);
+#endif
+
+	return skb;
+}
+
 static enum pkt_hash_types bnge_rss_ext_op(struct bnge_net *bn,
 					   struct rx_cmp *rxcmp)
 {
@@ -372,6 +744,7 @@ static struct sk_buff *bnge_rx_skb(struct bnge_net *bn,
 
 /* returns the following:
  * 1       - 1 packet successfully received
+ * 0       - successful TPA_START, packet not completed yet
  * -EBUSY  - completion ring does not have all the agg buffers yet
  * -ENOMEM - packet aborted due to out of memory
  * -EIO    - packet aborted due to hw error indicated in BD
@@ -405,6 +778,11 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 	cmp_type = RX_CMP_TYPE(rxcmp);
 
+	if (cmp_type == CMP_TYPE_RX_TPA_AGG_CMP) {
+		bnge_tpa_agg(bn, rxr, (struct rx_agg_cmp *)rxcmp);
+		goto next_rx_no_prod_no_len;
+	}
+
 	tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
 	cp_cons = RING_CMP(bn, tmp_raw_cons);
 	rxcmp1 = (struct rx_cmp_ext *)
@@ -419,6 +797,32 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	dma_rmb();
 	prod = rxr->rx_prod;
 
+	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP ||
+	    cmp_type == CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
+		bnge_tpa_start(bn, rxr, cmp_type,
+			       (struct rx_tpa_start_cmp *)rxcmp,
+			       (struct rx_tpa_start_cmp_ext *)rxcmp1);
+
+		*event |= BNGE_RX_EVENT;
+		goto next_rx_no_prod_no_len;
+
+	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
+		skb = bnge_tpa_end(bn, cpr, &tmp_raw_cons,
+				   (struct rx_tpa_end_cmp *)rxcmp,
+				   (struct rx_tpa_end_cmp_ext *)rxcmp1, event);
+
+		if (IS_ERR(skb))
+			return -EBUSY;
+
+		rc = -ENOMEM;
+		if (likely(skb)) {
+			bnge_deliver_skb(bn, bnapi, skb);
+			rc = 1;
+		}
+		*event |= BNGE_RX_EVENT;
+		goto next_rx_no_prod_no_len;
+	}
+
 	cons = rxcmp->rx_cmp_opaque;
 	if (unlikely(cons != rxr->rx_next_cons)) {
 		int rc1 = bnge_discard_rx(bn, cpr, &tmp_raw_cons, rxcmp);
@@ -453,7 +857,8 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
 		bnge_reuse_rx_data(rxr, cons, data);
 		if (agg_bufs)
-			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs);
+			bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs,
+					       false);
 		rc = -EIO;
 		goto next_rx_no_len;
 	}
@@ -468,7 +873,7 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 		if (!skb) {
 			if (agg_bufs)
 				bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0,
-						       agg_bufs);
+						       agg_bufs, false);
 			goto oom_next_rx;
 		}
 	} else {
@@ -486,7 +891,7 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 
 	if (agg_bufs) {
 		skb = bnge_rx_agg_netmems_skb(bn, cpr, skb, cp_cons,
-					      agg_bufs);
+					      agg_bufs, false);
 		if (!skb)
 			goto oom_next_rx;
 	}
@@ -584,6 +989,12 @@ static int bnge_force_rx_discard(struct bnge_net *bn,
 	    cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
 		rxcmp1->rx_cmp_cfa_code_errors_v2 |=
 			cpu_to_le32(RX_CMPL_ERRORS_CRC_ERROR);
+	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
+		struct rx_tpa_end_cmp_ext *tpa_end1;
+
+		tpa_end1 = (struct rx_tpa_end_cmp_ext *)rxcmp1;
+		tpa_end1->rx_tpa_end_cmp_errors_v2 |=
+			cpu_to_le32(RX_TPA_END_CMP_ERRORS);
 	}
 	rc = bnge_rx_pkt(bn, cpr, raw_cons, event);
 	return rc;
-- 
2.47.3


