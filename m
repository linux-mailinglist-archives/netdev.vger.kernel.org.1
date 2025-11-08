Return-Path: <netdev+bounces-237020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B132C43509
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 22:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8484E12A8
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A32270542;
	Sat,  8 Nov 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YngHX0IL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF81FF1B5
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762639186; cv=none; b=iAU17tCVVLFV0cwZza3h2WW/DhgwqbxgBBK194jEoiUipWK6zikqKIHBsRyr5bcQbdGcBge50Yph0YkGZIyrAeu8ap+qYkSk2YMjwy4LlB24Q9aR1AFZLvq+k/I+0ST0U7975GWFGD9olbRiod12CI3nupUZeEtLt9OpIIYRyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762639186; c=relaxed/simple;
	bh=OFqwXEpafbCBLTP2m+OZfqs+Mghqo7kDNHq9Y0VVeM8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=u04z57QP/cm8Nnkc9Yn5/7cXTW2zOKlxOoBl6W/cX197MdUinFDOm0jzLVaK9vXG5gwNXlFA+MeySuyDvz9SR0noOPdeE/pKyFcP1/xoS0QSDOx7YRvWPipT5Tw8jRjvjM3GSKQFQJB1ibStImk4405TPxKnxuMYSnwV0MEgqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YngHX0IL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47773cd29a4so3185015e9.2
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 13:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762639183; x=1763243983; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUUCHx3voMA+DkABJ6SPjYMWe4ZSWt3FwI2FopG/dvM=;
        b=YngHX0ILpoIs4YjbH5iclZ1fPtaVtG2FYnFBe8rDn8HPCyZqvn7QtCuk5zcgC3Tx4v
         xBjHEBsHbbM/eUKvmocePW+fSrbYclM6RBNHd6o+9RFZrAx/K4qBcYRAcTrKOH+RWlCE
         Fu3uNFMm0ykLVh+d7Sf1hT3VLGD4W8ymHosJKZjWUzxUR+aR84s3IDfDIjiwmcCvm38U
         H/hdcMFGB2DoxuWbIfeJeAu4T0XPt5/mNK4f3wssbA8qKO+dumu6CXk+hbLMWq2du6ZA
         otTsebvhpM+vrCunh5ZsBN8HVj30fTElxxmQcJx/8zkoaT1JaSGAgpu/k6UFPiBZyjjn
         e6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762639183; x=1763243983;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUUCHx3voMA+DkABJ6SPjYMWe4ZSWt3FwI2FopG/dvM=;
        b=w1Id0UAOT8fvcqdeXN26OAvyITfP3lfM15iYflmqaze6NqcwlAQ2COTVDnyIe5F9/g
         d4k7PbNHuaAdSjGg45lDVYVIVn0sFCGW2nNUneOqio/oPnpSUjwcs3yomCQKDX0H8JkR
         ecCDsvYXdexy+vjf/j6D0dez/+eoGHKYG+oHYWUA7fGiI4lq8burvuoL26LpTQCqjGzM
         v0DE5ZxAQpSLkqr+cA6lRWnaB8UmbsKoWL2Sb7KEZm0zdjTTErqzW3PlQhDok9YIxjvC
         sGP1X+M5mDSSemIHH2Bm7GVgklDjBznKMvorIZF6mAG13siMbAQlJ/7gYOj/Z33p6KCZ
         2rVA==
X-Gm-Message-State: AOJu0YyLIILvSBayumrOhFSZaURzuBn2/vIyejQjX6hYOXrjGn87rEaB
	oc/FW/r6CdxZSx29pDBZT4Lwun6qiFDNN4jkLR22FUTTPtIUhu6aB+wE
X-Gm-Gg: ASbGncu1eRigkZr2ebDJsr5mkQRYvtZsOjlyRkuxe0YMNK/Tf+yYd1Z30FwG3ASlnn8
	ClygxIEBTj9ffhe6TDopxqqHbWwPnSsLHFx4oWrAaAUgj8zXA43hHnVOUMLWovt6IwiDoVdptcc
	/S3SZDORs585jCbnLgRi2H8gyny/vap27DqThWirNGKEypW8/SMVs15QqGSMI7/ZjsqkJgFwCt7
	TkMILkYEznzHz/NW5ExqXTI1j+sU8SxAXX428FRArFJznFldFAXTVG6e1Iz7AW3wJm34WfZ8GX1
	MlrnZvmRU76YLvKQVfUPC8lrW4R/CeZpUXxl27AKV8JFaQXxsmlbrTzDyADcM3l2EzuxoGktP30
	pVAqJw9dE6PMN099F/LiORcrL1V833HOIxni3D7SMtPM7HKuBgqn27EuEoP+WZOmKvjPcV3z5fE
	Gv/wwKlHVFz21Xx00nEXeR6l5WzvABJQpdgyQ0Ih3jFF4PSBHOn4qO2grsSKPa9+Xd+zWbhibpO
	mq8vE/oVzzjTdfkZvnhGFlrdQEttLeIQyMYqLWRGR8=
X-Google-Smtp-Source: AGHT+IE5ai9PFBTamHZXMQlcCyqro95Tc2NnvdXv2gcn2wykGXojSoM2zLjR+aa0flIYwzDXeaiKhA==
X-Received: by 2002:a05:600c:354c:b0:477:5a11:5545 with SMTP id 5b1f17b1804b1-477732927cemr29608585e9.27.1762639182738;
        Sat, 08 Nov 2025 13:59:42 -0800 (PST)
Received: from ?IPV6:2003:ea:8f40:3e00:2167:ea64:152c:2ce9? (p200300ea8f403e002167ea64152c2ce9.dip0.t-ipconnect.de. [2003:ea:8f40:3e00:2167:ea64:152c:2ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm241349275e9.15.2025.11.08.13.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 13:59:41 -0800 (PST)
Message-ID: <922f1b45-1748-4dd2-87eb-9d018df44731@gmail.com>
Date: Sat, 8 Nov 2025 22:59:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: dsa: loop: use new helper
 fixed_phy_register_100fd to simplify the code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new helper fixed_phy_register_100fd to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/dsa_loop.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 650d93226..4a416f271 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -441,11 +441,6 @@ static int __init dsa_loop_create_switch_mdiodev(void)
 
 static int __init dsa_loop_init(void)
 {
-	struct fixed_phy_status status = {
-		.link = 1,
-		.speed = SPEED_100,
-		.duplex = DUPLEX_FULL,
-	};
 	unsigned int i;
 	int ret;
 
@@ -454,7 +449,7 @@ static int __init dsa_loop_init(void)
 		return ret;
 
 	for (i = 0; i < NUM_FIXED_PHYS; i++)
-		phydevs[i] = fixed_phy_register(&status, NULL);
+		phydevs[i] = fixed_phy_register_100fd();
 
 	ret = mdio_driver_register(&dsa_loop_drv);
 	if (ret) {
-- 
2.51.2


