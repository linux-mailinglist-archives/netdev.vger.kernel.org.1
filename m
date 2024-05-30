Return-Path: <netdev+bounces-99393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4108D4B58
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B7C2828F5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0EB1836D8;
	Thu, 30 May 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYR75etd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD16F2F1
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071153; cv=none; b=R1TtV8hrkavbTlirkNMg3OlQxEARDQrH5uZ/d4RWsjBNOCRgX9T8FfgiHHsjsCY5yXJcSY1d0wQB7S0mfTQWpOGDokaKHJyd58MuK/DBR9OhdABHhJldqOCR+ZmfA8kCOkL2EtTBIm22WmYZqZhaiftxOY+LnPbW4PwLQwlJzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071153; c=relaxed/simple;
	bh=xmIVpAopZsJ2ZtPSpEgRALCQGLbG0A1e9zqWQ/sIFc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odQX9bQVuYX4Z3pQ/9mds2G3wbinf5B8T1nLeWkAHvZIc43dKGhmfV0oYvj/8QvaD+2m7g1Yhwi7gcUjxLwSWHpMfNVFGtI5/cgwWYB4jxW3XtVukAJd8nnWaG5VbDcsxkZ/cAGpoKAwbID2k1MLx2r/OBupP3KTFGUdFJEjeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYR75etd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717071149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4ZPonxQfUaxHPhmUO2CXQCo0FNADvYEXeFvyWukAwU=;
	b=EYR75etd3CPunOSDC3Y/YCGrVbKelpEQkBA09oWIWnpwmLHaP8h7E+QF7GhY7/jljfnGe8
	dt40F7vllw59yNu0pQWThCtl0NDUmYNB8/JnvrQNWOHG+JVWSZXPqiFxlgu8vvlKmIrTSv
	Jv60fWflcmdVEBowsyZt2A5qqRnmZ9g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-WXXIrzNROziSMV2x64opTQ-1; Thu, 30 May 2024 08:12:28 -0400
X-MC-Unique: WXXIrzNROziSMV2x64opTQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c1a9e8d3b0so745315a91.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 05:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071147; x=1717675947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4ZPonxQfUaxHPhmUO2CXQCo0FNADvYEXeFvyWukAwU=;
        b=lxq6RMv20kfzm7cG1mSvJ1c+5RSir9vODQJMuNqZqMY+7lwjjz4C5fN5LOq+3PLPMA
         mMc4QMtgzPl15eG29vrSAa6SeObQs/fYoMBdviPpGE0hlBdHpiMRHie8dYdoZxALWla/
         v+h9Nv4OYrh9IVP01zA9P+EVnoM4LulZvP1p0CQuf2QoeWz9kbiJ4uNNrHUXXnuJGKlx
         AEh5M91bVGbGXvwjorUH69aoCAaL24j9bfHQ2bRLg1EfhX1O7rR7Ep1VWe2vW0xvNrc0
         RB6uzBDzABGiZgnXiOnvQSVkeZExOE+i22Nzh/3zegh26uAANo0qseQrnAEZcxuWgi9q
         lf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh8PAHNqhGbIY3RVec9rrRM1s9ccDPgsuZUVWjN3jcrhAD5OsX3kqpspiZ9KUvmRjyC/FukJuTm4C7YeiAHlNNny80pJ7K
X-Gm-Message-State: AOJu0Ywx2g2OOifjgoB9px5o+/dDROUHnuf/x6TlbZHUfAxhpc9RmMWO
	iW01P5w64tyhEPfjhekBxWqahvW3MUsFZHMgVcA/umlK9XyR2B8uxEyu5Z16mgNpVHFoTEUGxEY
	lq3X2DevvGzvgSFs6HSyfMCiBwpdA8j8P5xEY4ghlz81thB3oyXdASRUv4OC/nzb+ty7oJ7lyh1
	8yL7ha8gIiUqPShy6zeCn4KeEoPY2i
X-Received: by 2002:a17:90b:1a85:b0:2a2:7a00:f101 with SMTP id 98e67ed59e1d1-2c1abc4a2d9mr1568054a91.47.1717071147206;
        Thu, 30 May 2024 05:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxiVaGL5dfbdmmXh78ZPfATcru6UOjzaDGxFpxTSHh+NfsQAtdCSWJBv1oUf0a1JwZWKCpqfTxjfOGrN4uByQ=
X-Received: by 2002:a17:90b:1a85:b0:2a2:7a00:f101 with SMTP id
 98e67ed59e1d1-2c1abc4a2d9mr1568027a91.47.1717071146795; Thu, 30 May 2024
 05:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
In-Reply-To: <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 20:12:15 +0800
Message-ID: <CACGkMEt__DPnyTOU8Z-u=pFROVaAeHFKm0t5XtHpZq3o7j+dEg@mail.gmail.com>
Subject: Re: [PATCH net-next V2] virtio-net: synchronize operstate with admin
 state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 6:29=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > This patch synchronize operstate with admin state per RFC2863.
> > >
> > > This is done by trying to toggle the carrier upon open/close and
> > > synchronize with the config change work. This allows propagate status
> > > correctly to stacked devices like:
> > >
> > > ip link add link enp0s3 macvlan0 type macvlan
> > > ip link set link enp0s3 down
> > > ip link show
> > >
> > > Before this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN=
 mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ......
> > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500=
 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > After this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN=
 mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ...
> > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 15=
00 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - rebase
> > > - add ack/review tags
> >
> >
> >
> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > >       /* The lock to synchronize the access to refill_enabled */
> > >       spinlock_t refill_lock;
> > >
> > > +     /* Is config change enabled? */
> > > +     bool config_change_enabled;
> > > +
> > > +     /* The lock to synchronize the access to config_change_enabled =
*/
> > > +     spinlock_t config_change_lock;
> > > +
> > >       /* Work struct for config space updates */
> > >       struct work_struct config_work;
> > >
> >
> >
> > But we already have dev->config_lock and dev->config_enabled.
> >
> > And it actually works better - instead of discarding config
> > change events it defers them until enabled.
> >
>
> Yes but then both virtio-net driver and virtio core can ask to enable
> and disable and then we need some kind of synchronization which is
> non-trivial.
>
> And device enabling on the core is different from bringing the device
> up in the networking subsystem. Here we just delay to deal with the
> config change interrupt on ndo_open(). (E.g try to ack announce is
> meaningless when the device is down).

Or maybe you meant to make config_enabled a nest counter?

Thanks

>
> Thanks


