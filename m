Return-Path: <netdev+bounces-144103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848FA9C596E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F16280CB8
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733801F7084;
	Tue, 12 Nov 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Nqw7WWGM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACDD1F669B
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419116; cv=none; b=BGybM/bRjklwd8it2vE8UVxO0KmWJEBDClPly1+JfGTCgnumQUUlKpCTfCecSwccefgTGKvCbVR8HyY8oJZ/IHRdgP+GuEkzL3tCBUZrmw3JwX4ixXdX5nkzAPDNJRWHBFvvlhSKOUin9xrDfWbtgR3zEbCuh2A69Vz+PTUzB3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419116; c=relaxed/simple;
	bh=eK0JgUnvdI4BgI9OFi4xRyjtO2I7lWU2ZUIx9sD+CkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqVnsmgxoEBkJttG5wjXn3Ezi51CKL2/s1boGYv26anZ7oDHi8fIL5MiBIT65jbXfFRycNLmFX6cYEK2Be/ZwFgmHH5NtlO3+0vSLIowPx5xogtSvMfvwTAal8oSu+Dc7axDXQfJh071hdCV+AjXVa4maZhDQmC59yjtyKg/5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Nqw7WWGM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d7351883aso30190f8f.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 05:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1731419113; x=1732023913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XUKWYCOEO8JraKmH92gxAesW35gt2ceY4seF2B0tcR8=;
        b=Nqw7WWGMM8U/R0fD6E+hae70VWlLXnqB3kRuZtlb7LzAxW3CbCn+kRKF72RFXEB2Rj
         ncL1cqOG3JvN7tIjaAQAxzRErk8nmx4vltKd2ZT16BhiQ2gf/PzYxW13o3GTi3HY54OH
         zY+c252/N2nzxsj87/zGjtl+drmimtD5iyRz7BRSHhkapT+0C0z1gdH3681hatC9sI2Q
         iFHR9LEMy3oz2IVgMHvssMo2pvVDtfG/0wgEkrIZCLEjcVOJR31vDlWeAmWfBCNa8oCy
         VWzkMVNW+x3Z7/sQMLCsc6R9Z1VN70pTKUf2KNZwChlWKYKFVsWfslC98mlIUnTXtHvZ
         JQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419113; x=1732023913;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUKWYCOEO8JraKmH92gxAesW35gt2ceY4seF2B0tcR8=;
        b=s1gS/l5mGdvMHWlB28mqENYq2TS9QPfqdNPfyDuRCNKR3n8QRaVJBcAXZSEj6KVTBD
         0jGMZo+XmM81VIytB6NnvtoWj84C/uwGjbmilxwq4o8lr/ryDjT4Y8JzkgWnouH1hUP0
         5uFVeaO9cdJNSprsO64iWoJl2JB7bz/+XJgo9LU5V9fOpTiX3gS2Fg/efcR1pEr17CUO
         qNk/+zYrKDN+AxXPlwuTuX0sY+Gflc3xidtizYdo/KpvN1OHXJCmx+RBiRiAqP6gk/Lm
         iRcGXM5D5vg4BDAe/YpnMJb75Smoj0+GkDpWj1U484QLMeKUdhXa1+oFr3xWjF+NmMdi
         jKXw==
X-Forwarded-Encrypted: i=1; AJvYcCW6op+ExWNWefRylNF04j7nbzcLFY8YPI+3Yi8PWF6zgeU+8s/9GurfQGMnUkiedvFRX7c+JYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ie2aNN1CelXLEsswVrX/x3Ov7dLXy03QuEalxKJfc4OvSNzj
	nCJVIAF7xzJj0Arr3r+MbmsYTy2ly0hob3vECm6A9aAFrxO8pEYg7iULUg8gEMs=
X-Google-Smtp-Source: AGHT+IFC2uvQTtCNvqM6F1wITvf7NEB509E6RV01YibxNqNR7lMwXczEkawL6IQkI+EJe4oTWh7oyA==
X-Received: by 2002:a5d:6d04:0:b0:37d:54d0:1f15 with SMTP id ffacd0b85a97d-381f1838d7cmr5393970f8f.7.1731419112750;
        Tue, 12 Nov 2024 05:45:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:e183:c608:12da:8b26? ([2a01:e0a:b41:c160:e183:c608:12da:8b26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9706e2sm15782062f8f.7.2024.11.12.05.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:45:11 -0800 (PST)
Message-ID: <ef98012b-559c-42fc-831f-d8f54ca65b1b@6wind.com>
Date: Tue, 12 Nov 2024 14:45:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com,
 jiri@resnulli.us, stephen@networkplumber.org, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>,
 Patrick Ruddy <pruddy@vyatta.att-mail.com>
References: <20241110081953.121682-1-yuyanghuang@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241110081953.121682-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 10/11/2024 à 09:19, Yuyang Huang a écrit :
> This change introduces netlink notifications for multicast address
> changes, enabling components like the Android Packet Filter to implement
> IGMP offload solutions.
> 
> The following features are included:
> * Addition and deletion of multicast addresses are reported using
>   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET.
> * A new notification group, RTNLGRP_IPV4_MCADDR, is introduced for
>   receiving these events.
> 
> This enhancement allows user-space components to efficiently track
> multicast group memberships and program hardware offload filters
> accordingly.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-mail.com
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
>  include/uapi/linux/rtnetlink.h |  6 ++++
>  net/ipv4/igmp.c                | 58 ++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 3b687d20c9ed..354a923f129d 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -93,6 +93,10 @@ enum {
>  	RTM_NEWPREFIX	= 52,
>  #define RTM_NEWPREFIX	RTM_NEWPREFIX
>  
> +	RTM_NEWMULTICAST,
> +#define RTM_NEWMULTICAST RTM_NEWMULTICAST
> +	RTM_DELMULTICAST,
> +#define RTM_DELMULTICAST RTM_DELMULTICAST
These names are misleading, they are very generic, but in fact, specialized to igmp.

Are there plans to add more notifications later?
What about ipv6?

>  	RTM_GETMULTICAST = 58,>  #define RTM_GETMULTICAST RTM_GETMULTICAST
The RTM_GETMULTICAST works only for with IPv6 and the NEW/DEL will work for IPv4
only.

Regards,
Nicolas

>  
> @@ -774,6 +778,8 @@ enum rtnetlink_groups {
>  #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
>  	RTNLGRP_STATS,
>  #define RTNLGRP_STATS		RTNLGRP_STATS
> +	RTNLGRP_IPV4_MCADDR,
> +#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
>  	__RTNLGRP_MAX
>  };
>  #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)

