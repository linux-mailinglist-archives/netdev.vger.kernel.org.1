Return-Path: <netdev+bounces-105286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A79105F8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D7B254A4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ADB1AE09E;
	Thu, 20 Jun 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iu+BhHR+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viOBfUUz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F631AD4B2;
	Thu, 20 Jun 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890054; cv=none; b=jXOW72iwuqSFPIR9I3CZZUAbCXa6fL/gsWGmbZy9bHAMUt4sBZB5Z4BRwdC8NIdc1Fjn7TRZDJjowA4KAfflO8b54LmL7bssFREKPKa9KJ+o7Fv/dp8evAmvD6m8oa7BiqnURPE9l9ctVFS2YPhX40Rxaz/uPuG8SHH3BHBYzCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890054; c=relaxed/simple;
	bh=QtDo2HGf/L9ZrehLlTcmQLPQAAZesi1sG/KKDX+fAmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQH2yhNPXmowGRAb6kcnpfp+vx9c6SionuOcf6FvyQVfllgKfBnEpCcQ9gp4nWsWSrwDl7aRrV+HLzZ++zdY02K6lUczpA7DN3KfzxIb4XWqNrQa5C8hxO+HB+XrG6JACNV+AfscEdh4hig/h0z4Lf9beznDf1oiyxrSSjlExzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iu+BhHR+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viOBfUUz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718890050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfO9IgURCOa8OwNF0E1ITtjXLEOyfn4YupkCPqbnlWQ=;
	b=Iu+BhHR+exSVGuq/KMmF/Dbbc1HOfqaV3pDO2MeW2207Uxwq9mOl5qRJH/eEQmnz5fsMEO
	ouIJENjS5V2JTMx2s0wx6veaJ4+2qBZM84OnCsDzf0Mts+kAoiwxGvN//Sl4oLEq3oixPg
	CCVV4uKLfL2pRylXYub4EfAgGTsFVD5DwEI26eVrHeyqvU5B3S+zpCYhK7qz3SA9wXj879
	6Uii07zAGZM5tUbkshq3ENk8WJTKhRHdPkHdFliEZ7p24GmVWzj6+zauDbP6eddkC3bs3o
	7EnWVwZFr1EAMR27na7OIWMACflekUZKzGOdOdUl6abICPgj86ZEPxxrXEa7Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718890050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfO9IgURCOa8OwNF0E1ITtjXLEOyfn4YupkCPqbnlWQ=;
	b=viOBfUUz6Inq0vWV+pee4amjwEtJKZexqFS3ZUkr6dzWCjfn3aT1WRHBLAb9z+osGuz2n6
	s9A+l5gF0jJ4+ADw==
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
Subject: [PATCH v9 net-next 03/15] net: Use __napi_alloc_frag_align() instead of open coding it.
Date: Thu, 20 Jun 2024 15:21:53 +0200
Message-ID: <20240620132727.660738-4-bigeasy@linutronix.de>
In-Reply-To: <20240620132727.660738-1-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
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
index 2315c088e91d0..1b52f69ad05e2 100644
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


