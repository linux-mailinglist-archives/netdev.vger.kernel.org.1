Return-Path: <netdev+bounces-145345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9171D9CF392
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD8CB344A3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76CA1D63E8;
	Fri, 15 Nov 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpFVHUOL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6781D63E0;
	Fri, 15 Nov 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689573; cv=none; b=sk86kvDsNIr4o8LQylgNE/u3IOvLfVlECRitq7OTGZL+1/1eEGhvfRxZqm0a7ykO6vrGFy81H+XzKJ6HpOhZwYfDAECFRf6DRqGuNIYNzxQIveYEcWeR5EwNfu7TCWT4cX2Amz5HU7dgE87lndagkGzBvbdET7IWVF2PyxoReVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689573; c=relaxed/simple;
	bh=KmFQIPqrunG4ak8MKbdja0liL+Kg5SrJXxe1wOz+7gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7f5SG4rgfUr3p81PEPUyOh1xxSxQMU5RPRgy4+nwwO4wg2PPopAMhxcnKIXrAktIPnR2S4WXgzj1XR71tugp0DdScjfn/OHs5WD66Gy+4XBGGAc/fya9iQG629Yhc49Gb1YbPC7dyEPDHb+tZPZlyn+AwtorFP/sqI+2opzZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpFVHUOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D723CC4CED0;
	Fri, 15 Nov 2024 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731689573;
	bh=KmFQIPqrunG4ak8MKbdja0liL+Kg5SrJXxe1wOz+7gY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GpFVHUOL6XkAyNBmxv2aKUOvgpMMp2Wesvur5mFB9hEDoSploEXuY4CKvBhN+LxZr
	 YK1DIGadS+3g8i395ldRnq7fCoO5jzLvB+UxvRfs842e93WMGPkr//f4pYLtBtw61g
	 zbLCix56VWLPnsu0Yx1TymKgd5lbb8fWbdmNmGq5PVlcthH/Y1rs1fjq9fjb322DTq
	 nbQPR/1Ef5YnICOHDr1GbI4kCfMnjSTt/vUjGd6mfeyDVURH8PNBmD+yxmYubcq3hA
	 pXrQiC7ANssgF34XOPOaVruFoyBIHF1ajx5T4g/ofHtZ8oUhRQd+yXrIUsAGwYEOjS
	 IMS6w3mZBNj1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Nov 2024 17:52:35 +0100
Subject: [PATCH net-next 2/2] mptcp: pm: avoid code duplication to lookup
 endp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-net-next-mptcp-pm-lockless-dump-v1-2-f4a1bcb4ca2c@kernel.org>
References: <20241115-net-next-mptcp-pm-lockless-dump-v1-0-f4a1bcb4ca2c@kernel.org>
In-Reply-To: <20241115-net-next-mptcp-pm-lockless-dump-v1-0-f4a1bcb4ca2c@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O/z/Hsnsu0LR75JFQ4U+yjYL7PiLIn4Ce3jB0lRGo68=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnN3xdydDjCMxxodmAEg7nruMUclT9BHZ93cVyJ
 TmDdIH8x1+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzd8XQAKCRD2t4JPQmmg
 c+CuEACSxEujOpkJttoIF3f9j5rKquyF0TJ0EYDQuXkpOMPUZLPq73ZtfD2EMjK/EPRAmP5fljp
 4aQhKqhwqYfoK8tboi/UiIarV5bdmRkanCRJpc1N6+lFR4YtP9JBrAkSH6mfANJcfLMcMJYpUh+
 66Bcfe1Q7zm25XbBBnRW+YGicF+7yK7Dhc73e962bOgEXocPTKvu1aWYchIgfOba2BA+TCuweS7
 jo9J1t0kqvxGmZ2XgxRPCSnw7OHjU9gjhwQtnledSYtQqJ0fX6Of8i5k+Q18kVjojzgnGYMlaTQ
 APZKbSL/OCTo7W5r93YxpAX9ylgCpw4M70gTPat5rDNRNgVIVzvtGFVvVwXH451kyQ507AAaqB+
 ugJ8EYAa85BDWYJ5Bp2xLEZxj9NpM88KSDTQ6Oijw5mssKbN/elHVaDnEZUGFFZ135KsjjCh2js
 cnfYCg6vmwwDb6ulhgKNQzOkaabCWCyUTtjwOIwVTst5Q3rBof40NWkGFEBi+vQZ4OE3SHuUnEe
 KZ78aCxnkt55wXz2Npp8iWT3pkCyUdE/broaKYQP6llkZSXAP1l5ebBvETKAw70prSnUv4iqCvQ
 f4jTXfBmiasz1HpDMY+91+GZG3j6cG+rUbPRDxDS4aygxYglYnNyuhBDOKt7a6i+7HJeLmMWTMi
 uDL4e5qyCCB6sMQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper __lookup_addr() can be used in mptcp_pm_nl_get_local_id()
and mptcp_pm_nl_is_backup() to simplify the code, and avoid code
duplication.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2b005ddfd2d365b66abf42065289d74630e604f6..7a0f7998376a5bb73a37829f9a6b3cdb9a3236a2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1143,17 +1143,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	int ret = -1;
+	int ret;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
-		}
-	}
+	entry = __lookup_addr(pernet, skc);
+	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
 		return ret;
@@ -1180,15 +1176,11 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
-	bool backup = false;
+	bool backup;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-			break;
-		}
-	}
+	entry = __lookup_addr(pernet, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	rcu_read_unlock();
 
 	return backup;

-- 
2.45.2


