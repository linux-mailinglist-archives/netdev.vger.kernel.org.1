Return-Path: <netdev+bounces-240833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8CDC7B00A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AE634F26A9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A23396E9;
	Fri, 21 Nov 2025 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obc0CNTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCC3546F7;
	Fri, 21 Nov 2025 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744572; cv=none; b=OSurfrILb/xuLt+KBu4AFR4EdSbc9D5fvAclryErJi+/AwiDci+VS2XYbxw+avMGjmiEnChQvn11hK1c8794xm9+MuzJW6RNIf1DRrt3Eq+iW9BO3fmDm6TiDX9JCvTj8tld4xAg8Y6eHVkGkj+9OJAwnYK2NMcOLvdkoRSLvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744572; c=relaxed/simple;
	bh=jIdiLX3VWzgNrqf7EpPm0F5vpLI5qnCVaoAPIq4F4Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4HaDyoNpjTzue56hQc+gVmU0r2vTbj7MSbkFqN841DlJss4j286zYGojwqQ0s8KG3X1HpXm82bhgV2AuyxktNLURbigbcPtPjEqFjYVMPY1OCvmbEWqXTkdw2q0FXXpAt/Fp2TutbqwXnLePNaxWb3vpr/U2gFXNYyy7W2HztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obc0CNTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2CEC116C6;
	Fri, 21 Nov 2025 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744572;
	bh=jIdiLX3VWzgNrqf7EpPm0F5vpLI5qnCVaoAPIq4F4Gw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=obc0CNTmHNgimNG9AMF+2xHb5vpsiz7As8MBfZ++aEfoSuOX3OEHolL68mEm85Z4L
	 NjO6uCEySYBNcQlOtCC67wh/E6yJKQltlvz09TCABI4tLFnnEsWUwDJWXVldqIKCI4
	 bg8bL8Q2EdL/x+vmRzW7BruH9YbYAs2KhEvFoX6928dgBniTxcAIPLNOFy6UaZ3H3b
	 BDPlssUX3xOJdGzVE37iMkmi6IxMXDyHBM9+F4oKwH1f3drarg99mrqt5IQ41Oipzu
	 N3ljAi9J0hd79qNbkVNVv8fdGKZSldyUzlAH9IN49/gQz52yolXDUSVe5Jrdw1y0cG
	 rmODV7vwHH1bQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:06 +0100
Subject: [PATCH net-next 07/14] mptcp: ensure the kernel PM does not take
 action too late
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-7-1f34b6c1e0b1@kernel.org>
References: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tsDinnysBE7H5NIp/IYbumBnwwyuBfamcgQFOo66t24=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZktM8dN4YCUZpzirVzLlha/F6qa1nU+kVm88Eezw8
 Iz8SjuljlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlUXGD4n68hYHY0IOHP8qev
 Wssj93jOWfLwwk6lqcyiXBy74z3FDjMyPMjQkDzO26gvzDZB9pfm4u6A6dtDtt5S+Bv5ku+hwuv
 /LAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The PM hooks can currently take place when the msk is already shutting
down. Subflow creation will fail, thanks to the existing check at join
time, but we can entirely avoid starting the to be failed operations.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c        | 4 +++-
 net/mptcp/pm_kernel.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9604b91902b8..e2040c327af6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -594,6 +594,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow)
 {
+	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
@@ -617,7 +618,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	/* Even if this subflow is not really established, tell the PM to try
 	 * to pick the next ones, if possible.
 	 */
-	if (mptcp_pm_nl_check_work_pending(msk))
+	if (mptcp_is_fully_established(sk) &&
+	    mptcp_pm_nl_check_work_pending(msk))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 5c1dc13efa94..57570a44e418 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -337,6 +337,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	struct mptcp_pm_local local;
 
 	mptcp_mpc_endpoint_setup(msk);
+	if (!mptcp_is_fully_established(sk))
+		return;
 
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, endp_subflow_max,

-- 
2.51.0


