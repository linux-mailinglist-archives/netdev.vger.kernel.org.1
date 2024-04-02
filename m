Return-Path: <netdev+bounces-84128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D51895AD4
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD731C21D94
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086915A4BD;
	Tue,  2 Apr 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKVKUlw1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437F17582;
	Tue,  2 Apr 2024 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079546; cv=none; b=kjAHJucMepUq61tjI1ZqWsKfhv3BMre2Ju3HxlbQt1GjvbKb7ddzuYhCrXGHfa/I4V3XOfneo5qL5ZG4aRLV2vxRlgMq8y304xU8CdsHQSw3+HnB1M2CdpWsYRTPmHx4hPr2Y6iteDR1/q8yQlBZv/bOuAa2Bc+5OgNn+daT5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079546; c=relaxed/simple;
	bh=iuUzdNaQSKYbJhisLenP0E9J+WcZmYbuya8DASpXt2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S38gH699ud7fJi6leIoQyKhhnNZr6mTZOoeDZX7blJ6vZI/zJderesXNGm9b2Cc2a2Wd4AAufnagE/paHCb86ukNAGIQfrqFVhK0vf/3rwNoDz3EV0cWxjQiJfQdX90TCTVOxeb3vlV1s9Ax+yBmNTB992YLyIax80nw62S7+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKVKUlw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4EFC433F1;
	Tue,  2 Apr 2024 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079545;
	bh=iuUzdNaQSKYbJhisLenP0E9J+WcZmYbuya8DASpXt2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKVKUlw15t7FfFKLMMtxwRqwjPeFGT36YApX7IhVNk3b/q3ijsFahhBFtlje5u+No
	 l2/U9B75nnNLyZ6U2sHgLyfwP69C7AnTfc2nvctjtN0kQfvXwG6zH27EKxgph1JuUV
	 1lNGWeIaZ+PYxIDuAVSoSbGen5qcTP889I6D7552on12CgDSmX90EcD3o//b8ngv3l
	 PmqNUInpu6ypYoHSUx5klqlwCUXyyRfEY6ttbU0SxI5lFnhCJ5svNDwU147MfiOXqV
	 tcyuQdf+U/buPHlFGCD28ZWYSfgcpozRWVFkGuQ7gRsVE/H0BVKmmsPXrryHBBEaTb
	 IwMWaZypB+Snw==
Date: Tue, 2 Apr 2024 18:38:59 +0100
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
Message-ID: <20240402-ample-preview-c84edb69db1b@spud>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
 <20240328-ferocity-repose-c554f75a676c@spud>
 <ed3debc9-f2a9-41fb-9cf9-dc6419de5c01@huaweicloud.com>
 <87cyr7rgdn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rDUw0N+1zEfzL5kD"
Content-Disposition: inline
In-Reply-To: <87cyr7rgdn.fsf@all.your.base.are.belong.to.us>


--rDUw0N+1zEfzL5kD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 04:25:24PM +0200, Bj=F6rn T=F6pel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
>=20
> > On 2024/3/29 6:07, Conor Dooley wrote:
> >> On Thu, Mar 28, 2024 at 03:34:31PM -0400, Stefan O'Rear wrote:
> >>> On Thu, Mar 28, 2024, at 8:49 AM, Pu Lehui wrote:
> >>>> From: Pu Lehui <pulehui@huawei.com>
> >>>>
> >>>> This patch relaxes the restrictions on the Zbb instructions. The har=
dware
> >>>> is capable of recognizing the Zbb instructions independently, elimin=
ating
> >>>> the need for reliance on kernel compile configurations.
> >>>
> >>> This doesn't make sense to me.
> >>=20
> >> It doesn't make sense to me either. Of course the hardware's capability
> >> to understand an instruction is independent of whether or not a
> >> toolchain is capable of actually emitting the instruction.
> >>=20
> >>> RISCV_ISA_ZBB is defined as:
> >>>
> >>>             Adds support to dynamically detect the presence of the ZBB
> >>>             extension (basic bit manipulation) and enable its usage.
> >>>
> >>> In other words, RISCV_ISA_ZBB=3Dn should disable everything that atte=
mpts
> >>> to detect Zbb at runtime. It is mostly relevant for code size reducti=
on,
> >>> which is relevant for BPF since if RISCV_ISA_ZBB=3Dn all rvzbb_enable=
d()
> >>> checks can be constant-folded.
> >
> > Thanks for review. My initial thought was the same as yours, but after=
=20
> > discussions [0] and test verifications, the hardware can indeed=20
> > recognize the zbb instruction even if the kernel has not enabled=20
> > CONFIG_RISCV_ISA_ZBB. As Conor mentioned, we are just acting as a JIT t=
o=20
> > emit zbb instruction here. Maybe is_hw_zbb_capable() will be better?
>=20
> I still think Lehui's patch is correct; Building a kernel that can boot
> on multiple platforms (w/ or w/o Zbb support) and not having Zbb insn in
> the kernel proper, and iff Zbb is available at run-time the BPF JIT will
> emit Zbb.

This sentence is -ENOPARSE to me, did you accidentally omit some words?
Additionally he config option has nothing to do with building kernels that
boot on multiple platforms, it only controls whether optimisations for Zbb
are built so that if Zbb is detected they can be used.

> For these kind of optimizations, (IMO) it's better to let the BPF JIT
> decide at run-time.

Why is bpf a different case to any other user in this regard?
I think that the commit message is misleading and needs to be changed,
because the point "the hardware is capable of recognising the Zbb
instructions independently..." is completely unrelated to the purpose
of the config option. Of course the hardware understanding the option
has nothing to do with kernel configuration. The commit message needs to
explain why bpf is a special case and is exempt from an=20

I totally understand any point about bpf being different in terms of
needing toolchain support, but IIRC it was I who pointed out up-thread.
The part of the conversation that you're replying to here is about the
semantics of the Kconfig option and the original patch never mentioned
trying to avoid a dependency on toolchains at all, just kernel
configurations. The toolchain requirements I don't think are even super
hard to fulfill either - the last 3 versions of ld and lld all meet the
criteria.


--rDUw0N+1zEfzL5kD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxCswAKCRB4tDGHoIJi
0mUNAP4xNbI++bzEaHK6ZDR1lMX+P5ARgZL9DZ1skHQEVLlnYAD9GL99/nj02IYH
DN80f4mQlfeKWfcBAemilpEjnr5KugQ=
=6qti
-----END PGP SIGNATURE-----

--rDUw0N+1zEfzL5kD--

