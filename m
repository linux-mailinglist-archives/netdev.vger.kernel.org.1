Return-Path: <netdev+bounces-167851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE73A3C935
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA5B3ACBD0
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371FD22B8D5;
	Wed, 19 Feb 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq7/Hmpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143D22B8A4;
	Wed, 19 Feb 2025 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994925; cv=none; b=b46VB+SYqvKGek+y9xbL1WUdNwEdupDQr1yQV6fgk9qKl00F3PD0ZLyXxncmTNL+bbHPPIqE2aE9ml73Ump9vNDIaUBg7LwVhuuu7xNNrw90a/6nRZON9o/VI3zYnvskbnNRAuS6BaQeVhhkzbQUYfjkbfbvTlbuvb9GJ0ek6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994925; c=relaxed/simple;
	bh=yVUZK8gCoiDnAR1snyqg7EBPTo+7g708MEv+2bCTyw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSxx2xwnHB1nkAY9CcrnpgSnWNiDWv8i72v0WVsAcJ7xL+iWT4ysMa5Zp6K9vuVivcx5oMHIRwOd3EPy+xfkU+fUY4ANYJfseIBhCNBf4NIDA0UEdh1WqWowD0uWdBVenh3NLZVe+HmflAs3Id7iJTUAH1DW/xnmDXl+X/eZNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq7/Hmpq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso260572e87.1;
        Wed, 19 Feb 2025 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739994921; x=1740599721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nwduK7TQTHxgeQdQg9wMhQj8iW64DQxua4ohDJcSM0=;
        b=Lq7/Hmpq3y+M+/DeZ+GWmUmm63RyzZ/cKd+Z2XlRv3gEEdaAyJoTsx+bjwUyDOuY80
         RP9iR05POxdtFTlK5n3hT+Ew2JCiubJIzp9l2rdwTXacQRq9RtCkdBdGGaekH62Dd8Vl
         upZm1K0ukg6PNfoTmAOU9szmeJbkJoQTlKXoSKJjsaGnVUdIdVznRzjgrAga3Df7bPUr
         PLw9fcyHqs9KhfGSR2T5gBZ8A9yKpD8FvkHerKL4/1L4FgBDpwfL8HH7PDjtJEv1Nuxf
         sg/S0fiA6/OYViUF+es0xoPJNKYa87Y4fj9tm6QdxU9v6m6zOE9QeX17Gxk7zYtxXwGq
         ZN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739994921; x=1740599721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nwduK7TQTHxgeQdQg9wMhQj8iW64DQxua4ohDJcSM0=;
        b=CE8CuRdxCFoB8knCrM2TRbMR+vFgr1i+c9lo3suDBB6AN01cNFZVX7dhQBOjquFT/P
         kyweKpVv65MuTAnfhoxTAqEMIrF69+HerAVonUhiSny+XIgzVvI7jT8naVf/w5VLVBqe
         b/SMK9IXQFN+uDVWFZ/8U0+nbk8waHndqDMRiq3XgMWgVJh7j1TWy0GtEVmxjo8ZsLqz
         V1VkaAxxBwOYeDHaj0EwgjDx6ty0fzNAMoHyLWo7Kw5jdpdrhGIgIdZiVP7PaTCblEFW
         48bBCEHD4Qaz8x3yUWEn6Q1OysxJIqrjP691SLpJ1Zl1qOC1sM54iHIDWOgR08rQhjcp
         sIeg==
X-Forwarded-Encrypted: i=1; AJvYcCVfO/dXrna2wJomcVLvv5xuuU5QrKCQmesp3bMu0TwpaRkcovNmto/ZudA1EfjfexzNuCNZT30=@vger.kernel.org
X-Gm-Message-State: AOJu0YylO1Zyqhf39lufPou57zu+vElha8M+oOfIy8UGq9R876+rDiGM
	hxfpWcsU+IDE8NFrZNZX2C0Jmu4se9W0AwrTRH1zHqEWWIKnnF/r1B0UbqgusErISFqZr1W/z2R
	VjgSzlN7lmOrq4nxnDOuVsYvzKaw=
X-Gm-Gg: ASbGncv9oq92yxqZlU8ehbtufgW71G8XEHwDCuvIxpkVb6iq5rc35E2c1Kb7pZJdOeb
	IMJsfuRk1Ldxf/6y2s8tBM0TNqhsYB9sxdKVsj9kHxO/ekhUi4rbcUtmNRKUbeGrrk3B6t+b+Ow
	==
X-Google-Smtp-Source: AGHT+IEqsRq667GpONMts7CwUz3RAkG8oSwdJBbUPDOdn/Zb0fmxXfrrBu7+k7NBUEX8LCxJoGHMuea+qMTLTVRIWvw=
X-Received: by 2002:a05:6512:3a8a:b0:545:a7a:ce5e with SMTP id
 2adb3069b0e04-5452fe30b8emr6905358e87.15.1739994920869; Wed, 19 Feb 2025
 11:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739988644.git.pav@iki.fi>
In-Reply-To: <cover.1739988644.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Feb 2025 14:55:07 -0500
X-Gm-Features: AWEUYZm-7tPRHXGw5VWQFosenr6iRyfPIj450U181glg1Otv1n0-NNA7VUvc-wI
Message-ID: <CABBYNZ+j=TYq27g-Ym7NnCm_Mhd=f8JZ=gT-Veq75BdHqzvUEw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Feb 19, 2025 at 1:13=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add support for TX timestamping in Bluetooth ISO/L2CAP/SCO sockets.
>
> Add new COMPLETION timestamp type, to report a software timestamp when
> the hardware reports a packet completed. (Cc netdev for this)
>
> Previous discussions:
> https://lore.kernel.org/linux-bluetooth/cover.1739097311.git.pav@iki.fi/
> https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.googlers.=
com.notmuch/
> https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/
>
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> v4:
> - Change meaning of SOF_TIMESTAMPING_TX_COMPLETION, to save a bit in
>   skb_shared_info.tx_flags:
>
>   It now enables COMPLETION only for packets that also have software SND
>   enabled.  The flag can now be enabled only via a socket option, but
>   coupling with SND allows user to still choose for which packets
>   SND+COMPLETION should be generated.  This choice maybe is OK for
>   applications which can skip SND if they're not interested.
>
>   However, this would make the timestamping API not uniform, as the
>   other TX flags can be enabled via CMSG.
>
>   IIUC, sizeof skb_shared_info cannot be easily changed and I'm not sure
>   there is somewhere else in general skb info, where one could safely
>   put the extra separate flag bit for COMPLETION. So here's alternative
>   suggestion.

Due to cloning/dup of socket by bluetoothd wouldn't it be better to
have the completion on a per-packet basis? Not really sure if that is
what setting it via CMSG would mean, but in the other hand perhaps the
problem is that the error queue is socket wide, not per-fd, anyway it
doesn't sound very useful to notify the completion on all fd pointing
to the same socket. Or perhaps it is time for introducing a proper TX
complete queue rather than reuse the error queue? I mean we can keep
using the error queue for backwards compatibility but moving forward I
think it would be better not to mix errors with tx complete events, so
perhaps we can add something like a socket option that dissociates the
error queue from tx completion queue.

> - Better name in sof_timestamping_names
>
> - I decided to keep using sockcm_init(), to avoid open coding READ_ONCE
>   and since it's passed to sock_cmsg_send() which anyway also may init
>   such fields.
>
> v3:
> - Add new COMPLETION timestamp type, and emit it in HCI completion.
> - Emit SND instead of SCHED, when sending to driver.
> - Do not emit SCHED timestamps.
> - Don't safeguard tx_q length explicitly. Now that hci_sched_acl_blk()
>   is no more, the scheduler flow control is guaranteed to keep it
>   bounded.
> - Fix L2CAP stream sockets to use the bytestream timestamp conventions.
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> The packet flow in Bluetooth is the following. Timestamps added here
> indicated:
>
> user sendmsg() generates skbs
> |
> * skb waits in net/bluetooth queue for a free HW packet slot
> |
> * orphan skb, send to driver -> TSTAMP_SND
> |
> * driver: send packet data to transport (eg. USB)
> |
> * wait for transport completion
> |
> * driver: transport tx completion, free skb (some do this immediately)
> |
> * packet waits in HW side queue
> |
> * HCI report for packet completion -> TSTAMP_COMPLETION (for non-SCO)
>
> In addition, we may want to do the following in future (but not
> implemented in this series as we don't have ISO sequence number
> synchronization yet which is needed first, moreover e.g. Intel
> controllers return only zeros in timestamps):
>
> * if packet is ISO, send HCI LE Read ISO TX Sync
> |
> * HCI response -> hardware TSTAMP_SND for the packet the response
>   corresponds to if it was waiting for one, might not be possible
>   to get a tstamp for every packet
>
> Bluetooth does not have tx timestamps in the completion reports from
> hardware, and only for ISO packets there are HCI commands in
> specification for querying timestamps afterward.
>
> The drivers do not provide ways to get timestamps either, I'm also not
> aware if some devices would have vendor-specific commands to get them.
>
> Driver-side timestamps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Generating SND on driver side may be slightly more accurate, but that
> requires changing the BT driver API to not orphan skbs first.  In theory
> this probably won't cause problems, but it is not done in this patchset.
>
> For some of the drivers it won't gain much. E.g. btusb immediately
> submits the URB, so if one would emit SND just before submit (as
> drivers/net/usb/usbnet.c does), it is essentially identical to emitting
> before sending to driver.  btintel_pcie looks like it does synchronous
> send, so looks the same.  hci_serdev has internal queue, iiuc flushing
> as fast as data can be transferred, but it shouldn't be waiting for
> hardware slots due to HCI flow control.
>
> Unless HW buffers are full, packets mostly wait on the HW side.  E.g.
> with btusb (non-SCO) median time from sendmsg() to URB generation is
> ~0.1 ms, to USB completion ~0.5 ms, and HCI completion report at ~5 ms.
>
> The exception is SCO, for which HCI flow control is disabled, so they do
> not get completion events so it's possible to build up queues inside the
> driver. For SCO, COMPLETION needs to be generated from driver side, eg.
> for btusb maybe at URB completion.  This could be useful for SCO PCM
> modes (but which are more or less obsolete nowadays), where USB isoc
> data rate matches audio data rate, so queues on USB side may build up.
>
> Use cases
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In audio use cases we want to track and avoid queues building up, to
> control latency, especially in cases like ISO where the controller has a
> fixed schedule that the sending application must match.  E.g.
> application can aim to keep 1 packet in HW queue, so it has 2*7.5ms of
> slack for being woken up too late.
>
> Applications can use SND & COMPLETION timestamps to track in-kernel and
> in-HW packet queues separately.  This can matter for ISO, where the
> specification allows HW to use the timings when it gets packets to
> determine what packets are synchronized together. Applications can use
> SND to track that.
>
> Tests
> =3D=3D=3D=3D=3D
>
> See
> https://lore.kernel.org/linux-bluetooth/cover.1739026302.git.pav@iki.fi/
>
> Pauli Virtanen (5):
>   net-timestamp: COMPLETION timestamp on packet tx completion
>   Bluetooth: add support for skb TX SND/COMPLETION timestamping
>   Bluetooth: ISO: add TX timestamping
>   Bluetooth: L2CAP: add TX timestamping
>   Bluetooth: SCO: add TX timestamping socket-level mechanism
>
>  Documentation/networking/timestamping.rst |   9 ++
>  include/net/bluetooth/bluetooth.h         |   1 +
>  include/net/bluetooth/hci_core.h          |  13 +++
>  include/net/bluetooth/l2cap.h             |   3 +-
>  include/uapi/linux/errqueue.h             |   1 +
>  include/uapi/linux/net_tstamp.h           |   6 +-
>  net/bluetooth/6lowpan.c                   |   2 +-
>  net/bluetooth/hci_conn.c                  | 118 ++++++++++++++++++++++
>  net/bluetooth/hci_core.c                  |  17 +++-
>  net/bluetooth/hci_event.c                 |   4 +
>  net/bluetooth/iso.c                       |  24 ++++-
>  net/bluetooth/l2cap_core.c                |  41 +++++++-
>  net/bluetooth/l2cap_sock.c                |  15 ++-
>  net/bluetooth/sco.c                       |  19 +++-
>  net/bluetooth/smp.c                       |   2 +-
>  net/core/sock.c                           |   2 +
>  net/ethtool/common.c                      |   1 +
>  17 files changed, 258 insertions(+), 20 deletions(-)
>
> --
> 2.48.1
>


--=20
Luiz Augusto von Dentz

