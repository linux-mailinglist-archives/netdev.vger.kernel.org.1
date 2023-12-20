Return-Path: <netdev+bounces-59206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C96819DC1
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 12:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8390C1F22537
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008F210F3;
	Wed, 20 Dec 2023 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="EcGKt5LR"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE621340
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=3096; s=dkim-tub; t=1703070891;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=Iu50ugcbXNXt8U+5nmmJ1O0YCR7uppJruqg/NtFXAAE=;
  b=EcGKt5LRpRwx/i8orPsosznRB5EgKhd5AjNP0yyiMkIQiWQRS+dnz1pW
   AnypzfqTqPHW0daAIPAezEvuxp6zs3KINz+Bo1c27ktu9ipB4dBHKFpjt
   DiUHmk8oit2tycRZW3sP5aVOwp9BFOpO+AggmoJCuysXtEcxD/zKQ2ZrF
   c=;
X-CSE-ConnectionGUID: NV91EUNHSPyChAQeO4BTDQ==
X-CSE-MsgGUID: TFwjE/6QRn2AzUZmhee+5g==
X-IronPort-AV: E=Sophos;i="6.04,291,1695679200"; 
   d="scan'208";a="14415151"
Received: from postcard.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.142])
  by mailrelay.tu-berlin.de with ESMTP; 20 Dec 2023 12:13:39 +0100
Message-ID: <bff57ee057bdd15a2c951ff8b6e3aaa30f981cd2.camel@mailbox.tu-berlin.de>
Subject: Re: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
From: =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Thomas Lange <thomas@corelatus.se>, Netdev
	<netdev@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, John
 Fastabend <john.fastabend@gmail.com>
Date: Wed, 20 Dec 2023 12:13:36 +0100
In-Reply-To: <0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
	 <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
	 <0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Arnd,

thanks for indirectly pinging me here about the unfinished patches. I
kinda forgot about them over other things happening.

Happy to look back into them, it looks like it would be helpful to
apply them. Is it fine to just answer the remarks from earlier this
year, after a few months, in the same mail thread? Or preferable to
resubmit the series[1] first?

Thorben

[1]
https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox.tu-berl=
in.de/

On Wed, 2023-12-20 at 09:43 +0000, Arnd Bergmann wrote:
> On Wed, Dec 20, 2023, at 04:00, Willem de Bruijn wrote:
> > Thomas Lange wrote:
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 16584e2dd648..a56ec1d492c9 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk,
> > > struct cmsghdr *cmsg,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sockc->mark =3D *(u32 *)CMSG_DATA(cmsg);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIMESTAMPING=
_OLD:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIMESTAMPING_NEW:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return -EINVAL;
> > >=20
> > > However, looking through the module, it seems that
> > > sk_getsockopt() has no
> > > support for SO_TIMESTAMPING_NEW either, but sk_setsockopt() has.
> >=20
> > Good point. Adding the author to see if this was a simple oversight
> > or
> > there was a rationale at the time for leaving it out.
>=20
> I'm fairly sure this was just a mistake on our side. For the cmsg
> case,
> I think we just missed it because there is no corresponding
> SO_TIMESTAMP{,NS}
> version of this, so it fell through the cracks.
>=20
> In the patch above, I'm not entirely sure about what needs to happen
> with the old/new format, i.e. the
>=20
> =C2=A0=C2=A0 sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname =3D=3D
> SO_TIMESTAMPING_NEW)
>=20
> from setsockopt(). Is __sock_cmsg_send() allowed to turn on
> timestamping
> without it being first enabled using setsockopt()? If so, I think
> we need to set the flag here the same way that setsockopt does. If
> not, then I think we instead should check that the old/new format
> in the option sent via cmsg is the same that was set earlier with
> setsockopt.
>=20
> For the missing getsockopt, there was even a patch earlier this year
> by J=C3=B6rn-Thorben Hinz [1], but I failed to realize that we need patch
> 1/2 from his series regardless of patch 2/2.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20
> [1]
> https://lore.kernel.org/lkml/20230703175048.151683-2-jthinz@mailbox.tu-be=
rlin.de/


