Return-Path: <netdev+bounces-249652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6CBD1BE86
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0CB3300502A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE5F293B75;
	Wed, 14 Jan 2026 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj5mNH6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2329CE1
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353809; cv=none; b=CXuIHBAm85koZOvYxemi2ZZNJV9g0nnBiI1XaodCf2u4y4Huwyysys2Ydcx7DJSO5j30HA08hSU5I5ox0HPXeqVGIkw0yRJWB4F9srbasDEOTMZ2VtHxn4eY1Dppo+rA7vIybCbRKQYdAyjPWCAJ4FRIfyduz0UAaJ23OTosJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353809; c=relaxed/simple;
	bh=BPEgdSuvRF+erH8m711sFBEbnaKvRJS6o7epx3/2Bws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucxQ1EbtNaytjjTTDPICoV8gGFmmIJ3qM69QpT/5Fo3JZ+JYVYbBkGgqlEeSc3hqHJ/oov1F7q8IVbyY2MJvv0U56yerKkv3aeB31In/rQj6PM1nrFSJvLqcIGFHs/TJV2PyAYjD35pqjfJ3dgYHmM/kxCs1Q7ey3zbf57Afh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj5mNH6p; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8707005183so493029866b.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353806; x=1768958606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySZo9X0F3xYRmIrq5C0GOed6pua2kD4ROq4em9TrfAQ=;
        b=Yj5mNH6pIp1Laal11+E5ebC95KTRtQVe485I7+g6e36wZdgaa1KeZVByYADm9m1Puv
         A/yD9KSS51OBmHgrPkB8C6li4FnufjVlrZKkYX+StePRrKWsj7rJ1wWQtkPoWCdxYIV2
         v++qapSixl0hW9DUEKDHjg5OR8XBZkexYDhh2KfU3QSRjksClK6437LQXBQQGNPtjXbv
         4kO2TSUMeNOp5UcOtJz3yxv/NnLq7yd1kr23okllibEZZhfjnqlm0b+dcH3tnmKkHh6M
         LuS1cdKbhOccXj9Y/VnLdx7w6R5M2Rfqxp1HbKJdI3ozy1nmJKXeT/cEzs1Z6KwK9eKT
         i6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353806; x=1768958606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySZo9X0F3xYRmIrq5C0GOed6pua2kD4ROq4em9TrfAQ=;
        b=iPvwbkl4JA8aXvZHyBByhr+Z4YPAJu/e/JpJDMgC//D2Jy8zU12Ia7Qi+N4T7u3TG8
         GBt0+DODR4PP2X/BxHEMHtcBBrnVDQsJAAMnsKFxxo/nbJ6nhJ2Bj/KavifVYoRWQsxv
         UhAjVJvMWk/hIy+qg+hN4oV7SFphF/ZKbeq87R52BMncAHK6O7FU86u13QpGfFUthKvf
         aX8RsJbeN3HuA7j3u6upXnT/tMRrA7xgZR0VIcFdgaCPII7UwJ66RVWN0jYG5D68Gesk
         Eaa8zXJjAnIQnT8nULiqiq8ncTmMfAM1EuSGTjrCXD/ZWMR+EIHVeEAwNRGSlq9U+1Lc
         2CRA==
X-Forwarded-Encrypted: i=1; AJvYcCVuHN0yXxX86V41y/eLN8opy/20of3rcNt30VjMHa26LolG3/84XKes3/PSl9ViPatI3VLPsgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkM9cQWbuJalFBMC6PvGDcWnf03oFgEtehi7u9yzmeBHGemHHO
	uKC6SNkBWPmmnglwBkTcoNmyqDhrR+B11tVSmh6SsrQzM2C77GzagBhIGp1uarf2d/6U5KhTsvK
	8l03TDo65B5QDFxrWTyMtn4zKHXrLNxg=
X-Gm-Gg: AY/fxX6yyWwGZVXvr/QOYh23L5DTay++j074M8tCKSQvKEWUPW7zfQs00tcKdCD8ij7
	bISXo5Ie7JPeH757ay6iTzOzgRyPytFuW4COSAJ3CBQN6d+BQOXylIkRODQUkKjMQr97TXx4r7q
	KF3nyzKJjjDBf48XmXq9p2LJ3U7odFAWqTQnkmn9H9EouDo4560yribH96Nfg9xQ8NtO9IUDKfv
	YGW1ezoLt+mTMudSAhU+qcjh+0L2QpWpbdnRQBQOcZMbM5bvK8MExHd9R7FnVT/DTJPQi4vl7Zn
	ddoKx27Q4k0=
X-Received: by 2002:a17:907:3e0b:b0:b73:5e4d:fac4 with SMTP id
 a640c23a62f3a-b8760fdf7fdmr80293166b.7.1768353805902; Tue, 13 Jan 2026
 17:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-5-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-5-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:51 -0800
X-Gm-Features: AZwV_QgffzPSmZx8aCI6mvLKKfc5LGAU-7wrYvZFbwKkp3bhvag_OMQ2cEC60T0
Message-ID: <CAEf4BzZBhGfWN3t0_u-1GrOxtjoJUhMk+NqAaZFnFpgB4QskHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/11] bpf: support fsession for bpf_session_is_return
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> If fsession exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN) in
> ctx[-1] to store the "is_return" flag.
>
> The logic of bpf_session_is_return() for fsession is implemented in the
> verifier by inline following code:
>
>   bool bpf_session_is_return(void *ctx)
>   {
>       return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));

this look unnecessarily scary :) !! part is unnecessary because
non-zero integer will be converted to proper true(1)/false(0) by
compiler. But I'd just rewrite it in arguably slightly simpler form
that lays itself to assembly more directly:

return ((u64 *)ctx[-1] >> BPF_TRAMP_M_IS_RETURN) & 1;

>   }
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v9:
> - remove the definition of bpf_fsession_is_return()
>
> v7:
> - reuse the kfunc bpf_session_is_return() instead of introduce new kfunc
>
> v4:
> - split out the bpf_fsession_cookie() to another patch
>
> v3:
> - merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
>   patch
>
> v2:
> - store the session flags after return value, instead of before nr_args
> - inline the bpf_tracing_is_exit, as Jiri suggested
> ---
>  include/linux/bpf.h      |  3 +++
>  kernel/bpf/verifier.c    | 15 ++++++++++++++-
>  kernel/trace/bpf_trace.c | 28 +++++++++++++++++-----------
>  3 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 41228b0add52..2640ec2157e1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1229,6 +1229,9 @@ enum {
>  #endif
>  };
>
> +#define BPF_TRAMP_M_NR_ARGS    0
> +#define BPF_TRAMP_M_IS_RETURN  8

nit: What does "M" stand for? Macro? Mask? Menglong? ;) Some new
convention, why?

> +
>  struct bpf_tramp_links {
>         struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
>         int nr_links;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bfff3f84fd91..1b0292a03186 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12374,6 +12374,7 @@ enum special_kfunc_type {
>         KF_bpf_arena_alloc_pages,
>         KF_bpf_arena_free_pages,
>         KF_bpf_arena_reserve_pages,
> +       KF_bpf_session_is_return,
>  };
>
>  BTF_ID_LIST(special_kfunc_list)
> @@ -12451,6 +12452,7 @@ BTF_ID(func, bpf_task_work_schedule_resume_impl)
>  BTF_ID(func, bpf_arena_alloc_pages)
>  BTF_ID(func, bpf_arena_free_pages)
>  BTF_ID(func, bpf_arena_reserve_pages)
> +BTF_ID(func, bpf_session_is_return)
>
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
> @@ -12505,7 +12507,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
>         struct bpf_reg_state *reg =3D &regs[regno];
>         bool arg_mem_size =3D false;
>
> -       if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_c=
tx])
> +       if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_c=
tx] ||
> +           meta->func_id =3D=3D special_kfunc_list[KF_bpf_session_is_ret=
urn])
>                 return KF_ARG_PTR_TO_CTX;
>
>         if (argno + 1 < nargs &&
> @@ -22558,6 +22561,16 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                    desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_=
cast]) {
>                 insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>                 *cnt =3D 1;
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_session=
_is_return] &&
> +                  env->prog->expected_attach_type =3D=3D BPF_TRACE_FSESS=
ION) {
> +               /* implement and inline the bpf_session_is_return() for

nit: comment style

> +                * fsession, and the logic is:
> +                *   return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RE=
TURN))
> +                */
> +               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,=
 -8);
> +               insn_buf[1] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRA=
MP_M_IS_RETURN);
> +               insn_buf[2] =3D BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);

lol, your assembly is simpler than that C expression above, let's keep
C close to what you actually are doing in assembler

> +               *cnt =3D 3;
>         }
>
>         if (env->insn_aux_data[insn_idx].arg_prog) {
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 297dcafb2c55..1fe508d451b7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3334,34 +3334,40 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
>
>  __bpf_kfunc_end_defs();
>
> -BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
> +BTF_KFUNCS_START(session_kfunc_set_ids)
>  BTF_ID_FLAGS(func, bpf_session_is_return)
>  BTF_ID_FLAGS(func, bpf_session_cookie)
> -BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
> +BTF_KFUNCS_END(session_kfunc_set_ids)
>
> -static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfun=
c_id)
> +static int bpf_session_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
> -       if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
> +       if (!btf_id_set8_contains(&session_kfunc_set_ids, kfunc_id))
>                 return 0;
>
> -       if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
> +       if (!is_kprobe_session(prog) && !is_uprobe_session(prog) &&
> +           prog->expected_attach_type !=3D BPF_TRACE_FSESSION)

check both expected_attach_type *and* prog_type, please (and I think
it would be good to check prog type for kprobe_session and
uprobe_session as well, because now it's not guaranteed that program
will be of BPF_PROG_TYPE_KPROBE


>                 return -EACCES;
>
>         return 0;
>  }
>
> -static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set =3D {
> +static const struct btf_kfunc_id_set bpf_session_kfunc_set =3D {
>         .owner =3D THIS_MODULE,
> -       .set =3D &kprobe_multi_kfunc_set_ids,
> -       .filter =3D bpf_kprobe_multi_filter,
> +       .set =3D &session_kfunc_set_ids,
> +       .filter =3D bpf_session_filter,
>  };
>
> -static int __init bpf_kprobe_multi_kfuncs_init(void)
> +static int __init bpf_trace_kfuncs_init(void)
>  {
> -       return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprob=
e_multi_kfunc_set);
> +       int err =3D 0;
> +
> +       err =3D err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &b=
pf_session_kfunc_set);
> +       err =3D err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &=
bpf_session_kfunc_set);
> +
> +       return err;
>  }
>
> -late_initcall(bpf_kprobe_multi_kfuncs_init);
> +late_initcall(bpf_trace_kfuncs_init);
>
>  typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct ta=
sk_struct *tsk);
>
> --
> 2.52.0
>

