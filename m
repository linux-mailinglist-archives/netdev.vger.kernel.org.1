Return-Path: <netdev+bounces-84150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92BB895C1D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E771C2273A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFCD15B543;
	Tue,  2 Apr 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ4bwmey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313C8495;
	Tue,  2 Apr 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084449; cv=none; b=fZyxoKaKw9jS/KxSc6ZwP4HIldnJ2SW38yPJtvcZKj6zIqPKAzbrp5IJcEVXapJx5WSN89fGvbKDlQU77jtnXu0DfOIg2EuTMOITpwk3Bh7iBiGyGTuI2/7DmZ39cqp3byZe1CUt4JcZ4LE40Szxpr4pT0D8g2Jq0AVw56DIquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084449; c=relaxed/simple;
	bh=LAtbIzYyxLFCGtNL9bIPT1JIqLRx2Xsuxm7vJ6doThY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XvuM0yqjJypKBHFTajJDmxmpXae37nsZG0bBBaTCd7pnUCKoVoLO+aMZ+znF15LpdRkmnDPNiwOJhff7KKxfk0DLhauIfR1eIGnJWFnFaNGn7c8rSdqK0PPFP6kDZNCHOTAhXK1ER6oK2Iyq/Ll/3SfeUOaA0CMJ97lRVTtnpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ4bwmey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21C3C433C7;
	Tue,  2 Apr 2024 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712084449;
	bh=LAtbIzYyxLFCGtNL9bIPT1JIqLRx2Xsuxm7vJ6doThY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DZ4bwmeyU0UKQkMQsDplzrpVduUBrEcwHrOmJLCrxxwVSSz7gljEEa+sexxuDhkek
	 Q0GOstLz6J79g/c0cVcSX17twHaTIKdjTixPFXRS8JbIvVrzjKSzQBNsMOUi8Orv+0
	 eTOFSIzOFqF54mss/lkSeoVUjD3eE7sj6Qbo4R/C+DsOhInYQujzr9TRTIyvF42SYs
	 2DcamE9zwT9rnfb/YDlyGyJL43Nv7KXKmrPPOR0it/KuuLjKQKuQeuXFrLszqT2l7r
	 UqR7rgnQaJFyPmmM9Hba7oykBUvPCPbFT7r/p+Kd+6Vy38Y16qbQUGNcbEbcfly4gU
	 y88HfgZbdXtTw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Pu Lehui <pulehui@huaweicloud.com>, Stefan O'Rear <sorear@fastmail.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Manu Bretelle <chantr4@gmail.com>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb
 instructions
In-Reply-To: <20240402-ample-preview-c84edb69db1b@spud>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
 <20240328-ferocity-repose-c554f75a676c@spud>
 <ed3debc9-f2a9-41fb-9cf9-dc6419de5c01@huaweicloud.com>
 <87cyr7rgdn.fsf@all.your.base.are.belong.to.us>
 <20240402-ample-preview-c84edb69db1b@spud>
Date: Tue, 02 Apr 2024 21:00:45 +0200
Message-ID: <871q7nr3mq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Conor!

Conor Dooley <conor@kernel.org> writes:

> On Tue, Apr 02, 2024 at 04:25:24PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>> > On 2024/3/29 6:07, Conor Dooley wrote:
>> >> On Thu, Mar 28, 2024 at 03:34:31PM -0400, Stefan O'Rear wrote:
>> >>> On Thu, Mar 28, 2024, at 8:49 AM, Pu Lehui wrote:
>> >>>> From: Pu Lehui <pulehui@huawei.com>
>> >>>>
>> >>>> This patch relaxes the restrictions on the Zbb instructions. The ha=
rdware
>> >>>> is capable of recognizing the Zbb instructions independently, elimi=
nating
>> >>>> the need for reliance on kernel compile configurations.
>> >>>
>> >>> This doesn't make sense to me.
>> >>=20
>> >> It doesn't make sense to me either. Of course the hardware's capabili=
ty
>> >> to understand an instruction is independent of whether or not a
>> >> toolchain is capable of actually emitting the instruction.
>> >>=20
>> >>> RISCV_ISA_ZBB is defined as:
>> >>>
>> >>>             Adds support to dynamically detect the presence of the Z=
BB
>> >>>             extension (basic bit manipulation) and enable its usage.
>> >>>
>> >>> In other words, RISCV_ISA_ZBB=3Dn should disable everything that att=
empts
>> >>> to detect Zbb at runtime. It is mostly relevant for code size reduct=
ion,
>> >>> which is relevant for BPF since if RISCV_ISA_ZBB=3Dn all rvzbb_enabl=
ed()
>> >>> checks can be constant-folded.
>> >
>> > Thanks for review. My initial thought was the same as yours, but after=
=20
>> > discussions [0] and test verifications, the hardware can indeed=20
>> > recognize the zbb instruction even if the kernel has not enabled=20
>> > CONFIG_RISCV_ISA_ZBB. As Conor mentioned, we are just acting as a JIT =
to=20
>> > emit zbb instruction here. Maybe is_hw_zbb_capable() will be better?
>>=20
>> I still think Lehui's patch is correct; Building a kernel that can boot
>> on multiple platforms (w/ or w/o Zbb support) and not having Zbb insn in
>> the kernel proper, and iff Zbb is available at run-time the BPF JIT will
>> emit Zbb.
>
> This sentence is -ENOPARSE to me, did you accidentally omit some words?
> Additionally he config option has nothing to do with building kernels that
> boot on multiple platforms, it only controls whether optimisations for Zbb
> are built so that if Zbb is detected they can be used.

Ugh, sorry about that! I'm probably confused myself.

>> For these kind of optimizations, (IMO) it's better to let the BPF JIT
>> decide at run-time.
>
> Why is bpf a different case to any other user in this regard?
> I think that the commit message is misleading and needs to be changed,
> because the point "the hardware is capable of recognising the Zbb
> instructions independently..." is completely unrelated to the purpose
> of the config option. Of course the hardware understanding the option
> has nothing to do with kernel configuration. The commit message needs to
> explain why bpf is a special case and is exempt from an=20
>
> I totally understand any point about bpf being different in terms of
> needing toolchain support, but IIRC it was I who pointed out up-thread.
> The part of the conversation that you're replying to here is about the
> semantics of the Kconfig option and the original patch never mentioned
> trying to avoid a dependency on toolchains at all, just kernel
> configurations. The toolchain requirements I don't think are even super
> hard to fulfill either - the last 3 versions of ld and lld all meet the
> criteria.

Thanks for making it more clear, and I agree that the toolchain
requirements are not hard to fulfull.

My view has been that "BPF is like userland", but I realize now that's
odd. Let's make BPF similar to the rest of the RV kernel. If ZBB=3Dn, then
the BPF JIT doesn't know about emitting Zbb.


Bj=C3=B6rn

