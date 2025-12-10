Return-Path: <netdev+bounces-244277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA77BCB38C5
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 18:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8FF53004428
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EC301014;
	Wed, 10 Dec 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LpPMk0GC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A593B8D68
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386045; cv=none; b=R/lFlX0bjV5sjb8UIqfYY5q7bGSZtXFH8yRTxS/q2NWyLnQH3V4dhK7+i26cOWntqS7k5EefWFBjFjzjbiIp71zeT7wadfeiq4PrDS3NI9SetiBmTTQCNhB8AgdqrePBCSqByjrtrnEWnkFvWXYfEQ8qHNes5aZdWk9U4jnBj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386045; c=relaxed/simple;
	bh=FBmwFdk8KmfQOZkTTcpkqcEG4/3NqAXMQcceK6coI64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz5N1+Lk0/i02K32jKkVeYqvhstUjGgd+K4wsnL4dgtGYeN5i93Tz8WQEqfI5S2IHMORQdX3Rq4t9Dn8rl6oK7tyQ3ySZr81n8qweaAA+ZtwrE25zvOkZwh1qW4ksD0fGKKSug7Y/ejRX2NRGVn9NcbwxVyTYHSeodSqAJ6RVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LpPMk0GC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b737d4cde73so109721766b.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 09:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1765386042; x=1765990842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tD08r0a78l8/LQa4IKNrj3hiCwXxjQYeAIVJcC5GLJc=;
        b=LpPMk0GC9HOKE2e8pfyzUpfGf8NX1Qu+t3tQTAklR12jYbO0xGvYyxxVCKg2dFV6f7
         imcGJviVgF0yZc9D20xgWjfwlqnDN4WdELgw/GnvIQhnt6HgEonwT2VHld/gj7sDCzP1
         RnHUptnPBTQNin3OWVAgBPlzUVQmvD2oL5rdZuTuO69iCI3twQdmIrft5o0Skv3/sTZE
         XV+oFYI7GTM5UayMHlQnQ92+aGKQwO+5lbxisof1zZme/EPpOShs/I5jAb5XwM2vVY1u
         cMYK5OVSaxvQFAaowz5z0q+N4ARvHLgA8+gHwfT+sVZaCf8Booy9DaMLBBHM0UrN/xxW
         uXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765386042; x=1765990842;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD08r0a78l8/LQa4IKNrj3hiCwXxjQYeAIVJcC5GLJc=;
        b=ooBl0JAOt2/GHBVctmaqYzK/O59So7e38QBUa6t/c7OGDNBKIJl/xPNTi8LZYRS/Bl
         FsaktrilxT9cBFKxGk0/kCcrot6hxUob/lrhl8rh1ECAyxJWC7orJqRQVl9H7Dh8/0TZ
         Ae/ka++mlTB0IEUOGIoXQ6CG2CeMm0h4FuB10vdd94O00BgObyeZUlHm2GTqAk6EDEhZ
         8RfcW8uWTsmMpkeA7bVJYHQTcxNRbm/S/F50UfIVD6k/jlcdMKrpZGhFzcCi+kEIdmfZ
         ERB/4fP+KlnJBo9rEHIwW05I692ai6EqmGL8hF0YiClJ+sUTBUHv0NYD7wuWymhcL4gS
         m5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXujJlDpz9eGa972AqDjg1U9496vzHtoe453axRcywx6issJ1jmi/ANoC0AZmSMYcAvbLcp3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtIM7MGq1hcipJGHyKaMXtf9BYeoU0f6hP8pl2u2xCgsUg6dl
	VMonOPAFNaikGPs4JwxaWaWfHkP8uBBxwK1IsqQjcpKni+OpEExYaes1GQDvMpK7dFQ=
X-Gm-Gg: AY/fxX4gsXo02nn2/XMgCu3nuYogAv0V266rzbcgClohtcckflNu4YOrp4yU5sZ4UxU
	gz/1lhdX1PR41ZTO5jc3O1h7y/w2A2stA/YJJ1ESuaAsbManAz/+05MqS62V7ug2gFGCOLf7kT/
	qgNFy5pk2SNCowSpRYYQpAG6aGAraIQrSbknZX+OKMjS7msTzcPnDxaPQ0mrWYFV3zxxq1uL2w4
	Fp0HlC9Doke1f9YFz6JQxccrjDpvoY//GkoMSiLonH6+1gSzGyOv484MKALcCjQO4YtJZNG27bk
	oepEbyrvTMcpy6DwFqmnCi2NYngA86ErqNoLF3OWU4YnVxegbdRWSztY3EnedGXdl2U1uHEHoe0
	alj0zwXIGusUmZP3/tJDUT/gNjnfJRHORs23KElO2YWQ4RW8E5TzawoyXqOd9+FgprE1C1skWKZ
	uZk9I8bnBa2dLsIODqVH1UslVnVo4ktvLi+9jMnA9P11ByyAeUJN6AfNWqUHNMeYdztkBbb2wOk
	g==
X-Google-Smtp-Source: AGHT+IE9b2TKWKWerHCea/Hu7xxQ/Xr/I7f97pfyo9JbDmp7y9fYMSzYQ7ko2TC6vwBUEau8SdvygQ==
X-Received: by 2002:a17:907:2d8e:b0:b76:7e96:8b79 with SMTP id a640c23a62f3a-b7ce8287b3dmr185158866b.2.1765386041807;
        Wed, 10 Dec 2025 09:00:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa5d258dsm5753766b.71.2025.12.10.09.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 09:00:40 -0800 (PST)
Message-ID: <051053d9-65f2-43bf-936b-c12848367acd@6wind.com>
Date: Wed, 10 Dec 2025 18:00:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] seg6: fix route leak for encap routes
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Lebrun
 <david.lebrun@uclouvain.be>, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 stefano.salsano@uniroma2.it
References: <20251208102434.3379379-1-nicolas.dichtel@6wind.com>
 <20251210113745.145c55825034b2fe98522860@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20251210113745.145c55825034b2fe98522860@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 10/12/2025 à 11:37, Andrea Mayer a écrit :
> On Mon,  8 Dec 2025 11:24:34 +0100
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> 
>> The goal is to take into account the device used to set up the route.
>> Before this commit, it was mandatory but ignored. After encapsulation, a
>> second route lookup is performed using the encapsulated IPv6 address.
>> This route lookup is now done in the vrf where the route device is set.
>>
> 
> Hi Nicolas,
Hi Andrea,

> 
> I've got your point. However, I'm still concerned about the implications of
> using the *dev* field in the root lookup. This field has been ignored for this
> purpose so far, so some existing configurations/scripts may need to be adapted
> to work again. The adjustments made to the self-tests below show what might
> happen.
Yes, I was wondering how users use this *dev* arg. Maybe adding a new attribute,
something like SEG6_IPTUNNEL_USE_NH_DEV will avoid any regressions.

> 
> 
>> The l3vpn tests show the inconsistency; they are updated to reflect the
>> fix. Before the commit, the route to 'fc00:21:100::6046' was put in the
>> vrf-100 table while the encap route was pointing to veth0, which is not
>> associated with a vrf.
>>
>> Before:
>>> $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
>>> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0 metric 1024 pref medium
>>> fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium
>>
>> After:
>>> $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
>>> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0 metric 1024 pref medium
>>> $ ip -n rt_2-Rh5GP7 -6 r list | grep fc00:21:100::6046
>>> fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium
>>
>> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>  net/ipv6/seg6_iptunnel.c                                | 6 ++++++
>>  tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh | 2 +-
>>  tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh  | 2 +-
>>  tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh  | 2 +-
>>  4 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
>> index 3e1b9991131a..9535aea28357 100644
>> --- a/net/ipv6/seg6_iptunnel.c
>> +++ b/net/ipv6/seg6_iptunnel.c
>> @@ -484,6 +484,12 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>>  	 * now and use it later as a comparison.
>>  	 */
>>  	lwtst = orig_dst->lwtstate;
>> +	if (orig_dst->dev) {
> 
> When can 'orig_dst->dev' be NULL in this context?
I was cautious to avoid any unpleasant surprises. A dst can have dst->dev set to
NULL.

Thanks,
Nicolas

