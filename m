Return-Path: <netdev+bounces-115243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC652945978
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2421C22618
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27CB1C2337;
	Fri,  2 Aug 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtTv58HM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B881C2300;
	Fri,  2 Aug 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585869; cv=none; b=qSc7mIJJ9uNh6wD11LQtUXogf/M8eHEnYG+9ZNUu+0Yg98CAjghUyCtG7/n5JPSF0VgeP4C1WOqSAPD8iK5e7+CUsH1d7VPIY9uiPZb2ggbHN4vn5+x0OW23aNGCMtgkcYpn/yUYEpQj/ib8Sb6SWSnmvf3r1eZZArAaZh7u8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585869; c=relaxed/simple;
	bh=JoBbq3BZ+NlqcwQhzFxbIuwiZrCdVsKQA6exGRSjtos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1nMgtSHBCf/h3jmv3bD7c7oAa7GpY1cijgZIL/MGf2RUOnctdXtizM2H1kFBICChxe0fQqzSW3PsSe99pFSOUU9Htn8trshW6yFIMEfhg/vkE6p8ZQYdaJ7McmphMwpA0ozKlJlx7K/B1SPurBelIX+KJU88apRSlhe7Sp0tFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtTv58HM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ed9b802ceso9524462e87.3;
        Fri, 02 Aug 2024 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585866; x=1723190666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RwOmOINr7qpWrPib+z3oWqi79SCVjZOwhew2DDDrz0=;
        b=AtTv58HM94JLcpleLED3o6rZpVJ9kEzocoiopuWG5UI9wGTJqoLGzTiyv4pXZbBQP/
         J889kiCQW3yZ11HwC4s8sLnwj5R8qfs5m/WZnfnOydPXcDoEgsq6m3utVQCo+C0+CIlj
         3yidMGzJQSZByY3dsJwaaJbNSfT/xh2lrJ4iNucGVqEqnRUhkPfaS97sL7nq8BdzTlGC
         EQyqG8i0mtAzsA5hBRHPfbirBUTuuw0r7AM/LoZiU+d0cwa7MNjlUlzIVNlElwZn9eIC
         HR6qNE5QG4Ky/wvIEM1e+y2u0ufSIfe0NM9BTDnJFxKKLmYeQES3orRjiK5+mAVQiJzk
         kuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585866; x=1723190666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RwOmOINr7qpWrPib+z3oWqi79SCVjZOwhew2DDDrz0=;
        b=T3eCbpKe73S92M3g1mNqZytXG8dmBa4SK65rmOZW/YA8LrTfF0nXmicQ3B+KSFKMNR
         3IdU/fm9gg0mxjLVNU+W3AqGx0cWnSSxwZKlLUyIGQFp3Pbo8xUEQ6MMG5bkq3rAbTK7
         uRGt9UwhhtxxnNC7Fy7snSMa9kgVBbHpI5wxafXYXRSBt3RzNmPAPv2G6zzTOLVYKrmb
         M/7oi2d+/F/qnjbnIAMRQLsTM9r4z/iGrpIsZTXa09GK2uLIg7EpW17PyH9dOH3GqrEQ
         qEoMflwuTCHDU7mBAMoC/mnq4fJ21oft563kMA2g1DS7HK7kpE/MbrGvhuLWBFIu15Wk
         2mPg==
X-Forwarded-Encrypted: i=1; AJvYcCUIi7xk5jTcmaLHPoREIg8mnmZBr3kRMCRpIP8Os3dZHlCq0FfYEH5lFw8AT+NSIWHVbZNtsdx6W+xBv1CBKtpgFmnGEz64KfhoXp0f
X-Gm-Message-State: AOJu0Yx4oG8PbOmgirZlsHN2B9zWnBQ76VkHJar1853ymcWXa8DB4FXB
	Ql4NYlomKJPVeuOrsHhUj6C+QWIDs4Hhra9gDIxvr+LZsppTa4EZBjzCLfsK
X-Google-Smtp-Source: AGHT+IGo8i/IpXEQkuC+OU1bFgM+stx858C6kxb2d/DFT4WnYEjDTmmcc+iIn+WYwD0Ol1egH31KRQ==
X-Received: by 2002:a05:6512:280d:b0:52c:dba6:b4c8 with SMTP id 2adb3069b0e04-530bb36e7f4mr1937950e87.13.1722585865630;
        Fri, 02 Aug 2024 01:04:25 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e46sm163281e87.32.2024.08.02.01.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:04:25 -0700 (PDT)
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
Subject: [PATCH net 2/6] net: dsa: vsc73xx: pass value in phy_write operation
Date: Fri,  2 Aug 2024 10:03:59 +0200
Message-Id: <20240802080403.739509-3-paweldembicki@gmail.com>
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

In the 'vsc73xx_phy_write' function, the register value is missing,
and the phy write operation always sends zeros.

This commit passes the value variable into the proper register.

Fixes: 975ae7c69d51 ("net: phy: vitesse: Add support for VSC73xx")
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index f548ed4cb23f..4b300c293dec 100644
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


