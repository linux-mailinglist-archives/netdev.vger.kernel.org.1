Return-Path: <netdev+bounces-158059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A79A1049D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028EF18889B5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358922DC2C;
	Tue, 14 Jan 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bonusplay.pl header.i=@bonusplay.pl header.b="o7MSR1l4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.bonusplay.pl (unknown [132.226.202.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988962040AF
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851780; cv=none; b=IDtyAFB+IiqeY/seKpeuX3LvoYB3DdweyVafGMhZUFy+F65lgukZDLCNt1Ek+K1QgiXac1UnKFg4GX7f6t9bNsM7XaTrryUp+IGYCuM3NEl1+lxNUKRdgtepgEH04uck+b2TvQtLZ+T4h7qNbou/wbBqoyk2HmyAuCHS1E3fejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851780; c=relaxed/simple;
	bh=klXV4UttY4eYTV7jUjEz267jPS6nGu+sRMClWy2G9k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndB3DEklB5uDNjIZSJzcUz5W/f+kej75nWIyBsMKJOdEdyyoc9Jv9HNSpWTZyqGoENdWPSOyZ3dVj0l/RET+eHjJ7UWFYDI3HX+BSQRBCiGnP2r/MuAsZlscKXyTl4gLO9DL/oQrqMYONwP312SoSXAPURc1snFPO67C0E16dh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bonusplay.pl; spf=pass smtp.mailfrom=bonusplay.pl; dkim=pass (2048-bit key) header.d=bonusplay.pl header.i=@bonusplay.pl header.b=o7MSR1l4; arc=none smtp.client-ip=132.226.202.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bonusplay.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bonusplay.pl
Authentication-Results: mail.bonusplay.pl;
	auth=pass (plain)
Message-ID: <b4cba2d8-ac2d-47ca-a761-f81da6908c17@bonusplay.pl>
Date: Tue, 14 Jan 2025 11:49:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: be2net: oops due to RCU context switch
To: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Cc: netdev@vger.kernel.org
References: <515516c7-e6e9-450a-9a74-685a60d64497@bonusplay.pl>
Content-Language: en-US
From: Bonus <kernel@bonusplay.pl>
In-Reply-To: <515516c7-e6e9-450a-9a74-685a60d64497@bonusplay.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received: from localhost (Unknown [127.0.0.1])
	by mail.bonusplay.pl (Haraka) with ESMTPSA id 0B45C5FF-7B4B-4B89-8C3D-5B105F5816C5.1
	envelope-from <kernel@bonusplay.pl>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 14 Jan 2025 10:49:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonusplay.pl;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=s20211118323; t=1736851777;
 bh=klXV4UttY4eYTV7jUjEz267jPS6nGu+sRMClWy2G9k0=;
 b=o7MSR1l4lGRkbbfhqZ96Pr8lItHInIVYcsLqRQdjVkzV/+XDoIxj6/pJ+VJH7aB+Cq159rUTR
 VKPCi1C/dhsQlOhmxqsv66FoGf3cjcCCtomWFubzvSoDeAp2qEZp7OhgmgX6XaDeNlxRgm2Pgvx
 19uDmBCs8Menbn93A/x/b3c83ROEj6XQjqo/M3bAwS3L1nDcCLXRq0erkuFMVw733vIxN6TDWm9
 xF7XVyqPZGvO0W/4kF87n21aQRuPQ4rrZoz42h6sucdfDIoaMpVYYIcqVwAofobg0/Er9N7WhOH
 hWvNCEO1zibnZHnJihLb46Uzew1a9fwTm0kB/hfIKADA==

Thunderbird managed to mangle my oops trace, but I think this time it sho=
uld work.

[=C2=A0=C2=A0 17.106889] ------------[ cut here ]------------
[=C2=A0=C2=A0 17.106892] Voluntary context switch within RCU read-side cr=
itical section!
[=C2=A0=C2=A0 17.106895] WARNING: CPU: 2 PID: 1276 at kernel/rcu/tree_plu=
gin.h:331 rcu_note_context_switch+0x656/0x6e0
[=C2=A0=C2=A0 17.106899] Modules linked in: cfg80211 rfkill msr xt_conntr=
ack ip6t_rpfilter ipt_rpfilter xt_pkttype xt_LOG nf_log_syslog xt_tcpudp =
nft_compat nf_tables sch_fq_codel uinput nvidia_drm(PO) nvidia_modeset(PO=
) nls_iso8859_1 nls_cp437 vfat fat nvidia_uvm(PO) snd_soc_avs snd_soc_hda=
_codec snd_hda_codec_realtek snd_hda_ext_core snd_hda_codec_generic snd_h=
da_scodec_component snd_soc_core mei_hdcp snd_hda_codec_hdmi snd_compress=
 intel_rapl_msr ac97_bus iTCO_wdt mei_pxp intel_pmc_bxt snd_pcm_dmaengine=
 watchdog ee1004 snd_hda_intel intel_rapl_common snd_intel_dspcfg snd_int=
el_sdw_acpi snd_usb_audio mxm_wmi intel_uncore_frequency snd_hda_codec in=
tel_uncore_frequency_common intel_tcc_cooling x86_pkg_temp_thermal intel_=
powerclamp snd_usbmidi_lib snd_hda_core snd_ump coretemp snd_rawmidi snd_=
hwdep crct10dif_pclmul snd_seq_device crc32_pclmul polyval_clmulni polyva=
l_generic ghash_clmulni_intel snd_pcm battery e1000e snd_timer drm_ttm_he=
lper rapl mei_me i2c_i801 snd ttm intel_cstate ptp
i2c_mux intel_uncore pps_core be2net i2c_smbus
[=C2=A0=C2=A0 17.106944]=C2=A0 mei mc soundcore fan thermal video tpm_crb=
 backlight wmi tiny_power_button tpm_tis tpm_tis_core intel_pmc_core nvid=
ia(PO) intel_vsec acpi_pad button joydev pmt_telemetry pmt_class edac_cor=
e mousedev evdev mac_hid atkbd libps2 serio vivaldi_fmap loop cpufreq_pow=
ersave xt_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfil=
ter veth tun tap macvlan bridge stp llc kvm_intel kvm fuse efi_pstore con=
figfs nfnetlink efivarfs dmi_sysfs ip_tables x_tables autofs4 dm_crypt cb=
c encrypted_keys trusted asn1_encoder tee tpm rng_core libaescfb ecdh_gen=
eric ecc input_leds led_class hid_generic usbhid hid sd_mod ahci libahci =
libata nvme sha512_ssse3 sha256_ssse3 xhci_pci sha1_ssse3 scsi_mod aesni_=
intel nvme_core xhci_hcd gf128mul crypto_simd cryptd nvme_auth scsi_commo=
n rtc_cmos btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xo=
r raid6_pq dm_snapshot dm_bufio dm_mod dax
[=C2=A0=C2=A0 17.106998] CPU: 2 UID: 152 PID: 1276 Comm: systemd-network =
Tainted: P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.12.8 #1-NixOS
[=C2=A0=C2=A0 17.107001] Tainted: [P]=3DPROPRIETARY_MODULE, [O]=3DOOT_MOD=
ULE
[=C2=A0=C2=A0 17.107002] Hardware name: Micro-Star International Co., Ltd=
=2E MS-7B47/Z370 TOMAHAWK (MS-7B47), BIOS 1.00 09/12/2017
[=C2=A0=C2=A0 17.107003] RIP: 0010:rcu_note_context_switch+0x656/0x6e0
[=C2=A0=C2=A0 17.107005] Code: 00 00 00 0f 85 30 fd ff ff 49 89 8d a8 00 =
00 00 e9 24 fd ff ff c6 05 a5 b4 e7 01 01 90 48 c7 c7 30 e2 5e b9 e8 fb b=
3 f1 ff 90 <0f> 0b 90 90 e9 fa f9 ff ff 49 83 bd a0 00 00 00 00 49 8b 85 =
a8 00
[=C2=A0=C2=A0 17.107007] RSP: 0018:ffffa8d7c053b7d8 EFLAGS: 00010046
[=C2=A0=C2=A0 17.107008] RAX: 0000000000000000 RBX: ffff97d32a448000 RCX:=
 0000000000000000
[=C2=A0=C2=A0 17.107009] RDX: 0000000000000000 RSI: 0000000000000000 RDI:=
 0000000000000000
[=C2=A0=C2=A0 17.107010] RBP: ffff97d65eb369c0 R08: 0000000000000000 R09:=
 0000000000000000
[=C2=A0=C2=A0 17.107011] R10: 0000000000000000 R11: 0000000000000000 R12:=
 0000000000000000
[=C2=A0=C2=A0 17.107012] R13: ffff97d32a448000 R14: ffff97d30ea58814 R15:=
 ffff97d301800af0
[=C2=A0=C2=A0 17.107013] FS:=C2=A0 00007f90e82515c0(0000) GS:ffff97d65eb0=
0000(0000) knlGS:0000000000000000
[=C2=A0=C2=A0 17.107015] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
[=C2=A0=C2=A0 17.107016] CR2: 0000560b0481c360 CR3: 00000001243a0003 CR4:=
 00000000003726f0
[=C2=A0=C2=A0 17.107017] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
[=C2=A0=C2=A0 17.107018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=
 0000000000000400
[=C2=A0=C2=A0 17.107019] Call Trace:
[=C2=A0=C2=A0 17.107021]=C2=A0 <TASK>
[=C2=A0=C2=A0 17.107023]=C2=A0 ? __warn+0x89/0x130
[=C2=A0=C2=A0 17.107027]=C2=A0 ? rcu_note_context_switch+0x656/0x6e0
[=C2=A0=C2=A0 17.107029]=C2=A0 ? report_bug+0x172/0x1a0
[=C2=A0=C2=A0 17.107032]=C2=A0 ? handle_bug+0x61/0xb0
[=C2=A0=C2=A0 17.107034]=C2=A0 ? exc_invalid_op+0x17/0x80
[=C2=A0=C2=A0 17.107036]=C2=A0 ? asm_exc_invalid_op+0x1a/0x20
[=C2=A0=C2=A0 17.107040]=C2=A0 ? rcu_note_context_switch+0x656/0x6e0
[=C2=A0=C2=A0 17.107042]=C2=A0 ? rcu_note_context_switch+0x655/0x6e0
[=C2=A0=C2=A0 17.107044]=C2=A0 __schedule+0xca/0x12d0
[=C2=A0=C2=A0 17.107046]=C2=A0 ? get_nohz_timer_target+0x2a/0x140
[=C2=A0=C2=A0 17.107049]=C2=A0 ? timerqueue_add+0x66/0xd0
[=C2=A0=C2=A0 17.107052]=C2=A0 ? hrtimer_start_range_ns+0x258/0x380
[=C2=A0=C2=A0 17.107055]=C2=A0 schedule+0x27/0xf0
[=C2=A0=C2=A0 17.107056]=C2=A0 schedule_hrtimeout_range_clock+0xe2/0x140
[=C2=A0=C2=A0 17.107060]=C2=A0 ? __pfx_hrtimer_wakeup+0x10/0x10
[=C2=A0=C2=A0 17.107063]=C2=A0 ? be_mcc_notify_wait+0x6c/0x150 [be2net]
[=C2=A0=C2=A0 17.107070]=C2=A0 usleep_range_state+0x63/0xa0
[=C2=A0=C2=A0 17.107073]=C2=A0 be_mcc_notify_wait+0xbe/0x150 [be2net]
[=C2=A0=C2=A0 17.107080]=C2=A0 be_cmd_get_hsw_config+0x17c/0x1a0 [be2net]=

[=C2=A0=C2=A0 17.107088]=C2=A0 be_ndo_bridge_getlink+0xf0/0x110 [be2net]
[=C2=A0=C2=A0 17.107094]=C2=A0 rtnl_bridge_getlink+0x12a/0x1d0
[=C2=A0=C2=A0 17.107098]=C2=A0 ? __pfx_rtnl_bridge_getlink+0x10/0x10
[=C2=A0=C2=A0 17.107101]=C2=A0 rtnl_dumpit+0x85/0xb0
[=C2=A0=C2=A0 17.107103]=C2=A0 netlink_dump+0x138/0x370
[=C2=A0=C2=A0 17.107108]=C2=A0 __netlink_dump_start+0x1e7/0x2b0
[=C2=A0=C2=A0 17.107111]=C2=A0 ? __pfx_rtnl_bridge_getlink+0x10/0x10
[=C2=A0=C2=A0 17.107113]=C2=A0 rtnetlink_rcv_msg+0x2b8/0x400
[=C2=A0=C2=A0 17.107115]=C2=A0 ? __pfx_rtnl_dumpit+0x10/0x10
[=C2=A0=C2=A0 17.107117]=C2=A0 ? __pfx_rtnl_bridge_getlink+0x10/0x10
[=C2=A0=C2=A0 17.107120]=C2=A0 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[=C2=A0=C2=A0 17.107122]=C2=A0 netlink_rcv_skb+0x58/0x110
[=C2=A0=C2=A0 17.107125]=C2=A0 netlink_unicast+0x1a3/0x290
[=C2=A0=C2=A0 17.107127]=C2=A0 netlink_sendmsg+0x222/0x4b0
[=C2=A0=C2=A0 17.107129]=C2=A0 __sys_sendto+0x1ee/0x200
[=C2=A0=C2=A0 17.107134]=C2=A0 __x64_sys_sendto+0x24/0x40
[=C2=A0=C2=A0 17.107136]=C2=A0 do_syscall_64+0xb7/0x210
[=C2=A0=C2=A0 17.107138]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
[=C2=A0=C2=A0 17.107141] RIP: 0033:0x7f90e7d19df7
[=C2=A0=C2=A0 17.107150] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff =
eb 98 0f 1f 00 f3 0f 1e fa 80 3d 75 f2 0d 00 00 41 89 ca 74 30 b8 2c 00 0=
0 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 9d 00 00 00 31 d2 31 c9 31 f6 31 ff =
45 31
[=C2=A0=C2=A0 17.107151] RSP: 002b:00007ffe3ad3e3e8 EFLAGS: 00000202 ORIG=
_RAX: 000000000000002c
[=C2=A0=C2=A0 17.107153] RAX: ffffffffffffffda RBX: 0000560b047eebd0 RCX:=
 00007f90e7d19df7
[=C2=A0=C2=A0 17.107154] RDX: 0000000000000020 RSI: 0000560b04805bb0 RDI:=
 0000000000000003
[=C2=A0=C2=A0 17.107155] RBP: 0000560b0481bff0 R08: 00007ffe3ad3e3f0 R09:=
 0000000000000080
[=C2=A0=C2=A0 17.107156] R10: 0000000000000000 R11: 0000000000000202 R12:=
 00007ffe3ad3e4b4
[=C2=A0=C2=A0 17.107157] R13: 00007ffe3ad3e4f0 R14: 0000560ae711c650 R15:=
 0000560ae71dbc78
[=C2=A0=C2=A0 17.107159]=C2=A0 </TASK>
[=C2=A0=C2=A0 17.107160] ---[ end trace 0000000000000000 ]---


