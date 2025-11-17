Return-Path: <netdev+bounces-239226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A88C661E2
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 248B24EE1C4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D734A789;
	Mon, 17 Nov 2025 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9bx/ke7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00F337115
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411878; cv=none; b=IYgGb97RaJgHq4xbeRX6xqVj0xKFAj2/WHq2D4YUd9Cai1biuzd8OKlLpCH1JXn0+ELuF+6vi4axIFNIAM5JohsPmTwW+mRv8tSTuB7CtA7Yc4fB/zxY1KIdK0H+/mIitzj/Wf1D97+viR4kRk7kV8dcWkh41ZjjJhrqI85LjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411878; c=relaxed/simple;
	bh=H/afEZR5OmgO/wo5DvDvxHGKpoSvl2of+lDHotKOlF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxLvShCOM34UMjG8qH5ojWvVO+DR9QAtLDtOrx5t2vKHeAnOpH0Vff3ca/WT/7AlHQPNJMZFo4PJtznc/PAdyxyemhUOLOoJO5nVdg64cKDT4iE2O1K67e4g9mB2TD7hKFROlXEuMB9M16nhdtj2EZz/wmzibeYb21g3VzeN7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9bx/ke7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787da30c53dso42054677b3.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763411876; x=1764016676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G7F2FD762ATHSYtcqKtqrP8NQoTU2y2MIUTzfPOLk0=;
        b=W9bx/ke7ECoGYxxtPymKHQBMtnrB+aNh0HDzYLApKu5G/N2L/0m9VmxLP+bHfCuPnz
         pTf20byHJAqEmOg01Jdn0Twwb1EvonKItbtHT89+Z9rL0lDICoOQZ3ap+ENMI5YFLQo8
         g0S7asns9RyGp3WoCFwO1kRE9MR/GAC7586j4TAPcpX07K2Hxu4TF7RQieOI17EC7QUM
         1u51hACwF2I+LtpsRCrUVN4nUBIUhiz7CUJFgljcvv5QVfuxwV9sXzl6uzjZj4Xnn8HQ
         +6Tqc4rugYhFZo+yOEfH6OoqfsLIY5LlrzSBF1ic6/k+ZM4+8he2sEby3GbGCEunBgTP
         XkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411876; x=1764016676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/G7F2FD762ATHSYtcqKtqrP8NQoTU2y2MIUTzfPOLk0=;
        b=YeHPlXI/5REleeVD0Yccn30UC0SHjcKr4hI3zsR2mJNElFu5ljwq761fRvWtgtEv6v
         OhJO3qc2DizbbUyViQhdIUUxQJ6rYt4CwwpWYv/C27w1Vi6AZm4R8NHZ1G7x/0XuKtEI
         YKxb1J7sMjlCaTpBbfu85kYE+ftAhHBzPrD9vYF4MagT0s3Fp7Cmgmg6JBJ5XvOR6eeo
         EbuQiPeRZ2aS7KdxLQppBNUw3nRMyRztBWMurbzJIs9ZHhsVHOfVYVZGwtlv6Q5bqTx+
         +aelYg7OqsfC8JvvBnPWf5xjrwEPCNlwW4JTcUKyfcQ3TTvMMXrJnXrt3Qa/U7S35y2n
         pYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1TDlTjXMowYePLxy/QpMc7RvrCtKVpBJuUbjOPaombL5yHhhvgzmgrPkYH+U6o0TXUOhYhR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgvr6yxi9UCmQiZ2qCaBHEiM5/htZ+8xxud6cX69VTqJs/go4
	KGRwJN2m0ysac3ivj+CLlr9mJhm+M1GU26wFEnLGM/SA6j4jaZMInOkl3s91MqBVfyOs7q4xPHE
	dA7ZG8d3i7rPFDxMK0HCWsfSjOP4FQ0Y=
X-Gm-Gg: ASbGnctWcxVnsHoilmOR97kFTDPkHFwAH2vshqM1K+k/PIJ96OfSKDUpkj4Cd9IvEC6
	6uAB+MBXbRtsaN18RMTdsXR2ixlPBJsAt3ZlDQZz7hYuvzyXGJeWYUywTJs3z9t+W4DvX+h5Jow
	XnLsaDT/UuI8TJ2157vcqhn8O1FAmznIjiL61VnDB83JfpVqWswAS0ztXf8NpvVJhnfVv1hwjgt
	pqLwJ2ea/iHm3cHX4oGOgaDTmujI2Ztc+TIPrcs1wSQJuwCO7sSVq0426d+zeyHQMrVR4E=
X-Google-Smtp-Source: AGHT+IF9+DjhQ2mJHMvSlt32z3465h3hDBrldQe/uo/mhFLfoUwvSkzy/W1sfCZo1iFj1BbOXTMO7TJhlLiFBBTm3Gw=
X-Received: by 2002:a05:690e:2404:b0:63f:b366:98c9 with SMTP id
 956f58d0204a3-641e7647fbdmr8900359d50.46.1763411876000; Mon, 17 Nov 2025
 12:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114201329.3275875-1-ameryhung@gmail.com> <20251114201329.3275875-5-ameryhung@gmail.com>
 <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
In-Reply-To: <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 17 Nov 2025 12:37:45 -0800
X-Gm-Features: AWmQ_bm8IQ1uClD5PXxTcIm34tm9sSz0_99U1zoPJRrkD9ASAdNQ6MA1IvgW7Fw
Message-ID: <CAMB2axPEmykdt2Wcvb49j1iG8b+ZTxvDoRgRYKmJAnTvbLsN9g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 12:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> >
> > -       if (smap->bpf_ma) {
> > +       if (smap->use_kmalloc_nolock) {
> >                 rcu_barrier_tasks_trace();
> > -               if (!rcu_trace_implies_rcu_gp())
> > -                       rcu_barrier();
> > -               bpf_mem_alloc_destroy(&smap->selem_ma);
> > -               bpf_mem_alloc_destroy(&smap->storage_ma);
> > +               rcu_barrier();
>
> Why unconditional rcu_barrier() ?
> It's implied in rcu_barrier_tasks_trace().

Hmm, I am not sure.

> What am I missing?

I hit a UAF in v1 in bpf_selem_free_rcu() when running selftests and
making rcu_barrier() unconditional addressed it. I think the bug was
due to map_free() not waiting for bpf_selem_free_rcu() (an RCU
callback) to finish.

Looking at rcu_barrier() and rcu_barrier_tasks_trace(), they pass
different rtp to rcu_barrier_tasks_generic() so I think both are
needed to make sure in-flight RCU and RCU tasks trace callbacks are
done.

Not an expert in RCU so I might be wrong and it was something else.

>
> The rest looks good.
> If that's the only issue, I can fix it up while applying.

