Return-Path: <netdev+bounces-148327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E831C9E11FF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74957B2182B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932082E64A;
	Tue,  3 Dec 2024 03:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbIfDgGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5AA1C32;
	Tue,  3 Dec 2024 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197604; cv=none; b=SEBJYu/3R6g40/Ma5QhD57Fb5tFoFOvKCChSPW3Bah7uZLCpScQVMffhcq632EyDlDDJI4pcwNcfJP2PvBXqrv7IbMljtMY6SaJLAIiRNbiCkgLH9RLrMSwkTyZHJUusoafdRlXrUAILeWFkW2k/P/jSj2z3uki2X192+ghVL4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197604; c=relaxed/simple;
	bh=JMaPpDma1j8GDoEcKZqm8XMBNzO2RLuRVmO7u2MKZ+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OV1kmQNVnzwigcKf6gVa5ZSAr8Hibj5wXdBzswK33AV11AQz7QzunmYASweddkgPSOOUXlQ3jMnhtrljCcrEr37ncFK13jTz7x/SC7QF5ou4gfLGE/NT7Lv9PW4uAvAWfKHX5b9hxMoIWqXE/Qa4IuwEOXWhZFnOha2A5sjfo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbIfDgGo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2155db1c9bdso2933025ad.2;
        Mon, 02 Dec 2024 19:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733197602; x=1733802402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfWK2bC6fLogIRAZMauXMedmSz4HNdUM6Uq34dszc/I=;
        b=NbIfDgGo820CmwYu6r3keC6AIBmf+l7Hi9fYdgjelweTGtuPVqDhU5/IJ38vuHjIRO
         8npVhyKroaFvFpU8xvLMRhsxGL5VQXZaZbSB9bh/a6HtDOrWpWJZFiovr6/tnpjueH1h
         +nsTK8O/p6e8kL85psiNuS8PzOqn6qdYZeRamavyNxybwh0ZJRXtbOsmi8JboStbBod1
         ClgQZg+STRbU2ix0sNC5neFMTz2bYrE/tRHYE7CvCrBdtySK4LHpU+JaKSHg/bMTu11G
         mjB3o1dhbw3Brw83GADnItZ6U55Z0U5efYAqgLDQ329RD2/cuSTFJV/VR1stMjIXuU4g
         eOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733197602; x=1733802402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfWK2bC6fLogIRAZMauXMedmSz4HNdUM6Uq34dszc/I=;
        b=HESUid3u4rrPWvoBpvcijuVeb1BvOaOvv1+iUoXvBY1EMIqE4oNgXu5e6L4CIFNXMS
         aGOOhY0NVeYmXrKfOueMqOT3QbtAdxXXQ8ASjWKSN0lbbT4VOYD8Pkhv/oZsFYW/T+FH
         dJUaAm9lg39WkUuyntnywasR3nB4DDhWbswbLCBum5KoTDgdDvKqiPpNWauUKSOHVCKJ
         /Js4kzZ2s+QNE5WH0h/GhSxs8Q3W7sYdaXKo5FpePxtYgEPitcyUuZisSZeeU8cA5Cib
         R/fdnf7PISZ+plqDwAfMKtijir8o7b8s3sR3UMH30a0PFnqQVJF9oSAA5FvsXxmWa9tb
         E20Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtDpOvPkncQf1IZPWym2CNUTk1AixcIlzEjvmfPVxuiwUD8n9awcZ0x1EB8PNhVZKt3vchp8c1@vger.kernel.org, AJvYcCWVCuq4Yvt5pVPc0IjGhco6UZdvsiwuZXeb/1NrCUB7vQdQHTBraW6K+335ekolJR4aAYG+NbZzLEwHWgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3JQfXx0VabGmLz5dQ4ouYEPo6r8pPoV/HkyH6gglVldrHodM
	SpnjnGtAWH5oNwdxsgjTxLvrN4WmXek9LhuL0vt4zYCNH34TJFKD
X-Gm-Gg: ASbGncuLAn0isOm7jZVlFXjTWyzc5vY0xAfzeI9/5Xw4zeFQLvwa8u11QUQhNpd0XoY
	Aa3kxJb/8qJXVN1ZvE/7X2du3kukRQX9S2EGedrSGkQtEZSq+IxbsORFXEXfP9MIauHl1WNEMiK
	kXevYcRbQFMez4bkSRjO5fCvYM1G0rzKDPLcLnMmNVqNUNY/EwYE6NrCk9ZdSDvvuP3W+YAU4a0
	W0SKuoOYfsXbFL7yZ6qtIRkRCqswXOSt9aem5zNaDJPhFEU7iWq4mddpxr0
X-Google-Smtp-Source: AGHT+IFnxiRismHDHbgNLG0vm+LncBllSFxAqHjsrDutitda283dWbt8kqKO9q0nL1+rK2ARNb8kqg==
X-Received: by 2002:a17:903:190:b0:215:431f:268b with SMTP id d9443c01a7336-215bfaba4d7mr3998915ad.1.1733197602288;
        Mon, 02 Dec 2024 19:46:42 -0800 (PST)
Received: from nas-server.i.2e4.me ([156.251.176.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c31a0sm85260315ad.249.2024.12.02.19.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:46:41 -0800 (PST)
From: Zhiyuan Wan <kmlinuxm@gmail.com>
To: andrew@lunn.ch
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy.liu@realtek.com,
	Zhiyuan Wan <kmlinuxm@gmail.com>,
	Yuki Lee <febrieac@outlook.com>
Subject: [PATCH v2 1/2] net: phy: realtek: disable broadcast address feature of rtl8211f
Date: Tue,  3 Dec 2024 11:46:35 +0800
Message-Id: <20241203034635.2060272-1-kmlinuxm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bc8c7c6a-5d5f-4f7c-a1e2-e10a6a82d50e@lunn.ch>
References: <bc8c7c6a-5d5f-4f7c-a1e2-e10a6a82d50e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This feature is enabled defaultly after a reset of this transceiver.
When this feature is enabled, the phy not only responds to the
configuration PHY address by pin states on board, but also responds
to address 0, the optional broadcast address of the MDIO bus.

But some MDIO device like mt7530 switch chip (integrated in mt7621
SoC), also use address 0 to configure a specific port, when use
mt7530 and rtl8211f together, it usually causes address conflict,
leads to the port of RTL8211FS stops working.

This patch disables broadcast address feature of rtl8211f when
phy_addr is not 0. Solved address conflict with other devices
on MDIO bus.

Reviewed-by: Yuki Lee <febrieac@outlook.com>
Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
---
 drivers/net/phy/realtek.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f3..9824718af 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -31,6 +31,7 @@
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_INSR				0x1d
+#define RTL8211F_PHYAD0_EN			BIT(13)
 
 #define RTL8211F_LEDCR				0x10
 #define RTL8211F_LEDCR_MODE			BIT(15)
@@ -377,12 +378,18 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	struct device *dev = &phydev->mdio.dev;
 	u16 val_txdly, val_rxdly;
 	int ret;
+	u16 phyad0_disable = 0;
 
+	if (phydev->mdio.addr != 0) {
+		phyad0_disable = RTL8211F_PHYAD0_EN;
+		dev_dbg(dev, "disabling MDIO address 0 for this phy");
+	}
 	ret = phy_modify_paged_changed(phydev, 0xa43, RTL8211F_PHYCR1,
-				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
+				       RTL8211F_ALDPS_PLL_OFF  | RTL8211F_ALDPS_ENABLE |
+				       RTL8211F_ALDPS_XTAL_OFF | phyad0_disable,
 				       priv->phycr1);
 	if (ret < 0) {
-		dev_err(dev, "aldps mode  configuration failed: %pe\n",
+		dev_err(dev, "mode configuration failed: %pe\n",
 			ERR_PTR(ret));
 		return ret;
 	}
-- 
2.30.2


