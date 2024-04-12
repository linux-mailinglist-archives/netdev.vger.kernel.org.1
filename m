Return-Path: <netdev+bounces-87406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6638B8A2FF3
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922BC1C23E60
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA183CDD;
	Fri, 12 Apr 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="MR/lIHgB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20F85C52
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930096; cv=none; b=Vh7FrPZJsV7TifKJiy7KVS3wpik8D+wUYwaqzihhOU32a9BRY8UyA5RozVHA/m8jAAoHO1GShJaU8e5nLAWM8fV3xzvBafiFuSDuPZDEl0iSu8rrhDa+kXIzlrIHAJwR1zodIq4GBCin7xsCDwpV1mQFuqplqMdcCmK8K3WsYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930096; c=relaxed/simple;
	bh=7sbPrtlgccNX5VLrftyI3NxeqI9zOjlHcD4cFbfQleo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvSDfZK4XZa2+GhXowzvgMUems0OHkb5XLTs6SlcMue+f+s+xHtYIVvALKcIBci2evJMWgS3rDVb1BRSuaRyHdP0+lHQYHx8eeEypZohuaIlZjRyRsjztviA6RxojiPqnKTDls8cqi1i3Ty234aRATI426zNIMspO41pLh8gtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=MR/lIHgB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-418031b617bso3101815e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712930093; x=1713534893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BRTJ151vm78v5ajnTv/XmBmg5FroaKqxcncoiaHZS14=;
        b=MR/lIHgBoLukUxx/rC1n56u4nWDqJSSV4YQbuV1ea0Kf1YK5WV8damlG+UsYPm+yKW
         ZSyzERMaRc8q3RrmTdi7Tgdcx60Afv+aWNaf96JlQjzc20byrdyRYW9opmu0jxzXkrdL
         Gj5kD1AdRyOJgJ2QCyvw3txrJ2iIJ9xIlu6atZgYHedooWNvYjDsZdLP9xiggDaQDTUG
         XDbR2QHB1ozTN1OgXuZ8Ddkg9puZWASVX1T+XVEW5w7i/qUQCFCv3eNN7PFAju+cCAuF
         minzni+aivhcQC1Xw/OtNnf8PMgUgiJUX6DXD5s0JthY+EY2568+JDSn7e4ppL1oYHnN
         kedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930093; x=1713534893;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRTJ151vm78v5ajnTv/XmBmg5FroaKqxcncoiaHZS14=;
        b=HxyQoxGboiiyico8pF7DPB8bsNUDYbPBYf0REAiy41aqCDHr0556+BxPdiqUEP6PTQ
         JQfmrwF7VgHUEhxOdGJjre/nqYkYbeyBADKOTmMnTIZWkJ6f4yhqzOX+9h12DQROwspA
         OuuNi++59piqLeFGNKtWWxVnOcXygsgvHFVS7ytNvpTpCuaRckRWU0i+jsrjmzF7JQXX
         L2v/he6gsh3V5tbVfa6W8xt4+7hkBrMeGRPGRPIQtq2e9yADv3cblILLM+bzh6Of+xQd
         rMgVF24BFr3SO7ulFH4l34LpA8L34u4XtRypJKPJwE1jQI78s6QHWh8bChZDV+TINc6x
         9Cpg==
X-Forwarded-Encrypted: i=1; AJvYcCVNnk/wABLrsyHErm+SJkG3oLe+JvBReefvwuWVVjJId+skXJjNCQlyyXxvBrd4vs1MM6bLfEpogEvxmRB/7wRkVVkTsPNb
X-Gm-Message-State: AOJu0YwcAQ/u5e72KspHa/xIo2xH96e5foFGilKTG+arMOn2e3bweVGV
	2OdiIp5s3jmLDXA1FqwD21JS2jIPu356HhtpJXKdpzem9FZeMjCiBVGtKDEdP2Y=
X-Google-Smtp-Source: AGHT+IEo2CM02HpshRdJI4lvrs/ktps538c4Gzr05lCk3RuMZ9+T3vAnZc1vw/+SqFdSpn6BtlYqGQ==
X-Received: by 2002:a05:600c:4e91:b0:418:1083:d2a0 with SMTP id f17-20020a05600c4e9100b004181083d2a0mr455330wmq.21.1712930093471;
        Fri, 12 Apr 2024 06:54:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:309f:895d:c00e:dad3? ([2a01:e0a:b41:c160:309f:895d:c00e:dad3])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b0041816c3049csm5401wmq.11.2024.04.12.06.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:54:52 -0700 (PDT)
Message-ID: <424a52f9-df2f-4205-ab9d-cd943b8a7398@6wind.com>
Date: Fri, 12 Apr 2024 15:54:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v10 3/3] xfrm: Add dir validation to "in" data
 path lookup
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <d5e2ad71471e2895b19cb60c9a989228cd9a5d96.1712828282.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <d5e2ad71471e2895b19cb60c9a989228cd9a5d96.1712828282.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/04/2024 à 11:42, Antony Antony a écrit :
> grep -vw 0 /proc/net/xfrm_stat
> XfrmInDirError          	3
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
>  include/uapi/linux/snmp.h |  1 +
>  net/ipv6/xfrm6_input.c    |  7 +++++++
>  net/xfrm/xfrm_input.c     | 11 +++++++++++
>  net/xfrm/xfrm_proc.c      |  1 +
>  4 files changed, 20 insertions(+)
> 
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 00e179c382c0..da5714e9a311 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -338,6 +338,7 @@ enum
>  	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
>  	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
>  	LINUX_MIB_XFRMOUTDIRERROR,		/* XfrmOutDirError */
> +	LINUX_MIB_XFRMINDIRERROR,		/* XfrmInDirError */
Same here:
LINUX_MIB_XFRMINSTATEDIRERROR / XfrmInStateDirError

