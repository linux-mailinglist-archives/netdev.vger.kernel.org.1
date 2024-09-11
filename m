Return-Path: <netdev+bounces-127439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03821975683
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B18B214AC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5A1A2633;
	Wed, 11 Sep 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzEdAAqM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC7185954;
	Wed, 11 Sep 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067494; cv=none; b=LGg0vWzOJrGiyOzYB/tieVvTfxJXHQ9KwDnMbWigDjyE+X+6eODGKiwO87HI4dTANIvUfdziy3RvgB0TQbnBLHp2ytAjRf9D6Pinou5eH0nnvFJ3yzebt61mC+Ig46T2w2tE1mcGU2vGqr8ReV0mhOTyiQcXfDAQowYJEdb9v6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067494; c=relaxed/simple;
	bh=+SHK5QfuSNDmXzwG5RO6pTl1QpkP+wYb1qEaTwwJR38=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p5w+euBFNWpUdIfANVQrIm3i6yFL7HNGUHJaBC8E8hud+V/UMrKJk2b+HNZaW7WhRStSrNkM/F7C1ySvNZaLFTvoQ9jLwC21U/R/ZkMaxj8Lz2Hz/E8LD9milaHbqER2CPn9v1xS0HOzZvYsghv1LqVMNPa+ywKlDBLysF4B9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzEdAAqM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso2335733a12.1;
        Wed, 11 Sep 2024 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726067490; x=1726672290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5jaqn5c8jvDuB2JX68N4gnboeMP7OhW5ai87XBiwm7M=;
        b=LzEdAAqM48vxleSiywit9CttZzycBlnJiGRi6uAu7zmgB4s/ewd8Mov48xlbNk0LxU
         7Y+C0Kk9aijOGwZEeJ12OE4HgySUvQPsUzw8TPQ+ApGbFyZ+Bx9+C3liMMpGSBH3a3Km
         ZScCkkR5mXHWtm+qt5S/GQM+tUHL9cLKfVa8VwUpDkaRiLUXeNDD2lBIPAhNRoHgVtDg
         99MsBN8iKCdRdmm9tMHFF9NZQNImXOG1mQ1rcRBlR4Z3qoDpVv0m+sCjA8TYfFH0+8MS
         dBrKah4o8ZUyzVOd0+aQdErCFxRde7JZJmjP3sYQ5FeQLvhcxF94oCpWQa5dMON95fsh
         RhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067490; x=1726672290;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jaqn5c8jvDuB2JX68N4gnboeMP7OhW5ai87XBiwm7M=;
        b=eJFCMnaAWMprM9JMRsqatmJW32HQf7e+DSHRIKSHSvgO/KbZBZwEOE2V8CS639wHaP
         cLe9tfgsZ0ahrRki112t1q5KEDHfl0pO9DoHRX1WOPRK0lQuUFpuyBg8/DR1qt8IyXli
         3KywEoqiOQkYszbQS8kIv7nCJ6+IPODry+7tsmTkRU5L7sjlQKkPzj23wUS3GkgdpaoK
         3c6UgxaREghBzn5JkELkBtj7HfosR3HVaj6LTKg65Aq76BEhWZjIe7OshZLW2P9/8jN0
         /Q5g58OC05asvmhOALqSAWoffFOdPc7Mq4w7mOc7jifzSUdT+fZSA/ZhngO4vZghs8xI
         e1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVmEb0TlzvZNYZE7WMQCXBcgoazP53UfZvwqrQljti3BgX/AwrxRZAJimVRUJZz4SuQh+0+NuLVkw0ZXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsfBJsDnoPS91vGy2FZkOKhd3AwlqL7TmnNLwno9SRbLdvqLl
	ESLqcezchmY2AwnnAnSBTK2a/FniBOALyanpzUxRbYNOae6KNskb+wNR1UGUEcflQAjm9hi7o97
	w3smgZZIE64RTDDC6PED8+xbCCQWel+zb
X-Google-Smtp-Source: AGHT+IFkcaD8yDzoRXyrQwiAtSSuCH2SbWg1Qy3KS/ev9O89w61+b2OUV8LhViN9EN7GRfCy8Uyba/GC/x8FmRmY2zs=
X-Received: by 2002:a05:6402:1d51:b0:5c4:b23:fe6f with SMTP id
 4fb4d7f45d1cf-5c40bc24f4cmr2497512a12.11.1726067489066; Wed, 11 Sep 2024
 08:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Wed, 11 Sep 2024 17:10:41 +0200
Message-ID: <CAHaCkmfFt1oP=r28DDYNWm3Xx5CEkzeu7NEstXPUV+BmG3F1_A@mail.gmail.com>
Subject: igc: Network failure, reboot required: igc: Failed to read reg 0xc030!
To: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there

Over the past couple of months I've occasionally observed my machine
loosing its ethernet connection.

It usually only happens after I've been using the machine for a couple
of hours and it only happens around 3-4 times per month.
Every time (previously) I've just rebooted the machine and then things
were fine when it came back up, but the last time it happened I took a
look at 'dmesg' to see if there was a clue and I found this:

[   11.474412] igc 0000:0c:00.0 eno1: NIC Link is Up 2500 Mbps Full
Duplex, Flow Control: RX/TX
[   11.475554] igc 0000:0c:00.0 eno1: Force mode currently not supported
[   14.363040] usbcore: registered new interface driver snd-usb-audio
[   15.934429] igc 0000:0c:00.0 eno1: NIC Link is Up 2500 Mbps Full
Duplex, Flow Control: RX/TX
[   37.250435] systemd-journald[569]: Time jumped backwards, rotating.
[   38.593498] warning: `kdeconnectd' uses wireless extensions which
will stop working for Wi-Fi 7 hardware; use nl80211
[  352.786791] usb 3-2: new high-speed USB device number 7 using xhci_hcd
[15656.628279] igc 0000:0c:00.0 eno1: PCIe link lost, device now detached
[15656.628287] ------------[ cut here ]------------
[15656.628287] igc: Failed to read reg 0xc030!
[15656.628306] WARNING: CPU: 2 PID: 2383 at
drivers/net/ethernet/intel/igc/igc_main.c:6752 igc_rd32+0x88/0xa0
[igc]
[15656.628313] Modules linked in: snd_usb_audio snd_usbmidi_lib
snd_ump snd_rawmidi snd_seq_device mc vfat fat amd_atl intel_rapl_msr
intel_rapl_common kvm_amd iwlmvm eeepc_wmi asus_nb_wmi
kvm asus_wmi crct10dif_pclmul platform_profile mac80211
snd_hda_codec_hdmi crc32_pclmul snd_hda_intel polyval_clmulni libarc4
polyval_generic snd_intel_dspcfg gf128mul snd_intel_sdw_acpi bt
usb ghash_clmulni_intel snd_hda_codec btrtl iwlwifi sha512_ssse3
btintel sha256_ssse3 snd_hda_core sha1_ssse3 btbcm aesni_intel
snd_hwdep btmtk crypto_simd i8042 snd_pcm cryptd cfg80211 spa
rse_keymap bluetooth sp5100_tco snd_timer serio wmi_bmof rapl pcspkr
k10temp ccp igc i2c_piix4 snd ptp soundcore rfkill joydev pps_core
mousedev gpio_amdpt gpio_generic mac_hid i2c_dev cryp
to_user loop dm_mod nfnetlink ip_tables x_tables ext4 crc32c_generic
crc16 mbcache jbd2 hid_generic usbhid amdgpu amdxcp i2c_algo_bit
drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_help
er nvme drm_buddy drm_display_helper crc32c_intel nvme_core xhci_pci
xhci_pci_renesas cec
[15656.628364]  video nvme_auth wmi
[15656.628368] CPU: 2 PID: 2383 Comm: btop Not tainted 6.10.8-arch1-1
#1 a95ab4cbeff058332c57c6b7bbc94a2b00a74ca7
[15656.628370] Hardware name: ASUS System Product Name/ROG STRIX
X670E-E GAMING WIFI, BIOS 2007 04/12/2024
[15656.628371] RIP: 0010:igc_rd32+0x88/0xa0 [igc]
[15656.628374] Code: 48 c7 c6 30 f9 7e c1 e8 56 3a 27 d3 48 8b bd 28
ff ff ff e8 ba 26 ba d2 84 c0 74 c5 89 de 48 c7 c7 58 f9 7e c1 e8 48
c5 4e d2 <0f> 0b eb b3 83 c8 ff e9 47 74 53 d3 66 6
6 2e 0f 1f 84 00 00 00 00
[15656.628375] RSP: 0018:ffffb74248adf338 EFLAGS: 00010286
[15656.628377] RAX: 0000000000000000 RBX: 000000000000c030 RCX: 0000000000000027
[15656.628378] RDX: ffff97821d9219c8 RSI: 0000000000000001 RDI: ffff97821d9219c0
[15656.628379] RBP: ffff9773078cece8 R08: 0000000000000000 R09: ffffb74248adf1b8
[15656.628379] R10: ffff97821d7fffa8 R11: 0000000000000003 R12: 0000000000000000
[15656.628380] R13: 0000000000000000 R14: ffff97731260abc0 R15: 000000000000c030
[15656.628381] FS:  00007113194006c0(0000) GS:ffff97821d900000(0000)
knlGS:0000000000000000
[15656.628382] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15656.628383] CR2: 00007e621ecb2000 CR3: 00000001153b6000 CR4: 0000000000f50ef0
[15656.628384] PKRU: 55555554
[15656.628385] Call Trace:
[15656.628387]  <TASK>
[15656.628388]  ? igc_rd32+0x88/0xa0 [igc
22e0a697bfd5a86bd5c20d279bfffd131de6bb32]
[15656.628391]  ? __warn.cold+0x8e/0xe8
[15656.628393]  ? igc_rd32+0x88/0xa0 [igc
22e0a697bfd5a86bd5c20d279bfffd131de6bb32]
[15656.628398]  ? report_bug+0xff/0x140
[15656.628400]  ? console_unlock+0x84/0x130
[15656.628402]  ? handle_bug+0x3c/0x80
[15656.628404]  ? exc_invalid_op+0x17/0x70
[15656.628405]  ? asm_exc_invalid_op+0x1a/0x20
[15656.628408]  ? igc_rd32+0x88/0xa0 [igc
22e0a697bfd5a86bd5c20d279bfffd131de6bb32]
[15656.628411]  ? igc_rd32+0x88/0xa0 [igc
22e0a697bfd5a86bd5c20d279bfffd131de6bb32]
[15656.628414]  igc_update_stats+0x8a/0x6d0 [igc
22e0a697bfd5a86bd5c20d279bfffd131de6bb32]
[15656.628417]  igc_get_stats64+0x85/0x90 [igc
22e0a697bfd5a86bd5c20d279bfffd131de6bb32]
[15656.628420]  dev_get_stats+0x5d/0x130
[15656.628422]  rtnl_fill_stats+0x3b/0x130
[15656.628425]  rtnl_fill_ifinfo.isra.0+0x779/0x1520
[15656.628426]  ? nla_reserve_64bit+0x30/0x40
[15656.628430]  rtnl_dump_ifinfo+0x4af/0x650
[15656.628438]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628439]  ? kmalloc_reserve+0x62/0xf0
[15656.628442]  rtnl_dumpit+0x1c/0x60
[15656.628444]  netlink_dump+0x347/0x3b0
[15656.628449]  __netlink_dump_start+0x1eb/0x310
[15656.628451]  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
[15656.628452]  rtnetlink_rcv_msg+0x2aa/0x3f0
[15656.628454]  ? __pfx_rtnl_dumpit+0x10/0x10
[15656.628456]  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
[15656.628457]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[15656.628459]  netlink_rcv_skb+0x50/0x100
[15656.628463]  netlink_unicast+0x240/0x370
[15656.628465]  netlink_sendmsg+0x21b/0x470
[15656.628468]  __sys_sendto+0x201/0x210
[15656.628473]  __x64_sys_sendto+0x24/0x30
[15656.628474]  do_syscall_64+0x82/0x190
[15656.628476]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628477]  ? syscall_exit_to_user_mode+0x72/0x200
[15656.628479]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628480]  ? do_syscall_64+0x8e/0x190
[15656.628482]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628483]  ? seq_read_iter+0x208/0x460
[15656.628485]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628486]  ? update_curr+0x26/0x1f0
[15656.628488]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628489]  ? reweight_entity+0x1c4/0x260
[15656.628490]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628492]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628493]  ? task_tick_fair+0x40/0x420
[15656.628494]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628495]  ? sched_use_asym_prio+0x66/0x90
[15656.628496]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628497]  ? sched_balance_trigger+0x14c/0x340
[15656.628499]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628500]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628501]  ? rcu_accelerate_cbs+0x7a/0x80
[15656.628503]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628504]  ? __note_gp_changes+0x18b/0x1a0
[15656.628506]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628507]  ? note_gp_changes+0x6c/0x80
[15656.628508]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628509]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628510]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628511]  ? __rseq_handle_notify_resume+0xa6/0x490
[15656.628514]  ? srso_alias_return_thunk+0x5/0xfbef5
[15656.628515]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[15656.628517] RIP: 0033:0x71131b12a8e4
[15656.628531] Code: 7d e8 89 4d d4 e8 fc 49 f7 ff 44 8b 4d d0 4c 8b
45 c8 89 c3 44 8b 55 d4 8b 7d e8 b8 2c 00 00 00 48 8b 55 d8 48 8b 75
e0 0f 05 <48> 3d 00 f0 ff ff 77 34 89 df 48 89 45 e
8 e8 49 4a f7 ff 48 8b 45
[15656.628532] RSP: 002b:00007113193ff0b0 EFLAGS: 00000293 ORIG_RAX:
000000000000002c
[15656.628533] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000071131b12a8e4
[15656.628534] RDX: 0000000000000014 RSI: 00007113193ff180 RDI: 0000000000000003
[15656.628535] RBP: 00007113193ff0f0 R08: 00007113193ff140 R09: 000000000000000c
[15656.628536] R10: 0000000000000000 R11: 0000000000000293 R12: 00007113193ff270
[15656.628536] R13: 00007113193ff180 R14: 00007113193ffca8 R15: 00007113193ff780
[15656.628539]  </TASK>
[15656.628540] ---[ end trace 0000000000000000 ]---

I tried reloading the 'igc' module, but that didn't resolve the issue
- then I rebooted as usual and everything was fine again.

My NIC is (from `lspci -vvv`):
0c:00.0 Ethernet controller: Intel Corporation Ethernet Controller
I225-V (rev 03)
       DeviceName: Intel 2.5G LAN
       Subsystem: ASUSTeK Computer Inc. Device 87d2
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Latency: 0, Cache Line Size: 64 bytes
       Interrupt: pin A routed to IRQ 36
       IOMMU group: 19
       Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=1M]
       Region 3: Memory at 80200000 (32-bit, non-prefetchable) [size=16K]
       Capabilities: [40] Power Management version 3
               Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
               Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
       Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
               Address: 0000000000000000  Data: 0000
               Masking: 00000000  Pending: 00000000
       Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
               Vector table: BAR=3 offset=00000000
               PBA: BAR=3 offset=00002000
       Capabilities: [a0] Express (v2) Endpoint, IntMsgNum 0
               DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 0W TEE-IO-
               DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                       RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                       MaxPayload 128 bytes, MaxReadReq 512 bytes
               DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
               LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L1, Exit
Latency L1 <4us
                       ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
               LnkSta: Speed 5GT/s, Width x1
                       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
               DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR+
                        10BitTagComp- 10BitTagReq- OBFF Not Supported,
ExtFmt- EETLPPrefix-
                        EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                        FRS- TPHComp- ExtTPHComp-
                        AtomicOpsCap: 32bit- 64bit- 128bitCAS-
               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                        AtomicOpsCtl: ReqEn-
                        IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                        10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
               LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                        Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                        Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
               LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete- EqualizationPhase1-
                        EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                        Retimer- 2Retimers- CrosslinkRes: unsupported
       Capabilities: [100 v2] Advanced Error Reporting
               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                       ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                       ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
                       ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
               AERCap: First Error Pointer: 14, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
                       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
               HeaderLog: 40001001 0000000f 8020000c 8020000c
       Capabilities: [140 v1] Device Serial Number a0-36-bc-ff-ff-ac-b3-b6
       Capabilities: [1c0 v1] Latency Tolerance Reporting
               Max snoop latency: 0ns
               Max no snoop latency: 0ns
       Capabilities: [1f0 v1] Precision Time Measurement
               PTMCap: Requester+ Responder- Root-
               PTMClockGranularity: 4ns
               PTMControl: Enabled- RootSelected-
               PTMEffectiveGranularity: Unknown
       Capabilities: [1e0 v1] L1 PM Substates
               L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2-
ASPM_L1.1+ L1_PM_Substates+
               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
               L1SubCtl2:
       Kernel driver in use: igc

My distribution is Arch Linux.

My motherboard is a ASUS X670E-E running a AMD 7950X CPU and using 64G
of RAM at EXPO 6000 speed.

My kernel is: 6.10.9-arch1-1 #1 SMP PREEMPT_DYNAMIC Mon, 09 Sep 2024
02:38:45 +0000 x86_64 GNU/Linux

I'm connected to a 2.5GiB/sec switch that doesn't seem to have any
problems serving other machines when this happens.

I can provide further hardware details upon request, just let me know
what info you need.
I'm perfectly willing to try custom kernels and/or patches, just let
me know what you need me to try/build/test.

Kind regards,
 Jesper Juhl

