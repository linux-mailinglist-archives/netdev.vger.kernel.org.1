Return-Path: <netdev+bounces-115245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE49694597C
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83EC81F237C8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72C1C3F14;
	Fri,  2 Aug 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxCXEaQP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5C15CD62;
	Fri,  2 Aug 2024 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585874; cv=none; b=opZuah+Eksd8e1v1uJs8xV/rlZRQ8VNrEtmeN+9jQeAx42te3A1iKtJXmrTGuMqy5iwi/lbmjOlP9BculnTSCPsglel6ELpq3DShKSTQFeas3VTen0UvWJPEcdZBELV/RPgcenxeSpZvqUUKmGqkZD127j3iBPgfhEIGgLKowv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585874; c=relaxed/simple;
	bh=kQpO28XQ1oHp5hSZdzSi+mxKIJZewyLqfIXOsWCo2+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eb9HdzNdfKWjcOiftIGcZTP+6oEvjMjFMhrfZ9z3z48ajAeTtbMmnRSBy0YFSOxPBxTkuoGGUGDxmlWlj7zHFxLRdo5IXgiG3tkwkGu2f8Iv/PzILT5cNTOIoFBKRoAdue2F3jQ5zrZwiJGP07WJSG+eQGzxB7k9Q+z1qnGOROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxCXEaQP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52fc4388a64so13018499e87.1;
        Fri, 02 Aug 2024 01:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585870; x=1723190670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL5HLjJEHfQbcmXqkCj2bdZPkRLBrkGKwcNyE2fJ3tc=;
        b=mxCXEaQP4TntHYtS7TdbYl3ChSa3ltz2kEjCfXpoK9V1eo1SBGK3/M23Y7xjb3/njo
         EnUVIwLLc13lHUC1eJ28qyd1x0UyUeRT3LgEd1rkvcFv47BlUHDCKeUvn/t3N5gLntZa
         hHjZ7Z3tB2C5SjjIi7s3uMAZjfsIX/p+SsD2yfXg2eJ+bPxvP0pvd2WsqkZtPSFvqACw
         ujswaLFcwf+hm4J1hvuQ8Bfwz8IZyyZwRKrAd++DlfUh1mfw4wjjNPbG22hfmx0VEu8j
         GGRmoce7afUiUHXFShlDiOloYwbptDie2rVn4Azjd5BcvvKPQbsn62oWmgf50rLL1DbC
         GCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585870; x=1723190670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL5HLjJEHfQbcmXqkCj2bdZPkRLBrkGKwcNyE2fJ3tc=;
        b=nwBK1wWRX/Van9U+RyFCDYxV6Xtd3jhKp4NBWqNH7AfH5MiyBkPWz5c2GYr4XX3baq
         tsGi15YL6Isjkzf+yCd6uXAmrBWeXGiuS9vubDyUGDZ5KyziPjEiuLQ0YPy8n2RuBgO/
         oCx3Yq9OIB1eJOlnlrZ6Au7iOQSpfHS4QCh+/AaX813WDTtvfhbg25xOcL1QsydYkrH2
         Y9UUyahskvc6pB/2c2NG/pRSMhoT24Le0mqVGkadf37BTFDGMnIk8p7Pd4rfJex84wP5
         tEY8CcZpcqOvqx5w48RJSxfwHN0t8IC0AH6k5v0S4MphKiVNmOlBWg6nyeeF59yAFFQB
         nDyg==
X-Forwarded-Encrypted: i=1; AJvYcCUzDoQcBpe+BMzvNLA59QoOdnD5M6z4iWc3SbOhg3rC5KYcPofd+734/fnE0uUJb7lHi968NQvQnUMbH1UINdv/CsvGiQ04BudwGZN5
X-Gm-Message-State: AOJu0YzF94/zSlW+RDkmk2Xer/URat36sJnXNfEEjS4eImKZFrjdIJiH
	bd7+9fre1ey5o717NdbAxmQlnJVFCwxGV5aLbyQiEbDM1xD+SZQHDBUtRAeC
X-Google-Smtp-Source: AGHT+IE/rli6tNS809M3Hbzlv3d9SqCW9jd4XgAxdwT9HzYtHzwblrkLJbwpWooTywKsi8h652XlHA==
X-Received: by 2002:a05:6512:308c:b0:52e:fdeb:9381 with SMTP id 2adb3069b0e04-530bb39b806mr1708470e87.43.1722585870088;
        Fri, 02 Aug 2024 01:04:30 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e46sm163281e87.32.2024.08.02.01.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:04:29 -0700 (PDT)
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
Subject: [PATCH net 5/6] net: dsa: vsc73xx: allow phy resetting
Date: Fri,  2 Aug 2024 10:04:02 +0200
Message-Id: <20240802080403.739509-6-paweldembicki@gmail.com>
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

Now, phy reset isn't a problem for vsc73xx switches.
'soft_reset' can be done normally.

This commit removes the reset blockade in the 'vsc73xx_phy_write'
function.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 42b4f312c418..5f63c56db905 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -614,17 +614,6 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	if (ret)
 		return ret;
 
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


