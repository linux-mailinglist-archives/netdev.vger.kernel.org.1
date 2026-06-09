Return-Path: <netdev+bounces-297024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SWUZCgP6J2pB6gIAu9opvQ
	(envelope-from <netdev+bounces-297024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:33:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938065F874
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CNom5odz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297024-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297024-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E267303F735
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5BB3FE650;
	Tue,  9 Jun 2026 11:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB042EEE99
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 11:23:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004212; cv=none; b=MOlClAJ0kJpIyngjFnAGqj6e04woMeSiOGWFityewyeAEYBuRTxqAq4frJdsE35AqfTLXi32u6/140THD49cOMR5kfkDOz2ciHXd9TfoQdvWXLG2VdHB2oYlXeUfL+FV8kUkzgq8YdUeXctY7GXtax+nCY2x40qFTYN0c2du8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004212; c=relaxed/simple;
	bh=P4XGoRQ5BTryg0GgBlPYvMJjZgaDdzAwmxXZAWkJolA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUQaHkG2tSMJgIfc4XIdRWsSxosm1ZJluD2EkObNsHeyOylZU7D/npLJMW3Ez8xamiMF2Z3mV3VhRlRaXIN9Y6qOm0ODfF8vNgRbxrT9sZx+qNqISzc/3ogFfWf8cJSnHHbD3jN9G8dZ+mj4tVg4b3AcXRpH5ap6561ZTwUWfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNom5odz; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2a68d01so36739855ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781004211; x=1781609011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kk/KQ6BJWiQwzMAsi31u8EPjaiQOWvIKGyuiY9ezidI=;
        b=CNom5odz3fE7e6Jj4svbf81T5VRgXoNRKs+LDwHjmJr7UucLriuJSreP0Z1rKaCH11
         tPv4WFy86coLOeaGJMuPXugf33TKxc51Qjp1tlfGuT3Nc5Sua5Dknd4473wwGmg3X258
         VNbBJ/s4T+hmQ81b8M3n8j8AaIq2BdT0C1L+ctfXMcIOmGqVVI0grrRDNGDmVNuyYdHM
         kvQhuTFJgaZknEBG9FqDxS4ojwbT+qkslm2QskHF7jY5oKtfnG10Fd2LkU4vlWlx+a2Z
         aAWrVxoxMqzGTPoItzKYo3teshoyYdQyyN0SkKAfSn3Ahn3pxwCSRSGCP193eF2QREx5
         Atzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781004211; x=1781609011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk/KQ6BJWiQwzMAsi31u8EPjaiQOWvIKGyuiY9ezidI=;
        b=eh8H5y7002I2igg3mSdfLs9ZhouGoOixC5wrX7orW16zFOxru2JdeKD9iRRLx3yXEs
         qMSmZkPJEDcbUO0vh3CPXeqlyHNcGNrjv3ZlethNyn51NuVuK7KUFM3ASewRXWl00Wmv
         1sPngUDvXk17sko/hvblVVaI8AjvA82aQT5hCnC6uL1Pq/za1OMpNDv1NXX96jnKZv3k
         tnWuGd46MlJMg5CcBuAFLH4m72PRF9iahtO/JS+GgKVV9tT2mfadWi3qBvXZTbM4kYvL
         N6kiAjepOpo4TmRhikOp/ljKZxgDbnDd0O1TER1eIFPs2kyiD6AlTAc1MI/1ccFk/Tol
         j1gg==
X-Forwarded-Encrypted: i=1; AFNElJ+DuDm7StlHBTu9Jbhgza9I43w2uKtCOU6hM/FvrJDdoLJ52k9n4KacpUGgN4lzKAPx8PFM4Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRo25WnBxaq6SXFuOetwUuT+96BfVH9rXl9DihtnmXg27nx9/
	bR+GqvJ2KnxyNeic/0bh7lxerGrjYQ4vIuJv0jQ5S8i8YEv7J+JVoREY
X-Gm-Gg: Acq92OEuKp1l2ThhdbRDzFVGQYNLAuECZjGc7SpdVbZ9fl1eRP0a7/AkVz4Jg+NKPW6
	GUKaETfG1iWrAt9bQNZah5vCZoC8QCPVcMuq16uYBvGIzcWeHMHcoyPZez2T93VUEzCET1dzQxS
	EYz3eeUBaKOwwq5TxXw9oeGlI6LYFnNT8i16K7ryc9HK0EGBic9w8gqeGZlhLRY/kXt4ZrOm9wU
	yBowMbpDLwVaRuZB3IMo/ipoi21WG9hb56OT+JLEEN/RF3tYf1rznR73QT65k65ncXMnb58bFSR
	6BNhUPceOclBWF9vm0tJJi7inRmZ1F9iLZ2S163wcUegyPZC/SxI2DYQ9GAZ8yDhGwrMxTURu/F
	rwciz3KD2nUE2Lkgr2dZl9FMq/zq1SPPyaKtSSQnRQZEdAZjpMx9AQigptKReQOrMTOO20jiBOj
	gWRO32DoXmkIxpRtkHA9ewuy//M+5bWI+80HSHeupKjQO/HwoK4BuIR5pZlo7jBLrZzvaxB63B
X-Received: by 2002:a17:903:2342:b0:2bf:1486:e6ca with SMTP id d9443c01a7336-2c1e7d41eb6mr213499545ad.12.1781004210540;
        Tue, 09 Jun 2026 04:23:30 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ab01sm202528565ad.71.2026.06.09.04.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:23:30 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: fix use-after-free when the stream parser resizes the skb
Date: Tue,  9 Jun 2026 11:23:03 +0000
Message-ID: <20260609112316.3685738-1-rhkrqnwk98@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297024-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8938065F874

sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program to
find the length of the next message. strparser assembles a message out of
several received skbs by chaining them onto the head's frag_list and recording
where to append the next one in strp->skb_nextp:

	*strp->skb_nextp = skb;
	strp->skb_nextp = &skb->next;

and then calls the parser on the head:

	len = (*strp->cb.parse_msg)(strp, head);

The parser is only meant to inspect the skb, but the program may call
bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB. Once the
head carries a frag_list these go

	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail

and __pskb_pull_tail() frees the frag_list skbs that strparser still tracks
through skb_nextp:

	while ((list = skb_shinfo(skb)->frag_list) != insp) {
		skb_shinfo(skb)->frag_list = list->next;
		consume_skb(list);
	}

strp->skb_nextp now points into a freed sk_buff. The next segment of the same
message arrives in __strp_recv(), which links it with *strp->skb_nextp = skb,
an 8-byte write into the freed skb. The free and the write happen in different
__strp_recv() calls, so the message has to span at least three segments before
it triggers.

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

The same resize also leaves the head's length inconsistent with its frags, so
a later __pskb_pull_tail() can instead hit the BUG_ON(skb_copy_bits(...)) in
net/core/skbuff.c.

Run the parser on a private clone of the head whenever the message spans more
than one skb, so a resizing helper can only touch the clone and strparser's
head and skb_nextp stay valid. Single-skb messages have no frag_list and are
still parsed in place.

Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/skmsg.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..d5b10f9b0ba8 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1146,14 +1146,30 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 	struct bpf_prog *prog;
 	int ret = skb->len;
 
-	rcu_read_lock();
+	guard(rcu)();
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
+		 * strparser still tracks.  Run the program on a clone when a
+		 * frag_list is present so it cannot drop frags strparser owns.
+		 */
+		if (skb_has_frag_list(skb)) {
+			parse_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!parse_skb)
+				return -ENOMEM;
+		}
+		parse_skb->sk = psock->sk;
+		ret = bpf_prog_run_pin_on_cpu(prog, parse_skb);
+		parse_skb->sk = NULL;
+		if (parse_skb != skb)
+			kfree_skb(parse_skb);
 	}
-	rcu_read_unlock();
 	return ret;
 }
 
-- 
2.43.0


