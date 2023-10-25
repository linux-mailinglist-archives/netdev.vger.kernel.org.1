Return-Path: <netdev+bounces-44317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79F67D78B2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12179B2129C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3D5381BB;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq6Yj4F/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664D381B4;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB99C4166B;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698277033;
	bh=IgjebdIFVSu5Y4tpT4Iv0onAf3HAZuKQBub99pp6y2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cq6Yj4F/Ko3JT/7/LkRqQvb4iJluhN1mukm+Gs5MNpdEsNWgtg3k9razrHhsK/+FK
	 ogwGextNuagLg2ixZ5ZdipZYO+3WWT/pu9khWdeSGymgJH3lGT8dWVgJVx1y/q8FBH
	 33SeCkTwaYNUREO9Hw7tF5z3HXexpooPtQuYvsJEFO/B/6GI3CmLwOujOx+ocEchC1
	 1RF6UIUg+dzJXhL8/xJR8vfbHzqpC5GeqUbAWL9JIRdKSKbjullVZ9sEC6/04k1nwM
	 6v47MqwVR8B9pgSxmhSR/Pu0ZuJvqJQTRYptGfOWX3IdnqWfaILUK5tF7ayhk2RAYW
	 V52cpzklXiqVw==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 25 Oct 2023 16:37:06 -0700
Subject: [PATCH net-next 05/10] mptcp: use mptcp_check_fallback helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-send-net-next-20231025-v1-5-db8f25f798eb@kernel.org>
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

Use __mptcp_check_fallback() helper defined in net/mptcp/protocol.h,
instead of open-coding it in both __mptcp_do_fallback() and
mptcp_diag_fill_info().

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/sockopt.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a5322074353b..fe6f2d399ee8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1065,7 +1065,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
-	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
+	if (__mptcp_check_fallback(msk)) {
 		pr_debug("TCP fallback already done (msk=%p)", msk);
 		return;
 	}
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 574e221bb765..77f5e8932abf 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -916,7 +916,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_local_addr_max(msk);
 	}
 
-	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
+	if (__mptcp_check_fallback(msk))
 		flags |= MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;

-- 
2.41.0


