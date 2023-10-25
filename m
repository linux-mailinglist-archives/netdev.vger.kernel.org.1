Return-Path: <netdev+bounces-44321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2E7D78B5
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559A8281EA8
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF039943;
	Wed, 25 Oct 2023 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEQwBWiv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04567381D5;
	Wed, 25 Oct 2023 23:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E61C4339A;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698277033;
	bh=nH9eSRyr97sQBl762zJNIzDebdiVrUxjMr2kzANZ30Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TEQwBWiv3PqdP6EucXStiNrBQBPq5C0GLm1tMMjh/06ed4iiLN/zC4qxMEKf17HQV
	 UnHa9bqhig2LYDlUXIwQuRosMhvkKQonDA3B2D0ZhiLV6WIV5zyDq7rZwdbnt2k8q7
	 Wak+Zz/zOwd02R5sq4fX4IroqW6OIr+Zql9lrpn/q4eEaPGWFh5P/9UAU5mavOQRvT
	 P/9b6pV5FTj0GL6Hih2zzBRUNYiGklKPcEcXoVcHjt8Tp4ojcKQ99do6nUHGkBHbO7
	 cUv00xLM/c9Pin0yD/kVYuclK7utG3Nvkwgz8b4qaUYtJWF5PUc7Q8L3wzzwZvqRBE
	 Er84urt2PUR0Q==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 25 Oct 2023 16:37:08 -0700
Subject: [PATCH net-next 07/10] mptcp: move sk assignment statement ahead
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-send-net-next-20231025-v1-7-db8f25f798eb@kernel.org>
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

If we move the sk assignment statement ahead in mptcp_nl_cmd_sf_create()
or mptcp_nl_cmd_sf_destroy(), right after the msk null-check statements,
sk can be used after the create_err or destroy_err labels instead of
open-coding it again.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/pm_userspace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 25fa37ac3620..7bb2b29e5b96 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -335,6 +335,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto create_err;
@@ -352,8 +354,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	sk = (struct sock *)msk;
-
 	if (!mptcp_pm_addr_families_match(sk, &addr_l, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;
@@ -381,7 +381,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -458,6 +458,8 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto destroy_err;
@@ -487,7 +489,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	sk = (struct sock *)msk;
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
@@ -507,7 +508,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	release_sock(sk);
 
 destroy_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 

-- 
2.41.0


