Return-Path: <netdev+bounces-103937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B490A67F
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACA31F21932
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766A187358;
	Mon, 17 Jun 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8AIWVDs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB949187322
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608114; cv=none; b=BUAdW1tBA/JvQSX1X+T5ViIfFGN/bEo0dFadxo/+ym2090T7nKNuMIJdeBpxIotnxNbiXA7r7adiwCL88ph8vD1cxmeSyFIFn3sJkgD4uOhnKBTqMAMNyY/dgmxgIUupSgqE42F4hyIsG7CJBU8P17q0EfcDGFlmemWCyDVqKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608114; c=relaxed/simple;
	bh=USrfOZY7YjcJr3YXnlPp2uzKRs8/h1OqgvruayPDXP4=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MekSWwUaA9pqeK7ozE9EzLGSB5q9WGlbQYz0jBUG1Fh2thDXglEa3xzz9SS9J1AxvxpHo66V7K3p+CgSz43MR7s+OFoVgpIeaEr5AxM2JspcfJ/btePdIx45TK3uj63crRXCODfAFpQcF/TIDElT5dr5qsEOl1Q4FjQwEnO98OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8AIWVDs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718608111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFnZWNFJWyA94C2L1f2HcpW9Z4CdvGnFQUz/35+GLvM=;
	b=B8AIWVDs/y0X5erhVaGibouqRHHA7l5JGICcTPr4PH6IRRO5Q6t3dCNa6oNi2M1hF+iKvU
	K0D9M1bx7NM0yH9NDKCotAfiE6sba3MbE03aV1wY0bGN+0HBw22xsFkYjxLf2JRKp4h85M
	AEk8fo393V8V8lnfeibuJiP+5g9OLA8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-8bWIi0BWMFql7xtkJXnWwg-1; Mon, 17 Jun 2024 03:08:26 -0400
X-MC-Unique: 8bWIi0BWMFql7xtkJXnWwg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b077178ca4so54136046d6.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 00:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608106; x=1719212906;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFnZWNFJWyA94C2L1f2HcpW9Z4CdvGnFQUz/35+GLvM=;
        b=rVFFcy0CWHw2AP/M18gq81uzZDIXNi0qnL6zKR02wQIzd25GywhNO+k/y/7OW3VJ0R
         c+Wx0F4VJyMs31BvL5vMp4Fzu/pohbz0/HzBsaTOc7AG0Y5R7OjMOG1jeilyPMGgqM0Z
         3s7NW/6DPmqW224VoC7Vm8qEm6hhPxg+sBpR2DFRyd++UnGIAXn2IQ2VMygqxAlyMf9z
         rqv4Ztgz+k8eJj4ieKsFGdHx6afiw5XzNZbZqWPSdnExMxaoIVbsGUmyPp9C/prprfu4
         k2V+mkf/3YBCW1n+jHswGgyw9ea5rb1PC+IPLvMk7wLdr1pEqlnh/t74sd87pJgnWlXi
         7vHQ==
X-Gm-Message-State: AOJu0YxRJVIyc6fYAbxrPnl/fx2tUbp4Jer2j6x07OStyiwpwzbfzP/R
	yyo5+UgrENK8ejvb7SWmYsTM1znf3VSammulL1xKRdPI1wch/yYM8HNT3swPfPZFkEU0IyhRM+N
	/kXAt8/44OVUr9hsZFS8elPGgpUa14OXZQb3XrPse8O8yuEp0namTvTJj7NTsea/cdNJzR9xrFJ
	HG40PO66Fyk2JxLFfAwVtDKgQ1jq0G
X-Received: by 2002:a0c:e78d:0:b0:6b0:6400:3b6f with SMTP id 6a1803df08f44-6b2afc78e7emr89614616d6.8.1718608105379;
        Mon, 17 Jun 2024 00:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHngmpoF0G1Kpc6044Rkne2yjimTQKfws9kfGdgowCpRPFvfoKKY3G5g8yuJotyXboNdv+HW7uPscrnjkgdiZM=
X-Received: by 2002:a0c:e78d:0:b0:6b0:6400:3b6f with SMTP id
 6a1803df08f44-6b2afc78e7emr89614506d6.8.1718608105010; Mon, 17 Jun 2024
 00:08:25 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Jun 2024 07:08:24 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-7-amorenoz@redhat.com>
 <f7t4j9vo44g.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7t4j9vo44g.fsf@redhat.com>
Date: Mon, 17 Jun 2024 07:08:24 +0000
Message-ID: <CAG=2xmPW=1HzojWhHaE3z_x5u_Dv1zPVmMn4cSmV6DF4fzq5KA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/9] net: openvswitch: store sampling
 probability in cb.
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 14, 2024 at 12:55:59PM GMT, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > The behavior of actions might not be the exact same if they are being
> > executed inside a nested sample action. Store the probability of the
> > parent sample action in the skb's cb area.
>
> What does that mean?
>

Emit action, for instance, needs the probability so that psample
consumers know what was the sampling rate applied. Also, the way we
should inform about packet drops (via kfree_skb_reason) changes (see
patch 7/9).

> > Use the probability in emit_sample to pass it down to psample.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  include/uapi/linux/openvswitch.h |  3 ++-
> >  net/openvswitch/actions.c        | 25 ++++++++++++++++++++++---
> >  net/openvswitch/datapath.h       |  3 +++
> >  net/openvswitch/vport.c          |  1 +
> >  4 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> > index a0e9dde0584a..9d675725fa2b 100644
> > --- a/include/uapi/linux/openvswitch.h
> > +++ b/include/uapi/linux/openvswitch.h
> > @@ -649,7 +649,8 @@ enum ovs_flow_attr {
> >   * Actions are passed as nested attributes.
> >   *
> >   * Executes the specified actions with the given probability on a per-packet
> > - * basis.
> > + * basis. Nested actions will be able to access the probability value of the
> > + * parent @OVS_ACTION_ATTR_SAMPLE.
> >   */
> >  enum ovs_sample_attr {
> >  	OVS_SAMPLE_ATTR_UNSPEC,
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index 3b4dba0ded59..33f6d93ba5e4 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -1048,12 +1048,15 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
> >  	struct nlattr *sample_arg;
> >  	int rem = nla_len(attr);
> >  	const struct sample_arg *arg;
> > +	u32 init_probability;
> >  	bool clone_flow_key;
> > +	int err;
> >
> >  	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
> >  	sample_arg = nla_data(attr);
> >  	arg = nla_data(sample_arg);
> >  	actions = nla_next(sample_arg, &rem);
> > +	init_probability = OVS_CB(skb)->probability;
> >
> >  	if ((arg->probability != U32_MAX) &&
> >  	    (!arg->probability || get_random_u32() > arg->probability)) {
> > @@ -1062,9 +1065,21 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
> >  		return 0;
> >  	}
> >
> > +	if (init_probability) {
> > +		OVS_CB(skb)->probability = ((u64)OVS_CB(skb)->probability *
> > +					    arg->probability / U32_MAX);
> > +	} else {
> > +		OVS_CB(skb)->probability = arg->probability;
> > +	}
> > +
>
> I'm confused by this.  Eventually, integer arithmetic will practically
> guarantee that nested sample() calls will go to 0.  So eventually, the
> test above will be impossible to meet mathematically.
>
> OTOH, you could argue that a 1% of 50% is low anyway, but it still would
> have a positive probability count, and still be possible for
> get_random_u32() call to match.
>

Using OVS's probability semantics, we can express probabilities as low
as (100/U32_MAX)% which is pretty low indeed. However, just because the
probability of executing the action is low I don't think we should not
report it.

Rethinking the integer arithmetics, it's true that we should avoid
hitting zero on the division, eg: nesting 6x 1% sampling rates will make
the result be zero which will make probability restoration fail on the
way back. Threrefore, the new probability should be at least 1.


> I'm not sure about this particular change.  Why do we need it?
>

Why do we need to propagate the probability down to nested "sample"
actions? or why do we need to store the probability in the cb area in
the first place?

The former: Just for correctness as only storing the last one would be
incorrect. Although I don't know of any use for nested "sample" actions.
The latter: To pass it down to psample so that sample receivers know how
the sampling rate applied (and, e.g: do throughput estimations like OVS
does with IPFIX).


> >  	clone_flow_key = !arg->exec;
> > -	return clone_execute(dp, skb, key, 0, actions, rem, last,
> > -			     clone_flow_key);
> > +	err = clone_execute(dp, skb, key, 0, actions, rem, last,
> > +			    clone_flow_key);
> > +
> > +	if (!last)
>
> Is this right?  Don't we only want to set the probability on the last
> action?  Should the test be 'if (last)'?
>

This is restoring the parent's probability after the actions in the
current sample action have been executed.

If it was the last action there is no need to restore the probability
back to the parent's (or zero if it's there's only one level) since no
further action will require it. And more importantly, if it's the last
action, the packet gets free'ed inside that "branch" so we must not
access its memory.


> > +		OVS_CB(skb)->probability = init_probability;
> > +
> > +	return err;
> >  }
> >
> >  /* When 'last' is true, clone() should always consume the 'skb'.
> > @@ -1313,6 +1328,7 @@ static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
> >  	struct psample_metadata md = {};
> >  	struct vport *input_vport;
> >  	const struct nlattr *a;
> > +	u32 rate;
> >  	int rem;
> >
> >  	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
> > @@ -1337,8 +1353,11 @@ static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
> >
> >  	md.in_ifindex = input_vport->dev->ifindex;
> >  	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> > +	md.rate_as_probability = 1;
> > +
> > +	rate = OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_MAX;
> >
> > -	psample_sample_packet(&psample_group, skb, 0, &md);
> > +	psample_sample_packet(&psample_group, skb, rate, &md);
> >  #endif
> >
> >  	return 0;
> > diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> > index 0cd29971a907..9ca6231ea647 100644
> > --- a/net/openvswitch/datapath.h
> > +++ b/net/openvswitch/datapath.h
> > @@ -115,12 +115,15 @@ struct datapath {
> >   * fragmented.
> >   * @acts_origlen: The netlink size of the flow actions applied to this skb.
> >   * @cutlen: The number of bytes from the packet end to be removed.
> > + * @probability: The sampling probability that was applied to this skb; 0 means
> > + * no sampling has occurred; U32_MAX means 100% probability.
> >   */
> >  struct ovs_skb_cb {
> >  	struct vport		*input_vport;
> >  	u16			mru;
> >  	u16			acts_origlen;
> >  	u32			cutlen;
> > +	u32			probability;
> >  };
> >  #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
> >
> > diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> > index 972ae01a70f7..8732f6e51ae5 100644
> > --- a/net/openvswitch/vport.c
> > +++ b/net/openvswitch/vport.c
> > @@ -500,6 +500,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
> >  	OVS_CB(skb)->input_vport = vport;
> >  	OVS_CB(skb)->mru = 0;
> >  	OVS_CB(skb)->cutlen = 0;
> > +	OVS_CB(skb)->probability = 0;
> >  	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
> >  		u32 mark;
>


