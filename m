Return-Path: <netdev+bounces-148356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B99E13D7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DE3282BD4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454D1885B4;
	Tue,  3 Dec 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLB2VWqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC002500A8;
	Tue,  3 Dec 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210354; cv=none; b=tmwfpe1ivTxsX564Ar8BA9GNLC3OKWo6GU2Q6bldX4b3+gv6y9OI3xQONWXOuuW0UzvaOGIImHUGj4jKGJlnv9DlrKahW8moeIZ5sxL7MMC/lJGVUl/zG+wMROPqr7q9eqekNdTCOEf+g3eh6JmTf77CQz5UIxgI5ZBh6cG3nZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210354; c=relaxed/simple;
	bh=K1Vu1L0HLzL1ggJymF4GIWCvoKHTnpnZvrRz8i5oRc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ld3doFV0fAYmS5jh/CSysD/Mul0OsPC0cx3y7sbhyQVr650y57P3Qi1LeojdSYXFxosIguoqc9yFG5g07tlS++tmDa59XwRwsShfF7d/RN6pLgL8bCSenXbB59Jbv2sg6UT0wOCRfi5fcOR8+CJ/zOwuE5M0RPDbpauS23yAdWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLB2VWqs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea85fa4f45so408146a12.2;
        Mon, 02 Dec 2024 23:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733210352; x=1733815152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt0eqAzlepSF0XS40uHuceUpxcC/1vIW2KGLShCrnRY=;
        b=aLB2VWqspA8VDWAkrh5g3lfE2fpN0xOnEDKVUHXbaitV3cpBqh0o8gte06KDdf2WwY
         cV4690ZqOeayL5XahrJ/T46aQGca1P8IC3+QVzsaS0eU3pA1NddTZ0jDCJEsyWM82xcv
         qqeca2GNHkMKOKAAywXD0z6QzvH6SbIyIbs/GIhrV+Ue6G7e3RNT0gz08yq2cQgXGibn
         9t84iHmoelZFXbDYy+EHWWtvCu4bbIIae7PEVZvtIaYhNfxy+UNtN0r4YCCpp9ZvxuMA
         DLbgaNSEAOlXzHCcDLAooC4pQMFXCNAXtN2XnVekkxDyr3im5OQlD+f8icPpDhiMAxk2
         0QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733210352; x=1733815152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt0eqAzlepSF0XS40uHuceUpxcC/1vIW2KGLShCrnRY=;
        b=lHKsizfPPhFOVgXbUt0bY+tf8FpicXWcahyjZFWYAettDGWxEnNaQfDTcBGzuqBJ10
         mH1tKpp3HGl6hl+RqhcAPqRPJybafoIQtkev6dpuwHFHUXbzaa/+FHqMtKUo4qF42Y+D
         TeRny86maNVpxFHyGzRweuO5sLFDfo6M+lvhUI8uNU46w5fHrWFGWDtaBl0Tx1FnEMEX
         sgyGcwlUlJMBP5njD2RZ7/t0SVZOEoXtYjyaO48X1dTRs6aBs955+VoCwyBU24kiXICk
         X64+SMqn4YVTOK+bI1Cxp/984s1+4QWAMqhu/Wmk/hrxIPFCvwm664cC4b/EBCJLlfzB
         t9EA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jAnWyorRJRoZx3C4UxwNUuLYMMCzC/GsAMczCjbABtSSLvfi5K9UUrmHZRQNxhEX6cm4AwBpsvpajqQ=@vger.kernel.org, AJvYcCW8QFH+FQXDnJCQvBEyib7ilQV6hp+QO6Yq+QDDxYMYt/vLIPC2aUHmvCSnT4DdpakPqYPZxzJM@vger.kernel.org
X-Gm-Message-State: AOJu0YwrogFspzd4tx0zJggWJJEvrqun4q+GU/HxWpMK6PkAuult3Byx
	hbyOlQNskEqzleC8u+JNAIGY/n5LgsTy7Y6LCvdIHzlU92qNI7B2
X-Gm-Gg: ASbGnctV9M4Qj3e6grfdaAWhUpehwG/5UGB7pmry7vJBScHzyZgHV9QuvmVox0uhSCy
	EDUIryNfQj/COfqR+LhAFxagz45enVdKcxpDdlEYu54oW/Im2e3mfUjUkoZiDgwvUta2ImzM8FQ
	UdjWQuEVMK5VqYpJXADd6tT66oiyjxkhRJfMMAKm0HZE9HH4fc5pzliubsL69Q2fDyJrne3ywmk
	9nMzPa8t/9ou8y383IK3cfHrObiCr/7CCpGDIcOApWgNKtvopLuCnv6v809
X-Google-Smtp-Source: AGHT+IFiawVIjfTUCmCmFuedXi3MMPJDaws4aM1CWRor1IlvHiH98I1sypOj08nVpTsD3oOX0gAZIw==
X-Received: by 2002:a05:6a20:840d:b0:1cf:3be6:9f89 with SMTP id adf61e73a8af0-1e165337df6mr1364463637.0.1733210352461;
        Mon, 02 Dec 2024 23:19:12 -0800 (PST)
Received: from nas-server.i.2e4.me ([156.251.176.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541847925sm9692329b3a.176.2024.12.02.23.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:19:12 -0800 (PST)
From: Zhiyuan Wan <kmlinuxm@gmail.com>
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy.liu@realtek.com,
	Zhiyuan Wan <kmlinuxm@gmail.com>,
	Yuki Lee <febrieac@outlook.com>
Subject: [PATCH net-next 1/2] net: phy: realtek: disable broadcast address feature of rtl8211f
Date: Tue,  3 Dec 2024 15:18:53 +0800
Message-Id: <20241203071853.2067014-1-kmlinuxm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7a322deb-e20e-4b32-9fef-d4a48bf0c128@gmail.com>
References: <7a322deb-e20e-4b32-9fef-d4a48bf0c128@gmail.com>
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

This patch disables broadcast address feature of rtl8211f, and
returns -ENODEV if using broadcast address (0) as phy address.

Reviewed-by: Yuki Lee <febrieac@outlook.com>
Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
---
 drivers/net/phy/realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f65d7f1f3..8a38b02ad 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -31,6 +31,7 @@
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_INSR				0x1d
+#define RTL8211F_PHYAD0_EN			BIT(13)
 
 #define RTL8211F_LEDCR				0x10
 #define RTL8211F_LEDCR_MODE			BIT(15)
@@ -139,6 +140,17 @@ static int rtl821x_probe(struct phy_device *phydev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get phy clock\n");
 
+	dev_dbg(dev, "disabling MDIO address 0 for this phy");
+	ret = phy_modify_paged_changed(phydev, 0xa43, RTL8211F_PHYCR1,
+				       RTL8211F_PHYAD0_EN, 0);
+	if (ret < 0) {
+		dev_err(dev, "disabling MDIO address 0 failed: %pe\n",
+			ERR_PTR(ret));
+	}
+	/* Don't allow using broadcast address as PHY address */
+	if (phydev->mdio.addr == 0)
+		return -ENODEV;
+
 	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
 	if (ret < 0)
 		return ret;
-- 
2.30.2


