Return-Path: <netdev+bounces-172421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20828A54876
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CAC77A3A01
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEC202C56;
	Thu,  6 Mar 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg2VhGii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBA1A76BC
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258477; cv=none; b=oqIVjE4umeXp6egi/YwpI/PR90cgyRLmPXpBNLEi8i62zj0rKH54C+NZ96329DJZWIhsUMFVRzhSq5nbzAJixRj8i8Jz2Nh/IiLGkOxc0FTsMW+IVHAphaJiUNEsmsGn4zbRoxZZNyKKi9O0eVvGQ4w8gCDOoWv2Ndf7R23iQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258477; c=relaxed/simple;
	bh=DTXEqHRsUv7IuY3EGwfy8QvHIz/IJAu6F5Yuo1zJ9og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K79ypXMoUdFKplMquc4WdJTfIR6oeVQ7KixtzCv6ojW0I9BZw7S4zfY4RwnVBDoFmb7Zgiu1erppE/j1PH7t1l5BwVOJz1WmLfKa3ZmZmcuSGVdfx4rr19TDiJ9N5m9jV0DvtmRt/DpftywopErNr19c1rTrMcKz16ZIhd8Ygo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg2VhGii; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso946834a12.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741258474; x=1741863274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pjfn8yDfqOIVmY+I84TFADLHMjbAadZWj3wyHrkso50=;
        b=Xg2VhGiizOR/SFdCBTpEpz03YAKGMvEHMSu/lJiZ3ShXOlhtsYmuFCLB2PK/etpggP
         vg6EGZ7YPIOlI+uQlgFYjbz5AMG9f2Y1ifkvPnV6YZ0A/usTS2MRRzcernAlMfLW2yqT
         QHgc/CtoyTJ9pOZIubvYnXExsk+qbl549JzJPvc7gv6tHOZDvO/CIo7L3j7F/uDeBtRN
         g/Qd01doX2ahJjLgS+1UKSUTiNpc2XGfF8v0nC3bVofbAn7ee4IueOBxkGRlflVOtPFu
         +Y9Un0d5yyvqaUGy9kNozUmSufcS7Zds0qfbbln+Q4z3iIDqfATFqTIjJp1BmY4mMhN/
         HrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258474; x=1741863274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pjfn8yDfqOIVmY+I84TFADLHMjbAadZWj3wyHrkso50=;
        b=kXs/H8VH4V5gk4LkGFfNuBkjpUeQbi1r+nCUFLbu2/i9zr0QPN3ciAN/cMFJvIqbJY
         4nuXaTnlYhlT29yN6yzxItLz2/VD170s9WRXpi0xis0r1OTDsrgJi9dteajud4nt7Mgt
         JRWNj85zPN1FqfeC+MguXsQKUyx/1yarvxmsODx6C+7pE35TIjlv2Hv7Yiju99Svl2qr
         Q6VOnfAxlhHs7XpTrrWPVD0EyrjXMUjlPM7hGEXVIjjzX/hk2hf8vbEUbeqOFTduRS+j
         d3zvqtUvzjVP/tkTqHYP16T37y864HhMDfoQuvf4YOHOWgKE/zApSU2X70goURCXEoZ9
         JpXg==
X-Forwarded-Encrypted: i=1; AJvYcCUz6y5SF2zCNzk4sFPMWQwvcRTGkM1LiQqmGcOpsia1oTl1ZXhior7B8ijub+a3CfoAis6WMwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNkIB9f4E5ez4179BuG/50RsIx7++XHXPKEM0Skfbr7r/3R+N
	KQP59B7jqAGSvPW9yZE/C4CVkonf29S6EGoybeBTxIdfKgxxVImBbq3Rctvr+a2VaEvpcHR0A4Y
	MD7xisQtW7qtNn7lRjQYonFsJ0i0=
X-Gm-Gg: ASbGncunvyad+UdMeKQccm6nspa2SVcQQQf0zl7f4uyHwaJqzkefrPlMw2EhMygnKEd
	3deWany1mBVPP5WRnRPeclXkE098VDx+X0V9Unkk+eKo7Y5HHKLUTkh/Pv/ohOf10gW/YzKl2hB
	SCv/ogieEI6zFigxnmY2kzppTb5vFP
X-Google-Smtp-Source: AGHT+IFs1Y7K47JL+uPMO80i5xRb2496qmNQrpIK8qO8RdYeGaXfITUWaAmrKkqKKcSVnG0KfmuQTYIW5LgkhE0rZD0=
X-Received: by 2002:a05:6402:13ce:b0:5e4:a1e8:3f04 with SMTP id
 4fb4d7f45d1cf-5e59f3d47fcmr6148290a12.8.1741258473988; Thu, 06 Mar 2025
 02:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305225215.1567043-1-kuba@kernel.org>
In-Reply-To: <20250305225215.1567043-1-kuba@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 6 Mar 2025 19:54:22 +0900
X-Gm-Features: AQ5f1Jqxn4czFn9uxXE6SHMogeqJxaJB2zJEtMvzo5u_DD4vLL7SLeC7BO14ryU
Message-ID: <CAMArcTWwuQ0F5-oVGVt9j-juqyrVibQObpG1Jvqfjc17CxS7Bg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/10] eth: bnxt: maintain basic pkt/byte
 counters in SW
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>

Hi Jakub,
Thanks a lot for this work!

> Some workloads want to be able to track bandwidth utilization on
> the scale of 10s of msecs. bnxt uses HW stats and async stats
> updates, with update frequency controlled via ethtool -C.
> Updating all HW stats more often than 100 msec is both hard for
> the device and consumes PCIe bandwidth. Switch to maintaining
> basic Rx / Tx packet and byte counters in SW.
>
> Tested with drivers/net/stats.py:
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

I found kernel panic while testing stats.py, it occurs when the
interface is down. If the interface is down, cp_ring is not allocated
but bnxt_get_queue_stats_rx() accesses it without null check.

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 163990067 P4D 163990067 PUD 144363067 PMD 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 1654 Comm: python3 Not tainted 6.14.0-rc1+ #6
da0f9ad0522edf8bf0c96e8453594913017a5fc9
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:bnxt_get_queue_stats_rx+0xf/0x70 [bnxt_en]
Code: c6 87 b5 18 00 00 02 eb a2 66 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 48 8b 87 48 0b 00 00 48 63 f6 <48> 8b
1
RSP: 0018:ffffa95ac3c2b7e0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffffc0650710 RCX: 0000000000000000
RDX: ffffa95ac3c2b858 RSI: 0000000000000000 RDI: ffffa25a1c1e8000
RBP: ffffa259e3947100 R08: 0000000000000004 R09: ffffa259e4a6601c
R10: 0000000000000015 R11: ffffa259e4a66000 R12: 0000000000000000
R13: ffffa95ac3c2b8c0 R14: ffffa25a1c1e8000 R15: 0000000000000000
FS:  00007f0b3ccbf080(0000) GS:ffffa260df600000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000162d5a000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die+0x20/0x70
 ? page_fault_oops+0x15a/0x460
 ? exc_page_fault+0x6e/0x180
 ? asm_exc_page_fault+0x22/0x30
 ? bnxt_get_queue_stats_rx+0xf/0x70 [bnxt_en
3bf73dc1ebebb3ca46ef8948d1fc1a94acbeeba1]
 netdev_nl_stats_by_netdev+0x2b1/0x4e0
 ? xas_load+0x9/0xb0
 ? xas_find+0x183/0x1d0
 ? xa_find+0x8b/0xe0
 netdev_nl_qstats_get_dumpit+0xbf/0x1e0
 genl_dumpit+0x31/0x90
 netlink_dump+0x1a8/0x360

This is not a bug of this series, we can reproduce top of net/net-next
without this series.
Reproduce:
 ip link set $interface down
 ./cli.py --spec netdev.yaml --dump qstats-get
OR
 python ./stats.py

It seems that the driver is supposed to return qstats even if interface
is down. So, I think bnxt driver needs to store the sw_stats when the
interface is down. that may be very similar to the bnxt_get_ring_stats()
and bnxt_get_ring_drv_stats().
What do you think about it?

Thanks a lot!
Taehee Yoo

>
> Manually tested by comparing the ethtool -S stats (which continues
> to show HW stats) with qstats, and total interface stats.
> With and without HW-GRO, and with XDP on / off.
> Stopping and starting the interface also doesn't corrupt the values.
>
> v3:
>  - try to include vlan tag and padding length in the stats
> v2: https://lore.kernel.org/20250228012534.3460918-1-kuba@kernel.org
>  - fix skipping XDP vs the XDP Tx ring handling (Michael)
>  - rename the defines as well as the structs (Przemek)
>  - fix counding frag'ed packets in XDP Tx
> v1: https://lore.kernel.org/20250226211003.2790916-1-kuba@kernel.org
>
> Jakub Kicinski (10):
>   eth: bnxt: use napi_consume_skb()
>   eth: bnxt: don't run xdp programs on fallback traffic
>   eth: bnxt: rename ring_err_stats -> ring_drv_stats
>   eth: bnxt: snapshot driver stats
>   eth: bnxt: don't use ifdef to check for CONFIG_INET in GRO
>   eth: bnxt: consolidate the GRO-but-not-really paths in bnxt_gro_skb()
>   eth: bnxt: extract VLAN info early on
>   eth: bnxt: maintain rx pkt/byte stats in SW
>   eth: bnxt: maintain tx pkt/byte stats in SW
>   eth: bnxt: count xdp xmit packets
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  49 +++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   5 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 272 +++++++++++-------
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  20 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  47 ++-
>  5 files changed, 264 insertions(+), 129 deletions(-)
>
> --
> 2.48.1
>
>

