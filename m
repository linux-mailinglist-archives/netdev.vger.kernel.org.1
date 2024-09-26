Return-Path: <netdev+bounces-129891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112D986DDD
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99781F22BF6
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 07:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3D18E37A;
	Thu, 26 Sep 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoRxoCGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1AA18E02F
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336585; cv=none; b=P+7e8J7qaOP45MxmR3G//wbE6AsC8u496a5oe2wU3ee+Eoa7RmlJU9Kb75CmssV9S0YelztnpbkZGVN5X5exfyw2izJEot1SDT6F2BpeWoP5Fi0QLn8YWvV/YxS11T7UGzr8mVM77u4ALCd0SJ1d9vWXMO1h/+q6Lc+vyIb82D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336585; c=relaxed/simple;
	bh=Co1luChoJHsdq2vqvdMeBJyCwtJfjexDP06NvkmQ69I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TywX7n6LWSrtl/jOi5XlBGIKvpz3zVAAtSu4Y36iwZp6yX80p5D27B+QANanryxIwoiQvQS42k+o4A+2DiKp5ehSrmMT/Rmf1oziMdWTdj8RFTGqX13Io+T2dRKVypuuDaN25vNV9ncF17C1XdcXn/YfVri1VK/J/462w5OIgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoRxoCGj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5389917ef34so501257e87.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727336581; x=1727941381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbwcmR4OKXr2n3LKBkkPHXd1kG7uBs/YkPsPrBZR64w=;
        b=eoRxoCGjhk3REEPcCj2e6/HlSmHLf7mYXNrNpF4HUTPrP/nSeQYNjmyrB5h2aRUcSs
         1nmzykav8NuZ7NjhorSCkc43vuWQ3yhcrXeOJHkdrfKIemKZbTpIdztN5EIOcgEw1JyS
         gl/ByosA70Y0+uIaVvrWOcyM7tMIDpMZAZnzkUb3oSY2FYS5IXRLwdSabjVxnMDXg9e/
         +CoJFmTYabtVbSgbCWb/ZZ61Hv3TWjpQzZuB9FE0CH9NzOaT8ARP5dsPPZerDWrfECv9
         UI3y0UaMCvQYHgSwqHQ9nHC/swRji+X24q9uS2HgnTNAQ8dVJLvYXbd1O5tWOT1GscdL
         jtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727336581; x=1727941381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbwcmR4OKXr2n3LKBkkPHXd1kG7uBs/YkPsPrBZR64w=;
        b=G9zd1tqzQWliN8h2KcWuK+Pbwwc8Xc6DrmfvWO/pBmLYF+o8WVnh5QQhemp5KlTw/0
         xET8VHHktjd7cKMVrlLVIUmFc6XrMH/jwBHbpTWiOJ+F02+xeR9c2tq73AuviPliMy1j
         XtapPfhHIK8Q22JkAc9+sqCbqzLOmqw2bCHGN6UQjX9jOCIqlw3dfzYM0MW7jDRXrzgp
         BDWGL+awNVZO3shwIPTo3KvD9A+4raJrsHX8NES3q9r1EtzCYW1d6UXnKJ9ygUE4u8zG
         4w/1nT1w47Jdx/LGtjwKPAoCleFtR3oCS1IqY1r0wvoe5uTokvpumFzalPi7QyvMcBHp
         Erxw==
X-Forwarded-Encrypted: i=1; AJvYcCW4PBYFGTL/9zXAcuaHR0jg6+9o3Job2Ao7Baxq0Kmapq1ZjXg86Rts5P5Rf6zVq6hgC5KVkVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+Z2O0KvhErCO08JxdG6w31LYm1qmdjmKZmSxnLmdZZh867sC
	A8dgjqDg/K5JAWbFtqcubQcIHTD/5Mm8c1jvz/YmG+ZoSRL3rFyyFR2zgpl7EwHg7wKCeB+JAYg
	qfGOZ6UAqdXlZiaV/pdeIAOEEZ5T3cw/09dti
X-Google-Smtp-Source: AGHT+IElm/0GwEFlAjEclu2UmQX35ZhReU9j53E2Fx/Cd4qhbXcKfVFRinrUmfMI9XsfOBnzzE16W9ZE996T3vg6KL0=
X-Received: by 2002:a05:6512:3da3:b0:536:54df:bff2 with SMTP id
 2adb3069b0e04-53877568fe8mr3599723e87.54.1727336581235; Thu, 26 Sep 2024
 00:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925212942.3784786-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20240925212942.3784786-1-alexandre.ferrieux@orange.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Sep 2024 09:42:48 +0200
Message-ID: <CANn89iKDuODR=HasPhEkp6tFFD0-kcU2cZRgWenDr6fsPcziuA@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: avoid quadratic behavior in FIB insertion of
 common address
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: alexandre.ferrieux@orange.com, nicolas.dichtel@6wind.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:29=E2=80=AFPM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> Mix netns into all IPv4 FIB hashes to avoid massive collision when
> inserting the same address in many netns.
>
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>

I think this targets net-next tree, which re-opens next week.


> ---
>  net/ipv4/fib_semantics.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index ba2df3d2ac15..89fa8fd1a4a5 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -347,10 +347,12 @@ static unsigned int fib_info_hashfn_1(int init_val,=
 u8 protocol, u8 scope,
>         return val;
>  }
>
> -static unsigned int fib_info_hashfn_result(unsigned int val)
> +static unsigned int fib_info_hashfn_result(struct net *net, unsigned int=
 val)

This can be 'const struct net *net'

>  {
>         unsigned int mask =3D (fib_info_hash_size - 1);

mask can be deleted, see below.

>
> +       val ^=3D net_hash_mix(net);
> +
>         return (val ^ (val >> 7) ^ (val >> 12)) & mask;

Please replace this legacy stuff with something more generic :

return hash_32(val ^ net_hash_mix(net), fib_info_hash_bits);

>  }
>
> @@ -370,7 +372,7 @@ static inline unsigned int fib_info_hashfn(struct fib=
_info *fi)
>                 } endfor_nexthops(fi)
>         }
>

