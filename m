Return-Path: <netdev+bounces-182321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB55A887FD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2E818992A7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7527FD5C;
	Mon, 14 Apr 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3dpH8Au+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZywAtazY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A218DB26
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646892; cv=none; b=TlGLbxGHPtpiF6kijmftkgkzwWdD+7j9lUbWNsw2rBPdpT7JXrhLMg6PxQn+7jayORPQ9/9wNIusg6N+KhCeIgAkyfmCZ7aJnUnYkwZ054ycexZvfwdas3Cd2mGJdBQeyvW7FCnHdGSRRrwJfIw/nSMrTI4elNZ/CcjP9juLZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646892; c=relaxed/simple;
	bh=HHiVQTH+atgT4xOQAN37uuJt5UAHAio4xUM9Rqa92CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jl3A9QuGd7UkCaWskTZrBqkFCGP8mGvp82j2qK6YJzNoJtJS2863tRCtBy1ypa35z8cQde0NmynPLMWxSq1qbXBZzP7gIU7rNgjYirmWUouPVFEPygq4eF5HRV94hpWjmjkSi8LVrqaqsXHWAkzkmzWESbYT6yel6/e7HHSffig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3dpH8Au+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZywAtazY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aht/WxYRxsU2RswlJxtNzoWOPHgqB8qiJPYiwhb18pU=;
	b=3dpH8Au+ToIfW9BIFnc7AaITX1XQPlwXoRZyvL2x2AJE/jahNFOKxt4kc5+sTKTuRgdiqU
	vwzYx0X+0CNxlnPO34mLIntKHvyfRWRD68Bx95IpUvGXdgeLTgg5ci7aKjxV03qt0IirzC
	6h2DPUcjiEPgQJxvOwwSLZcU7LUQvhHMub80IYZUwTS/dJ7SxZBLxpbdy1MPwADNrZNPEW
	0YVb+WW7SKc8ivxKEjygSnHXQUhVgIx5FCvH4gtNPAXtLLJlBBYseOvPMdkrEh7kX26unN
	8Jm3C7Ncd9uAKI0GKNZ515C8cuUWCUkgWfqRUF2urRxijKzTZiD3YScx4WIvOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aht/WxYRxsU2RswlJxtNzoWOPHgqB8qiJPYiwhb18pU=;
	b=ZywAtazYo1ouehJF936eyFEGqF9KuC3ZxBLPIJ4P4kfQiDBe/CWqEg6ywAhYQ57qydzM3O
	c1G6mhxYBjRDv5CA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH net-next v2 01/18] net: page_pool: Don't recycle into cache on PREEMPT_RT
Date: Mon, 14 Apr 2025 18:07:37 +0200
Message-ID: <20250414160754.503321-2-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With preemptible softirq and no per-CPU locking in local_bh_disable() on
PREEMPT_RT the consumer can be preempted while a skb is returned.

Avoid the race by disabling the recycle into the cache on PREEMPT_RT.

Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/page_pool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7745ad924ae2d..ba8803c2c0b20 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -805,6 +805,10 @@ static bool page_pool_napi_local(const struct page_poo=
l *pool)
 	const struct napi_struct *napi;
 	u32 cpuid;
=20
+	/* On PREEMPT_RT the softirq can be preempted by the consumer */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return false;
+
 	if (unlikely(!in_softirq()))
 		return false;
=20
--=20
2.49.0


