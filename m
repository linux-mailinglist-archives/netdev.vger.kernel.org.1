Return-Path: <netdev+bounces-81101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21D885CF9
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD36E1F2130B
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A012C558;
	Thu, 21 Mar 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRla4iUb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9A12C54B
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037032; cv=none; b=UnhgFi8yOsJBwDBP2txptWL2gDFQGRs/6Zi4TJDYtcICXPi4OEVw0nYwnqpQVBdUNhn2duqzzavjcxAZvc4TPnIrHj++EubosLUF7YbWMdUUGf+xNh90m9NO7AOGJ5iO7r2mIfydmKqlOd6r9xrp9m13qlwKzrbFOtwwe8J0FTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037032; c=relaxed/simple;
	bh=jNRUz0jgIfEStM4yZqy3zC7tNXMNEa7Xo+ybcbIyIkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaTA4q1aegcYDiccC157rPdmm3sPZR67ioc4VZ7x2rYUaWOTioB3LP+YAMR/geIxjLY6jO1KyRL2Yt3rUM/suJ1gsUI+ulqUxAI+CxrD2DYN4AL9KpP8QEGYFmKiM9fKZfb5W0lSvbU/tE7n0rkw5pbRbKV4Eihq/NC9zxKMPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRla4iUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60BDC43394;
	Thu, 21 Mar 2024 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711037031;
	bh=jNRUz0jgIfEStM4yZqy3zC7tNXMNEa7Xo+ybcbIyIkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oRla4iUbEx6nG542xSnwJ0XyEGVpQalababI2bIf2LB8VMh9GYjl/6ByNU76m09Q3
	 Ta0xrymfq6q8VZjLbGF+4+BoRN8bwI2RK4qkEiEIDUG5UHmki4WwdiUwXzudvaSJJx
	 Rc2Rh8F1MaUiUCkbtsgeQAE0b3GNc8+mlSCq1SQ0yVtOP2W00IDU4Jx/Sam7seAoiH
	 n/96nG/WmdocJg8rVOdGHK2/rXQt2maGSzZta3L+m2+FHjQIDrKGzK8QmTn17yY2P3
	 A5x09z40g4kLyGo1MBKsOnpmG2SRz72zIBdbTnp+0CA0JjarzeKMUeScrdSjgCApNC
	 gxWiZRJDN1lPg==
Date: Thu, 21 Mar 2024 09:03:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: drozdi70 <drozdi70@o2.pl>
Cc: netdev <netdev@vger.kernel.org>, "chandrashekar.devegowda"
 <chandrashekar.devegowda@intel.com>, linuxwwan <linuxwwan@intel.com>,
 "chiranjeevi.rapolu" <chiranjeevi.rapolu@linux.intel.com>, "haijun.liu"
 <haijun.liu@mediatek.com>, "m.chetan.kumar"
 <m.chetan.kumar@linux.intel.com>, "ricardo.martinez"
 <ricardo.martinez@linux.intel.com>, "loic.poulain"
 <loic.poulain@linaro.org>, "ryazanov.s.a" <ryazanov.s.a@gmail.com>,
 johannes <johannes@sipsolutions.net>, davem <davem@davemloft.net>, edumazet
 <edumazet@google.com>, pabeni <pabeni@redhat.com>
Subject: Re: [BUG] mtk-t7xx driver on aarch64/cortex-a53
Message-ID: <20240321090349.7f3a1150@kernel.org>
In-Reply-To: <0a79d2339b29438a84986bad97290ebe@grupawp.pl>
References: <0a79d2339b29438a84986bad97290ebe@grupawp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Mar 2024 09:07:24 +0100 drozdi70 wrote:
> We are facing possible bug in the driver mtk-t7xx under OpenWrt linux 6.1=
/6.6.
>=20
> From first glance it looks like the driver is accessing an address in the=
 PCIe MMIO range in 32-bit alignment (ffffffc084a1d004)
> but likely the SoC only supports 64-bit aligned (so only addresses ending=
 on 0 or 8 will work) access there,
> hence the [ 294.051349] FSC =3D 0x21: alignment fault.

You gotta send pain text emails, linux MLs don't accept HTML.

Could you run the stack trace thru scripts/decode_stacktrace.sh
to get line numbers?

> [CUT]
> ...
> [=C2=A0=C2=A0 12.285356] mtk_t7xx 0003:01:00.0: assign IRQ: got 113
> [=C2=A0=C2=A0 12.290512] mtk_t7xx 0003:01:00.0: enabling device (0000 -> =
0002)
> [=C2=A0=C2=A0 12.296612] mtk_t7xx 0003:01:00.0: enabling bus mastering
> [=C2=A0=C2=A0 12.303087] (unnamed net_device) (dummy): netif_napi_add_wei=
ght() called with weight 128
> [=C2=A0=C2=A0 12.312160] mtk-pcie-gen3 11280000.pcie: msi#0x1 address_hi =
0x0 address_lo 0x11280c00 data 1
> [=C2=A0=C2=A0 12.320666] mtk-pcie-gen3 11280000.pcie: msi#0x2 address_hi =
0x0 address_lo 0x11280c00 data 2
> [=C2=A0=C2=A0 12.329153] mtk-pcie-gen3 11280000.pcie: msi#0x3 address_hi =
0x0 address_lo 0x11280c00 data 3
> [=C2=A0=C2=A0 12.331706] Unable to handle kernel paging request at virtua=
l address ffffffc083a1d004
> [=C2=A0=C2=A0 12.345488] Mem abort info:
> [=C2=A0=C2=A0 12.345518] mtk-pcie-gen3 11280000.pcie: msi#0x4 address_hi =
0x0 address_lo 0x11280c00 data 4
> [=C2=A0=C2=A0 12.348269]=C2=A0=C2=A0 ESR =3D 0x0000000096000061
> [=C2=A0=C2=A0 12.356716] mtk-pcie-gen3 11280000.pcie: msi#0x5 address_hi =
0x0 address_lo 0x11280c00 data 5
> [=C2=A0=C2=A0 12.360421]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =
=3D 32 bits
> [=C2=A0=C2=A0 12.368862] mtk-pcie-gen3 11280000.pcie: msi#0x6 address_hi =
0x0 address_lo 0x11280c00 data 6
> [=C2=A0=C2=A0 12.374133]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
> [=C2=A0=C2=A0 12.374135]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
> [=C2=A0=C2=A0 12.382574] mtk-pcie-gen3 11280000.pcie: msi#0x7 address_hi =
0x0 address_lo 0x11280c00 data 7
> [=C2=A0=C2=A0 12.385593]=C2=A0=C2=A0 FSC =3D 0x21: alignment fault
> [=C2=A0=C2=A0 12.388751] mtk-pcie-gen3 11280000.pcie: msi#0x8 address_hi =
0x0 address_lo 0x11280c00 data 8
> [=C2=A0=C2=A0 12.397137] Data abort info:
> [=C2=A0=C2=A0 12.397138]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000061, ISS2 =
=3D 0x00000000
> [=C2=A0=C2=A0 12.397140]=C2=A0=C2=A0 CM =3D 0, WnR =3D 1, TnD =3D 0, TagA=
ccess =3D 0
> [=C2=A0=C2=A0 12.422958]=C2=A0=C2=A0 GCS =3D 0, Overlay =3D 0, DirtyBit =
=3D 0, Xs =3D 0
> [=C2=A0=C2=A0 12.428261] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D00=
00000046ad6000
> [=C2=A0=C2=A0 12.434950] [ffffffc083a1d004] pgd=3D100000013ffff003, p4d=
=3D100000013ffff003, pud=3D100000013ffff003, pmd=3D0068000020a00711
> [=C2=A0=C2=A0 12.445552] Internal error: Oops: 0000000096000061 [#1] SMP
> [=C2=A0=C2=A0 12.451113] Modules linked in: mtk_t7xx mt7996e(O) mt792x_us=
b(O) mt792x_lib(O) mt7915e(O) mt76_usb(O) mt76_sdio(O) mt76_connac_lib(O) m=
t76(O) mac80211(O) iwlwifi(O) huawei_cdc_ncm cfg80211(O) cdc_ncm cdc_ether =
wwan usbserial usbnet slhc sfp rtc_pcf8563 nfnetlink nf_reject_ipv6 nf_reje=
ct_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mt6577_auxadc mdio_i2c =
libcrc32c compat(O) cdc_wdm cdc_acm at24 crypto_safexcel pwm_fan i2c_gpio i=
2c_smbus industrialio i2c_algo_bit i2c_mux_reg i2c_mux_pca954x i2c_mux_pca9=
541 i2c_mux_gpio i2c_mux dummy oid_registry tun sha512_arm64 sha1_ce sha1_g=
eneric seqiv md5 geniv des_generic libdes cbc authencesn authenc leds_gpio =
xhci_plat_hcd xhci_pci xhci_mtk_hcd xhci_hcd nvme nvme_core gpio_button_hot=
plug(O) dm_mirror dm_region_hash dm_log dm_crypt dm_mod dax usbcore usb_com=
mon ptp aquantia pps_core mii tpm encrypted_keys trusted
> [=C2=A0=C2=A0 12.526834] CPU: 2 PID: 1526 Comm: kworker/u9:0 Tainted: G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 6.6.22 #0
> [=C2=A0=C2=A0 12.534740] Hardware name: Bananapi BPI-R4 (DT)
> [=C2=A0=C2=A0 12.539259] Workqueue: md_hk_wq t7xx_fsm_uninit [mtk_t7xx]
> [=C2=A0=C2=A0 12.542217] sfp sfp2: module XICOM=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XC-SFP+-SR=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 rev A=C2=A0=C2=A0=C2=A0 sn C202307141626=C2=A0=C2=A0=C2=A0 =
dc 230714
> [=C2=A0=C2=A0 12.544746] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT =
-SSBS BTYPE=3D--)
> [=C2=A0=C2=A0 12.554144] mtk_soc_eth 15100000.ethernet eth1: switched to =
inband/10gbase-r link mode
> [=C2=A0=C2=A0 12.561064] pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk=
_t7xx]
> [=C2=A0=C2=A0 12.575139] lr : t7xx_cldma_start+0xac/0x13c [mtk_t7xx]
> [=C2=A0=C2=A0 12.580359] sp : ffffffc0813dbd30
> [=C2=A0=C2=A0 12.583661] x29: ffffffc0813dbd30 x28: 0000000000000000 x27:=
 0000000000000000
> [=C2=A0=C2=A0 12.590786] x26: 0000000000000000 x25: ffffff80c6888140 x24:=
 ffffff80c11f7e05
> [=C2=A0=C2=A0 12.591893] sfp sfp1: module XICOM=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XC-SFP+-LR=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 rev A=C2=A0=C2=A0=C2=A0 sn C202307141707=C2=A0=C2=A0=C2=A0 =
dc 230714
> [=C2=A0=C2=A0 12.593855] hwmon hwmon2: temp1_input not attached to any th=
ermal zone
> [=C2=A0=C2=A0 12.597909] x23: 0000000000000000 x22: ffffff80c0fdb9b8
> [=C2=A0=C2=A0 12.607297] mtk_soc_eth 15100000.ethernet eth2: switched to =
inband/10gbase-r link mode
> [=C2=A0=C2=A0 12.613792]=C2=A0 x21: ffffff80c0fdb128
> [=C2=A0=C2=A0 12.613794] x20: 0000000000000001 x19: ffffff80c0fdb080 x18:=
 0000000000000014
> [=C2=A0=C2=A0 12.631986] hwmon hwmon3: temp1_input not attached to any th=
ermal zone
> [=C2=A0=C2=A0 12.637419] x17: 00000000752a0f20 x16: 00000000468ff952 x15:=
 00000000246d1885
> [=C2=A0=C2=A0 12.651056] x14: 00000000b48c7dff x13: 000000001b6aa29e x12:=
 0000000000000001
> [=C2=A0=C2=A0 12.658180] x11: 0000000000000000 x10: 0000000000000000 x9 :=
 0000000000000000
> [=C2=A0=C2=A0 12.665304] x8 : ffffff80c90fdfb4 x7 : ffffff80c0fdb818 x6 :=
 0000000000000018
> [=C2=A0=C2=A0 12.672428] x5 : 0000000000000870 x4 : 0000000000000000 x3 :=
 0000000000000000
> [=C2=A0=C2=A0 12.679553] x2 : 00000001090f0000 x1 : ffffffc083a1d004 x0 :=
 ffffffc083a1d004
> [=C2=A0=C2=A0 12.686678] Call trace:
> [=C2=A0=C2=A0 12.689114]=C2=A0 t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mt=
k_t7xx]
> [=C2=A0=C2=A0 12.694942]=C2=A0 t7xx_fsm_uninit+0x578/0x5ec [mtk_t7xx]
> [=C2=A0=C2=A0 12.699814]=C2=A0 process_one_work+0x154/0x2a0
> [=C2=A0=C2=A0 12.703818]=C2=A0 worker_thread+0x2ac/0x488
> [=C2=A0=C2=A0 12.707558]=C2=A0 kthread+0xe0/0xec
> [=C2=A0=C2=A0 12.710603]=C2=A0 ret_from_fork+0x10/0x20
> [=C2=A0=C2=A0 12.714172] Code: f9400800 91001000 8b214001 d50332bf (f9000=
022)
> [=C2=A0=C2=A0 12.720253] ---[ end trace 0000000000000000 ]---
> [=C2=A0=C2=A0 12.731558] pstore: backend (ramoops) writing error (-28)
> [=C2=A0=C2=A0 12.736948] Kernel panic - not syncing: Oops: Fatal exception
> [=C2=A0=C2=A0 12.742680] SMP: stopping secondary CPUs
> [=C2=A0=C2=A0 12.746593] Kernel Offset: disabled
> [=C2=A0=C2=A0 12.750069] CPU features: 0x0,00000000,20000000,1000400b
> [=C2=A0=C2=A0 12.755370] Memory Limit: none
> [=C2=A0=C2=A0 12.765071] Rebooting in 1 seconds..
> PANIC at PC : 0x000000004300490c

