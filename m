Return-Path: <netdev+bounces-169394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1FA43B1F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E87188FA2E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379AC264A96;
	Tue, 25 Feb 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpLrEaeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB11624F8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478442; cv=none; b=L+jI9bW7bdGyOEDHhQXFrEQQotgyVLHz28BxkGe4fUQIoDrLQ+QgHNU3nTExtx3d3FH7DevTteKwhLiugdyZsrSxwPszbuIJ9eaMta1xwcOYOCvF7tzRXmFZK7QK55ppzHQFT1EW+BRGSMSWWN8jfKcT3aKoapqxiVg2r35Vy44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478442; c=relaxed/simple;
	bh=XejokhyDfBwGGlW1mHrZ/3sUkS8epuPszsSK8xy/jWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dKL1JzoU+gYofiTkz5uN6ESpWkX1Ga0f9EzN6QlfahMICGn6XsIP4ppluHUmeWgR603zCRoKMX13P6NbeL3dSpSt6w5l+D0jyjbfI3thWPe9eAOFlAEto74w/3M7AqR7P9bkhZEuEHOBQ9SG11nUo7rvVEX3DTYddvMGakx7n0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpLrEaeZ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86929964ed3so3222387241.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740478439; x=1741083239; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPisM70kXxEOdGAyLuwo0RPU1HQyXqneGUn41b+tCQM=;
        b=TpLrEaeZc24ZoC8OsQDWfpxIbwixHEQZplpKpWM529GU9Tp0xG9S5lJQdeoR0lz3gk
         DLGgOCTZs19d1GGLNLvscEoNNMZ+aioY0oTbHYP069eWmYMNKDmNp0WFtUgZeHlrBQhu
         Ea5n39SL1a+zKOG+/u+MDizZLhLv3GjeJnqKKQWAkDOh/30GC0VWRprnEocdLgQ/9iwl
         sYCuapkvokrrx7p7pZYxVVApQfdQDMsuIm+V4Ev/TZx8P/anB0Qt7nLryvrebefWiDYM
         tf2UZYSn0tp/1EvyMNHCmDIah+Zcrnht1L2TKefwsTgQ+PoUmplGOo27kitWq8lU9xTD
         YRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478439; x=1741083239;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPisM70kXxEOdGAyLuwo0RPU1HQyXqneGUn41b+tCQM=;
        b=FWSR/2j8h8vPyXNqs8kBSF8oLzHHxCribBAiN0BvXZk2D2GGAf2ULO7+UnnMZMvYhM
         Hw+iTZcb1HfyXiSPQuwvhppUiz5jKdHO6JYdGzOguZLW8Y6xBHIXa5EDnoVMWVKCNeMi
         e4kXIdrmrqPvFfcv3diorlBdKpLVtGKnqrXFzE2cOtty7NN6qK0+2pqyHND4PLuTADXN
         I06lw9E764EPhg0efEx9OCCJnJKhcqYC4tmxHSNAwoalVfHsIIwUEZgrxrwsTLcrplCS
         nM6MLStUQ0X/AONsIDvPsuBuQ1Sh433YDJR8y0z7y5tXlHCB1erZ3LPQp3g7MGUvKEPW
         CILw==
X-Gm-Message-State: AOJu0Yxo/Ccn4PmC9I47NzSeZ72rZWQpUPPRtdBjKHBQlaSUnAzOoviw
	mvCVyARHBesoBQCMZGbWzwPQsFf0Ierpsy6dYfmjz39KFNeL27aHdtRaqj7Zh5BfNGRlnhMIk0X
	AP+MOVu+8nCtEMUDBFJ6o7KzWWB1RdG963+o=
X-Gm-Gg: ASbGncu6TrntPkqZSd4HT2/9KLmC5YTXshFId5sPdi1oVUddsTyS2YzkE+dAMw6SM1U
	uL1irdR0MRGolcC53dG/v2m2xqEMmZvcvDlij8Cy9km2j5v6rJh3+wsWMD3PTH5+Q6uQVoGz7oU
	QXQxT8mg==
X-Google-Smtp-Source: AGHT+IGZICScFflBw9eihb+efTeqMi97oQZFFDuLf5qRA1jjr49qFG3+vgG5527nBv1X56WVguVQMNsbKcgXLpiMZBw=
X-Received: by 2002:a05:6102:8024:b0:4bb:eb4a:f9f0 with SMTP id
 ada2fe7eead31-4bfc028ddf2mr10292794137.24.1740478438724; Tue, 25 Feb 2025
 02:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
In-Reply-To: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Tue, 25 Feb 2025 11:13:47 +0100
X-Gm-Features: AQ5f1JpzX6uItOhhVrCJtMsmksgM9LIOdPpw2QppSBxT2RBL0BEBejl7IHNQ9gs
Message-ID: <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Same thing happens in 6.13.4, FYI

[    5.253286] ------------[ cut here ]------------
[    5.253291] Voluntary context switch within RCU read-side critical secti=
on!
[    5.253296] WARNING: CPU: 7 PID: 1052 at
kernel/rcu/tree_plugin.h:331 rcu_note_context_switch+0x66f/0x6d0
[    5.253304] Modules linked in: cfg80211 rfkill qrtr nft_masq
nft_nat sunrpc nft_numgen nft_chain_nat nf_nat nft_ct nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nf_tables vfat fat ocrdma ib_uverbs ib_core
xfs snd_hda_codec_realtek snd_hda_codec_generic intel_rapl_msr
snd_hda_scodec_component snd_hda_codec_hdmi intel_rapl_common
x86_pkg_temp_thermal snd_hda_intel intel_powerclamp coretemp
snd_intel_dspcfg mei_pxp snd_intel_sdw_acpi dell_pc iTCO_wdt
platform_profile snd_hda_codec mei_wdt at24 kvm_intel mei_hdcp
intel_pmc_bxt iTCO_vendor_support dell_smm_hwmon snd_hda_core dell_wmi
kvm snd_hwdep dell_smbios snd_pcm rapl dcdbas sparse_keymap
intel_cstate dell_wmi_descriptor intel_uncore intel_wmi_thunderbolt
wmi_bmof i2c_i801 i2c_smbus snd_timer mei_me snd e1000e lpc_ich mei
be2net soundcore sch_fq fuse loop dm_multipath nfnetlink zram
lz4hc_compress lz4_compress i915 crct10dif_pclmul i2c_algo_bit
crc32_pclmul drm_buddy crc32c_intel polyval_clmulni ttm
polyval_generic
[    5.253388]  ghash_clmulni_intel drm_display_helper sha512_ssse3
sha256_ssse3 sha1_ssse3 cec video wmi scsi_dh_rdac scsi_dh_emc
scsi_dh_alua pkcs8_key_parser
[    5.253405] Hardware name: Dell Inc. Precision T1700/04JGCK, BIOS
A28 05/30/2019
[    5.253407] RIP: rcu_note_context_switch+0x66f/0x6d0
[ 5.253411] Code: a8 00 00 00 00 0f 85 3c fd ff ff 49 89 8d a8 00 00
00 e9 30 fd ff ff 48 c7 c7 30 6f de b7 c6 05 7b 51 96 02 01 e8 61 0e
f2 ff <0f> 0b e9 dc f9 ff ff c6 45 11 00 48 8b 75 20 ba 01 00 00 00 48
8b
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: a8 00                test   $0x0,%al
   2: 00 00                add    %al,(%rax)
   4: 00 0f                add    %cl,(%rdi)
   6: 85 3c fd ff ff 49 89 test   %edi,-0x76b60001(,%rdi,8)
   d: 8d a8 00 00 00 e9    lea    -0x17000000(%rax),%ebp
  13: 30 fd                xor    %bh,%ch
  15: ff                    (bad)
  16: ff 48 c7              decl   -0x39(%rax)
  19: c7                    (bad)
  1a: 30 6f de              xor    %ch,-0x22(%rdi)
  1d: b7 c6                mov    $0xc6,%bh
  1f: 05 7b 51 96 02        add    $0x296517b,%eax
  24: 01 e8                add    %ebp,%eax
  26: 61                    (bad)
  27: 0e                    (bad)
  28:* f2 ff 0f              repnz decl (%rdi) <-- trapping instruction
  2b: 0b e9                or     %ecx,%ebp
  2d: dc f9                fdivr  %st,%st(1)
  2f: ff                    (bad)
  30: ff c6                inc    %esi
  32: 45 11 00              adc    %r8d,(%r8)
  35: 48 8b 75 20          mov    0x20(%rbp),%rsi
  39: ba 01 00 00 00        mov    $0x1,%edx
  3e: 48                    rex.W
  3f: 8b                    .byte 0x8b

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: e9 dc f9 ff ff        jmp    0xfffffffffffff9e3
   7: c6 45 11 00          movb   $0x0,0x11(%rbp)
   b: 48 8b 75 20          mov    0x20(%rbp),%rsi
   f: ba 01 00 00 00        mov    $0x1,%edx
  14: 48                    rex.W
  15: 8b                    .byte 0x8b
[    5.253413] RSP: 0018:ffffadb040f4b688 EFLAGS: 00010082
[    5.253416] RAX: 0000000000000000 RBX: ffff957a4d705380 RCX: 00000000000=
00027
[    5.253418] RDX: ffff957d4eba1908 RSI: 0000000000000001 RDI: ffff957d4eb=
a1900
[    5.253420] RBP: ffff957d4ebb7d40 R08: 0000000000000000 R09: 00000000000=
00000
[    5.253422] R10: 206c616369746972 R11: 0000000000000000 R12: 00000000000=
00000
[    5.253423] R13: ffff957a4d705380 R14: 000000000007a100 R15: ffff957a474=
00b30
[    5.253425] FS:  00007f6cc2c0dbc0(0000) GS:ffff957d4eb80000(0000)
knlGS:0000000000000000
[    5.253428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.253430] CR2: 0000556e7a98b188 CR3: 00000001210ce006 CR4: 00000000001=
726f0
[    5.253432] Call Trace:
[    5.253434]  <TASK>
[    5.253435] ? rcu_note_context_switch+0x66f/0x6d0
[    5.253439] ? __warn.cold+0x93/0xfa
[    5.253443] ? rcu_note_context_switch+0x66f/0x6d0
[    5.253447] ? report_bug+0xff/0x140
[    5.253451] ? console_unlock+0x9d/0x140
[    5.253455] ? handle_bug+0x58/0x90
[    5.253458] ? exc_invalid_op+0x17/0x70
[    5.253461] ? asm_exc_invalid_op+0x1a/0x20
[    5.253466] ? rcu_note_context_switch+0x66f/0x6d0
[    5.253469] ? rcu_note_context_switch+0x66f/0x6d0
[    5.253472] ? valid_bridge_getlink_req.constprop.0+0xac/0x1c0
[    5.253478] __schedule+0xcc/0x14b0
[    5.253482] ? get_nohz_timer_target+0x2d/0x180
[    5.253486] ? timerqueue_add+0x71/0xc0
[    5.253489] ? enqueue_hrtimer+0x42/0xa0
[    5.253492] schedule+0x27/0xf0
[    5.253495] usleep_range_state+0xea/0x120
[    5.253499] ? __pfx_hrtimer_wakeup+0x10/0x10
WARNING! Cannot find .ko for module be2net, please pass a valid module path
[    5.253503] ? be_mcc_notify_wait+0x6c/0x150 be2net
WARNING! Cannot find .ko for module be2net, please pass a valid module path
[    5.253516] be_mcc_notify_wait+0xbe/0x150 be2net
WARNING! Cannot find .ko for module be2net, please pass a valid module path
[    5.253526] be_cmd_get_hsw_config+0x16c/0x190 be2net
WARNING! Cannot find .ko for module be2net, please pass a valid module path
[    5.253537] be_ndo_bridge_getlink+0xe0/0x100 be2net
[    5.253547] rtnl_bridge_getlink+0x12b/0x1b0
[    5.253551] ? __pfx_rtnl_bridge_getlink+0x10/0x10
[    5.253555] rtnl_dumpit+0x80/0xa0
[    5.253558] netlink_dump+0x19c/0x410
[    5.253561] ? skb_release_data+0x193/0x200
[    5.253566] __netlink_dump_start+0x1eb/0x310
[    5.253569] ? __pfx_rtnl_bridge_getlink+0x10/0x10
[    5.253573] rtnetlink_rcv_msg+0x2da/0x460
[    5.253576] ? __pfx_rtnl_dumpit+0x10/0x10
[    5.253579] ? __pfx_rtnl_bridge_getlink+0x10/0x10
[    5.253582] ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    5.253586] netlink_rcv_skb+0x53/0x100
[    5.253590] netlink_unicast+0x245/0x390
[    5.253593] netlink_sendmsg+0x21b/0x470
[    5.253597] __sys_sendto+0x1ef/0x200
[    5.253602] __x64_sys_sendto+0x24/0x30
[    5.253605] do_syscall_64+0x82/0x160
[    5.253609] ? syscall_exit_to_user_mode+0x10/0x210
[    5.253613] ? do_syscall_64+0x8e/0x160
[    5.253616] ? atime_needs_update+0xa0/0x120
[    5.253621] ? touch_atime+0x1e/0x120
[    5.253624] ? iterate_dir+0x182/0x200
[    5.253627] ? __x64_sys_getdents64+0xa7/0x120
[    5.253629] ? __pfx_filldir64+0x10/0x10
[    5.253632] ? syscall_exit_to_user_mode+0x10/0x210
[    5.253635] ? do_syscall_64+0x8e/0x160
[    5.253638] ? do_syscall_64+0x8e/0x160
[    5.253642] ? do_syscall_64+0x8e/0x160
[    5.253645] ? do_syscall_64+0x8e/0x160
[    5.253648] ? do_syscall_64+0x8e/0x160
[    5.253651] ? exc_page_fault+0x7e/0x180
[    5.253654] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.253658] RIP: 0033:0x7f6cc34d55b7
[ 5.253669] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00
00 90 f3 0f 1e fa 80 3d 15 9b 0f 00 00 41 89 ca 74 10 b8 2c 00 00 00
0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d
d0
All code
=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax
   6: 77 69                ja     0x71
   8: c3                    ret
   9: 55                    push   %rbp
   a: 48 89 e5              mov    %rsp,%rbp
   d: 53                    push   %rbx
   e: 48 83 ec 38          sub    $0x38,%rsp
  12: 44 89 4d d0          mov    %r9d,-0x30(%rbp)
[    5.253671] RSP: 002b:00007ffc5839a338 EFLAGS: 00000202 ORIG_RAX:
000000000000002c
[    5.253674] RAX: ffffffffffffffda RBX: 0000556e7a95cc80 RCX: 00007f6cc34=
d55b7
[    5.253676] RDX: 0000000000000020 RSI: 0000556e7a9752d0 RDI: 00000000000=
00003
[    5.253677] RBP: 00007ffc5839a3d0 R08: 00007ffc5839a340 R09: 00000000000=
00080
[    5.253679] R10: 0000000000000000 R11: 0000000000000202 R12: 0000556e7a9=
8b2c0
[    5.253681] R13: 00007ffc5839a414 R14: 0000556e7a98b2c0 R15: 0000556e448=
c7a90
[    5.253684]  </TASK>
[    5.253685] ---[ end trace 0000000000000000 ]---

On Tue, Feb 25, 2025 at 9:05=E2=80=AFAM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> Just had this happen just before be2net initialization... FYI and all tha=
t ;)
>

[--8<--]

