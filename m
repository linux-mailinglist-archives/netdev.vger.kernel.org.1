Return-Path: <netdev+bounces-209356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DC1B0F55B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBA41CC1F09
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39582F49FE;
	Wed, 23 Jul 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWcmL0vJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A362F5080;
	Wed, 23 Jul 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281165; cv=none; b=B+W01GBTDF90tnDxlM0zFH8SJFI20WHFs5SieOn/MDyXaglsAfJ89CuBaZmdmBMdC0+ZoP3jZwBySTV/MLdtnktURN8+XexgeyKIA0k6qXWokAyBtjsthhOt3DkhVOD3Vd56C5uzl6i724IU+c0c2E5mNVRWT8bx9EkuyPrcAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281165; c=relaxed/simple;
	bh=Ofi++0IIDP8SlKC9LhxSvwNwUbH/5CbcHsC75xl40/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0+IINQNDUZoThUxHq7+0vQM3RxVHAXJnh5qEU02Tbm4GH7VBReOuiNRbP4+dPCgEnHgZJvQA54GSFmv5S+OznsAIxVnsHRBzqr4AhP3hBKS5AdwKtWywn2gzGy//GnPn9PEu/IWfXh1NmG055o58kWveuPzigMaXK/u/xzE14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWcmL0vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC30C4CEF8;
	Wed, 23 Jul 2025 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753281165;
	bh=Ofi++0IIDP8SlKC9LhxSvwNwUbH/5CbcHsC75xl40/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NWcmL0vJiqkhIqxz2O7+kXQqwCOkX6GxMRQiDmeVtAtgqfL6WryaPk3kwsOlsozMs
	 M4O7F+2ZVzk4t3XV+bNgleWOjAZierrcUD1Cu6HtEu8pE8b3DOZ/in3LyQ/obegk+v
	 pHzQNcWsSL2MrzpHf9xgn8xSeJoHSoFneqplV5hrsVAMBdt+XK6vIkT9Dk0g05lICO
	 IOrnglzz38coAe4WUQ2mte4mm18iXADZKrFnuaDBnpvUz4JIqp4ITGShBCztFgL80k
	 W9BgPo3QRXNJd60dpm7ABFeTqhqocLTPxriQd4Y6cj+zbBC7y2G5MDpR/h6hm4avaR
	 WTeUB0c9GR05A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 23 Jul 2025 16:32:24 +0200
Subject: [PATCH net-next 2/2] mptcp: remove pr_fallback()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-net-next-mptcp-track-fallbacks-v1-2-a83cce08f2d5@kernel.org>
References: <20250723-net-next-mptcp-track-fallbacks-v1-0-a83cce08f2d5@kernel.org>
In-Reply-To: <20250723-net-next-mptcp-track-fallbacks-v1-0-a83cce08f2d5@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pvITh45m9tlJ1IVW1aV52DIg50KtDjJIKxh9qo4dlt4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIaPrXWT4gJynyTu5ddRuxHLUOt8vKACqdtr9duWdbWf
 MmS+7J3RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET+LmZkuOZxoPb2A/19CR+b
 NbZFP5isHGPpNemy0i/rCqknly/9XcnI0GP+7aZi5Lrokmvf+BZ63v3y4ANfz9vVNb0/7DZaHrm
 awAUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

We can now track fully the fallback status of a given connection via the
relevant mibs, the mentioned helper is redundant. Remove it completely.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 1 -
 net/mptcp/protocol.c | 1 -
 net/mptcp/protocol.h | 3 ---
 net/mptcp/subflow.c  | 4 ----
 4 files changed, 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6cf02344249a65d00b5832ebb69dd39d6e5fe98e..70c0ab0ecf905d282e5dc6c1b21ffc6476c8d71b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -982,7 +982,6 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 			goto reset;
 		}
-		pr_fallback(msk);
 		return false;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 88bf092f230abbecddc965b4242f711a5ba9d6b6..9a287b75c1b31bac9c35581db996e39e594872e0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1167,7 +1167,6 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
-	pr_fallback(msk);
 }
 
 #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 912f048994a196304a80cde90747d4a512fb3d3d..b15d7fab5c4b66c6fb7a7cbdc91d49547ada6a94 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1257,13 +1257,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 	return true;
 }
 
-#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
-
 static inline void mptcp_early_fallback(struct mptcp_sock *msk,
 					struct mptcp_subflow_context *subflow,
 					int fb_mib)
 {
-	pr_fallback(msk);
 	subflow->request_mptcp = 0;
 	WARN_ON_ONCE(!__mptcp_try_fallback(msk, fb_mib));
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 600e59bba363f9b3350d9d65ca729cba4badb304..3f1b62a9fe889ab1ac07f2a210b9de050436b37e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -551,7 +551,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 				goto do_reset;
 			}
 
-			pr_fallback(msk);
 			goto fallback;
 		}
 
@@ -1855,14 +1854,11 @@ static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct sock *parent = subflow->conn;
-	struct mptcp_sock *msk;
 
 	__subflow_state_change(sk);
 
-	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
-		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}

-- 
2.50.0


