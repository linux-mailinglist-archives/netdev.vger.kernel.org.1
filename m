Return-Path: <netdev+bounces-235198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD170C2D59C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A7F189C5D9
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B966E322C63;
	Mon,  3 Nov 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHBvxqLf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC731D39C
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189252; cv=none; b=Ux8QjwHDudP5dDuQToqLQc8Rrx1mfRJFmkKJzg0JNMbUmHilC/zEc1YT+OPj4mLwS+/ifN6yqRbcWpDB6NKjgYeWcb7UP4GZuwERyUrdshnKcgg04hEs9N6nkmFooaFarQ3mUebqulkXSTE7zQzV+SlFZJKOM6ufG9pFJpQqaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189252; c=relaxed/simple;
	bh=aMwYe0EySTezrEppKMt0q6UCvKN2AoIoXMUT6QXGnk8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYDRclVxw8bCvhkTTqC3/HGIjWGXbS9XZ5qCoSpIJLj/0k1Lw6GGmvpiftj5PBcoAzQuGrDJ5Frqzg9J+nbkdQhKKJ20X9ki87VeUHSHKeKkABGQCj4Whwvn4EoD4sYMqDfmPt3kNFcEk2evQeWot4X0yCmH8uW3I2aIJAwy6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHBvxqLf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso1342133b3a.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189249; x=1762794049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nE1WtR/pENQnRtBaGvCHd3gX1RjqJte4zwXHyh62oDw=;
        b=nHBvxqLfldW/G+EzH3v4DnbTeWL6bbN3efrmB8IYST1VY7DXnrO2EQYN3aqzpfUIGw
         ZAO8qvvCwFbR1lPE5vGvKwXXjGLZF+Ag0sy7QYX5hJCcruTEbq3QdudY2s/Ymh36gKmd
         GCmF+V/LxLXmKJWpHRSXe+Fu9Z3zOy5UcEw1tu8bZPFo9tzBERlijRVx2WhrAoPczbfO
         SyI/dinEEutlQHqYmqe4o0wglYeLir4+SCPyN9bqFFMLXdnmJy1JdVZTk36tI/7QZQye
         DWCs8eNoowbydWSrI7ul09piumGVttClhuzCCxP3L/SGCB9y+egvdrEQE9Skux7BD5wi
         eKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189249; x=1762794049;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nE1WtR/pENQnRtBaGvCHd3gX1RjqJte4zwXHyh62oDw=;
        b=WUSXe+PwcjcEn65I4TCIbzoPoBVHg+mTR/I6Hw9nuIWr4QmZdycqEGVLxmuQPtLdP8
         k2ElcMsUOuJqxbBn9mxk/xgRhFekkxi/n+FwPiBWb2jpcl/2nrvL9kCcXU2HYm/z1OUa
         sBUuWTe9Uh7snAzYQ0q7ZiGNxCPtLxbFYser9rdnR+5g+G0fxYv2R/UChzCIuT3L77dl
         dQxyvBv/9LO8AzHZ4UDB2ppPITn5APhZ0yCWyYxaWyFWo4+ntN4+CH2+Jf3OB9FqkXfL
         OnEOHlpouT7FkBtw3pOy3kOtehBHbAaMHyicmmJlnNjg1ZPoPDfLnkKr8TVQI1KMyf5W
         /liw==
X-Gm-Message-State: AOJu0YzPJO46lIySJRs3viFDKL+UCW3HZYllInwpFM6jw2n6XLUTwzfM
	g1kYDIfJTNH+1LklKkti6ZqnZjoYC6nG8zBH0pQgiaVVCovnVlAtB6MC5RyS0Q==
X-Gm-Gg: ASbGncsQ62j5NRfnvJqZ9LcoNjKbHCiG/MoJz1xw0p9W5/jiaIMupTrN2bSmC3/t6Rw
	Fazz50lC6uc0KLiIHyuefdITsJ0qVJQ2eRCG7LgkmL++0veZNlQ5YBch1y0B00yvlCR5PBozfxq
	wTZ77BBlO/tzBbschXvyy+CO4ZoYJsqjxCDK8q2qKn/XJiTrb3UIQpizC19L61pbzlL0UjW12n2
	jFi6ex603frpedR+bFhALPqB+VpSVqoFJ0oDCVnuJ3lgx4Fd+eQtMacLEnAKU7zpraHon/gM1eC
	WwB4fNyuRSzTrGXKDWAQtWgR9AtVG5HrYWVSp8/s7LCRweNwCTIIxMFVu6T1LJXRywoRx0WV666
	LiTSGBogCxEbUucQzoGhyWnIZsqCv57G83c6OG+EAK/Gfopmd9D3kJAWpgazT6YhdXcOi50/ZD1
	oSJLdaW1sx7WueGYWUQs1TD/bAgXORlvI9vQ==
X-Google-Smtp-Source: AGHT+IH/zr36zjIkcnXlV6bVhZKTIq2428H+PvnEhPMDhfMVjiOcrf4WutyiYAIiJLxbUV4N3clkqA==
X-Received: by 2002:a05:6a20:a105:b0:33e:84f7:94f9 with SMTP id adf61e73a8af0-348c9f6707amr15086431637.9.1762189249350;
        Mon, 03 Nov 2025 09:00:49 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ac832a18d1sm801564b3a.36.2025.11.03.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:48 -0800 (PST)
Subject: [net-next PATCH v2 07/11] fbnic: Add logic to track PMD state via
 MAC/PCS signals
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:00:47 -0800
Message-ID: 
 <176218924780.2759873.4823837394552755015.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
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

That said we need to account for several things in the PMD and firmware
when managing the link. Specifically when the link first starts to come up
the PMD will cause the link to flap as the firmware will begin a training
cycle when the link is first detected. As a result this will cause link
flapping if we were to immediately report link up when the PCS first
detects it.

To address that we are adding a pmd_state variable that is meant to be a
countdown of sorts indicating the state of the PMD. If the link is down the
PMD will start out in the initialize state, otherwise if the link is up it
will start out in the send_data state. If link is detected while in the
initialize state the PMD state will switch to training, and if after 4
seconds the link is still stable we will transition to the send_data state.
With this we can avoid link flapping when a cable is first connected to the
NIC.

One side effect of this is that we need to pull the link state away from
the PCS. For now we use a union of the PCS link state register value and
the pmd_state. The plan is to add a phydev driver to report the pmd_state
to the phylink interface. With that we can then look at switching over to
the use of the XPCS driver for fbnic instead of having an internal one.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h         |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |    2 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |   59 ++++++++++++------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |   35 ++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    2 -
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   77 +++++++++++++++++------
 8 files changed, 137 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 98929add5f21..783a1a91dd25 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -83,6 +83,10 @@ struct fbnic_dev {
 	/* Last @time_high refresh time in jiffies (to catch stalls) */
 	unsigned long last_read;
 
+	/* PMD specific data */
+	unsigned long start_of_pmd_training;
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
index 145a33e231e7..cd874dde41a2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -131,7 +131,9 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 
 	fbn = netdev_priv(fbd->netdev);
 
-	phylink_mac_change(fbn->phylink, false);
+	/* Record link down events */
+	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec))
+		phylink_mac_change(fbn->phylink, false);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 28a2e1fd3760..5a219f03277b 100644
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
@@ -521,7 +520,36 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
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
+	} else if (fbd->pmd_state == FBNIC_PMD_TRAINING &&
+		   time_before(fbd->start_of_pmd_training + 4 * HZ, jiffies)) {
+		return true;
+	} else if (fbd->pmd_state == FBNIC_PMD_INITIALIZE) {
+		fbd->start_of_pmd_training = jiffies;
+		fbd->pmd_state = FBNIC_PMD_TRAINING;
+	}
+
+	return fbd->pmd_state == FBNIC_PMD_SEND_DATA;
+}
+
+static bool fbnic_mac_get_link(struct fbnic_dev *fbd, u8 aui, u8 fec)
 {
 	bool link;
 
@@ -538,7 +566,8 @@ static bool fbnic_mac_get_link(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_SIG_PCS_INTR_STS,
 	     FBNIC_SIG_PCS_INTR_LINK_DOWN | FBNIC_SIG_PCS_INTR_LINK_UP);
 
-	link = fbnic_mac_get_pcs_link_status(fbd);
+	link = fbnic_mac_get_link_status(fbd, aui, fec);
+	link = fbnic_pmd_update_state(fbd, link);
 
 	/* Enable interrupt to only capture changes in link state */
 	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK,
@@ -586,20 +615,15 @@ void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
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
@@ -867,10 +891,9 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
 
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
index 414c170abcba..2b08046645f2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -10,6 +10,23 @@ struct fbnic_dev;
 
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
+};
+
 enum {
 	FBNIC_LINK_EVENT_NONE	= 0,
 	FBNIC_LINK_EVENT_UP	= 1,
@@ -55,15 +72,15 @@ enum fbnic_sensor_id {
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
@@ -74,10 +91,10 @@ enum fbnic_sensor_id {
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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index b0a87c57910f..7b773c06e245 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -107,7 +107,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam);
 int fbnic_phylink_init(struct net_device *netdev);
-
+void fbnic_phylink_pmd_training_complete_notify(struct fbnic_net *fbn);
 bool fbnic_check_split_frames(struct bpf_prog *prog,
 			      unsigned int mtu, u32 hds_threshold);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 4620f1847f2e..428fc861deff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -207,6 +207,10 @@ static void fbnic_service_task(struct work_struct *work)
 {
 	struct fbnic_dev *fbd = container_of(to_delayed_work(work),
 					     struct fbnic_dev, service_task);
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
+	if (netif_running(fbd->netdev))
+		fbnic_phylink_pmd_training_complete_notify(fbn);
 
 	rtnl_lock();
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 3c0bd435ee28..66c4f8b3a917 100644
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
@@ -213,7 +222,9 @@ fbnic_phylink_mac_link_up(struct phylink_config *config,
 
 static const struct phylink_mac_ops fbnic_phylink_mac_ops = {
 	.mac_select_pcs = fbnic_phylink_mac_select_pcs,
+	.mac_prepare = fbnic_phylink_mac_prepare,
 	.mac_config = fbnic_phylink_mac_config,
+	.mac_finish = fbnic_phylink_mac_finish,
 	.mac_link_down = fbnic_phylink_mac_link_down,
 	.mac_link_up = fbnic_phylink_mac_link_up,
 };
@@ -254,3 +265,27 @@ int fbnic_phylink_init(struct net_device *netdev)
 
 	return 0;
 }
+
+/**
+ * fbnic_phylink_pmd_training_complete_notify - PMD training complete notifier
+ * @fbn: FBNIC Netdev private data struct phylink device attached to
+ *
+ * The PMD wil have a period of 2 to 3 seconds where the link will flutter when
+ * the link first comes up due to link training. To avoid spamming the kernel
+ * log with messages about this we add a delay of 4 seconds from the time of
+ * the last PCS report of link so that we can guarantee we are unlikely to see
+ * any further link loss events due to link training.
+ **/
+void fbnic_phylink_pmd_training_complete_notify(struct fbnic_net *fbn)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	if (fbd->pmd_state != FBNIC_PMD_TRAINING)
+		return;
+
+	if (!time_before(fbd->start_of_pmd_training + 4 * HZ, jiffies))
+		return;
+
+	fbd->pmd_state = FBNIC_PMD_SEND_DATA;
+	phylink_mac_change(fbn->phylink, true);
+}



