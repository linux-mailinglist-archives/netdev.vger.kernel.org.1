Return-Path: <netdev+bounces-243345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA7C9D778
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 02:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568AD3A726E
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 01:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184581DE3DC;
	Wed,  3 Dec 2025 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc2hiE6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C6155C97
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724128; cv=none; b=sK5g3MjY+aK1nzwg5jYkHKA/3vuLzGfniYCFlsSDhVMFiIpBFFwGNmHtsAfpJ4L5YGeUu6wm6m1Sd90bxbUPKXyasdLs07U8isqL3O7H0RYsOHjwmoj9Q5HwVZooYDfj/KvKAhfzaefAuA3/i+5ibAy6TyotUUpfeEvQ/qe7dNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724128; c=relaxed/simple;
	bh=rQBTAgJOiuh0kbrtjtVKx9aAufMuNrbTiT6AgBHP0Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3R3qqmp00NfqiYmMHF1JiEP2v2Hs6ByWaqEzE7c2lZVRXNAfcxGN/+KOFMfKCdAC4ZLOCeoxPKxOkNiBb1QssxKe657IGEZgQ/lfxaFv6zy2Qlvfp77OYS4GdrLCfILUnaiGfdhBderKqKPr7bE3WX6SXNOgW7JHjQNiNvJZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc2hiE6b; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42e2d44c727so1651834f8f.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 17:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764724125; x=1765328925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIi6UIN9E/Isqx0YiTULoC3prR4kNRXtnKzNbGPgQoE=;
        b=fc2hiE6bICgGFujg6FlqH3aopkV+gv+sRNjmX1097pnjzsxGSLGYHplduD8M76sVGT
         gsU5yKRTeZN62nOaS115mVFQ01plKucvQEc7yD0oy0m9ekg/P6FKTN8RcqKmov/43JWQ
         osxQRkbBe0jSh0QmX4wIcMhzWmt/v6OjhpVIOU2BXawUBh/TWvDVPKbAyPy6bU3nPcHl
         0Rl4mEHk7hpj+N9Z3B7eOXLMg246mPKmQBcQGWRkalPDO0RPaK5jsJc/ByPH3vqDmc8M
         im24TbeATX32Kv3gW9LTWESk3m218Z7T4PWJ2sKPoa6DvlgvZbLWHgrNr768wUuiJL0O
         3CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724125; x=1765328925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIi6UIN9E/Isqx0YiTULoC3prR4kNRXtnKzNbGPgQoE=;
        b=J1ZUGPCCMfKRpwZvtl+0M2YqXSiG/gMGpY9o7oXRyVEKjz2DexbNmciSgZdtcXdBBE
         BsexXdT0lSn5sqxhclgY3fxIcc4CXRfCkeGG6PcdpoeCl86VuZlc6Wp81Zz5B96L0hHj
         ydIH0eULeExrAChsdVLKipUZoHdN6fsP2S3OW9rdhGatRgL4yRmU3Ql+3qefvMkDhg5T
         fq77hhAnnE2b+tTR0/WiTumocx44IMCgtHrShUoOREEY1SF8GkN98eH+Q5gEUBFA3vU5
         rpLt+DSGt7xulN/SWG1RnLTrP1V8sqYL5KXdk2kqzyAH+VI8fnfXcZKPWJwcWXq4RGhh
         /T1Q==
X-Gm-Message-State: AOJu0YzgGnTnd6aRZsRRpP6aldKhXr6T7tAu0IGJWenAFQSrdC6c1jbE
	3qY2zs8wUQtDX39LbaC8sYlLwyq4hs/cLANiDf9hhCVBEZ9XJKD9XBp/BxEgQ6V9RkUcDIkfoA1
	wuqR3MhYuKh65wku8PH1EMT3+Sjg1YPo=
X-Gm-Gg: ASbGncsMhYnIXkBlXrJeTyBW40LIxj9uqPScsP6ROiLWP0h48gfQ9F49tj3wNI0iDjO
	LGviptMXVIylu4Ou4Gtkftv+pargB68CnETIMY0rJl6lIVeQm0Jv8eeQG33w/tsWyaAh50SeGxM
	YqT2Rk+C38ZQbEXFY9PsdMDirHyDfkKLcEXsgV11xge+k+KPHJfEqcpab813K2sVZzds9dI7vaD
	q7upN94LAnb39N+TeGqPJReb6YyoUtdDhIuo+mUomoTZA0W6zPlw6T591Vdr7OStxysdXw0Y0Sn
	076aU9ZU491ALVg9k6Oif5Llml5H
X-Google-Smtp-Source: AGHT+IFndPLQVWBUqAW30QfS8nMWTQ4Ktc7AzLZ8be9oL4PguH/Rq3CbkaD4lvJMzSdMkqHaSQcTfWTomd5mEdWBNvo=
X-Received: by 2002:a05:6000:613:b0:42b:5448:7b11 with SMTP id
 ffacd0b85a97d-42f731e92f9mr230436f8f.33.1764724124719; Tue, 02 Dec 2025
 17:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128160504.57844-1-enjuk@amazon.com> <20251128160504.57844-2-enjuk@amazon.com>
In-Reply-To: <20251128160504.57844-2-enjuk@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 17:08:32 -0800
X-Gm-Features: AWmQ_bns2SAo6GhwUZ9QnewKZ_mMKAN-b__gi9s_jqQeY9pFkzYBhc8BDM32WQ0
Message-ID: <CAADnVQLjw=iv3tDb8UadT_ahm_xuAFSQ6soG-W=eVPEjO_jGZw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
To: Kohei Enju <enjuk@amazon.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Shuah Khan <shuah@kernel.org>, kohei.enju@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 8:05=E2=80=AFAM Kohei Enju <enjuk@amazon.com> wrote=
:
>
> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>
> However, __cpu_map_entry_alloc() returns NULL on all failures, and
> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
> As a result, user space always receives -ENOMEM regardless of the actual
> underlying error.
>
> Examples of unexpected behavior:
>   - Nonexistent fd  : -ENOMEM (should be -EBADF)
>   - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>   - Bad attach type : -ENOMEM (should be -EINVAL)
>
> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
> and have cpu_map_update_elem() propagate this error.
>
> Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF =
program to cpumap")

The current behavior is what it is. It's not a bug and
this patch is not a fix. It's probably an ok improvement,
but since it changes user visible behavior we have to be careful.

I'd like Jesper and/or other cpumap experts to confirm that it's ok.

