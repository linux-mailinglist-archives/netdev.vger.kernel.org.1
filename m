Return-Path: <netdev+bounces-240825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95EC7AFB9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4215342A07
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8B33893C;
	Fri, 21 Nov 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edUiglc1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE32ED15D;
	Fri, 21 Nov 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744555; cv=none; b=mCFzFmJlravIgZkOWErRU6pa59/DApe6Pd0QoXjJRnpXKJS2qDDpxoKiRhr84Stsd75RUZTukJMpZGpIjxcVGdSMkV9HurC7urjOrLskWf0QbHS+2ZoJTjh0JzU1rmUTT0/YNHWk4XKfUG3eROmhwnYTlYB6bhE1KZeqOBLLEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744555; c=relaxed/simple;
	bh=0S2Dl/LwDiEUosVGC/2CWwzwI/BJ/rbvoLABLOoz4Jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvEHiV3PuQrV8R9btG8cL6giRYVds4WfjNM5I50W/DHgnMzKG0r95QYRQMFsVYCHcaoIN1uTvrC+M2thN8C1qh9JdhTusV1qT5VoNuFuK+BHpHudrjlSSooGyjruTkUJWEN5ZDA9S+4sZiH0umaL9XHYQ6F0kLw6XeaNeFXvFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edUiglc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F60C116C6;
	Fri, 21 Nov 2025 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744555;
	bh=0S2Dl/LwDiEUosVGC/2CWwzwI/BJ/rbvoLABLOoz4Jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=edUiglc18eTAHAXbz4xdaykCLWbkZGRNecOm9BKlIarDcfw5QdlErvL1rApCqvmpW
	 ctGdrPQTlKk1N4SNtwFMXF5VyMCQPUTohzpK/7khpnFvKddJb6zTrAwkwIuZfskyRy
	 Cfp6FWQwUQde1dUbxoDt+V8K1z4Kw3M4XnU9RRy3SYy5O+biqXMgh0NaTxPzcIOMf3
	 cCIFRjIclM6eNKZzrfOM60U2Qd/VreArsMshOi8eIF45Ig37rrWI6M95ZHsfRdkJV3
	 p6rrJ/gclgEVDn+xbiqeG1TJuCcJpCLavLtQ509PEN1YfpDDnMl1Dw7/5U5bEPB/x/
	 NFuKwRa4iof+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:01 +0100
Subject: [PATCH net-next 02/14] mptcp: factor-out cgroup data inherit
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-2-1f34b6c1e0b1@kernel.org>
References: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5JqcFvBV+VrzUQAyfBZzw40qaie6ZII/3JwjK0LcD90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZgsJ3P3Osrfil7HAhK7ZBTNkNgTkZpkGrHf4J+T9M
 0b/guLTjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlYFjP8s2krufNN/V+Y8e05
 KyZsP77uAqvdt3nhz/UTNyVe/zvJKpKR4VUxw/KZfr2Gu328Q/3kH5g8fti758Tj8IjPn8OPp3+
 fwgEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

MPTCP will soon need the same functionality for passive sockets,
factor them out in a common helper. No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 20 ++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a23780ff670f..6d9de13c1f9c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -707,6 +707,8 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
+void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
+
 int mptcp_is_enabled(const struct net *net);
 unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ddd0fc6fcf45..d98d151392d2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1712,21 +1712,25 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	return err;
 }
 
-static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
+void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk)
 {
 #ifdef CONFIG_SOCK_CGROUP_DATA
-	struct sock_cgroup_data *parent_skcd = &parent->sk_cgrp_data,
-				*child_skcd = &child->sk_cgrp_data;
+	struct sock_cgroup_data *sk_cd = &sk->sk_cgrp_data,
+				*ssk_cd = &ssk->sk_cgrp_data;
 
 	/* only the additional subflows created by kworkers have to be modified */
-	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
-	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
-		cgroup_sk_free(child_skcd);
-		*child_skcd = *parent_skcd;
-		cgroup_sk_clone(child_skcd);
+	if (cgroup_id(sock_cgroup_ptr(sk_cd)) !=
+	    cgroup_id(sock_cgroup_ptr(ssk_cd))) {
+		cgroup_sk_free(ssk_cd);
+		*ssk_cd = *sk_cd;
+		cgroup_sk_clone(sk_cd);
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
+}
 
+static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
+{
+	__mptcp_inherit_cgrp_data(parent, child);
 	if (mem_cgroup_sockets_enabled)
 		mem_cgroup_sk_inherit(parent, child);
 }

-- 
2.51.0


