Return-Path: <netdev+bounces-238764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E57C5F25C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDBE04F28DF
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8846A34D3BD;
	Fri, 14 Nov 2025 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZVEQFr8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68D348867
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150081; cv=none; b=W1mNSVGAT3PD22acPlo4zJ3OYFMvZnhzwMXuQzefgP6/f92eO5NVYLyD74hKJSYVjq8FshN4F1XxLphOUSfMGY5vX/UkeGj8NRSTsPjwJVaAymciuGGHAayvaDP6aFkfufPkweLewdnO7cYu7d04vTzM6b2zpGL51P/9n57Z0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150081; c=relaxed/simple;
	bh=OrD9Ux1I7rP754bI5lNMmoREVCGshVzoAURrDF98QP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGIPxfkkhvDsmSAO2fWY/oVHkkOVf/pY3bLTYGmHCwbKwGfylPGW0ZbB2Bc6fSWHbl0PW4exUF4zuf5ZT3Y9qGOEok6reKXJwC/grEvNk0O1a4dpctbo/CKQrcdTzBhW+9D5HT5x3KHzd6eG/jLnCclSN+Q1UGB1z/a9tuqhaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZVEQFr8Q; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8a479c772cfso160730085a.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150078; x=1763754878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uto9E9SZ6tzS7AVoNvWU4Gi1aUc7ff/KJq+z0rhWh2o=;
        b=ATUn6edawWQmkF0SfHQR/KGaCuCOrCjwLiVCo3RqZj8Iw/lzPefbqhcLgV1FJvHvsD
         dyagpVnqKxRjy23P7jB5Ej8Vv6q/QDA8+VpBE4nxFxMhQ7QAKC0dzms3PW4doDdJfDwm
         x+CzkiLlT3BIllztfty1GbD/vE2Yfm927oNtZwTaSY5PWLXuhfFNlr5Z2T4l5/D5Uc5f
         KdK7iatbh6FiAxWS9K5CNNEr8B/BViqhqIZIU5sklV0jHLWK8HpIcTJmXVzWgU+1awLu
         s27zpXkdmd8CIpmQrbvJhx8l6MCm1oSxYb5xBuJ5dqqDSR1+IWQ/UFYt9n7PEgsJm0zQ
         2g6Q==
X-Gm-Message-State: AOJu0YxKRdVr6UzOR3urFNxNj39HtVR+EuijmIj68O8IZU2qVqJTb0ad
	iGIOdGEagFUJ24JSzQfKl04nNKo+HIZnqvTAdYEwq5yNzhmJvFZcIfE9PumYBNMcgO08l02M2Rs
	7HGVr0miQR1mbZjaHHq2BpIjMTFsXnRxlrxQ+o+/hFjIA/q5/Juc2LheYQUWBPusfsyOC9LnJGq
	LnAVFudfy2SKmTNr1XLnZgf1J9WBgvIa14kOHBxPU++M1w+OiRYA3RLejL8O7x3nII/9tleCvRP
	fXA5g5dEzpV+O0LnA==
X-Gm-Gg: ASbGncviqViZjdqsDifW6Uk5olJftOdk11TUVBH3rm4jR54wrPwpBihnEZxWNh0pdZD
	/qvt59Az8sZDrEtMdRAcZn9JUV09guuqZ2POF/zGZPzaRreCs0vOzkv2hgcep5OgDB/yDO5OUt8
	TmwoFK+bcG82X2ceZtwOCs/TyMnGuco468+OyYd3HXK9yxXEFfpsr0bA3vYS3R5FYOgCjKaDxDP
	H0TgOEjn6//3YTsb145tTyhMxKSRn3RtfODceQItO2b6+zbrEkdHraBFLQ4ObxTFu8E8XL4ltQP
	7fWSwicz3xkT+ng6Plqu/BiF8fh7wsyenTu3mey0ZOQgZq/tqxwzksep6PkfFXrS/C6ezAVMVMg
	EAOIprV/r8jNZnORcg7zVYvx3vxPehLOXVoba2fJMuoKZqR5dhGV64Gwzcb5B29d6tKZEFECsA6
	xgSg91ryWbU5EdOF9mYge8Z8O6vrwkjGKerVlUlruMYeY=
X-Google-Smtp-Source: AGHT+IG2Ny6Kd9UYDtDWDoLeA0q+Pu4MyK6HdWOG6tiiLT5fUo9qhRzNnPbx+uwpdKOc0irdoy/f3f8EajA/
X-Received: by 2002:a05:620a:2801:b0:8a2:7cda:f040 with SMTP id af79cd13be357-8b2c31a1957mr561699085a.51.1763150078062;
        Fri, 14 Nov 2025 11:54:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8b2d327f1e2sm3308985a.2.2025.11.14.11.54.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:54:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297d50cd8c4so70379985ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763150077; x=1763754877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uto9E9SZ6tzS7AVoNvWU4Gi1aUc7ff/KJq+z0rhWh2o=;
        b=ZVEQFr8QJv1dSTYsJLjDuILxwlL0IUHrfkbjtDRVKKZnzyKWQkBqwLQz6DNrE7jopj
         7St50jD3MHlcbyCeS/TE1SPzzSxVPTRLriUp66mCMtQxO8fe745HcrP5cDtUfaYlXMTT
         0oaS0tTvMvzQepGXyYAttm2jLDJ4EVqZ1klMo=
X-Received: by 2002:a17:903:198d:b0:298:2de9:e312 with SMTP id d9443c01a7336-2986a76b898mr50608625ad.59.1763150076747;
        Fri, 14 Nov 2025 11:54:36 -0800 (PST)
X-Received: by 2002:a17:903:198d:b0:298:2de9:e312 with SMTP id d9443c01a7336-2986a76b898mr50608365ad.59.1763150076341;
        Fri, 14 Nov 2025 11:54:36 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea5f9fa4sm3108113a91.0.2025.11.14.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:54:35 -0800 (PST)
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
Subject: [v2, net-next 11/12] bng_en: Create per-PF workqueue and timer for asynchronous events
Date: Sat, 15 Nov 2025 01:22:59 +0530
Message-ID: <20251114195312.22863-12-bhargava.marreddy@broadcom.com>
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

Use a dedicated workqueue and timer for each PF to handle events. This
sets up the infrastructure for the next patch, which will implement the
event handling logic.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     | 10 ++++++
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 35 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 31 ++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  4 +++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 33b42408b1d..88b904246f5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -136,6 +136,7 @@ struct bnge_dev {
 	unsigned long           state;
 #define BNGE_STATE_DRV_REGISTERED      0
 #define BNGE_STATE_OPEN			1
+#define BNGE_STATE_IN_SP_TASK		2
 
 	u64			fw_cap;
 
@@ -208,9 +209,18 @@ struct bnge_dev {
 	u8			max_q;
 	u8			port_count;
 
+	unsigned int		current_interval;
+#define BNGE_TIMER_INTERVAL	HZ
+
+	struct timer_list	timer;
 	struct bnge_irq		*irq_tbl;
 	u16			irqs_acquired;
 
+	struct workqueue_struct *bnge_pf_wq;
+	struct work_struct	sp_task;
+	unsigned long		sp_event;
+#define BNGE_PERIODIC_STATS_SP_EVENT	0
+
 	/* To protect link related settings during link changes and
 	 * ethtool settings changes.
 	 */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 2c72dd34d50..dfa501f912a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -238,6 +238,23 @@ static int bnge_map_db_bar(struct bnge_dev *bd)
 	return 0;
 }
 
+static struct workqueue_struct *
+bnge_create_workqueue_thread(struct bnge_dev *bd, char thread_name[])
+{
+	struct workqueue_struct *wq;
+	char *wq_name;
+
+	wq_name = kasprintf(GFP_KERNEL, "%s-%s", thread_name,
+			    dev_name(bd->dev));
+	if (!wq_name)
+		return NULL;
+
+	wq = create_singlethread_workqueue(wq_name);
+
+	kfree(wq_name);
+	return wq;
+}
+
 static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int max_irqs;
@@ -277,6 +294,10 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_devl_free;
 	}
 
+	INIT_WORK(&bd->sp_task, bnge_sp_task);
+	timer_setup(&bd->timer, bnge_timer, 0);
+	bd->current_interval = BNGE_TIMER_INTERVAL;
+
 	rc = bnge_init_hwrm_resources(bd);
 	if (rc)
 		goto err_bar_unmap;
@@ -318,14 +339,24 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_config_uninit;
 	}
 
+	bd->bnge_pf_wq = bnge_create_workqueue_thread(bd, "bnge_pf_wq");
+	if (!bd->bnge_pf_wq) {
+		dev_err(&pdev->dev, "Unable to create workqueue.\n");
+		rc = -ENOMEM;
+		goto err_free_irq;
+	}
+
 	rc = bnge_netdev_alloc(bd, max_irqs);
 	if (rc)
-		goto err_free_irq;
+		goto err_free_workq;
 
 	pci_save_state(pdev);
 
 	return 0;
 
+err_free_workq:
+	destroy_workqueue(bd->bnge_pf_wq);
+
 err_free_irq:
 	bnge_free_irqs(bd);
 
@@ -356,6 +387,8 @@ static void bnge_remove_one(struct pci_dev *pdev)
 
 	bnge_netdev_free(bd);
 
+	destroy_workqueue(bd->bnge_pf_wq);
+
 	bnge_free_irqs(bd);
 
 	bnge_net_uninit_dflt_config(bd);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index f00576dd5e0..872c8b6a9be 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -253,6 +253,33 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
 	return rc;
 }
 
+void bnge_timer(struct timer_list *t)
+{
+	struct bnge_dev *bd = timer_container_of(bd, t, timer);
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct net_device *dev = bd->netdev;
+
+	if (!netif_running(dev) || !test_bit(BNGE_STATE_OPEN, &bd->state))
+		return;
+
+	if (atomic_read(&bn->intr_sem) != 0)
+		goto bnge_restart_timer;
+
+bnge_restart_timer:
+	mod_timer(&bd->timer, jiffies + bd->current_interval);
+}
+
+void bnge_sp_task(struct work_struct *work)
+{
+	struct bnge_dev *bd = container_of(work, struct bnge_dev, sp_task);
+
+	set_bit(BNGE_STATE_IN_SP_TASK, &bd->state);
+	smp_mb__after_atomic();
+
+	smp_mb__before_atomic();
+	clear_bit(BNGE_STATE_IN_SP_TASK, &bd->state);
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -2111,6 +2138,7 @@ static void bnge_disable_int_sync(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	atomic_inc(&bn->intr_sem);
 	bnge_disable_int(bn);
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
@@ -2124,6 +2152,7 @@ static void bnge_enable_int(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	atomic_set(&bn->intr_sem, 0);
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
@@ -2677,6 +2706,7 @@ static int bnge_open_core(struct bnge_net *bn)
 
 	bnge_enable_int(bn);
 	bnge_tx_enable(bn);
+	mod_timer(&bd->timer, jiffies + bd->current_interval);
 	/* Poll link status and check for SFP+ module status */
 	mutex_lock(&bd->link_lock);
 	bnge_get_port_module_status(bn);
@@ -2718,6 +2748,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+	timer_delete_sync(&bd->timer);
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 1b66e44c3b9..ad1cfd4e6f0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -350,6 +350,8 @@ struct bnge_net {
 
 	struct bnge_ethtool_link_info	eth_link_info;
 
+	atomic_t		intr_sem;
+
 	unsigned long           state;
 #define BNGE_STATE_NAPI_DISABLED	0
 
@@ -894,4 +896,6 @@ int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 void bnge_get_ring_err_stats(struct bnge_net *bn,
 			     struct bnge_total_ring_err_stats *stats);
 void bnge_copy_hw_masks(u64 *mask_arr, __le64 *hw_mask_arr, int count);
+void bnge_timer(struct timer_list *t);
+void bnge_sp_task(struct work_struct *work);
 #endif /* _BNGE_NETDEV_H_ */
-- 
2.47.3


