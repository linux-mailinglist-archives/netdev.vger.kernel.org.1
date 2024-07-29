Return-Path: <netdev+bounces-113815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66441940018
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9781C1C216D5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24E718FDB1;
	Mon, 29 Jul 2024 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHuA5atU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC218FC7D;
	Mon, 29 Jul 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287199; cv=none; b=LcVDgZc6VS7jW5Bsdn+N47RbEderWF5cuI/voqbmwkkaWTZZZ2zE2axUt+0r8b/dKlyyWXMbJTmSwm119fD3lVg8QRPbi6gYTLbTJ3V5ZFY3KP9covc7rFeY2flv1LDs5xbd7rCM4c9XpfwLYybsbMyh6sWpTiELzJ35o3XD9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287199; c=relaxed/simple;
	bh=9PzYzNxa34bGuET3h/1c2aOVDCaFjUvYNXFXCiCVELc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZqTcz6kcwJoiL6u1A8Ka8jb3VJm4hzkre1f1T5n3Ya5s8EY7eMp0SbiL3nvIPv8/jT1vK4vGq4pERgAGp6Bhp+fBJTK/FyilTuhbQR2Y9Ucf8/bXls2WQCSzjxH60DdhYU7DzdSfxHbDq5OhCO2XtpSxE59nb+uZANIiMycTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHuA5atU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f040733086so44323881fa.1;
        Mon, 29 Jul 2024 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287195; x=1722891995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPeiyI/flCr2rh5RvoIItQyovqvEHvH1KX+rrJF8n4c=;
        b=gHuA5atU2RdxmepT52vjk11v5m/FnoZfWF/5AqGLMoMghPH4B8VvZyzgRN3XzyZ4lM
         aFmQjJDZqVwf41j9+bt0/EJ634bCbWR18k3bOs2BDhRd8/WF44N5LjAU/xmh2ZZKWYWq
         5gANh900xM9gFPEpNRykoZlk06vsl7WYfD4VfpZxcu8XCs9v/Ph/PMHm8BPr/I0bjzBp
         arzBh5ZXWFU0gOKFRoc0hWDGC9aOb4aHeAmSM4wq6WDYC+yrCC9raleqtxFJjVYgbgLS
         DkWLQXTedswJ8fazAj4zkCwMPWykG0BS0C1JWdy29HU+sryQBmgqGQljBuLj489/nXrp
         B76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287195; x=1722891995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPeiyI/flCr2rh5RvoIItQyovqvEHvH1KX+rrJF8n4c=;
        b=nmbXq2ZAALrO4DwhlWU4JWu5kTogOJyBF9dfMupo+CeGvl2qFriCVFmnjz3BYuHmID
         xwSR91U80dZ/JLgPetT6G9Q6Kbz+/vBJ+hf9VbVFtVwr6zhJTj9ROjNI47AZBDKE3zd3
         JQN9m61k952toKOI7oBMNmkukOoqnSv+6Hi3WAnv/xrBRnZ0MGEGabp2ZG+EJvo2GoK0
         HkgR527CUWPnpF8xhJArYdpiAfdtR3YmPhP/Z281SAwSoeo7cBQD4MD6cydOfWiELEeV
         cExGGS4a4pB1vHlkmZ1GSz8jFqY72DKF7b6o5zs9Inp3Xgnqh5/vGQzS2Ys3zduKYtGB
         qVSg==
X-Forwarded-Encrypted: i=1; AJvYcCWkZqjolvXGE8Veh+gR+wjhK+z+3bgw/Y0dXXo48uVnj0rl4ij53WGVZfUsOtF4i5yQbhcJZbEsaVM4hWc2i53jDJlwfwVVtuU2Tf2v
X-Gm-Message-State: AOJu0Yx0an9LvDmiJoRO95Man/JHrzz/fsjFZvikueoVJAntJGTuy5K8
	FV/cGO//4KLLOXSJaRrMTvFYGywbTKZmGgt61e3rTMJGl5LZzfH6eW2VdOhP
X-Google-Smtp-Source: AGHT+IFcpXJmr/d+qKnrqIFRjFAWS09gD1z7660ijyeesv5bZXAFRdJE+rExuA818wnek4vySn0LVQ==
X-Received: by 2002:ac2:5690:0:b0:530:aa09:b6bf with SMTP id 2adb3069b0e04-530aa09b7c6mr155042e87.24.1722287195228;
        Mon, 29 Jul 2024 14:06:35 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:34 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/9] net: dsa: vsc73xx: allow phy resetting
Date: Mon, 29 Jul 2024 23:06:13 +0200
Message-Id: <20240729210615.279952-8-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729210615.279952-1-paweldembicki@gmail.com>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, phy reset isn't a problem for vsc73xx switches.
'soft_reset' can be done normally.

This commit removes the reset blockade in the 'vsc73xx_phy_write'
function.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 9e88eda6f4dd..df36118644f2 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -618,17 +618,6 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	if (ret)
 		goto err;
 
-	/* It was found through tedious experiments that this router
-	 * chip really hates to have it's PHYs reset. They
-	 * never recover if that happens: autonegotiation stops
-	 * working after a reset. Just filter out this command.
-	 * (Resetting the whole chip is OK.)
-	 */
-	if (regnum == 0 && (val & BIT(15))) {
-		dev_info(vsc->dev, "reset PHY - disallowed\n");
-		return 0;
-	}
-
 	cmd = FIELD_PREP(VSC73XX_MII_CMD_PHY_ADDR, phy) |
 	      FIELD_PREP(VSC73XX_MII_CMD_PHY_REG, regnum) |
 	      FIELD_PREP(VSC73XX_MII_CMD_WRITE_DATA, val);
-- 
2.34.1


