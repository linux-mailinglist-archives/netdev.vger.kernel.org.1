Return-Path: <netdev+bounces-84064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C58895674
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA03282D48
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606186151;
	Tue,  2 Apr 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfVAw2iR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC886146;
	Tue,  2 Apr 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067486; cv=none; b=dE9zQOaLyxbcYZ1m4bpk4R7A+VZGCSxu4m3Q46l4YzckkLOSW3AF927cdhFJTbMCA3vXTIDmwcurRGzeeR3TBTxHq4TwP6jaxEAhaZKTTF38j20o4KIb188SiKmwEfXDqqkVPU/OOJOETsWLfYh6TAnEf/q08exkPLfY2mz328A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067486; c=relaxed/simple;
	bh=JXeMgDJf7NztdBYQwze7zpUZgNxk5FTdMBjGNHLcJyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B2Iuy2UTt3mMaFwLQv+JXSZ5YylfzILugMpDuV2OzFnoKSBQNypK2WEt79kmHVitn/x4shutQw6GZKMM+31L17KW7FqrIhd3JlSwRvM/ixgseWWrXEm/CXOC3/Bfj81M4BJyaHu6Y4RyWlx08yZr7yRFwnfQnJg+DzmiEuJgPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfVAw2iR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FA2C433F1;
	Tue,  2 Apr 2024 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712067485;
	bh=JXeMgDJf7NztdBYQwze7zpUZgNxk5FTdMBjGNHLcJyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dfVAw2iRAvypeK/Zlw38Hf7kCcsuNwEhmQfBge96A/7PycL6UubyOuVvmKNRhslrZ
	 oNMfs3i2an13hurYmIouOhXwU0P7YwaKep4CpvN9DQOtyYOXS6BZSwcsdI9SEJ6VzA
	 J5WhBcosWO0m1/FPgwgQ4g5iwFvLaNkajPW7lBdqd+N+nu7hvFWMhPYBJZUM3RJ4KD
	 9LXtsG9PhmP3zt1699OP/kxI+DGr59xUutBN6wJ6BNEDepT71pRFxMer7JyIZ/6vZh
	 x0xWH8Nlw7f36+WcOiVt+7thgJjsCnDL3yrWnwaFMwUp/OxG3rfLNZe8aYzDY/t9pi
	 LsntEkP/9ghMg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>
Cc: Stefan O'Rear <sorear@fastmail.com>, Pu Lehui <pulehui@huaweicloud.com>,
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
In-Reply-To: <20240329-linguini-uncured-380cb4cff61c@wendy>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
 <20240328-ferocity-repose-c554f75a676c@spud>
 <20240329-linguini-uncured-380cb4cff61c@wendy>
Date: Tue, 02 Apr 2024 16:18:02 +0200
Message-ID: <87il0zrgpx.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor.dooley@microchip.com> writes:

> On Thu, Mar 28, 2024 at 10:07:23PM +0000, Conor Dooley wrote:
>
>> As I said on IRC to you earlier, I think the Kconfig options here are in
>> need of a bit of a spring cleaning - they should be modified to explain
>> their individual purposes, be that enabling optimisations in the kernel
>> or being required for userspace. I'll try to send a patch for that if
>> I remember tomorrow.
>
> Something like this:
>
> -- >8 --
> commit 5125504beaedd669b082bf74b02003a77360670f
> Author: Conor Dooley <conor.dooley@microchip.com>
> Date:   Fri Mar 29 11:13:22 2024 +0000
>
>     RISC-V: clarify what some RISCV_ISA* config options do
>=20=20=20=20=20
>     During some discussion on IRC yesterday and on Pu's bpf patch [1]
>     I noticed that these RISCV_ISA* Kconfig options are not really clear
>     about their implications. Many of these options have no impact on what
>     userspace is allowed to do, for example an application can use Zbb
>     regardless of whether or not the kernel does. Change the help text to
>     try and clarify whether or not an option affects just the kernel, or
>     also userspace. None of these options actually control whether or not=
 an
>     extension is detected dynamically as that's done regardless of Kconfig
>     options, so drop any text that implies the option is required for
>     dynamic detection, rewording them as "do x when y is detected".
>=20=20=20=20=20
>     Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c5=
54f75a676c@spud/ [1]
>     Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>     ---
>     I did this based on top of Samuel's changes dropping the MMU
>     requurements just in case, but I don't think there's a conflict:
>     https://lore.kernel.org/linux-riscv/20240227003630.3634533-4-samuel.h=
olland@sifive.com/
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d8a777f59402..f327a8ac648f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -501,8 +501,8 @@ config RISCV_ISA_SVNAPOT
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
> -	  time and enable its usage.
> +	  Add support for the Svnapot ISA-extension when it is detected by
> +	  the kernel at boot.
>=20=20
>  	  The Svnapot extension is used to mark contiguous PTEs as a range
>  	  of contiguous virtual-to-physical translations for a naturally
> @@ -520,9 +520,9 @@ config RISCV_ISA_SVPBMT
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	   Adds support to dynamically detect the presence of the Svpbmt
> -	   ISA-extension (Supervisor-mode: page-based memory types) and
> -	   enable its usage.
> +	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> +	   page-based memory types) when it is detected by the kernel at
> +	   boot.
>=20=20
>  	   The memory type for a page contains a combination of attributes
>  	   that indicate the cacheability, idempotency, and ordering
> @@ -541,14 +541,15 @@ config TOOLCHAIN_HAS_V
>  	depends on AS_HAS_OPTION_ARCH
>=20=20
>  config RISCV_ISA_V
> -	bool "VECTOR extension support"
> +	bool "Vector extension support"
>  	depends on TOOLCHAIN_HAS_V
>  	depends on FPU
>  	select DYNAMIC_SIGFRAME
>  	default y
>  	help
>  	  Say N here if you want to disable all vector related procedure
> -	  in the kernel.
> +	  in the kernel. Without this option enabled, neither the kernel nor
> +	  userspace may use vector.
>=20=20
>  	  If you don't know what to do here, say Y.
>=20=20
> @@ -606,8 +607,8 @@ config RISCV_ISA_ZBB
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	   Adds support to dynamically detect the presence of the ZBB
> -	   extension (basic bit manipulation) and enable its usage.
> +	   Add support for enabling optimisations in the kernel when the

I don't care much, but "optimizations" here -- for consistency reasons!
[1] ;-)

Nice change!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

[1] https://lwn.net/Articles/636286/

