Return-Path: <netdev+bounces-99127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537538D3C70
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B99F285181
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C2187322;
	Wed, 29 May 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dk0BWoov";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NEj0N+0B"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B01836FA;
	Wed, 29 May 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000176; cv=none; b=QNdZ4D+10hewKXYoFhAnefOaOULoGiOcpH0xpVYWXFuu28+x50cdjcc57gub5aeeLHNXPyaQ4B3LtgjifCKiWEhf5JxekiIXfqS/KGmNlqaD7xH8/0Zqs1aKKqhtySdyE+jYwMNTn5/++NLnXgiayEEgLCmTTy+mNjOn6fNA37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000176; c=relaxed/simple;
	bh=G+S7nMnQYP8Ub6wdwc/QdbVXpNg4qAepSUVQBtIndoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBshXa5jfK5M0KyDzyF8E2cNK/aqCHN29udPiZkSk78DQfYY8YKVv5KHPpUQBHrV+Lu82WngljMf5YvNuRZM348rTjGqXWb7PDxflConl/v2SHGq9D4nxVn8JWUOYvgUk0htcQ00ZIvXV5nVg3ySRaolArwThR8zXlaOfPdWtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dk0BWoov; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NEj0N+0B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717000174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jc9kVwpT1wazRgJL8VSyOnTf3zyLearQK1DZf1xb140=;
	b=Dk0BWoovK+FpV54pmBGACB8AmNa5pe/eujAl0iaJ5Fy50p9vvM4RgKShZ4h9MCK0aYVoXf
	pQtoc6lc+CO7f3crh/21niZif/nzG4rTxCCJEuM1hxeNkXDfeoBO5kzszaMwPzOReN/VHg
	ZftMLnCGnLkiO0GRQ1ouLthZiWhP0ivzCrtc5rQe8fIRihuqGbK47qQw4JMn3k2bYdSrZ4
	6qHMz6bhie5MZsQkWfRNm+SZpbjTxj3sT+lsW0Q89MsCxA62m/VeozUdP4+Vyqde1doxfs
	dRHIE20cnD6sb5Cw+mRJBleFWKfqZ9lNWj9y1cpwB0IPN5KmY2HMPnz1+8/M4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717000174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jc9kVwpT1wazRgJL8VSyOnTf3zyLearQK1DZf1xb140=;
	b=NEj0N+0BSnqs/GIeGiWZnSN/X3bIWhgCTy5fySHs/Y87oFKsb0I9N9iFLMYWcAgHhLKHw2
	EokxrCwUL2p7kECg==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 net-next 03/15] net: Use __napi_alloc_frag_align() instead of open coding it.
Date: Wed, 29 May 2024 18:02:26 +0200
Message-ID: <20240529162927.403425-4-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-1-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The else condition within __netdev_alloc_frag_align() is an open coded
__napi_alloc_frag_align().

Use __napi_alloc_frag_align() instead of open coding it.
Move fragsz assignment before page_frag_alloc_align() invocation because
__napi_alloc_frag_align() also contains this statement.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/skbuff.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e6..dda13fdffb697 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -318,19 +318,15 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, =
unsigned int align_mask)
 {
 	void *data;
=20
-	fragsz =3D SKB_DATA_ALIGN(fragsz);
 	if (in_hardirq() || irqs_disabled()) {
 		struct page_frag_cache *nc =3D this_cpu_ptr(&netdev_alloc_cache);
=20
+		fragsz =3D SKB_DATA_ALIGN(fragsz);
 		data =3D __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC,
 					       align_mask);
 	} else {
-		struct napi_alloc_cache *nc;
-
 		local_bh_disable();
-		nc =3D this_cpu_ptr(&napi_alloc_cache);
-		data =3D __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
-					       align_mask);
+		data =3D __napi_alloc_frag_align(fragsz, align_mask);
 		local_bh_enable();
 	}
 	return data;
--=20
2.45.1


