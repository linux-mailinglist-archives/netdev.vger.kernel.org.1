Return-Path: <netdev+bounces-105161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C17890FEC9
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA18EB22464
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABCE19580F;
	Thu, 20 Jun 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzmHs1O/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A1158A3E
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872075; cv=none; b=CW8GMz+WCS2auwEXpcuqwD+pPIbI0ZyKu+DN1F0b8V6akanp5jVNaWL4I7Qby0hcvymMlCH/odFTHKrfKgGy6SO1mZvhKNN1Z5j3n4vU9h5qTtYMWpp12z/eqsEOO3P+/7UKhw+rkKcSXQC8acSmB/JnuMg9EWCap115oMiSLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872075; c=relaxed/simple;
	bh=Q7qq9TpLHXbiRmyngYdWJcra7kmlcDHD89XeuynC+YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpqrTdt+hJxrzfucZgtCCd2uCVKlM04EYYN9v39mafQ1nEfEAN/lEJHBtCD8JwbP2i0qPKjbhEs+Si4QRXlzXMiur2PFJFp9/N+x8pRRjBP4JCdA9p3F56gMjEWJvg0k3dCYek8YBOtWFjUDmC7j8/7s+xgfoLCFcwa33lGkJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzmHs1O/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMWB+k5AtlGl2iX/M3MX2kWjllYDfPs71Gjiz22BUTs=;
	b=dzmHs1O/sh0RP0aWinb+oUR2b1UAjTZIuoKsHhZeTOV3OcCgjdf4VY8cgO+PlUSN0Iqnij
	NQJcw6/2DLui3bzChBxE9u+r6U/6SHQ849mPBcD1p1YVaZvEkh0ENww+Mf9BFzAuYAP9bT
	8TTdaq6gabLvoFm+/kzBPJqM7NRo/Xw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-A6zx0_0xMJGjV3TG_3Xuhg-1; Thu, 20 Jun 2024 04:27:49 -0400
X-MC-Unique: A6zx0_0xMJGjV3TG_3Xuhg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c7c3069f37so812561a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872068; x=1719476868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMWB+k5AtlGl2iX/M3MX2kWjllYDfPs71Gjiz22BUTs=;
        b=Cxc/L+5h7PVjTBoadhpb4l48MmAjo7MCl0pe9dNUsgKR7/V60oRafS26S28DCVdvok
         cSrGXKNr87HQ9Ztbn+UtvkAUf0NIDwvZWgKEFnKGCBXD+DLdGX3aZA8SD/+F96q+Hkua
         2lbJks69hnXv+oGc5E81JpS+kmG8EhlZ/fwWYldItQXSY5FWOAEE1U+youet5YfVP3Jp
         VnpU74HXUUrMj9HgRCzrP3gI9XWFVDHwlWzXQ9kQCYlFuLILznBaS7pCgs9rdJgps6Bv
         rdm+p7r7H/UtdiudUm88JoCoRhQGRVWyY21v0zI75asBnLeT5mH2RakasQi1ZBxvPpi7
         rEPA==
X-Forwarded-Encrypted: i=1; AJvYcCXByM/tYbGddZznTLvrPlceyWoo5HGvneoWkD+MWyb/cou4QEy+UvsgQ1vMW4GMDMGHQSr8Gl0c8JbYoqhlntEpaILZwZ6k
X-Gm-Message-State: AOJu0YzFzwxOerv+8MkT9Lgkr+HkeZw2vXoCbr9VGrqIglpnyQXpeDT/
	LkVeEbTAwbN4iJz7TOEs+SaUBvnBVxDuKER43evtd0pl6u7JlEh3rJpEeZDMNpaqlwPu9GQ3SfL
	SFIZcz+9RVJ1eH3XhY6NRzlOg7RnMgI+S8EHoK7u9BgqSUBN170H9/Mxm+hHLfUU0RKczCFDiB5
	UpceOICGcXXx9UfdQHlXtzkIg82FDs
X-Received: by 2002:a17:90a:c243:b0:2c7:700e:e2bf with SMTP id 98e67ed59e1d1-2c7b5cbdb3amr4852578a91.20.1718872068664;
        Thu, 20 Jun 2024 01:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGkq3SOyzSmbVDgjJyAR8QpUMzNvxVjXrDvqED4Wna271/5in8lNaeBdfhxp367xX9ZvVXbF3oe3N/NiCLIpk=
X-Received: by 2002:a17:90a:c243:b0:2c7:700e:e2bf with SMTP id
 98e67ed59e1d1-2c7b5cbdb3amr4852549a91.20.1718872068289; Thu, 20 Jun 2024
 01:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
 <20240530090742-mutt-send-email-mst@kernel.org> <CACGkMEsYRCJ96=sja9pBo_mnPsp75Go6E-wmm=-QX0kaOu4RFQ@mail.gmail.com>
 <CACGkMEu2vb8njbNHExWnDAG_pFjsLkYChgNerH4LAQ7pbYyEcg@mail.gmail.com> <20240620014550-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620014550-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:27:36 +0800
Message-ID: <CACGkMEvEySbG74u0_FGh7TathQoNijqR3TDxVSO6q8EQT6Xzsg@mail.gmail.com>
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

On Thu, Jun 20, 2024 at 1:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 06, 2024 at 08:22:13AM +0800, Jason Wang wrote:
> > On Fri, May 31, 2024 at 8:18=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, May 30, 2024 at 9:09=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> > > > > On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > > > > > This patch synchronize operstate with admin state per RFC2863=
.
> > > > > > >
> > > > > > > This is done by trying to toggle the carrier upon open/close =
and
> > > > > > > synchronize with the config change work. This allows propagat=
e status
> > > > > > > correctly to stacked devices like:
> > > > > > >
> > > > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > > > ip link set link enp0s3 down
> > > > > > > ip link show
> > > > > > >
> > > > > > > Before this patch:
> > > > > > >
> > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast st=
ate DOWN mode DEFAULT group default qlen 1000
> > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > ......
> > > > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> =
mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > >
> > > > > > > After this patch:
> > > > > > >
> > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast st=
ate DOWN mode DEFAULT group default qlen 1000
> > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > ...
> > > > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN=
> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default ql=
en 1000
> > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > >
> > > > > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > > Changes since V1:
> > > > > > > - rebase
> > > > > > > - add ack/review tags
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++---=
----------
> > > > > > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > > > > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > > > > > >       /* The lock to synchronize the access to refill_enabled=
 */
> > > > > > >       spinlock_t refill_lock;
> > > > > > >
> > > > > > > +     /* Is config change enabled? */
> > > > > > > +     bool config_change_enabled;
> > > > > > > +
> > > > > > > +     /* The lock to synchronize the access to config_change_=
enabled */
> > > > > > > +     spinlock_t config_change_lock;
> > > > > > > +
> > > > > > >       /* Work struct for config space updates */
> > > > > > >       struct work_struct config_work;
> > > > > > >
> > > > > >
> > > > > >
> > > > > > But we already have dev->config_lock and dev->config_enabled.
> > > > > >
> > > > > > And it actually works better - instead of discarding config
> > > > > > change events it defers them until enabled.
> > > > > >
> > > > >
> > > > > Yes but then both virtio-net driver and virtio core can ask to en=
able
> > > > > and disable and then we need some kind of synchronization which i=
s
> > > > > non-trivial.
> > > >
> > > > Well for core it happens on bring up path before driver works
> > > > and later on tear down after it is gone.
> > > > So I do not think they ever do it at the same time.
> > >
> > > For example, there could be a suspend/resume when the admin state is =
down.
> > >
> > > >
> > > >
> > > > > And device enabling on the core is different from bringing the de=
vice
> > > > > up in the networking subsystem. Here we just delay to deal with t=
he
> > > > > config change interrupt on ndo_open(). (E.g try to ack announce i=
s
> > > > > meaningless when the device is down).
> > > > >
> > > > > Thanks
> > > >
> > > > another thing is that it is better not to re-read all config
> > > > on link up if there was no config interrupt - less vm exits.
> > >
> > > Yes, but it should not matter much as it's done in the ndo_open().
> >
> > Michael, any more comments on this?
> >
> > Please confirm if this patch is ok or not. If you prefer to reuse the
> > config_disable() I can change it from a boolean to a counter that
> > allows to be nested.
> >
> > Thanks
>
> I think doing this in core and re-using config_lock is a cleaner approach=
 for sure, yes.
>
> For remove we do not need stacking. But yes we need it for freeze.
>
> I am not sure how will a counter work. Let's see the patch.
>
>
> It might be easier, besides config_enabled, to add config_disabled,
> document that  config_enabled is controlled by core,
> config_disabled by driver.
> And we'd have 2 APIs virtio_config_disable_core and
> virtio_config_disable_driver.
>
>
> But I leave that decision in your capable hands.

Let me try to switch to using a counter for config_enabled first.

Thanks

>
>
>
> > >
> > > Thanks
> > >
> > > >
> > > > --
> > > > MST
> > > >
>


