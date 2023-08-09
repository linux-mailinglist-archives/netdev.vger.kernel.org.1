Return-Path: <netdev+bounces-26026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3680D776953
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617FF281D75
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEA024528;
	Wed,  9 Aug 2023 19:58:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94B24523
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 19:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1F6C433C7;
	Wed,  9 Aug 2023 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691611086;
	bh=4gNG9iyI85fpiDYW6+SWdDb5gUrW7o6DYW4Uq1DK1yQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p7RWYFCcj/8VxdL4ncksv0KZwLPb8Y4lKDhXNTAdWJfPQ2/91BKROFIYBgTe/EsEt
	 XRmuyiwtglC6al2VfQ5fW40CU/Qwj6cg/IzLhVEqG+XnodVKr8RSD6iBhctSPULFK4
	 RRBU9V//iHfEc+vkY4jexP+8b0EsnX8//OVzuNcc+GSgzASr/NXYdIf/TguKonQ1I6
	 4GI/BD4RwFGm1MXC8l5yQlkN8bVX3ZlpVtVyLDfZqRKm2H8gjkjHH+c6cOAedDP2S9
	 DHB6KewYBRBqbLvT6eFARQHh54RlyFJzBTItP8kF7s6zgfy4R1DZnG+ZnlJaSmf4Ue
	 W6aTjzG3URbMg==
Date: Wed, 9 Aug 2023 12:58:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin =?UTF-8?B?S2rDpnIgSsO4cmdlbnNlbg==?= <me@lagy.org>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 nic_swsd@realtek.com
Subject: Re: r8169 link up but no traffic, and watchdog error
Message-ID: <20230809125805.2e3f86ac@kernel.org>
In-Reply-To: <87zg30a0h9.fsf@lagy.org>
References: <87zg30a0h9.fsf@lagy.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

CC: Heiner

On Wed, 09 Aug 2023 13:50:31 +0200 Martin Kj=C3=A6r J=C3=B8rgensen wrote:
> Hello netdev,
>=20
> My machine have 2 x PCI-E card both having 2 x "Realtek Semiconductor Co.=
, Ltd. RTL8125 2.5GbE
> Controller" devices giving me 4 ethernet ports in addition to the onboard
> ethernet controller.
>=20
> When a cable is plugged to on of the ports and the port in the other end
> suddenly goes down and up again, like if power cycled, all traffic on the=
 wire
> stops even though the port LEDs light up, and kernel produces klog
> entry, indicating a link.
>=20
> I need to issue a commands like:
>=20
> ip link set enp3s0 down
> ip link set enp3s0 up
>=20
> to have the link running again. This sometimes produces the error seen be=
low,
> but not all the time. After commands are issued the traffic flows again l=
ike
> normal, until the remote port goes down and up again.
>=20
> Have you guys got any ideas about this?

There were some fix in r8169 for power management changes recently.
Could you try the latest stable kernel? 6.4.9 ?

> [   36.324381] logitech-hidpp-device 0003:046D:4055.0009: HID++ 4.5 devic=
e connected.
> [  107.354641] r8169 0000:03:00.0 enp3s0: Link is Down
> [  169.142879] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
> [  180.198458] ------------[ cut here ]------------
> [  180.198469] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed ou=
t 9028 ms
> [  180.198496] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:525 dev_=
watchdog+0x232/0x240
> [  180.198509] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq nf_co=
nntrack_netlink xt_addrtype br_netfilter xt_policy jitterentropy_rng drbg a=
nsi_cprng authenc echainiv esp4 xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_=
REJECT nf_reject_ipv4 xt_tcpudp nft_compat xfrm_interface xfrm6_tunnel tunn=
el6 tunnel4 xfrm_user xfrm_algo twofish_generic twofish_avx_x86_64 twofish_=
x86_64_3way twofish_x86_64 twofish_common serpent_avx2 serpent_avx_x86_64 s=
erpent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 blowfis=
h_common cmac cast5_avx_x86_64 nls_utf8 cast5_generic cast_common cifs ctr =
ecb des_generic libdes algif_skcipher camellia_generic cifs_arc4 cifs_md4 d=
ns_resolver camellia_aesni_avx2 fscache netfs camellia_aesni_avx_x86_64 cam=
ellia_x86_64 xcbc md4 algif_hash af_alg nvme_fabrics overlay sunrpc binfmt_=
misc nft_fib_ipv6 nft_nat nft_fib_ipv4 nft_fib nls_ascii nls_cp437 vfat fat=
 intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp bri=
dge coretemp stp llc kvm_intel cfg80211 kvm rfkill
> [  180.198634]  snd_usb_audio uvcvideo videobuf2_vmalloc uvc videobuf2_me=
mops videobuf2_v4l2 snd_usbmidi_lib irqbypass rtsx_usb_ms snd_hwdep iTCO_wd=
t intel_cstate memstick mei_hdcp videodev mei_wdt mei_pxp intel_pmc_bxt snd=
_rawmidi snd_seq_device iTCO_vendor_support snd_pcm ftdi_sio videobuf2_comm=
on intel_uncore usbserial snd_timer mei_me intel_wmi_thunderbolt snd mc thi=
nk_lmi watchdog ee1004 firmware_attributes_class wmi_bmof mei soundcore joy=
dev intel_pmc_core int3400_thermal acpi_thermal_rel acpi_tad acpi_pad butto=
n evdev nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag=
_ipv4 nf_tables msr parport_pc ppdev lp nfnetlink parport fuse loop efi_pst=
ore configfs ip_tables x_tables autofs4 btrfs blake2b_generic hid_logitech_=
hidpp hid_logitech_dj rtsx_usb_sdmmc mmc_core rtsx_usb hid_jabra hid_generi=
c dm_crypt dm_mod efivarfs raid10 raid456 async_raid6_recov async_memcpy as=
ync_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath line=
ar md_mod usbhid hid ext4 crc16 mbcache jbd2 crc32c_generic
> [  180.198772]  i915 i2c_algo_bit drm_buddy crc32_pclmul drm_display_help=
er crc32c_intel nvme drm_kms_helper nvme_core cec ghash_clmulni_intel sha51=
2_ssse3 rc_core r8169 sha512_generic ahci t10_pi xhci_pci libahci ttm realt=
ek crc64_rocksoft_generic libata xhci_hcd crc64_rocksoft crc_t10dif drm mdi=
o_devres aesni_intel e1000e crct10dif_generic usbcore scsi_mod libphy crypt=
o_simd cryptd crct10dif_pclmul i2c_i801 crc64 i2c_smbus crct10dif_common sc=
si_common usb_common fan video wmi
> [  180.198837] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.4.0-1-amd64 #1=
  Debian 6.4.4-2
> [  180.198843] Hardware name: LENOVO 30E30051UK/1052, BIOS S0AKT3AA 04/25=
/2023
> [  180.198846] RIP: 0010:dev_watchdog+0x232/0x240
> [  180.198852] Code: ff ff ff 48 89 df c6 05 36 03 05 01 01 e8 d6 3d fa f=
f 45 89 f8 44 89 f1 48 89 de 48 89 c2 48 c7 c7 20 85 cf a9 e8 3e 17 70 ff <=
0f> 0b e9 2d ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
> [  180.198857] RSP: 0018:ffffa264c026ce70 EFLAGS: 00010286
> [  180.198862] RAX: 0000000000000000 RBX: ffff948781f58000 RCX: 000000000=
0000000
> [  180.198866] RDX: 0000000000000104 RSI: 0000000000000027 RDI: 00000000f=
fffffff
> [  180.198870] RBP: ffff948781f584c8 R08: 0000000000000000 R09: ffffa264c=
026cd00
> [  180.198873] R10: 0000000000000003 R11: ffffffffaa2d26a8 R12: ffff94878=
1f4f400
> [  180.198875] R13: ffff948781f5841c R14: 0000000000000000 R15: 000000000=
0002344
> [  180.198879] FS:  0000000000000000(0000) GS:ffff9496b5680000(0000) knlG=
S:0000000000000000
> [  180.198883] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  180.198886] CR2: 0000561606a0b170 CR3: 0000000146c82002 CR4: 000000000=
0770ee0
> [  180.198890] PKRU: 55555554
> [  180.198892] Call Trace:
> [  180.198896]  <IRQ>
> [  180.198899]  ? dev_watchdog+0x232/0x240
> [  180.198904]  ? __warn+0x81/0x130
> [  180.198916]  ? dev_watchdog+0x232/0x240
> [  180.198920]  ? report_bug+0x191/0x1c0
> [  180.198929]  ? prb_read_valid+0x1b/0x30
> [  180.198938]  ? handle_bug+0x3c/0x80
> [  180.198945]  ? exc_invalid_op+0x17/0x70
> [  180.198951]  ? asm_exc_invalid_op+0x1a/0x20
> [  180.198960]  ? dev_watchdog+0x232/0x240
> [  180.198965]  ? __pfx_dev_watchdog+0x10/0x10
> [  180.198969]  call_timer_fn+0x24/0x130
> [  180.198979]  ? __pfx_dev_watchdog+0x10/0x10
> [  180.198982]  __run_timers+0x222/0x2c0
> [  180.198992]  run_timer_softirq+0x2f/0x50
> [  180.199000]  __do_softirq+0xf1/0x301
> [  180.199007]  __irq_exit_rcu+0xb5/0x130
> [  180.199016]  sysvec_apic_timer_interrupt+0xa2/0xd0
> [  180.199027]  </IRQ>
> [  180.199029]  <TASK>
> [  180.199031]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  180.199037] RIP: 0010:cpuidle_enter_state+0xcc/0x440
> [  180.199044] Code: da fa 58 ff e8 b5 f0 ff ff 8b 53 04 49 89 c5 0f 1f 4=
4 00 00 31 ff e8 73 06 58 ff 45 84 ff 0f 85 56 02 00 00 fb 0f 1f 44 00 00 <=
45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [  180.199048] RSP: 0018:ffffa264c0193e90 EFLAGS: 00000246
> [  180.199052] RAX: ffff9496b5680000 RBX: ffffc264bfaa8e00 RCX: 000000000=
0000000
> [  180.199055] RDX: 0000000000000002 RSI: ffffffffa9c3fd02 RDI: ffffffffa=
9c2c5ed
> [  180.199058] RBP: 0000000000000002 R08: 0000000000000000 R09: 000000003=
3483483
> [  180.199061] R10: ffff9496b56b1d84 R11: 00000000000006b1 R12: ffffffffa=
a398300
> [  180.199064] R13: 00000029f4a9f550 R14: 0000000000000002 R15: 000000000=
0000000
> [  180.199071]  cpuidle_enter+0x2d/0x40
> [  180.199081]  do_idle+0x217/0x270
> [  180.199089]  cpu_startup_entry+0x1d/0x20
> [  180.199095]  start_secondary+0x134/0x160
> [  180.199104]  secondary_startup_64_no_verify+0x10b/0x10b
> [  180.199115]  </TASK>
> [  180.199117] ---[ end trace 0000000000000000 ]---
> [  226.051135] r8169 0000:03:00.0 enp3s0: Link is Down
> [  275.843212] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
>=20


