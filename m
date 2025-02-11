Return-Path: <netdev+bounces-165228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E6A31215
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6DD17A2942
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41525EF9D;
	Tue, 11 Feb 2025 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFY3HSta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC425EFAA;
	Tue, 11 Feb 2025 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292704; cv=none; b=lGKPdkWaLVRxVvHRZ4ClaO4kKisuZBnpWZhk50sVFscq6C4Q+tsVrw+vggvnM0NRCiNy5++k4c1OlEZGAypcRYeEIEq/gQXgbtPmXqdTmxSDXpkRSbSU8DiE9lLguljVvXPENa5fx+5rn6fMXV+AQpJtPZvnIhBbsdCtHQBTiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292704; c=relaxed/simple;
	bh=+CoLKqzIpAjLzHU4xXUAo7HbGHenab1WftcLUv9xDdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aErs/cgk1eoepDQR8MtNWO1pCrrkloaC4Lo98KGjPjoehKV32gKK2mSESb8u7l28Qs2xVtHZSOspwbs7SkDlDQIz0oipHX2kFTRzIcakkB+SlPD4iWDb5AhZ3Dka9SAl276DhNb7j6/+y2rDI1oAOHogyTBEU6SQcG237MDYIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFY3HSta; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3072f8dc069so60549621fa.3;
        Tue, 11 Feb 2025 08:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739292701; x=1739897501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYyS/Pce8IHd969E8US60tVG7+nHlOWBylQ9OLMgeBg=;
        b=iFY3HStaAYs6FePGJXSXcwpFgp7nUIH1pFsvL/ZszrHMdurfkFt+hkTVrUkT7WMQLf
         oEan56u+fgXuK2Yr1+qV1iDlcaPgH7+mz9RnCkXaV5YVNdEXA7gw9g/cy5ZpiSRr/dSp
         8WGrsn6+UHpGQDFVigZpZ7gDVKEUVKrdUyqTSBlEGRzsniu8lwTHmPlZuvWUqixDHpqy
         1rrVF9q6ItCC8GV21SqWvCk7JxTQqfpzy/QI8ptHxAWtdcKL5Vf7ZL1pjPIE4qnSFfJB
         Xg0eHNJc4gS3+mukdP3m6AWLXpHgbK4sGSFfthOmM8a62kXeMNf2PjF+Yku4+6ftiT+A
         bcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739292701; x=1739897501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYyS/Pce8IHd969E8US60tVG7+nHlOWBylQ9OLMgeBg=;
        b=Vg+WPerFd7Y9ZeYWTL8xSXrLdoTDLAYsw7O66EtYXt5pbhSJKsZyZEHmZRNV+yiy/u
         IEuZNJsxxPu41wxnjEWn11y+xlhmg3XBu5KhVSbV3BszNiQiOJ6BUIxI7hnbsrwmLPmt
         DZUZAiXHi7LHtTQsWSDE+5l0E4ihv2dQP3FQQ0PDYfZGr52y4jpJaX3FBzfUXtNQoxOO
         r1JCgc5o4BL8viwWChXXKoCv2ONuxyOEB/ENLp6pLcX13CefLskIoq89sf0clpqgxhSz
         GHTbv/SaNkcqp1sr/w0SdBOZaW2XIkEr2x53kNHgFKaokzYIq8OdCsSKnuyRvGYm79nW
         OSnA==
X-Forwarded-Encrypted: i=1; AJvYcCUdVUJaoeBb7WPQ0Ad3cmGln9HG5pbgcwcIanf/23M2TGk5VEPc41JimATeu2ix+d55upa0WsVjKlKk1Wv1@vger.kernel.org, AJvYcCUw51Bx6jjbrmg1xtRo8BJOuvUhdLBzT5dMYiCNv/JPcu6W8DTOgxwfHEqshryODmqM9CqlUASbcHAPrnEDxPU=@vger.kernel.org, AJvYcCWuAx7lbGVTGcun0AIdvm3RgvG6W8poDv7BmZFTGOq2QBC/tLMdBuAXNbrYGyJn9JUPhPAnE1jB@vger.kernel.org
X-Gm-Message-State: AOJu0YxAp2gN+Kx3sOEgx4cH9AfM0g5yZLjGMnJloQJr2xtahtvCOt5x
	kWCQXuJPFJPr1+ZoEY46q+ZV5tYv+ucfN/d5jjBpVe/+y05wSqHm+vDPDcFpQH4CwB3WP4GTvN1
	X1cX1/D6a3+E7csZjT1jwS+4YlRk=
X-Gm-Gg: ASbGnctKuo21XT0rtvLZhfPVYqWVvwUN2qUxPQuvSVQ2mKULK8cog/mSrioSy1MFlK+
	fhr3ACX8MjTIrkoccwv0PUUrp0O7o9lDi2hBVu6Q0pdk0ix1mPa+t7mddAoyiJGDdWnbhp9Z/8g
	==
X-Google-Smtp-Source: AGHT+IHSZfnRJv3VnbZmMe4zjtYIYfjA5FEQzWtS4zH+xXm76ZeJAi/00pACubYEqC1hhdeSlW1h8rqMDTlH+VgZbPc=
X-Received: by 2002:a2e:a595:0:b0:308:df1e:24c5 with SMTP id
 38308e7fff4ca-309036430d2mr1194791fa.9.1739292700405; Tue, 11 Feb 2025
 08:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a9e24a.050a0220.3d72c.0050.GAE@google.com> <e8b8686f-8de1-aa25-9707-fcad4ffa5710@salutedevices.com>
 <c2d99ec3-d69e-b47d-45cc-0ad39893afd7@salutedevices.com>
In-Reply-To: <c2d99ec3-d69e-b47d-45cc-0ad39893afd7@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Feb 2025 11:51:26 -0500
X-Gm-Features: AWEUYZkO3selwcJDC-g860TX_e4qYzoQBTRXvcQh9XLjmcc28cukeOUo2NTWki4
Message-ID: <CABBYNZJqmayOhPtWpmj8PwK5uyzUemCEUz9eN+h26wH9ix91Kg@mail.gmail.com>
Subject: Re: [DMARC error] Re: [syzbot] [bluetooth?] KASAN:
 slab-use-after-free Read in skb_queue_purge_reason (2)
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: hdanton@sina.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arseniy,

On Tue, Feb 11, 2025 at 11:22=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> May be my previous version was free of this problem ?
>
> https://lore.kernel.org/linux-bluetooth/a1db0c90-1803-e01c-3e23-d18e4343a=
4eb@salutedevices.com/

You can try sending it to
syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com to check if that
works.

> Thanks
>
> On 11.02.2025 17:16, Arseniy Krasnov wrote:
> > Hi, I guess problem here is that, if hci_uart_tty_close() will be calle=
d between
> > setting HCI_UART_PROTO_READY and skb_queue_head_init(), in that case mr=
vl_close()
> > will access uninitialized data.
> >
> > hci_uart_set_proto() {
> >         ...
> >         set_bit(HCI_UART_PROTO_READY, &hu->flags);
> >
> >         err =3D hci_uart_register_dev(hu);
> >                 mrvl_open()
> >                     skb_queue_head_init();

Or we follow what the likes of hci_uart_register_device_priv, in fact
we may want to take the time to clean this up, afaik the ldisc is
deprecated and serdev shall be used instead, in any case if we can't
just remove ldisc version then at very least they shall be using the
same flow when it comes to hci_register_dev since the share the same
struct hci_uart.

> >         if (err) {
> >                 return err;
> >         }
> >         ...
> > }
> >
> > Thanks
> >
> > On 10.02.2025 14:26, syzbot wrote:
> >> syzbot has bisected this issue to:
> >>
> >> commit c411c62cc13319533b1861e00cedc4883c3bc1bb
> >> Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> Date:   Thu Jan 30 18:43:26 2025 +0000
> >>
> >>     Bluetooth: hci_uart: fix race during initialization
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D116cebd=
f980000
> >> start commit:   40b8e93e17bf Add linux-next specific files for 2025020=
4
> >> git tree:       linux-next
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D136cebd=
f980000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D156cebdf98=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dec880188a8=
7c6aad
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D683f8cb11b94=
b1824c77
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10b7eeb0=
580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12f74f6458=
0000
> >>
> >> Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
> >> Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initializat=
ion")
> >>
> >> For information about bisection process see: https://goo.gl/tpsmEJ#bis=
ection



--=20
Luiz Augusto von Dentz

