Return-Path: <netdev+bounces-246286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C9CE817E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A2D13014A04
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29BB25B662;
	Mon, 29 Dec 2025 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYThaZjB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993023A984
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767038289; cv=none; b=Za8JlNf39Dlg684RQNAp30n0hlqflQiS5HsfiMo6ijjlPnXGJpnT0YzPWwiNJlHghhVcNzv/C95WL2NzpEAEg35mRYGAkASNO+avuabJZ4leP3Sv5DKPmOS4Zfwf0Nf9HopUvKnRz34HHLbx25dPKpCKGKx5hYMuvdE/eCQICjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767038289; c=relaxed/simple;
	bh=ILOnzjB6omPzsTjFaR5p7kIAmLgY60kDToG8kB6uAvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwWK/EbM2zo1gcpaTyth5PCPS2k5aSN5/NqgMwWCgfWBlFeG8ikHhpcJevCfogbO+rdX/DWFCLbBZg/IlsvAWNmy3l5RsGxD+wnvgqHpdGAmTfh5/8DBZghXE8JICg6EFUBX6wlonnGS95yjredbJQcKVqzeGFcS9M/W2r7JqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYThaZjB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-803474aaa8bso3236519b3a.0
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 11:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767038286; x=1767643086; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xko4XQ8K4/4/p+5qf10V0z8LE3R9sFv1la/WwKpKg8w=;
        b=ZYThaZjBxgHPLg/ru2oZZkkkGV9I+IQ40v7BeSRjUsjFg8NWfReiJwLQlrKmnUqHLA
         rvkVXYMB6uxFjEseJU4LblqV3xz3tL12y51GumsjIc6cyS6zleoKH96pr/Tu3MCKuh6z
         1dkPwxdpY+D6+VQ7nF03YfwSISSL9p0H/3y7TtvjKIMmnjgr5ZS7B38Ulg/fPpmOCF/C
         mzs007TEjxUXjZWR40SZsreLbn7Jhf2pb0ZW/kFXs1QmTYbCo3paFgYLhanP+ceAWCdo
         Ud7A7P4dtNPgw8WyCtxZZmpBMyv54oRfhGuAZ+FKsKVJkhdrbHIGLMTgVMUxRxwk+/qG
         7PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767038286; x=1767643086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xko4XQ8K4/4/p+5qf10V0z8LE3R9sFv1la/WwKpKg8w=;
        b=wdz7uhjfsJ5wrwD1eO7YvJs26ACZWt/EQvPexlD0NeEkX0OoPx5PzZe4qbwntsKfJT
         i9Kg1Ok0pc/5zWFbILl1B2U8NZSOHdJWprfHkvXLqzJKSPZz0PfjibPkTxZsBQYOa5D1
         KwsbTFyvOfPK7k0U/8McZtvGMEsMXIjXUrHtF+oKggEHTZHSAmPbp/P+x1WqGh0HR0sM
         57AzKDoOoQ7z5CiHNmJpCeSzUmQNjqXUd6D0pKwl+b/CBqiVR2Bk1w61F7+KkyX2M8hy
         6q9QVlBvaTTY+dZ/In/++yFuDAZwfICnfDCiYGxeIKDtCWh76e1dNRH8lBQSpTHWDIjy
         +jbg==
X-Forwarded-Encrypted: i=1; AJvYcCVRpTImV/0nvzPvj+arAuz8TJy4rgma4N+8jT+3uAyKNY2wp1NJVXWcqJNIDFX2VApr5Skm3GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPTvkzLJHXoKMikEIrMEpKvC7qQqCZ8agh4mGID3DVx7wbYTQ
	L/U0+hC0Tp2nTdhnRfwl7/Qeh9rkslsID+D+WbPX+CC3WsbC+5MqzlWh
X-Gm-Gg: AY/fxX6iWYw6TDo/e+jfM2qLPpK5l/mvvPM77XFj9or1JkvqdaTVv8XRl/tJ1ZI28ba
	oFunmhX4MWts36nnbxpQLqkFSjXTBcawLWS7oex+RR2IK99l88AkqmPLgnasOgU+o6/VsXXbyTw
	CAplTJr6DjDnngTmkzVlRfWiPPgNwwIuLy+01UO8VuKkQyJrBgmJTDzx8omH0SGyC7OmvKzDu9C
	soKvibkhLswNvSEzEdTRYZFCDXDnoBdP/zOuHvxTpRKLQKMxOaUnNwUDPqEeOZbIhBhOPlPtRMO
	IW6Syar/QN8bSTI61+Y4wTmnZ0zAh+owCKZ7/873Gw9SzmybmjqWsXMZeaNBERJYWM4BmusP5on
	A61qKLn3dc1FHLjlEJJSnooOQ9FwuRS8zqm2yrZiYHZmJnoaGu3Hk+VtZDVX8H8gbm2jtgC83wY
	7fVOmzfuLiK8j8qOtiEk4npGCtj4zaautV8X1rbY6Q9fXetoY=
X-Google-Smtp-Source: AGHT+IFClYfhXcvzYGUEAeGNRFFMkUwqOYUjfX2LyOlUE6PEoi9FZ13hia7PJghTWywP+YG21UqZAQ==
X-Received: by 2002:a05:6a20:7f81:b0:366:14b0:4b1c with SMTP id adf61e73a8af0-3769ff1c33fmr28383151637.39.1767038286311;
        Mon, 29 Dec 2025 11:58:06 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac6b:d5ad:83fe:6cca? ([2620:10d:c090:500::2:1bc9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm30215140b3a.32.2025.12.29.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 11:58:06 -0800 (PST)
Message-ID: <0f0bd124a42723acf87b427cc69356a0e4b1e339.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x86: inline bpf_get_current_task() for
 x86_64
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, 	dave.hansen@linux.intel.com,
 jiang.biao@linux.dev, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Dec 2025 11:58:03 -0800
In-Reply-To: <20251225104459.204104-1-dongml2@chinatelecom.cn>
References: <20251225104459.204104-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-25 at 18:44 +0800, Menglong Dong wrote:
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance. The instruction we use here is:
>=20
>   65 48 8B 04 25 [offset] // mov rax, gs:[offset]
>=20
> Not sure if there is any side effect here.
>=20
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---

The change makes sense to me.
Could you please address the compilation error reported by kernel test robo=
t?
Could you please also add a tests case using __jited annotation like
in verifier_ldsx.c?

>  arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b69dc7194e2c..7f38481816f0 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,19 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>  	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
> =20
> +static void emit_ldx_percpu_r0(u8 **pprog, const void __percpu *ptr)
> +{
> +	u8 *prog =3D *pprog;
> +
> +	/* mov rax, gs:[offset] */
> +	EMIT2(0x65, 0x48);
> +	EMIT2(0x8B, 0x04);
> +	EMIT1(0x25);
> +	EMIT((u32)(unsigned long)ptr, 4);
> +
> +	*pprog =3D prog;
> +}
> +
>  static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
>  			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
>  {
> @@ -2435,6 +2448,15 @@ st:			if (is_imm8(insn->off))
>  		case BPF_JMP | BPF_CALL: {
>  			u8 *ip =3D image + addrs[i - 1];
> =20
> +			if (insn->src_reg =3D=3D 0 && (insn->imm =3D=3D BPF_FUNC_get_current_=
task ||
> +						   insn->imm =3D=3D BPF_FUNC_get_current_task_btf)) {
> +				if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
> +					emit_ldx_percpu_r0(&prog, &const_current_task);
> +				else
> +					emit_ldx_percpu_r0(&prog, &current_task);

Nit: arch/x86/include/asm/current.h says that current_task and const_curren=
t_task are aliases.
     In that case, why would we need two branches here?

> +				break;
> +			}
> +
>  			func =3D (u8 *) __bpf_call_base + imm32;
>  			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
>  				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> @@ -4067,3 +4089,14 @@ bool bpf_jit_supports_timed_may_goto(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +	switch (imm) {
> +	case BPF_FUNC_get_current_task:
> +	case BPF_FUNC_get_current_task_btf:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

