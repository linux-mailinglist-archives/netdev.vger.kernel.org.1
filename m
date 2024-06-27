Return-Path: <netdev+bounces-107166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160E91A279
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73ED91C215D9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE27713B2B9;
	Thu, 27 Jun 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7uJHocC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15729CA
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479703; cv=none; b=ooMiio+8I6rdFb6ICDkmZgZ/cHZLvjmwNjo7umTJn3r8tiJcpeYO2pVcYp+LLbwLy313nIeFSzKHuhqEdmDdelkPpkJIjLxLsesC8lkgUL/+7/vSraJB1kVuFhX8ivmMxtMifcrhiM72oQHd5oxhNpfxlaBrR3Pt2NI91urLh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479703; c=relaxed/simple;
	bh=h7Ip8zK3mDHUw4oBDK/v9IeaMA5JH6v9JRdJSqYf15c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyxABnm4jD0uLEMIVHz370od3QHZoom9BkxRgqz8MQoOnhk6RMJVq+ep0LSkcg3tfJggcE3mAFSPfGnAu0O+2X6k3ll5lT4nYtoGBUJUTq6TZ3onGZSPcxtPEHWNXCBjsr/+eB2Jqxjbuqyza/mumjySbedS6ixbJiK09iZyNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7uJHocC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719479700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yre4isSI8ZnSjkTVUc8J3ilph4uhXMf3APIxGOGSJzM=;
	b=Y7uJHocCE2uCJt5qa3abrxlsfQVTpgybDY2b9VGcWwR5RxZtcVHoieIUastRkX5h1r0JeN
	DnKX2Ch+yVyb9bvH7v6niKQFhsOtArm0bM89Yq+Oav3GJg+dwqpEyTj9cnaGkrpVuonu4B
	pM08XsjIul0/De3PePHQc+KwBbmkJ2k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-JPauRUfHPTSYa-6WbNH18A-1; Thu, 27 Jun 2024 05:14:58 -0400
X-MC-Unique: JPauRUfHPTSYa-6WbNH18A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7246c24b00so279240366b.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 02:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719479697; x=1720084497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yre4isSI8ZnSjkTVUc8J3ilph4uhXMf3APIxGOGSJzM=;
        b=I/lcin3eXJS4rC5ZE0NIJ1FqF5iG0YaiCN5YAOqE7z8koMtqP2wPJfAgU0MV7EA3Oc
         ekCmUV2R2BNxwUJQi3BzRMaHKvOdJt7XE81lHscc/pe0R1XhJBa6LUeDxxUkQHznf9EZ
         3VIO09/PH+nHaO2qZVw4zjhoQf6zEwHQYcLYq//YHX/sgqXElT23UDTt2H9Wr2XTCODX
         zJhY3wbkciACUBHAgW90FpjHPP/v4mjHBjD1HOMlukZUT8R6UkgT9fpdRSSBuCFX8meW
         r0C7Vq9PbMauKGsLf6VXbb5ic84jqd9Ij4tc4cRQnAjBPFNiZiR7VEtxCEWY9XlI1i2j
         HtZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX82KIUNnNQ3JgLVDXsracn6+nu03HiT0U6z0tvbLBCDrd84yYJuXL7dET45nevFvKoFi1e4hPCAyMNFA7hSSPaFycXt7ty
X-Gm-Message-State: AOJu0YzQnnN13EAcHZo/TA77ce2L2bOgGJ0iPOCjvanDWpMeWtRkLOs2
	Pi4Jmty+Ax8LuEjpKNoWPFMfcActMdHbfFsljN7eWVRIHa1EK8TDTYRJArn7K7LEfh8GZCy0L/J
	FCQn2hDc4RhFfALBZ3oAO0JR/vZe43GYplxCyj4u/DJwgCIAmO3gEmA==
X-Received: by 2002:a17:907:c816:b0:a6e:f594:a292 with SMTP id a640c23a62f3a-a7242e119dbmr1105342866b.63.1719479697518;
        Thu, 27 Jun 2024 02:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVob3r+pWHg75IU70PjlRvxHcx6HfMKIkOjQHTBSN9yeOJMWDTqehexFaIZLGlEEGAUeZ0sA==
X-Received: by 2002:a17:907:c816:b0:a6e:f594:a292 with SMTP id a640c23a62f3a-a7242e119dbmr1105336866b.63.1719479696060;
        Thu, 27 Jun 2024 02:14:56 -0700 (PDT)
Received: from [10.39.192.225] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca005sm39480466b.212.2024.06.27.02.14.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2024 02:14:55 -0700 (PDT)
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
Date: Thu, 27 Jun 2024 11:14:54 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <DC37197E-BABA-425F-9BF2-D70F7B285527@redhat.com>
In-Reply-To: <617f9ff3-822e-4467-894c-f247fd9029ec@ovn.org>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-6-amorenoz@redhat.com>
 <EBFCD83F-D2AA-4D0E-A144-AC0975D22315@redhat.com>
 <CAG=2xmOnDZP3QtBbShoAqptY0uSywhFCGAwUYO+UuXfLkMXE7A@mail.gmail.com>
 <04D55CAD-0BFC-4B62-9827-C3D1A9B7792A@redhat.com>
 <CAG=2xmMThQvNaS30PRCFMjt1atODZQdyZ9jyVuWbeeXThs5UCg@mail.gmail.com>
 <617f9ff3-822e-4467-894c-f247fd9029ec@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 27 Jun 2024, at 10:36, Ilya Maximets wrote:

> On 6/27/24 09:52, Adri=C3=A1n Moreno wrote:
>> On Thu, Jun 27, 2024 at 09:06:46AM GMT, Eelco Chaudron wrote:
>>>
>>>
>>> On 26 Jun 2024, at 22:34, Adri=C3=A1n Moreno wrote:
>>>
>>>> On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
>>>>>
>>>>>
>>>>> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
>>>>>
>>>>>> Add support for a new action: emit_sample.
>>>>>>
>>>>>> This action accepts a u32 group id and a variable-length cookie an=
d uses
>>>>>> the psample multicast group to make the packet available for
>>>>>> observability.
>>>>>>
>>>>>> The maximum length of the user-defined cookie is set to 16, same a=
s
>>>>>> tc_cookie, to discourage using cookies that will not be offloadabl=
e.
>>>>>
>>>>> I=E2=80=99ll add the same comment as I had in the user space part, =
and that
>>>>> is that I feel from an OVS perspective this action should be called=

>>>>> emit_local() instead of emit_sample() to make it Datapath independe=
nt.
>>>>> Or quoting the earlier comment:
>>>>>
>>>>>
>>>>> =E2=80=9CI=E2=80=99ll start the discussion again on the naming. The=
 name "emit_sample()"
>>>>> does not seem appropriate. This function's primary role is to copy =
the
>>>>> packet and send it to a local collector, which varies depending on =
the
>>>>> datapath. For the kernel datapath, this collector is psample, while=
 for
>>>>> userspace, it will likely be some kind of probe. This action is dis=
tinct
>>>>> from the sample() action by design; it is a standalone action that =
can
>>>>> be combined with others.
>>>>>
>>>>> Furthermore, the action itself does not involve taking a sample; it=

>>>>> consistently pushes the packet to the local collector. Therefore, I=

>>>>> suggest renaming "emit_sample()" to "emit_local()". This same goes =
for
>>>>> all the derivative ATTR naming.=E2=80=9D
>>>>>
>>>>
>>>> This is a blurry semantic area.
>>>> IMO, "sample" is the act of extracting (potentially a piece of)
>>>> someting, in this case, a packet. It is common to only take some pac=
kets
>>>> as samples, so this action usually comes with some kind of "rate", b=
ut
>>>> even if the rate is 1, it's still sampling in this context.
>>>>
>>>> OTOH, OVS kernel design tries to be super-modular and define small
>>>> combinable actions, so the rate or probability generation is done wi=
th
>>>> another action which is (IMHO unfortunately) named "sample".
>>>>
>>>> With that interpretation of the term it would actually make more sen=
se
>>>> to rename "sample" to something like "random" (of course I'm not
>>>> suggestion we do it). "sample" without any nested action that actual=
ly
>>>> sends the packet somewhere is not sampling, it's just doing somethin=
g or
>>>> not based on a probability. Where as "emit_sample" is sampling even =
if
>>>> it's not nested inside a "sample".
>>>
>>> You're assuming we are extracting a packet for sampling, but this fun=
ction
>>> can be used for various other purposes. For instance, it could handle=
 the
>>> packet outside of the OVS pipeline through an eBPF program (so we are=
 not
>>> taking a sample, but continue packet processing outside of the OVS
>>> pipeline). Calling it emit_sampling() in such cases could be very
>>> confusing.
>
> We can't change the implementation of the action once it is part of uAP=
I.
> We have to document where users can find these packets and we can't jus=
t
> change the destination later.

I'm not suggesting we change the uAPI implementation, but we could use th=
e
emit_xxx() action with an eBPF probe on the action to perform other tasks=
=2E
This is just an example.

>> Well, I guess that would be clearly abusing the action. You could say
>> that of anything really. You could hook into skb_consume and continue
>> processing the skb but that doesn't change the intended behavior of th=
e
>> drop action.
>>
>> The intended behavior of the action is sampling, as is the intended
>> behavior of "psample".
>
> The original OVS_ACTION_ATTR_SAMPLE "Probabilitically executes actions"=
,
> that is it takes some packets from the whole packet stream and executes=

> actions of them.  Without tying this to observability purposes the name=

> makes sense as the first definition of the word is "to take a represent=
ative
> part or a single item from a larger whole or group".
>
> Now, our new action doesn't have this particular semantic in a way that=

> it doesn't take a part of a whole packet stream but rather using the
> part already taken.  However, it is directly tied to the parent
> OVS_ACTION_ATTR_SAMPLE action, since it reports probability of that par=
ent
> action.  If there is no parent, then probability is assumed to be 100%,=

> but that's just a corner case.  The name of a psample module has the
> same semantics in its name, it doesn't sample on it's own, but it is
> assuming that sampling was performed as it relays the rate of it.
>
> And since we're directly tied here with both OVS_ACTION_ATTR_SAMPLE and=

> the psample module, the emit_sample() name makes sense to me.

This is the part I don't like. emit_sample() should be treated as a
standalone action. While it may have potential dependencies on
OVS_ACTION_ATTR_SAMPLE, it should also be perfectly fine to use it
independently.

>>>> Having said that, I don't have a super strong favor for "emit_sample=
". I'm
>>>> OK with "emit_local" or "emit_packet" or even just "emit".
>
> The 'local' or 'packet' variants are not descriptive enough on what we'=
re
> trying to achieve and do not explain why the probability is attached to=

> the action, i.e. do not explain the link between this action and the
> OVS_ACTION_ATTR_SAMPLE.
>
> emit_Psample() would be overly specific, I agree, but making the name t=
oo
> generic will also make it hard to add new actions.  If we use some over=
ly
> broad term for this one, we may have to deal with overlapping semantics=
 in
> the future.
>
>>>> I don't think any term will fully satisfy everyone so I hope we can =
find
>>>> a reasonable compromise.
>>>
>>> My preference would be emit_local() as we hand it off to some local
>>> datapath entity.
>
> What is "local datapath entity" ?  psample module is not part of OVS da=
tapath.
> And what is "local" ?  OpenFlow has the OFPP_LOCAL port that is represe=
nted
> by a bridge port on a datapath level, that will be another source of co=
nfusion
> as it can be interpreted as sending a packet via a local bridge port.

I guess I hinted at a local exit point in the specific netdev/netlink dat=
apath, where exit is to the local host. So maybe we should call it emit_l=
ocalhost?

>> I'm OK removing the controversial term. Let's see what others think.
>>
>>>>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>>>>> ---
>>>>>>  Documentation/netlink/specs/ovs_flow.yaml | 17 +++++++++
>>>>>>  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
>>>>>>  net/openvswitch/Kconfig                   |  1 +
>>>>>>  net/openvswitch/actions.c                 | 45 ++++++++++++++++++=
+++++
>>>>>>  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++++-
>>>>>>  5 files changed, 123 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documenta=
tion/netlink/specs/ovs_flow.yaml
>>>>>> index 4fdfc6b5cae9..a7ab5593a24f 100644
>>>>>> --- a/Documentation/netlink/specs/ovs_flow.yaml
>>>>>> +++ b/Documentation/netlink/specs/ovs_flow.yaml
>>>>>> @@ -727,6 +727,12 @@ attribute-sets:
>>>>>>          name: dec-ttl
>>>>>>          type: nest
>>>>>>          nested-attributes: dec-ttl-attrs
>>>>>> +      -
>>>>>> +        name: emit-sample
>>>>>> +        type: nest
>>>>>> +        nested-attributes: emit-sample-attrs
>>>>>> +        doc: |
>>>>>> +          Sends a packet sample to psample for external observati=
on.
>>>>>>    -
>>>>>>      name: tunnel-key-attrs
>>>>>>      enum-name: ovs-tunnel-key-attr
>>>>>> @@ -938,6 +944,17 @@ attribute-sets:
>>>>>>        -
>>>>>>          name: gbp
>>>>>>          type: u32
>>>>>> +  -
>>>>>> +    name: emit-sample-attrs
>>>>>> +    enum-name: ovs-emit-sample-attr
>>>>>> +    name-prefix: ovs-emit-sample-attr-
>>>>>> +    attributes:
>>>>>> +      -
>>>>>> +        name: group
>>>>>> +        type: u32
>>>>>> +      -
>>>>>> +        name: cookie
>>>>>> +        type: binary
>>>>>>
>>>>>>  operations:
>>>>>>    name-prefix: ovs-flow-cmd-
>>>>>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux=
/openvswitch.h
>>>>>> index efc82c318fa2..8cfa1b3f6b06 100644
>>>>>> --- a/include/uapi/linux/openvswitch.h
>>>>>> +++ b/include/uapi/linux/openvswitch.h
>>>>>> @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
>>>>>>  };
>>>>>>  #endif
>>>>>>
>>>>>> +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
>>>>>> +/**
>>>>>> + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EM=
IT_SAMPLE
>>>>>> + * action.
>>>>>> + *
>>>>>> + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the sou=
rce of the
>>>>>> + * sample.
>>>>>> + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie =
that contains
>>>>>> + * user-defined metadata. The maximum length is OVS_EMIT_SAMPLE_C=
OOKIE_MAX_SIZE
>>>>>> + * bytes.
>>>>>> + *
>>>>>> + * Sends the packet to the psample multicast group with the speci=
fied group and
>>>>>> + * cookie. It is possible to combine this action with the
>>>>>> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet =
being emitted.
>>>>>
>>>>> Although this include file is kernel-related, it will probably be r=
e-used for
>>>>> other datapaths, so should we be more general here?
>>>>>
>>>>
>>>> The uAPI header documentation will be used for other datapaths? How =
so?
>>>> At some point we should document what the action does from the kerne=
l
>>>> pov, right? Where should we do that if not here?
>>>
>>> Well you know how OVS works, all the data paths use the same netlink =
messages. Not sure how to solve this, but we could change the text a bit =
to be more general?
>>>
>>>  * For the Linux kernel it sends the packet to the psample multicast =
group
>>>  * with the specified group and cookie. It is possible to combine thi=
s
>>>  * action with the %OVS_ACTION_ATTR_TRUNC action to limit the size of=
 the
>>>  * packet being emitted.
>>>
>>
>> I know we reuse the kernel attributes I don't think the uAPI
>> documentation should be less expressive just because some userspace
>> application decides to reuse parts of it.
>>
>> There are many kernel-specific terms all over the uAPI ("netdev",
>> "netlink pid", "skb", even the action "userspace") that do not make
>> sense in a non-kernel datapath.
>
> +1
>
> This is a kernel uAPI header it describes the behavior of the kernel.
> Having parts like "For the Linux kernel" in here is awkward.
>
>>
>> Maybe we can add such a comment in the copy of the header we store in
>> the ovs tree?
>
> Makes sense to me.
>
> If we'll want to implement a similar action in userspace datapath,
> we'll have to have a separate documentation for it anyway, since
> the packets will end up in a different place for users to collect.
>
>>
>>
>>>>>> + */
>>>>>> +enum ovs_emit_sample_attr {
>>>>>> +	OVS_EMIT_SAMPLE_ATTR_GROUP =3D 1,	/* u32 number. */
>>>>>> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie.=
 */
>>>>>
>>>>> As we start a new set of attributes maybe it would be good starting=
 it off in
>>>>> alphabetical order?
>>>>>
>>>>
>>>> Having an optional attribute before a mandatory one seems strange to=
 me,
>>>> wouldn't you agree?
>>>
>>> I don't mind, but I don't have a strong opinion on it. If others don'=
t mind,
>>> I would leave it as is.
>>>
>>
>> I think I prefer to put mandatory attributes first.
>
> That's my thought as well.  Though that might be broken if we ever need=

> more attributes.  But we do not extend individual actions that often.
>
> Best regards, Ilya Maximets.


