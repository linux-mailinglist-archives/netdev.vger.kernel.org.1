Return-Path: <netdev+bounces-128672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A929397AD96
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 11:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367D21F24DF7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487F114BFBF;
	Tue, 17 Sep 2024 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaneJ0Fz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AFF1BF24
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564217; cv=none; b=L/kGxaGaY7u0HooOSNyJipmYcfJZBZOZvkjBBJ9WAVMVB8d6KbtUk9H8Mhzkpy0Go/iaP00dbmuAl82TMaK57BwozW+/CC1Ul0FSGbe1Bya1CEgUsdYV8Z6sDvsoStlo5I4093T8w6N5HUmPzC9V1nYn7gkI02k7jE9g2ucw6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564217; c=relaxed/simple;
	bh=AQZBaJz82EAPQw+3X/objlRyd3pt5oMrGJ26FLJr4SA=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0eN4Jq0j19+xLKi0T+vDJ6sivle/BRYVHaAckkKSIaYC4V/3DK5k1HOmnxCW1kOaSxd0fMksHNKG3rYOk2qYMIi+NGgx7Xee3oN2opQqi/5UPEfM/ZeSw1CIOGR011n5kARzxOIh3sec/IdN2bsl5whGsS4A0MODxrIG0K9S5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KaneJ0Fz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726564214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRMYh/LV2+jKSL6exRA0dBf4cGn07QIVCfyuTHY1z7o=;
	b=KaneJ0FzS4ywAA2aNgBDSdJJxJDXBT/Q2VZ+egIUoKaP1lXcHYRDx9+RH4Men63mxz9LZp
	O78jN6kw9DNixwi/AMOBqf1oYq2HgFc1dYH7nHIpXq+gCLHgKdCuCq6CjZbjf8cDcRD65W
	9r4HS2pSlwXMM6iETtKQmza+Sw51KqM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-OL1HuKLbOtqXJBrKHvjMLQ-1; Tue, 17 Sep 2024 05:10:13 -0400
X-MC-Unique: OL1HuKLbOtqXJBrKHvjMLQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c3649bca89so98908556d6.1
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 02:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726564212; x=1727169012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WRMYh/LV2+jKSL6exRA0dBf4cGn07QIVCfyuTHY1z7o=;
        b=jbohswO5dKtAp4sR0OqFVcOLo7wrWRVRya+atjwnfROUs4xwhPdaUPse/pVuslpQTz
         dDgOG6q1DJkeObN8F37si+b5R5FVyMyzQLjuQJaRLL/5R3SFcruaSjOMCqXoKVv9pleM
         2RkH31mm0x3ZOk2KVnTAupw2GX7R/8THP9hMovl+aJlZU/bB261aqMJ+Gxy9YsDuqowR
         IE3ntTCf0r9HL0Ev9o1uSuCdTFWcUAKEw+zd6B4XExJSJHt8vno88z/BZdi04VRo+Gwk
         BDciQiWHXbfL+qH8HJvJQdx1HFYHf+zQDF/AKzu1bayndOZc43mCGL6asZKVTQAquDG1
         mhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxzQdHKYf2Mq33OKpPA2oabkYPplCiH7b1SG10P5U8smmRdFD5/pztEmg+l+FxYexufrw34Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvTbYUNtCKi9UXaUJBfq2/sp5U8oRvS4VxlhXSIi9M4EFg/bx
	mkUb+EAcvI7nNI91BSglUX/551PhjMMZmednBPh50kujPQoqazU+s3m/6LnE98ri4m+LhP+fkEO
	vC/JFkgB1XhkbUnRHW9DDtYSVkcHBv+hBh90ZlZzht/FPNOH6BEXIxTpJ7rkVJLYtF5SjQ/v4Oi
	Epik18j1gHpxj/JXs6Q3SzsqyEm24P
X-Received: by 2002:a05:6214:428b:b0:6c5:313d:7cca with SMTP id 6a1803df08f44-6c57df77628mr246794386d6.11.1726564212580;
        Tue, 17 Sep 2024 02:10:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEloN18rnVtTWl7vrBPurZ9PWyw+9yAsGvI0zLRuOD6G4nOqbUqBW9uWh1dev6mHEwi/4UxmLRZXGZ1TCzMTbc=
X-Received: by 2002:a05:6214:428b:b0:6c5:313d:7cca with SMTP id
 6a1803df08f44-6c57df77628mr246793936d6.11.1726564212018; Tue, 17 Sep 2024
 02:10:12 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Sep 2024 09:10:11 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <ZuAcpIqvJYmCTFFK@fedora> <385751.1726158973@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <385751.1726158973@famine>
Date: Tue, 17 Sep 2024 09:10:11 +0000
Message-ID: <CAG=2xmOVUrmBVF+ORfR0rO=nP0t7aDkPxcrzd0sp0FBT9fqBKw@mail.gmail.com>
Subject: Re: [Discuss] ARP monitor for OVS bridge over bonding
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Stanislas Faye <sfaye@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 09:36:13AM GMT, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> >Hi all,
> >
> >Recently, our customer got an issue with OVS bridge over bonding. e.g.
> >
> >  eth0      eth1
> >   |         |
> >   -- bond0 --
> >        |
> >      br-ex (ovs-vsctl add-port br-ex bond0; ip addr add 192.168.1.1/24 =
dev br-ex)
> >
> >
> >Before sending arp message for bond slave detecting, the bond need to ch=
eck
> >if the br-ex is in the same data path with bond0 via function
> >bond_verify_device_path(), which using netdev_for_each_upper_dev_rcu()
> >to check all upper devices. This works with normal bridge. But with ovs
> >bridge, the upper device is "ovs-system" instead of br-ex.
> >
> >After talking with OVS developers. It turned out the real upper OVS topo=
logy
> >is looks like
> >
> >              --------------------------------
> >              |                              |
> >  br-ex  -----+--      ovs-system            |
> >              |                              |
> >  br-int -----+--                            |
> >              |                              |
> >              |    bond0    eth2   veth42    |
> >              |      |       |       |       |
> >              |      |       |       |       |
> >              -------+-------+-------+--------
> >                     |       |       |
> >                  +--+--+  physical  |
> >                  |     |    link    |
> >                eth0  eth1          veth43
> >
> >The br-ex is not upper link of bond0. ovs-system, instead, is the master
> >of bond0. This make us unable to make sure the br-ex and bond0 is in the
> >same datapath.
>
> 	I'm guessing that this is in the context of an openstack
> deployment, as "br-ex" and "br-int" are names commonly chosen for the
> OVS bridges in openstack.
>
> 	But, yes, OVS bridge configuration is very different from the
> linux bridge, and the ARP monitor was not designed with OVS in mind.
>
> 	I'll also point out that OVS has its own bonding, although it
> does not implement functionality equivalent to the ARP monitor.
>
> 	However, OVS does provide an implementation of RFC 5880 BFD
> (Bidirectional Forwarding Detection).  The openstack deployments that
> I'm familiar with typically use the kernel bonding in LACP mode along
> with BFD.  Is there a reason that OVS + BFD is unsuitable for your
> purposes?
>
> >On the other hand, as Adri=C3=A1n Moreno said, the packets generated on =
br-ex
> >could be routed anywhere using OpenFlow rules (including eth2 in the
> >diagram). The same with normal bridge, with tc/netfilter rules, the pack=
ets
> >could also be routed to other interface instead of bond0.
>
> 	True, and, at least in the openstack OVN/OVS deployments I'm
> familiar with, heavy use of openflow rules is the usual configuration.
> Those deployments also make use of tc rules for various purposes.
>
> >So the rt interface checking in bond_arp_send_all() is not always correc=
t.
> >Stanislas suggested adding a new parameter like 'arp monitor source inte=
rface'
> >to binding that the user could supply. Then we can do like
> >	If (rt->dst.dev =3D=3D arp_src_iface->dev)
> >		goto found;
> >
> >What do you think?
>
> 	A single "arp_src_iface" parameter won't scale if there are
> multiple ARP targets, as each target might need a different
> "arp_src_iface."
>
> 	Also, the original purpose of bond_verify_device_path() is to
> return VLAN tags in the device stack so that the ARP will be properly
> tagged.
>
> 	I think what you're really asking for is a "I know what I'm
> doing" option to bypass the checks in bond_arp_send_all().  That would
> also skip the VLAN tag search, so it's not necessarily a perfect
> solution.

I agree this is a better approach than "arp_src_iface" and that it's
still not perfect. For OVS bridges, VLAN information is in userspace
so we don't have a good way of retrieving it.

Also, this flag would apply to all ARP targets although I cannot think
of any topology that would require monitoring addresses on OVS and non
OVS interfaces.

Another possible approach would be to internally encode what interfaces
types do honor the "stacking is datapath" assumption. I also dislike
this given the flexibility netfilter and ebpf (and OpenFlow for that
matter) have to create virtual datapaths independent from interface
stacking, even on bridges.

Thanks.
Adri=C3=A1n

>
> 	Before considering such a change, I'd like to know why OVS + BFD
> over a kernel bond attached to the OVS bridge is unsuitable for your use
> case, as that's a common configuration I've seen with OVS.
>
> 	-J
>
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net
>


