Return-Path: <netdev+bounces-84099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9FC8958E0
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E31C24736
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B4134CE0;
	Tue,  2 Apr 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPZALKOi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF013340D
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073049; cv=none; b=YdwpeAorZ24FS5SOIXPzWXsvZofZjOp6fT+UuHeaDFNBkVoA9tOkkugHVdGVfdwfho1jE3J+ImALclEc8NEa+OsP+qUVa2ASZxSPkCeY0U+J9zt9z3r/cnzpB/IQejFxO1vKYDJojJiV2rA+UpTMS6c3Laj59JVNCgIMt85j8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073049; c=relaxed/simple;
	bh=7keMWGSDxhPzmwLZYG4zFg9aDGSKhUKx1W29qdCGDQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrHQOvX/0QOiWWI3ZeAK85hFyoylRVU8D+45tTxOZqCb6O6E4VtfuM7ecryPPnaa3fcMR+UunOP5m+BmjehkqAXOzceQD870dTj0SEZrIY7NvQuGxKyuSaCAlnMSjdmK6jeGTOdeKeDXFtv1WS8BVoctygBOsP5CPD6GVVO9p0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YPZALKOi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so66087a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712073046; x=1712677846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sla1x0b7ZQqN0bpNZqaKHAT8jo9A9Xkd/jzhoqsAARU=;
        b=YPZALKOiGFm4ANl+bh75mKhCyZAmDVagddVQjqHYPQrkrEOtBZY2kHaqFRbrTq0Tiy
         rn5hWzrl5tbu+6KstzlBYS5HQzUA/VfkK/sy6Qc0HbK68ZG80tdmqApgqESxYRn9eWEG
         txavzB6gKixPW1rSJVtjyAEjgdf0pY7pVr9NeoI3MGsIkmxtCzzDb3rWmsjvKZ05B/ot
         84PfTlJ9uX7C2Hh394kq20TzDoWI50kmr1UnW4Ho0nt+WKHjP4DCbGnb+nRdjgpRPp2y
         1ujaDZ27O9g71z/XVbXPCJoTqQsdxtFrz+z1n+e3pqUePPxsm0m6/GAxEJ8LpmH5myrA
         THkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712073046; x=1712677846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sla1x0b7ZQqN0bpNZqaKHAT8jo9A9Xkd/jzhoqsAARU=;
        b=QyTEPVfuC0uTwb5bSkGVKLICCzkPgGD2e1PxbhQB7YlR3d+Ey5V4/VEOMe3RFS7aVA
         iYV7g+sY5xAKwO7uNQAGL/Q6+iw7DDmnLMi3cNRJgIQtxYXIVDmCtGawhfpqVNuuPbOA
         lHwKsLs4l/gn4EB7Jpy+o9wL5Qn4k9p9xoxyf8QQKTQpqLSTBdwJwhgIIS/GPvqQAyK6
         Ipg2kiWkkSQIiW12hoY7UPMVs1aUiYpHgOz8TlGcGyE2FyZqw7UWYSfQ+i5XYoHL69Nx
         9BnNJk+UOIzN+1fFcAyLdT1r/w0CAYs984m5h/GDO5NkTkt1HZVpfA97u05TklJojmHx
         sMZw==
X-Forwarded-Encrypted: i=1; AJvYcCW1yoJaJkk6UmYEEt6lzAEDYECQJWXHUOEPGyz3scASurXnvO/c80oooNS3VeLQzENpsA2z2ves70mNYsV9toxUIKi0oYyK
X-Gm-Message-State: AOJu0YxiXgkaUOiDwvmHkgW5t/JNejFW2dBMqfwHQF3vz3q4ERyd5Xjf
	mIxjjx6Kqca0XOFVMj/1e3BnADaqitYfiXrDe9ijHUjGworaxHBhkNdBOvJZR1OvBzn0j26hyc3
	A4bOU76tD2gq14N+dFq3T60jOh6ZNEGkeogBFbdXUOBXkY9021HSA
X-Google-Smtp-Source: AGHT+IHINWuUOQYpNVfa7d8o8Bs2c/eHCRx/aeP8n1BSffV5UegIikYO3xSIShv7K9WypEBd+XffdFyqugp7lAB6VXc=
X-Received: by 2002:a05:6402:26ce:b0:56d:dbad:3e8b with SMTP id
 x14-20020a05640226ce00b0056ddbad3e8bmr351176edd.0.1712073045522; Tue, 02 Apr
 2024 08:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <c110f41a0d2776b525930f213ca9715c@tesaguri.club>
In-Reply-To: <c110f41a0d2776b525930f213ca9715c@tesaguri.club>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 17:50:31 +0200
Message-ID: <CANn89iKMS2cvgca7qOrVMhWQOoJMuZ-tJ99WTtkXng1O69rOdQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: shironeko@tesaguri.club, Jose Alonso <joalonsof@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:28=E2=80=AFPM <shironeko@tesaguri.club> wrote:
>
> Hi all,
>
> These parts seems to be causing a regression for a specific USB NIC, I
> have this on one of home server, and it's network will randomly cut out
> a few times a week.
> Seems others have ran into the same issue with this particular NIC as
> well https://bugzilla.kernel.org/show_bug.cgi?id=3D218536
>
> > +/* inverse of tcp_win_from_space() */
> > +static inline int tcp_space_from_win(const struct sock *sk, int win)
> > +{
> > +     u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
> > +
> > +     do_div(val, tcp_sk(sk)->scaling_ratio);
> > +     return val;
> > +}
> > +
> > +static inline void tcp_scaling_ratio_init(struct sock *sk)
> > +{
> > +     /* Assume a conservative default of 1200 bytes of payload per 4K
> > page.
> > +      * This may be adjusted later in tcp_measure_rcv_mss().
> > +      */
> > +     tcp_sk(sk)->scaling_ratio =3D (1200 << TCP_RMEM_TO_WIN_SCALE) /
> > +                                 SKB_TRUESIZE(4096);
> >  }
> ...
> > @@ -740,12 +750,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
> >               do_div(grow, tp->rcvq_space.space);
> >               rcvwin +=3D (grow << 1);
> >
> > -             rcvmem =3D SKB_TRUESIZE(tp->advmss + MAX_TCP_HEADER);
> > -             while (tcp_win_from_space(sk, rcvmem) < tp->advmss)
> > -                     rcvmem +=3D 128;
> > -
> > -             do_div(rcvwin, tp->advmss);
> > -             rcvbuf =3D min_t(u64, rcvwin * rcvmem,
> > +             rcvbuf =3D min_t(u64, tcp_space_from_win(sk, rcvwin),
> >                              READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rm=
em[2]));
> >               if (rcvbuf > sk->sk_rcvbuf) {
> >                       WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
>
> The NIC:
> usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
> usb 2-2: New USB device found, idVendor=3D0b95, idProduct=3D1790, bcdDevi=
ce=3D
> 1.00
> usb 2-2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
> usb 2-2: Product: AX88179
> usb 2-2: Manufacturer: ASIX Elec. Corp.
> usb 2-2: SerialNumber: 0000000000009D
> ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at
> usb-0000:00:14.0-2, ASIX AX88179 USB 3.0 Gigabit Ethernet,
> 02:5e:c0:4b:a4:f7
> ax88179_178a 2-2:1.0 eth0: ax88179 - Link status is: 1
>
> The dmesg error I get:
>

Thanks for the report. This driver is probably lying on skb->truesize.

This commit looks suspicious

commit f8ebb3ac881b17712e1d5967c97ab1806b16d3d6
Author: Jose Alonso <joalonsof@gmail.com>
Date:   Tue Jun 28 12:13:02 2022 -0300

    net: usb: ax88179_178a: Fix packet receiving

