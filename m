Return-Path: <netdev+bounces-224168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A575B818DA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 21:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525F03A6C20
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686792FF660;
	Wed, 17 Sep 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzuoWa8y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743C2FC896
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136448; cv=none; b=O26Uw/OM3+OQBzjovrQch7239Umrr9B0zmRlhFVRkhBFB+Dma9FZIrnlWSS9u9EnNOlcpus8W+MSu8PWUdwUCOxEJXpsQ39LkKLqqJQBFpemahVNdWkeXUezbYSpdh5vX6tCTxoC/N9qu/TNXFKYKHzNXhCdXgYU6s6k+Zux90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136448; c=relaxed/simple;
	bh=oXGJc5PtcToWhpYg7IPZKPXFjyI+V6rr8h6OjDhs62c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Dyr0hB2Pc7MyInHvhVfg8Z5EJuAUQhP19O05necEpxnacGWZDgEgRyGPovZlwE0Mma0WbbqTl7I15HgQl36rLc9LY0AY3DmmIsk06FYfh69NAJWfCHdXiMbUIa+CkWBBCIlQ6wpyW+2DIWfdHXhWyqXASbP6QfJStIU+hoviLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzuoWa8y; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-545df2bb95dso60165e0c.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758136445; x=1758741245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRQZa+sJ/uVO1Ce6tXItjTSHDpvtVz0AGOs/O2qEd44=;
        b=PzuoWa8yrFjj+9i6OWFvwFRsSaxI/D5sInRZ/VkIHqMAxd/Xd+BxGwEoJ+igIBLij2
         k+zQLj1ICoX1krp5ViCblMY9J5ARXB9JIT+HA+LLSkILR1jML0me3ICyACQAJH7WMKqG
         qfdMYmYMyz0nsVMrW2VWzygW9CjZTAeBnEt4Q5QzW3bI4nBcWYvj8uCRVIcTNQAIEpuO
         SAQDgRFHvWXQgBGssiHqnXUuUYKGTrK8zxmAwIAo4XSaphyBH2yMQ+CZRmtXywYix6m3
         PnPmi8vsY4uxwaVPmEn1bxPM9L3kCfLPVPM8atTJXsOcbfntFkbq/cWV3aSFMr96Qnbo
         jk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136445; x=1758741245;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CRQZa+sJ/uVO1Ce6tXItjTSHDpvtVz0AGOs/O2qEd44=;
        b=aLHM2Yb/LpfzRKGxpF68vddpmQVgKdFg/p2f2qlNanLRPIa/RZb1Ud19MmBunU6RZQ
         frvIiQvAJCHZKEggUQfMN56iGNuVlyflkGVNO4QXf513wwJbjYaN2eBYykzEe4ZDg21+
         lMfXcucCSqZuE4oUIOXyHm5OsICkrD7WlMVUkW81gv/hHvjnidIo5uTrLlpDqF442GTs
         PTvUAkIeCVyA9buOK8/hkuoiVTNgdVMWu7oXj5SgYi3jIO+2bUCPAeEGpC98l73/RQle
         wiEAzWRDXXJesZQjPVRlUOQBYkZcVVIApz2hFLGQ6h9bRm+BPP0M7vHpvm4M3yBIojDP
         L+7g==
X-Forwarded-Encrypted: i=1; AJvYcCWNs+5tHAzd1OMgV5ho9/XBZTK1gLpobAvmnzY45nkGsc7zJbq9b2B20Kzp0ybDTZ6zAEUCpvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKO2ZFttg7/vPCVl41rUe+P+hJCO1priuDTQ9f8+QnI88/oEa
	mq0fkUlqbMP9OXdjHh/OiqwXX/64IXLIG1LJX1uEBGU5osScxzNn4WkV
X-Gm-Gg: ASbGncvPBFomVLRV2TLZUsrEXz0xrtKAsHDjscwB2x8Oa1AJDFISoou4VGPGSwWif/3
	e2gIm3px/S+nfhC78YlHcAkZEJeOuK1BhcUTq23k9IHIoMwHCiZ0VLTHjeZVWSBHdmCtpq0ARCS
	75e7bigyu7ZnhCTkvSbFl0DCxEyKrpcskraJq3AfUa/lvVbZs+eB1Qy7D50+MPKR0TpQv1ZcTZE
	NbQt6O0zLUsu+eeq0nQDKa3XyLYYV1X5H4QR7x+3H3cysMeleeVMhSYt+GTJxMhE6MLWo6YZ+J3
	Onm6I52LBK0GaJUz+w9Fe+AQ8NbrLwKpY/Zk2rFiQp3iOoto/MyKp4w0vz4ZHKh+kUA4o7c5nqI
	gAZ3GIblUGzJY1H4uam3JSZe/SaLyVSKEWj5sKP4q37y0pz6qxH8M600HzGDWVGvPde8fviTOoT
	CTUg==
X-Google-Smtp-Source: AGHT+IEWQK36fylCtprNzyW2M9skLMZXDXc3XKdbsHAwfTkeagnoPw/iQciwzN/2hP7Qd+838wurxw==
X-Received: by 2002:a05:6122:659a:b0:538:d49b:719 with SMTP id 71dfb90a1353d-54a605d2923mr1055836e0c.1.1758136445414;
        Wed, 17 Sep 2025 12:14:05 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54a729be0d7sm104960e0c.24.2025.09.17.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:14:04 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:14:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <willemdebruijn.kernel.896e45dd59fc@gmail.com>
In-Reply-To: <CANn89iK-iPeGNVP5zKq4t+0vPhTsqCFeP715Z5XSfW6KdfhzKg@mail.gmail.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-7-edumazet@google.com>
 <willemdebruijn.kernel.111bed09b8999@gmail.com>
 <CANn89iK-iPeGNVP5zKq4t+0vPhTsqCFeP715Z5XSfW6KdfhzKg@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] udp: update sk_rmem_alloc before busylock
 acquisition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Wed, Sep 17, 2025 at 8:01=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > Avoid piling too many producers on the busylock
> > > by updating sk_rmem_alloc before busylock acquisition.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/ipv4/udp.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index edd846fee90ff7850356a5cb3400ce96856e5429..658ae87827991a78c25=
c2172d52e772c94ea217f 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1753,13 +1753,16 @@ int __udp_enqueue_schedule_skb(struct sock =
*sk, struct sk_buff *skb)
> > >       if (rmem > (rcvbuf >> 1)) {
> > >               skb_condense(skb);
> > >               size =3D skb->truesize;
> > > +             rmem =3D atomic_add_return(size, &sk->sk_rmem_alloc);=

> > > +             if (rmem > rcvbuf)
> > > +                     goto uncharge_drop;
> >
> > This does more than just reorganize code. Can you share some context
> > on the behavioral change?
> =

> Sure : If we update sk_rmem_alloc sooner, before waiting 50usec+ on the=
 busylock
> other cpus trying to push packets might see sk_rmem_alloc being too
> big already and exit early,
> before even trying to acquire the spinlock.
> =

> Say you have many cpus coming there.
> =

> Before the patch :
> =

> They all spin on busylock, then update sk_rmem_alloc one at a time
> (while they hold busylock)
> =

> After :
> =

> They update sk_rmem_alloc :
> if too big, they immediately drop and return, no need to take any lock.=

> =

> If not too big, then they acquire the busylock.

I see. So this likely also overshoots the rcvbuf less?

As they currently all check against the sk_rcvbuf limit before
waiting (50usec+) on the busylock, and only update rmem and enqueue
after acquiring the lock. With no drop path at all (aside from
forward alloc).

Reviewed-by: Willem de Bruijn <willemb@google.com>

