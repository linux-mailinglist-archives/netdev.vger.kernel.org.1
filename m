Return-Path: <netdev+bounces-59821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E780481C1FD
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9D8B21B09
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749878E72;
	Thu, 21 Dec 2023 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="DY57DQ30"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7876DB6
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=7347; s=dkim-tub; t=1703201557;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=zoxLUtgx1+4cyNugjgUrS7AXMTS1yH+9tIsS3k8Qhgk=;
  b=DY57DQ30+FBtQ0kx/eCuxqKCcKRlX3O2tzcFN1bRtPzg4wUa1Oq96oky
   o2HgLnMK1zAL9NvYaWRIoS9+vrhDjsGws5biy21ejl9B5eks0f581kx6P
   pFn/fB8otUSkFopIeyH+2h7DJgnXrOsCo5PUHrBwIRYgVjYJdscdsVPlW
   Y=;
X-CSE-ConnectionGUID: D8tqrjK7SYWrHeqbLQC/Gw==
X-CSE-MsgGUID: gZqmApS4RFqOrYpwoTTo8A==
X-IronPort-AV: E=Sophos;i="6.04,294,1695679200"; 
   d="scan'208";a="14653601"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 22 Dec 2023 00:32:34 +0100
Message-ID: <4ac608c49852fae8e6707508a00b39dcfd77eed2.camel@mailbox.tu-berlin.de>
Subject: Re: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
From: =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Arnd Bergmann
	<arnd@arndb.de>, Thomas Lange <thomas@corelatus.se>, Netdev
	<netdev@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "John
 Fastabend" <john.fastabend@gmail.com>
Date: Fri, 22 Dec 2023 00:32:29 +0100
In-Reply-To: <658470ecd37f1_82de329452@willemb.c.googlers.com.notmuch>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
	 <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
	 <0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com>
	 <bff57ee057bdd15a2c951ff8b6e3aaa30f981cd2.camel@mailbox.tu-berlin.de>
	 <6582ffd3e5dc7_1a34a429482@willemb.c.googlers.com.notmuch>
	 <7cf460a9eea4f52f928d8624fb9e8c54b7f15566.camel@mailbox.tu-berlin.de>
	 <658470ecd37f1_82de329452@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-21 at 12:07 -0500, Willem de Bruijn wrote:
> J=C3=B6rn-Thorben Hinz wrote:
> > On Wed, 2023-12-20 at 09:53 -0500, Willem de Bruijn wrote:
> > > J=C3=B6rn-Thorben Hinz wrote:
> > > > Hi Arnd,
> > > >=20
> > > > thanks for indirectly pinging me here about the unfinished
> > > > patches.
> > > > I
> > > > kinda forgot about them over other things happening.
> > > >=20
> > > > Happy to look back into them, it looks like it would be helpful
> > > > to
> > > > apply them. Is it fine to just answer the remarks from earlier
> > > > this
> > > > year, after a few months, in the same mail thread? Or
> > > > preferable to
> > > > resubmit the series[1] first?
> > >=20
> > > Please resubmit instead of reviving the old thread. Thanks for
> > > reviving
> > > that.
> > Thanks for the hint, will do so! (Maybe after Christmas.)
> >=20
> > >=20
> > > IIRC the only open item was to limit the new BPF user to the new
> > > API?
> > > That only applies to patch 2/2.
> > Another point was to not change the behavior of
> > getsockopt(SO_TIMESTAMPING_OLD), that=E2=80=99s just a minor change.
> >=20
> > About limiting BPF to the SO_TIMESTAMPING_NEW, I am unsure if this
> > is
> > feasible, necessary, or even makes a difference (for a BPF
> > program). In
> > many places, BPF just passes-through calls like to get-
> > /setsockopt(),
> > only testing whether this call is explicitly allowed from BPF
> > space.
> >=20
> > Also, due to its nature, BPF code often has to re-provide defines,
> > see
> > for example tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > This is
> > also the case for SO_TIMESTAMPING_*. A limitation of BPF to
> > SO_TIMESTAMPING_NEW could only be done in the allowed get-
> > /setsockopt()
> > calls, not through any BPF-provided defines.
> >=20
> > I will take another look at this aspect and add my
> > comments/findings to
> > a resubmission.
> >=20
> > >=20
> > > The missing sk_getsockopt SO_TIMESTAMPING_NEW might be breaking
> > > users,
> > > so is best sent stand-alone to net, rather than net-next.
> > Hmm, I initially sent both patches together and to bpf-next since
> > the
> > second, BPF-related patch depends (for the included selftest) on
> > the
> > first one already being applied.
> >=20
> > I=E2=80=99m unsure how to split them because of the dependency. Would o=
ne
> > add a
> > comment that commit X needs to be pulled in from net for commit Y
> > to be
> > applied in bpf-next? (That sounds bound to break something.)
> >=20
> > Also, getsockopt(SO_TIMESTAMPING_NEW) has been missing since 2019,
> > since SO_TIMESTAMPING_NEW was added. Do you think it is still
> > "urgent"
> > enough to provide it through net instead of net-next/bpf-next?
>=20
> net gets pulled into net-next at least once a week. If you submit
> this
> patch now, it will likely be in bpf-next by the time we get to the
> second more involved patch.
Thank you for the explanation. I wasn=E2=80=99t aware that the synchronizat=
ion
happens that frequently. Then it=E2=80=99s of course not a problem to split=
 the
series.

I=E2=80=99ve submitted the old patch 1/2 on its own to net.

>=20
> This report was a reminder that the current omission can actually
> break users, so having it as a fix that goes to stable is warranted.
> The Fixes tag will be
>=20
> Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
Agree, that sounds reasonable. The Fixes: was already present in the
old submission.

>=20
>=20
> > >=20
> > > > Thorben
> > > >=20
> > > > [1]
> > > > https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox=
.tu-berlin.de/
> > > >=20
> > > > On Wed, 2023-12-20 at 09:43 +0000, Arnd Bergmann wrote:
> > > > > On Wed, Dec 20, 2023, at 04:00, Willem de Bruijn wrote:
> > > > > > Thomas Lange wrote:
> > > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > > index 16584e2dd648..a56ec1d492c9 100644
> > > > > > > --- a/net/core/sock.c
> > > > > > > +++ b/net/core/sock.c
> > > > > > > @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock
> > > > > > > *sk,
> > > > > > > struct cmsghdr *cmsg,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sockc->mark =3D *(u32 *)CMSG_DATA(cmsg=
);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIME=
STAMPING_OLD:
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIMESTAMPING_NE=
W:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cmsg->cmsg_len !=3D
> > > > > > > CMSG_LEN(sizeof(u32)))
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EINVAL;
> > > > > > >=20
> > > > > > > However, looking through the module, it seems that
> > > > > > > sk_getsockopt() has no
> > > > > > > support for SO_TIMESTAMPING_NEW either, but
> > > > > > > sk_setsockopt()
> > > > > > > has.
> > > > > >=20
> > > > > > Good point. Adding the author to see if this was a simple
> > > > > > oversight
> > > > > > or
> > > > > > there was a rationale at the time for leaving it out.
> > > > >=20
> > > > > I'm fairly sure this was just a mistake on our side. For the
> > > > > cmsg
> > > > > case,
> > > > > I think we just missed it because there is no corresponding
> > > > > SO_TIMESTAMP{,NS}
> > > > > version of this, so it fell through the cracks.
> > > > >=20
> > > > > In the patch above, I'm not entirely sure about what needs to
> > > > > happen
> > > > > with the old/new format, i.e. the
> > > > >=20
> > > > > =C2=A0=C2=A0 sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname =3D=
=3D
> > > > > SO_TIMESTAMPING_NEW)
> > > > >=20
> > > > > from setsockopt(). Is __sock_cmsg_send() allowed to turn on
> > > > > timestamping
> > > > > without it being first enabled using setsockopt()? If so, I
> > > > > think
> > > > > we need to set the flag here the same way that setsockopt
> > > > > does.
> > > > > If
> > > > > not, then I think we instead should check that the old/new
> > > > > format
> > > > > in the option sent via cmsg is the same that was set earlier
> > > > > with
> > > > > setsockopt.
> > >=20
> > > __sock_cmsg_send can only modify a subset of the bits in the
> > > timestamping feature bitmap, so a call to setsockopt is still
> > > needed
> > >=20
> > > But there is no ordering requirement, so the __sock_cmsg_send
> > > call
> > > can
> > > come before the setsockopt call. It would be odd, but the API
> > > allows
> > > it.
> > > > >=20
> > > > > For the missing getsockopt, there was even a patch earlier
> > > > > this
> > > > > year
> > > > > by J=C3=B6rn-Thorben Hinz [1], but I failed to realize that we
> > > > > need
> > > > > patch
> > > > > 1/2 from his series regardless of patch 2/2.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
> > > > >=20
> > > > > [1]
> > > > > https://lore.kernel.org/lkml/20230703175048.151683-2-jthinz@mailb=
ox.tu-berlin.de/
> > > >=20
> > >=20
> > >=20
> >=20
>=20
>=20


