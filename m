Return-Path: <netdev+bounces-228167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D716BC3B26
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 09:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D6E3BDDA6
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 07:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E562FC880;
	Wed,  8 Oct 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfUs8ELe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C32FDC3F
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908751; cv=none; b=uEQIxw96yIvXVUDOLArzwrleKRmCi3QxupFqpZ5Pfn3OfULEb5vA60YRc/3joEfKbAbMVV1Kg3COkvvL+6KU1OGYLhfOaYbxDVRBV4py7O2KbViJTRyD13JUNRdDa3YzqjHpG6s6yklS/LZrOrV6L7dCtEDEXIup+V0oRcjQ4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908751; c=relaxed/simple;
	bh=eTmAQ8l5fWjS7EWqoWLeKasQrdFaSoU4BqNQ/404vb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBmxDsZmlulnICTuqagbiGToALgwfWSonfuqOgzUD+tuIYRoxRwPYICWCxFThS3ThPV8nSmDGq73IM+debFRzStjznAp9VZ4y42IveEAcEduQilSpLwRuBIg1deF7t/hxz6P8rZvMIFdxF+wTbH7WNdc+McQkHBuAcp1e3mFhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfUs8ELe; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e06163d9e9so71475921cf.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759908748; x=1760513548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RHjanE3RNo2BpICNxnrQFoIPvVyPeJMUWtLjKj9WlQ=;
        b=lfUs8ELei3dYeJpTKdiUoOETxC/xk11aQpkTBrJ713KQSoukTF4HTf5cAeNI8IJz6a
         QmN6L4tjgeLbSsgT9cjAu3M7mh8h3zDZwCNiMDPr7Hf+wrjHqpFsy6i2UAMy+CO+t4Kf
         DnaVJ1U5NZ7uUQGVedYyuvSk9jwAcDOHEPAN7yidvMuPyP30XoBjvGx1qrpy9GfAoo4L
         HHlD3Zmzgax9nKnluUfy0w2By+iaz4uDsfzO1c4T1lub4HJhTgDTcNITw4W+XtugeoR7
         JhyNvgQkQqtmMQcdZUNT4lkHvfIp79m+QwaLBllVbwaDF2ppC7fCxjvR5RV8yeKNkjMn
         WEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908748; x=1760513548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RHjanE3RNo2BpICNxnrQFoIPvVyPeJMUWtLjKj9WlQ=;
        b=ZQUQKW0x5Ym2GqCcr/nT//4RcuwPBDylwHOSBYO7lxvu9++MRVeq6L8o+x5dLwTYlK
         ElapqaswOfMUCslmW0Pp27V74G07rlTOYMsNxLZBEZrWy6xwMZf5GWaBUyUPo9hvHdUI
         hH5sRnkWi5+5C9Dswc+w6ugbJTzt+vecMGA1KXIv4xnub13ocwLhL5Ru7YqeGbH2+OHc
         zXdbidSk9N2bmKu5n3it3gBSd5ZOgD+3/YEeN6Cxmg8pfsO12AOj1BOqDdps/ju8MoQk
         Qeabl3NuqITgO6QWBJcL8gjaL9me35sTbb167uCnY9Olx514RJa78TIDRfkVrBcOLX7N
         fuCg==
X-Forwarded-Encrypted: i=1; AJvYcCULVoSVHVC9762fvhOdDzpXI+bH095eAxbFFBsyJaGuNtV8PIGPR32CsUHBbQ1+QdORITRiU4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdp6IOwwXzem1e1ESBB4l+cCc7n4I5Uh1v2sDnrSBQkGTbt7Ea
	SdVoNQ4PJV7zj6dWLetsnpKyLBg5BGioLW/qbdUdgIOYDG6F31EINJ0j9lcGlXCVGVzle41hBwg
	LyibXqDNbNtwo+2FZEn8893MLgSBSFHD5FxXsbmMe
X-Gm-Gg: ASbGncvJU0dPUu7F8JkWe6dmmes4I0sHZ1gwFqi4jkEaaPnnEaOSVKaTO4iCsmnIeqp
	C78FqiAOr1NhJazdnDe7IZJrJ/ibx8v/1g7V0zMvu/wdGXG0N8nEHbkDkaBWbqprc1o3Ic//R6/
	bQsE98vdjtpdyKfiwPkh26AjNoNqUe7XespEO/X4vaDZMC1WeOAhJqHPmTER8hDy1QcaJjPdPx5
	TqhmYrz2Z+tJhT5yyJKuHUBTDFdwNPV3R7zORm6xgqx3Jrdqc01Y2XICtcF8vW+8czSS4BYd96b
	iO6cw24=
X-Google-Smtp-Source: AGHT+IEAgdj4IuQwINZCgd1Xs62sycPDvgeoYh9HLpIZaEcPq1c6iMbEaKEg4Ayh6n2fH0zXxUs81/UTuCpnxzoz6no=
X-Received: by 2002:a05:622a:1f89:b0:4e5:6cf8:289 with SMTP id
 d75a77b69052e-4e6eace4d33mr30181481cf.29.1759908748187; Wed, 08 Oct 2025
 00:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com> <20251006193103.2684156-6-edumazet@google.com>
 <fcd97ca7-f293-49ce-bf01-3ba0001a7753@redhat.com>
In-Reply-To: <fcd97ca7-f293-49ce-bf01-3ba0001a7753@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Oct 2025 00:32:17 -0700
X-Gm-Features: AS18NWB-xNGx-KpYwZg2X5Eaie-aoYO3ykKIOVDq6X61q-ehuMoQPKYADOiGDMk
Message-ID: <CANn89iKW=ZPpYMBBKN_U=-4zCYB4jZD6N4M6_HLcTJVupiVx3A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 11:37=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 10/6/25 9:31 PM, Eric Dumazet wrote:
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c236=
319705aecba8c30cf 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -115,7 +115,9 @@ struct Qdisc {
> >       struct Qdisc            *next_sched;
> >       struct sk_buff_head     skb_bad_txq;
> >
> > -     spinlock_t              busylock ____cacheline_aligned_in_smp;
> > +     atomic_long_t           defer_count ____cacheline_aligned_in_smp;
> > +     struct llist_head       defer_list;
> > +
>
> Dumb question: I guess the above brings back Qdisc to the original size
> ? (pre patch 4/5?) If so, perhaps is worth mentioning somewhere in the
> commit message.


Hmm, I do not think this changes the size.
The cache line that was starting at busylock had holes.
You can see that even adding the long and the pointer, we still have room i=
n it.

/* --- cacheline 3 boundary (192 bytes) --- */
struct gnet_stats_queue    qstats;               /*  0xc0  0x14 */
bool                       running;              /*  0xd4   0x1 */

/* XXX 3 bytes hole, try to pack */

unsigned long              state;                /*  0xd8   0x8 */
struct Qdisc *             next_sched;           /*  0xe0   0x8 */
struct sk_buff_head        skb_bad_txq;          /*  0xe8  0x18 */
/* --- cacheline 4 boundary (256 bytes) --- */
atomic_long_t              defer_count
__attribute__((__aligned__(64))); /* 0x100   0x8 */
struct llist_head          defer_list;           /* 0x108   0x8 */
spinlock_t                 seqlock;              /* 0x110   0x4 */

/* XXX 4 bytes hole, try to pack */

struct callback_head       rcu __attribute__((__aligned__(8))); /*
0x118  0x10 */
netdevice_tracker          dev_tracker;          /* 0x128   0x8 */
struct lock_class_key      root_lock_key;        /* 0x130     0 */

/* XXX 16 bytes hole, try to pack */

/* --- cacheline 5 boundary (320 bytes) --- */
long                       privdata[]
__attribute__((__aligned__(64))); /* 0x140     0 */

