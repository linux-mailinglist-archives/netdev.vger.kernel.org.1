Return-Path: <netdev+bounces-239265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F8C66903
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79FCB35786E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCED264A92;
	Mon, 17 Nov 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnhTdCVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA173093AA
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422583; cv=none; b=OPaCG8IpY6cZu6TTIXc/R06elsDIEUf0hnhJOWsHiaQQqQ9B2HI/bs5jZdog/2+3OoepVS2TZVwHQRapDnc4cVFYIaggmZIQSB9r3ng4tJcmtmWGFGQwNr3EAKV2GFEWL8DrHnxTMwqElgbAo0L+4TPNRBiR6Hw7xJTwZKDRHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422583; c=relaxed/simple;
	bh=dvDswBxG/btwda3Ai60E1wT6+jXBfwo3Ud4F9hlCrdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LumsSSU9MugMNuzHpP1DnQjhuSTolRbEVDTgI+0+MJOBbm6xq9BGUJZdB75ksGisPeWtICCXYKcSFw3KJ56ZmvL0mKNq8xTB3V4IGgUBoUp+NmHc9RtPXI516aVVx8xrOOdYAzS/JxtQveJQBdwRxC5cBJ7ASpiJ8ipoVB+Tdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnhTdCVM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so24515025e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 15:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763422580; x=1764027380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD2j0INhVFK9W4YyL9gKWByj8HQYLmc3TcGpp9WolVw=;
        b=gnhTdCVMdYLKFB/51VJnqhWQ1qQPLnyHm7Xz4yRhsQbfdI2JcSkwlnhVVnInIRalcZ
         7v9HB+XzFAjcFqlkx3rdft/rSCSYLXaCklJnddLJs5VnINSVjVH0o/auoMwiDmz9DF5P
         bGZXwvuUBudquqpg4oNNhDWSjn3F9sZ7jLzD3HrUgO77hAfMknsSAPla9+sGpxB8pQ4r
         51wAsiZY/u/6G7ykcEo+RSEQqOUrp3r0mxWUejQfEPByu3UEvgXhrrQoDBNQD+jKQ8Mn
         tuzxN//Ly2AIaUV4w0CeRRu7XFkXuqwzJZvqlQwQON+qM7dr8SwpFA1g0cemSbOAKCRZ
         4jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763422580; x=1764027380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wD2j0INhVFK9W4YyL9gKWByj8HQYLmc3TcGpp9WolVw=;
        b=ryCgqxEJFRyM05ZZ2zAI2OGKY+MZlJac+yBG6Zutvy+q4Zy4LOwSvdK5B+jwt1fIfl
         4A0yAAO3A5+/fcAFxwexVmbDI/D+29Fbt/2UIl+2iW+ghPCqiq1YySD0nE0tBsl27QoH
         +vKgUyCQYnaJaOoXnhorci7xXwHjrUvqALYk9G7T+otr5eyBF1SOy8pdKbFg9CP4lKM4
         dleio4ElO1j/5gySq4QWF3gRVn+EJ+OMKBC65TXWmGlAVrNaoVlVCzbOTssGYfdEAtAe
         VpRLNxEj+n7hi1TjZ0hrivCYRd8XXQFaAkb/JjqWDchKjxELh1VWRbE+uDxA87xNMpyz
         MPZA==
X-Forwarded-Encrypted: i=1; AJvYcCV2itWZvwGDR9Vx3OYvMn4Pp9V9XBlbs6HO6X+LYIcU09nNKWn6G2r721VRb1a8st2rjQvhlKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcCT05WXpGM+qSx4rJgoo90DRjmxBck7U8MT/gyKz5yjih49D
	oOW5U/COBQ5B+jMzK7CjUK5uj2atkkPxhFSpr406ZAewaJdXGuMhOc4Bx/DIHZwrN0hUzR0uDBJ
	/DAxqRoKcIN3UdBrISCcKjE9hCUYj1sY=
X-Gm-Gg: ASbGncuzp3fQhEj8wgiJyV3rxB61JeIvqFxvXkUJQDGDlsDAb/PGa72hrUguJcy+3wb
	13prZcBwXziSTlPjVBcsy+p5P5yJDNQLqSUPkTorMKTkO/g1Sck7CrrVT6+F+8EUzdSGBlg+SJV
	8avv+sOyY9VjuKB0YUW+4EcVSoa/o/d1/h4AlZlvVz6/zlBFOjHkng86KLkfBuT8oVXsCM5TW0R
	tB/IBuk6ofgy+R8OimtA4X4OgCZoDe1B0wp4Ln0lyEWwgZClbc7zX0FIXkLgOGn89pcbx5ofGOY
	OUTs0y3w
X-Google-Smtp-Source: AGHT+IHWmwKsJOJq7Cro7aBvFC3PbCIZnNHuABuErCA0Fb/nyzdx3fF/EEiqnshVY7WD1ncXFTqvGYKjjFGOE5zQYAI=
X-Received: by 2002:a05:600c:1d19:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-4778fe50bb3mr108159915e9.4.1763422579560; Mon, 17 Nov 2025
 15:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114201329.3275875-1-ameryhung@gmail.com> <20251114201329.3275875-5-ameryhung@gmail.com>
 <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com> <CAMB2axPEmykdt2Wcvb49j1iG8b+ZTxvDoRgRYKmJAnTvbLsN9g@mail.gmail.com>
In-Reply-To: <CAMB2axPEmykdt2Wcvb49j1iG8b+ZTxvDoRgRYKmJAnTvbLsN9g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Nov 2025 15:36:08 -0800
X-Gm-Features: AWmQ_bl1Mcu2D_uXpTbT6jUHtda0p1E6L-Tev-DafrdteNWz5zoJfwVWpvdPCHc
Message-ID: <CAADnVQ+FC5dscjW0MQbG2qYP7KSQ2Ld6LCt5uK8+M2xreyeU7w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: Amery Hung <ameryhung@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:37=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Fri, Nov 14, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 12:13=E2=80=AFPM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > >
> > >
> > > -       if (smap->bpf_ma) {
> > > +       if (smap->use_kmalloc_nolock) {
> > >                 rcu_barrier_tasks_trace();
> > > -               if (!rcu_trace_implies_rcu_gp())
> > > -                       rcu_barrier();
> > > -               bpf_mem_alloc_destroy(&smap->selem_ma);
> > > -               bpf_mem_alloc_destroy(&smap->storage_ma);
> > > +               rcu_barrier();
> >
> > Why unconditional rcu_barrier() ?
> > It's implied in rcu_barrier_tasks_trace().
>
> Hmm, I am not sure.
>
> > What am I missing?
>
> I hit a UAF in v1 in bpf_selem_free_rcu() when running selftests and
> making rcu_barrier() unconditional addressed it. I think the bug was
> due to map_free() not waiting for bpf_selem_free_rcu() (an RCU
> callback) to finish.
>
> Looking at rcu_barrier() and rcu_barrier_tasks_trace(), they pass
> different rtp to rcu_barrier_tasks_generic() so I think both are
> needed to make sure in-flight RCU and RCU tasks trace callbacks are
> done.
>
> Not an expert in RCU so I might be wrong and it was something else.

Paul,

Please help us here.
Does rcu_barrier_tasks_trace() imply rcu_barrier() ?

