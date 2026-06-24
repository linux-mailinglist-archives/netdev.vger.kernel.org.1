Return-Path: <netdev+bounces-301632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0jLDJjLKO2q8dAgAu9opvQ
	(envelope-from <netdev+bounces-301632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:14:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 081746BE06E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301632-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301632-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31B493005E8A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC32BEC43;
	Wed, 24 Jun 2026 12:14:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECF2D94B5
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:14:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303274; cv=none; b=ufME0jZ1iwVmvX6m9LwIh0QeS1cH83WP8c/kIiDiSGi3JJLL4ejKYnywz2lKR7Hg9sY0FwUWzJMteaDsa5La5HLa4ZygJHNOEOAdhV4AwaYrWYaftVaKRjgc1ge3C7e9IEVZ8+HAgc5bWMhd1rVh0jq258QAPWKeRHukJuYdppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303274; c=relaxed/simple;
	bh=1VcIPUC/nBpYX8U3kB1v5nOwaGgdyAKzTTbUyoLIidY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=sMIqmC85qU0uPCcA4WVcSHvAE1fsSqrIvRaKPhiWC/pOEVSTIfXjZRE43BZszzL2fNdf0bYr8LBVrPvlI0LUXtnarNzB/fa2dg/ijDRic/hZePcObak+M+EvGsJ1yugFeSGQAmvNSY8EQooZ8OXrx0aTs7fxdaRw2NXwcI3O7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-486cc29e03bso1296706b6e.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303272; x=1782908072;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0/BKGHSgt7kkPjfopsHIa52lwo20kFyOlX7eKJo26Y=;
        b=L66ZOjoiCgnYGnwWAEBDOcxMDHGt8i4EmgsiT/Xu0hh8VjwIibrnREAS5rSVge18fB
         q4MGL97kHDweh3lUHIP5O1dRuKxDFwA8VHW5DqX6cFfMNy7YrpWSZH6oKTBe3my5f90b
         11cTJ/TsbYxpAat4zW18Q8MwdN1d8jLPnBx1D7aD/vwWIRpy8lmr5TjnsGdVrLlL/CeX
         hjOWXf0CDrXRTz8MPRdHxepcm67G5UIraibF9MXKKCpZsrLZJW2bys9tGRqErlvEBr31
         f0YBUHmwwpjrI1kcbUc8TDu97xTsUJywAasiSrLhwuWTHJduqqrwIFcSHiUuIjFgdlVJ
         8BOw==
X-Forwarded-Encrypted: i=1; AFNElJ/n7PkBSWj+iBlXGSfhBoBJXuEAHhdhduZDL5DEYKoiw4poOoZcCLBD12Zgu2yFFGuil2T8sjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzopDQzpCdqWEF7PgARgoP0TdjspnSUaUsa78D3V+5rnydTXsTD
	NMe+kGqrtdMcQTUnKHc/50vCFPtkv95fbyrNJ+nZMqXTg5R3xIdznehZcUyusvl+4R2x0iQRFCs
	TkvYGwxnJJjcvmkRVByKwFPe0y3E2CzkddnLooQ4TM1ZRrJjQe8Yuu8KBUwg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6718:b0:485:5982:4cfc with SMTP id
 5614622812f47-49079492366mr2337970b6e.33.1782303272549; Wed, 24 Jun 2026
 05:14:32 -0700 (PDT)
Date: Wed, 24 Jun 2026 05:14:32 -0700
In-Reply-To: <20260624073209.3703492-1-edumazet@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3bca28.92e8a34c.2b91f1.0008.GAE@google.com>
Subject: [syzbot ci] Re: net: clear transport header during tunnel decapsulation
From: syzbot ci <syzbot+ci7e1fc283906ef7ab@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzbot@syzkaller.appspotmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:eric.dumazet@gmail.com,m:horms@kernel.org,m:idosch@nvidia.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot@syzkaller.appspotmail.com,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,google.com,gmail.com,nvidia.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301632-lists,netdev=lfdr.de,ci7e1fc283906ef7ab];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,googlegroups.com:email,googlesource.com:url,appspotmail.com:email,syzbot.org:url,syzkaller.appspotmail.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 081746BE06E

syzbot ci has tested the following series

[v1] net: clear transport header during tunnel decapsulation
https://lore.kernel.org/all/20260624073209.3703492-1-edumazet@google.com
* [PATCH net] net: clear transport header during tunnel decapsulation

and found the following issue:
WARNING in geneve_udp_encap_recv

Full report is available here:
https://ci.syzbot.org/series/1f6dc47e-354f-4904-bc18-c2b7ea4d79b2

***

WARNING in geneve_udp_encap_recv

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      d87363b0edfc7504ff2b144fe4cdd8154f90f42e
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/7bb83c16-d55d-4d99-8c2b-6050e0022ef6/config

------------[ cut here ]------------
!skb_transport_header_was_set(skb)
WARNING: ./include/linux/skbuff.h:3094 at geneve_udp_encap_recv+0x26ed/0x4130, CPU#1: kworker/1:3/5072
Modules linked in:
CPU: 1 UID: 0 PID: 5072 Comm: kworker/1:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:geneve_udp_encap_recv+0x26ed/0x4130
Code: c8 00 00 00 0f b6 04 01 84 c0 0f 85 f2 18 00 00 48 8b 7c 24 78 66 44 89 6f 0a e8 7e 9b 7a 03 e9 8c 00 00 00 e8 f4 fc 33 fb 90 <0f> 0b 90 e9 2e e3 ff ff 49 83 c6 06 4c 89 f0 48 c1 e8 03 48 b9 00
RSP: 0018:ffffc90000a08620 EFLAGS: 00010246
RAX: ffffffff8691f92c RBX: ffff8881bcc8b5d0 RCX: ffff88816a7abb80
RDX: 0000000000000100 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: ffffc90000a08790 R08: ffffffff903114f7 R09: 1ffffffff206229e
R10: dffffc0000000000 R11: fffffbfff206229f R12: ffff888109f6a108
R13: 1ffff110213ed5df R14: 0000000000000010 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8882a927b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6956ea5440 CR3: 000000016f55c000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 udp_queue_rcv_one_skb+0xfc5/0x10e0
 udp_unicast_rcv_skb+0x21a/0x3a0
 udp_rcv+0xecb/0x1db0
 ip_protocol_deliver_rcu+0x27e/0x440
 ip_local_deliver_finish+0x3bb/0x6f0
 NF_HOOK+0x336/0x3c0
 NF_HOOK+0x336/0x3c0
 process_backlog+0xa34/0x1860
 __napi_poll+0xaa/0x330
 net_rx_action+0x61d/0xf50
 handle_softirqs+0x225/0x840
 do_softirq+0x76/0xd0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130
 __dev_queue_xmit+0x1ed7/0x37f0
 ip6_output+0x337/0x540
 NF_HOOK+0x177/0x4f0
 mld_sendpack+0x890/0xe10
 mld_ifc_work+0x839/0xe70
 process_scheduled_works+0xa8e/0x14e0
 worker_thread+0xa47/0xfb0
 kthread+0x388/0x470
 ret_from_fork+0x514/0xb70
 ret_from_fork_asm+0x1a/0x30
 </TASK>


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

