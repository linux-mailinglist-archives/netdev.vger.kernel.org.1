Return-Path: <netdev+bounces-256000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XDedA1kDgWnZDgMAu9opvQ
	(envelope-from <netdev+bounces-256000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:04:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6EFD0E82
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 341483017DFB
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BD13783AE;
	Mon,  2 Feb 2026 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isDCH0k6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F230EF69
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062666; cv=none; b=gY8b5y4C4NbfvdlVINtIaHLjCzDQIkft/tNLD0g9w2XFRKMiIg02qDdJe4/CHUiUF9rkANjbxkbDAoc8bbOqfVVoKd9dzKjAz26ckx2EQxNivANzKCMbXwQSpUI4KEMjJ2EEy8cV2eXuCt+dQXT5jErQsVeXxEbqejz5M9lXYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062666; c=relaxed/simple;
	bh=FQWd66idNIPPBt7TUF6kuXek5+OLh0Gsn4zYraBgsdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOB3ebP4CPQp/uN98kZyG+R2Ls1Iw/rwxzrS6ECLIrnt3BQ3t3v04nuvuDSouYlSwKtRvOwUXfUuPSpy9GrGfh9yHeY/fBhUdGo6kjoEv5akTflSofRs4XMuPDRBmwpO7BDHPtBLOaOiY+w7EMVxAvybf+h9xk/stj5FKok3Y2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isDCH0k6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-481188b7760so32362225e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 12:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770062663; x=1770667463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ3Xd1JUldaEb0EE6XNzb7a8EiRdMWPdAN1y5gE4vRE=;
        b=isDCH0k6XqQRIo1V9owXcGM1UoI8I98Dv1GfPduWf0zKO/AmEkJnkRzOXD6eC/nwXj
         PdYrFBYp463gRj9czFGdUtTD/1/RWk2K0Y2A1yQMejk65RXtTa2qLTrkUWWRa30H0bPN
         Al4Md68jqgAAnVgB3FDcxgzubLzaEh7WLBHEnXMlVFFrMzNxI4zfKrptVdMQ3T741Pcv
         tEbbqGgtzE8WdmKvT+cpgdUABLGCBZGpBsUk1lDKXVxZVf3iUtX9/ZJaV5LbPlhSc9df
         Fx6Q7wD9KOnaDEitSs9NMof9HvoOmCvagsLGWuQgThtMPQRqV3bFVIQypgohZFfW/eYa
         okiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062663; x=1770667463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQ3Xd1JUldaEb0EE6XNzb7a8EiRdMWPdAN1y5gE4vRE=;
        b=JRl9Gxdhr1K2CGF7Q0rliRK5EENSQJvqmqRgIh+VLeJPKsUZU9YA8Vq/kWCMF6bD6d
         RjimW0W/20aixcQ45GHzjOxlQC+Jz3taHkeq08RxD02Gl5o0fIXTOyhy/Tru2cFdndoA
         bK0lQx7SFL4qHnMHf7y14l5bp/y4reL0PXsmYjLvFQpki8BHPsEXUweQUK8Q7lL1fPbb
         Nd9mk2E0KmdPRZI7656A71n5H7c/KYW78DznPDG7Y9k8gKLajz0fLP5DFZrTglxw+DcZ
         gUhirJncCl7524rPeMZCU6lKAnIRcwrUagUCqH67gkbua78REilKEVX7j+lyyWW4Uj9g
         cO8Q==
X-Gm-Message-State: AOJu0YzZ7gkR8QafWI6JQl9/+bzj8f/2tMdDyThqRJ9zAGQQXv0dLOoy
	LS0t7oT1Su6atoJBUIvvclzdMwUvI8KJoqTwipbakHuNKwP1jyBCIm92
X-Gm-Gg: AZuq6aII2uY20Xm2AOh0/es6u5xY8h5O6Z4byqnq/Bvfl+pmnPrjbT950ua/T7df8bv
	Ujdk4iOXoGkZEXbCCmKugTN0HVkNWNBhBW/42Fq2kbM3XFjIBl8WMjX+60a4P4d91br/ETmog4b
	vjg/ExQ9murK09eNn6Qnkn5GnejTGncQuR+M3gpQhc46m8BYhRChBljFerHaSiDxGrUGdguTuQA
	aHLWpZ4U65B4X9dCk9T2iC9/kGz2dUbiYZLLwrJOfVifmefB4fTyXSMDOCoszvCU8U+Pp295g5y
	pgewbmuKvRFi/Yicd6gNvKENGHVEYT1FYiPDvFyZgkph7EijYnXkSXtcQzdQ/ICpq0KVoDwWGOg
	4F5DQQF6dtvK4TeMdIt6VlLNkHELSx4jaugdGs+OIdBdbhn0H1ys0ClqZ/VkSpqOuPdODjdJaDj
	lKbVgKED2nQOY=
X-Received: by 2002:a05:600c:b99:b0:480:1e40:3d2 with SMTP id 5b1f17b1804b1-482db49a4a6mr185536155e9.29.1770062662900;
        Mon, 02 Feb 2026 12:04:22 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd3953esm120842955e9.4.2026.02.02.12.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:04:22 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v5 2/4] net: phy: realtek: add RTL8224 pair order support
Date: Mon,  2 Feb 2026 21:04:09 +0100
Message-ID: <20260202200411.373161-2-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202200411.373161-1-dam.dejean@gmail.com>
References: <20260202200411.373161-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256000-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C6EFD0E82
X-Rspamd-Action: no action

The RTL8224 has a register to configure a pair swap (from ABCD order to
DCBA) providing PCB designers more flexbility when wiring the chip. The
swap parameter has to be set correctly for each of the 4 ports before
the chip can detect a link.

After a reset, this register is (unfortunately) left in a random state,
thus it has to be initialized. On most of the devices the bootloader
does it once for all and we can rely on the value set, on some other it
is not and the kernel has to do it.

The MDI pair swap can be set in the device tree using the property
enet-phy-lane-order. The property is set to 0 to keep the default order
(ABCD), or 1 to reverse the pairs (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/Kconfig        |  1 +
 drivers/net/phy/realtek/realtek_main.c | 55 ++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index 75565fbdbf6d..85e928a0d3dc 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -171,6 +171,8 @@
 
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
+#define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -1820,6 +1822,57 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return rtl8224_cable_test_report(phydev, finished);
 }
 
+static int rtl8224_mdi_config_order(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 port_offset = phydev->mdio.addr & 3;
+	u32 order = 0;
+	int ret, val;
+
+	ret = of_property_read_u32(np, "enet-phy-lane-order", &order);
+
+	/* Do nothing in case the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (order & ~1)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_PAIR_SWAP);
+	if (val < 0) {
+		ret = val;
+		goto exit;
+	}
+
+	if (order)
+		val |= (1 << port_offset);
+	else
+		val &= ~(1 << port_offset);
+
+	ret = __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				      RTL8224_VND1_MDI_PAIR_SWAP, val);
+exit:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
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
@@ -2392,6 +2445,8 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
 		.flags		= PHY_POLL_CABLE_TEST,
+		.probe		= rtl8224_probe,
+		.config_init	= rtl8224_config_init,
 		.get_features	= rtl822x_c45_get_features,
 		.config_aneg	= rtl822x_c45_config_aneg,
 		.read_status	= rtl822x_c45_read_status,
-- 
2.47.3


