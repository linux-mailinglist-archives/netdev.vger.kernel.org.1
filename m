Return-Path: <netdev+bounces-99595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747048D56D2
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 02:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2720E287803
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4817E9;
	Fri, 31 May 2024 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJrJEChX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA56AB6
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114697; cv=none; b=Ir8w6XU9W6IZrXBmEf/ZyclrwdqRs2Mo/+BsjlcAT08N01GFFI+FJ46u9NrNV1jQC2VkwTwILRxzjG9L0oEO3UWq1+LAqKNkZBEVi9D0CwB1+Hs3egZg4WNstiEKXOIlQ96nIyJFt8T+A6CWTnv2SDEGGA5Rwz0X+lDSjizjYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114697; c=relaxed/simple;
	bh=KNXVkfWiz4Q50vCls1kWwILJ5qinN5zXnC4J+4f1Haw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFAJx6jVCtt4PZcL+4/MhfCLTGEJtb8+Op5+eBvEqDek06j/OBDZWW/8p8WVj9k8zL18iT8e2/Q4WM5InvDOy8h0UcQrxWfWX8Qp+eJlnPB1StWaGJsgPiGjjUJ2Ykf8bj2xA8DiOtUSW/C2aFtzge1ljWFZOSjm5q8PtDMOXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJrJEChX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717114694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jGk8SEMK5Bvtc/9k59FnMjRJyI8k1VJ2cg/HKGkhc4=;
	b=EJrJEChXPnVsS+OcqArUM4mqrFgU4x0z+c8JDI4QIQEjB3J0eLXicJeGHij14WxnPClZpN
	eJCuiJKMGVBnkgX7bfKIVQdstrINo7TWYhkNidWjRLxK50ZksI5qWYEVHLAErfteEmAVs3
	3mFK94jM5NTKPMooN5J9kmYdgwG5Wno=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Nvl0DVqCOza0pMYPSF_5hg-1; Thu, 30 May 2024 20:18:13 -0400
X-MC-Unique: Nvl0DVqCOza0pMYPSF_5hg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2bf5e099692so1368557a91.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717114692; x=1717719492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jGk8SEMK5Bvtc/9k59FnMjRJyI8k1VJ2cg/HKGkhc4=;
        b=hm8plprPZTEzAAhzObS+OkLqjCbutwIi7v30MeE/oUiy2usBlXvtACdMqkZA0bX86Q
         2YLEWUo016VWwm8TOMDBUb4rCbqqqwwSIjceOJPVZGpsU26cfwdwHa5sSVvh7TAgJb3Y
         Us2ascH2tB2IqhuX0aMHMLCkE6NbkcBOVaKThdJksM8LP8B651vDrDdCMNGuR+g9WTlH
         9gVI3xierTMN9a57KaOcoLsWMqEtPUbxqOSuE1f1sx/7LKP0IKGcX8RQ8xnrrH4m5ct0
         2eFl/cpLvSiUOOl//TFgkImgjI2UFqld5jwD5nQouCFuk6zCOljR3+tntz/dY5zBAacb
         y4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV+KsAydHJkf3/WsNNguzof1i+AtLsxTzNhXBwKnTnZEdjRpnid5/2hFZPxV6iMXych2kpMT9Qto4ZDpp/n6JvAoIxuK5w3
X-Gm-Message-State: AOJu0YzmEPCP97QkrWPy72z8pdsXgac7A09ELPLJCa6KASyr0s6mM2zo
	YtvdDVXYDQDJs8yWuQxKGqgXR2HlAurcO7W4fZQULAukg+qw6IO7mR7z+Lv9+gbxe3LyniIMqIW
	zObCt71Ql8fjK/BKseKIjZWKcTElml4Ua+Zjz/xERgnSn0nOWL705Ldg50xzwCIYqHhgr7crthC
	Htjo6tkg3xj8cW/6bS5zHIMt/djiAv
X-Received: by 2002:a17:90a:e28d:b0:2b9:e009:e47a with SMTP id 98e67ed59e1d1-2c1acc3d22cmr4688024a91.10.1717114691755;
        Thu, 30 May 2024 17:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGtxuo6Bp6PN93cBewrcbzjLxTqiGmrfw4AWkEQU+ceUU0PXzAO9ChgAQ0Le5dYGJn1ZxgaARLQjE0Gw2KYLs=
X-Received: by 2002:a17:90a:e28d:b0:2b9:e009:e47a with SMTP id
 98e67ed59e1d1-2c1acc3d22cmr4687990a91.10.1717114691232; Thu, 30 May 2024
 17:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com> <20240530090742-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530090742-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 May 2024 08:18:00 +0800
Message-ID: <CACGkMEsYRCJ96=sja9pBo_mnPsp75Go6E-wmm=-QX0kaOu4RFQ@mail.gmail.com>
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

On Thu, May 30, 2024 at 9:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> > On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > > This patch synchronize operstate with admin state per RFC2863.
> > > >
> > > > This is done by trying to toggle the carrier upon open/close and
> > > > synchronize with the config change work. This allows propagate stat=
us
> > > > correctly to stacked devices like:
> > > >
> > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > ip link set link enp0s3 down
> > > > ip link show
> > > >
> > > > Before this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ......
> > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 15=
00 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > After this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ...
> > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu =
1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 100=
0
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > > Changes since V1:
> > > > - rebase
> > > > - add ack/review tags
> > >
> > >
> > >
> > >
> > >
> > > > ---
> > > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++---------=
----
> > > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > > >       /* The lock to synchronize the access to refill_enabled */
> > > >       spinlock_t refill_lock;
> > > >
> > > > +     /* Is config change enabled? */
> > > > +     bool config_change_enabled;
> > > > +
> > > > +     /* The lock to synchronize the access to config_change_enable=
d */
> > > > +     spinlock_t config_change_lock;
> > > > +
> > > >       /* Work struct for config space updates */
> > > >       struct work_struct config_work;
> > > >
> > >
> > >
> > > But we already have dev->config_lock and dev->config_enabled.
> > >
> > > And it actually works better - instead of discarding config
> > > change events it defers them until enabled.
> > >
> >
> > Yes but then both virtio-net driver and virtio core can ask to enable
> > and disable and then we need some kind of synchronization which is
> > non-trivial.
>
> Well for core it happens on bring up path before driver works
> and later on tear down after it is gone.
> So I do not think they ever do it at the same time.

For example, there could be a suspend/resume when the admin state is down.

>
>
> > And device enabling on the core is different from bringing the device
> > up in the networking subsystem. Here we just delay to deal with the
> > config change interrupt on ndo_open(). (E.g try to ack announce is
> > meaningless when the device is down).
> >
> > Thanks
>
> another thing is that it is better not to re-read all config
> on link up if there was no config interrupt - less vm exits.

Yes, but it should not matter much as it's done in the ndo_open().

Thanks

>
> --
> MST
>


