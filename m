Return-Path: <netdev+bounces-254265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBu4C+UTemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:49:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5FCA24B4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F30304D264
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51135F8C7;
	Wed, 28 Jan 2026 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="gEa6Tl/s"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99435FF46
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608092; cv=none; b=d6X91Db8Od5zx+HeQTge6uN34moBI93XFgBebvfOu5XMp7uYOOwbX8DTofrKjfzP1VfFPi6+EBl2dlqIpK37An3hVgQUbNuZDVuzRgGABAqm6rnwFdsLTYaSDZbrvM2jR3Dg1g3jnkEOMwjlVm41cUK5WScmCkE/xR1ySx8HmQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608092; c=relaxed/simple;
	bh=m2uW/KvL/WqMqZUi45kpf4xd23lVIB90XvRajc6QXOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWp6ThvKUeFth/OTU2XQnswOXomfIHj65Q42yuq9hjTPHhH84mD5Zz9SkE6tg6gxAM7iVQGpFNaMmop1ohpZyhyz2wBS/Gmke4/pJ+TzMbBXhxt9GTQIX020L0t4dW8rUHzU9e8ILcss32Q3lKaYUn250Xr5SETvaAdDvgorIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=gEa6Tl/s; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3E595EAB01;
	Wed, 28 Jan 2026 14:39:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1769607546; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gc6OAhBdvxkJppmY4xORPUKOb8dfACXDwsHN+siUsEY=;
	b=gEa6Tl/sEQC/QhqbarjAMLiigwWhjvi30CroAwQcqvNlYbEVr6YVuWUqb+9K2E6Q3bjco0
	iHfaCnbpR3xboCqJ2L+7q7acOcTnuNtLW4P32KlOnLtzTiGqQ/e/8rywCMa24XfVN3OIET
	AINBL5qOc9Z4qETxwQ8Y/zaVt4UPT1PhHLYUwdiCmmjE/QbVZ/AuRQnlC+bjmbY0Y8GYIU
	b4ySrF7A23P6V2xOV1S4mAxvJ4xAqCui/rz5Y3S+VRCNAUDi7UvM9k/BS8/qxLvgmR85pU
	NUp3SXi0rVhOjJmNQ++gqtKMGeeyt0ZXPNOZg2u442WZeMuvarE3ldHqTn6Zrw==
From: Heinrich Toews <ht@twx-software.de>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v1 3/3] net: dsa: microchip: add single-led-mode support for KSZ9477
Date: Wed, 28 Jan 2026 14:38:33 +0100
Message-ID: <20260128133842.1173406-4-ht@twx-software.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128133842.1173406-1-ht@twx-software.de>
References: <20260128133842.1173406-1-ht@twx-software.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[twx-software.de,quarantine];
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254265-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ht@twx-software.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[twx-software.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twx-software.de:email,twx-software.de:dkim,twx-software.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC5FCA24B4
X-Rspamd-Action: no action

Add support for single LED mode via the "microchip,single-led-mode"
device tree property which will apply the configuration globally on all
non-CPU ports.

The implementation includes a workaround for Errata Module 19,
requiring a debug register write to ensure proper LED activity.
The mode is configured during the MAC link-up phase for non-CPU ports.

Signed-off-by: Heinrich Toews <ht@twx-software.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 34 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  4 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e5fa1f5fc09b3..bef8ec51d9483 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -815,6 +815,9 @@ static const u16 ksz9477_regs[] = {
 	[PTP_RTC_SEC]			= 0x0508,
 	[PTP_SUBNANOSEC_RATE]		= 0x050C,
 	[PTP_MSG_CONF1]			= 0x0514,
+	[P_PHY_MMD_SETUP]		= 0x011A,
+	[P_PHY_MMD_DATA]		= 0x011C,
+	[P_PHY_DIGITAL_DEBUG_3]		= 0x013C,
 };
 
 static const u32 ksz9477_masks[] = {
@@ -3241,6 +3244,14 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 		if (!port)
 			return MICREL_KSZ8_P1_ERRATA;
 		break;
+	case KSZ9477_CHIP_ID:
+		/* KSZ9477S Errata DS80000754F
+		 *
+		 * Module 19: Single-LED Mode Setting Requires Two Register Writes
+		 *   The PHY Port LEDx_0 pin does not go low in the presence of link
+		 *   activity when Single-LED Mode is selected in the MMD LED Mode Register.
+		 */
+		return MICREL_KSZ9_LED_ERRATA;
 	}
 
 	return 0;
@@ -3909,6 +3920,24 @@ static void ksz_set_gbit(struct ksz_device *dev, int port, bool gbit)
 	ksz_pwrite8(dev, port, regs[P_XMII_CTRL_1], data8);
 }
 
+static void ksz_enable_single_led_mode(struct ksz_device *dev, int port, struct phy_device *phydev)
+{
+	const u16 *regs = dev->info->regs;
+
+	ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x0002); /* Set up register address for MMD */
+	ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0000); /* Select Register 00h of MMD */
+	ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x4002); /* Select register data for MMD */
+	ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0011); /* Write value 0011h to MMD */
+
+	/* According to KSZ9477S Errata DS80000754F (Module 19) 0xfa00 has to
+	 * be written to the Debug Register 3 to enable Single-LED Mode.
+	 */
+	if (phydev->dev_flags & MICREL_KSZ9_LED_ERRATA)
+		ksz_pwrite16(dev, port, regs[P_PHY_DIGITAL_DEBUG_3], 0xfa00);
+
+	dev_info(dev->dev, "port-%d: single-led mode enabled.\n", port);
+}
+
 static void ksz_set_100_10mbit(struct ksz_device *dev, int port, int speed)
 {
 	const u8 *bitval = dev->info->xmii_ctrl0;
@@ -3977,6 +4006,9 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 	int port = dp->index;
 	struct ksz_port *p;
 
+	if (dev->single_led_mode && port != dev->cpu_port)
+		ksz_enable_single_led_mode(dev, port, phydev);
+
 	p = &dev->ports[port];
 
 	/* Internal PHYs */
@@ -5526,6 +5558,8 @@ int ksz_switch_register(struct ksz_device *dev)
 							   "wakeup-source");
 		dev->pme_active_high = of_property_read_bool(dev->dev->of_node,
 							     "microchip,pme-active-high");
+		dev->single_led_mode = of_property_read_bool(dev->dev->of_node,
+							     "microchip,single-led-mode");
 	}
 
 	ret = dsa_register_switch(dev->ds);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de5..9900e9dd91810 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -187,6 +187,7 @@ struct ksz_device {
 	bool synclko_disable;
 	bool wakeup_source;
 	bool pme_active_high;
+	bool single_led_mode;		/* Enable Single LED Mode */
 
 	struct vlan_table *vlan_cache;
 
@@ -277,6 +278,9 @@ enum ksz_regs {
 	PTP_RTC_SUB_NANOSEC,
 	PTP_SUBNANOSEC_RATE,
 	PTP_MSG_CONF1,
+	P_PHY_MMD_SETUP,
+	P_PHY_MMD_DATA,
+	P_PHY_DIGITAL_DEBUG_3,
 };
 
 enum ksz_masks {
-- 
2.52.0


