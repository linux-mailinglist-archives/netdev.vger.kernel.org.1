Return-Path: <netdev+bounces-187338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD07AA676F
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA3B16FD56
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1921B90B;
	Thu,  1 May 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpUOvMDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C945265607
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142214; cv=none; b=VdARLe1CwH71Tm0EYVUUMKyCYKH3odBltXY0J42obQtpvYSZXSUhkNnKbFoCpkhVJjCcqJcTX1hkXcOxzTc7wbtAFhru92bcfmLDzIDcJDXg5AbOroKegStaSsgkfMc+SHGZjFI84LNErhbXkYI3sn3XLUu1hSe/8tbiXQj8PhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142214; c=relaxed/simple;
	bh=Ic8i3AUMwybu3Em3oudzBG+B8K2B9bXU9vc1+3WFLo4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXRP2CyQLNU5Nd1xfICL6ucux5EjDR/HGMKq8bt5IgdVosyzsidqjtbRs/TRtIkhYwVIpcwr/ucUpWvhmNAd9ShPHKiej9DK1VQWYJiwLvi15KVYclzPqmGEr3b0MwOqzvvRz+/TxUlZntrGjyUtETdNWsvtVH4crQqbrR8sCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpUOvMDC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1506601b3a.0
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746142211; x=1746747011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RGU7yQMF+pHr09kvn6YF7wW8+U7H739V89wQF6f92G0=;
        b=WpUOvMDCRBWwIzhpwEodCTLXzS9vCQSur11npsSzfsML4QoY6UOESahtTf78kc6u8X
         EQWh3E3PJYAM9SpRTb9O8hTRupBdGSfwdN5pYKu5DqoDR8rMJ424tavZKedkKDVOaT/1
         jfXTfcdsxkZSZJLZyFdAPGUGXf8VHW4cmRyfpdqgFGrcfl8EZHIK6p5v3FW9VAYmj+A2
         GD+IONg4M1g+V4e7z7DyHlcJXAibUGG3tvl9gVoNW5+sBVcK7l4QqNiITyRXAWXxU4R/
         DidO1XHMcf9Q6lYTS+oO3bwCDpjWPcIvlmR9HjrZb0huLbGqbfH4SAYPsvz/l1yg8D74
         ddGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142211; x=1746747011;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGU7yQMF+pHr09kvn6YF7wW8+U7H739V89wQF6f92G0=;
        b=b09xJvdZglhws3BFeS0lRw7ECE9hgkkhsra6KLvIMGUK+hzP72jvvq7lsL1qf7ltUl
         7hUepbZS2Qn2+CwRnYXeVKu4U4bkgVcCYnpZD7zfOMRVhJX+13eZaHZoeSfPrMdCl5Pw
         3GEkK+dW+0u8LSpMZOGXYrtm0B/1SmeEpvF1hdZxIcL+wbhGtFhZOZusAl4sjPGYC6F9
         7yna1oIb/SsZzeWGh8cqbKYIpBsPOJd7IhqC03rAuFv1zgijxLjkMxnkQs5fOG0j5j6B
         JnL8Uu54+asAbT4IXjZMYj6HOFrVTyJJlYwUx5ZeBj1pWJx4zi40fxqRwzYjIdSdzD15
         LRUQ==
X-Gm-Message-State: AOJu0YwkvLz04vwvfWz9Ir2ZaNvyWpcMezm6TpLcpX6iJ4taT/zdbJu5
	eDpDeRLHWiqNHFVCyshmLy6c1UGwTv/+Lj8zS3K9oUd6EFWJ6BSU
X-Gm-Gg: ASbGncu+bpZIoJPUSrHYWJThT22quRqrj+HmeUq1xxvJBh5JyvVe+NjlkcJTcBXfj95
	y4i+krC3Nzk9vO8bx2qwGocdHOe9P77ghbD+MNfadJnzgoqBntwb/IeDyRDhLvxe3cW5pAPZY1t
	xNtfbSSo1Vy/645yIv9SYchBWwtyCg6N1/cpH/Jh/cl+QNCeDB/W3xGMQC+V/xrld19z9UVSaDJ
	GsnOrQaEGeDXbtzpXg9gAhJDFMxamD2lt70mYONctHU5EU5J9tnYQ3jxk/goXoz0LQcsNIElpe/
	dxWGYebwX5QW3nulDK6bL10lsw/Ajb90bCdQ4PVWEBt2md8uhspiiMx943qEjhNEp5teqimUWPk
	=
X-Google-Smtp-Source: AGHT+IErqYNdfaIjC1L27KfHHEErHYFAO4O3V4aRfsM0h497dZs6kKNSN4PStnGBmnGdWYOXSbaJBQ==
X-Received: by 2002:a05:6a20:7d9e:b0:1f5:56fe:b437 with SMTP id adf61e73a8af0-20cdfcfc81amr1122386637.32.1746142211290;
        Thu, 01 May 2025 16:30:11 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa82b68c1sm164640a12.37.2025.05.01.16.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:30:10 -0700 (PDT)
Subject: [net PATCH 3/6] fbnic: Add additional handling of IRQs
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 May 2025 16:30:10 -0700
Message-ID: 
 <174614221004.126317.3819743775871203479.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

We have two issues that need to be addressed in our IRQ handling.

One is the fact that we can end up double-freeing IRQs in the event of an
exception handling error such as a PCIe reset/recovery that fails. To
prevent that from becoming an issue we can use the msix_vector values to
indicate that we have successfully requested/freed the IRQ by only setting
or clearing them when we have completed the tiven action.

The other issue is that we have several potential races in our IRQ path due
to us manipulating the mask before the vector has been truly disabled. In
order to handle that in the case of the FW mailbox we need to not
auto-enable the IRQ and instead will be enabling/disabling it separately.
In the case of the PCS vector we can mitigate this by unmapping it and
synchronizing the IRQ before we clear the mask.

The general order of operations after this change is now to request the
interrupt, poll the FW mailbox to ready, and then enable the interrupt. For
the shutdown we do the reverse where we disable the interrupt, flush any
pending Tx, and then free the IRQ. I am renaming the enable/disable to
request/free to be equivilent with the IRQ calls being used. We may see
additions in the future to enable/disable the IRQs versus request/free them
for certain use cases.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Fixes: 69684376eed5 ("eth: fbnic: Add link detection")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h        |    8 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c    |  142 ++++++++++++++++--------
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |   14 +-
 4 files changed, 110 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 4ca7b99ef131..de6b1a340f55 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -154,14 +154,14 @@ struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev);
 void fbnic_devlink_register(struct fbnic_dev *fbd);
 void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 
-int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
-void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
+int fbnic_fw_request_mbx(struct fbnic_dev *fbd);
+void fbnic_fw_free_mbx(struct fbnic_dev *fbd);
 
 void fbnic_hwmon_register(struct fbnic_dev *fbd);
 void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
 
-int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
-void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);
+int fbnic_pcs_request_irq(struct fbnic_dev *fbd);
+void fbnic_pcs_free_irq(struct fbnic_dev *fbd);
 
 void fbnic_napi_name_irqs(struct fbnic_dev *fbd);
 int fbnic_napi_request_irq(struct fbnic_dev *fbd,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 1bbc0e56f3a0..1c88a2bf3a7a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -19,69 +19,105 @@ static irqreturn_t fbnic_fw_msix_intr(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int __fbnic_fw_enable_mbx(struct fbnic_dev *fbd, int vector)
+{
+	int err;
+
+	/* Initialize mailbox and attempt to poll it into ready state */
+	fbnic_mbx_init(fbd);
+	err = fbnic_mbx_poll_tx_ready(fbd);
+	if (err) {
+		dev_warn(fbd->dev, "FW mailbox did not enter ready state\n");
+		return err;
+	}
+
+	/* Enable interrupt and unmask the vector */
+	enable_irq(vector);
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
+
+	return 0;
+}
+
 /**
- * fbnic_fw_enable_mbx - Configure and initialize Firmware Mailbox
+ * fbnic_fw_request_mbx - Configure and initialize Firmware Mailbox
  * @fbd: Pointer to device to initialize
  *
- * This function will initialize the firmware mailbox rings, enable the IRQ
- * and initialize the communication between the Firmware and the host. The
- * firmware is expected to respond to the initialization by sending an
- * interrupt essentially notifying the host that it has seen the
- * initialization and is now synced up.
+ * This function will allocate the IRQ and then reinitialize the mailbox
+ * starting communication between the host and firmware.
  *
  * Return: non-zero on failure.
  **/
-int fbnic_fw_enable_mbx(struct fbnic_dev *fbd)
+int fbnic_fw_request_mbx(struct fbnic_dev *fbd)
 {
-	u32 vector = fbd->fw_msix_vector;
-	int err;
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	int vector, err;
+
+	WARN_ON(fbd->fw_msix_vector);
+
+	vector = pci_irq_vector(pdev, FBNIC_FW_MSIX_ENTRY);
+	if (vector < 0)
+		return vector;
 
 	/* Request the IRQ for FW Mailbox vector. */
 	err = request_threaded_irq(vector, NULL, &fbnic_fw_msix_intr,
-				   IRQF_ONESHOT, dev_name(fbd->dev), fbd);
+				   IRQF_ONESHOT | IRQF_NO_AUTOEN,
+				   dev_name(fbd->dev), fbd);
 	if (err)
 		return err;
 
 	/* Initialize mailbox and attempt to poll it into ready state */
-	fbnic_mbx_init(fbd);
-	err = fbnic_mbx_poll_tx_ready(fbd);
-	if (err) {
-		dev_warn(fbd->dev, "FW mailbox did not enter ready state\n");
+	err = __fbnic_fw_enable_mbx(fbd, vector);
+	if (err)
 		free_irq(vector, fbd);
-		return err;
-	}
 
-	/* Enable interrupts */
-	fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
+	fbd->fw_msix_vector = vector;
 
-	return 0;
+	return err;
 }
 
 /**
- * fbnic_fw_disable_mbx - Disable mailbox and place it in standby state
- * @fbd: Pointer to device to disable
+ * fbnic_fw_disable_mbx - Temporarily place mailbox in standby state
+ * @fbd: Pointer to device
  *
- * This function will disable the mailbox interrupt, free any messages still
- * in the mailbox and place it into a standby state. The firmware is
- * expected to see the update and assume that the host is in the reset state.
+ * Shutdown the mailbox by notifying the firmware to stop sending us logs, mask
+ * and synchronize the IRQ, and then clean up the rings.
  **/
-void fbnic_fw_disable_mbx(struct fbnic_dev *fbd)
+static void fbnic_fw_disable_mbx(struct fbnic_dev *fbd)
 {
-	/* Disable interrupt and free vector */
-	fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(0), 1u << FBNIC_FW_MSIX_ENTRY);
+	/* Disable interrupt and synchronize the IRQ */
+	disable_irq(fbd->fw_msix_vector);
 
-	/* Free the vector */
-	free_irq(fbd->fw_msix_vector, fbd);
+	/* Mask the vector */
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(0), 1u << FBNIC_FW_MSIX_ENTRY);
 
 	/* Make sure disabling logs message is sent, must be done here to
 	 * avoid risk of completing without a running interrupt.
 	 */
 	fbnic_mbx_flush_tx(fbd);
-
-	/* Reset the mailboxes to the initialized state */
 	fbnic_mbx_clean(fbd);
 }
 
+/**
+ * fbnic_fw_free_mbx - Disable mailbox and place it in standby state
+ * @fbd: Pointer to device to disable
+ *
+ * This function will disable the mailbox interrupt, free any messages still
+ * in the mailbox and place it into a disabled state. The firmware is
+ * expected to see the update and assume that the host is in the reset state.
+ **/
+void fbnic_fw_free_mbx(struct fbnic_dev *fbd)
+{
+	/* Vector has already been freed */
+	if (!fbd->fw_msix_vector)
+		return;
+
+	fbnic_fw_disable_mbx(fbd);
+
+	/* Free the vector */
+	free_irq(fbd->fw_msix_vector, fbd);
+	fbd->fw_msix_vector = 0;
+}
+
 static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
 {
 	struct fbnic_dev *fbd = data;
@@ -101,7 +137,7 @@ static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
 }
 
 /**
- * fbnic_pcs_irq_enable - Configure the MAC to enable it to advertise link
+ * fbnic_pcs_request_irq - Configure the PCS to enable it to advertise link
  * @fbd: Pointer to device to initialize
  *
  * This function provides basic bringup for the MAC/PCS IRQ. For now the IRQ
@@ -109,41 +145,61 @@ static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
  *
  * Return: non-zero on failure.
  **/
-int fbnic_pcs_irq_enable(struct fbnic_dev *fbd)
+int fbnic_pcs_request_irq(struct fbnic_dev *fbd)
 {
-	u32 vector = fbd->pcs_msix_vector;
-	int err;
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	int vector, err;
 
-	/* Request the IRQ for MAC link vector.
-	 * Map MAC cause to it, and unmask it
+	WARN_ON(fbd->pcs_msix_vector);
+
+	vector = pci_irq_vector(pdev, FBNIC_PCS_MSIX_ENTRY);
+	if (vector < 0)
+		return vector;
+
+	/* Request the IRQ for PCS link vector.
+	 * Map PCS cause to it, and unmask it
 	 */
 	err = request_irq(vector, &fbnic_pcs_msix_intr, 0,
 			  fbd->netdev->name, fbd);
 	if (err)
 		return err;
 
+	/* Map and enable interrupt, unmask vector after link is configured */
 	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
 		   FBNIC_PCS_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
 
+	fbd->pcs_msix_vector = vector;
+
 	return 0;
 }
 
 /**
- * fbnic_pcs_irq_disable - Teardown the MAC IRQ to prepare for stopping
+ * fbnic_pcs_free_irq - Teardown the PCS IRQ to prepare for stopping
  * @fbd: Pointer to device that is stopping
  *
- * This function undoes the work done in fbnic_pcs_irq_enable and prepares
+ * This function undoes the work done in fbnic_pcs_request_irq and prepares
  * the device to no longer receive traffic on the host interface.
  **/
-void fbnic_pcs_irq_disable(struct fbnic_dev *fbd)
+void fbnic_pcs_free_irq(struct fbnic_dev *fbd)
 {
+	/* Vector has already been freed */
+	if (!fbd->pcs_msix_vector)
+		return;
+
 	/* Disable interrupt */
 	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
 		   FBNIC_PCS_MSIX_ENTRY);
+	fbnic_wrfl(fbd);
+
+	/* Synchronize IRQ to prevent race that would unmask vector */
+	synchronize_irq(fbd->pcs_msix_vector);
+
+	/* Mask the vector */
 	fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(0), 1u << FBNIC_PCS_MSIX_ENTRY);
 
 	/* Free the vector */
 	free_irq(fbd->pcs_msix_vector, fbd);
+	fbd->pcs_msix_vector = 0;
 }
 
 void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr)
@@ -226,9 +282,6 @@ void fbnic_free_irqs(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
 
-	fbd->pcs_msix_vector = 0;
-	fbd->fw_msix_vector = 0;
-
 	fbd->num_irqs = 0;
 
 	pci_free_irq_vectors(pdev);
@@ -254,8 +307,5 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd)
 
 	fbd->num_irqs = num_irqs;
 
-	fbd->pcs_msix_vector = pci_irq_vector(pdev, FBNIC_PCS_MSIX_ENTRY);
-	fbd->fw_msix_vector = pci_irq_vector(pdev, FBNIC_FW_MSIX_ENTRY);
-
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 79a01fdd1dd1..2524d9b88d59 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -44,9 +44,10 @@ int __fbnic_open(struct fbnic_net *fbn)
 	if (err)
 		goto time_stop;
 
-	err = fbnic_pcs_irq_enable(fbd);
+	err = fbnic_pcs_request_irq(fbd);
 	if (err)
 		goto time_stop;
+
 	/* Pull the BMC config and initialize the RPC */
 	fbnic_bmc_rpc_init(fbd);
 	fbnic_rss_reinit(fbd, fbn);
@@ -82,7 +83,7 @@ static int fbnic_stop(struct net_device *netdev)
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
 	fbnic_down(fbn);
-	fbnic_pcs_irq_disable(fbn->fbd);
+	fbnic_pcs_free_irq(fbn->fbd);
 
 	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 6cbbc2ee3e1f..4e8595239c0f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -283,7 +283,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto free_irqs;
 	}
 
-	err = fbnic_fw_enable_mbx(fbd);
+	err = fbnic_fw_request_mbx(fbd);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Firmware mailbox initialization failure\n");
@@ -363,7 +363,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 	fbnic_hwmon_unregister(fbd);
 	fbnic_dbg_fbd_exit(fbd);
 	fbnic_devlink_unregister(fbd);
-	fbnic_fw_disable_mbx(fbd);
+	fbnic_fw_free_mbx(fbd);
 	fbnic_free_irqs(fbd);
 
 	fbnic_devlink_free(fbd);
@@ -387,7 +387,7 @@ static int fbnic_pm_suspend(struct device *dev)
 	rtnl_unlock();
 
 null_uc_addr:
-	fbnic_fw_disable_mbx(fbd);
+	fbnic_fw_free_mbx(fbd);
 
 	/* Free the IRQs so they aren't trying to occupy sleeping CPUs */
 	fbnic_free_irqs(fbd);
@@ -420,7 +420,7 @@ static int __fbnic_pm_resume(struct device *dev)
 	fbd->mac->init_regs(fbd);
 
 	/* Re-enable mailbox */
-	err = fbnic_fw_enable_mbx(fbd);
+	err = fbnic_fw_request_mbx(fbd);
 	if (err)
 		goto err_free_irqs;
 
@@ -438,15 +438,15 @@ static int __fbnic_pm_resume(struct device *dev)
 	if (netif_running(netdev)) {
 		err = __fbnic_open(fbn);
 		if (err)
-			goto err_disable_mbx;
+			goto err_free_mbx;
 	}
 
 	rtnl_unlock();
 
 	return 0;
-err_disable_mbx:
+err_free_mbx:
 	rtnl_unlock();
-	fbnic_fw_disable_mbx(fbd);
+	fbnic_fw_free_mbx(fbd);
 err_free_irqs:
 	fbnic_free_irqs(fbd);
 err_invalidate_uc_addr:



