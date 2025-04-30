Return-Path: <netdev+bounces-187055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74501AA4B93
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CE14E3DBF
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F0925C828;
	Wed, 30 Apr 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jf9UQ49e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oG/53Io8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B325C711
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017293; cv=none; b=JMBbd+MBmrlWtISgDpRxc6QWasnZmunbvD4HjyawcRJtzvLTls0ejrT+5S/oijK4fGiEsLTQ4xT5kvABG4gd5Iko1lNBq0mazev1ByFeCoJWEcF61sBbDcxpCTVnXNSVCDKmg9c3KKq4tXMs7fxKtjDahmxsa92ZSNYB4FqIS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017293; c=relaxed/simple;
	bh=HHiVQTH+atgT4xOQAN37uuJt5UAHAio4xUM9Rqa92CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2cCQ1/pi19TFjSiUuD50BQymxhf5EsjXoz8dfx6CWYseYTdQLX1xg98ZaGZNK/i+9iouk2jOA5OCcXoFwhO62HgPS2u4ROu4UIag+OBQE9RmCTtTYK9LjTYqqktIS23Qa0XjFcjjdJBkE2Ers+E6yQG1a8zjfCjKqYLpXibsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jf9UQ49e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oG/53Io8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aht/WxYRxsU2RswlJxtNzoWOPHgqB8qiJPYiwhb18pU=;
	b=jf9UQ49ethsMyl/tx9lmYViG6oVDlLW+1emLvPME2foh25byb4O1soEa0vdR/rc81+Xt+E
	a2QiVdD3wOZfZCuggND+ywiLI5URnFd/cCqrDce+/guQDw9VMFiTHSvuqajXOUC0H3lRf/
	nDSx1wkU8XLtCxTJyVl9db/KLs82qqbpB5Vz9ja/bqe7uulouLEqntsmYb15NX2FOV0jG8
	y+X70vK7nDvvoxP3MnImAFWIemhetWh2JIznZOskVEX45W48PJfy7fiFpTpyHxflZIQNP3
	CC0/M2bdaBLj1YQxx4PDn26IXXCUtHeyzd7gCtsarkg9YPfkOlaftZdjScnp4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aht/WxYRxsU2RswlJxtNzoWOPHgqB8qiJPYiwhb18pU=;
	b=oG/53Io85wvux/KwLi7uPrbPinrcqqapsLpa1jg2FICc4sfrOe26OBZPTDQXqh11zzX6Vh
	ntKr/J61YIzSHFBQ==
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
Subject: [PATCH net-next v3 01/18] net: page_pool: Don't recycle into cache on PREEMPT_RT
Date: Wed, 30 Apr 2025 14:47:41 +0200
Message-ID: <20250430124758.1159480-2-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
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


