Return-Path: <netdev+bounces-152867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86719F6106
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E028162C9E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1CF192B95;
	Wed, 18 Dec 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BF/Wq7Em"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD79192B83;
	Wed, 18 Dec 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512883; cv=none; b=koOHmnQiu/9JrKDpXcVnXMVhGRXz9cwkuGHVLoZMcUNDzviHpv94oUMBBZk+ucRZ0Z6HxbPm15aPl69Y1fuk5jcvTWDI3qKi8NQZXMZn7A75wsm5luQW1HlGsfkJso+WnCDkaTz1nKV8kIbsU+T6yG7A2x1mq881BhRcTYESZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512883; c=relaxed/simple;
	bh=16mMtJuOvxw8d3/oUHhHWZ1p+UqOMxaBYih6OxWvsg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnOoHo28yfhxUYGhE/RVc8YVSi8YjbYNzSLgoMWuDovf8j6VgHiVLCLn5xDLXb9eQecLODU4xnVBHO8eKcFhA2YKmvRDVu1NYo356ClBQO0Cz5Zxvn7vQY/buKgUyQEpptPmxiF40P8pwbX7EG83YAwd+DNUIKSCNsv/eOMe/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BF/Wq7Em; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 125FD24000B;
	Wed, 18 Dec 2024 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734512878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMuYYSNrGJHO3pOqsca4n7mxUQZgqKNB0TGOKm+gUDs=;
	b=BF/Wq7Em1diblMfNugnFc3Vm9120IrW2mvjOs7goniIA9ErD5oztxF4gwJ8Z9c/YKZCYxc
	mEWdKFqXn/CucYg6tE6F8+5WNLsPjsaIFJbaFuYNqfKWE2zdri32qy5faVdRZc0vprmjta
	bVrBR+kfX7VJJ850BppGCWA1ZFL0i5BI+ifyu6zjfmREA/2gXO9PvuBJHZ5LwqafHJYtAN
	C7bYJ52TMMzIMK3m8uc02GJ6IsC03ylg+xgY0PHEqpgCL+UzfbVb5Cu83pEvBgyYL7nP/w
	NCo7hhVZlOt/KgDy5RYgckng1WM7uIig2hX6JRIbSLTbytIFpGa/kpB757oPUg==
Date: Wed, 18 Dec 2024 10:07:56 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: ethtool: Fix suspicious rcu_dereference
 usage
Message-ID: <20241218100756.30de216b@kmaincent-XPS-13-7390>
In-Reply-To: <CANn89iJcQis_1u5PyBn6gPhge1r6SsVicCCywKeVTrjn9o83_g@mail.gmail.com>
References: <20241217140323.782346-1-kory.maincent@bootlin.com>
	<CANn89iJ3sax3eRDPCF+sgk4FQzTn45eFuz+c+tE9sD+gE_f4jA@mail.gmail.com>
	<20241217181712.049b5524@kmaincent-XPS-13-7390>
	<CANn89iJcQis_1u5PyBn6gPhge1r6SsVicCCywKeVTrjn9o83_g@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 17 Dec 2024 18:28:16 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Tue, Dec 17, 2024 at 6:17=E2=80=AFPM Kory Maincent <kory.maincent@boot=
lin.com>
> wrote:
> >
> > On Tue, 17 Dec 2024 16:47:07 +0100
> > Eric Dumazet <edumazet@google.com> wrote:
> > =20
> > > On Tue, Dec 17, 2024 at 3:03=E2=80=AFPM Kory Maincent <kory.maincent@=
bootlin.com>
> > > wrote: =20
>  [...] =20
> > >
> > > I have to ask : Can you tell how this patch has been tested ? =20
> >
> > Oh, it was not at all sufficiently tested. Sorry!
> > I thought I had spotted the issue but I hadn't.
> > =20
> > > rcu is not held according to syzbot report.
> > >
> > > If rtnl and rcu are not held, lockdep will still complain. =20
> >
> > You are totally right.
> > I may be able to see it with the timestamping kselftest. I will try. =20
>=20
> syzbot has a repro that you can compile and run.

Oh indeed, thanks for the pointer.

> Make sure to build and use a kernel with
>=20
> CONFIG_PROVE_LOCKING=3Dy

Yes I did.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

