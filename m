Return-Path: <netdev+bounces-100647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1210E8FB7B9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3B62832A6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2FA145FF8;
	Tue,  4 Jun 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viC6lkgC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lbgcgTVT"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885EA144313;
	Tue,  4 Jun 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515890; cv=none; b=nMb7AkzQcaML8fr/VIUn/imvi2c/c95NIKugl4AzBAU4uWR2eHcEUuEB3LTp0lKP/sueauMpTMEIiCXA675cDC4w3ufgJzvs9whL7zPF8jWGqTjmTLW4NpaEKqvkieTTab/GpyyXMnjb6xy3LVESjv12ykGvYC1wwTqVIclCgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515890; c=relaxed/simple;
	bh=G+S7nMnQYP8Ub6wdwc/QdbVXpNg4qAepSUVQBtIndoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBuibUkGh198+0InCgl96yI3D3E+346GTv6/20BSiaylxMvbuTvkT3a9zPPVFmscDx2907baaRPh7h8niw3sRFmtToaG6VIT665NMh3lO4KZqhQZ+Nhua0CfForXDEBh8veuG8aBzyY3c3jLnrk3njta0Q4+sa/AjiMzXNzVTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viC6lkgC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lbgcgTVT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717515887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jc9kVwpT1wazRgJL8VSyOnTf3zyLearQK1DZf1xb140=;
	b=viC6lkgCUzfivwQLWjonYU9EOhxsxw9uKJQ4t/Kcs7Xzabb6+7eKrTs+37I+KGYAUqcqhc
	lrDIMHbXrkURGhjydBgxiMSSE5mWDvHBf4teXDZ5wRLO9n4g/YyOV4l975yPhKtLHEUtip
	yxAdUv+azl+AxDRECQhcDok+JJyp2KKClPI8A1XHtLX6Ca+q5z6FhWQ8wVtu+z7V6NB7xG
	gcgK1qXEuwT/dUVXRO5Wh8KyRRXBAfumD3U4jP+zyMfLmXny1DhCqqBeKH5EikkM46m/hq
	ChGZbCv7N3WFWpu5MLkRsLr7aChJlOJgjk3H/VGo2QvS4Km3JHSvSw8HaFdHLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717515887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jc9kVwpT1wazRgJL8VSyOnTf3zyLearQK1DZf1xb140=;
	b=lbgcgTVTF1uYDTgw0nRUB8a20nSfMZ7QTl1+70n3F97TPtC4vUKLCFrzYJP8J67wlDrAMk
	7vMkY6vO8Kfn6QCg==
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
Subject: [PATCH v4 net-next 02/14] net: Use __napi_alloc_frag_align() instead of open coding it.
Date: Tue,  4 Jun 2024 17:24:09 +0200
Message-ID: <20240604154425.878636-3-bigeasy@linutronix.de>
In-Reply-To: <20240604154425.878636-1-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
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


