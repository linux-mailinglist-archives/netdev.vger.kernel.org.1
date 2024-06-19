Return-Path: <netdev+bounces-104740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AECAE90E393
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00090B2172E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 06:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099BD6F2E2;
	Wed, 19 Jun 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKq7d8dv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C862582
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778963; cv=none; b=JJ7tBGeRY7SieF9ob2c2zLiL9Q/kAROh27p0wmsWw15oQuWXpbm5//JQzSQ92/8+6b0ekSUE/PLbV7MA/et98+CJ3Sm4wESVPFOxWb9rcIwbxQal66JDIHNGq2SvYnBIZaE4NTUZP1bdlYuS2H8JasabcJHR2lc9e7ETFAJFyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778963; c=relaxed/simple;
	bh=z7fnUOpJn9iXs1WFNBu+J8B3dRAQiPHV6KcmVYH+pp8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WljNu52u+J/jIEDlCX0UnLIIiuaJyGSSNNbnKkM2EsGeCsLZM/I9EI4l637TBKzAxb4piFN+u354Fivy8P9N0tnyavAeznRJ6j4OL0xxC6l/VpWHl8h0stAZYala7Pz9qHaN+s72OMgNVX/uXNA+93H/SOGnz2dLwYrtHQYYKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKq7d8dv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718778960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaiauho8zuIrRMOeuRwnq+9cR0RXx6mO3pEo4S6k/MM=;
	b=PKq7d8dv1GUxQuKjWZB2wcFytcX4WOzQ9Yg/JB83CMt8mxneQu91Gz+/AE8S23mTxIQvxZ
	7bAnr+T0Y67hFjZd8t5mgxDldqxXxv0gOI4TWuDAU9XciEv0N8dcLdlc8m+SeQU+u9ny2D
	pQEn9uKx8l0E7lDsQ4lrKc6J5PedX44=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-n86JKvB9PLuQyRcBoIW6RQ-1; Wed, 19 Jun 2024 02:35:59 -0400
X-MC-Unique: n86JKvB9PLuQyRcBoIW6RQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c7430b3c4bso1434280a91.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718778958; x=1719383758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uaiauho8zuIrRMOeuRwnq+9cR0RXx6mO3pEo4S6k/MM=;
        b=ZnBOfpNOsLsRpHJSlcWffYjuQwWro+ct/bmpUIJUrSMVLXot18OG5iZ/ZZrl9GQDAp
         kj9F7NXc8Mt463Eh2I3tWS6FefuBEWaQ0oK8rpBLcHaM2FEYUU9Oz1RFPOn9813RXhr6
         z4QETVvjPtAHC1ONEF4Tti4r6C4nnv2oz0mgUAKeJIl5ntrIgdWJXUUM+PPoRp9IIc8j
         8XNdgW3B7M/F5Ohi3jazfZgMGW+JEgG9GnM9+VMuayBXDEOdQt0L4txc/R/BrNNGDBrf
         gzKXOePBEqXzE0+LAvib46jD87JNnzP12thaoI+EM1despZMgXMChOxeY98DgyJSjhU8
         Racg==
X-Gm-Message-State: AOJu0YxJXlKD18QwaQwN0bRjC0qNFo/K1kCixlZJm/GImj/KR3tURSyR
	IStlDTpDIoDg/lOmOuvI8Y9+YFsnFwxFCHoD3GKkHnrnHStVifdQ8RRlJBoXk4yktJxpf7hP5nB
	JixBTpYIzOC/FfPeN5r94K4ZGMYRE12yMD44FdJQ1QoVgIdl8W0iYWQF0XL2qrAiFcujuyejMZk
	9Wx5JkAKtHmV8/+IBxFjb3zRtFYYkL
X-Received: by 2002:a17:90a:b10a:b0:2c4:def3:b88b with SMTP id 98e67ed59e1d1-2c7b5cc9fe9mr1925840a91.23.1718778958094;
        Tue, 18 Jun 2024 23:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhkrv4QynBMfFTDVUaTZnwK8fmqgIoDFBa8qmryuxWUKgHn8K5AMz/fWihNr1uqk6F84p2jx1cW8lBg5NFO3A=
X-Received: by 2002:a17:90a:b10a:b0:2c4:def3:b88b with SMTP id
 98e67ed59e1d1-2c7b5cc9fe9mr1925818a91.23.1718778957506; Tue, 18 Jun 2024
 23:35:57 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Jun 2024 06:35:55 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-8-amorenoz@redhat.com>
 <8624ccf8-e9e2-4a95-a25c-7d3166bb3256@ovn.org> <f8050877-1728-4723-acb8-8a8ab7674470@ovn.org>
 <CAG=2xmPAwvCR4ky0cu7Yai29v3H592-ATXtNkhsNJ-vTwR4BVw@mail.gmail.com>
 <5f293bac-4117-4f93-8d3f-636d6ce236a4@ovn.org> <CAG=2xmPbpvYGy1rAkcLsK6PFxCx3bmZyXKX5RTag8XZBTxMZdg@mail.gmail.com>
 <5c369615-1774-4dc5-87fc-d96ce3421ff8@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5c369615-1774-4dc5-87fc-d96ce3421ff8@ovn.org>
Date: Wed, 19 Jun 2024 06:35:55 +0000
Message-ID: <CAG=2xmNWXjocXk6FXfvxjOeKgB0BQsEdXvFRm6OoqHKs88OmTw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/9] net: openvswitch: do not notify drops
 inside sample
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 05:44:05PM GMT, Ilya Maximets wrote:
> On 6/18/24 12:50, Adri=C3=A1n Moreno wrote:
> > On Tue, Jun 18, 2024 at 12:22:23PM GMT, Ilya Maximets wrote:
> >> On 6/18/24 09:00, Adri=C3=A1n Moreno wrote:
> >>> On Mon, Jun 17, 2024 at 02:10:37PM GMT, Ilya Maximets wrote:
> >>>> On 6/17/24 13:55, Ilya Maximets wrote:
> >>>>> On 6/3/24 20:56, Adrian Moreno wrote:
> >>>>>> The OVS_ACTION_ATTR_SAMPLE action is, in essence,
> >>>>>> observability-oriented.
> >>>>>>
> >>>>>> Apart from some corner case in which it's used a replacement of cl=
one()
> >>>>>> for old kernels, it's really only used for sFlow, IPFIX and now,
> >>>>>> local emit_sample.
> >>>>>>
> >>>>>> With this in mind, it doesn't make much sense to report
> >>>>>> OVS_DROP_LAST_ACTION inside sample actions.
> >>>>>>
> >>>>>> For instance, if the flow:
> >>>>>>
> >>>>>>   actions:sample(..,emit_sample(..)),2
> >>>>>>
> >>>>>> triggers a OVS_DROP_LAST_ACTION skb drop event, it would be extrem=
ely
> >>>>>> confusing for users since the packet did reach its destination.
> >>>>>>
> >>>>>> This patch makes internal action execution silently consume the sk=
b
> >>>>>> instead of notifying a drop for this case.
> >>>>>>
> >>>>>> Unfortunately, this patch does not remove all potential sources of
> >>>>>> confusion since, if the sample action itself is the last action, e=
.g:
> >>>>>>
> >>>>>>     actions:sample(..,emit_sample(..))
> >>>>>>
> >>>>>> we actually _should_ generate a OVS_DROP_LAST_ACTION event, but we=
 aren't.
> >>>>>>
> >>>>>> Sadly, this case is difficult to solve without breaking the
> >>>>>> optimization by which the skb is not cloned on last sample actions=
.
> >>>>>> But, given explicit drop actions are now supported, OVS can just a=
dd one
> >>>>>> after the last sample() and rewrite the flow as:
> >>>>>>
> >>>>>>     actions:sample(..,emit_sample(..)),drop
> >>>>>>
> >>>>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >>>>>> ---
> >>>>>>  net/openvswitch/actions.c | 13 +++++++++++--
> >>>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> >>>>>> index 33f6d93ba5e4..54fc1abcff95 100644
> >>>>>> --- a/net/openvswitch/actions.c
> >>>>>> +++ b/net/openvswitch/actions.c
> >>>>>> @@ -82,6 +82,15 @@ static struct action_fifo __percpu *action_fifo=
s;
> >>>>>>  static struct action_flow_keys __percpu *flow_keys;
> >>>>>>  static DEFINE_PER_CPU(int, exec_actions_level);
> >>>>>>
> >>>>>> +static inline void ovs_drop_skb_last_action(struct sk_buff *skb)
> >>>>>> +{
> >>>>>> +	/* Do not emit packet drops inside sample(). */
> >>>>>> +	if (OVS_CB(skb)->probability)
> >>>>>> +		consume_skb(skb);
> >>>>>> +	else
> >>>>>> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>>>> +}
> >>>>>> +
> >>>>>>  /* Make a clone of the 'key', using the pre-allocated percpu 'flo=
w_keys'
> >>>>>>   * space. Return NULL if out of key spaces.
> >>>>>>   */
> >>>>>> @@ -1061,7 +1070,7 @@ static int sample(struct datapath *dp, struc=
t sk_buff *skb,
> >>>>>>  	if ((arg->probability !=3D U32_MAX) &&
> >>>>>>  	    (!arg->probability || get_random_u32() > arg->probability)) =
{
> >>>>>>  		if (last)
> >>>>>> -			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>>>> +			ovs_drop_skb_last_action(skb);
> >>>>
> >>>> Always consuming the skb at this point makes sense, since having sma=
ple()
> >>>> as a last action is a reasonable thing to have.  But this looks more=
 like
> >>>> a fix for the original drop reason patch set.
> >>>>
> >>>
> >>> I don't think consuming the skb at this point makes sense. It was ver=
y
> >>> intentionally changed to a drop since a very common use-case for
> >>> sampling is drop-sampling, i.e: replacing an empty action list (that
> >>> triggers OVS_DROP_LAST_ACTION) with a sample(emit_sample()). Ideally,
> >>> that replacement should not have any effect on the number of
> >>> OVS_DROP_LAST_ACTION being reported as the packets are being treated =
in
> >>> the same way (only observed in one case).
> >>>
> >>>
> >>>>>>  		return 0;
> >>>>>>  	}
> >>>>>>
> >>>>>> @@ -1579,7 +1588,7 @@ static int do_execute_actions(struct datapat=
h *dp, struct sk_buff *skb,
> >>>>>>  		}
> >>>>>>  	}
> >>>>>>
> >>>>>> -	ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>>>> +	ovs_drop_skb_last_action(skb);
> >>>>>
> >>>>> I don't think I agree with this one.  If we have a sample() action =
with
> >>>>> a lot of different actions inside and we reached the end while the =
last
> >>>>> action didn't consume the skb, then we should report that.  E.g.
> >>>>> "sample(emit_sample(),push_vlan(),set(eth())),2"  should report tha=
t the
> >>>>> cloned skb was dropped.  "sample(push_vlan(),emit_sample())" should=
 not.
> >>>>>
> >>>
> >>> What is the use case for such action list? Having an action branch
> >>> executed randomly doesn't make sense to me if it's not some
> >>> observability thing (which IMHO should not trigger drops).
> >>
> >> It is exactly my point.  A list of actions that doesn't end is some so=
rt
> >> of a terminal action (output, drop, etc) does not make a lot of sense =
and
> >> hence should be signaled as an unexpected drop, so users can re-check =
the
> >> pipeline in case they missed the terminal action somehow.
> >>
> >>>
> >>>>> The only actions that are actually consuming the skb are "output",
> >>>>> "userspace", "recirc" and now "emit_sample".  "output" and "recirc"=
 are
> >>>>> consuming the skb "naturally" by stealing it when it is the last ac=
tion.
> >>>>> "userspace" has an explicit check to consume the skb if it is the l=
ast
> >>>>> action.  "emit_sample" should have the similar check.  It should li=
kely
> >>>>> be added at the point of action introduction instead of having a se=
parate
> >>>>> patch.
> >>>>>
> >>>
> >>> Unlinke "output", "recirc", "userspace", etc. with emit_sample the
> >>> packet does not continue it's way through the datapath.
> >>
> >> After "output" the packet leaves the datapath too, i.e. does not conti=
nue
> >> it's way through OVS datapath.
> >>
> >
> > I meant a broader concept of "datapath". The packet continues. For the
> > userspace action this is true only for the CONTROLLER ofp action but
> > since the datapath does not know which action it's implementing, we
> > cannot do better.
>
> It's not only controller() action.  Packets can be brought to userspace
> for various reason including just an explicit ask to execute some actions
> in userspace.  In any case the packet sent to userspace kind of reached i=
ts
> destination and it's not the "datapath drops the packet" situation.
>
> >
> >>>
> >>> It would be very confusing if OVS starts monitoring drops and adds a =
bunch
> >>> of flows such as "actions:emit_sample()" and suddently it stops repor=
ting such
> >>> drops via standard kfree_skb_reason. Packets _are_ being dropped here=
,
> >>> we are just observing them.
> >>
> >> This might make sense from the higher logic in user space application,=
 but
> >> it doesn't from the datapath perspective.  And also, if the user adds =
the
> >> 'emit_sample' action for drop monitring, they already know where to fi=
nd
> >> packet samples, they don't need to use tools like dropwatch anymore.
> >> This packet is not dropped from the datapath perspective, it is sample=
d.
> >>
> >>>
> >>> And if we change emit_sample to trigger a drop if it's the last actio=
n,
> >>> then "sample(50%, emit_sample()),2" will trigger a drop half of the t=
imes
> >>> which is also terribly confusing.
> >>
> >> If emit_sample is the last action, then skb should be consumed silentl=
y.
> >> The same as for "output" and "userspace".
> >>
> >>>
> >>> I think we should try to be clear and informative with what we
> >>> _actually_ drop and not require the user that is just running
> >>> "dropwatch" to understand the internals of the OVS module.
> >>
> >> If someone is already using sampling to watch their packet drops, why =
would
> >> they use dropwatch?
> >>
> >>>
> >>> So if you don't want to accept the "observational" nature of sample()=
,
> >>> the only other solution that does not bring even more confusion to OV=
S
> >>> drops would be to have userspace add explicit drop actions. WDYT?
> >>>
> >>
> >> These are not drops from the datapath perspective.  Users can add expl=
icit
> >> drop actions if they want to, but I'm really not sure why they would d=
o that
> >> if they are already capturing all these packets in psample, sFlow or I=
PFIX.
> >
> > Because there is not a single "user". Tools and systems can be built on
> > top of tracepoints and samples and they might not be coordinated betwee=
n
> > them. Some observability application can be always enabled and doing
> > constant network monitoring or statistics while other lower level tools
> > can be run at certain moments to troubleshoot issues.
> >
> > In order to run dropwatch in a node you don't need to have rights to
> > access the OpenFlow controller and ask it to change the OpenFlow rules
> > or else dropwatch simply will not show actual packet drops.
>
> The point is that these are not drops in this scenario.  The packet was
> delivered to its destination and hence should not be reported as dropped.
> In the observability use-case that you're describing even OpenFlow layer
> in OVS doesn't know if these supposed to be treated as packet drops for
> the user or if these are just samples with the sampling being the only
> intended destination.  For OpenFlow and OVS userspace components these
> two scenarios are indistinguishable.  Only the OpenFlow controller knows
> that these rules were put in place because it was an ACL created by some
> user or tool.  And since OVS in user space can't make such a distinction,
> kernel can't make it either, and so shouldn't guess what the user two
> levels of abstraction higher up meant.
>
> >
> > To me it seems obvious that drop sampling (via emit_sample) "includes"
> > drop reporting via emit_sample. In both cases you get the packet
> > headers, but in one case you also get OFP controller metadata. Now even
> > if there is a system that uses both, does it make sense to push to them
> > the responsibility of dealing with them being mutually exclusive?
> >
> > I think this makes debugging OVS datapath unnecessarily obscure when we
> > know the packet is actually being dropped intentionally by OVS.
>
> I don't think we know that we're in a drop sampling scenario.  We don't
> have enough information even in OVS userspace to tell.
>
> And having different behavior between "userspace" and "emit_sample" in
> the kernel may cause even more confusion, because now two ways of samplin=
g
> packets will result in packets showing up in dropwatch in one case, but
> not in the other.
>
> >
> > What's the problem with having OVS write the following?
> >     "sample(50%, emit_sample()),drop(0)"
>
> It's a valid sequence of actions, but we shouldn't guess what the end
> user meant by putting those actions into the kernel.  If we see such a
> sequence in the kernel, then we should report an explicit drop.  If
> there was only the "sample(50%, emit_sample())" then we should simply
> consume the skb as it reached its destination in the psample.
>
> For the question if OVS in user space should put explicit drop action
> while preparing to emit sample, this doesn't sound reasonable for the
> same reason - OVS in user space doesn't know what the intention was of
> the user or tool that put the sampling action into OpenFlow pipeline.
>

I don't see it that way. The spec says that packets whose action sets
(the result of classification) have no output action and no group action
must be dropped. Even if OFP sample action is an extension, I don't see
it invalidating that semantics.
So, IMHO, OVS does know that a flow that is just sampled is a drop.

> I actually became more confused about what are we arguing about.
> To recap:
>
>                                      This patch     My proposal
>
> 1. emit_sample() is the last            consume        consume
>     inside the sample()
>
> 2. the end of the action list           consume        drop
>     inside the sample()
>
> 3. emit_sample() is the last            drop           consume
>     outside the sample()
>
> 4. the end of the action list           drop           drop
>     outside the sample()
>
> 5. sample() is the last action          consume        consume
>     and probability failed
>
>
> I don't think cases 1 and 3 should differ, i.e. the behavior should
> be the same regardless of emit_sample() being inside or outside of
> the sample().  As a side point, OVS in user space will omit the 100%
> rate sample() action and will just list inner actions instead.  This
> means that 100% probability sampling will generate drops and 99% will
> not.  Doesn't sound right.
>

That's what I was refering to in the commit message, we still OVS to
write:
    actions:sample(..,emit_sample(..)),drop

> Case 2 should likely never happen, but I'd like to see a drop reported
> if that ever happens, because it is not a meaningful list of actions.
>
> Best regards, Ilya Maximets.
>

I think we could drop this patch if we agree that OVS could write
explicit drops when it knows the packet is being dropped and sampled
(the action only has OFP sample actions).

The drop could be placed inside the odp sample action to avoid
breaking the clone optimization:
    actions:sample(50%, actions(emit_sample(),drop)))

or outside if the sample itself is optimized out:
    actions:emit_sample(),drop

IIUC, if we don't do that, we are saying that sampling is incompatible
with decent drop reporting via kfree_skb infrastructure used by tools
like dropwatch or retis (among many others). And I think that is
unnecessarily and deliberately making OVS datapath more difficult to
troubleshoot.

Thanks,
Adri=C3=A1n


