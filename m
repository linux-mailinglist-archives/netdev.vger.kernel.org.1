Return-Path: <netdev+bounces-126683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383D97234B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857B11C23463
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418918A939;
	Mon,  9 Sep 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4lsFHZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F118A930;
	Mon,  9 Sep 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912601; cv=none; b=Bf+5SHgRSz97sQl8GFrVMJR0JM0yC9TxFpBea85xdyZJOFbvG+ZxTPVuFhJXodWtWK0S6SVt25wHXk9JigdZq38KJyL6lkhcLGZEJH21TuFqYyx0lY/T8ihAq/BBCp3wj7dNvobmW+AJ3KoyOa9jyzJuspc6tUG8QZxcC3M19p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912601; c=relaxed/simple;
	bh=uhcecyVMBusnKlSMXblybdnxLT3S8L3Jq1Lotz2VELI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jzlxi/Tg+p/eBw1rbwhM+8W8FCxzU/K5Mscltbm6zcfDMqmzilb9VmmyVl/YB3hHmw+gMH2gGAxGkghWoA81oW/zptDTZX/bZCkJUhmU1Gl5vu6l6I86hExmDhP4HBHQuWgpQ3di5gWPggaqfjX/pDav/yuYVuLxCSVdqlYtgf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4lsFHZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2086C4CECA;
	Mon,  9 Sep 2024 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725912601;
	bh=uhcecyVMBusnKlSMXblybdnxLT3S8L3Jq1Lotz2VELI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s4lsFHZKZKK1FGNja3JPBt0BnKuSPJM1G2xj7F5It7j2kNEsKnyNtfuDydpDV4iRH
	 P6ZRE7nuGWlubqan1j4Ehq9CrnBrjjsg7GwJf3OQ2GiQ0VJnDdwMs/bPWBERcp6NlX
	 CADsTjTu7eDQ4iYlyEEKciphfYjEySY5NCcpgJTMrVAZM8XY5p108zwycG9BKb/xLz
	 p/qGrJcuO68d20NMTIbQHXNygS98pgp8f4hz4xyI9kJB4ckqKnGz8E/EBucOcaIn7L
	 dSPfyd2kszQskqj/yxHCW8e1LlZOorlXc7q6CGhLQ4sGzlMzF+0/sbYAR3cwx/fyS6
	 V24/tg/w/rT+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 09 Sep 2024 22:09:21 +0200
Subject: [PATCH net-next 1/3] mptcp: export mptcp_subflow_early_fallback()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-net-next-mptcp-fallback-x-mpc-v1-1-da7ebb4cd2a3@kernel.org>
References: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
In-Reply-To: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uhcecyVMBusnKlSMXblybdnxLT3S8L3Jq1Lotz2VELI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm31YQUzPPUcRGkM6UOHKVSEiokLmMKq+2OxTvy
 Ok499XhD0yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZt9WEAAKCRD2t4JPQmmg
 c9jUEADKdGGrqC22AzmzQkF4b//Gr5DGb+P7hYHjOXECo/4vOCDAA4wez0zvnnSRKpuSb3myXyz
 /h/rO94p0uykXxbKdsjJ7oEO08KiKvFnZqIccD8ysC/yFDZ2J4ORhSnlNwupXuA2oeFobybxIVa
 sOHMVrEh2Saxcpz+34LinHOhi4WyaF3a8VqwNYb9ueHnM7aPGoCKguoaq9gAn1pfnl9uzoEZYqv
 WA4wagUlzvn9GzDhLa8B+hPenAoIP4K3GTGAErKBzogVi4Tse7UXb4kIhRZYXt97dWbiWl1s6sx
 BjfqPE9xrKfbM72yFBLgOhO+SkzEVdC2avasufsL+onj8/pF5VxLet1F4YdZKtjHWhp59OXvULy
 bpW8eE2vZXBOcXRO6C58Vy/fV4KYo+JcKt314sKuVUMIRO8dsYey+8wOFEKGuyHYHSZaMZnzEf3
 ZF/oF9wPkPZHMSQNbzuiFfF2q1sVhZ5RlBgUempeZwOQebA//3WmDL237HdEEV1THVSn7sQotY8
 +ZeII9/lMITNdDB0bI5i7l4OUU5CggyrQNNrknhZTuy/g1gIkalF02I6tPHEhiiDNpsCWsRW8WS
 LWsTHHfKbT+xcGYFA4OrSaDle4iUeWYx4nG6aLoZZ5jNf6Myf1yUPrfp5txhqS0XDsDOqZYbhig
 +7iu2R50FY/7LZA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This helper will be used outside protocol.h in the following commit.

While at it, also add a 'pr_fallback()' debug print, to help identifying
fallbacks.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 7 -------
 net/mptcp/protocol.h | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 37ebcb7640eb..cbbcc46cfef0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3717,13 +3717,6 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 	return 0;
 }
 
-static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
-					 struct mptcp_subflow_context *subflow)
-{
-	subflow->request_mptcp = 0;
-	__mptcp_do_fallback(msk);
-}
-
 static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bf03bff9ac44..302bd808b839 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1215,6 +1215,14 @@ static inline void mptcp_do_fallback(struct sock *ssk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
+static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
+						struct mptcp_subflow_context *subflow)
+{
+	pr_fallback(msk);
+	subflow->request_mptcp = 0;
+	__mptcp_do_fallback(msk);
+}
+
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
 {
 	struct mptcp_ext *mpext;

-- 
2.45.2


