Return-Path: <netdev+bounces-291377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDP1GjF+FGowNwcAu9opvQ
	(envelope-from <netdev+bounces-291377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:52:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB85CD10D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7403430177BB
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F43F4DD0;
	Mon, 25 May 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofJP1NgE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BB26738D;
	Mon, 25 May 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727894; cv=none; b=AQhzypN1LK21Igip+3pLogxr2ThnIN30i0DxLrz1dC4IbTQJId6ICp3P9FD/MKA0nRE4XcIcxyaWbQA3O7reMJ4SWYvONARM9ogHI4zW35qlgQsCISSSssGlRQBTil6bSCm+QqpljV1c5RDyj9gW4TqCXq24OjE9f2YaAXRCLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727894; c=relaxed/simple;
	bh=wF/jomMZ24V11Xkl5msHZrZUvPJCyI921osei6e5UfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5b7NYLyGoutsJZKajd4i8HLQvmQI5M13wTYL4OhHgf84NHoSe6yZBjCiyUCYB/dSeXB+azaSYfgMEJhQgNy9M2RZZs1DgGvDv+lLKYtdmnYUxfjDy/8w2LFMHku/C2v0vUQF/n1rFvKAu/C7w0cMmP8gsF6f4AnjvG9W2ukVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofJP1NgE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDEE1F00A3D;
	Mon, 25 May 2026 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727892;
	bh=IxJaGtQoJkPVdTRrPxKYx3Y8U4vPqPnOum4dhkgUAHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ofJP1NgED2ey6e2/TQOlgZckaV6Cnyu+o2VwBw1jI5+GFdXo0+YLVfJ3lhP4GfuCw
	 imI8w/rpE8Xaw/+URIpMmcVvRxFGfYKiNRmTZgvU0FAwXOlVQneH7ZeIT+OhsexeGZ
	 6BRbfgpDrJ1SwwhuuJpQRqmf0C/AOU8nVFw6B7WVQfJ0S5RDTjPR3rZVP3yvOQuckV
	 0Zngh0zLEApfqgsYS2ZkUX+9OGyV0qJLvBgT2Q5PYQBK7TcVYMRVUv67cPUVqqpt+1
	 Lt2X892G45KiZ3m+k7mhDQQA7kg4T65W2Ofuhdd5VCj1HB8XHsr6u7OHJdX9Uz/hZz
	 /8HEkxwu466aw==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:15 -0400
Subject: [PATCH net v3 1/8] net/handshake: Use spin_lock_bh for hn_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4764;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=6A+lqpdwbykiqZeeogOj+ebtUfZ/y8/UTW+7RqvHrqU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4RPkLmCr9G4vXTlRtRPquQN4vNWc5Tl9gsM
 1G7xEriz26JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EQAKCRAzarMzb2Z/
 lzIGD/442fxMYfTEY5rbtqA6gBoUsmqAW9Qi/SLIJxaoDMC8H/IzWwFXSivPlYPFtgcuRI7X+Sd
 x5uAKLZKsuqT+f4CW44JvFZw9Qtz3+ZA4yuZ3zq7TRtwHMe6rFkbxoZ6FYp8sS2fJj12qcuG0SN
 Vaksic4h65BS61mlwWKqp8+2qKd1TiMp+CNNfzZiaA3E0AVUpwIlvlxBdaZkU+lmLSofDYXjQPg
 EYZNlpcFsAlP8W9iPmxlgz17YEDHQ+WqeBZecio8fRuUeKYPhVwGAEgAOHIEsGVG6QbRyDiKdon
 +zf0glOSSAhHXbPUxZcOjXbrLvRw2bhLGq9JPQtSLtQcM6Rn2mlpInf3JAxCgGIFpSCwNiNYnmm
 G5pPCD55U9ITYmK9LnTlc93yAwjFkiQbgwq6d/J/cDN8xfj2aqeCJ1VFw+xwwTpvgQ+DrKSYlGu
 OHI4Qzd03wjtMpqJtX/4nuNKMuVCGDgtH3BSn8IkFrI4fV86oNx6bbkr6EPLrcrG/z812j6SqDK
 G4a0tCNnGLzwAr10z/Xza/vOQlBALfikkfeUEoouKNI+EeBM1dnrNLrewrUvgNSrv0lGcA1Ydo7
 ZuMotosy22ZXx2F+eMKcELSsqX/kLnjLVnFqfzoPpOufVFaCvg8O31QtXiCWqlL4zSA2B0gmUKg
 c7aDLMcjBUx5Cfg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291377-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: BBDB85CD10D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

nvmet_tcp_state_change(), a socket callback that runs in BH context,
can reach handshake_req_cancel() via nvmet_tcp_schedule_release_queue()
and tls_handshake_cancel().  handshake_req_cancel() acquires
hn->hn_lock with plain spin_lock().  If a process-context thread on
the same CPU holds hn->hn_lock when a softirq invokes the cancel path,
the lock attempt deadlocks.  This is the only caller that invokes
tls_handshake_cancel() from BH context; every other consumer calls it
from process context.

Deferring the cancel to process context in the NVMe target is not
straightforward: nvmet_tcp_schedule_release_queue() must call
tls_handshake_cancel() atomically with its state transition to
DISCONNECTING.  If the cancel were deferred, the handshake completion
callback could fire in the window before the cancel runs, observe the
unexpected state, and return without dropping its kref on the queue.
Reworking that interlock is considerably more invasive than hardening
the handshake lock.  Convert all hn->hn_lock acquisitions from
spin_lock/spin_unlock to spin_lock_bh/spin_unlock_bh so the lock is
never taken with softirqs enabled.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/netlink.c |  4 ++--
 net/handshake/request.c | 14 +++++++-------
 net/handshake/tlshd.c   |  2 ++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index b989456fc4c5..97114ec8027a 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -202,10 +202,10 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 * accepted and are in progress will be destroyed when
 	 * the socket is closed.
 	 */
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
 	list_splice_init(&requests, &hn->hn_requests);
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..5d4a17f902d2 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -167,12 +167,12 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 {
 	bool ret = false;
 
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	if (!list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	return ret;
 }
@@ -182,7 +182,7 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 	struct handshake_req *req, *pos;
 
 	req = NULL;
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	list_for_each_entry(pos, &hn->hn_requests, hr_list) {
 		if (pos->hr_proto->hp_handler_class != class)
 			continue;
@@ -190,7 +190,7 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 		req = pos;
 		break;
 	}
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	return req;
 }
@@ -249,7 +249,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
 		goto out_err;
 
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	ret = -EOPNOTSUPP;
 	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
 		goto out_unlock;
@@ -258,7 +258,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 		goto out_unlock;
 	if (!__add_pending_locked(hn, req))
 		goto out_unlock;
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	ret = handshake_genl_notify(net, req->hr_proto, flags);
 	if (ret) {
@@ -274,7 +274,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	return 0;
 
 out_unlock:
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 out_err:
 	/* Restore original destructor so socket teardown still runs on failure */
 	req->hr_sk->sk_destruct = req->hr_odestruct;
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 8f9532a15f43..af294c6cc717 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -425,6 +425,8 @@ EXPORT_SYMBOL(tls_server_hello_psk);
  * Request cancellation races with request completion. To determine
  * who won, callers examine the return value from this function.
  *
+ * Context: May be called from process or softirq context.
+ *
  * Return values:
  *   %true - Uncompleted handshake request was canceled
  *   %false - Handshake request already completed or not found

-- 
2.54.0


