Return-Path: <netdev+bounces-145344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4629CF227
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376C71F2B2CD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BE1D618E;
	Fri, 15 Nov 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klhRbOSA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE41D5CFB;
	Fri, 15 Nov 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689571; cv=none; b=i0kvF5y2LqfE5ngeL0iqIlOUcr+rnYl230x/m8zU9FzIYTeRs3pJJdFdmuBKey+gosJQaRL6xsgOT6/zWQPbA81ZMhGJ2Sl7ZMxtpdIlIMrojQOSnRku2dbWzK7PQMEyMsMEOXXIWxpzHrUPNB/ZwXfrOYJ89qnbX0Mymr7GqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689571; c=relaxed/simple;
	bh=tfk7X6n3kO1RA4qc8tKbACMVGSD49Fs5iMlnJva28iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bnz5x0k4wKcoaGaAKBlWRhxJRVX54r1BmRtSe1n9//NmzN6XQ14ks/fGq88Pza2NlfoqZTIxnDkGMV04weffqe2O/XObgcAbHPLLXwWUBmcOXDzhgAownC2Sd1CoOEypbCPw9o0HXPKn0JAJJs6Kim3aMlRUE/2xpc6pEGcCIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klhRbOSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31594C4CED6;
	Fri, 15 Nov 2024 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731689570;
	bh=tfk7X6n3kO1RA4qc8tKbACMVGSD49Fs5iMlnJva28iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=klhRbOSAHSspjSNnOchKcQagNdjiEc8l4XcpNpKALMpeIMsvHQaOIcFILi5taI6lB
	 +Dyd6q11EjSWSTedRRbP/Z9XGVwQTuligFkjrBO3OLmIqJRs2CSc3x/+gAkmeB+Fj+
	 5fJ9+axwPlzFmEMK2g9Jj8xK8l2TB64oDfI6KMtUsv1obBc3Te/JJLYkaXjqQZIN+V
	 xCxRgjtNStb2b/AtQ1IYxCQgb6hrpyo3fD/JTiWW7Cn2JhiYIfAY7btSzlLlC3aX4t
	 TSGEwidDIsSnpw8NJvRIiljMv7PooGyIhypPneoR4pjgXGNfrgkGqSE/PhHtqjnpnQ
	 Uz/qYBhb9ZwoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Nov 2024 17:52:34 +0100
Subject: [PATCH net-next 1/2] mptcp: pm: lockless list traversal to dump
 endp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-net-next-mptcp-pm-lockless-dump-v1-1-f4a1bcb4ca2c@kernel.org>
References: <20241115-net-next-mptcp-pm-lockless-dump-v1-0-f4a1bcb4ca2c@kernel.org>
In-Reply-To: <20241115-net-next-mptcp-pm-lockless-dump-v1-0-f4a1bcb4ca2c@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tfk7X6n3kO1RA4qc8tKbACMVGSD49Fs5iMlnJva28iw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnN3xd077QW/bsrncR7Xf1wc5syHDvk4LP6DiNo
 aambIFQ1vKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzd8XQAKCRD2t4JPQmmg
 c6jpEADrJQs0OCr+jrodL8JTqgkmx7zN1xHzilkBLhLYoo50LofjPBljsQBqPtSf+mT0NpxvgzO
 vUnKp6LMep7195o/fA3hkPRQ6yeKHpo3ZDjYwyFpoXmllDzRuMwEuQUbAHNdNnkbjkOxBZvXwCo
 b7neUMpVzVVwJ5lW6vJGd6iT5TQ4Mp/DmEZJBNIges0lcBrCPYohnSCzfpWd4SsOUuMgr/JAtTn
 0Iy9xOfqaxFzv/NmKqZu2f3Ubh+XutSodHel/vyUc81BJQNbuJrCxHLYoNtk9g9vUwQQGxQWbem
 GKHGPKcCSA+ihEHsr+CbqAOyssYOXZjDba0skV7v/1pXIIVxDwFHVT9M6306clBz7UL3q8uq4pm
 XndV77sUz87qE1krD0OgclyWptTWlh8/3aHyPOb08tTN0WuHKgHfloNACqNJTzSFAlgS1Iudfnd
 MTwjGcuE1N5IJpD76l7/bTNLA8OukZ8R46Yl+eMx0DUTZz3mfX/sGb7B0JY31IeTcenxNv7GZxZ
 SzGhP/kFpSFjSUSCuzDTiPgjWtgRf3dei6eRqDX14yrvPYpvjLVLr7A3KSUoHNYnOa2P5i3V+NY
 c1Mj6eGg4ff1cBph/c6ussCkyOiW/rRQSVBpX20Z39ZKUXSAYMDIlWwbIR62+48sP6s7sko4VUv
 LiRcqAi+DWImhug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To return an endpoint to the userspace via Netlink, and to dump all of
them, the endpoint list was iterated while holding the pernet->lock, but
only to read the content of the list.

In these cases, the spin locks can be replaced by RCU read ones, and use
the _rcu variants to iterate over the entries list in a lockless way.

Note that the __lookup_addr_by_id() helper has been modified to use the
_rcu variants of list_for_each_entry(), but with an extra conditions, so
it can be called either while the RCU read lock is held, or when the
associated pernet->lock is held.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 758a0dbfcf78e545d840c0b580c0b12bd042d7a4..2b005ddfd2d365b66abf42065289d74630e604f6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -512,7 +512,8 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (entry->addr.id == id)
 			return entry;
 	}
@@ -1824,7 +1825,7 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 	}
 
-	spin_lock_bh(&pernet->lock);
+	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
@@ -1838,11 +1839,11 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 	return ret;
 
 unlock_fail:
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 
 fail:
 	nlmsg_free(msg);
@@ -1866,7 +1867,7 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 
 	pernet = pm_nl_get_pernet(net);
 
-	spin_lock_bh(&pernet->lock);
+	rcu_read_lock();
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
@@ -1891,7 +1892,7 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			genlmsg_end(msg, hdr);
 		}
 	}
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 
 	cb->args[0] = id;
 	return msg->len;

-- 
2.45.2


