Return-Path: <netdev+bounces-248384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A61ED0799F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB8AE30265B3
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1972F0C7F;
	Fri,  9 Jan 2026 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWc8He7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E712FB0B3
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943964; cv=none; b=Whq5QGXyx/O1obaSpSnSeopfjsiIv+Nx5B7VromZJErMiYZpoyd+YMQmAs9SikkwH5bU57SxCY2JfAxMs8cr9VAtxP9BYN/txQ5Kv/XM5oG/ckiWwRSxcAZhL9edN0kDvOTfY3bu2DEPb70kdgaB59q5Xg6t7XKQDUXUD01/uWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943964; c=relaxed/simple;
	bh=rirtXj8KvyZtDvIPZ6TPGV+RYSfQiQNVMYzRKiwHbeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yv3jQlgysdNPoPSO4JQYRCCZ9VIeAcMgL15yC8UaHFigFIJd7pZOBp/FaOii+qGena1zgpwoL218fOXCneCCAjMuyJOjSLS8S6j7mRKSFam+JilKR8/ZReWflGxErPzK5rnV+M/bWYZb5tDfah21lmvsNWgurJpsp8hTbiXv9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWc8He7Z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477563e28a3so19193135e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 23:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767943955; x=1768548755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFzfDq3tGcyhX9QHzsCtsRtLwmGMPJlNWtMdXkKBybo=;
        b=TWc8He7ZBL/eDaXfBvYib7eXl8UU7m5Nz46+NDwl58YkivsfAn+uMICubGEjQ+oF+q
         XFbwHM1wSEiXrniWOOreaiD4QntUsDQyOsUroo2DF29OP7K6lVXb+j+c3oMgUyDB88Kd
         vcJ8Oo94pQyMjEpktALPZeZkUs33I/4NLmphQgbwafim1kvIv2J5tMoreDXzAPIsBSnI
         1Aeb2jsQQ9O32V/2MBy8eaoCptJgz4gm4BzfdgQUwSmaas+jzR7B1uoWsyqprgyyy7dk
         oO8yF9BBm8uWJjRJ/mYYX7/wt8gGqSCjK2fTR9vdJYT9gydTd5iO9ghNxYwy0TLAotsY
         Eguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943955; x=1768548755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFzfDq3tGcyhX9QHzsCtsRtLwmGMPJlNWtMdXkKBybo=;
        b=dOh+//NG7F9q1sCNOJWeQthtvtX0Q9y5n+cQkQ9jTo2alcVCetu8z2WtoK3q9xmpcL
         yYXtDdCzFkcMSf17hjrPDKnJqBd354aZdmSGJuPtVd1s4RNMEqArHgb7IkK61atYkwtV
         dVUi3yCO3t/cx5XApdTqV38ZYCTUFBdSjPbQidWtL3tJ+dtP8y5O/TzQtp1urj+0FDqr
         8HlKnLaxL5xsQl1YL/jj/3HihlSuBxqqAYw0l/4DAPFeT95dpBuea1w7xtawn7rW4DMV
         BOdbLNguV5FlKItrf6dzApflG1CwHf1FgTGDMmR1ddJ2P0sXlad7oNjuFPXqpSYcimSy
         e90A==
X-Forwarded-Encrypted: i=1; AJvYcCWway+mGScZwW82MMImVjaJSXRMxO53lirC1ZduOCfM+4sREYHKa2COc112hJJwk3dZNqNT1/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlpKdyR0WvQ0FrL2B0EuYwtyObaV3duvlSOIO+iFvlZc1daiR
	eVDEAnacKZs0oQGrq2PP8n077bb5Q0HG8RFoQZa6UjewIBhcG9BvGGQL
X-Gm-Gg: AY/fxX6r0p1s8XASsvSFvnheBLcPx3QEJ7z6ThkBBvl3JpoCp5+P2jM+syemKxhTWCX
	3xR6Atv9V+4p/2vYpC7v1nuwOyDFQP7K3xr7KPEUctn+liyD6MDUu6GZ9EQrLshyWWPoTVgF9i+
	f7/UYDz5WmEJvEcH+CJOB/+0LKU0z+ZoEd87RLt5VAn7PkEGno0DTcsJpkbgmzNbm6tRpIPgp8Z
	T/brmb1sHfhwV2cazRJZ3Ycc44sBckIS9uTIkR0400BqOobUOjgSph8scH2LDCsinKNVuj8zyFB
	ttQAgufcth7aXX4nqgYvlSpr5YaZ4Mz6JOSE0kcR6wMAZGgUiKbqu1yDI3AIZ5VSgs1Z62Bscwm
	TPIpyxsnQNITbjkkxLPjUm+idKlDAnvA0wz9Kz0Jmwn0mWGFwPhoCDQ2HYAKMtRi9XS2W1J+yKb
	0ztwkxKRDbWAp8iez/JUo8M0DUPW8ckgcyFPwf2l22OppczTvAb6xd2xOcCq2BG8IuSsNYwiLhz
	3GqkYzK0Fv83vs2Adqbq9rH1O87cxieBtvsGnit/kc+l1KXmewmRQ==
X-Google-Smtp-Source: AGHT+IGIqzafT+w7f1CB2dac/YkD7s3WV2Lj26d5Jn8/Bi0AHOvdVfU+D7qxzxiYDZHKufcG9rcCBg==
X-Received: by 2002:a05:600c:198a:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-47d8484a113mr109692855e9.5.1767943954982;
        Thu, 08 Jan 2026 23:32:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f34:b700:1da4:ce1d:3d7c:283d? (p200300ea8f34b7001da4ce1d3d7c283d.dip0.t-ipconnect.de. [2003:ea:8f34:b700:1da4:ce1d:3d7c:283d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c6csm204670745e9.1.2026.01.08.23.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 23:32:34 -0800 (PST)
Message-ID: <1261b3d5-3e09-4dd6-8645-fd546cbdce62@gmail.com>
Date: Fri, 9 Jan 2026 08:32:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: phy: realtek: demystify PHYSR register
 location
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1767926665.git.daniel@makrotopia.org>
 <bad322c8d939b5ba564ba353af9fb5f07b821752.1767926665.git.daniel@makrotopia.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <bad322c8d939b5ba564ba353af9fb5f07b821752.1767926665.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2026 4:03 AM, Daniel Golle wrote:
> Turns out that register address RTL_VND2_PHYSR (0xa434) maps to
> Clause-22 register MII_RESV2. Use that to get rid of yet another magic
> number, and rename access macros accordingly.
> 

RTL_VND2_PHYSR is documented in the datasheet, at least for RTL8221B(I)-VB-CG.
(this datasheet is publicly available, I don't have access to other datasheets)
MII_RESV2 isn't documented there. Is MII_RESV2 documented in any other datasheet?

> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index d07d60bc1ce34..5712372c71f91 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -178,12 +178,12 @@
>  #define RTL9000A_GINMR				0x14
>  #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
>  
> -#define RTL_VND2_PHYSR				0xa434
> -#define RTL_VND2_PHYSR_DUPLEX			BIT(3)
> -#define RTL_VND2_PHYSR_SPEEDL			GENMASK(5, 4)
> -#define RTL_VND2_PHYSR_SPEEDH			GENMASK(10, 9)
> -#define RTL_VND2_PHYSR_MASTER			BIT(11)
> -#define RTL_VND2_PHYSR_SPEED_MASK		(RTL_VND2_PHYSR_SPEEDL | RTL_VND2_PHYSR_SPEEDH)
> +#define RTL_PHYSR				MII_RESV2
> +#define RTL_PHYSR_DUPLEX			BIT(3)
> +#define RTL_PHYSR_SPEEDL			GENMASK(5, 4)
> +#define RTL_PHYSR_SPEEDH			GENMASK(10, 9)
> +#define RTL_PHYSR_MASTER			BIT(11)
> +#define RTL_PHYSR_SPEED_MASK			(RTL_PHYSR_SPEEDL | RTL_PHYSR_SPEEDH)
>  
>  #define	RTL_MDIO_PCS_EEE_ABLE			0xa5c4
>  #define	RTL_MDIO_AN_EEE_ADV			0xa5d0
> @@ -1102,12 +1102,12 @@ static void rtlgen_decode_physr(struct phy_device *phydev, int val)
>  	 * 0: Half Duplex
>  	 * 1: Full Duplex
>  	 */
> -	if (val & RTL_VND2_PHYSR_DUPLEX)
> +	if (val & RTL_PHYSR_DUPLEX)
>  		phydev->duplex = DUPLEX_FULL;
>  	else
>  		phydev->duplex = DUPLEX_HALF;
>  
> -	switch (val & RTL_VND2_PHYSR_SPEED_MASK) {
> +	switch (val & RTL_PHYSR_SPEED_MASK) {
>  	case 0x0000:
>  		phydev->speed = SPEED_10;
>  		break;
> @@ -1135,7 +1135,7 @@ static void rtlgen_decode_physr(struct phy_device *phydev, int val)
>  	 * 1: Master Mode
>  	 */
>  	if (phydev->speed >= 1000) {
> -		if (val & RTL_VND2_PHYSR_MASTER)
> +		if (val & RTL_PHYSR_MASTER)
>  			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
>  		else
>  			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
> @@ -1155,8 +1155,7 @@ static int rtlgen_read_status(struct phy_device *phydev)
>  	if (!phydev->link)
>  		return 0;
>  
> -	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
> -			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));
> +	val = phy_read(phydev, RTL_PHYSR);
>  	if (val < 0)
>  		return val;
>  
> @@ -1622,7 +1621,8 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
>  	}
>  
>  	/* Read actual speed from vendor register. */
> -	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_VND2_PHYSR);
> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
> +			   RTL822X_VND2_C22_REG(RTL_PHYSR));
>  	if (val < 0)
>  		return val;
>  


