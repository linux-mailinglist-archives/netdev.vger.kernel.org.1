Return-Path: <netdev+bounces-135016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418F99BCD4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 02:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBDD1C20DF1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 00:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A920EB;
	Mon, 14 Oct 2024 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-m-m-be.20230601.gappssmtp.com header.i=@t-m-m-be.20230601.gappssmtp.com header.b="H/fNRZvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB1380
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728864349; cv=none; b=saVkvpQdF9XXnVyAAKvN8Pq88jdYHoM+JTHNh7v+rPLIQSd9QeuAYZsJbjixdY8LFN/QS1utaXxKWpwnBZ2XNMdkopaa60ZwUII1c5IGiQ7KMFCEk+dIKsWIzjl7LBdNJXJaeqb7ef7oSHUuvnBTXLQY2h/glZlHnnICUL9Et0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728864349; c=relaxed/simple;
	bh=YLBKnIBP67xM5lBeJ6Ef8nz0r+19lY9WUW1iDHZNBRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mowAuzI1XuMlUE0HkHSgA1TU2X7jM3TWClQtLU5fuw1NMQogJRyMX/FHvqMcV5bOgO9dnRyTdV3FpA8xUO2xvgtkZBlBGT4wAdOvD9d/uxGabJB2Uni2It3+HW3z7CS3CuIREYmWIueH9rY/kRZT4+zrg0FC6l0wLXTWvxwZ+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-m-m.be; spf=pass smtp.mailfrom=t-m-m.be; dkim=pass (2048-bit key) header.d=t-m-m-be.20230601.gappssmtp.com header.i=@t-m-m-be.20230601.gappssmtp.com header.b=H/fNRZvC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-m-m.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-m-m.be
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so642682e87.1
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=t-m-m-be.20230601.gappssmtp.com; s=20230601; t=1728864343; x=1729469143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldjYLpHTshIvQAAuih4LM8b+XCiVXT7KC2aR7A+7Vc8=;
        b=H/fNRZvCNmt4bwE1m6gMloQVGQ7o0wzvMOwFSZaZWfQWtBd9qw4pw/TDqlOS7+l8yF
         cNiXNCzr7e9BJhOe+WezWHGiRyuwhZL3UqCkMZNTZwGaaueubFdYSOqXXtcQXBSQVWHQ
         Nvx5V/WU/P6WbASVqi0LJ0nRHAtJrbNAvCkzVnQ/uJgg1vQP648YSDgntIXF8hfVBysc
         +Hb7/bwSZPVs20Tbmuc7MUrqwPFjpmexfH656TDkig1Q1zLmwYJSlB2uf2a9q6IZHUwp
         dW48pDaoqQRpGPsNZe80M15A0iwp7WYXmCn94ObXYv8A4zxt0o2wbwEe7lKiJ2hSLlGd
         XYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728864343; x=1729469143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldjYLpHTshIvQAAuih4LM8b+XCiVXT7KC2aR7A+7Vc8=;
        b=nP4YXD8bIZYNVUpH5Rj6eL7U/y6QAF+OC/fOXkHpVhdCXAf+mxky/Y/iwAJ5O4EUat
         yMooXa/sgOs/38X1FeG0RsdzuQr4kGs/B0hgOsuTDs623iBPNQzUEVE7oJukD4YEZxFt
         Qfst41JqfLQ+I1Z746aY0pB8KDqruYX/693S3WKDbq598LoyvSHw7xK3mLAZhikPm3sV
         2KyMBxKxMYjy3PUHvDfnEl+hibOnomygp4+1ZqYwStXhmYX3HU7Td0P+GyiSjUVVplCo
         SrBTo+11OrnYrSTFmxYSt6KsWBA7ECoLrUoWTSfmpeRICJxE4PWK9fQXd6UvbHVEiQyq
         BbkA==
X-Gm-Message-State: AOJu0YyzcVepySh4nHKHaPBQ9xRDpKuOBef9nE6DdS/SWEsml73xoTky
	nmaFcYNMaui/3tPGZbltbXkWOwPd2Zb7CYf2drqUce16upRXLRRCtY3XlPOqQ3x2UKT2CV0BgJe
	Sv4B3jQg5VpfFAfpxrrbc5mweP1hsFtY1aJyyTQ==
X-Google-Smtp-Source: AGHT+IHV3sD5O6zvpvHxgkJXf4pd0CS4e08Vn4AmbSxbd10jMEeN/7wJW+gqaLo+1n51hGtALk/L3A23q/PLbKuUJLU=
X-Received: by 2002:a05:6512:108e:b0:539:ee0d:2bb4 with SMTP id
 2adb3069b0e04-539ee0d2dabmr944331e87.45.1728864343045; Sun, 13 Oct 2024
 17:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHJ97wTDiqgOHfLJc3pEjz=ZwpWP4LJV7sxUfYxQmkryi-rv0A@mail.gmail.com>
 <73e05f2e-2e0c-4a72-94a6-3f618b0e616e@gmail.com>
In-Reply-To: <73e05f2e-2e0c-4a72-94a6-3f618b0e616e@gmail.com>
From: Luc Willems <luc.willems@t-m-m.be>
Date: Mon, 14 Oct 2024 02:05:31 +0200
Message-ID: <CAHJ97wRJQ4qm_Hxx=FB8ZzD3O7njLYX7mcPvMvRbsdu=T7VZrg@mail.gmail.com>
Subject: Re: r8169 unknown chip XID 688
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI ,

installed the patch on a debian-backports 6.10.11 kernel in a VM (KVM)
with the realtek injected using pci pass through.
i had to modify the patch a bit, removing the RTL_GIGA_MAC_VER_63
related entries because these don't seem to be in this kernel

running this kernel gives me this result now

root@prxmox-kernel:~# uname -a
Linux prxmox-kernel 6.10+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC
Debian 6.10.11-1~bpo12+1r8169p1 (2024-10- x86_64 GNU/Linux
root@prxmox-kernel:~# dmesg |grep r8169
[    0.000000] Linux version 6.10+unreleased-amd64
(debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-12 (Debian
12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP
PREEMPT_DYNAMIC Debian 6.10.
11-1~bpo12+1r8169p1 (2024-10-
[    0.585895] r8169 0000:00:10.0: no dedicated PHY driver found for
PHY ID 0x001cc841, maybe realtek.ko needs to be added to initramfs?
[    0.586010] r8169 0000:00:10.0: probe with driver r8169 failed with erro=
r -49

root@prxmox-kernel:~# modinfo r8169
filename:
/lib/modules/6.10+unreleased-amd64/kernel/drivers/net/ethernet/realtek/r816=
9.ko.xz
firmware:       rtl_nic/rtl8126a-2.fw
firmware:       rtl_nic/rtl8125d-1.fw
firmware:       rtl_nic/rtl8125b-2.fw
firmware:       rtl_nic/rtl8125a-3.fw
firmware:       rtl_nic/rtl8107e-2.fw
firmware:       rtl_nic/rtl8168fp-3.fw
firmware:       rtl_nic/rtl8168h-2.fw
firmware:       rtl_nic/rtl8168g-3.fw
firmware:       rtl_nic/rtl8168g-2.fw
firmware:       rtl_nic/rtl8106e-2.fw
firmware:       rtl_nic/rtl8106e-1.fw
firmware:       rtl_nic/rtl8411-2.fw
firmware:       rtl_nic/rtl8411-1.fw
firmware:       rtl_nic/rtl8402-1.fw
firmware:       rtl_nic/rtl8168f-2.fw
firmware:       rtl_nic/rtl8168f-1.fw
firmware:       rtl_nic/rtl8105e-1.fw
firmware:       rtl_nic/rtl8168e-3.fw
firmware:       rtl_nic/rtl8168e-2.fw
firmware:       rtl_nic/rtl8168e-1.fw
firmware:       rtl_nic/rtl8168d-2.fw
firmware:       rtl_nic/rtl8168d-1.fw
license:        GPL
softdep:        pre: realtek
description:    RealTek RTL-8169 Gigabit Ethernet driver
author:         Realtek and the Linux r8169 crew <netdev@vger.kernel.org>
alias:          pci:v000010ECd00003000sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008126sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008125sv*sd*bc*sc*i*
alias:          pci:v00000001d00008168sv*sd00002410bc*sc*i*
alias:          pci:v00001737d00001032sv*sd00000024bc*sc*i*
alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*
alias:          pci:v00001259d0000C107sv*sd*bc*sc*i*
alias:          pci:v00001186d00004302sv*sd*bc*sc*i*
alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
alias:          pci:v00001186d00004300sv00001186sd00004B10bc*sc*i*
alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
alias:          pci:v000010FFd00008168sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008168sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008167sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008162sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008161sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008136sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
alias:          pci:v000010ECd00002600sv*sd*bc*sc*i*
alias:          pci:v000010ECd00002502sv*sd*bc*sc*i*
depends:        libphy,mdio_devres
retpoline:      Y
intree:         Y
name:           r8169
vermagic:       6.10+unreleased-amd64 SMP preempt mod_unload modversions

root@prxmox-kernel:~# lsmod |grep real
realtek                45056  0
libphy                225280  3 r8169,mdio_devres,realtek
root@prxmox-kernel:~#

On Sun, Oct 13, 2024 at 10:44=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> On 12.10.2024 21:03, Luc Willems wrote:
> > using new gigabyte X870E AORUS ELITE WIFI7 board, running proxmox pve k=
ernel
> >
> > Linux linux-s05 6.8.12-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-2
> > (2024-09-05T10:03Z) x86_64 GNU/Linux
> >
> > 11:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
> > 2.5GbE Controller (rev 0c)
> >         Subsystem: Gigabyte Technology Co., Ltd RTL8125 2.5GbE Controll=
er
> >         Flags: fast devsel, IRQ 43, IOMMU group 26
> >         I/O ports at e000 [size=3D256]
> >         Memory at dd900000 (64-bit, non-prefetchable) [size=3D64K]
> >         Memory at dd910000 (64-bit, non-prefetchable) [size=3D16K]
> >         Capabilities: [40] Power Management version 3
> >         Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
> >         Capabilities: [70] Express Endpoint, MSI 01
> >         Capabilities: [b0] MSI-X: Enable- Count=3D64 Masked-
> >         Capabilities: [d0] Vital Product Data
> >         Capabilities: [100] Advanced Error Reporting
> >         Capabilities: [148] Virtual Channel
> >         Capabilities: [164] Device Serial Number 01-00-00-00-68-4c-e0-0=
0
> >         Capabilities: [174] Transaction Processing Hints
> >         Capabilities: [200] Latency Tolerance Reporting
> >         Capabilities: [208] L1 PM Substates
> >         Capabilities: [218] Vendor Specific Information: ID=3D0002 Rev=
=3D4
> > Len=3D100 <?>
> >         Kernel modules: r8169
> >
> > root@linux-s05:/root# dmesg |grep r8169
> > [    6.353276] r8169 0000:11:00.0: error -ENODEV: unknown chip XID
> > 688, contact r8169 maintainers (see MAINTAINERS file)
> >
>
> Below is a patch with experimental support for RTL8125D. Could you
> please test it? Few notes:
> - Depending on the PHY ID of the integrated PHY you may receive an
>   error message that there's no dedicated PHY driver. Please forward the
>   error message with the PHY ID in this case.
> - As long as the firmware for this chip version isn't available, link
>   might be unstable or worst case completely missing. Driver will complai=
n
>   about the missing firmware file, but this error message can be ignored =
for now.
>
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++++++++++------
>  .../net/ethernet/realtek/r8169_phy_config.c   |  7 ++++++
>  3 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/=
realtek/r8169.h
> index e2db944e6..be4c96226 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -68,6 +68,7 @@ enum mac_version {
>         /* support for RTL_GIGA_MAC_VER_60 has been removed */
>         RTL_GIGA_MAC_VER_61,
>         RTL_GIGA_MAC_VER_63,
> +       RTL_GIGA_MAC_VER_64,
>         RTL_GIGA_MAC_VER_65,
>         RTL_GIGA_MAC_VER_66,
>         RTL_GIGA_MAC_NONE
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 1a2322824..dcd176a77 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -56,6 +56,7 @@
>  #define FIRMWARE_8107E_2       "rtl_nic/rtl8107e-2.fw"
>  #define FIRMWARE_8125A_3       "rtl_nic/rtl8125a-3.fw"
>  #define FIRMWARE_8125B_2       "rtl_nic/rtl8125b-2.fw"
> +#define FIRMWARE_8125D_1       "rtl_nic/rtl8125d-1.fw"
>  #define FIRMWARE_8126A_2       "rtl_nic/rtl8126a-2.fw"
>  #define FIRMWARE_8126A_3       "rtl_nic/rtl8126a-3.fw"
>
> @@ -139,6 +140,7 @@ static const struct {
>         [RTL_GIGA_MAC_VER_61] =3D {"RTL8125A",            FIRMWARE_8125A_=
3},
>         /* reserve 62 for CFG_METHOD_4 in the vendor driver */
>         [RTL_GIGA_MAC_VER_63] =3D {"RTL8125B",            FIRMWARE_8125B_=
2},
> +       [RTL_GIGA_MAC_VER_64] =3D {"RTL8125D",            FIRMWARE_8125D_=
1},
>         [RTL_GIGA_MAC_VER_65] =3D {"RTL8126A",            FIRMWARE_8126A_=
2},
>         [RTL_GIGA_MAC_VER_66] =3D {"RTL8126A",            FIRMWARE_8126A_=
3},
>  };
> @@ -708,6 +710,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
>  MODULE_FIRMWARE(FIRMWARE_8107E_2);
>  MODULE_FIRMWARE(FIRMWARE_8125A_3);
>  MODULE_FIRMWARE(FIRMWARE_8125B_2);
> +MODULE_FIRMWARE(FIRMWARE_8125D_1);
>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
>
> @@ -2099,10 +2102,7 @@ static void rtl_set_eee_txidle_timer(struct rtl816=
9_private *tp)
>                 tp->tx_lpi_timer =3D timer_val;
>                 r8168_mac_ocp_write(tp, 0xe048, timer_val);
>                 break;
> -       case RTL_GIGA_MAC_VER_61:
> -       case RTL_GIGA_MAC_VER_63:
> -       case RTL_GIGA_MAC_VER_65:
> -       case RTL_GIGA_MAC_VER_66:
> +       case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
>                 tp->tx_lpi_timer =3D timer_val;
>                 RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
>                 break;
> @@ -2234,6 +2234,9 @@ static enum mac_version rtl8169_get_mac_version(u16=
 xid, bool gmii)
>                 { 0x7cf, 0x64a, RTL_GIGA_MAC_VER_66 },
>                 { 0x7cf, 0x649, RTL_GIGA_MAC_VER_65 },
>
> +               /* 8125D family. */
> +               { 0x7cf, 0x688, RTL_GIGA_MAC_VER_64 },
> +
>                 /* 8125B family. */
>                 { 0x7cf, 0x641, RTL_GIGA_MAC_VER_63 },
>
> @@ -2501,9 +2504,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *=
tp)
>         case RTL_GIGA_MAC_VER_61:
>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
>                 break;
> -       case RTL_GIGA_MAC_VER_63:
> -       case RTL_GIGA_MAC_VER_65:
> -       case RTL_GIGA_MAC_VER_66:
> +       case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
>                         RX_PAUSE_SLOT_ON);
>                 break;
> @@ -3815,6 +3816,12 @@ static void rtl_hw_start_8125b(struct rtl8169_priv=
ate *tp)
>         rtl_hw_start_8125_common(tp);
>  }
>
> +static void rtl_hw_start_8125d(struct rtl8169_private *tp)
> +{
> +       rtl_set_def_aspm_entry_latency(tp);
> +       rtl_hw_start_8125_common(tp);
> +}
> +
>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>  {
>         rtl_set_def_aspm_entry_latency(tp);
> @@ -3863,6 +3870,7 @@ static void rtl_hw_config(struct rtl8169_private *t=
p)
>                 [RTL_GIGA_MAC_VER_53] =3D rtl_hw_start_8117,
>                 [RTL_GIGA_MAC_VER_61] =3D rtl_hw_start_8125a_2,
>                 [RTL_GIGA_MAC_VER_63] =3D rtl_hw_start_8125b,
> +               [RTL_GIGA_MAC_VER_64] =3D rtl_hw_start_8125d,
>                 [RTL_GIGA_MAC_VER_65] =3D rtl_hw_start_8126a,
>                 [RTL_GIGA_MAC_VER_66] =3D rtl_hw_start_8126a,
>         };
> @@ -3880,6 +3888,7 @@ static void rtl_hw_start_8125(struct rtl8169_privat=
e *tp)
>         /* disable interrupt coalescing */
>         switch (tp->mac_version) {
>         case RTL_GIGA_MAC_VER_61:
> +       case RTL_GIGA_MAC_VER_64:
>                 for (i =3D 0xa00; i < 0xb00; i +=3D 4)
>                         RTL_W32(tp, i, 0);
>                 break;
> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/ne=
t/ethernet/realtek/r8169_phy_config.c
> index cf29b1208..6b70f23c8 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1104,6 +1104,12 @@ static void rtl8125b_hw_phy_config(struct rtl8169_=
private *tp,
>         rtl8125b_config_eee_phy(phydev);
>  }
>
> +static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
> +                                  struct phy_device *phydev)
> +{
> +       r8169_apply_firmware(tp);
> +}
> +
>  static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
>                                    struct phy_device *phydev)
>  {
> @@ -1160,6 +1166,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp=
, struct phy_device *phydev,
>                 [RTL_GIGA_MAC_VER_53] =3D rtl8117_hw_phy_config,
>                 [RTL_GIGA_MAC_VER_61] =3D rtl8125a_2_hw_phy_config,
>                 [RTL_GIGA_MAC_VER_63] =3D rtl8125b_hw_phy_config,
> +               [RTL_GIGA_MAC_VER_64] =3D rtl8125d_hw_phy_config,
>                 [RTL_GIGA_MAC_VER_65] =3D rtl8126a_hw_phy_config,
>                 [RTL_GIGA_MAC_VER_66] =3D rtl8126a_hw_phy_config,
>         };
> --
> 2.47.0
>
>


--=20
T.M.M BV
Luc Willems
Schoolblok 7
2275 Lille


mobile: 0478/959140
email: luc.willems@t-m-m.be

