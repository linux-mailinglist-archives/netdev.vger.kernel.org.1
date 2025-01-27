Return-Path: <netdev+bounces-161064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12644A1D0D0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 07:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3211656B6
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA611FC101;
	Mon, 27 Jan 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="j78iKRCy"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78491FCCE6
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958089; cv=none; b=VRibamm9ErK2OcMhyqKG3V7d7EDNtyD/CDZEz92RBiXt0NWh5Rm0IrvgHxMuLC4fWmXJXpO0BingxdbxTDgmO1UlIL+1Rj18+3pVuW2UhYI5/FarwvZLBFG8yTaj2pWek8KwMN9Sb6O0Bsvcs7ULlEX8KTdgvsc0aU6cYcJ6pY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958089; c=relaxed/simple;
	bh=QEgd7BX7yzxVM380ufMNe3+nh8qKdJ/bIRiczmmNff0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKtqYUbjbsqlZPLsmLbP7B6ebS+pBTb48nSrK+w0HcSZsTbYgiDjPs/gOw6WwQqjIo/uN4djmM5hFTQAXiw1yNCu2fkRlHEjcwzCjq4pVkVuCn8+YdrhGF46X02R3bXArCUPLOHjFLSzBQfD+7U2eip20o3nU8poqf49SVKmshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=j78iKRCy; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A8781207A4;
	Mon, 27 Jan 2025 07:08:03 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FYtzDEQ4eXtQ; Mon, 27 Jan 2025 07:08:02 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 346DB207BB;
	Mon, 27 Jan 2025 07:08:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 346DB207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737958081;
	bh=k6g73wc7M5myNhw7yNvG5xCuUlAikR2eFihMZIMtQ1I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=j78iKRCyELmNr73pOi3vprsvp+cVE5gcx2tgljTj+pZqhsiEUGOD4dWwp08IMBMoe
	 9IJwfnHYh3KvADlLimw7Q/+LoZjQAxBAeWeEy6gm/W0DhKVc7IrRy6Ph2jyIVvUe3f
	 q9MiQV2HsaWhICVwbNPDcKBJhlUsUzIijXsUuG9izeyo7Q114iRPKUEL95vWlQwx+z
	 6stNL7W4NU84uSJzJpVSlWo6e2AZuwvq8JmqojK1o40zF3YF+zmAtDXJav//+vmzIO
	 +6J2xD5NcLHoDXcwxzdKIzpsbSIVo62eoTr373D5SJQZXgi8Tq9MDfv9nkQbrlAy5y
	 prZWsmruRgE6g==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 Jan 2025 07:08:01 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 07:08:00 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D8DF231841AA; Mon, 27 Jan 2025 07:07:59 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/5] xfrm: Don't disable preemption while looking up cache state.
Date: Mon, 27 Jan 2025 07:07:57 +0100
Message-ID: <20250127060757.3946314-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127060757.3946314-1-steffen.klassert@secunet.com>
References: <20250127060757.3946314-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Sebastian Sewior <bigeasy@linutronix.de>

For the state cache lookup xfrm_input_state_lookup() first disables
preemption, to remain on the CPU and then retrieves a per-CPU pointer.
Within the preempt-disable section it also acquires
netns_xfrm::xfrm_state_lock, a spinlock_t. This lock must not be
acquired with explicit disabled preemption (such as by get_cpu())
because this lock becomes a sleeping lock on PREEMPT_RT.

To remain on the same CPU is just an optimisation for the CPU local
lookup. The actual modification of the per-CPU variable happens with
netns_xfrm::xfrm_state_lock acquired.

Remove get_cpu() and use the state_cache_input on the current CPU.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/all/CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com/
Fixes: 81a331a0e72dd ("xfrm: Add an inbound percpu state cache.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1781728ca428..711e816fc404 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1150,9 +1150,8 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 	struct xfrm_hash_state_ptrs state_ptrs;
 	struct hlist_head *state_cache_input;
 	struct xfrm_state *x = NULL;
-	int cpu = get_cpu();
 
-	state_cache_input =  per_cpu_ptr(net->xfrm.state_cache_input, cpu);
+	state_cache_input = raw_cpu_ptr(net->xfrm.state_cache_input);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(x, state_cache_input, state_cache_input) {
@@ -1186,7 +1185,6 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 
 out:
 	rcu_read_unlock();
-	put_cpu();
 	return x;
 }
 EXPORT_SYMBOL(xfrm_input_state_lookup);
-- 
2.34.1


