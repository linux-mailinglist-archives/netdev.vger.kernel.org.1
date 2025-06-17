Return-Path: <netdev+bounces-198609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D79ADCDC9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E410D3B3CBA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174F2C032B;
	Tue, 17 Jun 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqib0UJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E661E1C3A
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167767; cv=none; b=dZBk+qvBoP922Skpgg5Jw++dXtMrH2dRO6MK7YlsZeSrH/Q9rL18inR+qlROZMT2UqD2RiVWheEg622Uhc5E4C04xGL70yRaM1i8Ckgww67EV6xjtweT4wKLDhd3g9sZX0Jenm4GAE4w4ksxkor8kjHGgidF1BvG4ebKib/4jYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167767; c=relaxed/simple;
	bh=VMXGXAOaXtwtT3kFAHDlI1OI5EbJdQ0OqsUaxSEymnI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kJqKoq3OG7z7Qv05xDTGCnvkl4Evmzrjs8IyVQ6NUZSunOiY2XZQ23b1y0H6eyfdeCDSPx1pZM6vnjdUlI8Dod3diAi+MLLBhCz6U1OcBAOFeV5yeODRNjGdjAi1UYrS/Bis4QP1P7cCjn79qYTl4mLYvn0FMheJW8JrydFudXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqib0UJg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453066fad06so43342365e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750167763; x=1750772563; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsQ5Q3kNIt7GCFfmHvW8O/B4Ra85tcsQXzF+b32bKaE=;
        b=fqib0UJgxgPvx+8fAohqJVubeHQyE1VqdneZZpvmw8xIs/Z2Jmf9OamtCCW3Q9UE6T
         +1hrpPm1QNHgVa3kQBbunfGyBSU7DVgufJWMlXpqRQHdlL05gpiZgWprJUUhxGKttG1u
         2pNuG0gk4fxVrRj1hJWoviV+d3T7YSuI18/Eh2X7GTDQDcWRh/7U0v0kFZmjWi5Ugg+w
         HXRdI6LSLFijXlGhE+Sqe3ea8IayR4UAvJ0wJczah9LwOjnTNEbrBrMBOm/0+1YQx0tt
         ZL1RAHqChptEKprSPrHCgQw1BH1+9jGNbqwgU5c1oAdcwKpFpB4S0mh9fEa91J/0BcHs
         9uWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167763; x=1750772563;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsQ5Q3kNIt7GCFfmHvW8O/B4Ra85tcsQXzF+b32bKaE=;
        b=Ij5RmKbLKBYIkaibB+7VP+OSvzNXyViXhuvWtydchAwfSLHo14U5TvxBjbCPLpPwin
         NtxlCRsEv5Z0FsRe6S3b69oeWApergHLJy3LKrmLp3GhT4vgQfW5QaNJMdKhN4Pn+cT/
         bTa9yqdjomJmwtoC3vq9G16lPTdK/TxS49aH7qIwREwTa4VGdpw2lUo15z5bHa4ZC6wk
         4FiHtLQQon4DNUtlL59cJtk4drbhpfVu8La4vFzSyP3tVaMDOhM4NZQwugLBGVVL/Pjz
         sj279/SIDm+DCS+4wuyEG/oTl5qru9oBWpUardQOGtafcffp9lVN5udldMobfyjnRqxk
         0pow==
X-Gm-Message-State: AOJu0YzlbmH7N17UmX4VqwqyMITs23G9lCu4BwadbvUMXEnh7jMzg8BQ
	xQEjkJcdne0AmCrk2lwhypZWsLYrI4//JVt5VYYDJcLzx2EYvwMmqas9
X-Gm-Gg: ASbGncub+JHlk3hODdG1/KNu1ZFneQyHra9B9aYtnTbTXIm9wU+WUSGzANOynPlhghU
	CJemv07PeR8URCBuGevW4G/BtAGRdxZ1zanicTZnwIj804ls9CjCfoAYYldVnqf+enkPmmF65ge
	l3mjenUeLk84ehTgdRFwlqSsXRYETa8lAXiJgmnQx0Up68gUJ+eOjsShIXxmtO20gotBywMY+mo
	F0yQexw44E3raeuLJ3KVW6NYv6BZuF+MK8sNRwbDplQhxz+yQl1AgzWScUViM+8Ikh97FDKLZcv
	w7RaO/p1u8eK3nO11J8KmM2oWmG+GrdbGfhHWY7nguuQjDLbiVeeR1YzaEX8clv6IBg30Yt1VaB
	vUPotkHNVscZEsQA=
X-Google-Smtp-Source: AGHT+IHPJ6CBmMtbIdDk+tf0CrReuT0aiXUUsBaVtAzlbinqH4LSg/pWQMttBb87Dt/A5Yl3W1o9/Q==
X-Received: by 2002:a05:600c:37c3:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-453561ce33bmr10965395e9.21.1750167763211;
        Tue, 17 Jun 2025 06:42:43 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a58963561csm1773358f8f.47.2025.06.17.06.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 06:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Jun 2025 15:42:42 +0200
Message-Id: <DAOUOYHC2G4F.2SOAYIUMZV3QY@gmail.com>
Cc: <netdev@vger.kernel.org>, <decot+git@google.com>
Subject: Re: [PATCH net-next] neighbour: add support for NUD_PERMANENT proxy
 entries
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Paolo Abeni" <pabeni@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250613134602.310840-1-nico.escande@gmail.com>
 <df6b49bd-0faf-4c5c-a900-459e76f40536@redhat.com>
In-Reply-To: <df6b49bd-0faf-4c5c-a900-459e76f40536@redhat.com>

On Tue Jun 17, 2025 at 3:25 PM CEST, Paolo Abeni wrote:
> On 6/13/25 3:46 PM, Nicolas Escande wrote:
>> As discussesd in [0] proxy entries (which are more configuration than
>> runtime data) should stay when the link goes does down (carrier wise).
>> This is what happens for regular neighbour entries added manually.
>>=20
>> So lets fix this by:
>>   - storing in the proxy entries the mdn_state (only NUD_PERMANENT for n=
ow)
>>   - not removing NUD_PERMANENT proxy entries on carrier down by adding a
>>     skip_perm arg to pneigh_ifdown_and_unlock() (same as how it's done i=
n
>>     neigh_flush_dev() for regular non-proxy entries)
>>=20
>> Link: https://lore.kernel.org/netdev/c584ef7e-6897-01f3-5b80-12b53f7b4bf=
4@kernel.org/ [0]
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
>>  include/net/neighbour.h |  1 +
>>  net/core/neighbour.c    | 13 ++++++++++---
>>  2 files changed, 11 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
>> index 9a832cab5b1d..d1e05b39cbb1 100644
>> --- a/include/net/neighbour.h
>> +++ b/include/net/neighbour.h
>> @@ -182,6 +182,7 @@ struct pneigh_entry {
>>  	netdevice_tracker	dev_tracker;
>>  	u32			flags;
>>  	u8			protocol;
>> +	u8			state;
>
> I think it's better to be consistent: either store the full state (u16,
> without masking) or a `permanent` boolean alike: !!(ndm->ndm_state &
> NUD_PERMANENT).

Sure I'll spin a v2 with a 'permanent' boolean then.

>
> The current choice could confuse who is going to touch this code in the
> future.
>
> Thanks,
>
> Paolo

Thanks for the review,

Nico

