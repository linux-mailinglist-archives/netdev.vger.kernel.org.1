Return-Path: <netdev+bounces-200549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636DAE60CA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5CA16F790
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9A271440;
	Tue, 24 Jun 2025 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSdGhIir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8171BC9E2
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757065; cv=none; b=WLJcnH1pqs+NRCTpKngs1EiCV/DehUHnod7FvGwiNeRDfNl41498F5LqYo95vSES55sAliQWnY6wdjZ9vYnXNdsN8wWirRHa6D5sBUJxqy62Xwm4Po5PVTfZ8Fxb/LK687tJ6kkts2+UWbLhg0PvOjzAJcgM/w53R7y4TiyrKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757065; c=relaxed/simple;
	bh=OOAaPBCoGc1x522s8OGPkql2FlMbcmpbBFheWsuu+ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3k1A2Ypc145oORN7yU1e3Lq6ugA1Kh4SLrS3RMJnCZ4bA+E2cyUDegRl0MatbNoOjtmjktolM/oZlzUNePAl0q9lXuFY9aQHD6KijuzTnSrJiB+qz1YTR7DKod5y5x3hjPRSAZaDuKD7+CJHIg82/cIHrDAjuUwwd9t67s+VMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSdGhIir; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade326e366dso943221766b.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750757062; x=1751361862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4Wzj1ONd4I92ud2wodp7eqHo4gMAvlR5sWpKppO+IE=;
        b=PSdGhIirWUamfXX6wfG4Hr3yhXGgZeXCdSAmzC1yVYRnYDhY1+6yxOE4pAPj/0nqjK
         /OK5yUIT+5o5tFXxbVOu+ppljbJZ4aMKYYUvYyiPMQbDw4iZjW0Xa/On59tyFnX2TN1m
         B9IU4oJwFIO0ENPtquwcWfq5/WG+qGoRlSd1qAf0MG2EOuAKkWBYYE2ASXaxSEGeEP2g
         vsvXDwfJvGmku3LDrLSefxVlEyZ/9RHZ64p2LRaPM/TjtxhkZcORPirpHMM3iVmChUdv
         24ruNdI0wCOJZY1KMRX8W1fh+3YJVh89GtGoOkE0+/ccLUoheZEs8AyD8cJDOGzlIzE7
         PVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750757062; x=1751361862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4Wzj1ONd4I92ud2wodp7eqHo4gMAvlR5sWpKppO+IE=;
        b=p5MmO3IHLtuxQKUS2/voUtc6D1quJHvGPYsRHglWMfJ/a5FZQKQNW8xXKswXrSKI6n
         r5lZN1MXO/PMQ2CgmMfkFwLJlzFRhig1Zrp4mDs3hoTnU0o9DSxpPfS1+PKk5bCyh/2u
         hwKsMkUgd0lWeC2wDns4WUy8lhOxkhY6olWTxcMYPdcPZ/vrtfsGzqbgfzVyi4IpHJkE
         1jo0lqMB3M4Ts/eqwp19H/WP5ffMnnHREfaDgQ2w1yskx/Vzh6DaCZmxiSIXTuyeJ1Xa
         wpJXh9+1rUMf8yaLj4RQnnshXms26iYL2t0Z/LNHliyZopTUNLi3tfNQ39FP5yga5Oa4
         luug==
X-Gm-Message-State: AOJu0YwKtsBgtZbRezR3SsyGTtMLd64zX32qKQhJuIZdh4Y8puJUD6ue
	e4EDYeCgZlsgGlP8z7tfLkY8Tl+KxLviuJ4la1ie6uo4ujFWlB4oBloU
X-Gm-Gg: ASbGnct56u/1iVXHldJPRyYmopbXzN9NyqfHyj78mWClkKFoY+LicY5xy/r3KHGK9h/
	c+k94a74gkgCrUzXCv12HdZ5ggGBaPrUwqXDHdTeGbHe43TVBjzPCew3Z+YeFYfSJh8h1DUWbTP
	6ptip6Nqyk0o4Bu/32Fph0Jk1rwYixyA2UBynArrn25N4qNbQO/sb8JB/J9VLIxR8/VAgGHgUNy
	Et8UX1Bwsq8INZSY45KZsaRj/VrrF2ABArcqD77CTe9XVaLVu2WZGn/+EUAcl3ZJYSckJt3WDJN
	SJcwAMSMxFjUeK8TlZ4Nh0FXHPax8onB/wz51iUR3EPnCDRsbU2JFWUkuTSLbMwPKyBuO/nHOGC
	VjQlrIIkvago/eMycfwWphXyfajBDQ40UP22qLREsggpMpE+t7mvA68M6ijp7prAOAfuF1kLY6q
	Vu86R8unrlU0whx+A=
X-Google-Smtp-Source: AGHT+IHOGKuGH7Yeg6NWfhyPwSVuXL047bcbV1p/UsDIEvEi67bjaHTDm++3lo/n7HGNogQWrwkTbA==
X-Received: by 2002:a17:907:3e17:b0:ae0:6a5a:4cd4 with SMTP id a640c23a62f3a-ae06a5a518cmr1184420466b.12.1750757062080;
        Tue, 24 Jun 2025 02:24:22 -0700 (PDT)
Received: from ?IPV6:2003:ed:774b:fc38:d9ac:77b7:ed46:71db? (p200300ed774bfc38d9ac77b7ed4671db.dip0.t-ipconnect.de. [2003:ed:774b:fc38:d9ac:77b7:ed46:71db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b10645c1sm52483066b.69.2025.06.24.02.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 02:24:21 -0700 (PDT)
Message-ID: <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
Date: Tue, 24 Jun 2025 11:24:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
In-Reply-To: <aFosjBOUlOr0TKsd@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/24/25 6:41 AM, Cong Wang wrote:
> On Mon, Jun 23, 2025 at 12:41:08PM +0200, Lion Ackermann wrote:
>> Hello,
>>
>> I noticed the fix for a recent bug in sch_hfsc in the tc subsystem is
>> incomplete:
>>     sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
>>     https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangcong@gmail.com/
>>
>> This patch also included a test which landed:
>>     selftests/tc-testing: Add an HFSC qlen accounting test
>>
>> Basically running the included test case on a sanitizer kernel or with
>> slub_debug=P will directly reveal the UAF:
> 
> Interesting, I have SLUB debugging enabled in my kernel config too:
> 
> CONFIG_SLUB_DEBUG=y
> CONFIG_SLUB_DEBUG_ON=y
> CONFIG_SLUB_RCU_DEBUG=y
> 
> But I didn't catch this bug.
>  

Technically the class deletion step which triggered the sanitizer was not
present in your testcase. The testcase only left the stale pointer which was
never accessed though.

>> To be completely honest I do not quite understand the rationale behind the
>> original patch. The problem is that the backlog corruption propagates to
>> the parent _before_ parent is even expecting any backlog updates.
>> Looking at f.e. DRR: Child is only made active _after_ the enqueue completes.
>> Because HFSC is messing with the backlog before the enqueue completed, 
>> DRR will simply make the class active even though it should have already
>> removed the class from the active list due to qdisc_tree_backlog_flush.
>> This leaves the stale class in the active list and causes the UAF.
>>
>> Looking at other qdiscs the way DRR handles child enqueues seems to resemble
>> the common case. HFSC calling dequeue in the enqueue handler violates
>> expectations. In order to fix this either HFSC has to stop using dequeue or
>> all classful qdiscs have to be updated to catch this corner case where
>> child qlen was zero even though the enqueue succeeded. Alternatively HFSC
>> could signal enqueue failure if it sees child dequeue dropping packets to
>> zero? I am not sure how this all plays out with the re-entrant case of
>> netem though.
> 
> I think this may be the same bug report from Mingi in the security
> mailing list. I will take a deep look after I go back from Open Source
> Summit this week. (But you are still very welcome to work on it by
> yourself, just let me know.)
> 
> Thanks!

> My suggestion is we go back to a proposal i made a few moons back (was
> this in a discussion with you? i dont remember): create a mechanism to
> disallow certain hierarchies of qdiscs based on certain attributes,
> example in this case disallow hfsc from being the ancestor of "qdiscs that may
> drop during peek" (such as netem). Then we can just keep adding more
> "disallowed configs" that will be rejected via netlink. Similar idea
> is being added to netem to disallow double duplication, see:
> https://lore.kernel.org/netdev/20250622190344.446090-1-will@willsroot.io/
> 
> cheers,
> jamal

I vaguely remember Jamal's proposal from a while back, and I believe there was 
some example code for this approach already? 
Since there is another report you have a better overview, so it is probably 
best you look at it first. In the meantime I can think about the solution a 
bit more and possibly draft something if you wish.

Thanks,
Lion

