Return-Path: <netdev+bounces-180064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB53A7F67B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920A41891FE7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88858264F81;
	Tue,  8 Apr 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvZlmC67"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A1263F51
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097692; cv=none; b=eqZwlQlxU11AKloJ5dFvk5MJixbMcD1ksjTS/tG0PdWHJkV1wOkxHcS6ZECMfnNvhA1jh2TIy7WNoxad44lQ+n2c9rDwbNaxApBhCBQuqjF6s0c0ssFdMjGG3m7kT9AK+rbCy+vyjI7UXct9Zt2IWlutvDg95Dfaw1/7U6HGHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097692; c=relaxed/simple;
	bh=Zw+nvfP4oH7YCpjyBFjQXUE7wWFGLtslccfPR5HCSeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk6como92bM07zuaM6qIefMlULIF/2BF1FPqlkeGwwoJa8d3SQ4MCaxOByUzZ6QO/vtqVS5IjookugD/Ogn35aH/cmOkSVYGgku8mhNnm+fzJbXOFw3LCuJtxMpoSw2whMeA3+UXkZJit0xiSVwGjAmorG64LCiyj5iYY+VhI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvZlmC67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744097689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgX/95pHI72BHQsp4Gb1Pk041dCapFrrBn2uranICwk=;
	b=EvZlmC67CykixpE2Ell4fSedXehwJHGU1lwhsQt9fo6jflnpRKstIA1iNn9nJC0qmkViVw
	tYSVul3aMqRX6uRZ6Xkttd8SOlGzANZQo1SznS9BQIEl2I7H3kLbQIog/yqTkOQt22DXGl
	BRqhmSqRx27GRnYImLH6FgWh8jCzAOM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-wcSe91Z6Mq-2TmYCyFglZg-1; Tue, 08 Apr 2025 03:34:47 -0400
X-MC-Unique: wcSe91Z6Mq-2TmYCyFglZg-1
X-Mimecast-MFC-AGG-ID: wcSe91Z6Mq-2TmYCyFglZg_1744097687
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736c89461d1so8005031b3a.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 00:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097687; x=1744702487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgX/95pHI72BHQsp4Gb1Pk041dCapFrrBn2uranICwk=;
        b=KK18awxkE2XpjGwQUM7yI7yIxaw4Y08NaHVINnsQnCHomusd7lBF7D+uGb4NR4G4F6
         71Zar+y6kaIwIxtb3qJgTiQs+hobb+cl930XXEWzwjuV+albodQe0r7DyxfJualdro5l
         e+roJjBw6MaJiJm5tWXXiMcaeo+GtD8qr6Fn2b5Xc1+/ePIlAiRi4OBtaHzz042Y0Cpy
         khqaurMgoGkK62IrPcgXF0eVYxWTlWoOnzJwGLPuaRDIYRy/3plK1A7seR7vMN3Z2BFp
         cTku7KfQ04H5E6RdD/Ed1an8jQ0eJrtxkDjU49Ot3DA4a/3QUNWLaSKRCduLY1y+12Bm
         FRtg==
X-Forwarded-Encrypted: i=1; AJvYcCVhyFCyrYK6LsUx1SSzd/Rqay5AvgRX/jhqRqsjg1InsWSbMpiV4DvXfmE+um+AWHBk/SXxLnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOOsJCAyCzQazWLPJr5Yo3IqqbJHy+Sq6B32HhRdLG/onLnBsO
	PcrdVTz89bYlPQVvW7RVgu24KoE5NYiSWd5lIehBOM4J1twcrJXtsiXi5gJAKzgneEXG75P6sbz
	RHfZ5WHiC6Ch/1NEH8vSf7QeqAon1aCfpBvxTVxLMze5FzO5uFjDxYBRzF4o9NIjHYTu1tJ1j4P
	dQxWptRBcuQBuf6VBE7kl0K7WkpO1M
X-Gm-Gg: ASbGncuNFvU9HpMtvEwSyhCXyDa8Octs2/EEiyLxZ2bH+sOzO8notGKYDQzX2CpBsqV
	C/T8YsLYB5pUPsK83uSMB4CISqqMbEIoz3gygNrVgE3EOwnPaJUquO8yuwAVlgo1+4GodslJt
X-Received: by 2002:a05:6a00:181d:b0:736:520a:58f9 with SMTP id d2e1a72fcca58-739e71136bemr15844028b3a.17.1744097686697;
        Tue, 08 Apr 2025 00:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEebzBktuzT34vutceE0Q+8ZimqM8gtaIQXLjH55vRIG5tqmEkA55owC0umuPvdKpOAEVEgy7rBakY9cJp/e3c=
X-Received: by 2002:a05:6a00:181d:b0:736:520a:58f9 with SMTP id
 d2e1a72fcca58-739e71136bemr15843995b3a.17.1744097686309; Tue, 08 Apr 2025
 00:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com> <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
In-Reply-To: <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 15:34:33 +0800
X-Gm-Features: ATxdqUHgOtXPv8x4ai3wnnr72S-UplgKPeU7AsldG5nqKrldqkZgJy1CXzhAwHI
Message-ID: <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 10:27=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 4/7/25 08:03, Xuan Zhuo wrote:
> > On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
> >> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> >> napi_disable() on the receive queue's napi. In delayed refill_work, it
> >> also calls napi_disable() on the receive queue's napi. This can leads =
to
> >> deadlock when napi_disable() is called on an already disabled napi. Th=
is
> >> scenario can be reproducible by binding a XDP socket to virtio-net
> >> interface without setting up the fill ring. As a result, try_fill_recv
> >> will fail until the fill ring is set up and refill_work is scheduled.
> >
> > So, what is the problem? The refill_work is waiting? As I know, that th=
read
> > will sleep some time, so the cpu can do other work.
>
> When napi_disable is called on an already disabled napi, it will sleep
> in napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck altogeth=
er.

This needs to be added to the chagelog. And it looks like this is a fix for

commit 413f0271f3966e0c73d4937963f19335af19e628
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Tue Jan 14 19:53:14 2025 -0800

    net: protect NAPI enablement with netdev_lock()

?

I wonder if it's simpler to just hold the netdev lock in resize or xsk
binding instead of this.

Thanks

>
> Thanks,
> Quang Minh.
>


