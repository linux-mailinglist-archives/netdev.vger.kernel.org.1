Return-Path: <netdev+bounces-79281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1408789A3
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 21:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2A128194E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991664E1CA;
	Mon, 11 Mar 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpVClC+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57FECC
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189877; cv=none; b=fSvzKyhn5yNDzO+85Kyrx53w+m4QLomYPHkHvCZeNFdmMETbIdQO/VxmJu0a5MIhDUZ7hQUXHmlTYJF0wsw687//mN1TLIF7r0ONZSMZ92MO/93svk+nl2GiSRdbRgeDgx74Cf7uOHMO97ydOmY2ScOzI2HyUrJVxBpwXPEssvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189877; c=relaxed/simple;
	bh=K5GLAzqXBP0IgvJdGENsuvS6XnS/2tVFy7Dw8SRIIAo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rKowGIMp0YQ54/Q1vkutm8G3VMh3PpW6lox31gcGnDgnhla59c0WH+nW4JG96oSLNJon0Ey3i94CMB3wYbp1VtgYqEjakCvbLwZG39lEfiwwaZo0Wr92dmo5lXsoVPFg8tUW1av98tXC75ZuRS6iMt90AgGXe99cQRJYjjIllHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpVClC+G; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso2193766a12.2
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189874; x=1710794674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3CnR1kkKmgZdQIqsCTozMnR0F4Zyup5FI0NOk1WXKN4=;
        b=CpVClC+GQAjjeOff+F+TNXeQHEbBo8SPJL5K6zH5J1ON4lZ+0/qjodkhyn87q6XX1q
         qfDoKGrztvZ6ai4RZeJbRwMltWitaE129kH3wVHW7zItsuMWKun8TRXkcO6ugeX/5WQ0
         uuwZMQJ9ymDpZOwQzhV0mVBhNO8E1vHODQNV79TKRtY0Y5cann4PN9ugvQ8RVK4fKsK4
         snSQ0xNWr3rXaPqU+cZ+8/X3rWiKMNVlMlenw2eU82kFmTR/K04628Ts/8FGhncEVWMv
         qlDXVpjYxfB265BqG50JXrZYi0xiM8o+EOlhEsyguNoPWEM1mCvjQW00UbjWOW/Y4PMI
         OMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189874; x=1710794674;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CnR1kkKmgZdQIqsCTozMnR0F4Zyup5FI0NOk1WXKN4=;
        b=FkvGAC9av4ygJCI/wMmjGY9q6TYtvfyT4o0CLQ7bIZZzfCw+CJxnS3iIHHkLNiWpEL
         ifrG716BK0zosJLR7s+omBuEJrmsanjPv8T2HRerParBZ7OHGkVZMSTVimIcylY180Nw
         SDD3VCz5h4jcIv8wrOKDz+LvgCSl3mqh/Ck+lkuPXMLuNoCUFgs7cRsi4nyvVyH+PYQ4
         AxR1pZiADz7GyevMJSECF23+LYEHMqZx9DsWnL3ichxBZRitDWVO2tzqeFPFp8xJjEji
         3lfQbsmA2ya/G89Y43KaabclT8mnS5hHKgeHGwo9RQQ8MzSt4p2eWXRV25tJYfLxJ4LH
         mg1Q==
X-Gm-Message-State: AOJu0Ywav51DiqVnPeUM5obRCQ2K2eFm0HC1YcdNsh5wneHIIBjKehGc
	oEZ4MtZPPAgtEUkiBOxOPOVgrD8GfYzPwt8mIU50a+W9u/XsFrBa
X-Google-Smtp-Source: AGHT+IF2xrXmQd3xTfRkk4X17bgPCSeFDfrfR9SyCBUWTyxtEBBm88zRE74N/xUxi0c9jp5LwQK5CA==
X-Received: by 2002:a50:d7de:0:b0:565:3aa7:565f with SMTP id m30-20020a50d7de000000b005653aa7565fmr4868969edj.8.1710189874089;
        Mon, 11 Mar 2024 13:44:34 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4b4:3d00:4dad:9536:a0d5:cc3b? (dynamic-2a01-0c23-c4b4-3d00-4dad-9536-a0d5-cc3b.c23.pool.telefonica.de. [2a01:c23:c4b4:3d00:4dad:9536:a0d5:cc3b])
        by smtp.googlemail.com with ESMTPSA id fe5-20020a056402390500b005684173e413sm1231265edb.72.2024.03.11.13.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 13:44:33 -0700 (PDT)
Message-ID: <ef591e21-9865-492a-a0d7-3ae6dfff6508@gmail.com>
Date: Mon, 11 Mar 2024 21:44:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: simplify a check in
 phy_check_link_status
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
References: <de37bf30-61dd-49f9-b645-2d8ea11ddb5d@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <de37bf30-61dd-49f9-b645-2d8ea11ddb5d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.03.2024 22:16, Heiner Kallweit wrote:
> Handling case err == 0 in the other branch allows to simplify the
> code. In addition I assume in "err & phydev->eee_cfg.tx_lpi_enabled"
> it should have been a logical and operator. It works as expected also
> with the bitwise and, but using a bitwise and with a bool value looks
> ugly to me.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index c3a0a5ee5..c4236564c 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -985,10 +985,10 @@ static int phy_check_link_status(struct phy_device *phydev)
>  		phydev->state = PHY_RUNNING;
>  		err = genphy_c45_eee_is_active(phydev,
>  					       NULL, NULL, NULL);
> -		if (err < 0)
> +		if (err <= 0)
>  			phydev->enable_tx_lpi = false;
>  		else
> -			phydev->enable_tx_lpi = (err & phydev->eee_cfg.tx_lpi_enabled);
> +			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
>  
>  		phy_link_up(phydev);
>  	} else if (!phydev->link && phydev->state != PHY_NOLINK) {

This patch was set to "changes requested" in patchwork. The comment that this refers to
(make two patches a series) isn't applicable and I answered to it here:
https://lore.kernel.org/netdev/d6ee6353-5cb0-4751-9b69-255ab62e6b56@gmail.com/T/
Whatever is better for you: If it can still be applied, fine. Otherwise I'd resubmit
after the merge window.


