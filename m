Return-Path: <netdev+bounces-78528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B708875920
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106B9285E6F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108D13B2BD;
	Thu,  7 Mar 2024 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp96pegr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84313AA52
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846177; cv=none; b=XetOiHRFCbI0uj4uKMwstgXdj7B759klNip15/f4u5z2awmVQXDQ2whhRMsAORxOWoM+UDcaQ9CKe7uPkQwwDp+r39o09D7/k6agCxAR6MvkDTd/Vi33DsS1ve2tpKsw3Mx8ekFdSiCGwA9xCOc/ltX45+Qvhhn9IhoKkL2Qjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846177; c=relaxed/simple;
	bh=nGQJpZX7FTD3lHVGs17tekaUU4cZr4AFm9j7cjZuiGg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pvIKUolBdHZhm++oxRD0yp3rEvQD9xqx9iqimX6oeBILk0i0JcnhbPKEMqES7A9tyVouWnt7fUL7m9d2kU/D+3o0ty1TcTyNcauOlT+0sBRJ5lM4W1SLCO18SKH4f7YY8yY4k8fwtXXUDRQoS50i2tT/e/bSgOXmPbMjjGUE/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp96pegr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28a6cef709so28255466b.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709846173; x=1710450973; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YDm1Npn/BBarhhdz44KEsh/OFcNAUPbz4zZKd6czpo=;
        b=Vp96pegrRg8LOAhwJDPES3m6zGn5+92Z0z2A/E+bJ2K3VAXvSu5NCT9z4DliBtKHCT
         rqeRFgeGeJUDv5c3NMgnbItO8hGKL1dAH/KxhPae7CXASnYcPj0iFuoOSSY1tAzbJGx8
         MO0zGf4CAe67Fd2B1+Fh7YbegonIclRkYNDq1Ug2LMfOmsO3JXoTE5mJlkRCHj1m69Yt
         L9ECaGSKR6drovK6O7VpDJ/reV0gHo8kfwvs2MtNzvcF4emUFZ5t7ll8loy0BdrHAUa0
         Hw8gpMgOHyCajEEHEsaNZBBKrEHtqhQMxYIQbQ264dh2qemEWXorU2lrZ857hJ3ijyeY
         Spvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846173; x=1710450973;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YDm1Npn/BBarhhdz44KEsh/OFcNAUPbz4zZKd6czpo=;
        b=aiBIimLyKO9nolGXZhKx7bLue3UhcpiZXp/IKqyYg3kUHzjK9+5I0KI15Yp3RjQ/j5
         DdoJ8vhstB/Pc0TiQiIxf8W6fK3kVDd0KwYfGnF2GL1Al60uRllkpznePJD+IO8Sg4Vs
         jhz3CFbZnZCI7ooGjXm67NHY8UyDwfehT0APjOIUEr0Ab5cIsKhZSlSty4BDdcLeaT2p
         mpZXnGkVNEoof0wV8Ubiasr690PlZVTQrWoC1nK9QZ8SrFmiavuuJJXENvgSVKLLOKRX
         sM/0NMNG+9kjLvs8yaBQ4Rm6PuFaHjTXkYUAMftDsYLmNxKXLAg/f9eqQ9uitd9OuEu0
         5KeQ==
X-Gm-Message-State: AOJu0Yzi/r2ID/9z1vQfF+J+NgpJSCzuGf6oahafrYqsurtdtZ/Xqf2r
	j4yZmpM8H/mqgX7rxiF5Kvrhs/x5i8za2jzFIxZ/kjQZgu78TG7R
X-Google-Smtp-Source: AGHT+IFXtpAeROyXqVQEh2vaKmVosFdkK1DSc9v+TmofosXGAdq3T/oS9ExzvnzWCPcok+OEIw+H0Q==
X-Received: by 2002:a17:906:b888:b0:a45:2a53:d6b9 with SMTP id hb8-20020a170906b88800b00a452a53d6b9mr9580823ejb.62.1709846173216;
        Thu, 07 Mar 2024 13:16:13 -0800 (PST)
Received: from ?IPV6:2a01:c22:6ea8:7500:7cdb:1fd3:51b6:fa25? (dynamic-2a01-0c22-6ea8-7500-7cdb-1fd3-51b6-fa25.c22.pool.telefonica.de. [2a01:c22:6ea8:7500:7cdb:1fd3:51b6:fa25])
        by smtp.googlemail.com with ESMTPSA id lf7-20020a170907174700b00a44d66a16efsm6535676ejc.2.2024.03.07.13.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 13:16:12 -0800 (PST)
Message-ID: <de37bf30-61dd-49f9-b645-2d8ea11ddb5d@gmail.com>
Date: Thu, 7 Mar 2024 22:16:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: simplify a check in phy_check_link_status
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Handling case err == 0 in the other branch allows to simplify the
code. In addition I assume in "err & phydev->eee_cfg.tx_lpi_enabled"
it should have been a logical and operator. It works as expected also
with the bitwise and, but using a bitwise and with a bool value looks
ugly to me.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index c3a0a5ee5..c4236564c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -985,10 +985,10 @@ static int phy_check_link_status(struct phy_device *phydev)
 		phydev->state = PHY_RUNNING;
 		err = genphy_c45_eee_is_active(phydev,
 					       NULL, NULL, NULL);
-		if (err < 0)
+		if (err <= 0)
 			phydev->enable_tx_lpi = false;
 		else
-			phydev->enable_tx_lpi = (err & phydev->eee_cfg.tx_lpi_enabled);
+			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
 
 		phy_link_up(phydev);
 	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
-- 
2.44.0


