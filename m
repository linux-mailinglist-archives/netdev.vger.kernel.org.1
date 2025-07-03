Return-Path: <netdev+bounces-203659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BAAF6ADD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C9A4A486D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D6295D92;
	Thu,  3 Jul 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dh1tWdqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81924293C53
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751525902; cv=none; b=hPipmp4f/VYirfvEF7FNTlwlsOGVDtnrokUlGyuFXzpcmEPefsL8UhtXC6p4Jpohhqsnnt3RBe8/WKH93WtxqXZhrtECvS6f+bwsprITmARGlcSkA2tlVJmoB90xBSdG9qBj09ea6NVPpc2LGYYzOLlabqYr5nNhtPZuESWHGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751525902; c=relaxed/simple;
	bh=bickAPlR7/NP79mWKt8/KneNlEYimMJnZ+NoqIvI854=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3UUefx1mJ/QwyVWihNGFOtaseIv4ygXpb+6eZF8NZSdDpQIl5XrlPp420aXwsvU8wuf9a5Bt+7S55R7rTZq7dDGcjYAduihfrzhB1//lkqSDdZfcDpxAjWZSOsH1MXdYccy9lU2rTJy2Z0eUguUhDzrKwAjThP3QIfPsuN+MYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dh1tWdqt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a577f164c8so1044617f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 23:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751525898; x=1752130698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uGKG5g4X2FtIIBBBni+nAn11AVuFyvfdg7Z2wu+7sP4=;
        b=dh1tWdqtB6NPRpo0/mK42wwS3VGH8FsFkNqIPeIBLmg2QY0JnNQYPvTHM1jVhMFlgE
         GzB2f+xQMNHHNfYWjtScja1t9a+QNdGQG9TMZc7eHL2qzKu9XgbFFPhZNdKL8tey+GWy
         WTT7UUPUJegTvHMkoI7HuC8xzcHny0hH36hPfjMFDEaYMl3u1VgaBKM4PKs7G6FNW8O7
         EBLSHSWkFMAF1Zu3cRCQWTCWrkNxVtt3C7zgBVG0oCLLoUR73tHtNWhM/32/XDzs+OdY
         +EmF4HdNtwnp0btOurmMHkZ+r5HQEJOVf/KpGbiwfxCz+jUYTG1l+PzElCNtxElkYd3N
         wpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751525898; x=1752130698;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGKG5g4X2FtIIBBBni+nAn11AVuFyvfdg7Z2wu+7sP4=;
        b=gsuoytZDjWWYmQIhPRKArldaqSxdheKyo1rHLPoNZzgKX6YoYkSbNmioJnMAy/joT5
         BEGDdIMhom/PCGp6lbwXg3+6kdvVO2WsEC7Xh/Wa7NRkEK0PugvyhVqXTFqZMCv+a77C
         8w2dymL+v87bVLU0PByR2BJvUsaL+273H4cVhicS2sgMGeuAUuG6JppL1454kaLNn83A
         Gb1yWKKzho9ZnsM1K5WMzBOulaE2z3L7cGM+z8NTarOdXwdNUVPf9FGGlQnkN/QkBviM
         CRN9azMfBdT16uAHy3je4I3hqlEEkNPPs65rLMorv++vWDq1PFpoImk1MYfa5FuCOwBI
         yRDg==
X-Gm-Message-State: AOJu0YwH0QI9UJ1rZLlgzekOBEFCdpjTvn9fC3rGqR67Ay0BgxjtQwcg
	FFA43cVywz/crl6ZEJsN8chZcHQ0C45hwCAukB4yNOfuiRn3LtaFldRS6TnawN1ESqYo6pEDvob
	uO2GnpKQ=
X-Gm-Gg: ASbGncuXe2GI37tH0He5a/hl4E9QGQGWcD8IZMdqkZ0S2wpXEEyy8k6zYgWGuKqeXz2
	R8mDu4TrZ4DavFP52Bbw6UWYiQZJV6fw+zlwVhahQKBmAwF0uas0wejRITnkmtke7+YyJ1XF2q0
	KTPS0XQMOzaQeSr+43vu76+MZHK2KAQ3G5iclelUD1AjM54ckKEzz79TrGcr/ssn09BpftLQoUl
	BFW9M1lPUu9JtG90qTnnr852phkQaQ4udcyN1U+Fv12pWqOwZqhrm7jYPoqfYAKsaVToz+6uOSe
	uQ5BgNN81yDo+lG8qmrSFB1rWA8HDxzCTfTheSfmNLfOR0/Vqx62jb3aNy76pB812A7K4135zJP
	Pf9xtZhGHHVDdUAOnDAOwahEz7LOB44RJn/OGmVs=
X-Google-Smtp-Source: AGHT+IFFoiiowVu/8wR0tlX292EVRJFeXC5GLN8cUKtKtyQtGsaIToPUA9LCF0OxS2wvlY0ljK8jzQ==
X-Received: by 2002:a05:6000:24c7:b0:3a4:dbdf:7152 with SMTP id ffacd0b85a97d-3b20110b371mr1611335f8f.14.1751525897572;
        Wed, 02 Jul 2025 23:58:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:5568:c43d:79bc:c2ec? ([2a01:e0a:b41:c160:5568:c43d:79bc:c2ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm17977144f8f.72.2025.07.02.23.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 23:58:16 -0700 (PDT)
Message-ID: <869cd247-2cde-46bd-9100-0011d8dbd47c@6wind.com>
Date: Thu, 3 Jul 2025 08:58:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Randy Dunlap <rdunlap@infradead.org>,
 Gabriel Goller <g.goller@proxmox.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
 <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com>
 <53d8eaa7-6684-4596-ae98-69688068b84c@infradead.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <53d8eaa7-6684-4596-ae98-69688068b84c@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/07/2025 à 00:26, Randy Dunlap a écrit :

[snip]

>>> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
>>> +					    void *buffer, size_t *lenp, loff_t *ppos)
>>> +{
>>> +	int *valp = ctl->data;
>>> +	int ret;
>>> +	int old, new;
>>> +
>>> +	// get extra params from table
>> /* */ for comment
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n598
> 
> Hm, lots there from the BK to git transfer in 2005, with a few updates by Mauro, Jakub, and myself.
> 
> 
> More recently (2016!), Linus said this:
>   https://lore.kernel.org/lkml/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com/
> 
> which seems to allow for "//" style commenting. But yeah, it hasn't been added to
> coding-style.rst.
I wasn't aware. I always seen '//' rejected.

> 
>>> +	struct inet6_dev *idev = ctl->extra1;
>>> +	struct net *net = ctl->extra2;
>> Reverse x-mas tree for the variables declaration
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n368
> 
> Shouldn't maintainer-netdev.rst contain something about netdev-style comment blocks?
> (not that I'm offering since I think it's ugly)
> 
It has been removed:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=82b8000c28b5

