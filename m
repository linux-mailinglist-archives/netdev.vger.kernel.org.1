Return-Path: <netdev+bounces-107716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAE91C12D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DF71F22766
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00771586C1;
	Fri, 28 Jun 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsqQ1lBh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFD1C0050
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585491; cv=none; b=QNeEGI1kjrmFKGUzdAbp8Tn0E+uqYE5898Fic+qmpOi2izRub8ZJprD3olu0e67Yk1ecNZdoelBJQKzL+2cwvoFHQNbOJxA6vyCmDRBElrgam0QYPfwPrb4QRtCJP+8kreaKmvC4al/J/LEUgW7UDZ66aF/fhXS9hINQcXU3vRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585491; c=relaxed/simple;
	bh=zroCYXj+UlsQ9YZCmb56AFpPDKxoaQBd5VRsjByam9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rJEpi4lsprBGYh9D/1GbXplk6M11XravNbIp2ojy/bN5b3f/6gzKtE9FS2izvBDe3ijlTybIic9shL6kiKfCDQAzD/u6JqEa/Yt7Qi4fxxQ67zI3G1UpStHonFhXXwpP5AV3N/p0n/LqR36Z33dquC9oxjM4/981DgDkWCOq03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsqQ1lBh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719585488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUf+ExPi82UBWeQTcS/JGaW0OAEu1iVb58h4e8AJeQs=;
	b=KsqQ1lBhiT5vyPJ7704DnYIqhO400F3l9H7XgvHdmwJEduzqem7Mnnym4FK4if768A6JyX
	6TJ1n9VQ04sL6DAU3vPRwu8GfdcEAQHfsC00qO+UpuCA+Q8rLh1FLBbRe0HGbKfGnc7FN1
	yVuDZV033eedh5kQh92OuFhWH/zoHuk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-XPy8jbNMOXmJBMb6tM_3Tg-1; Fri,
 28 Jun 2024 10:38:03 -0400
X-MC-Unique: XPy8jbNMOXmJBMb6tM_3Tg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ABA01956069;
	Fri, 28 Jun 2024 14:38:01 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E562F19773D8;
	Fri, 28 Jun 2024 14:37:58 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>,  Eelco Chaudron
 <echaudro@redhat.com>,  netdev@vger.kernel.org,  horms@kernel.org,
  dev@openvswitch.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Donald Hunter <donald.hunter@gmail.com>,
  Pravin B Shelar <pshelar@ovn.org>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample action
In-Reply-To: <CAG=2xmOxYAeQ2g9M4bk_sbEYcW2XC7846FUu0CTaGQ7+jp0nsg@mail.gmail.com>
	(=?utf-8?Q?=22Adri=C3=A1n?= Moreno"'s message of "Thu, 27 Jun 2024 06:48:35
 -0700")
References: <CAG=2xmOnDZP3QtBbShoAqptY0uSywhFCGAwUYO+UuXfLkMXE7A@mail.gmail.com>
	<04D55CAD-0BFC-4B62-9827-C3D1A9B7792A@redhat.com>
	<CAG=2xmMThQvNaS30PRCFMjt1atODZQdyZ9jyVuWbeeXThs5UCg@mail.gmail.com>
	<617f9ff3-822e-4467-894c-f247fd9029ec@ovn.org>
	<DC37197E-BABA-425F-9BF2-D70F7B285527@redhat.com>
	<b42e503b-663d-4d44-86d1-ab93feec4593@ovn.org>
	<97CA519E-AC24-4D61-819F-B3B5A88F89E4@redhat.com>
	<CAG=2xmP5oVKetn6WKKQg0kThh-V0Ofpe=xgiQOkHFSyTaXNHug@mail.gmail.com>
	<2c6317e3-615b-4113-8df6-702ca20bf87d@ovn.org>
	<f7tikxuzf6n.fsf@redhat.com>
	<CAG=2xmOxYAeQ2g9M4bk_sbEYcW2XC7846FUu0CTaGQ7+jp0nsg@mail.gmail.com>
Date: Fri, 28 Jun 2024 10:37:56 -0400
Message-ID: <f7ttthdxhdn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

> On Thu, Jun 27, 2024 at 09:30:08AM GMT, Aaron Conole wrote:
>> Ilya Maximets <i.maximets@ovn.org> writes:
>>
>> > On 6/27/24 12:15, Adri=C3=A1n Moreno wrote:
>> >> On Thu, Jun 27, 2024 at 11:31:41AM GMT, Eelco Chaudron wrote:
>> >>>
>> >>>
>> >>> On 27 Jun 2024, at 11:23, Ilya Maximets wrote:
>> >>>
>> >>>> On 6/27/24 11:14, Eelco Chaudron wrote:
>> >>>>>
>> >>>>>
>> >>>>> On 27 Jun 2024, at 10:36, Ilya Maximets wrote:
>> >>>>>
>> >>>>>> On 6/27/24 09:52, Adri=C3=A1n Moreno wrote:
>> >>>>>>> On Thu, Jun 27, 2024 at 09:06:46AM GMT, Eelco Chaudron wrote:
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>> On 26 Jun 2024, at 22:34, Adri=C3=A1n Moreno wrote:
>> >>>>>>>>
>> >>>>>>>>> On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
>> >>>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
>> >>>>>>>>>>
>> >>>>>>>>>>> Add support for a new action: emit_sample.
>> >>>>>>>>>>>
>> >>>>>>>>>>> This action accepts a u32 group id and a variable-length
>> >>>>>>>>>>> cookie and uses
>> >>>>>>>>>>> the psample multicast group to make the packet available for
>> >>>>>>>>>>> observability.
>> >>>>>>>>>>>
>> >>>>>>>>>>> The maximum length of the user-defined cookie is set to
>> >>>>>>>>>>> 16, same as
>> >>>>>>>>>>> tc_cookie, to discourage using cookies that will not be
>> >>>>>>>>>>> offloadable.
>> >>>>>>>>>>
>> >>>>>>>>>> I=E2=80=99ll add the same comment as I had in the user space =
part, and that
>> >>>>>>>>>> is that I feel from an OVS perspective this action should be =
called
>> >>>>>>>>>> emit_local() instead of emit_sample() to make it Datapath
>> >>>>>>>>>> independent.
>> >>>>>>>>>> Or quoting the earlier comment:
>> >>>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>> =E2=80=9CI=E2=80=99ll start the discussion again on the namin=
g. The name
>> >>>>>>>>>> "emit_sample()"
>> >>>>>>>>>> does not seem appropriate. This function's primary role
>> >>>>>>>>>> is to copy the
>> >>>>>>>>>> packet and send it to a local collector, which varies
>> >>>>>>>>>> depending on the
>> >>>>>>>>>> datapath. For the kernel datapath, this collector is
>> >>>>>>>>>> psample, while for
>> >>>>>>>>>> userspace, it will likely be some kind of probe. This
>> >>>>>>>>>> action is distinct
>> >>>>>>>>>> from the sample() action by design; it is a standalone
>> >>>>>>>>>> action that can
>> >>>>>>>>>> be combined with others.
>> >>>>>>>>>>
>> >>>>>>>>>> Furthermore, the action itself does not involve taking a samp=
le; it
>> >>>>>>>>>> consistently pushes the packet to the local collector. Theref=
ore, I
>> >>>>>>>>>> suggest renaming "emit_sample()" to "emit_local()". This
>> >>>>>>>>>> same goes for
>> >>>>>>>>>> all the derivative ATTR naming.=E2=80=9D
>> >>>>>>>>>>
>> >>>>>>>>>
>> >>>>>>>>> This is a blurry semantic area.
>> >>>>>>>>> IMO, "sample" is the act of extracting (potentially a piece of)
>> >>>>>>>>> someting, in this case, a packet. It is common to only
>> >>>>>>>>> take some packets
>> >>>>>>>>> as samples, so this action usually comes with some kind of
>> >>>>>>>>> "rate", but
>> >>>>>>>>> even if the rate is 1, it's still sampling in this context.
>> >>>>>>>>>
>> >>>>>>>>> OTOH, OVS kernel design tries to be super-modular and define s=
mall
>> >>>>>>>>> combinable actions, so the rate or probability generation
>> >>>>>>>>> is done with
>> >>>>>>>>> another action which is (IMHO unfortunately) named "sample".
>> >>>>>>>>>
>> >>>>>>>>> With that interpretation of the term it would actually
>> >>>>>>>>> make more sense
>> >>>>>>>>> to rename "sample" to something like "random" (of course I'm n=
ot
>> >>>>>>>>> suggestion we do it). "sample" without any nested action
>> >>>>>>>>> that actually
>> >>>>>>>>> sends the packet somewhere is not sampling, it's just
>> >>>>>>>>> doing something or
>> >>>>>>>>> not based on a probability. Where as "emit_sample" is
>> >>>>>>>>> sampling even if
>> >>>>>>>>> it's not nested inside a "sample".
>> >>>>>>>>
>> >>>>>>>> You're assuming we are extracting a packet for sampling,
>> >>>>>>>> but this function
>> >>>>>>>> can be used for various other purposes. For instance, it
>> >>>>>>>> could handle the
>> >>>>>>>> packet outside of the OVS pipeline through an eBPF program
>> >>>>>>>> (so we are not
>> >>>>>>>> taking a sample, but continue packet processing outside of the =
OVS
>> >>>>>>>> pipeline). Calling it emit_sampling() in such cases could be ve=
ry
>> >>>>>>>> confusing.
>> >>>>>>
>> >>>>>> We can't change the implementation of the action once it is
>> >>>>>> part of uAPI.
>> >>>>>> We have to document where users can find these packets and we
>> >>>>>> can't just
>> >>>>>> change the destination later.
>> >>>>>
>> >>>>> I'm not suggesting we change the uAPI implementation, but we
>> >>>>> could use the
>> >>>>> emit_xxx() action with an eBPF probe on the action to perform
>> >>>>> other tasks.
>> >>>>> This is just an example.
>> >>>>
>> >>>> Yeah, but as Adrian said below, you could do that with any action a=
nd
>> >>>> this doesn't change the semantics of the action itself.
>> >>>
>> >>> Well this was just an example, what if we have some other need for g=
etting
>> >>> a packet to userspace through emit_local() other than sampling? The
>> >>> emit_sample() action naming in this case makes no sense.
>> >>>
>> >>>>>>> Well, I guess that would be clearly abusing the action. You coul=
d say
>> >>>>>>> that of anything really. You could hook into skb_consume and con=
tinue
>> >>>>>>> processing the skb but that doesn't change the intended
>> >>>>>>> behavior of the
>> >>>>>>> drop action.
>> >>>>>>>
>> >>>>>>> The intended behavior of the action is sampling, as is the inten=
ded
>> >>>>>>> behavior of "psample".
>> >>>>>>
>> >>>>>> The original OVS_ACTION_ATTR_SAMPLE "Probabilitically
>> >>>>>> executes actions",
>> >>>>>> that is it takes some packets from the whole packet stream and ex=
ecutes
>> >>>>>> actions of them.  Without tying this to observability purposes th=
e name
>> >>>>>> makes sense as the first definition of the word is "to take a
>> >>>>>> representative
>> >>>>>> part or a single item from a larger whole or group".
>> >>>>>>
>> >>>>>> Now, our new action doesn't have this particular semantic in a wa=
y that
>> >>>>>> it doesn't take a part of a whole packet stream but rather using =
the
>> >>>>>> part already taken.  However, it is directly tied to the parent
>> >>>>>> OVS_ACTION_ATTR_SAMPLE action, since it reports probability
>> >>>>>> of that parent
>> >>>>>> action.  If there is no parent, then probability is assumed to be=
 100%,
>> >>>>>> but that's just a corner case.  The name of a psample module has =
the
>> >>>>>> same semantics in its name, it doesn't sample on it's own, but it=
 is
>> >>>>>> assuming that sampling was performed as it relays the rate of it.
>> >>>>>>
>> >>>>>> And since we're directly tied here with both OVS_ACTION_ATTR_SAMP=
LE and
>> >>>>>> the psample module, the emit_sample() name makes sense to me.
>> >>>>>
>> >>>>> This is the part I don't like. emit_sample() should be treated as a
>> >>>>> standalone action. While it may have potential dependencies on
>> >>>>> OVS_ACTION_ATTR_SAMPLE, it should also be perfectly fine to use it
>> >>>>> independently.
>> >>>>
>> >>>> It is fine to use it, we just assume implicit 100% sampling.
>> >>>
>> >>> Agreed, but the name does not make sense ;) I do not think we
>> >>> currently have any actions that explicitly depend on each other
>> >>> (there might be attributes carried over) and I want to keep it
>> >>> as such.
>> >>>
>> >>>>>>>>> Having said that, I don't have a super strong favor for
>> >>>>>>>>> "emit_sample". I'm
>> >>>>>>>>> OK with "emit_local" or "emit_packet" or even just "emit".
>> >>>>>>
>> >>>>>> The 'local' or 'packet' variants are not descriptive enough
>> >>>>>> on what we're
>> >>>>>> trying to achieve and do not explain why the probability is attac=
hed to
>> >>>>>> the action, i.e. do not explain the link between this action and =
the
>> >>>>>> OVS_ACTION_ATTR_SAMPLE.
>> >>>>>>
>> >>>>>> emit_Psample() would be overly specific, I agree, but making
>> >>>>>> the name too
>> >>>>>> generic will also make it hard to add new actions.  If we use
>> >>>>>> some overly
>> >>>>>> broad term for this one, we may have to deal with overlapping
>> >>>>>> semantics in
>> >>>>>> the future.
>> >>>>>>
>> >>>>>>>>> I don't think any term will fully satisfy everyone so I
>> >>>>>>>>> hope we can find
>> >>>>>>>>> a reasonable compromise.
>> >>>>>>>>
>> >>>>>>>> My preference would be emit_local() as we hand it off to some l=
ocal
>> >>>>>>>> datapath entity.
>> >>>>>>
>> >>>>>> What is "local datapath entity" ?  psample module is not part
>> >>>>>> of OVS datapath.
>> >>>>>> And what is "local" ?  OpenFlow has the OFPP_LOCAL port that
>> >>>>>> is represented
>> >>>>>> by a bridge port on a datapath level, that will be another
>> >>>>>> source of confusion
>> >>>>>> as it can be interpreted as sending a packet via a local bridge p=
ort.
>> >>>>>
>> >>>>> I guess I hinted at a local exit point in the specific
>> >>>>> netdev/netlink datapath,
>> >>>>> where exit is to the local host. So maybe we should call it
>> >>>>> emit_localhost?
>> >>>>
>> >>>> For me sending to localhost means sending to a loopback
>> >>>> interface or otherwise
>> >>>> sending the packet to the host networking stack.  And we're not
>> >>>> doing that.
>> >>>
>> >>> That might be confusing too... Maybe emit_external()?
>> >>
>> >> "External" was the word I used for the original userspace RFC. The
>> >> rationale being: We're sending the packet to something external from =
OVS
>> >> (datapath or userspace). Compared with IPFIX-based observability which
>> >> where the sample is first processed ("internally") by ovs-vswitchd.
>> >>
>> >> In userspace it kept the sampling/observability meaning because it was
>> >> part of the Flow_Sample_Collector_Set which is intrinsically an
>> >> observability thing.
>> >>
>> >> However, in the datapath we loose that meaning and could be confused
>> >> with some external packet-processing entity. How about "external_obse=
rve"
>> >> or something that somehow keeps that meaning?
>> >
>> > This semantics conversation doesn't seem productive as we're going
>> > in circles
>> > around what we already discussed what feels like at least three
>> > separate times
>> > on this and ovs-dev lists.
>>
>> +1
>>
>> > I'd say if we can't agree on OVS_ACTION_ATTR_EMIT_SAMPLE, then just ca=
ll
>> > it OVS_ACTION_ATTR_SEND_TO_PSAMPLE.  Simple, describes exactly what it=
 does.
>> > And if we ever want to have "local" sampling for OVS userspace datapat=
h,
>> > we can create a userspace-only datapath action for it and call it in a=
 way
>> > that describes what it does, e.g. OVS_ACTION_ATTR_SEND_TO_USDT or what=
ever.
>> > Unlike key attributes, we can relatively safely create
>> > userspace-only actions
>> > without consequences for kernel uAPI.  In fact, we have a few such act=
ions.
>> > And we can choose which one to use based on which one is supported by =
the
>> > current datapath.
>>
>> I'm okay with the emit_sample or with send_to_psample.  There are
>> probably hundreds of colors to paint this shed, tbh.  We could argue
>> that it could even be an extension to userspace() instead of a separate
>> action, or that we could have a generic socket_write(type=3Dpsample) type
>> of action.  But in the end, I don't have a strong feeling either way,
>> whether it's:
>>
>> OVS_ACTION_ATTR_EMIT_SAMPLE / emit_sample()
>> OVS_ACTION_ATTR_SEND_TO_PSAMPLE / psample() or emit_psample()
>> OVS_ACTION_ATTR_EMIT_EXTERNAL / emit_external()
>>
>> There aren't really too many differences in them, and it wouldn't bother
>> me in any case.  I guess a XXX?psample() action does end up being the
>> clearest since it has 'psample' right in the name and then we can know
>> right away what it is doing.
>>
>
> The original purpose of the name was to have the same action for both
> userspace and kernel so that, name aside, the semantics
> (ACT_XXXX(group=3D10,cookie=3D0x123)) remains the same. If we break that,=
 we
> risk having userspace and kernel actions differ in ways that makes it
> difficult to unify at the xlate/OpenFlow/OVSDB layers.
>
> But if we can enforce that somehow I guess it's OK.

I think it's less important for that.  We do have actions that exist
which are datapath specific, so there is precedent.

> Thanks.
> Adri=C3=A1n


