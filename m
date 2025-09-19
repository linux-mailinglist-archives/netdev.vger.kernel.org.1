Return-Path: <netdev+bounces-224817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EAAB8AD05
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3555860C7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE926D4F9;
	Fri, 19 Sep 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gM1fSlBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89B322A2E
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304126; cv=none; b=R5lnNCb6g72/mTIHb0IS2dKmmjIqdgXHrohFaGwkCMdsr7YLlNsGS9R3xMxbQ2pJBiTLfB/67RUjgxWAPAViQxjGvF9Q6sZDYEP0YVgUA8zQdAOssB4t90IOmyNUKqjPNCrVv7v2+fJRKr8o4bhVFHL81lcDFV0yqHq68WyWnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304126; c=relaxed/simple;
	bh=4ySHLREyUAtWjLh82gQtAIXKkbuM/Pq0RWplAHVjlNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0lERshmHjRdbganiRpTEuHJCQNpyK8xMCOhh4/MvuXwT0TSAMB0LfUGwJMpppcSEui6MjCaS440wGtrf5t72f6uD+bRqPxsbROq/YWBN5wFCANfGut7opBlruE6iwc8szk4Wd/h3Hn1uWuQU+Nk9es+m1DXQd7aRAmS5B35OFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gM1fSlBS; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-792f273fbe4so13999626d6.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304124; x=1758908924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iQIDq5dTw5x1Y6mcj+DSZeu2XXA5UkkoVmQGpR+sJs=;
        b=RV6aBBlNtpP7KBWLbayisT7qs9XmXOlPOkN6Z/SVKWnakrjKCaYBc1B48fVThDYSl7
         ukSBublJveF4wqxN4FUjJMvMYaHSFv7Ciac4bwcF6cZ9d6EYjfbnGiiwt/gzZ3qsCS7T
         XzHdkjSlMQB7hpqKeY2kvtCOW4sg8k5CimSqtSc2IaQCcAOlUUkdwT5uMWsDArW9xY8k
         ITqcBvD+kiJCvm58pXzQU1FZWmdfORbRsvgh+s+B1FgyreRPqgZaWfeEpz4oJi0CNAcX
         XLNno2jUXmjtzeyo18Fq1tu4hEMszJkgCHNPTJjyirPfYwnjb3ZQX9dbo2c/Q/Egzq7e
         Ylbg==
X-Gm-Message-State: AOJu0Yz1IOLs/1cdQIz04uJE1rduOamAhP/uw7BX7L17zuZ/lvfMScSy
	OvzSCiZKQgOB2tffAGCyX05iNUA+6KtpjBIGmqLrlmYPZxeiysDXheF12ETr8T8XxWA+4p484kA
	oEh2hfaG3o5ciW8uxjGKVxJRca8/t1FZGqdhjHICx9g9rHrlXcVpsJhH8DHP45c7RUgRwkss3OY
	QB0Z8DoMgs6lNIVgz8F3k8AiecbkLXqM7erJcDraWdM3d/Amo4yfcQruzB+XkFzFLPPKghhVhY/
	jQGEpTK3LCzCet6Xy7q
X-Gm-Gg: ASbGnctyhi2tF2Jfs7KXYWJEAySM7imcbkiNrZ2NssvOe4r5BoDciudxQcpqFuby04X
	YgXvwpYt23DOxpAwdRKtapq+mQX/sJ7cuE4NntLq62B3gd6EkSVZScJAXG8qjyL5EzCRv0qh7Ua
	3gt4Iuo/JRAHZ0vq338+/zsrS059j1ipX0F2B1UOoI05a26b4DO76XY1oJ92MDPIhTH6rmtZf3q
	f91rumlNnst2/LUg6zl3tGn4JFNhbGkmYvT+h/eP+NxL5IhYq1LTgavli0RoMZ/dJtbUCc2rwL/
	rhan+eEQurNr0M3HteBCEBgpLKH4aMBWxaLbYlNa0btAFIT10SLgho6qKCMSsDwLF6xewQJ6zcQ
	otHyok64krhW9ssQylFfl14OfV3Rvh3RLbvbKbj3HU7JHDM2h4sUDZfXHCHlWCpmd/2b2U4GH6R
	vlVy3Xi8Od
X-Google-Smtp-Source: AGHT+IHuEP2U2iCJvIKJeMSWxEzaqV/H+aoy4qWQ3uA6EM/vom0GczIwO3Xb7bLBWGgaByQPBj05J3pFZ2Zn
X-Received: by 2002:a05:6214:2129:b0:77e:dd3e:a0c9 with SMTP id 6a1803df08f44-79911fe849emr52065816d6.14.1758304123527;
        Fri, 19 Sep 2025 10:48:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79350777044sm3316916d6.36.2025.09.19.10.48.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77e5a77a25aso1586258b3a.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304122; x=1758908922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iQIDq5dTw5x1Y6mcj+DSZeu2XXA5UkkoVmQGpR+sJs=;
        b=gM1fSlBSWRw9g1bmkALPC5Qd+VzRzY2hpUkQrKC6JRrdtPcreRjAB6kKl+DKwZocUF
         jtQLg5Sn/p7NpFiMR5CsOYdks2bcLxYnsDdp1TIgN86l45uPHqnhFeNuQZsZG5r40smU
         MkKM9I8m+nsgPPL7BC+FHGn8tGA0w/sKX/9es=
X-Received: by 2002:a05:6a20:7483:b0:262:c083:bb2e with SMTP id adf61e73a8af0-2925991ad89mr6111960637.8.1758304122177;
        Fri, 19 Sep 2025 10:48:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:7483:b0:262:c083:bb2e with SMTP id adf61e73a8af0-2925991ad89mr6111935637.8.1758304121763;
        Fri, 19 Sep 2025 10:48:41 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:41 -0700 (PDT)
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
Subject: [v8, net-next 07/10] bng_en: Allocate stat contexts
Date: Fri, 19 Sep 2025 23:17:38 +0530
Message-ID: <20250919174742.24969-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
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
index 1ccc027c021..9f1deb60dd2 100644
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
@@ -651,6 +718,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -739,6 +807,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -1189,6 +1261,11 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
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
@@ -1256,6 +1333,25 @@ static int bnge_request_irq(struct bnge_net *bn)
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
@@ -1317,6 +1413,14 @@ static int bnge_init_nic(struct bnge_net *bn)
 		goto err_free_rx_ring_pair_bufs;
 
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
 
 err_free_rx_ring_pair_bufs:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 10bd29a833e..55497c4e7fb 100644
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


