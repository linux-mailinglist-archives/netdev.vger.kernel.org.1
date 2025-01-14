Return-Path: <netdev+bounces-158054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E4A1046B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DFE169274
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5621ADC9F;
	Tue, 14 Jan 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bonusplay.pl header.i=@bonusplay.pl header.b="Nxv7a7F6"
X-Original-To: netdev@vger.kernel.org
Received: from mail.bonusplay.pl (unknown [132.226.202.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF322F19
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851133; cv=none; b=jjd0Ln/yHJQgs1bBAh7/k7hthZ94IbDX5bJLLq1+QyZLm70/u8CjEE/fE6e2gPlQQ2wzRbyr8CwSFATCI3m6bnCxPpX92PXea+tnPffMCM5TvRQFVXuYbxRtEmOGl5m6uDvu181qDvtjC8lSzz7Tjg0vDumpJDkEYwu8aaE47B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851133; c=relaxed/simple;
	bh=EAjnoKhSvgH8erVkFzl8Pt4T6T7ANueknhSi8x6DCSs=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=kM1bXLAmzVFVWVGm7UFQ94aDERkpHRszg7toh9aS38yOvUSafRuW8eyRO1LdR1V4Zv4HKA5SZMkikpcMswFEPsLEmjWZFe69QxBkgpGPLmeKKvBaxC5gz6swVP8L877FkdTh+Aqz68s8hfJjJR25zStJf9dW1Fitc6p51eVICq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bonusplay.pl; spf=pass smtp.mailfrom=bonusplay.pl; dkim=pass (2048-bit key) header.d=bonusplay.pl header.i=@bonusplay.pl header.b=Nxv7a7F6; arc=none smtp.client-ip=132.226.202.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bonusplay.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bonusplay.pl
Authentication-Results: mail.bonusplay.pl;
	auth=pass (plain)
Message-ID: <515516c7-e6e9-450a-9a74-685a60d64497@bonusplay.pl>
Date: Tue, 14 Jan 2025 11:37:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
From: Bonus <kernel@bonusplay.pl>
Cc: netdev@vger.kernel.org
Subject: be2net: oops due to RCU context switch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.bonusplay.pl (Haraka) with ESMTPSA id 359F6B3A-7A17-4596-953D-C7EC904BABB4.1
	envelope-from <kernel@bonusplay.pl>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 14 Jan 2025 10:37:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonusplay.pl;
 h=Content-Transfer-Encoding: Content-Type: Subject: Cc: From: To:
 MIME-Version: Date: Message-ID; q=dns/txt; s=s20211118323; t=1736851057;
 bh=aPbJjbAXr60hPreQ6wJaNWNZx+zRJQtMGKz6ClcLd8w=;
 b=Nxv7a7F6ON3Ef2ntogzdqM1sDz/uvIH4HGgT0WEDt2Fo2vmL1kS8NJ+11DzhMMwLozsfq7JJS
 ZSVJVUGZ7DC6ZJ3/8Mn3p/wbMqhS8QMCrWMOdYySw5UjGgxB50S+yFDOOxq8SthNLSpsscdXSiq
 SlukRPXO7Zd21YnBd6d4+aWHOD4LCrRUPw3jF8KTfTK0E8H1ifb/Bd4PSzX8b39obFUVcBgAvR9
 xGLbAwrf+VY7JhPUr23IFaAFWNLX+cfKXV9l6XhNWaRsrgroIuKNkMRRnya2qZrTqFwl+pnEXeB
 aLIz3LSrYeHMorqGZzdNZ70PpAzW43m5Aa5F0i63pQ1A==

Hello,

I've encountered a regression with kernel 6.12 immediately after 
booting. I don't encounter it on 6.6. If required i can try to bisect 
it, as it is very easy to reproduce.

Stack trace below:

[ 17.106889] ------------[ cut here ]------------ [ 17.106892] Voluntary 
context switch within RCU read-side critical section! [ 17.106895] 
WARNING: CPU: 2 PID: 1276 at kernel/rcu/tree_plugin.h:331 
rcu_note_context_switch+0x656/0x6e0 [ 17.106899] Modules linked in: 
cfg80211 rfkill msr xt_conntrack ip6t_rpfilter ipt_rpfilter xt_pkttype 
xt_LOG nf_log_syslog xt_tcpudp nft_compat nf_tables sch_fq_codel uinput 
nvidia_drm(PO) nvidia_modeset(PO) nls_iso8859_1 nls_cp437 vfat fat 
nvidia_uvm(PO) snd_soc_avs snd_soc_hda_codec snd_hda_codec_realtek 
snd_hda_ext_core snd_hda_codec_generic snd_hda_scodec_component 
snd_soc_core mei_hdcp snd_hda_codec_hdmi snd_compress intel_rapl_msr 
ac97_bus iTCO_wdt mei_pxp intel_pmc_bxt snd_pcm_dmaengine watchdog 
ee1004 snd_hda_intel intel_rapl_common snd_intel_dspcfg 
snd_intel_sdw_acpi snd_usb_audio mxm_wmi intel_uncore_frequency 
snd_hda_codec intel_uncore_frequency_common intel_tcc_cooling 
x86_pkg_temp_thermal intel_powerclamp snd_usbmidi_lib snd_hda_core 
snd_ump coretemp snd_rawmidi snd_hwdep crct10dif_pclmul snd_seq_device 
crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel snd_pcm 
battery e1000e snd_timer drm_ttm_helper rapl mei_me i2c_i801 snd ttm 
intel_cstate ptp i2c_mux intel_uncore pps_core be2net i2c_smbus [ 
17.106944] mei mc soundcore fan thermal video tpm_crb backlight wmi 
tiny_power_button tpm_tis tpm_tis_core intel_pmc_core nvidia(PO) 
intel_vsec acpi_pad button joydev pmt_telemetry pmt_class edac_core 
mousedev evdev mac_hid atkbd libps2 serio vivaldi_fmap loop 
cpufreq_powersave xt_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 br_netfilter veth tun tap macvlan bridge stp llc 
kvm_intel kvm fuse efi_pstore configfs nfnetlink efivarfs dmi_sysfs 
ip_tables x_tables autofs4 dm_crypt cbc encrypted_keys trusted 
asn1_encoder tee tpm rng_core libaescfb ecdh_generic ecc input_leds 
led_class hid_generic usbhid hid sd_mod ahci libahci libata nvme 
sha512_ssse3 sha256_ssse3 xhci_pci sha1_ssse3 scsi_mod aesni_intel 
nvme_core xhci_hcd gf128mul crypto_simd cryptd nvme_auth scsi_common 
rtc_cmos btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor 
raid6_pq dm_snapshot dm_bufio dm_mod dax [ 17.106998] CPU: 2 UID: 152 
PID: 1276 Comm: systemd-network Tainted: P O 6.12.8 #1-NixOS [ 
17.107001] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE [ 17.107002] 
Hardware name: Micro-Star International Co., Ltd. MS-7B47/Z370 TOMAHAWK 
(MS-7B47), BIOS 1.00 09/12/2017 [ 17.107003] RIP: 
0010:rcu_note_context_switch+0x656/0x6e0 [ 17.107005] Code: 00 00 00 0f 
85 30 fd ff ff 49 89 8d a8 00 00 00 e9 24 fd ff ff c6 05 a5 b4 e7 01 01 
90 48 c7 c7 30 e2 5e b9 e8 fb b3 f1 ff 90 <0f> 0b 90 90 e9 fa f9 ff ff 
49 83 bd a0 00 00 00 00 49 8b 85 a8 00 [ 17.107007] RSP: 
0018:ffffa8d7c053b7d8 EFLAGS: 00010046 [ 17.107008] RAX: 
0000000000000000 RBX: ffff97d32a448000 RCX: 0000000000000000 [ 
17.107009] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000 [ 17.107010] RBP: ffff97d65eb369c0 R08: 
0000000000000000 R09: 0000000000000000 [ 17.107011] R10: 
0000000000000000 R11: 0000000000000000 R12: 0000000000000000 [ 
17.107012] R13: ffff97d32a448000 R14: ffff97d30ea58814 R15: 
ffff97d301800af0 [ 17.107013] FS: 00007f90e82515c0(0000) 
GS:ffff97d65eb00000(0000) knlGS:0000000000000000 [ 17.107015] CS: 0010 
DS: 0000 ES: 0000 CR0: 0000000080050033 [ 17.107016] CR2: 
0000560b0481c360 CR3: 00000001243a0003 CR4: 00000000003726f0 [ 
17.107017] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000 [ 17.107018] DR3: 0000000000000000 DR6: 
00000000fffe0ff0 DR7: 0000000000000400 [ 17.107019] Call Trace: [ 
17.107021] <TASK> [ 17.107023] ? __warn+0x89/0x130 [ 17.107027] ? 
rcu_note_context_switch+0x656/0x6e0 [ 17.107029] ? 
report_bug+0x172/0x1a0 [ 17.107032] ? handle_bug+0x61/0xb0 [ 17.107034] 
? exc_invalid_op+0x17/0x80 [ 17.107036] ? asm_exc_invalid_op+0x1a/0x20 [ 
17.107040] ? rcu_note_context_switch+0x656/0x6e0 [ 17.107042] ? 
rcu_note_context_switch+0x655/0x6e0 [ 17.107044] __schedule+0xca/0x12d0 
[ 17.107046] ? get_nohz_timer_target+0x2a/0x140 [ 17.107049] ? 
timerqueue_add+0x66/0xd0 [ 17.107052] ? 
hrtimer_start_range_ns+0x258/0x380 [ 17.107055] schedule+0x27/0xf0 [ 
17.107056] schedule_hrtimeout_range_clock+0xe2/0x140 [ 17.107060] ? 
__pfx_hrtimer_wakeup+0x10/0x10 [ 17.107063] ? 
be_mcc_notify_wait+0x6c/0x150 [be2net] [ 17.107070] 
usleep_range_state+0x63/0xa0 [ 17.107073] be_mcc_notify_wait+0xbe/0x150 
[be2net] [ 17.107080] be_cmd_get_hsw_config+0x17c/0x1a0 [be2net] [ 
17.107088] be_ndo_bridge_getlink+0xf0/0x110 [be2net] [ 17.107094] 
rtnl_bridge_getlink+0x12a/0x1d0 [ 17.107098] ? 
__pfx_rtnl_bridge_getlink+0x10/0x10 [ 17.107101] rtnl_dumpit+0x85/0xb0 [ 
17.107103] netlink_dump+0x138/0x370 [ 17.107108] 
__netlink_dump_start+0x1e7/0x2b0 [ 17.107111] ? 
__pfx_rtnl_bridge_getlink+0x10/0x10 [ 17.107113] 
rtnetlink_rcv_msg+0x2b8/0x400 [ 17.107115] ? __pfx_rtnl_dumpit+0x10/0x10 
[ 17.107117] ? __pfx_rtnl_bridge_getlink+0x10/0x10 [ 17.107120] ? 
__pfx_rtnetlink_rcv_msg+0x10/0x10 [ 17.107122] 
netlink_rcv_skb+0x58/0x110 [ 17.107125] netlink_unicast+0x1a3/0x290 [ 
17.107127] netlink_sendmsg+0x222/0x4b0 [ 17.107129] 
__sys_sendto+0x1ee/0x200 [ 17.107134] __x64_sys_sendto+0x24/0x40 [ 
17.107136] do_syscall_64+0xb7/0x210 [ 17.107138] 
entry_SYSCALL_64_after_hwframe+0x77/0x7f [ 17.107141] RIP: 
0033:0x7f90e7d19df7 [ 17.107150] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff 
ff ff ff eb 98 0f 1f 00 f3 0f 1e fa 80 3d 75 f2 0d 00 00 41 89 ca 74 30 
b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 9d 00 00 00 31 d2 31 c9 
31 f6 31 ff 45 31 [ 17.107151] RSP: 002b:00007ffe3ad3e3e8 EFLAGS: 
00000202 ORIG_RAX: 000000000000002c [ 17.107153] RAX: ffffffffffffffda 
RBX: 0000560b047eebd0 RCX: 00007f90e7d19df7 [ 17.107154] RDX: 
0000000000000020 RSI: 0000560b04805bb0 RDI: 0000000000000003 [ 
17.107155] RBP: 0000560b0481bff0 R08: 00007ffe3ad3e3f0 R09: 
0000000000000080 [ 17.107156] R10: 0000000000000000 R11: 
0000000000000202 R12: 00007ffe3ad3e4b4 [ 17.107157] R13: 
00007ffe3ad3e4f0 R14: 0000560ae711c650 R15: 0000560ae71dbc78 [ 
17.107159] </TASK> [ 17.107160] ---[ end trace 0000000000000000 ]---

Kind Regards, Bonus


