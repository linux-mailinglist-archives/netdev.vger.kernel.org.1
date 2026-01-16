Return-Path: <netdev+bounces-250588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBAD37B25
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B87300E023
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4F335573;
	Fri, 16 Jan 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g885Spbe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B293939BA
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585197; cv=none; b=ddUYtPkGsjs51L8H09XWo3RQtnrfKEeVMgnBncsUOSOIVhZO3abX7KoeAkmFmH/EuZAEuM/Qsawwt5NZPU97+hvTq1g6SMk3e5dAuUqKexErSRvgKJFbs1TPoKrOty3/FXVLmKTtWB8Amv2pRXoHfTJl6oFWKu9s5hiyR2t8v7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585197; c=relaxed/simple;
	bh=eBap1IGDUdQ1vvCZhSxaJLrp3/p164d504Gr1LbE0BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk0y+bc8U2zNNubeTaMQsA/U56eo3wguMSCJg8OcqF5iSI0aIbPMgoHJNUhKCuorMQf4YUMEQmnhZLMtO9Y/3QOu0BzITF+eAIrqxRBnQvL7ClYtOrZyRxWHJhBAWyG+e6rGQUA2+/0h9OXGiuHYeobp3SrrMVwP3yWXExs34T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g885Spbe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee07570deso16771695e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768585194; x=1769189994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szZwzFJtgiGVrOBlyWcGOP1Gxw0XN83QlB7b2YSzMJ4=;
        b=g885SpbelsLKQauWY7y7GJVqOLZtS7d6I5ZBaBmTqfukddhZyT8P58OTLUPG+oxayn
         g+D1fWsUGDgQQbLWazLSFFbX2S5jeOTFn59chc29it0vA7X7RLpeVki1ZXVqWe3ORNpy
         rduL884M4Bf708P5khRqSgnlXLBv7xrXEvFrR5O9SfyzGlVWUY9K5GRoYUL7Hasl+3E4
         i7QI60ULSHPar4oIcy9UWjdy43JzMLWsVhxlSY4LjaSfJf+anGeWY3yjMcIHvP9IF7L+
         OJZ8GBmVRu/EmlimluReTxxr2eyWGP5nweOPX8jcyQPs5im3xj5kT7PP+bTWNnFWle8o
         9O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768585194; x=1769189994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szZwzFJtgiGVrOBlyWcGOP1Gxw0XN83QlB7b2YSzMJ4=;
        b=UvvUGov5u6S9xy91R+s19lCIstUbHI5PInoTO1FaFssX54WIgkWfiy8Ko/zkzkKKZ8
         8IIMUUTVK4+0P6DHYdPa6kFnMbDdk5XV7nhtcOwD1W83CslI4/N6NWTmW7xqrZ5OGCmu
         UP1HdH4bILOnGgoewWIZEeENBm/jtOHpJTpZvJvZWDvFwWFiHR1O8ypq3DvmiWrpRhYv
         KE4Qjv750XSHPrTu9xv1NTRVJm/hFP/4B1+L8J8P1ZhZe/r4iOvPGpaKhEovTeRByUMA
         eoPePVBCkXP+62dOgVmw5kM5SuCO+m4nr8owDZQ9pKT29sal9tQ84igYqZ2o3dgI6etn
         z9ig==
X-Gm-Message-State: AOJu0YxslHtCxLJ9D9XI/1oWF3WqOCyCYSAaehBAfTmZ2fj7UfV9Oa6f
	X94LYv/NVmznRGijxaXnWcNDXn92YDmDyxAVyy3KO0rR7EPHspfeAzxtgHnKKg==
X-Gm-Gg: AY/fxX5bYQxBC+numer4m6u6Krc1Q8qQ4Ob6itx2HgAczG+FGeBJA32nQPOGAVwpOdf
	J/33V6zj9+b6I5QmrFOCalfLJpfV3nNzOQ1BOpjo1C6VdEfaJWpbpjRIHk0QhBT7Jc+DRu75KYJ
	ZtlgQN0L75ioU2ytfgiUmCsQC7w/I4+QB9KhPpYPk2asvakwUkVFTPlsDM0WJ2RJhwmr/AaA11W
	sdQx3tJ8QaSeEd54TDqpAus3e1bhkflPpDxlDCg6q70H26FJtB25LtDV6N3w5URfwP5m0jQA5zW
	QU+fRIT5tA9i+HBi2UAWimctO+Duzi930O+vWWVxc9A+7J61BnK4vYtvsxUGcejPH0XDW+j4I48
	XlFwrf6bMNRGlkCj2nxrAnm54aysBQWBccr5ltKZq8ppo56ZeUNtFQrZak9ra3mzAWtDU25J4fH
	1VYlsT8eU4RdJNUlVQocKSUA==
X-Received: by 2002:a05:600c:8710:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-4801eb17b45mr32623145e9.33.1768585194076;
        Fri, 16 Jan 2026 09:39:54 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b26764fsm108902105e9.12.2026.01.16.09.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:39:53 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: netdev@vger.kernel.org
Cc: Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH 2/2] net: phy: realtek: add RTL8224 polarity swap support
Date: Fri, 16 Jan 2026 18:39:20 +0100
Message-ID: <20260116173920.371523-2-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116173920.371523-1-dam.dejean@gmail.com>
References: <20260116173920.371523-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTL8224 has a register to configure the polarity of every pair of
each port. It provides device designers more flexbility when wiring the
chip.

Unfortunately, the register is left in an unknown state after a reset.
Thus on devices where the bootloader don't initialize it, the driver has
to do it to detect and use a link.

The MDI polarity swap can be set in the device tree using the property
realtek,mdi-polarity-swap. The u32 value is a bitfield where bit[0..3]
control the polarity of pairs A...D.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 .../bindings/net/realtek,rtl82xx.yaml         |  7 +++++
 drivers/net/phy/realtek/realtek_main.c        | 29 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 2d04d90f8b97..4abcc5cfaf5f 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -67,6 +67,13 @@ properties:
       - off
     default: keep
 
+  realtek,mdi-polarity-swap:
+    description:
+      A bitmap to describe pair polarity swap. Bit 0 to swap polarity of pair A,
+      bit 1 to swap polarity of pair B, bit 2 to swap polarity of pair C and bit
+      3 to swap polarity of pair D.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 unevaluatedProperties: false
 
 allOf:
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index e01bfad37cf5..3bcee2f40a44 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -164,6 +164,7 @@
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+#define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -219,6 +220,7 @@ enum pair_swap_state {
 
 struct rtl8224_priv {
 	enum pair_swap_state pair_swap;
+	int polarity_swap;
 };
 
 static int rtl821x_read_page(struct phy_device *phydev)
@@ -1713,12 +1715,28 @@ static void rtl8224_mdi_pair_swap(struct phy_device *phydev, bool swap)
 				RTL8224_VND1_MDI_PAIR_SWAP, val);
 }
 
+static void rtl8224_mdi_polarity_swap(struct phy_device *phydev, u32 swap)
+{
+	u32 val;
+	u8 offset;
+
+	offset = (phydev->mdio.addr & 3) * 4;
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_POLARITY_SWAP);
+	val &= ~(0xf << offset);
+	val |= (swap & 0xf) << offset;
+	__phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				RTL8224_VND1_MDI_POLARITY_SWAP, val);
+}
+
 static int rtl8224_config_init(struct phy_device *phydev)
 {
 	struct rtl8224_priv *priv = phydev->priv;
 
 	if (priv->pair_swap != PAIR_SWAP_KEEP)
 		rtl8224_mdi_pair_swap(phydev, priv->pair_swap == PAIR_SWAP_ON);
+	if (priv->polarity_swap >= 0)
+		rtl8224_mdi_polarity_swap(phydev, priv->polarity_swap);
 
 	return 0;
 }
@@ -1737,6 +1755,16 @@ static enum pair_swap_state rtlgen_pair_swap_state_get(const struct device_node
 	return PAIR_SWAP_KEEP;
 }
 
+static int rtlgen_polarity_swap_get(const struct device_node *np)
+{
+	u32 polarity;
+
+	if (!of_property_read_u32(np, "realtek,mdi-polarity-swap", &polarity))
+		return polarity;
+
+	return -1;
+}
+
 static int rtl8224_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -1748,6 +1776,7 @@ static int rtl8224_probe(struct phy_device *phydev)
 	phydev->priv = priv;
 
 	priv->pair_swap = rtlgen_pair_swap_state_get(dev->of_node);
+	priv->polarity_swap = rtlgen_polarity_swap_get(dev->of_node);
 
 	/* Device has 4 ports */
 	devm_phy_package_join(dev, phydev, phydev->mdio.addr & (~3), 0);
-- 
2.47.3


