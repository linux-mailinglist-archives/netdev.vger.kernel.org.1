Return-Path: <netdev+bounces-228346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D2BBC8597
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C968F4E1BBE
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9C2D738A;
	Thu,  9 Oct 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELVXkexs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhg2Sf5W"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064B25522B
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003023; cv=none; b=UaJvDyppJipb4h8ylhZJt9c/r+SmDh2w62AYdnYQzMtSKsA905O9Z+fWJmCaTsnq/Xs6l+C7V8YdfEef7RWmvYEg5En2AEVQV23yhUCI006cQj81Fotay89WQmJ/Gt/zrEO9MfgCauSWzyxZ/B3GbK8m/n5978mxqeYnlv4XHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003023; c=relaxed/simple;
	bh=bMGx3jti7pTNxXRhPr38++6PYG+wkiPqsKScc9EqXAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XM1NTOpXjAyQ9uDlzC38aP1eW1x9bgn5mWbndUc2MVLbFnA/JyuiYINozKcS0TMtyUSHRtH8bmF00ViaiAM2ttEA/DdxWDnV6DeOFBASJ4l8jX60vLzl8eZs2OkTiDhdQJFlKfYAZdoNZy1IsoYMzynxwEOBm80/B6nwLn5ykb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELVXkexs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhg2Sf5W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 9 Oct 2025 11:43:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760003019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+8IXPc55NVOCJ5X7QDr4JEG2v0yHinquInyH837VNF0=;
	b=ELVXkexsfdE1JtsJTBlgI1AEbCZKX/4NTa1BvhIOvyNGE8EqbZ/rIOv9Fzgwx625o+12eG
	m4ihjnAo0ptSenOaVs73fmxFv1l22FCj2ZYSQhzSVNT+NYV+32dvkA+nOAvcArlykO0MPP
	vSICfMb1T+WklATK3V3mDa5rkVh3KEG1j3dpDO29ThqATVbP++icnE61Wgyj9pCnTXMAyJ
	+d7VbHpe4Mq4MaMVNfhqVfNzR6jp3mCgAm2qzbK0aiRF5EKLklQqQvoFJ9Hy09Yjw4pB+q
	Sqn2l3gRDOgxv3I6Xkm4BoIlOigcUeoIEepN+TWZsEXzfCLXxtcrh45TGtM0zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760003019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+8IXPc55NVOCJ5X7QDr4JEG2v0yHinquInyH837VNF0=;
	b=lhg2Sf5Wy/IHx6kWPHpRpCYO9OoowuyD1a+F1JUSesCOKCBdoIxXOKBLzj6jcncmvmZYUC
	UX+dqEbDTubQDECA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Subject: [PATCH net] net: gro_cells: Use nested-BH locking for gro_cell
Message-ID: <20251009094338.j1jyKfjR@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The gro_cell data structure is per-CPU variable and relies on disabled
BH for its locking. Without per-CPU locking in local_bh_disable() on
PREEMPT_RT this data structure requires explicit locking.

Add a local_lock_t to the data structure and use
local_lock_nested_bh() for locking. This change adds only lockdep
coverage and does not alter the functional behaviour for !PREEMPT_RT.

Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68c6c3b1.050a0220.2ff435.0382.GAE@google.com/
Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

- I added have_bh_lock because there is this "goto drop, goto unlock"
  flow and I did not want to duplicate the block.

- gro_cell_poll() uses __local_lock_nested_bh() because the variable is
  already local instead per-CPU.

 net/core/gro_cells.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ff8e5b64bf6b7..b43911562f4d1 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -8,11 +8,13 @@
 struct gro_cell {
 	struct sk_buff_head	napi_skbs;
 	struct napi_struct	napi;
+	local_lock_t		bh_lock;
 };
 
 int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
+	bool have_bh_lock = false;
 	struct gro_cell *cell;
 	int res;
 
@@ -25,6 +27,8 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 		goto unlock;
 	}
 
+	local_lock_nested_bh(&gcells->cells->bh_lock);
+	have_bh_lock = true;
 	cell = this_cpu_ptr(gcells->cells);
 
 	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog)) {
@@ -39,6 +43,9 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	if (skb_queue_len(&cell->napi_skbs) == 1)
 		napi_schedule(&cell->napi);
 
+	if (have_bh_lock)
+		local_unlock_nested_bh(&gcells->cells->bh_lock);
+
 	res = NET_RX_SUCCESS;
 
 unlock:
@@ -54,6 +61,7 @@ static int gro_cell_poll(struct napi_struct *napi, int budget)
 	struct sk_buff *skb;
 	int work_done = 0;
 
+	__local_lock_nested_bh(&cell->bh_lock);
 	while (work_done < budget) {
 		skb = __skb_dequeue(&cell->napi_skbs);
 		if (!skb)
@@ -64,6 +72,7 @@ static int gro_cell_poll(struct napi_struct *napi, int budget)
 
 	if (work_done < budget)
 		napi_complete_done(napi, work_done);
+	__local_unlock_nested_bh(&cell->bh_lock);
 	return work_done;
 }
 
@@ -79,6 +88,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net_device *dev)
 		struct gro_cell *cell = per_cpu_ptr(gcells->cells, i);
 
 		__skb_queue_head_init(&cell->napi_skbs);
+		local_lock_init(&cell->bh_lock);
 
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
 
-- 
2.51.0


