Return-Path: <netdev+bounces-189700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B138AB33AC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2C83A66B5
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF5268689;
	Mon, 12 May 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vY/0/WVH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cTCln+Tg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252A267AF0
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042071; cv=none; b=hIo5io8vWeqBHP5irFKDvJwiUbCZ7fQQxPiTfCJ0tmQqaTUFCQZCGYLC9QK3j7zg4TjE086kF/yqvgiXCOaXjn1ALZHBUdVA2JOr6XgkXUQ/5tWyGJ+1qXJK8RdRfcHmTfAgXP8k5WWtsX00cRLSDUrFCMJCA6msyXGpIXYNTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042071; c=relaxed/simple;
	bh=VXleKi/U/kMgP7jABQMiZxQCqP98FQpEysCuzMoNYOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OycCuNr3LrUSU2RPBw6oChiSgAsbB6oPOWan6+R6pni8h+Yr4A6JARsegmvR2LVkOimMQv8+8ObEBOfIElAxks6J90VDWmKGWTK0cyHwjW7lOGYzJgWqEBep5lSqtqt8QOUCPGhF5lvnqkoU/ljnbzXqZx5Ocguz//mWB6nRK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vY/0/WVH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cTCln+Tg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqlT1nY5GZsGQPH1WnHjRykG1pCxKAGysrL3Y4gboDY=;
	b=vY/0/WVHE2Kh0Lty8SbEQ0pxO7rnjMQnxHvhCtQ7onLBIxCaVcjSWKMAkJKVBmeH5OJ6kB
	TVvA0LvM5lcxMRNkso+MsCJfhXT6nxhDCgXG2xyOXV5kR4kHXJf9wgb12ISP1LUEFGcOhy
	1c2TDJpCLdMVN4cfStdN5hDWrAKah6HPwfrgy0CYrjbiRE6Mao+WNqDNu6bt3M4SSBl8Vn
	s7m+M+TCPCEg6Qa5f/eXWkHq5bRNz1Oay1di6mxlz2egPFB1B65sq4HaOtxQR2fFk8Z++K
	vo0qtgMbZW5yxxBpRGL8Ux44kH/T7tZ6WDOQ+tLwJ3vtQoVl/bmUIe1H/9U2yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqlT1nY5GZsGQPH1WnHjRykG1pCxKAGysrL3Y4gboDY=;
	b=cTCln+TgL4Q8HPXyPPIvzWnnmeP7qtVA/FTQQiElQKZlvk7MEskxG0khpq0eFe3yspK2Ai
	+2v2UFcOoPIlbSDw==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH net-next v4 12/15] mptcp: Use nested-BH locking for hmac_storage
Date: Mon, 12 May 2025 11:27:33 +0200
Message-ID: <20250512092736.229935-13-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_delegated_actions is a per-CPU variable and relies on disabled BH for=
 its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT this d=
ata
structure requires explicit locking.

Add a local_lock_t to the data structure and use local_lock_nested_bh() for
locking. This change adds only lockdep coverage and does not alter the
functional behaviour for !PREEMPT_RT.

Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 9 ++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 44f7ab463d755..b6cb93a3f9a2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -46,7 +46,9 @@ static struct percpu_counter mptcp_sockets_allocated ____=
cacheline_aligned_in_sm
 static void __mptcp_destroy_sock(struct sock *sk);
 static void mptcp_check_send_data_fin(struct sock *sk);
=20
-DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
+DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions) =3D=
 {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
 static struct net_device *mptcp_napi_dev;
=20
 /* Returns end sequence number of the receiver's advertised window */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d409586b5977f..88cc2a857adce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -479,6 +479,7 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
=20
 struct mptcp_delegated_action {
 	struct napi_struct napi;
+	local_lock_t bh_lock;
 	struct list_head head;
 };
=20
@@ -670,9 +671,11 @@ static inline void mptcp_subflow_delegate(struct mptcp=
_subflow_context *subflow,
 		if (WARN_ON_ONCE(!list_empty(&subflow->delegated_node)))
 			return;
=20
+		local_lock_nested_bh(&mptcp_delegated_actions.bh_lock);
 		delegated =3D this_cpu_ptr(&mptcp_delegated_actions);
 		schedule =3D list_empty(&delegated->head);
 		list_add_tail(&subflow->delegated_node, &delegated->head);
+		local_unlock_nested_bh(&mptcp_delegated_actions.bh_lock);
 		sock_hold(mptcp_subflow_tcp_sock(subflow));
 		if (schedule)
 			napi_schedule(&delegated->napi);
@@ -684,11 +687,15 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_a=
ction *delegated)
 {
 	struct mptcp_subflow_context *ret;
=20
-	if (list_empty(&delegated->head))
+	local_lock_nested_bh(&mptcp_delegated_actions.bh_lock);
+	if (list_empty(&delegated->head)) {
+		local_unlock_nested_bh(&mptcp_delegated_actions.bh_lock);
 		return NULL;
+	}
=20
 	ret =3D list_first_entry(&delegated->head, struct mptcp_subflow_context, =
delegated_node);
 	list_del_init(&ret->delegated_node);
+	local_unlock_nested_bh(&mptcp_delegated_actions.bh_lock);
 	return ret;
 }
=20
--=20
2.49.0


