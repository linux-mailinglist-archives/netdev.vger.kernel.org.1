Return-Path: <netdev+bounces-228910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B50EBD6142
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 22:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF67D4F2E27
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6330504A;
	Mon, 13 Oct 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdbYBBwp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB63043C1
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387387; cv=none; b=bnRs2ZDwbk/pDfh1A4OBXzRj6qwUd0TVRbSUExdzn18RcYrqN64BmFxTf1Tj3jeOxydU/Kk2+nnDI8qlPOGeZ3c4LCCjiFSO+uKCPqwNSqW/pUqOHBMlKs5JpapG3ZySIQQfGJfU+C50YkwnLmxgkzcLIMl8vG7vv8BEY5Yk83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387387; c=relaxed/simple;
	bh=eLohQjCZWvFJ1dFDfxYuim1jcusXUWycBqdILsbFuF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwsShZ5wJ/hKaRco4PzBWalXGVFvWVAIFydsrtptHBenN9z1JpJogxcOfq+KMupxSC2xYuMTknCvSZpzqa+YnXoqgLO63TZx1fcD3+0WoOeVBNB5b0S/WI1/tTJ/Iz3ITE9teer1+KyrWsQBuSUM+bzBeEW1WodnowMDs82rMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdbYBBwp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so9066603a12.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760387384; x=1760992184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPuQd72D+jBq1spvFLJjLA1j9tiBdh3mywiWzRwOOm8=;
        b=gdbYBBwpXYBRzjZ9dvZcD2ntl7g3loGgQb2fNyoG0cYf4wLQh9eF4YTUDF4oUEEeMq
         7jpL9zi7DoKG+wEtE0CVsILa6fesI01XhN96ojJ8c61dCHTONBWaaMXn5yOd2alU/o79
         UI/36k6XPnSLqtQGqcuIEZWNLVqiXeaGycGbAlb5e32Pp/EHyn9yBQRIIAzLOLvrT9FY
         uytw2Nogpon9iX6jcoWR/w+Di5WNIzYCfW0eV/+6kvGJLrvV0ONYDnwois/9nSh4iciN
         X34Nh6kUwjpqfkIDutBw0drLyyps0Ryw+QHj8RquAcrv9EC2AG6LpQBg/Rw/aqFwvEbe
         1juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387384; x=1760992184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPuQd72D+jBq1spvFLJjLA1j9tiBdh3mywiWzRwOOm8=;
        b=E2d9blLdNRyzhUEW16Nyz1bF7pe9n9Kw+C9VW1M8tKg2kBg3sLEP56Q+tOFgU1jXzf
         xMetwfW901xuCuEZsR8oDuz6WWcJ5mLDQN0/JPE2wbKFLsm7FWo4D2t73b+dSlqfhCdg
         wS4WrOY5ODwpYpwK2jGzEPNyriHifmNlizfKOTXAXhQMLavLCL3LrQhlV76jgw8XhLGP
         ThC/px98p9ePp3lgIeg2WjCKax9y8mNSbfzxjhERh54/hVlxynaHqiYGjEw8uNgteQDB
         ZTq9Lh5w/PMyVT3RmEUeGhs6ihIBRcFWhmJDW1zGKE3FkwH4rH3+0yKWrBZXK1aALhga
         04XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjm+pNhACIX1MMlV/0XCfY+nJr4DM4keN4CpNDeXCVQFYhaytwZwNCKhEDDWriBzNoZmrr4X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvP+IzVEST8Eg0qGBLwUZYqMlwQKxdkTOqz99oKXb8rIYtVC4
	87flVREbG9f9drWUBbedoV72yX39UaFEyk5ySljp+Lk9FEhuPTSptSNM
X-Gm-Gg: ASbGncuXfk9kyFIYbUTtza6w16dw7u3j2b83OZehWfBLqV+W7AuTnSrhoskEkQn8jD5
	tpmxdR4qbP0RQqW1KTaV49Z8pYi7KkLd/3MepHlGC+oc0/RZMNW60IyLhtckm5fmIHxkXjnwB4z
	yX7B6uqQI1rGb6MFs29X8li2SHJMAlkNJLUG5vpxdti/PuucxO6QnXrpPiv1X0J6OcB+O1j+oDK
	AB2s0KxYe/pWF1EKIBeQMImh3Bo9B7BRW+PSG128M0mbutKMdyyeHQ2T/ArjiHKiBgaEramSdJY
	6eGquVg0CrE9cnRAXBZay55l7rUn9+qErDuKvVCpkG6ntDwuOO9fmzvnviZ2Y+UL82b/Y+UkBPt
	se+xhbQChj/vW++zle6G+SuuUrlkxXjnrHoWYm9cusM/RSCoI9vsPwLPEcurY/A==
X-Google-Smtp-Source: AGHT+IEPo05LdXDAeNyvkUd6ss/IS5PV+fJh9gShC3M3KXvAoo6cCl57CUp0l4gRoV9f/pEAA4s8Ig==
X-Received: by 2002:a05:6402:518a:b0:634:5722:cc3f with SMTP id 4fb4d7f45d1cf-639d5b912d2mr22232211a12.16.1760387383537;
        Mon, 13 Oct 2025 13:29:43 -0700 (PDT)
Received: from localhost.localdomain.pl ([89.151.31.85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c321341sm9541150a12.38.2025.10.13.13.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:29:43 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH net-next 2/2] net: phy: broadcom: support "brcm,master-mode" DT property
Date: Mon, 13 Oct 2025 22:29:44 +0200
Message-ID: <20251013202944.14575-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013202944.14575-1-zajec5@gmail.com>
References: <20251013202944.14575-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Specifying master mode as required is now possible using DT property
which is a much nicer way. It allows clean per-device hardware
description instead of runtime detection in specific Ethernet drivers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/net/phy/broadcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 3459a0e9d8b9..d66b79ea1c38 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -110,11 +110,13 @@ static int bcm54xx_config_clock_delay(struct phy_device *phydev)
 
 static int bcm54210e_config_init(struct phy_device *phydev)
 {
+	struct device_node *np = phydev->mdio.dev.of_node;
 	int val;
 
 	bcm54xx_config_clock_delay(phydev);
 
-	if (phydev->dev_flags & PHY_BRCM_EN_MASTER_MODE) {
+	if (of_property_read_bool(np, "brcm,master-mode") ||
+	    phydev->dev_flags & PHY_BRCM_EN_MASTER_MODE) {
 		val = phy_read(phydev, MII_CTRL1000);
 		val |= CTL1000_AS_MASTER | CTL1000_ENABLE_MASTER;
 		phy_write(phydev, MII_CTRL1000, val);
-- 
2.51.0


