Return-Path: <netdev+bounces-230186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FF7BE50F8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE2C19A79E1
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F1229B12;
	Thu, 16 Oct 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sit5thjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046920C00A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639411; cv=none; b=emfbkoI1wSXrWtWIlING4yKAYf3nRAzYOouNLWWv6V2Q7TSQeasBIgfGBHQEjrcHD7/QI/lWFzKK+vVv2Ermh4DQfV6eruKGPzvEO6F+iv0KJ96RkMF3rBY5YI6bV6MIzVofi2PwzEYCjbX6ayiZ4HFwmiHDv6z85DSLxeObW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639411; c=relaxed/simple;
	bh=aoax4UC32EpDmJkajFIfdAiZfcABPRqs395Ltiscm7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOIXSb1sE1YEglsosykFZDsr375UGbAh+Wok9ut6CweZeUN0BNV+Nlz4SasjVHAoJLB82jBH3RL/nX4WCilTxzHVpCrGEtQTNByhnoskkx+kGaW7XBrXAKE2ZShoOoAwEFgGV5V59voc8q9nXUKx1W9eyvzA9VoEkm7qy0EpiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sit5thjS; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e19642764so83732d50.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639409; x=1761244209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzhvXWtbCkYpovjzVNvs150bS4n9HsGkgAH9hJSW7LQ=;
        b=Sit5thjSmO1U4bJ10xzluPT41EwCXW3FGifmljjWGCvwmO8d20N1LxvilKkjzKvsxV
         ahCL+BT7ckaN2izuF6n0dEM38VUgm4cJofMQ3cJL8jXD9jaX5B8zOpIZXlMzGARQM7y1
         iN0skvz3KSm2VGyV6xptwZxfcmABYMjHYNN9IH13OWQuXQ2zs/US6Qz/zo/0b66A7oEk
         gNgETjz+fSjcrbU5Fsa7gBYY8NzsLp/6k2Zf5YpJSiXLmCtbMQqS1RKVUn9xEXIZu1TF
         2X3dHrU+OBv8eYGID3kUBUA8v24HE3pLLWbNYDWWyPKaWHPcePAZKrcfSeElA3avNSdT
         57sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639409; x=1761244209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzhvXWtbCkYpovjzVNvs150bS4n9HsGkgAH9hJSW7LQ=;
        b=MT5Maubwf7LqI+9UhTi0pYzl/7PHBm1kqxdVV+QdLjChKAzJIjZhb8kdHV6fGrj2if
         5TiXN+u542MsiC+kwhYq3lgM2e/TM774s9j/S4Bh2hIru2ZUlk1e10u30Rjana9wHJnw
         /iC08pElHbgltYVsYXl2//0TqBPQHVAQgi3AE/eDBf5W2o4CztO7uOwHpSagWZAQOOS1
         H3i6WJ30KqRk1g0+1cNJPIpa0ogUgVt/Z1P82vJ4fuj37uoPzwEBUX0Hwu7y/vJE9eGB
         nrPSF7ot4TwcUJGaQ5ozBpZo9sHwa5raZmVzv6zvTrN7Yb1BIQlVVXAol3yFg+ISGIkC
         AYmg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Th9LHgRd/U79qYdLjXban54oEVoPjvffTELTey32JSE5ogbBtsD4Cm8JyV2Y2fH90B4tBGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3iWCNZyBbYO7T11yZHnJ3vPWlfV9S3DKYi6dxPPXbSGIHfOu
	3ohZO04wnkSyDNmfXBKWeTGYBJQfD5sD7ytmGt313JbWVClp52ziIOxK0LgSfN0iyKVLEQGLm8x
	ncjRSsjbUG180Qcf+twHgqv6jSZ5B8kc=
X-Gm-Gg: ASbGncvskduzrLI2BOHc/bTQb7/AMzE+VDvGVlfeWCk+zUVuUX8NjJO1Q9tUCbOijBP
	7HziKH91Ysrdp5VNGJpUosRWwtn5TQoMEPUpaYk97E+KNl7VObwrQNyGRakaLfTDNYQYpEzzoPN
	QeH6UUyX9uKolxLCblB6D8XeMDXHgbE316qROfiOCim5U8K+nnIAHf+Bxdrb3LneHXxyc5FfCWo
	iiVqVwGhPtaHLF+tskJRncbqUWWGefy7r9CWkeGY87rdsNettGEVzSA957It0hrIv0QTkrB9+Nr
X-Google-Smtp-Source: AGHT+IH5oYT7ZLsH92Av5P9LlyrU53o8Cq9r2MjhjHiVkdNYfVY0oTjYKYqTmPtuvjEP+G86Xw9uVl7UKdVpAB7E6/4=
X-Received: by 2002:a53:5009:0:b0:63c:f5a7:3cc with SMTP id
 956f58d0204a3-63e161c6038mr864495d50.56.1760639408856; Thu, 16 Oct 2025
 11:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-2-ameryhung@gmail.com>
 <CAEf4Bzaqw2N58jCiApr6awfpub_8W6cTJMWuY75VpCCLMLjQBw@mail.gmail.com>
In-Reply-To: <CAEf4Bzaqw2N58jCiApr6awfpub_8W6cTJMWuY75VpCCLMLjQBw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 Oct 2025 11:29:57 -0700
X-Gm-Features: AS18NWCyZNZY1peWt4dmB31LMm4bdohA-ZAwwaH9Ng3BNMDyLMDDRgFLI7uyxQI
Message-ID: <CAMB2axOQqgpiUTb-33uOgYar48PM=DTeOFAZY3P3FYk16Dy33Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 1/4] bpf: Allow verifier to fixup kernel
 module kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:11=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > Allow verifier to fixup kfuncs in kernel module to support kfuncs with
> > __prog arguments. Currently, special kfuncs and kfuncs with __prog
> > arguments are kernel kfuncs. As there is no safety reason that prevents
> > a kernel module kfunc from accessing prog->aux, allow it by removing th=
e
> > kernel BTF check.
>
> I'd just clarify that this should be fine and shouldn't confuse all
> those desc->func_id comparisons because BTF IDs in module BTF are
> always greater than any of vmlinux BTF ID due to split BTF setup.

Got it. I will make the commit message less confusing.

>
>
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e892df386eed..d5f1046d08b7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21889,8 +21889,7 @@ static int fixup_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >
> >         if (!bpf_jit_supports_far_kfunc_call())
> >                 insn->imm =3D BPF_CALL_IMM(desc->addr);
> > -       if (insn->off)
> > -               return 0;
> > +
> >         if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl=
] ||
> >             desc->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_n=
ew_impl]) {
> >                 struct btf_struct_meta *kptr_struct_meta =3D env->insn_=
aux_data[insn_idx].kptr_struct_meta;
> > --
> > 2.47.3
> >

