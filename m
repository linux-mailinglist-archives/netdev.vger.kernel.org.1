Return-Path: <netdev+bounces-126685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84C972353
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCCF1C2352E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9731418BC3F;
	Mon,  9 Sep 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdVKyhgy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714F18A6A8;
	Mon,  9 Sep 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912610; cv=none; b=LZBrG2t0EmEsROZqaZ8uHM/RlEN83qFr+jCZy1xZ2gId3qzNEDZt5Ji7kXVgaaLx3kDfN3Qj8OeSCkYF/hZNLX62T6sKh5FZRmf5KZPMowPbFfzmQjXM4d9gMexV1Rl/g6SnkIInoxkipJ3XqtS04q+FqquVl2e8CytK3k0trRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912610; c=relaxed/simple;
	bh=48vNauhZgsf77F3dDTzOTKN2ZwxzuW1y8EmJeMm0Nv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQn/EW3tvim1vBimkchxnUzAHLPVpKQY5pHJJqQcJVMZJGLIBZn21N/F9Pj9qIL/SkPQhqf0UJNi5cZwhvNd4aQ9lzQRP8BKrq9bgYgGMp522+e7kXtzMyxcKZk37u8baspF5J+Nu5FlbAWlkZYcxNuX2cGPxIY0O8p/3W3dSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdVKyhgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD636C4CECD;
	Mon,  9 Sep 2024 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725912609;
	bh=48vNauhZgsf77F3dDTzOTKN2ZwxzuW1y8EmJeMm0Nv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BdVKyhgymkzN3JQ31i1cc2RzwMJ11PlVQRT64oTi8pseeg3r9u1rBNV4oHEza6OXp
	 biu5sExWim+GTShn8LtT439QjUA/bIRTQNyVQTLkJG7Okj/+e/mXHPGaOxlyFB2YHO
	 sZGc3AaDw72E+mhKzMQ4f19KIi6d3gyqYnwKJi3XQghGXuxAyeNfPDmQKwwtfNd3EI
	 sY7Boep7v/4zS6Cjne3kewS9gl5CWe2tU/4p5lljGCXTeKk/j+MYEEL9FfjNHcFSqh
	 3mMTRdnw92Q3qIyIkQkURt0ip4qgbbRlwBfUF+VeBsVjUHn1wpzPyghuQIoft+N59X
	 sFiG3H87MEYqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 09 Sep 2024 22:09:23 +0200
Subject: [PATCH net-next 3/3] mptcp: disable active MPTCP in case of
 blackhole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-net-next-mptcp-fallback-x-mpc-v1-3-da7ebb4cd2a3@kernel.org>
References: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
In-Reply-To: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=13633; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=48vNauhZgsf77F3dDTzOTKN2ZwxzuW1y8EmJeMm0Nv4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm31YQOpvAGEFyOtUS/wjnxZ+7zw8bcP5FvpNRM
 Ba8l1iKwICJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZt9WEAAKCRD2t4JPQmmg
 c/MzEACJKlSMThBPC5XNUMa4duEwxfDfVZFB/V70dBXgQmGrbX7QTYpN+mYUxmYS0/y8Q37RjTG
 7BLVzHjsMHH+9KST+FHfFnTpm0y+9lJWpDoyKVK+B5GkIf8lZq5LPLE/xtQj+XYY40hdz9BL1IQ
 RPUKRkaUiClYgtfleQTOUavg68NIibgYIkrAo0rPBigHbvDZoMil0/DOvDJyn+aGEuMRWrq9fXz
 BzQRavK38CYGkFGrhaFd/fpOhuJ01+CMf+k0OH2O+6trmvUZ0dN75Y+b0cbmFWVx+7WU4QozJTn
 J0e6NSSNaeY3LDLV+9XdA26W/YGfeyYqpcUBLKbrHaLd8jGIK00Cvk6h9nV8+bFFlRPcS7lVJGu
 ZnfTxPyhTtzafEpOA/cZfSFjtVjTeGfOyOj2m6ZeCfW0kC9V0H+yswuiKN4vFEkKvfaezwPBeAM
 5qevnT4IlRegceWEt3BLy3oqwPXoRZo854f+kJrIhYKp9LRFL+o4hNVi4lgUlFfdD7wyMoXdR41
 Im5edL8vjTh7zFihrrY6JnSHN8DVxNrmAU8+KAioew6Cb2dT2axK+LWrCcBUSQqaxdFJTjBFlNU
 RDDqxeJqdMDcWBZ8aP/xnykIsH/h4B6pJQzQrC/vc769iiU7Z1T2SAcBQDnYA+O8FleDGDnjM5z
 CbmNsFrUN/z7/GA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

An MPTCP firewall blackhole can be detected if the following SYN
retransmission after a fallback to "plain" TCP is accepted.

In case of blackhole, a similar technique to the one in place with TFO
is now used: MPTCP can be disabled for a certain period of time, 1h by
default. This time period will grow exponentially when more blackhole
issues get detected right after MPTCP is re-enabled and will reset to
the initial value when the blackhole issue goes away.

The blackhole period can be modified thanks to a new sysctl knob:
blackhole_timeout. Two new MIB counters help understanding what's
happening:

- 'Blackhole', incremented when a blackhole is detected.
- 'MPCapableSYNTXDisabled', incremented when an MPTCP connection
  directly falls back to TCP during the blackhole period.

Because the technique is inspired by the one used by TFO, an important
part of the new code is similar to what can find in tcp_fastopen.c, with
some adaptations to the MPTCP case.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/57
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst |  11 +++
 net/mptcp/ctrl.c                          | 121 +++++++++++++++++++++++++++++-
 net/mptcp/mib.c                           |   2 +
 net/mptcp/mib.h                           |   2 +
 net/mptcp/protocol.c                      |  11 ++-
 net/mptcp/protocol.h                      |   8 +-
 net/mptcp/subflow.c                       |   4 +
 7 files changed, 151 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index fd514bba8c43..95598c21fc8e 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -34,6 +34,17 @@ available_schedulers - STRING
 	Shows the available schedulers choices that are registered. More packet
 	schedulers may be available, but not loaded.
 
+blackhole_timeout - INTEGER (seconds)
+	Initial time period in second to disable MPTCP on active MPTCP sockets
+	when a MPTCP firewall blackhole issue happens. This time period will
+	grow exponentially when more blackhole issues get detected right after
+	MPTCP is re-enabled and will reset to the initial value when the
+	blackhole issue goes away.
+
+	0 to disable the blackhole detection.
+
+	Default: 3600
+
 checksum_enabled - BOOLEAN
 	Control whether DSS checksum can be enabled.
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 0b23e3c5e8ff..38d8121331d4 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -28,8 +28,11 @@ struct mptcp_pernet {
 #endif
 
 	unsigned int add_addr_timeout;
+	unsigned int blackhole_timeout;
 	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
+	atomic_t active_disable_times;
+	unsigned long active_disable_stamp;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
@@ -88,6 +91,8 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->blackhole_timeout = 3600;
+	atomic_set(&pernet->active_disable_times, 0);
 	pernet->close_timeout = TCP_TIMEWAIT_LEN;
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
@@ -152,6 +157,20 @@ static int proc_available_schedulers(const struct ctl_table *ctl,
 	return ret;
 }
 
+static int proc_blackhole_detect_timeout(const struct ctl_table *table,
+					 int write, void *buffer, size_t *lenp,
+					 loff_t *ppos)
+{
+	struct mptcp_pernet *pernet = mptcp_get_pernet(current->nsproxy->net_ns);
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (write && ret == 0)
+		atomic_set(&pernet->active_disable_times, 0);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -218,6 +237,13 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
 	},
+	{
+		.procname = "blackhole_timeout",
+		.maxlen = sizeof(unsigned int),
+		.mode = 0644,
+		.proc_handler = proc_blackhole_detect_timeout,
+		.extra1 = SYSCTL_ZERO,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -241,6 +267,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[6].data = &pernet->scheduler;
 	/* table[7] is for available_schedulers which is read-only info */
 	table[8].data = &pernet->close_timeout;
+	table[9].data = &pernet->blackhole_timeout;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
@@ -278,6 +305,88 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
 
 #endif /* CONFIG_SYSCTL */
 
+/* The following code block is to deal with middle box issues with MPTCP,
+ * similar to what is done with TFO.
+ * The proposed solution is to disable active MPTCP globally when SYN+MPC are
+ * dropped, while SYN without MPC aren't. In this case, active side MPTCP is
+ * disabled globally for 1hr at first. Then if it happens again, it is disabled
+ * for 2h, then 4h, 8h, ...
+ * The timeout is reset back to 1hr when a successful active MPTCP connection is
+ * fully established.
+ */
+
+/* Disable active MPTCP and record current jiffies and active_disable_times */
+void mptcp_active_disable(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	struct mptcp_pernet *pernet;
+
+	pernet = mptcp_get_pernet(net);
+
+	if (!READ_ONCE(pernet->blackhole_timeout))
+		return;
+
+	/* Paired with READ_ONCE() in mptcp_active_should_disable() */
+	WRITE_ONCE(pernet->active_disable_stamp, jiffies);
+
+	/* Paired with smp_rmb() in mptcp_active_should_disable().
+	 * We want pernet->active_disable_stamp to be updated first.
+	 */
+	smp_mb__before_atomic();
+	atomic_inc(&pernet->active_disable_times);
+
+	MPTCP_INC_STATS(net, MPTCP_MIB_BLACKHOLE);
+}
+
+/* Calculate timeout for MPTCP active disable
+ * Return true if we are still in the active MPTCP disable period
+ * Return false if timeout already expired and we should use active MPTCP
+ */
+bool mptcp_active_should_disable(struct sock *ssk)
+{
+	struct net *net = sock_net(ssk);
+	unsigned int blackhole_timeout;
+	struct mptcp_pernet *pernet;
+	unsigned long timeout;
+	int disable_times;
+	int multiplier;
+
+	pernet = mptcp_get_pernet(net);
+	blackhole_timeout = READ_ONCE(pernet->blackhole_timeout);
+
+	if (!blackhole_timeout)
+		return false;
+
+	disable_times = atomic_read(&pernet->active_disable_times);
+	if (!disable_times)
+		return false;
+
+	/* Paired with smp_mb__before_atomic() in mptcp_active_disable() */
+	smp_rmb();
+
+	/* Limit timeout to max: 2^6 * initial timeout */
+	multiplier = 1 << min(disable_times - 1, 6);
+
+	/* Paired with the WRITE_ONCE() in mptcp_active_disable(). */
+	timeout = READ_ONCE(pernet->active_disable_stamp) +
+		  multiplier * blackhole_timeout * HZ;
+
+	return time_before(jiffies, timeout);
+}
+
+/* Enable active MPTCP and reset active_disable_times if needed */
+void mptcp_active_enable(struct sock *sk)
+{
+	struct mptcp_pernet *pernet = mptcp_get_pernet(sock_net(sk));
+
+	if (atomic_read(&pernet->active_disable_times)) {
+		struct dst_entry *dst = sk_dst_get(sk);
+
+		if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))
+			atomic_set(&pernet->active_disable_times, 0);
+	}
+}
+
 /* Check the number of retransmissions, and fallback to TCP if needed */
 void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 {
@@ -290,10 +399,14 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 	timeouts = inet_csk(ssk)->icsk_retransmits;
 	subflow = mptcp_subflow_ctx(ssk);
 
-	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT &&
-	    (timeouts == 2 || (timeouts < 2 && expired))) {
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
-		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
+	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
+		if (timeouts == 2 || (timeouts < 2 && expired)) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
+			subflow->mpc_drop = 1;
+			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
+		} else {
+			subflow->mpc_drop = 0;
+		}
 	}
 }
 
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index d70a3e2bfad6..38c2efc82b94 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -16,6 +16,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableSYNTXDrop", MPTCP_MIB_MPCAPABLEACTIVEDROP),
+	SNMP_MIB_ITEM("MPCapableSYNTXDisabled", MPTCP_MIB_MPCAPABLEACTIVEDISABLED),
 	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
@@ -74,6 +75,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
 	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
+	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 062775700b63..c8ffe18a8722 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -11,6 +11,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEDROP,	/* Client-side fallback due to a MPC drop */
+	MPTCP_MIB_MPCAPABLEACTIVEDISABLED, /* Client-side disabled due to past issues */
 	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
@@ -75,6 +76,7 @@ enum linux_mptcp_mib_field {
 					 */
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
 	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
+	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cbbcc46cfef0..c2317919fc14 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3737,9 +3737,14 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
 		mptcp_subflow_early_fallback(msk, subflow);
 #endif
-	if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
-		mptcp_subflow_early_fallback(msk, subflow);
+	if (subflow->request_mptcp) {
+		if (mptcp_active_should_disable(sk)) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
+			mptcp_subflow_early_fallback(msk, subflow);
+		} else if (mptcp_token_new_connect(ssk) < 0) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
+			mptcp_subflow_early_fallback(msk, subflow);
+		}
 	}
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 302bd808b839..74417aae08d0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -531,7 +531,8 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
-		__unused : 9;
+		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
@@ -697,6 +698,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+
+void mptcp_active_disable(struct sock *sk);
+bool mptcp_active_should_disable(struct sock *ssk);
+void mptcp_active_enable(struct sock *sk);
+
 void mptcp_get_available_schedulers(char *buf, size_t maxlen);
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 				       struct mptcp_subflow_context *subflow,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b9b14e75e8c2..1040b3b9696b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -546,6 +546,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_capable = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
+		mptcp_active_enable(parent);
 		mptcp_propagate_state(parent, sk, subflow, &mp_opt);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
@@ -591,6 +592,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
 		}
 	} else if (mptcp_check_fallback(sk)) {
+		/* It looks like MPTCP is blocked, while TCP is not */
+		if (subflow->mpc_drop)
+			mptcp_active_disable(parent);
 fallback:
 		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}

-- 
2.45.2


