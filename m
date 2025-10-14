Return-Path: <netdev+bounces-228997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F7BD6D71
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9423188BF28
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EB32AE99;
	Tue, 14 Oct 2025 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeWSkgCn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2527470
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400674; cv=none; b=L6ArBcX3KV2j4vWpu4eINazU7jCfdsdSlOnqIHBQ9DonRG+hoSAaEp3fpJjXLtm+QK8eGCADCs0GJQst2RVAW/2YEkDsoU0LfoCq2VSMVtuV3OmPOkLfFp10sXldCbYCV0GZ0Da59+fZGiAD1xm4kG5y5/rc2KPx61XQnMfP4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400674; c=relaxed/simple;
	bh=oT6BIqSCXvVZg4wf8LhNiuknVaFfgx/opCT/JGn0Jqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ste5yMiZTHSrdosMOsMdhw75NkvTHfbR8ct4n/XF/SVUJ4+V7xLXlZue3RIOZx1Vy0mH4HLiBl3MZS0VZkD5dn/tsxKtEipftIox5VTxhlN9tcnT6j3jeBZxGGZuaYD80R685jrjN1t8za2JmJnmy9oreeERF8HZAvtfp9c/e30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeWSkgCn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so5074282a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400672; x=1761005472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ga6LtzXrkuwBiLFUJI3I332GgLVKaXY6PMLfMN7rmXo=;
        b=FeWSkgCnZ+achn8cSXD6UYb7vtCjj9vnoVPtE8izS+t7aWnXjUCJ01F2Qwz5tO6DOi
         iozj8TOupqeqeVmR7H5j6J7SSPP5aPTY7PqqOHK0ZAH64ue1bKlqpdBlidSfzMUn1KFB
         xcKVxV7MVqKU4OoHtuO6QUgAVXaPfEC4TcVZhWYzsrTF2qj3fbAXB/V2xDQCZPGIGhHj
         N5Q1dSPA6EYlcWuXWGzNq51/Vx8WYhfkZJEHherTplRpEZnWr5Jxt6yl/50CL8HlPW5Q
         4ETpy/QEg8Kwl74uyjCzd5o1PSBcC0X58nIyQUkWnV4H4WPY3q0LCQkdGUuYEriJzHfd
         9zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400672; x=1761005472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ga6LtzXrkuwBiLFUJI3I332GgLVKaXY6PMLfMN7rmXo=;
        b=akCwk86XDvA28Rt8uhXYm7IElZCIRWPsu37Cje3zmRm6EUY7NDoPEz8zuYhiA1hrn8
         TDVUczE02O0IFB5VPLrWSGxJzrKVry0Er4/JuZeLoUfnhVZ5P4U7uyZfLbAmRN25zL75
         xj9ryBqKqKgJAG2sGCJcmVKLK5qTDnJ5+0903Fvsby3sXEHfQe2vfu2Kf3BBsO/EFgX0
         ecWX/NdHOs4+TjR1vO7yLw9ciJbC82e4DtYT4flZirePzn0iDWcBE6M2BEczab+wNd6h
         9evkpvwYMhdI0V1SZZwYySq4VJEW2jy0ZroMyBpAr2Wa+KDLk11S9/m16WL1Q6pQdC2j
         f2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOWJ7YVNkg4mlLlFdqROonuSLkF/JH8T50Ip8NMRPiHwDJ6lz1i19GHiWOOXJTEFoUfxGpx3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkiAhfJzRKyEMJoT1ub/viUwvLEbc9gOvACX1IB+CKw7E+SlZ
	B1I9V69coLFfLY4fZGYseBJ7qhdTjJs6kZRNNj780kyG22Rw53/1R6kgmgp+EvDbkKzR8xBesum
	lOzdmXet0QBOMgI3sIXcJGSevkBSFc44=
X-Gm-Gg: ASbGnct56SLWxvWJYGX398jFtgBhaQYHQroQfDDOW24OeiNciRfjJuEg7Z+OLdsQQmh
	4zwGWzRocyYYfl2HhN5uhXyI08up4yVSjmTiwsAvl0EsiGlwwp5usyBn6TAkKpI9dLRh8qiwaHx
	305nkbYEGwagtQhYNAMawJSO7Mmua5gdjjrIbxs5SM6471jN5FJou9CZj01R4WDytNGr0OufuTm
	xE+5Y9VD8IB2J225LjN/9YgMtt2zrUXZjJ4WWTqRQ==
X-Google-Smtp-Source: AGHT+IHNzGcpeJ0qJsv8CxRS18TR3PDrOsBiaXfpxwC+CGNWj24f0/m0ufYeFsAVElIeU4O/uNkQWnGqnno9eKCYJQE=
X-Received: by 2002:a17:90b:3e8e:b0:31e:d4e3:4002 with SMTP id
 98e67ed59e1d1-33b5114b653mr28792584a91.2.1760400672051; Mon, 13 Oct 2025
 17:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com>
In-Reply-To: <20251010174953.2884682-1-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 17:10:56 -0700
X-Gm-Features: AS18NWDS7ccZYHKBu5pn8axn9X5cjmb7uFf288riz8z3_M8ZXSXxCydQVzsGBz8
Message-ID: <CAEf4BzZhRtswXo_x0Oks-VvcmCLHUdKPKGtELPSECDtxyAEoKg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 0/4] Support associating BPF programs with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> This patchset adds a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to
> the bpf() syscall to allow associating a BPF program with a struct_ops.
> The command is introduced to address a emerging need from struct_ops
> users. As the number of subsystems adopting struct_ops grows, more
> users are building their struct_ops-based solution with some help from
> other BPF programs. For exmample, scx_layer uses a syscall program as
> a user space trigger to refresh layers [0]. It also uses tracing program
> to infer whether a task is using GPU and needs to be prioritized [1]. In
> these use cases, when there are multiple struct_ops instances, the
> struct_ops kfuncs called from different BPF programs, whether struct_ops
> or not needs to be able to refer to a specific one, which currently is
> not possible.
>
> The new BPF command will allow users to explicitly associate a BPF
> program with a struct_ops map. The libbpf wrapper can be called after
> loading programs and before attaching programs and struct_ops.
>
> Internally, it will set prog->aux->st_ops_assoc to the struct_ops
> struct (i.e., kdata). struct_ops kfuncs can then get the associated
> struct_ops by adding a "__prog" argument. The value of the speical
> argument will be fixed up by the verifier during verification.
>
> The command conceptually associates the implementation of BPF programs
> with struct_ops map, not the attachment. A program associated with the
> map will take a refcount of it so that st_ops_assoc always points to a
> valid struct_ops struct. However, the struct_ops can be in an
> uninitialized or unattached state. The struct_ops implementer will be
> responsible to maintain and check the state of the associated
> struct_ops before accessing it.
>
> We can also consider support associating struct_ops link with BPF
> programs, which on one hand make struct_ops implementer's job easier,
> but might complicate libbpf workflow and does not apply to legacy
> struct_ops attachment.
>
> [0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/sr=
c/bpf/main.bpf.c#L557
> [1] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/sr=
c/bpf/main.bpf.c#L754
>
> Amery Hung (4):
>   bpf: Allow verifier to fixup kernel module kfuncs
>   bpf: Support associating BPF program with struct_ops
>   libbpf: Add bpf_struct_ops_associate_prog() API
>   selftests/bpf: Test BPF_STRUCT_OPS_ASSOCIATE_PROG command
>

please also drop RFC from the next revision

>  include/linux/bpf.h                           |  11 ++
>  include/uapi/linux/bpf.h                      |  16 +++
>  kernel/bpf/bpf_struct_ops.c                   |  32 ++++++
>  kernel/bpf/core.c                             |   6 +
>  kernel/bpf/syscall.c                          |  38 +++++++
>  kernel/bpf/verifier.c                         |   3 +-
>  tools/include/uapi/linux/bpf.h                |  16 +++
>  tools/lib/bpf/bpf.c                           |  18 +++
>  tools/lib/bpf/bpf.h                           |  19 ++++
>  tools/lib/bpf/libbpf.map                      |   1 +
>  .../bpf/prog_tests/test_struct_ops_assoc.c    |  76 +++++++++++++
>  .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
>  .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
>  14 files changed, 357 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_op=
s_assoc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c
>
> --
> 2.47.3
>

