Return-Path: <netdev+bounces-149011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24FB9E3C7B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7590286660
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B41F7096;
	Wed,  4 Dec 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="O4Yv6u3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A51F7567
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321830; cv=none; b=b71sBK0FvXayixMmmGe1hpmLG0sJsS1V5e28smKVkSJg0eg6rDV0NZJATncpvJ9KN2esBs8/p3EQ5HvsQMwg54CQGiC+sIzdZZ+ijN+d6e+JuhDp3d4M44gCKrA8DnMDOtiTLyxEnHx+7gIFS6V2BQY96I+7iOthxs7vRdG498k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321830; c=relaxed/simple;
	bh=2jNZpjY9xzTGNLFxTpYN9O3Jitc1oXX9PkIvQCAlAGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtmThtklSsW4kIQYR5Y3EGBASt+m7HmwqeOawcC4kJEJXhWfOrkJDXwVYSW9s8FE403VUz5bP1b5YJlOiCGXlZOrtleYFPzj4G7Sw3EkN2/vuXUqYDxukuxYL3PT/gSO6PbTAxNsyKNvIMC4Hy+zd0wkPgYoaDCRYR5hpPyXFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=O4Yv6u3Z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349dea3e0dso6954775e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1733321826; x=1733926626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5e02z9BRjcYbgypWAiToL8s08sXQAtJrzLjgBIZbGZo=;
        b=O4Yv6u3ZID8HDWw3zwXOlIwOvisUsjU2oo7frqNkb+Tfsed9KQwvu4z6RV4P95lHvy
         gzd0uf5qSL/S6vTt25XphsWDhQAyfzH8TA6z3dqqNRgEY6UcNK5l35BogcO09o5ew4LQ
         s7ZyZ8Wmp80T1vmMzpBd5GRc/Gkwcq/qi6ievLMB0N+YKLn7rVwnjtlecr6SWler8R4h
         lcGvIwtObF5FxPksgh5jwce9Vl8DVMiBzrAYkYBYxGVwVsn1l0VZDX+YZp4gsj+GMPGL
         JxxZXGzBnhFHF0XUmnD7oQciMs/20mm35H7EufCSOJnwJdhv3eey5EzsDddVVOQ7Y5TV
         otHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321826; x=1733926626;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e02z9BRjcYbgypWAiToL8s08sXQAtJrzLjgBIZbGZo=;
        b=ddUr4kpiZGVdE4KU4LLFwUGzjSIct9AXCgv+FyqGmSexBaV1WeII57xS7xR98M8joa
         2UI2beDjk5DOI49C5Zs26lXIOIJYNHBI7iGlGWRCV3HtvRHCGQXM7RbomkW1a6p39sYZ
         oJGVJYMgI1k9a8HjNkmX/S1v4ZPpUGIp//gMzVAy94TQGTGFuiRz5DBICCF8pGT9nhaa
         TnFhXniaEL+C49q91j6ERbNX4qEmAxFgjJXOjY1WiASEoksv7xLNPSsogp5cqk4YnMU+
         xo62nWm0OrQFnlRwe2IMq+xigrzl4V7nYh3SejmsNqubhhj6w51qS7gtMIGn/QPmiQ+u
         VZhw==
X-Forwarded-Encrypted: i=1; AJvYcCUcfkcJT2DEQ3hr9kg+2ZWpgnJL4MW9oGo75fvo1IWwbK6vtJfrT4F3tH67RQPvCxmZW6JXZBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKPPzP+xoUnD8zphE2cwyWFJGuaotFv0lsUxpq5+yhBhkPzFX
	JxXAQQfEOztOETKiWtCeYxMNomjClXurSaJpVZzkaNqrgno6QUPATYlAzEPUnVE=
X-Gm-Gg: ASbGncvsa4Xt/4m+GHjb4hyDXiXcWJAV6KFqBD3/tyqaAi/p4eHQP44RSUqy76D0gXR
	usJJfgFkEeLhEeDp0tjflwHGhq3fSFAKva95qyYjE2w6HqeGWRljPY/94uevk9ycCq4fcKOpdv6
	+A9Vp1HynWo71hycknIMnt6jvAlJZ3IeXIE8DatcwxQPiY58wUdeTfHbmTGGG7rWRBM8pzlOYRy
	5nnGj1Jiv3V0Xth6eLSBk9hRWW2SeHt9fMa4ox9tSLBO5Xf0pNXiD412YLSlbgLVRtfCFNFHQp6
	Av+PXcPOTLFCGPExxkdDbAZfKvk=
X-Google-Smtp-Source: AGHT+IFshaiJNDb1mhVbT5b4BQ7NyFVvmr+8vi62e4u4Wqui0kPooAX7Oy40UEvM46S1mbPjCOR0gA==
X-Received: by 2002:a05:600c:4fc3:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-434d5fc1990mr6884335e9.6.1733321826422;
        Wed, 04 Dec 2024 06:17:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:f6c0:3ce8:653e:656c? ([2a01:e0a:b41:c160:f6c0:3ce8:653e:656c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm25567555e9.13.2024.12.04.06.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:17:05 -0800 (PST)
Message-ID: <7057e5e0-c42b-4ae5-a709-61c6938a0316@6wind.com>
Date: Wed, 4 Dec 2024 15:17:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2-next, v3 2/2] iproute2: add 'ip monitor mcaddr'
 support
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com,
 jiri@resnulli.us, stephen@networkplumber.org, jimictw@google.com,
 prohr@google.com, liuhangbin@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20241204140208.2701268-1-yuyanghuang@google.com>
 <20241204140208.2701268-2-yuyanghuang@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241204140208.2701268-2-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/12/2024 à 15:02, Yuyang Huang a écrit :
> Enhanced the 'ip monitor' command to track changes in IPv4 and IPv6
> multicast addresses. This update allows the command to listen for
> events related to multicast address additions and deletions by
> registering to the newly introduced RTNLGRP_IPV4_MCADDR and
> RTNLGRP_IPV6_MCADDR netlink groups.
> 
> This patch depends on the kernel patch that adds RTNLGRP_IPV4_MCADDR
> and RTNLGRP_IPV6_MCADDR being merged first.
> 
> Here is an example usage:
> 
> root@uml-x86-64:/# ip monitor mcaddr

Note that 'ip maddr' (see 'man ip-maddress') already exists. Using 'mcaddr' for
'ip monitor' is confusing.

You could also update man/man8/ip-monitor.8


Regards,
Nicolas

