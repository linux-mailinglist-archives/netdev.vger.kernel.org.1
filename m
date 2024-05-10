Return-Path: <netdev+bounces-95414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227B48C22FD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B401F2189B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ABA17085C;
	Fri, 10 May 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvEo+gQT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870C170858;
	Fri, 10 May 2024 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339947; cv=none; b=GRz1O/UZQ+xvhlVT98IMQNOCZ9QextrBWHdvAVjHhyDJNTHVCbcxMxzCyao2ORAVcu1Hsxli+HX64jU6+ngZBZhu528f5APnOT4t7UwXKium/HGu969CyH056E/GZDgl/cNdlOMziYGhnI9ThGAC8s0uff96de8FbX1RDBeLbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339947; c=relaxed/simple;
	bh=mn3cUeuni9YG0Wzwevr2Z6WMUjH1cMxpP/hJKuF0rmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CF5of2ofTXilSYdoV+GR3ZOgSp3byUUyBRiVkiE5xM3nICnCN6cNotb5CiqiTQ0j+lM6TSxP/rkLLEg4/3xsfZl2757sT8k6iG3yW/NDLMj+guL76PmXHvNQyXQioUPiIBrpjZ1BqIzO/juwb3PSxu6XqOSk4vAsZy28j4tLXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvEo+gQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3CDC113CC;
	Fri, 10 May 2024 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339946;
	bh=mn3cUeuni9YG0Wzwevr2Z6WMUjH1cMxpP/hJKuF0rmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hvEo+gQT9vX5KrEu6smR3HDsQUe/rlydmQxcve33Biv6UklBzfSbiXASCofFVClV9
	 4Tt4uT86nUo499QB9zFaFYjcdHE5PC8h2KNRmmiA9pcZb3DeSeUon+dEEyeLkoGJrx
	 eXogtRk2RbwgRqQnRqIxaerc0+dEUl0Jvb8rQIeS02GowrlZGQA3AHd8fzMboIJzUK
	 84i6lA+p+l9BBbIQU7z745EWEq+Xl+A1amlGJDf5yt84tE+iSAAQ+x5HHkJlhFOvLn
	 wnQzindeFxJDSBIpCl0wAVW0tAHqXj4WWTKhE43WAh2Kcq2hvPH3JIJM3Vdetw6Kb3
	 mqG6FcdMehhxw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 May 2024 13:18:34 +0200
Subject: [PATCH net-next 4/8] mptcp: add net.mptcp.available_schedulers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-4-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4279; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=t1Yh7WAxI11wVfzjw8nlaeU3n8BxQOHG92M634eRusw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKcDyBOeI187aOHNMo0SRQQcQ9DSshF6DCfc
 7Xr+fBJAJWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CnAAKCRD2t4JPQmmg
 c6JIEADxMIDorQrlhIWMx4E9G4GPEsjfvnbVgRYF7S19eze6fI5+Rl+4cQXjk3Kw9vrpyljInxS
 zr03c4iUmIGaOJNiJ1Bj5Gz1TDx6SXuJUSHxqn1gLaeE/euzN3CLFUqSutAfQxFw6NB8G6gxRLp
 vgABit1HQ/fcrXbfCPPT124SZ1OzOfOrx02an9wdqhG0rUX44eb3xuJXlMOKfSus6rJJh8wlXOS
 6wMDEX3Iwjg2yo3IfnS7VOH7lk0zJOvs0qUksR+20A7Ulp6OAVbVqkmFaOeY1GJIOlpbDx0uGh0
 bVSTr6Y9IBYo3Ot3Jsvyn7IbE/a1BeQWaLVz1dsadAGw6TLi0UvI8cH54n+kvIz+/lq3HlLGENg
 156kUyx5nhkSFt+fbl5yTKOuyIbUZilvM4I1eKDdZGIcdaHAXJwfeuLja66MWol2w4RyX/iwhVc
 +axdGE0PDNJbG08T37sNzuQbOOKzUXdlpJ+x1v3qRIOL9sDTHqQoEBhkX1w/NqVbD31vcfxhBIq
 gu3nSPZb0LQaO11WsR6S+8MoX7CqfmhbOO5VzPeSQBknNce2IJt5YTUIOM2PHbszrQ2ZzC9tUMH
 ug2Da/yRORSpBJ8Im8+0qgQwH1XoUjAyygpebNVaq/v1hTt8vjegFQtRS7cbMIzKeGMcvzlXaRp
 GtaggEa9r5E0JwA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gregory Detal <gregory.detal@gmail.com>

The sysctl lists the available schedulers that can be set using
net.mptcp.scheduler similarly to net.ipv4.tcp_available_congestion_control.

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/mptcp.h  |  3 +++
 net/mptcp/ctrl.c     | 27 ++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 22 ++++++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index fb996124b3d5..0bc4ab03f487 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,6 +97,9 @@ struct mptcp_out_options {
 };
 
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SCHED_MAX		128
+#define MPTCP_SCHED_BUF_MAX	(MPTCP_SCHED_NAME_MAX * MPTCP_SCHED_MAX)
+
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 49abf80b3fad..542555ba474c 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -133,6 +133,24 @@ static int proc_scheduler(struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_available_schedulers(struct ctl_table *ctl,
+				     int write, void *buffer,
+				     size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tbl = { .maxlen = MPTCP_SCHED_BUF_MAX, };
+	int ret;
+
+	tbl.data = kmalloc(tbl.maxlen, GFP_USER);
+	if (!tbl.data)
+		return -ENOMEM;
+
+	mptcp_get_available_schedulers(tbl.data, MPTCP_SCHED_BUF_MAX);
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	kfree(tbl.data);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -187,6 +205,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_scheduler,
 	},
+	{
+		.procname = "available_schedulers",
+		.maxlen	= MPTCP_SCHED_BUF_MAX,
+		.mode = 0644,
+		.proc_handler = proc_available_schedulers,
+	},
 	{
 		.procname = "close_timeout",
 		.maxlen = sizeof(unsigned int),
@@ -214,7 +238,8 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
 	table[6].data = &pernet->scheduler;
-	table[7].data = &pernet->close_timeout;
+	/* table[7] is for available_schedulers which is read-only info */
+	table[8].data = &pernet->close_timeout;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4dcce3641d1d..39fc47e6b88a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -686,6 +686,7 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+void mptcp_get_available_schedulers(char *buf, size_t maxlen);
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 				       struct mptcp_subflow_context *subflow,
 				       const struct mptcp_options_received *mp_opt);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 4ab0693c069c..4a7fd0508ad2 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -51,6 +51,28 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 	return ret;
 }
 
+/* Build string with list of available scheduler values.
+ * Similar to tcp_get_available_congestion_control()
+ */
+void mptcp_get_available_schedulers(char *buf, size_t maxlen)
+{
+	struct mptcp_sched_ops *sched;
+	size_t offs = 0;
+
+	rcu_read_lock();
+	spin_lock(&mptcp_sched_list_lock);
+	list_for_each_entry_rcu(sched, &mptcp_sched_list, list) {
+		offs += snprintf(buf + offs, maxlen - offs,
+				 "%s%s",
+				 offs == 0 ? "" : " ", sched->name);
+
+		if (WARN_ON_ONCE(offs >= maxlen))
+			break;
+	}
+	spin_unlock(&mptcp_sched_list_lock);
+	rcu_read_unlock();
+}
+
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
 	if (!sched->get_subflow)

-- 
2.43.0


