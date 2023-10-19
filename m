Return-Path: <netdev+bounces-42519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF37CF224
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCC11C2098E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17514F6D;
	Thu, 19 Oct 2023 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY8ma3DE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6163D5
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 08:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD261C433C7;
	Thu, 19 Oct 2023 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697703212;
	bh=0hv3HV8AdYWgPJNSAVVsWOvT4OLWnZ3vpDnwGzK8GYo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BY8ma3DE8Ia/VEbMfQvOvOgt44LNDgSTdlB4k/lEJoHtS46giScwjCPTKug+6Fu4n
	 JPrRPVjrQkh5kHAVimRBT9mKd6Yp2Tl4Nrtve111u1Iq8DM0lPT+mznzXKpz/99OP2
	 l8JTCuta1Um83dC6OotFgB2IPfrZRXV1vcylxcZMyDmCzX4DLY123r9KnN8slTiRJ0
	 2jRVIJwEv6fXDush0m1PFgWEfht830N4F4NTIxV+dBBa608T6dXN28L6VaLS2R8Zqq
	 gCH9o0npRlAYD0iANr6pqRbIfefjk9Gsh2tMy3QSrmmojTBTERdgXWuQDT86Gtnum6
	 aPPAWxYpPTLtQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2023101840-scabbed-visitor-3fdd@gregkh>
References: <20231018154804.420823-1-atenart@kernel.org> <20231018154804.420823-2-atenart@kernel.org> <2023101840-scabbed-visitor-3fdd@gregkh>
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from device attributes
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mhocko@suse.com, stephen@networkplumber.org
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 19 Oct 2023 10:13:29 +0200
Message-ID: <169770320930.433869.5743241833039124669@kwain>

Quoting Greg KH (2023-10-18 18:49:18)
> On Wed, Oct 18, 2023 at 05:47:43PM +0200, Antoine Tenart wrote:
> > +static inline struct kernfs_node *sysfs_rtnl_lock(struct kobject *kobj,
> > +                                               struct attribute *attr,
> > +                                               struct net_device *ndev)
> > +{
> > +     struct kernfs_node *kn;
> > +
> > +     /* First, we hold a reference to the net device we might use in t=
he
> > +      * locking section as the unregistration path might run in parall=
el.
> > +      * This will ensure the net device won't be freed before we retur=
n.
> > +      */
> > +     dev_hold(ndev);
> > +     /* sysfs_break_active_protection was introduced to allow self-rem=
oval of
> > +      * devices and their associated sysfs files by bailing out of the
> > +      * sysfs/kernfs protection. We do this here to allow the unregist=
ration
> > +      * path to complete in parallel. The following takes a reference =
on the
> > +      * kobject and the kernfs_node being accessed.
> > +      *
> > +      * This works because we hold a reference onto the net device and=
 the
> > +      * unregistration path will wait for us eventually in netdev_run_=
todo
> > +      * (outside an rtnl lock section).
> > +      */
> > +     kn =3D sysfs_break_active_protection(kobj, attr);
> > +     WARN_ON_ONCE(!kn);
>=20
> If this triggers, you will end up rebooting the machines that set
> panic-on-warn, do you mean to do that?  And note, the huge majority of
> Linux systems in the world have that enabled, so be careful.

Right. My understanding was this can not happen here and I added this
one as a "that should not happen and something is really wrong", as the
attribute should be valid until at least the call to
sysfs_break_active_protection.

Thanks,
Antoine

