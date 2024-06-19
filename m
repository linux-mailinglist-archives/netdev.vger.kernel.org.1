Return-Path: <netdev+bounces-104754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E37890E449
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244CC1F22D1A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016C78276;
	Wed, 19 Jun 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tFLJgN4d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLXl8Dia"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D773770FA;
	Wed, 19 Jun 2024 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781804; cv=none; b=lpDSfnIcZdCjpb0AyjAsKJLH2bLVQdlVd2IhEnuJDbsOFeyNnjDuLjp2NOItlty7HE/IF6Gj8ugbuTNuoumpSnv/jD9nujQx9VTasJCGhyupYuO+QnCKMpMWy4/KlB89gbkvfDlmFOay+pOHHtmiqfNR6YyA7VVPP+slE2KZlhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781804; c=relaxed/simple;
	bh=9Lh6yED4JkBOgnEWhEg5MLGSkozpx3Dnb7sg4GUiXTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7FqqxxrYcTIJustO9ERUDaBUce5uf8t9cTfihVsFLZcheKJINRoA4R6zTIMPrxQS9Jk5q361QqaytBFplHQ+mGbut1TnzLMXmSJLGudzVmXpzxQSXFntNJpN4z3V+K64uJBCYuh1ZY5mSLhuD7o5it8fqhvx64tcZhW9EW7rZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tFLJgN4d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLXl8Dia; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718781801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEgrAQzPM3pCkJrAWGRjvGTANpNXKbEZYpnc+bTSS/w=;
	b=tFLJgN4dMeCPzkpu7pukDNsN8ZbPKwF+kNodfyHkSwlx5CNrnDErpqxZIe50y4f1j4q75U
	EBvdQK2zUUtCxFhMaTr6m/9lx436udosSXRlZiLg5OaawU+Yyc2Th2L7wKjRkBC/imi6b8
	F7ecRcpXQPNUfwJRGBgT9MpPV0rv6HO0iNLGoG7yDIWxY8rQBPrsnBcb8bPghMSN3SxHPW
	si2E3nuYh5E3dQZpen/ZJsTZGDfrM1X0W/tgHNx52L2DdKYednxKUc0WWtq9gaDm9KrnIu
	Yz5y1YQKLMknlXNm8UagpCGkFQ3l3ZTBiiFtaex7/HzgF9TQ2UuZnbth+oi2vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718781801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEgrAQzPM3pCkJrAWGRjvGTANpNXKbEZYpnc+bTSS/w=;
	b=sLXl8Dia9f3ciL/n27p94RrhwVmnz/Q+bMu58FdZgM+pqzaktvzZfIPt5hrRcLhlPobHbs
	Ov3ekf9CbCBRz5Dw==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v8 net-next 03/15] net: Use __napi_alloc_frag_align() instead of open coding it.
Date: Wed, 19 Jun 2024 09:16:54 +0200
Message-ID: <20240619072253.504963-4-bigeasy@linutronix.de>
In-Reply-To: <20240619072253.504963-1-bigeasy@linutronix.de>
References: <20240619072253.504963-1-bigeasy@linutronix.de>
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
index c8ac79851cd67..656b298255c5f 100644
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
2.45.2


