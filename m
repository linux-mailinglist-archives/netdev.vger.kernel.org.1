Return-Path: <netdev+bounces-87242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0F8A2413
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652FA1C211F5
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B32125BA;
	Fri, 12 Apr 2024 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr041rAp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930611190
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890761; cv=none; b=HzdTQV1qgLj3zR5+AhcvexYCrzfdBvkWx/LAfXJjsGA1tYaEQo1lgKtzjOd53Qvb25OXOKZpff+t7pY/DTn81EQl2WkPdmFEitKz15yBbyNDQjCN1JjL1eAAqatN3nT1ZCJqhK8VsaSIEMrbi629LQFrWKIp4thMST0oN/EBSzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890761; c=relaxed/simple;
	bh=0OiNthvOqI3q1luMR4Kn9bIvuwEF/mmPewFS9Q1Q6gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwkNGXKfhqeyGCqNfrO1RdeDn2UnuR3l6ddPfCRbSFUctdsmrPCwCEoZ5wghYJA2KPt2/YsVolcirnZAwHRAIme+0EONdqf9auFCC9jDbXaFvMSJRsJ9aAZXfptUkBw90f5XCL3nV9UtbpHDLuufJc+t/MrGul5VvvUeeel6/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr041rAp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712890757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aeAtr6lrakcb+TVIONgchAq7Riw6FwaXuUW4DirDuM=;
	b=Lr041rAphUrLCXqMPy1c+EMNSsfd/bmn0XOkkGCmqwmaU0D7XZ4dVfFGnBPxckVmEwT5fS
	6EOAEXHwstXmXsviIWH1BEx8kzIuqe7/Mg2KDMfXovGi6fx6Puop6916Ex2+eqOrlH4OLU
	GD4P+73FwMorQsYPzrzhBwNiDGwi/kA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-e4x6NVu5MhmjDndS7IrUJA-1; Thu, 11 Apr 2024 22:59:14 -0400
X-MC-Unique: e4x6NVu5MhmjDndS7IrUJA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a2c3543b85so448117a91.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 19:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712890753; x=1713495553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aeAtr6lrakcb+TVIONgchAq7Riw6FwaXuUW4DirDuM=;
        b=pcLrXBKAEmfWVMFgyYKz2XGAgj5p/9LEMhc32pa5RXZVUQ5gV8SMl24tJGNlJsmKFw
         6PO4fatXavIu+DVk1ZX41JcC6vjtsvQ7pZBd0QR6oFrJ+ZklSa6Hyp4pvonKVJyNen8b
         SghKYon7Eqh3mHlFCaTicrQ69d4xK6A30eswS7nmp4IPnHLcqmuezABayH4IlGlsJw0q
         zeYjd1NBGrAsdbat+tkYeogkexAxgdWqx9x0qVNp/o1YqiV1h4CQ3OoeFx9xCjvR+INS
         tCYOeAMgOUZMlhtouBJF8ptQ0VWRTeGT6L6g9VsbRXUtYWWWX6H+qjkFsnOlki0LsbcJ
         ddDw==
X-Forwarded-Encrypted: i=1; AJvYcCUPkRLarRrpjbehCwGuatIFoMWWty9GEfOGcCVLPUbZrTlIk66TZqxqqPgCBmsWKNIoGgOCfa00BsngfIoHCigey/Uy8vvj
X-Gm-Message-State: AOJu0YyQz15eEtaxkNunBMhpZ22epxO3G+S52/QpKu0xXDCJ/oSGAZaa
	sEVN5qm2nmYQSvmKt6NhAwePcGh2/pXKTNh4s0LZFUkqrRyjFeZZixsrbwrg9ajGktBFRZNzgPn
	rAjWrO1Eq3Pi5ZfwApoMIvKfffj1sMya+JzEypIcaj/+kIIvds04dvxMEq/fKCn/up79mtBt4fo
	ab+ktWCBiMy46ZBQ+2WZl4JUkUE09K
X-Received: by 2002:a17:90b:38c3:b0:2a2:830a:89a4 with SMTP id nn3-20020a17090b38c300b002a2830a89a4mr1152791pjb.41.1712890752902;
        Thu, 11 Apr 2024 19:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWSGum/v38/3wpVT6rb+8rdB0XrYg70dmN0a6JiH9h1CQVGNDVVRhXMB6SHmv9iC+0Fc2zO+/xRCOtIuzCTzM=
X-Received: by 2002:a17:90b:38c3:b0:2a2:830a:89a4 with SMTP id
 nn3-20020a17090b38c300b002a2830a89a4mr1152778pjb.41.1712890752451; Thu, 11
 Apr 2024 19:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406185029.93335-1-yuri.benditovich@daynix.com>
 <CACGkMEvKwh6GdkPzVyUDxODyCJQwHKFNJnOwCCRXurjUR=6aFQ@mail.gmail.com>
 <CAOEp5OdvTAzi830Kp1JiUbdDiq77oN3-5tD-hZXAaai4EUDTcQ@mail.gmail.com>
 <CACGkMEtKnu4MmPvdrxktygFB8B5Abn7rTkNcmU-cO-3MRkZgNg@mail.gmail.com>
 <CAOEp5OdhBJabrTTAZLxTgBvkJkQ3wKDGG-CYrimXd1dY9qqdkA@mail.gmail.com>
 <CACGkMEuEsCuRKUiAoUmb1LBL9pygGwEhXaivyx3m_sp9KqU27A@mail.gmail.com>
 <CAOEp5OeRvZny1fJY=T=Gc82Spux=fEeHsdfNVMje6Fr-dPXXVA@mail.gmail.com>
 <CACGkMEtSFEOKhhewvv6_pyw0RHvs0QqfAjrpjmfPxVK8RGm3JA@mail.gmail.com>
 <CAOEp5OepdfMhuh5rcKhadb4FBaxe4uEsxb_KFvEFW3q6Rj1MDA@mail.gmail.com>
 <CACGkMEsmZAQhN-c+PR270vx2MFWjT8mZKe9KDL0xO5tiCPpqfQ@mail.gmail.com> <CAOEp5Odj=_8Tj2CFNirdNEkA_yx-_8MJJKtpiX_dcQrtn6P76Q@mail.gmail.com>
In-Reply-To: <CAOEp5Odj=_8Tj2CFNirdNEkA_yx-_8MJJKtpiX_dcQrtn6P76Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 10:59:00 +0800
Message-ID: <CACGkMEt=qPdOiK+7o69cwNhBukHZBteaykMqbiFwHg+r8+q1bg@mail.gmail.com>
Subject: Re: [PATCH net] net: change maximum number of UDP segments to 128
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, yan@daynix.com, 
	andrew@daynix.com, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:39=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Thu, Apr 11, 2024 at 8:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Apr 11, 2024 at 1:32=E2=80=AFPM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 7:04=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Apr 10, 2024 at 4:28=E2=80=AFPM Yuri Benditovich
> > > > <yuri.benditovich@daynix.com> wrote:
> > > > >
> > > > > On Wed, Apr 10, 2024 at 9:07=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Tue, Apr 9, 2024 at 1:48=E2=80=AFPM Yuri Benditovich
> > > > > > <yuri.benditovich@daynix.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On Tue, Apr 9, 2024 at 6:53=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >>
> > > > > > >> On Mon, Apr 8, 2024 at 3:24=E2=80=AFPM Yuri Benditovich
> > > > > > >> <yuri.benditovich@daynix.com> wrote:
> > > > > > >> >
> > > > > > >> > On Mon, Apr 8, 2024 at 9:27=E2=80=AFAM Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > >> > >
> > > > > > >> > > On Sun, Apr 7, 2024 at 2:50=E2=80=AFAM Yuri Benditovich
> > > > > > >> > > <yuri.benditovich@daynix.com> wrote:
> > > > > > >> > > >
> > > > > > >> > > > Fixes: fc8b2a619469378 ("net: more strict VIRTIO_NET_H=
DR_GSO_UDP_L4 validation")
> > > > > > >> > > >
> > > > > > >> > > > The mentioned above commit adds check of potential num=
ber
> > > > > > >> > > > of UDP segments vs UDP_MAX_SEGMENTS in linux/virtio_ne=
t.h.
> > > > > > >> > > > After this change certification test of USO guest-to-g=
uest
> > > > > > >> > > > transmit on Windows driver for virtio-net device fails=
,
> > > > > > >> > > > for example with packet size of ~64K and mss of 536 by=
tes.
> > > > > > >> > > > In general the USO should not be more restrictive than=
 TSO.
> > > > > > >> > > > Indeed, in case of unreasonably small mss a lot of seg=
ments
> > > > > > >> > > > can cause queue overflow and packet loss on the destin=
ation.
> > > > > > >> > > > Limit of 128 segments is good for any practical purpos=
e,
> > > > > > >> > > > with minimal meaningful mss of 536 the maximal UDP pac=
ket will
> > > > > > >> > > > be divided to ~120 segments.
> > > > > > >> > >
> > > > > > >> > > Assuming different OS guests could run on top of KVM. I =
wonder if a
> > > > > > >> > > better fix is to relax the following check:
> > > > > > >> > >
> > > > > > >> > > =3D>                      if (skb->len - p_off > gso_siz=
e * UDP_MAX_SEGMENTS)
> > > > > > >> > >                                 return -EINVAL;
> > > > > > >> > There are also checks vs UDP_MAX_SEGMENTS in udp.c (in ipv=
4 and ipv6),
> > > > > > >> > they do not prevent guest-to-guest from passing but cause =
packet dropping in
> > > > > > >> > other cases..
> > > > > > >> > >
> > > > > > >> > > Changing UDP_MAX_SEGMENTS may have side effects. For exa=
mple, a new
> > > > > > >> > > Linux guest run on top of a old Linux and other.
> > > > > > >> > IMO, in the worst case _in specific setups_ the communicat=
ion will behave like
> > > > > > >> > it does now in all the setups.
> > > > > > >>
> > > > > > >> I meant if the guest limit is 128 but host limit is 64.
> > > > > > >
> > > > > > >
> > > > > > > If the guest limit is (128 or 64) and host limit is 64:
> > > > > > > If we send a UDP packet  with USO (length 64K, mss 600) - it =
is dropped.
> > > > > > > setsockopt does not limit us to use <=3D64 packets, neither i=
n windows nor in Linux,
> > > > > >
> > > > > > Just to make sure we are on the same page:
> > > > > >
> > > > > > Before fc8b2a619469378,
> > > > > >
> > > > > > 1) Windows guest works on Linux Host since we don't check again=
st
> > > > > > UDP_MAX_SEGMENTS on the host
> > > > >
> > > > >
> > > > > Windows guest-to-guest works since there  is no check for
> > > > > UDP_MAX_SEGMENTS in virtio_net.h
> > > > > Windows guest to Linux host suffers with size=3D64K mss=3D536 (as=
 an example)
> > > > >
> > > > > > 2) Linux guest works on Linux Host, since it will always send p=
acket
> > > > > > with less than UDP_MAX_SEGMENTS
> > > > >
> > > > >
> > > > > Not exactly.
> > > > > If you use "selftest" (udpgso*) _as is_, it will work as it has
> > > > > _internal_ define of 64 and never tries to do more than that.
> > > > > But (sorry for repeating that) there is no setsockopt() limitatio=
n and
> > > > > you're free to modify the test code
> > > > > to use more segments (as an example) and this will not work.
> > > >
> > > > I meant this part in udp_send_skb()
> > > >
> > > > =3D>              if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) =
{
> > > >                         kfree_skb(skb);
> > > >                         return -EINVAL;
> > > >                 }
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > This is the behaviour that we need to stick to, otherwise we br=
eak the
> > > > > > guests as you've noticed.
> > > > >
> > > > > We can stick to the behavior I've described above if we change on=
ly define
> > > > > UDP_MAX_SEGMENTS 64->128 in udp.h but leave untouched
> > > > > UDP_MAX_SEGMENTS=3D64 in udpgso (test code)
> > > > > (IMO does not make too much sense but possible)
> > > > >
> > > > > Actually, all this discussion happens because the initial code of=
 USO
> > > > > in the kernel was delivered with define of 64 without any special
> > > > > reason, just because this looked enough then.
> > > >
> > > > Right, but it's too late to "fix", the only thing we can do now is =
to
> > > > make sure to not break the application that worked in the past.
> > > >
> > > > >
> > > > > >
> > > > > > If we fix it by increasing the UDP_MAX_SEGMENTS, it fixes for 1=
) but
> > > > > > not necessarily for 2). If we don't check against UDP_MAX_SEGME=
NTS, it
> > > > > > works for 2) as well.
> > > > >
> > > >
> > > > So what I want to say is that having a check for UDP_MAX_SEGMENTS
> > > > seems to be problematic. And increasing it to 128 complicates the
> > > > problem furtherly.
> > > >
> > > > > There are following cases:
> > > > > - guest-to-guest (win-to-win, lin-to-lin,win-to-lin, lin-to-win)
> > > >
> > > > If we don't have the check for UDP_MAX_SEGMENTS, everything should =
be fine.
> > > >
> > > > If the sender can produces 128 and 64 is checked in the middle of t=
he
> > > > datapath in either tun or virtio-net, the packet will be dropped.
> > > >
> > > > > -guest-to-host (guest=3Dlin, guest=3Dwin)
> > > >
> > > > Same as above.
> > > >
> > > > > -host-to-host
> > > >
> > > > I don't see any issue in this part.
> > >
> > > The issue is that host-to-host UDP packets with more than 64 segments
> > > are dropped due to check vs  UDP_MAX_SEGMENTS is udp.c (v4 and v6)
> >
> > Yes, but if they fail since the introduction of UDP gso if I was not wr=
ong.
>
> In order to prevent failure we can limit the test to work with 64 segment=
s
> and it will be happy. Nothing will be broken.

I'm kind of lost here, if you still limit it to 64, why do you want to
increase the kernel to 128?

>
> >
> > >
> > >
> > > >
> > > > > -host-to-guest (guest=3Dlin, guest=3Dwin)
> > > >
> > > > Same as guest-to-guest.
> > > >
> > > > >
> > > > > Resulting table of results is much more complicated than you desc=
ribed.
> > > > > We can't use the udpgso code as the only indicator of go/nogo.
> > > >
> > > > We should not break userspace. If there's a setup that udpgso can w=
ork
> > > > in the past but not after a patch is applied, we should avoid such
> > > > cases.
> > > >
> > > > That's why I think avoiding checking UDP_MAX_SEGMENTS and doing oth=
er
> > > > hardening might be better (for example as Eric suggested).
> > >
> > > I've checked all this thread and I did not find any Eric's suggestion=
 regarding
> > > other hardening. Which suggestion have you mentioned?
> >
> > Quoted from Eric email (btw, for some reason the discussion is not
> > reached to the list, adding list here)
> >
> > """
> >
> > > Assuming different OS guests could run on top of KVM. I wonder if a
> > > better fix is to relax the following check:
> > >
> > > =3D>                      if (skb->len - p_off > gso_size * UDP_MAX_S=
EGMENTS)
> > >                                 return -EINVAL;
> > >
> > > Changing UDP_MAX_SEGMENTS may have side effects. For example, a new
> > > Linux guest run on top of a old Linux and other.
> >
> > Typical qdisc packet limit is 1000.
> >
> > I think a limit prevents abuses, like gso_size =3D=3D 1, and skb->len =
=3D 65000
>
> I understand. This was your suggestion to remove the check here.
> Then with > 64 segments:
> - windows guest-to-guest will work
> - host to windows guest will not work
> - linux guest to windows guest will not work
> - other pairs - I do not know yet

Why can this break? Did any guest produce packets with either gso_size
=3D 1 or skb->len >=3D 65000?

>
> This is what you prefer??

Thanks

>
>
> >
> > """
> >
> > The actual value needs more thought, for example 65K may block the
> > implementation of jumbogram in the future.
> >
> > Thanks
> >
> > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > >>
> > > > > > >>
> > > > > > >> > Note that this limit (UDP_MAX_SEGMENTS) is set
> > > > > > >> > in internal kernel define, it is not based on any RFC, not=
 visible via
> > > > > > >> > ethtool etc.
> > > > > > >>
> > > > > > >> In the future, it needs to be advertised to the guest via vi=
rtio spec.
> > > > > > >> Otherwise it might have compatibility issues.
> > > > > > >
> > > > > > >
> > > > > > > The spec targets 2 areas - hardware solutions and software so=
lutions.
> > > > > > > For hardware solutions everything is clear - there are no dec=
lared limits and if the hardware will limit the number of segments to anyth=
ing - it is a bug.
> > > > > > > So the advertising makes sense only for hypervisors and for e=
xample, qemu will need to obtain this magic number from the kernel.
> > > > > >
> > > > > > Right.
> > > > > >
> > > > > > > If/when we'll start adding this to the spec we'll face a reas=
onable question - why do we need to add something that is not mentioned in =
any RFC, why not add such a thing for TCP also?
> > > > > >
> > > > > > So the kernel has gso_max_segs for netdevice. We probably need =
it for
> > > > > > virtio-net as well, and it might be useful for jumbograms as we=
ll.
> > > > > >
> > > > > virtio-net is "limited" by common "#define GSO_MAX_SEGS        65=
535u"
> > > >
> > > > This works since the host will do software segmentation as a fallba=
ck
> > > > which will be very slow.
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Next, let's say we advertise this number over virtio capabili=
ties - does this solve something?
> > > > > >
> > > > > > For example, doing software segmentation by kernel?
> > > > > >
> > > > > > > The driver can't communicate this capability up. The setsocko=
pt will not limit this parameter.
> > > > > > >
> > > > > > >>
> > > > > > >> For example, migrate from 64 to 128.
> > > > > > >>
> > > > > > > Yes, but the migration from higher kernel to lower one looks =
like an immortal problem.
> > > > > >
> > > > > > This is not rare. For example, the patch for 128 is applied on =
the
> > > > > > source but not destination.
> > > > >
> > > > > I agree that such migration can happen and _theoretically_ may ca=
use
> > > > > some misunderstanding
> > > > > I'm almost sure that practically this can't cause any.misundersta=
nding
> > > > > and we can discuss this specific problem in depth.
> > > > > (I just need some time for some tests)
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > >>
> > > > > > >> > The same on Windows - the adapter does not have such a cap=
ability as maximal
> > > > > > >> > number of UDP segments, so the upper layers are unaware of=
 any limitation.
> > > > > > >>
> > > > > > >> Right, that might be problematic.
> > > > > > >>
> > > > > > >> The checking of UDP_MAX_SEGMENTS implies an agreement of gue=
st and
> > > > > > >> host.  But such implications are not true  .
> > > > > > >>
> > > > > > >> Thanks
> > > > > > >>
> > > > > > >>
> > > > > > >>
> > > > > > >> > >
> > > > > > >> > > Thanks
> > > > > > >> > >
> > > > > > >> > > >
> > > > > > >> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@dayn=
ix.com>
> > > > > > >> > > > ---
> > > > > > >> > > >  include/linux/udp.h                  | 2 +-
> > > > > > >> > > >  tools/testing/selftests/net/udpgso.c | 2 +-
> > > > > > >> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > >> > > >
> > > > > > >> > > > diff --git a/include/linux/udp.h b/include/linux/udp.h
> > > > > > >> > > > index 3748e82b627b..7e75ccdf25fe 100644
> > > > > > >> > > > --- a/include/linux/udp.h
> > > > > > >> > > > +++ b/include/linux/udp.h
> > > > > > >> > > > @@ -108,7 +108,7 @@ struct udp_sock {
> > > > > > >> > > >  #define udp_assign_bit(nr, sk, val)            \
> > > > > > >> > > >         assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_fl=
ags, val)
> > > > > > >> > > >
> > > > > > >> > > > -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> > > > > > >> > > > +#define UDP_MAX_SEGMENTS       (1 << 7UL)
> > > > > > >> > > >
> > > > > > >> > > >  #define udp_sk(ptr) container_of_const(ptr, struct ud=
p_sock, inet.sk)
> > > > > > >> > > >
> > > > > > >> > > > diff --git a/tools/testing/selftests/net/udpgso.c b/to=
ols/testing/selftests/net/udpgso.c
> > > > > > >> > > > index 1d975bf52af3..85b3baa3f7f3 100644
> > > > > > >> > > > --- a/tools/testing/selftests/net/udpgso.c
> > > > > > >> > > > +++ b/tools/testing/selftests/net/udpgso.c
> > > > > > >> > > > @@ -34,7 +34,7 @@
> > > > > > >> > > >  #endif
> > > > > > >> > > >
> > > > > > >> > > >  #ifndef UDP_MAX_SEGMENTS
> > > > > > >> > > > -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> > > > > > >> > > > +#define UDP_MAX_SEGMENTS       (1 << 7UL)
> > > > > > >> > > >  #endif
> > > > > > >> > > >
> > > > > > >> > > >  #define CONST_MTU_TEST 1500
> > > > > > >> > > > --
> > > > > > >> > > > 2.34.3
> > > > > > >> > > >
> > > > > > >> > >
> > > > > > >> >
> > > > > > >>
> > > > > >
> > > > >
> > > >
> > >
> >
>


