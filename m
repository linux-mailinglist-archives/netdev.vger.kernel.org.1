Return-Path: <netdev+bounces-259590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAYSEWF3l2nVywIAu9opvQ
	(envelope-from <netdev+bounces-259590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:49:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AAF1626E7
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1482A30151EB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423F318EE1;
	Thu, 19 Feb 2026 20:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F903307AF0
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534171; cv=none; b=awZqzxduOR0vC5TVtLwf1WSKF7k31WrN4+vY4k5FTPdRegQ28Mv+3TyBDUUMcSi7v5b6hxdr3NLNM9VX/4kq/cRubABSUBXpv52J+LLjThQlVv6/HRJPGohmURttI7auurjl2g17ImW5nx1ikx32g+LqzgscGGhAgZ2g8hYd9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534171; c=relaxed/simple;
	bh=VPpsP0dsawszPlt3WR8YV332ybsqWRl9JKH0WSPkup8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=adaF4zWfpA6kCPHhg8YuTm4Ki4o7ny8Wma9u4JaZ2g3/Mb7HpCiqLCjGoHAlHVCbwp+Aq/Vn4TaSHT/5cWUpn3z+bXWS9goDLNI7moT73mRfCiop97N9ILJzjxg259q/47hSzZT5Pw5Ys8rPQvDtMwr431KnYGYnadOq7RxVX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679a47a1febso17734699eaf.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 12:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771534169; x=1772138969;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpT7RKYs8o+VrGFqhw7mVJWRGQZTD3hsQ/+Luc9lqMU=;
        b=NS7C8WyooVHWBx8Ki0Tuyz4E6p7QFg7BDBvjUvYHVD67xVpnAl8t0IFxmzNVBqHL3e
         2f2fgs1JaFsB/quIDp6IPjJYmA/CpptEDgE9xj7NTyKA3lNgu2JHeI6xKihH3yxuesdx
         OqZGt4mZS23loZ9xmxgIPvTaB6e74w+7FRWu/ug7gvNBltkHRsInnyqkSSCQW+yWgpp7
         nOqJi4bDE7n32T8QGAXs+5SVLMYYUQvAfH6uS2hQKQusQD+Qi4CIyybFbVKME2tc3a6y
         LI11VwEXAjt3OojZL80o31tnoAj119K1eniOcxdyC0lcDMj/+/vYRVMFIZsAdu46XGfA
         AbSw==
X-Forwarded-Encrypted: i=1; AJvYcCW7sA59YTj12IpyUMoetFPiDWWEFaehn3MNhkiWytXIWjMhTqDO7wesIxy+SSt5WyNjiEEI/j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGIa98zyZ2dWzzWWKy83SZ6Xb9bqS0DTmvWan7Vcxd1w3wHE9
	0c1LZt1iZSw8CEoc/W2Q/Z/zG+ObUAti1hHdxyppo1P3/BgZfIF9T2nDFIXLD4Ysrr28fdPOGA7
	aSB0MxIOKkMrIjm7y0JFuJR1yXkjpCtGr1ZrGntUB+EIPgp4H4KfN6cn2aw4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a6:b0:677:8da:2867 with SMTP id
 006d021491bc7-679a742cc7emr3617174eaf.38.1771534169287; Thu, 19 Feb 2026
 12:49:29 -0800 (PST)
Date: Thu, 19 Feb 2026 12:49:29 -0800
In-Reply-To: <6920fe81.a70a0220.d98e3.004f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69977759.050a0220.21cd75.0198.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_mgd_probe_ap_send (3)
From: syzbot <syzbot+a59b5291776979816910@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259590-lists,netdev=lfdr.de,a59b5291776979816910];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: B4AAF1626E7
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    2b7a25df823d Merge tag 'mm-nonmm-stable-2026-02-18-19-56' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a0bb3a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e
dashboard link: https://syzkaller.appspot.com/bug?extid=a59b5291776979816910
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16445ffa580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e8715a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2b7a25df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3a54d09b17c/vmlinux-2b7a25df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb704901bce5/bzImage-2b7a25df.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a59b5291776979816910@syzkaller.appspotmail.com

------------[ cut here ]------------
!sta
WARNING: net/mac80211/mlme.c:4504 at ieee80211_mgd_probe_ap_send+0x497/0x560 net/mac80211/mlme.c:4504, CPU#0: kworker/u4:1/13
Modules linked in:
CPU: 0 UID: 0 PID: 13 Comm: kworker/u4:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_mgd_probe_ap_send+0x497/0x560 net/mac80211/mlme.c:4504
Code: 4c 89 fe 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 dd 2b 78 f6 e8 98 44 8c f6 90 0f 0b 90 e9 3a fc ff ff e8 8a 44 8c f6 90 <0f> 0b 90 e9 d3 fc ff ff e8 7c 44 8c f6 90 0f 0b 90 e9 3c ff ff ff
RSP: 0018:ffffc9000026fa60 EFLAGS: 00010293
RAX: ffffffff8b3957a6 RBX: ffff888012918dc0 RCX: ffff88801b7b0000
RDX: 0000000000000000 RSI: ffffffff8e16564a RDI: ffff88801b7b0000
RBP: 0000000000000001 R08: ffff88801b7b0000 R09: 000000000000000c
R10: 000000000000000c R11: 0000000000000000 R12: ffff88801291aae2
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff888012919d40
FS:  0000000000000000(0000) GS:ffff88808ca5b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f947154da08 CR3: 000000001253c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 cfg80211_wiphy_work+0x2ab/0x4a0 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

