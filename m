Return-Path: <netdev+bounces-84229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CF8961E9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0626F28B1AA
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F210940;
	Wed,  3 Apr 2024 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzPP77gA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756917727;
	Wed,  3 Apr 2024 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107212; cv=none; b=qgk7JVK6pgghZV71vMTSX0+SeCplZmyM7mu4GA8oSOEz0q6a+/0fK74EVdJaFWSJrT7B/ZXp0kn+PKkCFEY64rwum0Zpkf9TYp6a1I8T1w/rdxHX03mBpWOeO5d1jfjzwRJmBAa4sgFeRavOKj1lFZlyAGkfr6Qa1BYis8L3nHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107212; c=relaxed/simple;
	bh=WBasPOB8gQWqxUEirkIG9EvIRFQQW/a9zobZIgfrljU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPiMd5KJOu34WiyG5uu7kyO45y2u437o/95APaRxET5zqxHucPxm9LnK5Q32j314oSVkyuYXhoYsEcQ4uk0jbw/ku5CyUzNWyTin3UVyd83Ep06R8P9qbT85tGvgla2kGRknA2O7YKVjjL86M1mFtDah6L5hJlrtqu1WljgFsFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzPP77gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051D8C433F1;
	Wed,  3 Apr 2024 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712107212;
	bh=WBasPOB8gQWqxUEirkIG9EvIRFQQW/a9zobZIgfrljU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzPP77gAmq7VJZPzNdTJJm/WVZlJgwJfU8CjnbRSjE397SzRw5L+30o4KWMOW71Bs
	 U8ZPJuZt7Wnl+v+TvjOSx0d+Fiw7QQTYvN/rYm3Y+is9aMUaBU2Kfj8we4qt+UCMGj
	 HglIcdpP7fV2/sl0+x18HUhlAMzJyo28GSMaPLGubRvHKN3lDkkS5XtqZIs6920xxF
	 imDO5nX9ttgWLaXn1mGifpI1OzzKNCnAQvQaury3ToCIgO7Jm8g097t5nI2LLxzWnW
	 iDU6CcMcGQd5ctdEwNa7zgZV1mdef3NEktk6DF2lsVOdFudbjF3J66sylX3Mfet1jT
	 Hj1kGIJ7h9XGg==
Date: Wed, 3 Apr 2024 02:20:05 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Pu Lehui <pulehui@huaweicloud.com>, Stefan O'Rear <sorear@fastmail.com>,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Manu Bretelle <chantr4@gmail.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb
 instructions
Message-ID: <20240403-gander-parting-a47c56401716@spud>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
 <20240328-ferocity-repose-c554f75a676c@spud>
 <ed3debc9-f2a9-41fb-9cf9-dc6419de5c01@huaweicloud.com>
 <87cyr7rgdn.fsf@all.your.base.are.belong.to.us>
 <20240402-ample-preview-c84edb69db1b@spud>
 <871q7nr3mq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qv+BdwRgr1RU9Whw"
Content-Disposition: inline
In-Reply-To: <871q7nr3mq.fsf@all.your.base.are.belong.to.us>


--qv+BdwRgr1RU9Whw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 09:00:45PM +0200, Bj=F6rn T=F6pel wrote:

> >> I still think Lehui's patch is correct; Building a kernel that can boot
> >> on multiple platforms (w/ or w/o Zbb support) and not having Zbb insn =
in
> >> the kernel proper, and iff Zbb is available at run-time the BPF JIT wi=
ll
> >> emit Zbb.
> >
> > This sentence is -ENOPARSE to me, did you accidentally omit some words?
> > Additionally he config option has nothing to do with building kernels t=
hat
> > boot on multiple platforms, it only controls whether optimisations for =
Zbb
> > are built so that if Zbb is detected they can be used.
>=20
> Ugh, sorry about that! I'm probably confused myself.

Reading this back, I a bunch of words too, so no worries...

> >> For these kind of optimizations, (IMO) it's better to let the BPF JIT
> >> decide at run-time.
> >
> > Why is bpf a different case to any other user in this regard?
> > I think that the commit message is misleading and needs to be changed,
> > because the point "the hardware is capable of recognising the Zbb
> > instructions independently..." is completely unrelated to the purpose
> > of the config option. Of course the hardware understanding the option

This should have been "understanding the instructions"...

> > has nothing to do with kernel configuration. The commit message needs to
> > explain why bpf is a special case and is exempt from an

And this s/from an//...

> > I totally understand any point about bpf being different in terms of
> > needing toolchain support, but IIRC it was I who pointed out up-thread.

And "pointed that out".

I always make a mess of these emails that I re-write several times :)

> > The part of the conversation that you're replying to here is about the
> > semantics of the Kconfig option and the original patch never mentioned
> > trying to avoid a dependency on toolchains at all, just kernel
> > configurations. The toolchain requirements I don't think are even super
> > hard to fulfill either - the last 3 versions of ld and lld all meet the
> > criteria.
>=20
> Thanks for making it more clear, and I agree that the toolchain
> requirements are not hard to fulfull.
>=20
> My view has been that "BPF is like userland", but I realize now that's
> odd.

Yeah, I can understand that perspective, but it does seem rather odd to
someone that isn't a bpf-ist.

> Let's make BPF similar to the rest of the RV kernel. If ZBB=3Dn, then
> the BPF JIT doesn't know about emitting Zbb.


--qv+BdwRgr1RU9Whw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgyuxQAKCRB4tDGHoIJi
0n8AAQD1sU7Eea95pI9/h7ezuLYET85gYREpzO1Sd6hhzTQzQAEAsiT43tCTGqZa
3CuW+sMeb3FNF2lIMoNx7Bmqui7M9wY=
=JpAU
-----END PGP SIGNATURE-----

--qv+BdwRgr1RU9Whw--

