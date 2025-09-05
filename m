Return-Path: <netdev+bounces-220441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A74B45FED
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841DD1C21B1F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1079F37C0FD;
	Fri,  5 Sep 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bo2tuZuL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AB37C0ED
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092848; cv=none; b=mcmlQPBGsstOkXYnWuC10/3+Ylo7cFRdR68xOM7PMgtYJGv9tn9y4ceTNAUc1S6MqzX3xsgOulvloQ/gYZ8RgSqVXinsavSui8P914RTs09vFm8Y2Ccw3Ddu6yi3wSMW9OfU1xBt4/SHQadKCV0tY+CQ98/1Wk/Vci/2kYC20LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092848; c=relaxed/simple;
	bh=0uWL6KK8WN1zORbkeBOaGVywt7EirR6BpCTggXYgWzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6Kcjl5U58tYOyw4i7mRKsukLxwHPU012w/emNTKmvxWapB9ZRqhq/QZF0gP+KnwdB1MBjw02nkOJxvmfo9C13TB9zjj55SXTGppMdwO+aVUR195tdElFIjj+Up95eZGVNtUltLR5sdo2sjov1GrW9WckeWoma8ZCSLnFeM5IYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bo2tuZuL; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-71d605c6501so25166877b3.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092845; x=1757697645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLbk+VDIaBG3NrhNiwtkW7qI5ZnuEsuQOZ7XBwBTtd0=;
        b=HOPSmWTz88x9XK1TyynyxiRmiwSh2QvZrflV9PCk5dOjmMsH/TvPpER7pxmRWFNQSJ
         BHimBafegO/GLn0CbCpMgOApz6zJH5CQMASN6ZXuMhfXihiG4ZYUo6TYxiEcN/jvHGdT
         vIQJlQ1+GzkgBVAe4yeU23jBN3I5TXMb7DXImmJc/HHyvt1ATyLMM695xxNvF15xwQMt
         FqhJ2q9jE4J0sqlfqZyS3o0PBQSwvhPBua8W45ujrW5Vufs3vmqenOmqr9Zhq+xo/9bx
         Hlj7zWza4roXWl0jfos9Im3O4bIwmTzznkSI4KGKJ1BQtAp5HfnqVQopgykfIdaTy6ym
         5osQ==
X-Gm-Message-State: AOJu0YzXZPMUVDur7Ky2D67RljNAYVrtyxWGYc/JAMP3Fb8768li+XhF
	pBo8Uu7FjrGHeON+M1A9eiwhurpy7GVqeHweJRvCIynCh+V8IReUYb7oHlV1qqUikUIorpgTW2g
	BsX3w2jjYEy3iu8UZM3c6PWa3icO/8/cAIe0ogi+IrTqyWL/0lIujBvJ6+s/8m2/fWx+1LocJ1q
	ZLYgTq1lC1KRFps2axr08/Lm/RH9bZRTRQEAgDOY1zHlWPRVnUCYyIX1loQzHDczEXyAfnkusel
	u6MtcvKp/ixS6CJ4RjV
X-Gm-Gg: ASbGnctSUrO0+9tI7Rth6Jkz1D3BYOE2yJsQUIX6oKq1IY6+tvZj+aIBMOBY3MlU5Mf
	dw2VKf4DQ7xM50OerORVU6KjISB8fjfRsh7mWtuzPFJZ4Hp4Kb5EkVN3/GX00qfmf5qKeFYXdOi
	1D0GICBbVu/+eNZnzK9Seeq+ke0pos7Ho4NVO2+wdfvLrIGg/NuzvRSeRXM9eYYKUvRp9laLTOr
	BoE56txTaXKuD48I8XeA1aOesHV486TMiIqD/xOUjkkxB5Avch4ik4bhjIjxktr3t8ZF2UYT1wm
	LeJituE5voemwk1XhxHFt9sCYkv3PzFkZT6RaRNRWFWPV/S/x4RZfZZ1ANtwjiltPDh+kewHL2r
	IPlGzCBIxwuxzDQRvCYBzES4cF5/Wiw==
X-Google-Smtp-Source: AGHT+IHi/zT+ITk2WKgt5up0EGbYekayPIcau0JEY0noZrqp0VAz5X/p+4huV58TNDRrCW9E3VV6OMyGM0jU
X-Received: by 2002:a05:690c:d08:b0:720:5fbc:20c2 with SMTP id 00721157ae682-7227653694dmr260626317b3.36.1757092845298;
        Fri, 05 Sep 2025 10:20:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-723a84cab9bsm8536447b3.25.2025.09.05.10.20.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso2742936b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092844; x=1757697644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLbk+VDIaBG3NrhNiwtkW7qI5ZnuEsuQOZ7XBwBTtd0=;
        b=Bo2tuZuLpqxF6Hqx1Z+hpDnKTjZMPAUweMHOHVnIeeN6vN8D6xzAvQ+za0mk1WMdYU
         sZ0jUg6dDWu3/xYj2ISMshuh9PlICXOR5kmlYuwyy6F1QtRjfc942+KaiUYgf54tc/96
         1hPrjmQgwbD2AholUmO0fnKSazZUarEfzeA0w=
X-Received: by 2002:a05:6a00:3d4a:b0:774:20f9:63c5 with SMTP id d2e1a72fcca58-77420f965a5mr3326596b3a.0.1757092843675;
        Fri, 05 Sep 2025 10:20:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d4a:b0:774:20f9:63c5 with SMTP id d2e1a72fcca58-77420f965a5mr3326562b3a.0.1757092843195;
        Fri, 05 Sep 2025 10:20:43 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:42 -0700 (PDT)
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
Subject: [v6, net-next 07/10] bng_en: Allocate stat contexts
Date: Fri,  5 Sep 2025 22:46:49 +0000
Message-ID: <20250905224652.48692-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  59 ++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 101 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  12 +++
 4 files changed, 174 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 5c178fade06..eb72b7ec555 100644
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
index a9fd5b242cb..5465c07d317 100644
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
@@ -643,6 +707,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -731,6 +796,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -1180,6 +1249,11 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 	return rc;
 }
 
+static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
+{
+	bnge_hwrm_stat_ctx_free(bn);
+}
+
 static int bnge_request_irq(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1221,6 +1295,25 @@ static int bnge_request_irq(struct bnge_net *bn)
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
@@ -1304,6 +1397,14 @@ static int bnge_init_nic(struct bnge_net *bn)
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


