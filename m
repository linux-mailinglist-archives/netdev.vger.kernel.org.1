Return-Path: <netdev+bounces-234832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE492C27C21
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 11:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C856D4043C1
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2F2D838F;
	Sat,  1 Nov 2025 10:47:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF712D3737
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994046; cv=none; b=D4i2PUIQ49grwKwmHjit2XbRIlTHDN5TatH337ul20IX5fA19AvABKgUV+yXaU0FK+jMXJmXt/xWvi400eWUwfIEHYVn72g36FKy7XbcAyBOTmF836mAgGm8XP82cFdPZ8K8vFJ45dUwQ5G22kLHR39uPRVYeCpibe15iPiJOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994046; c=relaxed/simple;
	bh=qFgZ6BMfPVR4L7kSkP9Sp2uEYtB1QegDqr07U33I0Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkYW+sWwc+gKaKckp+W0dyeUHyb4NeWfu4AHuxiFF+dWyp3zgwXlB9yrUzfoaKJmnwMLYfOYepzMRgyJRgbSCD5osf/7/MMuaEwPKteUQCqoSa50oqcKP060k52ejYTy/tWdCmYVdGp4gWBu4I5+KKkcNnUUb6Y1bzIez+Xwm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.214] (p5dc558ed.dip0.t-ipconnect.de [93.197.88.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A4523617C4F97;
	Sat, 01 Nov 2025 11:46:15 +0100 (CET)
Message-ID: <f3fec306-13bb-49c8-a41c-8c0d73eca4d8@molgen.mpg.de>
Date: Sat, 1 Nov 2025 11:46:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panics trying to set up L2TP VPN
 (`__xfrm_state_destroy+0x6e/0x80`)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 James Chapman <jchapman@katalix.com>, regressions@lists.linux.dev
References: <b353f7e5-c32a-4f91-acbc-2b7aaa64c28f@molgen.mpg.de>
 <20251006115812.7408e8e9@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251006115812.7408e8e9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jakub,


Thank you for your reply, and sorry for the late reply.

Am 06.10.25 um 20:58 schrieb Jakub Kicinski:
> On Mon, 6 Oct 2025 08:37:06 +0200 Paul Menzel wrote:
>> #regzbot introduced: v6.17..070a542f08ac
> 
> Nothing obvious in this range. Could you bisect?

As I only have the production system, and it’s crashing the system, I 
did not want to bisect it on the system. I tried to set up a virtual 
machine (KVM/QEMU) but I am unable to reproduce it there.

> On xfrm side only c829aab21ed55 stands out but it's not too complex
> either.

For the record, I am *not* able to reproduce it with Linus’ current 
master branch v6.18-rc3-256-gba36dd5ee6fd.

The last tested commit is 6.17.0-12260-g0d97f2067c16, and I was able to 
reproduce it there with the trace at the end.


Kind regards,

Paul


```
Okt 22 23:35:58.447796 abreu kernel: Linux version 
6.17.0-12260-g0d97f2067c16 (build@bohemianrhapsody.molgen.mpg.de) (gcc 
(Debian 15.2.0-4) 15.2.0, GNU ld (GNU Binutils for Debian) 2.45) #153 
SMP PREEMPT_DYNAMIC Thu Oct  9 00:10:03 CEST 2025
[…]
Okt 22 23:36:26.279033 abreu nm-l2tp-service[2198]: /sbin/xl2tpd -D -c 
/run/nm-l2tp-837a96df-4fbc-4487-a2f5-152ff4e1ebd7/xl2tpd.conf -C 
/run/nm-l2tp-837a96df-4fbc-4487-a2f5-152ff4e1ebd7/xl2tpd-control -p 
/run/nm-l2tp-837a96df-4fbc-4487-a2f5-152ff4e1ebd7/xl2tpd.pid
Okt 22 23:36:26.280492 abreu nm-l2tp-service[2198]: xl2tpd started with 
pid 2300
Okt 22 23:36:26.280923 abreu NetworkManager[2300]: xl2tpd[2300]: Not 
looking for kernel SAref support.
Okt 22 23:36:26.289931 abreu kernel: PPP generic driver version 2.4.2
Okt 22 23:36:26.293979 abreu kernel: NET: Registered PF_PPPOX protocol 
family
Okt 22 23:36:26.301929 abreu kernel: l2tp_core: L2TP core driver, V2.0
Okt 22 23:36:26.303397 abreu kernel: l2tp_netlink: L2TP netlink interface
Okt 22 23:36:26.303448 abreu NetworkManager[2300]: xl2tpd[2300]: Using 
l2tp kernel support.
Okt 22 23:36:26.303448 abreu NetworkManager[2300]: xl2tpd[2300]: xl2tpd 
version xl2tpd-1.3.18 started on abreu PID:2300
Okt 22 23:36:26.303448 abreu NetworkManager[2300]: xl2tpd[2300]: Written 
by Mark Spencer, Copyright (C) 1998, Adtran, Inc.
Okt 22 23:36:26.303448 abreu NetworkManager[2300]: xl2tpd[2300]: Forked 
by Scott Balmos and David Stipp, (C) 2001
Okt 22 23:36:26.303448 abreu NetworkManager[2300]: xl2tpd[2300]: 
Inherited by Jeff McAdams, (C) 2002
Okt 22 23:36:26.303448 abreu NetworkManager[2300]: xl2tpd[2300]: Forked 
again by Xelerance (www.xelerance.com) (C) 2006-2016
Okt 22 23:36:26.303448 abreu NetworkManager[2300]: xl2tpd[2300]: 
Listening on IP address 0.0.0.0, port 1701
Okt 22 23:36:26.303448 abreu NetworkManager[2300]: xl2tpd[2300]: 
Connecting to host 141.14.220.175, port 1701
Okt 22 23:36:26.303781 abreu kernel: l2tp_ppp: PPPoL2TP kernel driver, V2.0
Okt 22 23:36:26.320509 abreu NetworkManager[2300]: xl2tpd[2300]: 
Connection established to 141.14.220.175, 1701.  Local: 8963, Remote: 1 
(ref=0/0).
Okt 22 23:36:26.320626 abreu NetworkManager[2300]: xl2tpd[2300]: Calling 
on tunnel 8963
Okt 22 23:36:26.322327 abreu kernel: ------------[ cut here ]------------
Okt 22 23:36:26.322385 abreu kernel: WARNING: CPU: 1 PID: 0 at 
net/xfrm/xfrm_state.c:800 __xfrm_state_destroy+0x6e/0x80
Okt 22 23:36:26.322409 abreu kernel: Modules linked in: l2tp_ppp 
l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppox ppp_generic slhc 
sha3_generic jitterentropy_rng drbg ansi_cprng authenc echainiv geniv 
esp4 xfrm_interface xfrm6_tunnel tunnel6 xfrm_user xfrm_algo sd_mod 
scsi_mod scsi_common cmac ccm snd_seq_dummy snd_hrtimer snd_seq 
snd_seq_device snd_hda_codec_intelhdmi uvcvideo videobuf2_vmalloc 
videobuf2_memops uvc videobuf2_v4l2 videodev videobuf2_common btusb 
btrtl btintel btbcm mc bluetooth usbhid snd_ctl_led ecdh_generic ecc 
snd_hda_codec_alc269 snd_hda_scodec_component snd_hda_codec_realtek_lib 
snd_hda_codec_generic snd_hda_intel snd_sof_pci_intel_skl 
snd_sof_intel_hda_generic snd_soc_acpi_intel_match snd_soc_acpi 
snd_soc_acpi_intel_sdca_quirks snd_sof_pci snd_sof_xtensa_dsp 
soundwire_intel soundwire_generic_allocation snd_sof_intel_hda_sdw_bpt 
joydev snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink 
snd_sof_intel_hda snd_hda_codec_hdmi snd_sof binfmt_misc snd_sof_utils 
soundwire_cadence crc8 soundwire_bus
Okt 22 23:36:26.322587 abreu kernel:  snd_soc_sdca snd_soc_avs 
snd_soc_hda_codec hid_multitouch snd_hda_ext_core hid_generic 
snd_hda_codec snd_hda_core nls_ascii x86_pkg_temp_thermal nls_cp437 
snd_intel_dspcfg intel_powerclamp ath10k_pci vfat coretemp 
snd_intel_sdw_acpi fat ath10k_core kvm_intel snd_soc_core ath dell_pc 
snd_compress kvm snd_hwdep mac80211 mei_hdcp mei_wdt mei_pxp snd_pcm 
libarc4 snd_timer irqbypass iTCO_wdt ghash_clmulni_intel rapl 
intel_pmc_bxt snd iTCO_vendor_support intel_cstate dell_laptop cfg80211 
intel_xhci_usb_role_switch mei_me i2c_i801 intel_lpss_pci intel_rapl_msr 
dell_smm_hwmon intel_uncore intel_wmi_thunderbolt rtsx_pci soundcore 
wmi_bmof i2c_smbus rfkill ucsi_acpi mei typec_ucsi roles intel_lpss i915 
idma64 typec intel_pch_thermal intel_pmc_core 
processor_thermal_device_pci_legacy i2c_algo_bit intel_soc_dts_iosf 
pmt_telemetry drm_buddy processor_thermal_device 
processor_thermal_wt_hint platform_temperature_control 
processor_thermal_soc_slider platform_profile pmt_discovery i2c_hid_acpi 
intel_gtt
Okt 22 23:36:26.322662 abreu kernel:  processor_thermal_rfim i2c_hid 
processor_thermal_rapl pmt_class intel_rapl_common xhci_pci 
drm_display_helper hid xhci_hcd processor_thermal_wt_req 
intel_pmc_ssram_telemetry ttm intel_oc_wdt intel_vbtn soc_button_array 
watchdog drm_client_lib usbcore int3403_thermal intel_vsec 
processor_thermal_power_floor battery processor_thermal_mbox 
int3400_thermal int340x_thermal_zone drm_kms_helper acpi_thermal_rel 
acpi_pad usb_common ac button msr parport_pc ppdev lp parport drm 
efi_pstore configfs nfnetlink efivarfs autofs4 ext4 crc16 mbcache jbd2 
dm_crypt dm_mod dell_wmi dell_smbios dell_wmi_descriptor dcdbas evdev 
video pcspkr serio_raw nvme nvme_core intel_hid wmi sparse_keymap 
aesni_intel
Okt 22 23:36:26.322716 abreu kernel: CPU: 1 UID: 0 PID: 0 Comm: 
swapper/1 Not tainted 6.17.0-12260-g0d97f2067c16 #153 PREEMPT(voluntary)
Okt 22 23:36:26.322738 abreu kernel: Hardware name: Dell Inc. XPS 13 
9360/0596KF, BIOS 2.21.0 06/02/2022
Okt 22 23:36:26.322769 abreu kernel: RIP: 
0010:__xfrm_state_destroy+0x6e/0x80
Okt 22 23:36:26.322799 abreu kernel: Code: 94 45 3c b1 48 c7 43 10 18 47 
3c b1 e8 ab 3d 10 00 48 8b 35 5c 5d 74 00 48 c7 c2 40 ea 80 b0 5b bf 00 
20 00 00 e9 22 05 5b ff <0f> 0b eb a4 0f 1f 00 66 66 2e 0f 1f 84 00 00 
00 00 00 f3 0f 1e fa
Okt 22 23:36:26.322820 abreu kernel: RSP: 0018:ffffbb27c003ee28 EFLAGS: 
00010293
Okt 22 23:36:26.322839 abreu kernel: RAX: 0000000000000001 RBX: 
ffff908de8b57a80 RCX: 0000000000000000
Okt 22 23:36:26.322864 abreu kernel: RDX: ffffffffaf808b40 RSI: 
0000000000000001 RDI: ffff908de8b57a80
Okt 22 23:36:26.322890 abreu kernel: RBP: 0000000000000000 R08: 
53f4d085493d81fc R09: e1e25ba0b71cb30f
Okt 22 23:36:26.322913 abreu kernel: R10: ffffffffb06080c0 R11: 
ffffbb27c003eff8 R12: ffff908d98f56808
Okt 22 23:36:26.322942 abreu kernel: R13: 00000000ffff0037 R14: 
ffffbb27c003eed0 R15: 0000000000000003
Okt 22 23:36:26.322971 abreu kernel: FS:  0000000000000000(0000) 
GS:ffff90913bd09000(0000) knlGS:0000000000000000
Okt 22 23:36:26.322996 abreu kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Okt 22 23:36:26.323022 abreu kernel: CR2: 00007f08b2f9c0e0 CR3: 
00000003a6222002 CR4: 00000000003726f0
Okt 22 23:36:26.323051 abreu kernel: Call Trace:
Okt 22 23:36:26.323070 abreu kernel:  <IRQ>
Okt 22 23:36:26.323093 abreu kernel:  __skb_ext_put+0x94/0xc0
Okt 22 23:36:26.323113 abreu kernel:  napi_consume_skb+0x42/0x100
Okt 22 23:36:26.323134 abreu kernel:  skb_defer_free_flush+0x70/0xb0
Okt 22 23:36:26.323158 abreu kernel:  net_rx_action+0x101/0x300
Okt 22 23:36:26.323180 abreu kernel:  ? __mod_timer+0x123/0x340
Okt 22 23:36:26.323199 abreu kernel:  handle_softirqs+0xc8/0x270
Okt 22 23:36:26.323222 abreu kernel:  __irq_exit_rcu+0xac/0xd0
Okt 22 23:36:26.323251 abreu kernel:  common_interrupt+0x85/0xa0
Okt 22 23:36:26.323278 abreu kernel:  </IRQ>
Okt 22 23:36:26.323301 abreu kernel:  <TASK>
Okt 22 23:36:26.323327 abreu kernel:  asm_common_interrupt+0x26/0x40
Okt 22 23:36:26.323354 abreu kernel: RIP: 
0010:cpuidle_enter_state+0xb5/0x400
Okt 22 23:36:26.323376 abreu kernel: Code: 00 00 e8 0e 2a 50 ff e8 39 f5 
ff ff 48 89 c5 0f 1f 44 00 00 31 ff e8 1a 3a 4f ff 45 84 ff 0f 85 2f 02 
00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 78 01 00 00 49 63 ce 48 2b 2c 
24 48 6b d1 68 48 89
Okt 22 23:36:26.323401 abreu kernel: RSP: 0018:ffffbb27c00fbe78 EFLAGS: 
00000246
Okt 22 23:36:26.323424 abreu kernel: RAX: ffff90913bd09000 RBX: 
0000000000000003 RCX: 0000000000000000
Okt 22 23:36:26.323457 abreu kernel: RDX: 00000008e16d4da1 RSI: 
fffffffdd5da65ec RDI: 0000000000000000
Okt 22 23:36:26.323484 abreu kernel: RBP: 00000008e16d4da1 R08: 
0000000000000002 R09: 00000000000008d1
Okt 22 23:36:26.323507 abreu kernel: R10: 000000000000090e R11: 
ffffffffffffffff R12: ffff9090eccca7c8
Okt 22 23:36:26.323528 abreu kernel: R13: ffffffffb07ae900 R14: 
0000000000000003 R15: 0000000000000000
Okt 22 23:36:26.323587 abreu kernel:  ? cpuidle_enter_state+0xa6/0x400
Okt 22 23:36:26.323609 abreu kernel:  cpuidle_enter+0x31/0x40
Okt 22 23:36:26.323631 abreu kernel:  do_idle+0x1de/0x240
Okt 22 23:36:26.323654 abreu kernel:  cpu_startup_entry+0x29/0x30
Okt 22 23:36:26.323679 abreu kernel:  start_secondary+0x107/0x130
Okt 22 23:36:26.323701 abreu kernel:  common_startup_64+0x13e/0x141
Okt 22 23:36:26.323723 abreu kernel:  </TASK>
Okt 22 23:36:26.323749 abreu kernel: ---[ end trace 0000000000000000 ]---
Okt 22 23:36:27.486519 abreu systemd[1]: 
NetworkManager-dispatcher.service: Deactivated successfully.
[…]
Okt 22 23:36:42.348536 abreu systemd[1]: 
NetworkManager-dispatcher.service: Deactivated successfully.
Okt 22 23:36:42.419150 abreu nm-l2tp-service[2198]: ipsec shut down
Okt 22 23:36:42.438007 abreu NetworkManager[2422]: Stopping strongSwan 
IPsec failed: starter is not running
Okt 22 23:36:42.441580 abreu nm-l2tp-service[2198]: ipsec shut down
Okt 22 23:36:43.882127 abreu kernel: Oops: general protection fault, 
probably for non-canonical address 0x774f29fad633ebf3: 0000 [#1] SMP
Okt 22 23:36:43.882758 abreu kernel: CPU: 1 UID: 5272 PID: 1428 Comm: 
gnome-shell Tainted: G        W           6.17.0-12260-g0d97f2067c16 
#153 PREEMPT(voluntary)
Okt 22 23:36:43.883011 abreu kernel: Tainted: [W]=WARN
Okt 22 23:36:43.883038 abreu kernel: Hardware name: Dell Inc. XPS 13 
9360/0596KF, BIOS 2.21.0 06/02/2022
Okt 22 23:36:43.883166 abreu kernel: RIP: 
0010:kmem_cache_alloc_noprof+0x47c/0x620
Okt 22 23:36:43.883186 abreu kernel: Code: c2 e9 d1 fc ff ff 48 85 ff 0f 
84 8b fe ff ff 48 85 c9 0f 84 82 fe ff ff 41 b9 ff ff ff ff 41 8b 44 24 
30 49 8b 34 24 48 01 f8 <4c> 8b 00 48 89 c1 4d 33 84 24 c0 00 00 00 48 
89 f8 48 0f c9 49 31
Okt 22 23:36:43.883309 abreu kernel: RSP: 0018:ffffbb27c4ae7690 EFLAGS: 
00010006
Okt 22 23:36:43.883324 abreu kernel: RAX: 774f29fad633ebf3 RBX: 
000000000000001b RCX: ffffe9770463d580
Okt 22 23:36:43.883349 abreu kernel: RDX: 00000000003be001 RSI: 
ffffffffb0fbd950 RDI: 774f29fad633ebb3
Okt 22 23:36:43.883473 abreu kernel: RBP: ffffbb27c4ae76f0 R08: 
ffff908d9e4c03d0 R09: 00000000ffffffff
Okt 22 23:36:43.883493 abreu kernel: R10: 0000000000000080 R11: 
0000000080200020 R12: ffff908d8110d400
Okt 22 23:36:43.883508 abreu kernel: R13: 0000000000000820 R14: 
0000000000000080 R15: ffffffffc0c7aa22
Okt 22 23:36:43.883629 abreu kernel: FS:  00007f76633b0000(0000) 
GS:ffff90913bd09000(0000) knlGS:0000000000000000
Okt 22 23:36:43.883650 abreu kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Okt 22 23:36:43.883668 abreu kernel: CR2: 0000561f2e1b3940 CR3: 
0000000151f69001 CR4: 00000000003726f0
Okt 22 23:36:43.883795 abreu kernel: Call Trace:
Okt 22 23:36:43.883811 abreu kernel:  <TASK>
Okt 22 23:36:43.883936 abreu kernel: 
i915_active_add_request+0x192/0x2a0 [i915]
Okt 22 23:36:43.883953 abreu kernel: 
_i915_vma_move_to_active+0xe4/0x350 [i915]
Okt 22 23:36:43.883971 abreu kernel: 
i915_gem_do_execbuffer+0x2048/0x2d90 [i915]
Okt 22 23:36:43.884091 abreu kernel: 
i915_gem_execbuffer2_ioctl+0x12a/0x2a0 [i915]
Okt 22 23:36:43.884108 abreu kernel:  ? 
i915_gem_do_execbuffer+0x2d90/0x2d90 [i915]
Okt 22 23:36:43.884127 abreu kernel:  drm_ioctl_kernel+0xa3/0xf0 [drm]
Okt 22 23:36:43.884251 abreu kernel:  drm_ioctl+0x3c0/0x570 [drm]
Okt 22 23:36:43.884269 abreu kernel:  ? 
i915_gem_do_execbuffer+0x2d90/0x2d90 [i915]
Okt 22 23:36:43.884287 abreu kernel:  __x64_sys_ioctl+0x3fb/0x900
Okt 22 23:36:43.884418 abreu kernel:  ? __x64_sys_ioctl+0x173/0x900
Okt 22 23:36:43.884440 abreu kernel:  do_syscall_64+0x82/0x9b0
Okt 22 23:36:43.884563 abreu kernel:  ? do_syscall_64+0xbb/0x9b0
Okt 22 23:36:43.884585 abreu kernel:  ? do_syscall_64+0xbb/0x9b0
Okt 22 23:36:43.884602 abreu kernel:  ? do_syscall_64+0xbb/0x9b0
Okt 22 23:36:43.884722 abreu kernel:  ? count_memcg_events+0xba/0x180
Okt 22 23:36:43.884749 abreu kernel:  ? handle_mm_fault+0x1d3/0x2d0
Okt 22 23:36:43.884886 abreu kernel:  ? do_user_addr_fault+0x216/0x690
Okt 22 23:36:43.884919 abreu kernel:  ? exc_page_fault+0x7e/0x1a0
Okt 22 23:36:43.884949 abreu kernel: 
entry_SYSCALL_64_after_hwframe+0x4b/0x53
Okt 22 23:36:43.884975 abreu kernel: RIP: 0033:0x7f76683168db
Okt 22 23:36:43.885004 abreu kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 
44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 
10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 
48 2b 04 25 28 00 00
Okt 22 23:36:43.885028 abreu kernel: RSP: 002b:00007ffc72a0cd20 EFLAGS: 
00000246 ORIG_RAX: 0000000000000010
Okt 22 23:36:43.885062 abreu kernel: RAX: ffffffffffffffda RBX: 
0000561f2b3ef070 RCX: 00007f76683168db
Okt 22 23:36:43.885092 abreu kernel: RDX: 00007ffc72a0cd90 RSI: 
0000000040406469 RDI: 000000000000000e
Okt 22 23:36:43.885119 abreu kernel: RBP: 0000561f2d1a8200 R08: 
0000561f2b179860 R09: 0000000000000001
Okt 22 23:36:43.885144 abreu kernel: R10: 00007f76683f1b70 R11: 
0000000000000246 R12: 000000000000000e
Okt 22 23:36:43.885168 abreu kernel: R13: 00007f764b4603c0 R14: 
0000561f2e2987e0 R15: 0000561f2b17987c
Okt 22 23:36:43.885302 abreu kernel:  </TASK>
Okt 22 23:36:43.885329 abreu kernel: Modules linked in: l2tp_ppp 
l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppox ppp_generic slhc 
sha3_generic jitterentropy_rng drbg ansi_cprng authenc echainiv geniv 
esp4 xfrm_interface xfrm6_tunnel tunnel6 xfrm_user xfrm_algo sd_mod 
scsi_mod scsi_common cmac ccm snd_seq_dummy snd_hrtimer snd_seq 
snd_seq_device snd_hda_codec_intelhdmi uvcvideo videobuf2_vmalloc 
videobuf2_memops uvc videobuf2_v4l2 videodev videobuf2_common btusb 
btrtl btintel btbcm mc bluetooth usbhid snd_ctl_led ecdh_generic ecc 
snd_hda_codec_alc269 snd_hda_scodec_component snd_hda_codec_realtek_lib 
snd_hda_codec_generic snd_hda_intel snd_sof_pci_intel_skl 
snd_sof_intel_hda_generic snd_soc_acpi_intel_match snd_soc_acpi 
snd_soc_acpi_intel_sdca_quirks snd_sof_pci snd_sof_xtensa_dsp 
soundwire_intel soundwire_generic_allocation snd_sof_intel_hda_sdw_bpt 
joydev snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink 
snd_sof_intel_hda snd_hda_codec_hdmi snd_sof binfmt_misc snd_sof_utils 
soundwire_cadence crc8 soundwire_bus
Okt 22 23:36:43.885403 abreu kernel:  snd_soc_sdca snd_soc_avs 
snd_soc_hda_codec hid_multitouch snd_hda_ext_core hid_generic 
snd_hda_codec snd_hda_core nls_ascii x86_pkg_temp_thermal nls_cp437 
snd_intel_dspcfg intel_powerclamp ath10k_pci vfat coretemp 
snd_intel_sdw_acpi fat ath10k_core kvm_intel snd_soc_core ath dell_pc 
snd_compress kvm snd_hwdep mac80211 mei_hdcp mei_wdt mei_pxp snd_pcm 
libarc4 snd_timer irqbypass iTCO_wdt ghash_clmulni_intel rapl 
intel_pmc_bxt snd iTCO_vendor_support intel_cstate dell_laptop cfg80211 
intel_xhci_usb_role_switch mei_me i2c_i801 intel_lpss_pci intel_rapl_msr 
dell_smm_hwmon intel_uncore intel_wmi_thunderbolt rtsx_pci soundcore 
wmi_bmof i2c_smbus rfkill ucsi_acpi mei typec_ucsi roles intel_lpss i915 
idma64 typec intel_pch_thermal intel_pmc_core 
processor_thermal_device_pci_legacy i2c_algo_bit intel_soc_dts_iosf 
pmt_telemetry drm_buddy processor_thermal_device 
processor_thermal_wt_hint platform_temperature_control 
processor_thermal_soc_slider platform_profile pmt_discovery i2c_hid_acpi 
intel_gtt
Okt 22 23:36:43.885432 abreu kernel:  processor_thermal_rfim i2c_hid 
processor_thermal_rapl pmt_class intel_rapl_common xhci_pci 
drm_display_helper hid xhci_hcd processor_thermal_wt_req 
intel_pmc_ssram_telemetry ttm intel_oc_wdt intel_vbtn soc_button_array 
watchdog drm_client_lib usbcore int3403_thermal intel_vsec 
processor_thermal_power_floor battery processor_thermal_mbox 
int3400_thermal int340x_thermal_zone drm_kms_helper acpi_thermal_rel 
acpi_pad usb_common ac button msr parport_pc ppdev lp parport drm 
efi_pstore configfs nfnetlink efivarfs autofs4 ext4 crc16 mbcache jbd2 
dm_crypt dm_mod dell_wmi dell_smbios dell_wmi_descriptor dcdbas evdev 
video pcspkr serio_raw nvme nvme_core intel_hid wmi sparse_keymap 
aesni_intel
Okt 22 23:36:43.885459 abreu kernel: ---[ end trace 0000000000000000 ]---
Okt 22 23:36:43.885472 abreu kernel: RIP: 
0010:kmem_cache_alloc_noprof+0x47c/0x620
Okt 22 23:36:43.885487 abreu kernel: Code: c2 e9 d1 fc ff ff 48 85 ff 0f 
84 8b fe ff ff 48 85 c9 0f 84 82 fe ff ff 41 b9 ff ff ff ff 41 8b 44 24 
30 49 8b 34 24 48 01 f8 <4c> 8b 00 48 89 c1 4d 33 84 24 c0 00 00 00 48 
89 f8 48 0f c9 49 31
Okt 22 23:36:43.885500 abreu kernel: RSP: 0018:ffffbb27c4ae7690 EFLAGS: 
00010006
Okt 22 23:36:43.885516 abreu kernel: RAX: 774f29fad633ebf3 RBX: 
000000000000001b RCX: ffffe9770463d580
Okt 22 23:36:43.885530 abreu kernel: RDX: 00000000003be001 RSI: 
ffffffffb0fbd950 RDI: 774f29fad633ebb3
Okt 22 23:36:43.885545 abreu kernel: RBP: ffffbb27c4ae76f0 R08: 
ffff908d9e4c03d0 R09: 00000000ffffffff
Okt 22 23:36:43.885559 abreu kernel: R10: 0000000000000080 R11: 
0000000080200020 R12: ffff908d8110d400
Okt 22 23:36:43.885573 abreu kernel: R13: 0000000000000820 R14: 
0000000000000080 R15: ffffffffc0c7aa22
Okt 22 23:36:43.885586 abreu kernel: FS:  00007f76633b0000(0000) 
GS:ffff90913bd09000(0000) knlGS:0000000000000000
Okt 22 23:36:43.885601 abreu kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Okt 22 23:36:43.885620 abreu kernel: CR2: 0000561f2e1b3940 CR3: 
0000000151f69001 CR4: 00000000003726f0
Okt 22 23:36:43.885636 abreu kernel: note: gnome-shell[1428] exited with 
irqs disabled
Okt 22 23:36:43.885653 abreu kernel: note: gnome-shell[1428] exited with 
preempt_count 1
```

