Return-Path: <netdev+bounces-114682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE57943726
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4BA1F22A25
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF7D148FF3;
	Wed, 31 Jul 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTt4topG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B11BDCF;
	Wed, 31 Jul 2024 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458122; cv=none; b=kC/ufGjuxhLgEOZTh0G3+9Lmb6gJfTN9/sF1XSuWLdx6hgl3+QJl8nh6nW1GgobUfLKYorZHARMueHCxiYPcX0KHDkp03rphZrGZFtQtdkQf4/9Jb9NEWSJorWdUFaAa9S82DyE08U9/0Fmctk24RuIOwW9E9tr1maw2ErBo6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458122; c=relaxed/simple;
	bh=jok7MlvD5wU4KXrXisIX59O/MBAs98y/QQZLgHJmEnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ov8BR51i081xM1ZAYvCCtQFuNBYuw/zcvFa20bpowJQmrUi13HUclL7/XChozM1HdPYLE/wRvM0lXtD4eQRd+JiOAPGpeUys93/mSI6Xtj6u2AoRsDCVioksuvWiRmi75ujpeMePJwb1wM9HiA3RfCSj86Wb2vPPXiOFMLQegXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTt4topG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f040733086so72464701fa.1;
        Wed, 31 Jul 2024 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722458118; x=1723062918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkANAEvtL2efA/r8IKXSmSfAgGIjzQiXqD+mNKD7A84=;
        b=CTt4topGdOkIJ7D3IC5aMkFQ7bKKOYopOx8JsnAavA/3MtnOydRuchMkYn0a0pkU2d
         s4tJlxFEyeFcrm9RDxzeLORXiG4SLaiVfCVWvG7mioiVX2V8ZrJAIBpB9pfwILERyPib
         jUthPHMHxGcLNMaX647NKguShQ2G8cqYLTpALxtZg+ctWxh7BTigO/+0YeljeFauHNyW
         9sa1IGVwNEohh0akFv25Uet3gZW10zRZVNQNNflrsY3CQDnXHgOEpR8Gvxj2iROlzLUR
         SInXND6OhFj2qW5HXkpDLG9f0HMVQUyaXq7i92QPRO+S0F1qNujuUBZ13+eul9ybfACk
         vkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458118; x=1723062918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkANAEvtL2efA/r8IKXSmSfAgGIjzQiXqD+mNKD7A84=;
        b=SNSaL1t3cP2JuKxtQItNrsq2dF6lLFtFE622vtkP1S4DgTRa2X9TFnM4+vPJ59XLPx
         8kCYqga9mHAjpybBCWqQdQliOWwPiDHkPUTsunt+quoNoJ4hSUcP86/0rO9IyaH18M2Y
         vjo3ldlNE3Tp77XBHjvFLkSZCWRmMSsvPH9lYRl5An90e4cOcolPPo84iPtPRe4KFrKT
         oBFAgGCdnXvYsTowuFiMnPagwCMZSNRU2DUee34nEWNyitTC+DKXiyXApyJrv4x2WXR8
         zgFgzkQ2FIuMeaNpI1sd7pTLqqXpUtaglHOzGD6O5TBPsUjfofPqf7ebLZg4pYTDlub5
         DvRw==
X-Forwarded-Encrypted: i=1; AJvYcCWJLnX9sWkvFh3EWec2mtgEF50HNJVMi2w+VSUgPT7pR6U0xr5UL5dpIv5qYiJ9m9dkBmM1oUjKqja2EjWEv7ng/2adohFwvUFolHqS
X-Gm-Message-State: AOJu0YwaywTd+oE7/9H9KlBObndYZ/V+VLlYhIjsevxKci2zTwkp0t33
	tEbByWfx05XsgzWRhSQplPBAg08bPnPn1pnQEVMDjd81kDJ3SMeUvZmWRVDb
X-Google-Smtp-Source: AGHT+IE1NkbXLgghE9mwOtXPHJVPIPv36bV/LBBQ+eOYuDVeKCJBLSFM88WkBb2gTqarhXmUnII4/g==
X-Received: by 2002:a2e:9651:0:b0:2f0:2760:407c with SMTP id 38308e7fff4ca-2f1533ab4e8mr3118721fa.30.1722458117651;
        Wed, 31 Jul 2024 13:35:17 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d0773b5sm21099161fa.128.2024.07.31.13.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:35:17 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: vsc73xx: speed up MDIO bus to max allowed value
Date: Wed, 31 Jul 2024 22:34:55 +0200
Message-Id: <20240731203455.580262-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet, the VSC73xx family's maximum internal MDIO bus
speed is 20 MHz. It also allows disabling the preamble.

This commit sets the MDIO clock prescaler to the minimum value and
disables the preamble to speed up MDIO operations.

It doesn't affect the external bus because it's configured in a different
subblock.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
This patch came from net-next patch series[0].
It was rebased only.

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-7-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 07b704a1557e..1711e780e65b 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -40,6 +40,9 @@
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
+/* MII Block subblock */
+#define VSC73XX_BLOCK_MII_INTERNAL     0x0 /* Internal MDIO subblock */
+
 #define CPU_PORT	6 /* CPU port */
 
 /* MAC Block registers */
@@ -224,6 +227,11 @@
 #define VSC73XX_MII_STAT	0x0
 #define VSC73XX_MII_CMD		0x1
 #define VSC73XX_MII_DATA	0x2
+#define VSC73XX_MII_MPRES	0x3
+
+#define VSC73XX_MII_MPRES_NOPREAMBLE	BIT(6)
+#define VSC73XX_MII_MPRES_PRESCALEVAL	GENMASK(5, 0)
+#define VSC73XX_MII_PRESCALEVAL_MIN	3 /* min allowed mdio clock prescaler */
 
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
@@ -748,7 +756,7 @@ static int vsc73xx_configure_rgmii_port_delay(struct dsa_switch *ds)
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
-	int i, ret;
+	int i, ret, val;
 
 	dev_info(vsc->dev, "set up the switch\n");
 
@@ -821,6 +829,15 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	mdelay(50);
 
+	/* Disable preamble and use maximum allowed clock for the internal
+	 * mdio bus, used for communication with internal PHYs only.
+	 */
+	val = VSC73XX_MII_MPRES_NOPREAMBLE |
+	      FIELD_PREP(VSC73XX_MII_MPRES_PRESCALEVAL,
+			 VSC73XX_MII_PRESCALEVAL_MIN);
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+		      VSC73XX_MII_MPRES, val);
+
 	/* Release reset from the internal PHYs */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_PHY_RESET);
-- 
2.34.1


