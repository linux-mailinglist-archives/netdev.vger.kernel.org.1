Return-Path: <netdev+bounces-96228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F48C4ACB
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A100E2837D8
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49230AD2C;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7yL0+bU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB7A943;
	Tue, 14 May 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649223; cv=none; b=hhI4SSyXMcxht9muZrBc0sOIH6bPQnLWib4O8w/xPtHAaTmFYxKJsZyAlo7kvW0U7GhFU7lyeYMq6rP+1qODUSdHk5bExZCEJ+Yzyq5K5eXY/ONzCpYckjcmEMCcbiIkDaHB6+hgs2J/o6X9BkjCMz182nP5juxTDjIO2XIv80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649223; c=relaxed/simple;
	bh=/tjjLXnJZHXr0yUVZDx0IqmuMZqiXFKW/W/L5z1PYUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz7D+FZGEW6R/egTdtWpxRirZIvOqS73fajB/XOTfq3FJW5UAKfvpLd4/7TueWkdsMisUeQJ+shLf4Oe55nUuYx7SRE/H4PYgVbux7ja09c2fLnMSM+kUpF5ETOaycIq1fb6n1Ke2JiTNtcE+mWC2/7gDEet1Apku4EbioEANhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7yL0+bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5733EC4AF17;
	Tue, 14 May 2024 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715649222;
	bh=/tjjLXnJZHXr0yUVZDx0IqmuMZqiXFKW/W/L5z1PYUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7yL0+bUnzZp4M5idIf9Ek5ksSa/cMN2bW+JJ7bWwu6uHsi61RPc+4Uu8ybYKbHsP
	 fe0Ga3f2b1I4Q/U2hO6ok8/ZbgwNpTOBm1SjMPYEAfLkJJBxVXGXV2XACLuydNLM9r
	 YySxev1f3wcwOVl+d6qWy+NGbjruT59okD4BEbE5dRw/1cG6jSuPXNOeSS7tfI7J7z
	 w//HarTGr3gcC5uPCZMuTbUdsAIZLZ2d6t7CuNOQLRhZFWEiwmFOZ72SW+dTryu+GG
	 qaADATm2dqm6Fk0awW1cjgHpnOeNpdZkA8MLDVoeaBMXkMNQLLN5P5mPUG6NPRkERR
	 WkSwOOOR1CJHw==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fw@strlen.de
Cc: Gregory Detal <gregory.detal@gmail.com>,
	netdev@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net-next v2 4/8] mptcp: add net.mptcp.available_schedulers
Date: Mon, 13 May 2024 18:13:28 -0700
Message-ID: <20240514011335.176158-5-martineau@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514011335.176158-1-martineau@kernel.org>
References: <20240514011335.176158-1-martineau@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Detal <gregory.detal@gmail.com>

The sysctl lists the available schedulers that can be set using
net.mptcp.scheduler similarly to net.ipv4.tcp_available_congestion_control.

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
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
2.45.0


