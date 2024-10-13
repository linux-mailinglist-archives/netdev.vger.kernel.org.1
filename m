Return-Path: <netdev+bounces-134981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B393499BB94
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F199B20BA1
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B301A4F20;
	Sun, 13 Oct 2024 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="BwT0Mkp0"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD401A01BD;
	Sun, 13 Oct 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850703; cv=none; b=Xmw+mPrCSZbzH6kmjmWB9oTxdiHhlW17chvd5jZwbsZuBKCFaXfJF0R1ipncDSrl92rI5RK1qWTct+09em+ayX2LLy3s3iilNQZfS+5cJUTWNmqfBWlv46XrLCfhkZ3BPZsegLL5lnONlOPfrjDKMr5T0YsezcgEv7R4nGOZlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850703; c=relaxed/simple;
	bh=htI9EsWsu8314B/PUvBjBsrP6HkmbEqFi+D8XQiMNkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFmzpBg03DFGrl/jIMeRGC9+eaMh9OdD/3Ki9lGdxaENualAF3MoKlbjP3Eg6OUUGx45MDn/iwu0dfXBoVO2jAqDfYobdNdHFu7WLmMvs1clf7y3sbOQ2RqLApTGN+iIDa34FpICfvsofB5yFsf2E0ZKxajvr0EiPM3ns3H44Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=BwT0Mkp0; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/D7+Ex7Pf63xwXU1HkOBgoErAFQ+xvEU7fj82vnitk=;
  b=BwT0Mkp0mhBl6ZMiS34UPba1KegNecSUOhYfJgwANrW0fpoepAHB3hov
   m5lj0bo5QQXLEU5x4d4zFpYJYv1A+sppaYFtGeMw/CZCnjYCZx2URoJjY
   IJ5T5D1D3Gv8luHTn9zIrHkl98iGA6nd4TijDfHBfd9gsp9yRVsPmps+7
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968289"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:18:01 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "David S. Miller" <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] kcm: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:17:01 +0200
Message-Id: <20241013201704.49576-15-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/kcm/kcmsock.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d4118c796290..24aec295a51c 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1584,14 +1584,6 @@ static int kcm_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-static void free_mux(struct rcu_head *rcu)
-{
-	struct kcm_mux *mux = container_of(rcu,
-	    struct kcm_mux, rcu);
-
-	kmem_cache_free(kcm_muxp, mux);
-}
-
 static void release_mux(struct kcm_mux *mux)
 {
 	struct kcm_net *knet = mux->knet;
@@ -1619,7 +1611,7 @@ static void release_mux(struct kcm_mux *mux)
 	knet->count--;
 	mutex_unlock(&knet->mutex);
 
-	call_rcu(&mux->rcu, free_mux);
+	kfree_rcu(mux, rcu);
 }
 
 static void kcm_done(struct kcm_sock *kcm)


