Return-Path: <netdev+bounces-83511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60FF892BE8
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 17:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E585E1C20E8D
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B791F39AF9;
	Sat, 30 Mar 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gitmlss/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3EB1E489
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711814513; cv=none; b=ZfMpvvPGXRceDWI1VToTMU084++on6rbw8pgOywTDgGWYqT+ssXDLyfrbxpJuiv9s71YO5+5EH3q7Ni5Xh2hxsidUkQ1R45h9zfeCAgbUNPXF4hdoT+tjtB8C/7m5qiFQkpcpmaLOSzPXRQt+4bv/Ho/jSvkSPGAtqApVJD8Ohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711814513; c=relaxed/simple;
	bh=IKvEF6gLdzJ8edeQX5qexjN3DnUKrIdXjm2MRtDpPAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKCM38MeMNM0s+XcQcIOjMej8wtObhOGDD7I95uNo0xGH6m1sRx6SVvUnWh7XEZzjbHpwUOBUWyKbf20saph6VLTWJaUSCJpqSFeUXgcbLbwTITL/g+TxmXkCPWugbwZGNJd+YXUSkQpLKNwX5UaVlJvJReoEzoqhcJnrwtK0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gitmlss/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c63f4a468so14595a12.0
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711814510; x=1712419310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGchPE1Us7hqkRVthzbd2AGVhkBAnz45ZivNXa88NzQ=;
        b=gitmlss/X6NN1amhELjaDo0OKt2q+tLc/ZotM3GzAaHP5tUySvpbc4ld0FcN1UUmBw
         qnrToAuLGc4/znb/ewH1PZ8TqRjo2tnUxR0i274ds4bQ0Pfh8qdgkXuEwUwdDNAT3x2l
         4/K3tn3iArxRzEXf/4mBvOxK7DRtiv9xQQ9tS0VEvyG7blFFGfFMNhlu5R2Nl1NwfYS6
         jDrgrW5z1R6DtJQMWnxgQHHr92YXRkLTucirjl1Qa1GGk8CfjfMAYPi+VJ7bOAlfCKj2
         eyOBUKQoVjXwNUWrQWlCiz1+FtjX4P3iJYCkU6mFUgmGEMKXRQqS0pKvpCkzOECfPun7
         Zl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711814510; x=1712419310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGchPE1Us7hqkRVthzbd2AGVhkBAnz45ZivNXa88NzQ=;
        b=udvdWilmxB/4pas8SqhVefGC3G6dAlIJF9g6lqFwP+VCMJpPqr3+TKnGml6ssRsb9e
         ZOYgcTUTH+fnnePzDeNBh5c238pExRkVIEhXZe4rlnzJg2V84fkkPrinTzwATNN2R9cX
         rqkyY5VvJusZC7r7F85o3unTywrFk8xhswa2gEel8HRDSvTDE9P85Z21gwd9uY0pgLA+
         LlNPAFz0b12uZhFLvUrpORyP8daBNj8OmYH0euDKmzbXCRH8KR+cjU0nuY3S9WOY3ASW
         KKO98nPskSIbkpFOWhB5NMCCj/ieoQdeirlBf5kAXFWxl731yp2wMWcRV01DK2mBcjQJ
         16tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxyXVvhp7+eAgZlW/bJZKGrR7X94wy/BAfTOiFP7IeZWK6Gr88BWVLA8Yl8f4epysxo4omEls6pg5v53UPCc93md7R7cR+
X-Gm-Message-State: AOJu0YxqF+tT0Sz49W0BPOOb+OKfn07sNPS/c4YXfOgwj50FeM0cmFpJ
	y9hLoS4dW8MJe848N4eYWd5f2kBlVGZDWKV0L4588OhI/Fn2TqiXQQRaSMg1Gmel09GLGbfDMjf
	kiO5Qu5gPMEkT4Ie1om4dyAJlTkpLyzDLs0sTzFVI4c7OW92toQ==
X-Google-Smtp-Source: AGHT+IHJcGz2b92vpsyTp4MbbDlyykFP3bhTQzQaPI5pxVAfJ6UlIgctpGYg+A7fYZ5haLQ3DRpyFbWfHDhM1EWGZ/Y=
X-Received: by 2002:a05:6402:b69:b0:56c:5230:de80 with SMTP id
 cb9-20020a0564020b6900b0056c5230de80mr276713edb.2.1711814509879; Sat, 30 Mar
 2024 09:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com> <20240329154225.349288-7-edumazet@google.com>
 <CAL+tcoBa1g1Ps5V_P1TqVtGWD482AvSy=wgvvUMT3RCHH+x2=Q@mail.gmail.com>
In-Reply-To: <CAL+tcoBa1g1Ps5V_P1TqVtGWD482AvSy=wgvvUMT3RCHH+x2=Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 30 Mar 2024 17:01:35 +0100
Message-ID: <CANn89iJKQuSLUivtGQRNxA2Xd3t8n68GQ_BAz2dp28eU9wzVcg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/8] net: rps: change input_queue_tail_incr_save()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 3:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Fri, Mar 29, 2024 at 11:43=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > input_queue_tail_incr_save() is incrementing the sd queue_tail
> > and save it in the flow last_qtail.
> >
> > Two issues here :
> >
> > - no lock protects the write on last_qtail, we should use appropriate
> >   annotations.
> >
> > - We can perform this write after releasing the per-cpu backlog lock,
> >   to decrease this lock hold duration (move away the cache line miss)
> >
> > Also move input_queue_head_incr() and rps helpers to include/net/rps.h,
> > while adding rps_ prefix to better reflect their role.
> >
> > v2: Fixed a build issue (Jakub and kernel build bots)
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/netdevice.h | 15 ---------------
> >  include/net/rps.h         | 23 +++++++++++++++++++++++
> >  net/core/dev.c            | 20 ++++++++++++--------
> >  3 files changed, 35 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 1c31cd2691d32064613836141fbdeeebc831b21f..14f19cc2616452d7e6afbba=
a52f8ad3e61a419e9 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3249,21 +3249,6 @@ struct softnet_data {
> >         call_single_data_t      defer_csd;
> >  };
> >
> > -static inline void input_queue_head_incr(struct softnet_data *sd)
> > -{
> > -#ifdef CONFIG_RPS
> > -       sd->input_queue_head++;
> > -#endif
> > -}
> > -
> > -static inline void input_queue_tail_incr_save(struct softnet_data *sd,
> > -                                             unsigned int *qtail)
> > -{
> > -#ifdef CONFIG_RPS
> > -       *qtail =3D ++sd->input_queue_tail;
> > -#endif
> > -}
> > -
> >  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> >
> >  static inline int dev_recursion_level(void)
> > diff --git a/include/net/rps.h b/include/net/rps.h
> > index 7660243e905b92651a41292e04caf72c5f12f26e..10ca25731c1ef766715fe7e=
e415ad0b71ec643a8 100644
> > --- a/include/net/rps.h
> > +++ b/include/net/rps.h
> > @@ -122,4 +122,27 @@ static inline void sock_rps_record_flow(const stru=
ct sock *sk)
> >  #endif
> >  }
> >
> > +static inline u32 rps_input_queue_tail_incr(struct softnet_data *sd)
> > +{
> > +#ifdef CONFIG_RPS
> > +       return ++sd->input_queue_tail;
> > +#else
> > +       return 0;
> > +#endif
> > +}
> > +
> > +static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
> > +{
> > +#ifdef CONFIG_RPS
> > +       WRITE_ONCE(*dest, tail);
> > +#endif
> > +}
>
> I wonder if we should also call this new helper to WRITE_ONCE
> last_qtail in the set_rps_cpu()?
>

Absolutely, I have another patch series to address remaining races
(rflow->cpu, rflow->filter ...)

I chose to make a small one, to ease reviews.

