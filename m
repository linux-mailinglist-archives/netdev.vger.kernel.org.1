Return-Path: <netdev+bounces-117913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739894FC6F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C98F1F21F45
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E81BC49;
	Tue, 13 Aug 2024 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeQv/QEO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE1179AE
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521231; cv=none; b=UAIT4HwSoK0dauY+FfVLzH0X+a65g5OKC+/wwHwBvuA0ofCeCIboZ07/eRzV422F/tR0l2AL18Qz6wEJ3n/EJmV5iPwm6g90rrgEiFvHKrHNMrlRzicIlBPhEsHM7uYoBRbuBnZ5WA7N3nBJ0jNetfokmrCCV+k24MT/7E8wf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521231; c=relaxed/simple;
	bh=1/YYj/FIhKGs1dZdd4D2WEQIg8dqO3w+5kVK4bkLaSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G++a7lUTm/NctDkQLT6eIjU9BitW40i0ofoSx2r892gRAyVHwAQD9mpcBPgxFNGKuoeIUd93b6Gec6Qj0ro449I928BWPhmyRYDYcyD/sKOQtEpplUWiU1HRUbmMyxPTLFKOXMfn3cBcaUIpXMZSFdpmRHhFoDCHkzjaiQz/TGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeQv/QEO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723521228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QOhbN+G2UI84CLxR8GtKPdibAYSavfIJXJ0B5CLThc=;
	b=PeQv/QEOYbAFCO6gcR3t2hn6NhYSGHLO5pHL+rDTMKQjeZMe4Tceugxjd8FzFQhP5oOLID
	jwpLVHN0El+YufdCzCI6CDF3wPq5ISi33C52by7uPBQWHxIHo9rMfIoZKi1nxaDxdZOWVr
	CviAfDqjelHTt3QMHcvBDuH99GJZrY4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-P2ukDynzO3CI9N8xrbIXeg-1; Mon, 12 Aug 2024 23:53:47 -0400
X-MC-Unique: P2ukDynzO3CI9N8xrbIXeg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cff79ae0f3so4899010a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 20:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723521225; x=1724126025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QOhbN+G2UI84CLxR8GtKPdibAYSavfIJXJ0B5CLThc=;
        b=Mhx3LXf4+hXaG4B9JvVwcYW8kD9IsBm4epI9gxnoW4Cr5EhzCq7jc89Rg5VGVz0mdr
         vrQvZ+D8L8MrLdQuY1kcVoIAQxQl7JWynSc/sg2RLnGtorlYjnuYDXpup8Phno9/MBLz
         H84XY7tQBxi73Y7hcwf+45BJps88uAZzKzsOMarWZZNK7RULG3K61YYJFqYdnFKAvX4Q
         dmjBXqS7xHb8pQcCFHYQbNKdXFQtLBEydlcFEZkiPV4HNmcRi5EEq1OLmRKfjytMnZSb
         jsUU3PN/OhPfznhF8MnnxNYBokG02hV/jz0a4DdPZJ9S48PuEFnIvRHPvfib02EG93UZ
         /RrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCDpZjFPx4fFqrU/o8QNYUGPf70UaNRk1nOF9ujXjaiU9IVJMI8Djzkpm3jS4lVGp09BvEshXt7NcZniAhqMVE+P9e2sFZ
X-Gm-Message-State: AOJu0Yzg3Bt5emdFmzbRdm47IWMNfgbPQvhBHFF4AmuA1ELu4P6HUQID
	F2QL5RFK+nWhFVrzvTtrFde5AoDLtkcNvedF5adIDIzMLY52w7JhXfpQBXyL8gOt9hDCxYRS5rl
	Al6BMVh5MGtXa8/nV7t/tcAbOj1vHHaCtn+jitXzInuMk04HF6ky+/hDYMzOrURho7cf6M4tqyU
	S2HtLawZY11StpI5Zl5Sc6RHKqVarugnIOKYRNVQE=
X-Received: by 2002:a17:90b:230b:b0:2c9:69cc:3a6a with SMTP id 98e67ed59e1d1-2d3924d6069mr2555094a91.3.1723521225443;
        Mon, 12 Aug 2024 20:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFJc3jsUUMplnLTRxbhe3p0rkwFDORq22WEdzxWm12Cd7QkQG/w4r8SCFfuIABlC3bvzqsUOBo/unBIpoolXI=
X-Received: by 2002:a17:90b:230b:b0:2c9:69cc:3a6a with SMTP id
 98e67ed59e1d1-2d3924d6069mr2555073a91.3.1723521224879; Mon, 12 Aug 2024
 20:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
 <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info> <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
 <CACGkMEsw-B5b-Kkx=wfW=obMuj-Si3GPyr_efSeCoZj+FozWmA@mail.gmail.com> <66ba421ee77f4_48f70294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <66ba421ee77f4_48f70294e@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Aug 2024 11:53:32 +0800
Message-ID: <CACGkMEt0QF0vnyCM5H8LDywG+gnrq_sf7O8+uYr=_Ko8ncUh3g@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: ayaka <ayaka@soulik.info>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:11=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Wang wrote:
> > On Fri, Aug 9, 2024 at 10:55=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > ayaka wrote:
> > > >
> > > > Sent from my iPad
> > >
> > > Try to avoid ^^^
> > >
> >
> > [...]
> >
> > > > 2. Does such a hash operation happen to every packet passing throug=
h?
> > >
> > > For packets with a local socket, the computation is cached in the
> > > socket.
> > >
> > > For these tunnel packets, see tun_automq_select_queue. Specifically,
> > > the call to __skb_get_hash_symmetric.
> > >
> > > I'm actually not entirely sure why tun has this, rather than defer
> > > to netdev_pick_tx, which call skb_tx_hash.
> >
> > Not sure I get the question, but it needs to use a consistent hash to
> > match the flows stored before.
>
> This is a bit tangential to Randy's original thread, but I would like
> to understand this part a bit better, if you don't mind.

Comments are more than welcomed. The code is written more than 10
years, it should have something that can be improved.

>
> Tun automq calls __skb_get_hash_symmetric instead of the
> non-symmetrical skb_get_hash of netdev_pick_tx. That makes sense.
>
> Also, netdev_pick_tx tries other things first, like XPS.

Right, using XPS may conflict with the user expected behaviour (e.g
the automatic steering has been documented in the virtio spec, though
it's best effort somehow).

>
> Why does automq have to be stateful, keeping a table. Rather than
> always computing symmetrical_hash % reciprocal_scale(txq, numqueues)
> directly, as is does when the flow is not found?
>
> Just curious, thanks.

You are right, I think we can avoid the hash calculation and depend on
the fallback in netdev_pick_tx().

Have put this in my backlog.

Thanks

>
> > >
> > > > 3. Is rxhash based on the flow tracking record in the tun driver?
> > > > Those CPU overhead may demolish the benefit of the multiple queues =
and filters in the kernel solution.
> > >
> > > Keyword is "may". Avoid premature optimization in favor of data.
> > >
> > > > Also the flow tracking has a limited to 4096 or 1024, for a IPv4 /2=
4 subnet, if everyone opened 16 websites, are we run out of memory before s=
ome entries expired?
> > > >
> > > > I want to  seek there is a modern way to implement VPN in Linux aft=
er so many features has been introduced to Linux. So far, I don=E2=80=99t f=
ind a proper way to make any advantage here than other platforms.
> >
> > I think I need to understand how we could define "modern" here.
> >
> > Btw, I vaguely remember there are some new vpn projects that try to
> > use vhost-net to accelerate.
> >
> > E.g https://gitlab.com/openconnect/openconnect
> >
> > Thanks
> >
>
>


