Return-Path: <netdev+bounces-29460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9437835A2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCF91C20A06
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234021C29B;
	Mon, 21 Aug 2023 22:25:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604FF1ADCE;
	Mon, 21 Aug 2023 22:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E8CC433B7;
	Mon, 21 Aug 2023 22:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692656723;
	bh=bnVF7wxEKyiRFifLwfrCEM0L/IllcnM6/xPEkTFqHNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oXnU/r2QQWpb0nedNOc53foOYlFrbIiMyCf85oftoTl5ahxQhEOx58D942PoXQAFk
	 VD8smiJBQ8JbJXI2GbabNYOGWEqd/2a1HuX2cgCgQkKWbhP5iUZRgChb5qaWpixBBk
	 7ElIx87xVJoJvsm3rntRU85uSFbZfSKlH3NLQPRPCLawQqArVA2c7nlwT0McIav2Pl
	 Ahr7dlSXhPMzkX8bF9YYCVWXjhbkQUJxfNfnT3ti/JnThSYKtk3s+Y0iM8BFfakhQe
	 DgLyIUDJ71GdhJ61aLYpc45tLT2PXUEkwQJwipq39xrwgpuH+L5BEKL34BlTjlp0xH
	 SHZMP4Xn/ViGQ==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 21 Aug 2023 15:25:17 -0700
Subject: [PATCH net-next 06/10] mptcp: add scheduled in
 mptcp_subflow_context
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-upstream-net-next-20230818-v1-6-0c860fb256a8@kernel.org>
References: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
In-Reply-To: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a new member scheduled in struct mptcp_subflow_context,
which will be set in the MPTCP scheduler context when the scheduler
picks this subflow to send data.

Add a new helper mptcp_subflow_set_scheduled() to set this flag using
WRITE_ONCE().

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.h | 3 +++
 net/mptcp/sched.c    | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 548c302a757e..e7523a40132f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -491,6 +491,7 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		__unused : 9;
 	enum mptcp_data_avail data_avail;
+	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -663,6 +664,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
+				 bool scheduled);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 53773668b5ee..d295b92a5789 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -87,3 +87,9 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 
 	bpf_module_put(sched, sched->owner);
 }
+
+void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
+				 bool scheduled)
+{
+	WRITE_ONCE(subflow->scheduled, scheduled);
+}

-- 
2.41.0


