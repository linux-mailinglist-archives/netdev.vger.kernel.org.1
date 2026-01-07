Return-Path: <netdev+bounces-247874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52017D0014D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 22:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D4B3014ACC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0E296BA8;
	Wed,  7 Jan 2026 21:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71691275B15
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819698; cv=none; b=DWwvEa8JQJSEbmedecoi+oO2y8/QopuvxyDhC8Jf4JAkTVHmnb1NtqLpDjs+VCBFqQ2skIVzRwhSpVzfSmh8bfjTH01LB4Td/kJMz6R1XVkvvAV2W73N9tHkAYX9xyyEWytd/dyL5oDucuJcSkpPix+3jJC3Do60J0aCajHL7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819698; c=relaxed/simple;
	bh=svbXz6QwZmZZutYCyDA/vwOZpaivfZPm6H0oEcHlEbs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=iE0yN5ZCo+x4GV9E0wl7lNPI4n06O0x2TC02uQPK5wXGzio/2OuK48j22a1K1+8ysuHduZX+m/l8WUle0l7dd3+TMMub9RG8+UbnEC5uut/rJ1thW65R7VRX9EQs5V2KvT0oQg7njpu4s4vdtvTrjfcsK0VCICBjR5c9+kRvcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7ce5218a74cso2261948a34.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 13:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767819695; x=1768424495;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQCqX6kWiG9Ax9dPgEFr63876bw1qGgkAwiAS4CGSg4=;
        b=SeVyjbRdUYXfO5qcI0EKTNuyLw6qqgrMYXaE9BjPtnaH6V+cQ3WBnG7S2ffp30PnDH
         +kCBHnDiLf3cx6RH7hGBOCMGt9/A4YR+c+vXGLzWjm9/CLHyhpH3Mrk0ZRhHZSDcTARB
         xzmbGKO3rPUWZj/a0ndGuiG+dAmLzxYLDx10dK8tBlnzrim+esYtCwZLnyv93I05kuJx
         zBFnoKgPEKVnlbWE7S6yEqwXj6oZECoYJpgF3/0zJphmNabObir2jImP8oSGqlhXKZRf
         c5WyV8UJTag+zlgrP5ZiORV/gRGhLOs9AEDEy/GZ737uzT7RxLeM30NfHkWtR7ALiQZk
         R9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVrMv2ySO2Ev1mkCkxIB03KwiWksQOdxYXu9njAW98aiNNfcexi6ODY1SaUrwchOF0FrR0UUqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvqImIT/E9bRoy5qLFMkqPCBlsqjrWoedzKeShp/Mhd0hLRWJ
	VrSP09XCFGCNCD+SiWDHi9xtmKcAlw3icVwHolNmmwmZlSaQKiJ/4soMRfuIb0TmT/owG98uFjf
	cescN1c6KWf0A22q8/xwgi1Pp+Iiku/zC+e/oZTqiW0DcPOu+8Jzr1uzvoL8=
X-Google-Smtp-Source: AGHT+IGMOnxovbIoT6GN2XGJGsdfciW2WbfLn2wUP6PWmbKEnbnIGAr5RyinnPH3Tv0EO+NZxg4ZLuFppLl+Fr8/6Ot6Ad7if63e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d814:0:b0:65d:c79:8b87 with SMTP id
 006d021491bc7-65f54ed647dmr1322354eaf.5.1767819695373; Wed, 07 Jan 2026
 13:01:35 -0800 (PST)
Date: Wed, 07 Jan 2026 13:01:35 -0800
In-Reply-To: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695ec9af.050a0220.1c677c.037d.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Fix memory access flags in helper prototypes
From: syzbot ci <syzbot+cicac8180258d8bceb@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dxu@dxuuu.xyz, eddyz87@gmail.com, 
	edumazet@google.com, electronlsr@gmail.com, ftyghome@gmail.com, 
	gplhust955@gmail.com, haoluo@google.com, haoran.ni.cs@gmail.com, 
	horms@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mattbobrowski@google.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] bpf: Fix memory access flags in helper prototypes
https://lore.kernel.org/all/20260107-helper_proto-v1-0-e387e08271cc@gmail.com
* [PATCH bpf 1/2] bpf: Fix memory access flags in helper prototypes
* [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag

and found the following issue:
WARNING in check_helper_call

Full report is available here:
https://ci.syzbot.org/series/020c2fa8-b95d-4273-9bc0-2f82fa714a8e

***

WARNING in check_helper_call

tree:      bpf
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf.git
base:      ab86d0bf01f6d0e37fd67761bb62918321b64efc
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251202083448+f68f64eb8130-1~exp1~20251202083504.46), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/9a24b0e7-35e4-4718-b939-3b210b6b5126/config
C repro:   https://ci.syzbot.org/findings/8fcbdcf8-4480-46d8-b7a8-f1de9401a8ac/c_repro
syz repro: https://ci.syzbot.org/findings/8fcbdcf8-4480-46d8-b7a8-f1de9401a8ac/syz_repro

------------[ cut here ]------------
verifier bug: incorrect func proto bpf_tcp_raw_check_syncookie_ipv6#207
WARNING: kernel/bpf/verifier.c:11546 at check_helper_call+0xc00/0x6e10 kernel/bpf/verifier.c:11546, CPU#0: syz.0.17/5981
Modules linked in:
CPU: 0 UID: 0 PID: 5981 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:check_helper_call+0xc16/0x6e10 kernel/bpf/verifier.c:11546
Code: ef e6 ff 49 bf 00 00 00 00 00 fc ff df 48 8d 1d a0 c2 ea 0d 44 8b 64 24 24 44 89 e7 e8 d3 32 0c 00 48 89 df 48 89 c6 44 89 e2 <67> 48 0f b9 3a 49 81 c6 80 08 00 00 44 89 e7 e8 b6 32 0c 00 4c 89
RSP: 0018:ffffc90007116fa0 EFLAGS: 00010246
RAX: ffffffff8b934740 RBX: ffffffff8fc645d0 RCX: dffffc0000000000
RDX: 00000000000000cf RSI: ffffffff8b934740 RDI: ffffffff8fc645d0
RBP: ffffc900071171b0 R08: ffff88816b42ba80 R09: 0000000000000002
R10: 0000000000000004 R11: 0000000000000000 R12: 00000000000000cf
R13: f8f8f8f8f8f8f8f8 R14: ffff888112440000 R15: dffffc0000000000
FS:  000055557af7b500(0000) GS:ffff88818e40e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd892207dac CR3: 0000000161682000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 do_check_insn kernel/bpf/verifier.c:20417 [inline]
 do_check+0x99eb/0xec30 kernel/bpf/verifier.c:20598
 do_check_common+0x19cc/0x25b0 kernel/bpf/verifier.c:23882
 do_check_main kernel/bpf/verifier.c:23965 [inline]
 bpf_check+0x5f0d/0x1c4a0 kernel/bpf/verifier.c:25272
 bpf_prog_load+0x1484/0x1ae0 kernel/bpf/syscall.c:3088
 __sys_bpf+0x570/0x920 kernel/bpf/syscall.c:6164
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd891f9acb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee24b6bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fd892205fa0 RCX: 00007fd891f9acb9
RDX: 0000000000000094 RSI: 0000200000000300 RDI: 0000000000000005
RBP: 00007fd892008bf7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd892205fac R14: 00007fd892205fa0 R15: 00007fd892205fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	ef                   	out    %eax,(%dx)
   1:	e6 ff                	out    %al,$0xff
   3:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
   a:	fc ff df
   d:	48 8d 1d a0 c2 ea 0d 	lea    0xdeac2a0(%rip),%rbx        # 0xdeac2b4
  14:	44 8b 64 24 24       	mov    0x24(%rsp),%r12d
  19:	44 89 e7             	mov    %r12d,%edi
  1c:	e8 d3 32 0c 00       	call   0xc32f4
  21:	48 89 df             	mov    %rbx,%rdi
  24:	48 89 c6             	mov    %rax,%rsi
  27:	44 89 e2             	mov    %r12d,%edx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	49 81 c6 80 08 00 00 	add    $0x880,%r14
  36:	44 89 e7             	mov    %r12d,%edi
  39:	e8 b6 32 0c 00       	call   0xc32f4
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

