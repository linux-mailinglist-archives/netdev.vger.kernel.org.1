Return-Path: <netdev+bounces-239292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02CC66A7E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C4FB4EA8B6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB952727EE;
	Tue, 18 Nov 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDYnXp23"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC9273D6F
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425510; cv=none; b=ihVANbj4JuuRIAGiX8ko3LuxSiEAeRmz5DWVXQ2H9m5/fzFn+KpY5YkpFd+hg8ovpADL4gqEz3JREIPZ2+Pp4GUkQVfMdXYemkyWfaNRDyEbZE6Gsb0ySmu4cmpGa6+WpjL7nG37hR4SHd3b0Wk6CvUNXy0pu3X1dIQJMAHppec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425510; c=relaxed/simple;
	bh=4mzWxm0FExzAVQfP+Nggm4NdLPQI9ceVCiBNtj72gag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYEERnhsdYloIb2SerN4afYiV7Iw5iOVd1hCdPf+EmIkY65CEBhahNa/x9xbOC/lyi9qXzBobBkNvyEy76aE2iSnAxzVEkSPsuiMBqiJJIYZyPryawjxyWK3iPzB0Gja6Le1HWh3xVFuS6/eUo/LuaJv5IAuGpvhaEGoxpNttCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDYnXp23; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-787df0d729dso49250707b3.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763425507; x=1764030307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXfCa+oVsDITgwK8E28o89vmmOunafNUqzYLlmnNM/U=;
        b=ZDYnXp23Qe5lguiuBJvK3Svm7I3EnDmSpwh4WEPt19man5kNf+eNE026RKR7NXB46N
         8nWQyfM9QMTJMQvI4B2+ijaQWmawyFtavUpmKkw0Z0D2j2TrFQhGuOAiKnkQl9Fqa2sC
         xqrfNn+QaaDFFAuroy1ncAhRqe5kTXKU2OrecFvsJk4JY61jOVdd3Ymq4GDJ+uxa4pq1
         p02SpiBON5WjjAny6AneA4Sqj7jd9IePYJkI+DVmYbPxaBNoos/ODikTEgwRDrfmV2pk
         6kSNNzcnW3ACl2sWf1fvpzrW0+yQM0DiBnAiFULG9miE+bDkRWDiWKmc8nw6iKjUOUgQ
         Zbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763425507; x=1764030307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXfCa+oVsDITgwK8E28o89vmmOunafNUqzYLlmnNM/U=;
        b=DgW9v8bnrQcK/QOJz7s1x5q628ls/xZUs0gPeOmLg79vFIIDBj01ujAFwZ+PwCfveb
         6dQlzRjq4dy7QTa6cJSsnhKjnCxK9h1FXGjXI/+YYzBWD8pLD8b32QA5SkE9ugcVmp8V
         yYsn/6B7tUpgKtP7RhcpPvvXZGZCV0LKfVMJD0TAQil0/ZMGEgsTaaOtslmuRvqLRzjQ
         FiqMBZdM7GJ6w9DKQ8/jZPKjdd3UBVaVidxzJz1+Pvs9weNIA6wGSg17i0Wew27ERs0K
         5i5Xf35DWR6FaXUN1vTQnH/4WMdd5/xlgKxlI4ixPxj2qYPv3KcNLuQ1cH71oYCrCqAw
         9S+g==
X-Forwarded-Encrypted: i=1; AJvYcCVh02CexapGos2aZFbj+NGDEV0ZRrL18wBj4yDgEtoFRbOi0XAeIxWh85NkZlNEO049RX7GPFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwncoKMJjChlC72AqlldniuBkXxSf87Re8ozhy3mveGIgut+Jip
	gYpekVyQ/DhkdJkPLNkTsmBMxlbHlUUkVHdjAC+Rd9kMLKhtoz6tdqyEwkc0+jVXggvda3BuLZH
	vt2IFtYkJlIRh9IHFLJkK59vUtvURVN4=
X-Gm-Gg: ASbGncvbtlVYzYGJLE0WLM/c6z16Orq5oIa9plWrhCHxPp8cUHh921RHJcU40kGDKLa
	wRC/mxzg5saku9yQU1dsuDiITbGk9DYOY0NTLmyFDWCQdm1Xh6V+veOl89o2Dt6Exbn72ZGb1Cd
	gaI1qovLTS1GoRUfOKHCqXMc+9+pUrNqaUV3OldNQLLV3leWgnsruG0q4IVuo1sN3anT3UVy9Vy
	4rO7VFIyL+S8lmVYBYlKZ0WY9HIQYThZt1XP5AO4a3YpJsOFSj4lAV93iz8tfOP3ivuHeDJ6qrj
	nadQGASCGNEye3sr
X-Google-Smtp-Source: AGHT+IHAbfGoyHsYKH3jzHgG0RQdTWgI5Lr057GSg4HE7cHSIAb0B6av2FDxAkjEWfHyMd+mdAfguAzO/NjFZpbRp+4=
X-Received: by 2002:a05:690e:4101:b0:642:84a:7bdc with SMTP id
 956f58d0204a3-642084a7ee2mr3479239d50.83.1763425507022; Mon, 17 Nov 2025
 16:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114201329.3275875-1-ameryhung@gmail.com> <20251114201329.3275875-5-ameryhung@gmail.com>
 <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
 <CAMB2axPEmykdt2Wcvb49j1iG8b+ZTxvDoRgRYKmJAnTvbLsN9g@mail.gmail.com>
 <CAADnVQ+FC5dscjW0MQbG2qYP7KSQ2Ld6LCt5uK8+M2xreyeU7w@mail.gmail.com> <450751b2-5bc4-4c76-b9ca-019b87b96074@paulmck-laptop>
In-Reply-To: <450751b2-5bc4-4c76-b9ca-019b87b96074@paulmck-laptop>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 17 Nov 2025 16:24:56 -0800
X-Gm-Features: AWmQ_blKF7jNU3eJ3H4uPhlx_7GuSkI4zHWsuVPdxNFvoNJJVys8ZBeiZMnjxas
Message-ID: <CAMB2axM==X6+WJFenbuwTn82=2iRL-5_GCmj5RmK_fsGf07x7w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: paulmck@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 3:46=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Nov 17, 2025 at 03:36:08PM -0800, Alexei Starovoitov wrote:
> > On Mon, Nov 17, 2025 at 12:37=E2=80=AFPM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 14, 2025 at 12:13=E2=80=AFPM Amery Hung <ameryhung@gmai=
l.com> wrote:
> > > > >
> > > > >
> > > > > -       if (smap->bpf_ma) {
> > > > > +       if (smap->use_kmalloc_nolock) {
> > > > >                 rcu_barrier_tasks_trace();
> > > > > -               if (!rcu_trace_implies_rcu_gp())
> > > > > -                       rcu_barrier();
> > > > > -               bpf_mem_alloc_destroy(&smap->selem_ma);
> > > > > -               bpf_mem_alloc_destroy(&smap->storage_ma);
> > > > > +               rcu_barrier();
> > > >
> > > > Why unconditional rcu_barrier() ?
> > > > It's implied in rcu_barrier_tasks_trace().
> > >
> > > Hmm, I am not sure.
> > >
> > > > What am I missing?
> > >
> > > I hit a UAF in v1 in bpf_selem_free_rcu() when running selftests and
> > > making rcu_barrier() unconditional addressed it. I think the bug was
> > > due to map_free() not waiting for bpf_selem_free_rcu() (an RCU
> > > callback) to finish.
> > >
> > > Looking at rcu_barrier() and rcu_barrier_tasks_trace(), they pass
> > > different rtp to rcu_barrier_tasks_generic() so I think both are
> > > needed to make sure in-flight RCU and RCU tasks trace callbacks are
> > > done.
> > >
> > > Not an expert in RCU so I might be wrong and it was something else.
> >
> > Paul,
> >
> > Please help us here.
> > Does rcu_barrier_tasks_trace() imply rcu_barrier() ?
>
> I am sorry, but no, it does not.

Thanks for the clarification, Paul!

>
> If latency proves to be an issue, one approach is to invoke rcu_barrier()
> and rcu_barrier_tasks_trace() each in its own workqueue handler.  But as
> always, I suggest invoking them one after the other to see if a latency
> problem really exists before adding complexity.
>
> Except that rcu_barrier_tasks_trace() is never invoked by rcu_barrier(),
> only rcu_barrier_tasks() and rcu_barrier_tasks_trace().  So do you really
> mean rcu_barrier()?  Or rcu_barrier_tasks()?

Sorry for the confusion. I misread the code. I was trying to say that
rcu_barrier() and rcu_barrier_tasks_trace() seem to wait on different
callacks but then referring to rcu_barrier_tasks() implementation
wrongly.

>
> Either way, rcu_barrier_tasks() and rcu_barrier_tasks_trace() are also
> independent of each other in the sense that if you need tw wait on
> callbacks from both call_rcu_tasks() and call_rcu_tasks_trace(), you
> need both rcu_barrier_tasks() and rcu_barrier_tasks_trace() to be invoked=
.
>
>                                                         Thanx, Paul

