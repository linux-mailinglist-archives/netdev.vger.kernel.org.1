Return-Path: <netdev+bounces-237739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3788C4FC6F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBBD1890060
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04DC368271;
	Tue, 11 Nov 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LOMIgvKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148143DABE3
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894790; cv=none; b=PDnMukwVzmsyDMfmSs9Iygvgk+6fI7UCnC2wPSkp/SncjcH8LTUYhX+mAszn0Q80nx18jD2q+foQYwlbiSrObywWDUm+QhnQcyW8BQf9qQgRwjHQ3ocyR+VS2e4JTJ9byl+Ah6x+I2eGX6tyDVfTi0fKTxsfsr6X2XIC4/KslzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894790; c=relaxed/simple;
	bh=/qibkdkVZ/riFI1K0SgZu6BUGYGyIiaUFuAoIlefhPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdZ2PDzSK2ijZxvDHgX+09mk/vanuX/ntDP3SfxU2FzpjEqQl1QXkEuUl+9il+mBDL0WqGv65laGJ2+zpZD+hXmMaT4yBNXKka9ZYqNd+2wjayjlsOBWd3/byZ5RxlpjSPHkMkFORjtYCGitWcpXoZm0OHCGFCAM7si6L7kJHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LOMIgvKM; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so148301b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894788; x=1763499588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSdvE6BkVvMuvX+7mrakAC9nf9JTo8L7M24bVrgAbUs=;
        b=MXfmT78ie+BtmL1SOyNP2MGVR1LfPKFIIrK94DH//7HaSfw/CskgJPzEPjwoZwGUFT
         35bYqU8tjKktiv/kLNg/CTGRQchG+pCf9CmdhR0HS+GK/W4xHN9V6Nu9XoX+vWYL5uIT
         O1XG+Frm6mF30lW/tHh/AqwTD726RyE4v1fFc8DclbzxGBCE0zmoDrnaDTKyFMS7DeDB
         uZeNhYyE7gTWab8wlXanCDqSXUlTb7jKRKogTwbYJkksua69hDuNMEhkCLI9Wb3VEzIa
         wDFZ0NO9FkDDAZIkbwoUwL9yC7fTIa54ysU2hfLF2A7IpvnDQW5M/Hj65We/qSyGT5OV
         ikgg==
X-Gm-Message-State: AOJu0YytLY9J4LvBwlbhRzDcQjNsvfPnrJPwSyY/+dztOpM+Hv6/mwd5
	rGca4o1hcI4L85GKGImay7Zg1iJpHtlc+9ypuhlJQGBHtS5n6JRxx7Vr/5Za34fm9ocdh+OsV2d
	dtRnA3SZtkjRT2Dm4+ryT2dhpHM/nco/2bBzP66ZVAMEjrMwMrt6ke9WlJEQR20vAGZRoLWip2X
	i5bOZvOVRwgwpQ/zW2JAoj7gnt6VQxFDFPC1vyQ0wyalLhXc7dvBzqOAzoXGqFjGKp7teP+a8iV
	zaay9R6e5qxwGNfT/tW
X-Gm-Gg: ASbGncstnuS5Or7dEuDifmvVcH/B+L/O+rJ2fXeywkwLsssdeWwMw+rtDRfiF3hL7c1
	lDmBTul6gu55du8U9JbO1T3MZWaLn9dJcFKZfjDoCTini2p9RT7qZHBRVb3NhsRCCvU0mlG9ixg
	Cdoby8XfnVVKEhviOnBZ0Vb2cb3E72aQ09SXSNWVubv40bsM4TIuIP10Nf6vSNqE5SfLKE98oFW
	l0joGH0vOtUm92tTDfVho87ToOMrAjJy8GTXKTR4x3RGlunFJEfgZmRZFoVcQE+627WKz/a+UpH
	tZIq22sachwmTPVUuKJPxUJzKBHGfbOzRjNfXpdYGeYI7U+7+YLlK4P1sMsbjCDQ6QTQYIoN707
	tpEZ6YFX51AIIOudujki9FCmqF+lOrNeiEdE9Wv7nqw8sGFmswQg0fITbIsKEqAEL7CKZx0Z3vy
	UVdt3aF6EueHhuFCgMNyKAHdjD9OonKmdrcQAaahaJ
X-Google-Smtp-Source: AGHT+IGgreuSFryy18SYlUqBLY/RscZEuWX75csuWfjEAzwXIOIl0BlreOW1dYpyYOjfr18TCNmXZyPQe/dQ
X-Received: by 2002:a17:902:e5c3:b0:295:ed6:4625 with SMTP id d9443c01a7336-2984ee0459dmr7546035ad.47.1762894788326;
        Tue, 11 Nov 2025 12:59:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2984dc30078sm736685ad.28.2025.11.11.12.59.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:59:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7aa148105a2so132242b3a.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894787; x=1763499587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSdvE6BkVvMuvX+7mrakAC9nf9JTo8L7M24bVrgAbUs=;
        b=LOMIgvKMCevQKB/1YMgzCOrSdQy4OpQDnGTGMv4EBPVxCEx6bJHdfsubojnLwNI5oC
         NeBv+Xm9ghlJcOdB3NQ2i9tGTN2uJAyZi4HuMz7xEPQNA6+GFEdOFCMr6lIWPnYr+/N0
         n9wx772W/vnA84319neKyGKXAn0SfEXimM5nc=
X-Received: by 2002:a05:6a20:7d8b:b0:311:99:7524 with SMTP id adf61e73a8af0-3590968f670mr598252637.18.1762894786817;
        Tue, 11 Nov 2025 12:59:46 -0800 (PST)
X-Received: by 2002:a05:6a20:7d8b:b0:311:99:7524 with SMTP id adf61e73a8af0-3590968f670mr598227637.18.1762894786381;
        Tue, 11 Nov 2025 12:59:46 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:46 -0800 (PST)
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
Subject: [net-next 11/12] bng_en: Create per-PF workqueue and timer for asynchronous events
Date: Wed, 12 Nov 2025 02:28:01 +0530
Message-ID: <20251111205829.97579-12-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 29 +++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  2 ++
 4 files changed, 75 insertions(+), 1 deletion(-)

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
index ea406eaf18f..35362ab2aec 100644
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
@@ -2680,6 +2707,7 @@ static int bnge_open_core(struct bnge_net *bn)
 
 	bnge_enable_int(bn);
 	bnge_tx_enable(bn);
+	mod_timer(&bd->timer, jiffies + bd->current_interval);
 	/* Poll link status and check for SFP+ module status */
 	mutex_lock(&bd->link_lock);
 	bnge_get_port_module_status(bn);
@@ -2721,6 +2749,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+	timer_delete_sync(&bd->timer);
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index a7bcaeb461a..7ff993aaedc 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -905,4 +905,6 @@ int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 void bnge_get_ring_err_stats(struct bnge_net *bn,
 			     struct bnge_total_ring_err_stats *stats);
 void bnge_copy_hw_masks(u64 *mask_arr, __le64 *hw_mask_arr, int count);
+void bnge_timer(struct timer_list *t);
+void bnge_sp_task(struct work_struct *work);
 #endif /* _BNGE_NETDEV_H_ */
-- 
2.47.3


