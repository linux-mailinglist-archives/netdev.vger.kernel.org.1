Return-Path: <netdev+bounces-211987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA3B1CEE5
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 00:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322EF3ABBD7
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764BD221269;
	Wed,  6 Aug 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M49FBrr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B91A5B8B
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517719; cv=none; b=LvXbLr76sy5SYaRFd954Hj9Rn3IgMlqxEZhwA7FCJLMhQ5H0+vlAD6qa1dah7Pv/yYopSwa/x0F+ms3JGf1gX9taSI4KxpPncL/f7Ht43lR0dNuyQPwK37+xN7rVKFMh91H2iNBuo140dbXq/2ftD/32Piq/5ARuaBSLJugNklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517719; c=relaxed/simple;
	bh=wxmbacTzB5m4yxerqFQOHx/HCzp+RS+1K80LXLTDWKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qb3GMTyfEDKn6xNtgPLDE504bAmlRjfD9EPg57AL8Xw55JuQmt/dM0f9bf0DRWgha1EqMK3MZqoFcPJuuXSP2NWFbeLoi3LYI0PNXorjFNckhm+EseyArUhvriaikaFEVBfGHCyYhALbHGu/jqxRHUTU4OugDPzKXL5ad6j6igg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M49FBrr2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b390136ed88so233588a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754517716; x=1755122516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS5sWoIyqI1LV97Jb4CN01ckOCIdChBVFk4TORl7K0c=;
        b=M49FBrr2sJ1DWx1r01t3SqTDILRkjGBdq5F4fypoXqFdvtsruxWgOgsgPBleKgy5er
         r8cCnRa9z3As7ZQ36RbI9wcWO6XI6TvVMggz/+5Gqi6AkMLWc0hdesyfjaY36xNs7d1u
         BJFxoFczebMjHikoxnSQxu76fq9yn7tyvxLsxA3ZV1cnloJV0MYFnJrwXNLmWEzGVVoN
         q8A2KCbUIu02xnGgOc0XO84jln02JKc5rqE+btQHyh6B0lg5aO5QFNEef6Mn1mpb8HZA
         2tduLvpB9mCvDvHnb+46rFItJRQy296R6WP20xnN2F0wi6rTPzGlAn+oDVqxBHlK7A1D
         Xx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517716; x=1755122516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS5sWoIyqI1LV97Jb4CN01ckOCIdChBVFk4TORl7K0c=;
        b=duDfJR+f9VvQ2rPQkLtWPS4LluzKwmGLcBU93khUHB5RFHP73swSBBTq0lXIeMLElY
         TPDn4Hi7VHolRt91/puzyaFrdUY7tu1pbJ12CTNblRXQNC3sxZM/bzEgDXhBoKh44TJK
         3f4nfPdjdMGkB5Or367aThKbCJk+czS/SL2eGyksRzloNPEJBH8p2NohoZIM5gYBXasg
         KKJcGeIFuN/mDAGTfgG7LA6CgVK2IxR6fXrUe7+ePSGs5iPtq04LOcy3WES+Y9JwWESE
         QaGhZf0v2dmvvIflZmTu/gYjDKGPAr0J3n815xb7Hgrrh4msVy077DbhD7EYINSvldAP
         Z/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVq1vwlUkoCFnJWbU6R99PJsO3s/4YHVGECq6GgKyVIKPJRP2w6d2Q5CFw8IykOu7cuCXtnxxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNK7zpE3UC8sOxxCcsuLiPioQn6RffcOGJgQsSziP3XM67SNV
	kS1ua3xcAQf7gYf1jNnPmGupp052DELzafJ5+1KMk/S6rGfieKjad7YRB21ibIwuW3/MMcy0nZz
	/Yzect7NIWRcsWqPOPs0o7SBvF8cUL9nbtzF5/I1D
X-Gm-Gg: ASbGncv8XhjQ8NBs2o9zkWyP0fS6Fl9PYNA/yoRCTatnyK2dbS5BMUfUvFUrAPpgWVx
	sJSjHRj2qpMKvbwA5nDkNd6CVQawFQ2zs+1R8OW8pOOcrI+vJnQVZOK719MA4GUtG7IWxpihAnR
	fde/qmhdcrv1Cq567Vek88vbASdsseEV5dcc209Sn56xiZBjdopaGpLlKGnIJf9in2eQxdpdW/w
	+ybFey4YIuNVrlpaVDs2UR1AEwgXEcLLwVZcA==
X-Google-Smtp-Source: AGHT+IHSk7dzFSFXcu4X48id9sXvSiAxg4OZ+/L9B0Yq3eL15/6jfV7hChGejTL37W1MR4sOHnmzKtJZuAb4DsrqR74=
X-Received: by 2002:a17:903:2f89:b0:23f:d861:bd4b with SMTP id
 d9443c01a7336-2429f2d99a8mr55381415ad.5.1754517715836; Wed, 06 Aug 2025
 15:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com> <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
In-Reply-To: <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 6 Aug 2025 15:01:44 -0700
X-Gm-Features: Ac12FXyFJKmVEi3oHI4ogHBbfqPpbXF9V_pMaOAaUcyE_TX_Or4bugRENLRs7x8
Message-ID: <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:54=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Wed, Aug 06, 2025 at 12:20:25PM -0700, Kuniyuki Iwashima wrote:
> > > > -                     WRITE_ONCE(memcg->socket_pressure, jiffies + =
HZ);
> > > > +                     socket_pressure =3D jiffies + HZ;
> > > > +
> > > > +                     jiffies_diff =3D min(socket_pressure - READ_O=
NCE(memcg->socket_pressure), HZ);
> > > > +                     memcg->socket_pressure_duration +=3D jiffies_=
to_usecs(jiffies_diff);
> > >
> > > KCSAN will complain about this. I think we can use atomic_long_add() =
and
> > > don't need the one with strict ordering.
> >
> > Assuming from atomic_ that vmpressure() could be called concurrently
> > for the same memcg, should we protect socket_pressure and duration
> > within the same lock instead of mixing WRITE/READ_ONCE() and
> > atomic?  Otherwise jiffies_diff could be incorrect (the error is smalle=
r
> > than HZ though).
> >
>
> Yeah good point. Also this field needs to be hierarchical. So, with lock
> something like following is needed:
>
>         if (!spin_trylock(memcg->net_pressure_lock))
>                 return;
>
>         socket_pressure =3D jiffies + HZ;
>         diff =3D min(socket_pressure - READ_ONCE(memcg->socket_pressure),=
 HZ);

READ_ONCE() should be unnecessary here.

>
>         if (diff) {
>                 WRITE_ONCE(memcg->socket_pressure, socket_pressure);
>                 // mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
>                 // OR
>                 // while (memcg) {
>                 //      memcg->sk_pressure_duration +=3D diff;
>                 //      memcg =3D parent_mem_cgroup(memcg);

The parents' sk_pressure_duration is not protected by the lock
taken by trylock.  Maybe we need another global mutex if we want
the hierarchy ?


>                 // }
>         }
>
>         spin_unlock(memcg->net_pressure_lock);
>
> Regarding the hierarchical, we can avoid rstat infra as this code path
> is not really performance critical.

