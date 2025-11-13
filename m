Return-Path: <netdev+bounces-238445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBF8C58FC6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D514235DCC7
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0035C183;
	Thu, 13 Nov 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSbcTYlj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FC2F0C68
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051620; cv=none; b=rpM9xrAEcagJJ1EApGu2TdFxmkSTR4yHWptawpbbxw3LoN3wpSfCiFle/S8fhQ5ANQC91jRUF7Tpaid68aBOAWgWdD2WgDtl3jnXhpg8Iqsm3D0BIh3rAxQzjVHGspSnq6oND4fO4Wcl4MQC+yigVlfavLItCuhYPecA8Qw0d+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051620; c=relaxed/simple;
	bh=k/yl9UJWLqC7o84Nr/U5yALEEvU7+KaksmcAaGzK4YU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7+9qUtzOR8ZGBQCgiPceLjqvlKto6m/cClE4D/5i3TlRqNv77+HUZwx9FFpXADS09WiYsJtydZIUU5hqUwy+oFUoMVuG5tcko3NKmpXKp7z1ig12lAUCfxHrhUFqw4SXh7Ea7xNYgav087EzTp7kt9KYAWrtkUoJjvTyDZAAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSbcTYlj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34381ec9197so1019297a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051617; x=1763656417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lHEzl/fdgNanz+gPhE0va0KzQvIPklNm4R2Ogm7AeTA=;
        b=BSbcTYljIQrtc6LtPy52IxbvQ3Mk/buIsOkzHLxnztW5vR2LNpaz9E7OnVXfxpB54L
         s8zNrC1VtgIFL5nrV3Nxovr41ITz5LmXZPumhdJ93yaOLrSDBZ5QavzAS+ciCT91GQv3
         iQ5o43ZcUyc049LtWRR7VYF6EqCB78dDwQ2hLMiivuNWg0hdSoGRA4yFCeXLcXWaKKav
         1SVdRdzagbsxmUmvBVs53cLQpVYGTSVmSRC6bDOFo00EVjbKN5B/3U7qpmxjzUH7+MSk
         7FS0wRs1385y/q0qjMghWgTdXdT65zpyb2vDM6P+7SYEoPkwW2VKDZp5PFZ3m25lQGNJ
         qQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051617; x=1763656417;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHEzl/fdgNanz+gPhE0va0KzQvIPklNm4R2Ogm7AeTA=;
        b=VV0v+KryvU4S0Z+3zqcjc/Fnq/wJxPB6ApCTuNuOtBqnV3IT9S18gKo4rQ8ELHyPU1
         DoGJBv4MT4IH2okEy267GIo34Ze9wQvxQ6Q350+FRXakP+WeWx+NlLNcOWe1Ey5O1E4m
         XvlH8TNXqMfMz4J+4J95s/laEFDPnti0jYTBIXeO1czhUJdt6pxkF4HbLIFEbtTGlHlO
         BU2qRaZ5N1gvOe2qeg4pap49cDvASSAImhxyweetZb7EsstwdXXJJH4fDaVAbFkmEPjI
         WcqRPVWrfxGLBpbeW6jZJ3y0naceiZhxxBTnXYwf1s3l5oFlf+U/dQ8n7N/WcSaDiyUc
         YK1g==
X-Gm-Message-State: AOJu0YyAe9mS2EQWJXAY59a5w9lcsg4OqbM/o6ovaw/uAWMvu4SpZBku
	wSUIZB1VVfzHhiSaysv3LS42rwQcFErmmZ1ChCSc9p6xdxkEi5zIbGRK
X-Gm-Gg: ASbGncufHxKzUcf3Ygb695Su8a3OsTteEgJMJxp5FJoJYfjRZmyC3uqqKzC44oPHhQy
	7HdNHSdaUO65bFf4qQbWcLWZ0UP8iOLN8nto0DqavDg/GQwWS3jj1+djz7rPsTmLwef71ArZMki
	lTj0TF50QuPV0vreM41ajjyR1zVj4P+oFaTMt4KgsZpT4XCQr+UmPUvMWLBqg7IMt6onGlnJ3xD
	JrafsOF32k+Gxp0C+lWkdInX1rssPPT2DzwrbQLJwT7EqtIa5sBGR1OSVKH06nuQBnu3cZxZM8M
	id79Q03IfPUEMUf2QalHA9AytJtI/FKv7U7iKK91R3732jMQohGgEvk+2Y9dmESwBcuewcP78PX
	ZwTEOn1CB8g30wmtoqpoQwwv5qWkNi5gCJltjHmwGQ1GaTA9MZoziEZY78q6rNOWqbAgNZx4UKd
	vd9PIv+7R+nzyc/2u9mOMoXwVewHOBKmmzqwsD+f4EKx7csEuE4A1xxBc=
X-Google-Smtp-Source: AGHT+IFjWA9+CvuQG6h1j/Hkcokc30AC60i/Brv2AXQVRg+bIOfW0HbBisxsPIh48E28HDtI4e0Nxg==
X-Received: by 2002:a17:90b:5625:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-343dde9e89bmr9778808a91.26.1763051617437;
        Thu, 13 Nov 2025 08:33:37 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eacde046sm1686196a91.5.2025.11.13.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:33:37 -0800 (PST)
Subject: [net-next PATCH v4 06/10] fbnic: Rename PCS IRQ to MAC IRQ as it is
 actually a MAC interrupt
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:33:35 -0800
Message-ID: 
 <176305161592.3573217.8662271582761158731.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
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

Throughout several spots in the code I had called out the IRQ as being
related to the PCS. However the actual IRQ is a part of the MAC and it is
just exposing PCS data. To more accurately reflect the owner of the calls
this change makes it so that we rename the functions and values that are
taking in the interrupt value and processing it to reflect that it is a MAC
call and not a PCS one.

This change is mostly motivated by the fact that we will be moving the
handling of this interrupt from being PCS focused to being more PMA/PMD
focused as this will drive the phydev driver that I am adding instead of
driving the PCS directly.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h         |    6 ++---
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   30 ++++++++++++-----------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |   14 +++++------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |    8 +++---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    4 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |    2 +-
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index b03e5a3d5144..98929add5f21 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -34,7 +34,7 @@ struct fbnic_dev {
 	u32 __iomem *uc_addr4;
 	const struct fbnic_mac *mac;
 	unsigned int fw_msix_vector;
-	unsigned int pcs_msix_vector;
+	unsigned int mac_msix_vector;
 	unsigned short num_irqs;
 
 	struct {
@@ -175,8 +175,8 @@ void fbnic_fw_free_mbx(struct fbnic_dev *fbd);
 void fbnic_hwmon_register(struct fbnic_dev *fbd);
 void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
 
-int fbnic_pcs_request_irq(struct fbnic_dev *fbd);
-void fbnic_pcs_free_irq(struct fbnic_dev *fbd);
+int fbnic_mac_request_irq(struct fbnic_dev *fbd);
+void fbnic_mac_free_irq(struct fbnic_dev *fbd);
 
 void fbnic_napi_name_irqs(struct fbnic_dev *fbd);
 int fbnic_napi_request_irq(struct fbnic_dev *fbd,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 1c88a2bf3a7a..40947e142c5d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -118,12 +118,12 @@ void fbnic_fw_free_mbx(struct fbnic_dev *fbd)
 	fbd->fw_msix_vector = 0;
 }
 
-static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
+static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 {
 	struct fbnic_dev *fbd = data;
 	struct fbnic_net *fbn;
 
-	if (fbd->mac->pcs_get_link_event(fbd) == FBNIC_LINK_EVENT_NONE) {
+	if (fbd->mac->get_link_event(fbd) == FBNIC_LINK_EVENT_NONE) {
 		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
 			   1u << FBNIC_PCS_MSIX_ENTRY);
 		return IRQ_HANDLED;
@@ -137,20 +137,20 @@ static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
 }
 
 /**
- * fbnic_pcs_request_irq - Configure the PCS to enable it to advertise link
+ * fbnic_mac_request_irq - Configure the MAC to enable it to advertise link
  * @fbd: Pointer to device to initialize
  *
- * This function provides basic bringup for the MAC/PCS IRQ. For now the IRQ
+ * This function provides basic bringup for the MAC/PHY IRQ. For now the IRQ
  * will remain disabled until we start the MAC/PCS/PHY logic via phylink.
  *
  * Return: non-zero on failure.
  **/
-int fbnic_pcs_request_irq(struct fbnic_dev *fbd)
+int fbnic_mac_request_irq(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
 	int vector, err;
 
-	WARN_ON(fbd->pcs_msix_vector);
+	WARN_ON(fbd->mac_msix_vector);
 
 	vector = pci_irq_vector(pdev, FBNIC_PCS_MSIX_ENTRY);
 	if (vector < 0)
@@ -159,7 +159,7 @@ int fbnic_pcs_request_irq(struct fbnic_dev *fbd)
 	/* Request the IRQ for PCS link vector.
 	 * Map PCS cause to it, and unmask it
 	 */
-	err = request_irq(vector, &fbnic_pcs_msix_intr, 0,
+	err = request_irq(vector, &fbnic_mac_msix_intr, 0,
 			  fbd->netdev->name, fbd);
 	if (err)
 		return err;
@@ -168,22 +168,22 @@ int fbnic_pcs_request_irq(struct fbnic_dev *fbd)
 	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
 		   FBNIC_PCS_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
 
-	fbd->pcs_msix_vector = vector;
+	fbd->mac_msix_vector = vector;
 
 	return 0;
 }
 
 /**
- * fbnic_pcs_free_irq - Teardown the PCS IRQ to prepare for stopping
+ * fbnic_mac_free_irq - Teardown the MAC IRQ to prepare for stopping
  * @fbd: Pointer to device that is stopping
  *
- * This function undoes the work done in fbnic_pcs_request_irq and prepares
+ * This function undoes the work done in fbnic_mac_request_irq and prepares
  * the device to no longer receive traffic on the host interface.
  **/
-void fbnic_pcs_free_irq(struct fbnic_dev *fbd)
+void fbnic_mac_free_irq(struct fbnic_dev *fbd)
 {
 	/* Vector has already been freed */
-	if (!fbd->pcs_msix_vector)
+	if (!fbd->mac_msix_vector)
 		return;
 
 	/* Disable interrupt */
@@ -192,14 +192,14 @@ void fbnic_pcs_free_irq(struct fbnic_dev *fbd)
 	fbnic_wrfl(fbd);
 
 	/* Synchronize IRQ to prevent race that would unmask vector */
-	synchronize_irq(fbd->pcs_msix_vector);
+	synchronize_irq(fbd->mac_msix_vector);
 
 	/* Mask the vector */
 	fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(0), 1u << FBNIC_PCS_MSIX_ENTRY);
 
 	/* Free the vector */
-	free_irq(fbd->pcs_msix_vector, fbd);
-	fbd->pcs_msix_vector = 0;
+	free_irq(fbd->mac_msix_vector, fbd);
+	fbd->mac_msix_vector = 0;
 }
 
 void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 2a84bd1d7e26..28a2e1fd3760 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -434,14 +434,14 @@ static void fbnic_mac_tx_pause_config(struct fbnic_dev *fbd, bool tx_pause)
 	wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
 }
 
-static int fbnic_pcs_get_link_event_asic(struct fbnic_dev *fbd)
+static int fbnic_mac_get_link_event(struct fbnic_dev *fbd)
 {
-	u32 pcs_intr_mask = rd32(fbd, FBNIC_SIG_PCS_INTR_STS);
+	u32 intr_mask = rd32(fbd, FBNIC_SIG_PCS_INTR_STS);
 
-	if (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_DOWN)
+	if (intr_mask & FBNIC_SIG_PCS_INTR_LINK_DOWN)
 		return FBNIC_LINK_EVENT_DOWN;
 
-	return (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_UP) ?
+	return (intr_mask & FBNIC_SIG_PCS_INTR_LINK_UP) ?
 	       FBNIC_LINK_EVENT_UP : FBNIC_LINK_EVENT_NONE;
 }
 
@@ -521,7 +521,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 	return !lane_mask;
 }
 
-static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
+static bool fbnic_mac_get_link(struct fbnic_dev *fbd)
 {
 	bool link;
 
@@ -869,8 +869,8 @@ static const struct fbnic_mac fbnic_mac_asic = {
 	.init_regs = fbnic_mac_init_regs,
 	.pcs_enable = fbnic_pcs_enable_asic,
 	.pcs_disable = fbnic_pcs_disable_asic,
-	.pcs_get_link = fbnic_pcs_get_link_asic,
-	.pcs_get_link_event = fbnic_pcs_get_link_event_asic,
+	.get_link = fbnic_mac_get_link,
+	.get_link_event = fbnic_mac_get_link_event,
 	.get_fec_stats = fbnic_mac_get_fec_stats,
 	.get_pcs_stats = fbnic_mac_get_pcs_stats,
 	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index ede5ff0dae22..414c170abcba 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -59,9 +59,9 @@ enum fbnic_sensor_id {
  *	Configure and enable PCS to enable link if not already enabled
  * void (*pcs_disable)(struct fbnic_dev *fbd);
  *	Shutdown the link if we are the only consumer of it.
- * bool (*pcs_get_link)(struct fbnic_dev *fbd);
+ * bool (*get_link)(struct fbnic_dev *fbd);
  *	Check PCS link status
- * int (*pcs_get_link_event)(struct fbnic_dev *fbd)
+ * int (*get_link_event)(struct fbnic_dev *fbd)
  *	Get the current link event status, reports true if link has
  *	changed to either FBNIC_LINK_EVENT_DOWN or FBNIC_LINK_EVENT_UP
  *
@@ -76,8 +76,8 @@ struct fbnic_mac {
 
 	int (*pcs_enable)(struct fbnic_dev *fbd);
 	void (*pcs_disable)(struct fbnic_dev *fbd);
-	bool (*pcs_get_link)(struct fbnic_dev *fbd);
-	int (*pcs_get_link_event)(struct fbnic_dev *fbd);
+	bool (*get_link)(struct fbnic_dev *fbd);
+	int (*get_link_event)(struct fbnic_dev *fbd);
 
 	void (*get_fec_stats)(struct fbnic_dev *fbd, bool reset,
 			      struct fbnic_fec_stats *fec_stats);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index e95be0e7bd9e..2d5ae89b4a15 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -44,7 +44,7 @@ int __fbnic_open(struct fbnic_net *fbn)
 	if (err)
 		goto time_stop;
 
-	err = fbnic_pcs_request_irq(fbd);
+	err = fbnic_mac_request_irq(fbd);
 	if (err)
 		goto time_stop;
 
@@ -89,7 +89,7 @@ static int fbnic_stop(struct net_device *netdev)
 	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
 
 	fbnic_down(fbn);
-	fbnic_pcs_free_irq(fbn->fbd);
+	fbnic_mac_free_irq(fbn->fbd);
 
 	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 7ce3fdd25282..3c0bd435ee28 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -132,7 +132,7 @@ fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	state->duplex = DUPLEX_FULL;
 
-	state->link = fbd->mac->pcs_get_link(fbd);
+	state->link = fbd->mac->get_link(fbd);
 }
 
 static int



