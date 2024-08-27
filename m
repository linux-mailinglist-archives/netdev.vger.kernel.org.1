Return-Path: <netdev+bounces-122095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64495FE26
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DDB283031
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 01:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE89923CE;
	Tue, 27 Aug 2024 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ1JduaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927B944F
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724720962; cv=none; b=hQW++H2EGkhmXUWw506nKYKIEFE/0DdRYIt979amfg99BqN2YWq80924mIVDiwJhKRkHxvo6z5vuF3smSRXRz7W/0ZluQawJ3fq+ICu4w4k2NDjMrjqiQxP9aVMKdgDMrgsxLTD938kX/pdKw0u4QjXxAXhk5kx+nD7/O62Za/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724720962; c=relaxed/simple;
	bh=2/0m2/KYunbqEYUbteimebPucWSVjaRioJYqa2No7KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx4hyoDuvf9sucmQmnOx4IVwoeKcIgYNZtcmwVRFuyl00gPzovLwh81IxYANerpeO04odnqQ5IeesHqqPnrQqVUZNOEGjqW/gwwF81ad5wjJOEVRhsdSd30R3f2+IVZQeVv+YSPwupi+DQsmIt7nFwA2MHw6zTFLIFzv+6CeAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ1JduaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2823C8B7A2;
	Tue, 27 Aug 2024 01:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724720962;
	bh=2/0m2/KYunbqEYUbteimebPucWSVjaRioJYqa2No7KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vQ1JduaMZQaryYJsfg3NOCg4+leV3f00uYIlyhXNBDtukZ8Ntmd0P1N3UzN2m0Vta
	 dcynC+S1rR66R9P92607rALxV1P1v8p88yOsfQNfo9ejdIEPjJ/Lz4V6nYc9/R+2Jt
	 Bkc1v46X8cCY20UtD8RIAWml4Ny02QW+G0B9i8oTWvQXxZgo32Ph20OhELHdVTnPf7
	 DPJxD7HmcqsvYRgIeH8NqdxCNWVZTQilHIrBtwD096Mb9UpOCrTYC7q9gnvHRuywbt
	 lhptiEm/pII7UO5yISnZXHXFM62xJb7uCOdK2BF1CuLz4THva6cnkp2O/HRnic8g8w
	 fdpKkZbUMP3jA==
Date: Mon, 26 Aug 2024 18:09:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
Message-ID: <20240826180921.560e112d@kernel.org>
In-Reply-To: <b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
	<20240819223442.48013-3-anthony.l.nguyen@intel.com>
	<20240820181757.02d83f15@kernel.org>
	<613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
	<20240822161718.22a1840e@kernel.org>
	<b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Aug 2024 14:59:17 +0200 Alexander Lobakin wrote:
> >> For now it's done as a lib inside Intel folder, BUT if any other vendor
> >> would like to use this, that would be great and then we could move it
> >> level up or some of these APIs can go into the core.
> >> IOW depends on users.
> >>
> >> libie in contrary contains HW-specific code and will always be
> >> Intel-specific. =20
> >=20
> > Seems like an odd middle ground. If you believe it's generic finding
> > another driver shouldn't be hard. =20
>=20
> But it's up to the vendors right, I can't force them to use this code or
> just switch their driver to use it :D

It shouldn't be up to interpretation whether the library makes code
better. If it doesn't -- what's the point of the library. If it does
-- the other vendors better have a solid reason to push back.

> >> So you mean just open-code reads/writes per each field than to compress
> >> it that way? =20
> >=20
> > Yes. <rant> I don't understand why people try to be clever and
> > complicate stats reading for minor LoC saving (almost everyone,
> > including those working on fbnic). Just type the code in -- it=20
> > makes maintaining it, grepping and adding a new stat without
> > remembering all the details soo much easier. </rant> =20
>=20
> In some cases, not this one, iterating over an array means way less
> object code than open-coded per-field assignment. Just try do that for
> 50 fields and you'll see.

Do you have numbers? How much binary code is 50 simple moves on x86?

> >> You mean to leave 0xffs for unsupported fields? =20
> >=20
> > Kinda of. But also I do mean to call out that you haven't read the doc
> > for the interface over which you're building an abstraction =F0=9F=98=
=B5=E2=80=8D=F0=9F=92=AB=EF=B8=8F =20
>=20
> But I have...

Read, or saw it?

> >> I believe this nack is for generic Netlink stats, not the whole, right?
> >> In general, I wasn't sure about whether it would be better to leave
> >> Netlink stats per driver or write it in libeth, so I wanted to see
> >> opinions of others. I'm fine with either way. =20
> >=20
> > We (I?) keep pushing more and more stats into the generic definitions,
> > mostly as I find clear need for them in Meta's monitoring system.
> > My main concern is that if you hide the stats collecting in a library
> > it will make ensuring the consistency of the definition much harder,
> > and it will propagate the use of old APIs (dreaded ethtool -S) into new
> > drivers. =20
>=20
> But why should it propagate?=20

I'm saying it shouldn't. The next NIC driver Intel (inevitably :))
creates should not report generic stuff via ethtool -S.
If it plugs in your library - it will.

> People who want to use these generic stats
> will read the code and see which fields are collected and exported, so
> that they realize that, for example, packets, bytes and all that stuff
> are already exported and and they need to export only driver-specific
> ones...
>=20
> Or do you mean the thing that this code exports stuff like packets/bytes
> to ethtool -S apart from the NL stats as well?=20

Yes, this.

> I'll be happy to remove that for basic Rx/Tx queues (and leave only
> those which don't exist yet in the NL stats) and when you introduce
> more fields to NL stats, removing more from ethtool -S in this
> library will be easy.

I don't scale to remembering 1 easy thing for each driver we have.

> But let's say what should we do with XDP Tx
> queues? They're invisible to rtnl as they are past real_num_tx_queues.

They go to ethtool -S today. It should be relatively easy to start
reporting them. I didn't add them because I don't have a clear use=20
case at the moment.

> > If you have useful helpers that can be broadly applicable that's
> > great. This library as it stands will need a lot of work and a lot
> > of convincing to go in. =20
>=20
> Be more precise and I'll rework the stuff you find bad/confusing/etc,
> excluding the points we discuss above* as I already noted them. Just
> saying "need a lot of work and a lot of convincing" doesn't help much.
> You can take a driver as an example (fbnic?) and elaborate why you
> wouldn't use this lib to implement the stats there.

The other way around. Why would I? What is this layer of indirection
buying us? To add a statistic today I have to plug it into 4 places:
 - queue struct
 - the place it gets incremented
 - the place it gets reported
 - aggregation when ring is freed (BUILD_BUG_ON() will remind of this)

This is pretty intuitive and not much work at all. The complexity of
the library and how hard it is to read the 200 LoC macros by far
outweighs the 2 LoC I can save. Not to mention that I potentially
save space on all the stats I'm not implementing.

I'd argue that anything that the library can usefully do can be just
moved into the core.

> * implementing NL stats in drivers, not here; not exporting NL stats
> to ethtool -S
>=20
> A driver wants to export a field which is missing in the lib? It's a
> couple lines to add it. Another driver doesn't support this field and
> you want it to still be 0xff there? Already noted and I'm already
> implementing a different model.

I think it will be very useful if you could step back and put on paper
what your goals are with this work, exactly.

