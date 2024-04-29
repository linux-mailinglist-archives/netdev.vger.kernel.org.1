Return-Path: <netdev+bounces-92062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0728B53E2
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513641F21F63
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE7512E7F;
	Mon, 29 Apr 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/ASOKbN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9OKZWQzD"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064D17BCB
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381912; cv=none; b=Rlx4A731pvZD97ibQHirNSJ1oKaU5EQ8x1paydHNIpVBVSG7glRi7FdEiQmleIaM/B7LQSLfZ8QPF1xjWzroQ/hxu91YRwZ3/6WyQOzmYldts+sD6BEaUfTlfz+xXgg/9PFB3NFZ8KeQiIZ4gkCeqUlc6g71bz2+Vkcv0tXJ5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381912; c=relaxed/simple;
	bh=N4NNr5A2CUMUnGazLWh+nrKjEdU312shalDUwfb2OmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cORvmJseUnBSxiBdm1Ts/V0eKxee6b7o3CwIDxUXnm0yOvUKJnJzExMx4vtJERqW/nBM2kZJ/GWyddUM34+W1rB5Fx3zfkAN/na2m7dh39QevV8hPk0iUGG36VT0P/spuO6ygPBY9Cgckhu9xIMbEb51MjHRtU8q4r0qTN7dc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/ASOKbN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9OKZWQzD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 11:11:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6IP5zXxMx/vvA2rdUGJ1us7PrzkupexO0RU+IHTOF0=;
	b=i/ASOKbNapASGXYcR+MifJjLKmMVeK7y9tACMnKxzB9xoHCcNfAGl/f0H2US9upwBnlwxu
	CIBmb2t3JrnJVCqu7CpsrbWDc5Q9T3kx0tsQEm59cekE4xp30einlvYTWpjNFoLqhK8jTb
	QEuE6UEfURa3FUxElvhky7ZYH2jEh9duYlXfANkcnc0ZXzN8jWDCdkwCYv8Fou0vxGOKym
	Kr4b/NG13qxjspcOEhGOdpEq3tTr0bDQ2MlxbcrbUYUDaJccMqQUQWx6+eQskHxbGQ9t0o
	S8+Gf0UsALxlR3VQkptp7Fp0H7S6wT4P8LxdIZZG3E0k029MT2Qim/VYabAquQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6IP5zXxMx/vvA2rdUGJ1us7PrzkupexO0RU+IHTOF0=;
	b=9OKZWQzDM0kkjvDbqmGR+8GHJRvVgk4aX+nj1S868n88bm0uv5LdunHLrQPH3u6jk1V4yh
	I5jhwNFfUdCAI4BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	Raju Rangoju <rajur@chelsio.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH net] cxgb4: Properly lock TX queue for the selftest.
Message-ID: <20240429091147.YWAaal4v@linutronix.de>
References: <Zic0ot5aGgR-V4Ks@thinkpad2021>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zic0ot5aGgR-V4Ks@thinkpad2021>

The selftest for the driver sends a dummy packet and checks if the
packet will be received properly as it should be. The regular TX path
and the selftest can use the same network queue so locking is required
and was missing in the selftest path. This was addressed in the commit
cited below.
Unfortunately locking the TX queue requires BH to be disabled which is
not the case in selftest path which is invoked in process context.
Lockdep should be complaining about this.

Use __netif_tx_lock_bh() for TX queue locking.

Fixes: c650e04898072 ("cxgb4: Fix race between loopback and normal Tx path")
Reported-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Closes: https://lore.kernel.org/all/Zic0ot5aGgR-V4Ks@thinkpad2021/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 49d5808b7d11d..de52bcb884c41 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2670,12 +2670,12 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	lb->loopback = 1;
 
 	q = &adap->sge.ethtxq[pi->first_qset];
-	__netif_tx_lock(q->txq, smp_processor_id());
+	__netif_tx_lock_bh(q->txq);
 
 	reclaim_completed_tx(adap, &q->q, -1, true);
 	credits = txq_avail(&q->q) - ndesc;
 	if (unlikely(credits < 0)) {
-		__netif_tx_unlock(q->txq);
+		__netif_tx_unlock_bh(q->txq);
 		return -ENOMEM;
 	}
 
@@ -2710,7 +2710,7 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	init_completion(&lb->completion);
 	txq_advance(&q->q, ndesc);
 	cxgb4_ring_tx_db(adap, &q->q, ndesc);
-	__netif_tx_unlock(q->txq);
+	__netif_tx_unlock_bh(q->txq);
 
 	/* wait for the pkt to return */
 	ret = wait_for_completion_timeout(&lb->completion, 10 * HZ);
-- 
2.43.0

