Return-Path: <netdev+bounces-167900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92415A3CBDE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F49172589
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19B720F082;
	Wed, 19 Feb 2025 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="g8tBG6+n"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C023DEB6;
	Wed, 19 Feb 2025 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002099; cv=pass; b=EW/8i3QX0AYfxXKmps5dQ6pDebklgV5u95cO0PnyWBtke+YzfAFK1HDmtftr57tnkqnjQUK9zaSO6in2IcHwchhol2m2iXAWZR6B8lbS7M8TzSte1EpXBgiIwn88Fh3IXUVowvV+BRWGfsvxv9824VIskYoaaLt5o5Khpg0GS0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002099; c=relaxed/simple;
	bh=3smt+KX0feUWzWD5u7BX0QOcielt0U4BKUcnhRCMcLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJNyNbxNuTxarmqc4UJ/Zt5rk1nMpHGHMfMCgaXEKhuL+nos8Zr/yTsGUu/IJU4EXbQzZWrAn8olGzg5fpBuXhUQ6PlKlbC9cC9fsP5srf6LvCUZfmi3OW60q5D5hVqzJA5b1HC7ZclPh1PtXDOUj6ViXD6GXnBchwgvNvf9zck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=g8tBG6+n; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YyqtX0gwHz49PvR;
	Wed, 19 Feb 2025 23:54:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740002086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mG6x2AWDkrkQOGEGxoDcHtbU8g613LdS4e6+qEBm2fA=;
	b=g8tBG6+nviP7GzomdDc832mVTsw+GCgFZaitwduKPBMy56GcVBf6PA4gUCUItP8eWWDUl/
	QSqdgDLnELQFV4gV+8f2jedm62YV+Fq7ZTlp49QS+9wRugAqYrTkZDm5sBxPtwLuf2dBB/
	OSY041vNXvFNRdhgSju16/S1Zh8fFMLg+wFrnxNaVju6jlolHozCDgJksq8aTC6QAgOML1
	LXgPUy9b81iqgFUbNZ2WMb+RLaLQ0KRN5MIZ44UlFbzcNMs/fHe4/GfAi4OXrcLD8HfQ2O
	xQRjAVG1bZIvqVjv3uJWM8b5rrgf7AGc4mbMC/tFCrUXMtrJhYmJD5tnc1Idsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740002086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mG6x2AWDkrkQOGEGxoDcHtbU8g613LdS4e6+qEBm2fA=;
	b=RFyVeQO+A2ZNoCQFYTvo7yH4xj0vPrvc6WFVq1WX+81A+d2hY4TqsgJ7L//Pa/XgAvmd6Y
	9RmLNpyrGhbRux54D3WM6k2d7HVY2tTINB03IhXpfnaJUQfgFX/QQg7HzDAd0FGnzFCL3f
	B3AZuDpfEwhZDfM2jyeXa9EcXIVV9arEhSNqYir7fv6iusMjZbfUdwbS/lDBjByDs29lGI
	qqceL/Zav6A/wzLtq5e3lBx0pzH2Ycr0MAdg3Pz1uLuwzOQMLUG2v4y6L50ts5gII9fEk9
	mppL1EO7YlrjDufFpRZtvjTEw0tVBmoA/Hildw49HSC2ExUKrxy+LG9ti1Agyw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740002086; a=rsa-sha256;
	cv=none;
	b=LSSgndqzsJfCFr+bWH2fs5pQxRyhEg6DEK/gqBxc8c4zu8D+Ix1NLWKnsOGFFbP/hWqDqj
	/TTRNy665+Uj0iNjt3yVW9QDGjb3TYjso2ebZKPle1m9n1yzOP5QAqEKNPiTtAb42c0mmy
	aAz7UJm0TmOYdjtj+PODGYnOK6WQoIF56ZBPSsU+cakHfR2PLsauUoNTRwtBnNKC2l0ANs
	r+AL7Oo1NrnMDBPR++2Yted2PxHBhNWNRCW5aYzIZesmW+wiiI1AyXsroVV6ih7LeAEZtg
	9CFBdn0o6KL5AskpuguKAUJ2DgxQmSnsoapW7vlGec4yLdraGh6iU43OkN16pw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <5a916cd4906749eb715561bfe92ae91b3e052028.camel@iki.fi>
Subject: Re: [PATCH v4 0/5] net: Bluetooth: add TX timestamping for
 ISO/L2CAP/SCO
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com
Date: Wed, 19 Feb 2025 23:54:42 +0200
In-Reply-To: <CABBYNZ+j=TYq27g-Ym7NnCm_Mhd=f8JZ=gT-Veq75BdHqzvUEw@mail.gmail.com>
References: <cover.1739988644.git.pav@iki.fi>
	 <CABBYNZ+j=TYq27g-Ym7NnCm_Mhd=f8JZ=gT-Veq75BdHqzvUEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2025-02-19 kello 14:55 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, Feb 19, 2025 at 1:13=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add support for TX timestamping in Bluetooth ISO/L2CAP/SCO sockets.
> >=20
> > Add new COMPLETION timestamp type, to report a software timestamp when
> > the hardware reports a packet completed. (Cc netdev for this)
> >=20
> > Previous discussions:
> > https://lore.kernel.org/linux-bluetooth/cover.1739097311.git.pav@iki.fi=
/
> > https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.googler=
s.com.notmuch/
> > https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/
> >=20
> > Changes
> > =3D=3D=3D=3D=3D=3D=3D
> > v4:
> > - Change meaning of SOF_TIMESTAMPING_TX_COMPLETION, to save a bit in
> >   skb_shared_info.tx_flags:
> >=20
> >   It now enables COMPLETION only for packets that also have software SN=
D
> >   enabled.  The flag can now be enabled only via a socket option, but
> >   coupling with SND allows user to still choose for which packets
> >   SND+COMPLETION should be generated.  This choice maybe is OK for
> >   applications which can skip SND if they're not interested.
> >=20
> >   However, this would make the timestamping API not uniform, as the
> >   other TX flags can be enabled via CMSG.
> >=20
> >   IIUC, sizeof skb_shared_info cannot be easily changed and I'm not sur=
e
> >   there is somewhere else in general skb info, where one could safely
> >   put the extra separate flag bit for COMPLETION. So here's alternative
> >   suggestion.
>
> Due to cloning/dup of socket by bluetoothd wouldn't it be better to
> have the completion on a per-packet basis?

So this is about a few lines change to v3, not a big redesign.

This change is a suggestion in response to the concern on using the
last available bit in tx_flags raised here:

https://lore.kernel.org/linux-bluetooth/67a972a6e2704_14761294b0@willemb.c.=
googlers.com.notmuch/

So normally how it works is that based on socket flags and CMSG, skb
info is tagged with bit flags that indicate which tstamps they emit.
The v3->v4 change just avoids needing another bit for COMPLETION, by
using the existing bit for SND tstamp together with socket flag (which
in v3 instead controlled whether skbs are tagged for COMPLETION) to
decide between SND and SND+COMPLETION.

So I'm not sure if this sounds preferable over using the last free
tx_flags bit to indicate COMPLETION is requested (or if there is some
other place in skb to put a bit that I'm not seeing).

>  Not really sure if that is what setting it via CMSG would mean,

I was here referring to the CMSG timestamping API, Sec 1.3.4 in

https://www.kernel.org/doc/Documentation/networking/timestamping.rst

> but in the other hand perhaps the
> problem is that the error queue is socket wide, not per-fd, anyway it
> doesn't sound very useful to notify the completion on all fd pointing
> to the same socket. Or perhaps it is time for introducing a proper TX
> complete queue rather than reuse the error queue? I mean we can keep
> using the error queue for backwards compatibility but moving forward I
> think it would be better not to mix errors with tx complete events, so
> perhaps we can add something like a socket option that dissociates the
> error queue from tx completion queue.


Some good solution to the issue of wakeups on timestamps and multiple
errqueue consumers would be useful, but that probably requires a
separate patch series.

> > - Better name in sof_timestamping_names
> >=20
> > - I decided to keep using sockcm_init(), to avoid open coding READ_ONCE
> >   and since it's passed to sock_cmsg_send() which anyway also may init
> >   such fields.
> >=20
> > v3:
> > - Add new COMPLETION timestamp type, and emit it in HCI completion.
> > - Emit SND instead of SCHED, when sending to driver.
> > - Do not emit SCHED timestamps.
> > - Don't safeguard tx_q length explicitly. Now that hci_sched_acl_blk()
> >   is no more, the scheduler flow control is guaranteed to keep it
> >   bounded.
> > - Fix L2CAP stream sockets to use the bytestream timestamp conventions.
> >=20
> > Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > The packet flow in Bluetooth is the following. Timestamps added here
> > indicated:
> >=20
> > user sendmsg() generates skbs
> > >=20
> > * skb waits in net/bluetooth queue for a free HW packet slot
> > >=20
> > * orphan skb, send to driver -> TSTAMP_SND
> > >=20
> > * driver: send packet data to transport (eg. USB)
> > >=20
> > * wait for transport completion
> > >=20
> > * driver: transport tx completion, free skb (some do this immediately)
> > >=20
> > * packet waits in HW side queue
> > >=20
> > * HCI report for packet completion -> TSTAMP_COMPLETION (for non-SCO)
> >=20
> > In addition, we may want to do the following in future (but not
> > implemented in this series as we don't have ISO sequence number
> > synchronization yet which is needed first, moreover e.g. Intel
> > controllers return only zeros in timestamps):
> >=20
> > * if packet is ISO, send HCI LE Read ISO TX Sync
> > >=20
> > * HCI response -> hardware TSTAMP_SND for the packet the response
> >   corresponds to if it was waiting for one, might not be possible
> >   to get a tstamp for every packet
> >=20
> > Bluetooth does not have tx timestamps in the completion reports from
> > hardware, and only for ISO packets there are HCI commands in
> > specification for querying timestamps afterward.
> >=20
> > The drivers do not provide ways to get timestamps either, I'm also not
> > aware if some devices would have vendor-specific commands to get them.
> >=20
> > Driver-side timestamps
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Generating SND on driver side may be slightly more accurate, but that
> > requires changing the BT driver API to not orphan skbs first.  In theor=
y
> > this probably won't cause problems, but it is not done in this patchset=
.
> >=20
> > For some of the drivers it won't gain much. E.g. btusb immediately
> > submits the URB, so if one would emit SND just before submit (as
> > drivers/net/usb/usbnet.c does), it is essentially identical to emitting
> > before sending to driver.  btintel_pcie looks like it does synchronous
> > send, so looks the same.  hci_serdev has internal queue, iiuc flushing
> > as fast as data can be transferred, but it shouldn't be waiting for
> > hardware slots due to HCI flow control.
> >=20
> > Unless HW buffers are full, packets mostly wait on the HW side.  E.g.
> > with btusb (non-SCO) median time from sendmsg() to URB generation is
> > ~0.1 ms, to USB completion ~0.5 ms, and HCI completion report at ~5 ms.
> >=20
> > The exception is SCO, for which HCI flow control is disabled, so they d=
o
> > not get completion events so it's possible to build up queues inside th=
e
> > driver. For SCO, COMPLETION needs to be generated from driver side, eg.
> > for btusb maybe at URB completion.  This could be useful for SCO PCM
> > modes (but which are more or less obsolete nowadays), where USB isoc
> > data rate matches audio data rate, so queues on USB side may build up.
> >=20
> > Use cases
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > In audio use cases we want to track and avoid queues building up, to
> > control latency, especially in cases like ISO where the controller has =
a
> > fixed schedule that the sending application must match.  E.g.
> > application can aim to keep 1 packet in HW queue, so it has 2*7.5ms of
> > slack for being woken up too late.
> >=20
> > Applications can use SND & COMPLETION timestamps to track in-kernel and
> > in-HW packet queues separately.  This can matter for ISO, where the
> > specification allows HW to use the timings when it gets packets to
> > determine what packets are synchronized together. Applications can use
> > SND to track that.
> >=20
> > Tests
> > =3D=3D=3D=3D=3D
> >=20
> > See
> > https://lore.kernel.org/linux-bluetooth/cover.1739026302.git.pav@iki.fi=
/
> >=20
> > Pauli Virtanen (5):
> >   net-timestamp: COMPLETION timestamp on packet tx completion
> >   Bluetooth: add support for skb TX SND/COMPLETION timestamping
> >   Bluetooth: ISO: add TX timestamping
> >   Bluetooth: L2CAP: add TX timestamping
> >   Bluetooth: SCO: add TX timestamping socket-level mechanism
> >=20
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
> >=20
> > --
> > 2.48.1
> >=20
>=20
>=20

--=20
Pauli Virtanen

