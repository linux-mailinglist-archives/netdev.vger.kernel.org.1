Return-Path: <netdev+bounces-304199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QmRdNblvRmo9VAsAu9opvQ
	(envelope-from <netdev+bounces-304199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA66F8A99
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:03:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=n9UQCXIk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304199-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304199-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A83D8300B288
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97604B8DF6;
	Thu,  2 Jul 2026 14:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C144ADD8B;
	Thu,  2 Jul 2026 14:00:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000855; cv=none; b=ORCO8917PUOYeDToERhWeDrY28T3sdGZLnwRNffoM2rOrALpHOyVUZ4PZWpJBCqwdvZh+QKrZSFGlErWB9QYoTjVfaWSGKo50N+lLp7kzAhCiP/19rqPTbJmobVqnGHdU8kCxkHmhG4hS4Gx2SFu6wfuvWSvGJIuQHv+6+HKWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000855; c=relaxed/simple;
	bh=NxGzxz36h2GTZCsN7+zsKburnLEv5LIAVAAa1+G7NFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zug89Y2xOoiZHYbc/UURsY24eeLb1Zx94BFYjehL6GriJ+LKZQgW1OEojgz3Kh797vNtodJxTVtzpHO5nWrpKsDlF2WKUUpwytKUzzvxevmL/VD+T02BGHz9jNJ5tY9y5+S0JonGontiQ6I1nV5Q4di1A9I86ZoVddWeMiTyHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=n9UQCXIk; arc=none smtp.client-ip=113.46.200.221
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rurax16pQxCQ7BXDE9yn3T2tSCVEnYVid19tKQDrMp0=;
	b=n9UQCXIk+n9WZTWkb61OY1//SoqO32PkzYiRK2O/Er0PPmh6g6m+q0Sb23wbjaFKo4wXAl/Hr
	djYP4rlv5Z5aFTt6oztsjjqp3C5gy1rAinEckJkQ6UgJJi6HjUA3ewuLhEDRYhCB+XTyS3B2Cj3
	ngn3b9y/HJSo9q1FWxY/my0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4grdb74s17zRhVG;
	Thu,  2 Jul 2026 21:51:31 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id CE76940593;
	Thu,  2 Jul 2026 22:00:40 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Jul 2026 22:00:40 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Jul 2026 22:00:39 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <daniel@iogearbox.net>, <edumazet@google.com>, <ncardwell@google.com>,
	<kuniyu@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<jiayuan.chen@linux.dev>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <zhangchangzhong@huawei.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dong Chenchen <dongchenchen2@huawei.com>,
	<syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com>
Subject: [PATCH net 1/2] bpf, sockmap: account only unread data in tcp_eat_skb
Date: Thu, 2 Jul 2026 22:09:58 +0800
Message-ID: <20260702140959.1806754-2-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260702140959.1806754-1-dongchenchen2@huawei.com>
References: <20260702140959.1806754-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304199-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:zhangchangzhong@huawei.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:dongchenchen2@huawei.com,m:syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com,m:johnfastabend@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,google.com,gmail.com,cloudflare.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,syzkaller.appspot.com:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,06dbd397158ec0ea4983];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCEA66F8A99

tcp_eat_skb() advances copied_seq by the full skb length when a sockmap
verdict drops or redirects an skb. This assumes none of the skb has
previously been consumed.

That assumption does not hold when userspace partially reads an skb
before adding the socket to a sockmap. A later packet invokes the
verdict path, which dequeues the partially consumed skb. Adding its full
length counts the consumed prefix twice and can move copied_seq beyond
rcv_nxt, causing subsequent native TCP reads to fail.

The following sequence reproduces the corruption:

  1. TCP receives a 200-byte segment; skb sits on sk_receive_queue.
  2. Userspace reads 50 bytes //copied_seq = 50, rcv_nxt = 200
  3. Socket is inserted into a sockmap with an SK_DROP verdict.
  4. A 1-byte segment arrives and tcp_try_coalesce() merges it with the
     existing skb. //skb->len = 201, copied_seq = 50, rcv_nxt = 201
  5. The verdict path calls tcp_eat_skb(), which does:

       copied_seq += skb->len; // copied_seq = 251, rcv_nxt = 201

     This counts the 50 already-read bytes again.
  6. After removing the socket from the map, native receive triggers the
     sequence warning:

       TCP recvmsg seq # bug 2: copied AA28C633, seq AA28C601,
           rcvnxt AA28C602, fl 40
       WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked+0x45e/0x9f0

Fix tcp_eat_skb() to advance copied_seq to the skb TCP end sequence and
pass only the distance from the old copied_seq to end_seq to
__tcp_cleanup_rbuf().

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Reported-by: syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/ipv4/tcp_bpf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..d640f8e06529 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -15,7 +15,7 @@
 void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tcp;
-	int copied;
+	u32 end_seq, delta;
 
 	if (!skb || !skb->len || !sk_is_tcp(sk))
 		return;
@@ -24,10 +24,11 @@ void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 		return;
 
 	tcp = tcp_sk(sk);
-	copied = tcp->copied_seq + skb->len;
-	WRITE_ONCE(tcp->copied_seq, copied);
+	end_seq = TCP_SKB_CB(skb)->end_seq;
+	delta = end_seq - tcp->copied_seq;
+	WRITE_ONCE(tcp->copied_seq, end_seq);
 	tcp_rcv_space_adjust(sk);
-	__tcp_cleanup_rbuf(sk, skb->len);
+	__tcp_cleanup_rbuf(sk, delta);
 }
 
 static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
-- 
2.43.0


