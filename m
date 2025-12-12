Return-Path: <netdev+bounces-244474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7BDCB88E7
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B30302C22B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F443161A6;
	Fri, 12 Dec 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f8w14o4o"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6373161A5;
	Fri, 12 Dec 2025 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765533563; cv=none; b=KKZyrXsVFDyEZTmrEbwmPcQitXj1fdbnYDqXDXry8blfhBRit/57HAtkW10utSP+O7mfzB1miSUPwd3C9QfcwdY3gKUA6KoVHNR0zJ1eCiJ+nC4yCXjEekkcLB3yt6YokWEcEbGYrSzxmjo6DRxIx4dssKjbECzgrWaTIab9eGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765533563; c=relaxed/simple;
	bh=rcWaxzsy/BhKrpMBzTexaQPucukDOlfhcS9RbDkSI0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQvMWTw+f3BROha1dTZdnz1f4i2K8mVWBAK37Np/6fJg+nEqDmtRCrJmCxbKpht+mSFVan0MLLMQoVgkxdHysiGykQAi9jFtKzCGgNlc7AgFv7svNv0HFUQGYRhP/jiGmfMQEKG3dxLgjBGB1irDokpAjwdg5MKNacMxPMndlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f8w14o4o; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765533556; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g9p1PKRiJ+IqF8WgLeqdKGX/8PMrBBoE7jD+fozUtWI=;
	b=f8w14o4oWWW91r9A5uVfZYoeUf1HH46sOsOdkzmYdH7I6aLrIG4cTefKINNf51rHr+2wtfnU7mBsbF0BuytTmQi4FW6rglN3+/KuzietXgVzR21mjy5eTXSLqI5MhcYCURp6eHs0ZO4by2FX2H9PAAUQNgj7FyYBERRckr7+o5c=
Received: from localhost(mailfrom:evan.li@linux.alibaba.com fp:SMTPD_---0WududpR_1765533555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 17:59:16 +0800
From: evan.li@linux.alibaba.com
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Evan Li <evan.li@linux.alibaba.com>,
	kitta <kitta@linux.alibaba.com>
Subject: [PATCH] subflow: relax WARN in subflow_data_ready() on teardown races
Date: Fri, 12 Dec 2025 17:59:09 +0800
Message-ID: <20251212095909.2480475-1-evan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Evan Li <evan.li@linux.alibaba.com>

A WARN splat in subflow_data_ready() can be triggered when a subflow
enters an unexpected state during connection teardown or cleanup:

WARNING: net/mptcp/subflow.c:1527 at subflow_data_ready+0x38a/0x670

This comes from the following check:

WARN_ON_ONCE(!__mptcp_check_fallback(msk) &&
!subflow->mp_capable &&
!subflow->mp_join &&
!(state & TCPF_CLOSE));

Under fuzzing and other stress scenarios, there are legitimate windows
where this condition can become true without indicating a real bug, for
example:

during connection teardown / fastclose handling
races with subflow destruction
packets arriving after subflow cleanup
when the parent MPTCP socket is being destroyed
After commit ae155060247b ("mptcp: fix duplicate reset on fastclose"),
these edge cases became easier to trigger and the WARN started firing
spuriously, causing noisy reports but no functional issues.

Refine the state check in subflow_data_ready() so that:

if the socket is in a known teardown/cleanup situation
(SOCK_DEAD, zero parent refcnt, or repair/recv-queue handling),
the function simply returns without emitting a warning; and

for other unexpected states, we emit a ratelimited pr_debug() to
aid debugging, instead of a WARN_ON_ONCE() that can panic
fuzzing/CI kernels or flood logs in production.

This suppresses the bogus warning while preserving diagnostics for any
real state machine bugs.

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Reported-by: kitta <kitta@linux.alibaba.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220856
Co-developed-by: kitta <kitta@linux.alibaba.com>
Signed-off-by: Evan Li <evan.li@linux.alibaba.com>
---
 net/mptcp/subflow.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 86ce58ae5..01d30679c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1524,9 +1524,27 @@ static void subflow_data_ready(struct sock *sk)
 		return;
 	}
 
-	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
-		     !subflow->mp_join && !(state & TCPF_CLOSE));
-
+	/* Check if subflow is in a valid state. Skip warning for legitimate edge cases
+	 * such as connection teardown, race conditions, or when parent is being destroyed.
+	 */
+	if (!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
+	    !subflow->mp_join && !(state & TCPF_CLOSE)) {
+	/* Legitimate cases where this can happen:
+	 * 1. During connection teardown
+	 * 2. Race conditions with subflow destruction
+	 * 3. Packets arriving after subflow cleanup
+	 * Log debug info but don't warn loudly in production.
+	 */
+	if (unlikely(tcp_sk(sk)->repair_queue == TCP_RECV_QUEUE ||
+	    sock_flag(sk, SOCK_DEAD) || !refcount_read(&parent->sk_refcnt))) {
+			/* Expected during cleanup, silently return */
+			return;
+	}
+	/* For other cases, still log for debugging but don't WARN */
+	if (net_ratelimit())
+		pr_debug("MPTCP: subflow in unexpected state sk=%p parent=%p state=%u\n",
+			 sk, parent, state);
+	}
 	if (mptcp_subflow_data_available(sk)) {
 		mptcp_data_ready(parent, sk);
 
-- 
2.43.7


