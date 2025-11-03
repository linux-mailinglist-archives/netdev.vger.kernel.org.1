Return-Path: <netdev+bounces-235197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0DEC2D611
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BD6424CA0
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663F321F51;
	Mon,  3 Nov 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq/IQPUV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E82322522
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189245; cv=none; b=NiO7dNBPKx11IKUjltQ4YfOSV4pXtMwjUxKZmJt/GqUOObiNIfpImcFylcGY1rsNMxv1WytbqwpWTMQXJlnqtWQKdupeP4zvAAQl+9hYywdgx790kpTC5ES8hZSx4AEMmkGlAfcmApRyXP3YqCUSNHkAzmIDoy/gD6bylAW2wmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189245; c=relaxed/simple;
	bh=646ZlTGJec+c4mMOS9NaFbC3q6ZhS5JORiJKQHy2jS0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiDlo7wu187Adzkas7Ma3exJ61oSbc0JpU0A1l9rU0LO8LndIjevs8AIHUv22cWQf+q8k96jE+Lu4TVJ6YOEygM0kjhajPEYMJzOG0Jl/dd3YrMh8V0MylOQYkxK7h/pY8FuIEhvgnGkprhrHYMutCLsfidltevkWlsRFz+p79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq/IQPUV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-294fb21b160so32544405ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189243; x=1762794043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckLU6xWUzuud+l0EZTiA4DFH3yIgyMcuuXufc5PsnyA=;
        b=Uq/IQPUVdbjl5l/SnYbf2RD7IUbxcndN+rcvlpuBu67cRpsgc5Wvi/qLuXVpCGGqBQ
         3JxPpoJPsT3XL80iXsgb8j59eIxRvJKPmPyxuBXF/Rdq0gaZMbNLFbbU2SYlsnwZhuAP
         4rbKYBfgMauNOmQYusqX8XXZMe+MHRjV2SVbbvdOgmcYzcFGUSidj4KpNNRPREo94m0t
         KIWK+J5qOB8CT5igCuNcvy9A0DlWPBVOJKf72mhzXNVtBNhica04uEaZjfvkj2HENy/3
         V50BcExEEOWRiQU4HW5mSxxQ4mwgOdRYGXWN7y2veJGsJOCgvGoK8vwk5G8k1E3JroBy
         5Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189243; x=1762794043;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckLU6xWUzuud+l0EZTiA4DFH3yIgyMcuuXufc5PsnyA=;
        b=mKZBqKlg8uTjZOffgBA9ACCWPV5cGwaqc/tF1H3vfXh8xLye4jolbWnMES0c47ibLQ
         Qk6OWPj9FQla7UvvPR/SpxHhxCprWNrn9U5Okxp6jnG8+2ftfRekcMrzJWIkZXOIKO0h
         GA0eJHUu3BiLZXAi8hgxdHIKUuM1j8zx57BQwSXAk2k+NSIA5qKCWJYo1lWlfniwj0Ve
         jsvKIS8Yv1ssin6YCmQJJLPrCTQj4hqJtfW5NYAVyTvwk1YLQMBnwefdIEJwdlv18FXx
         sqz6y4/mOv7lzKLsbJ5M34BGoAmAI2nZjCMGog/abX7Gg053tCJ0YPHAV+1AvKxXhsHj
         05kg==
X-Gm-Message-State: AOJu0YyRr7q4oeghdc2zwctlY8e8LhOwaT4TzpgKZlT8XdkohVnD+Fla
	lFhBXPysb//XiPjfO5LrefeVN0PQrA0v7arQIrg23aYQqI9O8b3xk8WvpUt6kg==
X-Gm-Gg: ASbGncssQWzgFAKhC4BVyRqkXECSw7SwSrVKiql1jD3VmjHmX6hiG9qan/ptrWZjarb
	iwEnLKFn1Jd/V2kvcbgheuws4F+6eRF0Fpd7Oqh5z/xbzU7+MowJX/Rpblj9YL4S/AxsCjBCUnv
	DPjVdO0i8TbtI/e7ADulHTVPC8dIY9UepG4BtYFT1jUIbOcEH8Wpdu62hDBItyqMdLM3B+fx5i3
	cVs3bZ+asLv6I2GjgR7nLAs0JcAJEIu9PrY1yYX36caN7eImLw7jnIET3v3gKJrf9utI/6NnQas
	RvRitYQIDavMEdOyvR3Kk3Yq0Nn+sGLZYBOFkceEM3M7oiWV1qk3Odkv4IoCb7C/o81JaE51W04
	2HoPmrxy8qNQVSK+3cFmqRvGh6bkGqJFL3geXCZDiV65sFQuT1PWAF88FCJ1MIiPMOXOxJVEGwO
	uwkjkXzke8R7r4Tl5f3QveWR7aJR3lm1z9lw==
X-Google-Smtp-Source: AGHT+IEvE+DKZracKKXNv2t0/fJ4N3mUj3DuB7XOdUlltXO4+thd9FghKn5nNx6zLHZVO5O7mJoWcg==
X-Received: by 2002:a17:903:2282:b0:295:5132:1aa5 with SMTP id d9443c01a7336-295513221e2mr137269225ad.55.1762189242569;
        Mon, 03 Nov 2025 09:00:42 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b603sm127782445ad.79.2025.11.03.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:42 -0800 (PST)
Subject: [net-next PATCH v2 06/11] fbnic: Rename PCS IRQ to MAC IRQ as it is
 actually a MAC interrupt
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:00:41 -0800
Message-ID: 
 <176218924103.2759873.8687328716983200406.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/fbnic/fbnic.h         |    6 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   32 ++++++++++++-----------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |   14 +++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |    8 +++---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    4 +--
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |    2 +
 6 files changed, 33 insertions(+), 33 deletions(-)

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
index 1c88a2bf3a7a..145a33e231e7 100644
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
@@ -131,26 +131,26 @@ static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
 
 	fbn = netdev_priv(fbd->netdev);
 
-	phylink_pcs_change(&fbn->phylink_pcs, false);
+	phylink_mac_change(fbn->phylink, false);
 
 	return IRQ_HANDLED;
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



