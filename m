Return-Path: <netdev+bounces-117286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B239C94D777
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6E52820ED
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2B16C440;
	Fri,  9 Aug 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0D00T90"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DF15A876;
	Fri,  9 Aug 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232312; cv=none; b=JadENE6t6eZLfEPHWMREV4w/Q4lagiTFBN1UWSFFlVV5aX8s4/RA0H8zs4NsdV2U80JAfSDBRkqI8xXERRbtE63zJgTYuDIYhKjpmSpW1XeePTNaU/clycfaWNkT3Vpt467jU/b930aGBDnD8OO8IE+h0nyCeaF/S30fFf1/qZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232312; c=relaxed/simple;
	bh=hGiIHFCuDlCJorymIuZvjwbZr8IRQttMj5OJQ1BJn5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOr3nk56YqJ5tI5I4oukukUJ75Vd6sJt8Zq5IL2r5mb2LP/edACwmaOcnIa+Ajntru6kBF+AdEJW7KrqtnxYZ441KqEeVP+n9E05N2y9dQtwqsJeIGd2sQKPastuH1lP6fWMIGgEaWyuiaBpT0PZSoCSBboiOdclqPG2iEXAx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0D00T90; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso26121621fa.1;
        Fri, 09 Aug 2024 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723232309; x=1723837109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5XnvSJGfWoNnd9xB3nkKhARJnXMCYFlCktgU13i1x4=;
        b=d0D00T90VOrAMdAMRMepbhyTLRzL6oCfcxDHp4eEybK6BuLbfVXTfZ5oYUhD/IhlHt
         0UREOMqclcMdE2nC/2p69ChijhI0pdkqGFwGrGpg5BFS2Q5c2RMZqTOH+NYtFbXdIGbP
         4a6wP+k9YZO/Li8ggWYQx9j1r02gDc+7qCJk9V6JV0x0x7FYfKKqOtE76AmCVNXrhglg
         3XntiPQwRw0HG3oln2DEwcBTwvZpuApVkvZUT5bDRFFWk+Z0+pUstTtNWhzN+rJbv9u0
         RaNzD0S9QoND9ah1J3vehUw3mE87gw5OGvQ3CKeCtmdkfH52Ndm+Vbp8PrAIgAr9sqjO
         QY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232309; x=1723837109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5XnvSJGfWoNnd9xB3nkKhARJnXMCYFlCktgU13i1x4=;
        b=Qh68esdnLbO6g5Rghno9vNcfafiCWQ05gQ3d1vrMn8wW+eqcowXdUqGTmze1VvAs0g
         yFAlo/vEcw1ChHKpXVCkdAJ7a2kWNi7pqFtIy2kQJGIBYZHmlKl2J8Z+RPkWkxZGG+Gx
         bvwMXVh5tiDi8mg8E+2d/76wtrlLhxEZsZlHtSIgZtaisQWO+YHx8casCaZnVG8W3C9L
         mFgcMyqOPTbt8yk1gcHaqq1oqdDZFrn91/BHMUJLsa8f6xDhZy9Hd8KoAa1JA3kv23kO
         xG8C/NUToIzwO0ivktwLLeirDmLICtdtH2+T3x4KYY3oEQc3p5y+wKBmGYi0qF4iWJ6N
         /JuA==
X-Forwarded-Encrypted: i=1; AJvYcCUse0a+cbR779CAZ66eaGc487Ia1S+NYar6H8KvL5XNj6VRbYPYHKan4eZ2qNMok8CfaapLdO55+AnnfwOKqxUae9CgWufF3jbfJs9j
X-Gm-Message-State: AOJu0Yz8aIfAl6iPdz98O15/4QjGDrjAkkeuMncP/rRGo/vqo8VgMrc0
	4CIyoJy3NOt1JiXRAnMQz9pyfsGiRwBm/KCHjnZmfHt6D5xiJPdr7J9KKQdM
X-Google-Smtp-Source: AGHT+IEbfdTEnzonydMkAgqLF47kdXiqOOeuXt9NdeU0/+leTu/2jcCLUvll/fXH2SpAEININDq9Dw==
X-Received: by 2002:a2e:9e89:0:b0:2ef:2e1c:79b5 with SMTP id 38308e7fff4ca-2f1a6c5aa3cmr16934361fa.14.1723232308518;
        Fri, 09 Aug 2024 12:38:28 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:8a4a:2fa4:7fd1:3010])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f291df4987sm451311fa.50.2024.08.09.12.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:38:28 -0700 (PDT)
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
Subject: [PATCH net v3 4/5] net: dsa: vsc73xx: allow phy resetting
Date: Fri,  9 Aug 2024 21:38:05 +0200
Message-Id: <20240809193807.2221897-5-paweldembicki@gmail.com>
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

Resetting the VSC73xx PHY was problematic because the MDIO bus, without
a busy check, read and wrote incorrect register values.

My investigation indicates that resetting the PHY only triggers changes
in configuration. However, improper register values written earlier
were only exposed after a soft reset.

The reset itself wasn't the issue; rather, the problem stemmed from
incorrect read and write operations.

A 'soft_reset' can now proceed normally. There are no reasons to keep
the VSC73xx from being reset.

This commit removes the reset blockade in the 'vsc73xx_phy_write'
function.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - resend only
v2:
  - improved commit description

This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index a789b2da9b7d..e3f95d2cc2c1 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -598,17 +598,6 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
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
 	cmd = (phy << 21) | (regnum << 16) | val;
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
-- 
2.34.1


