Return-Path: <netdev+bounces-283709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LWgyGRFA+Gm7rwIAu9opvQ
	(envelope-from <netdev+bounces-283709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 08:43:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BF4B8F9A
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 08:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CDC7300158D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 06:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE62BD58A;
	Mon,  4 May 2026 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqIR5h6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17E1D63F3
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877001; cv=none; b=P58EM270PGn45aEtNRd/6L+nRSDZqD0f0AT2F99VVNDEG+DlrLcrT55V2yJE91414xz26TXSqt7iFbVXKzu8dWbpNqDOC++jyCiY6WyNfVUyoVGP/KMJBdo63VNcNEijhXAEkf3KUkLAjH0qe1InVwuC4vyi2ttfeAKwpDBtWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877001; c=relaxed/simple;
	bh=wo7fOgBG2VauhvWr0enPU7lyvoP1io1GqCFHCp45PaI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nXFLhQQPodZL4VUI+iBXSvlwG55XmpDKFqJsrrHWLHOQ7b/T4ZQ89TY+92djYLZ3+puKnGlE8flW/Nj6p7S97+HoMb+6U12RBv+dmd47RRmzgHvvOfA862Zfi88JzzcAcc/e0SwqboHBgjg5pWDXs78UYbCJ6n9wtj/5dLFah0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqIR5h6U; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76bfd7b9cdso913523a12.3
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 23:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777877000; x=1778481800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O4nQa1P0yGpkp0BtI3NhFxt0zzIaCuQEDQXaWWhWv0o=;
        b=FqIR5h6UJfD0ZOWR199EkidwaaKoKOpBzySHxhPF9b9PZhmJ2y7WKRqo222Mcht15+
         gJEunhVHy3FsS1rL9HV9B4hF9s7pbL4LdYhzQhU/+upi21vlPoGxna49Vt88Qfj1M3PC
         ns/P9+h5rch3baxuswctCqkh0BaCt22gvvnSQUDmqlVh8LyarKlQyr3PXKtrE9D/2W4A
         OMIhYu5YoJbsCRqAY1eYHOmvZbum6nX01x3DkSsZkaYe6ZZxlXzNohtrMscDSxtWuDVo
         iCWCGksVOng66K1rqXzHXoUm9j/XsAJC/fECjjAzFDFWDNv9GWvGVOE9krVbkaSHbbxb
         onwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777877000; x=1778481800;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4nQa1P0yGpkp0BtI3NhFxt0zzIaCuQEDQXaWWhWv0o=;
        b=KdbENWptEGe03WuW8086olx0tNtvahnjrvTvbSiEhel0VfgVV4NLb7SsKOLey9RbmH
         +22WKG//kPGgB5JQfnlH/EXWPeh3gYGBAdIlySm3ohnVuwLPusgZ9fTZi/IOQDz9Zn8x
         8QP/1/oIbKuRIP/I3Qrc0xn2vElMD4mJJgqk79kFhFHDJ+T2LtKYwuREnK28MEJtlS9r
         Q4sKxBs0OtbSD1awiojy3O85G7Hw2h2aUZ7DS/Tg7Ai4KGteHa7KJZGqEU40oSXjV9Fr
         tdfJoSgc+uI88HxRXZsZ4ZDp2j3Ga+RqEx3MegxjuEnb4SRzpsukNtDHGVC6BUHF2RC1
         eTaA==
X-Forwarded-Encrypted: i=1; AFNElJ8zwv5ztdyb41XKMzBqxRl3uwuya3rcWhnObU5avP/Mz33meIiIfDvF/EW2Lbim10eWL7ZN8bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqO/jyFzkELuh6E8bUIBuK8e1E9xTd/q/t+WFA8kEWZtEV+xO
	qZ8mccMe6fz5sPcmAkWtDKZ7RaHfkffBTFuVlHvWBZsJ6zZg3l2uJ2ghTtPOYSuw4LM9A9AYt0o
	DpQvKtQ==
X-Received: from pgjh19.prod.google.com ([2002:a63:df53:0:b0:c79:61dd:3232])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1e:b0:398:9fc9:e07c
 with SMTP id adf61e73a8af0-3a7f1c280e1mr8473775637.24.1777876999476; Sun, 03
 May 2026 23:43:19 -0700 (PDT)
Date: Mon,  4 May 2026 06:43:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504064316.3820775-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipv6: Fix null-ptr-deref in fib6_mtu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+01f005f9c6387ca6f6dd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 585BF4B8F9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283709-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,01f005f9c6387ca6f6dd];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

syzbot reported null-ptr-deref in fib6_mtu(). [0]

When res->f6i->fib6_pmtu is 0 in fib6_mtu(), it fetches MTU from
__in6_dev_get(nh->fib_nh_dev)->cnf.mtu6.

However, __in6_dev_get() could return NULL when the device is
being unregistered.

Let's return 0 MTU if __in6_dev_get() returns NULL in fib6_mtu().

[0]:
Oops: general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
CPU: 0 UID: 0 PID: 7890 Comm: syz.2.502 Tainted: G             L      syzkaller #0 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:fib6_mtu net/ipv6/route.c:1648 [inline]
RIP: 0010:rt6_insert_exception+0x9eb/0x10a0 net/ipv6/route.c:1753
Code: 3b 14 cf f7 45 85 f6 0f 85 1d 02 00 00 e8 7d 19 cf f7 48 8d bb e0 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 89
RSP: 0000:ffffc9000610f120 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000c001000
RDX: 00000000000000bc RSI: ffffffff8a38bc83 RDI: 00000000000005e0
RBP: ffff888052f06000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888042d16c00
R13: ffff888042d16cc8 R14: 0000000000000001 R15: 0000000000000500
FS:  0000000000000000(0000) GS:ffff88809717d000(0063) knlGS:00000000f540db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f73c6d50 CR3: 000000006eff0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __ip6_rt_update_pmtu+0x555/0xd60 net/ipv6/route.c:2982
 ip6_update_pmtu+0x34f/0x3b0 net/ipv6/route.c:3014
 icmpv6_err+0x2a2/0x3f0 net/ipv6/icmp.c:82
 icmpv6_notify+0x35e/0x820 net/ipv6/icmp.c:1087
 icmpv6_rcv+0x10bf/0x1ae0 net/ipv6/icmp.c:1228
 ip6_protocol_deliver_rcu+0xf97/0x1500 net/ipv6/ip6_input.c:478
 ip6_input_finish+0x1e4/0x4a0 net/ipv6/ip6_input.c:529
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip6_input+0x105/0x2f0 net/ipv6/ip6_input.c:540
 ip6_mc_input+0x513/0xf50 net/ipv6/ip6_input.c:630
 dst_input include/net/dst.h:480 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:119 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ipv6_rcv+0x34c/0x3d0 net/ipv6/ip6_input.c:351
 __netif_receive_skb_one_core+0x12d/0x1e0 net/core/dev.c:6202
 __netif_receive_skb+0x1f/0x120 net/core/dev.c:6315
 netif_receive_skb_internal net/core/dev.c:6401 [inline]
 netif_receive_skb+0x13b/0x7f0 net/core/dev.c:6460
 tun_rx_batched.isra.0+0x3f6/0x750 drivers/net/tun.c:1511
 tun_get_user+0x1e31/0x3c20 drivers/net/tun.c:1955
 tun_chr_write_iter+0xdc/0x200 drivers/net/tun.c:2001
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 do_int80_emulation+0x141/0x700 arch/x86/entry/syscall_32.c:172
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0023:0xf715616b
Code: 57 56 53 8b 44 24 14 f6 00 08 75 23 8b 44 24 18 8b 5c 24 1c 8b 4c 24 20 8b 54 24 24 8b 74 24 28 8b 7c 24 2c 8b 6c 24 30 cd 80 <5b> 5e 5f 5d c3 5b 5e 5f 5d e9 f7 a1 ff ff 66 90 66 90 66 90 90 53
RSP: 002b:00000000f540d44c EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 0000000080000640
RDX: 000000000000007a RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Fixes: dcd1f572954f ("net/ipv6: Remove fib6_idev")
Reported-by: syzbot+01f005f9c6387ca6f6dd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69f83f22.170a0220.13cc2.0004.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0dc0316530ca..e3d355d1fbd6 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1645,6 +1645,10 @@ static unsigned int fib6_mtu(const struct fib6_result *res)
 
 		rcu_read_lock();
 		idev = __in6_dev_get(dev);
+		if (!idev) {
+			rcu_read_unlock();
+			return 0;
+		}
 		mtu = READ_ONCE(idev->cnf.mtu6);
 		rcu_read_unlock();
 	}
-- 
2.54.0.545.g6539524ca2-goog


