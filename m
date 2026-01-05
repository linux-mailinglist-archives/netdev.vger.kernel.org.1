Return-Path: <netdev+bounces-247153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A836CF5166
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E803E30090EE
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D52FD697;
	Mon,  5 Jan 2026 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="IEsmvlJg"
X-Original-To: netdev@vger.kernel.org
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB22E65D;
	Mon,  5 Jan 2026 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635583; cv=none; b=sFSzhKYQGzF6Z1jaa+UZBAycpFieJaoQP9xnNkC5rVF6d2/0bJNyJndauunTL5gZTL6fx7SF70VD/6PO1BxpzJErFF7t4X9Nm9SV4jrbllKStx+iUCS/2tbsVHOuVwxvKN6fLV4744lNnE2ACaCgHldj908B3x7SXTa1FoAkHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635583; c=relaxed/simple;
	bh=Jo37RxW7ZeS/FnBGnolxYG37UdjVp/fjKHE41qK6t4Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OEph8yRrVc/CFxwHLjlAxIXo4KY9HdL190ZdjrlZQLeKs6mEisbhrB98jypalEnHqV73xPXIwYttXWYAP5Ggf4GAYhqFCQ6wsSDOyR5Szit/ByGTWIt3KveyGZpTrPkPCpeImtsfncUeeqc0GDNBaVgV3xN/VX5Kn0wmwVXrmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=IEsmvlJg; arc=none smtp.client-ip=115.124.28.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1767635576; h=From:To:Subject:Date:Message-Id;
	bh=N1oHDrUlpV7L/b2GZ8I+0kNj8ML9zNxhHZs4DZQ5gDM=;
	b=IEsmvlJgvbvp6a8rBxtP4V9ujykkURybfWF4WnjAFrIhFiI6NfQmqgxek6aN5RZ1ar0TMMTfzW9TIMYF4/t6L1MZICbmncmPNFNqFjB20Ca0jPHT6BXLp+xz6PWLCRfy9PF9B82FQU3b7VUk+n992dQYqJIiu6sPvnAqhHEJzbE=
Received: from localhost(mailfrom:fangwu.lcc@antgroup.com fp:SMTPD_---.g-aLsst_1767635575 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 01:52:55 +0800
From: "=?UTF-8?B?5YiY6IGq6IGqKOaWueWLvyk=?=" <fangwu.lcc@antgroup.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc:  <kuniyu@google.com>,
   <dsahern@kernel.org>,
   <pabeni@redhat.com>,
   <horms@kernel.org>,
   <linux-kernel@vger.kernel.org>,
  "=?UTF-8?B?5YiY6IGq6IGqKOaWueWLvyk=?=" <fangwu.lcc@antgroup.com>
Subject: [PATCH net-next] tcp: fix error handling of tcp_retransmit_skb
Date: Tue, 06 Jan 2026 01:52:54 +0800
Message-Id: <20260105175254.2708866-1-fangwu.lcc@antgroup.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The tcp_retransmit_timer() function checks if tcp_retransmit_skb()
returns a value greater than 0, but tcp_retransmit_skb() returns
0 on success and negative error codes on failure. This means the
error handling branch is never executed when retransmission fails.

Fix this by changing the condition to check for != 0 instead of > 0.

Signed-off-by: Liu Congcong <fangwu.lcc@antgroup.com>
---
 net/ipv4/tcp_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 160080c9021d..4fbb387e7e7b 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -624,7 +624,7 @@ void tcp_retransmit_timer(struct sock *sk)
 	tcp_enter_loss(sk);
 
 	tcp_update_rto_stats(sk);
-	if (tcp_retransmit_skb(sk, tcp_rtx_queue_head(sk), 1) > 0) {
+	if (tcp_retransmit_skb(sk, tcp_rtx_queue_head(sk), 1)) {
 		/* Retransmission failed because of local congestion,
 		 * Let senders fight for local resources conservatively.
 		 */
-- 
2.17.0


