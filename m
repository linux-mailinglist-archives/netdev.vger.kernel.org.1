Return-Path: <netdev+bounces-107300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7629091A7E5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA707B280C3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A0E19308E;
	Thu, 27 Jun 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTWpiOUW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBD6EB56
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495023; cv=none; b=j+0T9JjRzKs5C2QbuigAuwob6lOl7lVrDu6MSaX9Nh4tLwB0N17e1Hmmtf6OdAc5PH68K1Ct4/DwY9beIvp1/dQE/wpAZ6meYR2Ingt36DOCm2BowPwxDmPKYEr+GkXTZB8BWQgKpijpjbBkc7ywMmwFRc16DxdeOcFW1SuMk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495023; c=relaxed/simple;
	bh=cLTj/prjFL8YimmE6QY1i5sa76gsqkII64wbJx6alt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OAeWjypjXDkoYYASsOHfZCuDAec6dxqyldh9rpAUd+LWoF/rdsEHcyfhH9/7lGn5qR3//VMKahRv1j2ii6tHrk7vZFmZmvwYnTXK0wuFnBXh1U+qWOwf2ltk450nSDoSmPzcHOurJNXHGxXX8XbjUGtoUukKyNWjfsJU5/g4jWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTWpiOUW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719495019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNL47henN2ZMR0UKGFJgvaLHIQkny0nh3eBTEo26YfE=;
	b=aTWpiOUWr8Cce5H9mYUxX97vY2DWEGRLQmap1PXl/AIZlqbNKREiVQgT4WHl6vAwZT3sm9
	6+2GOw1U5GqgVolVdF5gDdLjmxPP9+FRyTSsMCBttSaHyiCMzsVur3k43LyBfakAgdfdqk
	kR+5TBQX2HW9wp/xjs0n1Pd+t/QUbl0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-Y31JkgblPxe5xMMpwg6LCg-1; Thu,
 27 Jun 2024 09:30:15 -0400
X-MC-Unique: Y31JkgblPxe5xMMpwg6LCg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A1AE1944D1D;
	Thu, 27 Jun 2024 13:30:13 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 653001955BD4;
	Thu, 27 Jun 2024 13:30:10 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>,  Eelco Chaudron
 <echaudro@redhat.com>,  netdev@vger.kernel.org,  horms@kernel.org,
  dev@openvswitch.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Donald Hunter <donald.hunter@gmail.com>,
  Pravin B Shelar <pshelar@ovn.org>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample action
In-Reply-To: <2c6317e3-615b-4113-8df6-702ca20bf87d@ovn.org> (Ilya Maximets's
	message of "Thu, 27 Jun 2024 12:52:35 +0200")
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
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 27 Jun 2024 09:30:08 -0400
Message-ID: <f7tikxuzf6n.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Ilya Maximets <i.maximets@ovn.org> writes:

> On 6/27/24 12:15, Adri=C3=A1n Moreno wrote:
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
>>>>>> On 6/27/24 09:52, Adri=C3=A1n Moreno wrote:
>>>>>>> On Thu, Jun 27, 2024 at 09:06:46AM GMT, Eelco Chaudron wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 26 Jun 2024, at 22:34, Adri=C3=A1n Moreno wrote:
>>>>>>>>
>>>>>>>>> On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
>>>>>>>>>>
>>>>>>>>>>> Add support for a new action: emit_sample.
>>>>>>>>>>>
>>>>>>>>>>> This action accepts a u32 group id and a variable-length cookie=
 and uses
>>>>>>>>>>> the psample multicast group to make the packet available for
>>>>>>>>>>> observability.
>>>>>>>>>>>
>>>>>>>>>>> The maximum length of the user-defined cookie is set to 16, sam=
e as
>>>>>>>>>>> tc_cookie, to discourage using cookies that will not be offload=
able.
>>>>>>>>>>
>>>>>>>>>> I=E2=80=99ll add the same comment as I had in the user space par=
t, and that
>>>>>>>>>> is that I feel from an OVS perspective this action should be cal=
led
>>>>>>>>>> emit_local() instead of emit_sample() to make it Datapath indepe=
ndent.
>>>>>>>>>> Or quoting the earlier comment:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> =E2=80=9CI=E2=80=99ll start the discussion again on the naming. =
The name "emit_sample()"
>>>>>>>>>> does not seem appropriate. This function's primary role is to co=
py the
>>>>>>>>>> packet and send it to a local collector, which varies depending =
on the
>>>>>>>>>> datapath. For the kernel datapath, this collector is psample, wh=
ile for
>>>>>>>>>> userspace, it will likely be some kind of probe. This action is =
distinct
>>>>>>>>>> from the sample() action by design; it is a standalone action th=
at can
>>>>>>>>>> be combined with others.
>>>>>>>>>>
>>>>>>>>>> Furthermore, the action itself does not involve taking a sample;=
 it
>>>>>>>>>> consistently pushes the packet to the local collector. Therefore=
, I
>>>>>>>>>> suggest renaming "emit_sample()" to "emit_local()". This same go=
es for
>>>>>>>>>> all the derivative ATTR naming.=E2=80=9D
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is a blurry semantic area.
>>>>>>>>> IMO, "sample" is the act of extracting (potentially a piece of)
>>>>>>>>> someting, in this case, a packet. It is common to only take some =
packets
>>>>>>>>> as samples, so this action usually comes with some kind of "rate"=
, but
>>>>>>>>> even if the rate is 1, it's still sampling in this context.
>>>>>>>>>
>>>>>>>>> OTOH, OVS kernel design tries to be super-modular and define small
>>>>>>>>> combinable actions, so the rate or probability generation is done=
 with
>>>>>>>>> another action which is (IMHO unfortunately) named "sample".
>>>>>>>>>
>>>>>>>>> With that interpretation of the term it would actually make more =
sense
>>>>>>>>> to rename "sample" to something like "random" (of course I'm not
>>>>>>>>> suggestion we do it). "sample" without any nested action that act=
ually
>>>>>>>>> sends the packet somewhere is not sampling, it's just doing somet=
hing or
>>>>>>>>> not based on a probability. Where as "emit_sample" is sampling ev=
en if
>>>>>>>>> it's not nested inside a "sample".
>>>>>>>>
>>>>>>>> You're assuming we are extracting a packet for sampling, but this =
function
>>>>>>>> can be used for various other purposes. For instance, it could han=
dle the
>>>>>>>> packet outside of the OVS pipeline through an eBPF program (so we =
are not
>>>>>>>> taking a sample, but continue packet processing outside of the OVS
>>>>>>>> pipeline). Calling it emit_sampling() in such cases could be very
>>>>>>>> confusing.
>>>>>>
>>>>>> We can't change the implementation of the action once it is part of =
uAPI.
>>>>>> We have to document where users can find these packets and we can't =
just
>>>>>> change the destination later.
>>>>>
>>>>> I'm not suggesting we change the uAPI implementation, but we could us=
e the
>>>>> emit_xxx() action with an eBPF probe on the action to perform other t=
asks.
>>>>> This is just an example.
>>>>
>>>> Yeah, but as Adrian said below, you could do that with any action and
>>>> this doesn't change the semantics of the action itself.
>>>
>>> Well this was just an example, what if we have some other need for gett=
ing
>>> a packet to userspace through emit_local() other than sampling? The
>>> emit_sample() action naming in this case makes no sense.
>>>
>>>>>>> Well, I guess that would be clearly abusing the action. You could s=
ay
>>>>>>> that of anything really. You could hook into skb_consume and contin=
ue
>>>>>>> processing the skb but that doesn't change the intended behavior of=
 the
>>>>>>> drop action.
>>>>>>>
>>>>>>> The intended behavior of the action is sampling, as is the intended
>>>>>>> behavior of "psample".
>>>>>>
>>>>>> The original OVS_ACTION_ATTR_SAMPLE "Probabilitically executes actio=
ns",
>>>>>> that is it takes some packets from the whole packet stream and execu=
tes
>>>>>> actions of them.  Without tying this to observability purposes the n=
ame
>>>>>> makes sense as the first definition of the word is "to take a repres=
entative
>>>>>> part or a single item from a larger whole or group".
>>>>>>
>>>>>> Now, our new action doesn't have this particular semantic in a way t=
hat
>>>>>> it doesn't take a part of a whole packet stream but rather using the
>>>>>> part already taken.  However, it is directly tied to the parent
>>>>>> OVS_ACTION_ATTR_SAMPLE action, since it reports probability of that =
parent
>>>>>> action.  If there is no parent, then probability is assumed to be 10=
0%,
>>>>>> but that's just a corner case.  The name of a psample module has the
>>>>>> same semantics in its name, it doesn't sample on it's own, but it is
>>>>>> assuming that sampling was performed as it relays the rate of it.
>>>>>>
>>>>>> And since we're directly tied here with both OVS_ACTION_ATTR_SAMPLE =
and
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
>>>>>>>>> Having said that, I don't have a super strong favor for "emit_sam=
ple". I'm
>>>>>>>>> OK with "emit_local" or "emit_packet" or even just "emit".
>>>>>>
>>>>>> The 'local' or 'packet' variants are not descriptive enough on what =
we're
>>>>>> trying to achieve and do not explain why the probability is attached=
 to
>>>>>> the action, i.e. do not explain the link between this action and the
>>>>>> OVS_ACTION_ATTR_SAMPLE.
>>>>>>
>>>>>> emit_Psample() would be overly specific, I agree, but making the nam=
e too
>>>>>> generic will also make it hard to add new actions.  If we use some o=
verly
>>>>>> broad term for this one, we may have to deal with overlapping semant=
ics in
>>>>>> the future.
>>>>>>
>>>>>>>>> I don't think any term will fully satisfy everyone so I hope we c=
an find
>>>>>>>>> a reasonable compromise.
>>>>>>>>
>>>>>>>> My preference would be emit_local() as we hand it off to some local
>>>>>>>> datapath entity.
>>>>>>
>>>>>> What is "local datapath entity" ?  psample module is not part of OVS=
 datapath.
>>>>>> And what is "local" ?  OpenFlow has the OFPP_LOCAL port that is repr=
esented
>>>>>> by a bridge port on a datapath level, that will be another source of=
 confusion
>>>>>> as it can be interpreted as sending a packet via a local bridge port.
>>>>>
>>>>> I guess I hinted at a local exit point in the specific netdev/netlink=
 datapath,
>>>>> where exit is to the local host. So maybe we should call it emit_loca=
lhost?
>>>>
>>>> For me sending to localhost means sending to a loopback interface or o=
therwise
>>>> sending the packet to the host networking stack.  And we're not doing =
that.
>>>
>>> That might be confusing too... Maybe emit_external()?
>>=20
>> "External" was the word I used for the original userspace RFC. The
>> rationale being: We're sending the packet to something external from OVS
>> (datapath or userspace). Compared with IPFIX-based observability which
>> where the sample is first processed ("internally") by ovs-vswitchd.
>>=20
>> In userspace it kept the sampling/observability meaning because it was
>> part of the Flow_Sample_Collector_Set which is intrinsically an
>> observability thing.
>>=20
>> However, in the datapath we loose that meaning and could be confused
>> with some external packet-processing entity. How about "external_observe"
>> or something that somehow keeps that meaning?
>
> This semantics conversation doesn't seem productive as we're going in cir=
cles
> around what we already discussed what feels like at least three separate =
times
> on this and ovs-dev lists.

+1

> I'd say if we can't agree on OVS_ACTION_ATTR_EMIT_SAMPLE, then just call
> it OVS_ACTION_ATTR_SEND_TO_PSAMPLE.  Simple, describes exactly what it do=
es.
> And if we ever want to have "local" sampling for OVS userspace datapath,
> we can create a userspace-only datapath action for it and call it in a way
> that describes what it does, e.g. OVS_ACTION_ATTR_SEND_TO_USDT or whateve=
r.
> Unlike key attributes, we can relatively safely create userspace-only act=
ions
> without consequences for kernel uAPI.  In fact, we have a few such action=
s.
> And we can choose which one to use based on which one is supported by the
> current datapath.

I'm okay with the emit_sample or with send_to_psample.  There are
probably hundreds of colors to paint this shed, tbh.  We could argue
that it could even be an extension to userspace() instead of a separate
action, or that we could have a generic socket_write(type=3Dpsample) type
of action.  But in the end, I don't have a strong feeling either way,
whether it's:

OVS_ACTION_ATTR_EMIT_SAMPLE / emit_sample()
OVS_ACTION_ATTR_SEND_TO_PSAMPLE / psample() or emit_psample()
OVS_ACTION_ATTR_EMIT_EXTERNAL / emit_external()

There aren't really too many differences in them, and it wouldn't bother
me in any case.  I guess a XXX?psample() action does end up being the
clearest since it has 'psample' right in the name and then we can know
right away what it is doing.

> Best regards, Ilya Maximets.


