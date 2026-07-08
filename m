Return-Path: <netdev+bounces-305819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lla+Fe5TTmogKwIAu9opvQ
	(envelope-from <netdev+bounces-305819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99975726E84
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:43:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="W81e0/UJ";
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305819-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305819-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9741D306FDCF
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E4D37F000;
	Wed,  8 Jul 2026 13:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA833EAED
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 13:38:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517925; cv=none; b=P5rf+BJfc6RQn7xpykN3tUxhwWlRO2+6dq1tCFTQ6MtSlpQ27QIXf15gN6qNzWVPJaRNjAsAMyGizA8yWfO3WCumSiM7bIJr4B4687AHZsig7/eFCzwtdYmFctZjNwkaCqEMGUPrARORfqWp7AI/65cUkBpEaVbjGpQy718K9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517925; c=relaxed/simple;
	bh=8x59uWo+vOBAmbBpCRrHvxUBCJ1Z7mHDLdZzdTN389M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svMaD1KlEeBS57Z48g7m3WmDiSv/42fWkZG0tS4wprdGO0wATdLKMABNpB1UuQpoRJx1TKGYeT32xd1SCK09PXWMviqK9YTDqD9J4TDphsSYQT1Rmo2QNcrHaMu18D3/RpNGswrdHPswm8gaY0UHjsZJFHRTKlvvTMogcsfGqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W81e0/UJ; arc=none smtp.client-ip=95.215.58.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783517921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qG1YA7kIP6qYbdRqQAeeSPUuuJTJjj8sPfJa3wtyOFw=;
	b=W81e0/UJkOUNpofzmj9jhWBEe9h9MYyosQmMi5pVgdUJZEyOuPEoBabjb3AMLr+YA/Mw2p
	QN4ce4F7zgNJTjOTBxHZqf0B1az/gWquWMXHRm1Zs9EVLIj7FUX3erLdPXM6EQpDeLm1co
	dgKO5VDA2qP56ygF8wy0hCuqIdHPQUk=
From: Usama Arif <usama.arif@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] net: use sync wakeups for socket error reports
Date: Wed,  8 Jul 2026 06:38:15 -0700
Message-ID: <20260708133815.3419465-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305819-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:kuniyu@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:willemb@google.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:riel@surriel.com,m:kernel-team@meta.com,m:usama.arif@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99975726E84

sock_def_readable() and sock_def_write_space() pass WF_SYNC to their
waitqueue wakeups, switch sock_def_error_report() to
wake_up_interruptible_sync_poll() so EPOLLERR waiters get the same hint.
ep_poll_callback() forwards it through to
try_to_wake_up() / select_task_rq_fair(), where wake_affine() can
prefer the waker CPU and skip a cross-CPU wakelist IPI when its
heuristics agree.

WF_SYNC matches the choice already made for readable/write_space. Some
error reports have the same producer/consumer shape: the waker has queued
an skb on sk->sk_error_queue, and the wakee is about to dequeue and copy
it out. Other reports publish sk_err/socket state directly, but still wake
a task likely to consume that socket state immediately.

Measured on a 176-core EPYC 9D64 host running a Meta production
workload, bpftrace on tracepoint:ipi:ipi_send_cpu with a kstack filter
attributed the sock_def_error_report -> ep_poll_callback ->
try_to_wake_up -> ttwu_queue_wakelist -> __smp_call_single_queue
chain to 16,326 IPIs/min. Switching to wake_up_interruptible_sync_poll()
will help reduce those IPIs.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8a59bfaa8096..c724f1442987 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3639,7 +3639,7 @@ static void sock_def_error_report(struct sock *sk)
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
 	if (skwq_has_sleeper(wq))
-		wake_up_interruptible_poll(&wq->wait, EPOLLERR);
+		wake_up_interruptible_sync_poll(&wq->wait, EPOLLERR);
 	sk_wake_async_rcu(sk, SOCK_WAKE_IO, POLL_ERR);
 	rcu_read_unlock();
 }
-- 
2.53.0-Meta


