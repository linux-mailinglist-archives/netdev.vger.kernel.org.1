Return-Path: <netdev+bounces-147907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50359DF045
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 13:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937FC1633DC
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD04155CB0;
	Sat, 30 Nov 2024 12:08:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156DAD23
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732968521; cv=none; b=YN3N6KeI/EqlynQW7BrkPQTQJ+ecZLGdyYlEqCfXrzzZoV4jXS9wE4Eha3joimYnSsA8K+tnx1qr7PgEmc/ZGtsFugD8Hh84EpZ7YX+hqhtzG4zAcrbC/SlVI9bq0XkKvb+u1rI9CSHUnH1aeI1BhllFoqbn0JJYSx1rdW1rPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732968521; c=relaxed/simple;
	bh=sfortfnCsVGJ0sBtYZ2YpGiQ9QhOu8MqfidTXy8Zb2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Yp0f09YAK8fgbJZvNt8efVYbMUEvQMR7HhfdnF6oADuFlMBab9F07pVCwE/M0lu4FiVX1HicQxxy9Ov1ChasS7PJeYarq9RoaNWyCiDn/ikvNvc+nutogfDdQyhW5Fk6gB3dp1mMldvPNONsY1MVgB44NP+hK71BeBKm/8f3zFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-9-AKHHcEJZPPSsj3Gy6ahZuw-1; Sat, 30 Nov 2024 12:08:30 +0000
X-MC-Unique: AKHHcEJZPPSsj3Gy6ahZuw-1
X-Mimecast-MFC-AGG-ID: AKHHcEJZPPSsj3Gy6ahZuw
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 30 Nov
 2024 12:08:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 30 Nov 2024 12:08:09 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Cong Wang' <xiyou.wangcong@gmail.com>, Frederik Deweerdt
	<deweerdt.lkml@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dhowells@redhat.com"
	<dhowells@redhat.com>
Subject: RE: [PATCH net] splice: do not checksum AF_UNIX sockets
Thread-Topic: [PATCH net] splice: do not checksum AF_UNIX sockets
Thread-Index: AQHbQsku2GTdmYph6EuwTd6Tcu7oVbLPuDvg
Date: Sat, 30 Nov 2024 12:08:09 +0000
Message-ID: <aef4869613f6418a9cc01ba4f012520c@AcuMS.aculab.com>
References: <Z0pMLtmaGPPSR3Ea@xiberoa> <Z0ptqDcLjrjqruQA@pop-os.localdomain>
In-Reply-To: <Z0ptqDcLjrjqruQA@pop-os.localdomain>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YJ2WxhFGQ81UDfWLe0Bje6-XwItJYtgci9Wy4xevXa8_1732968510
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Cong Wang <xiyou.wangcong@gmail.com>
> Sent: 30 November 2024 01:43
>=20
> On Fri, Nov 29, 2024 at 03:20:14PM -0800, Frederik Deweerdt wrote:
> > When `skb_splice_from_iter` was introduced, it inadvertently added
> > checksumming for AF_UNIX sockets. This resulted in significant
> > slowdowns, as when using sendfile over unix sockets.
> >
> > Using the test code [1] in my test setup (2G, single core x86_64 qemu),
> > the client receives a 1000M file in:
> > - without the patch: 1577ms (+/- 36.1ms)
> > - with the patch: 725ms (+/- 28.3ms)
> >
> > This commit skips addresses the issue by skipping checksumming when
> > splice occurs a AF_UNIX socket.
> >
> > [1] https://gist.github.com/deweerdt/a3ee2477d1d87524cf08618d3c179f06
> >
> > Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> > Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuf=
f for MSG_SPLICE_PAGES")
> > ---
> >  net/core/skbuff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 6841e61a6bd0..49e4f9ab625f 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -7233,7 +7233,7 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb,=
 struct iov_iter *iter,
> >  =09=09=09=09goto out;
> >  =09=09=09}
> >
> > -=09=09=09if (skb->ip_summed =3D=3D CHECKSUM_NONE)
> > +=09=09=09if (skb->ip_summed =3D=3D CHECKSUM_NONE && skb->sk->sk_family=
 !=3D AF_UNIX)
>=20
> Are you sure it is always safe to dereferene skb->sk here? I am not sure
> about the KCM socket case.
>=20
> Instead of checking skb->sk->sk_family, why not just pass an additional
> boolean parameter to this function?

A thought.
It is ever actually worth doing an 'early checksum' in software for either
TCP or UDP?
Most modern ethernet hardware supports transmit checksum offload, so there
is nothing to be gained by doing the checksum during a copy and everything
to be lost because the copy is a lot slower.

I think the code always does a checksum when copying data in send()
pretty much all the time it isn't needed.

The same is true for the delayed checksum of receive UDP.
I'm not sure what the rational for that was (and Linus can't remember),
my guess is a userspace NFS daemon.
But it seriously complicated the code.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


