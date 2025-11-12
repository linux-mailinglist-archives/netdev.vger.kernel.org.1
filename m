Return-Path: <netdev+bounces-238120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD02C544FE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A17C84E9BFB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9692BE7B4;
	Wed, 12 Nov 2025 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRlq5pbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7929C33D
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977101; cv=none; b=UihzU9yG9kM9VXEZJ5Ss49VXEbLxt9ugESt8zFq7b6z1lknRLUnM17kQDz6GuedfOsiPD1wM/WqHwxkqR3PUq44f22kpcV7RSj4gKSgjdMh4Fy8i8NU9twV93lvWTcc1mvv+D7nScCmNP2QMEH+xJyay5Qk8UlJ2mSZZ0WEubw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977101; c=relaxed/simple;
	bh=V7wPAPhq8x5M4/YATnSSgKnLhUMD6c5KAFlBJaCrEcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k50JnU4rltupVXbErRWbIxZU+eqTAFSug9s09O+lIyBs0Y5DzNtld/JtHeKqzXMmxxMv6wcFrkuUIqr1hVEpARovfnLAM3oXI1aW8vqpmBduQbauSAZ1QB+0LkhCMjuqlIZM8SLQdHvuToyyl3mgZtrv95AvzUa0RpJJMJHPsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRlq5pbU; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640daf41b19so107501d50.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762977099; x=1763581899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJYfN17bLgWls35SPZiZd6WIyEOIlB4gSdWvVkAzlr0=;
        b=IRlq5pbUznrI3p0eO6q0knA44P/+AiWMoaGFlQwG+SrkMrzBz3TOYyDWfeK6TY3ut/
         iN41IlYjjTWA7K6O1KI3XhyjYmM1bLWLj1mm8mmclKXjxoow1CD78Ac/D8z11bgJOPYt
         dZdWdQ2TwmULfBBzPBMia3VURW1JFUdVMl+3yCfQLVKazdphw4W7tNodJ4syfGvB6Q0C
         rn8ch8f9tHSJ7f3m7YZeVfcDrumeap4Kzc5J+o+kHjuS9tK+m8yp4M34xEqn8rhsjioI
         3d8QDVGWQkSD7V2bU77zKFQ1sOGZMkHft7p91BjiaUsPxmcHGArZwTnQunA7lseKwbKE
         oSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977099; x=1763581899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJYfN17bLgWls35SPZiZd6WIyEOIlB4gSdWvVkAzlr0=;
        b=vN6Zf3EXCxBT++mm6hlQlqjqk5FoxKwHEZKKxxNqVD7hdzOlY4IkrbLTnEluKAysJl
         oDxdQ94fuoS+5AmqcTjhGY6NKj93iHGaoMbl3Fv1lb9xixgHoCPOKPM8voPjE/+afosW
         Mx9KdkblPsbrK6AxUuS778FrOXoSGsTKmgFvbPM+N+pgihI38qOEaEoVYmaF98QQ60Z4
         mmRRrNOkgf05GNN+Qp/1ydF81Qs+VTeeBuuOM/Ky9EPnWuga6ZMJ6ezY+23GhlkvRmtf
         tXGhKE7cT/S5ZsiUCFkyszIBJ9EqCLcAuqjN4ySDqrE/tp6baYM4P1EstgqwD1N1O8g0
         g3EA==
X-Forwarded-Encrypted: i=1; AJvYcCXp+GgA0E2OCQyEk6s7Ixh2phdKbJv4LxNJEQ1/CFtxsk8ZChtgkY28VaEsys9Ar5OnPPoQBLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuvrYE6PDNSVbIiU92/TJ9pbufy4vjtWCd9JVeaEIMbK1yvlvG
	aXWNllTMbr1VTp6MNj/Q2tdi84zqWlEkLqnElD0Mgz2kLEZOX0XgJIvqeDqj1AAqobyJn+9JmOc
	3UX/aTtGwU2PpftfccEDZAEr+6z6fSus=
X-Gm-Gg: ASbGncvswTfcL8FXfFFvWAe9K1DiFIZlic+IBiB3PRAetB+uhSwanCVa3TTOXvnShhL
	WMK2+xG9rK9MJkpZom2DbX72w9J5RolHaaJGBYCiMBMpSJ/99GIVoJepCqbWNkgMDIvIq8TMbd5
	DboVD3DV4HS3/hCOeyYWLJ/774Y3mp3k6PYke/VCXDDy2YFMlyqQ8EPdFaEMM/IGQzh/akdp0I+
	FsmML3rQo8rTvxa+jLMuI77fLI1a21JwKqJa0gDXfrE10VE6dtDDhoTszxY
X-Google-Smtp-Source: AGHT+IHDvGelbxCEpK08X9r207VkXnI6e8GlcXrImEfkUYHEMat+XgVVkEQp76J/ax+q5wAadKI+yMtJcBgjHF3gClc=
X-Received: by 2002:a05:690e:1188:b0:63f:ac46:65d8 with SMTP id
 956f58d0204a3-6410d06e1b5mr538850d50.3.1762977098680; Wed, 12 Nov 2025
 11:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112175939.2365295-1-ameryhung@gmail.com> <20251112175939.2365295-3-ameryhung@gmail.com>
 <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com>
In-Reply-To: <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 12 Nov 2025 11:51:28 -0800
X-Gm-Features: AWmQ_bkgyQAPwH2MCTZ9FGX8d6QE2vx9BF5-S96K2YJAQhbC8GqslofJzqi52-k
Message-ID: <CAMB2axM0-NF5F=O6Lq1WPbb8PJtdZrQaOTFKWApWEhfT7MD4hw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/2] bpf: Use kmalloc_nolock() in local
 storage unconditionally
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 12, 2025 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > @@ -80,23 +80,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap,=
 void *owner,
> >         if (mem_charge(smap, owner, smap->elem_size))
> >                 return NULL;
> >
> > -       if (smap->bpf_ma) {
> > -               selem =3D bpf_mem_cache_alloc_flags(&smap->selem_ma, gf=
p_flags);
> > -               if (selem)
> > -                       /* Keep the original bpf_map_kzalloc behavior
> > -                        * before started using the bpf_mem_cache_alloc=
.
> > -                        *
> > -                        * No need to use zero_map_value. The bpf_selem=
_free()
> > -                        * only does bpf_mem_cache_free when there is
> > -                        * no other bpf prog is using the selem.
> > -                        */
> > -                       memset(SDATA(selem)->data, 0, smap->map.value_s=
ize);
> > -       } else {
> > -               selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size,
> > -                                       gfp_flags | __GFP_NOWARN);
> > -       }
> > +       selem =3D bpf_map_kmalloc_nolock(&smap->map, smap->elem_size, g=
fp_flags, NUMA_NO_NODE);
>
>
> Pls enable CONFIG_DEBUG_VM=3Dy then you'll see that the above triggers:
> void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> {
>         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> ...
>         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
>                                       __GFP_NO_OBJ_EXT));
>
> and benchmarking numbers have to be redone, since with
> unsupported gfp flags kmalloc_nolock() is likely doing something wrong.

I see. Thanks for pointing it out. Currently the verifier determines
the flag and rewrites the program based on if the caller of
storage_get helpers is sleepable. I will remove it and redo the
benchmark.

Thanks,
Amery

