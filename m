Return-Path: <netdev+bounces-269195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BrAAb8fu2lofQIAu9opvQ
	(envelope-from <netdev+bounces-269195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:57:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A52C32F8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4F631C6507
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613837D13C;
	Wed, 18 Mar 2026 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3pOFD8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163E36BCC4
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870912; cv=none; b=XjviZ5lotGiS6qJiiq1zYGBRoa/91F3QnS0e6uDijQ7OQm+v8R/cZddvCSJ+FOjLytwgULAwwWefeAY0jqHUDFBwt1BMFXgzRpnelGG1zBvrMRdWzEoVb/hx/tvRxpm7vf0ILPYx4g0Gb4DOy3Ig5VvEtDTq/pLfvhC36czVCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870912; c=relaxed/simple;
	bh=2/LV7x1w5ZpN78khNcFfHL9/K9EjNlAJ+nQoAYrNtBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NstAlY3BpVBDw5UojiX8NiiivMVTOLKKkfk1PbMrEpFXLp/1qlFmNnTb7XLHa3PiBIROqaatDjj7vY5JabVrp3bN0j1f30/g1AZoJmKAqjvAxryM2iv/MBtSHr4BDm2vcXpAwsC+yVkrRRLgXvHeJ8B4a0WNGXlBKHV9MRM/kVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3pOFD8Z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso2718735e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773870909; x=1774475709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWDjinezebp/AuPLcd5BKlN7px/L4sHMddcyTp7RIds=;
        b=M3pOFD8ZDY1KvrcAm94860DvZ6TEh9S4rIYfpSaG6K7BwV1HiHzB6B8IZU5OKWRFi6
         VS9Vqe3ufFRD8zhptyKaYVNIU0kpa97MI+2oUFNKLe0G8GcAlpwOD2vE2d2+kLCiLhdM
         3ePvD0dwVyB0pZceTOjMUQsANhWsLv75vxOinrZC3LSlwKPV3ZMTb/BwNAvIdvKx2wQR
         KfbwNJXHV2igY/vcWsFLp9GCAIrdS/H8daJbiMLuLmQLP/6RUZCpgBwCa3M6fl773Tzd
         ZPCB5A0CPiEjCmiuZKqCOvfFL46vzGESG8ZIfOtbPGR5EUwxXKLVNSaOu/QPy1Krmo3F
         lK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773870909; x=1774475709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VWDjinezebp/AuPLcd5BKlN7px/L4sHMddcyTp7RIds=;
        b=XsiaRJm2P7bsqbP+P/39iPFgFbDKsYwxi94CfU2zFu7Wa2V9Jn4fmnwfcz7Gco2618
         4lFbhWRMQqHvpTioOPkAqWOdXykTVzFTaZdH6nO1Tk/IBWGvj9p5rKRWtGgfppcB6oAs
         l0k/8QPWq/x9219y2XyH8aAQ6A4FymT2x7LhgvQ9mzbuDx58vkR+xjiNGGBI39WzkZ2r
         Sa70nF7kjLmjy/dkBmOYuFy/U32mjJ/VJXPqw61jLlh1hnfb5kCVe4YnfAKyLn0vVnhR
         RzqduUuCGpgO2cyxNBZCU/EU10P/sfRnuqyzPnGVNRneLC3EFtxwV762f2cDiByCAXGt
         LOnQ==
X-Gm-Message-State: AOJu0YyPGlm1HX4GzA1qci5yD40dFK2/5/y57czg2K9EcrUIgFiHGB8J
	22blmBUoK1TzkNHzHH6qVZne97ntVig/A7rjNrKUylmYiZ11RcgXPaQ1
X-Gm-Gg: ATEYQzywwBTcZnGd6Rln18uIfFCzjOcsE0kk5kqDxMQZiUWdtpbGl/LB5F0Bw4ZVY5H
	Kblq3L68uj9J5dt6x80q5RMUL6kgAaVu9GkhvhKFUaz5/1kntSTo8WuKp+VMolua1NpvTXLpsad
	792TU3YJLelpsRbOtjT1/0CzVrRaXpneqdr5bSa2/jyzmu7bD2qbpcEQT+OmIIWSObMAvTv2O8Z
	6tVzicuCrLNHXN884B70B+AZPFwEvxXKlkC8k6SrlCgAqfgjYrQ+b85OWzYKRhT4Zs71keHFmaF
	BA3eUIybTxc31OfCe2T7zFcCGDLCusiRHB+LViehrU7lDtaHcszsoHR24iAh+5NLxyka3/8QkFE
	TuNwwKSysoMVMbTCwy1a3whZDDuHOz2NasWzebxTFyaSsC3jI+MSvmZvyBO/d5lKXZa/k7yi0eW
	OqyTJxy5SWYrKYgBMLT8qGBK0=
X-Received: by 2002:a05:600c:4e56:b0:485:3dfc:569 with SMTP id 5b1f17b1804b1-486f4441067mr75301165e9.16.1773870909451;
        Wed, 18 Mar 2026 14:55:09 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e10:c662:37ff:fe09:94df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c292e2sm19373735e9.2.2026.03.18.14.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:55:09 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v9 4/4] net: phy: realtek: add RTL8224 polarity support
Date: Wed, 18 Mar 2026 22:55:01 +0100
Message-ID: <20260318215502.106528-5-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318215502.106528-1-dam.dejean@gmail.com>
References: <20260318215502.106528-1-dam.dejean@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269195-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.797];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B1A52C32F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8224 has a register to configure the polarity of every pair of
each port. It provides device designers more flexbility when wiring the
chip.

Unfortunately, the register is left in an unknown state after a reset.
Thus on devices where the bootloader don't initialize it, the driver has
to do it to detect and use a link.

The MDI polarity swap can be set in the device tree using the property
enet-phy-pair-polarity. The u32 value is a bitfield where bit[0..3]
control the polarity of pairs A..D.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 34 +++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 63134e300c33..023e47ad605b 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -172,6 +172,7 @@
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+#define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -1870,9 +1871,40 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 					  order ? BIT(port_offset) : 0);
 }
 
+static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 offset = (phydev->mdio.addr & 3) * 4;
+	u32 polarity = 0;
+	int ret;
+
+	ret = of_property_read_u32(np, "enet-phy-pair-polarity", &polarity);
+
+	/* Do nothing if the property is not present */
+	if (ret == -EINVAL || ret == -ENOSYS)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (polarity & ~0xf)
+		return -EINVAL;
+
+	return rtl8224_package_modify_mmd(phydev, MDIO_MMD_VEND1,
+					  RTL8224_VND1_MDI_POLARITY_SWAP,
+					  0xf << offset,
+					  polarity << offset);
+}
+
 static int rtl8224_config_init(struct phy_device *phydev)
 {
-	return rtl8224_mdi_config_order(phydev);
+	int ret;
+
+	ret = rtl8224_mdi_config_order(phydev);
+	if (ret)
+		return ret;
+
+	return rtl8224_mdi_config_polarity(phydev);
 }
 
 static int rtl8224_probe(struct phy_device *phydev)
-- 
2.47.3


