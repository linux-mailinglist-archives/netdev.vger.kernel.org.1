Return-Path: <netdev+bounces-65451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A1F83A945
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 13:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A494AB2547E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3C363118;
	Wed, 24 Jan 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="G1KOJ8Ea"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460A60DC7
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098209; cv=none; b=ViTivrcq56H4Sdq/TIXU/BOviPs+ocwaMTEV2XKHrchyc0dBA8qY52IbsGL5Q6Giy0qwiDry9d7le3XwUT5mrCQOA15uaNXBasBlRDmYNvhqbGETz1IoGsQmKaZbO30We5+c8m25U53X0GSpCQC27JD9PhQzw4sVbIkCPGztshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098209; c=relaxed/simple;
	bh=zl9VzZezR3O5GUVP0MRYZ600XsfdMgKtjgE2vefKqg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csQ3RDmG2RDMvUhPn5+1A9kaUE3Y6gF7/pygiV6GN/4JwJ2yLpBjLUFj5rSpFDPbF9hCpgkpCWQwFbCJCVNpBDj7XsC4vkNl8QzRJztkzos57vfaxrR77WurudemhhwP6PQeUruD866JlM2emkqyBzvcwl7yBViMGsFhjsgwRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=G1KOJ8Ea; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60036bfdbfeso19762547b3.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 04:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706098207; x=1706703007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxsDva+3z7gecuc15h26DDSxAVZxkuNdlTUgHNx+MUU=;
        b=G1KOJ8EazYXxQqPITvclUIZ9Ln8RLiONp+jMjPs3BZWZ/AN4PHT0OdX1BaA6d+bQcW
         Bac8JysRMRY5Jwl0rCO5csK86E4uP26zXfnI7fferviViYiCAbOv1NYbu0Ohwx7bbaLI
         I8yDAJV6xCPMQqDexdpokYCxupyPl1kL+vGwPBwU4c6xGsDm0OsIxLjJBSio7Sb2E1W5
         h2D2LEGox2P35wXCq83W3rItzg9j1Lq9rU9BCxcE1fw2yo22aVkhqGxdEWuWqmngPZC8
         wA8pIZ9t2WPBUMuOchoUjIPpkJOYTtqt+/o9OZRlvNaxcETCUqVD2dZgO9bHjeeaUJ/w
         8V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706098207; x=1706703007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxsDva+3z7gecuc15h26DDSxAVZxkuNdlTUgHNx+MUU=;
        b=jvos8/zfD9OfEYWwZh9/ITqUKKZkHh4sA3ZqykaQ1/k9KQnydh9f+rKkbc9GZL/vRX
         TUXiDb38RjFHByAysccEYKnU690rbI4RWc+BVupHbv4qo/aOdH5BopeCu8qUspouYHq9
         AEphn9LkH7re2DjTrXDY8VPJA/tOWY5r5FG2Y38zndt12PAw7UK+IUUgSitkmkd2hSeA
         7Li+SIyO80xM+c4gtBgtw3PU7IWwLykvlc+MCqIuQSZVZ+9kXhl6ZRHFg288eSClv9iI
         WiKuZL5cg8XD/b+18olSrTfUFEB60uqlS4aXAJ2cmGFJD0f6dBC/gA7qBZQYCIGihXrb
         wZwg==
X-Gm-Message-State: AOJu0Yw4eu4aVA5GXD7ZSr0X1mhAyyLoxVLsfgyGxmO3GpPBRS2i4TLK
	SzLnjo1Bqr2O41DcgqHnHjolc1pJKaWZAyeEiCqr4cmyNoaWjBun5pvAjqieb+GgRc97nvGijPs
	8aq6atuzaju3bATWNPZ0sLc2tN6ZPSJlIIo5S
X-Google-Smtp-Source: AGHT+IGbF9p+7BMCoFk4YAYyD9UUnddh9A31toesB8/u6BODEL060j8TKy3YXmd5jZBkDVBxVHHttZnG4WKKpJztZ9k=
X-Received: by 2002:a05:6902:1ac9:b0:dbe:3ddf:57e8 with SMTP id
 db9-20020a0569021ac900b00dbe3ddf57e8mr630817ybb.55.1706098206688; Wed, 24 Jan
 2024 04:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com> <ZbAr_dWoRnjbvv04@google.com>
In-Reply-To: <ZbAr_dWoRnjbvv04@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 24 Jan 2024 07:09:54 -0500
Message-ID: <CAM0EoMkHZO9Mpz7JugN7+o95gqX8HBgAVK6R_jhRRYQ-D=QDFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 0/8] net_sched: Introduce eBPF based Qdisc
To: Stanislav Fomichev <sdf@google.com>
Cc: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	yangpeihao@sjtu.edu.cn, toke@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 4:13=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 01/17, Amery Hung wrote:
> > Hi,
> >
> > I am continuing the work of ebpf-based Qdisc based on Cong=E2=80=99s pr=
evious
> > RFC. The followings are some use cases of eBPF Qdisc:
> >
> > 1. Allow customizing Qdiscs in an easier way. So that people don't
> >    have to write a complete Qdisc kernel module just to experiment
> >    some new queuing theory.
> >
> > 2. Solve EDT's problem. EDT calcuates the "tokens" in clsact which
> >    is before enqueue, it is impossible to adjust those "tokens" after
> >    packets get dropped in enqueue. With eBPF Qdisc, it is easy to
> >    be solved with a shared map between clsact and sch_bpf.
> >
> > 3. Replace qevents, as now the user gains much more control over the
> >    skb and queues.
> >
> > 4. Provide a new way to reuse TC filters. Currently TC relies on filter
> >    chain and block to reuse the TC filters, but they are too complicate=
d
> >    to understand. With eBPF helper bpf_skb_tc_classify(), we can invoke
> >    TC filters on _any_ Qdisc (even on a different netdev) to do the
> >    classification.
> >
> > 5. Potentially pave a way for ingress to queue packets, although
> >    current implementation is still only for egress.
> >
> > I=E2=80=99ve combed through previous comments and appreciated the feedb=
acks.
> > Some major changes in this RFC is the use of kptr to skb to maintain
> > the validility of skb during its lifetime in the Qdisc, dropping rbtree
> > maps, and the inclusion of two examples.
> >
> > Some questions for discussion:
> >
> > 1. We now pass a trusted kptr of sk_buff to the program instead of
> >    __sk_buff. This makes most helpers using __sk_buff incompatible
> >    with eBPF qdisc. An alternative is to still use __sk_buff in the
> >    context and use bpf_cast_to_kern_ctx() to acquire the kptr. However,
> >    this can only be applied to enqueue program, since in dequeue progra=
m
> >    skbs do not come from ctx but kptrs exchanged out of maps (i.e., the=
re
> >    is no __sk_buff). Any suggestion for making skb kptr and helper
> >    functions compatible?
> >
> > 2. The current patchset uses netlink. Do we also want to use bpf_link
> >    for attachment?
>
> [..]
>
> > 3. People have suggested struct_ops. We chose not to use struct_ops sin=
ce
> >    users might want to create multiple bpf qdiscs with different
> >    implementations. Current struct_ops attachment model does not seem
> >    to support replacing only functions of a specific instance of a modu=
le,
> >    but I might be wrong.
>
> I still feel like it deserves at leasta try. Maybe we can find some poten=
tial
> path where struct_ops can allow different implementations (Martin probabl=
y
> has some ideas about that). I looked at the bpf qdisc itself and it doesn=
't
> really have anything complicated (besides trying to play nicely with othe=
r
> tc classes/actions, but I'm not sure how relevant that is).

Are you suggesting that it is a nuisance to integrate with the
existing infra? I would consider it being a lot more than "trying to
play nicely". Besides, it's a kfunc and people will not be forced to
use it.

cheers,
jamal

> With struct_ops you can also get your (2) addressed.

