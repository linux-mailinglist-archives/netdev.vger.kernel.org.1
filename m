Return-Path: <netdev+bounces-278948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGtHMESK4GkyjgAAu9opvQ
	(envelope-from <netdev+bounces-278948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9740ADFC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6701F30209C1
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46D630EF63;
	Thu, 16 Apr 2026 07:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632478F39
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776323084; cv=none; b=FRiHWNL6vA4LWji3psdYicDuwKmemP+wEu/yMy6ThfQSjBF+NqpNwnmpGSZbd2a57t3tJ2ZSsGuD+SRzi8C/qhwrndwqtxRL7DaX3OS4231fmC7a71nnQfH4LQItLlQACWir3/2xd+f8jZuyoWcXVvli5eJvEOsRZcCRQxuQ2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776323084; c=relaxed/simple;
	bh=LwJ7uSj1qda+RSJcuR7+m//SXytkZ1om/XMT1yQAL4w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Dyitx6UOr5Qc7uPKU8TPdL1XoAYUjjALmk2U42c4LqEz1IMjjdA6B6zKU9kxdQe80JMPauThL+BgPUdmUpxVEByFh5Wz7guQaKMHOSyip6ERR+6wR2pHkN79TzAw9F/TD+A3ZHrCMICBrgN0NxLggHfqP3whnt2duvYeUpJp/g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-66b612efb4aso510498eaf.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 00:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323082; x=1776927882;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAwaHyfHxLs/DDfINn/4Jb88Y4F8ujkGWAxngWsCqFs=;
        b=Hfe6V2JUMLKQwXn/ZYGbJQIJ/2l4IiXFSQPQY1yqSpPiYFejGnU4qemG1jzUZlJNDy
         4YzumvA3ilDeey0wLDEV8AVNkJPOEO7vJiErdHwoBM143jWfdIpl0FwFekMGMejupFjC
         uQE9LTE3hTemCBUyVNfLoT5wMX8GUUwfD7wLqkjYhBBTTyMLgJvpP6uSfl3Fi8GBpdbx
         fvDSrt7+hiIGABAzdBJ1Gome5c/uVTRXKeYjlZBTBtUwcADdH4ErOSmgX36+4sBjZib1
         6sMXhtHmV+mG6OaXVdLMJXGVV5gfAl8sXjnOhVpvca9/It5E2eVr2fJOQpeDg+fQ2sFT
         PoMg==
X-Forwarded-Encrypted: i=1; AFNElJ8PKUpvuoaDUw90k+VPpX0I76ydrHSF8mxNI/1dQb+jcqT8yJ2+tB+R6NdTkYAMo5a/PpYFEQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJaN9F2auuZCwWqxsmPlI52GTjadmOC9SqMmSpcURyeSag+EBv
	/xUrRE+WG59ryVxuB/oJ8vdFFUHvHCJ4VE141dTx01iT/NeSaQl6iWq8DjuFwR4eHEde3LctfOP
	xkQt968SSZr0yPQqgcWOsX9tcaB9KzGcBdn0LBoLKDzZFpmJVMzxxxbpkGKI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c17:b0:688:8c68:1f0a with SMTP id
 006d021491bc7-69423ec22fbmr843075eaf.19.1776323082599; Thu, 16 Apr 2026
 00:04:42 -0700 (PDT)
Date: Thu, 16 Apr 2026 00:04:42 -0700
In-Reply-To: <20260416034610.8873-1-jiayuan.chen@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e08a0a.a70a0220.259bc5.0019.GAE@google.com>
Subject: [syzbot ci] Re: net: tunnel: fix stale transport header after GRE/TEB decap
From: syzbot ci <syzbot+ci8b43956da1b72f0c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, jiayuan.chen@linux.dev, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	pshelar@nicira.com, syzbot@syzkaller.appspotmail.com, tom@herbertland.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-278948-lists,netdev=lfdr.de,ci8b43956da1b72f0c];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzbot.org:url,appspotmail.com:email,googlegroups.com:email]
X-Rspamd-Queue-Id: 0FE9740ADFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v1] net: tunnel: fix stale transport header after GRE/TEB decap
https://lore.kernel.org/all/20260416034610.8873-1-jiayuan.chen@linux.dev
* [PATCH net v1 1/2] net: tunnel: fix stale transport header after GRE/TEB decap
* [PATCH net-next v1 2/2] net: add DEBUG_NET_WARN_ON_ONCE for negative transport offset

and found the following issue:
WARNING in udpv6_err

Full report is available here:
https://ci.syzbot.org/series/3886f2f1-a6d5-4c5c-8dc8-bc1cec577567

***

WARNING in udpv6_err

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      1f5ffc672165ff851063a5fd044b727ab2517ae3
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/06cf41a2-60fe-4f9b-8f68-57eb6d1e48cc/config

------------[ cut here ]------------
off < 0
WARNING: ./include/linux/skbuff.h:3239 at udpv6_err+0x1521/0x16d0, CPU#0: kworker/u9:2/51
Modules linked in:

CPU: 0 UID: 0 PID: 51 Comm: kworker/u9:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker

RIP: 0010:udpv6_err+0x1521/0x16d0
Code: f7 b0 01 89 44 24 30 49 bf 00 00 00 00 00 fc ff df e9 ea ef ff ff e8 8e f2 66 f7 90 0f 0b 90 e9 2a f9 ff ff e8 80 f2 66 f7 90 <0f> 0b 90 e9 bb f9 ff ff e8 72 f2 66 f7 90 0f 0b 90 e9 1a fa ff ff
RSP: 0018:ffffc900000074e0 EFLAGS: 00010246

RAX: ffffffff8a5e6c30 RBX: 0000000080000000 RCX: ffff888106e91d80
RDX: 0000000000000100 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90000007670 R08: ffff88810be30ae0 R09: 000000000000234e
R10: 000000000000003c R11: ffffffff8a5e5710 R12: ffff888116513390
R13: ffff888114c38900 R14: fffffffffffffff8 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88818dc43000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555561513898 CR3: 000000016fad2000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 icmpv6_notify+0x407/0x850
 icmpv6_rcv+0x13b0/0x1d80
 ip6_protocol_deliver_rcu+0xe37/0x1610
 ip6_input_finish+0x191/0x370
 NF_HOOK+0x336/0x3c0
 ip6_input+0x16a/0x270
 NF_HOOK+0x336/0x3c0
 process_backlog+0x7dd/0x1950
 __napi_poll+0xae/0x340
 net_rx_action+0x627/0xf70
 handle_softirqs+0x22a/0x840
 do_softirq+0x76/0xd0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130
 wg_socket_send_skb_to_peer+0x16b/0x1d0
 wg_packet_handshake_send_worker+0x203/0x350
 process_scheduled_works+0xb5d/0x1860


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

