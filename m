Return-Path: <netdev+bounces-208192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C6B0A7DF
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1F916B55D
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE82DEA9C;
	Fri, 18 Jul 2025 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL1zbpYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B362DEA65;
	Fri, 18 Jul 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853353; cv=none; b=Xu9lXYMyVFdZIefZd1NuNsJr5h+hfnggKn07k1Mf3VTEUIO7mlm4TnHFGUlBpCSWKjXY9OU1ZOuSuijRaYQ0zEsbB7CKIaAJc2pEwe4jsbDYfZ0LFswRjfGGzAI5vRAV74RBuZZqH0aIiybr3mImXHdMEQM1mFzIhEsMo/iDKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853353; c=relaxed/simple;
	bh=BXM5uKiC3tn5UlB1pxiuAFlHEfvCLSeqzdILZ1Z1V0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KPHTRg9J0wyFxXyMUIiEAE5ev2dLpBwbP4pPqssLeHGy4ir6dyHW3OFzv/o5grbGsg37PdvC7I57YqxSue0ZbvS9iGpp2lY4WMrOv4rnFXYngx7iDJH0CKjw5uGY7wRFnr3FauhA7yWSsJw1BIS5swbjYg0K0EWgs2nLF63UpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL1zbpYc; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a54700a46eso1321686f8f.1;
        Fri, 18 Jul 2025 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752853350; x=1753458150; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kMykobZFTCct97XrWw8W4vWt2bhS8iKpkAQBmHPk8j4=;
        b=HL1zbpYcG6J1n9ykugggZihjw55KWTenDaoPhpYMxK7Mfh8DPTf9rIqmLj1o8VBTzQ
         Z1beNc4h8eUb5VmIhFml0fKBVLy88gW3IptSwAjR/gSKr/JCAQjaGGlRL+mrP044hfBX
         +hI84kqDF29qr6YjRV+T9wjydcAbyEQ5KnFpsjDLc8Ad1H5bGwdRFWELPvlDR8XdpLyI
         P2WoTYq07qIZ0fUgutPkOhnp/jm/bCHxZEC01XXPcYrNYa5CzMa71w4H3hDUGRt5uWSS
         FDJVJcPjsxK7laJfBOXu1LRpO8L66qnlsWrLrhT1Ezw0RjqPBZit+4OFqjE2Eb8ONCfr
         EpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853350; x=1753458150;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMykobZFTCct97XrWw8W4vWt2bhS8iKpkAQBmHPk8j4=;
        b=ZRqonn2E6M412ryfL77str/3CdSFfpY6w9xRqEwkKUEWUePXqxHDx79mIlQ8iBGAU0
         YfgvAcfYkZO+yFvdiJmcExKOV6a7mfIMjtTfR+pceyy/z5k6kgS4gFPlW43+1Ij9F99J
         5mN2VH+VUckvX4vH7T1ZiEjREY4XHV7Iv7oUBnhB0BdsPblKi2jdYmY/kX6S21+1RQ+z
         ix33NVYZiC+eew6ckxFt908nGofu6zK1Q81z3YCe4fMTS5FfHmO47Wa1pO4YyhRlOqV9
         yNHHuQd8xvW2BGPKRbEhEfPpfZr/T5UOI4B3R8AXYFbYasLIoPm/FRcilx92N72WwMxS
         wxgw==
X-Forwarded-Encrypted: i=1; AJvYcCVWoxOi+RQnB4z7nW8tUth84yclBU5QniUQ817FAYFfR2bxPF7KzeyllINqlAPQ7/dJbrKXMn2syJidOHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2ATU+g2tPwSTF7ut8p/1LtrGEVDHOc0QQM/uN7UwDD9hBGOc
	XoDP8tZVQPfsOvOzcH3A+DSWHGnBt6yasbpqzXFzJAECYu7p9g0tZScA
X-Gm-Gg: ASbGnctWOM2F5fh9AgZKY19Y/14HUaau5y9cdNsrj7pdEAVTtjxUBjb9kn59Xo7XI+0
	kyRdPP2gAdeBGFmOIZUtWKrc0RrKrvFYTQ5GXDQPUM3WV8GHLE0PvYQ0aGpyJuBzazCECMR4ntu
	vJy6SPfdcZf+3klE+5GXbNFgxG+vyo9/UkWHBAwUSVk4d14axDPTqpVTy+E+ZQ4plTOlOX2TNGO
	Om2CdIsvzKqUVtibTC5rgGgdJno26kIoQ9VO199bSwXDSaPDkJgNkPBcad8WOddLfd3Xjl3uk9j
	tzNh6kEeBY/matNmukqZ2HBjIg6b6J7AN6IlgdqslzeP9CKkf4S4ANwomCnNTg/FPHZDEq+Hmo2
	kTTYpC9Awit9VjHk3eyvV8N1WMHsobi80Z5tScZO9BxH+eE2APR288drcPqnysKEsw2/1
X-Google-Smtp-Source: AGHT+IEDgGZ3SdMj2b+zSCKKk38eyP0jlLt6kqaUwdhEQ+3h8PVPeXIDYx2Cd6/EcIY70mYdITACAw==
X-Received: by 2002:a05:6000:4022:b0:3a4:d6ed:8df8 with SMTP id ffacd0b85a97d-3b613ea2606mr6600353f8f.39.1752853349709;
        Fri, 18 Jul 2025 08:42:29 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-98-199-117.alshamil.net.ae. [86.98.199.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80731bsm81682065e9.15.2025.07.18.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:42:29 -0700 (PDT)
From: Abid Ali <dev.nuvorolabs@gmail.com>
Date: Fri, 18 Jul 2025 15:42:22 +0000
Subject: [PATCH] net: phy: Fix premature resume by a PHY driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-phy_resume-v1-1-9c6b59580bee@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF1remgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0ML3YKMyvii1OLS3FTd5GQLM0MDS2NLs+RkJaCGgqLUtMwKsGHRsbW
 1ABezVXZcAAAA
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.nuvorolabs@gmail.com>
X-Mailer: b4 0.13.0

There are possibilities for phy_resume to be executed when the ethernet
interface is initially taken UP after bootup. This is harmless in most
cases, but the respective PHY driver`s resume callback cannot have any
logic that should only be executed if it was previously suspended.

In stmmac for instance, 2 entry points of phy_resume:
1. stmmac_open->phylink_of_phy_connect->phy_attach_direct->phy_resume
commit 1211ce530771 ("net: phy: resume/suspend PHYs on attach/detach")
This is not needed at the initial interface UP but required if the PHY
may suspend when the interface is taken DOWN.

2. stmmac_open->phylink_start->phy_start->__phy_resume
commit 9e573cfc35c6 ("net: phy: start interrupts in phy_start")
This patch does not introduce the __phy_resume in phy_start but removes
it from being conditional to PHY_HALTED. Now it fails to ensure if it
really needs to resume.

Prevent these duplicate access and provide logic exclusivity for resume
callback in a PHY driver.

Signed-off-by: Abid Ali <dev.nuvorolabs@gmail.com>
---
 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2844..68583bb74aec 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1846,7 +1846,7 @@ int __phy_resume(struct phy_device *phydev)
 
 	lockdep_assert_held(&phydev->lock);
 
-	if (!phydrv || !phydrv->resume)
+	if (!phydrv || !phydrv->resume && phydev->suspended)
 		return 0;
 
 	ret = phydrv->resume(phydev);

---
base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
change-id: 20250718-phy_resume-cc86109396cc

Best regards,
-- 
Abid Ali <dev.nuvorolabs@gmail.com>


