Return-Path: <netdev+bounces-104362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93990C4A0
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 09:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E6FB20A52
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9295413EFEC;
	Tue, 18 Jun 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCGoUCsu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23C13E40D
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694050; cv=none; b=Zh2/P/HriU9zqgfw/5I9g3NzwajjWz4vLwsaqAJXxxqlA9pOinZnWdj8Q+Eg8Pg8S6bskwVbnKpmVMeTsf7iLSFGw1SO4DqKo38ER9zbD8U1jNwrA2jrZNE/cLGHyGsbn/dyN14FCejGzz+b9EQU4n83nblIWSjpgyQ/dNJqkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694050; c=relaxed/simple;
	bh=koGFnlpbCpuU4KL+q3WrDcJYuF4AEaeHFdLsf7yGA+M=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7p/3Smg/raYuAljZY/SgPVz3lVkTBkvPqWqTGhOJmvHgvwjvkuMSzNHUBo/AkvLeygm2Io+bmNF8HYMu/DFUEk1EKyIKEXdu9swX3X6VZM+SGlyW/Xohz1ManpUDMxIAE+W1MdU7IC2SscKpqXyG02vM5cpAyHS8VYsl5gYrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCGoUCsu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718694047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CAAk9T1H9U1M1crw69ogPtlpQmhld5Cb/qTawqiil0=;
	b=RCGoUCsuYerl6YrMZlswrhS/46njitj14l5WHpaH2xXl2fMbx0RfcjqIjdrVWzbw1m1Irg
	6QOl+CMNVmA28JC0httKu2Z4ZjOHJqGDmUZZlgD+WIle1drJWs8GTdJmZhWmrZTYI6bPs8
	aYfHByA/jm0iwCF3xcoXZkki2mlJhVw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-krwvd1x8ON27S8cNDcxl0g-1; Tue, 18 Jun 2024 03:00:41 -0400
X-MC-Unique: krwvd1x8ON27S8cNDcxl0g-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6f9ae3ddf07so5583984a34.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 00:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718694041; x=1719298841;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CAAk9T1H9U1M1crw69ogPtlpQmhld5Cb/qTawqiil0=;
        b=OMa+9DuWakFKs0x4sWDpypS28+kmGJAacoS4882HazSY+fv0Wpxg3MMsC1NBYfJr75
         E7bH3DabzDt+Zak6SISEZnNqNZuJJY1dv40VoYQn6xkns+tpnOTK3ifja9J4XxetZINp
         Zwx3VikEfpMyiSOwQUZfuSVcI6neo3fEozlSjkj+QGZMD27KhVF0QUFlatWzx1j01TTv
         YuZh45+UTNg6UZk8jGry98nfawSx6oBNUhV9ZZS7YWByu37/WZwqiDSOo5YkzKRRdF3O
         CSbGQ8SpyVo6/b9NBtVXrNWTZa1k9vxM13epyrrfbOIgjbPb8LmBaSn6ZRV7PUV64S54
         vVxg==
X-Gm-Message-State: AOJu0YwAGFoX1wLikwW2IRqvUCZ5NRCS46E77FrbdL7kc7gl9kE9eJZ6
	cDazdOjgLDUh8yePZHR+IKbRIwtC0pPMiMUAz4Kh37PINJW1z2a8otZiBxwhKzELqW0F8TKGY0B
	m8EkdatMT7IzNoOQCqnmCBFRg6qgCU5qIjwwFd63PX7JtjGRrp0wXM5tSwBc1YLnJ7vvWQ7of4v
	m8M44I+ouQoYDUMMPpPKic9F1xqpUQ
X-Received: by 2002:a9d:7c81:0:b0:6f9:a404:b40e with SMTP id 46e09a7af769-6fb933aac7dmr13141154a34.9.1718694040900;
        Tue, 18 Jun 2024 00:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpd22CWvyOlPyQA5J6TFX26D7S9UfTetiExuAiWEE1oStk4KjDbGnca03d+faN1nvKGXfNZJ0n0twHytQDb1o=
X-Received: by 2002:a9d:7c81:0:b0:6f9:a404:b40e with SMTP id
 46e09a7af769-6fb933aac7dmr13141126a34.9.1718694040442; Tue, 18 Jun 2024
 00:00:40 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 07:00:39 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-8-amorenoz@redhat.com>
 <8624ccf8-e9e2-4a95-a25c-7d3166bb3256@ovn.org> <f8050877-1728-4723-acb8-8a8ab7674470@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f8050877-1728-4723-acb8-8a8ab7674470@ovn.org>
Date: Tue, 18 Jun 2024 07:00:39 +0000
Message-ID: <CAG=2xmPAwvCR4ky0cu7Yai29v3H592-ATXtNkhsNJ-vTwR4BVw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/9] net: openvswitch: do not notify drops
 inside sample
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 17, 2024 at 02:10:37PM GMT, Ilya Maximets wrote:
> On 6/17/24 13:55, Ilya Maximets wrote:
> > On 6/3/24 20:56, Adrian Moreno wrote:
> >> The OVS_ACTION_ATTR_SAMPLE action is, in essence,
> >> observability-oriented.
> >>
> >> Apart from some corner case in which it's used a replacement of clone()
> >> for old kernels, it's really only used for sFlow, IPFIX and now,
> >> local emit_sample.
> >>
> >> With this in mind, it doesn't make much sense to report
> >> OVS_DROP_LAST_ACTION inside sample actions.
> >>
> >> For instance, if the flow:
> >>
> >>   actions:sample(..,emit_sample(..)),2
> >>
> >> triggers a OVS_DROP_LAST_ACTION skb drop event, it would be extremely
> >> confusing for users since the packet did reach its destination.
> >>
> >> This patch makes internal action execution silently consume the skb
> >> instead of notifying a drop for this case.
> >>
> >> Unfortunately, this patch does not remove all potential sources of
> >> confusion since, if the sample action itself is the last action, e.g:
> >>
> >>     actions:sample(..,emit_sample(..))
> >>
> >> we actually _should_ generate a OVS_DROP_LAST_ACTION event, but we aren't.
> >>
> >> Sadly, this case is difficult to solve without breaking the
> >> optimization by which the skb is not cloned on last sample actions.
> >> But, given explicit drop actions are now supported, OVS can just add one
> >> after the last sample() and rewrite the flow as:
> >>
> >>     actions:sample(..,emit_sample(..)),drop
> >>
> >> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >> ---
> >>  net/openvswitch/actions.c | 13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> >> index 33f6d93ba5e4..54fc1abcff95 100644
> >> --- a/net/openvswitch/actions.c
> >> +++ b/net/openvswitch/actions.c
> >> @@ -82,6 +82,15 @@ static struct action_fifo __percpu *action_fifos;
> >>  static struct action_flow_keys __percpu *flow_keys;
> >>  static DEFINE_PER_CPU(int, exec_actions_level);
> >>
> >> +static inline void ovs_drop_skb_last_action(struct sk_buff *skb)
> >> +{
> >> +	/* Do not emit packet drops inside sample(). */
> >> +	if (OVS_CB(skb)->probability)
> >> +		consume_skb(skb);
> >> +	else
> >> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >> +}
> >> +
> >>  /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
> >>   * space. Return NULL if out of key spaces.
> >>   */
> >> @@ -1061,7 +1070,7 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
> >>  	if ((arg->probability != U32_MAX) &&
> >>  	    (!arg->probability || get_random_u32() > arg->probability)) {
> >>  		if (last)
> >> -			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >> +			ovs_drop_skb_last_action(skb);
>
> Always consuming the skb at this point makes sense, since having smaple()
> as a last action is a reasonable thing to have.  But this looks more like
> a fix for the original drop reason patch set.
>

I don't think consuming the skb at this point makes sense. It was very
intentionally changed to a drop since a very common use-case for
sampling is drop-sampling, i.e: replacing an empty action list (that
triggers OVS_DROP_LAST_ACTION) with a sample(emit_sample()). Ideally,
that replacement should not have any effect on the number of
OVS_DROP_LAST_ACTION being reported as the packets are being treated in
the same way (only observed in one case).


> >>  		return 0;
> >>  	}
> >>
> >> @@ -1579,7 +1588,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >>  		}
> >>  	}
> >>
> >> -	ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >> +	ovs_drop_skb_last_action(skb);
> >
> > I don't think I agree with this one.  If we have a sample() action with
> > a lot of different actions inside and we reached the end while the last
> > action didn't consume the skb, then we should report that.  E.g.
> > "sample(emit_sample(),push_vlan(),set(eth())),2"  should report that the
> > cloned skb was dropped.  "sample(push_vlan(),emit_sample())" should not.
> >

What is the use case for such action list? Having an action branch
executed randomly doesn't make sense to me if it's not some
observability thing (which IMHO should not trigger drops).

> > The only actions that are actually consuming the skb are "output",
> > "userspace", "recirc" and now "emit_sample".  "output" and "recirc" are
> > consuming the skb "naturally" by stealing it when it is the last action.
> > "userspace" has an explicit check to consume the skb if it is the last
> > action.  "emit_sample" should have the similar check.  It should likely
> > be added at the point of action introduction instead of having a separate
> > patch.
> >

Unlinke "output", "recirc", "userspace", etc. with emit_sample the
packet does not continue it's way through the datapath.

It would be very confusing if OVS starts monitoring drops and adds a bunch
of flows such as "actions:emit_sample()" and suddently it stops reporting such
drops via standard kfree_skb_reason. Packets _are_ being dropped here,
we are just observing them.

And if we change emit_sample to trigger a drop if it's the last action,
then "sample(50%, emit_sample()),2" will trigger a drop half of the times
which is also terribly confusing.

I think we should try to be clear and informative with what we
_actually_ drop and not require the user that is just running
"dropwatch" to understand the internals of the OVS module.

So if you don't want to accept the "observational" nature of sample(),
the only other solution that does not bring even more confusion to OVS
drops would be to have userspace add explicit drop actions. WDYT?


