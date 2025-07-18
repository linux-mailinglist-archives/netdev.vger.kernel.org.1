Return-Path: <netdev+bounces-208260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CAB0ABED
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336FF3BF61B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AAC2222BA;
	Fri, 18 Jul 2025 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCLtDpa+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4524221FD2;
	Fri, 18 Jul 2025 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876444; cv=none; b=ltalxQFHWW77WFkSz1c3fI54yO64BC9xYQUeXVWU1x0rAzL1yg/Fp2VYDuAnnL9VUPlLN6bI6jiKrmEScLcT+UkcTDfUq5xxdfaoEUtrwlyQ4jcWLvlwk2G+C1nEdBcBjqxETo1dwoFt/vc0grM/+m6DwSW8JJjNbMBo3o/ifVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876444; c=relaxed/simple;
	bh=420QYmMY0wmOtX/SXHLWfvY10xt3pIcBXfE3TtnLy2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trjOaJUOg4tPplTpgkDB0OKtzl1cJKweHP6Qg+qfFUf1OgxphC8Y5Vh6fuCVj2mn9tyKgTerlaU6jxAMJ6Cu/rokExMvqu4lJa4TX3z6LSXt2XfEMSh/EpUEWSfb56JTZISrP761O8ALIa1aKJJ4MCN2E0gSnNfi4IQmelkLGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCLtDpa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10D5C4CEF8;
	Fri, 18 Jul 2025 22:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752876444;
	bh=420QYmMY0wmOtX/SXHLWfvY10xt3pIcBXfE3TtnLy2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OCLtDpa+VTSP5eTlSD2mVu3F4/OVM9b9AU8Rm/FfvOPDvypOwghr9PZdvep1jlkbf
	 HKUqrkaq1/STefdCHahb6S7XsW2An/BD2s7eJcJGTBvDHCABVw8nsqu+njiDrU10DQ
	 JOhBNO4WeSCS+ZIKtxi7uEVyQbZi9EzzdnGJHhSsw3pbTiyPrrstX95KeHWEmm7aj1
	 5x1mAZcQvAY+bcsABnoH3zgxBHavJ9lAYcCsFu2dfGB2CkpT0TWwTkWSs7DBQIbiZW
	 VQfXnX3N99PJF5LMMBJdQpIneoE8RxSslW5e48cqu1F1HUu7sbTnlC1qzU4CkDKw1E
	 MLw9bUlMsEUMA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Jul 2025 00:06:56 +0200
Subject: [PATCH net-next v2 1/4] mptcp: sockopt: drop redundant
 tcp_getsockopt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-net-next-mptcp-tcp_maxseg-v2-1-8c910fbc5307@kernel.org>
References: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
In-Reply-To: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qdD75UMq+XWOs/t4m+2jVqNG0JZGcjJknqKh4cn2e6I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKqjk6oOzZlW+2PBx12WpdmbNhx+9waXuZN56Sar51f+
 NyvzbGGq6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAigssZ/nBmmzbJZKe/9ms0
 +xXwv+ztrLcL/ijVzl8U/GLq3/x2jhWMDCfirub8i9216MuCRbMtPW+Jr55/barWh0s6yekz7x1
 KmMcLAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

tcp_getsockopt() is called twice in mptcp_getsockopt_first_sf_only() in
different conditions, which makes the code a bit redundant.

The first call to tcp_getsockopt() when the first subflow exists can be
replaced by going to a new label "get" before the second call.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3caa0a9d3b3885ce6399570f2d98a2e8f103638d..afa54fba51e215bc2efb21f16ed7d0a0fb120972 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -914,10 +914,8 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 
 	lock_sock(sk);
 	ssk = msk->first;
-	if (ssk) {
-		ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
-		goto out;
-	}
+	if (ssk)
+		goto get;
 
 	ssk = __mptcp_nmpc_sk(msk);
 	if (IS_ERR(ssk)) {
@@ -925,6 +923,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 		goto out;
 	}
 
+get:
 	ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
 
 out:

-- 
2.50.0


