Return-Path: <netdev+bounces-101979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B83900EEB
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 02:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE54281AE2
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 00:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974252579;
	Sat,  8 Jun 2024 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8U8aqva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10941FBB
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807345; cv=none; b=susEOF4Ct0jjodNFsemncHF/L9KMMqrfacFlhOZAhd0TW3bpxWENXyM7yZbrX1zRYOkc/tM0FAxKCbD7BxXwcRqefg5CEZShlQE8ivP5PUFXCXj7hBFoNJJsWWi4SLu+dFkVLhldWOMOamZbwIHU15I5fro+9R9r1NBOvrLDOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807345; c=relaxed/simple;
	bh=7CdzY8u60hVre4UuCBwjSH/y9SSMvN9FtIZmohj0aa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qcrth41Bp2Uq7dPqk7SOqjj2Oj6LJ86pkjVQ5+BbnFMzFfRPBnpXysoDqBI5GEtXWTBYDJrA2XhEV08jJn1d6+QlbPSZz69/+Vmnx7m58sOYSdUgf6Jt7GxNZZgvG09Tsn1kB218ca+ASyogJPCBSVfM1gOadon/H4Dqt+BCb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8U8aqva; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c614c572aso896554a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 17:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807342; x=1718412142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CdzY8u60hVre4UuCBwjSH/y9SSMvN9FtIZmohj0aa8=;
        b=l8U8aqvaffd4EqWUxjkoOpdRMCgXJzPCT/yzPK4n5z0NrAG9RFzq5TnzeZ9PvnDc4S
         cu638igwdgvdUkYVxl9FJBuPHfeaOmkMMgJCiRfHxjVPyI/TdpuqCuk6sXTZMncEgWyZ
         aniIiOdtloig7VwqfUP7ifa9afvf7U7oQZvPJbvra0UGPVA9UKtN5aJg8Q44EnDZro7d
         nhWmZocRD64N3C/0aCIvoTChbcjoxc5vf+FT70DQLhpcyHnVbxVEry+oAxEcn2QggT+J
         D6TX4a60IY58zbuRnOVyJXjftrRXt9v1y4BjKe1Zut7xBMoIF5oArvPCxbOFAt+pimPV
         fZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807342; x=1718412142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CdzY8u60hVre4UuCBwjSH/y9SSMvN9FtIZmohj0aa8=;
        b=bbb4tPjdTY6LQTKvn/cWzip1keFuu8J87Rt8bJauSpEn02knkVHpbi/kNLE/qBP4PG
         wzDWdD03ObqqdVHZ2d6Ih0hPl63HvJCkf5VPieRl3SBd208GeSesr7F+rINnQLrzwzka
         /jLAO82s0WQ+tjcenAp+kAQ2V9PBe6hNoszBt8lT+Zl7en4iXjMFP5wIyHU+nJuuzGYK
         OGRUZUI5r+pAY5+No+/5wQiQraThzEBKc7NmBOckCmTqqrnPDLptNrU0RYjgaYHlVcWk
         sZGBIt4dwvQPKOqOmcDMHfOTvaaBiLrF4YxT0Hxgg+o9bcslMZSsNeo8Vx8qdlpVvY8A
         wF5A==
X-Forwarded-Encrypted: i=1; AJvYcCUYyzW1a28+1CJXpzBfmQk2ZGddNSmhXWZiGy92sYsWPT6rV0C1/g8D0HqV4rvMDVmqeTmLbGY3pBRp3O1Tb3Qp4enByZB3
X-Gm-Message-State: AOJu0Ywj0k8BZUVHEYsBPKuxIGv2sE1HXVBl3woGD9MF1GNTeC9pIZHg
	0YtoRwj8RATW7b0/9CgimgaACsY3y1l4MRaaFMJ0DHLPC7zoPOYAX89WV1VA/JZUBG6J1trATFq
	V1xt5MGpyrM0QM3xLxk5eihkRBkE=
X-Google-Smtp-Source: AGHT+IEHWIDAolb0vOIBfsYcRRrGiN8TUODMF8KNwk7mL5ys88vHxhm2QSUBT863nTuguHxrsKwWwyX1lfIQk5ot9Ts=
X-Received: by 2002:a17:907:3584:b0:a68:90d5:1580 with SMTP id
 a640c23a62f3a-a6cd7a884demr255657066b.46.1717807341921; Fri, 07 Jun 2024
 17:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130142521.18593-1-danielj@nvidia.com> <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org> <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org> <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org> <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org> <CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com> <CH0PR12MB85804D451A889448D3427132C9FB2@CH0PR12MB8580.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB85804D451A889448D3427132C9FB2@CH0PR12MB8580.namprd12.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Jun 2024 08:41:44 +0800
Message-ID: <CAL+tcoDkpZva=aStFKWTO6_8VK2iu9CeSeW2aeC+2QTXR2nD=Q@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Dan Jurgens <danielj@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:37=E2=80=AFPM Dan Jurgens <danielj@nvidia.com> wro=
te:
>
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Sent: Friday, June 7, 2024 4:16 AM
> > To: Dan Jurgens <danielj@nvidia.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>; Michael S. Tsirkin <mst@redhat.co=
m>;
> > netdev@vger.kernel.org; jasowang@redhat.com;
> > xuanzhuo@linux.alibaba.com; virtualization@lists.linux.dev;
> > davem@davemloft.net; edumazet@google.com; abeni@redhat.com; Parav
> > Pandit <parav@nvidia.com>
> > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
> >
> > On Sat, Feb 3, 2024 at 12:46=E2=80=AFAM Daniel Jurgens <danielj@nvidia.=
com> wrote:
> > >
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Sent: Friday, February 2, 2024 10:01 AM
> > > > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake
> > > > counters
> > > >
> > > > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > > > Can you say more? I'm curious what's your use case.
> > > > >
> > > > > I'm not working at Nvidia, so my point of view may differ from th=
eirs.
> > > > > From what I can tell is that those two counters help me narrow
> > > > > down the range if I have to diagnose/debug some issues.
> > > >
> > > > right, i'm asking to collect useful debugging tricks, nothing
> > > > against the patch itself :)
> > > >
> > > > > 1) I sometimes notice that if some irq is held too long (say, one
> > > > > simple case: output of printk printed to the console), those two
> > > > > counters can reflect the issue.
> > > > > 2) Similarly in virtio net, recently I traced such counters the
> > > > > current kernel does not have and it turned out that one of the
> > > > > output queues in the backend behaves badly.
> > > > > ...
> > > > >
> > > > > Stop/wake queue counters may not show directly the root cause of
> > > > > the issue, but help us 'guess' to some extent.
> > > >
> > > > I'm surprised you say you can detect stall-related issues with this=
.
> > > > I guess virtio doesn't have BQL support, which makes it special.
> > > > Normal HW drivers with BQL almost never stop the queue by themselve=
s.
> > > > I mean - if they do, and BQL is active, then the system is probably
> > > > misconfigured (queue is too short). This is what we use at Meta to
> > > > detect stalls in drivers with BQL:
> > > >
> > > > https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.o=
r
> > > > g/
> > > >
> > > > Daniel, I think this may be a good enough excuse to add per-queue
> > > > stats to the netdev genl family, if you're up for that. LMK if you
> > > > want more info, otherwise I guess ethtool -S is fine for now.
> > >
> > > For now, I would like to go with ethtool -S. But I can take on the ne=
tdev
> > level as a background task. Are you suggesting adding them to
> > rtnl_link_stats64?
> >
> > Hello Daniel, Jakub,
> >
> > Sorry to revive this thread. I wonder why not use this patch like mlnx =
driver
> > does instead of adding statistics into the yaml file? Are we gradually =
using or
> > adding more fields into the yaml file to replace the 'ethtool -S' comma=
nd?
> >
>
> It's trivial to have the stats in ethtool as well. But I noticed the stat=
s series intentionally removed some stats from ethtool. So I didn't put it =
both places.

Thank you for the reply. I thought there was some particular reason :-)

