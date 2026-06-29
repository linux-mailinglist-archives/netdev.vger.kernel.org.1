Return-Path: <netdev+bounces-302553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 65VPNjtCQmqX2wkAu9opvQ
	(envelope-from <netdev+bounces-302553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:00:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0606D88EE
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:00:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bCfx8ehP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302553-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302553-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 663923061D62
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5679A3B8409;
	Mon, 29 Jun 2026 09:51:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83EF3B6C1D
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:51:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726716; cv=none; b=CXDgHilutAa/Y0dm9IXlpJOMXjOU22cvcGDU317aZA+r4xE+QmKY92fmyssTz8BHSMahPol/2jBNIVNBPELFJUVkKOOdn9Oj0xP1lyyhoqHZWltiptK2ExQ/Hpauvz28w5OIgQxt8Hqib3/RYRidJ4M+T0wOdGTWU+sPnFHtbCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726716; c=relaxed/simple;
	bh=jT/07ZjnEljCDkg1Sui4v5JLloAdoehB4ms4+KILrac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoKKXVVF8Zz7Lr04shWbm9DpyMuzQoNsbzYWqqu491Kkd65rw3NODs81voLgr0fexdSKjWZEesCAqDOFVFud0gE0dVNWT23chopSqw+gVuDxmJ2HaZ//ZHESPbsQL+zd7p7OB9gu1vG2iESoy+RNe/+WdhJXfl6Bk/HeqR7qblk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCfx8ehP; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37cb36ca63bso1300738a91.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726714; x=1783331514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZntHgB1VK83jSGRR6wDqH2TYAXRNVfVNGYQkueQtUtc=;
        b=bCfx8ehPCTE0J0Qca0r+V0+q7TfDPfuak5II0H7mxn+smEAzEY+0pJvzq8I5eNkFF2
         1IzzHgjqF9JCYXPrNS2ZtkER/jwbBZe4wN68YCckYXt5mCu7tAepva9B5xak5nErdWz9
         cdFrAowT+PsxCf5WYoMUUMNTjlhVppRtUcqbVsqJ73b7U4Gfk8ZF8tJ/U/T6eX5uTiQn
         wjUYrB+pDM+Dx1T0XNwvcLmNBHYMN7CEYMR1eljfAs0n+B12E3whZzjxbRr5mdOvmrdp
         8TWzfW4X4DrsSGNgZsA3/Qta6OyNUZgp4MctoRqwLlMalP2Uyhi/gmjraCl6TLKKyd/7
         t9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726714; x=1783331514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZntHgB1VK83jSGRR6wDqH2TYAXRNVfVNGYQkueQtUtc=;
        b=fOMI1K0MK5wVgtCZHZycS6mEiTdGtk/AySvUQD1HXU0HV3dEX3BJXzlgeCk9uk5B+y
         t9KnkAAFRwwXqhec9DrRL2EHYCgiI6kVIjXF4cgK7U670EmC5Rc0NXw3h7+NQCDrE6X6
         X5218yFqJkVMN/gDwQc0aW+ifvDRRMnti9nRTo5QRhU/8EB4kgD+PNgExcCpGoWt4b/y
         3zpV7wzHkOINMjdYANOUk3cE8kQWxy2BPk9ONFa/rJcGGnHWaAQzmR46M2mdJVpYuup5
         dXp+kNStRTKykKLwuQB012iW12G00qRgEG97zvoX8NLuW/B1qk/nNy5ivfL5TSwtqQYz
         PHAg==
X-Forwarded-Encrypted: i=1; AHgh+RoFGEdkXpUzoMDHpC8pXICrXak+aPuRkBq2iKtT8FHykJ3iAHwwihE23Ivq+hSZ6fDIbvew1bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/HgzT8ih3Kv9HLNu3CfTXeo6wjk/19X9nWdt9CDVnLT3JhS0
	guCAmUqx1p26I37eRUkLC2wPqTojZ4vmmeAjepMdR2LTHbfsfqynvrKS
X-Gm-Gg: AfdE7ckS1NbmBRjX4dzE2ESYSwdGqu1KBfjXErzPCIfXRRULwoO27owSAZ58e/dNoD7
	xRymdhwNGd8UsBQnvtKrSysaVcNZimBGNBWAHpT4TY7wKngvJzaJP3/E/BDLm0db2zR7+5BgGR1
	SCAdrihjrlnAXEmO73VNHxkneyWYI5zs+3YeUgne6ucHXEb++axgA/j4ltHrD3TosPGhUoqW3Uq
	W0A3Gw7owYRJMA6PJFwIMSg1MJoXyD1kI1dPqznscLBAXwhf6plohW5y3SssimfOsHcSDMX7k4i
	iDghaa69jHgfs6rwTRqZOLBgQEObmFuXXRWqoKWZeaxhj0IlaVxAKSGQIPuNSJOC1rSm9p68/5S
	3hmsH5Ty48lvVJDAoWcoru/7rr5G3ShV5rnPrHdrVGILWPJ6vp+OiFI3/+G1D5FxxGWenmAgXDD
	l/dnBGIhyCrXIGKuvWssRHJ6kwdCotHg5v2VivA0FZgapwVck59LM=
X-Received: by 2002:a17:90b:57cc:b0:37d:85cd:1367 with SMTP id 98e67ed59e1d1-37dfa2363cbmr14496003a91.15.1782726713861;
        Mon, 29 Jun 2026 02:51:53 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e1c93272fsm5550432a91.14.2026.06.29.02.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:51:53 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>,
	Ursula Braun <ubraun@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v3] net/smc: fix out-of-bounds read when sk_user_data holds a sk_psock
Date: Mon, 29 Jun 2026 09:51:33 +0000
Message-ID: <20260629095140.679754-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302553-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jiayuan.chen@linux.dev,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:ubraun@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B0606D88EE

A passive-open child inherits the listener's smc_clcsock_data_ready().
sk_clone_lock() clears its sk_user_data to NULL because the listener tagged
it SK_USER_DATA_NOCOPY. Until accept restores the callback, a BPF sock_ops
program can add the established child to a sockmap, and sk_psock_init()
installs a sk_psock into the NULL sk_user_data. The inherited callback then
reads it back through smc_clcsock_user_data(), which strips only NOCOPY,
takes the sk_psock for an smc_sock, and dereferences a clcsk_* field past
its end:

  BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
  Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
   <IRQ>
   smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
   tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
   tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
   tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
   [...]
   </IRQ>

  Allocated by task 67930:
   sk_psock_init+0x142/0x740 net/core/skmsg.c:766
   sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
   bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
   __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
   tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
   [...]

Resolve the conflict on the write path. Reserve the child's sk_user_data
with a NULL pointer tagged SK_USER_DATA_NOCOPY so sk_psock_init() returns
-EBUSY, and release it at accept. smc_clcsock_user_data() still strips the
tag to NULL, so the inherited callback stays a no-op.

Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v3:
 - reserve sk_user_data on the write path instead of the read-side check (D. Wythe)

v2:
 - https://lore.kernel.org/netdev/20260619150342.3626224-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/netdev/20260614120931.4041687-1-rhkrqnwk98@gmail.com/

 net/smc/af_smc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b5db69073e20..78f162344fe3 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -154,7 +154,11 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 					       own_req, opt_child_init);
 	/* child must not inherit smc or its ops */
 	if (child) {
-		rcu_assign_sk_user_data(child, NULL);
+		/* reserve sk_user_data so sockmap cannot claim the slot */
+		write_lock_bh(&child->sk_callback_lock);
+		__rcu_assign_sk_user_data_with_flags(child, NULL,
+						     SK_USER_DATA_NOCOPY);
+		write_unlock_bh(&child->sk_callback_lock);
 
 		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
 		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
@@ -1773,6 +1777,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	/* new clcsock has inherited the smc listen-specific sk_data_ready
 	 * function; switch it back to the original sk_data_ready function
 	 */
+	write_lock_bh(&new_clcsock->sk->sk_callback_lock);
 	new_clcsock->sk->sk_data_ready = lsmc->clcsk_data_ready;
 
 	/* if new clcsock has also inherited the fallback-specific callback
@@ -1786,6 +1791,9 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 		if (lsmc->clcsk_error_report)
 			new_clcsock->sk->sk_error_report = lsmc->clcsk_error_report;
 	}
+	/* release the slot reserved in smc_tcp_syn_recv_sock() */
+	rcu_assign_sk_user_data(new_clcsock->sk, NULL);
+	write_unlock_bh(&new_clcsock->sk->sk_callback_lock);
 
 	(*new_smc)->clcsock = new_clcsock;
 out:
-- 
2.43.0


