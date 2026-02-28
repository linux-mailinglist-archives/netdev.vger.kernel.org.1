Return-Path: <netdev+bounces-262092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPVrJEaZomlI4QQAu9opvQ
	(envelope-from <netdev+bounces-262092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:29:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC371C0FF3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03BA230D861B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AD36C5B8;
	Sat, 28 Feb 2026 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UwNk9hhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DDC36CDE6
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263687; cv=none; b=idxG4Lo5kevgeye4WVOUiZy5fhcptJ4x9MTq1P1q57rH5g7kvsLWVhQqSW1D0gQ8iixtP4YQGvCD1CGTyhRYWMmkl/2UZmJor42pM4EeMTbX82iN/FUWOqpBohnAvOH/PiiK1jXpuFx7aGR9+p4G0jit6Xux2hDvnLv878X3aFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263687; c=relaxed/simple;
	bh=JxO81/weFyc459OMqAugvZdWK5EbJ/Ld7je/eSdGL+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8YTR+PM/3IJPeA350qB+WCkFnOZImmATrNHE7qgJdP/4scv2rg4xVJi9z+Pm1yGaeKRjUknTkR0L7y91+fY7bnysMoYTj+Upi1HrE73f4pUHLEs4Rxl6GhgUZLX7RLFUdQOM3/eWrUxqMI0lIfbBEM0ODwHZgYQgcbzzZVrLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UwNk9hhx; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-899b2b6ab42so25132866d6.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772263681; x=1772868481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLbZWpd5u/NFnfx5DlhA19ecuXsYw/JuQ0/iZQbB610=;
        b=Ce5Ml7hZHeVGI5ZPK1F0VU3SKFE7vn8mAUs9MPmdGXZNJW2YbFYJBnEn27ZiqiKI1E
         kaC7Nsy1RT1IAQSCOTwGY8hyB7HoEz+TZG30KNx00uMmIZkaPyXJtwCSF8nlH/Twg2ig
         GzZNG+eO8adVZFI5f4aA57iY2UgZwkfBhzxMAZqL4RLlVtw6d/sIZ27MmuHOiO/IJNx9
         QqxS5I+HVVg7Uilnw4w9mdSy6CSmwz3eIzPrErzdgyBoEDsdl74bL/+BxRgDlOgkdRBS
         13SZfhknkrPBuujk5Lzck5cQhBlGcZQQGf+lQjJ706IRTVwXJyfuJw/wFyqEL0f7rDsR
         Fn6Q==
X-Gm-Message-State: AOJu0Yx59xtLPAZiTA0pb+ihz62Svqq6+0faqDSKblfjVv5z/vRIeweS
	bJy7xQ3PHbCN5+tIEiTeVao8eddzzI2lJVFPTnKYbBejF4sNCBWz8BuOF7CqsdeDpie+7oT23m/
	HWF+HmRLM9qcq3XJVnn9CROCt6nCdPI6pOpqcWaBnJBsVxjk3vYw2I2jFvzsBeX4ORm2HO9is5f
	Bq2HUuO6XsvMEPs112NN83eYOamupVDeIj3qmbHgrz8Sh7KrEKioBngk2M+YLhUjO/t+GC/6bM9
	2CTFnBgjKKCXc8Ncw==
X-Gm-Gg: ATEYQzybuHSR++sXE48U5blbozla46ClKAQ3UcJu7rDxYwV33aB98SKW8jtmT644XW6
	vC4li7cf025HVWbgo278F52sQxQZwemR6WLZfiCNVkJEsURGx4fEGczWS+BDqnqXabCE4JjhTvG
	ebMKgBdVoTzFsl4ytTbjjRSnLwLjnzFXhvVLnwcwJVntfpO+T1CiJ3hLnmifqClNZrIWIiqaw27
	Pw3/cZzUP24+4DilbN68QhOlCBFyawSEFagNAUGPzZgn7aP96MEY0r3f24jze3CSBXdwSeaNB2P
	5yKV2VIPpReJWS3RUw816PUvmcRPvnD6qqCIpIo9x2a++iP8lni85NhNZTh4/On3OnXUVerXyaO
	MVZNg6qm96An9fpWNJDuSebTIO7RxZBsQpXgGAtJAKmdHgsOxWbrQncNCRDmZWFPLsTiVITqhOZ
	5FLNCYodLyfajKehRunsnq3R9V/2gktFGC83uvuhGG4tbiELoIfogJdHtFgYQ0aWbzYg==
X-Received: by 2002:a05:6214:3008:b0:895:d629:5083 with SMTP id 6a1803df08f44-899d1dbabe2mr84209136d6.27.1772263681441;
        Fri, 27 Feb 2026 23:28:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-899c7374ee1sm6566476d6.30.2026.02.27.23.28.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 23:28:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70f137aa4aso1570904a12.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772263680; x=1772868480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLbZWpd5u/NFnfx5DlhA19ecuXsYw/JuQ0/iZQbB610=;
        b=UwNk9hhxpBboU/7fH1zZh2Ntg/PE+IyOh3sfkhk4VKgww4iD2D4uU//QlItvgKt0Jy
         wS5Ok6mVwfkgLhfEziRNU2IeRQxSopMb8N4jDDqns7l46MCBXnySYoxd98WVEioYoPal
         G3fsYVzeX/d79WHsVO7rn5SeXbJEo/EqdK+fM=
X-Received: by 2002:a05:6a00:f04:b0:81f:2b25:ca73 with SMTP id d2e1a72fcca58-8274d9eabbemr5703040b3a.38.1772263679767;
        Fri, 27 Feb 2026 23:27:59 -0800 (PST)
X-Received: by 2002:a05:6a00:f04:b0:81f:2b25:ca73 with SMTP id d2e1a72fcca58-8274d9eabbemr5703022b3a.38.1772263679189;
        Fri, 27 Feb 2026 23:27:59 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm6809267b3a.36.2026.02.27.23.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:27:58 -0800 (PST)
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
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v3 1/8] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Sat, 28 Feb 2026 12:57:08 +0530
Message-ID: <20260228072715.1632280-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
References: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262092-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EFC371C0FF3
X-Rspamd-Action: no action

Add a dedicated single-thread workqueue and a timer for each PF
to drive deferred slow-path work such as link event handling and
stats collection. The timer is stopped via timer_delete_sync()
when interrupts are disabled and restarted on open. The open and
close paths now start and drain these resources.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 87 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 13 ++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a20dc3ca640..ee77b29f5b9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -101,6 +101,45 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
 	return rc;
 }
 
+static void bnge_timer(struct timer_list *t)
+{
+	struct bnge_net *bn = timer_container_of(bn, t, timer);
+	struct bnge_dev *bd = bn->bd;
+
+	if (!netif_running(bn->netdev) ||
+	    !test_bit(BNGE_STATE_OPEN, &bd->state))
+		return;
+
+	/* Periodic work added by later patches */
+
+	mod_timer(&bn->timer, jiffies + bn->current_interval);
+}
+
+static void bnge_sp_task(struct work_struct *work)
+{
+	struct bnge_net *bn = container_of(work, struct bnge_net, sp_task);
+	struct bnge_dev *bd = bn->bd;
+
+	set_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+	/* Ensure sp_task state is visible before checking BNGE_STATE_OPEN */
+	smp_mb__after_atomic();
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
+		clear_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+		return;
+	}
+
+	/* Event handling work added by later patches */
+
+	/* Ensure all sp_task work is done before clearing the state */
+	smp_mb__before_atomic();
+	clear_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+}
+
+static bool bnge_drv_busy(struct bnge_net *bn)
+{
+	return test_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -2507,6 +2546,9 @@ static int bnge_open_core(struct bnge_net *bn)
 	bnge_enable_int(bn);
 
 	bnge_tx_enable(bn);
+
+	mod_timer(&bn->timer, jiffies + bn->current_interval);
+
 	return 0;
 
 err_free_irq:
@@ -2542,6 +2584,12 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	/* Ensure BNGE_STATE_OPEN is cleared before checking drv_busy */
+	smp_mb__after_atomic();
+	while (bnge_drv_busy(bn))
+		msleep(20);
+
+	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
 	bnge_free_all_rings_bufs(bn);
@@ -2690,6 +2738,23 @@ static void bnge_init_ring_params(struct bnge_net *bn)
 	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
 }
 
+static struct workqueue_struct *
+bnge_create_workqueue_thread(struct bnge_dev *bd, const char *thread_name)
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
+	kfree(wq_name);
+
+	return wq;
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -2774,6 +2839,17 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	if (bd->tso_max_segs)
 		netif_set_tso_max_segs(netdev, bd->tso_max_segs);
 
+	INIT_WORK(&bn->sp_task, bnge_sp_task);
+	timer_setup(&bn->timer, bnge_timer, 0);
+	bn->current_interval = BNGE_TIMER_INTERVAL;
+
+	bn->bnge_pf_wq = bnge_create_workqueue_thread(bd, "bnge_pf_wq");
+	if (!bn->bnge_pf_wq) {
+		netdev_err(netdev, "Unable to create workqueue.\n");
+		rc = -ENOMEM;
+		goto err_netdev;
+	}
+
 	bn->rx_ring_size = BNGE_DEFAULT_RX_RING_SIZE;
 	bn->tx_ring_size = BNGE_DEFAULT_TX_RING_SIZE;
 	bn->rx_dir = DMA_FROM_DEVICE;
@@ -2789,11 +2865,13 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
-		goto err_netdev;
+		goto err_free_workq;
 	}
 
 	return 0;
 
+err_free_workq:
+	destroy_workqueue(bn->bnge_pf_wq);
 err_netdev:
 	free_netdev(netdev);
 	return rc;
@@ -2802,8 +2880,15 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 void bnge_netdev_free(struct bnge_dev *bd)
 {
 	struct net_device *netdev = bd->netdev;
+	struct bnge_net *bn;
+
+	bn = netdev_priv(netdev);
 
 	unregister_netdev(netdev);
+
+	cancel_work_sync(&bn->sp_task);
+	destroy_workqueue(bn->bnge_pf_wq);
+
 	free_netdev(netdev);
 	bd->netdev = NULL;
 }
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 70f1a7c2481..b00d2e3922d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -224,6 +224,13 @@ struct bnge_tpa_info {
 #define BNGE_NQ_HDL_TYPE(hdl)	(((hdl) & BNGE_NQ_HDL_TYPE_MASK) >>	\
 				 BNGE_NQ_HDL_TYPE_SHIFT)
 
+enum bnge_net_state {
+	BNGE_STATE_NAPI_DISABLED,
+	BNGE_STATE_IN_SP_TASK,
+};
+
+#define BNGE_TIMER_INTERVAL	HZ
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -281,13 +288,17 @@ struct bnge_net {
 	u32			stats_coal_ticks;
 
 	unsigned long		state;
-#define BNGE_STATE_NAPI_DISABLED	0
 
 	u32			msg_enable;
 	u16			max_tpa;
 	__be16			vxlan_port;
 	__be16			nge_port;
 	__be16			vxlan_gpe_port;
+
+	unsigned int		current_interval;
+	struct timer_list	timer;
+	struct workqueue_struct *bnge_pf_wq;
+	struct work_struct	sp_task;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
-- 
2.47.3


