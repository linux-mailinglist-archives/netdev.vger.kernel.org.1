Return-Path: <netdev+bounces-241638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4704EC86FFA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D073B6873
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5418933BBBA;
	Tue, 25 Nov 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzE44jCt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A633BBA0
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101849; cv=none; b=eyrTMcI4t1fnUz5ztDNB4uf4IvFy+50AnW5BFEOgrw73WlTBOidQpDyR37G/v9yMl3Q6cUlCDdPo5jTFnCm9bVYwE9EacfXgGeNxwO84Z85n7hh/7Al+eRxOJYdNmgibFJnudlruJYrxAiyjoYQT5RHeyY5oiaA8Zcvv+g29XZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101849; c=relaxed/simple;
	bh=1PzS2N+z71XNXdUPEBhTGgqytzUXhsvPwz6YdnjW6wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejcLfPfMMrPaF/gwppxsT8+MCoqdlAPlSZgPV/0Dajiu64FCxhWmOmBodPKiIj+3loBoTyZprmLhTQcf83x//R8ydgMSmKpLhhbZFPSEzjk1KvLGL3VYKmpI6xf/zuCL8NtawkxCbotMBZ32uvjjQAGu15/+pu0H3JqcN2Tx/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzE44jCt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297e13bf404so37305ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764101847; x=1764706647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKPb/Q8XRwdHjj4wOc0hfpXR1h+irCkwiFy/57BQFpw=;
        b=nzE44jCtgkbOMfUfyRqOiahP+sBeomlItsYXFGOzJlQQnLPu9Rg4/SJvXLgFtautnc
         EocDOQxh5uFGetDSDM/fZFxu10ADsCIfkBnS/hDZ+qXihamNbeuAecp8hwYtmGN49BeR
         HBhUpoYSll8B08OcnLCKEDdMyWISwEthZrFOLivRDpjsucblbkxwLIeKL4+N7Tfp2/n1
         UYPUihG7fTZS/HcUD4qKLPgmQbgsRUXNhNRiOmWd69KDrUVjcrhVQPsOGrnMNpmBOJRi
         6BZ7VgHtXaaCpZyPJka4KJLFnYySyV4+MiFYFkc0kWlEX2FHyBUgwHe+oGx4p7eEF9ai
         QrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764101847; x=1764706647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKPb/Q8XRwdHjj4wOc0hfpXR1h+irCkwiFy/57BQFpw=;
        b=taQad9v5GVvNzRp88M6vLfDvNTPwSLsCD8fdJKM/b/PvzZlBNFq3Fm+9aqR5sorDvL
         6h6H/grccMB4FTsCRDp0j7vg2/h8UlQORlTjn6whClQuTsp7YeCL+UXXPDgZjPpr538x
         3pz1X13Nh91lrMmER6gKxtiYUCRnWjl5dQMaZ2s6jTigvjHjOEeHpjhxOfavcxhVHZL9
         XOyLZ8gXWTKQbEhbaztubZdYmbQpt6qCsxkv6FFfuDN3EA7byoaRIKgE99pK0onGlS5U
         PekAzsK/Bxe09EMEl5JrZCy2VG2y86pwExoeWh7ZCsfIuGfOSYrue4r8c23CigMXq/Zv
         xZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCV9gMuo5LTgEqnixLdtB62MoHp9jku7jcTJfT+wpZf9uctgoUcc/i74nnuIA0iP16u73ino0p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0tqMbAd2KJWTO02DcLry79qGma++aQtPsGiu0CNc1pINyJS6
	7RWgyShoOkklZz8HmtnOGBNbx3n93E1ktXyi5duBjBL2RkCTmvGYwWN2JIi4KZfrju1UUZdzEHa
	xNJv+BUuO7cZEzD12APVqp90fL52x9WLoD5gPUcM6
X-Gm-Gg: ASbGncvnB8872EvnXeBS2loLnAstD68jfoYFGaxeycjOyfx/dgaexi5J1uisX1EOnIU
	ROk5BF6xh7U6xHkoLbbNKBRH5PJCE8GOsHYuc+WhPJYHNZcf75erR46G4esihLZx2Or2tIqA/Tz
	tjcoUWKrdEs2xHGeMg/R1sTLImaudIUYaYRXccdSY0VO8KomxSW0xt6z+imaeptplS906RkcN3G
	+jBVcc0cmv2PAEIu0RZytCemA0QBZszFD3cY2Y6eUo+2H/zZdSuvZ/2az82Gbd3kByW
X-Google-Smtp-Source: AGHT+IHvmsdQ1i3sD44wFN96KNygmmjaSKAmQ7+dJALul4ekMXziswltg2TxCwyuISJIXUpB3n1Fat9tThTJe8VkxCI=
X-Received: by 2002:a05:7022:6288:b0:119:e55a:808e with SMTP id
 a92af1059eb24-11dc32ab12bmr24513c88.11.1764101846546; Tue, 25 Nov 2025
 12:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-7-samitolvanen@google.com> <2bcc2005-e124-455e-b4db-b15093463782@redhat.com>
In-Reply-To: <2bcc2005-e124-455e-b4db-b15093463782@redhat.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 25 Nov 2025 12:16:49 -0800
X-Gm-Features: AWmQ_bmVA2aVwPCG9RhBv6ys5ciK8JJKLwfzgItOrbXov_WtENqGlXcwruSRAdo
Message-ID: <CABCJKudpUh7i9PTWV_k5ZWehkyRvHcRTwSOWQu_1yjCE9h_bTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viktor,

On Fri, Nov 21, 2025 at 8:06=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 7/28/25 22:26, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
> > indirect function calls use a function pointer type that matches the
> > target function. I ran into the following type mismatch when running
> > BPF self-tests:
> >
> >   CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
> >     bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
> >   Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
> >   ...
> >
> > As bpf_crypto_ctx_release() is also used in BPF programs and using
> > a void pointer as the argument would make the verifier unhappy, add
> > a simple stub function with the correct type and register it as the
> > destructor kfunc instead.
>
> Hi,
>
> this patchset got somehow forgotten and I'd like to revive it.
>
> We're hitting kernel oops when running the crypto cases from test_progs
> (`./test_progs -t crypto`) on CPUs with IBT (Indirect Branch Tracking)
> support. I managed to reproduce this on the latest bpf-next, see the
> relevant part of dmesg at the end of this email.
>
> After applying this patch, the oops no longer happens.
>
> It looks like the series is stuck on a sparse warning reported by kernel
> test robot, which seems like a false positive. Could we somehow resolve
> it and proceed with reviewing and merging this?

I agree, it does look like a false positive.

> Since this resolves our issue, adding my tested-by:
>
> Tested-by: Viktor Malik <vmalik@redhat.com>

Thanks for testing! I can resend this series when I have a chance to
put it back in the review queue. The CFI config option also changed
from CONFIG_CFI_CLANG to just CONFIG_CFI since this was sent, so the
commit message could use an update too.

Sami

