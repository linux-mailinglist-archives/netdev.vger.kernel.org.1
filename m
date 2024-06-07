Return-Path: <netdev+bounces-101671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871918FFC91
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8081F2876D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0CC15359B;
	Fri,  7 Jun 2024 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GxLmm8pM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Yav37B/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980491514DB;
	Fri,  7 Jun 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743875; cv=none; b=Zjns3PoRPVrr6eXZEwFLzB1/v1cC64f/4HR6kz4Ge8llAf9Ko5WtI8Sc9Oat13z9LpGg/VARnrNTurTVZAK3YkBH34vsdhcyx75tSQhQqDR4pXT/hZdF3lMUfgxl9LsXdoUNh+DeEcHgewpdiJEtigwsnpEHDrhjwGJP1u60rCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743875; c=relaxed/simple;
	bh=bghL6tgmgkRzlloyIs229ULAO8wmcKFlVMxXqGEhuGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Szq6W7TInXnWkxEB6N4RxkFmk3Ftddl+svBeT8qmQp+rIP11Mrg3V7vzIstx7nvzRG0tB2QBlNr3PGTqnP1SUWL9l70jr6lCbuNDqw80WePgby6h2+MOWe9eE/PhImpi6yI2ZU6wa0rFfUqgX6wTWwKCG5yXDlXJ6V8BJqwwW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GxLmm8pM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Yav37B/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717743871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjDH1aZopl/PB/1qPdF+A5rutVmzd0668ZVYnzeXpm0=;
	b=GxLmm8pMqT04ERbIr7QYyPWYHWkaN+Ps8YD+X5map6/iWF63LNrJaiHPCYiBPGWqxdO/ST
	aORsRoHWEU/KMc9LURfe5jKHAZsGbYceYkUlS6PQguC91URSRc6/TVB1Yo96EKT4/FKgLk
	2Urnlu1gxTcLEx5LZddxTBdto4ZzJa5VXsEFzuo53I3OXOLXfdoqoDe3f/aGWvGX9t+5hK
	zl2RagcWCiKGkFzIRMWEidrTqsolNhJ18FWLeWJXx8wNfmrrJQZ2JsEFA5g4DqstXwPiK7
	T0y/Y2AdTBK6ZnaNXkcv79EjxvaKJ+iZJpIDAoS2hxV2zgDMEHlJeaa+Lyuv4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717743871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjDH1aZopl/PB/1qPdF+A5rutVmzd0668ZVYnzeXpm0=;
	b=5Yav37B/hUrqo058W69ZgD++27hYvtYBBGNCMmo2XnLj9LMopcubS8xbc51s8JmELVx9cE
	BT3ofKjE3pJx4AAw==
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
Subject: [PATCH v5 net-next 03/15] net: Use __napi_alloc_frag_align() instead of open coding it.
Date: Fri,  7 Jun 2024 08:53:06 +0200
Message-ID: <20240607070427.1379327-4-bigeasy@linutronix.de>
In-Reply-To: <20240607070427.1379327-1-bigeasy@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
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
2.45.1


