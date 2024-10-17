Return-Path: <netdev+bounces-136717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BC9A2BDF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5882863AF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E01DFE3F;
	Thu, 17 Oct 2024 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-m-m-be.20230601.gappssmtp.com header.i=@t-m-m-be.20230601.gappssmtp.com header.b="E3nooMuU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DA1DFDB2
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188899; cv=none; b=WvV/CwYS0eTyRAWHUfFUJ2O3JQoLmAl5eIjq9W0C1fnfzqFaJy5M3d1IQbcRazEbX7pUP4t3LV4yiON0Lc8tNLkIc2Zl/fRq4+TPa8TgNnBWLkTgf/aV3Ac9mwyp/r2hnL8If+SrVOJJob8bR2FaLazgea7xbWN8bP/jRguHa7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188899; c=relaxed/simple;
	bh=lXcnzZU4nlMUZSmtAZTKrzSQVXd7+cvb++Mfj8fDHrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/I3BX35KEADk9JqdPxM1Ui6Y4U+7bbAtqqWqoDJKuTuk6GJ4k53soEiPtOMcWnLH1JCyqfDurNrIk1fpX95y/opEK9LDFXIfbTCAPFIt6FLzs3V7VL4AjwaWZRlfz7ECnebPzDtq5Auq2Fwlr2WZVmCVzkal8weaMa/AI/b6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-m-m.be; spf=pass smtp.mailfrom=t-m-m.be; dkim=pass (2048-bit key) header.d=t-m-m-be.20230601.gappssmtp.com header.i=@t-m-m-be.20230601.gappssmtp.com header.b=E3nooMuU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-m-m.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-m-m.be
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1564322e87.3
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=t-m-m-be.20230601.gappssmtp.com; s=20230601; t=1729188890; x=1729793690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwiffKS9AttvSWI3yNu5y82UpDq2iA6kgWkL1iF+Up0=;
        b=E3nooMuUuMJvp/FNzi3wEKkiKUmNervYhZfOe+i1HeCmju+4wKqpe4lIorYQkiRj45
         RDaV0GekttIRuhQWcGuH7w+td3n4T/0GjJ8m2bX2tb9E3eMJorcunhwR1SBpdHenu7WO
         YPbsfEIal0ud+LEOavs2Udtyr5fHAZB9f3O8/1aP9fO/CCugoA9JwgdbWWLykuLyPaJw
         qzw2TH8cEy7fbtXGgDwO6kVFDqpcsPcfSto/ETdsDfJAFPC9udnRFngGdwy2+uw2JHd7
         bb0mbIq6z4poJNHMcVHa7/rU9S60VjnQ/RofSgBajluL8JlXD3dqxc9az6l5ZGzSBzUX
         8jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188890; x=1729793690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwiffKS9AttvSWI3yNu5y82UpDq2iA6kgWkL1iF+Up0=;
        b=bzY3rWULd5L83hw8wsT6D4fVq8hunt+ByiLexTvvb4AHeqy3AkNaeFNROQsI81hicX
         vGK0dT2WNmlqam9tQglcWCsNrvnF9IZQpMUsvTkZBQSVZpiOnZeXL3LkSvwPWtVd1ZUp
         jU/iBG4C7fCuDo6bCZFZ4ziuYts7iARyzhJmnG3PvIt9mDjXKSEX3q6BO2NQrl4cPBl0
         N/6+endI983W4rI0guY4/3X3Vm8G79I8i1rbRXTDUBxvw2TKAmIEg0jMYWJg/JBHC7fa
         yCyCUnIRLD+UJYnIRYQQIMAu6sFCgSOlJagovPoigIsXeSMKstOpLqmsC3TbdyjkdYOr
         qzHg==
X-Gm-Message-State: AOJu0YwMcpXGcIiJIj2mBhZU/13hG0DiLJDAyH1UeSb2H5UTIZyG7vFD
	LDKL/3Q3aDVUwwVhgoViyj1ITmufpwy6hx5+2bCiGD0uVMg5OKymUj6pBC6IwwSQV0BfjBnUahJ
	Y3V/Rdm3qqOM+VwXQU/ZgXXx0Epm8RlK7gs2BAi5C3grjuMheGUU=
X-Google-Smtp-Source: AGHT+IHEB6DI7jiVKxtoONpfiijpU4fpPTtt49cGE96QRgt9+6L1n1icwUCOPDb/J6vKrytvVpd9Trm0cLXFtADyn6g=
X-Received: by 2002:a05:6512:39cb:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-53a03f18ddamr5798400e87.13.1729188889479; Thu, 17 Oct 2024
 11:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHJ97wTDiqgOHfLJc3pEjz=ZwpWP4LJV7sxUfYxQmkryi-rv0A@mail.gmail.com>
 <73e05f2e-2e0c-4a72-94a6-3f618b0e616e@gmail.com> <CAHJ97wRJQ4qm_Hxx=FB8ZzD3O7njLYX7mcPvMvRbsdu=T7VZrg@mail.gmail.com>
 <d49e275f-7526-4eb4-aa9c-31975aecbfc6@gmail.com> <CAHJ97wRoaOAXASnWOwADQpL0pcsosRscNyQZFxnTYj76M4eE+g@mail.gmail.com>
 <CAHJ97wSAiwJgA297ry7z37kPut_jqYXGEakkbyKK6tJXvtCmOw@mail.gmail.com> <2ada65e1-5dfa-456c-9334-2bc51272e9da@gmail.com>
In-Reply-To: <2ada65e1-5dfa-456c-9334-2bc51272e9da@gmail.com>
From: Luc Willems <luc.willems@t-m-m.be>
Date: Thu, 17 Oct 2024 20:14:38 +0200
Message-ID: <CAHJ97wT1jGSg=1qsbhryxSvk3QWTDtgSTHvkxxjyda-8N1OD4w@mail.gmail.com>
Subject: Re: r8169 unknown chip XID 688
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

install the firmware,
- static ip assignment using /etc/network/interfaces seems to work ok
, system reboots in normal time, and connectivity works using iperf3
(short test)
- dhcp ip assignment still fails , reboot seems to hang on waiting for
dhcp client timeout , and after that a second ifdown/ifup sequences
doesn't seem to work , even ip link show the link up and active

root@prxmox-kernel:~# ifup ens16
Internet Systems Consortium DHCP Client 4.4.3-P1
Copyright 2004-2022 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/ens16/10:ff:e0:6b:66:98
Sending on   LPF/ens16/10:ff:e0:6b:66:98
Sending on   Socket/fallback
DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 8
DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 7
DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 12
DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 12
DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 11
DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 11
No DHCPOFFERS received.
No working leases in persistent database - sleeping.
root@prxmox-kernel:~# ip l
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
mode DEFAULT group default qlen 1000
   link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
state UP mode DEFAULT group default qlen 1000
   link/ether bc:24:11:e6:79:8f brd ff:ff:ff:ff:ff:ff
   altname enp0s18
3: ens16: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
state UP mode DEFAULT group default qlen 1000
   link/ether 10:ff:e0:6b:66:98 brd ff:ff:ff:ff:ff:ff
   altname enp0s16
root@prxmox-kernel:~#

using hotplug ens16 instead of auto ens16 in the interface seems to
result in the interface staying down state.
ethtool also doesn=C2=B4t provide any useful info.

switching back to static ip, i can retrieve information using ethtool
on the interface.


 luc




On Wed, Oct 16, 2024 at 7:44=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 14.10.2024 14:48, Luc Willems wrote:
> > small correction, it took some time but dhcp has finally assigned an ip=
 address
> >
> > I could run iperf3 on it, getting 2.35Gbits/sec for a short test.
> > but after reboot i lost connectivity again , even switching to static
> > ip did not provide a solution.
> >
> > so for the moment, not very stable.
> > seems we need to wait to have specific firmware.
> >
> Firmware file has been submitted by Realtek, however it may take time unt=
il
> the next linux-firmware release is published. In the meantime you can get=
 the
> firmware file from here:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it/tree/rtl_nic/rtl8125d-1.fw
> Just place it under /lib/firmware/rtl_nic/
>
> >
> >
> >
> >
> > On Mon, Oct 14, 2024 at 2:31=E2=80=AFPM Luc Willems <luc.willems@t-m-m.=
be> wrote:
> >>
> >> after last patch, i now have an ens16 interface but not able to assign
> >> ip using static or dhcp
> >>
> >> [    0.586421] r8169 0000:00:10.0 eth0: RTL8125D, 10:ff:e0:6b:66:98,
> >> XID 688, IRQ 46
> >> [    0.586424] r8169 0000:00:10.0 eth0: jumbo features [frames: 9194
> >> bytes, tx checksumming: ko]
> >> [    0.789719] r8169 0000:00:10.0 ens16: renamed from eth0
> >> [   13.583533] r8169 0000:00:10.0: firmware: failed to load
> >> rtl_nic/rtl8125d-1.fw (-2)
> >> [   13.583541] r8169 0000:00:10.0: firmware: failed to load
> >> rtl_nic/rtl8125d-1.fw (-2)
> >> [   13.583542] r8169 0000:00:10.0: Direct firmware load for
> >> rtl_nic/rtl8125d-1.fw failed with error -2
> >> [   13.583544] r8169 0000:00:10.0: Unable to load firmware
> >> rtl_nic/rtl8125d-1.fw (-2)
> >> [   13.609457] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-80:00: attached
> >> PHY driver (mii_bus:phy_addr=3Dr8169-0-80:00, irq=3DMAC)
> >> [   13.737853] r8169 0000:00:10.0 ens16: Link is Down
> >> [   16.937666] r8169 0000:00:10.0 ens16: Link is Up - 2.5Gbps/Full -
> >> flow control rx/tx
> >> root@prxmox-kernel:~#
> >>
> >> On Mon, Oct 14, 2024 at 12:22=E2=80=AFPM Heiner Kallweit <hkallweit1@g=
mail.com> wrote:
> >>>
> >>> On 14.10.2024 02:05, Luc Willems wrote:
> >>>> HI ,
> >>>>
> >>>> installed the patch on a debian-backports 6.10.11 kernel in a VM (KV=
M)
> >>>> with the realtek injected using pci pass through.
> >>>> i had to modify the patch a bit, removing the RTL_GIGA_MAC_VER_63
> >>>> related entries because these don't seem to be in this kernel
> >>>>
> >>>> running this kernel gives me this result now
> >>>>
> >>>> root@prxmox-kernel:~# uname -a
> >>>> Linux prxmox-kernel 6.10+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC
> >>>> Debian 6.10.11-1~bpo12+1r8169p1 (2024-10- x86_64 GNU/Linux
> >>>> root@prxmox-kernel:~# dmesg |grep r8169
> >>>> [    0.000000] Linux version 6.10+unreleased-amd64
> >>>> (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-12 (Debian
> >>>> 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP
> >>>> PREEMPT_DYNAMIC Debian 6.10.
> >>>> 11-1~bpo12+1r8169p1 (2024-10-
> >>>> [    0.585895] r8169 0000:00:10.0: no dedicated PHY driver found for
> >>>> PHY ID 0x001cc841, maybe realtek.ko needs to be added to initramfs?
> >>>> [    0.586010] r8169 0000:00:10.0: probe with driver r8169 failed wi=
th error -49
> >>>>
> >>>> root@prxmox-kernel:~# modinfo r8169
> >>>> filename:
> >>>> /lib/modules/6.10+unreleased-amd64/kernel/drivers/net/ethernet/realt=
ek/r8169.ko.xz
> >>>> firmware:       rtl_nic/rtl8126a-2.fw
> >>>> firmware:       rtl_nic/rtl8125d-1.fw
> >>>> firmware:       rtl_nic/rtl8125b-2.fw
> >>>> firmware:       rtl_nic/rtl8125a-3.fw
> >>>> firmware:       rtl_nic/rtl8107e-2.fw
> >>>> firmware:       rtl_nic/rtl8168fp-3.fw
> >>>> firmware:       rtl_nic/rtl8168h-2.fw
> >>>> firmware:       rtl_nic/rtl8168g-3.fw
> >>>> firmware:       rtl_nic/rtl8168g-2.fw
> >>>> firmware:       rtl_nic/rtl8106e-2.fw
> >>>> firmware:       rtl_nic/rtl8106e-1.fw
> >>>> firmware:       rtl_nic/rtl8411-2.fw
> >>>> firmware:       rtl_nic/rtl8411-1.fw
> >>>> firmware:       rtl_nic/rtl8402-1.fw
> >>>> firmware:       rtl_nic/rtl8168f-2.fw
> >>>> firmware:       rtl_nic/rtl8168f-1.fw
> >>>> firmware:       rtl_nic/rtl8105e-1.fw
> >>>> firmware:       rtl_nic/rtl8168e-3.fw
> >>>> firmware:       rtl_nic/rtl8168e-2.fw
> >>>> firmware:       rtl_nic/rtl8168e-1.fw
> >>>> firmware:       rtl_nic/rtl8168d-2.fw
> >>>> firmware:       rtl_nic/rtl8168d-1.fw
> >>>> license:        GPL
> >>>> softdep:        pre: realtek
> >>>> description:    RealTek RTL-8169 Gigabit Ethernet driver
> >>>> author:         Realtek and the Linux r8169 crew <netdev@vger.kernel=
.org>
> >>>> alias:          pci:v000010ECd00003000sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00008126sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00008125sv*sd*bc*sc*i*
> >>>> alias:          pci:v00000001d00008168sv*sd00002410bc*sc*i*
> >>>> alias:          pci:v00001737d00001032sv*sd00000024bc*sc*i*
> >>>> alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*
> >>>> alias:          pci:v00001259d0000C107sv*sd*bc*sc*i*
> >>>> alias:          pci:v00001186d00004302sv*sd*bc*sc*i*
> >>>> alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
> >>>> alias:          pci:v00001186d00004300sv00001186sd00004B10bc*sc*i*
> >>>> alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010FFd00008168sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00008168sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00008167sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00008162sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00008161sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00008136sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00002600sv*sd*bc*sc*i*
> >>>> alias:          pci:v000010ECd00002502sv*sd*bc*sc*i*
> >>>> depends:        libphy,mdio_devres
> >>>> retpoline:      Y
> >>>> intree:         Y
> >>>> name:           r8169
> >>>> vermagic:       6.10+unreleased-amd64 SMP preempt mod_unload modvers=
ions
> >>>>
> >>>> root@prxmox-kernel:~# lsmod |grep real
> >>>> realtek                45056  0
> >>>> libphy                225280  3 r8169,mdio_devres,realtek
> >>>> root@prxmox-kernel:~#
> >>>>
> >>>> On Sun, Oct 13, 2024 at 10:44=E2=80=AFAM Heiner Kallweit <hkallweit1=
@gmail.com> wrote:
> >>>>>
> >>>>> On 12.10.2024 21:03, Luc Willems wrote:
> >>>>>> using new gigabyte X870E AORUS ELITE WIFI7 board, running proxmox =
pve kernel
> >>>>>>
> >>>>>> Linux linux-s05 6.8.12-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-2
> >>>>>> (2024-09-05T10:03Z) x86_64 GNU/Linux
> >>>>>>
> >>>>>> 11:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL81=
25
> >>>>>> 2.5GbE Controller (rev 0c)
> >>>>>>         Subsystem: Gigabyte Technology Co., Ltd RTL8125 2.5GbE Con=
troller
> >>>>>>         Flags: fast devsel, IRQ 43, IOMMU group 26
> >>>>>>         I/O ports at e000 [size=3D256]
> >>>>>>         Memory at dd900000 (64-bit, non-prefetchable) [size=3D64K]
> >>>>>>         Memory at dd910000 (64-bit, non-prefetchable) [size=3D16K]
> >>>>>>         Capabilities: [40] Power Management version 3
> >>>>>>         Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bi=
t+
> >>>>>>         Capabilities: [70] Express Endpoint, MSI 01
> >>>>>>         Capabilities: [b0] MSI-X: Enable- Count=3D64 Masked-
> >>>>>>         Capabilities: [d0] Vital Product Data
> >>>>>>         Capabilities: [100] Advanced Error Reporting
> >>>>>>         Capabilities: [148] Virtual Channel
> >>>>>>         Capabilities: [164] Device Serial Number 01-00-00-00-68-4c=
-e0-00
> >>>>>>         Capabilities: [174] Transaction Processing Hints
> >>>>>>         Capabilities: [200] Latency Tolerance Reporting
> >>>>>>         Capabilities: [208] L1 PM Substates
> >>>>>>         Capabilities: [218] Vendor Specific Information: ID=3D0002=
 Rev=3D4
> >>>>>> Len=3D100 <?>
> >>>>>>         Kernel modules: r8169
> >>>>>>
> >>>>>> root@linux-s05:/root# dmesg |grep r8169
> >>>>>> [    6.353276] r8169 0000:11:00.0: error -ENODEV: unknown chip XID
> >>>>>> 688, contact r8169 maintainers (see MAINTAINERS file)
> >>>>>>
> >>>>>
> >>>>> Below is a patch with experimental support for RTL8125D. Could you
> >>>>> please test it? Few notes:
> >>>>> - Depending on the PHY ID of the integrated PHY you may receive an
> >>>>>   error message that there's no dedicated PHY driver. Please forwar=
d the
> >>>>>   error message with the PHY ID in this case.
> >>>>> - As long as the firmware for this chip version isn't available, li=
nk
> >>>>>   might be unstable or worst case completely missing. Driver will c=
omplain
> >>>>>   about the missing firmware file, but this error message can be ig=
nored for now.
> >>>>>
> >>>>> ---
> >>>>>  drivers/net/ethernet/realtek/r8169.h          |  1 +
> >>>>>  drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++++++++++--=
----
> >>>>>  .../net/ethernet/realtek/r8169_phy_config.c   |  7 ++++++
> >>>>>  3 files changed, 24 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/eth=
ernet/realtek/r8169.h
> >>>>> index e2db944e6..be4c96226 100644
> >>>>> --- a/drivers/net/ethernet/realtek/r8169.h
> >>>>> +++ b/drivers/net/ethernet/realtek/r8169.h
> >>>>> @@ -68,6 +68,7 @@ enum mac_version {
> >>>>>         /* support for RTL_GIGA_MAC_VER_60 has been removed */
> >>>>>         RTL_GIGA_MAC_VER_61,
> >>>>>         RTL_GIGA_MAC_VER_63,
> >>>>> +       RTL_GIGA_MAC_VER_64,
> >>>>>         RTL_GIGA_MAC_VER_65,
> >>>>>         RTL_GIGA_MAC_VER_66,
> >>>>>         RTL_GIGA_MAC_NONE
> >>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/ne=
t/ethernet/realtek/r8169_main.c
> >>>>> index 1a2322824..dcd176a77 100644
> >>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >>>>> @@ -56,6 +56,7 @@
> >>>>>  #define FIRMWARE_8107E_2       "rtl_nic/rtl8107e-2.fw"
> >>>>>  #define FIRMWARE_8125A_3       "rtl_nic/rtl8125a-3.fw"
> >>>>>  #define FIRMWARE_8125B_2       "rtl_nic/rtl8125b-2.fw"
> >>>>> +#define FIRMWARE_8125D_1       "rtl_nic/rtl8125d-1.fw"
> >>>>>  #define FIRMWARE_8126A_2       "rtl_nic/rtl8126a-2.fw"
> >>>>>  #define FIRMWARE_8126A_3       "rtl_nic/rtl8126a-3.fw"
> >>>>>
> >>>>> @@ -139,6 +140,7 @@ static const struct {
> >>>>>         [RTL_GIGA_MAC_VER_61] =3D {"RTL8125A",            FIRMWARE_=
8125A_3},
> >>>>>         /* reserve 62 for CFG_METHOD_4 in the vendor driver */
> >>>>>         [RTL_GIGA_MAC_VER_63] =3D {"RTL8125B",            FIRMWARE_=
8125B_2},
> >>>>> +       [RTL_GIGA_MAC_VER_64] =3D {"RTL8125D",            FIRMWARE_=
8125D_1},
> >>>>>         [RTL_GIGA_MAC_VER_65] =3D {"RTL8126A",            FIRMWARE_=
8126A_2},
> >>>>>         [RTL_GIGA_MAC_VER_66] =3D {"RTL8126A",            FIRMWARE_=
8126A_3},
> >>>>>  };
> >>>>> @@ -708,6 +710,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
> >>>>>  MODULE_FIRMWARE(FIRMWARE_8107E_2);
> >>>>>  MODULE_FIRMWARE(FIRMWARE_8125A_3);
> >>>>>  MODULE_FIRMWARE(FIRMWARE_8125B_2);
> >>>>> +MODULE_FIRMWARE(FIRMWARE_8125D_1);
> >>>>>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
> >>>>>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
> >>>>>
> >>>>> @@ -2099,10 +2102,7 @@ static void rtl_set_eee_txidle_timer(struct =
rtl8169_private *tp)
> >>>>>                 tp->tx_lpi_timer =3D timer_val;
> >>>>>                 r8168_mac_ocp_write(tp, 0xe048, timer_val);
> >>>>>                 break;
> >>>>> -       case RTL_GIGA_MAC_VER_61:
> >>>>> -       case RTL_GIGA_MAC_VER_63:
> >>>>> -       case RTL_GIGA_MAC_VER_65:
> >>>>> -       case RTL_GIGA_MAC_VER_66:
> >>>>> +       case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
> >>>>>                 tp->tx_lpi_timer =3D timer_val;
> >>>>>                 RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
> >>>>>                 break;
> >>>>> @@ -2234,6 +2234,9 @@ static enum mac_version rtl8169_get_mac_versi=
on(u16 xid, bool gmii)
> >>>>>                 { 0x7cf, 0x64a, RTL_GIGA_MAC_VER_66 },
> >>>>>                 { 0x7cf, 0x649, RTL_GIGA_MAC_VER_65 },
> >>>>>
> >>>>> +               /* 8125D family. */
> >>>>> +               { 0x7cf, 0x688, RTL_GIGA_MAC_VER_64 },
> >>>>> +
> >>>>>                 /* 8125B family. */
> >>>>>                 { 0x7cf, 0x641, RTL_GIGA_MAC_VER_63 },
> >>>>>
> >>>>> @@ -2501,9 +2504,7 @@ static void rtl_init_rxcfg(struct rtl8169_pri=
vate *tp)
> >>>>>         case RTL_GIGA_MAC_VER_61:
> >>>>>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_B=
URST);
> >>>>>                 break;
> >>>>> -       case RTL_GIGA_MAC_VER_63:
> >>>>> -       case RTL_GIGA_MAC_VER_65:
> >>>>> -       case RTL_GIGA_MAC_VER_66:
> >>>>> +       case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
> >>>>>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_B=
URST |
> >>>>>                         RX_PAUSE_SLOT_ON);
> >>>>>                 break;
> >>>>> @@ -3815,6 +3816,12 @@ static void rtl_hw_start_8125b(struct rtl816=
9_private *tp)
> >>>>>         rtl_hw_start_8125_common(tp);
> >>>>>  }
> >>>>>
> >>>>> +static void rtl_hw_start_8125d(struct rtl8169_private *tp)
> >>>>> +{
> >>>>> +       rtl_set_def_aspm_entry_latency(tp);
> >>>>> +       rtl_hw_start_8125_common(tp);
> >>>>> +}
> >>>>> +
> >>>>>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
> >>>>>  {
> >>>>>         rtl_set_def_aspm_entry_latency(tp);
> >>>>> @@ -3863,6 +3870,7 @@ static void rtl_hw_config(struct rtl8169_priv=
ate *tp)
> >>>>>                 [RTL_GIGA_MAC_VER_53] =3D rtl_hw_start_8117,
> >>>>>                 [RTL_GIGA_MAC_VER_61] =3D rtl_hw_start_8125a_2,
> >>>>>                 [RTL_GIGA_MAC_VER_63] =3D rtl_hw_start_8125b,
> >>>>> +               [RTL_GIGA_MAC_VER_64] =3D rtl_hw_start_8125d,
> >>>>>                 [RTL_GIGA_MAC_VER_65] =3D rtl_hw_start_8126a,
> >>>>>                 [RTL_GIGA_MAC_VER_66] =3D rtl_hw_start_8126a,
> >>>>>         };
> >>>>> @@ -3880,6 +3888,7 @@ static void rtl_hw_start_8125(struct rtl8169_=
private *tp)
> >>>>>         /* disable interrupt coalescing */
> >>>>>         switch (tp->mac_version) {
> >>>>>         case RTL_GIGA_MAC_VER_61:
> >>>>> +       case RTL_GIGA_MAC_VER_64:
> >>>>>                 for (i =3D 0xa00; i < 0xb00; i +=3D 4)
> >>>>>                         RTL_W32(tp, i, 0);
> >>>>>                 break;
> >>>>> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/driv=
ers/net/ethernet/realtek/r8169_phy_config.c
> >>>>> index cf29b1208..6b70f23c8 100644
> >>>>> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> >>>>> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> >>>>> @@ -1104,6 +1104,12 @@ static void rtl8125b_hw_phy_config(struct rt=
l8169_private *tp,
> >>>>>         rtl8125b_config_eee_phy(phydev);
> >>>>>  }
> >>>>>
> >>>>> +static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
> >>>>> +                                  struct phy_device *phydev)
> >>>>> +{
> >>>>> +       r8169_apply_firmware(tp);
> >>>>> +}
> >>>>> +
> >>>>>  static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
> >>>>>                                    struct phy_device *phydev)
> >>>>>  {
> >>>>> @@ -1160,6 +1166,7 @@ void r8169_hw_phy_config(struct rtl8169_priva=
te *tp, struct phy_device *phydev,
> >>>>>                 [RTL_GIGA_MAC_VER_53] =3D rtl8117_hw_phy_config,
> >>>>>                 [RTL_GIGA_MAC_VER_61] =3D rtl8125a_2_hw_phy_config,
> >>>>>                 [RTL_GIGA_MAC_VER_63] =3D rtl8125b_hw_phy_config,
> >>>>> +               [RTL_GIGA_MAC_VER_64] =3D rtl8125d_hw_phy_config,
> >>>>>                 [RTL_GIGA_MAC_VER_65] =3D rtl8126a_hw_phy_config,
> >>>>>                 [RTL_GIGA_MAC_VER_66] =3D rtl8126a_hw_phy_config,
> >>>>>         };
> >>>>> --
> >>>>> 2.47.0
> >>>>>
> >>>>>
> >>>>
> >>>>
> >>>
> >>> Thanks for testing. For PHY ID 0x001cc841 there's no PHY driver yet.
> >>> Following isn't a proper patch but just a quick hack to see whether
> >>> it makes your NIC work. Could you please apply this change on top
> >>> and re-test?
> >>>
> >>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> >>> index 166f6a728..1bb8139cb 100644
> >>> --- a/drivers/net/phy/realtek.c
> >>> +++ b/drivers/net/phy/realtek.c
> >>> @@ -1348,7 +1348,7 @@ static struct phy_driver realtek_drvs[] =3D {
> >>>                 .read_mmd       =3D rtl822x_read_mmd,
> >>>                 .write_mmd      =3D rtl822x_write_mmd,
> >>>         }, {
> >>> -               PHY_ID_MATCH_EXACT(0x001cc840),
> >>> +               PHY_ID_MATCH_EXACT(0x001cc841),
> >>>                 .name           =3D "RTL8226B_RTL8221B 2.5Gbps PHY",
> >>>                 .get_features   =3D rtl822x_get_features,
> >>>                 .config_aneg    =3D rtl822x_config_aneg,
> >>>
> >>>
> >>>
> >>
> >>
> >> --
> >> T.M.M BV
> >> Luc Willems
> >> Schoolblok 7
> >> 2275 Lille
> >>
> >>
> >> mobile: 0478/959140
> >> email: luc.willems@t-m-m.be
> >
> >
> >
>


--=20
T.M.M BV
Luc Willems
Schoolblok 7
2275 Lille


mobile: 0478/959140
email: luc.willems@t-m-m.be

