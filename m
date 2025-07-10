Return-Path: <netdev+bounces-205724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AEBAFFDE2
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB332643125
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF7292B5B;
	Thu, 10 Jul 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBZNZ16Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF2292B33
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139128; cv=none; b=pi6Gp32KDuGpXQaw5Tzta2IL4eDm7XbtVIBtzwMYly9Ya5rceweCKd9Sgpw/T7L2TkKQ9yWVAJLLNumIpefOakcO8HBsG0uV6HNyuyUojxpCH9po3m7G3OWL46IbwkolCE0vecTOnARGzkKcsQ3rBs7pCULZ8AihqeS+9gYDvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139128; c=relaxed/simple;
	bh=mmDM/kfe3ofrDf3m1A/JMuLw4nLRvfvqcO1ZsVgU9pc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMLwv0UkrkhCfxpsFi9iexhWFftUbRz8cCK03e+nE7YECs3mIqvuKDXKVgVQ70CfeDdJx95iqyI5cL2z0sAtGlIvnAPphzu0/DCAAkK0iq32V8jY9+LHnEyhmVl6LxUNsU1EPUh8PYQ+f47EhsfFYFGfe0f0ji9y6toGby9v0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBZNZ16Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752139125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vErM9YMAjyVbU9XoRBE0HFeaNzZ3EDkr7IefHYPQq3Y=;
	b=MBZNZ16ZeHPBP5QawF3S8JwsqkyK6KVutoPx03z24ZowYRDNdF/wXjyzV07lWKuTY9HpII
	dfRzQGppQQouo5V7zaXOoD4T8ettPmxsJ+UJCanCZQdRtNHtG1xpSaF/+e+R03GbIBpitP
	Zf3mE6fI455/9L274arnnGC35nfY0oo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-Q5x_QooDPeu4WXhlCsWTBg-1; Thu, 10 Jul 2025 05:18:44 -0400
X-MC-Unique: Q5x_QooDPeu4WXhlCsWTBg-1
X-Mimecast-MFC-AGG-ID: Q5x_QooDPeu4WXhlCsWTBg_1752139123
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae0cd07eeb2so57704266b.3
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139123; x=1752743923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vErM9YMAjyVbU9XoRBE0HFeaNzZ3EDkr7IefHYPQq3Y=;
        b=xLeGunljjoyX+v/UAROviBGAHPyT3+c0ok8kvlrLS2JiaB4QxKlqroDNrN9ZP7d4t3
         YLnyy0xmJat6yKvl+iMXNW4Lw9c+4nZdzdbIzCrd5SD3Qj4Wi38cuquLWGIME47dAzIS
         fdNngzPCNfSpHPAIHPE3zbCVxWyhbZZVQSmMCNbxJHZjduMOiavY0fpLNuyTJnyTKl86
         TSkHLqLhNDT/j0aYXkfd/HMPeULnv10KUcfVLaMbOnIJlQQE5SKvPTpysA/T9OSF9uSQ
         +F9p4l5lYr3kIG584PMUkE5fPUoYCLpk3TXVkdp+0g4rL56N6fsQOY8fryOxsS0fM+Nz
         SonA==
X-Forwarded-Encrypted: i=1; AJvYcCV2KQjj350BxNsxZtDSkwv+KKZ2PpTAaceVOxpgm96RHkg3jUdcdEPwhV+h112euLC63puO3ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3NW+cQ2fthMtnxNFzBj6P2sJ5C9zo8uIqroG+1xo4HlYhUX5
	QvXyZVLk3o2ojycHghs1jNvT/HGH7QJVAEnUipuEpl8l0o18wfgW+ajKUQZXHcK9dUi34KONFgF
	0IPsCr6OAssUz6+D2u5aJpiNnYtQ/jSzH0JN+EE/Hqqy9ztTZIImFPxq5oRyU8rpc25cTzQfrNb
	jDG90gzMKK5R3xZs1tz+NlsyAWMwpNTolT
X-Gm-Gg: ASbGncvATL68ZKBRyZrnVf/+999Sc1VWM9uWOmZd/442+fG119C/DZ9sOiMotRBRkzV
	ylY629jHlY0hhwz3Xdwi+KcuYI3EdLGEJF5YuDT/Hb4Wech78WlOlhGeVcW3bNM1ibknOOJY8m3
	sRbZ8ZWA==
X-Received: by 2002:a17:907:d2d9:b0:ae3:d100:a756 with SMTP id a640c23a62f3a-ae6e70f440amr194196266b.56.1752139123086;
        Thu, 10 Jul 2025 02:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/p29PIqL4/upV61DSF3GHhstA1tko0GVCfHl6wcCMDV9Ox64IH6XwFYVNKx8dFoP01kJK64oYzbdnI9xi8gc=
X-Received: by 2002:a17:907:d2d9:b0:ae3:d100:a756 with SMTP id
 a640c23a62f3a-ae6e70f440amr194192666b.56.1752139122574; Thu, 10 Jul 2025
 02:18:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Jul 2025 04:18:40 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Jul 2025 04:18:40 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20250627210054.114417-1-aconole@redhat.com> <aGAWMLjQhKPvKx2R@pop-os.localdomain>
 <f7ta55ppfv3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7ta55ppfv3.fsf@redhat.com>
Date: Thu, 10 Jul 2025 04:18:40 -0500
X-Gm-Features: Ac12FXwY-b8UE2WimjVt5zN9LUk2GAV5DvBVB3CVzXDrNrtt-oFhDPlHbvfbWh8
Message-ID: <CAG=2xmMzJEReLU13zCGR0cvXgkx3NnxuzhXL_s+2iLGA=pxyqQ@mail.gmail.com>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map concept.
To: Aaron Conole <aconole@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, dev@openvswitch.org, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Mike Pattrick <mpattric@redhat.com>, Florian Westphal <fw@strlen.de>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Joe Stringer <joe@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 08:34:56AM -0400, Aaron Conole wrote:
> Cong Wang <xiyou.wangcong@gmail.com> writes:
>
> > On Fri, Jun 27, 2025 at 05:00:54PM -0400, Aaron Conole wrote:
> >> The Open vSwitch module allows a user to implemnt a flow-based
> >> layer 2 virtual switch.  This is quite useful to model packet
> >> movement analagous to programmable physical layer 2 switches.
> >> But the openvswitch module doesn't always strictly operate at
> >> layer 2, since it implements higher layer concerns, like
> >> fragmentation reassembly, connection tracking, TTL
> >> manipulations, etc.  Rightly so, it isn't *strictly* a layer
> >> 2 virtual forwarding function.
> >>
> >> Other virtual forwarding technologies allow for additional
> >> concepts that 'break' this strict layer separation beyond
> >> what the openvswitch module provides.  The most handy one for
> >> openvswitch to start looking at is the concept of the socket
> >> map, from eBPF.  This is very useful for TCP connections,
> >> since in many cases we will do container<->container
> >> communication (although this can be generalized for the
> >> phy->container case).
> >>
> >> This patch provides two different implementations of actions
> >> that can be used to construct the same kind of socket map
> >> capability within the openvswitch module.  There are additional
> >> ways of supporting this concept that I've discussed offline,
> >> but want to bring it all up for discussion on the mailing list.
> >> This way, "spirited debate" can occur before I spend too much
> >> time implementing specific userspace support for an approach
> >> that may not be acceptable.  I did 'port' these from
> >> implementations that I had done some preliminary testing with
> >> but no guarantees that what is included actually works well.
> >>
> >> For all of these, they are implemented using raw access to
> >> the tcp socket.  This isn't ideal, and a proper
> >> implementation would reuse the psock infrastructure - but
> >> I wanted to get something that we can all at least poke (fun)
> >> at rather than just being purely theoretical.  Some of the
> >> validation that we may need (for example re-writing the
> >> packet's headers) have been omitted to hopefully make the
> >> implementations a bit easier to parse.  The idea would be
> >> to validate these in the validate_and_copy routines.
> >
> > Maybe it is time to introduce eBPF to openvswitch so that they can
> > share, for example, socket maps, from other layers?
>
> Hi Cong,
>
> Yes, it's a good thought.  I don't really know the best way to introduce
> it.  What I mean is, I'd rather completely switch to using something
> like a set of XDP hooks all the way through, but currently OVS datapath
> is still too complex to express in eBPF, from my understanding.
> Hopefully that can change in the future, and then we can seriously
> consider a larger effort like that.
>
> But let's say we try a partial approach - for example, we can add
> something like an rx side hook at ovs_vport_receive that builds an
> xdp_buff object and passes it along.  That can let us use this one
> specific use case, but it may not give the same kind of "XDP"
> performance boost that people are used to seeing (if that matters) -
> we're long past the time where an skb has been built and may need to
> coalesce or ignore some skb from the driver.  I guess it's still doable,
> and then the userspace can just attach the eBPF programs it wants.
> Probably, we would add the xdp program to the vport object instead of to
> the underlying device?  In that case sketching it in ovs_vport_receive()
> might look like:
>
>   {
>   	struct bpf_prog *xdp_prog;
>   	....
>
>   	xdp_prog =3D rcu_dereference(vport->xdp_prog);
>   	if (xdp_prog) {
>   		struct xdp_buff xdpb =3D { ... }; /* Set up buff */
>   		int result;
>
>   		result =3D bpf_prog_run(xdp_prog, &xdpb);
>   		switch (result) {
>   		... /* break for XDP_PASS, and 'exit' for others*/
>   		}
>   	}
>
>   	/* Extract flow from 'skb' into 'key'. */
> 	error =3D ovs_flow_key_extract(tun_info, skb, &key);
>
>   }
>
> Then I guess we can just do all the accounting, etc. in userspace.  But
> I'm not sure whether that's better than being able to implement the
> entire datapath in XDP from the start.  Although, it does solve the
> immediate idea - getting access to bpf sockmap.  Not sure what others
> think about that approach.  It's important to note that currently, OVS
> userspace would need quite a bit more work to deal with this since it
> isn't in the 'flow' that OVS is setup to deal with, so things like
> accounting need to be changed on that side anyway.  The kernel hook for
> it could be easier to add overall.

Is there a chance to add it as a part of the netdev-offload API? If so,
we could at least reuse the existing accounting infrastructure.

This new offload provider would keep track of sockets per vport by
reusing sockmap infra.
As a new flows are "put" (i.e: "offloaded"), it would have keep track
of the recirculation chain that leads to an output action on a vport
where a matching socket also exists. This tracking is costy but we need
to do it anyways right? How would userspace be able to produce
"socket(NS,INO,recirc(0x1))" if not?

When one of these socket mappings is detected, the XDP prog would be
instructed to redirect packets directly and stats would be added to all
flows in the chain.

I haven't thought out the details of this idea but wanted to share it
for the sake of discussion.
Also, maybe there are things that can be made easier by having a higher
level offload API (Eelco might have thoughts on this).

Thanks.
Adri=C3=A1n


