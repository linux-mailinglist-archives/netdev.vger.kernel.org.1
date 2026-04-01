Return-Path: <netdev+bounces-274072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBgJMx8JzWm3ZgYAu9opvQ
	(envelope-from <netdev+bounces-274072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:01:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11737A0AC
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC4FA30255CA
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B26940B6C8;
	Wed,  1 Apr 2026 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPcL+11t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA21840B6CA
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044267; cv=none; b=Ztx6gi1tkO5DF/3id0KRhVgVVp3CDEeD4iC2OQHzFKDrcSxSg/AiZ/HWXo+ZWSgIwgpbvLdh4CGiV3OtN5A08ZHkldDzDoJeFT9S0hLBegAqwguE5d2GM08lwv2kuOLHouVCy6L5nQeMVKZdMEU4GIb/aQMnJOlffYAtjQzzGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044267; c=relaxed/simple;
	bh=x5wBMRf9REXeqaw3JhjM4+SIbO+3GwPThHBMJHmSn08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B03Ays6U+WaP6+R2lbpDI51Vq97/sWUZCVOJqosu4bF7rJlCnFe6Q6DHggCALa9wfFi4ZlqiRI7VbKMj1YEIAfYOM2IYa0zvYl8mnTOwAWWr9SjzDXkoim0tk2u+fECSbP1ZRp1E+/0DAqH+ZQs2ip1But1lzgEE0+GlgXE8/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPcL+11t; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso3607998f8f.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775044264; x=1775649064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykKcOeoNKH8nXWk+DCod1qUgx5fH/3oGVEQk5ZNMGPw=;
        b=UPcL+11tosOj2OnWXKkVcP9YOe0ONBG824EMILuSli6j4P90vPgW+jG1YuiHHXSwOq
         YjS+0dcRlua677u2x2eSi9VfetTNc6tnwFB4BFrg8l1FAN/9SzH8zIUUjwAIRglUSXmV
         tqM9cBkNQAdoqN78JmUSMfRgkjUQMegpnOVaqVCIL6tzIVrOqR9CdwYFks2iWKZPtdlo
         js3I9wcrOAvX5av+6JaPR5coNl+R0WFxY987+w5kXqDq3+ewXV/vJtkIpDKhnfHKbi0U
         QDhvW14iANnwvLZbZlDzqh4BqJEczz59NFVcu2u8hkwfmcDvuaIVmtka2lsTYztYJXNz
         9DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775044264; x=1775649064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykKcOeoNKH8nXWk+DCod1qUgx5fH/3oGVEQk5ZNMGPw=;
        b=ZOru3T76H8yLQXP4T29CmwOlZQJld4cztWjCeRZg98Mbmw8aaQGVfIXYRgEbYyb8Eu
         SfA/OpPe8lQmGfYIGnxKllLDQnjm6ypYXTnlf3Qh1Jgei+oJF/l0H2DQkvywi69XSnhc
         BhXxenEsobtpa6jTSN6xgbgR90ZaRzACDuf+UmfvRbR/dBJzbuS6jxLV6LtwiM7nfbm9
         Gq9OXe6pXK/OfBmf4ZXrxJGJuL6kf1f4bfQTf6seJD9rV6+aDL/AbqYiF8tgTKmbDug8
         m/9OTGAXpwg3NgirOFibUDRqt33JRCuzCTpTYDFhvp2273CY1Ok5VZw0stej/NfGGMiS
         8ReQ==
X-Gm-Message-State: AOJu0YyBHfDeP8fGbhBxW8D/Fw/tmyYRY44R51ncn7O0TGRhkBmK3RCW
	UXDlH/WiICmptC+VLwyvPYf6UcHe7bjTk46TVEFqbsQMicGMY6c6cQrBEnlCOg==
X-Gm-Gg: ATEYQzw9PEe8++oa/ETvKhrg4aIaeODTuxvtIFNQMRb9q/WnyJe8WVKqlfI65k+hzfm
	WP8wgCxY0eG3k0AOA2KoeVrpuGoeMALcF/IIWnXJ+1EuYTWIwpnqhkT5USBicG+D92fcb0MH18X
	jnK3WPUdUzjQl2fFLi1Id5Yx4kfVsV27qujfWWT/RLSlgSn/eEHsaWobX5YhZNA9FhOz7YfhhPE
	qcJ4d4TmxdZAOG+Cte22RwisA1XjHMaS+SMncgBRkVGcjMJWtbecFSk8PRyGIwSl63ACaqfJHMd
	SfD60RDDCaTnxh2mN3f8aH4SroxqRqOD559ZQL8xwvaxiwtnV10R6eDl+QBspO90fIbIy/0fX53
	LvmdLhZeM+sz8b6QMxL9UcvV4sJmKIEh7FHxzTiLRGAj6P+Wa52oYP7PqBmQ+qRh7uEfOJxVma5
	gNT1tM+3Y8OPXJE6zjaf9b74w0eRn80p83LEhlUMckg0LhacqqnZSOxIc1nAeV8zspWrg9lxgcg
	/5W1sdgi6GQWA5X
X-Received: by 2002:a05:6000:26c3:b0:43b:495a:a75d with SMTP id ffacd0b85a97d-43d15042dcemr6286414f8f.5.1775044262448;
        Wed, 01 Apr 2026 04:51:02 -0700 (PDT)
Received: from 6850u.ox.dtw.sh (cpc69060-oxfd26-2-0-cust335.4-3.cable.virginm.net. [82.6.49.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm37142640f8f.24.2026.04.01.04.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:51:01 -0700 (PDT)
From: Daniel Wagner <wagner.daniel.t@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Wagner <wagner.daniel.t@gmail.com>
Subject: [PATCH net-next] net: phy: bcm84881: add LED framework support for BCM84891/BCM84892
Date: Wed,  1 Apr 2026 12:49:31 +0100
Message-ID: <20260401114931.3091818-1-wagner.daniel.t@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274072-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wagnerdanielt@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[wagnerdanielt.gmail.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA11737A0AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose LED1 and LED2 pins via the PHY LED framework. Each pin has a
source mask (MASK_LOW + MASK_EXT registers) selecting which hardware
events light it, plus a CTL field in the shared 0xA83B register
(RMW; LED4 is firmware-controlled per the datasheet).

Hardware can offload per-speed link triggers (1000/2500/5000/10000),
RX/TX activity, and force-on. LINK_100 is accepted only alongside
LINK_1000: source bit 4 lights at both speeds and 100-alone isn't
representable, so the unrepresentable case falls to software.

The chip has five LED pins; only LED1/LED2 are exposed here as those
are the only ones characterized on tested hardware. LED4 is firmware-
controlled regardless of strap configuration.

Tested on TRENDnet TEG-S750 (LED1/LED2 wired to an antiparallel
bicolor LED): brightness_set via sysfs; netdev trigger offloaded=1
with amber lit at 100M/1G/2.5G and green lit at 10G via respective
link_* modes; LED off immediately on cable unplug with no software
involvement.

Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>
---
 drivers/net/phy/bcm84881.c | 156 +++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index f114212dd3..2ae70dcf82 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -20,6 +20,33 @@ enum {
 	MDIO_AN_C22 = 0xffe0,
 };
 
+/* BCM8489x LED controller (BCM84891L datasheet 2.4.1.58). Each pin has
+ * CTL bits in 0xA83B (stride 3: 2-bit CTL + 1-bit OE_N) plus MASK_LOW/
+ * MASK_EXT source selects. LED4 is firmware-controlled; always RMW.
+ */
+#define BCM8489X_LED_CTL		0xa83b
+#define BCM8489X_LED_CTL_ON(i)		(0x2 << ((i) * 3))
+#define BCM8489X_LED_CTL_MASK(i)	(0x3 << ((i) * 3))
+
+#define BCM8489X_LED_SRC_RX		BIT(1)
+#define BCM8489X_LED_SRC_TX		BIT(2)
+#define BCM8489X_LED_SRC_1000		BIT(3)	/* high only at 1000 */
+#define BCM8489X_LED_SRC_100_1000	BIT(4)	/* high at 100 and 1000 */
+#define BCM8489X_LED_SRC_FORCE		BIT(5)	/* always-1 source */
+#define BCM8489X_LED_SRC_10G		BIT(7)
+#define BCM8489X_LED_SRCX_2500		BIT(2)
+#define BCM8489X_LED_SRCX_5000		BIT(3)
+
+#define BCM8489X_MAX_LEDS		2
+
+static const struct {
+	u16 mask_low;
+	u16 mask_ext;
+} bcm8489x_led_regs[BCM8489X_MAX_LEDS] = {
+	{ 0xa82c, 0xa8ef },	/* LED1 */
+	{ 0xa82f, 0xa8f0 },	/* LED2 */
+};
+
 static int bcm84881_wait_init(struct phy_device *phydev)
 {
 	int val;
@@ -69,6 +96,127 @@ static int bcm8489x_config_init(struct phy_device *phydev)
 				  MDIO_CTRL1_LPOWER);
 }
 
+static int bcm8489x_led_write(struct phy_device *phydev, u8 index,
+			      u16 low, u16 ext)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
+			    bcm8489x_led_regs[index].mask_low, low);
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
+			    bcm8489x_led_regs[index].mask_ext, ext);
+	if (ret)
+		return ret;
+	return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, BCM8489X_LED_CTL,
+			      BCM8489X_LED_CTL_MASK(index),
+			      (low | ext) ? BCM8489X_LED_CTL_ON(index) : 0);
+}
+
+static int bcm8489x_led_brightness_set(struct phy_device *phydev,
+				       u8 index, enum led_brightness value)
+{
+	if (index >= BCM8489X_MAX_LEDS)
+		return -EINVAL;
+
+	return bcm8489x_led_write(phydev, index,
+				  value ? BCM8489X_LED_SRC_FORCE : 0, 0);
+}
+
+static const unsigned long bcm8489x_supported_triggers =
+	BIT(TRIGGER_NETDEV_LINK) |
+	BIT(TRIGGER_NETDEV_LINK_100) |
+	BIT(TRIGGER_NETDEV_LINK_1000) |
+	BIT(TRIGGER_NETDEV_LINK_2500) |
+	BIT(TRIGGER_NETDEV_LINK_5000) |
+	BIT(TRIGGER_NETDEV_LINK_10000) |
+	BIT(TRIGGER_NETDEV_RX) |
+	BIT(TRIGGER_NETDEV_TX);
+
+static int bcm8489x_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	if (index >= BCM8489X_MAX_LEDS)
+		return -EINVAL;
+
+	if (rules & ~bcm8489x_supported_triggers)
+		return -EOPNOTSUPP;
+
+	/* Source bit 4 lights at both 100 and 1000; "100 only" isn't
+	 * representable in hardware. Accept LINK_100 only alongside
+	 * LINK_1000 or LINK so the offload is precise.
+	 */
+	if ((rules & BIT(TRIGGER_NETDEV_LINK_100)) &&
+	    !(rules & (BIT(TRIGGER_NETDEV_LINK_1000) |
+		       BIT(TRIGGER_NETDEV_LINK))))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int bcm8489x_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	u16 low = 0, ext = 0;
+
+	if (index >= BCM8489X_MAX_LEDS)
+		return -EINVAL;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
+		low |= BCM8489X_LED_SRC_100_1000;
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
+		low |= BCM8489X_LED_SRC_1000;
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK)))
+		ext |= BCM8489X_LED_SRCX_2500;
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_5000) | BIT(TRIGGER_NETDEV_LINK)))
+		ext |= BCM8489X_LED_SRCX_5000;
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_10000) | BIT(TRIGGER_NETDEV_LINK)))
+		low |= BCM8489X_LED_SRC_10G;
+	if (rules & BIT(TRIGGER_NETDEV_RX))
+		low |= BCM8489X_LED_SRC_RX;
+	if (rules & BIT(TRIGGER_NETDEV_TX))
+		low |= BCM8489X_LED_SRC_TX;
+
+	return bcm8489x_led_write(phydev, index, low, ext);
+}
+
+static int bcm8489x_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	int low, ext;
+
+	if (index >= BCM8489X_MAX_LEDS)
+		return -EINVAL;
+
+	low = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+			   bcm8489x_led_regs[index].mask_low);
+	if (low < 0)
+		return low;
+	ext = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+			   bcm8489x_led_regs[index].mask_ext);
+	if (ext < 0)
+		return ext;
+
+	*rules = 0;
+	if (low & BCM8489X_LED_SRC_100_1000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+	if (low & BCM8489X_LED_SRC_1000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+	if (ext & BCM8489X_LED_SRCX_2500)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_2500);
+	if (ext & BCM8489X_LED_SRCX_5000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_5000);
+	if (low & BCM8489X_LED_SRC_10G)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_10000);
+	if (low & BCM8489X_LED_SRC_RX)
+		*rules |= BIT(TRIGGER_NETDEV_RX);
+	if (low & BCM8489X_LED_SRC_TX)
+		*rules |= BIT(TRIGGER_NETDEV_TX);
+
+	return 0;
+}
+
 static int bcm84881_probe(struct phy_device *phydev)
 {
 	/* This driver requires PMAPMD and AN blocks */
@@ -290,6 +438,10 @@ static struct phy_driver bcm84881_drivers[] = {
 		.config_aneg	= bcm84881_config_aneg,
 		.aneg_done	= bcm84881_aneg_done,
 		.read_status	= bcm84881_read_status,
+		.led_brightness_set = bcm8489x_led_brightness_set,
+		.led_hw_is_supported = bcm8489x_led_hw_is_supported,
+		.led_hw_control_set = bcm8489x_led_hw_control_set,
+		.led_hw_control_get = bcm8489x_led_hw_control_get,
 	}, {
 		PHY_ID_MATCH_MODEL(0x359050a0),
 		.name		= "Broadcom BCM84892",
@@ -300,6 +452,10 @@ static struct phy_driver bcm84881_drivers[] = {
 		.config_aneg	= bcm84881_config_aneg,
 		.aneg_done	= bcm84881_aneg_done,
 		.read_status	= bcm84881_read_status,
+		.led_brightness_set = bcm8489x_led_brightness_set,
+		.led_hw_is_supported = bcm8489x_led_hw_is_supported,
+		.led_hw_control_set = bcm8489x_led_hw_control_set,
+		.led_hw_control_get = bcm8489x_led_hw_control_get,
 	},
 };
 
-- 
2.47.3


