Return-Path: <netdev+bounces-44319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52A17D78B4
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7558FB211AB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FE38FAE;
	Wed, 25 Oct 2023 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSYmxu9o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF7381BA;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B01C433BD;
	Wed, 25 Oct 2023 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698277033;
	bh=iHTW92DQYzrFSdt6z90d4EIwPhRKgXAhTgEPt3iGoqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GSYmxu9oSs1sV+fYywY1t/o1O6SyqSIgi5WzfFTfQfvzT2NwC5Yc1i0DmW2OmQ73L
	 8FvYyqhW1qCRv2darmBmwYRv37wkhs7pGDFQ6udfM2YE8dMMEQumTGyH0zdErf/JEY
	 KzLHAVCyw4WwQvkhRkzPz+tOpR9XrOc70/izG1+wt98VO0JvpEU7lqsFSNfeI3dCbu
	 XLWRK1nlVrJ3JVzBfFTT/WoEqwm9/dzzpVcUqfoNkrfW8nuklLj6al9MpcMHgna9HC
	 +hebTEQxTo9iS+XQXO7q3gjFpFyz9WoDMR1rAEnvFq1eOygrslAuzhVCLSmseYTsGK
	 vv/U25tzMxTxw==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 25 Oct 2023 16:37:05 -0700
Subject: [PATCH net-next 04/10] mptcp: drop useless ssk in
 pm_subflow_check_next
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-send-net-next-20231025-v1-4-db8f25f798eb@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
In-Reply-To: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

The code using 'ssk' parameter of mptcp_pm_subflow_check_next() has been
dropped in commit "95d686517884 (mptcp: fix subflow accounting on close)".
So drop this useless parameter ssk.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/pm.c       | 2 +-
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d8da5374d9e1..4ae19113b8eb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -184,7 +184,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1dacc072dcca..a29116eda30a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2490,7 +2490,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
 	 */
-	mptcp_pm_subflow_check_next(mptcp_sk(sk), ssk, subflow);
+	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
 
 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9092fcf18798..a5322074353b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -888,7 +888,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
-void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);

-- 
2.41.0


