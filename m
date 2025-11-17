Return-Path: <netdev+bounces-239260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8CC665D0
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 861614EBFC4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E034572B;
	Mon, 17 Nov 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkbDLrjI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5762F549A
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416428; cv=none; b=Xckwf+V+bQTDYZm2/bGNGFieQj1mwskDfJVlS9GhigS2ws1+SvKRAf6AQRGya9EFDWXy+WZbgR17crOlcJqdUuDPGMnsd3djE54hc6VdaDwh5rd9mOZc+uV4Qf/WNLk54Bp19AVo3DV055jp4awyV1izbYYlQRoJ9c3sodyVxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416428; c=relaxed/simple;
	bh=HTJ3eLKna4TP+p8VyJ5dKdx8lRHlt7F7zGYv0LwV0wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsasulWiVOkqqD/eIc+hbNt2YrPe9qX+a5X7HIdtVs+8wmf0Kso1qZH4igz4dcRWUcCtHwLTrXJZfy6L+uGOGDs1l/1sSN+QoOMtGGgBEJvmfMYu4o4trH5fr2tJxI/NWjfv20olACowauuU4jhQCPYH9MwvQ3HBRJX9W4VlSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkbDLrjI; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-786a822e73aso50987067b3.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763416426; x=1764021226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRpEc91gJgm396nD4yAqSc5cg7ZEzKjtcQzeuqnnQ2Q=;
        b=GkbDLrjIcFm1t5yab9rfxOUYFpZKUu+u+cheTtK7KnnJlNBapKnPnT4gM5M44XJVX/
         GHDoi15lkzfawQfJC/lWqJ5NJj+nFqrv6Abidhm9lAclkI8gR2IbDpLPPEX9R06OtChA
         jpDnKWvLYV6ByjCBWiUPOjn+lwAQ1T0HgBAVab7WHapI+lAmCQtMIBbmLQb4Du76KXE2
         eqbFabf0+6jouqN5nZMQnAYpeUJuvtUkzf3IDHc7Yjr7EnMbRfRpGFr3VQcUTcwX+a1T
         1MiQFopEZOQvA6Ag98aM5o1ZvlCBJahPlQhO67wzD3HGqVO+mcorhYkTnw/MpVGnRV5X
         +ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763416426; x=1764021226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QRpEc91gJgm396nD4yAqSc5cg7ZEzKjtcQzeuqnnQ2Q=;
        b=EMoLs/VWf7hroem3id6WF/8QBVtX7HOtB2lBB8f6L+CZSaGuK6JUb1ND+/HtkGHjvY
         4JtYmiQJuXoTFNPmRwJqVePQ5IV6i9QEdES/ERhSVtT+OCNhF9uS2mXZYmRfCX81oLY1
         GwG01fINlmto8/VeV8pgPnN4OKi8yhf1KErvM/t4A1Y7A7tp+6ptqBUVRf+P5cv5WVn3
         FVTGzrO1YALRPQcNcUW/7ci+M3OuYfEgMazjpm10rH32OOykorlHkOk+u9B61m5CrCcd
         C6x5bnN2rW3BVahvKjE5zkRZGXwi3ZQ0vNLXQe1bvja4fjFDzfdzMAhC/udLwllK/Tev
         ot6Q==
X-Gm-Message-State: AOJu0YxNpjrdS/nfdi44y7Zaqvi6iUG6wU+gjA5rI9Cjh3Mn3S/i62Kl
	NXWD6Ch0DYsg8nPAz/AqawPjErgqs9R4hdYIBkLEK0V7oiWQcVw2+iBXRBPT6/vtrbw6CsXuex7
	Whd69R/iPLhj9A2He7ItPX+Kc9uP76Fw=
X-Gm-Gg: ASbGnctWEQ3Y9J0rh/fm2DtaCzW56077zqb3FZAHvTDiqUKEHqAizePniOsaKarPxGC
	bofG8a4rFoFjE5NO5FQJ2UdkES55Q8ADB8/wxY6DS4RXFEv1E60Nq/Zp6tu4C9f6bFQgsO3hMi7
	TV1MEmZ2j8qPpYH+qXzYqTS1B/8wQMetN+CX5+T6ZW0D1BXypH5+upOINVMff+kmBlzKX649Js+
	9vJlpXwLuOsW+nHrpWanDBMFkQTY4yQKWjN/1vPJYNEppPQJAbC+0ceQwPnkvAQUYGaPnwAMf+v
	E8dmxg==
X-Google-Smtp-Source: AGHT+IEjt+SgKJgvqZfIWTt3iBRLNEkiTQgsh8E8Ozy14q1xT0QTWKgZXkWXJrZSKQeoqfKoNoZyyR/KwS3Ce6QEtc8=
X-Received: by 2002:a05:690e:2514:20b0:641:f5bc:6949 with SMTP id
 956f58d0204a3-641f5bc6ebamr6521194d50.77.1763416425718; Mon, 17 Nov 2025
 13:53:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114221741.317631-3-ameryhung@gmail.com> <16d43cdc90504cad5143df62b3d40f325a271aeca0adc521c6fef711023f90ef@mail.kernel.org>
 <c891d752-33cc-413d-8311-dcf8afbf339d@linux.dev>
In-Reply-To: <c891d752-33cc-413d-8311-dcf8afbf339d@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 17 Nov 2025 13:53:35 -0800
X-Gm-Features: AWmQ_bllaccjMOakNQGT5Qu09mBjvusObW0uY6jWy3hdesVzuIyVmf42SM1SzgA
Message-ID: <CAMB2axPrnaEf981+drX-MPBZOrPhZvFxuq0d+2Ue-sTqvEQZ8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Support associating BPF program with struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ast@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, bot+bpf-ci@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 1:39=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
>
>
> On 11/14/25 2:51 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> >> index a41e6730e..626aa9197 100644
> >> --- a/kernel/bpf/bpf_struct_ops.c
> >> +++ b/kernel/bpf/bpf_struct_ops.c
> >
> > [ ... ]
> >
> >> @@ -811,6 +822,12 @@ static long bpf_struct_ops_map_update_elem(struct=
 bpf_map *map, void *key,
> >>              bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
> >>                            &bpf_struct_ops_link_lops, prog, prog->expe=
cted_attach_type);
> >>              *plink++ =3D &link->link;
> >> +
> >> +            err =3D bpf_prog_assoc_struct_ops(prog, &st_map->map);
> >> +            if (err) {
> >> +                    bpf_prog_put(prog);
> >> +                    goto reset_unlock;
> >> +            }
> >
> > Can this double-put the prog reference? In bpf_struct_ops_map_update_el=
em:
> >
> >    prog =3D bpf_prog_get(prog_fd);              // refcnt =3D 1
> >    bpf_link_init(..., prog, ...);             // link takes ownership
> >    *plink++ =3D &link->link;                    // link stored in st_ma=
p
> >    err =3D bpf_prog_assoc_struct_ops(prog, ...);
> >    if (err) {
> >      bpf_prog_put(prog);                      // refcnt =3D 0, prog fre=
ed
> >      goto reset_unlock;
> >    }
> >
> > Then at reset_unlock:
> >
> >    bpf_struct_ops_map_put_progs(st_map);      // calls bpf_link_put(lin=
k)
> >
> > The bpf_link_put will eventually call bpf_link_dealloc()->bpf_prog_put(=
link->prog),
> > attempting to put the already-freed prog reference. This looks like a u=
se-after-free
> > if bpf_prog_assoc_struct_ops fails (which can happen when a non-struct_=
ops program
> > is already associated and returns -EBUSY).
>
> The ai-review should be correct in general on the double bpf_prog_put.
>
> >
> > Should the error path skip the bpf_prog_put and let bpf_struct_ops_map_=
put_progs
> > handle the cleanup via the link?
>
> bpf_prog_assoc_struct_ops will never return error for
> BPF_PROG_TYPE_STRUCT_OPS. If that is the case, maybe completely remove
> the err check.

Thanks for reviewing

Will remove the check and add comments about why the error can be ignored.

>

