Return-Path: <netdev+bounces-84107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DFE8959A0
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4C81F22F9E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107C14B062;
	Tue,  2 Apr 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJAqvU+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76714B061
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075026; cv=none; b=KG5NH+vLabwNfcSVg5xSrjZxLx4ztWdKLHTHhSQprxGyd/eXjlK8TOeLGmQmVqaUL/L8nOpLML6jrAQAZutPpKh29dIM98X5m9U14CjmjSZ9AaZ8YQ/ETFj9a0Mtd7RRCw/AJNxayHHvdt0CQbpKwPN9/oYegE+W0ZOjSHlOFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075026; c=relaxed/simple;
	bh=IyQnuKfJjvYtIRbGhkfkDil1O8E3zgaXf/1TH/RfdnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLhv3gCgGUgqwvsM70tgcPVLU3pXs6bVmWuib34eKHLPzuIZW/jSzsn5GvfK8s3PREhXRQO98oHAICS4SXzKuGSJiHywWJUz4Ys7DsrPdIo2YZCM9kdiJAXF/R4Al0X371nzrJmCMkWRRV/own93AKOH36dwBm3mRk3nL/hIdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJAqvU+y; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so50669a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712075023; x=1712679823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wgVmp+0wEyx7PlexlueAyPf94Pjb56IglGYtO7Yb6A=;
        b=KJAqvU+yhrlNnwWeEDMtWZORzx8sntIPOEypXJMvFjwPGJTwyEjPs/I0XqqoyD1GJ8
         3h1xsNXLrwU34sn6WA1Ftqp2+7VzlaMo7+yjGQpwhM0KfzoyaWOm4TAGkihz+9eYdBv9
         xsUaMnFKrf7l2xehghkLQQRSNrLBCWw6o37DBmBzJgaSIyIEkkRwc1mOIPB3jn0oKKPG
         cPYBMBDt7es6439pMjObHdBC6u5zZj+P0xpVT/PrLtbosNbBoajnMXvIhCVeC3XeFoJF
         M8gg38/FRjb33mvGYSJfI6coloBtMjoSkz9x277Tp9ZpYeMUEx8USk2G6LkNiTWseSEz
         OI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075023; x=1712679823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wgVmp+0wEyx7PlexlueAyPf94Pjb56IglGYtO7Yb6A=;
        b=ko5LQr2ZiyiOIEWP7JPcIaD2qNvXbM/q0kc6eeQ0Hlrws6cNyTA18UCdcd/c3seMi1
         FXEL1HqTzH2wcStl06ie+CHQkWv7MgAyJvDsMr3L6FYD2b6KdtQRBykSZdfkPIS5fvI+
         IYWOyHJLmCVb2BBMCDBwZiOa7MGBD030qnhz9CTIlNmkzZwq0Sqmp6XOcGtKjF+zhCh3
         /VOYhWhFuBP+IaW0CBTMbqWXOu2N7Ug5FQvd58ldIVoYit0JxRlQ1+5Azo+MSYP58Bry
         IZQohd9VXMtArvPER8vA9GeAqnnefYK+E8f055WQVQOMWAQyqe6HOHdTxdOAijM8A4k2
         bFpw==
X-Forwarded-Encrypted: i=1; AJvYcCWzfdS1QuGOvhvqOeAd3qjPLHCl/AKgnXKNQBq/70nFqIBCsD7j786ac5M+fIH9yLTWXOpdAm9iMJxICasJAlqZw0ewACfB
X-Gm-Message-State: AOJu0YxY7ESaPDK7vUD7VinaqCRmuaHnojbNH/Gx9Xh1trxqiz+0bHrG
	GCFUnW3TlLB1TNYWwQ0QqRewdsNr4kCEcVLCWGiF6pRTi1HOrNok368W9XN1DwVcpFTtUeSkIxt
	HCk1F4U/Hu9OIAotZN0a8PlSGY0AH7gQrRInp
X-Google-Smtp-Source: AGHT+IHghWq7h/oFhbPrpBo/7zzGwDQlf+AM3S/EaXPDEZyAedvKk6du5lyH0QaPHhRbL+3tQDBnGDPLRGKWKFMqePE=
X-Received: by 2002:a05:6402:c94:b0:56c:2d40:7430 with SMTP id
 cm20-20020a0564020c9400b0056c2d407430mr551675edb.3.1712075022940; Tue, 02 Apr
 2024 09:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <c110f41a0d2776b525930f213ca9715c@tesaguri.club>
 <CANn89iKMS2cvgca7qOrVMhWQOoJMuZ-tJ99WTtkXng1O69rOdQ@mail.gmail.com>
In-Reply-To: <CANn89iKMS2cvgca7qOrVMhWQOoJMuZ-tJ99WTtkXng1O69rOdQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 18:23:32 +0200
Message-ID: <CANn89iKm5X8V7fMD=oLwBBdX2=JuBv3VNQ5_7-G7yFaENYJrjg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: shironeko@tesaguri.club, Jose Alonso <joalonsof@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:50=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Apr 2, 2024 at 5:28=E2=80=AFPM <shironeko@tesaguri.club> wrote:
> >
> > Hi all,
> >
> > These parts seems to be causing a regression for a specific USB NIC, I
> > have this on one of home server, and it's network will randomly cut out
> > a few times a week.
> > Seems others have ran into the same issue with this particular NIC as
> > well https://bugzilla.kernel.org/show_bug.cgi?id=3D218536
> >
> > > +/* inverse of tcp_win_from_space() */
> > > +static inline int tcp_space_from_win(const struct sock *sk, int win)
> > > +{
> > > +     u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
> > > +
> > > +     do_div(val, tcp_sk(sk)->scaling_ratio);
> > > +     return val;
> > > +}
> > > +
> > > +static inline void tcp_scaling_ratio_init(struct sock *sk)
> > > +{
> > > +     /* Assume a conservative default of 1200 bytes of payload per 4=
K
> > > page.
> > > +      * This may be adjusted later in tcp_measure_rcv_mss().
> > > +      */
> > > +     tcp_sk(sk)->scaling_ratio =3D (1200 << TCP_RMEM_TO_WIN_SCALE) /
> > > +                                 SKB_TRUESIZE(4096);
> > >  }
> > ...
> > > @@ -740,12 +750,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
> > >               do_div(grow, tp->rcvq_space.space);
> > >               rcvwin +=3D (grow << 1);
> > >
> > > -             rcvmem =3D SKB_TRUESIZE(tp->advmss + MAX_TCP_HEADER);
> > > -             while (tcp_win_from_space(sk, rcvmem) < tp->advmss)
> > > -                     rcvmem +=3D 128;
> > > -
> > > -             do_div(rcvwin, tp->advmss);
> > > -             rcvbuf =3D min_t(u64, rcvwin * rcvmem,
> > > +             rcvbuf =3D min_t(u64, tcp_space_from_win(sk, rcvwin),
> > >                              READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_=
rmem[2]));
> > >               if (rcvbuf > sk->sk_rcvbuf) {
> > >                       WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> >
> > The NIC:
> > usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
> > usb 2-2: New USB device found, idVendor=3D0b95, idProduct=3D1790, bcdDe=
vice=3D
> > 1.00
> > usb 2-2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
> > usb 2-2: Product: AX88179
> > usb 2-2: Manufacturer: ASIX Elec. Corp.
> > usb 2-2: SerialNumber: 0000000000009D
> > ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at
> > usb-0000:00:14.0-2, ASIX AX88179 USB 3.0 Gigabit Ethernet,
> > 02:5e:c0:4b:a4:f7
> > ax88179_178a 2-2:1.0 eth0: ax88179 - Link status is: 1
> >
> > The dmesg error I get:
> >
>
> Thanks for the report. This driver is probably lying on skb->truesize.
>
> This commit looks suspicious
>
> commit f8ebb3ac881b17712e1d5967c97ab1806b16d3d6
> Author: Jose Alonso <joalonsof@gmail.com>
> Date:   Tue Jun 28 12:13:02 2022 -0300
>
>     net: usb: ax88179_178a: Fix packet receiving

Could you try this patch ?

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.=
c
index 88e084534853dd50505fd730e7ccd07c70f2d8ee..ca33365e49cc3993a974ddbdbf6=
8189ce4df2e82
100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1452,21 +1452,16 @@ static int ax88179_rx_fixup(struct usbnet
*dev, struct sk_buff *skb)
                        /* Skip IP alignment pseudo header */
                        skb_pull(skb, 2);

-                       skb->truesize =3D SKB_TRUESIZE(pkt_len_plus_padd);
                        ax88179_rx_checksum(skb, pkt_hdr);
                        return 1;
                }

-               ax_skb =3D skb_clone(skb, GFP_ATOMIC);
+               ax_skb =3D netdev_alloc_skb_ip_align(dev->net, pkt_len);
                if (!ax_skb)
                        return 0;
-               skb_trim(ax_skb, pkt_len);
+               skb_put(ax_skb, pkt_len);
+               memcpy(ax_skb->data, skb->data + 2, pkt_len);

-               /* Skip IP alignment pseudo header */
-               skb_pull(ax_skb, 2);
-
-               skb->truesize =3D pkt_len_plus_padd +
-                               SKB_DATA_ALIGN(sizeof(struct sk_buff));
                ax88179_rx_checksum(ax_skb, pkt_hdr);
                usbnet_skb_return(dev, ax_skb);

