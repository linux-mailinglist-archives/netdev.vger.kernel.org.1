Return-Path: <netdev+bounces-251956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFtcKy/3cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:56:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CD59894
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5261F7A3127
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E5B48C3F0;
	Wed, 21 Jan 2026 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIVrbQlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF647A0D5
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008528; cv=none; b=iqwDIc8p4tRNsnNVAPLuXrnBax/FLZIPKm2sK4RAzTnvIDX5LXnCaT2aRqyHd2mdIW4x4qlsZceZjG86xC0zVSA4/FhTuJVv0mhm2TVyLWnPBo6d61IbYY8PKnWLQvqPyH7xEx4WSYibWFN62wjOfECwLsp3dSn1SnPbLRPbGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008528; c=relaxed/simple;
	bh=GTDYEFiega8YxWihJVfzhrRVHZNr2+ykLR1wXxa9TVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5fNbLRVHjB9zIE1kdtwCwkv0y9gcjcpEd2QrEq0VE4B1s7/284/Y1WtvZxarUhI5hqqqbSILHngtr0hN2T3p+QzBF44cxpQ7buH1Xv1l9FIfp6ax2c5VnhPjUeV2nUm3F90BmLsmiDjYMMcQh4CB1prP3w6HPsqNVIMGVgJW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIVrbQlJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee07570deso48611445e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769008525; x=1769613325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W91/nThu/hrkiQ9f4tK/HK4NnadCCD9MyZ0A6Cw7s6o=;
        b=iIVrbQlJ8IRL4p92YCZExrCKxYZhahtuE+EvuDoA81fggK3To6zpphtJRvyOsdfm8t
         +TJQ5X42sYmiIuElcuyubG+NBL4TqrkEmOnqQeAOh5PEOCGau3XoDks55zFquBG8fDlv
         h+9xsofcdtb3Jk107JovolPGJnEgElNZjuCbnes0auBToB6vONv5c6o+RXOnqYY4w+PD
         +DqH0n3lBp4NkSbOJbed/VX3m0Aw230HkyvHvNUOPNNqsXpVtMI8xNUGvKCEfY9Rx0fD
         0DAreSwEDO+utU8hX93t/9PUBCGdkg3MmrgZIeqXjZIMGJVxyqFDRhqZa0pWURF1ScsO
         nzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769008525; x=1769613325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W91/nThu/hrkiQ9f4tK/HK4NnadCCD9MyZ0A6Cw7s6o=;
        b=J6SWjZuFDiC2i74bqa8PZd/h+j5UGVwkfn8G7QLXAtZgZ9YqCDjBBas6J58FDmtiy4
         prfDfYT8QaX03VGvhSgbe72qEskWt/MlDVGrAAPBWBKDq8VfDJDwvbIovSiedUBS03/x
         BWbELc1OmunHI7eizLMYHF50F/Dc8TOANST9vVW1uR1qFnCuGzyeGeNJ/KGhpo1+Mtdg
         lzWF/ssGAxihZhybuoRsrBvm1a9//kLAS+m56SLY5j+DkJG1EjHkNMY1g6urTnHBAr7S
         wDkLnkTan/ERWENc0sEjhDs7CcGPHGUol8pLSX+yCLvfcrYLNTGPXHEzj0SlAX5+KoTj
         d6Fg==
X-Gm-Message-State: AOJu0YwghrzxVnoRGQdsGBjsf+CLPaz5uyuL5oBBci81eI9Iku9G3HDR
	+yCYYrkcSLQZEj5z6eBpLbvFBhcBKZ4CNjGFpkg7W9tz+reoCvUCOF2C
X-Gm-Gg: AZuq6aJSb5FEDGj3SWCMV3lgf/PqhCcPD/Edm1X1FLl+6cVgzn52fWRtE9Abhk1+K9a
	n84rIe9mzuEuSJlojgcaOhX2qgYZEeLO12rW4UwhnlO9ssE0bPqbPCpESPDTN2UQ+diU1WHd7p4
	3lBgpVfnuqJkoYRXxz8TzedDz7PtWYRDHP19H7GI2C8MJ7Ohu7czCHwZiLbRR29ooirIZWmGXRc
	eGBmtzW/s+LDAOfI/UZNl4G/eub9We79gYmmnzCR0xzORD2XPcowffa8nDkhaHbvNqMOgiDYHhr
	3DJj6XXCuZjr/VXX6Ml1zSYKgjWyMjirsMdSDXnhjKLvl/s44VO4Dz2Hkwx5CO/zDSM28TEaOlo
	/u6bm7pcSiL3ByUtzQ+ag+3fYU70vUth5TGKcRSD05oyjmIPoLbD5aBtuEQt+iDCHBPqY8MXbvQ
	0CZkgIjvLPZKo=
X-Received: by 2002:a05:600c:608a:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-48025ccb812mr216647125e9.10.1769008524782;
        Wed, 21 Jan 2026 07:15:24 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435924ae6f1sm10534349f8f.33.2026.01.21.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:15:24 -0800 (PST)
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
Subject: [PATCH v2 4/4] net: phy: realtek: add RTL8224 polarity support
Date: Wed, 21 Jan 2026 16:15:06 +0100
Message-ID: <20260121151506.813783-4-dam.dejean@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-251956-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 554CD59894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8224 has a register to configure the polarity of every pair of
each port. It provides device designers more flexbility when wiring the
chip.

Unfortunately, the register is left in an unknown state after a reset.
Thus on devices where the bootloader don't initialize it, the driver has
to do it to detect and use a link.

The MDI polarity swap can be set in the device tree using the property
realtek,mdi-cfg-polarity. The u32 value is a bitfield where bit[0..3]
control the polarity of pairs A..D.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 39 +++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 85b0eea936e4..d2dc4f7a1971 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -164,6 +164,7 @@
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+#define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -1719,9 +1720,45 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 				       RTL8224_VND1_MDI_PAIR_SWAP, val);
 }
 
+static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 port_offset = phydev->mdio.addr & 3;
+	u32 polarity, val;
+	int ret;
+
+	ret = of_property_read_u32(np, "realtek,mdi-cfg-polarity", &polarity);
+
+	/* Do nothing if the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (!ret)
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
+	if (!ret)
+		return ret;
+
+	return rtl8224_mdi_config_polarity(phydev);
 }
 
 static int rtl8224_probe(struct phy_device *phydev)
-- 
2.47.3


