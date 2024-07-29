Return-Path: <netdev+bounces-113809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FD94000C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A04A281A22
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9718D4C3;
	Mon, 29 Jul 2024 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8qdc9ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53518C348;
	Mon, 29 Jul 2024 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287189; cv=none; b=FnZqwbW2i7+CProPt1Xkv2EUWoYHw9e3KXx2tR43pAauqujxZnydrsVEmI04zi88qG83JsamCfVBidS8ZGbXc07zJ5bQj+jpll0ybTqjcTdEJKT9rXdVy59REcDLD6ejuI46C50xawIPGRGcwsvKjdIyeLGpbk9S4hgfvjU5kUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287189; c=relaxed/simple;
	bh=oYuRkMKuync56Kp92Gq+AU+N5WxnYHTAYbqdC13jN7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dg6//MqcAoJKuE09aAY5jGwaL7Y2a/EJM5DlG3jeZnDg7N50ZYk7SY8Le8TdBn2uXmUAXtsUqNlaeAxCyHUI7ymImvOSO8TNSmrHIVaQtF7Z0jEXUzA3J6S4jlzrxhKtTIN798QXFmqmMDfPx/28bqRQCsTArUbz91CgUuXXTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8qdc9ay; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efd530a4eso6079387e87.0;
        Mon, 29 Jul 2024 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287185; x=1722891985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr16QoD8C9lyhgmRp/qXwtErgjnoS+MtiXzjP2XrR8w=;
        b=l8qdc9ayIar+lT2jMxwo8YKIA8E++l44krc0oVagw+t+SrQ4Yecq4XBdHZIUCuL/lg
         wL26N4KxVev7CiK+KbWsj7a7lVqP/UkH1Z44i0zj7y0MHcqPOaGdvwGCAxjmT42qwQXo
         ADJ8JhIZ59JpTi8hKUK0AjmGChHiy69/wohBYEOtIWaqBkSEjnG2JkHKKy+7GzCYvm60
         Zju3x4TTx2SzL4WKrutgBuOEre1SiZ+sFEoz/g4EvYRY6d1xRxDmqCTg1hsz9eO7yiSZ
         mZ5GukkjvIOJTtVvBzkK8i3zQZz4b/LJ6W2eOf9+3F5e+En6KUjUrffLdD96MhVmA4+H
         hFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287185; x=1722891985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xr16QoD8C9lyhgmRp/qXwtErgjnoS+MtiXzjP2XrR8w=;
        b=uwqPLf4NlHp6qykeO2Zr72E5nmciTEHUTv42OUm8My/UEzOoaoiebeAJnsyarX10sP
         4uvQwU/6+n4D9Fz9W/XcCORAxqLis313D4ekXzy7c1oJIuhzZD2o+mXk2apBN+j6HoSc
         h31vsUFZ3VvJq0qDjTSaCaJ+shF589UhVe/aHapaN9OJFKuNrnWgILVLfrIQuHgedura
         SnmM80FAg3BMIdNUtSeH8Nd5qmwbwhG3LBu+3DUWpvhg8dKaSDMu821OHAs1Yhu42DgL
         rmg+RIUzPzrRCKXRUoBn8R+6z3wW4LEh+R/9n9tU7X9RUkLPRkNTttkv6rYSKb0RWAis
         n9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV43s/77/47z38Qn4VAKICtpIXFjTCZiead4PUjE7VoHPO5SbQao1O0RPpILyT+jy13kMvKO9SRhDiHT2pFsWE3sH4fNDEqa7ffGJLN
X-Gm-Message-State: AOJu0YwAuVxEPu3n/3v7mGXd5DwlFGBWgnfnKqjl9ZWU5jxDr8L16OGP
	qIlEFs+cAXa9jqE7O65Uty7nnCyxex9JkRRe6VOU+uMA3I1Ua+J1sW0CsWPS
X-Google-Smtp-Source: AGHT+IG1Zx4MTH4Am/c6seUJgOkMB3p87wXkvqow/FXEw850L/NrlH9jEJel+xTyRoCFqATzV7gWBg==
X-Received: by 2002:a05:6512:31c1:b0:52e:9df2:7de0 with SMTP id 2adb3069b0e04-5309b2cabd2mr6915925e87.40.1722287185285;
        Mon, 29 Jul 2024 14:06:25 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:24 -0700 (PDT)
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
Subject: [PATCH net-next 1/9] net: dsa: vsc73xx: fix phylink capabilities
Date: Mon, 29 Jul 2024 23:06:07 +0200
Message-Id: <20240729210615.279952-2-paweldembicki@gmail.com>
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

According datasheet, VSC73XX family switches supports symmetric and
asymmetric pause and 1000BASE in FD only.

This patch fix it.

Fixes: a026809c261b ("net: dsa: vsc73xx: add phylink capabilities")

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 07b704a1557e..43aeb578d608 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1491,7 +1491,8 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
 	}
 
-	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
+	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
+				   MAC_10 | MAC_100 | MAC_1000FD;
 }
 
 static int
-- 
2.34.1


