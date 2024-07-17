Return-Path: <netdev+bounces-111839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FDF933767
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 08:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEFD1F23531
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F71417BDC;
	Wed, 17 Jul 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEyzfCwt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4D168BD
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199205; cv=none; b=J8MdzZTc2Fb0UpYevQtCLenUReAD4aq3ubbgR3EzT+jcUD5vA1mOgMjpS8SWlBwbujz0ILC9jEpur8b89H9T+bYrt9mHLuQzECtjzQChWe2u7D5IxmXaWkfVSIJpDBhEXT8jJhdnjnKXNbCdoqvi2iU6PqedxpcqFMtdknTxNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199205; c=relaxed/simple;
	bh=uic/llVqAcebDBQyOtbh1hqN6xjJJmHzOFUf5hsJaeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0dNtmvWz3O8rxYknj/Ht9MwMiHELXrR6PiFgZtx9ib9jT7HG2De/SFgc52nujs3QH7PYXDkUdyFfkzBlm8yYaqZUJAQp63qIcEvZQxNANFJAPyBGoxnso3cA1Zsiigv2VxYfwrRX1cCIlW2XKAtKL/45EWz5zxL8gQiZuwwII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEyzfCwt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721199202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3wUHZxtL7ge8mhgj3gN0VcPUpLkTBbNSymS6wzbPTc=;
	b=XEyzfCwts3AtCWQSgCr6+CjZq/ALBveraoMOsAE3VcodSTrorfmJXPo12TujiEttGSwY/L
	fKJwQqbekZ7r2tg6KmJE2YJQYdNLos7aYFP5yvA3La8ciJXP+uBxoaKRM1etVBhtijNaVd
	a1/6QHN1XO4OldMMWf+ujhmY8xbnodA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-xAs-OPquMI67AW08q2XtCQ-1; Wed, 17 Jul 2024 02:53:20 -0400
X-MC-Unique: xAs-OPquMI67AW08q2XtCQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c96e73c888so6849711a91.3
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 23:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721199199; x=1721803999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3wUHZxtL7ge8mhgj3gN0VcPUpLkTBbNSymS6wzbPTc=;
        b=Utny64N2okYGK5aOZKcxt3WvvCWNk91C7R0pIRZz/sJWMPVrtjvPufzlb+fhwmME9k
         iQUTH0Hj9VpbDZm7nahH52C2Xsc1q/Bx9B/lcHxkEAHCqRWMGRYjt6oI81uvIdTessml
         fUwEITk5+VOvvdbLrsIVP42wJQY8LygfwGlDXGWZZWUvXpYFOIqjLgU/z15LyUhQEg8f
         xE/xwy15QMteaTg6YwJ8TewowvElAmwO6KMaYtPfw7JpXNBT7WITSfJhLUXjyEk7viip
         BGC89OPWaghxwOBc474lOjqqVElTZKOexkCCN54GnlrYhmueIobDEoInBIuo1Je8vJeO
         dPwA==
X-Forwarded-Encrypted: i=1; AJvYcCXD6ZA5LbMx2ONItwq2AWOd7A/9rqwFwm6vttu8kefPnfIVKyLZ8wWD9lQoMdY7p4YyJX3iYsktlipxzRjH8desYsA52YAK
X-Gm-Message-State: AOJu0YyPkQ9MlZE69NLvwPVNiJoSU/Dpt9XTXeOLLtGvJvaWBPzeDIiR
	oRWLu59edsAeo5G0hZWIjkwbVtYfyyelekVMHabysO9M+Jm2sEMlTJrQi2OQI6WtEtLBwGZ8ScU
	lvN8djR6lCnXjWwC+UJghPtiwuCDE4pDfexsM8Zyp09TdRomyuAHufdiQPZpbhmzaxgnzULryzf
	b893+npSMOMGvROlzOGJuLWf+c7l9W
X-Received: by 2002:a17:90b:1403:b0:2ca:d1dc:47e2 with SMTP id 98e67ed59e1d1-2cb52932383mr569034a91.33.1721199199374;
        Tue, 16 Jul 2024 23:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8jCLQ6um85ikfqpsMh6S5Hr0/9SWrMBmLpya6//pJpEdr011a67n7T3S3/Qgfa2EU+bKqVpScjxBtk7rsJA0=
X-Received: by 2002:a17:90b:1403:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2cb52932383mr569015a91.33.1721199198891; Tue, 16 Jul 2024
 23:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709080214.9790-1-jasowang@redhat.com> <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org> <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
 <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com> <20240717015904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240717015904-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Jul 2024 14:53:00 +0800
Message-ID: <CACGkMEtntsAyddgrtxrbQe407dZkitac4ogC7cASF=iYgsum_A@mail.gmail.com>
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

On Wed, Jul 17, 2024 at 2:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 17, 2024 at 09:19:02AM +0800, Jason Wang wrote:
> > On Wed, Jul 10, 2024 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > > >
> > > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > > > This patch synchronize operstate with admin state per RFC2863.
> > > > >
> > > > > This is done by trying to toggle the carrier upon open/close and
> > > > > synchronize with the config change work. This allows propagate st=
atus
> > > > > correctly to stacked devices like:
> > > > >
> > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > ip link set link enp0s3 down
> > > > > ip link show
> > > > >
> > > > > Before this patch:
> > > > >
> > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state =
DOWN mode DEFAULT group default qlen 1000
> > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > ......
> > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu =
1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > >
> > > > > After this patch:
> > > > >
> > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state =
DOWN mode DEFAULT group default qlen 1000
> > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > ...
> > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mt=
u 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1=
000
> > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > I think that the commit log is confusing. It seems to say that
> > > > the issue fixed is synchronizing state with hardware
> > > > config change.
> > > > But your example does not show any
> > > > hardware change. Isn't this example really just
> > > > a side effect of setting carrier off on close?
> > >
> > > The main goal for this patch is to make virtio-net follow RFC2863. Th=
e
> > > main thing that is missed is to synchronize the operstate with admin
> > > state, if we do this, we get several good results, one of the obvious
> > > one is to allow virtio-net to propagate status to the upper layer, fo=
r
> > > example if the admin state of the lower virtio-net is down it should
> > > be propagated to the macvlan on top, so I give the example of using a
> > > stacked device. I'm not we had others but the commit log is probably
> > > too small to say all of it.
> >
> > Michael, any more comments on this?
> >
> > Thans
>
>
> Still don't get it, sorry.
> > > > > This is done by trying to toggle the carrier upon open/close and
> > > > > synchronize with the config change work.
> What does this sentence mean? What is not synchronized with config
> change that needs to be?

I meant,

1) maclvan depends on the linkwatch to transfer operstate from the
lower device to itself.
2) ndo_open()/close() will not trigger the linkwatch so we need to do
it by ourselves in virtio-net to make sure macvlan get the correct
opersate
3) consider config change work can change the state so ndo_close()
needs to synchronize with it

Thanks


