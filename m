Return-Path: <netdev+bounces-115242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC95945976
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4354E1C2183B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C51C230B;
	Fri,  2 Aug 2024 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9dSAZ7s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA53D6A;
	Fri,  2 Aug 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585868; cv=none; b=o2O0BiW5L+DsRWPtB5LoZ6U03/GRTXAKYZKOsxlSU/sAe9EnBJ2INYS8nI68e7DLJtpbs5Z+V4eBKiGSUezw7rTnv3E1OdJ6sBayweAfYkC5XvTpK+eRyuAVprTRjPhw2+kyXm4LpKDV3lpzOAsh48ySNB5fBnr7/EEV3siixIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585868; c=relaxed/simple;
	bh=HfCmiea5VQtPyVj4eppRfoaO3gEvxil4OBlgs5vTqnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7ZrY3/5GHxaygjnfh72Ayg/eP7vHcMmt935789yc3B7PPz7iuqIFTaFvkoy4jsGpL15Bz094rXphcgdrTyppHz/4lEzmllFSH5ecA+bcizgmnb0FoPX/Twzcvjv8kIfatOnT1vkHMZXwDgZUWyUlc/EDka/NqJGh0BWXbnTpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9dSAZ7s; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efba36802so12848267e87.2;
        Fri, 02 Aug 2024 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585864; x=1723190664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwqyuy00M/6AfVIaFz7rsZgtuFx4kCP90PKPfqs8w04=;
        b=B9dSAZ7ssN+onZVepNm7bnFhcEB9yn4USQOWIDgq/fx9+tmQLymUHgFd1cxlkTufaX
         q3EHruEPbtafbYuGOE6uQ4LIsPsNMOKRa3SGDY24T481aL/qXkiMX0rhc7E4TpresoYG
         JOfmGBnKKWTic0B12Nmp/RwGyqjo9qUj085kyd71FoUireL30j7eSGHjvfZm2VErXH6S
         hwRlOCW3euklYgXviYTHf3nkE1yPojk86V7IgEX1Ws+1XvlgolHjD0OlXLzpBsM+HkQ1
         MA3QCI8LhFJbMwI57j/T8j0F+x3cycdRcnugHipj5f+wrjV4ZhrAzB0mPAG/NBRYAfj6
         AkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585864; x=1723190664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kwqyuy00M/6AfVIaFz7rsZgtuFx4kCP90PKPfqs8w04=;
        b=fItWv3hsSF6oo/RFhYRxOIp1K/MTvoGb4vVc8gedEIXzRfxgNmPylpmCweQ4fgvj2m
         WiY/m/kKw244YEFFlpDsV99Heef6YYEw3ycp+tGCKWjeqswQDHNBWCGIDDRPZyUITbnW
         FJ3JDSMZpJ/UZr5EptFvKbI6WflGM064BehKW/omW3DVvrdwSis6pKUJqzsgz9pfQbz7
         UZUeyRTevRNyqhfqVPvaPGE42xvUGcK3Cl22hEKRJSJdyW/pQ0OrWgekpEE8RExdVDoj
         0UitTJQxy+F/MVs+xV5/t+uarUWkTjvz5uDVxNu4C4/RJRk5kSyJpZXHK9SW0qrToyYU
         J8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2HKi6ez2GrWc/egW+jLimvwJHLEYmAqmsZAxxV+NjCHIGz7OAbmdfa8zx1NXkWKG5pxH2l9zjCKbUAL6tJG6XHHQrtj1M15OHT5SN
X-Gm-Message-State: AOJu0YzHszFdN9dFKjgQl83Hte0nfJo0FaBaeX5xThBhJq/1T0AM9FnZ
	D4BizgJUMJ5mcJS4LM1W9ygXZLsJl4rd998sk/Lj5qNTw0cYrnn72FJj3ASm
X-Google-Smtp-Source: AGHT+IEu4sEEedH3oVR1l7bkR5CEJHjv2xndEOUPUG5cb8oblRZj4ZzN/yIqPh5GFYDoQ9DZIRLiBA==
X-Received: by 2002:a05:6512:2395:b0:530:adfe:8607 with SMTP id 2adb3069b0e04-530bb3a2bd1mr1971759e87.51.1722585864113;
        Fri, 02 Aug 2024 01:04:24 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e46sm163281e87.32.2024.08.02.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:04:23 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/6] net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
Date: Fri,  2 Aug 2024 10:03:58 +0200
Message-Id: <20240802080403.739509-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802080403.739509-1-paweldembicki@gmail.com>
References: <20240802080403.739509-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet description ("Port Mode Procedure" in 5.6.2),
the VSC73XX_MAC_CFG_WEXC_DIS bit is configured only for half duplex mode.

The WEXC_DIS bit is responsible for MAC behavior after an excessive
collision. Let's set it as described in the datasheet.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index d9d3e30fd47a..f548ed4cb23f 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -957,6 +957,11 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 
 	if (duplex == DUPLEX_FULL)
 		val |= VSC73XX_MAC_CFG_FDX;
+	else
+		/* In datasheet description ("Port Mode Procedure" in 5.6.2)
+		 * this bit is configured only for half duplex.
+		 */
+		val |= VSC73XX_MAC_CFG_WEXC_DIS;
 
 	/* This routine is described in the datasheet (below ARBDISC register
 	 * description)
@@ -967,7 +972,6 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 	get_random_bytes(&seed, 1);
 	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
 	val |= VSC73XX_MAC_CFG_SEED_LOAD;
-	val |= VSC73XX_MAC_CFG_WEXC_DIS;
 
 	/* Those bits are responsible for MTU only. Kernel takes care about MTU,
 	 * let's enable +8 bytes frame length unconditionally.
-- 
2.34.1


