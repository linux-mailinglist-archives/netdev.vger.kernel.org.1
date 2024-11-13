Return-Path: <netdev+bounces-144302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2909C680C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831B9B2480F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 04:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721615CD58;
	Wed, 13 Nov 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CoGLsQ6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870D230984
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472033; cv=none; b=ZJdeyTEEPkY1zgeGcjWdWRaC3JKY/ra73hCQ0vuPjYxVpJ7V0y82dTBxhWWNPW8cmEBu2a+/rh8lcojyXS+UfgUT15a3Z/f59mZfsijRDMA4Z7TYZMmgIj9NfXGlgKX0PzzOrLPYU+9Wd8SkgrPdQzFwEq/WMr2td07LB2mpkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472033; c=relaxed/simple;
	bh=1ME7PDPqd3491CNKzMBYktquuZVHUC0mAsyPaon0wiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZSQCnAsZdOdIUVlbUYqeOyR3Grf9BG6JK4vfVS9e8LWjLUXVEGfEhPbJLkKdEOszPALHvSt4HCBOxU5mXBJY9smRxkf5QMR8P9rYmhHk2LM+TgCC6y4+gWidp+D5LVe/PcPVJ/hiIPCXa+2I+thMeogZDfTDiBsQ6dPVxIgIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CoGLsQ6y; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e64ed090so8e87.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 20:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731472029; x=1732076829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QThO7EgtQuVWhNQW/XWzM7RwCcNoGRfMt97x7tFusKY=;
        b=CoGLsQ6yKvJt/HwB/jyKHnfMT2Ls7HRKCkHkXNq8VgQ6PTX0GpQc8SUU2kann2vFJ/
         2kfsCvgB/7x5qNT7SSHWk42pRyL2M3YUdL/A0NhBWmW3+S8tGrxn33flF79iWZ5hEWUd
         YLjJpaGMjMbVU1V/3zzpEa25+0J7myRHq1Bvn0C9j1UlUyZHFhh8Nx22RuaRT+oXyy+o
         yT9zD0lt/OuXh2nbTvJulaSjM/Dyy/yZRygo6cTFRo4JuPOXq6CW51neF2TtLm9prGBm
         1KtBTCRV/3V2hxfrvueUTcW/Kck3MVeQwcrfijc08TUSSH2cNF7YlcgvBqDlTn/+uBmY
         /Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731472029; x=1732076829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QThO7EgtQuVWhNQW/XWzM7RwCcNoGRfMt97x7tFusKY=;
        b=nepzd9dpj7SPcB09ixMDZICIujffQz0xPShxPoWbh960re0otX2iiK/i+ls+cdL6Fl
         SStQXSynD+Kwu4+yuG7CUqtM8WcHfPiZf/dIQYderS/34RkJXiX9haV47vavj+e/0WzP
         xQanqG7cGHeNH4WegWxaS0R85ZFwNU+QWVl59nrQKScvREKCgy7y6ADO1QAaeGYlpt6T
         QW1w4qYvCUdl90630zNzASiE5vAj2+7d9UG8T2dPxihfwW1ncp0pRBp+VFblZx6nDrd3
         g0Y5NGZzot+9Ca1splyW3y9m85g4eeI14dQab0E2VNiaFFuPhxgCWtHuZW92qV6bkZp9
         TcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrtvkeRsVtENX9/ASkS17cTD1RK2moYy0/ZkEPzuoPlvdnoDHH3/5tRuMhl0MOP19opweyc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Wpp1klaI1sD48s+ERhjRzurEsA8XImMXraS6wMawxB1Nht4I
	u9MFXkieI6SeIwiNPdjKV/Wlnj1utRP9YvJc4WYivLsEX5WsO5TPUA8fTFBv9k+FrfiACbGmgSH
	n1tiK1xoOjrP+IO3aR+779HdGB/FABg++nwUq
X-Gm-Gg: ASbGncvemc0nOI7jh/aRUSZdk+dxcs/jY/P4MRDoXmd8W7niI1hviyqiBsZfkFhPN3C
	iZw8WsTtD7CIFb46Hmxs0Op0VydjRH/uqSmo31nSSR6u4IPB7grcFlr6RTnuCly5b
X-Google-Smtp-Source: AGHT+IHAzsO794M5B2GmbH1Xmxi9JkvYY0pGB0Ri1pDCwCrUp9RX5DK3Gb2pxzi/RfQC28jvJE11YK5xTt5ZPqsU8U4=
X-Received: by 2002:a05:6512:54d:b0:535:60b1:ffc2 with SMTP id
 2adb3069b0e04-53da06d8699mr2895e87.0.1731472028396; Tue, 12 Nov 2024 20:27:08
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110081953.121682-1-yuyanghuang@google.com>
 <ZzMlvCA4e3YhYTPn@fedora> <b47b1895-76b9-42bc-af29-e54a20d71a52@lunn.ch>
 <CADXeF1HMvDnKNSNCh1ULsspC+gR+S0eTE40MRhA+OH16zJKM6A@mail.gmail.com> <ce2359c3-a6eb-4ef3-b2cf-321c5c282fab@lunn.ch>
In-Reply-To: <ce2359c3-a6eb-4ef3-b2cf-321c5c282fab@lunn.ch>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 13 Nov 2024 13:26:29 +0900
Message-ID: <CADXeF1FYoXTixLFFhESDkCo2HXG3JAzzdMCfkFrr2dqmRVQcWg@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, 
	jiri@resnulli.us, stephen@networkplumber.org, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>O.K. WiFi is not my area. But i'm more interested in uAPIs, and
> ensuring you are not adding APIs which promote kernel bypass.

WiFi chipset vendors must implement the Android WiFi HAL to install
and read the APF program from WiFi firmware. The Android System Server
will talk to vendor HAL service using the WiFi HAL. The datapath is:
Network Stack process -> Android System Server -> vendor HAL service
-> WiFi driver -> WiFi firmware. The Android WiFi HAL is specific to
Android. The vendor HAL service, WiFi driver and WiFi firmware are all
vendor proprietary software.  In other words, those API are not in
mainline yet.

Feel free to referring to the following page for more details:
* APF public doc:
https://source.android.com/docs/core/connect/android-packet-filter
* APF interpreter:
https://cs.android.com/android/platform/superproject/main/+/main:hardware/g=
oogle/apf/v6/
* APF program generator:
https://cs.android.com/android/platform/superproject/main/+/main:packages/m=
odules/NetworkStack/src/android/net/apf/ApfFilter.java
* APF WiFi HAL:
https://cs.android.com/android/platform/superproject/main/+/main:hardware/i=
nterfaces/wifi/aidl/aidl_api/android.hardware.wifi/2/android/hardware/wifi/=
IWifiStaIface.aidl;l=3D50?q=3DinstallApfPacketFilter

>Is the API to pass this bytestream to the wifi chipset in mainline?

Currently, these APIs are only in Android HAL, which is not in
mainline. We are working on adding proper APF APIs into ethtool.
Please some previous discussion here:
https://lore.kernel.org/netdev/20240813223325.3522113-1-maze@google.com/T/

>And how does APF differ from BPF? Or P4? Why would we want APF when
>mainline has BPF?

Android has utilized APF on Pixel devices since approximately 2016
(potentially as early as Pixel 3). All new devices launching with
Android 14/U+ are required to implement APFv4 on their WiFi client/STA
interface, enforced through Android VTS. APFv6 introduces support for
reply sending (e.g., ARP offload). This version is planned to be a
requirement for new devices launching with Android 16/W (or its
eventual successor), extending to wired interfaces as well.

APF is distinct from eBPF due to the latter's complexity and larger
memory footprint.  Many low-end WiFi chipsets lack sufficient RAM in
firmware to accommodate eBPF. In contrast, the latest APFv6
interpreter requires only ~5kB of compiled code and ~2kB of bytecode
(4kB recommended). Even this minimal size presents integration
challenges for some WiFi chipset vendors.

In sum, eBPF bytecode is very space inefficient compared to APF.

We have collaborated with major WiFi chipset vendors (Broadcom,
Synaptics, Qualcomm, Mediatek etc.) across various device categories
(phones, watches, tablets, TV etc.). To my knowledge, none have
integrated eBPF or P4 into their chipsets. Instead, they have either
implemented vendor-specific offload solutions or adopted APF. One of
APF's goals is to defrag the hardware offloading within the Android
ecosystem.

Moving the APF program generator into kernel space would eliminate the
need for generating the program in userspace. Ideally, future Linux
APIs would directly interact with drivers to manage offloads and APF
loading. The kernel could even be responsible for building the APF
bytecode, resolving race conditions caused by fetching kernel state
for bytecode generation.  A BPF program could potentially build the
APF bytecode during suspend.

However, this is a long-term goal requiring significant design and
discussion with the upstream Linux community. In the short term, APF
program generation will remain in user space.

>Do the new netlink message make sense without APF? Can i write a user
>space IGMP snooping implementation and then call bridge mdb
>add/del/replace?

The RTM_NEWMULTICAST and RTM_DELMULTICAST events introduced in this
patch enable user space implementation of IGMP/MLD offloading and
IPv4/IPv6 multicast filtering. I have limited knowledge on how to
implement IGMP snooping correctly so I don't know if they are
sufficient.

These two events have broader applications beyond APF. Any user space
implementation of IGMP/MLD offloading requires kernel events to signal
when a multicast address is added or removed. In fact, in the original
attempt of this patch from "Patrick Ruddy", the commit message also
mentioned about "having userspace applications to program multicast
MAC filters in hardware". Which makes me believe APF won't be the only
potential use case. Please check the following thread for more
details:  https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.at=
t-mail.com

>Assuming i can, why are the WiFi card not using that API, same a switches =
do?

I'm unsure if I understand your suggestion to use
RTM_NEWMDB/RTM_DELMDB/RTNLGRP_MDB. Currently, the kernel doesn't send
these events outside the bridge context.
Previous patches attempted to reuse these events, but reviewers raised
concerns about potential confusion for existing users.  IMHO, I agree
with the reviewer that re-using the RTM_NEWMDB/RTM_DELMDB/RTNLGRP_MDB
might be confusing and might affect the current applications that use
those events. Those events seem to make more sense from a bridge
perspective. Our use cases are targeting the end device which is not a
bridge or router.

It might also make sense to consider whether to accept the proposed
APIs from an API completeness perspective. The current netlink API for
multicast addresses seems incomplete. While RTM_GETMULTICAST exists,
it only supports IPv6, not IPv4. This limitation forces tools like 'ip
maddr' to rely on parsing procfs instead of using netlink.
Additionally, 'ip monitor' cannot track multicast address additions or
removals. I feel it would make sense to have full netlink based
dumping and event notification support for both IPv4/IPv6 multicast
addresses as well.

Thanks,
Yuyang



On Wed, Nov 13, 2024 at 10:17=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Wed, Nov 13, 2024 at 09:56:17AM +0900, Yuyang Huang wrote:
> > > Please could you say more about programming hardware offload filters?
> > > How is this done?
> >
> > Sure,  please let me explain a little bit further on how Android
> > Packet Filter (APF) works here.
> >
> > The Android Packet Filter (APF) has two parts:
> > * APF Interpreter: Runs on the Wi-Fi chipset and executes APF
> > programs(bytecodes) to decide whether to accept, drop, or reply to
> > incoming packets.
>
> O.K. WiFi is not my area. But i'm more interested in uAPIs, and
> ensuring you are not adding APIs which promote kernel bypass.
>
> Is the API to pass this bytestream to the wifi chipset in mainline?
> And how does APF differ from BPF? Or P4? Why would we want APF when
> mainline has BPF?
>
> Do the new netlink message make sense without APF? Can i write a user
> space IGMP snooping implementation and then call bridge mdb
> add/del/replace? Assuming i can, why are the WiFi card not using that
> API, same a switches do?
>
>         Andrew

