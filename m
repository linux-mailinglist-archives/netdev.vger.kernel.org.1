Return-Path: <netdev+bounces-241704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58DC8786E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C3DC4E15D3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FA2EC081;
	Tue, 25 Nov 2025 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtpw89cL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FD25B311
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114863; cv=none; b=SFQhA6Xyei+4p9NCvin/rC2a6j1N5k54xDnTHXCaFXey5JeSPVT3aGsVLJSr/mqlqJXolfQUSyAlknPIURiik1vWriZBJ7dMG0Ysb0fJYfKMb2Uq+V8ILXnR6gcKTgbdtm26lus/pMfCfo2B8sxOG561mLDKw7+8LkaiawLblvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114863; c=relaxed/simple;
	bh=UmA+zl3Jz/3zmGCtyMZouwtZhX1vm0jkAbwHClmqIJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owS4/BG2FHfO0xBmowARffLTeMKEWOGJKPkQo9BQMwHoKLjf5EKJvlUZN8HduFf3Vjo7ytv4XD1Lk+BVc5XaaynRo7EjFbAQF1h9uEKh6mZRBE9qlsNPqPak18cIddte/m/ifkdpruir73sLzEtTMIv1mZd9sWWPBRh2DuQRN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtpw89cL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso5047838a91.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114861; x=1764719661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3RPqln1ANJzd5R6QcbYwk0cJfLEX6kIEy3vJdt+mSo=;
        b=Qtpw89cLqhlxE1Nz3zIbwiz1BGeJpFafeyuT+9pRmA8XYDA00pWpBugGdo1amncSLG
         VC4D0XpQPFOEcRfQNg4WTQz4vXi0V0CoAiDavhINiJgyoSClNeDc8wxpetCOQUvnycM2
         6YwP5ayjCdT06eoKHuv1rCOhBJ5sdtujpBjWVW4oMSaqKKtNxtWlUmkeQSWe/KIllQkN
         er2QBtTW8t7AGZlPy2GVROE9DiKjch3HwfijGR07neFQY4HvwFIs3QMlCoOfjMViuFaJ
         6T/+Bp8YnnOUZYElrsQGoUzHiF0TZhDDL96ESgSuvEywA7jOzCOzdrV9WVZOZVdgg0CU
         SFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114861; x=1764719661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3RPqln1ANJzd5R6QcbYwk0cJfLEX6kIEy3vJdt+mSo=;
        b=AEfT/VbBPOdHK9MTZ9o6L3I8GQD/Uxv9cNdcZ2TjsYMdiUujO0gYY8sxJp+bRqM5Mr
         qy2Lwb1L46s9XizbagfoJTIxRZGchjyTwUtHbJU7QaXiS2Vy4fBVGi+JBUG7tQVADS7d
         SozcolHS3Y9uyptZSRaAgmUi4dtg1YMfrXemK1L5GVYwOSzJx/FRT//1aASmbNwFH10w
         BeDZpPfx5w7tSTKE4fdVamD9hUq090D3EOLegLwLlWzbJ/jgRSjiCe58rWoj2oTX416s
         8z1u+/VWNhlTXIm75LUzOYD4lgU6QYS+On4jMJbdznKMjbmkl4egCHkpQLoC5TK4DJem
         sl1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1GIfBud+wp9IlrkZz7F2nw8RKkF/wYbvzQ/5hKw5KA7KiVOatevVx28FrzvqiOcFqNG2/lBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvMVHPloCjCd4Ba4/QiiLQKHUdx2pvuqoKLkPIQJ/1RXGNKwO
	WJvataGYnBKD2UOlYpqN4NTtZ1RZ9lB/W6Vl3VxKUxdR6mao9xiQlghio8mSFPL06ECvt/hywkD
	s0Qr6BrDTLtCTiwZn2ga3NC3bk9kB38A=
X-Gm-Gg: ASbGncv/2SMSGwrU5lW7lrSWDUd634254R77OFqJaJWprB0JUbEy5JU6nA0VLvwmnOD
	cXDXGjkHJavXqYEu2yEaPN4pkLwGtsdUZ+x2qw6V3pmfIfzeiWIpObjNhvSlL8jQIByBPjW2rUE
	7fniHtK/1VASdcerx9uhYyJ7O+B+lt6M3lQkE37E0chPmiUnxRKG4c5hZrtLsJuklW99nIdvFul
	f7XdXE1H7pn6KSTRnk8ljERpwLcDqJZsOVXAap2Q3I0m21enQtYi+QTTGtM4wn4uOdI1QALqnK7
	B6uIlysPBu8=
X-Google-Smtp-Source: AGHT+IF6DOi7rb9isyagDTFCSIeNpairvyjgWvoz5d1kCo9mQEw0RTdWc+nqLtog+K5EXGn+7yuTYDMM0zhR2x9reFQ=
X-Received: by 2002:a17:90b:3502:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-34733e72350mr16761843a91.13.1764114861031; Tue, 25 Nov 2025
 15:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-4-ameryhung@gmail.com>
In-Reply-To: <20251121231352.4032020-4-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 15:54:07 -0800
X-Gm-Features: AWmQ_bm7thx54-FFcBIeNbOReQG7DwMzS9jTc_MbqlUFWTrGKvBtFbX0cRXJ5o0
Message-ID: <CAEf4BzYaiBYKEvLZk78MMj1R1yjeTZ5P=C7QCrUquh250ENcpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/6] libbpf: Add support for associating BPF
 program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:14=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
> command in the bpf() syscall.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
>  tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
>  tools/lib/bpf/libbpf.c   | 31 +++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  5 files changed, 89 insertions(+)
>

[...]

>
> +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_m=
ap *map,
> +                                 struct bpf_prog_assoc_struct_ops_opts *=
opts)
> +{
> +       int prog_fd, map_fd;
> +
> +       prog_fd =3D bpf_program__fd(prog);
> +       if (prog_fd < 0) {
> +               pr_warn("prog '%s': can't associate BPF program without F=
D (was it loaded?)\n",
> +                       prog->name);
> +               return -EINVAL;

This is an error return path from the public libbpf API, please use
libbpf_err() everywhere to ensure errno is set. Missed this in earlier
revisions, sorry.

> +       }
> +
> +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> +               pr_warn("prog '%s': can't associate struct_ops program\n"=
, prog->name);
> +               return -EINVAL;
> +       }
> +

[...]

