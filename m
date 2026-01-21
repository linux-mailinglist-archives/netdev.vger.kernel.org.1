Return-Path: <netdev+bounces-251954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAFSLYwJcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-251954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:14:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 643655A5FF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2D0FAE093F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27F48122B;
	Wed, 21 Jan 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3Mi6NUK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB644266AF
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008522; cv=none; b=OeToXm5X1XCUpo6W0qKb7hBFQsXJi3kF9W/9w6DQw1bBDwKOt6PVukJ6rZF1pvcTFnUeHW39R+Is46I6KdS/xouJmAXGyz8yr6Zcvfz2G6rWcWhTWbcGxKdLv5APW5MvaOX/9w0Xf7HQmOm4I4bbe7dWdyJwg/Q1VfOzWY+219s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008522; c=relaxed/simple;
	bh=G9t3/+goRa+enLB8DmMGYDI18LDXSU1kkDUtcw16/GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDWaS6onHFD53ajAXwKoqM2NRE1X6i4W6wjZxgRUQgqJKWplKIu9Xk83qDEUtyhJ7M3npZN9l5G41+3lRQ5CovKFmBQybAauAGUtKpa48cD0wVf+jH+11Vw6MyOwnQeyeYoZIBrHM5gbIjICdZCIhDKHufxm/2uqjLRxiZ37B9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3Mi6NUK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so64793865e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769008519; x=1769613319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDPqcBo1Wyp98J6zUH84/iFee/PYTwwHPKaiZ4Q0o9M=;
        b=I3Mi6NUKqQ5zoEg+Q7Nfu3+6q9xLZ5J8MIRN+THSRfjBHmh8NUr7TE2IACbC8XfUoj
         rFj5j/BugRU/Mo7eVO/62BFskIldeirwEE16dfSvN6w9H9CpNIFVyaFulhMXc14BtrmE
         NGQ8Tju5peEIvpkjujjP7qOA7T1xNKvhbsUMCAlfOh8M8bsodY7YVq0B+vu05wZ4sTTt
         LizZ4t/L/DKYNtxbwzT1W4cQb8afiiMBEFWdDAAiQ7CzAh4w7RGadi9B/O8Ne27Vz/fq
         L4S2wQr12LHqxfAmlww2vBC1lNfAggMenC0EqR3IgAzVpndrb6dwwI2EZOgONxCgV8Fh
         pkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769008519; x=1769613319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDPqcBo1Wyp98J6zUH84/iFee/PYTwwHPKaiZ4Q0o9M=;
        b=YRPhQ3VyoobMMHE4/t16zbNVLUyOekCtzSiYARBc7Gwbm0zDsbBmYyRhgrzHDQhFe5
         iszoQUSJwALBatNWhUweTPefYwSCLL1vob9tVJUC6m6lbaUWruTr933iMVYHRbmiyskh
         Nk2NkQ4yd/m9UP4exyXhjq7hAEeWxej3ny/yU/2q/TN5rYghC6TNVolKlQirc9X8WRhH
         xjJpcxkNWePUwf2C7icAXRJY3Ok/S9zk03JkrMhr6jKnU7NtGZzOAOtDhuQmoNXc/Se8
         uKxY7GxajNeYocrUDjO8uO6iForByK/RNAEfoYqg3igzbRj0RrKo3yl0DTG2/8Gcpnj+
         2lHQ==
X-Gm-Message-State: AOJu0YysdgIOGs+qXHEr92WZ/Xd5GEgmBIO+VONbcWuxiK3d8srVRS8z
	gVDdiwVivr1ymD1iXAgrU4aGDI6QG6LbbCAOdI2+5K6vLHPXZVi8HrVP
X-Gm-Gg: AZuq6aI/IiZrPIZmKhDJj9Jz5CtEjofXPuc6lb8G9AtixzqoYL4+ptsEVr/013C4Sqn
	MLOCodm/eEOO4cA4XSk/qpo02pWGMdYw5HNGVoGg91fTC4BkbOhnes9aKIv1b10RV1X3JE7xVhF
	msp3tdp9rvNpivCndgtG2SKvP02N3WfRDu9rc/0SmCgql6NlHgKtOkD72phWhbN7mPpwucHB/Nf
	bL0XQOLxcymHyz7I2Gu6aYg0k+Dt1NwtjqGyqaSXj1twuWk2TAPqVduT+UJiTnNWO7M1OxNpaRQ
	/r1G5NV5J2vPu+c3xXchmPmRBvrKD2Jw9kK9P6O+mI6cAfpKbIeTUUMa8+4Ak8hQBVOY5EZlXuT
	x2UDdC8Aicd/PZqQMWEop9v2Oai469yLWa+ebKyit9kwQmsc3zHBXiWwxZVdYr3TfpLTrMSeE/E
	NcufS6m8S95fQ=
X-Received: by 2002:a05:600c:c16a:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-4801e33c332mr257343245e9.25.1769008518764;
        Wed, 21 Jan 2026 07:15:18 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435924ae6f1sm10534349f8f.33.2026.01.21.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:15:18 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v2 2/4] net: phy: realtek: add RTL8224 pair order support
Date: Wed, 21 Jan 2026 16:15:04 +0100
Message-ID: <20260121151506.813783-2-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121151506.813783-1-dam.dejean@gmail.com>
References: <20260121151506.813783-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-251954-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 643655A5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8224 has a register to configure a pair swap (from ABCD order to
DCBA) providing PCB designers more flexbility when wiring the chip. The
swap parameter has to be set correctly for each of the 4 ports before
the chip can detect a link.

After a reset, this register is (unfortunately) left in a random state,
thus it has to be initialized. On most of the devices the bootloader
does it once for all and we can rely on the value set, on some other it
is not and the kernel has to do it.

The MDI pair swap can be set in the device tree using the property
realtek,mdi-cfg-order. The property is set to 0 to keep the default
order (ABCD), or 1 to reverse the pairs (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/Kconfig        |  1 +
 drivers/net/phy/realtek/realtek_main.c | 50 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
index b05c2a1e9024..a741b34d193e 100644
--- a/drivers/net/phy/realtek/Kconfig
+++ b/drivers/net/phy/realtek/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config REALTEK_PHY
 	tristate "Realtek PHYs"
+	select PHY_PACKAGE
 	help
 	  Currently supports RTL821x/RTL822x and fast ethernet PHYs
 
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 6ff0385201a5..85b0eea936e4 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/string_choices.h>
 
+#include "../phylib.h"
 #include "realtek.h"
 
 #define RTL8201F_IER				0x13
@@ -162,6 +163,8 @@
 
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
+#define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -1683,6 +1686,51 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return rtl8224_cable_test_report(phydev, finished);
 }
 
+static int rtl8224_mdi_config_order(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 port_offset = phydev->mdio.addr & 3;
+	u32 mdi_conf, val;
+	int ret;
+
+	ret = of_property_read_u32(np, "realtek,mdi-cfg-order", &mdi_conf);
+
+	/* Do nothing in case the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (mdi_conf & ~1)
+		return -EINVAL;
+
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_PAIR_SWAP);
+	if (val < 0)
+		return val;
+
+	if (mdi_conf)
+		val |= (1 << port_offset);
+	else
+		val &= ~(1 << port_offset);
+
+	return __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				       RTL8224_VND1_MDI_PAIR_SWAP, val);
+}
+
+static int rtl8224_config_init(struct phy_device *phydev)
+{
+	return rtl8224_mdi_config_order(phydev);
+}
+
+static int rtl8224_probe(struct phy_device *phydev)
+{
+	/* Chip exposes 4 ports, join all of them in the same package */
+	return devm_phy_package_join(&phydev->mdio.dev, phydev,
+				     phydev->mdio.addr & ~3, 0);
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -2212,6 +2260,8 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
 		.flags		= PHY_POLL_CABLE_TEST,
+		.probe		= rtl8224_probe,
+		.config_init	= rtl8224_config_init,
 		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822x_c45_read_status,
-- 
2.47.3


