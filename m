Return-Path: <netdev+bounces-86921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0DB8A0C9E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075E51C20E24
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8A145324;
	Thu, 11 Apr 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="E303wuL5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C914601D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828391; cv=none; b=b/Mxpq95FQ5I+FuQy8+wckAoo+hPMTjVkSn/cO8EzFcN7N1ofqRONNTMbWC+WFFoOxuvYvHIFSyUd3y79gPrRnmTfOUszy+sBB5MNJ1YJeuw5awus2H3eSVYdIeaKQpVSNDCS4nQAwOfEFJa4OKbTPbUJfrMpwcnGq0Jhw20UHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828391; c=relaxed/simple;
	bh=FS1DhTieh97fWr4nARlO/WGzpgfID7wE6oOJJ2Q/qyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwHvegnDEiuRATmAOKfJbW7/zpFr0KNgP8PJQTtElON2FW2q5tQO3sfktfScFFPOaqldfFZsuXyHBJE8FlA/jOU5SDU5Rfnctsnz1bU6yxZiSBqhhi9Gam1+Mxa8jKutDd3oBhcxPtgR7ZjhyqzYLWs2ZuHeO9jbzIu3oiBucxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=E303wuL5; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea29cf24c6so1402861a34.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712828388; x=1713433188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA0Sne3UlFQAadu9hJ3OeYl6DtBRbckx4vR8/s8a6IM=;
        b=E303wuL51x79Pn3ZqMCRcFDeVTEE2ykD5XNkyJlFWLFk4t6HqPElPdq4L2RWhRXLgh
         1WTQCTtHbIZFcQ7Fm9QX57mnfspefHCmxVIoPreiY78GnPkVRH2jnW6jEC1C2uB9P/0f
         /wI0eIKcrOhnbVcF7YokfdToTbNQsAFX1qyPFP2A/DtQrndoI84ur2O6A9O2BbUAv7R6
         cG9E3yy6Bhpzj5a3NrXqczaNYhk+jugGcfElZI/eJthne14+P3VdYnrT+1VoG3gxEDsb
         zAaSSMFwtIrCqKDQLT/D4s143nFSXk8bjj1ge0P/7MBtpBSkalKvpTGAiF6khqXu59YW
         IYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712828388; x=1713433188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA0Sne3UlFQAadu9hJ3OeYl6DtBRbckx4vR8/s8a6IM=;
        b=Yz1bE4nC7VJuQDIJ89IJbi5pXLI5H3OVJVLYQLZznLy1t8O7YX7yfQkms8IhHRdwmM
         4MRjAcp+MX7j/sjrHxXDiHX0vV3z+fPwF1Fkx0dyrU7XGcssNTYt/pyh2sH0MxE8+wn7
         OAhFKkG1kAT3Ub3I1KOiI9Ffn1ELS9fxeidAJJlLGrHjkXP5Dijstr26GCN6k1irPmKq
         yssP3Pe/jThzO0Pxqo1rV9xv2yq39TrFpACR8JKhS4AAa1tX0qjS6yC6gs5sgyA8xWX7
         KJ+iH7eAWvlrF7w1e//T0zux8q70OBLuT8xlubLhp02ZllF/0ZKWIwY9uhKS6DWNZFZg
         NIJA==
X-Forwarded-Encrypted: i=1; AJvYcCWDh/kE0V6q6IddPiZoUlNwQmfRj8Q3x1HJYBjFMOkyBYFY4xYq4vBT0hyqTfp+3IoxkZDD7AnhVV8+uD+qLkxVkwD9p4ir
X-Gm-Message-State: AOJu0YyockJ+UmLU9GY4pHIC41qnifiievMrT7skLzLyyK8EkQvwF499
	pROIgZWhLRQVZJkKIf+rfwa4Gk+lkvSEqB9H3ZE+B0y4etFqR2nHPjuU+s1VvrcDXPsC8jwax1K
	1qFKarupU46Tvdl396PRNOx/W9Mg5wKYPM1dVsg==
X-Google-Smtp-Source: AGHT+IG83pjLJ8QDTjDZEh+mIg/T8nKoCFXUtpkxWrXn2fbdz3IHixY/VihtHOxEM63LPICYxsXD/6nn2EK+3QOAIDk=
X-Received: by 2002:a05:6808:2a44:b0:3c5:fce8:26cb with SMTP id
 fa4-20020a0568082a4400b003c5fce826cbmr4672893oib.48.1712828388099; Thu, 11
 Apr 2024 02:39:48 -0700 (PDT)
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
 <CAOEp5OepdfMhuh5rcKhadb4FBaxe4uEsxb_KFvEFW3q6Rj1MDA@mail.gmail.com> <CACGkMEsmZAQhN-c+PR270vx2MFWjT8mZKe9KDL0xO5tiCPpqfQ@mail.gmail.com>
In-Reply-To: <CACGkMEsmZAQhN-c+PR270vx2MFWjT8mZKe9KDL0xO5tiCPpqfQ@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 11 Apr 2024 12:39:36 +0300
Message-ID: <CAOEp5Odj=_8Tj2CFNirdNEkA_yx-_8MJJKtpiX_dcQrtn6P76Q@mail.gmail.com>
Subject: Re: [PATCH net] net: change maximum number of UDP segments to 128
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, yan@daynix.com, 
	andrew@daynix.com, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Apr 11, 2024 at 1:32=E2=80=AFPM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > On Thu, Apr 11, 2024 at 7:04=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Apr 10, 2024 at 4:28=E2=80=AFPM Yuri Benditovich
> > > <yuri.benditovich@daynix.com> wrote:
> > > >
> > > > On Wed, Apr 10, 2024 at 9:07=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Tue, Apr 9, 2024 at 1:48=E2=80=AFPM Yuri Benditovich
> > > > > <yuri.benditovich@daynix.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On Tue, Apr 9, 2024 at 6:53=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >>
> > > > > >> On Mon, Apr 8, 2024 at 3:24=E2=80=AFPM Yuri Benditovich
> > > > > >> <yuri.benditovich@daynix.com> wrote:
> > > > > >> >
> > > > > >> > On Mon, Apr 8, 2024 at 9:27=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > >> > >
> > > > > >> > > On Sun, Apr 7, 2024 at 2:50=E2=80=AFAM Yuri Benditovich
> > > > > >> > > <yuri.benditovich@daynix.com> wrote:
> > > > > >> > > >
> > > > > >> > > > Fixes: fc8b2a619469378 ("net: more strict VIRTIO_NET_HDR=
_GSO_UDP_L4 validation")
> > > > > >> > > >
> > > > > >> > > > The mentioned above commit adds check of potential numbe=
r
> > > > > >> > > > of UDP segments vs UDP_MAX_SEGMENTS in linux/virtio_net.=
h.
> > > > > >> > > > After this change certification test of USO guest-to-gue=
st
> > > > > >> > > > transmit on Windows driver for virtio-net device fails,
> > > > > >> > > > for example with packet size of ~64K and mss of 536 byte=
s.
> > > > > >> > > > In general the USO should not be more restrictive than T=
SO.
> > > > > >> > > > Indeed, in case of unreasonably small mss a lot of segme=
nts
> > > > > >> > > > can cause queue overflow and packet loss on the destinat=
ion.
> > > > > >> > > > Limit of 128 segments is good for any practical purpose,
> > > > > >> > > > with minimal meaningful mss of 536 the maximal UDP packe=
t will
> > > > > >> > > > be divided to ~120 segments.
> > > > > >> > >
> > > > > >> > > Assuming different OS guests could run on top of KVM. I wo=
nder if a
> > > > > >> > > better fix is to relax the following check:
> > > > > >> > >
> > > > > >> > > =3D>                      if (skb->len - p_off > gso_size =
* UDP_MAX_SEGMENTS)
> > > > > >> > >                                 return -EINVAL;
> > > > > >> > There are also checks vs UDP_MAX_SEGMENTS in udp.c (in ipv4 =
and ipv6),
> > > > > >> > they do not prevent guest-to-guest from passing but cause pa=
cket dropping in
> > > > > >> > other cases..
> > > > > >> > >
> > > > > >> > > Changing UDP_MAX_SEGMENTS may have side effects. For examp=
le, a new
> > > > > >> > > Linux guest run on top of a old Linux and other.
> > > > > >> > IMO, in the worst case _in specific setups_ the communicatio=
n will behave like
> > > > > >> > it does now in all the setups.
> > > > > >>
> > > > > >> I meant if the guest limit is 128 but host limit is 64.
> > > > > >
> > > > > >
> > > > > > If the guest limit is (128 or 64) and host limit is 64:
> > > > > > If we send a UDP packet  with USO (length 64K, mss 600) - it is=
 dropped.
> > > > > > setsockopt does not limit us to use <=3D64 packets, neither in =
windows nor in Linux,
> > > > >
> > > > > Just to make sure we are on the same page:
> > > > >
> > > > > Before fc8b2a619469378,
> > > > >
> > > > > 1) Windows guest works on Linux Host since we don't check against
> > > > > UDP_MAX_SEGMENTS on the host
> > > >
> > > >
> > > > Windows guest-to-guest works since there  is no check for
> > > > UDP_MAX_SEGMENTS in virtio_net.h
> > > > Windows guest to Linux host suffers with size=3D64K mss=3D536 (as a=
n example)
> > > >
> > > > > 2) Linux guest works on Linux Host, since it will always send pac=
ket
> > > > > with less than UDP_MAX_SEGMENTS
> > > >
> > > >
> > > > Not exactly.
> > > > If you use "selftest" (udpgso*) _as is_, it will work as it has
> > > > _internal_ define of 64 and never tries to do more than that.
> > > > But (sorry for repeating that) there is no setsockopt() limitation =
and
> > > > you're free to modify the test code
> > > > to use more segments (as an example) and this will not work.
> > >
> > > I meant this part in udp_send_skb()
> > >
> > > =3D>              if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
> > >                         kfree_skb(skb);
> > >                         return -EINVAL;
> > >                 }
> > >
> > > >
> > > > >
> > > > >
> > > > > This is the behaviour that we need to stick to, otherwise we brea=
k the
> > > > > guests as you've noticed.
> > > >
> > > > We can stick to the behavior I've described above if we change only=
 define
> > > > UDP_MAX_SEGMENTS 64->128 in udp.h but leave untouched
> > > > UDP_MAX_SEGMENTS=3D64 in udpgso (test code)
> > > > (IMO does not make too much sense but possible)
> > > >
> > > > Actually, all this discussion happens because the initial code of U=
SO
> > > > in the kernel was delivered with define of 64 without any special
> > > > reason, just because this looked enough then.
> > >
> > > Right, but it's too late to "fix", the only thing we can do now is to
> > > make sure to not break the application that worked in the past.
> > >
> > > >
> > > > >
> > > > > If we fix it by increasing the UDP_MAX_SEGMENTS, it fixes for 1) =
but
> > > > > not necessarily for 2). If we don't check against UDP_MAX_SEGMENT=
S, it
> > > > > works for 2) as well.
> > > >
> > >
> > > So what I want to say is that having a check for UDP_MAX_SEGMENTS
> > > seems to be problematic. And increasing it to 128 complicates the
> > > problem furtherly.
> > >
> > > > There are following cases:
> > > > - guest-to-guest (win-to-win, lin-to-lin,win-to-lin, lin-to-win)
> > >
> > > If we don't have the check for UDP_MAX_SEGMENTS, everything should be=
 fine.
> > >
> > > If the sender can produces 128 and 64 is checked in the middle of the
> > > datapath in either tun or virtio-net, the packet will be dropped.
> > >
> > > > -guest-to-host (guest=3Dlin, guest=3Dwin)
> > >
> > > Same as above.
> > >
> > > > -host-to-host
> > >
> > > I don't see any issue in this part.
> >
> > The issue is that host-to-host UDP packets with more than 64 segments
> > are dropped due to check vs  UDP_MAX_SEGMENTS is udp.c (v4 and v6)
>
> Yes, but if they fail since the introduction of UDP gso if I was not wron=
g.

In order to prevent failure we can limit the test to work with 64 segments
and it will be happy. Nothing will be broken.

>
> >
> >
> > >
> > > > -host-to-guest (guest=3Dlin, guest=3Dwin)
> > >
> > > Same as guest-to-guest.
> > >
> > > >
> > > > Resulting table of results is much more complicated than you descri=
bed.
> > > > We can't use the udpgso code as the only indicator of go/nogo.
> > >
> > > We should not break userspace. If there's a setup that udpgso can wor=
k
> > > in the past but not after a patch is applied, we should avoid such
> > > cases.
> > >
> > > That's why I think avoiding checking UDP_MAX_SEGMENTS and doing other
> > > hardening might be better (for example as Eric suggested).
> >
> > I've checked all this thread and I did not find any Eric's suggestion r=
egarding
> > other hardening. Which suggestion have you mentioned?
>
> Quoted from Eric email (btw, for some reason the discussion is not
> reached to the list, adding list here)
>
> """
>
> > Assuming different OS guests could run on top of KVM. I wonder if a
> > better fix is to relax the following check:
> >
> > =3D>                      if (skb->len - p_off > gso_size * UDP_MAX_SEG=
MENTS)
> >                                 return -EINVAL;
> >
> > Changing UDP_MAX_SEGMENTS may have side effects. For example, a new
> > Linux guest run on top of a old Linux and other.
>
> Typical qdisc packet limit is 1000.
>
> I think a limit prevents abuses, like gso_size =3D=3D 1, and skb->len =3D=
 65000

I understand. This was your suggestion to remove the check here.
Then with > 64 segments:
- windows guest-to-guest will work
- host to windows guest will not work
- linux guest to windows guest will not work
- other pairs - I do not know yet

This is what you prefer??


>
> """
>
> The actual value needs more thought, for example 65K may block the
> implementation of jumbogram in the future.
>
> Thanks
>
> >
> > > >
> > > > >
> > > > > >
> > > > > >>
> > > > > >>
> > > > > >> > Note that this limit (UDP_MAX_SEGMENTS) is set
> > > > > >> > in internal kernel define, it is not based on any RFC, not v=
isible via
> > > > > >> > ethtool etc.
> > > > > >>
> > > > > >> In the future, it needs to be advertised to the guest via virt=
io spec.
> > > > > >> Otherwise it might have compatibility issues.
> > > > > >
> > > > > >
> > > > > > The spec targets 2 areas - hardware solutions and software solu=
tions.
> > > > > > For hardware solutions everything is clear - there are no decla=
red limits and if the hardware will limit the number of segments to anythin=
g - it is a bug.
> > > > > > So the advertising makes sense only for hypervisors and for exa=
mple, qemu will need to obtain this magic number from the kernel.
> > > > >
> > > > > Right.
> > > > >
> > > > > > If/when we'll start adding this to the spec we'll face a reason=
able question - why do we need to add something that is not mentioned in an=
y RFC, why not add such a thing for TCP also?
> > > > >
> > > > > So the kernel has gso_max_segs for netdevice. We probably need it=
 for
> > > > > virtio-net as well, and it might be useful for jumbograms as well=
.
> > > > >
> > > > virtio-net is "limited" by common "#define GSO_MAX_SEGS        6553=
5u"
> > >
> > > This works since the host will do software segmentation as a fallback
> > > which will be very slow.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Next, let's say we advertise this number over virtio capabiliti=
es - does this solve something?
> > > > >
> > > > > For example, doing software segmentation by kernel?
> > > > >
> > > > > > The driver can't communicate this capability up. The setsockopt=
 will not limit this parameter.
> > > > > >
> > > > > >>
> > > > > >> For example, migrate from 64 to 128.
> > > > > >>
> > > > > > Yes, but the migration from higher kernel to lower one looks li=
ke an immortal problem.
> > > > >
> > > > > This is not rare. For example, the patch for 128 is applied on th=
e
> > > > > source but not destination.
> > > >
> > > > I agree that such migration can happen and _theoretically_ may caus=
e
> > > > some misunderstanding
> > > > I'm almost sure that practically this can't cause any.misunderstand=
ing
> > > > and we can discuss this specific problem in depth.
> > > > (I just need some time for some tests)
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > >>
> > > > > >> > The same on Windows - the adapter does not have such a capab=
ility as maximal
> > > > > >> > number of UDP segments, so the upper layers are unaware of a=
ny limitation.
> > > > > >>
> > > > > >> Right, that might be problematic.
> > > > > >>
> > > > > >> The checking of UDP_MAX_SEGMENTS implies an agreement of guest=
 and
> > > > > >> host.  But such implications are not true  .
> > > > > >>
> > > > > >> Thanks
> > > > > >>
> > > > > >>
> > > > > >>
> > > > > >> > >
> > > > > >> > > Thanks
> > > > > >> > >
> > > > > >> > > >
> > > > > >> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix=
.com>
> > > > > >> > > > ---
> > > > > >> > > >  include/linux/udp.h                  | 2 +-
> > > > > >> > > >  tools/testing/selftests/net/udpgso.c | 2 +-
> > > > > >> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > >> > > >
> > > > > >> > > > diff --git a/include/linux/udp.h b/include/linux/udp.h
> > > > > >> > > > index 3748e82b627b..7e75ccdf25fe 100644
> > > > > >> > > > --- a/include/linux/udp.h
> > > > > >> > > > +++ b/include/linux/udp.h
> > > > > >> > > > @@ -108,7 +108,7 @@ struct udp_sock {
> > > > > >> > > >  #define udp_assign_bit(nr, sk, val)            \
> > > > > >> > > >         assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flag=
s, val)
> > > > > >> > > >
> > > > > >> > > > -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> > > > > >> > > > +#define UDP_MAX_SEGMENTS       (1 << 7UL)
> > > > > >> > > >
> > > > > >> > > >  #define udp_sk(ptr) container_of_const(ptr, struct udp_=
sock, inet.sk)
> > > > > >> > > >
> > > > > >> > > > diff --git a/tools/testing/selftests/net/udpgso.c b/tool=
s/testing/selftests/net/udpgso.c
> > > > > >> > > > index 1d975bf52af3..85b3baa3f7f3 100644
> > > > > >> > > > --- a/tools/testing/selftests/net/udpgso.c
> > > > > >> > > > +++ b/tools/testing/selftests/net/udpgso.c
> > > > > >> > > > @@ -34,7 +34,7 @@
> > > > > >> > > >  #endif
> > > > > >> > > >
> > > > > >> > > >  #ifndef UDP_MAX_SEGMENTS
> > > > > >> > > > -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> > > > > >> > > > +#define UDP_MAX_SEGMENTS       (1 << 7UL)
> > > > > >> > > >  #endif
> > > > > >> > > >
> > > > > >> > > >  #define CONST_MTU_TEST 1500
> > > > > >> > > > --
> > > > > >> > > > 2.34.3
> > > > > >> > > >
> > > > > >> > >
> > > > > >> >
> > > > > >>
> > > > >
> > > >
> > >
> >
>

