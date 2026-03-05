Return-Path: <netdev+bounces-264265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMmKGctUqWli5gAAu9opvQ
	(envelope-from <netdev+bounces-264265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:02:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D5A20F416
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7320C3111284
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501193793C9;
	Thu,  5 Mar 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0JLxhwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5A37BE77
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704673; cv=none; b=XqzqVQAyk/RkVRiqcNBzsCGMumi++2Hd12cl0Vj/SB6WjH687steaRSIwmnPgdajihx3ExlZ11GEaaWYY45tNB/6qJXKSIdDYvTj5POUnc3YrQuqNKcppBFzR9x/GTWK8WagGEaGmZonlMIt8rGIGCg7oNtSeZocMEpdtJhvQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704673; c=relaxed/simple;
	bh=jlkScESxNUogKkHaHRLJLXXp1SV4QB+oHCJ4HOMzlys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNWG/qS26vfrGicu6UhSetZNbqjRtJDQ4t4uI6FXJhO1D5lLpg32k9+0WjK2Op+tro7mO1ZZ8+Uy+IKgeat67Bt8j0ZNZBG4FkS4u8EkocTIUdLCKYVChcDju5ldKbD6PsUMGKKg8lGOejQkXhFGS520ADgwEFSvK3xSRT1k4NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0JLxhwt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48372efa020so69552795e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772704670; x=1773309470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7E9Qs1njpqB/a47bgwAM8gLGwtbiQTrMmbAWkFpwl0=;
        b=l0JLxhwtGDeLcprWte3EGqg66kYaawhJIRjnQsWP58N5o/uzHQXizzI3Z5u7YVFaN5
         Gh+7XePPHEoEJ5Q/aH5P48snkQqLvMEtjbWelGRQaajbIt674hzDHoimvfsq3d9JSXNJ
         z/9trzYYPzb3K6bshptfKNV7GVkkqJ5K4sIBjFlkRDTOPmw46WOq7J4yfJ94MkuN+Vik
         uJXvbURUfSWr/EjmF98UiBt3mQ/4s0r/sBJZWFutVA57EUeKOKJf5HKIwo6qRVbmtJwP
         X/lxQMFe7DEIQN+rpVQ1SwaZTEpFuZSbr9FdzVzwL7IrVoyqDAmAiS6q5PsKNpFtqUhK
         Y0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704670; x=1773309470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7E9Qs1njpqB/a47bgwAM8gLGwtbiQTrMmbAWkFpwl0=;
        b=jr6Sc/BNu+Jy+TsxQmifcmbiupq9Ru8HqhEyOdnxj4Nromyzdj3Bq69n3sw+L1TNJg
         icRdLsGOlmalR+fj6THuzBrjHqRTiG5wHYl0jJhyZtAciiuNMmy4tYXpnkGziyFAmmLJ
         qoLRZA/6VptMjp4GPIM8/lIBrA1j3/22zGeWQaCdrtEebmzJ7KYMnzCegq7dnrj+F52K
         k3OJHF4dS/5THfDXlXRIH2TsEddpISMvMnEXDmO2ntWb0DhB67XjsKIwEvRjWGEjptr3
         nPV/lSNj6aBtlAJIz7m0q1u9DCtgGMBJfkl025BK+e4wg3jx5a9X8Xmc0/kQLLEnKrX8
         5CqQ==
X-Gm-Message-State: AOJu0Yz1+7kAmoCp0/oe3i9ppsd3jMyw6REsalBUYXhV2imWFQjCpFK/
	8Yl2HIpsqriQz8GYSv2lDNmd9aN1FBawh07fzJf+MdzquIysJbWmBj9n
X-Gm-Gg: ATEYQzyiCwBJWqT6V3xFqjRAIXpRRvv5SZwNSMMUQQtlQL+5zOvdLIZGfUNlp4sEweI
	l4xU1gGgOf8bVHFr28QuRqCk7ZnR3JYdWNrG1bl/6tFoNX7DaX0agN/SqLZ3vq6u1hV8//0OLo/
	70k17A9S9V6FjSXBGt4Lh/7UErD0EyRIej/mkdhcpNENA3Hc6edA9FMpozTxiEYj86l2YEYrrGE
	ndUO4K958f2Hh4ul5bGWB2y3ss6ZnzYwPH4giHvfM/iDXDaMDYwvCW36OlfIZa/4oi+t/0KTDa8
	EFkitx9XsQvMubvOFEcCrOu1uJppISsuIgag0pk0AgjDdIkmGPEQA1OA4Ro7BRWwrTBEOGFGwPz
	msg4VP1RVCU+TEApyy+UmVd2iN2UjqlWkdr6Ypqd8QrFQWpPlomn7oEi5gQYTqw6eyYiIXMP9XP
	bUJ6jex235EjrQ/jYAYIs6iwsPcYzwSvLa/vDeRH+6NgrRwIPoyzQEyiEx6VeHeLi18AQd+Ngiu
	JqPD7Vi1vGbUWr1wmqX8SR1MgtGiXVT1TuUsU7eCqUtZW+FFSx+yBdLSoyayuNhOeW0N47g2Rog
X-Received: by 2002:a05:600c:6389:b0:480:6941:d38b with SMTP id 5b1f17b1804b1-4851989f63amr78243085e9.30.1772704669981;
        Thu, 05 Mar 2026 01:57:49 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:e300:adcc:a5d1:b048:7fb3? (p200300ea8f26e300adcca5d1b0487fb3.dip0.t-ipconnect.de. [2003:ea:8f26:e300:adcc:a5d1:b048:7fb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb3668csm51928375e9.13.2026.03.05.01.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:57:49 -0800 (PST)
Message-ID: <57990136-9635-4c6a-b949-732828d1d6fe@gmail.com>
Date: Thu, 5 Mar 2026 10:57:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] net: phy: improve mdiobus_stats_acct
To: Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Lunn
 <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
 <2ceeb542-986a-404e-ad0f-62e0a938ce7c@gmail.com>
 <CGME20260305083138eucas1p19943c4dec735b06f536525de26252f03@eucas1p1.samsung.com>
 <9433de15-8675-4645-a6aa-85458e833d2d@samsung.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <9433de15-8675-4645-a6aa-85458e833d2d@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9D5A20F416
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 05.03.2026 09:31, Marek Szyprowski wrote:
> On 27.02.2026 23:11, Heiner Kallweit wrote:
>> - Remove duplicated preempt disable. Disabling preemption has been added
>>    to functions like u64_stats_update_begin() in the meantime.
>> - Simplify branch structure
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> This patch has been merged to yesterday's linux-next as commit 
> 1afccc5a201e ("net: phy: improve mdiobus_stats_acct"). In my tests I 
> found that it introduces the following warning on 32bit machines with 
> USB ethernet adapters, so the preempt disable was there for a good reason:
> 

Thanks for the report. Indeed, on non-PREEMPT_RT systems it's still needed.
I'll send a revert.

