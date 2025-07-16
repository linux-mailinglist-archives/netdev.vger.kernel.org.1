Return-Path: <netdev+bounces-207433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31234B07355
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CCD581223
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB752F4310;
	Wed, 16 Jul 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If1JW8as"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B82F4307;
	Wed, 16 Jul 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661702; cv=none; b=NisAfnMp+QKJE2705yXo0ozU5lfsHHuldqsP4+hhjwgOjoBaMdVtJK2TfX34dRlgKMAS4bbwQpE1zeWysJgtlW61Aytqxe4nWEzo0G3B0X03REruCtBkjCRNcylxJ9mBms5MmhVVrGNPMo/SCFykoMvH+HI4/RnLOtj+WbQQ534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661702; c=relaxed/simple;
	bh=uubJkcASmdlBqyOvngpV0o6PcVvEqHNyWJgMpNd4zhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRrybFfDCKhUXgsDoPLB81DLAXUkOwdtcaD+1mwtKDn9EutowbQYr/58QWFa4qVvl9zMxF82pUxqwsTjOG0ueeNEIfY/RUGGrt3kw9CcNTstblLF2Y3MeHP9a/W8UORoqvE0mXmwG4d9WnSqqtZkDunXKIBoJQlbQy+Rbp9Uvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If1JW8as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B59C4CEF0;
	Wed, 16 Jul 2025 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661702;
	bh=uubJkcASmdlBqyOvngpV0o6PcVvEqHNyWJgMpNd4zhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=If1JW8as8nFoLsTdcQEUHsMROXj4gfdD+T5wHsJBX7HSjAnVY7ZJtmpAnIyfk+wAe
	 EPdVq1fufeGrJjAMFEmwEwhoE5BnB4rBEnSxvZ9wi1+6bbH+xbRKZcIIaGBwkF8nx6
	 dJs3M2rUYdYsAtz1GVVmKPadNB6HFUgIC3nnbHEwHtUbZBseyYNgVzYwCJqOjyBpqr
	 YnrUiUTH2YVBi/+8HYgAth+X410JKLpOwIsiZlj3qmIeZAZ7hngrY4ISAsf3QUrNQA
	 qVMQu0wSvcfgkIFSE0zi03VPaG2KfBeXIM3u8Wt3+75oHT5YliM0Qd4NSQYYLmRNqm
	 TLMFqKep/WJvA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 16 Jul 2025 12:28:03 +0200
Subject: [PATCH net-next 1/4] mptcp: sockopt: drop redundant tcp_getsockopt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-net-next-mptcp-tcp_maxseg-v1-1-548d3a5666f6@kernel.org>
References: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
In-Reply-To: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
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
 h=from:subject:message-id; bh=TuqgIvrSS2p7z4IQu39LyqcaRxpvwfcEBIky4XYlVRI=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGh3fr2jV22jLKdGynGn3jqW0GsrgHeG9iRtYaNNXiAN2Woq+
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmh3fr0ACgkQfCLwwvNHCpcbLAEA2XUL
 NK1tHeqp6mtwjoFdUSaRlG3jBpbuNd0nuq9sDVIBAOH5aU4EgrFh974wC8/rT/93mbHWuaty/vU
 o2iZQdFIF
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
2.48.1


