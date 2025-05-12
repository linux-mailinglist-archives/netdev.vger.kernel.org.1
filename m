Return-Path: <netdev+bounces-189690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEACAB3393
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA99B188B4F1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44642266F0F;
	Mon, 12 May 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WmX0NYmw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="go4lxhOU"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63F266B66
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042066; cv=none; b=GqsLoCelONenIn+wZzrV8RwpuusrlkPxxF+RBddfUINrt3XP7HxyVJE5xriJBXlJpqjJ2ClVdFt2ZPrh13aqWoICk7VcQ8LTwCFtAm+OKH+qsxWFEq4eqadwmxIWYcWRC5lvbrpqjkiLbgmtrRN6vjmNR8f1QEr2jOh18uBDZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042066; c=relaxed/simple;
	bh=HHiVQTH+atgT4xOQAN37uuJt5UAHAio4xUM9Rqa92CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1MdVES9RL6me5IZmP9R5Usd/A6j8uVKKzrP2h/t/MHVS5nDJBJ2MfmWOkCxHU8iOUMhTEaN7CQ0RZh39Z8QWyfJTFjZIvG6dwvO52yohZTaSuvJLpq/GTkjWECoUVF5vbr+b/nqLvD9rXCXSZdhJRSkvGMIWAiCTwYxhMCV8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WmX0NYmw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=go4lxhOU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aht/WxYRxsU2RswlJxtNzoWOPHgqB8qiJPYiwhb18pU=;
	b=WmX0NYmw/xjmv7ThOizSpElm/yNlDwwkFIUKwmDd9stzGBjedl8oGd5fNO68yquSfbi8GD
	0w1A943b/0yrOyUFKPQhEVwGpOV3LXiGcykmOJ8L42LLwBOYGvaKRWU5Q5hl5+8Xus7m3L
	D/O2JBkbX4mzjz4bUC5qqKl9xX4pDai7sjmXlPjxbZd+Yj31f56fY4qb2SgOcz1pMw3Uh7
	RgzWIJ+TXdWT29znIKP+SwdgMD2/n0PKcl5jtAziapPNrIYz6z9CsUcH6gtLuznotg1hUa
	45fcVsq463XjfRBKXqK2tNQWsffdxuXD0cQzp9wMPeFMGHeG0S1JQuRYAdWteA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aht/WxYRxsU2RswlJxtNzoWOPHgqB8qiJPYiwhb18pU=;
	b=go4lxhOU3q/RXQ+gl0FB4+QsPNhbRSh92OHsrf1nHcZzOwWn7iX/kbHuHMXR7WuRaJ3AQA
	LTokS5cEEP80XqAQ==
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
Subject: [PATCH net-next v4 01/15] net: page_pool: Don't recycle into cache on PREEMPT_RT
Date: Mon, 12 May 2025 11:27:22 +0200
Message-ID: <20250512092736.229935-2-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
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


