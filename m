Return-Path: <netdev+bounces-135192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE999CA9E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79D71C228A0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCF1AA78F;
	Mon, 14 Oct 2024 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-m-m-be.20230601.gappssmtp.com header.i=@t-m-m-be.20230601.gappssmtp.com header.b="Hoy66V+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3E15D5CE
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910120; cv=none; b=iDcimAHnCxxHvBsKcTdKFzI4cwvxNTWfsyDDJXSP5+Qt7vTOOqzPx+51ZhfhN7mN/GibvbUcg2SK9y2keJNFADW/Lt7V8X2y1uoLnf+saZn5iPIwtCbeYhfaib5T/SQe6phlrel1liRbw6gure+znIy87zBe9YoCcOnRg7aXISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910120; c=relaxed/simple;
	bh=Mu2UYxYV89Nqc1brOrKHQdinbU2VCnLXHa5m+YVzaTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlLVqLkNNUSqwoxZMQAa6HGVWsPJTqOJWFJOiJ/2RuQSBFIzPkkANQ6E+Tt3ZrNIwhyQXKsOwPcGENXEfMs0P+usEISK2n00DAp88zS+oqRC0SASrwn5E/J1ujE5Qw2AUSQavY7zX93Zi0fSB3berPxVvpxJO8LQyIfITAevwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-m-m.be; spf=pass smtp.mailfrom=t-m-m.be; dkim=pass (2048-bit key) header.d=t-m-m-be.20230601.gappssmtp.com header.i=@t-m-m-be.20230601.gappssmtp.com header.b=Hoy66V+P; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-m-m.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-m-m.be
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1855088e87.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=t-m-m-be.20230601.gappssmtp.com; s=20230601; t=1728910116; x=1729514916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbgXbq9rHlIRzZR1D8yBbdkGrB9JBUyDekQP9rIMRgY=;
        b=Hoy66V+PHmGS4sjZEh/xy7fSUfCOPM20mqtBA7HzmKiCjmAN5iq3BQxe/mzR8XtKV9
         n7z/9G2gZhH9Vhw4+R3gcgxWB0nqpzeNNME3qVeuLSMXL/b5k77i1HXVg49p5hqxpGc8
         4xoa5cTqYVXXxxx/I9ektSEfEU0+pE3mMJRCO054eu0LZzuojMVJinAV3Kpabdxn3owS
         ORwsKnh3UpSvCzIAJaY+HBWQduIqvTRGld/pONsDa9c4aujmIDIZjxDVQ01HfM0BOc/A
         rg8AoeH97DQQ9AwdyAgo6leCuF37aWDoCF10Lm6TF/wUJ4FG16qchsh7eOwU0MzsNkaI
         tfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910116; x=1729514916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbgXbq9rHlIRzZR1D8yBbdkGrB9JBUyDekQP9rIMRgY=;
        b=Mhr5azH9yeTGorYkaV/yFN1fBT9SrTZ1wvYWxZEv00BcQJhRDPtt0eTaT4onx4wr4V
         wFhd2QL8vE5m4uSorjL+YyHuMg5oftN99Kk0SeC9WiEhhT6+uONP0r5Y21x+jLoPj5Se
         jIdTkGqUnYudWhBDbAaa3nx4eVXyrvQ28Y5iTxPUljg+X/dq/Pgbb99TNkTCBABJNjLv
         nHAEXp9fgk3Pw8+QOc1DLcQ5+1AfpESUgxuH/qkG/E0hBTGMUzxg+kTiWo46Ax0hbQl6
         NfvKFVNvc1x8KmbnE3dfToZRuXRpF+SAfbZlkdwbJmIsnoxZC+RNAQ7viONkZ19N+Bkp
         6+rQ==
X-Gm-Message-State: AOJu0YxtGb1zls7b28xva5g16NvRBF/ZDpz9FyFnJ41DZbkICEzEY8CE
	IqljEwUrtFLMu2xNTg3407r5y/1ZoBcoI2sB5ntC1up4JiZjUSopuIh4YUWourbIoBmbiKZXDWW
	YZhBaS+AnPVUStK3VBzaAwx1Ko1MVo+LDa7m2lSfZyeBqb9vp
X-Google-Smtp-Source: AGHT+IEjcKlLZkOhNIL0a/rFrq/q/AxQS1HJhGk96bd3QFz4hzS+T+1MKZIr/IqkguJu3BARD7vohiuM2yzx+WWf9UQ=
X-Received: by 2002:a05:6512:6419:b0:539:e279:b3da with SMTP id
 2adb3069b0e04-539e279b507mr4534483e87.18.1728910115681; Mon, 14 Oct 2024
 05:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHJ97wTDiqgOHfLJc3pEjz=ZwpWP4LJV7sxUfYxQmkryi-rv0A@mail.gmail.com>
 <73e05f2e-2e0c-4a72-94a6-3f618b0e616e@gmail.com> <CAHJ97wRJQ4qm_Hxx=FB8ZzD3O7njLYX7mcPvMvRbsdu=T7VZrg@mail.gmail.com>
 <d49e275f-7526-4eb4-aa9c-31975aecbfc6@gmail.com> <CAHJ97wRoaOAXASnWOwADQpL0pcsosRscNyQZFxnTYj76M4eE+g@mail.gmail.com>
In-Reply-To: <CAHJ97wRoaOAXASnWOwADQpL0pcsosRscNyQZFxnTYj76M4eE+g@mail.gmail.com>
From: Luc Willems <luc.willems@t-m-m.be>
Date: Mon, 14 Oct 2024 14:48:23 +0200
Message-ID: <CAHJ97wSAiwJgA297ry7z37kPut_jqYXGEakkbyKK6tJXvtCmOw@mail.gmail.com>
Subject: Re: r8169 unknown chip XID 688
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

small correction, it took some time but dhcp has finally assigned an ip add=
ress

I could run iperf3 on it, getting 2.35Gbits/sec for a short test.
but after reboot i lost connectivity again , even switching to static
ip did not provide a solution.

so for the moment, not very stable.
seems we need to wait to have specific firmware.





On Mon, Oct 14, 2024 at 2:31=E2=80=AFPM Luc Willems <luc.willems@t-m-m.be> =
wrote:
>
> after last patch, i now have an ens16 interface but not able to assign
> ip using static or dhcp
>
> [    0.586421] r8169 0000:00:10.0 eth0: RTL8125D, 10:ff:e0:6b:66:98,
> XID 688, IRQ 46
> [    0.586424] r8169 0000:00:10.0 eth0: jumbo features [frames: 9194
> bytes, tx checksumming: ko]
> [    0.789719] r8169 0000:00:10.0 ens16: renamed from eth0
> [   13.583533] r8169 0000:00:10.0: firmware: failed to load
> rtl_nic/rtl8125d-1.fw (-2)
> [   13.583541] r8169 0000:00:10.0: firmware: failed to load
> rtl_nic/rtl8125d-1.fw (-2)
> [   13.583542] r8169 0000:00:10.0: Direct firmware load for
> rtl_nic/rtl8125d-1.fw failed with error -2
> [   13.583544] r8169 0000:00:10.0: Unable to load firmware
> rtl_nic/rtl8125d-1.fw (-2)
> [   13.609457] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-80:00: attached
> PHY driver (mii_bus:phy_addr=3Dr8169-0-80:00, irq=3DMAC)
> [   13.737853] r8169 0000:00:10.0 ens16: Link is Down
> [   16.937666] r8169 0000:00:10.0 ens16: Link is Up - 2.5Gbps/Full -
> flow control rx/tx
> root@prxmox-kernel:~#
>
> On Mon, Oct 14, 2024 at 12:22=E2=80=AFPM Heiner Kallweit <hkallweit1@gmai=
l.com> wrote:
> >
> > On 14.10.2024 02:05, Luc Willems wrote:
> > > HI ,
> > >
> > > installed the patch on a debian-backports 6.10.11 kernel in a VM (KVM=
)
> > > with the realtek injected using pci pass through.
> > > i had to modify the patch a bit, removing the RTL_GIGA_MAC_VER_63
> > > related entries because these don't seem to be in this kernel
> > >
> > > running this kernel gives me this result now
> > >
> > > root@prxmox-kernel:~# uname -a
> > > Linux prxmox-kernel 6.10+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC
> > > Debian 6.10.11-1~bpo12+1r8169p1 (2024-10- x86_64 GNU/Linux
> > > root@prxmox-kernel:~# dmesg |grep r8169
> > > [    0.000000] Linux version 6.10+unreleased-amd64
> > > (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-12 (Debian
> > > 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP
> > > PREEMPT_DYNAMIC Debian 6.10.
> > > 11-1~bpo12+1r8169p1 (2024-10-
> > > [    0.585895] r8169 0000:00:10.0: no dedicated PHY driver found for
> > > PHY ID 0x001cc841, maybe realtek.ko needs to be added to initramfs?
> > > [    0.586010] r8169 0000:00:10.0: probe with driver r8169 failed wit=
h error -49
> > >
> > > root@prxmox-kernel:~# modinfo r8169
> > > filename:
> > > /lib/modules/6.10+unreleased-amd64/kernel/drivers/net/ethernet/realte=
k/r8169.ko.xz
> > > firmware:       rtl_nic/rtl8126a-2.fw
> > > firmware:       rtl_nic/rtl8125d-1.fw
> > > firmware:       rtl_nic/rtl8125b-2.fw
> > > firmware:       rtl_nic/rtl8125a-3.fw
> > > firmware:       rtl_nic/rtl8107e-2.fw
> > > firmware:       rtl_nic/rtl8168fp-3.fw
> > > firmware:       rtl_nic/rtl8168h-2.fw
> > > firmware:       rtl_nic/rtl8168g-3.fw
> > > firmware:       rtl_nic/rtl8168g-2.fw
> > > firmware:       rtl_nic/rtl8106e-2.fw
> > > firmware:       rtl_nic/rtl8106e-1.fw
> > > firmware:       rtl_nic/rtl8411-2.fw
> > > firmware:       rtl_nic/rtl8411-1.fw
> > > firmware:       rtl_nic/rtl8402-1.fw
> > > firmware:       rtl_nic/rtl8168f-2.fw
> > > firmware:       rtl_nic/rtl8168f-1.fw
> > > firmware:       rtl_nic/rtl8105e-1.fw
> > > firmware:       rtl_nic/rtl8168e-3.fw
> > > firmware:       rtl_nic/rtl8168e-2.fw
> > > firmware:       rtl_nic/rtl8168e-1.fw
> > > firmware:       rtl_nic/rtl8168d-2.fw
> > > firmware:       rtl_nic/rtl8168d-1.fw
> > > license:        GPL
> > > softdep:        pre: realtek
> > > description:    RealTek RTL-8169 Gigabit Ethernet driver
> > > author:         Realtek and the Linux r8169 crew <netdev@vger.kernel.=
org>
> > > alias:          pci:v000010ECd00003000sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00008126sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00008125sv*sd*bc*sc*i*
> > > alias:          pci:v00000001d00008168sv*sd00002410bc*sc*i*
> > > alias:          pci:v00001737d00001032sv*sd00000024bc*sc*i*
> > > alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*
> > > alias:          pci:v00001259d0000C107sv*sd*bc*sc*i*
> > > alias:          pci:v00001186d00004302sv*sd*bc*sc*i*
> > > alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
> > > alias:          pci:v00001186d00004300sv00001186sd00004B10bc*sc*i*
> > > alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
> > > alias:          pci:v000010FFd00008168sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00008168sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00008167sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00008162sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00008161sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00008136sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00002600sv*sd*bc*sc*i*
> > > alias:          pci:v000010ECd00002502sv*sd*bc*sc*i*
> > > depends:        libphy,mdio_devres
> > > retpoline:      Y
> > > intree:         Y
> > > name:           r8169
> > > vermagic:       6.10+unreleased-amd64 SMP preempt mod_unload modversi=
ons
> > >
> > > root@prxmox-kernel:~# lsmod |grep real
> > > realtek                45056  0
> > > libphy                225280  3 r8169,mdio_devres,realtek
> > > root@prxmox-kernel:~#
> > >
> > > On Sun, Oct 13, 2024 at 10:44=E2=80=AFAM Heiner Kallweit <hkallweit1@=
gmail.com> wrote:
> > >>
> > >> On 12.10.2024 21:03, Luc Willems wrote:
> > >>> using new gigabyte X870E AORUS ELITE WIFI7 board, running proxmox p=
ve kernel
> > >>>
> > >>> Linux linux-s05 6.8.12-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-2
> > >>> (2024-09-05T10:03Z) x86_64 GNU/Linux
> > >>>
> > >>> 11:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL812=
5
> > >>> 2.5GbE Controller (rev 0c)
> > >>>         Subsystem: Gigabyte Technology Co., Ltd RTL8125 2.5GbE Cont=
roller
> > >>>         Flags: fast devsel, IRQ 43, IOMMU group 26
> > >>>         I/O ports at e000 [size=3D256]
> > >>>         Memory at dd900000 (64-bit, non-prefetchable) [size=3D64K]
> > >>>         Memory at dd910000 (64-bit, non-prefetchable) [size=3D16K]
> > >>>         Capabilities: [40] Power Management version 3
> > >>>         Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit=
+
> > >>>         Capabilities: [70] Express Endpoint, MSI 01
> > >>>         Capabilities: [b0] MSI-X: Enable- Count=3D64 Masked-
> > >>>         Capabilities: [d0] Vital Product Data
> > >>>         Capabilities: [100] Advanced Error Reporting
> > >>>         Capabilities: [148] Virtual Channel
> > >>>         Capabilities: [164] Device Serial Number 01-00-00-00-68-4c-=
e0-00
> > >>>         Capabilities: [174] Transaction Processing Hints
> > >>>         Capabilities: [200] Latency Tolerance Reporting
> > >>>         Capabilities: [208] L1 PM Substates
> > >>>         Capabilities: [218] Vendor Specific Information: ID=3D0002 =
Rev=3D4
> > >>> Len=3D100 <?>
> > >>>         Kernel modules: r8169
> > >>>
> > >>> root@linux-s05:/root# dmesg |grep r8169
> > >>> [    6.353276] r8169 0000:11:00.0: error -ENODEV: unknown chip XID
> > >>> 688, contact r8169 maintainers (see MAINTAINERS file)
> > >>>
> > >>
> > >> Below is a patch with experimental support for RTL8125D. Could you
> > >> please test it? Few notes:
> > >> - Depending on the PHY ID of the integrated PHY you may receive an
> > >>   error message that there's no dedicated PHY driver. Please forward=
 the
> > >>   error message with the PHY ID in this case.
> > >> - As long as the firmware for this chip version isn't available, lin=
k
> > >>   might be unstable or worst case completely missing. Driver will co=
mplain
> > >>   about the missing firmware file, but this error message can be ign=
ored for now.
> > >>
> > >> ---
> > >>  drivers/net/ethernet/realtek/r8169.h          |  1 +
> > >>  drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++++++++++---=
---
> > >>  .../net/ethernet/realtek/r8169_phy_config.c   |  7 ++++++
> > >>  3 files changed, 24 insertions(+), 7 deletions(-)
> > >>
> > >> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethe=
rnet/realtek/r8169.h
> > >> index e2db944e6..be4c96226 100644
> > >> --- a/drivers/net/ethernet/realtek/r8169.h
> > >> +++ b/drivers/net/ethernet/realtek/r8169.h
> > >> @@ -68,6 +68,7 @@ enum mac_version {
> > >>         /* support for RTL_GIGA_MAC_VER_60 has been removed */
> > >>         RTL_GIGA_MAC_VER_61,
> > >>         RTL_GIGA_MAC_VER_63,
> > >> +       RTL_GIGA_MAC_VER_64,
> > >>         RTL_GIGA_MAC_VER_65,
> > >>         RTL_GIGA_MAC_VER_66,
> > >>         RTL_GIGA_MAC_NONE
> > >> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net=
/ethernet/realtek/r8169_main.c
> > >> index 1a2322824..dcd176a77 100644
> > >> --- a/drivers/net/ethernet/realtek/r8169_main.c
> > >> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > >> @@ -56,6 +56,7 @@
> > >>  #define FIRMWARE_8107E_2       "rtl_nic/rtl8107e-2.fw"
> > >>  #define FIRMWARE_8125A_3       "rtl_nic/rtl8125a-3.fw"
> > >>  #define FIRMWARE_8125B_2       "rtl_nic/rtl8125b-2.fw"
> > >> +#define FIRMWARE_8125D_1       "rtl_nic/rtl8125d-1.fw"
> > >>  #define FIRMWARE_8126A_2       "rtl_nic/rtl8126a-2.fw"
> > >>  #define FIRMWARE_8126A_3       "rtl_nic/rtl8126a-3.fw"
> > >>
> > >> @@ -139,6 +140,7 @@ static const struct {
> > >>         [RTL_GIGA_MAC_VER_61] =3D {"RTL8125A",            FIRMWARE_8=
125A_3},
> > >>         /* reserve 62 for CFG_METHOD_4 in the vendor driver */
> > >>         [RTL_GIGA_MAC_VER_63] =3D {"RTL8125B",            FIRMWARE_8=
125B_2},
> > >> +       [RTL_GIGA_MAC_VER_64] =3D {"RTL8125D",            FIRMWARE_8=
125D_1},
> > >>         [RTL_GIGA_MAC_VER_65] =3D {"RTL8126A",            FIRMWARE_8=
126A_2},
> > >>         [RTL_GIGA_MAC_VER_66] =3D {"RTL8126A",            FIRMWARE_8=
126A_3},
> > >>  };
> > >> @@ -708,6 +710,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
> > >>  MODULE_FIRMWARE(FIRMWARE_8107E_2);
> > >>  MODULE_FIRMWARE(FIRMWARE_8125A_3);
> > >>  MODULE_FIRMWARE(FIRMWARE_8125B_2);
> > >> +MODULE_FIRMWARE(FIRMWARE_8125D_1);
> > >>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
> > >>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
> > >>
> > >> @@ -2099,10 +2102,7 @@ static void rtl_set_eee_txidle_timer(struct r=
tl8169_private *tp)
> > >>                 tp->tx_lpi_timer =3D timer_val;
> > >>                 r8168_mac_ocp_write(tp, 0xe048, timer_val);
> > >>                 break;
> > >> -       case RTL_GIGA_MAC_VER_61:
> > >> -       case RTL_GIGA_MAC_VER_63:
> > >> -       case RTL_GIGA_MAC_VER_65:
> > >> -       case RTL_GIGA_MAC_VER_66:
> > >> +       case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
> > >>                 tp->tx_lpi_timer =3D timer_val;
> > >>                 RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
> > >>                 break;
> > >> @@ -2234,6 +2234,9 @@ static enum mac_version rtl8169_get_mac_versio=
n(u16 xid, bool gmii)
> > >>                 { 0x7cf, 0x64a, RTL_GIGA_MAC_VER_66 },
> > >>                 { 0x7cf, 0x649, RTL_GIGA_MAC_VER_65 },
> > >>
> > >> +               /* 8125D family. */
> > >> +               { 0x7cf, 0x688, RTL_GIGA_MAC_VER_64 },
> > >> +
> > >>                 /* 8125B family. */
> > >>                 { 0x7cf, 0x641, RTL_GIGA_MAC_VER_63 },
> > >>
> > >> @@ -2501,9 +2504,7 @@ static void rtl_init_rxcfg(struct rtl8169_priv=
ate *tp)
> > >>         case RTL_GIGA_MAC_VER_61:
> > >>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BU=
RST);
> > >>                 break;
> > >> -       case RTL_GIGA_MAC_VER_63:
> > >> -       case RTL_GIGA_MAC_VER_65:
> > >> -       case RTL_GIGA_MAC_VER_66:
> > >> +       case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
> > >>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BU=
RST |
> > >>                         RX_PAUSE_SLOT_ON);
> > >>                 break;
> > >> @@ -3815,6 +3816,12 @@ static void rtl_hw_start_8125b(struct rtl8169=
_private *tp)
> > >>         rtl_hw_start_8125_common(tp);
> > >>  }
> > >>
> > >> +static void rtl_hw_start_8125d(struct rtl8169_private *tp)
> > >> +{
> > >> +       rtl_set_def_aspm_entry_latency(tp);
> > >> +       rtl_hw_start_8125_common(tp);
> > >> +}
> > >> +
> > >>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
> > >>  {
> > >>         rtl_set_def_aspm_entry_latency(tp);
> > >> @@ -3863,6 +3870,7 @@ static void rtl_hw_config(struct rtl8169_priva=
te *tp)
> > >>                 [RTL_GIGA_MAC_VER_53] =3D rtl_hw_start_8117,
> > >>                 [RTL_GIGA_MAC_VER_61] =3D rtl_hw_start_8125a_2,
> > >>                 [RTL_GIGA_MAC_VER_63] =3D rtl_hw_start_8125b,
> > >> +               [RTL_GIGA_MAC_VER_64] =3D rtl_hw_start_8125d,
> > >>                 [RTL_GIGA_MAC_VER_65] =3D rtl_hw_start_8126a,
> > >>                 [RTL_GIGA_MAC_VER_66] =3D rtl_hw_start_8126a,
> > >>         };
> > >> @@ -3880,6 +3888,7 @@ static void rtl_hw_start_8125(struct rtl8169_p=
rivate *tp)
> > >>         /* disable interrupt coalescing */
> > >>         switch (tp->mac_version) {
> > >>         case RTL_GIGA_MAC_VER_61:
> > >> +       case RTL_GIGA_MAC_VER_64:
> > >>                 for (i =3D 0xa00; i < 0xb00; i +=3D 4)
> > >>                         RTL_W32(tp, i, 0);
> > >>                 break;
> > >> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drive=
rs/net/ethernet/realtek/r8169_phy_config.c
> > >> index cf29b1208..6b70f23c8 100644
> > >> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> > >> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> > >> @@ -1104,6 +1104,12 @@ static void rtl8125b_hw_phy_config(struct rtl=
8169_private *tp,
> > >>         rtl8125b_config_eee_phy(phydev);
> > >>  }
> > >>
> > >> +static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
> > >> +                                  struct phy_device *phydev)
> > >> +{
> > >> +       r8169_apply_firmware(tp);
> > >> +}
> > >> +
> > >>  static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
> > >>                                    struct phy_device *phydev)
> > >>  {
> > >> @@ -1160,6 +1166,7 @@ void r8169_hw_phy_config(struct rtl8169_privat=
e *tp, struct phy_device *phydev,
> > >>                 [RTL_GIGA_MAC_VER_53] =3D rtl8117_hw_phy_config,
> > >>                 [RTL_GIGA_MAC_VER_61] =3D rtl8125a_2_hw_phy_config,
> > >>                 [RTL_GIGA_MAC_VER_63] =3D rtl8125b_hw_phy_config,
> > >> +               [RTL_GIGA_MAC_VER_64] =3D rtl8125d_hw_phy_config,
> > >>                 [RTL_GIGA_MAC_VER_65] =3D rtl8126a_hw_phy_config,
> > >>                 [RTL_GIGA_MAC_VER_66] =3D rtl8126a_hw_phy_config,
> > >>         };
> > >> --
> > >> 2.47.0
> > >>
> > >>
> > >
> > >
> >
> > Thanks for testing. For PHY ID 0x001cc841 there's no PHY driver yet.
> > Following isn't a proper patch but just a quick hack to see whether
> > it makes your NIC work. Could you please apply this change on top
> > and re-test?
> >
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index 166f6a728..1bb8139cb 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -1348,7 +1348,7 @@ static struct phy_driver realtek_drvs[] =3D {
> >                 .read_mmd       =3D rtl822x_read_mmd,
> >                 .write_mmd      =3D rtl822x_write_mmd,
> >         }, {
> > -               PHY_ID_MATCH_EXACT(0x001cc840),
> > +               PHY_ID_MATCH_EXACT(0x001cc841),
> >                 .name           =3D "RTL8226B_RTL8221B 2.5Gbps PHY",
> >                 .get_features   =3D rtl822x_get_features,
> >                 .config_aneg    =3D rtl822x_config_aneg,
> >
> >
> >
>
>
> --
> T.M.M BV
> Luc Willems
> Schoolblok 7
> 2275 Lille
>
>
> mobile: 0478/959140
> email: luc.willems@t-m-m.be



--=20
T.M.M BV
Luc Willems
Schoolblok 7
2275 Lille


mobile: 0478/959140
email: luc.willems@t-m-m.be

