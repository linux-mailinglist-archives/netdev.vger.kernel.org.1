Return-Path: <netdev+bounces-146607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB049D48C6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C2281BCE
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0A1CB32D;
	Thu, 21 Nov 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HzbnfOO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DE1CB303
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177450; cv=none; b=P/UODUSnfV4CSGV/5A2uACy0jF1h6pmPMDD0bm7dJEAF88LnBCLpa5qVkiVB3NOIq+RGGzOEGmBEvuL33PiWKQ9FzXYCIxQdmAoiz8/oWC5+eifq8nO5APO+Sv05P2Y/dfz5v+usXuuGH/00Lr2X/XyvlrotedMISHIHLCQWKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177450; c=relaxed/simple;
	bh=SjnNjj6eEjhkdS65B5/uDkp8jKyB8727x/5ZGdDTNM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLbAqjgKjLcdHwLtVfxZyucS+YaXvBws+XUvas6xptTk9bq6YN9W+cTkX1hsoYsebPb9HLREooMj1jUr83GHxgbMdI0NESyYv09/B28qRpSCba/8PrBzqDbiI6VhCFB8sAVNezYvqkvDEi4iIeZhrYy83nSpzIJwgi50WDHwHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=HzbnfOO7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43160c5bad8so161535e9.3
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1732177447; x=1732782247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M1sJfTwn7Gyd084YXpAF+iK6+RJm+FhconOKLhhofXs=;
        b=HzbnfOO7LiLFbWTuOYlKEk23imEZtRgLPz3z1PkF8oWyMOm8R7QM0sLqB8HY90RzYF
         Wi6y/o7adTgTgS5k12cjKOW9u4xPGjM2xfn4PvqYdqOrdN9HNIJCjSR3zn0wOUPajmFT
         S/GEQhTv2a4+g7QBvBs1ItPwGODWEwEiDdLj7MCR5Sjy++T1QT4FQ7wfXjNcw9d5/Zmn
         zvav38pxyjS5adHiNbY2HXrKX0H3OWCj/JIWR1crL99YFJKGtvgZZ9aa+FGOw05YSDX2
         edzId9XuZqPtfxWtejkwr43rObwH0TnsTB8bnOTNPnh7oAkF0x6V4QsHhCpqEiW3R+Yg
         4mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177447; x=1732782247;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1sJfTwn7Gyd084YXpAF+iK6+RJm+FhconOKLhhofXs=;
        b=Xj9iyWxXVDgtHOi5fhVdmmvt7sIBG3It3WVXWNJWV0XMMonAmC7cUfMltPC+jnaKzU
         b8SdTQQUh0n4Pge6ysjSv8vvlj+LtxGImdib7Ewvfo+HdQiWgiMGLmKlB5Jz3Zw103CS
         J6hOqzTQgsQIVlXHZNyfm7SRie7WvczEjOeW6A4Y/pVqyXEbfi+strJ6VIK0/r13+eu9
         deuvFZ3I7W7TruDAqetx1+0bvinS478Q2c0++a097oac3YNRc9Mfbjoz31b6wzVu9VQN
         uKAHqCbGIacAsKzb++XCFaKE2e5zXJAYY3+70s+po2TWi4s8YWaREgHw7aj4CPspltG3
         5fZQ==
X-Forwarded-Encrypted: i=1; AJvYcCULvvtsEJrYN5EwfhAEQ1okVQk5I0BTKvIM3ZpEvkxplmxceRVonNSNCJuayqR8eLsy6GfVl1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YytowAZl8UrA6D4JP3zpJGJwFclyGIV4vQvP2bXtqOtsSXJpHU2
	KyvpcX0cK56DAeTAsjafYcSHoxCRpFBRFyuZpMxeVMQqDJ2KCuXU77zJ88kR/o4=
X-Gm-Gg: ASbGnctMsqAHWOOHTPorRuV9H0/sN2NU7FjSSen19MuYHKm27sQOwRYuGwE1gsdDA+d
	Qcvfl6Hn08Bt3BJ16WAFGlPahqUQ9I5NdVqZ7WQmY0RzovS6dax9pgCG5dPw2kZ3jlvazES17y+
	+ll1sBm7cj2soCkdsTIAENxaCYrcNJys77PHQ8BDV+SvaPOpoGlONeZzQSChKeSRmotPfTKf1yV
	2KkkCcXGbW+xfMXBxpmQCgQn+pz5FK7jzGad+AuKykPZipAZ54cIVVS5YnEhk5hF5QiOPe3isNo
	cUjAl1Ive88cr5maDM1C4OlJVuE=
X-Google-Smtp-Source: AGHT+IEs5rFa7LQSDMqAm+y4pd4HRXOgjMCNgppccy/tI5bWIghbZ3mlTctuJQq56mR6HnS9FLIOyw==
X-Received: by 2002:a05:600c:1c9b:b0:42c:b9c8:2b95 with SMTP id 5b1f17b1804b1-4334f025af6mr21527315e9.6.1732177447009;
        Thu, 21 Nov 2024 00:24:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:cbfa:348f:b057:1762? ([2a01:e0a:b41:c160:cbfa:348f:b057:1762])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46359b9sm45019925e9.36.2024.11.21.00.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:24:06 -0800 (PST)
Message-ID: <a68fb3e3-e461-4192-9c5c-d3b0864dbeb3@6wind.com>
Date: Thu, 21 Nov 2024 09:24:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next, v3] netlink: add IGMP/MLD join/leave
 notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com,
 jiri@resnulli.us, stephen@networkplumber.org, jimictw@google.com,
 prohr@google.com, liuhangbin@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>,
 Patrick Ruddy <pruddy@vyatta.att-mail.com>
References: <20241121054711.818670-1-yuyanghuang@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241121054711.818670-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 21/11/2024 à 06:47, Yuyang Huang a écrit :
> This change introduces netlink notifications for multicast address
> changes. The following features are included:
> * Addition and deletion of multicast addresses are reported using
>   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
>   AF_INET6.
> * Two new notification groups: RTNLGRP_IPV4_MCADDR and
>   RTNLGRP_IPV6_MCADDR are introduced for receiving these events.
> 
> This change allows user space applications (e.g., ip monitor) to
> efficiently track multicast group memberships by listening for netlink
> events. Previously, applications relied on inefficient polling of
> procfs, introducing delays. With netlink notifications, applications
> receive realtime updates on multicast group membership changes,
> enabling more precise metrics collection and system monitoring. 
> 
> This change also unlocks the potential for implementing a wide range
> of sophisticated multicast related features in user space by allowing
> applications to combine kernel provided multicast address information
> with user space data and communicate decisions back to the kernel for
> more fine grained control. This mechanism can be used for various
> purposes, including multicast filtering, IGMP/MLD offload, and
> IGMP/MLD snooping.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-mail.com
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

net-next is currently closed, you will have to resubmit after the v6.13-rc1 is
out: https://patchwork.hopto.org/net-next.html

One comment below.

> ---
> 
> Changelog since v2:
> - Use RT_SCOPE_UNIVERSE for both IGMP and MLD notification messages for
>   consistency.
> 
> Changelog since v1:
> - Implement MLD join/leave notifications.
> - Revise the comment message to make it generic.
> - Fix netdev/source_inline error.
> - Reorder local variables according to "reverse xmas tree” style.
> 
>  include/uapi/linux/rtnetlink.h |  8 +++++
>  net/ipv4/igmp.c                | 53 +++++++++++++++++++++++++++++++
>  net/ipv6/mcast.c               | 58 ++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index db7254d52d93..92964a9d2388 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -93,6 +93,10 @@ enum {
>  	RTM_NEWPREFIX	= 52,
>  #define RTM_NEWPREFIX	RTM_NEWPREFIX
>  
> +	RTM_NEWMULTICAST,
RTM_NEWMULTICAST = 56

> +#define RTM_NEWMULTICAST RTM_NEWMULTICAST
> +	RTM_DELMULTICAST,
> +#define RTM_DELMULTICAST RTM_DELMULTICAST
>  	RTM_GETMULTICAST = 58,
And you can probably remove this '= 58' to align to other families.


Regards,
Nicolas

