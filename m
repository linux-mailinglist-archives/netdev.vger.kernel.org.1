Return-Path: <netdev+bounces-242027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE145C8BB90
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2CC3B92AE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C2346783;
	Wed, 26 Nov 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IIFWL6zU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE1346771
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186656; cv=none; b=QCgrxBa5/MpFUT8LBkLVvTS6rgEOJLh5EYQ5PfABzJxyWZakyhFjwEJtL9Wv4xO4fj7J40NvZPW3B/ybW4EBCqHUBJDEf5wUTmFpwUC83SYljs+AYNMmZ3r7xAvviTrbSeQpHtTuPfcorOGMOCynsKkRd5mbc9le3BOxO1YTGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186656; c=relaxed/simple;
	bh=BdToKwzhHDUrBZibBWqCuDSMZ+L/D7pPWXii5IIWxJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8332oYZfsVD4w9wV0h29ME4NWki8WI07z65gM3I0g6UD3SfdnL+TzT0dH4yxS0o5UvYdwbMxtubTLnUTzRYiuMwZr/TH2aFJB6oPJAeNzBS6Ke2KaraG2ZD4G8mqYgfuzmUV+CztiWq3mvXsjopgFy8mHxvEUo6YeSyRxzgLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IIFWL6zU; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7c76607b968so64752a34.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186653; x=1764791453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbNNdnMVfUObfWb7xsLH9p8NbtGDNVo859r7X/oBhzg=;
        b=vt7LvGJqXFNu+GHPKgWWXlRoMaIOBKwkm6dCGWL9ibUJd7vLAoI3orfTJ4b0Dt9Tzx
         yeJ9+o/MDIXC/H63JqO7qu6J8wRQbGnUybxwJGzCpGpW+z6/FDBcPesZgN8Q5SISC2J8
         HOiMo7+3h6Y+j9yhkGXqU6/BO5lQkyhpHIeeEHnqglV59WVqujjlt0hIgqKfonIL+pl1
         6+/k5HEQS+yJwXZ/dR+OIWyvDBaNeRFoGUzSDmDbcFc4ScDJ6nkm+MSnjhCBQsrYjVUQ
         EWpHWHHHutGhY8tH+79yi6IXdP50T9mPUkYFDcdX3a7l1Y78AvrVcF6nP0kDVqAIiQnN
         Njvw==
X-Gm-Message-State: AOJu0Yz/F4hHzrUNEhJ4dq+MqJ5AuxuyTIktBvTsGcARO8if2kGde42u
	kuUt6MYPwH6aXhViIDRJqVrn9C2OXuSTUIBj3j/K7z0XOeTdJMNQxsw8j6U62DfJsXFo8XhrsKL
	1unKXpySena2GZRWuwgv/DOlY1rVwwbrPsQb1NA18+qFFNcHEgW0xFQpXyo48gla6h4yQt0MAR5
	cDiFxNtF4PH/0ZItC2wiaLRAbccNs0iM1afMhXM+oBumfJPdGovLOGepOFN23W6SdBxrG6DNGcy
	SzJKsmWfQl+62C2fHcj
X-Gm-Gg: ASbGncvvwQsjRWz9pp5wwUDtgtl62kU6qvvwVN2gN+D+qCXQTnvuvYv+s/IfIHI9iQr
	MSGNMJ+DR8/TrJHTA2yuNOrmu68RLDkQO8mqEpo+PLra2FBLu2RP4zesgzS+LbGDBK6D8HnAYHJ
	VZiXcSwFYZd0FvznJEuHli5THWIUEj+jA6v4g6uAmjW2ZudJKdooELcF7i9bYgQgaygmEmbv/Ru
	mk82qaLh+6DIC/IYifGzrVr0hdf18rRSfFBakuYR18m7hG/VvJLDCSnWhhupGYIpkx77vyDVuHW
	TlDuQa4A328fihH2Bq5zOsOuOfc5GfGq9EKMkS3fyn0tOzZgJWwoWkLIjohafAi/5Dvpsha0dPF
	AqvxX3v2zKBUA4Zclph6P4pwJ+KORVIc3wqfepf+vEzDRIviU7DofbHstS+lmdzErezBLYHRz2I
	4FOk8nJIlX8WDOkfY9Mus7Hi1KivccG1Vvbbz3WISbwuMlw9QdTEk=
X-Google-Smtp-Source: AGHT+IFxD/DIZ2l9gBmewOZ3YG3W/DEMQCzOfC4V4Sdz40TzqjXnzw7WEOZy3sjkU34SGy2k7zWhBD+zTvwp
X-Received: by 2002:a05:6830:6da7:b0:7c6:c841:657d with SMTP id 46e09a7af769-7c7990baea0mr9259293a34.34.1764186653373;
        Wed, 26 Nov 2025 11:50:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c78d3d072csm2240445a34.8.2025.11.26.11.50.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297e5a18652so1293525ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764186652; x=1764791452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbNNdnMVfUObfWb7xsLH9p8NbtGDNVo859r7X/oBhzg=;
        b=IIFWL6zU0gIW5esnhSta1CTmxMA13CgQ/RdEEqy+rA5NqNN+YRvpRFtc/ZgDkNnMCb
         o3ACoKMERI/rmcCbHHG13x2vR1Q6CCAMtehR3T5bftR3yq84cQw+lZ/B6t++3VAiQfVN
         BbGuav9tHDDVqTX2UCax4vx/tR6Jl9e6jF5g8=
X-Received: by 2002:a17:902:ef51:b0:295:9b39:4533 with SMTP id d9443c01a7336-29b6c57210emr239858145ad.30.1764186651891;
        Wed, 26 Nov 2025 11:50:51 -0800 (PST)
X-Received: by 2002:a17:902:ef51:b0:295:9b39:4533 with SMTP id d9443c01a7336-29b6c57210emr239857815ad.30.1764186651480;
        Wed, 26 Nov 2025 11:50:51 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm206782375ad.58.2025.11.26.11.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:51 -0800 (PST)
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
Subject: [v3, net-next 11/12] bng_en: Create per-PF workqueue and timer for asynchronous events
Date: Thu, 27 Nov 2025 01:19:30 +0530
Message-ID: <20251126194931.455830-12-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  3 ++
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 72d9865ba7b..0b75d6139b1 100644
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
index f9d7f90a825..824374c1d9c 100644
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
index d7713bd57c6..9f5430d4180 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -352,6 +352,7 @@ struct bnge_net {
 
 	unsigned long		state;
 #define BNGE_STATE_NAPI_DISABLED	0
+	atomic_t		intr_sem;
 
 	u32			msg_enable;
 	u16			max_tpa;
@@ -646,4 +647,6 @@ int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 void bnge_get_ring_err_stats(struct bnge_net *bn,
 			     struct bnge_total_ring_err_stats *stats);
 void bnge_copy_hw_masks(u64 *mask_arr, __le64 *hw_mask_arr, int count);
+void bnge_timer(struct timer_list *t);
+void bnge_sp_task(struct work_struct *work);
 #endif /* _BNGE_NETDEV_H_ */
-- 
2.47.3


