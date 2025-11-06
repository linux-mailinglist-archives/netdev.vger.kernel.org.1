Return-Path: <netdev+bounces-236117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3758AC38A61
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A05D3B739F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE51ACEAF;
	Thu,  6 Nov 2025 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkTec8Ij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D157C9F
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390881; cv=none; b=sC4JGjB8FYwDhcvVQTWwqmJq1dWhnzsPL17+2n0zBEsjQvMg6YuVVqPvg2I4M+Yn6T84ACJLpjLj1Kce3ItSBUl+2dF/D3XrTZ1zZDqHA1a4xXrfp94eZUHs7P4G7vbeAEKvTWeDtQprk2w4VFuEy7SHtTbQ4z1hNmFBSRxXrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390881; c=relaxed/simple;
	bh=S89tqRFp+PXsyn1Y0GRHHsQFt99m2f8E+vOLMoAiV6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzLmD5qiEoLOVjNekJcCs4eWL3BAeqH+gUsce8l+aY5nvNh5g6a1alRb35XnE9weP/ednXMYTGKHLW6eMyQg/9xNpFusrpiGjFxaqCa6W851Lkm2Z4MyNws0iuVKsuG/VY0u6UYzpxlmj+g6+hdu/rMV/2zWCIjenffDNpaBfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkTec8Ij; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7866aca9ff4so4735177b3.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 17:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762390879; x=1762995679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AarGBYTgL9zKcVypSTxWBS5/EisbGgb5FtG1W1CCJD4=;
        b=CkTec8IjtyQ1MnLowb5hGvtgZz5+aEdVuIXOE3cW69rgKkCbOyxfkQ41tyWOOLkhbp
         cLLlBS8rKJJHO10euSiR4WQ2sXFDEznbMirrBseVsW17fIaptvniGCFg+sGZlxxOKJyW
         Yy14YHdCa5ZLXEmGi0rb8z+0ck/GP1N23PfKJwuXqt+g8IsntIna/bIXm/5+aHEoiaHA
         WS3mCQBuT17P+Hwt47xPwANuVUYyDKTNRQzZo6eW1JQidCkN9i168ZW9JBkBgTJXHg3v
         d2AuI7R2hWjhCwwuoA5/tKvML8LuMEWC1Q2JuTUJiZrLr+ADFfih/FYS9Y3hJpr2TWlg
         hOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762390879; x=1762995679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AarGBYTgL9zKcVypSTxWBS5/EisbGgb5FtG1W1CCJD4=;
        b=A8+MeuxLsUxQluhA0nkNorpcKKBhmTqxVdzMlT4zZv2FHNTcxU7PK6xDAvyUlt/xwc
         IcwB4fWn2ddJWqa4HSbJwUe+4VXoNEHYpwXuQTmEaHYGQYCACphLTKldgnBPAPC1JRTP
         wjRsp+LL2/WU8Se/JfmHxz+XeaZNPnypBfNPMWWIwRMoRAn6Q1CZ1DFuPcxfQM1ngJYM
         nC4fQVF6fUTyCStTKOMTI/msl88Pji0mNIfu3oERguND7hexX9Fs82Q+oB3TUadBEoDf
         cCgKBta6LW5EC7Pot5zo3TbflittrRxceX7a8aB42k3A+x6wkRroJIl2kvYlZFOnFkz5
         NDcA==
X-Gm-Message-State: AOJu0YzuyYfUOL+25rWwYhQ1knR3A4lS6dtnsmmdVY/c81J2CMeb44tQ
	8aIBWu8dyLG/EOeoLoNdlmXBF1VEaik63vIwzWiHwz+2qhJFgGwDSxVHLCoeDU/krgf+U+ISoQl
	ddwQWmGoA+Wsy8y2/xuFVoJhAObafQR4=
X-Gm-Gg: ASbGncudn9v+q5EPjmUU4ar9TpdPVSSTnLVPHNV2+836qXmiwu69yEcLQaypxNdJYtV
	aI0n8Onpo8CMlvqSFpFY/yxD3ACxYxMFcxXP1tpNqDJjkUA6dNRZJu7MTlC4gUZi7rVhmYwF6Fn
	gA5r1WvcL/0VImR0QE/q21tSXVrJoqXSb+E2mlYjwr8Rh2/vHH5aSYOwxNyJ5spTMgkyrBEFqeT
	gcKFKDhOOX7kpMIPnVHwxzbbBfKTW91mO+EUbDeBnjSY7BIrZY09KNlz8oZ
X-Google-Smtp-Source: AGHT+IFLOz68rzug+sGxDkaF+7PnT43fXh+tzMxbuP6r8jxFzobWE06oyM+mseh5WYpbBKYArGhQWUB4tuRflrEWhO8=
X-Received: by 2002:a05:690e:23cb:b0:63e:1df9:c895 with SMTP id
 956f58d0204a3-63fd35c024bmr3466219d50.66.1762390879245; Wed, 05 Nov 2025
 17:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-3-ameryhung@gmail.com>
 <3d44b770-6fca-4b8d-a650-2680a977d2b7@linux.dev>
In-Reply-To: <3d44b770-6fca-4b8d-a650-2680a977d2b7@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 5 Nov 2025 17:01:08 -0800
X-Gm-Features: AWmQ_bnM8rVSWxRxizaeh94dYgZCpOF9P9g7YuCEROGTvk1xXE0n-3-VcOZkMzE
Message-ID: <CAMB2axP7z6xWs_YuLDEKi1ciz0QE9b507nDf5FcydNjWq8MogA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:57=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
>
>
> On 11/4/25 9:26 AM, Amery Hung wrote:
> > +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
> > +{
> > +     struct bpf_map *st_ops_assoc =3D READ_ONCE(aux->st_ops_assoc);
> > +     struct bpf_struct_ops_map *st_map;
> > +
> > +     if (!st_ops_assoc || st_ops_assoc =3D=3D BPF_PTR_POISON)
> > +             return NULL;
> > +
> > +     st_map =3D (struct bpf_struct_ops_map *)st_ops_assoc;
> > +
> > +     if (smp_load_acquire(&st_map->kvalue.common.state) =3D=3D BPF_STR=
UCT_OPS_STATE_INIT) {
> > +             bpf_map_put(st_ops_assoc);
>
> hmm... why bpf_map_put is needed?
>

AI also caught this. This is not needed. I overlooked it when changing
from v4, where bpf_prog_get_assoc_struct_ops() used to first bump the
refcount.

> Should the state be checked only once during assoc time instead of
> checking it every time bpf_prog_get_assoc_struct_ops is called?
>
> > +             return NULL;
> > +     }
> > +
> > +     return &st_map->kvalue.data;
> > +}
>

