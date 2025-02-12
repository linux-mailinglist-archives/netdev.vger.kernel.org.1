Return-Path: <netdev+bounces-165575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9896A32992
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331991886FBA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E019211285;
	Wed, 12 Feb 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwC5rewM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/HgXyp8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30212211276
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373074; cv=none; b=WDbFCujbaiAoGrtZr5cUCguNiaXt0h0nyA0SCCV7C7Dl7DuVyzFDcsjjOOP0t87h8LnZUvrUFh2qEbznet69yIQ4H+LBmuGVzgrMX8ACN/DrNv+vPDv4c9+ObixrNoeC7lOa1KV1NInoOYqTRniL9qnUjbTFZqeUzSDCossvMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373074; c=relaxed/simple;
	bh=82qqi7EhBcHhvR+S/WkfkXa0RYZNI9DIYY5fDYXpCNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rahT+7NziBCXSTX8GlWDxJeYO2ob/Xz9RzT9V+qPGmnhg4xcruugWpls1jeGtNyXWgs5e756zYcJBQSOhviijs2j8fDyiVp8FHGxzImNuWJ53eRv2gJhTFK6fq90f3GfmWbpS9hO7TyJp8/TauQWVhbTVFuA+HdPzQge76ums2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwC5rewM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/HgXyp8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Feb 2025 16:11:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739373070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SrfOWDCT3XuVLyeucGyiCbsN3LAsppGk75lAUq/SMs=;
	b=bwC5rewMj4IiTKRVeoaFCl3ZEAWop6emxipwa6BMA4/fCHtzKaYn+EI4P+DGRI3kozJMDc
	x2JIUDdg9OMpF2Vqchi7IIHryBwaqvssgk/NpeuE5p9Ty73Zii7A6sZ8JbLak87/DVvzLR
	e+tV+PtROlAaitsiGhgEfA2IGr50N+GjOT1141DgpaOwUTqbSzqwIBrIWAkEcKR28r0XVn
	jD1RoGV6y7UeIQlB4OMCfD5T20FHdAnyyuPSrPQTIHU8YM4wetZCIgaNPATEZUFhpU6viw
	D2TLMt6dMaFbi5xlgkKZFrEY3y35+CNpjVh9RdOjESXfE2N1yl5XTLbBQpXezQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739373070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SrfOWDCT3XuVLyeucGyiCbsN3LAsppGk75lAUq/SMs=;
	b=o/HgXyp8ZAFpI+kXnPtVxC36730434MotVM6XITNddzybVCSipIvUNpBOGw7Hk2ufBW1v4
	If0ijLensOdwkJCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, rostedt@goodmis.org,
	clrkwllms@kernel.org, jgarzik@redhat.com, yuma@redhat.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <20250212151108.jI8qODdD@linutronix.de>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>

On 2025-02-12 08:56:47 [-0300], Wander Lairson Costa wrote:
> > What disables preemption? On PREEMPT_RT the spin_lock() does not disable
> > preemption. You shouldn't spin that long. When was interrupt scheduled.
> > _Why_ is the interrupt delayed that long.
> >=20
> When I was using trace-cmd report -l, it omitted some fields, one of
> them is preempt-lazy-depth (which was something new to me), and it seems
> this is what affects interrupts. It comes from here [1]. I had the logs,
> but the machine went under maintenance  before I could save them. Once
> it comes back, I can grab them and post here.
>=20
> [1] https://elixir.bootlin.com/linux/v6.13.2/source/drivers/net/ethernet/=
intel/igbvf/netdev.c#L1522

If you do send patches against mainline please test against mainline. As
of today we have preempt-disable and migrate-disable depth. We don't
do lazy-depth anymore, we just have a bit now (which is [lLbB]).
The referenced line will only disable migration, not preemption.

It is important to understand what exactly is going on.

> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/et=
hernet/intel/igb/igb_main.c
> > index d368b753a4675..6fe37b8001c36 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -912,7 +912,7 @@ static int igb_request_msix(struct igb_adapter *ada=
pter)
> >  	struct net_device *netdev =3D adapter->netdev;
> >  	int i, err =3D 0, vector =3D 0, free_vector =3D 0;
> > =20
> > -	err =3D request_irq(adapter->msix_entries[vector].vector,
> > +	err =3D request_threaded_irq(adapter->msix_entries[vector].vector, NU=
LL,
> >  			  igb_msix_other, 0, netdev->name, adapter);
> >  	if (err)
> >  		goto err_out;
> >=20
> > just to see if it solves the problem?
> >=20
> I have two test cases:
>=20
> 1) Boot the machine with nr_cpus=3D1. The driver reports "PF still
> resetting" message continuously. This issue is gone.

good.

> 2) Run the following script:
>=20
>     ipaddr_vlan=3D3
>     nic_test=3Dens14f0
>     vf=3D${nic_test}v0 # The main testing steps:
>     while true; do
>         ip link set ${nic_test} mtu 1500
>         ip link set ${vf} mtu 1500
>         ip link set $vf up
>         # 3. set vlan and ip for VF
>         ip link set ${nic_test} vf 0 vlan ${ipaddr_vlan}
>         ip addr add 172.30.${ipaddr_vlan}.1/24 dev ${vf}
>         ip addr add 2021:db8:${ipaddr_vlan}::1/64 dev ${vf}
>         # 4. check the link state for VF and PF
>         ip link show ${nic_test}
>         if ! ip link show $vf | grep 'state UP'; then
>             echo 'Error found'
>             break
>         fi
>         ip link set $vf down
>     done
>=20
> This one eventually fails. It is the first time that one works and the
> other fails. So far, it has been all or nothing. I didn't have time yet to
> investigate why this happens.

"eventually fails". Does this mean it passes the first few iterations
but then it times out? In that case it might be something else

I managed to find a "Intel Corporation I350 Gigabit Network Connection
(rev 01)" and I end up in a warning if I start the script (without the
while true):

|8021q: adding VLAN 0 to HW filter on device eno0v0
|igbvf 0000:08:10.0: Vlan id 0 is not added
|igb 0000:07:00.0: Setting VLAN 3, QOS 0x0 on VF 0
|igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
|------------[ cut here ]------------
|WARNING: CPU: 25 PID: 3013 at drivers/net/ethernet/intel/igbvf/netdev.c:17=
77 igbvf_close+0x111/0x120
=E2=80=A6
|CPU: 25 UID: 0 PID: 3013 Comm: ip Not tainted 6.14.0-rc1-rt1+ #186 PREEMPT=
_RT+LAZY 39474a76e7562bb76173f4b98cf194301d39bf7f
|igbvf 0000:08:10.0: Link is Up 1000 Mbps Full Duplex
|---[ end trace 0000000000000000 ]---
|igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
|igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
|igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter
|8021q: adding VLAN 0 to HW filter on device eno0v0
|igb 0000:07:00.0: VF 0 attempted to override administratively set VLAN tag
|Reload the VF driver to resume operations
|igbvf 0000:08:10.0: Link is Up 1000 Mbps Full Duplex
|igb 0000:07:00.0: VF 0 attempted to set invalid MAC filter

and the state is down ('Error found' is printed). But if I do it
manually, line by line, then it all passes without the warning and the
state of the VF device is up.

Sebastian

