Return-Path: <netdev+bounces-228996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C623BD6D80
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CFE4042C8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F422615;
	Tue, 14 Oct 2025 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsQLX4tG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E11A26B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400666; cv=none; b=sQKMCjrc2Fa2PwvafznTFDqLo6SVyt5/LZvXNY0fE/HI9HKxpX+4BxFEAHXGR+qINg8UeH3dhLP4aHkQEsgCzwt1/pJa3OFHcTm7/rzp4Wriic/nmlQnjz7FtSz22CBcBI/P7EiKG6rTIZGIHSnuxv217wgGhEdhZ87z4GZJyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400666; c=relaxed/simple;
	bh=PmJmwnxzQbiXdVq7YPn+LyjsMeAreUe9WlflIcSK7WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itEs9NmzQJYrud3JvnPKgpkSJzaxvV6oXNHOR+AUFFM3WIjYDYvp8lPQMt4l+8+ljRdQ8NIWZ9ZaMIkgJ/Es2/SJS7t/RQt4KiKj52NhhIkKV5mLPRI9NkI363YWmbd1x1ardeV0bBrDbHKLzihnnZolP3SJBNz9mKd6FskQp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsQLX4tG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33067909400so3505921a91.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 17:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400664; x=1761005464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUoHlBrtr6CHTQT/miISpVT7kYYDapO491CV2JbqrHM=;
        b=YsQLX4tGlniZlRP9yWzrLDhdqWj9Ff5oOQrAeRH0jOWar4GqLbxRNoXQVT58TH9xEf
         ovGQt9poJIjLv25Wh/rprG/tUQzskOTV/QyEFAoU2pHSaMIkQd7Q+lniuoTeSznP6ED5
         ZYSQ0W0GL2C9Qzcdr4zu5ahowbs/14U/FABzRNydmS3CyC+hSSFWlo9aY8z6vO7EVwwA
         0tzj34hMAbbgg1H/ymYE1vURObO/HmTnn6012knyk4q872+D430b/xmbaGWvoJs/CJj0
         AsUdxrUMlwDTOZqUJr8KHq3y6n0JLl5hzD4fKrnA8t22mI8fw24oiLycXN1U9QRRG/Sb
         KHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400664; x=1761005464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUoHlBrtr6CHTQT/miISpVT7kYYDapO491CV2JbqrHM=;
        b=fHtgsMe8Z0Pa8nbmJiQZ1AjAAYY/XeAzlPISTIIckx3bdbQC9BqjbCFECJyLcLm3z6
         eM8nxOzqFUkPaZaPRbyeNBX2VFnDjf42Pn6vUEkh3DsaCPiFVUnGR2AmyAQxxEVjc5vX
         q2omU3yS7/AYTP5k7EJJFblqrvaXX7vZggzRjZg6InMC5f5wAeTQy1C4fgbPKy56cLdW
         f6ikZ80J133kgRc4/mK0NOferPw7W+RnhBNycV2eyHIRfZYz8Js0QpOxBiuvfJF7wuUD
         673IzNyX6Htkwo/+bos0FEKDxmnJqAnG6fWnjCTsMmY2zXeI6CH2xNZOJ8q9yCiqLucu
         dyOw==
X-Forwarded-Encrypted: i=1; AJvYcCXFctcgmdPcTWYIX9raRwwKlNrQKzMJSAevQz6ass1kiRWcCF2S1VmR3AnN96Kz7C4dsix7TIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQJJAlWXGVY5ZskcGpoLLQUt3SX8JFZCNl0+IE6oot4zcR2fo
	HkSmeg/XUkxxoxGJP9OgbRjoQCLmmX5kCEo1h8ntaAxtuDXHom7YORVVpfukiV/f5W7TXK89Qsj
	N9535VCDZqF9BrSb+XHUkY3LLRUJhPwRnVw==
X-Gm-Gg: ASbGncuOGdkoHrHHDEns1AKv4Lf1aAp0W/Js7vkRM0/dvL3seAUdYHRDzWFD61MvoI6
	PzQaSqZBIvdrvSXQgsTS4SX2IAmx8m0Z56rjQ29ixwckk7mhzTXk+kxEWPruy9ClSAuoF7Bjx/b
	s2qq2KAmvM2D9axMSl9QeRvjfQedrNaySYBMEXgRBv1FFMVAHY5sj34FYFtGalJAuyE7/9vXvN1
	Ail0+l5k5QAfKxShfdfYmK/UC45i7PP+e9vkZI0jA==
X-Google-Smtp-Source: AGHT+IG7tjm/UVzlDeCLVcdxN8Dx9aB/YxtYqhwqnA6LojzbBF/WPp0andbmQnhQ7blP7XJdl0pSI7oF+qa5n46wCLs=
X-Received: by 2002:a17:90b:4990:b0:338:3b73:39ce with SMTP id
 98e67ed59e1d1-33b5138e3a7mr30543519a91.25.1760400664111; Mon, 13 Oct 2025
 17:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-2-ameryhung@gmail.com>
In-Reply-To: <20251010174953.2884682-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 17:10:30 -0700
X-Gm-Features: AS18NWCacFMkX4SFcVRfh02uzNmUrvCIqHbTtFb96eJqekyjz_BKBYhnvGI98HM
Message-ID: <CAEf4Bzaqw2N58jCiApr6awfpub_8W6cTJMWuY75VpCCLMLjQBw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 1/4] bpf: Allow verifier to fixup kernel
 module kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> Allow verifier to fixup kfuncs in kernel module to support kfuncs with
> __prog arguments. Currently, special kfuncs and kfuncs with __prog
> arguments are kernel kfuncs. As there is no safety reason that prevents
> a kernel module kfunc from accessing prog->aux, allow it by removing the
> kernel BTF check.

I'd just clarify that this should be fine and shouldn't confuse all
those desc->func_id comparisons because BTF IDs in module BTF are
always greater than any of vmlinux BTF ID due to split BTF setup.


>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e892df386eed..d5f1046d08b7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21889,8 +21889,7 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>
>         if (!bpf_jit_supports_far_kfunc_call())
>                 insn->imm =3D BPF_CALL_IMM(desc->addr);
> -       if (insn->off)
> -               return 0;
> +
>         if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] =
||
>             desc->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new=
_impl]) {
>                 struct btf_struct_meta *kptr_struct_meta =3D env->insn_au=
x_data[insn_idx].kptr_struct_meta;
> --
> 2.47.3
>

