Return-Path: <netdev+bounces-113811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A54940010
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55AEAB21EE6
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C605F18EFD3;
	Mon, 29 Jul 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjabzVIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF318E74C;
	Mon, 29 Jul 2024 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287192; cv=none; b=i86//tbFkgaNnCitga7/RlWUZ42tYZjVqdt65yoW4tPO8LbnRkpsHzu0WYo0fjMcxBiusm+VwEZD1Zg4hMpl1VwP7LUGwegg1VYeoBKfEhHJBc03NNHmV+2/mP8/STGj3ZiDCj8PoCR9cZp7P03HHaeVrLeY509EYKfbS/FblVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287192; c=relaxed/simple;
	bh=rV7wgd1a/2PaavX7mS0emaXW4OxAagpTYybH8nhE42k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQJuU7233px8yx2TowlGtv9WtRd+jmXBHj4V7m5Bn+oNbrFb9M7gLCa/bO6VfLNMgSknS31GJXH22z8zgKRmaMgb5Y3i48JtD0Pmteai8Q04+hRFA5jtUwnoBntRP9YF9/kL8ZoT8uhj0b8BwNZRskdrDKs6Id88i7YEOlrpAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjabzVIp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so61027721fa.0;
        Mon, 29 Jul 2024 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287189; x=1722891989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msePXB5IId9Qa+88Qq8POO8AenDgqkeQ4o+na08K7vI=;
        b=UjabzVIpciw4QxZvwrpfzNFp+S2J55b+Ct6Arg5WfQeRpCjRBpFILSLpI0HMR1RbdN
         NH9J//7YWa+nhbNGU2ZUbOTUgljsqK6AOQR7QGG2v0JGffrKYTxXbiMNm4/68nVxUhjM
         xlhtsKMb9U1eDTMDHa5xRwNc8ggJmwAK1amYGhUfrM+kmQP1/wOlqcuVol6BmgnVm/ye
         IQQkxykd6sWOOYmFKupw1gZB3+5II1O3H8P8yatTgnFj8xl05tCGgofdPN+vAq5Gy98n
         AHiEz3ma3BgJ8Fo/5m1FqPhz5sSQOB0AweMXjEBaL9QPyGIpemryGIkb0QQIIPH/xqta
         KHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287189; x=1722891989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msePXB5IId9Qa+88Qq8POO8AenDgqkeQ4o+na08K7vI=;
        b=HaQcQJ+vVnluE2ZBP5KM9880IXBBANS1pQEwraA5VMYYOlBGtx6uxYEOgxc4LaDQ/P
         uTg3Ka+VHiTV46V0bkQNAZ6dvVC2NIrbuQVlZGE2b5DujgKSrUv0906SK9NMvO/NMQFC
         XrQmgOwySAkDUwNkKFICXBHO3nRiGji32+bV18wKWHbs6GVrSK2OqV/r7jj/7/+NkV8l
         vX6htV+dSgxRNrful2nXkCu8FG1WQGtLe9fi/FN55//XAJSakBv3RZ+TtXJoSMTeQL/2
         cCPZUWzi6xmPQX4je21lie2Qs687GyofajEYw8wd4YDdCgH8Wyi3Qyl9Bx2x5TVkLZI6
         CZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCU3EfNPhppfZJC3Xj85JTYWoFMtXiqfWydvHGC4nb390L7z6YkCSZalJv2U98kNkTCgBEanu1kZFYkXzGdRdQvv7Cu/DQNQ6XiG/n78
X-Gm-Message-State: AOJu0Ywi3DQzWZFi3VwKo8JswX6pdXJiHgVwcwmClQnBWU9WpLv7oB4g
	6SfcotGy6rlNc7aM5rCua42ZT7UgTWcmhIomCemrcdGEig1IOoS/u2s3j10G
X-Google-Smtp-Source: AGHT+IFD0MP7XLLd0D/K413Z0t4gipnOtlinyJcis4U2FuKwct05dUajDQycjE8h3Yox0+44g2dahg==
X-Received: by 2002:ac2:4d12:0:b0:52c:e09c:b747 with SMTP id 2adb3069b0e04-5309b27a554mr5205801e87.27.1722287188597;
        Mon, 29 Jul 2024 14:06:28 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:28 -0700 (PDT)
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
	Linus Walleij <linus.walleij@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/9] net: dsa: vsc73xx: pass value in phy_write operation
Date: Mon, 29 Jul 2024 23:06:09 +0200
Message-Id: <20240729210615.279952-4-paweldembicki@gmail.com>
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

In the 'vsc73xx_phy_write' function, the register value is missing,
and the phy write operation always sends zeros.

This commit passes the value variable into the proper register.

Fixes: 975ae7c69d51 ("net: phy: vitesse: Add support for VSC73xx")

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 9bd186af8941..e5466396669d 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -574,7 +574,7 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 		return 0;
 	}
 
-	cmd = (phy << 21) | (regnum << 16);
+	cmd = (phy << 21) | (regnum << 16) | val;
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
-- 
2.34.1


