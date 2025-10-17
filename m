Return-Path: <netdev+bounces-230614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CB2BEBE14
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AFE402A81
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A3261B91;
	Fri, 17 Oct 2025 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/XLr+sK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC823BD06
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738708; cv=none; b=Thp10+QKSXqaEY9+TDq9w0Rg4cpFdFUN4HKFQtIWdyzVzWQnk+Iy/evV3+yAEb31Vrr0fxfm+eewhyTLWzrCY51XEz7qKP+SEiHcij2JM3KS+kYHlZlv8jkgOjlrdm8crsT057h37N58kj41JHckWYHc0dKQBRR7P9D57vwrGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738708; c=relaxed/simple;
	bh=L/v3CTudYliQuwWtD7vEW8OqVQUXTzmYJnx6dWikryU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPyy8HYNN6wCcmfNwmrA7uXPnHYt6S2GhPiVnkbcDPPMg2a+wXSp3SA9nj3QgqPeXLZnT+XPyDf0YgL1Miil7LXV/G9ZKLY1+s7SVnKekivkiCppHfceLSH4GEypQfCJ0jhBfLJ/DzaU1qg9MNIOxSNqkhqTsZ1x5onLCvUH0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/XLr+sK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2342689b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760738706; x=1761343506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5N25k40+HpXv+7dIs8x9peeiwcAwgumjCpa41Pq1oE=;
        b=b/XLr+sKvgAEsaabP93Hu0ShkOdwW/zoryuJvoSQEw26qKVAKwJuva++deMXP5oj8A
         hAEUwDVAgN6ToQQATVdZMJ/cPKaWSXwJuj+USki0L6mjAks7iI+CNiJf2dRFEFm5gXLx
         R25lplaipT3Vw1ZhiKB79aowz/IN5nyY/RJ+o01BUfo74pKPhDHSie8oP20m9lSnf6uo
         /F1WPT1FPCnZM7N6ZxBS7WxASql8l8T8x6z9E4WWzgHw12pCX4AfB/sBSbPNi+U+UEAo
         9LvZRyREPVLXFK58e9O0JAYSNz5kthLLCKUxVMEb/SVRAO8DwGzrRFLq/B8FW1NT/MBu
         CCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738706; x=1761343506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5N25k40+HpXv+7dIs8x9peeiwcAwgumjCpa41Pq1oE=;
        b=c7dMzXJ8cwQeIypNgDVW8lCfFxNwk09x39j5FZMYpvxAOWjR/n0PzLlNCCZDOhgT/C
         dLklKUhlmvnkpfK7qPX+DWBkZOmv2pm7DRMzzhjBUbLKjh04nEd7m836jis85jay423h
         6k8WagB1s6lGw/AZrLzp4KaAyB4loAHoe4U4ASJR/RAYPVnqPiPkVqjWdTcEHRPEuotA
         UB5qr4dKlq7ySvvSQ8p4sRSKY+rfPx6kR/smKNfESFrQogXu4iv6jyy+sn75vHPUHwHb
         bt5zNO9YC2kc5yqnzYv9ZOQZb9szEsFWzYp3zK/lTKEUQfe59AI94WTD+ziB7HEGgayx
         1pkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOIMNhplAoM4wXcrXMGNyHZZsWA39U05wZKnY0NVF1KZdGEcO+AY9ReIjj/iFHexnYZ0Ih+Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmQZ62hpHHXwawIxStR874OEDyX23U+Lm+xi2HEssmxvo2FU5
	7oJXrLBBVlHRpnMg3aDjL/O6xwNom8AXoi4RkdA60ljqUuBk/IxtBCwrvbOSICnrr9Nmb3bBdGn
	+AoTf1ICC/aoFtEYels/lmMerp1p1If8=
X-Gm-Gg: ASbGncshH67z1v1JYsF9AzwKd12/4PKbMBTX+o51ES2Uvq4cIynoWHaHREQj3UXEFOx
	6tLu8LbsD7T1V0QvDGl1QyTDTVbWT8p2NRzGgXf1M4nzsX58PSLBT+9+Kg0IAsHJyMLfCorgfM0
	MJu9nK0ByaoTdRAalVILWIBZO0jTEpb740UPlKJjmIIawLS3kZW7Wn4XXpjymEg8WoPbf1g87Km
	rRDSFlyGr0L2wpT1OyQqgHMoFTO+Fd0BadrFF5NXFFH8DTuaNwD3yUVcs0uWnJLPsCy
X-Google-Smtp-Source: AGHT+IFiuXNUTpXYxfdpvqV+gLBa2YeIV2vx00ctFQ7hYpKwEysWT8im2YJgk8k3lQmmp9gMaqJes3Gfdh21dO/ZiDM=
X-Received: by 2002:a05:6a20:549d:b0:32d:a6c0:15bb with SMTP id
 adf61e73a8af0-334a7a5fed0mr6484069637.31.1760738705834; Fri, 17 Oct 2025
 15:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017215627.722338-1-ameryhung@gmail.com> <20251017215627.722338-3-ameryhung@gmail.com>
In-Reply-To: <20251017215627.722338-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Oct 2025 15:04:52 -0700
X-Gm-Features: AS18NWCAT-OoCMOJRJGYTJr1PPe2I6Y44OtQD5sgdSoMYhQcOAV5Pm1z1pkiGuA
Message-ID: <CAEf4BzaRxpR5XLJmFopwq-asBUv0vJ2RZtcx2f=+XbfcCgBeFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Support associating BPF program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:56=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> a BPF program with a struct_ops map. This command takes a file
> descriptor of a struct_ops map and a BPF program and set
> prog->aux->st_ops_assoc to the kdata of the struct_ops map.
>
> The command does not accept a struct_ops program or a non-struct_ops
> map. Programs of a struct_ops map is automatically associated with the
> map during map update. If a program is shared between two struct_ops
> maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> be reset since we have lost track of associated struct_ops. For other
> program types, the associated struct_ops map, once set, cannot be
> changed later. This restriction may be lifted in the future if there is
> a use case.
>
> A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> the associated struct_ops pointer. The pointer returned, if not NULL, is
> guaranteed to be valid and point to a fully updated struct_ops struct.
> This is done by increasing the refcount of the map for every associated
> non-struct_ops programs. For struct_ops program reused in multiple
> struct_ops map, the return will be NULL. struct_ops implementers should
> note that the struct_ops returned may or may not be attached. The
> struct_ops implementer will be responsible for tracking and checking the
> state of the associated struct_ops map if the use case requires an
> attached struct_ops.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf.h            | 16 ++++++++
>  include/uapi/linux/bpf.h       | 17 +++++++++
>  kernel/bpf/bpf_struct_ops.c    | 70 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  3 ++
>  kernel/bpf/syscall.c           | 46 ++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 17 +++++++++
>  6 files changed, 169 insertions(+)
>

[...]

> @@ -1394,6 +1401,69 @@ int bpf_struct_ops_link_create(union bpf_attr *att=
r)
>         return err;
>  }
>
> +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map=
)
> +{
> +       guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> +
> +       if (prog->aux->st_ops_assoc && prog->aux->st_ops_assoc !=3D map) =
{
> +               if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> +                       WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISO=
N);
> +                       return 0;
> +               }
> +
> +               return -EBUSY;
> +       }
> +
> +       if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> +               bpf_map_inc(map);

if st_ops_assoc was already set to map before, we will bump refcount
one more time here, but we'll bpf_map_put() only once in
bpf_prog_disassoc_struct_ops(), no?

> +
> +       WRITE_ONCE(prog->aux->st_ops_assoc, map);
> +       return 0;
> +}
> +
> +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> +{
> +       struct bpf_map *map;
> +
> +       guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> +
> +       map =3D READ_ONCE(prog->aux->st_ops_assoc);
> +       if (!map || map =3D=3D BPF_PTR_POISON)
> +               return;
> +
> +       if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> +               bpf_map_put(map);
> +
> +       WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
> +}
> +

[...]

