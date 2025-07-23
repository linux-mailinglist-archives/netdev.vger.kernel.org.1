Return-Path: <netdev+bounces-209371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1331B0F675
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2D7AC69FB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2432FA622;
	Wed, 23 Jul 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq58MTfI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1C230268
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282570; cv=none; b=ZTTz/2AVtL8ZlDhxJrNrKKIGEc7WqCg4cWircvGp7MoNX/D4zRmrIRIEwS1aNWLISoSHjHm1MKKeObhEkfhpkREtZoLqeSgcmoNUY5M3UIvliQg5FSy4l4gXdKjT3eEwqmmJzT76hTzxtJEZKdLNp4jnDL7hhZ3AFyAaB/fhJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282570; c=relaxed/simple;
	bh=7Iq/N1kUhHkuPMer9SZPP1trZhSuqS71M3BMcnulUKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFkt3qKCgnimYRJ0PzslGYNeiBwxVQwwvMjRqthdcqtZdba71bwY0nl73JjUy2vgjwpz4W8X3n40p+RCifkafErGmzdKzCHWfEa5MTSMCSO0b+zO3wJCOXnbFGJR0LmHet8gfQzvc0fRaCOSVw2J1kuzd6Va7GCD9vI83WaOapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq58MTfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452B8C4CEF8;
	Wed, 23 Jul 2025 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282566;
	bh=7Iq/N1kUhHkuPMer9SZPP1trZhSuqS71M3BMcnulUKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lq58MTfIj+0xP0mzV8RJftsDMEndYro3Hg7vg7fzk+M1b0KFa1i8yZJEuxqWfAmEf
	 FWLo2pif7pERFPuwUTCN5gonKsh9YscL3dSrvhWDhs8K2YUZZTkBMWtBPq0fbJ17Vh
	 jeXhBAuxwTsuQsSXPSLchqUfU/iA8TELU5mwdMShVL6JPN8MJw/nIfQvZXNO4JTcA/
	 Ic9/8mTjrn3bgOInJYBA6XN4zOMMDvE/0zbRttEjIAqFBUC5uzIVL5AqTILNZsCjtd
	 +b37jMex5Hib+Sup0yrRyD2A8DypT/9j2RKJ9W6Lzu1ekggiCZrvDJFlOHVTXXhORb
	 KxA0OsrUmf8VA==
Date: Wed, 23 Jul 2025 07:56:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org, Joe
 Damato <joe@dama.to>
Subject: Re: [PATCH net-next] net: Restore napi threaded state only when it
 is enabled
Message-ID: <20250723075605.16ec3756@kernel.org>
In-Reply-To: <CAAywjhQN4Re3+64=qiukq1Q2wtLBj2pesaDSsvojK4tDAGHegw@mail.gmail.com>
References: <20250721233608.111860-1-skhawaja@google.com>
	<20250722183647.1fd15767@kernel.org>
	<CAAywjhQN4Re3+64=qiukq1Q2wtLBj2pesaDSsvojK4tDAGHegw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 19:36:31 -0700 Samiullah Khawaja wrote:
> On Tue, Jul 22, 2025 at 6:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 21 Jul 2025 23:36:08 +0000 Samiullah Khawaja wrote: =20
> > > Commit 2677010e7793 ("Add support to set NAPI threaded for individual
> > > NAPI") added support to enable/disable threaded napi using netlink. T=
his
> > > also extended the napi config save/restore functionality to set the n=
api
> > > threaded state. This breaks the netdev reset when threaded napi is =20
> >
> > "This breaks the netdev reset" is very vague. =20
> Basically on netdev reset inside napi_enable when it calls
> napi_restore_config it tries to stop the NAPI kthread. Since during
> napi_enable, the NAPI has STATE_SCHED set on it, the stop_kthread gets
> stuck waiting for the STATE_SCHED to be unset. It should not be
> destroying the kthread since threaded is enabled at device level. But
> I think your point below is valid, we should probably set
> napi->config->threaded in netif_set_threaded.
>=20
> I should add this to the commit message.

Ah, I see! The impermanence of the DISABLED bit strikes again :(

> > > enabled at device level as the napi_restore_config tries to stop the
> > > kthreads as napi->config->thread is false when threaded is enabled at
> > > device level. =20
> >
> > My reading of the commit message is that the WARN triggers, but
> > looking at the code I think you mean that we fail to update the
> > config when we set at the device level?
> > =20
> > > The napi_restore_config should only restore the napi threaded state w=
hen
> > > threaded is enabled at NAPI level.
> > >
> > > The issue can be reproduced on virtio-net device using qemu. To
> > > reproduce the issue run following,
> > >
> > >   echo 1 > /sys/class/net/threaded
> > >   ethtool -L eth0 combined 1 =20
> >
> > Maybe we should add that as a test under tools/testing/drivers/net -
> > it will run against netdevsim but also all drivers we test which
> > currently means virtio and fbnic, but hopefully soon more. Up to you. =
=20
> +1
>=20
> I do want to add a test for it. I was thinking of extending
> nl_netdev.py but that doesn't seem suitable as it only looks at the
> state. I will look at the driver directory. Should I send a test with
> this fix or should I send that later after the next reopen?

We recommend sending the patch and the fix in one series, but up to you.

> > I'm not sure I agree with the semantics, tho. IIUC you're basically
> > making the code prefer threaded option. If user enables threading
> > for the device, then disables it for a NAPI - reconfiguration will
> > lose the fact that specific NAPI instance was supposed to have threading
> > disabled. Why not update napi->config in netif_set_threaded() instead? =
=20
> I think this discrepancy is orthogonal to the stopping of threads in
> restore. This is because the napi_enable is calling restore_config and
> then setting the STATE_THREADED bit on napis based on dev->threaded.
> Even if restore unsets the THREADED bit (which would have already been
> unset during napi_disable), it will be set again based on
> dev->threaded.
>=20
> I think napi_restore_config should be called after setting up STATE bits?

Yes, I think that would work. In fact I think it makes more sense in
the first place to "list" the NAPI in the hash table accessible by user
space only after it's actually enabled.

I'd also be tempted to move some of the config restoration to
netif_napi_add(), so that we don't start the thread just to stop it.
But we'd need it in both places, IIRC netlink only holds the instance
lock, so theoretically the config may change between "add" and "enable"
:(

cc: Joe, who's probably offline, but note his non-Fastly address

