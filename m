Return-Path: <netdev+bounces-107181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A291A39D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047661C213FE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F35413C80B;
	Thu, 27 Jun 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA6/xobD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF39481BA
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483362; cv=none; b=dGy7GK5tXcXw3DxUfcm/dKKo1EVFDVn1jHr2Z/KjvayT2XE3LAoGF7HTR8qDukk7UXwe7Gpl33mxhA+pPVttyVrW1iEnspLeo2fe0U+i1fxJw56TvocZWWrA4nDZzpzYQnzmV5OLGhmit0PNjVvoZ+TLyYwYtkvg9GfASMh0W+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483362; c=relaxed/simple;
	bh=25YPE3PaNnyJaDV/SJM9Hy7or9ncwIL3IflyRz7nSfM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGKqLKOqM9mkIfMERmZQ8nsbNvz8NNy/aKjyhsmiYJtcJfATNiZbA3mMqAfVipniU+zAjVK4TZvaC0C+pIt4tBQdD7lmPcVT7Q+6CqVgzE/OTLCrqeGox3sPbjdhedPIh72tAu8ZMn4jSoH0Z3SI/+aps0V47XhYxbEkC3/AIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cA6/xobD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719483359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuzHFb209PgNxyVemT6AZ4x0060HlfqS826e6D6RQ0Q=;
	b=cA6/xobDucGZrxikvQppTyrAE9Go4jLApfZe0lLOhyjwEVdcw7TT9BO04jp1XnhHKc3RQ0
	WlnWvZ/+OKpz7WL5FQ3uMno5ZNuTa4RpgNRLUC8Rcf0xL59IaLbmnNd0xcxxAy/qd1Rb+t
	tyM94vMFfV9beceFd82TZVuOL+vuvZE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-XbM4AHKjNW-6Cu3gThXaLw-1; Thu, 27 Jun 2024 06:15:57 -0400
X-MC-Unique: XbM4AHKjNW-6Cu3gThXaLw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b51042049eso127205916d6.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719483357; x=1720088157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KuzHFb209PgNxyVemT6AZ4x0060HlfqS826e6D6RQ0Q=;
        b=rnTDBn2Y7E4J/5tll0aPkTOYO8mD4pgGzKcDXui9AzsOZSxKuohMhv2T25UzWqkdWE
         7QO5iEwQHiYzVA39A8OHy1Y9hfRfaLWRNQ7GgKCUrsWI+q2EjBpXdLNx1W9UhN5e2jum
         bp2LQTy2KQk9T/mzwpkOSK1WCiK3AdXrRiY5tRBXdKorc/IHUsQnbiyDiUQqxXw55V75
         UPGkSU7BCWhiIa/MAtSZ2hgo8MBcN3qRW6I/Lg8FIddVyUw5K7PS51+19nfTMtTF/Czj
         /gvb5XbyiCzakymNrJZo2wtQIJeIADAl35lZo5op7+/Wn15oJ/88BBY1KuxOD39HPLJC
         5LlA==
X-Forwarded-Encrypted: i=1; AJvYcCWIkHFlCevrVQk5+3H4A2nWaqMJi8t1f1Zw9uLgVfpB0Ca9O7W5q4hd8vHxqtB2qjc2wXIBcr00dNmqTl8LehtZYyyVYrYf
X-Gm-Message-State: AOJu0Yz9o62R4X2o3104oK+dDF9AQi8UrBup7quWgbufpvSE4FP3gMx9
	C6iIeOqrQfA3+jw274mLECjVQvg72w09nydAx8R8ys4iFeLfhyqZPcoskHbC9w4Px8OxaFo4DOz
	dA40pGwS0l/prK+ctUZhEpZ3S803oibrnSf71orZZWvHSiF6W2N3LM0JCZYOJl/OFwV5gIofNPP
	ozv1d+tVlp4qIQnDiruYotZ7kKHR6d
X-Received: by 2002:ad4:4c4b:0:b0:6b5:38d3:de6d with SMTP id 6a1803df08f44-6b538d3dfb6mr152623936d6.30.1719483357103;
        Thu, 27 Jun 2024 03:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHZhyfASO7nkpBjhddm/vnFZbPDE4nCIfg2n5Y8DbQtdL0pVtmO4dv4aRmNddrwFpk6ZlYV4Ba9JiLqIqNoLg=
X-Received: by 2002:ad4:4c4b:0:b0:6b5:38d3:de6d with SMTP id
 6a1803df08f44-6b538d3dfb6mr152623726d6.30.1719483356634; Thu, 27 Jun 2024
 03:15:56 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jun 2024 10:15:55 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com> <20240625205204.3199050-6-amorenoz@redhat.com>
 <EBFCD83F-D2AA-4D0E-A144-AC0975D22315@redhat.com> <CAG=2xmOnDZP3QtBbShoAqptY0uSywhFCGAwUYO+UuXfLkMXE7A@mail.gmail.com>
 <04D55CAD-0BFC-4B62-9827-C3D1A9B7792A@redhat.com> <CAG=2xmMThQvNaS30PRCFMjt1atODZQdyZ9jyVuWbeeXThs5UCg@mail.gmail.com>
 <617f9ff3-822e-4467-894c-f247fd9029ec@ovn.org> <DC37197E-BABA-425F-9BF2-D70F7B285527@redhat.com>
 <b42e503b-663d-4d44-86d1-ab93feec4593@ovn.org> <97CA519E-AC24-4D61-819F-B3B5A88F89E4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <97CA519E-AC24-4D61-819F-B3B5A88F89E4@redhat.com>
Date: Thu, 27 Jun 2024 10:15:55 +0000
Message-ID: <CAG=2xmP5oVKetn6WKKQg0kThh-V0Ofpe=xgiQOkHFSyTaXNHug@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample action
To: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, aconole@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Pravin B Shelar <pshelar@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:31:41AM GMT, Eelco Chaudron wrote:
>
>
> On 27 Jun 2024, at 11:23, Ilya Maximets wrote:
>
> > On 6/27/24 11:14, Eelco Chaudron wrote:
> >>
> >>
> >> On 27 Jun 2024, at 10:36, Ilya Maximets wrote:
> >>
> >>> On 6/27/24 09:52, Adri=C3=A1n Moreno wrote:
> >>>> On Thu, Jun 27, 2024 at 09:06:46AM GMT, Eelco Chaudron wrote:
> >>>>>
> >>>>>
> >>>>> On 26 Jun 2024, at 22:34, Adri=C3=A1n Moreno wrote:
> >>>>>
> >>>>>> On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
> >>>>>>>
> >>>>>>>> Add support for a new action: emit_sample.
> >>>>>>>>
> >>>>>>>> This action accepts a u32 group id and a variable-length cookie =
and uses
> >>>>>>>> the psample multicast group to make the packet available for
> >>>>>>>> observability.
> >>>>>>>>
> >>>>>>>> The maximum length of the user-defined cookie is set to 16, same=
 as
> >>>>>>>> tc_cookie, to discourage using cookies that will not be offloada=
ble.
> >>>>>>>
> >>>>>>> I=E2=80=99ll add the same comment as I had in the user space part=
, and that
> >>>>>>> is that I feel from an OVS perspective this action should be call=
ed
> >>>>>>> emit_local() instead of emit_sample() to make it Datapath indepen=
dent.
> >>>>>>> Or quoting the earlier comment:
> >>>>>>>
> >>>>>>>
> >>>>>>> =E2=80=9CI=E2=80=99ll start the discussion again on the naming. T=
he name "emit_sample()"
> >>>>>>> does not seem appropriate. This function's primary role is to cop=
y the
> >>>>>>> packet and send it to a local collector, which varies depending o=
n the
> >>>>>>> datapath. For the kernel datapath, this collector is psample, whi=
le for
> >>>>>>> userspace, it will likely be some kind of probe. This action is d=
istinct
> >>>>>>> from the sample() action by design; it is a standalone action tha=
t can
> >>>>>>> be combined with others.
> >>>>>>>
> >>>>>>> Furthermore, the action itself does not involve taking a sample; =
it
> >>>>>>> consistently pushes the packet to the local collector. Therefore,=
 I
> >>>>>>> suggest renaming "emit_sample()" to "emit_local()". This same goe=
s for
> >>>>>>> all the derivative ATTR naming.=E2=80=9D
> >>>>>>>
> >>>>>>
> >>>>>> This is a blurry semantic area.
> >>>>>> IMO, "sample" is the act of extracting (potentially a piece of)
> >>>>>> someting, in this case, a packet. It is common to only take some p=
ackets
> >>>>>> as samples, so this action usually comes with some kind of "rate",=
 but
> >>>>>> even if the rate is 1, it's still sampling in this context.
> >>>>>>
> >>>>>> OTOH, OVS kernel design tries to be super-modular and define small
> >>>>>> combinable actions, so the rate or probability generation is done =
with
> >>>>>> another action which is (IMHO unfortunately) named "sample".
> >>>>>>
> >>>>>> With that interpretation of the term it would actually make more s=
ense
> >>>>>> to rename "sample" to something like "random" (of course I'm not
> >>>>>> suggestion we do it). "sample" without any nested action that actu=
ally
> >>>>>> sends the packet somewhere is not sampling, it's just doing someth=
ing or
> >>>>>> not based on a probability. Where as "emit_sample" is sampling eve=
n if
> >>>>>> it's not nested inside a "sample".
> >>>>>
> >>>>> You're assuming we are extracting a packet for sampling, but this f=
unction
> >>>>> can be used for various other purposes. For instance, it could hand=
le the
> >>>>> packet outside of the OVS pipeline through an eBPF program (so we a=
re not
> >>>>> taking a sample, but continue packet processing outside of the OVS
> >>>>> pipeline). Calling it emit_sampling() in such cases could be very
> >>>>> confusing.
> >>>
> >>> We can't change the implementation of the action once it is part of u=
API.
> >>> We have to document where users can find these packets and we can't j=
ust
> >>> change the destination later.
> >>
> >> I'm not suggesting we change the uAPI implementation, but we could use=
 the
> >> emit_xxx() action with an eBPF probe on the action to perform other ta=
sks.
> >> This is just an example.
> >
> > Yeah, but as Adrian said below, you could do that with any action and
> > this doesn't change the semantics of the action itself.
>
> Well this was just an example, what if we have some other need for gettin=
g
> a packet to userspace through emit_local() other than sampling? The
> emit_sample() action naming in this case makes no sense.
>
> >>>> Well, I guess that would be clearly abusing the action. You could sa=
y
> >>>> that of anything really. You could hook into skb_consume and continu=
e
> >>>> processing the skb but that doesn't change the intended behavior of =
the
> >>>> drop action.
> >>>>
> >>>> The intended behavior of the action is sampling, as is the intended
> >>>> behavior of "psample".
> >>>
> >>> The original OVS_ACTION_ATTR_SAMPLE "Probabilitically executes action=
s",
> >>> that is it takes some packets from the whole packet stream and execut=
es
> >>> actions of them.  Without tying this to observability purposes the na=
me
> >>> makes sense as the first definition of the word is "to take a represe=
ntative
> >>> part or a single item from a larger whole or group".
> >>>
> >>> Now, our new action doesn't have this particular semantic in a way th=
at
> >>> it doesn't take a part of a whole packet stream but rather using the
> >>> part already taken.  However, it is directly tied to the parent
> >>> OVS_ACTION_ATTR_SAMPLE action, since it reports probability of that p=
arent
> >>> action.  If there is no parent, then probability is assumed to be 100=
%,
> >>> but that's just a corner case.  The name of a psample module has the
> >>> same semantics in its name, it doesn't sample on it's own, but it is
> >>> assuming that sampling was performed as it relays the rate of it.
> >>>
> >>> And since we're directly tied here with both OVS_ACTION_ATTR_SAMPLE a=
nd
> >>> the psample module, the emit_sample() name makes sense to me.
> >>
> >> This is the part I don't like. emit_sample() should be treated as a
> >> standalone action. While it may have potential dependencies on
> >> OVS_ACTION_ATTR_SAMPLE, it should also be perfectly fine to use it
> >> independently.
> >
> > It is fine to use it, we just assume implicit 100% sampling.
>
> Agreed, but the name does not make sense ;) I do not think we
> currently have any actions that explicitly depend on each other
> (there might be attributes carried over) and I want to keep it
> as such.
>
> >>>>>> Having said that, I don't have a super strong favor for "emit_samp=
le". I'm
> >>>>>> OK with "emit_local" or "emit_packet" or even just "emit".
> >>>
> >>> The 'local' or 'packet' variants are not descriptive enough on what w=
e're
> >>> trying to achieve and do not explain why the probability is attached =
to
> >>> the action, i.e. do not explain the link between this action and the
> >>> OVS_ACTION_ATTR_SAMPLE.
> >>>
> >>> emit_Psample() would be overly specific, I agree, but making the name=
 too
> >>> generic will also make it hard to add new actions.  If we use some ov=
erly
> >>> broad term for this one, we may have to deal with overlapping semanti=
cs in
> >>> the future.
> >>>
> >>>>>> I don't think any term will fully satisfy everyone so I hope we ca=
n find
> >>>>>> a reasonable compromise.
> >>>>>
> >>>>> My preference would be emit_local() as we hand it off to some local
> >>>>> datapath entity.
> >>>
> >>> What is "local datapath entity" ?  psample module is not part of OVS =
datapath.
> >>> And what is "local" ?  OpenFlow has the OFPP_LOCAL port that is repre=
sented
> >>> by a bridge port on a datapath level, that will be another source of =
confusion
> >>> as it can be interpreted as sending a packet via a local bridge port.
> >>
> >> I guess I hinted at a local exit point in the specific netdev/netlink =
datapath,
> >> where exit is to the local host. So maybe we should call it emit_local=
host?
> >
> > For me sending to localhost means sending to a loopback interface or ot=
herwise
> > sending the packet to the host networking stack.  And we're not doing t=
hat.
>
> That might be confusing too... Maybe emit_external()?

"External" was the word I used for the original userspace RFC. The
rationale being: We're sending the packet to something external from OVS
(datapath or userspace). Compared with IPFIX-based observability which
where the sample is first processed ("internally") by ovs-vswitchd.

In userspace it kept the sampling/observability meaning because it was
part of the Flow_Sample_Collector_Set which is intrinsically an
observability thing.

However, in the datapath we loose that meaning and could be confused
with some external packet-processing entity. How about "external_observe"
or something that somehow keeps that meaning?


>
> >>>> I'm OK removing the controversial term. Let's see what others think.
> >>>>
> >>>>>>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >>>>>>>> ---
> >>>>>>>>  Documentation/netlink/specs/ovs_flow.yaml | 17 +++++++++
> >>>>>>>>  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
> >>>>>>>>  net/openvswitch/Kconfig                   |  1 +
> >>>>>>>>  net/openvswitch/actions.c                 | 45 ++++++++++++++++=
+++++++
> >>>>>>>>  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++++=
-
> >>>>>>>>  5 files changed, 123 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documen=
tation/netlink/specs/ovs_flow.yaml
> >>>>>>>> index 4fdfc6b5cae9..a7ab5593a24f 100644
> >>>>>>>> --- a/Documentation/netlink/specs/ovs_flow.yaml
> >>>>>>>> +++ b/Documentation/netlink/specs/ovs_flow.yaml
> >>>>>>>> @@ -727,6 +727,12 @@ attribute-sets:
> >>>>>>>>          name: dec-ttl
> >>>>>>>>          type: nest
> >>>>>>>>          nested-attributes: dec-ttl-attrs
> >>>>>>>> +      -
> >>>>>>>> +        name: emit-sample
> >>>>>>>> +        type: nest
> >>>>>>>> +        nested-attributes: emit-sample-attrs
> >>>>>>>> +        doc: |
> >>>>>>>> +          Sends a packet sample to psample for external observa=
tion.
> >>>>>>>>    -
> >>>>>>>>      name: tunnel-key-attrs
> >>>>>>>>      enum-name: ovs-tunnel-key-attr
> >>>>>>>> @@ -938,6 +944,17 @@ attribute-sets:
> >>>>>>>>        -
> >>>>>>>>          name: gbp
> >>>>>>>>          type: u32
> >>>>>>>> +  -
> >>>>>>>> +    name: emit-sample-attrs
> >>>>>>>> +    enum-name: ovs-emit-sample-attr
> >>>>>>>> +    name-prefix: ovs-emit-sample-attr-
> >>>>>>>> +    attributes:
> >>>>>>>> +      -
> >>>>>>>> +        name: group
> >>>>>>>> +        type: u32
> >>>>>>>> +      -
> >>>>>>>> +        name: cookie
> >>>>>>>> +        type: binary
> >>>>>>>>
> >>>>>>>>  operations:
> >>>>>>>>    name-prefix: ovs-flow-cmd-
> >>>>>>>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/lin=
ux/openvswitch.h
> >>>>>>>> index efc82c318fa2..8cfa1b3f6b06 100644
> >>>>>>>> --- a/include/uapi/linux/openvswitch.h
> >>>>>>>> +++ b/include/uapi/linux/openvswitch.h
> >>>>>>>> @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
> >>>>>>>>  };
> >>>>>>>>  #endif
> >>>>>>>>
> >>>>>>>> +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
> >>>>>>>> +/**
> >>>>>>>> + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_=
EMIT_SAMPLE
> >>>>>>>> + * action.
> >>>>>>>> + *
> >>>>>>>> + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the s=
ource of the
> >>>>>>>> + * sample.
> >>>>>>>> + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cooki=
e that contains
> >>>>>>>> + * user-defined metadata. The maximum length is OVS_EMIT_SAMPLE=
_COOKIE_MAX_SIZE
> >>>>>>>> + * bytes.
> >>>>>>>> + *
> >>>>>>>> + * Sends the packet to the psample multicast group with the spe=
cified group and
> >>>>>>>> + * cookie. It is possible to combine this action with the
> >>>>>>>> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packe=
t being emitted.
> >>>>>>>
> >>>>>>> Although this include file is kernel-related, it will probably be=
 re-used for
> >>>>>>> other datapaths, so should we be more general here?
> >>>>>>>
> >>>>>>
> >>>>>> The uAPI header documentation will be used for other datapaths? Ho=
w so?
> >>>>>> At some point we should document what the action does from the ker=
nel
> >>>>>> pov, right? Where should we do that if not here?
> >>>>>
> >>>>> Well you know how OVS works, all the data paths use the same netlin=
k messages. Not sure how to solve this, but we could change the text a bit =
to be more general?
> >>>>>
> >>>>>  * For the Linux kernel it sends the packet to the psample multicas=
t group
> >>>>>  * with the specified group and cookie. It is possible to combine t=
his
> >>>>>  * action with the %OVS_ACTION_ATTR_TRUNC action to limit the size =
of the
> >>>>>  * packet being emitted.
> >>>>>
> >>>>
> >>>> I know we reuse the kernel attributes I don't think the uAPI
> >>>> documentation should be less expressive just because some userspace
> >>>> application decides to reuse parts of it.
> >>>>
> >>>> There are many kernel-specific terms all over the uAPI ("netdev",
> >>>> "netlink pid", "skb", even the action "userspace") that do not make
> >>>> sense in a non-kernel datapath.
> >>>
> >>> +1
> >>>
> >>> This is a kernel uAPI header it describes the behavior of the kernel.
> >>> Having parts like "For the Linux kernel" in here is awkward.
> >>>
> >>>>
> >>>> Maybe we can add such a comment in the copy of the header we store i=
n
> >>>> the ovs tree?
> >>>
> >>> Makes sense to me.
> >>>
> >>> If we'll want to implement a similar action in userspace datapath,
> >>> we'll have to have a separate documentation for it anyway, since
> >>> the packets will end up in a different place for users to collect.
> >>>
> >>>>
> >>>>
> >>>>>>>> + */
> >>>>>>>> +enum ovs_emit_sample_attr {
> >>>>>>>> +	OVS_EMIT_SAMPLE_ATTR_GROUP =3D 1,	/* u32 number. */
> >>>>>>>> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cooki=
e. */
> >>>>>>>
> >>>>>>> As we start a new set of attributes maybe it would be good starti=
ng it off in
> >>>>>>> alphabetical order?
> >>>>>>>
> >>>>>>
> >>>>>> Having an optional attribute before a mandatory one seems strange =
to me,
> >>>>>> wouldn't you agree?
> >>>>>
> >>>>> I don't mind, but I don't have a strong opinion on it. If others do=
n't mind,
> >>>>> I would leave it as is.
> >>>>>
> >>>>
> >>>> I think I prefer to put mandatory attributes first.
> >>>
> >>> That's my thought as well.  Though that might be broken if we ever ne=
ed
> >>> more attributes.  But we do not extend individual actions that often.
> >>>
> >>> Best regards, Ilya Maximets.
> >>
>


