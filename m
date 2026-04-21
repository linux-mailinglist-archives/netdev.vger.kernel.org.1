Return-Path: <netdev+bounces-280171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIe8GgqY52mp+AEAu9opvQ
	(envelope-from <netdev+bounces-280171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:30:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4642F43CBFA
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 592AC30314AD
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FB83D9026;
	Tue, 21 Apr 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C45U6ZqM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314623D8910
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784949; cv=none; b=El+VQFogyK4HMUY2ynhue0cB4MQfKEsqUyjx1KcphA16SATZFENu3XZHPOudGATw65SDNbzaBiztAC93CS6riBVsIIxSm8K97SICFMvtHGmSp5vd7LRcUrmi6pYAxNd3K8Qj9PoQRkk2juQIUb0ZuMBn1re6O7zfRaZrSGAo8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784949; c=relaxed/simple;
	bh=Y13M/z1PUkRYdx6T147SQvL+8nHPZtZjHP2OD6TEy6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paPxtE8kkIlQNsS8Tbh9CNXcnV8ZgYfUpdwdo93Aun/B3MmLL8VB0NGJ5+DngL3Ph+Dqp9gCqkjZJ/pSTdMLF19i/sggMvH6b+b+TXdiOgzDu6kMEXcDgeCqLlQo6Mx3uhAv1a6mNKulwBXQM68H1MP5lKs8qvX9vyNB5ph+oBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C45U6ZqM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3037433f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784946; x=1777389746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vQyN4XtQNgy58qiSyngDxgLbuPWflaYDxCcpF1TE+w=;
        b=C45U6ZqMNPDjcIecGV5PZjiiuzhRTlihC6pAQIUvwzJw3T9Ez2thtTcFz5J/B0K6JF
         AW9cGaGCaeKhjZ4z9ywvX+l9OpYeRJ5j4qGhHcjao2oN+MlXgNZqgzs6ZSYmCe5R9YYI
         oivrBqzkW5E+ztNQs0HfO7wOVA1bRL8DwJRDBdrOULv1/UYAbodF3TxOP/Aj4uwvnNA2
         VChx1odLMzxPc/DlWtA4or8skljTzaUt9UdZRYExv1I4P0JE9s06aXr/pCIPb+SRxjr+
         epeX8Pe7FVE6uM8gLEkuUOL2rdfjuT65K7zpblEJVT4t7jdRg8/uXNs8RFEpRKFitbIT
         wHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784946; x=1777389746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vQyN4XtQNgy58qiSyngDxgLbuPWflaYDxCcpF1TE+w=;
        b=UH1ti2nP7+K/8ZzNJxMg1sZJ7cNR9DXuZXk50E8ezTpdVHJgPtubtb8wA0/dU5w7z3
         3WxJ452C5fDxqbOnt5Mj3GHWYUkquLlOG3WgBG+I0P5men8RrslRRFP50hAhyTkqBbow
         XibucEW9pItzqbrDxGQz0aQTxpLKA8Dyyd3CowHyzQhqCgjvWpsES0u935D2cy84d4p8
         9pfd/H5SF3DKSSxu1H7Q+9ZxmN7Rqa6+skPGJ/gLtjIZ8WU74C0ZmDlLSY2jXfpTUeMg
         8ucChdf6ZvotlnOR1YiTcV0UVNJYXZh+Fi9XJETAKuIzaaK6l7Fs4L25sFzKuuqDHIf8
         hrRQ==
X-Gm-Message-State: AOJu0YxeGHteiA9+eAigdpaKhlJnX2i+gUlYP1toXSAI2nOrHZRp6s+Z
	XiIxxfZ0/s9CT7x0Knj6efIXtNtHqQQf2eNfISBZRDp1yofOYidNswYRxMPcR1Pu
X-Gm-Gg: AeBDievixiwdZxMu6AY9ea0enHJLjpo6Pf2ZHRDicrsm2S/Vj6NC7mhDiBCsin9U5nt
	9VbqpXdsXjtKOkqRpQFFH9HunpM86uFu+Sowqmn80SyqDHUfwulB57ga2sttNaJ5dERsijLmhVF
	M1Htt8ZiTP9ti1fZO7MQGobBg4o1J9BJxKYNRJYjKqS5fHcCRj6g9Sdsh1B+FbgOaVhdj6ikpib
	vNA4Ujm0kP3F2UsTVgTr30iq+BdkdpC/VkDzHYPDgP7uRwbJZk3VbM9kG+OAZhAR+gvB9ZFS0u3
	Ah45KzK6L1P7YdLBv5w57qcPTDA5E4rSQsLcV0JUrg082DMfmgGIL+qFnoHDZW+MV5fFnRdzH76
	3IUXlZYUXjfbAWrjmG6+DJ4qEy0b9/BsThANAMYfi1jaUX4CNp6hOKALOPBh9GS/a6Ua5Be2jfs
	V+3und0gR1YX78cbhiIPA7BjCDMz9mw8a1T2VzIjmxhLe6IMQ8XfPdkBrp9giVovfoBZRxTv8du
	kpTsPUtNHUCUgAfD+kxBg==
X-Received: by 2002:a05:6000:250e:b0:439:b440:b8a2 with SMTP id ffacd0b85a97d-43fe3dfba35mr27902238f8f.28.1776784945891;
        Tue, 21 Apr 2026 08:22:25 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm8975225f8f.1.2026.04.21.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:22:25 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 2/3] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Tue, 21 Apr 2026 16:22:10 +0100
Message-ID: <20260421152216.38127-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421152216.38127-1-devnexen@gmail.com>
References: <20260421152216.38127-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280171-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4642F43CBFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Handle MSG_ERRQUEUE on the MPTCP socket by selecting a subflow with
pending errqueue data, moving one error skb to the parent socket, and
consuming it through the parent socket ABI.

This surfaces subflow errqueue activity through poll(), keeps the
userspace ABI tied to the socket being used, and restores the skb to
the subflow errqueue if requeueing to the parent fails under rmem
pressure.

Signed-off-by: David Carlier <devnexen@gmail.com>
Assisted-by: Codex:gpt-5
---
 net/mptcp/protocol.c | 121 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbffd3a43fe8..1b2e3bede122 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -819,26 +819,29 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
 	int ssk_state;
 	int err;
+	bool has_errqueue;
 
-	/* only propagate errors on fallen-back sockets or
-	 * on MPC connect
-	 */
-	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
-		return false;
-
+	has_errqueue = !skb_queue_empty_lockless(&ssk->sk_error_queue);
 	err = sock_error(ssk);
-	if (!err)
+	if (!err && !has_errqueue)
 		return false;
 
-	/* We need to propagate only transition to CLOSE state.
-	 * Orphaned socket will see such state change via
-	 * subflow_sched_work_if_closed() and that path will properly
-	 * destroy the msk as needed.
+	/* Errqueue notifications should wake poll()/recvmsg(MSG_ERRQUEUE) on
+	 * the MPTCP socket, but only fallback sockets and the MPC connect path
+	 * inherit TCP's sk_err semantics.
 	 */
-	ssk_state = inet_sk_state_load(ssk);
-	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-		mptcp_set_state(sk, ssk_state);
-	WRITE_ONCE(sk->sk_err, -err);
+	if (err &&
+	    (sk->sk_state == TCP_SYN_SENT || __mptcp_check_fallback(mptcp_sk(sk)))) {
+		/* We need to propagate only transition to CLOSE state.
+		 * Orphaned socket will see such state change via
+		 * subflow_sched_work_if_closed() and that path will properly
+		 * destroy the msk as needed.
+		 */
+		ssk_state = inet_sk_state_load(ssk);
+		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+			mptcp_set_state(sk, ssk_state);
+		WRITE_ONCE(sk->sk_err, -err);
+	}
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 	smp_wmb();
@@ -2286,6 +2289,68 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
+static struct sock *mptcp_pick_errqueue_subflow(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk = NULL;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		struct sock *subflow_sk = mptcp_subflow_tcp_sock(subflow);
+
+		if (skb_queue_empty_lockless(&subflow_sk->sk_error_queue))
+			continue;
+
+		if (!refcount_inc_not_zero(&subflow_sk->sk_refcnt))
+			continue;
+
+		ssk = subflow_sk;
+		break;
+	}
+	release_sock(sk);
+
+	return ssk;
+}
+
+static bool mptcp_has_error_queue(const struct sock *sk)
+{
+	return !skb_queue_empty_lockless(&sk->sk_error_queue);
+}
+
+static int mptcp_recv_error(struct sock *sk, struct msghdr *msg, int len)
+{
+	struct sk_buff *skb;
+	struct sock *ssk;
+	int ret, ret2;
+
+	if (mptcp_has_error_queue(sk))
+		return inet_recv_error(sk, msg, len);
+
+	ssk = mptcp_pick_errqueue_subflow(sk);
+	if (!ssk)
+		return -EAGAIN;
+
+	skb = sock_dequeue_err_skb(ssk);
+	if (!skb)
+		goto put_ssk;
+
+	ret = sock_queue_err_skb(sk, skb);
+	if (ret) {
+		ret2 = sock_queue_err_skb(ssk, skb);
+		sock_put(ssk);
+		if (ret2)
+			kfree_skb(skb);
+		return ret;
+	}
+
+	sock_put(ssk);
+	return inet_recv_error(sk, msg, len);
+
+put_ssk:
+	sock_put(ssk);
+	return -EAGAIN;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags)
 {
@@ -2295,9 +2360,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len);
+		return mptcp_recv_error(sk, msg, len);
 
 	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
@@ -4296,6 +4360,26 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	return 0;
 }
 
+static bool mptcp_subflow_has_error(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	bool has_error = false;
+
+	mptcp_data_lock(sk);
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (READ_ONCE(ssk->sk_err) ||
+		    !skb_queue_empty_lockless(&ssk->sk_error_queue)) {
+			has_error = true;
+			break;
+		}
+	}
+	mptcp_data_unlock(sk);
+
+	return has_error;
+}
+
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
@@ -4339,7 +4423,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) || mptcp_has_error_queue(sk) ||
+	    mptcp_subflow_has_error(sk))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0


