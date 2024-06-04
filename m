Return-Path: <netdev+bounces-100649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565B8FB7BE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFB81F22439
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91B1482E7;
	Tue,  4 Jun 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dAnI/ccw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fn8U+lPB"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DB1448CB;
	Tue,  4 Jun 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515891; cv=none; b=HjEsoe/SraypHGTSdtv9NMDfWind24D8wh97+/FZOfCIn08YjLf1T1HbV/eP8NcIL0rbXFM4IQk2Dw+VrD1aaDDTfGQBZMTaqga6CH271tpSLQiSKn5gy32OCRKoY+78nkjW56TTGNNPljfFZpTkiuh3OF83ou67YLuYzgBDx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515891; c=relaxed/simple;
	bh=+x9DQd7KqwkYQ1bgShD+qKWpEAz5ME5eTGkkafsEoWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUQJoKSiqRlAejm3RcQVaTbblKZuKapCeNEhrdSPb4b+/0ODQviVhBJyZtYseQIKz6NCUr2t2Ouahuu0G97QsyBB5rKSz/sL79jpcm2ownhINUpDaKM5XQL/gPD2JKAJwcdfsji0Lv2+ROkyPEAEkQ9Ojbn5sWxg5EeoMeW25SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dAnI/ccw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fn8U+lPB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717515888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJeYTIv57cozwpPfPkR5Rxm28jZwxXFq0rv+rRq51Co=;
	b=dAnI/ccwdG4/BdnPrwDrKy9n0vA7o2UTzfgvrA/anVwHQx3fIeyotnx6Klwj+JyhsiQkZJ
	nBWUyxttoRmvZGcgV1btKexspmk6mrnbL13jMBVBxJ2lLGf6QXekmb+QyJ2zFPp5PPTWgs
	NW8TOe/OkRuAh//SY/bhbGOskT5/6xN4Qtaml/xa+C0Jl/55Ym+FWZ1I0cHuyJ/fynknWu
	MauhLEI0358Y/spg2EUcxw4AAwGxCG+01CF3VSoQE4dnTMRdFmeA35/poh25dEt26fbFg4
	v6/kYTgvjbFRFikE1yvCZJtxvk0BMQpLa5i+qrJ7OMTyJFTWBfBV991rDzx3CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717515888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJeYTIv57cozwpPfPkR5Rxm28jZwxXFq0rv+rRq51Co=;
	b=Fn8U+lPBxTLM1Hieo8iT9d80vGw/P01MH2LxDxO/zI4YroqdPqPUgLheIFl4nNV7MZGmti
	COdWtCmGkKSeXXCA==
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
Subject: [PATCH v4 net-next 04/14] net/tcp_sigpool: Use nested-BH locking for sigpool_scratch.
Date: Tue,  4 Jun 2024 17:24:11 +0200
Message-ID: <20240604154425.878636-5-bigeasy@linutronix.de>
In-Reply-To: <20240604154425.878636-1-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
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
2.45.1


