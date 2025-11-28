Return-Path: <netdev+bounces-242605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E54C9293E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 17:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 536D434BF75
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750927934B;
	Fri, 28 Nov 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="E76gFo06"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E91264A92
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347326; cv=none; b=PACtPA4fMIoq1QxNgevUteyaBME7gVIrjSxiSbGBlH2Nvfj8WYP4UvFZWOR5Q+Uf9muu/NxI9F2SdAPIIOKSWrRlaizTHmkkErcvGo0pcL1ds9zeAANOI6gGss5O6wSn2uJPiBLBDkGH8UoZ+NoPm/oLIP9DAd8rn/EfI725ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347326; c=relaxed/simple;
	bh=/J5DRG/yhyH9XScdI2xlix5typiMEgqrrQ4NkG024cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhqHqoKlRyvRRty7u7JT+gJF4y1NYHTUBwo7c5tngnkxO4qxLEw14vCnbQrMnCX2o2WZRIkpfy2rYEsFttOuPqAEPZ/tGJsmylYK/8BfaIjWvri2mZPARpl4MFP73XwtY2fSo7QTFfqWMRik6ZBVq4kqMg5OCoegbx44RhKtL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=E76gFo06; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47798089d30so843485e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1764347322; x=1764952122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MWVgBR86+gsQDl43dudSj4r2Y18LxRKUFKptnCVF5qk=;
        b=E76gFo06cUymsyIGew3x4p/ywRBC46KJTw9jjeR3rrdb+RASiywtPIcBl8y7XHCj9C
         zlK6nJta94p97VMR0PyG7v5CwCKznVoBWPXN2VwBC5jY4yHi5T/ywX9a9dSounFay7oc
         O5TdCJ64b3w0nB6AQC9BIqbZyJfrIg2cnBmdA7sJynEprWRldesuZRmV1AwBrNq84ptK
         iwjtajC35B5OPGZbArdvscaoyHhW+de/NI8RCA3i4kqdDguEVQyVKyJckbsQQJ2rFJnz
         NXWT5D1nD/SjhweP5X/kbwcLbl1ULVXFIGp1F7PgJ69yFpk5n4hgeeKxIzQuyE8AWDZQ
         H0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764347322; x=1764952122;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWVgBR86+gsQDl43dudSj4r2Y18LxRKUFKptnCVF5qk=;
        b=b0B19FldVZZRf8SxMpqSw3ZkzWXn5lLWLsBrWeIrjPQQGX47GDyZEQBBDC724L8w1j
         tL2owhcKdV+NbRy5DiQ69AKyjRnsh0sS6EW7CiuFftBnaXAA1pMasJkgWNAjKrUHg5/a
         HKPlx11RR2FTCgkfqEHb/uVSEp6zswMytX6Jvz313saDrIm9+KrwvCDGq7esCmmEK0xZ
         CDvemdE7nHrhksXsG1yk3CxUKuzRnNOoqrmQE/dMRgx6h4CNVJswWYMceHYY0Uz/YovQ
         XzdheyOVkO8ezuX6tpLAjU6Ad51Vh0cIPgXWKjn9aE1Iuw0enTlsKHh2LBk1761PFl//
         jHYA==
X-Forwarded-Encrypted: i=1; AJvYcCUF4ChKlCs1t3MI8KntEBrHsc0V3EUjkum4VQgLrcM5HVwiKTrFPL2pmEF/5vYNoGlhcUY+kR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMcTwO3kWv+GZJLw3z+aciTGrrGmP+ts5H6wAeOsouYj12fMx
	D9XGRb1Vc5vRr3VEZM0YUVnEC2TKW4Xa0y9aHfwluOHcbSJPuIijWhtQ5u9TQRe/EFk=
X-Gm-Gg: ASbGncuZME7+4ZvAC2398XNx+RuYakOJ8iwjJDtvduWW21+TCuHF/RiONSaCCIt007Z
	MrhHjdJChW0IvPQ39GvVIww2tt2gwRUUCZN5UXtnQQuCuhi4rTjx4XP6kz0r09LnptYwLHKAR2a
	Wsojy+bZJZaii9RqaqhNC80DnpM30f9Pi4rbJLv/j5jSCgOCHraMw9EEE0m3h402YHYQOxFgFEL
	rwykVqMXT5K+S/2QB+KdFZlxd6RJ+sUDf2RgjnmqRY/exBUAI+gb5n4kwzo77F+wfoYWFPZ9EdT
	tCOyb25PKaUfAEbp4WTPOZn/Ag4xZvwpMo/x2WXJRs2R4oJ/C7mUXtlJ6lbFX+Rpn7/JLG9kZkp
	e56q5Q1LySscJOKPh8ZxiguxMBD2qEgdPNY3/27w6fsWunntVM4yBnW8TehUYvwcxGm0n6GtH6w
	ECkonJFCplnn8uU5W62TzVHv5aOraK2Y88QtZaRTD+v6SNPMfwsa8r5ywM2f7XOXA=
X-Google-Smtp-Source: AGHT+IGARX+vVQA/ipOb8XQbNYsHjW2Pu4QOj0ibN5i5pI/TS6bzdCqP0DFKw+EtW5me+7loi2pI3w==
X-Received: by 2002:a05:600c:1d0e:b0:477:7b16:5f97 with SMTP id 5b1f17b1804b1-477c2ac5615mr166427635e9.0.1764347322489;
        Fri, 28 Nov 2025 08:28:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0cc1d6sm154441115e9.12.2025.11.28.08.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 08:28:41 -0800 (PST)
Message-ID: <56a0ec5c-da92-4f92-9697-71127866049b@6wind.com>
Date: Fri, 28 Nov 2025 17:28:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
To: azey <me@azey.net>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
 <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
 <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net>
 <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
 <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net>
 <da447d68-8461-4ca5-87ae-dcfdec1308db@6wind.com>
 <19acb23fcf6.126ff53f1199305.3435243475109739554@azey.net>
 <19acb2c1318.fb2ad2c5200221.6191734529593487240@azey.net>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <19acb2c1318.fb2ad2c5200221.6191734529593487240@azey.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 28/11/2025 à 16:54, azey a écrit :
>> On 2025-11-28 09:38:07 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>>> With IPv6, unlike IPv4, the ECMP next hops can be added one by one. Your commit
>>> doesn't allow this:
> 
> Hold on, I think I understand what you actually meant by this, sorry.
> I got too focused on regressions from the discussion in v1, I'll make
> a v3 of the patch that allows dev-only routes to be added via append.
Yes, that is what I pointed out.

Please, add some self-tests to show that there is no regression. You probably
have to test different combinations of NLM_F_* flags. See:

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/ip/iproute.c#n2418

