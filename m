Return-Path: <netdev+bounces-243750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5BFCA6F03
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8158D319B585
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAD33F368;
	Fri,  5 Dec 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="oMKInCI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9C3043CE
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921269; cv=none; b=hBT6bClNAAjNZJGAutI0o1dRa5ybW/iqXAJauRG6PDMsxCE7Ua2q4smy3HsJxjs9uLajer0tpBwpcuZFBM1IIyu8fy9pQb4t8vUPSGFNfWZkSoEEEz3ppmw/fxJjiwTmUGxKBz3fl+eMcw0c+PLW4oq/nKmqBVvtmN0uEj6JYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921269; c=relaxed/simple;
	bh=WLTH2VOXxo9q3jUt+Fcs/KgDVU5UxTeBr7VyXD9982U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQVZR922iiRmngp5irqvt3HWGCd8zqsVVUPQD3CUuctW6g/M3oWb41gABfA1V/ChxuaugAqRsO1Y5pcGtUWTZV086zuYiRDx53qXLFTx/HV+WOQcg2tlcXFq81GKEFbE7Dn5AP+tVnDn7AVbXTL/WKUhNR1BM7W9HUzZlGYIZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=oMKInCI0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AB132401BB
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764921246;
	bh=/r0s+rYdqQo7mGeZduOw4SJ+2zXsvt5fSdkb0prY1SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=oMKInCI0twD/6nxZrdVt8U2PGdo9EHtuWThUWJ4h9dGRDTEYWIIWC9c/xKWfMODBk
	 p7lZaGREDKEjAoLSY8vbPCjJyUyE7EEh/qBv3VFqVuZANRliFol9Er3x6wi6sdsaNI
	 Qr3ZeyPgEkVmw3mthP0t3DqCpKmtTinRYx5JwiAOKjYrdohhRLHSVZ+xaRotXQiPjs
	 lrDOLbFgexDL72bAdPeapfRzbXv0vcYCqTdEJoHBcTfhzQ88D3l0k+tJFtE8cwPR3Q
	 0jr7lDux2jK+u+2AMmbD5Xi9DqXJt6t0lZ354d15pGYsPTAf0taRdf+DvtWOtGvLjO
	 OwcscAJ9l1rBE8NouESZNeA7SvwW58kVt6xsWAoo/8W/ZNTucWoXz4PnsGOLn97Y4i
	 tBDM3aQmkOdj6j6zLsznYzEftpaHmeZh6EndVNyFMagGabpgor4KmmZnu/llNW3nNm
	 0OC6KrFcv4eebZ3lf53u3Yi1mQlSwwv8bxZHb77UF/CsLZKF8DkoMWSk68GsWCXVNh
	 VIq2OGocTMLSnWEVnS7tU5WymZH88if/Fa1mff+wuVtLoFfe910fNqfMAWVQALvvLR
	 oXcctO7ppRcIgQEK+DvLiTsCYQVM6iRc6dHV/ttBleimx76WRpOdHs2lisLYGKMoFh
	 AC+dDZZStU5Z6B3qzymTOsMY=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so2265840a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 23:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764921244; x=1765526044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/r0s+rYdqQo7mGeZduOw4SJ+2zXsvt5fSdkb0prY1SE=;
        b=rfLxKghdQl4+HAHkBdx5II4RVDR/V1W8GNuZGKSmVXxKNh5DKvb+EHmZiNfN9un3YZ
         9yqwFcYVq97EQlOEAH4emQDUGzafb8A/QwrgruNW1q4rQNdPTu1jDL6hmyxBigiqJ+4C
         IdB/FVCXQLTT1Zt60TM/eBejmbDYf0swKw0Hapu5VBl4rHiqsrUN5X9DC9hbJTrlLJRC
         2niKHVyxa5CH95IGmisZRlv+nn4gYyLPw/3RJh8pWzBw9+/MgicrRu511F49/XoWhdGu
         q7NqUkP5CzJ6qvrwTdf1rxznuH201MhwAbs3almTL82UzRBbhhyozQWtdFAThc+CgkIa
         NK+A==
X-Forwarded-Encrypted: i=1; AJvYcCWw6q/bNfQTvWm7VhVKEzJzZNgANP8h4uwMpJsdJ7wj1dHWLmJDzbu7e2snGe3UGxRGjAkjrGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vCBApap1oKKEsnG//7n8Vr5vofvVI3wLnmAkH9NUYR+RLCtH
	9A12+mnpHsCzvWO1DNw7MBq59dexeO4SXA5TF+f7qkoF+7reJcaBp1ewHg9ELKgRKScEXmdeWsk
	wGSm37Fa5QO3qKiZ8iHsODKT4FOE2aL2cp8eqTN0gc23onia64+VI2yVV6VJ5/t0C2TsB/rj3f5
	ZAGtusK/DUBNjF0+31/YiykF8V7MagQkyBQtWntifJJIi3WXrF
X-Gm-Gg: ASbGncv+h/kA1zC9iO/xTpJtamUFtx9w/B03dIpKsyGdIuYw1wuoZcJRE1iBlF8tuch
	3dBeedVgqcYfsewyz+YRuIhX9KQsUR8TwJL9heHSMmS/UEO9z82uCmJIk6puprTd2DForn1JCpB
	xKRQyUdV26dz9Kk7DrJpTIvkMqTV6jgm8raU3ns4XoJhXwgsuvuhwix6O3fvDMGatKekg=
X-Received: by 2002:a05:7023:b86:b0:11b:9386:8267 with SMTP id a92af1059eb24-11df0c5d7damr6902605c88.44.1764921244233;
        Thu, 04 Dec 2025 23:54:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0bKWGPVEBaGnmged0Li+pevKQJOkARye81sjIdsiVqXgdVqxXielqaFJpZQn5KkKDDawI3D3vPE/riGkVSXI=
X-Received: by 2002:a05:7023:b86:b0:11b:9386:8267 with SMTP id
 a92af1059eb24-11df0c5d7damr6902593c88.44.1764921243745; Thu, 04 Dec 2025
 23:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205023757.1541228-1-aaron.ma@canonical.com> <IA3PR11MB8986E3F5CD6666035875A112E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986E3F5CD6666035875A112E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Fri, 5 Dec 2025 15:53:52 +0800
X-Gm-Features: AWmQ_bmV6dFfCPiqIyrVaQaM9KJbLan39ewKlCxCpB8YbmdAE4Ikl1BwMhMTgk8
Message-ID: <CAJ6xRxV41ijkGmQycdiK4Miu8sQGvo3sQt17azCqZFJOQv5fVQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 1/2] ice: Fix NULL pointer dereference
 in ice_vsi_set_napi_queues
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 3:13=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Aaron Ma
> > Sent: Friday, December 5, 2025 3:38 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH 1/2] ice: Fix NULL pointer
> > dereference in ice_vsi_set_napi_queues
> >
> > Add NULL pointer checks in ice_vsi_set_napi_queues() to prevent
> > crashes during resume from suspend when rings[q_idx]->q_vector is
> > NULL.
> >
> > <1>[  231.443607] BUG: kernel NULL pointer dereference, address:
> > 0000000000000040 <1>[  231.444052] #PF: supervisor read access in
> > kernel mode <1>[  231.444484] #PF: error_code(0x0000) - not-present
> > page <6>[  231.444913] PGD 0 P4D 0 <4>[  231.445342] Oops: Oops: 0000
> > [#1] SMP NOPTI <4>[  231.446635] RIP:
> > 0010:netif_queue_set_napi+0xa/0x170
> > <4>[  231.447067] Code: 31 f6 31 ff c3 cc cc cc cc 0f 1f 80 00 00 00
> > 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48
> > 85 c9 74 0b <48> 83 79 30 00 0f 84 39 01 00 00 55 41 89 d1 49 89 f8 89
> > f2 48 89 <4>[  231.447513] RSP: 0018:ffffcc780fc078c0 EFLAGS: 00010202
> > <4>[  231.447961] RAX: ffff8b848ca30400 RBX: ffff8b848caf2028 RCX:
> > 0000000000000010 <4>[  231.448443] RDX: 0000000000000000 RSI:
> > 0000000000000000 RDI: ffff8b848dbd4000 <4>[  231.448896] RBP:
> > ffffcc780fc078e8 R08: 0000000000000000 R09: 0000000000000000 <4>[
> > 231.449345] R10: 0000000000000000 R11: 0000000000000000 R12:
> > 0000000000000001 <4>[  231.449817] R13: ffff8b848dbd4000 R14:
> > ffff8b84833390c8 R15: 0000000000000000 <4>[  231.450265] FS:
> > 00007c7b29e9d740(0000) GS:ffff8b8c068e2000(0000)
> > knlGS:0000000000000000 <4>[  231.450715] CS:  0010 DS: 0000 ES: 0000
> > CR0: 0000000080050033 <4>[  231.451179] CR2: 0000000000000040 CR3:
> > 000000030626f004 CR4: 0000000000f72ef0 <4>[  231.451629] PKRU:
> > 55555554 <4>[  231.452076] Call Trace:
> > <4>[  231.452549]  <TASK>
> > <4>[  231.452996]  ? ice_vsi_set_napi_queues+0x4d/0x110 [ice] <4>[
> > 231.453482]  ice_resume+0xfd/0x220 [ice] <4>[  231.453977]  ?
> > __pfx_pci_pm_resume+0x10/0x10 <4>[  231.454425]
> > pci_pm_resume+0x8c/0x140 <4>[  231.454872]  ?
> > __pfx_pci_pm_resume+0x10/0x10 <4>[  231.455347]
> > dpm_run_callback+0x5f/0x160 <4>[  231.455796]  ?
> > dpm_wait_for_superior+0x107/0x170 <4>[  231.456244]
> > device_resume+0x177/0x270 <4>[  231.456708]  dpm_resume+0x209/0x2f0
> > <4>[  231.457151]  dpm_resume_end+0x15/0x30 <4>[  231.457596]
> > suspend_devices_and_enter+0x1da/0x2b0
> > <4>[  231.458054]  enter_state+0x10e/0x570
> >
> > Add defensive checks for both the ring pointer and its q_vector before
> > dereferencing, allowing the system to resume successfully even when
> > q_vectors are unmapped.
> >
>
> Please add minimal test system details alongside the call trace:
>   - Adapter model (E810/E822... PF/VF? SR-IOV state)

Adapter model:
60:00.0 Ethernet controller [0200]: Intel Corporation Ethernet
Controller E810-XXV for SFP [8086:159b] (rev 02)
       Subsystem: Intel Corporation Ethernet Network Adapter
E810-XXV-2 [8086:4003]

Both disabled and enabled SR-IOV can reproduce the issue.

>   - Kernel version (and whether net-next or stable backport)

Tested kernel version: upstream 6.18.

>   - Repro steps (S3 sequence, timing, if NAPI ops are called during resum=
e)

Bootup and execute suspend like systemctl suspend or rtcwake.

Should I send a v2?

Thanks for your review.
Aaron

> It helps validate the fix for NAPI queue-to-IRQ mapping on various platfo=
rms.
>
> > Fixes: 2a5dc090b92cf ("ice: move netif_queue_set_napi to rtnl-
> > protected sections")
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 15621707fbf81..9d1178bde4495 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -2779,11 +2779,13 @@ void ice_vsi_set_napi_queues(struct ice_vsi
> > *vsi)
> >
> >       ASSERT_RTNL();
> >       ice_for_each_rxq(vsi, q_idx)
> > -             netif_queue_set_napi(netdev, q_idx,
> > NETDEV_QUEUE_TYPE_RX,
> > +             if (vsi->rx_rings[q_idx] && vsi->rx_rings[q_idx]-
> > >q_vector)
> > +                     netif_queue_set_napi(netdev, q_idx,
> > NETDEV_QUEUE_TYPE_RX,
> >                                    &vsi->rx_rings[q_idx]->q_vector-
> > >napi);
> >
> >       ice_for_each_txq(vsi, q_idx)
> > -             netif_queue_set_napi(netdev, q_idx,
> > NETDEV_QUEUE_TYPE_TX,
> > +             if (vsi->tx_rings[q_idx] && vsi->tx_rings[q_idx]-
> > >q_vector)
> > +                     netif_queue_set_napi(netdev, q_idx,
> > NETDEV_QUEUE_TYPE_TX,
> >                                    &vsi->tx_rings[q_idx]->q_vector-
> > >napi);
> >       /* Also set the interrupt number for the NAPI */
> >       ice_for_each_q_vector(vsi, v_idx) {
> > --
> > 2.43.0
>

