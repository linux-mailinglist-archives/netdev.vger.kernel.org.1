Return-Path: <netdev+bounces-240818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A12F8C7AE62
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51D56368988
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B82E9ECA;
	Fri, 21 Nov 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzKplaFG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8028466C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743236; cv=none; b=MSDoaGFbf5rMQRIuTtSLfYBQB/BeQWQ4CHMFGcFn2mnGfS1Cm4Je2LLvXfSRbkXD5wF4iY0zAO1zkKRp7PKxvd95+5M9MYfmy+XlySwlVzuvmjqxP/tY9JVQjg8v1EI9zI7ER3zBc7VusYQsXPVAjVWhyNcWxC98NF2VCW/1qZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743236; c=relaxed/simple;
	bh=Hj0KP0luAb0GLcV9yU2elL/XIGy6V+4QBeWCKSIK3HQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fe6UMfao+YUVJvNJD8Jv9gL/e4yXf44ITZgHCfpsfW5g7t0W2Wx8HHPltkuOzvno1iD7K8nFX6On3H6VaShb7mXphGdam7gwDo5CVuUoeKyx64/HSyLIT7O/TCvkY7l14XJtqXZroDauyFDXXO+PTurDD5VzFNsY9mu+zXZMxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzKplaFG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297d4a56f97so32122865ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743233; x=1764348033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MmDqwDn6JtOwxkkKW51olwaYE9FrbRuoE1gRhQunZcI=;
        b=FzKplaFG0n4dM+t66pEVbcm6nj+ddHIP9kRRodUGjgAhSPSBcGteuYXGVod9WJSGLv
         kNldAJVo89VFm1FRL/nwhCaXommKyRCXN9oV13+qEGYl8UuPr7QLeYXpgBJkvCyTA/7j
         FS2casipsUAPKtGieLWPDHCOuq8zUV0SSWmQjs0+NGYMl9Gs7R50i+S2ewfgNsUEjEuu
         ztTbD59m4U9s5sGugE9dLM6c7Gs0vf/KrQx+A7AbyuzAFEXLDk2sPER3PU8b/Giots6G
         V9UaWqN2yRri9ZlTVd2SeGMD9Tmv+lM/PFlSvHmPiwQJwDlbsl86CE3+Reqz193B9jFE
         QFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743233; x=1764348033;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmDqwDn6JtOwxkkKW51olwaYE9FrbRuoE1gRhQunZcI=;
        b=FyFXTnd/j0y/dMBxcRQYeZteFqoyIIyTuY+0bW7G/peRKanV9sAp0DqyU8a9+wR8t5
         K9LKIreftzEp3p4MNSpUgFkMjZTJSrNVeGAgnN5VtJRIxYKIbZNzLtvhIQPlVsO2DJ4S
         djFu3II/NPtc9xaTZu/MTRKlIPF8gvLqJCzBcyGOUwCNv/2qcLZMKOt31CrSoefbyR52
         YpWn4sZM59wJD4k0j+V9doVP0zRUqu596JAnq7mm5BOF11J4uiCy5sG4r5amiW/lr+8B
         CKK9ubRWZWn0PxAtVnRpd/AO7FWXVMfqVz0vrbwEIeKQZW0skr+I/Qj60FcDT4O8w3mN
         itHg==
X-Gm-Message-State: AOJu0Yxj7cEObGEJRtC9ZjfsYSHCXmL0+4vU1icaKK9br2qVh7H1cOrm
	yBSMo3C4a3kwnfDE8fsXRwH4M+Ur4yPQGjosJzoeYiIgJdCApSSKEbHw
X-Gm-Gg: ASbGncvvxqo7Laaep5PA96WIoF1QsYiw50MdufK/LtwMRawPdKDbFaJhetabIU7IkQY
	W/PvZgOaK+bKsvJw3EejBsjCObt015QkpHIEcdbIVt4anNJ5H4h6UqUZeoyyvpQW5hhvylVUcpF
	T25aLNhNRUAeCa7Nf455s51aaHsQrCPCBIBT44e/7prIeRlMCEnePXQp3URSCjn3nJVL00LAyHq
	DEfxVlDMU+OMxHL0il71UfVwyVOzTaLoPaX/kZSslYP5qvJteQD9VzhkBr0qGecOQD8Ej/v47f0
	FqeX5/sBS8GhPxteuEUJKPrMPyqKhxp6JYS29wUUIHP9NvoygYOo7ktAp+xZalrjiHnyP0I7e2K
	0zmXcfrQSEG9xcyFtWmK82CSswHRqvfhvzPRCcJGK1Xtama08l0ZrQVF2937S6HhAKzFCXdhjhi
	VnZe3D46mFsGoAOx8bc070tNMNRrGRapkhNY9l4PMOXJMb
X-Google-Smtp-Source: AGHT+IGxi2ai0CVOaQqvu9VVrQ0cicshMZG09Hp56w7Sq9sy5nJcTQqbHRZWPDAfqVs008+FWpkjLQ==
X-Received: by 2002:a17:903:2f8d:b0:298:52a9:31d4 with SMTP id d9443c01a7336-29b6c6b87c7mr41987085ad.54.1763743233053;
        Fri, 21 Nov 2025 08:40:33 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13ddc1sm62215745ad.37.2025.11.21.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:40:32 -0800 (PST)
Subject: [net-next PATCH v5 6/9] fbnic: Add logic to track PMD state via
 MAC/PCS signals
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:40:31 -0800
Message-ID: 
 <176374323107.959489.14951134213387615059.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
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

One complication with the design of our part is that the PMD doesn't
provide a direct signal to the host. Instead we have visibility to signals
that the PCS provides to the MAC that allow us to check the link state
through that.

We will need to account for several things in the PMD and firmware when
managing the link. Specifically when the link first starts to come up the
PMD will cause the link to flap. This is due to the firmware starting a
training cycle when the link is first detected. This will cause link
flapping if we were to immediately report link up when the PCS first
detects it.

To address that we are adding a pmd_state variable that is meant to be a
countdown of sorts indicating the state of the PMD. If the link is down or
has been reconfigured the PMD will start out in the initialize state. By
default the link is assumed to be in the SEND_DATA state if it is available
on initial link inspection. If link is detected while in the initialize
state the PMD state will switch to training, and if after 4 seconds the
link is still stable we will transition to link_ready, and finally the
send_data state.  With this we can avoid link flapping when a cable is
first connected to the NIC.

One side effect of this is that we need to pull the link state away from
the PCS. For now we use a union of the PCS link state register value and
the pmd_state. The plan is to add a PMD register to report the pmd_state
to the phylink interface. With that we can then look at switching over to
the use of the XPCS driver for fbnic instead of having an internal one.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h         |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |   69 ++++++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |   36 ++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |    6 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |  102 ++++++++++++++++++-----
 9 files changed, 175 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 98929add5f21..fac1283d0ade 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -83,6 +83,10 @@ struct fbnic_dev {
 	/* Last @time_high refresh time in jiffies (to catch stalls) */
 	unsigned long last_read;
 
+	/* PMD specific data */
+	unsigned long end_of_pmd_training;
+	u8 pmd_state;
+
 	/* Local copy of hardware statistics */
 	struct fbnic_hw_stats hw_stats;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index d3a7ad921f18..422265dc7abd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -787,6 +787,8 @@ enum {
 
 /* MAC PCS registers */
 #define FBNIC_CSR_START_PCS		0x10000 /* CSR section delimiter */
+#define FBNIC_PCS_PAGE(n)	(0x10000 + 0x400 * (n))	/* 0x40000 + 1024*n */
+#define FBNIC_PCS(reg, n)	((reg) + FBNIC_PCS_PAGE(n))
 #define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
 
 #define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 40947e142c5d..9b068b82f30a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -131,7 +131,9 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 
 	fbn = netdev_priv(fbd->netdev);
 
-	phylink_pcs_change(&fbn->phylink_pcs, false);
+	/* Record link down events */
+	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec))
+		phylink_pcs_change(&fbn->phylink_pcs, false);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 28a2e1fd3760..fc7abea4ef5b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -466,9 +466,8 @@ static u32 __fbnic_mac_cmd_config_asic(struct fbnic_dev *fbd,
 	return command_config;
 }
 
-static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
+static bool fbnic_mac_get_link_status(struct fbnic_dev *fbd, u8 aui, u8 fec)
 {
-	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
 	u32 pcs_status, lane_mask = ~0;
 
 	pcs_status = rd32(fbd, FBNIC_SIG_PCS_OUT0);
@@ -476,7 +475,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 		return false;
 
 	/* Define the expected lane mask for the status bits we need to check */
-	switch (fbn->aui) {
+	switch (aui) {
 	case FBNIC_AUI_100GAUI2:
 		lane_mask = 0xf;
 		break;
@@ -484,7 +483,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 		lane_mask = 3;
 		break;
 	case FBNIC_AUI_LAUI2:
-		switch (fbn->fec) {
+		switch (fec) {
 		case FBNIC_FEC_OFF:
 			lane_mask = 0x63;
 			break;
@@ -502,7 +501,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 	}
 
 	/* Use an XOR to remove the bits we expect to see set */
-	switch (fbn->fec) {
+	switch (fec) {
 	case FBNIC_FEC_OFF:
 		lane_mask ^= FIELD_GET(FBNIC_SIG_PCS_OUT0_BLOCK_LOCK,
 				       pcs_status);
@@ -521,7 +520,46 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 	return !lane_mask;
 }
 
-static bool fbnic_mac_get_link(struct fbnic_dev *fbd)
+static bool fbnic_pmd_update_state(struct fbnic_dev *fbd, bool signal_detect)
+{
+	/* Delay link up for 4 seconds to allow for link training.
+	 * The state transitions for this are as follows:
+	 *
+	 * All states have the following two transitions in common:
+	 *	Loss of signal -> FBNIC_PMD_INITIALIZE
+	 *		The condition handled below (!signal)
+	 *	Reconfiguration -> FBNIC_PMD_INITIALIZE
+	 *		Occurs when mac_prepare starts a PHY reconfig
+	 * FBNIC_PMD_TRAINING:
+	 *	signal still detected && 4s have passed -> Report link up
+	 *	When link is brought up in link_up -> FBNIC_PMD_SEND_DATA
+	 * FBNIC_PMD_INITIALIZE:
+	 *	signal detected -> FBNIC_PMD_TRAINING
+	 */
+	if (!signal_detect) {
+		fbd->pmd_state = FBNIC_PMD_INITIALIZE;
+		return false;
+	}
+
+	switch (fbd->pmd_state) {
+	case FBNIC_PMD_TRAINING:
+		return time_before(fbd->end_of_pmd_training, jiffies);
+	case FBNIC_PMD_LINK_READY:
+	case FBNIC_PMD_SEND_DATA:
+		return true;
+	}
+
+	fbd->end_of_pmd_training = jiffies + 4 * HZ;
+
+	/* Ensure end_of_training is visible before the state change */
+	smp_wmb();
+
+	fbd->pmd_state = FBNIC_PMD_TRAINING;
+
+	return false;
+}
+
+static bool fbnic_mac_get_link(struct fbnic_dev *fbd, u8 aui, u8 fec)
 {
 	bool link;
 
@@ -538,7 +576,8 @@ static bool fbnic_mac_get_link(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_SIG_PCS_INTR_STS,
 	     FBNIC_SIG_PCS_INTR_LINK_DOWN | FBNIC_SIG_PCS_INTR_LINK_UP);
 
-	link = fbnic_mac_get_pcs_link_status(fbd);
+	link = fbnic_mac_get_link_status(fbd, aui, fec);
+	link = fbnic_pmd_update_state(fbd, link);
 
 	/* Enable interrupt to only capture changes in link state */
 	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK,
@@ -586,20 +625,15 @@ void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
 	}
 }
 
-static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
+static void fbnic_mac_prepare(struct fbnic_dev *fbd, u8 aui, u8 fec)
 {
 	/* Mask and clear the PCS interrupt, will be enabled by link handler */
 	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
 	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
 
-	return 0;
-}
-
-static void fbnic_pcs_disable_asic(struct fbnic_dev *fbd)
-{
-	/* Mask and clear the PCS interrupt */
-	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
-	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
+	/* If we don't have link tear it all down and start over */
+	if (!fbnic_mac_get_link_status(fbd, aui, fec))
+		fbd->pmd_state = FBNIC_PMD_INITIALIZE;
 }
 
 static void fbnic_mac_link_down_asic(struct fbnic_dev *fbd)
@@ -867,10 +901,9 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
 
 static const struct fbnic_mac fbnic_mac_asic = {
 	.init_regs = fbnic_mac_init_regs,
-	.pcs_enable = fbnic_pcs_enable_asic,
-	.pcs_disable = fbnic_pcs_disable_asic,
 	.get_link = fbnic_mac_get_link,
 	.get_link_event = fbnic_mac_get_link_event,
+	.prepare = fbnic_mac_prepare,
 	.get_fec_stats = fbnic_mac_get_fec_stats,
 	.get_pcs_stats = fbnic_mac_get_pcs_stats,
 	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 414c170abcba..9b4fb0586dff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -10,6 +10,24 @@ struct fbnic_dev;
 
 #define FBNIC_MAX_JUMBO_FRAME_SIZE	9742
 
+/* States loosely based on section 136.8.11.7.5 of IEEE 802.3-2022 Ethernet
+ * Standard.  These are needed to track the state of the PHY as it has a delay
+ * of several seconds from the time link comes up until it has completed
+ * training that we need to wait to report the link.
+ *
+ * Currently we treat training as a single block as this is managed by the
+ * firmware.
+ *
+ * We have FBNIC_PMD_SEND_DATA set to 0 as the expected default at driver load
+ * and we initialize the structure containing it to zero at allocation.
+ */
+enum {
+	FBNIC_PMD_SEND_DATA	= 0x0,
+	FBNIC_PMD_INITIALIZE	= 0x1,
+	FBNIC_PMD_TRAINING	= 0x2,
+	FBNIC_PMD_LINK_READY	= 0x3,
+};
+
 enum {
 	FBNIC_LINK_EVENT_NONE	= 0,
 	FBNIC_LINK_EVENT_UP	= 1,
@@ -55,15 +73,15 @@ enum fbnic_sensor_id {
  * void (*init_regs)(struct fbnic_dev *fbd);
  *	Initialize MAC registers to enable Tx/Rx paths and FIFOs.
  *
- * void (*pcs_enable)(struct fbnic_dev *fbd);
- *	Configure and enable PCS to enable link if not already enabled
- * void (*pcs_disable)(struct fbnic_dev *fbd);
- *	Shutdown the link if we are the only consumer of it.
- * bool (*get_link)(struct fbnic_dev *fbd);
- *	Check PCS link status
  * int (*get_link_event)(struct fbnic_dev *fbd)
  *	Get the current link event status, reports true if link has
  *	changed to either FBNIC_LINK_EVENT_DOWN or FBNIC_LINK_EVENT_UP
+ * bool (*get_link)(struct fbnic_dev *fbd, u8 aui, u8 fec);
+ *	Check link status
+ *
+ * void (*prepare)(struct fbnic_dev *fbd, u8 aui, u8 fec);
+ *	Prepare PHY for init by fetching settings, disabling interrupts,
+ *	and sending an updated PHY config to FW if needed.
  *
  * void (*link_down)(struct fbnic_dev *fbd);
  *	Configure MAC for link down event
@@ -74,10 +92,10 @@ enum fbnic_sensor_id {
 struct fbnic_mac {
 	void (*init_regs)(struct fbnic_dev *fbd);
 
-	int (*pcs_enable)(struct fbnic_dev *fbd);
-	void (*pcs_disable)(struct fbnic_dev *fbd);
-	bool (*get_link)(struct fbnic_dev *fbd);
 	int (*get_link_event)(struct fbnic_dev *fbd);
+	bool (*get_link)(struct fbnic_dev *fbd, u8 aui, u8 fec);
+
+	void (*prepare)(struct fbnic_dev *fbd, u8 aui, u8 fec);
 
 	void (*get_fec_stats)(struct fbnic_dev *fbd, bool reset,
 			      struct fbnic_fec_stats *fec_stats);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 2d5ae89b4a15..65318a5b466e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -86,10 +86,10 @@ static int fbnic_stop(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
+	fbnic_mac_free_irq(fbn->fbd);
 	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
 
 	fbnic_down(fbn);
-	fbnic_mac_free_irq(fbn->fbd);
 
 	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index e6ca23a9957d..deab789b2a6c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -109,7 +109,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam);
 int fbnic_phylink_init(struct net_device *netdev);
-
+void fbnic_phylink_pmd_training_complete_notify(struct net_device *netdev);
 bool fbnic_check_split_frames(struct bpf_prog *prog,
 			      unsigned int mtu, u32 hds_threshold);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 4620f1847f2e..dea5367d2190 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -207,6 +207,10 @@ static void fbnic_service_task(struct work_struct *work)
 {
 	struct fbnic_dev *fbd = container_of(to_delayed_work(work),
 					     struct fbnic_dev, service_task);
+	struct net_device *netdev = fbd->netdev;
+
+	if (netif_running(netdev))
+		fbnic_phylink_pmd_training_complete_notify(netdev);
 
 	rtnl_lock();
 
@@ -224,7 +228,7 @@ static void fbnic_service_task(struct work_struct *work)
 		netdev_unlock(fbd->netdev);
 	}
 
-	if (netif_running(fbd->netdev))
+	if (netif_running(netdev))
 		schedule_delayed_work(&fbd->service_task, HZ);
 
 	rtnl_unlock();
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 99fa79acd2df..20f88c8dcc79 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -132,25 +132,9 @@ fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	state->duplex = DUPLEX_FULL;
 
-	state->link = fbd->mac->get_link(fbd);
-}
-
-static int
-fbnic_phylink_pcs_enable(struct phylink_pcs *pcs)
-{
-	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
-	struct fbnic_dev *fbd = fbn->fbd;
-
-	return fbd->mac->pcs_enable(fbd);
-}
-
-static void
-fbnic_phylink_pcs_disable(struct phylink_pcs *pcs)
-{
-	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
-	struct fbnic_dev *fbd = fbn->fbd;
-
-	return fbd->mac->pcs_disable(fbd);
+	state->link = (fbd->pmd_state == FBNIC_PMD_SEND_DATA) &&
+		      (rd32(fbd, FBNIC_PCS(MDIO_STAT1, 0)) &
+		       MDIO_STAT1_LSTATUS);
 }
 
 static int
@@ -164,8 +148,6 @@ fbnic_phylink_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 static const struct phylink_pcs_ops fbnic_phylink_pcs_ops = {
 	.pcs_config = fbnic_phylink_pcs_config,
-	.pcs_enable = fbnic_phylink_pcs_enable,
-	.pcs_disable = fbnic_phylink_pcs_disable,
 	.pcs_get_state = fbnic_phylink_pcs_get_state,
 };
 
@@ -179,12 +161,39 @@ fbnic_phylink_mac_select_pcs(struct phylink_config *config,
 	return &fbn->phylink_pcs;
 }
 
+static int
+fbnic_phylink_mac_prepare(struct phylink_config *config, unsigned int mode,
+			  phy_interface_t iface)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	fbd->mac->prepare(fbd, fbn->aui, fbn->fec);
+
+	return 0;
+}
+
 static void
 fbnic_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 			 const struct phylink_link_state *state)
 {
 }
 
+static int
+fbnic_phylink_mac_finish(struct phylink_config *config, unsigned int mode,
+			 phy_interface_t iface)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	/* Retest the link state and restart interrupts */
+	fbd->mac->get_link(fbd, fbn->aui, fbn->fec);
+
+	return 0;
+}
+
 static void
 fbnic_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 			    phy_interface_t interface)
@@ -216,7 +225,9 @@ fbnic_phylink_mac_link_up(struct phylink_config *config,
 
 static const struct phylink_mac_ops fbnic_phylink_mac_ops = {
 	.mac_select_pcs = fbnic_phylink_mac_select_pcs,
+	.mac_prepare = fbnic_phylink_mac_prepare,
 	.mac_config = fbnic_phylink_mac_config,
+	.mac_finish = fbnic_phylink_mac_finish,
 	.mac_link_down = fbnic_phylink_mac_link_down,
 	.mac_link_up = fbnic_phylink_mac_link_up,
 };
@@ -257,3 +268,52 @@ int fbnic_phylink_init(struct net_device *netdev)
 
 	return 0;
 }
+
+/**
+ * fbnic_phylink_pmd_training_complete_notify - PMD training complete notifier
+ * @netdev: Netdev struct phylink device attached to
+ *
+ * When the link first comes up the PMD will have a period of 2 to 3 seconds
+ * where the link will flutter due to link training. To avoid spamming the
+ * kernel log with messages about this we add a delay of 4 seconds from the
+ * time of the last PCS report of link so that we can guarantee we are unlikely
+ * to see any further link loss events due to link training.
+ **/
+void fbnic_phylink_pmd_training_complete_notify(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	if (fbd->pmd_state != FBNIC_PMD_TRAINING)
+		return;
+
+	/* Prevent reading end_of_pmd_training until we verified state */
+	smp_rmb();
+
+	if (!time_before(READ_ONCE(fbd->end_of_pmd_training), jiffies))
+		return;
+
+	/* At this point we have verified that the link has been up for
+	 * the full training duration. As a first step we will try
+	 * transitioning to link ready.
+	 */
+	if (cmpxchg(&fbd->pmd_state, FBNIC_PMD_TRAINING,
+		    FBNIC_PMD_LINK_READY) != FBNIC_PMD_TRAINING)
+		return;
+
+	/* Perform a follow-up check to verify that the link didn't flap
+	 * just before our transition by rechecking the training timer.
+	 */
+	if (!time_before(READ_ONCE(fbd->end_of_pmd_training), jiffies))
+		return;
+
+	/* The training timeout has been completed. We are good to swap out
+	 * link_ready for send_data assuming no other events have occurred
+	 * that would have pulled us back into initialization or training.
+	 */
+	if (cmpxchg(&fbd->pmd_state, FBNIC_PMD_LINK_READY,
+		    FBNIC_PMD_SEND_DATA) != FBNIC_PMD_LINK_READY)
+		return;
+
+	phylink_pcs_change(&fbn->phylink_pcs, false);
+}



