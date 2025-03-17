Return-Path: <netdev+bounces-175419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21CA65B83
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF003AF98B
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D601B3939;
	Mon, 17 Mar 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMKypX63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D71AD403;
	Mon, 17 Mar 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233853; cv=none; b=qR0JBO/e0kFnFc8ELaG7bTHOljle3lT5aQQAwbQQZwL1R+HIHIZb1DyHagsGhDbL7Y+ShfLZTVJ0gM5n6vBk/FSOpcMLAl2T3XqEvaHCG8LugC6Ho120exhjCLpjJ7L1YTBlfnhTs6WMPKF6RNj4FcC0fV8yzQF0LnPaUOk92YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233853; c=relaxed/simple;
	bh=VJ1ZWASwSSpGAnDvjBJu4VbOxSfSE8Ei2yYazmhpv/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8AF2dzl7Z2ywl2R2CX66fWoZm728iNwFurOi4xmdOflgFxHq/xtiQrDgsCTcH26FM/MbrPTwjg/4NqBDzMMkYKr8yo2wFQ5IDuH3TFU6HTlVZiInr0XdiZKzhAQiYJ8gxwImHDq3OCzcIEaLeLNrvp33C1Ou6uwlu//BhPvXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMKypX63; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307bc125e2eso53384341fa.3;
        Mon, 17 Mar 2025 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233850; x=1742838650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W7SUyodVOA5Na5UVj73LgHk/Ble4Glw8k7ZbsTr1Q8=;
        b=JMKypX63uNVKr1Gn//DyvLJxo6ZDO9O2F+s6T/F8DtqKBH0L4ZnVbEMTPbnyfNTQlb
         4d3UT9FaxHyr95h0Bp+WVfcKR2l1eUPj8eueM3NTkzm4clz2oQPAOv6rd8hLvTWM/bMT
         dmSE+sbZw01Q8YyKlTw6jpdc99v9wpRELMPv9CffuAyas1MpzlivgfVnRdOJ99RE5gf9
         6u6e0we7s8gG5+Dr4PWObE+/jg4M1BaMn8qF4D7L0cegtNqYcJHmD4OrrKyYREVXIgU0
         HTbB+ABkTJwlHdyGIPzrVjhENCG20gkqwMtUqlEHgGxU6iw1uLY9ga+10Dvj8rSXotfJ
         9i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233850; x=1742838650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W7SUyodVOA5Na5UVj73LgHk/Ble4Glw8k7ZbsTr1Q8=;
        b=qO4l3SF1fjz2W/bW5FIIXbKTuUhYZegF88Jea2Dlgz8t1rP/JEOwRa1w5fUT1uOneW
         TCjd9YiqeLsYBVBK0m2UO+G7dwAFchVsZanlglXbtgN6LAeYoRGVSdaM8uG5ao/FKJTA
         yh16iW77a2DbdUumJB9URngEg6YJSnAw5K/6EALNRnGOjwggEeHYP/VQd49pjRY+ENg6
         kgEZRRLS/GjyBsUrB160xzSvk8YwTrX3pdEOSLK1Td+KYVN27Iq2aUoW2aMXEAmp4sM0
         UTwNKz2KSiXj73y/lSYs2/Rfm5aWJ3gChpMLZsMrswufPX6nwgHDpUsriz9rYltfQeFW
         JCSg==
X-Forwarded-Encrypted: i=1; AJvYcCVNHA0u2BXrDqnIFxo4Fvo8onGhjXm7WjKbJeh+6G966vIArbZo7QX2UReWhnwcXu+pYygDxvYdEa1mS3z0Ba4=@vger.kernel.org, AJvYcCWZ6UHO0eIajFT+oRhrH5SH19wP7duQ7l9wCMEsZhJCRIxv6DakzcP8RJdPJhFyL7ahgT2jvMY4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95c0i5WxGUzzcwGxePi5D/lkkMe4jDqgoYqg57TakV52/K4pR
	Btr3RT8D5rauiaNewUnToN9sgdOotvzyvuXOAmHKTsuY52OeQgJ+Gzu7eYuAyvGUIDKzxBrm6ky
	hEs2PfwvYnU4HOh/oAzV4l1vde38=
X-Gm-Gg: ASbGncuFCYpkd+Ic3ZSgHvs+XGkHwjXPSZMkk6tNurASUwaA11Ec1ormyeJzzN+U94v
	EFvnRGmJiD99uiR7NVRGyg/3EQ69CQE9/S7HCYz0jUq8086eF2yIfifN6PyKy/bF2ZFBJEt5UW3
	AOYtYX0l34H5tkITbegRHEXnuv
X-Google-Smtp-Source: AGHT+IGjvA+djOTB5K+p6Hs0VxEPzjiFLTt6btr6BgwV1whbGzDT/rnsda6AoTAjcZaToAdLKY1Nb+4tVwBI0rc8Iio=
X-Received: by 2002:a2e:be8c:0:b0:30c:1002:faa8 with SMTP id
 38308e7fff4ca-30c4a74e0e5mr67376191fa.7.1742233849187; Mon, 17 Mar 2025
 10:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739988644.git.pav@iki.fi> <CAL+tcoAAj0p=4h+MBYaN0v-mKQLNau43Av7crF7CVXFEnVL=LQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAAj0p=4h+MBYaN0v-mKQLNau43Av7crF7CVXFEnVL=LQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Mar 2025 13:50:36 -0400
X-Gm-Features: AQ5f1Jr2XGp_LRdQCakAWy9gaULVo0bY3dHIGD-IXTm2XmFMXICuYepOmhNOYmo
Message-ID: <CABBYNZJQc7x-b=_UQDjGbTVnY-iKASNzg=rTFXDRXyn_O+ohNQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Feb 19, 2025 at 7:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >
> > Add support for TX timestamping in Bluetooth ISO/L2CAP/SCO sockets.
> >
> > Add new COMPLETION timestamp type, to report a software timestamp when
> > the hardware reports a packet completed. (Cc netdev for this)
> >
> > Previous discussions:
> > https://lore.kernel.org/linux-bluetooth/cover.1739097311.git.pav@iki.fi=
/
> > https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.googler=
s.com.notmuch/
> > https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/
> >
> > Changes
> > =3D=3D=3D=3D=3D=3D=3D
> > v4:
> > - Change meaning of SOF_TIMESTAMPING_TX_COMPLETION, to save a bit in
> >   skb_shared_info.tx_flags:
> >
> >   It now enables COMPLETION only for packets that also have software SN=
D
> >   enabled.  The flag can now be enabled only via a socket option, but
> >   coupling with SND allows user to still choose for which packets
> >   SND+COMPLETION should be generated.  This choice maybe is OK for
> >   applications which can skip SND if they're not interested.
> >
> >   However, this would make the timestamping API not uniform, as the
> >   other TX flags can be enabled via CMSG.
> >
> >   IIUC, sizeof skb_shared_info cannot be easily changed and I'm not sur=
e
> >   there is somewhere else in general skb info, where one could safely
> >   put the extra separate flag bit for COMPLETION. So here's alternative
> >   suggestion.
> >
> > - Better name in sof_timestamping_names
> >
> > - I decided to keep using sockcm_init(), to avoid open coding READ_ONCE
> >   and since it's passed to sock_cmsg_send() which anyway also may init
> >   such fields.
>
> Please don't do this since the current sockcm_init() initializes more
> than you need. Please take a look at what the new sockcm_init looks
> like and what this series has done[1] which just got merged in recent
> days :)
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/=
commit/?id=3Daefd232de5eb2e7
>
> Thanks,
> Jason
>
> >
> > v3:
> > - Add new COMPLETION timestamp type, and emit it in HCI completion.
> > - Emit SND instead of SCHED, when sending to driver.
> > - Do not emit SCHED timestamps.
> > - Don't safeguard tx_q length explicitly. Now that hci_sched_acl_blk()
> >   is no more, the scheduler flow control is guaranteed to keep it
> >   bounded.
> > - Fix L2CAP stream sockets to use the bytestream timestamp conventions.
> >
> > Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The packet flow in Bluetooth is the following. Timestamps added here
> > indicated:
> >
> > user sendmsg() generates skbs
> > |
> > * skb waits in net/bluetooth queue for a free HW packet slot
> > |
> > * orphan skb, send to driver -> TSTAMP_SND
> > |
> > * driver: send packet data to transport (eg. USB)
> > |
> > * wait for transport completion
> > |
> > * driver: transport tx completion, free skb (some do this immediately)
> > |
> > * packet waits in HW side queue
> > |
> > * HCI report for packet completion -> TSTAMP_COMPLETION (for non-SCO)
> >
> > In addition, we may want to do the following in future (but not
> > implemented in this series as we don't have ISO sequence number
> > synchronization yet which is needed first, moreover e.g. Intel
> > controllers return only zeros in timestamps):
> >
> > * if packet is ISO, send HCI LE Read ISO TX Sync
> > |
> > * HCI response -> hardware TSTAMP_SND for the packet the response
> >   corresponds to if it was waiting for one, might not be possible
> >   to get a tstamp for every packet
> >
> > Bluetooth does not have tx timestamps in the completion reports from
> > hardware, and only for ISO packets there are HCI commands in
> > specification for querying timestamps afterward.
> >
> > The drivers do not provide ways to get timestamps either, I'm also not
> > aware if some devices would have vendor-specific commands to get them.
> >
> > Driver-side timestamps
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Generating SND on driver side may be slightly more accurate, but that
> > requires changing the BT driver API to not orphan skbs first.  In theor=
y
> > this probably won't cause problems, but it is not done in this patchset=
.
> >
> > For some of the drivers it won't gain much. E.g. btusb immediately
> > submits the URB, so if one would emit SND just before submit (as
> > drivers/net/usb/usbnet.c does), it is essentially identical to emitting
> > before sending to driver.  btintel_pcie looks like it does synchronous
> > send, so looks the same.  hci_serdev has internal queue, iiuc flushing
> > as fast as data can be transferred, but it shouldn't be waiting for
> > hardware slots due to HCI flow control.
> >
> > Unless HW buffers are full, packets mostly wait on the HW side.  E.g.
> > with btusb (non-SCO) median time from sendmsg() to URB generation is
> > ~0.1 ms, to USB completion ~0.5 ms, and HCI completion report at ~5 ms.
> >
> > The exception is SCO, for which HCI flow control is disabled, so they d=
o
> > not get completion events so it's possible to build up queues inside th=
e
> > driver. For SCO, COMPLETION needs to be generated from driver side, eg.
> > for btusb maybe at URB completion.  This could be useful for SCO PCM
> > modes (but which are more or less obsolete nowadays), where USB isoc
> > data rate matches audio data rate, so queues on USB side may build up.
> >
> > Use cases
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In audio use cases we want to track and avoid queues building up, to
> > control latency, especially in cases like ISO where the controller has =
a
> > fixed schedule that the sending application must match.  E.g.
> > application can aim to keep 1 packet in HW queue, so it has 2*7.5ms of
> > slack for being woken up too late.
> >
> > Applications can use SND & COMPLETION timestamps to track in-kernel and
> > in-HW packet queues separately.  This can matter for ISO, where the
> > specification allows HW to use the timings when it gets packets to
> > determine what packets are synchronized together. Applications can use
> > SND to track that.
> >
> > Tests
> > =3D=3D=3D=3D=3D
> >
> > See
> > https://lore.kernel.org/linux-bluetooth/cover.1739026302.git.pav@iki.fi=
/
> >
> > Pauli Virtanen (5):
> >   net-timestamp: COMPLETION timestamp on packet tx completion
> >   Bluetooth: add support for skb TX SND/COMPLETION timestamping
> >   Bluetooth: ISO: add TX timestamping
> >   Bluetooth: L2CAP: add TX timestamping
> >   Bluetooth: SCO: add TX timestamping socket-level mechanism
> >
> >  Documentation/networking/timestamping.rst |   9 ++
> >  include/net/bluetooth/bluetooth.h         |   1 +
> >  include/net/bluetooth/hci_core.h          |  13 +++
> >  include/net/bluetooth/l2cap.h             |   3 +-
> >  include/uapi/linux/errqueue.h             |   1 +
> >  include/uapi/linux/net_tstamp.h           |   6 +-
> >  net/bluetooth/6lowpan.c                   |   2 +-
> >  net/bluetooth/hci_conn.c                  | 118 ++++++++++++++++++++++
> >  net/bluetooth/hci_core.c                  |  17 +++-
> >  net/bluetooth/hci_event.c                 |   4 +
> >  net/bluetooth/iso.c                       |  24 ++++-
> >  net/bluetooth/l2cap_core.c                |  41 +++++++-
> >  net/bluetooth/l2cap_sock.c                |  15 ++-
> >  net/bluetooth/sco.c                       |  19 +++-
> >  net/bluetooth/smp.c                       |   2 +-
> >  net/core/sock.c                           |   2 +
> >  net/ethtool/common.c                      |   1 +
> >  17 files changed, 258 insertions(+), 20 deletions(-)
> >
> > --
> > 2.48.1
> >
> >

We are sort of running out of time, if we want to be able to merge by
the next merge window then it must be done this week.

--=20
Luiz Augusto von Dentz

