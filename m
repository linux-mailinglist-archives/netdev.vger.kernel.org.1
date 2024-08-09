Return-Path: <netdev+bounces-117284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC2894D773
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B948B1F23A87
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C91684B4;
	Fri,  9 Aug 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z24/S14l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F15160883;
	Fri,  9 Aug 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232309; cv=none; b=KkobS9LZJZ/23fcHW2gtmSd+u7XggffSl9U7kvLY2zeSQP3V0DvhaaFoZ17108UukYrUDjG8gSaZXxdG0hG4BlQpo0ThHwnlUXCbSgLUBACYQyaFMm/HJ86mk+6wRbgwzTdK0O3Mf60iYxMuS0Mf8CnwKdGhjVlPIqFaE6MXipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232309; c=relaxed/simple;
	bh=WSMIz8ePO8Mg0qWeewYQB+Bm2eSDnkwAHXVk5lb0b1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abswAEW0+1MMQkRjiefJ7YSVmPdTjI+VBUlzB6OKULOKaUlSj78UZ43yNdTK7NbLmOBnC4Gynq+PooCmL2wFErArIzDWRo59m/TcO1Xi4cTLFFa115p8T9dF9+0BWKY8+QKJ4o3y26PJAosiUJ+HLZv/Tjtf+UIkOgMmek8shdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z24/S14l; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso32851251fa.1;
        Fri, 09 Aug 2024 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723232305; x=1723837105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQQOtv5+SwUJsnRDNKwr5ME9pKfFz7OtKr2B3mxcU2c=;
        b=Z24/S14l2EJVbAoMOsuG5pbajrbRiXX+OvIUe7eTzZ/zifkB1yPkyx9pGUK67CCERV
         VMPYD0bBjXULSzHEXxVlGduOctW7tiBS5QFkoVxZ6QfZyGk09YvFSLYxb3UvY03/ni91
         GFXiMZXhvRYLTBWLXUBWi641ZV71zGEllCE3IYdNVqyGAYa79l8GcTp7v06q0EA27PmS
         vLigmEOlI+jUKbAoOTunn8tKMgPFJgRw1DlDv/U0mm3E2IWf6zUSrKD0BJyQPGVP2cPm
         G1hlreBrbgj7rTi6stF73htGciE2J42sj62sCXd5LbcINBtAgXju9uJqHM0REdXbVGnO
         I7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232305; x=1723837105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQQOtv5+SwUJsnRDNKwr5ME9pKfFz7OtKr2B3mxcU2c=;
        b=bvhdipGtedilV1FCX5peC5JH+R6/XLtjVin4mbiRCAzXJtgbtt3kQ1/E0bQM38IaR7
         K9u6bhoeJtFKzESuyZrxGEJtn95kgH/M6K17ZcfPBZaDzyywBgEU/o6EhrpqjQuIheB6
         lw2lQ8zPV55zkN6keS4WKcnjcrhBA9wkgc1kcJs9jedYL7u7GJ1zyu9lIageN3DxSsrm
         AHr/SMHoNw3AXmAIKKieV7g66pU+8rPUWRUOwpx4xAcfMVcFmzgfjY526sjCcXMBEW6E
         EBTdPy7mbQxHUv8g1XfngnPW+UVWaRGH3mhsX27+aF7HruQztPgVhVyL8Kyzr1KcOQxk
         yzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjbEvWc7Pw4aJylvPxQPXry9V8BHqNRVsvDl/ld04JH9d5GdjYF3c5wfpUWei6xvIaj6yS8v3GCyNBS8Acpc6mISvQ3AXOT7X366UI
X-Gm-Message-State: AOJu0Yz0Jj2Ek6fIh6hGknxWa8/Cd4g8AQ0U95BgJhaAngtiiHvJbPhG
	PLnNTVxUYT5NpX4vjF+LLRqeWeHgTJVYVWH74piIhb76IqQPgfH4RIFsgnoC
X-Google-Smtp-Source: AGHT+IHA2MeC2Vwulta89/mxT4t6l/gtG901wsBGSBxpF/JbbsG1jriKpEohhTEIBiHEPi7Ccw3Uzw==
X-Received: by 2002:a05:651c:19a5:b0:2f0:29e4:dc52 with SMTP id 38308e7fff4ca-2f1a6d26849mr18914421fa.27.1723232305171;
        Fri, 09 Aug 2024 12:38:25 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:8a4a:2fa4:7fd1:3010])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f291df4987sm451311fa.50.2024.08.09.12.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:38:24 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/5] net: dsa: vsc73xx: pass value in phy_write operation
Date: Fri,  9 Aug 2024 21:38:03 +0200
Message-Id: <20240809193807.2221897-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809193807.2221897-1-paweldembicki@gmail.com>
References: <20240809193807.2221897-1-paweldembicki@gmail.com>
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

Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - resend only
v2:
  - Fixed 'Fixes' and added 'Reviewed-by' to commit message

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


