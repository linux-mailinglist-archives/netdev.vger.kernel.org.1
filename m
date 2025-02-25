Return-Path: <netdev+bounces-169317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0807BA436EF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D6F171DA6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37881FC0F4;
	Tue, 25 Feb 2025 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeM3flxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D941482E1
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470741; cv=none; b=ay9kZdj6MrL91eehs9mbgfKqRgVbZqzwB3MlC/euZ6oBn4eUo2sO61az+IuQtTsyg2c9AKNM4rsXdPk65DjwQzJ/4lL27TaAKR1mCJNfN4VQzzsSk/IiT9glx5Mj10bISxHnvYhG6l51NBA9dsMwpbbV9fCPU2wv25P9qjr5ues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470741; c=relaxed/simple;
	bh=rBsZDGIMljlxL3Os4JjRnxiQpmS0FpLZ1B5n3dcfWJA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=neOqq10cCra05cPLsEpNC/7Y5h6PBK0X3dui+f+MBeJ5m5md394iTTpZeNO9Q87Bv4H0AxW5VUlaDtPRGNQuFwhdJQwq6Urt6akuKKptmOVLlNr/SnCTzlUc6yt+e9BZzEJwPMG6sgq7gjuRMef7lhBwvjXgyFB3n7I/0vAwmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeM3flxf; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-520b9dc56afso1250537e0c.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 00:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740470738; x=1741075538; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qoU+Lm8cVAhYRyD2FhuJbdE3VkPEmKPLTUBoelS1pIg=;
        b=DeM3flxfS+P+ByzzRwUMSsu5ukzMkZC7fo9YjWJZft21iPiiwsK4C/ZNgbRkx4zb2P
         4p9OigcojrVl0dO6dXLs7EKRb8PAPIXf0kwNcntIMivf8xyNqWGgfA4PlZeszt4M+lDG
         DBkbhfCWxviGgRBfDnz0AolxxE4QY5/a0zMS3IIDVUwPZJ81X8lpECuzOL6jff9V1fQA
         SoqcEYAlCFikmCEkpaWVdHtmbxgkTOfw+29T5SgVS2PRvGB+S9A//w1G5WThZh2iTaV2
         NQbRhO/qiO5tiqNFXFHvGPnW2E1MGQK99PK6FyxmWFkfXRUcxWCoEGL56mm5lciC8ale
         bPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740470738; x=1741075538;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoU+Lm8cVAhYRyD2FhuJbdE3VkPEmKPLTUBoelS1pIg=;
        b=mtFGL7y8/TKud9FAFBpnlL7EHeX6jdQ0j2GVYyxMYYRXsmNjsrKfovG0jkIDTBItpm
         n8/u5ggc7kY9tYspb6usXuB7ezkuhxL0go20/e6+SD6bYdSX5V+t3cdYRc6wdhkHfFFD
         6OWZK5CRzCBUQ2hQ4j6jTUoCNHyKvhpNMcEHUbmlCeGqjpCFyGhHGfcY0OxunvzxqAp1
         D+vuuXo5T5cN2ri413LsUx5UdHrObSlpJAOebbi2rZEBTuMEkDDuTEb9av04laDodlhJ
         6QM5t5JoED0wRbFWmTF9A2cTrHvsBX2X758XVUs4KXdXgA50HsyfPB5NIlHM3jTzLbMs
         2RDQ==
X-Gm-Message-State: AOJu0Ywu/zttGH2r5o+cc0vivYZ03e3aAeWMcahpmIMtuZXRahqnZ5kf
	srdqqvCPLgSF5aB3GWxlQt0K+3U4ocfk4aFKPm8xxX+frX/MrgotBsFPpMQ6np2NtQGYfTWGA0A
	u1qNmnmiZ+3z51r2kBKg6tSZ6SGTWWh4Pndk=
X-Gm-Gg: ASbGnctHM9WJ8rJ1qVdh53F31/oCRxat4TeP8UIQTcF0cELCSGsT/MpKla1aPKW3e+2
	iye/MCLlmQKP3u9jedbLXwmpQ6x3zJBb0P/CXymuy7KRiJAfFD/0QACfUuNuV8vIIDNXZSSmE3h
	Mf+xBEZg==
X-Google-Smtp-Source: AGHT+IGuhPXlfEW1YtMStwmRoDro0xC8O52eOx46YYL829mBiTBnN0IlkiV9lkcOdqUpmYB5LFwNk7dPKTt+luSkwJQ=
X-Received: by 2002:a05:6122:6602:b0:520:42d3:91d2 with SMTP id
 71dfb90a1353d-5223cba712fmr804017e0c.1.1740470738008; Tue, 25 Feb 2025
 00:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Tue, 25 Feb 2025 09:05:26 +0100
X-Gm-Features: AQ5f1JpiKQzBZCgO3WzVwUZX8idDcxyg29dPkaJFMo9mdkAfBc4THOro6D07OiU
Message-ID: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
Subject: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Just had this happen just before be2net initialization... FYI and all that ;)

[    5.220133] ------------[ cut here ]------------
[    5.220137] Voluntary context switch within RCU read-side critical section!
[    5.220143] WARNING: CPU: 4 PID: 1045 at
kernel/rcu/tree_plugin.h:331 rcu_note_context_switch+0x65a/0x6d0
[    5.220150] Modules linked in: cfg80211 rfkill qrtr nft_masq
nft_nat nft_numgen nft_chain_nat nf_nat nft_ct nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nf_tables sunrpc vfat fat ocrdma ib_uverbs
ib_core xfs intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel snd_hda_codec_realtek
snd_hda_codec_generic iTCO_wdt dell_pc intel_pmc_bxt mei_wdt at24
iTCO_vendor_support snd_hda_codec_hdmi snd_hda_scodec_component kvm
platform_profile mei_hdcp mei_pxp snd_hda_intel snd_intel_dspcfg
dell_wmi dell_smm_hwmon snd_intel_sdw_acpi dell_smbios snd_hda_codec
rapl snd_hda_core intel_wmi_thunderbolt dcdbas intel_cstate
intel_uncore sparse_keymap wmi_bmof dell_wmi_descriptor i2c_i801
snd_hwdep i2c_smbus snd_pcm snd_timer mei_me be2net e1000e mei snd
lpc_ich soundcore sch_fq fuse loop dm_multipath nfnetlink zram
lz4hc_compress lz4_compress i915 crct10dif_pclmul crc32_pclmul
crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel
[    5.220232]  i2c_algo_bit drm_buddy sha512_ssse3 ttm sha256_ssse3
sha1_ssse3 drm_display_helper video cec wmi scsi_dh_rdac scsi_dh_emc
scsi_dh_alua pkcs8_key_parser
[    5.220250] Hardware name: Dell Inc. Precision T1700/04JGCK, BIOS
A28 05/30/2019
[    5.220253] RIP: rcu_note_context_switch+0x65a/0x6d0
[ 5.220256] Code: a8 00 00 00 00 0f 85 64 fd ff ff 49 89 8d a8 00 00
00 e9 58 fd ff ff 48 c7 c7 d0 ab e5 87 c6 05 b6 26 a2 02 01 e8 16 1c
f2 ff <0f> 0b e9 f1 f9 ff ff 49 83 bd a0 00 00 00 00 75 c2 e9 18 fd ff
ff
All code
========
   0: a8 00                test   $0x0,%al
   2: 00 00                add    %al,(%rax)
   4: 00 0f                add    %cl,(%rdi)
   6: 85 64 fd ff          test   %esp,-0x1(%rbp,%rdi,8)
   a: ff 49 89              decl   -0x77(%rcx)
   d: 8d a8 00 00 00 e9    lea    -0x17000000(%rax),%ebp
  13: 58                    pop    %rax
  14: fd                    std
  15: ff                    (bad)
  16: ff 48 c7              decl   -0x39(%rax)
  19: c7                    (bad)
  1a: d0 ab e5 87 c6 05    shrb   $1,0x5c687e5(%rbx)
  20: b6 26                mov    $0x26,%dh
  22: a2 02 01 e8 16 1c f2 movabs %al,0xffff21c16e80102
  29:* ff 0f <-- trapping instruction
  2b: 0b e9                or     %ecx,%ebp
  2d: f1                    int1
  2e: f9                    stc
  2f: ff                    (bad)
  30: ff 49 83              decl   -0x7d(%rcx)
  33: bd a0 00 00 00        mov    $0xa0,%ebp
  38: 00 75 c2              add    %dh,-0x3e(%rbp)
  3b: e9 18 fd ff ff        jmp    0xfffffffffffffd58

Code starting with the faulting instruction
===========================================
   0: 0f 0b                ud2
   2: e9 f1 f9 ff ff        jmp    0xfffffffffffff9f8
   7: 49 83 bd a0 00 00 00 cmpq   $0x0,0xa0(%r13)
   e: 00
   f: 75 c2                jne    0xffffffffffffffd3
  11: e9 18 fd ff ff        jmp    0xfffffffffffffd2e
[    5.220259] RSP: 0018:ffffb28d80ae73c0 EFLAGS: 00010086
[    5.220262] RAX: 0000000000000000 RBX: ffff8a2c1f3ad380 RCX: 0000000000000027
[    5.220264] RDX: ffff8a2f0ea21908 RSI: 0000000000000001 RDI: ffff8a2f0ea21900
[    5.220266] RBP: ffff8a2f0ea38040 R08: 0000000000000000 R09: 0000000000000000
[    5.220268] R10: 6374697773207478 R11: 0000000000000000 R12: 0000000000000000
[    5.220269] R13: ffff8a2c1f3ad380 R14: 0000000000000000 R15: ffff8a2c1a200af0
[    5.220271] FS:  00007ff780c64bc0(0000) GS:ffff8a2f0ea00000(0000)
knlGS:0000000000000000
[    5.220274] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.220276] CR2: 000055d7b4ddb208 CR3: 0000000110256001 CR4: 00000000001726f0
[    5.220278] Call Trace:
[    5.220280]  <TASK>
[    5.220282] ? rcu_note_context_switch+0x65a/0x6d0
[    5.220285] ? __warn.cold+0x93/0xfa
[    5.220288] ? rcu_note_context_switch+0x65a/0x6d0
[    5.220294] ? report_bug+0xff/0x140
[    5.220297] ? handle_bug+0x58/0x90
[    5.220300] ? exc_invalid_op+0x17/0x70
[    5.220303] ? asm_exc_invalid_op+0x1a/0x20
[    5.220308] ? rcu_note_context_switch+0x65a/0x6d0
[    5.220312] __schedule+0xcc/0x14b0
[    5.220316] ? get_nohz_timer_target+0x2d/0x180
[    5.220322] ? timerqueue_add+0x71/0xc0
[    5.220326] ? enqueue_hrtimer+0x42/0xa0
[    5.220331] schedule+0x27/0xf0
[    5.220334] schedule_hrtimeout_range_clock+0x100/0x1b0
[    5.220338] ? __pfx_hrtimer_wakeup+0x10/0x10
[    5.220342] usleep_range_state+0x65/0x90
WARNING! Cannot find .ko for module be2net, please pass a valid module path
[    5.220347] ? be_mcc_notify_wait+0x6c/0x150 be2net
WARNING! Cannot find .ko for module be2net, please pass a valid module path
[    5.220360] be_mcc_notify_wait+0xbe/0x150 be2net
WARNING! Cannot find .ko for module be2net, please pass a valid module path
[    5.220371] be_cmd_get_hsw_config+0x16c/0x190 be2net
WARNING! Cannot find .ko for module be2net, please pass a valid module path
[    5.220382] be_ndo_bridge_getlink+0xe0/0x100 be2net
[    5.220393] rtnl_bridge_getlink+0x12b/0x1b0
[    5.220398] ? __pfx_rtnl_bridge_getlink+0x10/0x10
[    5.220401] rtnl_dumpit+0x80/0xa0
[    5.220404] netlink_dump+0x13b/0x360
[    5.220409] __netlink_dump_start+0x1eb/0x310
[    5.220412] ? __pfx_rtnl_bridge_getlink+0x10/0x10
[    5.220415] rtnetlink_rcv_msg+0x2da/0x460
[    5.220418] ? __pfx_rtnl_dumpit+0x10/0x10
[    5.220421] ? __pfx_rtnl_bridge_getlink+0x10/0x10
[    5.220424] ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    5.220427] netlink_rcv_skb+0x53/0x100
[    5.220432] netlink_unicast+0x245/0x390
[    5.220435] netlink_sendmsg+0x21b/0x470
[    5.220438] __sys_sendto+0x1df/0x1f0
[    5.220444] __x64_sys_sendto+0x24/0x30
[    5.220446] do_syscall_64+0x82/0x160
[    5.220449] ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    5.220452] ? netlink_rcv_skb+0x82/0x100
[    5.220455] ? netlink_unicast+0x24d/0x390
[    5.220457] ? kmem_cache_free+0x3ee/0x440
[    5.220461] ? skb_release_data+0x193/0x200
[    5.220465] ? netlink_unicast+0x24d/0x390
[    5.220468] ? netlink_sendmsg+0x228/0x470
[    5.220471] ? __sys_sendto+0x1df/0x1f0
[    5.220475] ? syscall_exit_to_user_mode+0x10/0x210
[    5.220478] ? do_syscall_64+0x8e/0x160
[    5.220480] ? iterate_dir+0x182/0x200
[    5.220483] ? __x64_sys_getdents64+0xfa/0x130
[    5.220486] ? __pfx_filldir64+0x10/0x10
[    5.220489] ? syscall_exit_to_user_mode+0x10/0x210
[    5.220491] ? do_syscall_64+0x8e/0x160
[    5.220493] ? syscall_exit_to_user_mode+0x10/0x210
[    5.220496] ? do_syscall_64+0x8e/0x160
[    5.220498] ? exc_page_fault+0x7e/0x180
[    5.220500] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.220504] RIP: 0033:0x7ff7807045b7
[ 5.220516] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00
00 90 f3 0f 1e fa 80 3d 15 9b 0f 00 00 41 89 ca 74 10 b8 2c 00 00 00
0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d
d0
All code
========
   0: c7 c0 ff ff ff ff    mov    $0xffffffff,%eax
   6: eb be                jmp    0xffffffffffffffc6
   8: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
   f: 00 00 00
  12: 90                    nop
  13: f3 0f 1e fa          endbr64
  17: 80 3d 15 9b 0f 00 00 cmpb   $0x0,0xf9b15(%rip)        # 0xf9b33
  1e: 41 89 ca              mov    %ecx,%r10d
  21: 74 10                je     0x33
  23: b8 2c 00 00 00        mov    $0x2c,%eax
  28: 0f 05                syscall
  2a:* 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax <--
trapping instruction
  30: 77 69                ja     0x9b
  32: c3                    ret
  33: 55                    push   %rbp
  34: 48 89 e5              mov    %rsp,%rbp
  37: 53                    push   %rbx
  38: 48 83 ec 38          sub    $0x38,%rsp
  3c: 44 89 4d d0          mov    %r9d,-0x30(%rbp)

Code starting with the faulting instruction
===========================================
   0: 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax
   6: 77 69                ja     0x71
   8: c3                    ret
   9: 55                    push   %rbp
   a: 48 89 e5              mov    %rsp,%rbp
   d: 53                    push   %rbx
   e: 48 83 ec 38          sub    $0x38,%rsp
  12: 44 89 4d d0          mov    %r9d,-0x30(%rbp)
[    5.220518] RSP: 002b:00007ffc921b4ff8 EFLAGS: 00000202 ORIG_RAX:
000000000000002c
[    5.220522] RAX: ffffffffffffffda RBX: 000055d7b4dacc80 RCX: 00007ff7807045b7
[    5.220524] RDX: 0000000000000020 RSI: 000055d7b4db7ff0 RDI: 0000000000000003
[    5.220525] RBP: 00007ffc921b5090 R08: 00007ffc921b5000 R09: 0000000000000080
[    5.220527] R10: 0000000000000000 R11: 0000000000000202 R12: 000055d7b4ddb350
[    5.220529] R13: 00007ffc921b50d4 R14: 000055d7b4ddb350 R15: 000055d77d5f8a90
[    5.220532]  </TASK>
[    5.220533] ---[ end trace 0000000000000000 ]---

