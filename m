Return-Path: <netdev+bounces-43640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10377D412B
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FFD281626
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6D579EC;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHnAtImy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034876AAE;
	Mon, 23 Oct 2023 20:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7020CC433CA;
	Mon, 23 Oct 2023 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093933;
	bh=o1HCQ1dOhPEC+TSq7N6CCYqvYtbLIm8iE9Kh+2gyczg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jHnAtImyKwZTBYcT/jMHG3/vyR55ck0Z5QT/qR1LdU2/mwDiWkyZf/zi8CemwqFEu
	 FbHa9V9R532FnCNpiW9DYkEzDyuCV7UAtElj+4vds3d6zgAevAhRPdL6TexEL6cGHa
	 Eo6eMAWlwOVMmk/xy6M8rqcvg5NQSoS0U9W+6bSRVqyHqdYLMOzIyj03pkKNpMIlTZ
	 d/7SljtxgIrfDC5QcgRIe36WpCZGKkZYUwEKK0ZigIDpNwNLsGIgJVuP1Lvqd/KOy7
	 xTvs5WSJ5JC2vuUzuACPDNIQ1l9i1hXN3JzOT3io9y7UJuboQBgjpfcB5IPVKo3GcA
	 6p1G4XH1g2N6w==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 13:44:34 -0700
Subject: [PATCH net-next 1/9] mptcp: add a new sysctl for make after break
 timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-2-v1-1-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol allows sockets with no alive subflows to stay
in ESTABLISHED status for and user-defined timeout, to allow for
later subflows creation.

Currently such timeout is constant - TCP_TIMEWAIT_LEN. Let the
user-space configure them via a newly added sysctl, to better cope
with busy servers and simplify (make them faster) the relevant
pktdrill tests.

Note that the new know does not apply to orphaned MPTCP socket
waiting for the data_fin handshake completion: they always wait
TCP_TIMEWAIT_LEN.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 11 +++++++++++
 net/mptcp/ctrl.c                          | 16 ++++++++++++++++
 net/mptcp/protocol.c                      |  6 +++---
 net/mptcp/protocol.h                      |  1 +
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 15f1919d640c..69975ce25a02 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -25,6 +25,17 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
+close_timeout - INTEGER (seconds)
+	Set the make-after-break timeout: in absence of any close or
+	shutdown syscall, MPTCP sockets will maintain the status
+	unchanged for such time, after the last subflow removal, before
+	moving to TCP_CLOSE.
+
+	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
+	sysctl.
+
+	Default: 60
+
 checksum_enabled - BOOLEAN
 	Control whether DSS checksum can be enabled.
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index e72b518c5d02..13fe0748dde8 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -27,6 +27,7 @@ struct mptcp_pernet {
 #endif
 
 	unsigned int add_addr_timeout;
+	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
@@ -65,6 +66,13 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
 	return mptcp_get_pernet(net)->stale_loss_cnt;
 }
 
+unsigned int mptcp_close_timeout(const struct sock *sk)
+{
+	if (sock_flag(sk, SOCK_DEAD))
+		return TCP_TIMEWAIT_LEN;
+	return mptcp_get_pernet(sock_net(sk))->close_timeout;
+}
+
 int mptcp_get_pm_type(const struct net *net)
 {
 	return mptcp_get_pernet(net)->pm_type;
@@ -79,6 +87,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->close_timeout = TCP_TIMEWAIT_LEN;
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
@@ -141,6 +150,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dostring,
 	},
+	{
+		.procname = "close_timeout",
+		.maxlen = sizeof(unsigned int),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_jiffies,
+	},
 	{}
 };
 
@@ -163,6 +178,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
 	table[6].data = &pernet->scheduler;
+	table[7].data = &pernet->close_timeout;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 886ab689a8ae..a21f8ed26343 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2391,8 +2391,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (msk->in_accept_queue && msk->first == ssk &&
 	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
 		/* ensure later check in mptcp_worker() will dispose the msk */
-		mptcp_set_close_tout(sk, tcp_jiffies32 - (TCP_TIMEWAIT_LEN + 1));
 		sock_set_flag(sk, SOCK_DEAD);
+		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
 		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
 		goto out_release;
@@ -2516,7 +2516,7 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
 		return false;
 
 	return time_after32(tcp_jiffies32,
-		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
+		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
 }
 
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
@@ -2659,7 +2659,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 		return;
 
 	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
-			TCP_TIMEWAIT_LEN;
+			mptcp_close_timeout(sk);
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3612545fa62e..02556921bc6c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -613,6 +613,7 @@ unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
+unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,

-- 
2.41.0


