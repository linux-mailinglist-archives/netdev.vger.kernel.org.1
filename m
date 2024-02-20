Return-Path: <netdev+bounces-73452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF20D85CA45
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5221C20BC6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CBC151CF4;
	Tue, 20 Feb 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4nfvEdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E947612D7
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466142; cv=none; b=hS616ZLOTiY6WSCGU6vBI23qw3SEpWshAxTQJ5zyWSwCvmcw9s1FW47tZ8K6INvWAhA+5Q6scU5f+F7KjO6flwSgqAVP8pQk5qnSZ/cqyV0t1OitO16g/NHnlGMbttMY6YjWtENx6qr8fpXgU6dvAGtInDaEJDiRRBAlNmsv/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466142; c=relaxed/simple;
	bh=Ohfg6T6Za7EqzUoJaNbztzcTRxD8DrEsl9F5ANeiNQQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RCX67ZlUVcIzTQ91GONIGg2O5pwzkl9Of+uMdvirzdY6rLQjRtEJVknIHvPlR6YgXxU2phNx50G34J1kINjsUNwIZNhTH1mG4iKENtJv/GAiw2uI4TCOE8W7x1CWQlGlztJrfrbDZIuKZunfxcNe7wTsKVAetkKmW1Pqgul/mgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4nfvEdQ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512be87a0f3so2454184e87.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708466138; x=1709070938; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfpooYLoCYO6WvT8FcmJA22hezt7ArNHHwo8+rD9X8Q=;
        b=L4nfvEdQCMjzXV+5M3z7L5ProVutbn08IEBwhJ4ENXTN0klIIMsPHWuaNve1AzrzSy
         wqr73QzhKibg9251ebMmnheQjVMF3E1qe3iKEee8mJ12QpTSFQEcLPLJbySwuDBHWzPc
         /WNNe3fH2am2iG3oKaGOGWYMOYxr9OI3ZqPys/KOPEAzo+P4b+BCbdCvNkr5cUeSco3n
         NR2vEn8hLjgEuGuoxxmxXZgxW13Ow4k6DPRCkk/Q85q33CWJQKFL8rMKNXJ3n9Mmib/1
         AcobCiEKKFMfzZSao4DzGx3uGQQnMrqlOYWMno2+GACkSUbqkGlN7rsQO7FZW6QpTi+8
         WIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466138; x=1709070938;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfpooYLoCYO6WvT8FcmJA22hezt7ArNHHwo8+rD9X8Q=;
        b=B17VrTi5w9iTTBkyI4TMaxhK0Dqh/awxyxIFmWgKqQmGccpbfHMlgSB8+HJ0uewVyA
         SOjGoXwk8AD7LT3iiZJ6t16T0VFQzRqJiGQ2H2Y+a8Mim322N6WlPexotCwFVA3ZZfPi
         EagA3wJbiTuozQu2ys2MpkzJvwmRDlrwmuzRPuDApE35kZ5jtNYve33Ob99v0250Y8Nl
         +j0wsvovh+0OYeKhJHWCMbK7ug+Xhitu+vRIPCwnZEULDNjqLWEPep2L6gwNqopsvjoG
         LrFXso+UHtyO+QJfY4+JR1Xp43Rkfgszah8AATGTG+AZQrE1px7EbEF8TsfsIvnOuw/q
         jkEg==
X-Gm-Message-State: AOJu0Yx74HBIUHR9/eUjycLB7/QYFDx1maOE/nXdGyyEpKqmE1mtFreQ
	5sUqUwefMrqAL8A0w1Bx+gV/n1a4MR5uW1aKIKEigmQEjeybcvsiS7CQmVV9
X-Google-Smtp-Source: AGHT+IHlmO01lIh+Q7Vowu6qNy1czetUhGzfctLi7gua7V0utQAmRPCgur7dBUbzFb2kRDd+TAoWgw==
X-Received: by 2002:a05:6512:10d2:b0:512:bb39:3491 with SMTP id k18-20020a05651210d200b00512bb393491mr4263391lfg.60.1708466137945;
        Tue, 20 Feb 2024 13:55:37 -0800 (PST)
Received: from ?IPV6:2a01:c23:c021:dc00:d145:3658:43b:c702? (dynamic-2a01-0c23-c021-dc00-d145-3658-043b-c702.c23.pool.telefonica.de. [2a01:c23:c021:dc00:d145:3658:43b:c702])
        by smtp.googlemail.com with ESMTPSA id cw4-20020a170907160400b00a3e45a18a5asm3522770ejd.61.2024.02.20.13.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:55:37 -0800 (PST)
Message-ID: <442277c7-7431-4542-80b5-1d3d691714d7@gmail.com>
Date: Tue, 20 Feb 2024 22:55:38 +0100
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
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: simplify genphy_c45_ethtool_set_eee
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Simplify the function, no functional change intended.

- Remove not needed variable unsupp, I think code is even better
  readable now.
- Move setting phydev->eee_enabled out of the if clause
- Simplify return value handling

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index c69568e76..9566645ea 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1560,10 +1560,8 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 
 		if (!linkmode_empty(adv)) {
 			__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
-			bool unsupp;
 
-			unsupp = linkmode_andnot(tmp, adv, phydev->supported_eee);
-			if (unsupp) {
+			if (linkmode_andnot(tmp, adv, phydev->supported_eee)) {
 				phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
 				return -EINVAL;
 			}
@@ -1572,18 +1570,15 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 		}
 
 		linkmode_copy(phydev->advertising_eee, adv);
-		phydev->eee_enabled = true;
-	} else {
-		phydev->eee_enabled = false;
 	}
 
+	phydev->eee_enabled = data->eee_enabled;
+
 	ret = genphy_c45_an_config_eee_aneg(phydev);
-	if (ret < 0)
-		return ret;
 	if (ret > 0)
 		return phy_restart_aneg(phydev);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_set_eee);
 
-- 
2.43.2


