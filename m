Return-Path: <netdev+bounces-222680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E950AB556BF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A533AE015B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D8287508;
	Fri, 12 Sep 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMg4UxOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC31279351
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703951; cv=none; b=P4VmVJYgaOQXLWHafMy/Iq1zqhe+nT8mh1Mq5Z3a+jZD2fOv9C5PF1zc7E3Hr1JOMOqwY9DZ0Trn0fGDUV2LyqLNSiRdMkyMkGL+cCuEEutCxsaBsE6eIM5pYJDtcG+VCXH9mUHwXwObjvLpPczqTS3lITfY9osD5DscsZCCATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703951; c=relaxed/simple;
	bh=JPifwe26TeMIDKb3TtpyAGl30pPEVeVHIksh0eodx0o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ItQfB9eOcWWpjw/R8qWOqvx8kp0WJ/v9f4jHwWPRrXVGmwGxDzUfT9WllmKVum+VAGu1jdUDgKJ0zebcL96Lnsn4BkPiOrSwWGvZwcDeQrZXAFjAEHGAA9hzufUxHQoGEcZ2Vy0eJJQyCmgyeIofVG6Vz4MYqD/80wl41c26mbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMg4UxOH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e46fac8421so1837402f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703948; x=1758308748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RZt3YR8Jp/DJkowpDgTgU3Tb1oCCE1Z6HJdioie8Jqg=;
        b=RMg4UxOHPH+RHSo99NZ1peEVoDOkq0DdCxrQhT9fBonPZiZOTt3JrpUl78pXAbq6Li
         ZR/MJqdKlWNyXGIlR1tGH9GhlVrzGwAft+GMbxZLMA2sMajxFZfkAqhVPuBOXqrkLlgs
         gK8ex+1OsdVPo9/kGhOH640a5CknAWbHSJgoDcR4qGRNuyfUKutosjuknAX0r2jWeodq
         pJhsUCjqGIxouKMBHl38l54BBbNzefbYzJjg8GKOfAeetegenXcQGVZ34QAFNy5eTxK6
         KeQHaWk10Y2EbNUv5R8b2/NI7dHiwgo4a17P37Mch3Gpaicx1VmNje+NSCCNBNXV76Kp
         uniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703948; x=1758308748;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZt3YR8Jp/DJkowpDgTgU3Tb1oCCE1Z6HJdioie8Jqg=;
        b=ltrpEFJz+p+K3C43pLOEQzr8roxIAhb5k1qX1W4FKqPhivGrEB2Vj3VO4aAqJ8C9GG
         Za3+hA7rv58FzJndH8uKhHCw+hGBoKBp1cdk0TaBOi6Lfd6zdGRhX4U6AWVX0cSgN5Rp
         9/oULUo4Oqsbe0Qm/Evpj3r722YNQNDBA2nCuIR5PJwkWIUdTLstgDvh6a0D/I5BlwEa
         RYATGtBaonUKtFvpls6EMKF2ywVmdkWcQwaOmLlvipeWvXXoSh8AQyS+dn9NdyUggPwL
         CMJMUm4lmMiVGgBQHPWz4mECApGLGNtigG6kjzeQVEqIjQiyCFhKOYWPmro/iaBCHAy9
         sgEA==
X-Forwarded-Encrypted: i=1; AJvYcCUSNtoXWlg6xlZT/xVHpvmbJUFH4eqO8qlimh4ooJo+QeqcDZxlrMwfxOB3XdhwtLVsyIEFnp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04NtPoljiyQHWnPYUyOLhqanWhDhzGiE19Z2DX7z94qj3RmDI
	gK6yeqR27CvaPoASU//ijm2NkZU8NwycgkQhTETuG6D7HLi5ZTIP6uOa
X-Gm-Gg: ASbGncvdPRiWCpobco7jwKZqVBueLMNDceh8cAd330G6B8sHpnYZ6Krm/0PpHTUBqnH
	7m1CQ1IJKlUsVeS3CRFQLO7ANasXxKflLH8g1WaHLtzp5Ioq17FU0YxVuDhRBfNRUlhO6goNZqR
	UBiDMl4ReiyQ7AUFLdAlXFz5WTOHwMiF/MverzkagcMD3Q46QSEIETx4WMVEjMehX5u9Tv9v1pv
	oY7cv93azSZ8jxU6KIgqmXIRKbsNWHJHL/Uv1BuBLWsh7DtJLrnFG2fzDfJ4ZxvRxoYeA4YuGp3
	CubGePF5Q1Orsgec0ezsR7i/TGbuOGgxC2k74Etv3yZiUcJC56YhHQBatq2fZT7qK9/nsglB916
	TjfxAt8DO2QtIOYD7poWjv/UjFib57ynchWZo3sWopu+2cLL/m1/AxoH+zKJiUO6qCqsK6/eMMZ
	CUkFTJlonDPAPRj+SQyxLE8cZ6jZt3eqJJxAz3JiRe+uy2f/Hv89tiB2bcg3g=
X-Google-Smtp-Source: AGHT+IGfUlDZCVtV4RXCtwZ3mG2aBQcR0hCWA3CXSTyoCHQfY2pHfDv30qRmGQ2kH5Z7ml/01bCOkw==
X-Received: by 2002:a05:6000:2586:b0:3ce:f0a5:d597 with SMTP id ffacd0b85a97d-3e7659ee949mr3176492f8f.47.1757703948153;
        Fri, 12 Sep 2025 12:05:48 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f09:8900:81f2:fb63:ffd:3c7d? (p200300ea8f09890081f2fb630ffd3c7d.dip0.t-ipconnect.de. [2003:ea:8f09:8900:81f2:fb63:ffd:3c7d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7607d7ff9sm7396526f8f.51.2025.09.12.12.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 12:05:47 -0700 (PDT)
Message-ID: <faf94844-96eb-400f-8a3a-b2a0e93b27d7@gmail.com>
Date: Fri, 12 Sep 2025 21:06:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 1/2] of: mdio: warn if deprecated fixed-link
 binding is used
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs, but still there's a number of users. Print a warning when
usage of the deprecated binding is detected.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- use %pOF printk specifier
v3:
- add missing newline
---
 drivers/net/mdio/of_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index d8ca63ed8..24e03f7a6 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -447,6 +447,8 @@ int of_phy_register_fixed_link(struct device_node *np)
 	/* Old binding */
 	if (of_property_read_u32_array(np, "fixed-link", fixed_link_prop,
 				       ARRAY_SIZE(fixed_link_prop)) == 0) {
+		pr_warn_once("%pOF uses deprecated array-style fixed-link binding!\n",
+			     np);
 		status.link = 1;
 		status.duplex = fixed_link_prop[1];
 		status.speed  = fixed_link_prop[2];
-- 
2.51.0




