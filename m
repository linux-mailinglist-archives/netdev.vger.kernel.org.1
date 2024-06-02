Return-Path: <netdev+bounces-99988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D128D7641
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E78B1F225AC
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57144376;
	Sun,  2 Jun 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENHS5eeq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A13DBBF;
	Sun,  2 Jun 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339006; cv=none; b=KHGf/I+y4N6ApNhizIsOBHWCa8lyKVgY0h2J45DcTSU7Oupmj26iN5E9BEyRKA75qDQFKiTn037Ol3x2dp2nyJNTB2f2n5Ft6I/P1q+bdwLA3hjVbW3aDn+eLlXLrEPKf9Uv1D9y/ILfOR3BIl14ZwwvXPaaT4bFSlSD9BlEraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339006; c=relaxed/simple;
	bh=HKd+U5CDCJq1sAkohvaBdQJfgDvEMWTiR6NKfKP+qm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyxSu0PW/Ct5xESMJMCKvrPQEnoDlbVPxI3Lu7ak6UIKuSGhjXOTe5OUi8H6keLO3ue81xjr05GmnglSCOntmcz0TVjGTDR2bXm0GkxqCkSgQFaxjlv8F7cTopBD6t/xeeOwn3VmFTHTV5rpdi3iMnH39XS+9O+83X30Wv6YiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENHS5eeq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e96f29884dso41685761fa.0;
        Sun, 02 Jun 2024 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339003; x=1717943803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riZO9gpWg+72DwRvoZciAprxyAK6Sq4iImVOkfuj2k8=;
        b=ENHS5eeqRUfSiU6mf8dbCceEjj0nw830ECc82/FOy04M3eth+pWckL5RZNked3Zw1o
         lQoMqN1UxE4Ave26Xn/J7n0Gbvt+Zs8WBLoWh6TIN1lXUziD3xX61r+nCttZwRBLxv5B
         mJbOjJEiDtcWpy1z+b2/6hVo+hQtSKZFsZy4+skIBhIAMBHTERI23yuycCWxvYVyJNbg
         T+x4KTZ7OLq1l9bIjvUNOUKmYPkgNJC5WO3ijtcssSiUsLGyyazqWuqDXfew2IX5Xnxl
         /g14xHF/qSFWAbbS2d0bV068MHhDENlOCRVYauok5DbtS+X48nsVM5FgqGmREhU7FASr
         6x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339003; x=1717943803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riZO9gpWg+72DwRvoZciAprxyAK6Sq4iImVOkfuj2k8=;
        b=V4M0mkjME1ofucxwkmVtNLalWW+hn873xDs5zOv5EkNQvy0vGsBdoYIBrQHGyKuMLV
         W6BtYpUuZV2E/w8d5y7JpGFb7kgF/0InTxRkkG7xGUrzUCC0UvhD6jDI1hyPNIUogWp8
         +Y59EN8NSWZ8CsW2kX6s5728wAtUTMM93dH6Oh2Zx2/Ta6k2ixxuXGMLDJdQ3xwwwzww
         a/HAv3Q3lja5ysy5Ah3rkecyltY0nswVsNNQ/dNBOn7pjhKe3/B1bBV/RP01JG2XSZtO
         OpNALzdkraUYty98n3dLhBtJIiMzWgCAlBTUALY9UEGGGmhZfZNNsYnNe5uy9TRT8o4g
         3C9w==
X-Forwarded-Encrypted: i=1; AJvYcCVmWC58JEEvpnWCDf332cJ9tvBFokPx00QSKeuxGG9D7/sVspsfQ5FfM609W1umx0q3qI13kacUiqSpPxlPxQbGhEF5BWT7ZXecEHQKmuErhZDGSq1lG+r0NK3AubJ0ItN42OlujT9HesWv1c6l4yDjcdLIxyWA1DmCDmYdVWljew==
X-Gm-Message-State: AOJu0YwTBGYX0/ELY50pDXJbfA5g6bjmrEhJzxsuHnYgkv4S7z3cNdme
	yCPD6nHchNbIY9upkXErkGNCjNw9iM6Sjp3rTJ/vBRaSXosWYllS
X-Google-Smtp-Source: AGHT+IG/nqO6KddNLN4fpmEQxGgs5n8RHQTH8IjsI3YbjSKU5j1KmcjSR/VTeLrOiH7DXm32Jlu6Mw==
X-Received: by 2002:a2e:9141:0:b0:2e5:1dae:1789 with SMTP id 38308e7fff4ca-2ea9512f6d0mr48251181fa.22.1717339002935;
        Sun, 02 Jun 2024 07:36:42 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cefc4fsm9282471fa.118.2024.06.02.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:36:42 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 01/10] net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
Date: Sun,  2 Jun 2024 17:36:15 +0300
Message-ID: <20240602143636.5839-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602143636.5839-1-fancer.lancer@gmail.com>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the next commits will alter the DW XPCS driver to support setting a
custom device ID for the particular MDIO-device detected on the platform.
The generic DW XPCS ID can be used as a custom ID as well in case if the
DW XPCS-device was erroneously synthesized with no or some undefined ID.
In addition to that having all supported DW XPCS device IDs defined in a
single place will improve the code maintainability and readability.

Note while at it rename the macros to being shorter and looking alike to
the already defined NXP XPCS ID macro.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Alter the commit log so one would refer to the DW XPCS driver change and
  would describe the change clearer. (@Russell)
- s/sinle/single (@Vladimir)
---
 drivers/net/pcs/pcs-xpcs.c   | 8 ++++----
 drivers/net/pcs/pcs-xpcs.h   | 3 ---
 include/linux/pcs/pcs-xpcs.h | 2 ++
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 31525fe9c32e..99adbf15ab36 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1343,16 +1343,16 @@ static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
 
 static const struct xpcs_id xpcs_id_list[] = {
 	{
-		.id = SYNOPSYS_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.id = DW_XPCS_ID,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = synopsys_xpcs_compat,
 	}, {
 		.id = NXP_SJA1105_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = nxp_sja1105_xpcs_compat,
 	}, {
 		.id = NXP_SJA1110_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = nxp_sja1110_xpcs_compat,
 	},
 };
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 96c36b32ca99..369e9196f45a 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -6,9 +6,6 @@
  * Author: Jose Abreu <Jose.Abreu@synopsys.com>
  */
 
-#define SYNOPSYS_XPCS_ID		0x7996ced0
-#define SYNOPSYS_XPCS_MASK		0xffffffff
-
 /* Vendor regs access */
 #define DW_VENDOR			BIT(15)
 
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index da3a6c30f6d2..8dfe90295f12 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -12,6 +12,8 @@
 
 #define NXP_SJA1105_XPCS_ID		0x00000010
 #define NXP_SJA1110_XPCS_ID		0x00000020
+#define DW_XPCS_ID			0x7996ced0
+#define DW_XPCS_ID_MASK			0xffffffff
 
 /* AN mode */
 #define DW_AN_C73			1
-- 
2.43.0


