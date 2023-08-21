Return-Path: <netdev+bounces-29462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8AA7835AD
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B66280F66
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4451C2B5;
	Mon, 21 Aug 2023 22:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696051BB2B;
	Mon, 21 Aug 2023 22:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17B0C433AB;
	Mon, 21 Aug 2023 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692656724;
	bh=tc2xDya1T5Y4oXutUgVLxid1Ewv0x3sfXACYqZv2uGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T1yM9POoWNazPxOCyvR0R8ILF78NsIPwSn/2pBNUVzFVlK0TbejK8//W1+OTnl5Xc
	 jlpT2/B6+a+3spoyJI91+VDwjmvZfFAfUN/p5xMR9xioyuo8uhZhi44gWm6sDCu6ru
	 ciCe+cPXX7IB3bnIMGxZAh776JDiiCGaWUCusDLgM3O8U3Xdan5+8zo+zoQGDoygWd
	 1Thb68Ojgasdi8Y7MC1BOLisZrKvNuJ8bnZbwrUXtmVownnPNpiABjRzJilsu8t/Dk
	 war49dxeLDYvZFedwwczN7nhKrLos6W3bGeYxxobiDWxJ3TN61ZD9pgD5W+aaMV5Pm
	 z985/OjVFB3Kw==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 21 Aug 2023 15:25:21 -0700
Subject: [PATCH net-next 10/10] mptcp: register default scheduler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-upstream-net-next-20230818-v1-10-0c860fb256a8@kernel.org>
References: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
In-Reply-To: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Geliang Tang <geliang.tang@suse.com>

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Invoke mptcp_sched_default_get_subflow in get_send() and get_retrans()
if the defaut scheduler is set or msk->sched is NULL.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 55 +++++++++++++++++++++++++++++++---------------------
 3 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 61590ff2b9ee..933b257eee02 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3965,6 +3965,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 78562f695c46..7254b3562575 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -661,6 +661,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index cac1cc1fa3b0..4ab0693c069c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,26 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.get_subflow	= mptcp_sched_default_get_subflow,
+	.name		= "default",
+	.owner		= THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 {
@@ -50,16 +70,24 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched == &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
 
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -70,7 +98,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
@@ -117,17 +144,9 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	if (!msk->sched) {
-		struct sock *ssk;
-
-		ssk = mptcp_subflow_get_send(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
 	data.reinject = false;
+	if (msk->sched == &mptcp_sched_default || !msk->sched)
+		return mptcp_sched_default_get_subflow(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -147,16 +166,8 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	if (!msk->sched) {
-		struct sock *ssk;
-
-		ssk = mptcp_subflow_get_retrans(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
 	data.reinject = true;
+	if (msk->sched == &mptcp_sched_default || !msk->sched)
+		return mptcp_sched_default_get_subflow(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }

-- 
2.41.0


