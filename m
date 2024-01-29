Return-Path: <netdev+bounces-66793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426D840ADF
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FE21F2300D
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115115530D;
	Mon, 29 Jan 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDNszNXe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD511552F0
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544638; cv=none; b=D1ET12OZJRo/Q7XjxRFS42cVvFB8fBuie/K6kqmNOZGEGpmQPpvMXoq/lArFuf9FmBWYgx78d5hRwrYmh6Vw+E3SizwwmWdjpRK0yHgFzARDAnk3iUtRucgulUDnx6CtPz2jj0oGGRW2sb5PqUe9Gai1HOkgA8lyC3/Qxa6vqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544638; c=relaxed/simple;
	bh=6rSRI2QI4j1oNMuMnM7Vlac0VWIiDSMt5/GovMCFjSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLKTnlaJkPqRd13sqhnXnftD5lXhCxbxlwDWms+RW6BBOgnC1hpE7/0r6jBCUPirLA5YmXHRDTXuNGV364YziwIqh+miYs6ujqyEN6ZWi6xzGns1WMmZMmv2MAElERBOGlzpNb+emoLmElmQzlO+YW8sXgLaGKBn2oEjb0ebi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDNszNXe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d748d43186so13763895ad.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544636; x=1707149436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNrVLetu+gTUFiDz8iSxZ3dn0tJKLzI6V7Bx276mGKE=;
        b=SDNszNXegUtsSW5tB+YFSB9+ZNSzT15LT0HHTBjCQx1/GCRCxWCXVkbcu/THGXIKd7
         +IjhASdszgesHUWCabbX94S+sP8ED2Nr9dbgpLLYmmU6cS6rGIp8gSFOSxnSKSWTpVNy
         hZmmh+5qIsoAlZzv+/4RHIR1eJkGfw+z018Ej507ElTQ48OHlc1K4+B+zH0faovB6EtZ
         Y2VYxbbUSGlbCdzMD6i2dBm16YMRnob2skUqUhHtnDdE4GFfEqhYJSVxO8J1gq/oBS+5
         YL9jT3BzeP7UiOcDe0Ua1G3Zgo56DCev1kJhjqACLDOaQAUbsc9MzA7iJ9sUJWG6Lt3v
         YX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544636; x=1707149436;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNrVLetu+gTUFiDz8iSxZ3dn0tJKLzI6V7Bx276mGKE=;
        b=fSTEA7Mrbrgqui8FbKsM0IrextF47uGvhPPLSWISKog/RNWrc34ZmiiOr6MsvWH/Yd
         /WkhLZCK3YWxK2Mg8N7l94QhNcxGuxzQo+6wDd+lIekopP+E/mdZSc4bqiHn0wf6bUev
         0jRt3FOiGb8mZkYxpZBU6hDH2FtmaL+0bfpuFfDdwUD2zIlwWA01JrA9XEcl6/T5hC/c
         YBwTonQKNpNwvSTsdBY3TRVaUXVpp5sw0yYOpRhlKmnxJp65Lg4uD0Riwh/NZIRVEqNy
         t6B3tTBYkdi2rqikYCCAv0cntw9xpW+DGoPXHXxyr+t6fPnAHgbSf9DJrLYCRZbumvGv
         TDAw==
X-Gm-Message-State: AOJu0YwiZXiu1ALeikTWad70PGBTc+jHTqnDbHrE5+P6gEWOm2Yi/jBS
	nKzj5tMPtpi8d1lSdGB2FZt8IMdyW/L9g+ULmX2H6SGiW+HK26lu
X-Google-Smtp-Source: AGHT+IFI9Cj21uqMaaiF3MTRFD0XY3v5LLVgxPDH95w5NnywQEoODqOO88RlUyXCe9l6ReLBfmd2zA==
X-Received: by 2002:a17:902:d512:b0:1d8:e2af:f7a3 with SMTP id b18-20020a170902d51200b001d8e2aff7a3mr2347446plg.60.1706544636110;
        Mon, 29 Jan 2024 08:10:36 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:8853:5abd:d9f3:2a01? ([2600:8802:b00:ba1:8853:5abd:d9f3:2a01])
        by smtp.gmail.com with ESMTPSA id kr12-20020a170903080c00b001d8f82c61cdsm850632plb.231.2024.01.29.08.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:10:35 -0800 (PST)
Message-ID: <4f81c6d3-b74f-4f61-9862-83ee84258880@gmail.com>
Date: Mon, 29 Jan 2024 08:10:34 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 04/11] net: dsa: realtek: keep variant
 reference in realtek_priv
Content-Language: en-US
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com,
 ansuelsmth@gmail.com
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-5-luizluca@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240123215606.26716-5-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/2024 1:55 PM, Luiz Angelo Daros de Luca wrote:
> Instead of copying values from the variant, we can keep a reference in
> realtek_priv.
> 
> This is a preliminary change for sharing code betwen interfaces. It will
> allow to move most of the probe into a common module while still allow
> code specific to each interface to read variant fields.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

[snip]

> diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> index e9ee778665b2..0c51b5132c61 100644
> --- a/drivers/net/dsa/realtek/realtek.h
> +++ b/drivers/net/dsa/realtek/realtek.h
> @@ -58,9 +58,6 @@ struct realtek_priv {
>   	struct mii_bus		*bus;
>   	int			mdio_addr;
>   
> -	unsigned int		clk_delay;
> -	u8			cmd_read;
> -	u8			cmd_write;
>   	spinlock_t		lock; /* Locks around command writes */
>   	struct dsa_switch	*ds;
>   	struct irq_domain	*irqdomain;
> @@ -79,6 +76,8 @@ struct realtek_priv {
>   	int			vlan_enabled;
>   	int			vlan4k_enabled;
>   
> +	const struct realtek_variant *variant;

This is not probably performance sensitive but should the variant 
pointer be moved where clk_delay was such that we preserve a somewhat 
similar cacheline alignment?

Regardless of that:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

