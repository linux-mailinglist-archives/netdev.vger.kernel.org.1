Return-Path: <netdev+bounces-204040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E8AF88EF
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A953587E39
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6E2797BF;
	Fri,  4 Jul 2025 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k0d2Su75"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CBA27991C
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751613324; cv=none; b=aOXBOR9H7FdQtgTfMoaWdnNwmcmaZzpiy7DWEOolVVCYud1YzShfLsqrB9EcZOVJ4K7AlwG+fSMONZ2hUAlEM7ty9l61lPBrU5ij+jo0pn/H4RlyfdHXrziIms6umdwsBEh2KFoRaMyDFRgF/cO8KusfX0NIHxa3TuaAJJWPWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751613324; c=relaxed/simple;
	bh=PJ17NYzwR8crZVZzpZEmSEDl3INy0gxmFE0naPX67hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBZfdOdGKt7vLwTQUBgiAZa3XbsvSxemcipNpC+RCq7kXDvSYzJvS1DKUal0z4bwcpzorOt5fGpyTmxp6OhmkRRmV3YVy6tXyd0F+7221i+gji7/Zf4qTe5OQk2Eoi0GVvr9PIRt/GDDDvd6mHLtfYjF+C35A2mln1p7psR6AyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k0d2Su75; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 51ED63F921
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751613317;
	bh=eOHKenlUn0WrzTitWPsxik4RxUTJ+cwEPC53JoDl8e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=k0d2Su756ZZWygzdi1eyrA6LEl9naSq5CpdW2S17BSiObLuq6X1LBNl8aBnTqF/Tk
	 oumy/w4cW7hBbHbx0+biaOxdcnXrG8deUOlXEAPG7LoGLwVC7Y4BJ1qkW3cAwM1Anw
	 y+Meh4XwAnJkWaqHl6zbYM6/admUeAkn4cQ1sz6UYWBrynk7P5AWrtc0LLOIGYbeOo
	 OdmOpHbI8f9JVeMuvVbqRElDKTG0h4yTMmBmYjU4f/D1q0CMFqZLHsH0JAmX863F7z
	 UIF4KV0Z9uPc8PxvKjAb4eHQgWAAZELUTC7MgD5wPNxz/JhzS7B8Brsd9ZzhSNfAZl
	 mNHEuCbhgEDnQ==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso378417f8f.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 00:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751613315; x=1752218115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOHKenlUn0WrzTitWPsxik4RxUTJ+cwEPC53JoDl8e8=;
        b=lgzD6T7SpS8jIELg+tZKQaNfv6+mxROyb6dVBPumkZC+hrFxNBW5pPj1htsxHRv3p5
         VXRFxf7Hf+7Ow/dnJGRd0cjCsWonjqGmER7X+Juj+cOYr7defpUfCcr+9bLBUb7NWFaR
         PyjtdfNJcGsPK1RGKfe/Cj9xvt3CAnzmS7BXp6+18okL1+uBSNy0QIBqdErZsVCHbBBo
         Eny1gEHAAF48cYS7l5dQf5Mr6l663lOZTxQ1Zz0yqDbjQr1G0Sc9jK8hhp/dO0mUoScu
         v6bG6vJIoHyjK8M8vRZsKRNY9bap6nYYfDixOVLH97kacIYXGXmxuZ3k7QV6t3UqJeH2
         uleA==
X-Forwarded-Encrypted: i=1; AJvYcCUxwCUsVNWbfThcmyXxiKHm+HBkm6y72it2fuRgG/dNZtdzw5yGCnXpHyvUYmInlqUwNbz433k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dqhg3OeY46UBqR/tyxuM+kAQje2dTxy74h8WLaPmHWsLTuwr
	oIIFSk1n6sP9KXKkBnRP+TeGCBedM8VOSLJTR6TgcMOEPgbB7p2TDuoc3aJINrO0UqpOSA75rDz
	k0RivmUFcWnqBXblAW6PcsQh5BdUl6nJ49aB0Okj5wzZLrQdXlOemh+eJfHFT3Z8O3Cop7WysxL
	7mkJCLWfCr3au5R8jE68oql7HY0VlOZ5YS7m6ynRzmh2eDFfBr
X-Gm-Gg: ASbGncskbbi5lmLI5ULacJxa1fOfHI9YQPKWZt5DeYC7YwQK5oI5nu7fbtxlqOVZxTT
	v8Ms3WS+agWYIpOmlmekvow+hr3EL1vbtdXvB05UEvBom/AX4gKyj18gqodHCTfBexLcL2q3si+
	SIt9ey
X-Received: by 2002:a05:6000:2c0e:b0:3b3:9cb4:a2fb with SMTP id ffacd0b85a97d-3b496607ba4mr1101145f8f.33.1751613314585;
        Fri, 04 Jul 2025 00:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs2loDZ8Ahhlwp61+khQUNQNmUajyh8hMqo5bymejd7TY7m60S3yJ4iCiWJA6UU/KjjSwjuFppfJUbhZc5mRE=
X-Received: by 2002:a05:6000:2c0e:b0:3b3:9cb4:a2fb with SMTP id
 ffacd0b85a97d-3b496607ba4mr1101108f8f.33.1751613314079; Fri, 04 Jul 2025
 00:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.com>
 <3023fe74-29c7-4a41-b805-c6b00fb0b3cc@intel.com> <20250701154423.1917c3de@onyx.my.domain>
In-Reply-To: <20250701154423.1917c3de@onyx.my.domain>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Fri, 4 Jul 2025 15:15:02 +0800
X-Gm-Features: Ac12FXyj1-ZyBE3D1qBUiJnE2eIIgUp4g0jGX8z1J7TRdyPJWcFakElyE77oy6Y
Message-ID: <CAMqyJG1bt_p9trGrtk-_xqfEF954TrSKoV6QokuadJK8ga80xA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [REGRESSION] Packet loss after hot-plugging
 ethernet cable on HP Zbook (Arrow Lake)
To: Timo Teras <timo.teras@iki.fi>
Cc: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you all for your quick response. Sorry for the delay.

I ran two independent tests:

1. The same experiment as Timo said: When the packet-loss problem
occurs (by hot-plugging the Ethernet cable), running the following
command fixes the issue
$ ethtool -r # trigger a re-negotiation

2. As Vitaly suggests: By enabling flow control, we no longer observe
any packet loss.
e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx


From the power management perspective, I can confirm that the Ethernet
controller stays D0 at all times. But I=E2=80=99m not sure if it=E2=80=99s =
the case
for PHY, as I=E2=80=99m not familiar with how to check the power state of a
PHY.

Thanks,
En-Wei.

On Tue, 1 Jul 2025 at 20:44, Timo Teras <timo.teras@iki.fi> wrote:
>
> On Tue, 1 Jul 2025 14:46:18 +0300
> "Lifshits, Vitaly" <vitaly.lifshits@intel.com> wrote:
>
> > On 7/1/2025 8:31 AM, En-Wei WU wrote:
> > > Hi,
> > >
> > > I'm seeing a regression on an HP ZBook using the e1000e driver
> > > (chipset PCI ID: [8086:57a0]) -- the system can't get an IP address
> > > after hot-plugging an Ethernet cable. In this case, the Ethernet
> > > cable was unplugged at boot. The network interface eno1 was present
> > > but stuck in the DHCP process. Using tcpdump, only TX packets were
> > > visible and never got any RX -- indicating a possible packet loss or
> > > link-layer issue.
> > >
> > > This is on the vanilla Linux 6.16-rc4 (commit
> > > 62f224733431dbd564c4fe800d4b67a0cf92ed10).
> > >
> > > Bisect says it's this commit:
> > >
> > > commit efaaf344bc2917cbfa5997633bc18a05d3aed27f
> > > Author: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > > Date:   Thu Mar 13 16:05:56 2025 +0200
> > >
> > >      e1000e: change k1 configuration on MTP and later platforms
> > >
> > >      Starting from Meteor Lake, the Kumeran interface between the
> > > integrated MAC and the I219 PHY works at a different frequency.
> > > This causes sporadic MDI errors when accessing the PHY, and in rare
> > > circumstances could lead to packet corruption.
> > >
> > >      To overcome this, introduce minor changes to the Kumeran idle
> > >      state (K1) parameters during device initialization. Hardware
> > > reset reverts this configuration, therefore it needs to be applied
> > > in a few places.
> > >
> > >      Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
> > >      Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > >      Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> > >      Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > >
> > >   drivers/net/ethernet/intel/e1000e/defines.h |  3 +++
> > >   drivers/net/ethernet/intel/e1000e/ich8lan.c | 80
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
-----
> > >   drivers/net/ethernet/intel/e1000e/ich8lan.h |  4 ++++
> > >   3 files changed, 82 insertions(+), 5 deletions(-)
> > >
> > > Reverting this patch resolves the issue.
> > >
> > > Based on the symptoms and the bisect result, this issue might be
> > > similar to
> > > https://lore.kernel.org/intel-wired-lan/20250626153544.1853d106@onyx.=
my.domain/
> > >
> > >
> > > Affected machine is:
> > > HP ZBook X G1i 16 inch Mobile Workstation PC, BIOS 01.02.03
> > > 05/27/2025 (see end of message for dmesg from boot)
> > >
> > > CPU model name:
> > > Intel(R) Core(TM) Ultra 7 265H (Arrow Lake)
> > >
> > > ethtool output:
> > > driver: e1000e
> > > version: 6.16.0-061600rc4-generic
> > > firmware-version: 0.1-4
> > > expansion-rom-version:
> > > bus-info: 0000:00:1f.6
> > > supports-statistics: yes
> > > supports-test: yes
> > > supports-eeprom-access: yes
> > > supports-register-dump: yes
> > > supports-priv-flags: yes
> > >
> > > lspci output:
> > > 0:1f.6 Ethernet controller [0200]: Intel Corporation Device
> > > [8086:57a0] DeviceName: Onboard Ethernet
> > >          Subsystem: Hewlett-Packard Company Device [103c:8e1d]
> > >          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
> > > >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >          Latency: 0
> > >          Interrupt: pin D routed to IRQ 162
> > >          IOMMU group: 17
> > >          Region 0: Memory at 92280000 (32-bit, non-prefetchable)
> > > [size=3D128K] Capabilities: [c8] Power Management version 3
> > >                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                  Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
1
> > > PME- Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> > >                  Address: 00000000fee00798  Data: 0000
> > >          Kernel driver in use: e1000e
> > >          Kernel modules: e1000e
> > >
> > > The relevant dmesg:
> > > <<<cable disconnected>>>
> > >
> > > [    0.927394] e1000e: Intel(R) PRO/1000 Network Driver
> > > [    0.927398] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> > > [    0.927933] e1000e 0000:00:1f.6: enabling device (0000 -> 0002)
> > > [    0.928249] e1000e 0000:00:1f.6: Interrupt Throttling Rate
> > > (ints/sec) set to dynamic conservative mode
> > > [    1.155716] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized):
> > > registered PHC clock
> > > [    1.220694] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width
> > > x1) 24:fb:e3:bf:28:c6
> > > [    1.220721] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network
> > > Connection [    1.220903] e1000e 0000:00:1f.6 eth0: MAC: 16, PHY:
> > > 12, PBA No: FFFFFF-0FF [    1.222632] e1000e 0000:00:1f.6 eno1:
> > > renamed from eth0
> > >
> > > <<<cable connected>>>
> > >
> > > [  153.932626] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps
> > > Half Duplex, Flow Control: None
> > > [  153.934527] e1000e 0000:00:1f.6 eno1: NIC Link is Down
> > > [  157.622238] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps
> > > Full Duplex, Flow Control: None
> > >
> > > No error message seen after hot-plugging the Ethernet cable.
> > >
> >
> > Thank your for the report.
> >
> > We did not encounter this issue during our patch testing. However, we
> > will attempt to reproduce it in our lab.
> >
> > One detail that caught my attention is that flow control is disabled
> > in both scenarios. Could you please check whether the issue persists
> > when flow control is enabled? This might require connecting to a link
> > partner that supports flow control.
>
> I wrote the other similar report from Dell Pro referenced earlier.
> Additional testing on the Dell provided the following insight:
>
> - A fast cable out/in will work. The cable should be disconnected
>   for 10-15 seconds for the issue to trigger.
>
> - Sometimes the first spurious link up is 1000 mbps/half and sometimes
>   10 mbps/half.
>
> - Using ethtool -r to renegotiate the link will make things work in
>   the defunct state.
>
> And yes, my issue seems to be exactly the same.
>
> Thanks,
> Timo

