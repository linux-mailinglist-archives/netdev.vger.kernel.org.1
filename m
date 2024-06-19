Return-Path: <netdev+bounces-105035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B690F796
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B53F2832B0
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7521591F3;
	Wed, 19 Jun 2024 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3ddwFdO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40E46426
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829609; cv=none; b=bHVyKZWpg15N7A7VKhxCR6sjcyUSZ4kfPeFpVoaSrDBomoDB3DkOcdQFh+6Rjra9UOIq0xuzZzM6o4kPfHew2Rz4mngR33z6or88VDf/AGG7iz+QN6VUf6g/H2Rmb6SVx/K2wGENCthMRo6gbrG7JDR2ZZBELuNc2gmlbzHAtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829609; c=relaxed/simple;
	bh=S7QilYAI/ERc+Iiav2VuCMv39uHnsftVBxzze6qxJb0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEL1yILl0p76Fzs476pIxVblZ1AQqjCTpTk1QihTJV+VFfWS9R0TSmWtx/T6hIujNrHMaZY5o4TVBVPdfMznhdR5a/wPE8yPH2+nyKvqwJ0WtxKzyHudz9eoUFexQO0sI5DCYnKBtz8dP8OIOEX/89wU2BnD46Qku4SbduoBSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3ddwFdO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718829605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7AlWQL5S/wkFuqpvdeZdhsg4cN8Wxn4B6AXKblG+Gs=;
	b=d3ddwFdON09v30C5Vxosd0OoED7yfYWJ6Cd6uMBZRm/eCX8Z33NCDe0cxjzyp6yiuYM8Ym
	2aIlbE7Lt2oWlIMSdaOTId1mUeOh7ibrlekBp7GgBs9mufmgvoUx8ebM3uySoWPl29ZUJA
	Uyj+XV/DXNrsDsLHfyM9WiI55F56B84=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-AaIaIQZJOIOpQqSNhx-fVw-1; Wed, 19 Jun 2024 16:40:04 -0400
X-MC-Unique: AaIaIQZJOIOpQqSNhx-fVw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b50433add5so2871106d6.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718829604; x=1719434404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7AlWQL5S/wkFuqpvdeZdhsg4cN8Wxn4B6AXKblG+Gs=;
        b=u8FNRcQHD3uRZukpq85Bvstk/TXLX++fA8MWTjlJfVak2+aiTVJS95E9R2bDxLbC0q
         bPAlL38H57boLLLRWDe0yMA9aWxrNmug6VIg7PIR1BbezVovt7m78dndxTyHRNLxx+tx
         GmJDsow3Cyo1U+6RRx/hoe42qH38qT2fD/vvEpK/NeGDEfxj5AUmgVXLl2xt7Gw+kycO
         7AdmjNh4ZoExeEM7clAqZB9EEhcsAHCqNcBIgUpuGtw9GXqT6ftXeKwoIeKN6wz+MsQv
         lGriLuNJVKIpOVuzJyxNQDht+o/tE3N6egrWHfLJdr7dYSFxw8k0UYs3KXdBjZeah3RN
         ljzQ==
X-Gm-Message-State: AOJu0Yz6aMK1uYYElbTTNeRzClcFzVR/gR307zloyagMTggZg901uc9r
	z7ruLmMcSVDD49tk8p99TY01ktmH/oeZBXys8z90rv4u31sGsCRqFg5fCplgIfhyFLL1g/EwYV6
	72pfFiiG0pcOJS8lMvwRSEn3aJohPOsq352uNIJH0VHNS6zIQXTbzYYW+fAkpyJL5RIg775LeQe
	5dLGy8VESJxMKF08lToZLGE3fTZJeE
X-Received: by 2002:ad4:57aa:0:b0:6b0:738f:faf1 with SMTP id 6a1803df08f44-6b501e3f1b4mr35696856d6.38.1718829603818;
        Wed, 19 Jun 2024 13:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3u9It0QDraAyuCt1WFEP98Mdj35/qyKCseYUSVQBU/Nw54QbB7EnD+Lbrc+FZrsnolxqHwl8GX/vbXLbSfLE=
X-Received: by 2002:ad4:57aa:0:b0:6b0:738f:faf1 with SMTP id
 6a1803df08f44-6b501e3f1b4mr35696746d6.38.1718829603338; Wed, 19 Jun 2024
 13:40:03 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Jun 2024 20:40:02 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-8-amorenoz@redhat.com>
 <8624ccf8-e9e2-4a95-a25c-7d3166bb3256@ovn.org> <f8050877-1728-4723-acb8-8a8ab7674470@ovn.org>
 <CAG=2xmPAwvCR4ky0cu7Yai29v3H592-ATXtNkhsNJ-vTwR4BVw@mail.gmail.com>
 <5f293bac-4117-4f93-8d3f-636d6ce236a4@ovn.org> <CAG=2xmPbpvYGy1rAkcLsK6PFxCx3bmZyXKX5RTag8XZBTxMZdg@mail.gmail.com>
 <5c369615-1774-4dc5-87fc-d96ce3421ff8@ovn.org> <CAG=2xmNWXjocXk6FXfvxjOeKgB0BQsEdXvFRm6OoqHKs88OmTw@mail.gmail.com>
 <9ef1ec07-2345-4176-bc7a-ab7e011484b0@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9ef1ec07-2345-4176-bc7a-ab7e011484b0@ovn.org>
Date: Wed, 19 Jun 2024 20:40:02 +0000
Message-ID: <CAG=2xmPW1Du3ahvwjarHaXMiXe2qr2G-wH9z8Sv7qKQK9t9nTA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/9] net: openvswitch: do not notify drops
 inside sample
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 08:21:02PM GMT, Ilya Maximets wrote:
> On 6/19/24 08:35, Adri=C3=A1n Moreno wrote:
> > On Tue, Jun 18, 2024 at 05:44:05PM GMT, Ilya Maximets wrote:
> >> On 6/18/24 12:50, Adri=C3=A1n Moreno wrote:
> >>> On Tue, Jun 18, 2024 at 12:22:23PM GMT, Ilya Maximets wrote:
> >>>> On 6/18/24 09:00, Adri=C3=A1n Moreno wrote:
> >>>>> On Mon, Jun 17, 2024 at 02:10:37PM GMT, Ilya Maximets wrote:
> >>>>>> On 6/17/24 13:55, Ilya Maximets wrote:
> >>>>>>> On 6/3/24 20:56, Adrian Moreno wrote:
> >>>>>>>> The OVS_ACTION_ATTR_SAMPLE action is, in essence,
> >>>>>>>> observability-oriented.
> >>>>>>>>
> >>>>>>>> Apart from some corner case in which it's used a replacement of =
clone()
> >>>>>>>> for old kernels, it's really only used for sFlow, IPFIX and now,
> >>>>>>>> local emit_sample.
> >>>>>>>>
> >>>>>>>> With this in mind, it doesn't make much sense to report
> >>>>>>>> OVS_DROP_LAST_ACTION inside sample actions.
> >>>>>>>>
> >>>>>>>> For instance, if the flow:
> >>>>>>>>
> >>>>>>>>   actions:sample(..,emit_sample(..)),2
> >>>>>>>>
> >>>>>>>> triggers a OVS_DROP_LAST_ACTION skb drop event, it would be extr=
emely
> >>>>>>>> confusing for users since the packet did reach its destination.
> >>>>>>>>
> >>>>>>>> This patch makes internal action execution silently consume the =
skb
> >>>>>>>> instead of notifying a drop for this case.
> >>>>>>>>
> >>>>>>>> Unfortunately, this patch does not remove all potential sources =
of
> >>>>>>>> confusion since, if the sample action itself is the last action,=
 e.g:
> >>>>>>>>
> >>>>>>>>     actions:sample(..,emit_sample(..))
> >>>>>>>>
> >>>>>>>> we actually _should_ generate a OVS_DROP_LAST_ACTION event, but =
we aren't.
> >>>>>>>>
> >>>>>>>> Sadly, this case is difficult to solve without breaking the
> >>>>>>>> optimization by which the skb is not cloned on last sample actio=
ns.
> >>>>>>>> But, given explicit drop actions are now supported, OVS can just=
 add one
> >>>>>>>> after the last sample() and rewrite the flow as:
> >>>>>>>>
> >>>>>>>>     actions:sample(..,emit_sample(..)),drop
> >>>>>>>>
> >>>>>>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >>>>>>>> ---
> >>>>>>>>  net/openvswitch/actions.c | 13 +++++++++++--
> >>>>>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions=
.c
> >>>>>>>> index 33f6d93ba5e4..54fc1abcff95 100644
> >>>>>>>> --- a/net/openvswitch/actions.c
> >>>>>>>> +++ b/net/openvswitch/actions.c
> >>>>>>>> @@ -82,6 +82,15 @@ static struct action_fifo __percpu *action_fi=
fos;
> >>>>>>>>  static struct action_flow_keys __percpu *flow_keys;
> >>>>>>>>  static DEFINE_PER_CPU(int, exec_actions_level);
> >>>>>>>>
> >>>>>>>> +static inline void ovs_drop_skb_last_action(struct sk_buff *skb=
)
> >>>>>>>> +{
> >>>>>>>> +	/* Do not emit packet drops inside sample(). */
> >>>>>>>> +	if (OVS_CB(skb)->probability)
> >>>>>>>> +		consume_skb(skb);
> >>>>>>>> +	else
> >>>>>>>> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>  /* Make a clone of the 'key', using the pre-allocated percpu 'f=
low_keys'
> >>>>>>>>   * space. Return NULL if out of key spaces.
> >>>>>>>>   */
> >>>>>>>> @@ -1061,7 +1070,7 @@ static int sample(struct datapath *dp, str=
uct sk_buff *skb,
> >>>>>>>>  	if ((arg->probability !=3D U32_MAX) &&
> >>>>>>>>  	    (!arg->probability || get_random_u32() > arg->probability)=
) {
> >>>>>>>>  		if (last)
> >>>>>>>> -			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>>>>>> +			ovs_drop_skb_last_action(skb);
> >>>>>>
> >>>>>> Always consuming the skb at this point makes sense, since having s=
maple()
> >>>>>> as a last action is a reasonable thing to have.  But this looks mo=
re like
> >>>>>> a fix for the original drop reason patch set.
> >>>>>>
> >>>>>
> >>>>> I don't think consuming the skb at this point makes sense. It was v=
ery
> >>>>> intentionally changed to a drop since a very common use-case for
> >>>>> sampling is drop-sampling, i.e: replacing an empty action list (tha=
t
> >>>>> triggers OVS_DROP_LAST_ACTION) with a sample(emit_sample()). Ideall=
y,
> >>>>> that replacement should not have any effect on the number of
> >>>>> OVS_DROP_LAST_ACTION being reported as the packets are being treate=
d in
> >>>>> the same way (only observed in one case).
> >>>>>
> >>>>>
> >>>>>>>>  		return 0;
> >>>>>>>>  	}
> >>>>>>>>
> >>>>>>>> @@ -1579,7 +1588,7 @@ static int do_execute_actions(struct datap=
ath *dp, struct sk_buff *skb,
> >>>>>>>>  		}
> >>>>>>>>  	}
> >>>>>>>>
> >>>>>>>> -	ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>>>>>> +	ovs_drop_skb_last_action(skb);
> >>>>>>>
> >>>>>>> I don't think I agree with this one.  If we have a sample() actio=
n with
> >>>>>>> a lot of different actions inside and we reached the end while th=
e last
> >>>>>>> action didn't consume the skb, then we should report that.  E.g.
> >>>>>>> "sample(emit_sample(),push_vlan(),set(eth())),2"  should report t=
hat the
> >>>>>>> cloned skb was dropped.  "sample(push_vlan(),emit_sample())" shou=
ld not.
> >>>>>>>
> >>>>>
> >>>>> What is the use case for such action list? Having an action branch
> >>>>> executed randomly doesn't make sense to me if it's not some
> >>>>> observability thing (which IMHO should not trigger drops).
> >>>>
> >>>> It is exactly my point.  A list of actions that doesn't end is some =
sort
> >>>> of a terminal action (output, drop, etc) does not make a lot of sens=
e and
> >>>> hence should be signaled as an unexpected drop, so users can re-chec=
k the
> >>>> pipeline in case they missed the terminal action somehow.
> >>>>
> >>>>>
> >>>>>>> The only actions that are actually consuming the skb are "output"=
,
> >>>>>>> "userspace", "recirc" and now "emit_sample".  "output" and "recir=
c" are
> >>>>>>> consuming the skb "naturally" by stealing it when it is the last =
action.
> >>>>>>> "userspace" has an explicit check to consume the skb if it is the=
 last
> >>>>>>> action.  "emit_sample" should have the similar check.  It should =
likely
> >>>>>>> be added at the point of action introduction instead of having a =
separate
> >>>>>>> patch.
> >>>>>>>
> >>>>>
> >>>>> Unlinke "output", "recirc", "userspace", etc. with emit_sample the
> >>>>> packet does not continue it's way through the datapath.
> >>>>
> >>>> After "output" the packet leaves the datapath too, i.e. does not con=
tinue
> >>>> it's way through OVS datapath.
> >>>>
> >>>
> >>> I meant a broader concept of "datapath". The packet continues. For th=
e
> >>> userspace action this is true only for the CONTROLLER ofp action but
> >>> since the datapath does not know which action it's implementing, we
> >>> cannot do better.
> >>
> >> It's not only controller() action.  Packets can be brought to userspac=
e
> >> for various reason including just an explicit ask to execute some acti=
ons
> >> in userspace.  In any case the packet sent to userspace kind of reache=
d its
> >> destination and it's not the "datapath drops the packet" situation.
> >>
> >>>
> >>>>>
> >>>>> It would be very confusing if OVS starts monitoring drops and adds =
a bunch
> >>>>> of flows such as "actions:emit_sample()" and suddently it stops rep=
orting such
> >>>>> drops via standard kfree_skb_reason. Packets _are_ being dropped he=
re,
> >>>>> we are just observing them.
> >>>>
> >>>> This might make sense from the higher logic in user space applicatio=
n, but
> >>>> it doesn't from the datapath perspective.  And also, if the user add=
s the
> >>>> 'emit_sample' action for drop monitring, they already know where to =
find
> >>>> packet samples, they don't need to use tools like dropwatch anymore.
> >>>> This packet is not dropped from the datapath perspective, it is samp=
led.
> >>>>
> >>>>>
> >>>>> And if we change emit_sample to trigger a drop if it's the last act=
ion,
> >>>>> then "sample(50%, emit_sample()),2" will trigger a drop half of the=
 times
> >>>>> which is also terribly confusing.
> >>>>
> >>>> If emit_sample is the last action, then skb should be consumed silen=
tly.
> >>>> The same as for "output" and "userspace".
> >>>>
> >>>>>
> >>>>> I think we should try to be clear and informative with what we
> >>>>> _actually_ drop and not require the user that is just running
> >>>>> "dropwatch" to understand the internals of the OVS module.
> >>>>
> >>>> If someone is already using sampling to watch their packet drops, wh=
y would
> >>>> they use dropwatch?
> >>>>
> >>>>>
> >>>>> So if you don't want to accept the "observational" nature of sample=
(),
> >>>>> the only other solution that does not bring even more confusion to =
OVS
> >>>>> drops would be to have userspace add explicit drop actions. WDYT?
> >>>>>
> >>>>
> >>>> These are not drops from the datapath perspective.  Users can add ex=
plicit
> >>>> drop actions if they want to, but I'm really not sure why they would=
 do that
> >>>> if they are already capturing all these packets in psample, sFlow or=
 IPFIX.
> >>>
> >>> Because there is not a single "user". Tools and systems can be built =
on
> >>> top of tracepoints and samples and they might not be coordinated betw=
een
> >>> them. Some observability application can be always enabled and doing
> >>> constant network monitoring or statistics while other lower level too=
ls
> >>> can be run at certain moments to troubleshoot issues.
> >>>
> >>> In order to run dropwatch in a node you don't need to have rights to
> >>> access the OpenFlow controller and ask it to change the OpenFlow rule=
s
> >>> or else dropwatch simply will not show actual packet drops.
> >>
> >> The point is that these are not drops in this scenario.  The packet wa=
s
> >> delivered to its destination and hence should not be reported as dropp=
ed.
> >> In the observability use-case that you're describing even OpenFlow lay=
er
> >> in OVS doesn't know if these supposed to be treated as packet drops fo=
r
> >> the user or if these are just samples with the sampling being the only
> >> intended destination.  For OpenFlow and OVS userspace components these
> >> two scenarios are indistinguishable.  Only the OpenFlow controller kno=
ws
> >> that these rules were put in place because it was an ACL created by so=
me
> >> user or tool.  And since OVS in user space can't make such a distincti=
on,
> >> kernel can't make it either, and so shouldn't guess what the user two
> >> levels of abstraction higher up meant.
> >>
> >>>
> >>> To me it seems obvious that drop sampling (via emit_sample) "includes=
"
> >>> drop reporting via emit_sample. In both cases you get the packet
> >>> headers, but in one case you also get OFP controller metadata. Now ev=
en
> >>> if there is a system that uses both, does it make sense to push to th=
em
> >>> the responsibility of dealing with them being mutually exclusive?
> >>>
> >>> I think this makes debugging OVS datapath unnecessarily obscure when =
we
> >>> know the packet is actually being dropped intentionally by OVS.
> >>
> >> I don't think we know that we're in a drop sampling scenario.  We don'=
t
> >> have enough information even in OVS userspace to tell.
> >>
> >> And having different behavior between "userspace" and "emit_sample" in
> >> the kernel may cause even more confusion, because now two ways of samp=
ling
> >> packets will result in packets showing up in dropwatch in one case, bu=
t
> >> not in the other.
> >>
> >>>
> >>> What's the problem with having OVS write the following?
> >>>     "sample(50%, emit_sample()),drop(0)"
> >>
> >> It's a valid sequence of actions, but we shouldn't guess what the end
> >> user meant by putting those actions into the kernel.  If we see such a
> >> sequence in the kernel, then we should report an explicit drop.  If
> >> there was only the "sample(50%, emit_sample())" then we should simply
> >> consume the skb as it reached its destination in the psample.
> >>
> >> For the question if OVS in user space should put explicit drop action
> >> while preparing to emit sample, this doesn't sound reasonable for the
> >> same reason - OVS in user space doesn't know what the intention was of
> >> the user or tool that put the sampling action into OpenFlow pipeline.
> >>
> >
> > I don't see it that way. The spec says that packets whose action sets
> > (the result of classification) have no output action and no group actio=
n
> > must be dropped. Even if OFP sample action is an extension, I don't see
> > it invalidating that semantics.
> > So, IMHO, OVS does know that a flow that is just sampled is a drop.
>
> This applies to "action sets", but most users are actually using "action
> lists" supplied via "Apply-actions" OF instruction and the action sets
> always remain empty.  So, from the OF perspective, strictly speaking, we
> are dropping every single packet.  So, this is not a good analogy.
>
> >
> >> I actually became more confused about what are we arguing about.
> >> To recap:
> >>
> >>                                      This patch     My proposal
> >>
> >> 1. emit_sample() is the last            consume        consume
> >>     inside the sample()
> >>
> >> 2. the end of the action list           consume        drop
> >>     inside the sample()
> >>
> >> 3. emit_sample() is the last            drop           consume
> >>     outside the sample()
> >>
> >> 4. the end of the action list           drop           drop
> >>     outside the sample()
> >>
> >> 5. sample() is the last action          consume        consume
> >>     and probability failed
> >>
> >>
> >> I don't think cases 1 and 3 should differ, i.e. the behavior should
> >> be the same regardless of emit_sample() being inside or outside of
> >> the sample().  As a side point, OVS in user space will omit the 100%
> >> rate sample() action and will just list inner actions instead.  This
> >> means that 100% probability sampling will generate drops and 99% will
> >> not.  Doesn't sound right.
> >>
> >
> > That's what I was refering to in the commit message, we still OVS to
> > write:
> >     actions:sample(..,emit_sample(..)),drop
> >
> >> Case 2 should likely never happen, but I'd like to see a drop reported
> >> if that ever happens, because it is not a meaningful list of actions.
> >>
> >> Best regards, Ilya Maximets.
> >>
> >
> > I think we could drop this patch if we agree that OVS could write
> > explicit drops when it knows the packet is being dropped and sampled
> > (the action only has OFP sample actions).
> >
> > The drop could be placed inside the odp sample action to avoid
> > breaking the clone optimization:
> >     actions:sample(50%, actions(emit_sample(),drop)))
> >
> > or outside if the sample itself is optimized out:
> >     actions:emit_sample(),drop
> >
> > IIUC, if we don't do that, we are saying that sampling is incompatible
> > with decent drop reporting via kfree_skb infrastructure used by tools
> > like dropwatch or retis (among many others). And I think that is
> > unnecessarily and deliberately making OVS datapath more difficult to
> > troubleshoot.
>
> This makes some sense, so let's ensure that semantics is consistent
> within the kernel and discuss how to make the tools happy from the
> user space perspective.
>
> But we shouldn't simply drop this patch, we still need to consume the
> skb after emit_sample() when it is the last action.  The same as we
> do for the userpsace() action.  Though it should be done at the point
> of the action introduction.  Having both actions consistent will allow
> us to solve the observability problem for both in the same way by
> adding explicit drop actions from user space.

OK. I'll resend the series dropping this patch (and consuming the skb
apropriately).

>
> On a side note:
> I wonder if probability-induced drop needs a separate reason... i.e.
> it could have been consumed by emit_smaple()/userspace() but wasn't.
>

You mean in sample action "get_random_u32() > arg->probability"?
It only makes sense to drop it if the last action so currently uses
OVS_DROP_LAST_ACTION.

> Best regards, Ilya Maximets.
>

Thanks for the great discussion.
Adri=C3=A1n


