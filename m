Return-Path: <netdev+bounces-226773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B9BA50CF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB754A0505
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A32848A8;
	Fri, 26 Sep 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6K5CG30"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A814927877B
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917599; cv=none; b=m7B+4Xf1NCidJ5ax7XDC5Ey/F5EVOelKuxl9UPmAiTTE7fHxxooa5wBl7v7kcx8rWFxG4KLVSc58towQitSe/HUNip18f5fyTD7D2VP/OCTh00e0m4taeZMMN+LzK+fWqvtiMBvgGvFsL6ybIKRoeMrFyd1nfRy3EFZKP8wq98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917599; c=relaxed/simple;
	bh=ockMKje8IiP3ZkK2AE6a5yj/VWFQ9iypReLwJDNvmR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goNMdg8HHy5eUR2/YafziJSSxWo/9zwRlgXy2lnJIM8H08oNUMHz9k8Ir67ncF6ynjjx22mE7zW/VWW094sM8yNFrLPhRpN4Hr09tYwXYV/pKgn/J3abW9T78a4daN1ZOA3buubvxutCjWqrEZJiIyBbdZvwH/Cy8onjb+/jLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6K5CG30; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so2969578a91.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758917596; x=1759522396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azJ7D3HhTIhe5KhU07JKwHjsPi1hvzfaP5sawhvAHr4=;
        b=I6K5CG304Mikg6FT/CbhLl3z8M7G/4m08XEMF5FaNEt0+3bXMsY4ef7IKn3CYfHG6M
         HAgucfltRaYO0bMGBXRF6ycrN0iZ+OpLZrM8U88agu5tfiMHx1YtfMuHUk+ZWf4CgHgT
         iETTzLINHPlyBNBhCjB9Uzd15bK9IpSyNhrzjhgWIuB3MwxvyNzYt2XwwrqVYYE4K7ex
         AA5lXwLqM9t3hEuQJlTvUyvhi/8Awjrf0/yvY9y5H5r2mgqtzG3FSEW+dz3yZwGDXv0y
         vcQR1N1ABqK/K+ay9qei9jwIPccS0r3p+GLbgL4gcDl4HC8UTIHS/FFo7O2quQZTnAsl
         JpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917596; x=1759522396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azJ7D3HhTIhe5KhU07JKwHjsPi1hvzfaP5sawhvAHr4=;
        b=trsph7pJenpTpH1BpYkmf0X1Z9JDZ7df+IG1FOnIM26OtJ2qkgS8nmu8tAWnfzDL2s
         Z3o55dyMI+yBMBIEz7xWogykKaG6rC1LQ3UdsJyWrP9fWp9Ms301FOtLej9xCChw8mnf
         r5rXIBH+tA6XySu7w3OSiauNV2h4TGrS88bZ0LoRrTe3Qlp4aHWkssdvb1+kpFHi9UWq
         TU5JqoWoSMbVu9lqFaN7W9imvozJrs+14aUPiZpFoJyAVcvnaJs9KCaVeeIgHPzkGqGF
         WvrxDEZIIcO/p4Azs3PoVryOKoLev4ihWajZmH4vUU/xkgVZ237uC7Zebit1kD2EKuUz
         q6MA==
X-Forwarded-Encrypted: i=1; AJvYcCV2PRPUvdbkcAt4x2/WOAAu+Hw9bJ9jxChC9F0ajAM7+GjbbHnHsX4ffg8hKE7ohe3QeTufq4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmL96AqFuBdPjyeouPZ9CEEN3Y7b+Avvg20sZQ/Tjw0GiXhxm5
	FM4/4oIpJvFXmi107tZ+qU/YoYSqdSzC2TO88+hYbaZWGe4lwPOHt1lXilk750ELwZvvbtMdowV
	gp/m2WX9gTQM1NcW1WZGylJhahaKGiVg=
X-Gm-Gg: ASbGncuE9NEoqbA4lz61bO9HsKZ8OardW8bdo4Gn0M018R1TU7bmxxCI1g3YAykXnWq
	DPGvawtO6qzOUuYQWpQH2AWOuQSBbuH0cb3M4ftUHfPLamiH73jyeuKIkhzX4Hm/C9Bu2c9+AP1
	eWs5MxL0oc3UJY0tc8MdcxVVmsCgDBEwPBHsye5kLLXfztzrjskrDo+xsPYfF/jQdA7QIIhGtAH
	QPVhwICf219WncylzXSd3H+YsTq1sZJsA==
X-Google-Smtp-Source: AGHT+IE9wktAnJaXtU0PxcthBauR24TfJwetpBW/V+26k16vTx5pCVgALqEiwxzd5//zsiqXJsPyO+D1zjUVWDi51VA=
X-Received: by 2002:a17:90b:4a49:b0:32b:a332:7a0a with SMTP id
 98e67ed59e1d1-3342a242c7cmr8106347a91.1.1758917595750; Fri, 26 Sep 2025
 13:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926071751.108293-1-alibuda@linux.alibaba.com> <bf53fe2d-366f-46eb-bd9c-5820ebd87db7@linux.dev>
In-Reply-To: <bf53fe2d-366f-46eb-bd9c-5820ebd87db7@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Sep 2025 13:12:59 -0700
X-Gm-Features: AS18NWDCAjm_CCwW4B5mtgKQl5ZzUHpMh8GaGW0BqCqWybt4qyHd4Xb5OMFtX94
Message-ID: <CAEf4BzZibyj4cyeMBAhGUWMVJ8P9ZeiwZgXF8HV90L8iwmkjTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix error when st-prefix_ops and ops
 from differ btf
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, pabeni@redhat.com, song@kernel.org, sdf@google.com, 
	haoluo@google.com, yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com, 
	wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 9:53=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/26/25 12:17 AM, D. Wythe wrote:
> > When a module registers a struct_ops, the struct_ops type and its
> > corresponding map_value type ("bpf_struct_ops_") may reside in differen=
t
> > btf objects, here are four possible case:
> >
> > +--------+---------------+-------------+-------------------------------=
--+
> > |        |bpf_struct_ops_| xxx_ops     |                               =
  |
> > +--------+---------------+-------------+-------------------------------=
--+
> > | case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmlinu=
x |
>
> s/bft/btf/
>
> > +--------+---------------+-------------+-------------------------------=
--+
> > | case 1 | btf_vmlinux   | mod_btf     | INVALID                       =
  |
> > +--------+---------------+-------------+-------------------------------=
--+
> > | case 2 | mod_btf       | btf_vmlinux | reg in mod but be used both in=
  |
> > |        |               |             | vmlinux and mod.              =
  |
> > +--------+---------------+-------------+-------------------------------=
--+
> > | case 3 | mod_btf       | mod_btf     | be used and reg only in mod   =
  |
> > +--------+---------------+-------------+-------------------------------=
--+
> >
> > Currently we figure out the mod_btf by searching with the struct_ops ty=
pe,
> > which makes it impossible to figure out the mod_btf when the struct_ops
> > type is in btf_vmlinux while it's corresponding map_value type is in
> > mod_btf (case 2).
> >
> > The fix is to use the corresponding map_value type ("bpf_struct_ops_")
> > as the lookup anchor instead of the struct_ops type to figure out the
> > `btf` and `mod_btf` via find_ksym_btf_id(), and then we can locate
> > the kern_type_id via btf__find_by_name_kind() with the `btf` we just
> > obtained from find_ksym_btf_id().
> >
> > With this change the lookup obtains the correct btf and mod_btf for cas=
e 2,
> > preserves correct behavior for other valid cases, and still fails as
> > expected for the invalid scenario (case 1).
> >
> > Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
> >   1 file changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 5161c2b39875..a93eed660404 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1018,35 +1018,34 @@ find_struct_ops_kern_types(struct bpf_object *o=
bj, const char *tname_raw,
> >       const struct btf_member *kern_data_member;
> >       struct btf *btf =3D NULL;
> >       __s32 kern_vtype_id, kern_type_id;
> > -     char tname[256];
> > +     char tname[256], stname[256];

I adjusted tname size down to 192 to avoid compiler complains that
snprintf below can truncate output (useless warning, but oh well)

> >       __u32 i;
> >
> >       snprintf(tname, sizeof(tname), "%.*s",
> >                (int)bpf_core_essential_name_len(tname_raw), tname_raw);
> >
> > -     kern_type_id =3D find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
> > -                                     &btf, mod_btf);
> > -     if (kern_type_id < 0) {
> > -             pr_warn("struct_ops init_kern: struct %s is not found in =
kernel BTF\n",
> > -                     tname);
> > -             return kern_type_id;
> > -     }
> > -     kern_type =3D btf__type_by_id(btf, kern_type_id);
> > +     snprintf(stname, sizeof(stname), "%s%.*s", STRUCT_OPS_VALUE_PREFI=
X,
> > +              (int)strlen(tname), tname);
>
> nit. strlen(tname) should not be needed. Others lgtm.

yeah, dropped that while applying, thanks. this was a copy/paste from
tname's snprint, but there we do actually need a prefix of a type, not
here, so strlen() makes no sense


applied to bpf-next

>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
>
>
>

