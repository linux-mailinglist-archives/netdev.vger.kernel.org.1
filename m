Return-Path: <netdev+bounces-112366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B79389FC
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6EB1C20FB9
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D31BC3C;
	Mon, 22 Jul 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEfIGlaf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE381B960
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633090; cv=none; b=HleMBHwcoV4H+bdx5pXBgYc/gHWxDziJb71g5B0YHe2kGJyQn/Lf5R48xk335auTcuP1ltSClTA6gekuL+fNfBdUkvU4m2Jkoj6+rnUQJ7vf+UFLBHlve0jOxycnHiWRH1q+QxgTjXKV5WOj7ezghv0Hh+4GUDNlpYekt8cOJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633090; c=relaxed/simple;
	bh=v7PvEK9SRryhQ0yl2RVyk/L4XGuIY0eQHGxznJK09FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8KbSmdegq2+LGTnyBInZmwO08oL4VGxo4Jme/GNwmMmNGrN3nbl0mCKDrbaXDLQh5J7UlBGKzNarEHV5aMcq8gAvKVZyvJQdKuC1CAGxIZsUh1lw03SKcqdxK0z6wctGRf90BqJXkJenEgCSyXXleW6BlQGzT4cwvn6HzMmLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEfIGlaf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721633087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b8DbvMTIZs4UYUWpNzuhLY/mHU8qxZgrbal7u48m9Q=;
	b=ZEfIGlaf29NhcL9i2THuMka/DELMvfxHE613uQn0md7+BBRMlllbeECLVtScOXHVkeiQ/2
	kTci21xeKVFpZZak0p1q6BI+fXtWBFm8B1ytrhFXc1wbyPZstvYdow2hZLCa3PLrfALSOc
	O2TBBwQ2QL7tHqzNJF0NcUdHxG90K40=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-hy-bHEP8MNilzNLUniH7-Q-1; Mon, 22 Jul 2024 03:24:45 -0400
X-MC-Unique: hy-bHEP8MNilzNLUniH7-Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb567fccf4so3041210a91.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 00:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633085; x=1722237885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b8DbvMTIZs4UYUWpNzuhLY/mHU8qxZgrbal7u48m9Q=;
        b=CwN/UQBOUqHuku/9yfNw3Gumcyc2pGt8TM48DxEohHimzRswNM9A3ToxGY3NBwchvq
         ptmTCHpX0YzmxiubmL9axkCAsAZ62rsMIe1o4ipESrYXOfr9hR/yaWl9v0FDOR0Ix0zL
         v//bsg/pyE81AotDPJ3zizexIiAxLYAP4RDhQ494Vm7b4+ONH/xcFCUfKj/PnDjFyTbG
         Xdg0RlBGiA5b2GoSd+iEH2LPAxc/CWOTfn/A/YX83i1s2pa6YcZ1WPgKx+iDhf1hy+1G
         W/ih0Efk2+TOfedaI+KU/dDtiAosCP0kxaIz97jWkC0KIG0KJS4wv3eaGN1zESwUVOjg
         EM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq0H8BCDEZQ1wkNGGucgxLgZjYINcelgZAEmTf+vO8Efev/I5P20136SwwI83oi9LtZjy48r8ALx97OdLntpwodi6oRgE1
X-Gm-Message-State: AOJu0YyHfNLs+8vwB10ZjGkrEHtNLO+OmBUmcVPDJ6fqBPzBWVA2QHFH
	3EauaXxTeqWCDDJEUeIh1w35Ar2oIdbaMFy1eLL04gvkAQs4ixZOLQb3SGLyzMRZjn6i60nztNJ
	DoxUPv7Ih4yjM7faJ6pdD8sxzjlTtELHEqxOsly3LOzFiYlz6jRgo7ClECiMP68KQrmzRp7QwrP
	LDveOUV+FP4ixGR4dPLSgjTayU2F3I
X-Received: by 2002:a17:90a:d804:b0:2c9:5c67:dd9e with SMTP id 98e67ed59e1d1-2cd27432530mr2182481a91.19.1721633084874;
        Mon, 22 Jul 2024 00:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxdBJ/mcGD/aWunnzQ1cFnQfiRB3cLn9nWcv3t64CQgVrqxXu9zfgIZNks+aHUVpy63rI4Xsl+ZPoOkSNQaEw=
X-Received: by 2002:a17:90a:d804:b0:2c9:5c67:dd9e with SMTP id
 98e67ed59e1d1-2cd27432530mr2182471a91.19.1721633084452; Mon, 22 Jul 2024
 00:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709080214.9790-1-jasowang@redhat.com> <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org> <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
 <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com>
 <20240717015904-mutt-send-email-mst@kernel.org> <CACGkMEtntsAyddgrtxrbQe407dZkitac4ogC7cASF=iYgsum_A@mail.gmail.com>
 <CACGkMEsd63vH3J5m_4srO3ww2MWGOPc31L4171PfQ7uersN7PQ@mail.gmail.com> <20240718211816-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240718211816-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:24:32 +0800
Message-ID: <CACGkMEsvCqymNBZdTB03SacL7JW8emAwgRuS+1e+VkzfEarBrw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:19=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 19, 2024 at 09:02:29AM +0800, Jason Wang wrote:
> > On Wed, Jul 17, 2024 at 2:53=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Jul 17, 2024 at 2:00=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Jul 17, 2024 at 09:19:02AM +0800, Jason Wang wrote:
> > > > > On Wed, Jul 10, 2024 at 11:03=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@=
redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > > > > > > This patch synchronize operstate with admin state per RFC28=
63.
> > > > > > > >
> > > > > > > > This is done by trying to toggle the carrier upon open/clos=
e and
> > > > > > > > synchronize with the config change work. This allows propag=
ate status
> > > > > > > > correctly to stacked devices like:
> > > > > > > >
> > > > > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > > > > ip link set link enp0s3 down
> > > > > > > > ip link show
> > > > > > > >
> > > > > > > > Before this patch:
> > > > > > > >
> > > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast =
state DOWN mode DEFAULT group default qlen 1000
> > > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > > ......
> > > > > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN=
> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > > >
> > > > > > > > After this patch:
> > > > > > > >
> > > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast =
state DOWN mode DEFAULT group default qlen 1000
> > > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > > ...
> > > > > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DO=
WN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default =
qlen 1000
> > > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > >
> > > > > > > I think that the commit log is confusing. It seems to say tha=
t
> > > > > > > the issue fixed is synchronizing state with hardware
> > > > > > > config change.
> > > > > > > But your example does not show any
> > > > > > > hardware change. Isn't this example really just
> > > > > > > a side effect of setting carrier off on close?
> > > > > >
> > > > > > The main goal for this patch is to make virtio-net follow RFC28=
63. The
> > > > > > main thing that is missed is to synchronize the operstate with =
admin
> > > > > > state, if we do this, we get several good results, one of the o=
bvious
> > > > > > one is to allow virtio-net to propagate status to the upper lay=
er, for
> > > > > > example if the admin state of the lower virtio-net is down it s=
hould
> > > > > > be propagated to the macvlan on top, so I give the example of u=
sing a
> > > > > > stacked device. I'm not we had others but the commit log is pro=
bably
> > > > > > too small to say all of it.
> > > > >
> > > > > Michael, any more comments on this?
> > > > >
> > > > > Thans
> > > >
> > > >
> > > > Still don't get it, sorry.
> > > > > > > > This is done by trying to toggle the carrier upon open/clos=
e and
> > > > > > > > synchronize with the config change work.
> > > > What does this sentence mean? What is not synchronized with config
> > > > change that needs to be?
> > >
> > > I meant,
> > >
> > > 1) maclvan depends on the linkwatch to transfer operstate from the
> > > lower device to itself.
> > > 2) ndo_open()/close() will not trigger the linkwatch so we need to do
> > > it by ourselves in virtio-net to make sure macvlan get the correct
> > > opersate
> > > 3) consider config change work can change the state so ndo_close()
> > > needs to synchronize with it
> > >
> > > Thanks
> >
> > Michael, are you fine with the above or I miss something there?
> >
> > Thanks
>
>
> I don't understand 3. config change can always trigger.
> what I do not like is all these reads from config space
> that now trigger on open/close. previously we did
> read
> - on probe
> - after probe, if config changed
>
>
> and that made sense.

Ok, not sure I get you all but I will post a new version to see.

Thanks

>
> --
> MST
>


