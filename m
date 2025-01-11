Return-Path: <netdev+bounces-157395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DAA0A226
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8479A1691F0
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314B0186615;
	Sat, 11 Jan 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moz/c6sR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43182899
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586639; cv=none; b=CdeZVNKCWt96PnvEug3KEuJTWrFeqHatoPyl6DSXd/F6kBwZgBTAK6PAREEe8JnPDpHC7Yqx2PZP2RvGMlMSyfARNbX0posJH0orD2iQsegLfftO2r7CRl/emsfwLZyvdh0ZEmYj+mFsCuYqXE0bXBmkXyqIMABy2iVLdh/vA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586639; c=relaxed/simple;
	bh=e3lGXnFJzc/6AN1kouqi/pFyvjX0OIBOYaqQogQeEY4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GHklbZvae6227T+JneV0uDpLzgt+kZDFZXdhte54w31T4qNyK+RCAgpAuJYu3ErAP/uISgFmj4jqrZNjO+3QlXFzZ9I6jXIdCtktAruM3v/cfWTrt09Lpn13vf8Mo6BAeRu/BwYNu5FHOQ4Fh0yNg71SoD4sWZPlTGRx4q/M6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moz/c6sR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso5170538a12.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586636; x=1737191436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h9PiRgSwcYASZLOtz5Zv08Qq54r8edwwhD8G7hSh+ps=;
        b=Moz/c6sRkrXPmRHa7H8pT1zh5AOgEx6+x8D5aX+oDZ8q8pDAc+NNVx5DS4Tk99Viw1
         meRkXxsGrHcRASrmpkqTMmLoY7iwYw7fHAeIhgz4ZA++vCIG8T6co1m4y6pNBRpKnHZA
         4LUDZJkR/K0D0122YHewjL6KCMDurbUHuOdr1NLzZRQ8EJyJf2oMh4+mT2rRe9pNo70Z
         2GqbO52vGICjSGGjtz1FRl1XcJMEhCVeRV9mPWN73d6K4Qu2S7dbrcGeaR4bf3dZXzKt
         eAzpv2ajwbtmaoZh7kX+vMs1isR/5bHK9Y/7l4q8c18bjXX9BPSoyrS1Idj3t+UwXvXy
         Aulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586636; x=1737191436;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9PiRgSwcYASZLOtz5Zv08Qq54r8edwwhD8G7hSh+ps=;
        b=MbNuhJwPq8KowBtWggjBckuX3OCO9BReZnvtqKbqAe+31We07VheP0qZb46/dSpuN1
         Dx+Rfhi+9nEMBx+G5rEL5GX7EzS8x1cI/Rlq+BoDeWAgTyca+arcwFhnospAtD4lfaiK
         ad4m0bGOhVbpI1GAq0CWZVAHPuDhlNqvhMks03l7w/hFzd/z18CHdc38Sqa0LPHSYmLR
         kba28VGj0QVbz3LA83H+R3wzYN2v3OH1oxtonklZdSPQHXSaYlypd9I8i5D3FFxIW0gZ
         6Vs5y5HJ4ALA9o8oSepKdDl0mpxqj+N48ywGETfZeycC7/s6o1IR/ZpLk/MF8yAbRjCu
         wlFw==
X-Gm-Message-State: AOJu0YxgDYnZITjzAAa5EAOE/rx2cE33ahTEn/0Z/dkQlQGp6jOUsrHO
	4dm9fw5MukmZJhzwMy8VXy7bjXJOS+Lq7fZwbHhLNTed42TNvEbo
X-Gm-Gg: ASbGncu6j/QP2fdIuYpS57FjydEmae6CTaxSM6uHs6cSR3GARGGd6GIMXO+sDxRev9D
	gNFkbw3EabLyhWX7d0GJhszfMvIvrqpPHseVzsyJXCG4qD6yyDkLGPq94XtK20hlw0fhkW2rBNU
	R/v09sG3fdYbS7KBybIFG0WanM9WMid0UQPbeDpoU5xjW3UCaSmCTEO/PO3IWMuvPmcHscpotM0
	WGXGwf4fjowkfeV4L6PDzm2oMPwIM873MZ3b7JsQOsFx1XOUG5Mx3BIXbF66bvFJMAraPpwB8L7
	6qvsyN5hPUzPfEjycULTofDdtBz1yqWTJ15VDrmukPxJ284iJiIJ4fMdHXYi+0jP8YBqSDfC7K8
	tC4tyaRFY3bf5967KnSivxAluappPk9rCmyH6M1D37zaOqKeS
X-Google-Smtp-Source: AGHT+IFtR/LZPTODQhGkPMF3hMSWV3ZGYJ0suAmwyzZti/IJNkhk4q4KaQdQUVMpgosoBUxBjjpyaA==
X-Received: by 2002:a05:6402:90e:b0:5d3:e99c:6bda with SMTP id 4fb4d7f45d1cf-5d98628814dmr8380082a12.16.1736586635593;
        Sat, 11 Jan 2025 01:10:35 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c3211sm2487767a12.38.2025.01.11.01.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:10:34 -0800 (PST)
Message-ID: <a558197d-853c-469e-b6ca-6823fc14a3a5@gmail.com>
Date: Sat, 11 Jan 2025 10:10:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 8/9] net: phy: c45: use cached EEE advertisement in
 genphy_c45_ethtool_get_eee
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Now that disabled EEE modes are considered when populating
advertising_eee, we can use this bitmap here instead of reading
the PHY register.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index ef58d3b23..6d05aef5f 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1516,13 +1516,13 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 {
 	int ret;
 
-	ret = genphy_c45_eee_is_active(phydev, data->advertised,
-				       data->lp_advertised);
+	ret = genphy_c45_eee_is_active(phydev, NULL, data->lp_advertised);
 	if (ret < 0)
 		return ret;
 
 	data->eee_active = phydev->eee_active;
 	linkmode_copy(data->supported, phydev->supported_eee);
+	linkmode_copy(data->advertised, phydev->advertising_eee);
 
 	return 0;
 }
-- 
2.47.1



