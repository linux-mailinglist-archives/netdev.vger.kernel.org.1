Return-Path: <netdev+bounces-265310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMb3LRuOrWlE4QEAu9opvQ
	(envelope-from <netdev+bounces-265310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 15:56:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C23E230CE9
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 15:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54E5D300DA5E
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB828469A;
	Sun,  8 Mar 2026 14:56:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E91280325
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772981784; cv=none; b=p/tK+sg/jHQfAkutYF4cc5zgBsoszw3SgqStq6lXR1JJNzbyREo+kPVXClo1Z8DOFoRC8+5xk6MLG24LpokpTyMwytvT0eSMGnI8jFa2W64NvTKztDidZFWm2E9sAoI/C5YTvIRv0pzPpioGMJqM8GCYz0TlP9o/NdvG5cg7AdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772981784; c=relaxed/simple;
	bh=tyQhVH22aDygD/ZADCJxhZW1bNhtNJwliSY/9cW60HA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CRxFgNhrFSSYgjVpTZxtvpY/IOJ7FyAieYDDuLNMqtN7Rpzgm8V7RuIagEG8E9yJWferm17knkB29nqh5IcVM4o90ltvkL6CgLvG7zHC7vXMF+vjYCrJbotfaVW9KESsYuY5vhnHZMaFR/jcl69qHNb1FURIAa+OY69HEI6kdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67999892f00so181289993eaf.3
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 07:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772981781; x=1773586581;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwKum3eaGpxlRXiKO+ocszJG7j17Yg5sHhgYN1V6OMw=;
        b=KsRpOs26N5qNZjqvlrWCyrlXD83b2BZaieLwzCL/JNLqfMxejftou8CYw1XwTRTTH4
         w19HX3OZaBY5pQAfpoXO/44QRJrtHIEtBeQ7z+xcqa7kiObZ3EO4J7orPfMNWhBvod8H
         XvMfFLZrsMTKSTfPFCIbvyjfY6fFKJEoNpkOI4SO8fC2oxCUJ6AcVfucyBc2DFSNUOiK
         rnRxAWh6I5mkM30WaG/Weg7yL3LZ/ivgc4v+IztnXEUe/CrvPr3D17A9ey6ySPJyLspT
         PZIrk5KwbP6O05EmxpDYa5sop/2dWnWgV7GXgMlLHNlSeNkbZvx2BQ2Fsk34MinwtM+1
         52Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUbN1iHnH8lO3rngZd56qWfW4AM2vKMkGcBKt8oIS6o3m/qy/fi20AiqATItTGGJazgtrw33Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAP74B8xrbDS5uA1LezXUFEMD09q09g48nSZLHHofOq8xyCuEG
	6gY/IpWp7/tfpWgqcDoENvll3k/WeTSzB3gPQwB7vyk5pXDSGjMxd+0YP4XRzyqRV/8c2XQsxjw
	UNBBiHq1hVcmffdZizxs6y7c2LB1HsmHFjMEuFVAYxOKptkMMQM90V5Cxvao=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:820:b0:67b:b33c:48d7 with SMTP id
 006d021491bc7-67bb33c4a70mr483102eaf.65.1772981781716; Sun, 08 Mar 2026
 07:56:21 -0700 (PDT)
Date: Sun, 08 Mar 2026 07:56:21 -0700
In-Reply-To: <66f49736.050a0220.211276.0036.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ad8e15.050a0220.310d8.000d.GAE@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: task hung in wg_netns_pre_exit (5)
From: syzbot <syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, andrew@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	davem@davemloft.net, edumazet@google.com, hpa@zytor.com, jason@zx2c4.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	wireguard@lists.zx2c4.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2C23E230CE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=779072223d02a312];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265310-lists,netdev=lfdr.de,f2fbf7478a35a94c8b7c];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    c113d5e32678 Merge branch 'net-spacemit-a-few-error-handli..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4875a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
dashboard link: https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cf3fe6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b5c8ba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1a0aa684791/disk-c113d5e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d0461aed5ba/vmlinux-c113d5e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05b26502bb1f/bzImage-c113d5e3.xz

The issue was bisected to:

commit d4dfc5700e867b22ab94f960f9a9972696a637d5
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Mar 19 23:38:49 2024 +0000

    bpf: pass whole link instead of prog when triggering raw tracepoint

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ccbc58580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=142cbc58580000
console output: https://syzkaller.appspot.com/x/log.txt?x=102cbc58580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when triggering raw tracepoint")

INFO: task kworker/u8:7:1016 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:7    state:D stack:25664 pid:1016  tgid:1016  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x15dd/0x52d0 kernel/sched/core.c:6908
 __schedule_loop kernel/sched/core.c:6990 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7005
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7062
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7fe/0x1300 kernel/locking/mutex.c:776
 wg_netns_pre_exit+0x1c/0x200 drivers/net/wireguard/device.c:419
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x940 net/core/net_namespace.c:234
 cleanup_net+0x56b/0x800 net/core/net_namespace.c:704
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

