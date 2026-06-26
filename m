Return-Path: <netdev+bounces-302128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j++wINU+Pmo7CAkAu9opvQ
	(envelope-from <netdev+bounces-302128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:56:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 285426CB829
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:56:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=k8q13b5b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302128-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302128-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12CA33016D3A
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F473E7179;
	Fri, 26 Jun 2026 08:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B13E3160
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 08:56:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464205; cv=none; b=kHIXGjVUGDLl8PQavTXY8BALL9qrWb/DxGZQdQ/1JMkDhrBc6E7P+ONND/uzrNdty83TPCtBCRpE+oEm3jorIPHhOf6zwaFGfAZxUYqhZGVZS31u30p0cIgLvaohMLJFTXOgulzRW2NST2kJOrFBcEo/KCsK5UTpUqQFsV6F+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464205; c=relaxed/simple;
	bh=1aXJGRbVoYKOn4u0DgdN8Q+n5LU9ZhzbykXuBdXCH40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8MaW3s4aOBjOo6Bc8jcln9/C8Aef6Aih9tds2hIb4UN4vVH+iXsjckar0W3t94jbrDFe9FhTYHHqClRoJJ3RWw/1CpyaMPv26MgpsJ2lD+2ceLJw6iRK3A6X4s8Y8w5R4rxdkPHlJ//eIOAcuvcBSou3U1/PIJ0/vTe5GWAyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8q13b5b; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37d4ab2e7c5so480703a91.2
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782464203; x=1783069003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71FI73VI21O1fNx/zNQGP47ZU6D3Tij4DI4glfvr49s=;
        b=k8q13b5bB9Q1E9rCDWAS3XdVpNoh5b6iDUgKpLcNWPv+TKy0HzK/8NIWuCKm8C6d6B
         Fg8Qktp/8DDFZ1e2taxoVIZ9vcPFNxFB9BsIEKXctO0nQH3w1bxypX4H84Vwqjo9KoKd
         RNrHFu9kTDhba5B+s2M5q1jPKSxkA5oD7A7AFYMn+hYzay4Bngscoew26QcQ0HGvIDRv
         +8kiRp8k+sVPxJJKdafOD0EtZFuThnkfrGxY1vMbOPvwcS7mVQOfW3uAaXRad3nSNtyY
         fhyhHRNIw6jiJD3EHktl/T77SV31OPL9B33t2USd1sBXQukWsGR4fdkZ23xaoEuG0rm1
         /bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782464203; x=1783069003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71FI73VI21O1fNx/zNQGP47ZU6D3Tij4DI4glfvr49s=;
        b=Ov3hoVBVZ2/u21OKVrnOwX97tAG2gHB/27KHCMPUXVw7HegW5kQlVhPlgJIPFA6ztu
         6NCGc8jNWb6aIHwcgmtxcVaGwUVYxLgmRz7O8PtoYYsc8HYFbIWJcKO/hzy8o47MX8X+
         iIm37PGXmUrybD1mEbO3L5BXg6+wubTXyMvUPEKt3QUPENUQocsA9ozTi3igwVFLApQM
         ZkpfWwGEgEknFbxHALMID2DccPieQYZ1OcLDdyfeyeHfb/FXZJHOsgXgIHX54bYx8WuF
         0WGf0N9eQsDiM5o/oyX5WEG+LEUq0Zf1kfoe0J2H7DarJswLNVqq65on6/6FG4vBzcE8
         HBYw==
X-Forwarded-Encrypted: i=1; AHgh+Rq44hAQmBq0X5pE3+uAkAPj4ZJpBSz1Cwiaq2bfB0d9ytkQjNmvwYEioz1oIDiyB1sWek8NwiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznp5xWSuazCkoxDguBYHq2DhtlAzagCjRLaEJXJYKbHwPPpp7o
	3lDppf0uliVWTmo/l1hVWogJE5m3Vk3WUIAIW/k0XlXeSKrH5oQeCg8C
X-Gm-Gg: AfdE7cnEsmcu9K76D8ANLI8diz6i97ZO8Cp04OrYe5Zi5seyCRm3ADFgNkCdh8vkgxr
	BhYH7m631Nps+Wp0ktPK+YdVhnm7EvZXm9gpVAmL0/tglyRM1XoPo/9MQRS/HsrvH7ZUeWl5gwC
	hd7zQyl0Q+p7uE3+LLuqv4HaWIRkhN+ND22AvC6UFmShYWzb5fDt95xV4lScmn9lnFmW4Wbursy
	09THPpewuZZ2h22vHvt5gxlUjIX+OkLkwQnSww2RZq9SXGdn6K1ZaBOwQHXSKtZ7N1sCBAuJEte
	9Q3qlU3IdSRFAIlgubeXy0uAkwujilwZ4kGkCk0JBF409WTcvWGjHH4koT/JEWN2KxR+KHcJDYH
	dwsGlXKHolA2419XaWqumHPEJuQoqeJbj1k9tFqC2efNUPXA9Y+QfCKp8B6IcuBk3S8IXiyzWce
	b7qFM2VxWwjwodpfdmm2AOdV02CdO1wYlw+fWjRg==
X-Received: by 2002:a17:90b:3a47:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-37dfa235cbamr5609647a91.19.1782464202811;
        Fri, 26 Jun 2026 01:56:42 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e1c93272fsm418179a91.14.2026.06.26.01.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:56:42 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhangqi@xiaomi.com,
	baohua@kernel.org,
	zhangpengfei16@xiaomi.com,
	Pengfei Zhang <zhangfeionline@gmail.com>
Subject: [PATCH net-next] ipv4: fib: fix route re-dump in inet_dump_fib() on multi-batch dump
Date: Fri, 26 Jun 2026 16:56:36 +0800
Message-Id: <20260626085636.1524451-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,xiaomi.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302128-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenzhangqi@xiaomi.com,m:baohua@kernel.org,m:zhangpengfei16@xiaomi.com,m:zhangfeionline@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zhangfeionline@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangfeionline@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 285426CB829

inet_dump_fib() saves its progress in cb->args[1] as a positional
index within the current hash chain.  Between batches, a concurrent
fib_new_table() can insert a new table at the chain head, shifting
all existing entries.  On resume the saved index lands on a different
table, causing already-dumped tables to be re-dumped and the
originally suspended table to restart from the beginning.

Fix by storing tb->tb_id in cb->args[1] instead of a positional
index, mirroring the fix applied to inet6_dump_fib().

Fixes: 1b43af5480c3 ("[IPV6]: Increase number of possible routing tables to 2^32")
Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
Consider a hash slot containing two tables [A(pos=0), B(pos=1)] where
B is large enough to require multiple batches.  On the first batch, B
suspends mid-walk and the loop saves:

  cb->args[1] = e;   /* e=1, position of B in the chain */

The lock is then released.  At this point a concurrent fib_new_table()
inserts table C at the chain head via hlist_add_head_rcu(), making the
chain [C(pos=0), A(pos=1), B(pos=2)].

On the next batch, inet_dump_fib() resumes with s_e=1 and iterates:

  s_e = cb->args[1];   /* s_e = 1 */
  hlist_for_each_entry_rcu(tb, head, tb_hlist) {
      if (e < s_e)     /* skip C at pos=0 */
          goto next;
      /* e=1: tb now points to A, not B */
      if (dumped)
          memset(...);  /* resets B's suspended progress */
      fib_table_dump(tb, ...);   /* re-dumps A from scratch */
      dumped = 1;
      /* e=2: tb now points to B */
      fib_table_dump(tb, ...);   /* re-dumps B from beginning */
  }

Routes from A are dumped twice, and the portion of B that was already
dumped in the first batch is dumped again.

 net/ipv4/fib_frontend.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 42212970d..65fa245af 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1019,10 +1019,11 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 		.dump_routes = true,
 		.dump_exceptions = true,
 	};
-	unsigned int e = 0, s_e, h, s_h;
 	struct hlist_head *head;
 	int dumped = 0, err = 0;
+	unsigned int h, s_h;
 	struct fib_table *tb;
+	u32 s_id;
 
 	rcu_read_lock();
 	if (cb->strict_check) {
@@ -1054,29 +1055,28 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	s_h = cb->args[0];
-	s_e = cb->args[1];
+	s_id = cb->args[1];
 
 	err = 0;
-	for (h = s_h; h < FIB_TABLE_HASHSZ; h++, s_e = 0) {
-		e = 0;
+	for (h = s_h; h < FIB_TABLE_HASHSZ; h++, s_id = 0) {
 		head = &net->ipv4.fib_table_hash[h];
 		hlist_for_each_entry_rcu(tb, head, tb_hlist) {
-			if (e < s_e)
-				goto next;
+			if (s_id && tb->tb_id != s_id)
+				continue;
+
+			s_id = 0;
 			if (dumped)
 				memset(&cb->args[2], 0, sizeof(cb->args) -
 						 2 * sizeof(cb->args[0]));
+			cb->args[1] = tb->tb_id;
 			err = fib_table_dump(tb, skb, cb, &filter);
 			if (err < 0)
 				goto out;
 			dumped = 1;
-next:
-			e++;
 		}
 	}
 out:
 
-	cb->args[1] = e;
 	cb->args[0] = h;
 
 unlock:
-- 
2.34.1


