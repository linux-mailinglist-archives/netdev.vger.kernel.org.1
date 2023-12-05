Return-Path: <netdev+bounces-53865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD0805042
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B921F21499
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAE810A2F;
	Tue,  5 Dec 2023 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAUDwXA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EEFA;
	Tue,  5 Dec 2023 02:36:05 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so33422001fa.1;
        Tue, 05 Dec 2023 02:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772564; x=1702377364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4aEtBuTh0UC9CrFmY+V3IFx8owY/yY3vgzi9PmzSa0=;
        b=AAUDwXA5Vn5b2YgoYr1vhdX4/ruUKqMQ9z99m1JaH+80iapLCXGjmE89Qq3zq1DfBt
         IoCOHzlVwVuPsaHqoxhoBf+bz0TONTg74PcgEAsd8zOvL15YNu4Cl+LW/3ddlX8ak2Mp
         wLsBekjU6wqp5sNn8RHoJxvXn8rcMFcdl2SoE1DBljG1gZQGNkS5YzIAUaNcg+exw+Cb
         8lzEkkdCM8fYoM8Te9n4ZrQxwEuNi5amQ0amQluYfm1iOiUiPn+qy6J2OwvWPsiqlzE4
         SYcYQNRRs2HDffs28uaphVQJMMjqNogoAvU2TO+fMgwixb89X8ZMO32q7tLARz960XOK
         /M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772564; x=1702377364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4aEtBuTh0UC9CrFmY+V3IFx8owY/yY3vgzi9PmzSa0=;
        b=s8DkiuDCHP4yiUwai+qSMy5tjK6gYiM5aOTSb8DMZBHJW8L+my0UkPcLFcwTmmRaNO
         Lk7iYTKF86gF6QBI6tKkd0L2bT3rmR7KlO0AWc5E4xTgMVXelKcmyw+kYpXH85bQ2LL+
         qcHiqIMl+eTtLFu79dowmbts1NiECbPUGkEFB+R4Ju2G+xKP3wYGD9YotWrWRndpsziw
         3JWRJpqPoyIfWwhqSkz3z/0qpVvXCDKGmESrKrGIO37zQECn+mUww/X8cw1CVjxXBoDd
         GgmI6sNOYcO+x1UvnkSwJ6u8WSjU9bdpGXXolJLRB4Ks0jrGGbHse7F/Jw/yBQpVGou2
         SR8A==
X-Gm-Message-State: AOJu0YwvnjCyn46xnE8WbTF81oFLDNF0u6udXvoIVY7IYoa68VFOaznJ
	R+4a/w17WaWeJrf0NNDGatE=
X-Google-Smtp-Source: AGHT+IFZKr4mte8mEyBn5TUCZn71LfadvBGTszjO/emPzCHL8qpyDtiAvPGC3HEYzGHAFjI4CXkWeA==
X-Received: by 2002:a2e:b24d:0:b0:2c0:17bc:124e with SMTP id n13-20020a2eb24d000000b002c017bc124emr2510299ljm.38.1701772563975;
        Tue, 05 Dec 2023 02:36:03 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h20-20020a2e5314000000b002c9bb53ee68sm849784ljb.136.2023.12.05.02.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:03 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/16] net: pcs: xpcs: Drop sentinel entry from 2500basex ifaces list
Date: Tue,  5 Dec 2023 13:35:22 +0300
Message-ID: <20231205103559.9605-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are currently two methods (xpcs_find_compat() and
xpcs_get_interfaces()) defined in the driver which loop over the available
interfaces. All of them rely on the xpcs_compat.num_interfaces field value
to get the number of interfaces. That field is initialized with the
ARRAY_SIZE(xpcs_*_interfaces) macro function call. Thus the interface
arrays are supposed to be filled with actual interface IDs and there is no
need in the dummy terminating ID placed at the end of the arrays. Let's
drop the redundant PHY_INTERFACE_MODE_MAX entry from the
xpcs_2500basex_interfaces list and the redundant
PHY_INTERFACE_MODE_MAX-based conditional statement from the
xpcs_get_interfaces() method then.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 31f0beba638a..dc7c374da495 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -130,7 +130,6 @@ static const phy_interface_t xpcs_1000basex_interfaces[] = {
 
 static const phy_interface_t xpcs_2500basex_interfaces[] = {
 	PHY_INTERFACE_MODE_2500BASEX,
-	PHY_INTERFACE_MODE_MAX,
 };
 
 enum {
@@ -636,8 +635,7 @@ void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		const struct xpcs_compat *compat = &xpcs->id->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
-			if (compat->interface[j] < PHY_INTERFACE_MODE_MAX)
-				__set_bit(compat->interface[j], interfaces);
+			__set_bit(compat->interface[j], interfaces);
 	}
 }
 EXPORT_SYMBOL_GPL(xpcs_get_interfaces);
-- 
2.42.1


