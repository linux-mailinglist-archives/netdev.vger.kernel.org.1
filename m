Return-Path: <netdev+bounces-87080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D27F8A1B49
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3501C21B60
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2378B49;
	Thu, 11 Apr 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Png7ANxl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCA6A033
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851148; cv=none; b=QjDOVKiqhC9ziksUiGQ6asseBuxHJ8JIXMwHnWa0WBi3A0m96vMFzXdt26B+qU4MP+65X8NSsx3j4JmA7tQlhZwoXUJ0+IxepCbH0n86ThLCNVd9QnVNam1iXWoI4vZmr8xaYmcHgX/4ViVsWKvmfyOjgAniAp0QP1gjee6vH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851148; c=relaxed/simple;
	bh=ii+23nAPi9jHARCy0phU/wUZ/Usov3rxugtgHWjiZ3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kMMUSR+apohqV21xLmTHoyMmWMg7VPifLoCu2InQKhXR+9JdtspPOGAgDF9Fpqa0urEw8y3FdA1iFEyZxyQ7PqC/Osj9VyXyJcqzB6XvNTuUtHMUcV5pDtWTv5Qqqk1ZkIjw5wsKc/CIJfODfKjagNYSug7sOXKWwm/nQCwzjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Png7ANxl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712851145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=53+MeA9gJHv3yhIAjAB7LG59XdWLW5gt1T8hD5NlCJQ=;
	b=Png7ANxl/FQjm3gHcCMxzcpqR/e0asPvgiPwO5clOfHHT///JAJRhc90Gy5pZEODxcPrqk
	/6MJcq705tRUlffG0IrrrpQT34hpsFjkhzlUAlULs8jwWjFdt7kkML5Msa1OXlyQnXnUAM
	soL/HApIZW4rFHN31yxja5bwcb/bbxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-XchZI8DRPo-VxmsTOfvkjQ-1; Thu, 11 Apr 2024 11:59:03 -0400
X-MC-Unique: XchZI8DRPo-VxmsTOfvkjQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-346b68157cdso290650f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 08:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851142; x=1713455942;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53+MeA9gJHv3yhIAjAB7LG59XdWLW5gt1T8hD5NlCJQ=;
        b=SvLWmLjyu2Hw23SC4cbZJOCjC13T6QfFpNkAddJMGvols8dqtWg9eoedMhgoYqlGMB
         Uk1IDRX3r5jXdkrCozv0oNzcibFUKeqc75WL69zKTeuk2EfhAK+XqahLdqcUmuakT7FR
         dcaTuh73TXo6rXSotbsvI8tTaYOQUOmSWsMcaCnsAKfCOUtaXY0qR/SvyN1UvpJYun5t
         G97sAK87kpGTC63cDFJpimcAMiFuirMCPdvrKljXvU7WdYNKndBdXHVn1d5X/3VYhHkH
         3tq0AHsrBiSr9tXiYqXJJLc7gNPvd3dPKA+b+TG86XsDnKjfxyuwK6dV0Od2vDDTrQEm
         jnyw==
X-Forwarded-Encrypted: i=1; AJvYcCXCh20I18YTtmPFiHr9CSRkHbjcVnKxj2ttktnB0oRm7Clnrpnw+0hvKWwY3r0IUFEQOXlJUw4wn3/pc1tUbWLbtctsPs2x
X-Gm-Message-State: AOJu0Yy+qM+NPfuxWclNbS+sag+thqysSgYo5d9Mon0dYouAqfB/B4Ca
	sf4M5qlPqBE+LXjzgqgb4RW2FB1yTjAosjsHYwU27Qdr6qod1Iv+ANhU3MDUxb/Bv7kYmeDM6Tw
	6beukfJM6xFo+qFWcY9z6xPAhA3m01YbSOEFE+WWaB+NzuQEoxgvj6glUWNnNFA==
X-Received: by 2002:a05:600c:310d:b0:416:5339:d114 with SMTP id g13-20020a05600c310d00b004165339d114mr153006wmo.1.1712851142267;
        Thu, 11 Apr 2024 08:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzV2h2iXNQIVWi3HcQHjp9lRYxZJ33gf18BUICBODDTLH7OAeQVjiHgK18M/3PkAw9YL70QQ==
X-Received: by 2002:a05:600c:310d:b0:416:5339:d114 with SMTP id g13-20020a05600c310d00b004165339d114mr152984wmo.1.1712851141500;
        Thu, 11 Apr 2024 08:59:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-217.dyn.eolo.it. [146.241.235.217])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c34c400b004155387c08esm2763782wmq.27.2024.04.11.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:59:01 -0700 (PDT)
Message-ID: <de5bc3a7180fdc42a58df56fd5527c4955fd0978.camel@redhat.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>
Date: Thu, 11 Apr 2024 17:58:59 +0200
In-Reply-To: <20240410075745.4637c537@kernel.org>
References: <20240405102313.GA310894@kernel.org>
	 <20240409153250.574369e4@kernel.org>
	 <91451f2da3dcd70de3138975ad7d21f0548e19c9.camel@redhat.com>
	 <20240410075745.4637c537@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-10 at 07:57 -0700, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 10:33:50 +0200 Paolo Abeni wrote:
> >=20
> > The reference to privileged functions is here to try to ensure proper
> > isolation when required.
> >=20
> > E.g. Let's suppose the admin in the the host wants to restricts/limits
> > the B/W for a given VF (the VF itself, not the representor! See below
> > WRT shaper_lookup_mode) to some rate, he/she likely wants intends
> > additionally preventing the guest from relaxing the setting configuring
> > the such rate on the guest device.
>=20
> 1) representor is just a control path manifestation of the VF
>    any offload on the representor is for the VF - this is how forwarding
>    works, this is how "switchdev qdisc offload" works
>=20
> 2) its a hierarchy, we can delegate one layer to the VF and the layer
>    under that to the eswitch manager. VF can set it limit to inf
>    but the eswitch layer should still enforce its limit
>    The driver implementation may constrain the number of layers,
>    delegation or form of the hierarchy, sure, but as I said, that's an
>    implementation limitation (which reminds me -- remember to add extack=
=20
>    to the "write" ops)
>=20
> > > > enum shaper_lookup_mode {
> > > >     SHAPER_LOOKUP_BY_PORT,
> > > >     SHAPER_LOOKUP_BY_NETDEV,
> > > >     SHAPER_LOOKUP_BY_VF,
> > > >     SHAPER_LOOKUP_BY_QUEUE,
> > > >     SHAPER_LOOKUP_BY_TREE_ID, =20
> > >=20
> > > Two questions.
> > >=20
> > > 1) are these looking up real nodes or some special kind of node which
> > > can't have settings assigned directly?=C2=A0
> > > IOW if I want to rate limit=20
> > > the port do I get + set the port object or create a node above it and
> > > link it up? =20
> >=20
> > There is no concept of such special kind of nodes. Probably the above
> > enum needs a better/clearer definition of each element.
> > How to reach a specific configuration for the port shaper depends on
> > the NIC defaults - whatever hierarchy it provides/creates at
> > initialization time.=C2=A0
> >=20
> > The NIC/firmware can either provide a default shaper for the port level
> > - in such case the user/admin just need to set it. Otherwise user/admin
> > will have to create the shaper and link it.
>=20
> What's a default limit for a port? Line rate?
> I understand that the scheduler can't be "disabled" but that doesn't mean
> we must expose "noop" schedulers as if user has created them.
>=20
> Let me step back. The goal, AFAIU, was to create an internal API into
> which we can render existing APIs. We can combine settings from mqprio
> and sysfs etc. and create a desired abstract hierarchy to present to=20
> the driver. That's doable.
> Transforming arbitrary pre-existing driver hierarchy to achieve what
> the uAPI wants.. would be an NP hard problem, no?
>=20
> > I guess the first option should be more common/the expected one.
> >=20
> > This proposal allows both cases.
> >=20
> > > Or do those special nodes not exit implicitly (from the example it
> > > seems like they do?) =20
>=20
> s/exit/exist/
> =20
> > Could you please re-phrase the above?
>=20
> Basically whether dump of the hierarchy is empty at the start.
>=20
> > > 2) the objects themselves seem rather different. I'm guessing we need
> > > port/netdev/vf because either some users don't want to use switchdev
> > > (vf =3D repr netdev) or drivers don't implement it "correctly" (port =
!=3D
> > > netdev?!)? =20
> >=20
> > Yes, the nodes inside the hierarchy can be linked to very different
> > objects. The different lookup mode are there just to provide easy
> > access to relevant objects.
> >=20
> > Likely a much better description is needed:  'port' here is really the
> > cable plug level, 'netdev' refers to the Linux network device. There
> > could be multiple netdev for the same port as 'netdev' could be either
> > referring to a PF or a VFs. Finally VF is really the virtual function
> > device, not the representor, so that the host can configure/limits the
> > guest tx rate.=20
> >=20
> > The same shaper can be reached/looked-up with different ids.
> >=20
> > e.g. the device level shaper for a virtual function can be reached
> > with:
> >=20
> > - SHAPER_LOOKUP_BY_TREE_ID + unique tree id (every node is reachable
> > this way) from any host device in the same hierarcy
> > - SHAPER_LOOKUP_BY_VF + virtual function id, from the host PF device
> > - SHAPER_LOOKUP_BY_NETDEV, from the guest VF device
> >=20
> > > Also feels like some of these are root nodes, some are leaf nodes? =
=20
> >=20
> > There is a single root node (the port's parent), possibly many internal
> > nodes (port, netdev, vf, possibly more intermediate levels depending on
> > the actual configuration [e.g. the firmware or the admin could create
> > 'device groups' or 'queue groups']) and likely many leave nodes (queue
> > level).
> >=20
> > My personal take is than from an API point of view differentiating
> > between leaves and internal nodes makes the API more complex with no
> > practical advantage for the API users.
>=20
> If you allow them to be configured.
>=20
> What if we consider netdev/queue node as "exit points" of the tree,=20
> to which a layer of actual scheduling nodes can be attached, rather=20
> than doing scheduling by themselves?
>=20
> > > > 	int (*get)(struct net_device *dev,
> > > > 		   enum shaper_lookup_mode lookup_mode, u32 id,
> > > >                    struct shaper_info *shaper, struct netlink_ext_a=
ck *extack); =20
> > >=20
> > > How about we store the hierarchy in the core?
> > > Assume core has the source of truth, no need to get? =20
> >=20
> > One design choice was _not_ duplicating the hierarchy in the core: the
> > full hierarchy is maintained only by the NIC/firmware.=C2=A0The NIC/fir=
mware
> > can perform some changes "automatically" e.g. when adding or deleting
> > VFs or queues it will likely create/delete the paired shaper. The
> > synchronization looks cumbersome and error prone.
>=20
> The core only needs to maintain the hierarchy of whats in its domain of
> control.
>=20
> > The hierarchy could be exposed to both host and guests, I guess only
> > the host core could be the source of truth, right?
>=20
> I guess you're saying that the VF configuration may be implemented by ask=
ing=20
> the PF driver to perform the actions? Perhaps we can let the driver alloc=
ate
> and maintain its own hierarchy but yes, we don't have much gain from hold=
ing
> that in the core.
>=20
> This is the picture in my mind:
>=20
> PF / eswitch domain
>=20
>               Q0 ]-> [50G] | RR | >-[ PF netdev =3D pf repr ] - |
>               Q1 ]-> [50G] |    |                             |
>                                                               |
> -----------------------------------------                     |
> VF1 domain                               |                    |
>                                          |                    |
>      Q0 ]-> | RR | - [35G] >-[ VF netdev x vf repr ]-> [50G]- | RR | >- p=
ort
>      Q1 ]-> |    |                       |                    |
>                                          |                    |
> -----------------------------------------                     |
>                                                               |
> -------------------------------------------                   |
> VF2 domain                                 |                  |
>                                            |                  |
>      Q0 ]-> [100G] -> |0 SP | >-[ VF net.. x vf r ]-> [50G] - |
>      Q1 ]-> [200G] -> |1    |              |                  |
> -------------------------------------------
>=20
> In this contrived example we have VF1 which limited itself to 35G.
> VF2 limited each queue to 100G and 200G (ignored, eswitch limit is lower)
> and set strict priority between queues.
> PF limits each of its queues, and VFs to 50G, no rate limit on the port.
>=20
> "x" means we cross domains, "=3D" purely splices one hierarchy with anoth=
er.
>=20
> The hierarchy for netdevs always starts with a queue and ends in a netdev=
.
> The hierarchy for eswitch has just netdevs at each end (hierarchy is
> shared by all netdevs with the same switchdev id).
>=20
> If the eswitch implementation is not capable of having a proper repr for =
PFs
> the PF queues feed directly into the port.
>=20
> The final RR node may be implicit (if hierarchy has loose ends, the are
> assumed to RR at the last possible point before egress).

Let me try to wrap-up all the changes suggested above:

- we need to clearly define the initial/default status (possibly no b/w
limits and all the objects on the same level doing RR)

- The hierarchy controlled by the API should shown only non
default/user-configured nodes

- We need to drop the references to privileged VFs.

- The core should maintain the full status of the user-provided
configuration changes (say, the 'delta' hierarchy )

Am I missing something?

Also it's not 110% clear to me the implication of:

> consider netdev/queue node as "exit points" of the tree,=20
> to which a layer of actual scheduling nodes can be attached

could you please rephrase a bit?

I have the feeling the the points above should not require significant
changes to the API defined here, mainly more clear documentation, but
I'll have a better look.

Thanks!

Paolo=20


