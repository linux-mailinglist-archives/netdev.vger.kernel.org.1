Return-Path: <netdev+bounces-159392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69149A15665
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061333AA5FA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C17D1A7AD0;
	Fri, 17 Jan 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Q6VF7zu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B691A4F09
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137904; cv=none; b=Q6ZDcnaLpbuKx8IOhf0MtpQNIgE1dnIfV+Cdu8EXoa8fNrcb+mvVBizfMH28b0sePMjUSKmbgp9tyXvFk/St5qyqW84ueHVpNr+pAuam4cM4G65NaKa+Y2MZdmukltzUSF6ZFQb/HtI/as0VJLd3mL8fLnvdZ1vOKBaCz8VgyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137904; c=relaxed/simple;
	bh=3EDTiQEHH+pAtdnIAHrthYzsduNKAMVtd+SetVi+ETs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX5Zkk+MPT7eY/XdI0527IsDst0tOrWS2EMKrrN31A8FUBTpDwncTiT050QMqaNlLUhfPYXr0+C5RnN4f8Ncm0GiUoUvWkwEsDJBjs4UZHrVKPbQYP5b2JcsoNTFH3bkz1Iw8KVaNctVvcx5iVWf8CWkVyREcHt0skAdYF+ja+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Q6VF7zu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso3624714a12.2
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737137901; x=1737742701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKthkcmWeTC5PhDRa4KSK5u1RCQ2wpFA8/+wzpkqtgI=;
        b=3Q6VF7zuZjs3+Xn3shQQZNaKBR33TcAg1E8DWevWIoo4GDGbxaGnsBWG7kFt7+kfIa
         Fg8vwLled7tNcWTdvbQ609R2xcsSnBcLInv+BDmlyeN3YcihxSXlFnMO7EW3RAIkQ/bx
         d38o/fPJI/1ogKYaK2B5uIQ2u0cYGANBTal5DwkJoRqdI+61r8vvJSEoA4fRprMpwqNo
         GbrR7IGicarY0ZJU6jG7J596Nt+s+cVIAu9Ik3NUpEdwJ2/EpD6pRmPt5fbd87EXCJEj
         ZyKB4fPNx67HAB52CkB5aBoeKv1CdYufN1c1cnFkiq2+FK5UOocybso/ucz6HPCXcq9+
         4oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737137901; x=1737742701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKthkcmWeTC5PhDRa4KSK5u1RCQ2wpFA8/+wzpkqtgI=;
        b=rYi9jkiFWYI/lJa87inp+DMJuQmVafuK7OOPE9tV6k6QgbJctnUWyxBDB+Xm1nMDKO
         FMD3MC4RGL1JkdomsS6O9W0TDEZPj+qamU8+aLvIqMr4FBdh4Yas2d+Hk199ISQHwofE
         7hx29vHgg1Iw2M/QqkbmjhQvYf71L1bTCZLeyBBxa/O1UbTJLLMtCSTpkYttkqCGbIDz
         xcLap+Sxs5nDpRFmSCMgdFUBsvFACqtE22enWG5nQwvbktmsVQTkFUuc3xfwDkVsFKJB
         9xBLEoEtJGNRtUdM+6U6/3BQ1bXHby1BGCu6L1V/HTOGhDg93EZp/6RqjReiA8iEEM9t
         RGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcImNSL+IMAeYbPOGHXpRE+TYMbxEiRoHB6lQgU6Kys/0O2eQFNKza1IitTPBAjVuWSncwEr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LHB53b4BAINgQW/R9QUj+XQy5vRlrBKoLLBQKqxyUPihfeCW
	y8m0Zpys3y06B15stK0oCQ5yp4AyD2MwIIbvmfTYllt/wcKfQJKvmWvfkQd6fBBfIxu7yZQHUL1
	8RthFrIKpoUE5XA7WKkr4yqrnvwht5bpKI34u
X-Gm-Gg: ASbGncsLBIGqwuiTSFRiIOOUqJBDBAN39kw2BDgxj8P6PqeQAgEnPmfgPG7V++MwLnk
	wDrICMyTH47qbBkqpqMyeyXVr75ME9k5MbgXEDQ==
X-Google-Smtp-Source: AGHT+IGl8C+iZO/UvcDQv2VKcajPxc7SEMu4YPuPA+YDZiPA7loyr8rwyb2octIpvWh4jLrfm7V+U60Creth/ODgwJs=
X-Received: by 2002:a05:6402:278f:b0:5d2:7346:3ecb with SMTP id
 4fb4d7f45d1cf-5db7d2f8066mr3436666a12.12.1737137900578; Fri, 17 Jan 2025
 10:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126144344.4177332-1-edumazet@google.com> <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
 <Z4pmD3l0XUApJhtD@PC-LX-SteWu> <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
In-Reply-To: <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 19:18:09 +0100
X-Gm-Features: AbW1kvY8DcndeYC4SDZHIeZH1mXXDjXECF9fyuVRHlF_SiPj7Yut9JzPDk6cdaQ
Message-ID: <CANn89iJghv1JSwO7AVh97mU1Laj11SooiioZOHJ+UbUVeAcKUQ@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in fill_frame_info()
To: Stephan Wurm <stephan.wurm@a-eberle.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com, 
	WingMan Kwok <w-kwok2@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>, 
	George McCollister <george.mccollister@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 7:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jan 17, 2025 at 3:16=E2=80=AFPM Stephan Wurm <stephan.wurm@a-eber=
le.de> wrote:
> >
> > Am 17. Jan 14:22 hat Eric Dumazet geschrieben:
> > >
> > > Thanks for the report !
> > >
> > > You could add instrumentation there so that we see packet content.
> > >
> > > I suspect mac_len was not properly set somewhere.
> > >
> > > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > > index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..b0068e23083416ba13794=
e3b152517afbe5125b7
> > > 100644
> > > --- a/net/hsr/hsr_forward.c
> > > +++ b/net/hsr/hsr_forward.c
> > > @@ -700,8 +700,10 @@ static int fill_frame_info(struct hsr_frame_info=
 *frame,
> > >                 frame->is_vlan =3D true;
> > >
> > >         if (frame->is_vlan) {
> > > -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr=
, vlanhdr))
> > > +               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr=
,
> > > vlanhdr)) {
> > > +                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
> > >                         return -EINVAL;
> > > +               }
> > >                 vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
> > >                 proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto=
;
> > >         }
> >
> > Thanks for your instrumentation patch.
> >
> > I got the following output in kernel log when sending an icmp echo with
> > VLAN header:
> >
> > kernel: prp0: entered promiscuous mode
> > kernel: skb len=3D46 headroom=3D2 headlen=3D46 tailroom=3D144
> >         mac=3D(2,14) net=3D(16,-1) trans=3D-1
> >         shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0)=
)
> >         csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
> >         hash(0x0 sw=3D0 l4=3D0) proto=3D0x0000 pkttype=3D0 iif=3D0
> > kernel: dev name=3Dprp0 feat=3D0x0000000000007000
> > kernel: sk family=3D17 type=3D3 proto=3D0
> > kernel: skb headroom: 00000000: 0d 12
> > kernel: skb linear:   00000000: 00 d0 93 4a 2d 91 00 d0 93 53 9c cb 81 =
00 00 00
> > kernel: skb linear:   00000010: 08 00 45 00 00 1c 00 01 00 00 40 01 d4 =
a1 ac 10
> > kernel: skb linear:   00000020: 27 14 ac 10 27 0a 08 00 f7 ff 00 00 00 =
00
> > kernel: skb tailroom: 00000000: 00 01 00 06 20 03 00 25 3c 20 00 00 00 =
00 00 00
> > kernel: skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 =
01 00 3d
> > kernel: skb tailroom: 00000020: 00 00 00 00 67 8a 61 45 15 63 56 39 00 =
25 00 7f
> > kernel: skb tailroom: 00000030: f8 fe ff ff 7f 00 d0 93 ff fe 64 e8 8e =
00 53 00
> > kernel: skb tailroom: 00000040: 14 0e 14 31 00 00 53 00 14 0e 14 29 00 =
00 00 00
> > kernel: skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 08 00 45 =
00 00 34
> > kernel: skb tailroom: 00000060: 24 fa 40 00 40 06 17 c8 7f 00 00 01 7f =
00 00 01
> > kernel: skb tailroom: 00000070: aa 04 13 8c 94 1d a0 b2 77 d6 5f 8a 80 =
10 02 00
> > kernel: skb tailroom: 00000080: fe 28 00 00 01 01 08 0a 89 e9 8a f7 89 =
e9 8a f7
> > kernel: prp0: left promiscuous mode
> >
>
> Yup, mac_len is incorrect, and the network header is also wrong.
>
> Please give us a stack trace, because at least one caller of
> hsr_forward() needs to be VLAN ready.
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..6f65a535c7fcd740cef81e718=
323e86fd1eef832
> 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -700,8 +700,11 @@ static int fill_frame_info(struct hsr_frame_info *fr=
ame,
>                 frame->is_vlan =3D true;
>
>         if (frame->is_vlan) {
> -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vl=
anhdr))
> +               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr,
> vlanhdr)) {
> +                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
> +                       WARN_ON_ONCE(1);
>                         return -EINVAL;
> +               }
>                 vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
>                 proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
>         }

BTW, also please cherry-pick this commit from linux-6.10

commit 4308811ba90118ae1b71a95fee79ab7dada6400c
Author: Eric Dumazet <edumazet@google.com>
Date:   Sun Apr 7 08:06:06 2024 +0000

    net: display more skb fields in skb_dump()

