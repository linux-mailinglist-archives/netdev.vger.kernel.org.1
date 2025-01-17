Return-Path: <netdev+bounces-159391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC8CA1565B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1AD16949A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC3519D89D;
	Fri, 17 Jan 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Rf3j9YT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFB1A42A5
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137678; cv=none; b=ulABmrB7xFDNFJ8BI4GpqRz6EHdPWmShQYbCb5kFVmwGESd3+4P1Bl3CnHaQ2cqcBAO1qxoTFiZe1j/EqPVXkkb+cWYQj9uNXifm5Yxnl1fGOn0NUGXIK94Pqzz/yAtIYmDvhr+Wl4sVnI0cV/lyWJTUd2jWsXO4xCl1Da5HK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137678; c=relaxed/simple;
	bh=3P931gRFbo8B49WEYftAT8Dg4KVcXUdGMsHl15TMsw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3qDlUruLlZjFPNlkrqIuQGvhxnLR2TGknQxw8/KE+gHqQnCUNfC9G+NVAISLn3/Xd1e64M1Ty1RKunGWm4XuZcIEoG/YGTCHt1bz9vmGuOebGm57CiCcDM5SyCkCTvq8E/WQHUy1aegd9Q9quTRXqjLgDohVVCdrzWqTnSzd40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Rf3j9YT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso4345608a12.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737137675; x=1737742475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXW4W84VULbb7BXsn41c2QJo6cyj47o6wm8szlX6XJE=;
        b=4Rf3j9YTnWBqmm+uYq48EaKKfkvZ50tpkDwBKbaE9OhSuUaOWmylSjIx6DwwYJbxSd
         T1qzb5wW1CX/jVn+L5eVJTq7wNvE0nH+VL5UVv+oNJx0V3fQ7Hni+ypNA/Fyww3FkpDd
         wdUdliLuvzOQH8d4mAhQ8o0ho62JCwvZneQAyeMfh1qLHJQ8NnFBDE/P0MzFYxdeZ+R6
         DL7ZDwmBClnQCsEoiVkX82XKcsTPaT6X1NVdrHTd/XHr2apyAr5iUN7LLecR7rEOnv85
         RTRwj/S2HDa+DtCp8eLvS4Ebj6WpRpNyrwUCtS8cHiYp22fbq5kNicOWLp/74daEIHRW
         YfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737137675; x=1737742475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXW4W84VULbb7BXsn41c2QJo6cyj47o6wm8szlX6XJE=;
        b=mvWsP0/6RoeduGqJupvQO3L+bgAVaIPFFf7RIgb3Y9F970O+lU8/T+Mo4XGOy94amj
         Xv2UUXxdH958FMvxblrWml9NV+xwGS5J7/rZA4Ps3kbpEyJoy+WklYXM8ecwy6AT+XdU
         n+mKLdTJFf2cFBTY/eKuYx3YUoYvtKeppWw5RmMzoJVZHKYwwVjvPs2axNRBCQsdtBr4
         miwGbTkTLN/F4A/RFZ81LRZel05hzNgCmCPYbn0L0v2VIaah8/TFYPjlE531HyczsEXU
         mI7vsVnWjlt7tdlVHlCCjXJL5K90qBXf/+v5GxhB4hQwlJwsHWtdygdMC33DUABqlRTX
         ZCSg==
X-Forwarded-Encrypted: i=1; AJvYcCWS8yLNW04bLggxfoPIGDlXALaBDIhm1QlTgb8o1+q/rmmkD/6/pdBAhc+hqf3gqAQg4jWHFqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFseJDshPt3QNeZgC9Yg2c1WOVYqs44+lf99ftk0P8nYXIPhIX
	/68LT6dZj8c6ygs0ZkoJ2rKa4NKlDgBylq5SIijF08iTBNzXkyTjkyaLNEYJOw0Z1D9SoufzgAc
	cl879pmGWk0OJZJ/HGV8yjsqQbewhlvldjqxD
X-Gm-Gg: ASbGncvFqp51E0fNOqiPkyNWoLBeZiF0mjPWi8ETkh4J3mFSIRFIs1G6fHoy6Xyl9X5
	6XzKuTqR5lcYdr+wWpfxIYtifwZv6G21bK7lVmA==
X-Google-Smtp-Source: AGHT+IHaLMQbdM0zPWY8zJlPranyOlKwTeZDk9Hpplqz8CRRR0jiptPs9tjlct/gmCYEz5uGaZagAC0l4UmoZ8zf2S0=
X-Received: by 2002:a05:6402:268e:b0:5da:a78:4c8b with SMTP id
 4fb4d7f45d1cf-5db7d2d2e1cmr3255494a12.2.1737137673149; Fri, 17 Jan 2025
 10:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126144344.4177332-1-edumazet@google.com> <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com> <Z4pmD3l0XUApJhtD@PC-LX-SteWu>
In-Reply-To: <Z4pmD3l0XUApJhtD@PC-LX-SteWu>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 19:14:22 +0100
X-Gm-Features: AbW1kvaQOleg-BRwlcuui8Ku25sd3QsQ5Gy8xv-PeWUW4VU9ZBOF-BqUzhuO-g4
Message-ID: <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
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

On Fri, Jan 17, 2025 at 3:16=E2=80=AFPM Stephan Wurm <stephan.wurm@a-eberle=
.de> wrote:
>
> Am 17. Jan 14:22 hat Eric Dumazet geschrieben:
> >
> > Thanks for the report !
> >
> > You could add instrumentation there so that we see packet content.
> >
> > I suspect mac_len was not properly set somewhere.
> >
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..b0068e23083416ba13794e3=
b152517afbe5125b7
> > 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -700,8 +700,10 @@ static int fill_frame_info(struct hsr_frame_info *=
frame,
> >                 frame->is_vlan =3D true;
> >
> >         if (frame->is_vlan) {
> > -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, =
vlanhdr))
> > +               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr,
> > vlanhdr)) {
> > +                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
> >                         return -EINVAL;
> > +               }
> >                 vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
> >                 proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
> >         }
>
> Thanks for your instrumentation patch.
>
> I got the following output in kernel log when sending an icmp echo with
> VLAN header:
>
> kernel: prp0: entered promiscuous mode
> kernel: skb len=3D46 headroom=3D2 headlen=3D46 tailroom=3D144
>         mac=3D(2,14) net=3D(16,-1) trans=3D-1
>         shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
>         csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
>         hash(0x0 sw=3D0 l4=3D0) proto=3D0x0000 pkttype=3D0 iif=3D0
> kernel: dev name=3Dprp0 feat=3D0x0000000000007000
> kernel: sk family=3D17 type=3D3 proto=3D0
> kernel: skb headroom: 00000000: 0d 12
> kernel: skb linear:   00000000: 00 d0 93 4a 2d 91 00 d0 93 53 9c cb 81 00=
 00 00
> kernel: skb linear:   00000010: 08 00 45 00 00 1c 00 01 00 00 40 01 d4 a1=
 ac 10
> kernel: skb linear:   00000020: 27 14 ac 10 27 0a 08 00 f7 ff 00 00 00 00
> kernel: skb tailroom: 00000000: 00 01 00 06 20 03 00 25 3c 20 00 00 00 00=
 00 00
> kernel: skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 01=
 00 3d
> kernel: skb tailroom: 00000020: 00 00 00 00 67 8a 61 45 15 63 56 39 00 25=
 00 7f
> kernel: skb tailroom: 00000030: f8 fe ff ff 7f 00 d0 93 ff fe 64 e8 8e 00=
 53 00
> kernel: skb tailroom: 00000040: 14 0e 14 31 00 00 53 00 14 0e 14 29 00 00=
 00 00
> kernel: skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 08 00 45 00=
 00 34
> kernel: skb tailroom: 00000060: 24 fa 40 00 40 06 17 c8 7f 00 00 01 7f 00=
 00 01
> kernel: skb tailroom: 00000070: aa 04 13 8c 94 1d a0 b2 77 d6 5f 8a 80 10=
 02 00
> kernel: skb tailroom: 00000080: fe 28 00 00 01 01 08 0a 89 e9 8a f7 89 e9=
 8a f7
> kernel: prp0: left promiscuous mode
>

Yup, mac_len is incorrect, and the network header is also wrong.

Please give us a stack trace, because at least one caller of
hsr_forward() needs to be VLAN ready.

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..6f65a535c7fcd740cef81e71832=
3e86fd1eef832
100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -700,8 +700,11 @@ static int fill_frame_info(struct hsr_frame_info *fram=
e,
                frame->is_vlan =3D true;

        if (frame->is_vlan) {
-               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlan=
hdr))
+               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr,
vlanhdr)) {
+                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
+                       WARN_ON_ONCE(1);
                        return -EINVAL;
+               }
                vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
                proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
        }

