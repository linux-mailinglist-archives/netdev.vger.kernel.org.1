Return-Path: <netdev+bounces-90081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA08ACB10
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32601F212F6
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE878145FEF;
	Mon, 22 Apr 2024 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbW0SM6j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF9145B35
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782410; cv=none; b=aU5mHqPSZpDjueF+ilWsekTV/B5obr7xhFPM0N+aYewvVQTZyHJtastOvDC3srVVk+HLUpZygyHow4KwU6ELEmC1PCzZ4z7wNBLQZLgo7QPtVsfDFiSM7SHh/K3s9d/UocUN9nJ6W6W3vIHJ6mnNRJ58s9p9dcly9FhDfNKB5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782410; c=relaxed/simple;
	bh=yPuizPNQBsDm0QlNIxIuJO4PyIYRpflJOS4KBLCVBT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on9EXeHlaN8mQ9eLs3Ktjc1skqcv0N5lB/xESiVuINgIcUDbze1ybcYJfSC6UewCIgQxfHdPZW7tuO8MStwoIXWe77nC55ctvFJoV6FZXod1EFrXk0oRDssQYhFuya4sw21OpW5G+/N3C8M6qM+lK5TU2sFWpnP1NSe/nF4yOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbW0SM6j; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a55bf737cecso53293166b.0
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713782407; x=1714387207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PU8oOFAY/YYDdJAwyLxJMdE0l/xQWeIMM2nhqSnxHQw=;
        b=GbW0SM6j2t9X10BVnQzCYd9yDJkkYWkMFEZ3E8/Sc72Pp1grk/PKjAwnnvQRP/PkAR
         WzVIdUEoMbHgLnZ5BOsaAjxS/vTuLSlmkcISaaWThNJn5iTfZN12KvX96L8PCeiyDBrq
         Nv6+WkxwSugBvHPvqDEozwtlwTveYdQP0ozV+/XKy1GCqpKhW56U4icfHp85XPt6kZX5
         L4f0YX36sDFNUSFm5INJj2aXvXbznuMWGtY3U+gdg4Iuxxu26RujInK4nfimwIYjLxwY
         tYKCpkxNZ5icHzjFYHceti83F2tOpr9mndddsFQ6UxMZP7DbAWP6U2jjsIAn1hyn/Yym
         cfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782407; x=1714387207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU8oOFAY/YYDdJAwyLxJMdE0l/xQWeIMM2nhqSnxHQw=;
        b=u7LkJ1cXY4qO7SfzmPh+YTn76hEjhWpGpDabcsgdJ1oesChT7YkBMK90DL7R6qJRvw
         /LNXo5zR1u4vVOD9Np8bUD+14ViP33k+iIqdbRzZBAeIDfLIV0wiAGkLYCAXYAGJUaNx
         uvXXvgudwySMrXJDf8KEyw2A1L1G+f7aEjmCa2bzmvQUG6tP7retjrW989BCh2c+rPan
         0/L3aCb1h6TQHhF4TcABxLjXgfs8rMoK2gt945eTQ4eURyh1dEGPfT5TYk6Iwp+q9tIL
         y+bNJJF2LonEdcPLTDBIaPNQ5zyTHxwo2uRbJdQDOJbm4JC38TMf4lacEzXeAGbLmv3x
         I71g==
X-Forwarded-Encrypted: i=1; AJvYcCU8ETOj1zmznKek1pQxRzT0h4aAg3mhwdaa1GS7jF+ICKrkI3H3jWqtrvXikRxYM3BH5odMB/f9S/Ct2AO+ZbDc3QMs38ch
X-Gm-Message-State: AOJu0YxFStTKgaJMJLZ5/a0b0+OxwWjK1xh+5JxmXS6LEwshQQUIZBF/
	6hyCqZ1uEXmcnEZ/fxR1qWc3uZUx61jQHNYCFkX80Yceitg+tk874dbZHlJGLws=
X-Google-Smtp-Source: AGHT+IHPt8qPJfNY6zwmNDd/HxSdKl8es2KhWHULyHlWRefR96h0ssDbMq+7bTHcmVmDmmO1PEDsgQ==
X-Received: by 2002:a17:907:94c5:b0:a55:9e16:f005 with SMTP id dn5-20020a17090794c500b00a559e16f005mr3967131ejc.57.1713782407121;
        Mon, 22 Apr 2024 03:40:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s16-20020a1709060c1000b00a560ee2db26sm389281ejf.124.2024.04.22.03.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:40:06 -0700 (PDT)
Date: Mon, 22 Apr 2024 13:40:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: dsa: mv88e6xxx: Correct check for
 empty list
Message-ID: <d667834a-476b-4f33-9c94-10b3672b6edb@moroto.mountain>
References: <20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org>

On Fri, Apr 19, 2024 at 01:17:48PM +0100, Simon Horman wrote:
> Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
> busses") mv88e6xxx_default_mdio_bus() has checked that the
> return value of list_first_entry() is non-NULL. This appears to be
> intended to guard against the list chip->mdios being empty.
> However, it is not the correct check as the implementation of
> list_first_entry is not designed to return NULL for empty lists.
> 
> Instead check directly if the list is empty.
> 
> Flagged by Smatch
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> I'm unsure if this should be considered a fix: it's been around since
> v4.11 and the patch is dated January 2017. Perhaps an empty list simply
> cannot occur. If so, the function could be simplified by not checking
> for an empty list. And, if mdio_bus->bus, then perhaps caller may be
> simplified not to check for an error condition.
> 
> It is because I am unsure that I have marked this as an RFC.
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index e950a634a3c7..a236c9fe6a74 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -131,10 +131,11 @@ struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
>  {
>  	struct mv88e6xxx_mdio_bus *mdio_bus;
> 
> +	if (list_empty(&chip->mdios))
> +		return NULL;
> +
>  	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
>  				    list);
> -	if (!mdio_bus)
> -		return NULL;

The other option here would have been to use list_first_entry_or_null().

regards,
dan carpenter


