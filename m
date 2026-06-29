Return-Path: <netdev+bounces-302826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7WVYKg/fQmokGAoAu9opvQ
	(envelope-from <netdev+bounces-302826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:09:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 415636DECA0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:09:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302826-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302826-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD55E300CD9A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC03ACA61;
	Mon, 29 Jun 2026 21:09:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33133DEF9
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:09:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767369; cv=none; b=bG3DVYSCa2gLsxYd4luvNdWUIU8wA9IVdEBJv/lJSb3xcl8Ma4TznH6i+/wI+dT3ZOt4daA3lBbUNQXXuq4VAU/Nf3EQAo3Q+WSl2/h6LHOTyXv48Dsy97nFeLcADPveZewaKlUvxCQ5Iq6pFiyteI+THXxrsD++kjIZ02VjVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767369; c=relaxed/simple;
	bh=ywK+jmLIUBCAOzSFSMVIKI+bYm9mhJ6yboUEn0dK8YU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qf6fsfcPPV1VOpaVnXv+YkPmwW+y4VaFIeBmUmUOBLMwPzzX55VGiOiW0cQ9JJaiZTWWJLwmpPSgUhfOngt22nybrQ3vskJQ6XzlWXdDW/dwLisnWT9EOGkPYdlkavTxu+1e/ygDhRLDs/73B3duytYihoMLv5vTG/WP5twfCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-448d51840c4so493320fac.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782767367; x=1783372167;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gaZr34ys5Ki64CCh0X0YqV0Wo6Hd8GclX02Ssf8CR9g=;
        b=JTnFCmvG3+NQcDjWe0zXFhdkwLUlmR/9mNwH8svlfj6aTX236LM1do/PFbbXOSSJhJ
         msZSjDtNfROlgm4Xf5qXuLoO3UzWRex75AcChgKiGEH/zjxbtXXmehq/syfJSswjGYq3
         lZ2SvGl4oPDW6e7+os7R9jbHExobGiuCF+okAUbftlxQtRQDfeSSX3AkzRcZXgclvBXh
         jPloKJbAvFhXfTzx/ElLS/E2Ncm5lSSsMWaqFH2xzeDgSUGGpVYwNrMS8pH9/5JGMXcJ
         BevQLYF3kqQ33wdYmXxzVqqNuK7w3yDUIZbk4jmLK+/0VWHDdeKa6cJiR4H7Dl6r5PfS
         jFNA==
X-Forwarded-Encrypted: i=1; AFNElJ8n6Z7Ieagyv6Gt9B0J4zmBmss75IeK4qc4CFUYZ61Tlf50haX/PCgutHm5Nha4tXgbX99/gZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jMj+Ql1QCSctHcJsELE7EZjONeKQfHLrGvwRO/p4O6mdAWly
	ieZjiRGmCMa9bCmkaiFGS+sQX7BFTSGCs0z6qiZdKrFdE7LLyYmhvXgKHOM+Ir4nk97HGTQxFeX
	YL7ulv38KZdwLuCSDFcYtWK0sFehZt+E8QufliwGvmTTpdf9dDCqcLwOyKA8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5296:b0:491:bee4:d722 with SMTP id
 5614622812f47-495eaf639a5mr851332b6e.23.1782767367604; Mon, 29 Jun 2026
 14:09:27 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a42df07.854d4ab9.360e1d.000d.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in uea_upload_pre_firmware
From: syzbot <syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, castet.matthieu@free.fr, gregkh@linuxfoundation.org, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, stf_xl@wp.pl, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2bb8183b2d472f18];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302826-lists,netdev=lfdr.de,3d45d763d18796f97412];
	FORGED_RECIPIENTS(0.00)[m:3chas3@gmail.com,m:castet.matthieu@free.fr,m:gregkh@linuxfoundation.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:stf_xl@wp.pl,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,free.fr,linuxfoundation.org,lists.sourceforge.net,vger.kernel.org,wp.pl,googlegroups.com];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,vger.kernel.org:from_smtp,goo.gl:url,storage.googleapis.com:url,syzkaller.appspotmail.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 415636DECA0

Hello,

syzbot found the following issue on:

HEAD commit:    3d5670d672ae Add linux-next specific files for 20260626
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b76dfe580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bb8183b2d472f18
dashboard link: https://syzkaller.appspot.com/bug?extid=3d45d763d18796f97412
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fa0e1c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13519391580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a96151aa0055/disk-3d5670d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cdb70a1a6c6c/vmlinux-3d5670d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ffb9df12cc1/bzImage-3d5670d6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __intf_to_usbdev include/linux/usb.h:752 [inline]
BUG: KASAN: slab-use-after-free in uea_upload_pre_firmware+0x8d/0x640 drivers/usb/atm/ueagle-atm.c:598
Read of size 8 at addr ffff88802b0710b8 by task kworker/0:2/1664

CPU: 0 UID: 0 PID: 1664 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: events request_firmware_work_func

Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __intf_to_usbdev include/linux/usb.h:752 [inline]
 uea_upload_pre_firmware+0x8d/0x640 drivers/usb/atm/ueagle-atm.c:598
 request_firmware_work_func+0xf7/0x2d0 drivers/base/firmware_loader/main.c:1164
 process_one_work+0x93a/0x12b0 kernel/workqueue.c:3326
 process_scheduled_works kernel/workqueue.c:3409 [inline]
 worker_thread+0xb05/0x10d0 kernel/workqueue.c:3490
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5937:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d2/0x6b0 mm/slub.c:5515
 _kmalloc_noprof include/linux/slab.h:969 [inline]
 _kzalloc_noprof include/linux/slab.h:1290 [inline]
 usb_set_configuration+0x3cc/0x2180 drivers/usb/core/message.c:2096
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_new_device+0x98d/0x1610 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x28cf/0x4cf0 drivers/usb/core/hub.c:5953


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

