Return-Path: <netdev+bounces-25822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C99775E92
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7524D1C211F6
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB261800E;
	Wed,  9 Aug 2023 12:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83418034
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:11:14 +0000 (UTC)
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 05:11:12 PDT
Received: from anon.cephalopo.net (anon.cephalopo.net [128.76.233.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CEDDF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lagy.org; s=def2;
	t=1691582477; bh=bKauydvPAOmap/N3+tVCAebqh2hK0Op+MHXVZyk+HNk=;
	h=From:To:Subject:Date:From;
	b=q29EeH43eb/iaF/qjJZkIC34XvzUtNiHyCr/yNvb+Xl9dQ1I+J9nBMbZWlA/x1GiG
	 KGonW8W+d9Jg9RpnejCk4qqM1yLfZnf5HFvbNnYujJA9uf3qFRRXD4zDcv0VNobPpM
	 Jp5BB0MGq31aUbS/DXsMvbf4H4lI8JyNNfUAgMgXXJnhjCCJqreW8DpImPR11MGe3T
	 sPjux5YV7cZ1CGtqtU5FCP77PF3kIzJX6IwQGCI9TWExTbFfK6IpO2EISheQLLh6hD
	 kD6kOIsVAz7sF6iH8MaVspasUTV8wsS06vLd8UgTyyL7P3OPCWdO0Hm6CN70jbDoSg
	 dZ03GxSaw/c/g==
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.auth=u1 smtp.mailfrom=me@lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 83E4E11C00BE
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:01:17 +0200 (CEST)
User-agent: mu4e 1.8.13; emacs 29.1
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: netdev@vger.kernel.org
Subject: r8169 link up but no traffic, and watchdog error
Date: Wed, 09 Aug 2023 13:50:31 +0200
Message-ID: <87zg30a0h9.fsf@lagy.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hello netdev,

My machine have 2 x PCI-E card both having 2 x "Realtek Semiconductor Co., =
Ltd. RTL8125 2.5GbE
Controller" devices giving me 4 ethernet ports in addition to the onboard
ethernet controller.

When a cable is plugged to on of the ports and the port in the other end
suddenly goes down and up again, like if power cycled, all traffic on the w=
ire
stops even though the port LEDs light up, and kernel produces klog
entry, indicating a link.

I need to issue a commands like:

ip link set enp3s0 down
ip link set enp3s0 up

to have the link running again. This sometimes produces the error seen belo=
w,
but not all the time. After commands are issued the traffic flows again like
normal, until the remote port goes down and up again.

Have you guys got any ideas about this?

/Martin


[1]:

[   36.324381] logitech-hidpp-device 0003:046D:4055.0009: HID++ 4.5 device =
connected.
[  107.354641] r8169 0000:03:00.0 enp3s0: Link is Down
[  169.142879] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[  180.198458] ------------[ cut here ]------------
[  180.198469] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed out =
9028 ms
[  180.198496] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:525 dev_wa=
tchdog+0x232/0x240
[  180.198509] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq nf_conn=
track_netlink xt_addrtype br_netfilter xt_policy jitterentropy_rng drbg ans=
i_cprng authenc echainiv esp4 xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_RE=
JECT nf_reject_ipv4 xt_tcpudp nft_compat xfrm_interface xfrm6_tunnel tunnel=
6 tunnel4 xfrm_user xfrm_algo twofish_generic twofish_avx_x86_64 twofish_x8=
6_64_3way twofish_x86_64 twofish_common serpent_avx2 serpent_avx_x86_64 ser=
pent_sse2_x86_64 serpent_generic blowfish_generic blowfish_x86_64 blowfish_=
common cmac cast5_avx_x86_64 nls_utf8 cast5_generic cast_common cifs ctr ec=
b des_generic libdes algif_skcipher camellia_generic cifs_arc4 cifs_md4 dns=
_resolver camellia_aesni_avx2 fscache netfs camellia_aesni_avx_x86_64 camel=
lia_x86_64 xcbc md4 algif_hash af_alg nvme_fabrics overlay sunrpc binfmt_mi=
sc nft_fib_ipv6 nft_nat nft_fib_ipv4 nft_fib nls_ascii nls_cp437 vfat fat i=
ntel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp bridg=
e coretemp stp llc kvm_intel cfg80211 kvm rfkill
[  180.198634]  snd_usb_audio uvcvideo videobuf2_vmalloc uvc videobuf2_memo=
ps videobuf2_v4l2 snd_usbmidi_lib irqbypass rtsx_usb_ms snd_hwdep iTCO_wdt =
intel_cstate memstick mei_hdcp videodev mei_wdt mei_pxp intel_pmc_bxt snd_r=
awmidi snd_seq_device iTCO_vendor_support snd_pcm ftdi_sio videobuf2_common=
 intel_uncore usbserial snd_timer mei_me intel_wmi_thunderbolt snd mc think=
_lmi watchdog ee1004 firmware_attributes_class wmi_bmof mei soundcore joyde=
v intel_pmc_core int3400_thermal acpi_thermal_rel acpi_tad acpi_pad button =
evdev nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 nf_tables msr parport_pc ppdev lp nfnetlink parport fuse loop efi_pstor=
e configfs ip_tables x_tables autofs4 btrfs blake2b_generic hid_logitech_hi=
dpp hid_logitech_dj rtsx_usb_sdmmc mmc_core rtsx_usb hid_jabra hid_generic =
dm_crypt dm_mod efivarfs raid10 raid456 async_raid6_recov async_memcpy asyn=
c_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear=
 md_mod usbhid hid ext4 crc16 mbcache jbd2 crc32c_generic
[  180.198772]  i915 i2c_algo_bit drm_buddy crc32_pclmul drm_display_helper=
 crc32c_intel nvme drm_kms_helper nvme_core cec ghash_clmulni_intel sha512_=
ssse3 rc_core r8169 sha512_generic ahci t10_pi xhci_pci libahci ttm realtek=
 crc64_rocksoft_generic libata xhci_hcd crc64_rocksoft crc_t10dif drm mdio_=
devres aesni_intel e1000e crct10dif_generic usbcore scsi_mod libphy crypto_=
simd cryptd crct10dif_pclmul i2c_i801 crc64 i2c_smbus crct10dif_common scsi=
_common usb_common fan video wmi
[  180.198837] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.4.0-1-amd64 #1  =
Debian 6.4.4-2
[  180.198843] Hardware name: LENOVO 30E30051UK/1052, BIOS S0AKT3AA 04/25/2=
023
[  180.198846] RIP: 0010:dev_watchdog+0x232/0x240
[  180.198852] Code: ff ff ff 48 89 df c6 05 36 03 05 01 01 e8 d6 3d fa ff =
45 89 f8 44 89 f1 48 89 de 48 89 c2 48 c7 c7 20 85 cf a9 e8 3e 17 70 ff <0f=
> 0b e9 2d ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
[  180.198857] RSP: 0018:ffffa264c026ce70 EFLAGS: 00010286
[  180.198862] RAX: 0000000000000000 RBX: ffff948781f58000 RCX: 00000000000=
00000
[  180.198866] RDX: 0000000000000104 RSI: 0000000000000027 RDI: 00000000fff=
fffff
[  180.198870] RBP: ffff948781f584c8 R08: 0000000000000000 R09: ffffa264c02=
6cd00
[  180.198873] R10: 0000000000000003 R11: ffffffffaa2d26a8 R12: ffff948781f=
4f400
[  180.198875] R13: ffff948781f5841c R14: 0000000000000000 R15: 00000000000=
02344
[  180.198879] FS:  0000000000000000(0000) GS:ffff9496b5680000(0000) knlGS:=
0000000000000000
[  180.198883] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  180.198886] CR2: 0000561606a0b170 CR3: 0000000146c82002 CR4: 00000000007=
70ee0
[  180.198890] PKRU: 55555554
[  180.198892] Call Trace:
[  180.198896]  <IRQ>
[  180.198899]  ? dev_watchdog+0x232/0x240
[  180.198904]  ? __warn+0x81/0x130
[  180.198916]  ? dev_watchdog+0x232/0x240
[  180.198920]  ? report_bug+0x191/0x1c0
[  180.198929]  ? prb_read_valid+0x1b/0x30
[  180.198938]  ? handle_bug+0x3c/0x80
[  180.198945]  ? exc_invalid_op+0x17/0x70
[  180.198951]  ? asm_exc_invalid_op+0x1a/0x20
[  180.198960]  ? dev_watchdog+0x232/0x240
[  180.198965]  ? __pfx_dev_watchdog+0x10/0x10
[  180.198969]  call_timer_fn+0x24/0x130
[  180.198979]  ? __pfx_dev_watchdog+0x10/0x10
[  180.198982]  __run_timers+0x222/0x2c0
[  180.198992]  run_timer_softirq+0x2f/0x50
[  180.199000]  __do_softirq+0xf1/0x301
[  180.199007]  __irq_exit_rcu+0xb5/0x130
[  180.199016]  sysvec_apic_timer_interrupt+0xa2/0xd0
[  180.199027]  </IRQ>
[  180.199029]  <TASK>
[  180.199031]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  180.199037] RIP: 0010:cpuidle_enter_state+0xcc/0x440
[  180.199044] Code: da fa 58 ff e8 b5 f0 ff ff 8b 53 04 49 89 c5 0f 1f 44 =
00 00 31 ff e8 73 06 58 ff 45 84 ff 0f 85 56 02 00 00 fb 0f 1f 44 00 00 <45=
> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  180.199048] RSP: 0018:ffffa264c0193e90 EFLAGS: 00000246
[  180.199052] RAX: ffff9496b5680000 RBX: ffffc264bfaa8e00 RCX: 00000000000=
00000
[  180.199055] RDX: 0000000000000002 RSI: ffffffffa9c3fd02 RDI: ffffffffa9c=
2c5ed
[  180.199058] RBP: 0000000000000002 R08: 0000000000000000 R09: 00000000334=
83483
[  180.199061] R10: ffff9496b56b1d84 R11: 00000000000006b1 R12: ffffffffaa3=
98300
[  180.199064] R13: 00000029f4a9f550 R14: 0000000000000002 R15: 00000000000=
00000
[  180.199071]  cpuidle_enter+0x2d/0x40
[  180.199081]  do_idle+0x217/0x270
[  180.199089]  cpu_startup_entry+0x1d/0x20
[  180.199095]  start_secondary+0x134/0x160
[  180.199104]  secondary_startup_64_no_verify+0x10b/0x10b
[  180.199115]  </TASK>
[  180.199117] ---[ end trace 0000000000000000 ]---
[  226.051135] r8169 0000:03:00.0 enp3s0: Link is Down
[  275.843212] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx

