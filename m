Return-Path: <netdev+bounces-93867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CE8BD6DA
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519AC1F21190
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C815B55F;
	Mon,  6 May 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+Kaspbd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B651EBB
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030895; cv=none; b=qEVT9N1PpfPKa6ToI6UyFmBaNunr1s7dN7JPZ4XRrLAm9FMiS7lCF0U3J1jG1ExgZA0kzdzzPrP8ZQNuTA1byCaI4VL4pl289aczge11OsvwBQR6kOFEbVAIvTL3VhHDuMSABLRqt2zRyL+Pl1uTmPB+qM/uzzOrjHlJgpyunpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030895; c=relaxed/simple;
	bh=0/Q76VXKsbZ/FdlqEhSQtcpWVPvx5ZDbZQw8cIErhls=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KjnJilYN7u1wIeYxNiJ9GLpJwdfoC2UZ7Jjao7RY8GR4OJoJd49R4/H9ib9meGVTI2b4J7z2x4jrJ3uMG9qJqyO33647bVxvNER0kZk5L8Ns5McEv8nc2M3apCS0MC6KndiLRdbP7MbLBzMJDG3a6kP4k0/bY2MX8+QjyEktmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+Kaspbd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b79451145so18111375e9.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715030891; x=1715635691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23ZVZ8gIUCilP7WHW718nKpIxy6fxpXdeG8PGItykUQ=;
        b=W+KaspbdvOzYmqwCwVaNbsMvnHDI1n4bthm7FGnnHfJWn/Pz4XgkEO7dVoKafwK6cW
         xqu3ORZ4ePprPmbndXBTY5982qJ/nyr3VaSB3jOp3DoKkifbPcmSOz+xg7K5hGfJtSQ/
         Coc7EqWP+IAgPUG+GIpmpUROouH1GTN21V96UvDUHZGi+w2pGb58U6X8wCrKJvRQdIN0
         /01wIEjivfALpOjxX601CPx8OQmeLRHub83k23xrCAc5BbPo0fcUGCQL53Lx1eZzx+bh
         tMaS4BgHJXisSpUcXvnNDXe//g/Ss7H5fecz41/826DunWs36fcQDLxHaRi4JF9Ar18Y
         elEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715030891; x=1715635691;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23ZVZ8gIUCilP7WHW718nKpIxy6fxpXdeG8PGItykUQ=;
        b=jkX/ZwcY9+N3A4JkYzCi5L1GgGWQhNcNAzpbiEuXjiK1b7X8xLZVaANbMl70Ohlksg
         VsAHWoFH9eniA9YBrVgN4d5MeXI7mzRbUrTU2gDm1gA9qrlJgUZBOvscvBnt/FRg188C
         3r1hDGZkf/Ax2TK2pyCqpespkNC+sYmIzfUotRCLtHw7GDVBBoWFMLJ+VSzP1c1WH4Xo
         vkmJChcyB9N6lyJRkd71Dp2YMuEWZg4fnaiNJIzgwbJjurr74TTdgiZP4e4TQOYzDtKW
         GSVwULl3tQtYK5gfspgFUFKzXcWfZajuDNicZmz9fzC5+mcnE484PUfIB3ffWtuIZLqO
         UQvA==
X-Gm-Message-State: AOJu0YxPwhUGxa67aKcZHyU8TUpYZjlWbmc9lhBi9wMZBX2ao3+8Bcgt
	OrLM+rThRJsR41SKU6578bSn1emZUIK6jhki4C68uIaforSSIcUYxrlG4ugk
X-Google-Smtp-Source: AGHT+IEWrNCJQehkdHu+uU4SaYN6Wn7rIKV/r0ry0wIdVKe9/XGBD4ChfzYzMoyXUR8o8rVGXInnDA==
X-Received: by 2002:a05:600c:354a:b0:418:f991:8ad4 with SMTP id i10-20020a05600c354a00b00418f9918ad4mr8338374wmq.6.1715030890299;
        Mon, 06 May 2024 14:28:10 -0700 (PDT)
Received: from [192.168.1.58] (111.68.9.51.dyn.plus.net. [51.9.68.111])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0041bfa2171efsm17398022wmo.40.2024.05.06.14.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 14:28:09 -0700 (PDT)
Message-ID: <ad6a0c52-4dcb-444e-88cd-a6c490a817fe@gmail.com>
Date: Mon, 6 May 2024 22:28:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ken Milmore <ken.milmore@gmail.com>
Subject: r8169: transmit queue timeouts and IRQ masking
Content-Language: en-GB
To: netdev@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have a motherboard with an integrated RTL8125B network adapter, and I h=
ave found a way to predictably cause TX queue timeouts with the r8169 dri=
ver.

Briefly, if rtl8169_poll() ever gets called with interrupts unmasked on t=
he device, then it seems to be possible to get it stuck in a non-interrup=
ting state.
It appears disaster can be averted in this case by making sure device int=
errupts are always masked when inside rtl8169_poll()! For which see below=
=2E..

The preconditions I found for causing a timeout are:
- Set gro_flush_timeout to a NON-ZERO value
- Set napi_defer_hard_irqs to ZERO
- Put some heavy bidirectional load on the interface (I find iperf3 to an=
other host does the job nicely: 1Gbps is enough).

e.g.
# echo 20000 > /sys/class/net/eth0/gro_flush_timeout
# echo 0 > /sys/class/net/eth0/napi_defer_hard_irqs
# iperf3 --bidir -c hostname

The bitrate falls off to zero almost immediately, whereafter the interfac=
e just stops working:

[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec  1010 KBytes  8.26 Mbits/sec    1   1.39 KB=
ytes      =20
[  7][RX-C]   0.00-1.00   sec   421 KBytes  3.45 Mbits/sec               =
  =20
[  5][TX-C]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    0   1.39 KByt=
es      =20
[  7][RX-C]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec                 =
=20
[  5][TX-C]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.39 KByt=
es      =20

On recent(ish) kernels I see the "ASPM disabled on Tx timeout" message as=
 it tries to recover, then after some delay, the familiar "transmit queue=
 0 timed out" warning usually occurs.


[  149.473134] ------------[ cut here ]------------
[  149.473155] NETDEV WATCHDOG: eth0 (r8169): transmit queue 0 timed out =
6812 ms
[  149.473188] WARNING: CPU: 18 PID: 0 at net/sched/sch_generic.c:525 dev=
_watchdog+0x235/0x240
[  149.473206] Modules linked in: nft_chain_nat nf_nat bridge stp llc qrt=
r sunrpc binfmt_misc ip6t_REJECT nf_reject_ipv6 joydev ipt_REJECT nf_reje=
ct_ipv4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=
 nft_compat nf_tables libcrc32c nfnetlink hid_generic nls_ascii nls_cp437=
 usbhid vfat hid fat amdgpu intel_rapl_msr snd_sof_pci_intel_tgl intel_ra=
pl_common snd_sof_intel_hda_common soundwire_intel soundwire_generic_allo=
cation intel_uncore_frequency intel_uncore_frequency_common snd_sof_intel=
_hda_mlink soundwire_cadence snd_sof_intel_hda snd_sof_pci x86_pkg_temp_t=
hermal intel_powerclamp snd_sof_xtensa_dsp iwlmvm snd_sof coretemp kvm_in=
tel snd_sof_utils snd_hda_codec_realtek snd_soc_hdac_hda mac80211 kvm snd=
_hda_ext_core snd_hda_codec_generic snd_soc_acpi_intel_match snd_soc_acpi=
 ledtrig_audio snd_soc_core irqbypass snd_compress libarc4 drm_exec snd_p=
cm_dmaengine snd_hda_codec_hdmi ghash_clmulni_intel amdxcp soundwire_bus =
drm_buddy sha512_ssse3 gpu_sched sha256_ssse3 snd_hda_intel sha1_ssse3
[  149.473574]  drm_suballoc_helper snd_intel_dspcfg iwlwifi snd_intel_sd=
w_acpi drm_display_helper snd_hda_codec cec aesni_intel snd_hda_core cryp=
to_simd cryptd rc_core snd_hwdep mei_pxp mei_hdcp snd_pcm rapl drm_ttm_he=
lper pmt_telemetry iTCO_wdt cfg80211 ttm pmt_class snd_timer intel_pmc_bx=
t evdev intel_cstate drm_kms_helper wmi_bmof mxm_wmi snd iTCO_vendor_supp=
ort mei_me intel_uncore i2c_algo_bit ee1004 pcspkr watchdog mei soundcore=
 rfkill intel_vsec serial_multi_instantiate intel_pmc_core acpi_pad acpi_=
tad button drm nct6683 parport_pc ppdev lp parport loop efi_pstore config=
fs efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_gen=
eric dm_mod nvme ahci nvme_core xhci_pci libahci t10_pi xhci_hcd r8169 li=
bata realtek crc64_rocksoft mdio_devres crc64 usbcore scsi_mod crc_t10dif=
 i2c_i801 crct10dif_generic libphy crc32_pclmul crct10dif_pclmul crc32c_i=
ntel i2c_smbus video scsi_common usb_common crct10dif_common fan wmi pinc=
trl_alderlake
[  149.474122] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 6.6.13+bpo-amd=
64 #1  Debian 6.6.13-1~bpo12+1
[  149.474134] Hardware name: Micro-Star International Co., Ltd. MS-7D43/=
PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
[  149.474141] RIP: 0010:dev_watchdog+0x235/0x240
[  149.474154] Code: ff ff ff 48 89 df c6 05 6c 2a 40 01 01 e8 e3 37 fa f=
f 45 89 f8 44 89 f1 48 89 de 48 89 c2 48 c7 c7 60 5f f2 9f e8 0b e3 6a ff=
 <0f> 0b e9 2a ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[  149.474163] RSP: 0018:ffffa4c3c0444e78 EFLAGS: 00010286
[  149.474176] RAX: 0000000000000000 RBX: ffff93d94b354000 RCX: 000000000=
000083f
[  149.474185] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000=
000083f
[  149.474192] RBP: ffff93d94b3544c8 R08: 0000000000000000 R09: ffffa4c3c=
0444d00
[  149.474199] R10: 0000000000000003 R11: ffff93e0bf780228 R12: ffff93d94=
b346a00
[  149.474207] R13: ffff93d94b35441c R14: 0000000000000000 R15: 000000000=
0001a9c
[  149.474215] FS:  0000000000000000(0000) GS:ffff93e09f680000(0000) knlG=
S:0000000000000000
[  149.474225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.474232] CR2: 00007f616800a008 CR3: 0000000136820000 CR4: 000000000=
0f50ee0
[  149.474240] PKRU: 55555554
[  149.474247] Call Trace:
[  149.474254]  <IRQ>
[  149.474261]  ? dev_watchdog+0x235/0x240
[  149.474271]  ? __warn+0x81/0x130
[  149.474289]  ? dev_watchdog+0x235/0x240
[  149.474298]  ? report_bug+0x171/0x1a0
[  149.474314]  ? handle_bug+0x41/0x70
[  149.474326]  ? exc_invalid_op+0x17/0x70
[  149.474338]  ? asm_exc_invalid_op+0x1a/0x20
[  149.474353]  ? dev_watchdog+0x235/0x240
[  149.474363]  ? dev_watchdog+0x235/0x240
[  149.474372]  ? __pfx_dev_watchdog+0x10/0x10
[  149.474381]  call_timer_fn+0x24/0x130
[  149.474396]  ? __pfx_dev_watchdog+0x10/0x10
[  149.474404]  __run_timers+0x222/0x2c0
[  149.474420]  run_timer_softirq+0x1d/0x40
[  149.474433]  __do_softirq+0xc7/0x2ae
[  149.474444]  __irq_exit_rcu+0x96/0xb0
[  149.474459]  sysvec_apic_timer_interrupt+0x72/0x90
[  149.474469]  </IRQ>
[  149.474473]  <TASK>
[  149.474479]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  149.474492] RIP: 0010:cpuidle_enter_state+0xcc/0x440
[  149.474504] Code: fa b6 53 ff e8 35 f4 ff ff 8b 53 04 49 89 c5 0f 1f 4=
4 00 00 31 ff e8 43 c4 52 ff 45 84 ff 0f 85 57 02 00 00 fb 0f 1f 44 00 00=
 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  149.474514] RSP: 0018:ffffa4c3c022be90 EFLAGS: 00000246
[  149.474524] RAX: ffff93e09f6b3440 RBX: ffffc4c3bfcb2140 RCX: 000000000=
000001f
[  149.474529] RDX: 0000000000000012 RSI: 000000003c9b26c9 RDI: 000000000=
0000000
[  149.474536] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000000=
0000500
[  149.474542] R10: 0000000000000007 R11: ffff93e09f6b1fe4 R12: ffffffffa=
079a500
[  149.474548] R13: 00000022cd4ab97d R14: 0000000000000004 R15: 000000000=
0000000
[  149.474560]  cpuidle_enter+0x2d/0x40
[  149.474571]  do_idle+0x20d/0x270
[  149.474585]  cpu_startup_entry+0x2a/0x30
[  149.474598]  start_secondary+0x11e/0x140
[  149.474613]  secondary_startup_64_no_verify+0x18f/0x19b
[  149.474630]  </TASK>
[  149.474635] ---[ end trace 0000000000000000 ]---


Here's a dump of the registers (MAC Address redacted).
It seems to be stuck on TxDescUnavail | RxOverflow | TxOK | RxOk, and int=
errupts are unmasked.

# ethtool -d eth0
Unknown RealTek chip (TxConfig: 0x67100f00)
Offset		Values
------		------
0x0000:		XXXXXXXXXXXXXXXXX fe 09 40 00 00 00 80 00 01 00=20
0x0010:		00 00 57 ff 00 00 00 00 0a 00 00 00 00 00 00 00=20
0x0020:		00 10 7d ff 00 00 00 00 19 1e 9f b4 79 a5 3f 3b=20
0x0030:		00 00 00 00 00 00 00 0c 3f 00 00 00 95 00 00 00=20
0x0040:		00 0f 10 67 0e 0f c2 40 00 00 00 00 00 00 00 00=20
0x0050:		11 00 cf bc 60 11 03 01 00 00 00 00 00 00 00 00=20
0x0060:		00 00 00 00 00 00 00 00 00 00 02 00 f3 00 80 f0=20
0x0070:		00 00 00 00 00 00 00 00 07 00 00 00 00 00 b3 e9=20
0x0080:		62 60 02 00 00 02 20 00 00 00 00 00 00 00 00 00=20
0x0090:		00 00 00 00 60 00 20 02 62 64 00 00 00 00 00 00=20
0x00a0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
0x00b0:		1f 00 00 00 80 00 00 00 ec 10 1a d2 01 00 01 00=20
0x00c0:		00 00 00 00 00 00 00 00 00 00 00 00 12 00 00 00=20
0x00d0:		21 00 04 12 00 00 01 00 00 00 00 40 ff ff ff ff=20
0x00e0:		20 20 03 01 00 00 91 fe 00 00 00 00 ff 02 00 00=20
0x00f0:		3f 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00=20


I tried instrumenting the code a bit and found that rtl8169_poll() being =
called with interrupts unmasked seems to be a precursor to the problem oc=
curing.
The *only* time this usually happens is when a GRO timer has been set but=
 napi_defer_hard_irqs is off.
Now that the defaults are gro_flush_timeout=3D20000, napi_defer_hard_irqs=
=3D1, this probably doesn't happen very often for most people.
I guess it will happen with busy polling, but I haven't tested that yet.


diff --git linux-source-6.6~/drivers/net/ethernet/realtek/r8169_main.c li=
nux-source-6.6/drivers/net/ethernet/realtek/r8169_main.c
index 81fd31f..927786f 100644
--- linux-source-6.6~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.6/drivers/net/ethernet/realtek/r8169_main.c
@@ -4601,6 +4601,8 @@ static int rtl8169_poll(struct napi_struct *napi, i=
nt budget)
        struct net_device *dev =3D tp->dev;
        int work_done;
=20
+       WARN_ONCE(RTL_R32(tp, IntrMask_8125) !=3D 0, "rtl8169_poll: IRQs =
enabled!");
+
        rtl_tx(dev, tp, budget);
=20
        work_done =3D rtl_rx(dev, tp, budget);

[ 5055.978473] ------------[ cut here ]------------
[ 5055.978503] rtl8169_poll: IRQs enabled!
[ 5055.978527] WARNING: CPU: 15 PID: 0 at /home/ken/work/r8169/linux-sour=
ce-6.6/drivers/net/ethernet/realtek/r8169_main.c:4604 rtl8169_poll+0x4e5/=
0x520 [r8169]
[ 5055.978568] Modules linked in: r8169(OE) realtek mdio_devres libphy nf=
t_chain_nat nf_nat bridge stp llc ip6t_REJECT nf_reject_ipv6 qrtr ipt_REJ=
ECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_=
defrag_ipv4 sunrpc nft_compat nf_tables libcrc32c nfnetlink binfmt_misc j=
oydev nls_ascii nls_cp437 vfat fat hid_generic usbhid hid amdgpu intel_ra=
pl_msr intel_rapl_common intel_uncore_frequency snd_sof_pci_intel_tgl int=
el_uncore_frequency_common snd_sof_intel_hda_common x86_pkg_temp_thermal =
soundwire_intel intel_powerclamp soundwire_generic_allocation snd_sof_int=
el_hda_mlink coretemp iwlmvm soundwire_cadence kvm_intel snd_sof_intel_hd=
a snd_sof_pci snd_sof_xtensa_dsp snd_sof kvm mac80211 snd_sof_utils snd_s=
oc_hdac_hda snd_hda_ext_core irqbypass snd_soc_acpi_intel_match snd_soc_a=
cpi libarc4 snd_hda_codec_realtek ghash_clmulni_intel snd_soc_core sha512=
_ssse3 snd_hda_codec_generic drm_exec sha256_ssse3 amdxcp sha1_ssse3 ledt=
rig_audio drm_buddy iwlwifi gpu_sched snd_compress snd_hda_codec_hdmi snd=
_pcm_dmaengine
[ 5055.979159]  drm_suballoc_helper soundwire_bus drm_display_helper aesn=
i_intel snd_hda_intel cec crypto_simd cryptd snd_intel_dspcfg rc_core snd=
_intel_sdw_acpi rapl snd_hda_codec mei_hdcp drm_ttm_helper mei_pxp pmt_te=
lemetry intel_cstate cfg80211 evdev pmt_class snd_hda_core ttm snd_hwdep =
mei_me snd_pcm drm_kms_helper iTCO_wdt wmi_bmof intel_pmc_bxt snd_timer i=
ntel_uncore snd iTCO_vendor_support i2c_algo_bit mei ee1004 mxm_wmi watch=
dog pcspkr soundcore rfkill intel_vsec serial_multi_instantiate intel_pmc=
_core acpi_tad acpi_pad button drm nct6683 parport_pc ppdev lp parport lo=
op configfs efi_pstore efivarfs ip_tables x_tables autofs4 ext4 crc16 mbc=
ache jbd2 crc32c_generic dm_mod nvme ahci nvme_core libahci xhci_pci t10_=
pi libata xhci_hcd crc64_rocksoft crc64 usbcore scsi_mod crc_t10dif i2c_i=
801 crc32_pclmul crct10dif_generic crct10dif_pclmul crc32c_intel i2c_smbu=
s video scsi_common usb_common fan crct10dif_common wmi pinctrl_alderlake=
 [last unloaded: r8169(OE)]
[ 5055.979787] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G        W  OE   =
   6.6.13+bpo-amd64 #1  Debian 6.6.13-1~bpo12+1
[ 5055.979797] Hardware name: Micro-Star International Co., Ltd. MS-7D43/=
PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
[ 5055.979803] RIP: 0010:rtl8169_poll+0x4e5/0x520 [r8169]
[ 5055.979829] Code: 19 00 00 76 40 89 50 38 eb 98 80 3d 24 e2 00 00 00 0=
f 85 66 fb ff ff 48 c7 c7 7a d0 8d c0 c6 05 10 e2 00 00 01 e8 ab f6 fe f4=
 <0f> 0b e9 4c fb ff ff ba 40 00 00 00 88 50 38 e9 a5 fc ff ff 31 c0
[ 5055.979836] RSP: 0018:ffffad4340618e88 EFLAGS: 00010286
[ 5055.979846] RAX: 0000000000000000 RBX: ffff8f799b16c9e0 RCX: 000000000=
000083f
[ 5055.979853] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000=
000083f
[ 5055.979859] RBP: ffff8f799b16c9e0 R08: 0000000000000000 R09: ffffad434=
0618d10
[ 5055.979864] R10: 0000000000000003 R11: ffff8f80ff780228 R12: ffff8f799=
b16c000
[ 5055.979871] R13: 0000000000000040 R14: ffff8f799b16c9c0 R15: ffff8f799=
b16c9e0
[ 5055.979877] FS:  0000000000000000(0000) GS:ffff8f80df5c0000(0000) knlG=
S:0000000000000000
[ 5055.979884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5055.979890] CR2: 00007f0062503000 CR3: 00000004afc20000 CR4: 000000000=
0f50ee0
[ 5055.979897] PKRU: 55555554
[ 5055.979903] Call Trace:
[ 5055.979911]  <IRQ>
[ 5055.979916]  ? rtl8169_poll+0x4e5/0x520 [r8169]
[ 5055.979940]  ? __warn+0x81/0x130
[ 5055.979955]  ? rtl8169_poll+0x4e5/0x520 [r8169]
[ 5055.979978]  ? report_bug+0x171/0x1a0
[ 5055.979992]  ? handle_bug+0x41/0x70
[ 5055.980004]  ? exc_invalid_op+0x17/0x70
[ 5055.980014]  ? asm_exc_invalid_op+0x1a/0x20
[ 5055.980026]  ? rtl8169_poll+0x4e5/0x520 [r8169]
[ 5055.980048]  ? rtl8169_poll+0x4e5/0x520 [r8169]
[ 5055.980070]  ? ktime_get+0x3c/0xa0
[ 5055.980079]  ? sched_clock+0x10/0x30
[ 5055.980090]  __napi_poll+0x28/0x1b0
[ 5055.980104]  net_rx_action+0x2a4/0x380
[ 5055.980116]  __do_softirq+0xc7/0x2ae
[ 5055.980126]  __irq_exit_rcu+0x96/0xb0
[ 5055.980139]  sysvec_apic_timer_interrupt+0x72/0x90
[ 5055.980148]  </IRQ>
[ 5055.980152]  <TASK>
[ 5055.980156]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 5055.980167] RIP: 0010:cpuidle_enter_state+0xcc/0x440
[ 5055.980179] Code: fa b6 53 ff e8 35 f4 ff ff 8b 53 04 49 89 c5 0f 1f 4=
4 00 00 31 ff e8 43 c4 52 ff 45 84 ff 0f 85 57 02 00 00 fb 0f 1f 44 00 00=
 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[ 5055.980187] RSP: 0018:ffffad4340213e90 EFLAGS: 00000246
[ 5055.980197] RAX: ffff8f80df5f3440 RBX: ffffcd433fbf2140 RCX: 000000000=
000001f
[ 5055.980203] RDX: 000000000000000f RSI: 000000003c9b26c9 RDI: 000000000=
0000000
[ 5055.980208] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000000=
0000012
[ 5055.980214] R10: 0000000000000008 R11: ffff8f80df5f1fe4 R12: ffffffffb=
759a500
[ 5055.980219] R13: 000004992fcca629 R14: 0000000000000004 R15: 000000000=
0000000
[ 5055.980229]  cpuidle_enter+0x2d/0x40
[ 5055.980238]  do_idle+0x20d/0x270
[ 5055.980253]  cpu_startup_entry+0x2a/0x30
[ 5055.980265]  start_secondary+0x11e/0x140
[ 5055.980279]  secondary_startup_64_no_verify+0x18f/0x19b
[ 5055.980294]  </TASK>
[ 5055.980298] ---[ end trace 0000000000000000 ]---


So to make the problem go away, I found that putting an unconditional cal=
l to rtl_irq_disable() up front in rtl8169_poll() is sufficient.
This seems a shame, since in almost every case, interrupts are already of=
f at this point so it is an unnecessary write to the card.

I assume it is rtl8169_interrupt() clearing the interrupt status register=
 while something inside rtl8169_interrupt() is going on that causes the p=
roblem, so this needs to be avoided.
I tried moving the interrupt masking around inside rtl_tx() and rtl_rx() =
to see if I could work out which specific place is vulnerable to the race=
, but it was inconclusive.


The cheap hack below seems like a more performant solution than masking i=
nterrupts unconditionally in the poll function:
If a hardware interrupt comes in and NAPI_STATE_SCHED is set, we assume w=
e're either in the poll function already or it will be called again soon,=
 so we can safely disable interrupts.
It has worked perfectly for me so far, although it doesn't prevent the po=
ll function from *ever* getting called with interrupts on. I suspect it w=
ill come apart with busy polling or the like.

No doubt some sort of semaphore between the interrupt handler and poll fu=
nction will be needed to decide who gets to disable interrupts.
It would be great if NAPI had a "begin polling" upcall or something...


diff --git linux-source-6.6~/drivers/net/ethernet/realtek/r8169_main.c li=
nux-source-6.6/drivers/net/ethernet/realtek/r8169_main.c
index 81fd31f..60cf4f6 100644
--- linux-source-6.6~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.6/drivers/net/ethernet/realtek/r8169_main.c
@@ -4521,6 +4521,11 @@ release_descriptor:
        return count;
 }
=20
+static inline bool napi_is_scheduled(struct napi_struct *n)
+{
+       return test_bit(NAPI_STATE_SCHED, &n->state);
+}
+
 static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 {
        struct rtl8169_private *tp =3D dev_instance;
@@ -4546,7 +4551,8 @@ static irqreturn_t rtl8169_interrupt(int irq, void =
*dev_instance)
        if (napi_schedule_prep(&tp->napi)) {
                rtl_irq_disable(tp);
                __napi_schedule(&tp->napi);
-       }
+       } else if (napi_is_scheduled(&tp->napi))
+               rtl_irq_disable(tp);
 out:
        rtl_ack_events(tp, status);

