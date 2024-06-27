Return-Path: <netdev+bounces-107301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C699291A7E6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCE91C209C7
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF3A80031;
	Thu, 27 Jun 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TifNakbl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E519306C
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495033; cv=none; b=k7PR8EUnsWKzMOIX8X8ra/wGvAO1ugx7Agnhh0tFx/h5lgGsnKJOmSYpCGoezw6bG5SrGemFmu6chSoGHTA4HZ7u/MIMhV407iNPYB3BGtgRH+yqgQBJg62t6qCoI2BmiRkMP5qh1T0payIU3mOFXf7ZAtvcKk0qPI+mKX3bUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495033; c=relaxed/simple;
	bh=HaYamcrrwgbKFznn6kweo5491C2tXpZXnbzeM9ernrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJd3ey7dRugRlCjUYA2lv/6zk40UrsLTBBY8I4SMd166zKmZyctPvxJmJN+LDCb9TtsVsRf/YOf2ELRhDXUjYNJRsLb+sXOafFZiMcmv6we9cCO8PdLX7kCrse4CaRNG40qn05JorD8O75QnBt3sYkdwUox39wuNK2uAsOxxaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TifNakbl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719495030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VZklb6tVOpAi1DKjrHYqTN53uZQbLSiG/g6Aw8zWzQ=;
	b=TifNakble413ddOqfQFluUOj9QVHnd8LHewha3digvhpzk93zrOMN4cZduETRg4o2AJQac
	4ZefpehpdMVRDKaWhUdZFRturplbWAMes3YtkOAoc9yHvp5FV0U6KIL3UTyvnZU+E5/1wA
	fk0A76WYYTFYt2b1K/LHa1ugg1VVDZ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-LYys5lH5MqOOIvnkxxm4iQ-1; Thu, 27 Jun 2024 09:30:28 -0400
X-MC-Unique: LYys5lH5MqOOIvnkxxm4iQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a72469c0fdcso318940066b.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719495027; x=1720099827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VZklb6tVOpAi1DKjrHYqTN53uZQbLSiG/g6Aw8zWzQ=;
        b=c87Vn2kaYYAGf1TdAv11ORh1x20SCMyA5w3juMKQxb8TDwfUfWe5mLKRNBCPQ6xb0h
         bqb41u5cOFZUMp/KIcvluy5cJV2Y/RmK4VM/WrFTMJRP6N5aj2NwqI6KlUhzgXrfKLKF
         SkK5Ji/SP/rGKZvwgf2Ool73t2aaVUXlbHxrmnHoZOmj4cMEiBkbZXVWGv4LFqosa93f
         JPu0AJxmwtyYgm3wPjpwCJXgRIuh/5lUUimU26RiFa86CwUrJZexYtaXqiAFA7H1vLPz
         kEyC9qHS+FRojUoixsNJdf6LILZU+a8Uk5KggjsDyaqUQIWbnOSKtDD9GXS8Sj0ryctY
         LT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWgP6VvxG5VSsosJIMIFQdMqTleHOyVElfNBUlOAeCdTIghEdlOQDEapCbo8dJc8sfp+boeSNQ/1e+nkIEco5KZsg/zt2S
X-Gm-Message-State: AOJu0YwhAXoznAQNnUvVSbA2HzwlSMNf+4cGT8Alh9fU3maeDSZFzHyi
	MNvAd/8RYUGE7emaRCNgQepY8LhFm8E9pe29OWrh8ERdN1jXSO+KK9syc8BKtS02IkOvAVqAniN
	m3R134g1Eu4XSyuPsKtUiaC9Wi8ALv1ocVlUTFhyNPUZiRk6gvYTsZg==
X-Received: by 2002:a17:906:7f05:b0:a6e:4693:1f6e with SMTP id a640c23a62f3a-a7242c39be2mr922229566b.29.1719495027540;
        Thu, 27 Jun 2024 06:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg26TJPXbF11zqG5OsIeZsEqBBtlkODJYKksSE7cDwNGcJYKD5Q/kX4xKPgLQTm+YFKdWmFw==
X-Received: by 2002:a17:906:7f05:b0:a6e:4693:1f6e with SMTP id a640c23a62f3a-a7242c39be2mr922227366b.29.1719495027088;
        Thu, 27 Jun 2024 06:30:27 -0700 (PDT)
Received: from [172.16.1.27] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d778b7asm59137866b.124.2024.06.27.06.30.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2024 06:30:26 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: =?utf-8?q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>,
 netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 dev@openvswitch.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Pravin B Shelar <pshelar@ovn.org>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample
 action
Date: Thu, 27 Jun 2024 15:30:25 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <CD9D918D-EF26-451D-8931-08BA846BA353@redhat.com>
In-Reply-To: <2c6317e3-615b-4113-8df6-702ca20bf87d@ovn.org>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-6-amorenoz@redhat.com>
 <EBFCD83F-D2AA-4D0E-A144-AC0975D22315@redhat.com>
 <CAG=2xmOnDZP3QtBbShoAqptY0uSywhFCGAwUYO+UuXfLkMXE7A@mail.gmail.com>
 <04D55CAD-0BFC-4B62-9827-C3D1A9B7792A@redhat.com>
 <CAG=2xmMThQvNaS30PRCFMjt1atODZQdyZ9jyVuWbeeXThs5UCg@mail.gmail.com>
 <617f9ff3-822e-4467-894c-f247fd9029ec@ovn.org>
 <DC37197E-BABA-425F-9BF2-D70F7B285527@redhat.com>
 <b42e503b-663d-4d44-86d1-ab93feec4593@ovn.org>
 <97CA519E-AC24-4D61-819F-B3B5A88F89E4@redhat.com>
 <CAG=2xmP5oVKetn6WKKQg0kThh-V0Ofpe=xgiQOkHFSyTaXNHug@mail.gmail.com>
 <2c6317e3-615b-4113-8df6-702ca20bf87d@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27 Jun 2024, at 12:52, Ilya Maximets wrote:

> On 6/27/24 12:15, Adrián Moreno wrote:
>> On Thu, Jun 27, 2024 at 11:31:41AM GMT, Eelco Chaudron wrote:
>>>
>>>
>>> On 27 Jun 2024, at 11:23, Ilya Maximets wrote:
>>>
>>>> On 6/27/24 11:14, Eelco Chaudron wrote:
>>>>>
>>>>>
>>>>> On 27 Jun 2024, at 10:36, Ilya Maximets wrote:
>>>>>
>>>>>> On 6/27/24 09:52, Adrián Moreno wrote:
>>>>>>> On Thu, Jun 27, 2024 at 09:06:46AM GMT, Eelco Chaudron wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 26 Jun 2024, at 22:34, Adrián Moreno wrote:
>>>>>>>>
>>>>>>>>> On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
>>>>>>>>>>
>>>>>>>>>>> Add support for a new action: emit_sample.
>>>>>>>>>>>
>>>>>>>>>>> This action accepts a u32 group id and a variable-length cookie and uses
>>>>>>>>>>> the psample multicast group to make the packet available for
>>>>>>>>>>> observability.
>>>>>>>>>>>
>>>>>>>>>>> The maximum length of the user-defined cookie is set to 16, same as
>>>>>>>>>>> tc_cookie, to discourage using cookies that will not be offloadable.
>>>>>>>>>>
>>>>>>>>>> I’ll add the same comment as I had in the user space part, and that
>>>>>>>>>> is that I feel from an OVS perspective this action should be called
>>>>>>>>>> emit_local() instead of emit_sample() to make it Datapath independent.
>>>>>>>>>> Or quoting the earlier comment:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> “I’ll start the discussion again on the naming. The name "emit_sample()"
>>>>>>>>>> does not seem appropriate. This function's primary role is to copy the
>>>>>>>>>> packet and send it to a local collector, which varies depending on the
>>>>>>>>>> datapath. For the kernel datapath, this collector is psample, while for
>>>>>>>>>> userspace, it will likely be some kind of probe. This action is distinct
>>>>>>>>>> from the sample() action by design; it is a standalone action that can
>>>>>>>>>> be combined with others.
>>>>>>>>>>
>>>>>>>>>> Furthermore, the action itself does not involve taking a sample; it
>>>>>>>>>> consistently pushes the packet to the local collector. Therefore, I
>>>>>>>>>> suggest renaming "emit_sample()" to "emit_local()". This same goes for
>>>>>>>>>> all the derivative ATTR naming.”
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is a blurry semantic area.
>>>>>>>>> IMO, "sample" is the act of extracting (potentially a piece of)
>>>>>>>>> someting, in this case, a packet. It is common to only take some packets
>>>>>>>>> as samples, so this action usually comes with some kind of "rate", but
>>>>>>>>> even if the rate is 1, it's still sampling in this context.
>>>>>>>>>
>>>>>>>>> OTOH, OVS kernel design tries to be super-modular and define small
>>>>>>>>> combinable actions, so the rate or probability generation is done with
>>>>>>>>> another action which is (IMHO unfortunately) named "sample".
>>>>>>>>>
>>>>>>>>> With that interpretation of the term it would actually make more sense
>>>>>>>>> to rename "sample" to something like "random" (of course I'm not
>>>>>>>>> suggestion we do it). "sample" without any nested action that actually
>>>>>>>>> sends the packet somewhere is not sampling, it's just doing something or
>>>>>>>>> not based on a probability. Where as "emit_sample" is sampling even if
>>>>>>>>> it's not nested inside a "sample".
>>>>>>>>
>>>>>>>> You're assuming we are extracting a packet for sampling, but this function
>>>>>>>> can be used for various other purposes. For instance, it could handle the
>>>>>>>> packet outside of the OVS pipeline through an eBPF program (so we are not
>>>>>>>> taking a sample, but continue packet processing outside of the OVS
>>>>>>>> pipeline). Calling it emit_sampling() in such cases could be very
>>>>>>>> confusing.
>>>>>>
>>>>>> We can't change the implementation of the action once it is part of uAPI.
>>>>>> We have to document where users can find these packets and we can't just
>>>>>> change the destination later.
>>>>>
>>>>> I'm not suggesting we change the uAPI implementation, but we could use the
>>>>> emit_xxx() action with an eBPF probe on the action to perform other tasks.
>>>>> This is just an example.
>>>>
>>>> Yeah, but as Adrian said below, you could do that with any action and
>>>> this doesn't change the semantics of the action itself.
>>>
>>> Well this was just an example, what if we have some other need for getting
>>> a packet to userspace through emit_local() other than sampling? The
>>> emit_sample() action naming in this case makes no sense.
>>>
>>>>>>> Well, I guess that would be clearly abusing the action. You could say
>>>>>>> that of anything really. You could hook into skb_consume and continue
>>>>>>> processing the skb but that doesn't change the intended behavior of the
>>>>>>> drop action.
>>>>>>>
>>>>>>> The intended behavior of the action is sampling, as is the intended
>>>>>>> behavior of "psample".
>>>>>>
>>>>>> The original OVS_ACTION_ATTR_SAMPLE "Probabilitically executes actions",
>>>>>> that is it takes some packets from the whole packet stream and executes
>>>>>> actions of them.  Without tying this to observability purposes the name
>>>>>> makes sense as the first definition of the word is "to take a representative
>>>>>> part or a single item from a larger whole or group".
>>>>>>
>>>>>> Now, our new action doesn't have this particular semantic in a way that
>>>>>> it doesn't take a part of a whole packet stream but rather using the
>>>>>> part already taken.  However, it is directly tied to the parent
>>>>>> OVS_ACTION_ATTR_SAMPLE action, since it reports probability of that parent
>>>>>> action.  If there is no parent, then probability is assumed to be 100%,
>>>>>> but that's just a corner case.  The name of a psample module has the
>>>>>> same semantics in its name, it doesn't sample on it's own, but it is
>>>>>> assuming that sampling was performed as it relays the rate of it.
>>>>>>
>>>>>> And since we're directly tied here with both OVS_ACTION_ATTR_SAMPLE and
>>>>>> the psample module, the emit_sample() name makes sense to me.
>>>>>
>>>>> This is the part I don't like. emit_sample() should be treated as a
>>>>> standalone action. While it may have potential dependencies on
>>>>> OVS_ACTION_ATTR_SAMPLE, it should also be perfectly fine to use it
>>>>> independently.
>>>>
>>>> It is fine to use it, we just assume implicit 100% sampling.
>>>
>>> Agreed, but the name does not make sense ;) I do not think we
>>> currently have any actions that explicitly depend on each other
>>> (there might be attributes carried over) and I want to keep it
>>> as such.
>>>
>>>>>>>>> Having said that, I don't have a super strong favor for "emit_sample". I'm
>>>>>>>>> OK with "emit_local" or "emit_packet" or even just "emit".
>>>>>>
>>>>>> The 'local' or 'packet' variants are not descriptive enough on what we're
>>>>>> trying to achieve and do not explain why the probability is attached to
>>>>>> the action, i.e. do not explain the link between this action and the
>>>>>> OVS_ACTION_ATTR_SAMPLE.
>>>>>>
>>>>>> emit_Psample() would be overly specific, I agree, but making the name too
>>>>>> generic will also make it hard to add new actions.  If we use some overly
>>>>>> broad term for this one, we may have to deal with overlapping semantics in
>>>>>> the future.
>>>>>>
>>>>>>>>> I don't think any term will fully satisfy everyone so I hope we can find
>>>>>>>>> a reasonable compromise.
>>>>>>>>
>>>>>>>> My preference would be emit_local() as we hand it off to some local
>>>>>>>> datapath entity.
>>>>>>
>>>>>> What is "local datapath entity" ?  psample module is not part of OVS datapath.
>>>>>> And what is "local" ?  OpenFlow has the OFPP_LOCAL port that is represented
>>>>>> by a bridge port on a datapath level, that will be another source of confusion
>>>>>> as it can be interpreted as sending a packet via a local bridge port.
>>>>>
>>>>> I guess I hinted at a local exit point in the specific netdev/netlink datapath,
>>>>> where exit is to the local host. So maybe we should call it emit_localhost?
>>>>
>>>> For me sending to localhost means sending to a loopback interface or otherwise
>>>> sending the packet to the host networking stack.  And we're not doing that.
>>>
>>> That might be confusing too... Maybe emit_external()?
>>
>> "External" was the word I used for the original userspace RFC. The
>> rationale being: We're sending the packet to something external from OVS
>> (datapath or userspace). Compared with IPFIX-based observability which
>> where the sample is first processed ("internally") by ovs-vswitchd.
>>
>> In userspace it kept the sampling/observability meaning because it was
>> part of the Flow_Sample_Collector_Set which is intrinsically an
>> observability thing.
>>
>> However, in the datapath we loose that meaning and could be confused
>> with some external packet-processing entity. How about "external_observe"
>> or something that somehow keeps that meaning?
>
> This semantics conversation doesn't seem productive as we're going in circles
> around what we already discussed what feels like at least three separate times
> on this and ovs-dev lists.
>
> I'd say if we can't agree on OVS_ACTION_ATTR_EMIT_SAMPLE, then just call
> it OVS_ACTION_ATTR_SEND_TO_PSAMPLE.  Simple, describes exactly what it does.
> And if we ever want to have "local" sampling for OVS userspace datapath,
> we can create a userspace-only datapath action for it and call it in a way
> that describes what it does, e.g. OVS_ACTION_ATTR_SEND_TO_USDT or whatever.
> Unlike key attributes, we can relatively safely create userspace-only actions
> without consequences for kernel uAPI.  In fact, we have a few such actions.
> And we can choose which one to use based on which one is supported by the
> current datapath.

My goal was to avoid adding more actions, but this proposal does the opposite.
We need a name that represents the actual action’s action:

  getting a packet quickly from the kernel (data path) to userspace with some
  meta-data.

Considering the actual purpose of the action, what would be a good name
(disregarding that the packet might not be related to sampling)?

  emit_userspace()

Maybe there are other people on the list with better naming skills that
want to chime in :)

//Eelco









