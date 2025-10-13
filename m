Return-Path: <netdev+bounces-228946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42550BD6403
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 22:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE0C84E03E0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994A22F74A;
	Mon, 13 Oct 2025 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soww1+nu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69617A305
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388616; cv=none; b=ri6w8gFcw/eMG95WeGCQOAEcCJECbI94iRiPdDiyPBaztHBSZfTujLv4AzwVGlTRoLRcP2tjz48y9Tp1GOjh4b2cxwV/8b98jksMqRHXlyi36IfoylV7C2S42EQXOx/3yqtRNWhpSCAM2tGMBpAS72YeLgPIe2mv9zGFkkGkDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388616; c=relaxed/simple;
	bh=uX6Zif+1qT0JzNLV2frHwDsRIRvKf+Y6E3GbB3L6M/Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EIeVzyseIBgW6fhD/oeQBAx/SnOmZA7G4fGKQRspkCL1Omy1ggLs+73YAWyjsexiIezFqIabFrZHJl5uejv6EMneJt3L9g6Dr7VyfcOW28dhKWomcIIlbwYVFM+hLVe2AqlmlEKXajfDy5pnp5z2R1Hv4lPUR81YSuyO0xXM5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Soww1+nu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42420c7de22so2108920f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760388613; x=1760993413; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q922gVEErvw+bV0VIWVXamxIoZHRHe+sbt9JiWHba0=;
        b=Soww1+nu+UQxAhJfHCJZvjwaJnJ14MTHR0NYN0o9o86s9k6JfHXmCNsAzsOLiIpOdT
         iUJ8QGYfwrzs0c6iJYUCss7OKKakKctpPrhAo8GCEDM5PFGeBss8vzGZxWz9WbH2YhI7
         zf5ifPklU7EcdcXxcfZIsSEzH8o9F8flPah3OoKvlxgfpBVYDjeVRkIaNQz6ONukbp6b
         aB5gLZy6yp6DmKhhaidp6z5g06CqbiEP9R81C1G+2qrnBMjeenC+73X6DmOUzgo/Tbuo
         T5bibCq+auOayhQ8qhKQeuenduyg0D02knf4o5jt6+A9ZmuJPIafdb9OsjQj6jfK9e9H
         pGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388613; x=1760993413;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q922gVEErvw+bV0VIWVXamxIoZHRHe+sbt9JiWHba0=;
        b=LzuQV9GEag1r6WFE04UXVJJuFgOl298FYkOPjoRoR7Dd5ot6PIe/vqy/NWY6BvJvgv
         XgjU/RSth4nk/UeBoWS6peQGGLciZ+rsKmRotSeGKybFN4tYR1BT19gnAW18esnB5uT8
         fIpIVTNJiLwrI6mtuC2r16/nZfG+s/2g5q3IlqSU+bSqKYJCS+wIKjL14Ve3Z0ZfuVc1
         dwJFGEuET1+RwV9uKBZ0J8w6bV9QikAdDlJPPffhPLZ7asUvQY3G/jM4K0n94EK2FPmE
         0JZHM9ghNbYGt4tFUPYfOnK0doVJ6leA8NU5Ezfr+FyD1NW2ktjV5ngN7sy9Oyuxro0J
         q8EA==
X-Gm-Message-State: AOJu0YxdVa/gkMcE1sYPBRWf+jEgt5KW7OAwSWbOJewk5IdDmzmoH09C
	GLvnVeNRi4Xq7B38Iha4DQ+J5tvfLszveNh8tiqgYKRf6ywHaJ1LlhtA
X-Gm-Gg: ASbGncuBKsP+Zxd9G3vFsVn8UvcHSha0mpsRpK0luYarInXUU7LXPqgkMRWw4Eo5Obk
	jIZRidxQAUiTigvTUjInvms1dckiWGCQXv1I7Cjp3EdeFHfCXcpEcQyIdJTwW073Jbcau6zheuj
	cTUWeShM6/fxL1//yC90f8v7L0W/LHvrAErS2FWLaku6DAFX23lQqeTyfOIkzPhvDOoge+47rEf
	Ipm89ORo1DLdNkuAa0o7nqCxtmL0+I+D+IQl5V+Bk+65T0OD6uMRyT0g6Ra/j+rodm+vS6+I/MM
	SrUXWW431CyUswfQVt4qvskSP/fHg4RR4WEHt+c4DaUszc7hbzhNNxWGJJOKSVgE6R7F5+kEQ9U
	lXx/GuwBjgvXHKZ25bP7i05lKtlgYmcBoFrWvHK8GRIpLlJ5FLPQWnkRrOhHRwhAEA1YEa+2nLi
	VASx036zTFe2/kSLfmaO7K3/22jkSp/pkvW2CwktbCM0uMfzlcwG6QF56aBccDOCGv8m7ysHVOG
	8UeJfPi
X-Google-Smtp-Source: AGHT+IHLd9twqMEn00/yigpX27JCrmySZamuxgBupuZ85MJni6E+FhzZakN9mzQf0mfWNJS/h4pE1A==
X-Received: by 2002:a05:6000:250c:b0:3e8:71ad:de53 with SMTP id ffacd0b85a97d-4266e8e8ff9mr13844872f8f.59.1760388612580;
        Mon, 13 Oct 2025 13:50:12 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f35:3c00:45f6:d7f9:ba96:7758? (p200300ea8f353c0045f6d7f9ba967758.dip0.t-ipconnect.de. [2003:ea:8f35:3c00:45f6:d7f9:ba96:7758])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb484c71csm209882735e9.8.2025.10.13.13.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 13:50:12 -0700 (PDT)
Message-ID: <e5c37417-4984-4b57-8154-264deef61e0d@gmail.com>
Date: Mon, 13 Oct 2025 22:50:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: mdio: use macro module_driver to avoid
 boilerplate code
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use macro module_driver to avoid boilerplate code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/mdio.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index c640ba44d..42d6d47e4 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -689,16 +689,7 @@ struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr);
  * init/exit. Each module may only use this macro once, and calling it
  * replaces module_init() and module_exit().
  */
-#define mdio_module_driver(_mdio_driver)				\
-static int __init mdio_module_init(void)				\
-{									\
-	return mdio_driver_register(&_mdio_driver);			\
-}									\
-module_init(mdio_module_init);						\
-static void __exit mdio_module_exit(void)				\
-{									\
-	mdio_driver_unregister(&_mdio_driver);				\
-}									\
-module_exit(mdio_module_exit)
+#define mdio_module_driver(_mdio_driver) \
+	module_driver(_mdio_driver, mdio_driver_register, mdio_driver_unregister)
 
 #endif /* __LINUX_MDIO_H__ */
-- 
2.51.0


