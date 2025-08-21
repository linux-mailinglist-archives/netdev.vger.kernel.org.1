Return-Path: <netdev+bounces-215711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA3B2FF37
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033747B8BD1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80C2DEA97;
	Thu, 21 Aug 2025 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fN1g1Bit"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821B2DEA72
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791347; cv=none; b=dGP7/eYtHhW2s4g4Fv7wWISPPpNPGPAcrsm/EhojPCBSSFq5LIqj6VUeK4xuNiNb7Y+QFcM5NZtNNJzo6I8Gyo3MecVkCCcEoI0tU/kXXy+Yg+V8Zwwcay7eBny37k2TewNTp9bIhoolIiX6OLgJUXlco3Zd3PU5So+7fqarE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791347; c=relaxed/simple;
	bh=SLgwdJPCml5SEteq1QtjDP3gBpVWEzTDRQoYhchZqTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qmd3xWfRPQ1mNPta/xbHxMYPvYI0k1DkYeCIb4JY6xiDcz0EExFuVZ9jnZFBMKhBCcbTKkOvaAWxWLr5xW/P5deQYkbErmYjZ5t6IUCLI87049Etb2Q80bq27RKLLbdZfUjGUrTuIw14GymW2YJvrUfR4bQQC8GXlBmnek0ClB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fN1g1Bit; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-74381df387fso357474a34.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791344; x=1756396144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDAUK/BRJ3xkVPDivw+kDGYaPU8l51c9YPN1dmd3w2Q=;
        b=xS8fNrjVwMKcjiJSOtcFQaMp20GSfkT+rHzTQznkyrhCbbgwfzS3BgfIc10Q8bzzqW
         3kPxngzkTlSC8K7Hfze/y4G8tY1z7EldcBgbdzdidlv4L/VnMfr15/qARenLynuuCSYG
         aDqBB4YKv8a7TsIAOJaAf5R0tKDWiD5cBlMZ8fO9m/25eDLPpzfw5EOcb3WIZk9WClaj
         IbzXnu+l23SB1I4hOHpSmjh1uhtfhvPZo5iLipnF8VrIzip/CW/dOkzuxIrGC844gp2D
         sDz5r+mFlJQZyVQ1zUl64XQj7FTS/IHmt5CIWXg23u3Qb3P4OzI2tTRyFmcu4es/Axab
         /Dug==
X-Gm-Message-State: AOJu0Yxzh1aCm3xlJ02SLKNiyZ2nBz/lPemKIP0aQa+ZHpBNXGi2NU0C
	nDNFnvW8gA7s1Hat+vpSi+MlqA4fm4++zQ8BWTwpjuLH+GM19j0p+Bz0P77zYxqX7E8X842jbOS
	PFgd1yG19e3hQ0GJKK489ePOeX+9QcABOlj5WgJt/ZiEHZ/TXi0L1NHRe/BBOiKrfN3AK2+Z+dM
	K3ohL2pNcDN+yzR9MhrpQdvIs9rbLrdpXR4DuK0BDo53kJ9jkb4tMcHtllQk8k6sZu4G2LRcgQn
	EX/9bX25YGpQHQl90Jh
X-Gm-Gg: ASbGncsXAC6TWnnxBZXvIQm/f2A2CcapN12m1fa7/dUJ3qtglKqJMlz9de2vW4zSq0k
	WIVl9jNB1cZwJ4FmUe5jtQXqTqhBpntqQmpUqgJV62E9dMDuMjLIBDR31IiRrJCTw18hPPPi+2o
	pqOCe43x55rosjJVVsPZ8kejNe2KKD5S7U04HWnDxWlbq0WspvmF4C9f/iV3Ba2eW5EJla1JNyK
	Qk2qxli3LsHEPaeyenAmw2voz7e+1r+Fahh288Tm2/OtHgUmoZmNW8dUPJRAxHIbAM+4gYGC4r9
	QCIB4G3XkO5inDijFugZK9buKZq670DFv1ZhuDZCTJPlyyE/8UrqtPiRaCNU+pUn81HRZfu/LBH
	E5TLDyX4jxU4UhSuHUsUCqFgNmgAQDq2IGfch64ZiSadCIa5h9ak/3qr+8eyGfIs8d/CopLuwJY
	hLSyN5VQ==
X-Google-Smtp-Source: AGHT+IFTNkvViNATM6BpEoefEZhxg4+NDx+poOH9fhs1xiolL1mVrI5zWxpdSZegYjB4QBBeEMRU69FPKH/s
X-Received: by 2002:a05:6830:658b:b0:743:8443:6b31 with SMTP id 46e09a7af769-74500994ea4mr446a34.6.1755791343649;
        Thu, 21 Aug 2025 08:49:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-61bebfd81aasm227925eaf.6.2025.08.21.08.49.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:49:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b474a689901so838902a12.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755791342; x=1756396142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDAUK/BRJ3xkVPDivw+kDGYaPU8l51c9YPN1dmd3w2Q=;
        b=fN1g1BitWucw6QVyoiXzQMTL1n7kWpXVkzyjPuuEcSzr3HUBD9GM4Qemx35oh3nbZA
         BsZVwndmVrBepEn/9PG2CRawSaGOyuVf3vdp29WrpxSY0TYJ0xNPBTmDxcB+R2pvLjCZ
         gJpwvYWn+M/VZlmXWW+iKtkfJc49dS2gs8i6A=
X-Received: by 2002:a05:6a20:6a08:b0:240:e327:d7a1 with SMTP id adf61e73a8af0-2433074ea52mr4270551637.1.1755791342116;
        Thu, 21 Aug 2025 08:49:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a08:b0:240:e327:d7a1 with SMTP id adf61e73a8af0-2433074ea52mr4270524637.1.1755791341612;
        Thu, 21 Aug 2025 08:49:01 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm5046894a12.46.2025.08.21.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:49:01 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v3, net-next 6/9] bng_en: Allocate stat contexts
Date: Thu, 21 Aug 2025 21:15:14 +0000
Message-ID: <20250821211517.16578-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
References: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 59 +++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 97 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 12 +++
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 6992066690bd..d77ea5536e7c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -701,3 +701,62 @@ int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd)
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
+	if (!bn->bnapi)
+		return;
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
index 6c03923eb559..1c3fd02d7e0a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -24,4 +24,6 @@ int bnge_hwrm_func_qcfg(struct bnge_dev *bd);
 int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd);
 
+void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
+int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index d1674408d6aa..046219c11f91 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -30,6 +30,70 @@
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
+			return rc;
+
+		nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
+	}
+
+	return 0;
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -628,6 +692,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -717,6 +782,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -1164,6 +1233,11 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 	return bnge_set_real_num_queues(bn);
 }
 
+static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
+{
+	bnge_hwrm_stat_ctx_free(bn);
+}
+
 static int bnge_request_irq(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1205,6 +1279,27 @@ static int bnge_request_irq(struct bnge_net *bn)
 	return rc;
 }
 
+static int bnge_init_chip(struct bnge_net *bn)
+{
+	int rc = 0;
+
+#define BNGE_DEF_STATS_COAL_TICKS	 1000000
+	bn->stats_coal_ticks = BNGE_DEF_STATS_COAL_TICKS;
+
+	rc = bnge_hwrm_stat_ctx_alloc(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm stat ctx alloc failure rc: %d\n",
+			   rc);
+		goto err_out;
+	}
+
+	return 0;
+err_out:
+	bnge_hwrm_resource_free(bn, 0);
+
+	return rc;
+}
+
 static int bnge_napi_poll(struct napi_struct *napi, int budget)
 {
 	int work_done = 0;
@@ -1285,7 +1380,7 @@ static int bnge_init_nic(struct bnge_net *bn)
 	bnge_init_ring_grps(bn);
 	bnge_init_vnics(bn);
 
-	return 0;
+	return bnge_init_chip(bn);
 }
 
 static int bnge_open_core(struct bnge_net *bn)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 0859f500b3f4..387f68d24a4e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -224,6 +224,7 @@ struct bnge_net {
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
 	u8			rss_hash_key_updated:1;
+	u32			stats_coal_ticks;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -270,6 +271,14 @@ void bnge_set_ring_params(struct bnge_dev *bd);
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
@@ -285,6 +294,9 @@ struct bnge_nq_ring_info {
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


