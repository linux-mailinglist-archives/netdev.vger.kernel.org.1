Return-Path: <netdev+bounces-298595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIrzGOzuK2r2HwQAu9opvQ
	(envelope-from <netdev+bounces-298595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:35:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA9678FE8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=b0EIjzFx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298595-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298595-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8DA03019C8B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37363C8708;
	Fri, 12 Jun 2026 11:35:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7701387574
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:35:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264103; cv=none; b=fSlvaGTj6S680LfTj1rqoOFs1vzrXY+FjlRTiKbJRkUeZB8vdi5BM3mSJMnL7pm46zsadRH6+1MVFAzMO2GxEH1ke3LwydNIKrldF58OqvUBNX2Ym96fqpQSr3fDsAEXmSROPHrUh1YMBhQYVzCXPQUKEbHoBsadbyny2wk0A18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264103; c=relaxed/simple;
	bh=v+a/0vxtzfg5vU/1AWu+LM9ezHbmg+SuWuOYwy+t/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkQNaAWy7MFHmENN5BxY/qKIt1/AK6Cs77USW9ysFQXrOvogjeDPMtJKBxhUHfHrT6NZRNXDrgh3R+pARFy0X8mCv1gL5e0Q9c8KXmcmKsgJmaYFIuAeHNYC8Ya06k0uzqqREvFz62bKKUeE2GcfgVNioznHPqcxB3uWGlJvC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0EIjzFx; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so545402a91.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264100; x=1781868900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZasNhzyut4yZ1h38+2iP2uzrqSBD3v2I7RBNB9rdm0=;
        b=b0EIjzFx+45gM/z452S9otOmVp0efEnS2H2SjMmV4Zt+HApgBf9SlxjJGjhCjDHJ+I
         kimR97ixZDDq+Ov4Wc//BcqWGC6S2LZCB4e5OVbl7u3htLuEYF+NHPnl9d8y5s7YNk+T
         SJceR39CZdSKCkwgywVtg8YOn7qg3QYhISqHhEqytcfY81lF0g2SfyYx6MyfP5vAcuPy
         o2KpqkdnMIWUgC4bz6sNvbsRk7vtE5BxkTigqj93BSmxE/CWrHCTKLh2GnxpHP86gc0P
         qoeB6JruaThYI+IjKQkKAznbCUzD3hBbYq6PwgrkJZ/zmLRLBWShQqPxJeei5sMD0+wT
         8FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264100; x=1781868900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZasNhzyut4yZ1h38+2iP2uzrqSBD3v2I7RBNB9rdm0=;
        b=VfeevzJmzh9ZvpEFJ5VDVHmX4fWtNT2beQh7dxdWvcHVGPveXu8+/1tdtrJhKOaY8s
         oUMnhWJU5lq76z+7pC8vZ1OoRvYImR/SYD3cSxAe/8/IH59f5q91tlPvH6JARcydDTVR
         by5ETQSmtnQe14TPrt3TAW8ktmTjmgkalyO4GDTE5sEU/Lgfl+mfDPys1b0cVQ1fU9Pg
         FIwZrdkUGSjm4sOhLX8qBjTR0/lSFMqJVgHNNeuCjbDJhfOhxcmRGqCe/iqg2yk8I1sR
         TTBGiB7/gSlxEGmCNB+sW/gGfh1IObNuWGJsFSoD3JOYrKwLNtnWUXBC8+PqXA4LSzB6
         vx1g==
X-Forwarded-Encrypted: i=1; AFNElJ8Z9PtHnVH2oWXKlgsRZPlxK5VXdxaQs6ZJA9TmKT4J8q+fPy6yAW7SJOOf6K+2GJjG0yqtwBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsz4XA0TJxr9rAL8tR4kUDBchEVP4acpGSSqtLg1RdHfiOhVSS
	DmDfayAX6KH2vwK9vNkUbopyFuPTsevRjWDuEECsSP2zdh+53/w42yW+
X-Gm-Gg: Acq92OFRaYGe5z8vz6IN/e8k3jYz2Zsvrvqw8Jf0qu4fAvffbgsxdSPbGCiLGL+A5vP
	LoW0deuiPNbDFZ2V+J3HC+d6IsCXcugD/Drc37S5bvNLbOnCnDrhkYZbrYbuzON+B1cQGSwJxBQ
	2hOMCvMNORp40uK0fnz0gYZtWHarsk2IdTXWS5ntNzoStYTMbmcXlDSr4GyN/Yx5SzQVgLyDaaS
	JrWgTGZYPi6+ICH7ifJJvcaW2/QUDZd4gWnG2aOXdxXAFVC3uWLqcsa88LT+oezJLYKv4uDN16q
	O+NjtFn+jf1VzzrKBj2l8uV0Ho0KB9e6NhD8/RtWE6eV7SvlZ8igBxjAVMNSjaD4su9YwuJ+Yo6
	ikE0mXKvswUODn3h90I8Cz2X/cuqNlBTmAVxdp9DkhFfJPcMEPzMsx4RcXO2jbU54JIwfC7iDJW
	70OBcwcYs4DPrEEKDrSOH3AdZBYXHV8ZsZY10Y5hm77LutibDDHNZQLT4JpqwVGg==
X-Received: by 2002:a17:90b:3a05:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-37a01845ec7mr2627752a91.4.1781264100039;
        Fri, 12 Jun 2026 04:35:00 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e7e217c0sm1543081a91.2.2026.06.12.04.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:34:59 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream parser resizes the skb
Date: Fri, 12 Jun 2026 11:34:26 +0000
Message-ID: <20260612113451.2697869-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298595-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDFA9678FE8

sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
to find the length of the next message. strparser assembles a message out
of several received skbs by chaining them onto the head's frag_list and
recording where to append the next one in strp->skb_nextp:

	*strp->skb_nextp = skb;
	strp->skb_nextp = &skb->next;

and then calls the parser on the head:

	len = (*strp->cb.parse_msg)(strp, head);

The parser is only meant to inspect the skb, but the program may call
bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
Once the head carries a frag_list these go

	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail

and __pskb_pull_tail() frees the frag_list skbs that strparser still
tracks through skb_nextp:

	while ((list = skb_shinfo(skb)->frag_list) != insp) {
		skb_shinfo(skb)->frag_list = list->next;
		consume_skb(list);
	}

strp->skb_nextp now points into a freed sk_buff. The next segment of
the same message arrives in __strp_recv(), which links it with
*strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
and the write happen in different __strp_recv() calls, so the message
has to span at least three segments before it triggers.

  BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
  Write of size 8 at addr ffff88810db86140 by task repro/349

  Call Trace:
   <IRQ>
   __strp_recv+0x447/0xda0
   __tcp_read_sock+0x13d/0x590
   tcp_bpf_strp_read_sock+0x195/0x320
   strp_data_ready+0x267/0x340
   sk_psock_strp_data_ready+0x1ce/0x350
   tcp_data_queue+0x1364/0x2fd0
   tcp_rcv_established+0xe07/0x1640
   [...]

  Allocated by task 349:
   skb_clone+0x17b/0x210
   __strp_recv+0x2c3/0xda0
   __tcp_read_sock+0x13d/0x590
   [...]

  Freed by task 349:
   kmem_cache_free+0x150/0x570
   __pskb_pull_tail+0x57b/0xc20
   skb_ensure_writable+0x236/0x260
   __bpf_skb_change_tail+0x1d4/0x590
   sk_skb_change_tail+0x2a/0x40
   bpf_prog_1b285dcd6c41373e+0x27/0x30
   bpf_prog_run_pin_on_cpu+0xf3/0x260
   sk_psock_strp_parse+0x118/0x1e0
   __strp_recv+0x4f6/0xda0
   [...]

The same resize also leaves the head's length inconsistent with its
frags, so a later __pskb_pull_tail() can instead hit the
BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.

Run the parser on a private clone of the head when the message spans more
than one skb and the program can modify the packet
(prog->aux->changes_pkt_data), so a resizing helper can only touch the
clone and strparser's head and skb_nextp stay valid. Single-skb messages
have no frag_list and read-only parsers cannot resize, so both are still
parsed in place. If the clone cannot be allocated, return 0 so the caller
retries on the next read rather than failing the parser.

Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - clone only when prog->aux->changes_pkt_data (Bobby Eshleman)
 - return 0 on clone failure instead of -ENOMEM (Bobby Eshleman)
 - free the clone with consume_skb() instead of kfree_skb()
 - drop the unrelated guard(rcu)() change (Bobby Eshleman)

v1:
 - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/

 net/core/skmsg.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..501e8cfc7505 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1149,9 +1149,28 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 	rcu_read_lock();
 	prog = READ_ONCE(psock->progs.stream_parser);
 	if (likely(prog)) {
-		skb->sk = psock->sk;
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
-		skb->sk = NULL;
+		struct sk_buff *parse_skb = skb;
+
+		/*
+		 * strparser chains the message skbs through skb->frag_list and
+		 * keeps a pointer into that list in strp->skb_nextp.  The parser
+		 * program may call bpf_skb_change_tail() and friends, which go
+		 * through __pskb_pull_tail() and free the frag_list skbs that
+		 * strparser still tracks.  Run the program on a clone when the head
+		 * has a frag_list and the program can modify the packet, so it
+		 * cannot drop frags strparser owns.
+		 */
+		if (skb_has_frag_list(skb) && prog->aux->changes_pkt_data) {
+			parse_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!parse_skb) {
+				rcu_read_unlock();
+				return 0;
+			}
+		}
+		parse_skb->sk = psock->sk;
+		ret = bpf_prog_run_pin_on_cpu(prog, parse_skb);
+		parse_skb->sk = NULL;
+		if (parse_skb != skb)
+			consume_skb(parse_skb);
 	}
 	rcu_read_unlock();
 	return ret;
-- 
2.43.0


