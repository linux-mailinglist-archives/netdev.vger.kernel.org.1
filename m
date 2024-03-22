Return-Path: <netdev+bounces-81190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F148867F1
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC34B24057
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58E1426C;
	Fri, 22 Mar 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="RraFUfUm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpo52.interia.pl (smtpo52.interia.pl [217.74.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B614A93
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094991; cv=none; b=bhMKkpAFp3fIxVIZhMZHR7FHb6GXanJUsQ9htAn8bdP3I7j8vA8/EhaFh/mg91AlnjkI246HLpTw1gF3crMmsKJ9M5eoQK4FpSEnXam1rfH98yz3HjLnXwOvPZNDoInt/3hUPuLbuZ/HkSNItnyEV8J5aepRBfa5EFF5Pfl4IxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094991; c=relaxed/simple;
	bh=831a/4TnESFp0tdtIEQSOuV7B6NQOLjtRjFdT9lLK2Y=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=I6zKZmlwm1sLjWJJfeRiKt44+4odE3Od7X2QtKy52LyEVZ5CQffY6QYchiRIVIqrcys/grhFsym8UM5KGJcVDf6t0Y0jiKNwmgwDxMye8sXAyfcyCu9WX349+YfPipxnbDFP/R5MIMXjL7r20jbD5o87qyXB9fbncrp9RQcUhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=RraFUfUm; arc=none smtp.client-ip=217.74.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Date: Fri, 22 Mar 2024 09:06:57 +0100
From: Robert <777777@poczta.fm>
Subject: [BUG] mtk-t7xx driver on aarch64/cortex-a53
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Mailer: interia.pl/pf09
Message-Id: <vglpeczsxljzntxhyjew@hpkd>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1711094835; bh=Z7wzbKyY90jdxHcCuj4Y2w4nDmk4p2ZyNNOaAt8j1N4=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type;
	b=RraFUfUmeho3tXwFtQd6jOS9hSzMT8yQUq7YgzZoR22Enxv7r9TFK+8wYzau17qNJ
	 1R6KrqVtlwYEuYzPcCjJENkm0ui1np1RqwG95ke4jxr9FwaC6HNUUe2aSouAnuA6GN
	 pOABEDVqZ/j7FLyPUjiIElJX5+uUJSHw5zhwZPME=

Hi

We are facing possible bug in the driver mtk-t7xx under OpenWrt linux 6.1/6.6.

From first glance it looks like the driver is accessing an address in the PCIe MMIO range in 32-bit alignment (ffffffc084a1d004) 
but likely the SoC only supports 64-bit aligned (so only addresses ending on 0 or 8 will work) access there, 
hence the [ 294.051349] FSC = 0x21: alignment fault.



[CUT]
...
[   12.285356] mtk_t7xx 0003:01:00.0: assign IRQ: got 113
[   12.290512] mtk_t7xx 0003:01:00.0: enabling device (0000 -> 0002)
[   12.296612] mtk_t7xx 0003:01:00.0: enabling bus mastering
[   12.303087] (unnamed net_device) (dummy): netif_napi_add_weight() called with weight 128
[   12.312160] mtk-pcie-gen3 11280000.pcie: msi#0x1 address_hi 0x0 address_lo 0x11280c00 data 1
[   12.320666] mtk-pcie-gen3 11280000.pcie: msi#0x2 address_hi 0x0 address_lo 0x11280c00 data 2
[   12.329153] mtk-pcie-gen3 11280000.pcie: msi#0x3 address_hi 0x0 address_lo 0x11280c00 data 3
[   12.331706] Unable to handle kernel paging request at virtual address ffffffc083a1d004
[   12.345488] Mem abort info:
[   12.345518] mtk-pcie-gen3 11280000.pcie: msi#0x4 address_hi 0x0 address_lo 0x11280c00 data 4
[   12.348269]   ESR = 0x0000000096000061
[   12.356716] mtk-pcie-gen3 11280000.pcie: msi#0x5 address_hi 0x0 address_lo 0x11280c00 data 5
[   12.360421]   EC = 0x25: DABT (current EL), IL = 32 bits
[   12.368862] mtk-pcie-gen3 11280000.pcie: msi#0x6 address_hi 0x0 address_lo 0x11280c00 data 6
[   12.374133]   SET = 0, FnV = 0
[   12.374135]   EA = 0, S1PTW = 0
[   12.382574] mtk-pcie-gen3 11280000.pcie: msi#0x7 address_hi 0x0 address_lo 0x11280c00 data 7
[   12.385593]   FSC = 0x21: alignment fault
[   12.388751] mtk-pcie-gen3 11280000.pcie: msi#0x8 address_hi 0x0 address_lo 0x11280c00 data 8
[   12.397137] Data abort info:
[   12.397138]   ISV = 0, ISS = 0x00000061, ISS2 = 0x00000000
[   12.397140]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[   12.422958]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   12.428261] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000046ad6000
[   12.434950] [ffffffc083a1d004] pgd=100000013ffff003, p4d=100000013ffff003, pud=100000013ffff003, pmd=0068000020a00711
[   12.445552] Internal error: Oops: 0000000096000061 [#1] SMP
[   12.451113] Modules linked in: mtk_t7xx mt7996e(O) mt792x_usb(O) mt792x_lib(O) mt7915e(O) mt76_usb(O) mt76_sdio(O) mt76_connac_lib(O) mt76(O) mac80211(O) iwlwifi(O) huawei_cdc_ncm cfg80211(O) cdc_ncm cdc_ether wwan usbserial usbnet slhc sfp rtc_pcf8563 nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mt6577_auxadc mdio_i2c libcrc32c compat(O) cdc_wdm cdc_acm at24 crypto_safexcel pwm_fan i2c_gpio i2c_smbus industrialio i2c_algo_bit i2c_mux_reg i2c_mux_pca954x i2c_mux_pca9541 i2c_mux_gpio i2c_mux dummy oid_registry tun sha512_arm64 sha1_ce sha1_generic seqiv md5 geniv des_generic libdes cbc authencesn authenc leds_gpio xhci_plat_hcd xhci_pci xhci_mtk_hcd xhci_hcd nvme nvme_core gpio_button_hotplug(O) dm_mirror dm_region_hash dm_log dm_crypt dm_mod dax usbcore usb_common ptp aquantia pps_core mii tpm encrypted_keys trusted
[   12.526834] CPU: 2 PID: 1526 Comm: kworker/u9:0 Tainted: G           O       6.6.22 #0
[   12.534740] Hardware name: Bananapi BPI-R4 (DT)
[   12.539259] Workqueue: md_hk_wq t7xx_fsm_uninit [mtk_t7xx]
[   12.542217] sfp sfp2: module XICOM            XC-SFP+-SR       rev A    sn C202307141626    dc 230714
[   12.544746] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   12.554144] mtk_soc_eth 15100000.ethernet eth1: switched to inband/10gbase-r link mode
[   12.561064] pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
[   12.575139] lr : t7xx_cldma_start+0xac/0x13c [mtk_t7xx]
[   12.580359] sp : ffffffc0813dbd30
[   12.583661] x29: ffffffc0813dbd30 x28: 0000000000000000 x27: 0000000000000000
[   12.590786] x26: 0000000000000000 x25: ffffff80c6888140 x24: ffffff80c11f7e05
[   12.591893] sfp sfp1: module XICOM            XC-SFP+-LR       rev A    sn C202307141707    dc 230714
[   12.593855] hwmon hwmon2: temp1_input not attached to any thermal zone
[   12.597909] x23: 0000000000000000 x22: ffffff80c0fdb9b8
[   12.607297] mtk_soc_eth 15100000.ethernet eth2: switched to inband/10gbase-r link mode
[   12.613792]  x21: ffffff80c0fdb128
[   12.613794] x20: 0000000000000001 x19: ffffff80c0fdb080 x18: 0000000000000014
[   12.631986] hwmon hwmon3: temp1_input not attached to any thermal zone
[   12.637419] x17: 00000000752a0f20 x16: 00000000468ff952 x15: 00000000246d1885
[   12.651056] x14: 00000000b48c7dff x13: 000000001b6aa29e x12: 0000000000000001
[   12.658180] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   12.665304] x8 : ffffff80c90fdfb4 x7 : ffffff80c0fdb818 x6 : 0000000000000018
[   12.672428] x5 : 0000000000000870 x4 : 0000000000000000 x3 : 0000000000000000
[   12.679553] x2 : 00000001090f0000 x1 : ffffffc083a1d004 x0 : ffffffc083a1d004
[   12.686678] Call trace:
[   12.689114]  t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
[   12.694942]  t7xx_fsm_uninit+0x578/0x5ec [mtk_t7xx]
[   12.699814]  process_one_work+0x154/0x2a0
[   12.703818]  worker_thread+0x2ac/0x488
[   12.707558]  kthread+0xe0/0xec
[   12.710603]  ret_from_fork+0x10/0x20
[   12.714172] Code: f9400800 91001000 8b214001 d50332bf (f9000022)
[   12.720253] ---[ end trace 0000000000000000 ]---
[   12.731558] pstore: backend (ramoops) writing error (-28)
[   12.736948] Kernel panic - not syncing: Oops: Fatal exception
[   12.742680] SMP: stopping secondary CPUs
[   12.746593] Kernel Offset: disabled
[   12.750069] CPU features: 0x0,00000000,20000000,1000400b
[   12.755370] Memory Limit: none
[   12.765071] Rebooting in 1 seconds..
PANIC at PC : 0x000000004300490c

Kindly
Robert

