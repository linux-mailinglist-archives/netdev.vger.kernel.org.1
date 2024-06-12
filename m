Return-Path: <netdev+bounces-102939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 924BC90596B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3251A1F2238C
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F12181317;
	Wed, 12 Jun 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dIY7CBjL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rVrWllcR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02B16C84F;
	Wed, 12 Jun 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211802; cv=none; b=SawT4knOUGs4LoxRI4PLhv9I9oW4RFCLfmIKxi5QHgJPolGs3UCkRlCPZiOHEgqJxELpX5VccV4wN/2qyZISPuAQTd+dg9d/N1ipNoRITTym1s39C9j5umRtbKH1b6+zDl6fSyVmXz9mExJtQBH8G06WYQSj1UAoXjdpi6kQwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211802; c=relaxed/simple;
	bh=bghL6tgmgkRzlloyIs229ULAO8wmcKFlVMxXqGEhuGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLk3mfY7rnfCFAIjMrDVt7sawk86pabvVfMlmgfTd+8hDcrqKw++gGaYiiEHkZjXIkHyNwcQf+t4jrqKdj1RPXBG/sSdecclq+37kKlYP7Dwt91YGoxnp7lwXo+hZAQ9bXpv764VIeoWU7BclGih2OT+z5yEXCyFCZyww4R16VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dIY7CBjL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rVrWllcR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718211794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjDH1aZopl/PB/1qPdF+A5rutVmzd0668ZVYnzeXpm0=;
	b=dIY7CBjLk6lEhwKYIH+U2MenkAgha0dy6pZP+cRjxE3Xn/9CcnlPgy++vEQI0wc/5SM3SX
	VMWdnICH7K2d9C+JRyCS3cHShlgN5mxrCnfATbWuf/6NyahyS2rHZNpnwVZ1LwZG/S58J0
	Ey2hXaAQ6IMAStd1zYEHSGScpPDROWGJZVNtYiwUcyZHvzNw6ZLXk6e9vayMuEG7Ri5xbV
	PvmhbWF2ILy2aByiveOMwSyj+dJ2YsXsrPY/quFaeuXoenAkipCjBQdfVKjwAOvAgIWiQS
	tnUyH8kyRD1Du4M3uqKqNJccTy+tm+ti7MagsFuIM0rHrO53Rp+i2Y1jRVU79A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718211794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjDH1aZopl/PB/1qPdF+A5rutVmzd0668ZVYnzeXpm0=;
	b=rVrWllcRSY9RQ9TOfCnjukYn/Sr+gMr6QuQwyvcRHuMvJvGq00qrfSHQmg0xKlx6eiAf7N
	m2mDL/zTnzrXEKDw==
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
Subject: [PATCH v6 net-next 03/15] net: Use __napi_alloc_frag_align() instead of open coding it.
Date: Wed, 12 Jun 2024 18:44:29 +0200
Message-ID: <20240612170303.3896084-4-bigeasy@linutronix.de>
In-Reply-To: <20240612170303.3896084-1-bigeasy@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
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


