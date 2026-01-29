Return-Path: <netdev+bounces-254688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDV0NIwze2lJCQIAu9opvQ
	(envelope-from <netdev+bounces-254688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:16:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3BAE778
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E171300A320
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F80340A4D;
	Thu, 29 Jan 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn1LsHnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C34327C0F
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681786; cv=none; b=eXgxWJ+ENQXIBQhbXBIfP4yk3lezIoftab7j3Lu4bjiy5UinuOWb6gR8q6IcxxnwTRW5s/MHKRPm3wo5dRXnhvFI9JlutXlBDCJEXpk2ScsnFpBiqpi8e2ULsXIoCtEOCEBsVQYuFc+HMB/i1uf3kN3Mqi+0VWkdZBJJemsc8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681786; c=relaxed/simple;
	bh=J/SoU3MkP2MY74o7Q2lAtkpaITboiBABKZxNYr/6I5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWF8eyaQwvqKuoJzn338fUFfijRfBeB3hBfErCUKQulxEhxie7emjVZLoYvKcdC9xfy0p9+vkX3ic1WqdD1Rg0LBV7wHPSHlOH9BEBnMXvOSZxAQ7HD3jXIXR4pK5wl9uvXvO2+jX+1E5UpcA0EuO0TIvyfJPmvmljWGP3mJHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn1LsHnT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso7618885e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769681783; x=1770286583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scwnG4+Nck1/cLGODsLX+wXP9q98UaUDMSFVIL+kckU=;
        b=Fn1LsHnTZZuhO9s7j0iy8OLAOxLuTxc4NaiAm8OWogllw+3qIdTsjIrrLkumJZbYQP
         uc10GKVQX042Q1nfopJ6X9cSZcBnejfFHwB8RIMfhpoasVq/AuhiHbyT7313Dm7d+mCl
         yKh/OaIlCahvOQXlhSXCqlqBfnQ0s7nioVwho/6zDIScwqqLx784TtCgbsmJZRBwjUeL
         0o0oXosFizz4ZI/ArNkSyG+c1PSBQLdX5LL4SsjsO9RZbj1S6lbbWw5F4cx9V1+WHg53
         7nbZWohnXrE2Eic2UAozRFm8dcYA6xG69ScnwGNrquj4kzIHCNNCFq/Zuh8i8GOWZlqA
         ajig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681783; x=1770286583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scwnG4+Nck1/cLGODsLX+wXP9q98UaUDMSFVIL+kckU=;
        b=T9WhFl6yIM5lPL3X9EjZFcBGoPm/wCA2qy0TBnpl6ru9VIO0IrwvIFJCvHp3RdGp50
         XqJcf6oPe3H3wUEDqriSiPSXD4Rcp81uqHKNQhMzjtn+Y/Ii/RqVZKqvln469iIfu+Xk
         lJzKP+l6CmNmm8YNBx5vP3XYbiKhap6jfc5sPv5y6SbCTlWFEZkodwf13fsoZHaR4JbK
         jvkTrfCb2nVRRM6oiEyE57e6qefKabMIqEvC69l4h6pxEbwmy8K5rU2w7J7gYTRNAWxl
         EKNHtZ10gpEoOOD/z8K2V3sNOs6Us/XfIpf5qTaRnjKocTKC53LxBkLmKas/UJWDDs8Z
         yJFg==
X-Gm-Message-State: AOJu0YyUK1Nx7ZGdtgJPK4DLEqIynwFdDvYKJjtsc1/0XMslVAXGH/Jc
	PTqsllRCNrJ+PwhXg2uF8EdPi4ccrGYxOU4PyYpm85TD3DlNAnOoOsPU
X-Gm-Gg: AZuq6aKsHCCVUszLoye/ALHrAq4f/A/Nv5OH4BT9Sw6skTGsuhIgFgi7cxXVBx8tvL2
	5Ca00VofXfW22sq2pnrOL9LFJCaU9DozzOg8uwkrUl/PHx+BdqZsrkTQ+mmQ8Gy0/ynxHOOdKOQ
	BaoHjLJLp3Nt7PkPkACz/jF65SgbH2MvjaD4CsFybwW9ZZAcKtknUOSvQW8DbKaiXF7jtznDeSH
	jyVIJd4gh+NEocp2fpEYMxP4+urI+xx1aHRlii2e+S+lnjHRHJEc+WoVKuzQl9+LG0hRcjjToR3
	UUMg67CNnMqSJ8NbeUdsbJfaR5GiGZMa4HFRd2qoCk1WywQIkUCFfNB5+PL8fJKgIj5CHbcT3Zn
	pmR9Cy8SQiF8HiyMO83Vpg1cKyNjh6SLxCC1+nOEhIeFEHS9OgsmvQ4uAtAAfk+vdUk37EPeuuy
	r55Z4peEDQuik=
X-Received: by 2002:a05:600c:8b84:b0:47e:e78a:c832 with SMTP id 5b1f17b1804b1-48069c82494mr90663755e9.37.1769681783205;
        Thu, 29 Jan 2026 02:16:23 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132303fsm13413662f8f.36.2026.01.29.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:16:22 -0800 (PST)
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
Subject: [PATCH v4 4/4] net: phy: realtek: add RTL8224 polarity support
Date: Thu, 29 Jan 2026 11:16:06 +0100
Message-ID: <20260129101606.33972-4-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129101606.33972-1-dam.dejean@gmail.com>
References: <20260129101606.33972-1-dam.dejean@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-254688-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A9F3BAE778
X-Rspamd-Action: no action

The RTL8224 has a register to configure the polarity of every pair of
each port. It provides device designers more flexbility when wiring the
chip.

Unfortunately, the register is left in an unknown state after a reset.
Thus on devices where the bootloader don't initialize it, the driver has
to do it to detect and use a link.

The MDI polarity swap can be set in the device tree using the property
enet-phy-lane-polarity. The u32 value is a bitfield where bit[0..3]
control the polarity of pairs A..D.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 39 +++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 79c2762b610e..8013ba453f05 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -172,6 +172,7 @@
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+#define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -1855,9 +1856,45 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 				       RTL8224_VND1_MDI_PAIR_SWAP, val);
 }
 
+static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 port_offset = phydev->mdio.addr & 3;
+	u32 polarity = 0;
+	int ret, val;
+
+	ret = of_property_read_u32(np, "enet-phy-lane-polarity", &polarity);
+
+	/* Do nothing if the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (polarity & ~0xf)
+		return -EINVAL;
+
+	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
+				     RTL8224_VND1_MDI_POLARITY_SWAP);
+	if (val < 0)
+		return val;
+
+	val &= ~(0xf << port_offset);
+	val |= polarity << port_offset;
+	return __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
+				       RTL8224_VND1_MDI_POLARITY_SWAP, val);
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


