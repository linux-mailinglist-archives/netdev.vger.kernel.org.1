Return-Path: <netdev+bounces-247949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC4D00C25
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 04:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD33D300532C
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 03:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9CE2773F9;
	Thu,  8 Jan 2026 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5hJu33h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE8277013
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841372; cv=none; b=fo6wHVc5nhRC0KaUYf2Bjbi/SnJSWYw1y2/ZnDDowmpzUaszLH4kul8Ozroh5lr/FEPXeyVKreaNkv+Ez0/n86oNjH1pJVQNn0NnhW57h3M79qZsgMwQRWa4yzN3k5ae/Bm99q7XVYSdFxjVebHW0qq4F9YWT062LsO4ugdc8tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841372; c=relaxed/simple;
	bh=a1RoPEBc3Wwr14BkNfsBMLUakvIh0moEc6K1EVQg+VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG7UmoeCn7OsxzmhLJyQlPaHjfc1IgaHzN4u1sfsXZ9+lqZQwmgF9org6kv3MAgIboK4jhOwhMdb3+RLI5MMJeFQGv2f5XEY/XcAfMcjfEUG6pAwHgVqOSqCvxW0cOAQ7j4sSNlmeZhZCbG3dXXJUY43CgHVdHGcI2eZVmIUjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5hJu33h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae77516so29897785e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 19:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767841369; x=1768446169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY0Wa1WSCYpKugnUdEH4qnlMyznAtnS0fsyNGN8xDaQ=;
        b=W5hJu33hoo5YWNtxoY5QrA2DwZ8TemQzQitYCsyGvO0iPyEU1imnlB80Tq+jYXsRU6
         fiwR09Li44vhpgdLxwBKbyLyomYktAB7pLMXzwiG6/bt7MVWXgEBaHwkF3ZyefHN7E6T
         Eamfygr68E0LWAFlP31lJpm62OqDnyFE+6eCNs784v9MH0xzigh/rMuVFOMILWqPtRW1
         IbDuGhpVsA9ZRVaZ8OzatcQxUoU1BuFG/99ryBeP3u3sXleltOh7FgzoNB3J4gZDfBGu
         xlrwV2lVrKOnyiPJmjekoxNwgrBCVuHtQSig6YVYEW2r8OysAI2pd6oGQM9F8FnaPifD
         4Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767841369; x=1768446169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EY0Wa1WSCYpKugnUdEH4qnlMyznAtnS0fsyNGN8xDaQ=;
        b=Hoq14IzKpFp6moqX27oktS5IqbLDTdFNcItojC9iwAQiRR4H32ozWn8FulrhhWqEqN
         wPELcFYeOxJ1Pyk5PjTPUbgFV0pZX/RDJXhQWv0eCz1epR9JeKcj5GNrIgILTuNUilqi
         eTOfRcdj/HldVMlNY+MJk8tXXst4oMsyZk6Gtve0xNEE+wqZ1bPHt61juPGRIKLH/mdz
         itFjGWijR5os95SdCZQxOwsEiiAD6ehDA1D+8xlyw9h2TSlp7gHgjQKmzop7OI6+IzR8
         npJ5uHL20WD6XBdOs3UD5/BHQ6ij91xqXnqM7VjD/gf1jVJna6MoeMRIHkGo1c5jyuEE
         8ENQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl1/v6RFTejc4K0o6eFGUjNNf8MwfLIWxUPdtiO7FQEoj65Ae+DuBf72fKsDoWF30nB+MkT+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfAC8IDRx3riFQlO3bHcVBqXZjHHSlwf+411zOC6v8OCq5cmH
	Uj+JIX/SG7VaLVXa/s8ReB2iiMKYIF1vbF94am6RWC7A4RRX6D/7UzH4zgJAkGE49YJtmjPywqs
	h3dLd+0PiSA6tuOOQHUakZmFVVE5xJQM=
X-Gm-Gg: AY/fxX4OLc+S7oXK/m95ZF6vFnC4f7cxMVP5YVoAanz2kOg0vKdCB0zcmljtWNEOg0R
	n2P9ypvIseGLulkif75m//MUpu+J9Tb3AgYGVF979VarqmBqHPbxJW7C8pYb1+G9h77ciiGDESq
	BoaFWpCT/k91L9ZbmqOcIt7QoJgipmvvnAYKGSFXuVMBMQgNRvj9YTfhJOwZWwtaHcyRgvSizDb
	gsf7X0qTVi+IOYOm8mxw4Fc1Lzh2WduqHFaxtwSkLAOkeuzj36wmLPiB2uZaTh0Y+RXSNXxfwWf
	WOMtOme5Pj8cMYsWvYCJqyR+lEVQ
X-Google-Smtp-Source: AGHT+IFW66HRut9McAB8OEPWLeJFLNhe0/dDJVE93tL54XTWKmtvQQkTSQ8hA2441xczEvpcbAVxYSHf7hqnV2fwp8s=
X-Received: by 2002:a05:600c:4fc6:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-47d84b0aaa3mr49166775e9.3.1767841368671; Wed, 07 Jan 2026
 19:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <695bc686.050a0220.1c677c.032f.GAE@google.com> <tencent_8D33CB9E2A1B8D4B511BB0250FBAA8BB8708@qq.com>
In-Reply-To: <tencent_8D33CB9E2A1B8D4B511BB0250FBAA8BB8708@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jan 2026 19:02:37 -0800
X-Gm-Features: AQt7F2pFxMkZPeYscSWsMcUQcIaqgB9d00Syi9jMit8X8Vd3bheI37TGkZZySQE
Message-ID: <CAADnVQ+oMVuUjZi0MtGf52P3Xg9p4RBFarwZ_PiLWMAu+hU=rg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Format string can't be empty
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:39=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> The user constructed a BPF program containing a bpf_snprintf() call.
> The fmt parameter passed to bpf_snprintf() was not assigned a value;
> it only executed the BPF_MAP_FREEZE command to freeze the fmt string.
> Furthermore, when bpf_check() executed check_reg_const_str() and
> check_bpf_snprintf_call() to check the fmt input parameter of the
> user-constructed BPF program's bpf_snprintf() call, strnchr() only
> checked if fmt was a null-terminated string. This led the BPF verifier
> to incorrectly assume the constant format string was valid.
> When the BPF program was actually executed, the out-of-bounds (OOB)
> issue reported by syzbot occurred [1].
>
> This issue is strongly related to bpf_snprintf(), therefore adding a
> check for an empty format string in check_bpf_snprintf_call() would
> be beneficial. Since it calls bpf_bprintf_prepare(), only adding a
> check on the result of strnchr() is needed to prevent the case where
> the format string is empty.
>
> [1]
> BUG: KASAN: slab-out-of-bounds in strnchr+0x5e/0x80 lib/string.c:405
> Read of size 1 at addr ffff888029e093b0 by task ksoftirqd/1/23
> Call Trace:
>  strnchr+0x5e/0x80 lib/string.c:405
>  bpf_bprintf_prepare+0x167/0x13d0 kernel/bpf/helpers.c:829
>  ____bpf_snprintf kernel/bpf/helpers.c:1065 [inline]
>  bpf_snprintf+0xd3/0x1b0 kernel/bpf/helpers.c:1049
>
> Allocated by task 6022:
>  __bpf_map_area_alloc kernel/bpf/syscall.c:395 [inline]
>  bpf_map_area_alloc+0x64/0x180 kernel/bpf/syscall.c:408
>  insn_array_alloc+0x52/0x140 kernel/bpf/bpf_insn_array.c:49
>  map_create+0xafd/0x16a0 kernel/bpf/syscall.c:1514
>
> The buggy address is located 0 bytes to the right of
>  allocated 944-byte region [ffff888029e09000, ffff888029e093b0)
>
> Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf"=
)
> Reported-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2c29addf92581b410079
> Tested-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index db72b96f9c8c..88da2d0e634c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -827,7 +827,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size=
, const u64 *raw_args,
>         char fmt_ptype, cur_ip[16], ip_spec[] =3D "%pXX";
>
>         fmt_end =3D strnchr(fmt, fmt_size, 0);
> -       if (!fmt_end)
> +       if (!fmt_end || fmt_end =3D=3D fmt)
>                 return -EINVAL;

I don't think you root caused it correctly.
The better fix and analysis:
https://patchwork.kernel.org/project/netdevbpf/patch/20260107021037.289644-=
1-kartikey406@gmail.com/

pw-bot: cr

