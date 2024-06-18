Return-Path: <netdev+bounces-104373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A490C539
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07C4B20B4B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29889156F29;
	Tue, 18 Jun 2024 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aF0ybsnW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V1tddVWU"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71338156878;
	Tue, 18 Jun 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695539; cv=none; b=Gmpw/QcxNgB4hkBQUjPiT3rE1ui6yZURmtAkx4v8nwqRVizRfqIg94YBklRpIj2F8XP2aiMX7s460JOvMP7RNsIFlfxb6B9ZcXQGyLbqskU4++1+hyJWgIt/5NnxZQzqMIDxdeW2ir1Y82mb68wYu/uh7R0h/WWTi44iQRAAAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695539; c=relaxed/simple;
	bh=3nOCXH40kHfZO87SmAo125DaEM6dygak/4wmXIHT9LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvmAHOcSKdl2GJRPI+pRkj8MyeV9HxCSgMr+ANV3/3N5HlVIBCr9L/RVZG4VR3HKxtbM8VNXBwYogYwhL0umoLFFWJUZWnQYAHKZmqsZoZGKOjbYJH0eZw16yhbu9eZbonFomEr6lcLGSNM+hJC7e5nHmRoZbM5TbGjuhM0xZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aF0ybsnW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V1tddVWU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718695532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6ZJx97XD1+mNbkUbduQBaAsweYRZijjNDkdfe4a/D8=;
	b=aF0ybsnWTEcK6NbLNKE6h4Rp6gDQKVDbtuBX2+p2/5V/UyyEwhFBJLadx2hCqC9EKDRoxs
	iV9oM43Gz9eRC9XVABOhU8lhvtkAYNyRQz1OlcdspmP9pFDCXIaUFLZ8aBIgxv73IOPyRY
	7XtxH8YZahoZ+PaGySr68AGI/z/DeD+vqg98vIVq2wH4b1bkW7ALqWMi2DjxnDl07v8kEx
	6Zx0nGAMbheKXGZWNjsvo4r8St5l0apGfGeHs5MrFWZDPTfIgBuvYDN78obXhF/P+lFMTE
	rPhdHU9Nm4koopsZCJ4K3aX7A5TPTa4OMc2o0tpLG4l6xLAkiLQW5jmMpk75EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718695532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6ZJx97XD1+mNbkUbduQBaAsweYRZijjNDkdfe4a/D8=;
	b=V1tddVWU1sNSTuhJrAyjMY53PjqHLkDpfVSfYlKyTyKqxHKmCSrO3xNjdTzYmqh9Gf65bT
	VQTXCPmN8yIACiCg==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v7 net-next 05/15] net/tcp_sigpool: Use nested-BH locking for sigpool_scratch.
Date: Tue, 18 Jun 2024 09:13:21 +0200
Message-ID: <20240618072526.379909-6-bigeasy@linutronix.de>
In-Reply-To: <20240618072526.379909-1-bigeasy@linutronix.de>
References: <20240618072526.379909-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sigpool_scratch is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Make a struct with a pad member (original sigpool_scratch) and a
local_lock_t and use local_lock_nested_bh() for locking. This change
adds only lockdep coverage and does not alter the functional behaviour
for !PREEMPT_RT.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/ipv4/tcp_sigpool.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
index 8512cb09ebc09..d8a4f192873a2 100644
--- a/net/ipv4/tcp_sigpool.c
+++ b/net/ipv4/tcp_sigpool.c
@@ -10,7 +10,14 @@
 #include <net/tcp.h>
=20
 static size_t __scratch_size;
-static DEFINE_PER_CPU(void __rcu *, sigpool_scratch);
+struct sigpool_scratch {
+	local_lock_t bh_lock;
+	void __rcu *pad;
+};
+
+static DEFINE_PER_CPU(struct sigpool_scratch, sigpool_scratch) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 struct sigpool_entry {
 	struct crypto_ahash	*hash;
@@ -72,7 +79,7 @@ static int sigpool_reserve_scratch(size_t size)
 			break;
 		}
=20
-		old_scratch =3D rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
+		old_scratch =3D rcu_replace_pointer(per_cpu(sigpool_scratch.pad, cpu),
 					scratch, lockdep_is_held(&cpool_mutex));
 		if (!cpu_online(cpu) || !old_scratch) {
 			kfree(old_scratch);
@@ -93,7 +100,7 @@ static void sigpool_scratch_free(void)
 	int cpu;
=20
 	for_each_possible_cpu(cpu)
-		kfree(rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
+		kfree(rcu_replace_pointer(per_cpu(sigpool_scratch.pad, cpu),
 					  NULL, lockdep_is_held(&cpool_mutex)));
 	__scratch_size =3D 0;
 }
@@ -277,7 +284,8 @@ int tcp_sigpool_start(unsigned int id, struct tcp_sigpo=
ol *c) __cond_acquires(RC
 	/* Pairs with tcp_sigpool_reserve_scratch(), scratch area is
 	 * valid (allocated) until tcp_sigpool_end().
 	 */
-	c->scratch =3D rcu_dereference_bh(*this_cpu_ptr(&sigpool_scratch));
+	local_lock_nested_bh(&sigpool_scratch.bh_lock);
+	c->scratch =3D rcu_dereference_bh(*this_cpu_ptr(&sigpool_scratch.pad));
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tcp_sigpool_start);
@@ -286,6 +294,7 @@ void tcp_sigpool_end(struct tcp_sigpool *c) __releases(=
RCU_BH)
 {
 	struct crypto_ahash *hash =3D crypto_ahash_reqtfm(c->req);
=20
+	local_unlock_nested_bh(&sigpool_scratch.bh_lock);
 	rcu_read_unlock_bh();
 	ahash_request_free(c->req);
 	crypto_free_ahash(hash);
--=20
2.45.2


