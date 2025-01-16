Return-Path: <netdev+bounces-158977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443CCA13FF7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B0A16B289
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00425242263;
	Thu, 16 Jan 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkyQ/NjR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD5242247;
	Thu, 16 Jan 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046500; cv=none; b=beOajpC4LmdoGx/1a4DFvZXSGeU6so3F4tYEYRN2FuVRNFOb4z2E2xxPL0Vqe+5Pq+fY2DGrsJ3Qj8tcrroxes27fkSIrGeVDOop7rXSowVitGVBHkJdpRBBwJTmjEXwgkMZ0vIO4D3xQ2E/cmDQyh77oz325pah+6kz53QoVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046500; c=relaxed/simple;
	bh=uziRL227ApHOvwJzr8yQyxGJWOUBP26j3Jr3QhVI4Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqYcnlESyDQjR6vF8d6q3L4UW5OycwnEHKYuWP2AZ4hxtunwmpTnZDd7M8/FN+N4cpucHbhLYX9f0oTeP7YiN4yZfsZdA2FoB5aXpbrf5V5zzZGeCYMtJI103Z2+lkwkpcZ5rdAyDpaGytwvkDEnplQ19Wr/ke4NwudUUDId8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkyQ/NjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677FCC4CEE4;
	Thu, 16 Jan 2025 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046500;
	bh=uziRL227ApHOvwJzr8yQyxGJWOUBP26j3Jr3QhVI4Ms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WkyQ/NjRd/1faneUvfeVnYHrIslP+Y36U0JFc7keriQ25fBcYV55Wvi4R+55ncCZ8
	 R8fML0MIzvTs89CsVMFaRES/zPzDqKTuvLgu0CQuwEv/RKlEpsbYymglvCchkMURDA
	 KkXS1dMUeUaWLeG3y6nXXxJ14e4vidmdO8+uAQPMOQw1xTJrJn3OMPoU7noRwd/Cgg
	 ymFLVzMxhNCxc3/oZrlqwaIUeLx/Vwtlc/FI/hXHqjv7KK2qHKiZSAerTRVq+eE5il
	 /Riwp2XFFt5TCcaU7ik3cW5Rjm1NRGXsAZg3jcu3BnGtcsKFbZ17whH8CQ5kyFlXWK
	 rHWy+tpafFxAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:32 +0100
Subject: [PATCH net-next 10/15] mptcp: pm: drop skb parameter of get_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-10-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0rjmG/ewCiPTFRj22Er2jmFVpoiIpDJnsPfK53wI9zs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnH4RqyP7JrwgW/nTJ4I+NZ9enWimctVARDE
 i1cOKBVM1mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xwAKCRD2t4JPQmmg
 c4AAEAC/Iyu2qfKBq1n+qApfJxDWTMIO5ydbEcTQ5PvdYbQhGiMmeO6fSpZXFtKeawIZm502F4t
 9UD21J4gGgG0/zbzvnD3TnZUtUFDrt1xmGN9GWc8cka5v7SPKpIrWm9BxaP6fxvIYIARs79rYs8
 i+M6ncfSAdcjkpFcNdxB8kyal2FSz5fcBFDTZ2MR368wwhCyBmCCIDE/C/26sHFsTLqAA+Xyuk6
 dWPwk10HbWIOub8Hejs4RERILz5F6lJBKI6MjXRiYUwaEzOF3JGWNejgE5TfBpryIDf+1C5WgZ3
 WfI3lURwRbLPz2SnHQTqMqNqNIAOEqzPHuI7mjujjW69lTRR/FX0qXLCv88JUIeNdPjfNW74JHS
 0ooj5OSyQsi3XV9Ry6zYgoTQE1baSbN5VmTtPwnjetZ+gxmcrugqvf2ILZGNcx1AO2yxhpBVTUS
 b5tskiAu4Usr9nZKoUhMW/H9VdFdGn8VlsLflkBNQMHE+cbGd7Bixzd0AlZzToy1eUUBLzFckRT
 nWZuCIX5/0qt9vleaoEpxqB/2886QRbrgt7/kLqYxIbI4zAqLUbwnaRdZhuZb5tPeUQ6AHkR1O+
 d30WPG6NnhN4p1m46wvsqdWMvpNJLTnprMJP7duQO+EBt4zhMsvALoXR/54rC8C/b7avu0eZWkK
 6Ken8+RQfVqWwwQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameters 'skb' of get_addr() interfaces are now useless
since mptcp_userspace_pm_get_sock() helper is used. This patch drops
these useless parameters of them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 8 ++++----
 net/mptcp/pm_netlink.c   | 2 +-
 net/mptcp/pm_userspace.c | 3 +--
 net/mptcp/protocol.h     | 5 ++---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a29be5ff73a6b5ca8241a939f9a029bc39914374..526e5bca1fa1bb67acb8532ad8b8b819d2f5151c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,16 +434,16 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
+		return mptcp_userspace_pm_get_addr(info);
+	return mptcp_pm_nl_get_addr(info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(skb, info);
+	return mptcp_pm_get_addr(info);
 }
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 460588833639e88c51a6e1f417bd4ba1a8039d47..853b1ea8680ae753fcb882d8b8f4486519798503 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1773,7 +1773,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8dddb16247363a11ba11bcb94c4557dd0cfd8745..1246063598c8152eb908586dc2e3bcacaaba0a91 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -684,8 +684,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 98e7262c6b06f96b9c3a8a711e4bb755015c118d..69f3909bef8fd163e701f27a003378cdea453805 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,9 +1127,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct genl_info *info);
+int mptcp_userspace_pm_get_addr(struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {

-- 
2.47.1


