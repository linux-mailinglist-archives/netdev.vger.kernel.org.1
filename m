Return-Path: <netdev+bounces-107304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302191A848
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185C82838E3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7190D194A45;
	Thu, 27 Jun 2024 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2R3Mg0e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C741946B8
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496123; cv=none; b=DTh+uTEzYlNaZ1TPhxoEwZFCOsXIYWdY6eBLgZtGlZ5wjvH9m6ur1GhnuaZxpa6Q67pto7CoHEaBFvuWzeTJuaFt3CVu+dFcBgR9Pm0wF3Ok53Pdh9qsIJptFluAaqRDZZyHyPEgeOV+m1kwTvg1V4ln/REq8lYX2XEyWwGlh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496123; c=relaxed/simple;
	bh=9yohlM4xB0FRwzz/IGTSvZ4KBSPKS2iMjhIGgpWSa20=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R82FIL9xdlQgaAGX+KSuASMhAHs4L/NECcht0ruv7aXIn/Zm0BbkcY/ow1zJKgNTovvyODsjH6Fcjd4OCP1OUl9264UHry2xyuE1kwj9tj/XLB514hzWYOuJF2MigTG5X80QzFMeoUhvdh5krQfrz4BJvghwBN7ujtcXlFCno4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2R3Mg0e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719496120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/1RktnrhfAxIyut1kOZLMos2VtDaaFNc71o9vXXv/w=;
	b=e2R3Mg0eEoFC3LVHVBA5afH2n8gTTMp7ILxwEbJ7sE5v1VVwmB9muLNwsglsbbp1PDI7uh
	qTn1H7Jsc0I9DsMY8AhCadXXkWVByDZZ3ciXpKlrwjDcm4qOpJEG8y8Yjzcm7xT6XhwJQe
	wqrGVB7HkjwTMsUUDf/X0vxAxcO9dh8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-dsNHRmJ6NKaKvygkhaA86A-1; Thu, 27 Jun 2024 09:48:38 -0400
X-MC-Unique: dsNHRmJ6NKaKvygkhaA86A-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-704d99cb97aso9371344a12.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719496117; x=1720100917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H/1RktnrhfAxIyut1kOZLMos2VtDaaFNc71o9vXXv/w=;
        b=uG+3I83GumJBF+BYaJDOTl+epr890eAq1P60uXSiNvsTdEb/odBEHFQWDZDLzTmyJ/
         7P0XGkkJjctWBnBqHEJYElnREjJKTvlX29r8tdzTWS574Zjge25wsWT4qpCEvKQ4ouuc
         88x6IThPCcyXaHZl112UW8wvQ1+QPCFykXOZs2eyupJwtBh87dCUmnNB7+EPFEyb8Fbw
         FY9pc8oGnvXYHkAgbFEK7vrTDBbc94279RqKQMNjm4eCvjWt7v6IO62WTn0lM2tK2RZq
         lRGW1XQ8Ju9KYUf/kMwyEJ0Dew73oGmkhDCqg7E0n0kUC73KThnBkQ6glvYsUZEKSPyU
         uimQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6TtBrACeqpSiUprO+G0G3O6UvngcvkJIpR+nuLKGGaiN/lMt4S4tOIM7sHOa6P8REa8b7gr+TPw33CfvQrTsc5YB2tkY1
X-Gm-Message-State: AOJu0Yzc96ybEgYPgkBt9sNK1bgTiaI3vKlYjHDI9uhUXxSMOYd3NXsf
	siY4IjcI9l9x9K6M+pCN+8dME2XIa8pgJZVdp3TcLhYuv1XP+wX6i0yS/vMZLM/F70cjs+OHSu4
	igEpuh7nw4TELQmj4zlGBuZjMXZb1dYkOzQrUlBAxjcORn3oz638BQ0RtIuT+ebSWXnm9olmE5l
	BdXBNzEEMtMru0wA1rjfXPaZwDzTwi
X-Received: by 2002:a05:6a20:4c1b:b0:1be:c479:5734 with SMTP id adf61e73a8af0-1bec4795acdmr3463852637.4.1719496117511;
        Thu, 27 Jun 2024 06:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIHFbRXyP+NP/pQqBSeTIUokImw9rJdFPp+H+SsRRWg5gvrm8YfDg5bIDkuY23gt3dBYIRsHKbt2el78xhhdQ=
X-Received: by 2002:a05:6a20:4c1b:b0:1be:c479:5734 with SMTP id
 adf61e73a8af0-1bec4795acdmr3463828637.4.1719496117019; Thu, 27 Jun 2024
 06:48:37 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jun 2024 06:48:35 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <CAG=2xmOnDZP3QtBbShoAqptY0uSywhFCGAwUYO+UuXfLkMXE7A@mail.gmail.com>
 <04D55CAD-0BFC-4B62-9827-C3D1A9B7792A@redhat.com> <CAG=2xmMThQvNaS30PRCFMjt1atODZQdyZ9jyVuWbeeXThs5UCg@mail.gmail.com>
 <617f9ff3-822e-4467-894c-f247fd9029ec@ovn.org> <DC37197E-BABA-425F-9BF2-D70F7B285527@redhat.com>
 <b42e503b-663d-4d44-86d1-ab93feec4593@ovn.org> <97CA519E-AC24-4D61-819F-B3B5A88F89E4@redhat.com>
 <CAG=2xmP5oVKetn6WKKQg0kThh-V0Ofpe=xgiQOkHFSyTaXNHug@mail.gmail.com>
 <2c6317e3-615b-4113-8df6-702ca20bf87d@ovn.org> <f7tikxuzf6n.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7tikxuzf6n.fsf@redhat.com>
Date: Thu, 27 Jun 2024 06:48:35 -0700
Message-ID: <CAG=2xmOxYAeQ2g9M4bk_sbEYcW2XC7846FUu0CTaGQ7+jp0nsg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample action
To: Aaron Conole <aconole@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Eelco Chaudron <echaudro@redhat.com>, netdev@vger.kernel.org, 
	horms@kernel.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Pravin B Shelar <pshelar@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 09:30:08AM GMT, Aaron Conole wrote:
> Ilya Maximets <i.maximets@ovn.org> writes:
>
> > On 6/27/24 12:15, Adri=C3=A1n Moreno wrote:
> >> On Thu, Jun 27, 2024 at 11:31:41AM GMT, Eelco Chaudron wrote:
> >>>
> >>>
> >>> On 27 Jun 2024, at 11:23, Ilya Maximets wrote:
> >>>
> >>>> On 6/27/24 11:14, Eelco Chaudron wrote:
> >>>>>
> >>>>>
> >>>>> On 27 Jun 2024, at 10:36, Ilya Maximets wrote:
> >>>>>
> >>>>>> On 6/27/24 09:52, Adri=C3=A1n Moreno wrote:
> >>>>>>> On Thu, Jun 27, 2024 at 09:06:46AM GMT, Eelco Chaudron wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 26 Jun 2024, at 22:34, Adri=C3=A1n Moreno wrote:
> >>>>>>>>
> >>>>>>>>> On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
> >>>>>>>>>>
> >>>>>>>>>>> Add support for a new action: emit_sample.
> >>>>>>>>>>>
> >>>>>>>>>>> This action accepts a u32 group id and a variable-length cook=
ie and uses
> >>>>>>>>>>> the psample multicast group to make the packet available for
> >>>>>>>>>>> observability.
> >>>>>>>>>>>
> >>>>>>>>>>> The maximum length of the user-defined cookie is set to 16, s=
ame as
> >>>>>>>>>>> tc_cookie, to discourage using cookies that will not be offlo=
adable.
> >>>>>>>>>>
> >>>>>>>>>> I=E2=80=99ll add the same comment as I had in the user space p=
art, and that
> >>>>>>>>>> is that I feel from an OVS perspective this action should be c=
alled
> >>>>>>>>>> emit_local() instead of emit_sample() to make it Datapath inde=
pendent.
> >>>>>>>>>> Or quoting the earlier comment:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> =E2=80=9CI=E2=80=99ll start the discussion again on the naming=
. The name "emit_sample()"
> >>>>>>>>>> does not seem appropriate. This function's primary role is to =
copy the
> >>>>>>>>>> packet and send it to a local collector, which varies dependin=
g on the
> >>>>>>>>>> datapath. For the kernel datapath, this collector is psample, =
while for
> >>>>>>>>>> userspace, it will likely be some kind of probe. This action i=
s distinct
> >>>>>>>>>> from the sample() action by design; it is a standalone action =
that can
> >>>>>>>>>> be combined with others.
> >>>>>>>>>>
> >>>>>>>>>> Furthermore, the action itself does not involve taking a sampl=
e; it
> >>>>>>>>>> consistently pushes the packet to the local collector. Therefo=
re, I
> >>>>>>>>>> suggest renaming "emit_sample()" to "emit_local()". This same =
goes for
> >>>>>>>>>> all the derivative ATTR naming.=E2=80=9D
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> This is a blurry semantic area.
> >>>>>>>>> IMO, "sample" is the act of extracting (potentially a piece of)
> >>>>>>>>> someting, in this case, a packet. It is common to only take som=
e packets
> >>>>>>>>> as samples, so this action usually comes with some kind of "rat=
e", but
> >>>>>>>>> even if the rate is 1, it's still sampling in this context.
> >>>>>>>>>
> >>>>>>>>> OTOH, OVS kernel design tries to be super-modular and define sm=
all
> >>>>>>>>> combinable actions, so the rate or probability generation is do=
ne with
> >>>>>>>>> another action which is (IMHO unfortunately) named "sample".
> >>>>>>>>>
> >>>>>>>>> With that interpretation of the term it would actually make mor=
e sense
> >>>>>>>>> to rename "sample" to something like "random" (of course I'm no=
t
> >>>>>>>>> suggestion we do it). "sample" without any nested action that a=
ctually
> >>>>>>>>> sends the packet somewhere is not sampling, it's just doing som=
ething or
> >>>>>>>>> not based on a probability. Where as "emit_sample" is sampling =
even if
> >>>>>>>>> it's not nested inside a "sample".
> >>>>>>>>
> >>>>>>>> You're assuming we are extracting a packet for sampling, but thi=
s function
> >>>>>>>> can be used for various other purposes. For instance, it could h=
andle the
> >>>>>>>> packet outside of the OVS pipeline through an eBPF program (so w=
e are not
> >>>>>>>> taking a sample, but continue packet processing outside of the O=
VS
> >>>>>>>> pipeline). Calling it emit_sampling() in such cases could be ver=
y
> >>>>>>>> confusing.
> >>>>>>
> >>>>>> We can't change the implementation of the action once it is part o=
f uAPI.
> >>>>>> We have to document where users can find these packets and we can'=
t just
> >>>>>> change the destination later.
> >>>>>
> >>>>> I'm not suggesting we change the uAPI implementation, but we could =
use the
> >>>>> emit_xxx() action with an eBPF probe on the action to perform other=
 tasks.
> >>>>> This is just an example.
> >>>>
> >>>> Yeah, but as Adrian said below, you could do that with any action an=
d
> >>>> this doesn't change the semantics of the action itself.
> >>>
> >>> Well this was just an example, what if we have some other need for ge=
tting
> >>> a packet to userspace through emit_local() other than sampling? The
> >>> emit_sample() action naming in this case makes no sense.
> >>>
> >>>>>>> Well, I guess that would be clearly abusing the action. You could=
 say
> >>>>>>> that of anything really. You could hook into skb_consume and cont=
inue
> >>>>>>> processing the skb but that doesn't change the intended behavior =
of the
> >>>>>>> drop action.
> >>>>>>>
> >>>>>>> The intended behavior of the action is sampling, as is the intend=
ed
> >>>>>>> behavior of "psample".
> >>>>>>
> >>>>>> The original OVS_ACTION_ATTR_SAMPLE "Probabilitically executes act=
ions",
> >>>>>> that is it takes some packets from the whole packet stream and exe=
cutes
> >>>>>> actions of them.  Without tying this to observability purposes the=
 name
> >>>>>> makes sense as the first definition of the word is "to take a repr=
esentative
> >>>>>> part or a single item from a larger whole or group".
> >>>>>>
> >>>>>> Now, our new action doesn't have this particular semantic in a way=
 that
> >>>>>> it doesn't take a part of a whole packet stream but rather using t=
he
> >>>>>> part already taken.  However, it is directly tied to the parent
> >>>>>> OVS_ACTION_ATTR_SAMPLE action, since it reports probability of tha=
t parent
> >>>>>> action.  If there is no parent, then probability is assumed to be =
100%,
> >>>>>> but that's just a corner case.  The name of a psample module has t=
he
> >>>>>> same semantics in its name, it doesn't sample on it's own, but it =
is
> >>>>>> assuming that sampling was performed as it relays the rate of it.
> >>>>>>
> >>>>>> And since we're directly tied here with both OVS_ACTION_ATTR_SAMPL=
E and
> >>>>>> the psample module, the emit_sample() name makes sense to me.
> >>>>>
> >>>>> This is the part I don't like. emit_sample() should be treated as a
> >>>>> standalone action. While it may have potential dependencies on
> >>>>> OVS_ACTION_ATTR_SAMPLE, it should also be perfectly fine to use it
> >>>>> independently.
> >>>>
> >>>> It is fine to use it, we just assume implicit 100% sampling.
> >>>
> >>> Agreed, but the name does not make sense ;) I do not think we
> >>> currently have any actions that explicitly depend on each other
> >>> (there might be attributes carried over) and I want to keep it
> >>> as such.
> >>>
> >>>>>>>>> Having said that, I don't have a super strong favor for "emit_s=
ample". I'm
> >>>>>>>>> OK with "emit_local" or "emit_packet" or even just "emit".
> >>>>>>
> >>>>>> The 'local' or 'packet' variants are not descriptive enough on wha=
t we're
> >>>>>> trying to achieve and do not explain why the probability is attach=
ed to
> >>>>>> the action, i.e. do not explain the link between this action and t=
he
> >>>>>> OVS_ACTION_ATTR_SAMPLE.
> >>>>>>
> >>>>>> emit_Psample() would be overly specific, I agree, but making the n=
ame too
> >>>>>> generic will also make it hard to add new actions.  If we use some=
 overly
> >>>>>> broad term for this one, we may have to deal with overlapping sema=
ntics in
> >>>>>> the future.
> >>>>>>
> >>>>>>>>> I don't think any term will fully satisfy everyone so I hope we=
 can find
> >>>>>>>>> a reasonable compromise.
> >>>>>>>>
> >>>>>>>> My preference would be emit_local() as we hand it off to some lo=
cal
> >>>>>>>> datapath entity.
> >>>>>>
> >>>>>> What is "local datapath entity" ?  psample module is not part of O=
VS datapath.
> >>>>>> And what is "local" ?  OpenFlow has the OFPP_LOCAL port that is re=
presented
> >>>>>> by a bridge port on a datapath level, that will be another source =
of confusion
> >>>>>> as it can be interpreted as sending a packet via a local bridge po=
rt.
> >>>>>
> >>>>> I guess I hinted at a local exit point in the specific netdev/netli=
nk datapath,
> >>>>> where exit is to the local host. So maybe we should call it emit_lo=
calhost?
> >>>>
> >>>> For me sending to localhost means sending to a loopback interface or=
 otherwise
> >>>> sending the packet to the host networking stack.  And we're not doin=
g that.
> >>>
> >>> That might be confusing too... Maybe emit_external()?
> >>
> >> "External" was the word I used for the original userspace RFC. The
> >> rationale being: We're sending the packet to something external from O=
VS
> >> (datapath or userspace). Compared with IPFIX-based observability which
> >> where the sample is first processed ("internally") by ovs-vswitchd.
> >>
> >> In userspace it kept the sampling/observability meaning because it was
> >> part of the Flow_Sample_Collector_Set which is intrinsically an
> >> observability thing.
> >>
> >> However, in the datapath we loose that meaning and could be confused
> >> with some external packet-processing entity. How about "external_obser=
ve"
> >> or something that somehow keeps that meaning?
> >
> > This semantics conversation doesn't seem productive as we're going in c=
ircles
> > around what we already discussed what feels like at least three separat=
e times
> > on this and ovs-dev lists.
>
> +1
>
> > I'd say if we can't agree on OVS_ACTION_ATTR_EMIT_SAMPLE, then just cal=
l
> > it OVS_ACTION_ATTR_SEND_TO_PSAMPLE.  Simple, describes exactly what it =
does.
> > And if we ever want to have "local" sampling for OVS userspace datapath=
,
> > we can create a userspace-only datapath action for it and call it in a =
way
> > that describes what it does, e.g. OVS_ACTION_ATTR_SEND_TO_USDT or whate=
ver.
> > Unlike key attributes, we can relatively safely create userspace-only a=
ctions
> > without consequences for kernel uAPI.  In fact, we have a few such acti=
ons.
> > And we can choose which one to use based on which one is supported by t=
he
> > current datapath.
>
> I'm okay with the emit_sample or with send_to_psample.  There are
> probably hundreds of colors to paint this shed, tbh.  We could argue
> that it could even be an extension to userspace() instead of a separate
> action, or that we could have a generic socket_write(type=3Dpsample) type
> of action.  But in the end, I don't have a strong feeling either way,
> whether it's:
>
> OVS_ACTION_ATTR_EMIT_SAMPLE / emit_sample()
> OVS_ACTION_ATTR_SEND_TO_PSAMPLE / psample() or emit_psample()
> OVS_ACTION_ATTR_EMIT_EXTERNAL / emit_external()
>
> There aren't really too many differences in them, and it wouldn't bother
> me in any case.  I guess a XXX?psample() action does end up being the
> clearest since it has 'psample' right in the name and then we can know
> right away what it is doing.
>

The original purpose of the name was to have the same action for both
userspace and kernel so that, name aside, the semantics
(ACT_XXXX(group=3D10,cookie=3D0x123)) remains the same. If we break that, w=
e
risk having userspace and kernel actions differ in ways that makes it
difficult to unify at the xlate/OpenFlow/OVSDB layers.

But if we can enforce that somehow I guess it's OK.

Thanks.
Adri=C3=A1n


