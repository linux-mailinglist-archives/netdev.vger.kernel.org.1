Return-Path: <netdev+bounces-167933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE0A3CE31
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 01:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EF5170DFF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160E735971;
	Thu, 20 Feb 2025 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpfccCEL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E08488;
	Thu, 20 Feb 2025 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012201; cv=none; b=hDma9BPdeXnA2bWziHdsUOEEFc8A/Kb2lvVIUq2mPKfZI1ZrUMpJ/CNF1pD2o4SEnn+S6uGf5UaGjhQrUvdApGVrwSTcaCfw1ZlhjncBtJylAFZuA90FBQsAOrkulNA7vjLTyu9QdiinHC0YiI2RtU5d9TgjjfTLKYkiMmoqTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012201; c=relaxed/simple;
	bh=LnNnL6cWPbx1mluWUGMsWrhdILcy8oFeYGlWjm+wPO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ksxx6U3rcWeI00cY7fHxjWoN7Gj2bIaEgNb1cLxUH2M8xEs++IehqkjNZ72LmuiPNavFcYgqS6W2U4QJ1Hf2zDo824osmsI51yNMpl7wo85dvunOvd6vpsgUVhfaOtcs2g5gp/6gfGMizA1OcCvxfSwwwIfklZqQ7aO9rahZy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpfccCEL; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-855b2a5ad32so10806439f.1;
        Wed, 19 Feb 2025 16:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740012198; x=1740616998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqFJieXrPemEvMeVPQU3GiCT2IHDLm0dJ72plT/ng0I=;
        b=VpfccCELcmXMFgh9wkqQxvBu9TdDMrHFEme2MUeBQambBzlmZ0dIzcQtxt1eGMb3T5
         uX/X3ETypU5VRa6J+0rw3wcGy4aJ9xDHyUPNJUyPDkTE14sgZeN5mv8F74wI0Ldwv9xK
         b0Dx/gXLX5CMPIsvT9sSFRw38oghspRopqQ0xzduHVxYp6ldkehbsuglnBNxGbAl1u8A
         7EsGaREv9fQjcim9g/d6zykpcqTHUZO0AMpfRq+f1UlwIgUDSM5PzcxtW33+sUQ05w5h
         Vrk2/J6+p14INEW5252j9LANvFfDW6fVP6ZFxbJUSHhYiP4QaxPB0OFKKLXKvQSs6w/S
         0K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740012198; x=1740616998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqFJieXrPemEvMeVPQU3GiCT2IHDLm0dJ72plT/ng0I=;
        b=CpBYSG36o52I3LeQ9ZTb0re4Ke41UZeTJi3mBo9QJIimJtsQQNAh17Qkw0IfBmnW/h
         98R1cWbPnrDFSiWc+vJa9hlhl7KdbdYUJqMFsNW69VoPLGlPB1fPnqBeXA3g2yNm2Z2N
         YAxeb7lE++dVoJnmRuW+s2Hl9udVBnBzT6YdaCdecK5jiOvWSdO3GZWcYv1NGtC/ieaW
         Aa/lmiCSvrgNM1o4lJClqx8gTbZ40/MuC8U9A6NIXvC7WzK6BTYeSdOq5Bp+Zfs0DoBw
         e/ObUZ9+iLuMTKcMakcE4jCsFgXVEpjEuRJO7s3BgFhEnHMplObeoKlOCXF+1kpLSpkm
         ACoA==
X-Forwarded-Encrypted: i=1; AJvYcCWjIbk4dBQZHigrmGkMoerr6D0ml77OzoH0GT1tH3J4/BBkGCVcMru4j8vXb8CFuz+6hFxC7Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8Mv3jq0ldS93yGM9GDm4UjtcwQ77q70FImJ+MyIGJbViQIWR
	gWym+sHFI6FdB3LTEylFDdgj+SCliWOeULCahOvBMboK8TUitZJwiJUehQZKXUnDgnwR4g0EDlh
	1KP6pWIZWKBnTvAZcCSauZ1DIhQA6PFc3iJJ7bjvS
X-Gm-Gg: ASbGnctEIT1elhmii5U0ytksHmMVCny7rRCp8RwQmPU6C2LXPoBj8wll1x3/NzkbZhz
	iEF1Typqz1157p/pl3X4XboAsvUpJuA94BsXfIpQD6eKYF+PQ7HO8kw0T1+OlG9SPr6+gJaK6
X-Google-Smtp-Source: AGHT+IEQx7PVpkWM3fihu44oDzSz4H805pjBv7+MfxdqjLp4kZO0rHbmtFOMF9i/3zQW3MVpiqwttZ9r2dFFKt1mYio=
X-Received: by 2002:a05:6e02:2405:b0:3d1:9236:ca50 with SMTP id
 e9e14a558f8ab-3d2b51058fdmr58553595ab.0.1740012198212; Wed, 19 Feb 2025
 16:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739988644.git.pav@iki.fi>
In-Reply-To: <cover.1739988644.git.pav@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 08:42:42 +0800
X-Gm-Features: AWEUYZl4vRVSc65W5ltrVKuTANOd3eo6AfOMYq79SakSLAPUZ5Z8gB1HuK8Ypwg
Message-ID: <CAL+tcoAAj0p=4h+MBYaN0v-mKQLNau43Av7crF7CVXFEnVL=LQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
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
>
> - Better name in sof_timestamping_names
>
> - I decided to keep using sockcm_init(), to avoid open coding READ_ONCE
>   and since it's passed to sock_cmsg_send() which anyway also may init
>   such fields.

Please don't do this since the current sockcm_init() initializes more
than you need. Please take a look at what the new sockcm_init looks
like and what this series has done[1] which just got merged in recent
days :)

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3Daefd232de5eb2e7

Thanks,
Jason

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
>

