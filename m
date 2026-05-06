Return-Path: <netdev+bounces-284956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ+OGMRy+2lgbQMAu9opvQ
	(envelope-from <netdev+bounces-284956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:56:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF244DE730
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9A6530185B2
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B44A1382;
	Wed,  6 May 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTiSChjf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3924968E1
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086571; cv=none; b=YRATQwZ8wl9lFi27EJM5lGrCk13E4cSn74XwucQZupbv5Ahdl4YiBIsLitmuONsAaBN0OyeeQ3hE38jcK9My8FC5caIe5ELMhEN60BitKIGBA1cAx0OOfLG21zCsmbFIDw8vKaywM0LS4eTeXy0hGzfueQkQkFchwX/D1Loj81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086571; c=relaxed/simple;
	bh=EqNU8Yrd0TXiupxHPwzxKotS3UioELwzqEx0ic4rLgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2ChT1/6r+g2QvLAko93mc4fyiohgW9Ge0SYVQFdMPFmCcd83uNgNTAF4sUvU7Fb+90aW2JhWjppUxnDoIfF4P3XK0fOZp1AXSlFRQO+mlUdH5A6i9DSxH3q0Yqzg6kDk77Gej+hijQ74OG0FjYiY+bPRwOsmaSBZFtpHrjBnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTiSChjf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so75165305e9.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086568; x=1778691368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzDki06gKQpjz5uZEWAJE/Td9F8aqZ6hehFHrs+9QQs=;
        b=QTiSChjfJlQI3Gu3Pwhcbf3tuq5lHhIUUifylDss2l8Ih78C9BtBgKe56zf+ps+UgD
         pjJ2aZusfdXDU67WuyVQ6pG9Bt3266tF0JWDbHLMGHO4iUEZJtCXl24rfNO0dHyeT1vD
         gLQ6AaiEhdQcC/iB50f44ufb5TVttzDVI9jOLlrtKuYsTnHNRhRp3kY9utmFIWoD46sK
         xaxkh1UwAmiwunXpNh68CkTnRP2RGaN8Naixi/tDulLeY9QNo8p74quCoXlIc95w4EVa
         NgeewQGyOHsY9Ah/N8+v7EAcaTpht6lsc0eliY115gJWkQaHsqKsjsPyCs/wzPasvKwo
         v94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086568; x=1778691368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xzDki06gKQpjz5uZEWAJE/Td9F8aqZ6hehFHrs+9QQs=;
        b=g2U+DaJbjfyOnbZvi2VYUPwrlYGPx7t9cRHoz7WqirgQXU6KLpXSCusSNe4fZx5gvJ
         g2/ml9rzq9NtgsbIvQ8ZIlUel4UcZEhfknFJTDGMlfok5Pm3zrIR+YB9CAoiGYFwMwOL
         ve/X/U50B/IV+rOqNJU6iQ7ZPzznymP6w8Y5+ulF3/5BewN+DiD/nPueBqBPGqdkVbY+
         Fx3xSDyyaXnhcPBIGL5jKhfkcQyeORsIxNe0nUWqGLylOvmur8ZfXYoQBtBPfbTOolq1
         EdzlFwqRszSqcejYcauwk8HzStpw/7S8HTmhuZ3sk30rmb0m31zt19xGRzIshA8b/vtI
         bx3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/l4KbkNbw/gnw//lsGPMNtjiwThsJ5hDNLgeMMoNG2muB1UfmbWTyLl9uGHeqfsTkPns7JosI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+a+Vob85liXu4GtgfC5+Zw15eOXPrx0/tsUSqbD8arXcSZ9y
	DxhPE46A7aXIfJH/bSG0jC5AvKAoVqaa9rnU1LvkqIQF9DUMRz3By+RSUAZlOTxx7HA=
X-Gm-Gg: AeBDietGDabc4if211Cd8lpsTnZFfW+RsoEGtM1ZCUGLqB4kS4Kac6s5oStLo94cZbL
	OvHZAZoOV3v2wE5lR+vl0rHEg8gLuOynHmG24xEpRQpLarBFNltC61IfSjt77BMI+/R77pSM09T
	uwu4b9awOZmdUPSXAb8oQAPzJvazX7U58BTcd+qzVL7YYlCJyBLkYPOSANn0qBA8CUuB3W03kJz
	ybGfU9I1vPgFvOtadSXXT6tLSC0JLpmo41yukpdUSmm4jq7pj/kutIx0Y+P+dtelDEln7utghTc
	0MfCVIa0duKXwtY3xiTbWBFRrhbsiTd2X9Hiu+bpe5RFRvrSlY3f4aCGdi0AVxBSUKMFymtzVR+
	uPcJTm7Tf9XBZlZkK/ygZcF9BpZkC4tmKHgy/xUg8ZMVIHBq4ttreQXpmmuCLiPvfLXoT4EKdG+
	VdNYBleTEG0mtPu/uZJXoiG553R9cDI07U0GWGn3+IlXGMf2cLuS4WSJb3+almZBGbaxGs7lpud
	59LOdRfZGxQkj6cETMG6w==
X-Received: by 2002:a05:600c:3e8d:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-48e51f40b12mr79389955e9.22.1778086567804;
        Wed, 06 May 2026 09:56:07 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:07 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Wed,  6 May 2026 17:55:55 +0100
Message-ID: <2b6d945e90f64cb8b18cf866faf8f1a66683152b.1778086500.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778086500.git.devnexen@gmail.com>
References: <cover.1778086500.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCF244DE730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284956-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Splice pending err skbs from each subflow's error queue onto the parent
msk's error queue at error-report time, so poll() and recvmsg(MSG_ERRQUEUE)
on the parent socket observe TX timestamps and MSG_ZEROCOPY completion
notifications through the standard inet ABI.

The splice filters by SO_EE_ORIGIN: TIMESTAMPING / ZEROCOPY / LOCAL
events forward to the parent because they are tied to user-handed data,
not to a specific path; subflow-level ICMP errors are dropped because
the legacy RECVERR ABI cannot meaningfully convey their per-subflow peer
identity to single-path-aware userspace. Such events will be carried by
a future MPTCP_RECERR channel.

mptcp_recv_error() retries the splice on the pull side: if
sock_queue_err_skb() previously failed under rmem pressure, the skb
stays on the subflow queue, and the next recvmsg(MSG_ERRQUEUE) splices
it once the parent's queue has been drained.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 74 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0db50e3715c3..203ee37f57e0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/errqueue.h>
 #include <net/aligned_data.h>
 #include <net/rps.h>
 #include <net/sock.h>
@@ -815,21 +816,52 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool mptcp_errqueue_skb_forwardable(const struct sk_buff *skb)
+{
+	u8 origin = SKB_EXT_ERR(skb)->ee.ee_origin;
+
+	return origin == SO_EE_ORIGIN_TIMESTAMPING ||
+		origin == SO_EE_ORIGIN_ZEROCOPY ||
+		origin == SO_EE_ORIGIN_LOCAL;
+}
+
+static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
+{
+	struct sk_buff *skb;
+	bool moved = false;
+
+	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {
+		if (!mptcp_errqueue_skb_forwardable(skb)) {
+			kfree_skb(skb);  /* path-specific (ICMP) — belongs in MPTCP_RECERR */
+			continue;
+		}
+		if (sock_queue_err_skb(sk, skb)) {
+			skb_queue_head(&ssk->sk_error_queue, skb);
+			break;
+		}
+		moved = true;
+	}
+
+	return moved;
+}
+
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
 	int ssk_state;
+	bool report;
 	int err;
 
+	report = __mptcp_subflow_splice_errqueue(sk, ssk);
+
 	/* only propagate errors on fallen-back sockets or
 	 * on MPC connect
 	 */
 	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
-		return false;
+		goto out;
 
 	err = sock_error(ssk);
 	if (!err)
-		return false;
-
+		goto out;
 	/* We need to propagate only transition to CLOSE state.
 	 * Orphaned socket will see such state change via
 	 * subflow_sched_work_if_closed() and that path will properly
@@ -839,6 +871,11 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
 		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
+	report = true;
+
+out:
+	if (!report)
+		return false;
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 	smp_wmb();
@@ -2286,6 +2323,31 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
+static int mptcp_recv_error(struct sock *sk, struct msghdr *msg, int len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	int ret;
+
+	/* Drain the parent first: a previous splice may have failed under
+	 * rmem pressure and the skb stayed on a subflow. Freeing space here
+	 * lets the splice below succeed; sock_queue_err_skb() then re-asserts
+	 * EPOLLERR so userspace knows to drain again on the next poll.
+	 */
+	ret = inet_recv_error(sk, msg, len);
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (!skb_queue_empty_lockless(&ssk->sk_error_queue))
+			__mptcp_subflow_splice_errqueue(sk, ssk);
+	}
+	release_sock(sk);
+
+	return ret;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags)
 {
@@ -2295,9 +2357,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len);
+		return mptcp_recv_error(sk, msg, len);
 
 	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
@@ -4340,7 +4401,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0


