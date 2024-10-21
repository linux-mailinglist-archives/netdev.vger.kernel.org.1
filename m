Return-Path: <netdev+bounces-137542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BCF9A6DD6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39440280BE2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBA71FBC81;
	Mon, 21 Oct 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6dBmo4B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681C1F9EA4;
	Mon, 21 Oct 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523680; cv=none; b=EqRvD+u7/Et8DDcQNEKZdgh74vbtymbOPAfemlALvI9x64UrPYGkekp8QY9XIGRpOX5mDya8TO8EIWxJHvOpRy8pfUcB3YETWUCImae+npoKOJ962JZjMrh6Gm4XjkL+Yvu7faa7qaQpnm34/p/JPBPLMZCs29gfBk2BDjMxIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523680; c=relaxed/simple;
	bh=4sqNqcl6enA2uep5yPbqNRkltc0niKW2hhqA/FLbO5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U80xk8svMVm76zPkjC5wRCxGTdsccJR4IlzMwHec0h04wd++K4oKzmVj04/Ha2omHQg1+2KqGtMTph9NXdU6rkPQsS8JBgrDvb0sREiHcE86ygz8bvY7FxGHJgbMpcpMrme55ahOL21l1h4fMcFkBb/cUPNpMZK2xSNCkyt7pAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6dBmo4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C6FC4CEE6;
	Mon, 21 Oct 2024 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523680;
	bh=4sqNqcl6enA2uep5yPbqNRkltc0niKW2hhqA/FLbO5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H6dBmo4Bul+vk/CYUyLi43MWU4cp9Ypmuvx6iBWBdhcgBtV392XpeR1MX6qXFtJOb
	 oyChvjaLNC/fMTa3CJwzSolCXx7skGo/RfJPst8dASmnVWpaIb6Yl46Qi9xgb1O7Gb
	 47oSYZi6WgrxEZOGxYYNaKlJIzRgbfgrTxnKMkR4qxudgC38zQu+Oh5inTu2ELrA4B
	 3fuPetX1ZYUHEXclM0K/ZVVT5x5nJaqgMhe5UUjdTCAYRiimh1Z37Gt8DlgnCJhm6O
	 YlKTFOjQymuKAXFv7JD/hoiQBUJc5NeqpisuBk59SCQhIbv9EKmWVdjVy1GgZAyIyI
	 FBtV6EAEUK/XA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Oct 2024 17:14:06 +0200
Subject: [PATCH net-next 4/4] mptcp: use "middlebox interference" RST when
 no DSS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-net-next-mptcp-misc-6-13-v1-4-1ef02746504a@kernel.org>
References: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
In-Reply-To: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kl9DK7HD7r1EeUzN5KT2dnyn50jJCyFp2AMSo9gs1og=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFm/TO9aj5czQ2jOGmTdUgveys84TK2SLiS6BN
 8U7BbZRd3OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxZv0wAKCRD2t4JPQmmg
 c3nCEACyOlH8DW5LM8a1tjOtVTJFSV8slTWiHnS/Rr+DiPD206bxZCOhH5QLBp4HRezF3NZh5LB
 lDq0+XMAwJ39M4AIm5W0YDPlTk2pN5WvM3P41iKFoy2Yn3M1BLm4lv7GYq9tHYj1YUVjJifmowM
 McGAMmBANwz5iZ2gbLolwPXZVpAJutMYRb3enPAgEJKKQVq6HeL46eiS1qS5yylIWP6aZBd/Lib
 Rf3Mjf3Vtv3KJQ/luPGNIVgHrGQ8NzkZc0bJbGUKJxPx/AZtYayJ6y6PAyO0sAc2sT+u5Ksl0Fg
 oF9waAxr6JJM+2Va2DMLFvPIfbvd28CCdY10r4AAYG+PxfBoSMHctGE6oW8aW67OZBTKUvqox+k
 O0/Mg/KznETAbfF55G/67iYBn1kx6AgTVgFWfPx2kpYw4FOQMKgsAtTbE1poPK3ei7lprFQ1Izp
 jZGFbpMwfmozqMqgFTmkDD+KONkqTq0b+Vt4LbOplklaFox5+zonvCShoVYRFJWN38tRpa+yy6e
 lg7gOv63KhC/jivoKDkXp1FiQZapvk0ygawmp1vF72qBo3xcuW7tO3XZn+SeA9+um7L4S6isF+n
 5qtt3SSP24woGDN2h23KOJO0SPd89dxnCBYwiYjarfQZnxsmCRB3ZuFJoK47Msx48c49ejk9Tl3
 wp6F3x6Ou17Hr2A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

RFC8684 suggests use of "Middlebox interference (code 0x06)" in case of
fully established subflow that carries data at TCP level with no DSS
sub-option.

This is generally the case when mpext is NULL or mpext->use_map is 0:
use a dedicated value of 'mapping_status' and use it before closing the
socket in subflow_check_data_avail().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/518
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 860903e0642255cf9efb39da9e24c39f6547481f..07352b15f145832572a4203ab4d0427c37675e94 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -971,7 +971,8 @@ enum mapping_status {
 	MAPPING_EMPTY,
 	MAPPING_DATA_FIN,
 	MAPPING_DUMMY,
-	MAPPING_BAD_CSUM
+	MAPPING_BAD_CSUM,
+	MAPPING_NODSS
 };
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
@@ -1128,8 +1129,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 			return MAPPING_EMPTY;
 		}
 
+		/* If the required DSS has likely been dropped by a middlebox */
 		if (!subflow->map_valid)
-			return MAPPING_INVALID;
+			return MAPPING_NODSS;
 
 		goto validate_seq;
 	}
@@ -1343,7 +1345,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
 		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
-			     status == MAPPING_BAD_CSUM))
+			     status == MAPPING_BAD_CSUM || status == MAPPING_NODSS))
 			goto fallback;
 
 		if (status != MAPPING_OK)
@@ -1396,7 +1398,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
 			subflow->reset_transient = 0;
-			subflow->reset_reason = MPTCP_RST_EMPTCP;
+			subflow->reset_reason = status == MAPPING_NODSS ?
+						MPTCP_RST_EMIDDLEBOX :
+						MPTCP_RST_EMPTCP;
 
 reset:
 			WRITE_ONCE(ssk->sk_err, EBADMSG);

-- 
2.45.2


