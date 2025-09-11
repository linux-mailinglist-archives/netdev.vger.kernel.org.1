Return-Path: <netdev+bounces-222268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68A4B53C65
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FBEAC0716
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39460327A1C;
	Thu, 11 Sep 2025 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g3ohRDMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36D320A2D
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619356; cv=none; b=cJfheE5KY0w5zC7Vuvb/NnJIdnooc9bqhl7t7+juMDSSHD57Ej96NXuUTYDNgHZ8mIMaPQA22yG6k5CnXcDOTFPoD1PHU4Ic3r9I3fyrRntzlZL+Rt0sHLnSc9YN1lcO4jiBpyD7TjebwfQSKeKlKYdv4jlaXPz1DkmcGMiRMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619356; c=relaxed/simple;
	bh=jMACtddO2Nyt6OuXa3Y+Beh4QEbbo8dKInRO8s1N3aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hr9iOV7s/Pw+ehPBQQu/xz67/fCGlMNGFs/ySXCjvRbXQowLuZr5k8pYMTYloMsLshQguX+1Xpf0pK6X+PzMW95ruHiwTIxHnW0anIenlB4Etiyh7X4PjBr6VuMWjaFyi2g27ZwfP41CGFK3bNrWQ3QnSCom0N/AWkWP9YiXYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g3ohRDMv; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-88758c2a133so95859339f.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619353; x=1758224153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSkjXsBDFAsP29yzWlC1fHRSEWpM310BU6iAEk4rSPU=;
        b=H949TzSBhyp0wtxBaN3U4wRcEqwrgtQeAbCW97oSRgkirc/8Bb5IOLGdK3gULw56Yw
         hq4u3JiSB6y7z5Z+/iOTuEgh0NTZ8LWf82leqcePo5Nox3ouzwvlc6nsqZueVOVuJVr1
         EBYDTIK6THwOexC1jQcsgdTJXYgD6tV6yFZ8965Yn/q4JdfleJNYn4po6G5trfibqdTs
         ZRnqykcynkP3a6CGV8fbJdG7KfXi92Zbxadzlldnrc5H4QN8qlVlDFXdeiZ897Ej+78W
         2RU46x6qptAxr8Lj1gOQ5J2i+8cAWl1XW/JdWZ36m7vhxDeVbmCzFxWouedUSrnBISbL
         rOPw==
X-Gm-Message-State: AOJu0YwJJb6C7WROPP4+xkVi2pScepuFvCG+341CEm7XBChPOW018MGr
	lfj+apncjPEM0oHLotbnSqcJoocK1/NbDHB3ZTItXfkUjp8wWvLXZAcRBK9xh4c74ASu6XSQ6PE
	9dkx4VYiWO6n6JH9ldQajATRcFo0oNTx/LWUMbUK5jTJgrd5Qg4c40D5Nh7IZoz8jJnyJ6Hj2VD
	M1Z5KNYwtdJrhWMAuSOhmws0KY1cYlO4xzzVIl/JP6oePlfWehNXal+nFOZoVRJaEELcrCzH6Rq
	7Uty/E+8XtjmhINr21r
X-Gm-Gg: ASbGnct9qDfXGHnQm+GLjBMTf9L1zZ1iUtoeWoeChXuu54ubjVZp4WZqHGPoS3CBiNY
	pOTjx1ZAtDPMHbn3tairvffMnQjEcV6fD8JDLk1tdgh2CMOeSXSg7Rtpm39Hk9eQ//WCey61JhL
	RBtTzU0LuL49jaiuQcURRuppsMiHcBzY4s29TULLx/1Y8Lut3NQQlaExlsypgzrgYL7oz36Xx35
	KC0fle5jGtosV0BBz9n7KfqJyJgMnSMNnpv15wJmgAYm7WUuPafCbEwTWFXlj7DLfwQKm/k+Vrt
	Ql0PxmUyyrsAvp1uTa2CNO4RJGePFVMu9zHc88AGdVZJX58f5r1qNmUQGfwpbUqlRNA1WjxqMur
	/B5iKdFaUTJRaxtFIetEUTmAOhDG/lwTnMmNoD+IRZ+ir93EVMd7LNbsxdvL8dSSlD081e0yEdv
	vWdnB2m9RN
X-Google-Smtp-Source: AGHT+IG7sH7T96pA+1vzUE0P/lOawxXSlCDxQY4WMaWgT964sxHej2wAM0Yr+Gb6+2jmRvJL3gcjmu0RUBWZ
X-Received: by 2002:a05:6602:15c8:b0:87e:b4f9:5fa4 with SMTP id ca18e2360f4ac-89034331e3bmr67645139f.9.1757619353493;
        Thu, 11 Sep 2025 12:35:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-511f2efa3bdsm183795173.19.2025.09.11.12.35.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458274406so19680105ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619352; x=1758224152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSkjXsBDFAsP29yzWlC1fHRSEWpM310BU6iAEk4rSPU=;
        b=g3ohRDMvKlTSnpi/kpXVx82Lqn5eRQzq1GIecfn2u6psvf3ZcTnz5pJUji+DNAs6Ai
         S/GahzKMldTocWDLxrNCwN9uUdJ/A8/L5LkceTWQsNEZVODXl8bR3RDX0GAxkQy3mggN
         3XXpE52DP9zazNPNPIj5JEs+OrihcEc6lbmoA=
X-Received: by 2002:a17:902:fc4d:b0:24c:a5f3:b901 with SMTP id d9443c01a7336-25d27c1df47mr5065395ad.40.1757619351840;
        Thu, 11 Sep 2025 12:35:51 -0700 (PDT)
X-Received: by 2002:a17:902:fc4d:b0:24c:a5f3:b901 with SMTP id d9443c01a7336-25d27c1df47mr5065155ad.40.1757619351419;
        Thu, 11 Sep 2025 12:35:51 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:50 -0700 (PDT)
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
Subject: [v7, net-next 07/10] bng_en: Allocate stat contexts
Date: Fri, 12 Sep 2025 01:05:02 +0530
Message-ID: <20250911193505.24068-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Allocate the hardware statistics context with the firmware and
register DMA memory required for ring statistics. This helps the
driver to collect ring statistics provided by the firmware.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  56 ++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 104 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  12 ++
 4 files changed, 174 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 5c178fade06..8f20b880c11 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -701,3 +701,59 @@ int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd)
 	bnge_hwrm_req_drop(bd, req);
 	return rc;
 }
+
+void bnge_hwrm_stat_ctx_free(struct bnge_net *bn)
+{
+	struct hwrm_stat_ctx_free_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (bnge_hwrm_req_init(bd, req, HWRM_STAT_CTX_FREE))
+		return;
+
+	bnge_hwrm_req_hold(bd, req);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		if (nqr->hw_stats_ctx_id != INVALID_STATS_CTX_ID) {
+			req->stat_ctx_id = cpu_to_le32(nqr->hw_stats_ctx_id);
+			bnge_hwrm_req_send(bd, req);
+
+			nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
+		}
+	}
+	bnge_hwrm_req_drop(bd, req);
+}
+
+int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn)
+{
+	struct hwrm_stat_ctx_alloc_output *resp;
+	struct hwrm_stat_ctx_alloc_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc, i;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_STAT_CTX_ALLOC);
+	if (rc)
+		return rc;
+
+	req->stats_dma_length = cpu_to_le16(bd->hw_ring_stats_size);
+	req->update_period_ms = cpu_to_le32(bn->stats_coal_ticks / 1000);
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		req->stats_dma_addr = cpu_to_le64(nqr->stats.hw_stats_map);
+
+		rc = bnge_hwrm_req_send(bd, req);
+		if (rc)
+			break;
+
+		nqr->hw_stats_ctx_id = le32_to_cpu(resp->stat_ctx_id);
+		bn->grp_info[i].fw_stats_ctx = nqr->hw_stats_ctx_id;
+	}
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 6c03923eb55..1c3fd02d7e0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -24,4 +24,6 @@ int bnge_hwrm_func_qcfg(struct bnge_dev *bd);
 int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd);
 
+void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
+int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index ee7cf8596cd..1d506e36af9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -30,6 +30,73 @@
 #define BNGE_TC_TO_RING_BASE(bd, tc)	\
 	((tc) * (bd)->tx_nr_rings_per_tc)
 
+static void bnge_free_stats_mem(struct bnge_net *bn,
+				struct bnge_stats_mem *stats)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	if (stats->hw_stats) {
+		dma_free_coherent(bd->dev, stats->len, stats->hw_stats,
+				  stats->hw_stats_map);
+		stats->hw_stats = NULL;
+	}
+}
+
+static int bnge_alloc_stats_mem(struct bnge_net *bn,
+				struct bnge_stats_mem *stats)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	stats->hw_stats = dma_alloc_coherent(bd->dev, stats->len,
+					     &stats->hw_stats_map, GFP_KERNEL);
+	if (!stats->hw_stats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void bnge_free_ring_stats(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		bnge_free_stats_mem(bn, &nqr->stats);
+	}
+}
+
+static int bnge_alloc_ring_stats(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	u32 size, i;
+	int rc;
+
+	size = bd->hw_ring_stats_size;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		nqr->stats.len = size;
+		rc = bnge_alloc_stats_mem(bn, &nqr->stats);
+		if (rc)
+			goto err_free_ring_stats;
+
+		nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
+	}
+	return 0;
+
+err_free_ring_stats:
+	bnge_free_ring_stats(bn);
+	return rc;
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -649,6 +716,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -737,6 +805,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -1138,6 +1210,11 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 	return netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
 }
 
+static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
+{
+	bnge_hwrm_stat_ctx_free(bn);
+}
+
 static void bnge_free_irq(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1205,6 +1282,25 @@ static int bnge_request_irq(struct bnge_net *bn)
 	return rc;
 }
 
+static int bnge_init_chip(struct bnge_net *bn)
+{
+	int rc;
+
+#define BNGE_DEF_STATS_COAL_TICKS	 1000000
+	bn->stats_coal_ticks = BNGE_DEF_STATS_COAL_TICKS;
+
+	rc = bnge_hwrm_stat_ctx_alloc(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm stat ctx alloc failure rc: %d\n", rc);
+		goto err_out;
+	}
+	return 0;
+
+err_out:
+	bnge_hwrm_resource_free(bn, 0);
+	return rc;
+}
+
 static int bnge_napi_poll(struct napi_struct *napi, int budget)
 {
 	int work_done = 0;
@@ -1259,6 +1355,14 @@ static int bnge_init_nic(struct bnge_net *bn)
 	if (rc)
 		return rc;
 	bnge_init_vnics(bn);
+
+	rc = bnge_init_chip(bn);
+	if (rc)
+		goto err_free_ring_grps;
+	return rc;
+
+err_free_ring_grps:
+	bnge_free_ring_grps(bn);
 	return rc;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 234c0523547..56df0765bf0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -225,6 +225,7 @@ struct bnge_net {
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
 	u8			rss_hash_key_updated:1;
+	u32			stats_coal_ticks;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -271,6 +272,14 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 	     txr = (iter < BNGE_MAX_TXR_PER_NAPI - 1) ?	\
 	     (bnapi)->tx_ring[++iter] : NULL)
 
+struct bnge_stats_mem {
+	u64		*sw_stats;
+	u64		*hw_masks;
+	void		*hw_stats;
+	dma_addr_t	hw_stats_map;
+	int		len;
+};
+
 struct bnge_cp_ring_info {
 	struct bnge_napi	*bnapi;
 	dma_addr_t		*desc_mapping;
@@ -286,6 +295,9 @@ struct bnge_nq_ring_info {
 	struct nqe_cn		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
 
+	struct bnge_stats_mem	stats;
+	u32			hw_stats_ctx_id;
+
 	int				cp_ring_count;
 	struct bnge_cp_ring_info	*cp_ring_arr;
 };
-- 
2.47.3


