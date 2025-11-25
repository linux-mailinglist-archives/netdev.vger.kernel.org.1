Return-Path: <netdev+bounces-241699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C4C87796
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B403B4370
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21192ED17C;
	Tue, 25 Nov 2025 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNRme6jH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADBD1DDC2C
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764113708; cv=none; b=eQ8aco4aoDMkkN0pxyN/3EeissHgTVuFkzlVU7rTKck5+lNRsR8juBljWzhkm0ycjQmT65e4d/lD6Tb/Jq6o9NViQ3eJMGEobERGC0UMUJ0PisFfPlZjkplYQCpVa+LLvA8grlE8n+gFS/Zw/NU6L9uwqAO6omt2LJ8DyNK5jnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764113708; c=relaxed/simple;
	bh=C+mZJ7Ei2aBD/P6+5pyK1SNgXoEz8GNxaGMjrFGvhDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOl97/b6ldMk+5OVXWhXWYKrF3yN2ZN5buojIYwJ4HSRq5lNJgJuYHuqgSpIaZhc0LFb415HrPyMdvQtexm/XR6AMRt0cJM9HGhshZwYOZ5dsjOq/ILHpjxGsbeMTrhIBC/R7V8dfv2HHj1tCc1tjsHV6Qfhwjq5m/4QYJPRoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNRme6jH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340ba29d518so3848342a91.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764113706; x=1764718506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDqsvr1920JjRW/8/NnElCXEKY/tSMm4ImZmdUq0Sf0=;
        b=GNRme6jHqm/2D1ebs9OEZpUbuRpbs4aHcHakqmZF2RVR5cyz+Iv3+6U1kKo/PmgVvo
         mcgGith+35+rhaYzgYzOS+9A6r4Mo4gUtZzgpSL/1gfqELJASxuWKE1L5IWfkSJCfPwL
         Pgoit3q+T6laQJDPrnSy2Z4I75JJArl7vVkc4L7WqGIIFMvT+ruTWSFFBsRUQ46WNhVa
         QNJ0Rst9zM2BPCsZJaUTQb/Nn/FjtsVD0kRDL66jTBB6wJmON4sMqEU49Bu9vV3J6mxm
         6T3VomdI4d4zdQg2iAxfJD4z7u4llYQnDcJegHhYvLEVGhRewjnmYVfraOkYhibO5oQQ
         0c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764113706; x=1764718506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZDqsvr1920JjRW/8/NnElCXEKY/tSMm4ImZmdUq0Sf0=;
        b=oIyosqs2E6/P8jaqDWcFGVo5o3syQJa2MNmqwejTUhm7EybtfB6Bq+4j135YWqnYfA
         X9jPdFaeKEaFuCz2EJxde1zxdzuKVVRj4QXTGFsMmoZ3Db5l/YBUWa2Z8vwkOEnIPYEa
         ti+MKgvBsj8kCCq+03hUpxkYa+TT9JK75MeSQ17xO9ESUv3r4dJoY3zYyyNkAJK4lfTI
         P3tyvP3m/WybPwd5Xa2kqYmbAMdZLC/NBJbQjy+/BgTpDqX9vZtcOAJwoKRfPQoVYKj+
         CHHcDw2hL/+xakdauxQaqBBoK58uL6kpfHla31iAW5+osyIA50e27jO/jul96vV9uWm7
         UpXg==
X-Forwarded-Encrypted: i=1; AJvYcCWoHrs2yOLeNGoakUK98J/MCUoa7slQ1MzaivyXYrvjovY0mywBswnxOKEWl6+dwG4EleyiOvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ev5kND10yixrmjUs7hImi2Peir7P0lRk6ylNcouQgiWKmBR/
	jDybcQvd/CPLJ5cJ8JqBu77181YWppBTbcTafBMkcxIrXVjsaAZcFp/qAm8J6Wm1hzyBC4dVlfs
	0FIrCBuVjqwZoNuxPr9GlCSbv3STIkMc=
X-Gm-Gg: ASbGncvQIDR4ITUOBHfLhyb7ODuEnUwitjtBJp81T2ogEjbjGG67D8O5ySsEXQqFA5a
	YUdx0GKPBhnUEbtKmQUC2MSnhS08SEsmuT/OFr7qadqpWDDc+4MOOb4qAOCEEZM9RXOoX7WB/mX
	PNUxkZ7mCT6KStKNs3ax7w0cDVasrofhHbQFGSWhQCUl+CMV7IYpoYKA6sknv0Utsm9nqZbB8OP
	WBn6RGEgszxGvOjKUTMl0MgKOdgF75N/kASbbUGXNwQEMj+upeiXCM6aSJrbMd5fAYIY7YgauVR
	vRVIZUAcC78=
X-Google-Smtp-Source: AGHT+IH9ehM7VoPyOY+zY9PcgQ2CgMl+AZnSJmtRRthtdUFnP/8h2w/C0Djuh5wJEQDSTpH/K4RPRQ86kSL7Z6xxjL0=
X-Received: by 2002:a17:90b:5404:b0:341:124f:474f with SMTP id
 98e67ed59e1d1-3475ed6bcffmr4141117a91.32.1764113706243; Tue, 25 Nov 2025
 15:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191515.2934026-1-ameryhung@gmail.com> <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
 <20251118104247.0bf0b17d@pumpkin> <CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
In-Reply-To: <CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 15:34:52 -0800
X-Gm-Features: AWmQ_blXxGROrL4pjDy8uJxN14iXeiY-DY73x2QGt6MkDuyy383S8RzRc9I57YQ
Message-ID: <CAEf4BzYmi=wJLpz18_K1Kqc-9Q4UKbq+GsyVH_N+3-+_ka0uwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
To: Amery Hung <ameryhung@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 12:12=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Tue, Nov 18, 2025 at 2:42=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 18 Nov 2025 05:16:50 -0500
> > Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > > On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:
> > > >
> > > > Locking a resilient queued spinlock can fail when deadlock or timeo=
ut
> > > > happen. Mark the lock acquring functions with __must_check to make =
sure
> > > > callers always handle the returned error.
> > > >
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > ---
> > >
> > > Looks like it's working :)
> > > I would just explicitly ignore with (void) cast the locktorture case.
> >
> > I'm not sure that works - I usually have to try a lot harder to ignore
> > a '__must_check' result.
>
> Thanks for the heads up.
>
> Indeed, gcc still complains about it even casting the return to (void)
> while clang does not.
>
> I have to silence the warning by:
>
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wunused-result"
>        raw_res_spin_lock(&rqspinlock);
> #pragma GCC diagnostic pop
>

For BPF selftests we have

#define __sink(expr) asm volatile("" : "+g"(expr))

Try if that works here?

> Thanks!
> Amery
>
> >
> >         David

