Return-Path: <netdev+bounces-168607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E94CA3F95E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A6986088B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630E211A28;
	Fri, 21 Feb 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnn0hpm9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52051E47CA;
	Fri, 21 Feb 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152670; cv=none; b=JEXw6QKsnzfqp+PMrGVGeBvrvrJri7fFnapMQ7OszxKwS0p008j5zdYe/OYJkjZHHgPdr+iZdqZI7SHHddeBjmecftjgqIojyny0Jk5XwFWFQNe9p/qVJDqpUR2446g7Qmm9uPh2jKSq0DX+9VXkGTfzUAsy4OOeTljD0RFdwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152670; c=relaxed/simple;
	bh=pIHmmZWQGeAQvcIrXjKJgOXjxp9GrZuLJAqY4jRYyR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mjKquQbpr3GJ3A4o6HIUdlhPE5nRYdO8b78o9tHXXy6cQNQ0qteZE78LrOvmudHYR79jzQ6AjHI7cZ+1viZp8btTykSQu41KTUNF2iS2F4Kcujhgp2LAg4OaR55M7Sl1HWKtvdZ0JWqiSO7ev20Qf/jai8cC82gMU4TGGhWyGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnn0hpm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E39CC4CEE4;
	Fri, 21 Feb 2025 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152670;
	bh=pIHmmZWQGeAQvcIrXjKJgOXjxp9GrZuLJAqY4jRYyR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rnn0hpm9NF0bKnTpwSiVgysq0AhvbCI36Gu/UTlWh6bsNMMvZ/FU6JFKVritb5JgJ
	 F7dT6gm1/JfEwS/f6iMnAJ3T1an/I4A32f47QJw4bCdYmDstarxrJoQLQvFbEjo9sE
	 XPDMIfIX+wyG3HrQ6q30kabtFD8VzD91ahbvA4cBD0IvQMIxujC5+0a4OeKZ+ZnNBm
	 YQZSQx3AmqWXPJqVquyhWnqGWwGCjhywQMAgJi1o7NQvYiEOUuTF7FEbvqoNPIDHZl
	 /12N9ZgQwfMxfrqISomST8sVTgkCBPHPKN1ciFc4neiTXOiaiDh82a1w9VFMFEXGD1
	 H2c5y1zEijF2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:44:01 +0100
Subject: [PATCH net-next 08/10] mptcp: sched: split get_subflow interface
 into two
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-8-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4111; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4etufhjOFcm5rpcVbLB5Hl2mjEGGh+/HGlGO5Nqd8vQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9HXut+RXO7bryGeSFWKp6mSx5zeJQUIME1H
 8Yu2qA9xJOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c2pHEAC31BgHJRnIMxVTYaG69jvX2fXo6fYWm6lvUVKdz7Xtiol5KCkrVTgXMjmp4i/L7X/Wp4q
 9I8Y2k+2inMuNV1dbvkcrQv6yCvUWp9JZ0t92m0zGDUjNjOKbrsyTLOayItHIiQEHHyv1pJ3DtE
 KyNtvutQ8ZRcnnU5R1wG1ZCWFEQZq4hHZP4h2CSv4BkP7orDQ/QnfYnekiKHlB4InwZ41DiH0wl
 LmYPvR9Cn7TCHh5eP5TJ4Z1kjF/LUPY5o7k0frK4aCaJyNK9HqHN/h0l9ARHZIz6c7N71lDN77U
 n1zw3uQsLDeymlDg2PorV5GLr4pkUhMqmhlGVp3TTA0JSfPwhanXVe1U9NyxlpIHzq+lO7ocKPv
 caVcOHm7tTaAr1Ksqee9cnCZxDxmrmxaJ4dnZNV4qRqafqdvEQHueJcPugEmvAEfT7jVJs2yPBp
 K2jD9uCb+txcPJ06pOnam6BQHY5SHVggH40LXMJRIX35zMAlzSyT8Ivbz54YjgPDzuTefkyxhlo
 SdAg7ltQkpSB72EBkFhWX4BnMM1+9ip8MNHYFJ7IYWvf+xUEdapvB0kSNbOS3w11JCWapDNI7+2
 ++/tg7qaqFBceX0Pfpbn+WZjs1iglpX1RYlyznlx8HtDowaJ8u1lwOa53LabQdBG4HC0bjSkkLh
 DRzn8WMihb9caPA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

get_retrans() interface of the burst packet scheduler invokes a sleeping
function mptcp_pm_subflow_chk_stale(), which calls __lock_sock_fast().
So get_retrans() interface should be set with BPF_F_SLEEPABLE flag in
BPF. But get_send() interface of this scheduler can't be set with
BPF_F_SLEEPABLE flag since it's invoked in ack_update_msk() under mptcp
data lock.

So this patch has to split get_subflow() interface of packet scheduer into
two interfaces: get_send() and get_retrans(). Then we can set get_retrans()
interface alone with BPF_F_SLEEPABLE flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/mptcp.h |  5 +++--
 net/mptcp/sched.c   | 35 ++++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5e3e474a2bac5e4cca5a89abcfe1c..2c85ca92bb1c39989ae08a74ff4ef9b42099e60d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -103,13 +103,14 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
-	bool	reinject;
 	u8	subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-	int (*get_subflow)(struct mptcp_sock *msk,
+	int (*get_send)(struct mptcp_sock *msk,
+			struct mptcp_sched_data *data);
+	int (*get_retrans)(struct mptcp_sock *msk,
 			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index df7dbcfa3b71370cc4d7e4e4f16cc1e41a50dddf..94dc4b3ad82f6a462961ae5195b7eba2271d8275 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,13 +16,25 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
-static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
+static int mptcp_sched_default_get_send(struct mptcp_sock *msk,
+					struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = mptcp_subflow_get_send(msk);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk,
 					   struct mptcp_sched_data *data)
 {
 	struct sock *ssk;
 
-	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
-			       mptcp_subflow_get_send(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		return -EINVAL;
 
@@ -31,7 +43,8 @@ static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
 }
 
 static struct mptcp_sched_ops mptcp_sched_default = {
-	.get_subflow	= mptcp_sched_default_get_subflow,
+	.get_send	= mptcp_sched_default_get_send,
+	.get_retrans	= mptcp_sched_default_get_retrans,
 	.name		= "default",
 	.owner		= THIS_MODULE,
 };
@@ -73,7 +86,7 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->get_send)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
@@ -164,10 +177,9 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	data.reinject = false;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_subflow(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+		return mptcp_sched_default_get_send(msk, &data);
+	return msk->sched->get_send(msk, &data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
@@ -186,8 +198,9 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_subflow(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+		return mptcp_sched_default_get_retrans(msk, &data);
+	if (msk->sched->get_retrans)
+		return msk->sched->get_retrans(msk, &data);
+	return msk->sched->get_send(msk, &data);
 }

-- 
2.47.1


