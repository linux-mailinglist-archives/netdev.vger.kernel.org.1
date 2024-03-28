Return-Path: <netdev+bounces-83106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80065890D2A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 23:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD0FB212CC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA81448E2;
	Thu, 28 Mar 2024 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiY+MAvZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE671448DA;
	Thu, 28 Mar 2024 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663650; cv=none; b=qar7Mbl1p1ZkcGuyKdHmdSBrEQJ6iquXu75U4w7grAseeEmKzQ1PYsQkfutg8fwQV/pf5O2wgJ48DF8nkjssF/Krvo+n+nmi4C+gEQmt5zkyUTWuZeAkF/Ry9sm27qUWgR5FssJlX++lgEUHDNw/JZlVDySGxvGc5AtpWZOuBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663650; c=relaxed/simple;
	bh=qy7UxkfEbTXP0fG7wTtOhGPzbFidkRhVmLz4VIILo8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohkCd3ympkEcQk8ic6P2I7hUCT+uWSVjXdJLRnO2paC43ywyb74+dSfoDhhuVSoBOgnwFW9pRitzCqVLUww49eb2uFPzOUbru6Qo8ZxrGs5bFKoc2PR1Vs5P1mhYCcjBQucQ/tT+x+1kiFuwa+54Z+sI1I8iiVOOo92Y0p2+vEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiY+MAvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCAEC433C7;
	Thu, 28 Mar 2024 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711663649;
	bh=qy7UxkfEbTXP0fG7wTtOhGPzbFidkRhVmLz4VIILo8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiY+MAvZ71RFRJLOV9wNKnH78WzuQ+yoDrFEDHLeDYUytCNt8LwKz0Sygxq8mN3zB
	 zQ6z9aJ/UtcJQYb+0Ix1xOcUvBTzmGnVrlnLp0Gmy7zuin8SEKFIMvaRgai8sI5mNa
	 rT0GGDmlNev4jmnp2j+eIlSQgjrssSa+StiYbos4MJYWh8B1/94h4hBeRi0O8f134x
	 7uE7DuBDy9eZNkcQZ17ObD+cwHa1FuZ5aWLMcVBNPO0eRbV2uVEVu77DeIN5SRax/v
	 JzK10wMVrXwQSwVmxMsxsApYaUSTFjSerYL/VPgvBRQMixcY7jSB7TVLmYTpiDnk/3
	 kwyow4tk4wpsA==
Date: Thu, 28 Mar 2024 22:07:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <20240328-ferocity-repose-c554f75a676c@spud>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AbnF/Y1LlP5Fvmu+"
Content-Disposition: inline
In-Reply-To: <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>


--AbnF/Y1LlP5Fvmu+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 03:34:31PM -0400, Stefan O'Rear wrote:
> On Thu, Mar 28, 2024, at 8:49 AM, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> >
> > This patch relaxes the restrictions on the Zbb instructions. The hardwa=
re
> > is capable of recognizing the Zbb instructions independently, eliminati=
ng
> > the need for reliance on kernel compile configurations.
>=20
> This doesn't make sense to me.

It doesn't make sense to me either. Of course the hardware's capability
to understand an instruction is independent of whether or not a
toolchain is capable of actually emitting the instruction.

> RISCV_ISA_ZBB is defined as:
>=20
>            Adds support to dynamically detect the presence of the ZBB
>            extension (basic bit manipulation) and enable its usage.
>=20
> In other words, RISCV_ISA_ZBB=3Dn should disable everything that attempts
> to detect Zbb at runtime. It is mostly relevant for code size reduction,
> which is relevant for BPF since if RISCV_ISA_ZBB=3Dn all rvzbb_enabled()
> checks can be constant-folded.
>=20
> If BPF needs to become an exception (why?), this should be mentioned in
> Kconfig.

And in the commit message. On one hand I think this could be a reasonable
thing to do in bpf as it is acting as a jit here, and doesn't actually
need the alternatives that we are using elsewhere to enable the
optimisations nor the compiler support. On the other the intention of
that kconfig option is to control optimisations like rvzbb_enabled()
gates, so this is gonna need a proper justification as to

As I said on IRC to you earlier, I think the Kconfig options here are in
need of a bit of a spring cleaning - they should be modified to explain
their individual purposes, be that enabling optimisations in the kernel
or being required for userspace. I'll try to send a patch for that if
I remember tomorrow.

Thanks,
Conor.

> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> > ---
> >  arch/riscv/net/bpf_jit.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> > index 5fc374ed98ea..bcf109b88df5 100644
> > --- a/arch/riscv/net/bpf_jit.h
> > +++ b/arch/riscv/net/bpf_jit.h
> > @@ -20,7 +20,7 @@ static inline bool rvc_enabled(void)
> >=20
> >  static inline bool rvzbb_enabled(void)
> >  {
> > -	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&=20
> > riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
> > +	return riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
> >  }
> >=20
> >  enum {
> > --=20
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--AbnF/Y1LlP5Fvmu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgXqGwAKCRB4tDGHoIJi
0n9mAQCMUUZGliN/KpdYVcNTscPK+ff5W8UCov2gCxTu1Rgs/gD/aDZv9SYF6EQx
SpQgWucp0nYikxazDlNmYYOtPAZn8QE=
=TrHF
-----END PGP SIGNATURE-----

--AbnF/Y1LlP5Fvmu+--

