Return-Path: <netdev+bounces-249042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6BD1316A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC461300B9AB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8E24A049;
	Mon, 12 Jan 2026 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP7rd36s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nVMNyCMb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99824BBFD
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227471; cv=none; b=Q5l09JQJcUX9LweeSzFdVr60Q+UyqjCRbJKgLuYwdpNDOKAXSis0BWPT4Urj/NgOGmCV8EH4Ich1PH8ZEDhTmkoAPBqvNw9bcfB8tA5/bj4mIS7wwMoUdHJAG5Yc9XdzAJnMA0oyeHIf9FOG5vXu+NcfT5yG5R2+k/CjR3W3hJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227471; c=relaxed/simple;
	bh=gWLgqx9Px4ttCfjHBwmyfqseiILCYPqYzjdcUy1a1NE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b1qrkAVmbYzcewRUx6GkG/JaDOorD2Uh1gUpUuMixghVbnBZI2+6h8KBxM7pMMFShIXL8W+YO7gwsFDgLOzale2lM9Z+mAjV8V2tg04wvfnQaPsVSUuJTTqYVV+TTNtsWvKju06R+6UA9ZPDZvWU/aWxOZSPOfjmdAHQYNwTets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CP7rd36s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nVMNyCMb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768227468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccP6OACDWYKEad3mdDJUsSE8Czfq656stuJDEwDNdYU=;
	b=CP7rd36sPrk0Y1IVP+VXSS+B+Dg4Y3gRzRNfPoUtmTE9bEFIB0gA8xg6jkq9otig/qaP//
	SwchT7o+Qkak2B2LCwEtt306vK952h9PpcvJnZ2CbKZg36FopU16YR2+V1Jc7nZaBnwf18
	jye+v80yRarJa0T7rxUb83YEXkMH1dM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-0XbZwZGjNtSatIGeTihIqQ-1; Mon, 12 Jan 2026 09:17:47 -0500
X-MC-Unique: 0XbZwZGjNtSatIGeTihIqQ-1
X-Mimecast-MFC-AGG-ID: 0XbZwZGjNtSatIGeTihIqQ_1768227466
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so51063685e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768227466; x=1768832266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccP6OACDWYKEad3mdDJUsSE8Czfq656stuJDEwDNdYU=;
        b=nVMNyCMbqa8TZAedmckJgxaJ/+1jrMppwyUrCuxChMlOr0VWeUAKmGHW3a1824Lssv
         995sKwzE2WLcomkr4GicMasezGOjnLfDiz3CKrTyiiKyiy3lbZALFq8SPkv8o+zwGvvA
         xO3T8AwDpSrXMR1xfGxb+qR+qFEJR/KtCfdz5ej4t42fm47gECJRwcNS+EkljXEB4YTD
         HgCNXvOb9P12TPRfmB0gBeD0sU32WxvXgYojU6zPXZ5kSALZK4lH+IvjZhTnBgf5jXUK
         46SbGduJSJQGnCa4ecGCfjC34gftvLKtdqy5F8iZmbgfMcpW8SdADaRCbN3QaOW6sWJd
         pZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227466; x=1768832266;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ccP6OACDWYKEad3mdDJUsSE8Czfq656stuJDEwDNdYU=;
        b=pfwjN+QMLhXv4fqlL0aesviq7atVIld30t3YnR4LcJodio10lximY+suhORCoeGBuY
         qUNWDRmKDTQwUJgf1wbGNZjx+pYcvYf/h6OpELfZIn1WempddYfpP1co3MyQ/ncBhiyT
         iyb7/LsPJjPwcAtJZTNOTLMLNdx9wXGJE8MC5+iXhxaygWtSQBsFPBaYY+rse0chg/AC
         x+3iUjE0IRyBoweaKc4bjrSrklJ2J3JYk7+03cZ3Gb3f5/6ga9im3QJqzwaJQjqdfAzd
         MtvZj/k7v9hF2CTQzjI0K4DQFhmhzTAmQ+We0htrUdVFOBaRSKIndUv3dEFikFp2v0dF
         9DKw==
X-Forwarded-Encrypted: i=1; AJvYcCXOrhfzru6JAqk2uthy6VSWIFVWcRs56DhrAJbq5Zs17e0OQ7baoauwNz+A/rK+67JY9Iz9z9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgLFK8UrAo4SVFKGNmMhFTL97MHR+NyZ8IgLqSC+Jlp9Nz1fP
	yIPBlxiN34buyR162Y0574sHbDU/a0/474nY+/QYLNpq5jcEuKHtM0iQczrbdxTbdR+YlZkO3Oz
	oAJdHGLi2F8wR51DYRvHp6AJ2P4yksDzj/ef/6LuIdvew2/lhS8Z4IYW70A==
X-Gm-Gg: AY/fxX6/FaC6Are+6KzO0OA5vswhEE+gSoY6lwAIgd0JuulABZUMDiRxj2USm/jpopk
	jU6fz9RbhDjXgP/75HkdiUbSHCfINOZ4a97kZtgNx2jQySVCg5a/1OlaeAEvpju7/NnpJlhT0VX
	Ujdpxy0DRumBVarfBOWVVJseyNEP4Fg5hC4DV8l35TDDr6vgP+ZtKxLC5wsyHe4S9XS0w6bULBo
	ZZGgaAmnCizfoPKiZ1Jv2LtyK84GIE0ZlGKsVfzXYbmzcmeIj5RCJmjkee49xa2C+gQs2oc3y0Y
	Z51U/YZE8Ggb9EZNeNpOEb1rys55SU1Mr9OWUBzcNRHpzD3NFrKuh7ZcYmKbQKzKBbXGvjIYc97
	RtELdcm1dvvHti4XWgX67dySbqXX4CZB8FJr5EYJpW368t6s=
X-Received: by 2002:a05:600c:3b15:b0:47b:e0ff:60f9 with SMTP id 5b1f17b1804b1-47d84b347bbmr179276105e9.20.1768227466048;
        Mon, 12 Jan 2026 06:17:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEovxbZOIqegQ/IO/5UbFDz+TlkskET29hbOvBI52e0QUi2p6Iz1T0wmy/M2NhVCC6rSDF6qA==
X-Received: by 2002:a05:600c:3b15:b0:47b:e0ff:60f9 with SMTP id 5b1f17b1804b1-47d84b347bbmr179275795e9.20.1768227465641;
        Mon, 12 Jan 2026 06:17:45 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f390a69sm353846025e9.0.2026.01.12.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:17:45 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 5/8] cadence: macb: add XDP support for gem
In-Reply-To: <DFJBRX0BOZ94.1YAHY6PVCGA0L@bootlin.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-6-pvalerio@redhat.com>
 <DFJBRX0BOZ94.1YAHY6PVCGA0L@bootlin.com>
Date: Mon, 12 Jan 2026 15:17:44 +0100
Message-ID: <87ikd6oqyf.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08 Jan 2026 at 04:49:45 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> Hello Paolo, netdev,
>
> On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
>> Introduce basic XDP support for macb/gem with the XDP_PASS,
>> XDP_DROP, XDP_REDIRECT verdict support.
>>
>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.h      |   3 +
>>  drivers/net/ethernet/cadence/macb_main.c | 184 ++++++++++++++++++++---
>>  2 files changed, 169 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/=
cadence/macb.h
>> index 45c04157f153..815d50574267 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/workqueue.h>
>>  #include <net/page_pool/helpers.h>
>>  #include <net/xdp.h>
>> +#include <linux/bpf_trace.h>
>
> Shouldn't that land in macb_main.c? Required by trace_xdp_exception().
>

that's right, no need to stay here

>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 582ceb728124..f767eb2e272e 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -5,6 +5,7 @@
>>   * Copyright (C) 2004-2006 Atmel Corporation
>>   */
>>=20=20
>> +#include <asm-generic/errno.h>
>
> This is a mistake. For example compiling for a MIPS target I get all
> errno constants redefined. Seeing where it was added it might have been
> added by auto-import tooling.
>

yeah, it doesn't look right. No extra include is needed here.
You're right about the auto-import tooling. I just noticed I wrote
this on an lsp-mode/clangd config with the related default option
still on.

> If needed, to be replaced by
>    #include <linux/errno.h>
>
> =E2=9F=A9 git grep -h 'include.*errno' drivers/ | sort | uniq -c | sort -=
nr | head -n3
>    1645 #include <linux/errno.h>
>      19 #include <asm/errno.h>
>       5 #include <linux/errno.h> /* For the -ENODEV/... values */
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


