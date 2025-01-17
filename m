Return-Path: <netdev+bounces-159427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28CAA15771
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C40C3AAAC6
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEFC1DEFE7;
	Fri, 17 Jan 2025 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twSGKUme"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148631DEFC2;
	Fri, 17 Jan 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139318; cv=none; b=bb0LZdjmqDttj7UfukcLZDUwJOV7+sGMqLcl/Jl1jBfv9h84VRuAG5thtWIK/I+lFnGya6vvDAvtvGmpbMGQHdRXOTh+M51uMUSvYKpPE9TIZ2vOhq86R5qdsMWX4DFxcHaoc7D5p1wI55YPk3RnsezBO2x2aFmeALfwLMm9hhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139318; c=relaxed/simple;
	bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8L1agZVUBKIyLJNM328wsp/ujbC+uLwk8b2RplAAnWrk1G04Y2Cs6zUTRrEvVLU/YA74BiaPs6Yzl6FBx3mMRyW7HAmI4HY3EN5sKB7Nz1lj6IbZL0JLhIcoKRpvTXgOu3CYRkz/y5/9PuatSg8f9Ads+GZJaapD+/8Nx/q3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twSGKUme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524A1C4CEE0;
	Fri, 17 Jan 2025 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139317;
	bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=twSGKUmelVI3K77aOH0v9lfRjoc1y9mQ98YcgczFyFmDhZCT7M0k746vgPrGTYayg
	 o7y24YIOaMRAgS6fIP52bCEVI5eVQIGkwPDlPaIJPezwB719dxEHbPkqyII2pqxh7U
	 C5Wulc17pnMGcooziGdkVuhOedNtMAZ0lHTiY2YgradrzB9d6InrYoFToYKFnDWHry
	 Lv0b4ch1Z6okWFrFv9Pe3eY5uMK3MCYOJDk61ByRIx8G1fWax8IPQTbCmBQZtLdAhw
	 i+Zspuvqn57PbopuS/DbxDMfkG6hA01paSZtWhSMB/7r3QwL9XMSO3xYN+Ti1FC6ao
	 AATrzxN6t+pCg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:35 +0100
Subject: [PATCH net-next v2 03/15] mptcp: pm: more precise error messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-3-61d4fe0586e8@kernel.org>
References: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqkXF527JvDWAAbi+5e9zxEn18fVb1bhr0r
 b8rJ/ARe2GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c7xpD/45l20LP+o2AA0gBYMSbbtO2sPQi+HVNKTqOCKGm5NvvWptiAvq34u/KBldvarqIzk0r+F
 TeEDzHwbhd40aGxgmeeu62DhlxoAwDMrUgjnx1wk92sOfqZR4wkIwIK0WpBFerom0m46ztpO39C
 DbpbEQDM9epNl4zYueVG1BslXXd+PSbc1rUWg27IsqUspbceIhHHiYQI13Ukxt6YcpuMjVvJl3P
 kX40RcZrqj2H2XlPGx4PgHLJ0XmU33B1iYo44pcEk0sVhB4Fv4Nu8KdYLKiuKG+nIUpFNzKM8js
 k7N2G+63RBv9UYX3Zg9u5KNf5RpccCXIQohAa35/TJEj0kYh4ZxSGYBEJ6rOgbHgSJXV+4aUgmf
 vq+/o8/mG5Qffni6giDWWZbOBizpteidWoafGWuK59ftn9ycu2SzaU7cC0VBMwCs9K+TO1sDWmJ
 qF7pgnt7FgknEWPke57hqiEKi937ijvr3BQLRi44W8f2Z38qdVq4Zp1+6csmpEXB++ao2yCO0kk
 e4i/FFqqnZ/VPCgPpVw+Wbw4p43is8TjlleiqoX1INOdt7OLdZtmz4tGJ5K4JWAxsj0XhHIKpm2
 PwtaMFWr/zWp3MgeuXKwAhPhIIOFViWPKC/qej+DQvc6uyqCaeVg5FFHCEpRqqaVoLzDLL6rpoU
 n6wa1Xiyv7o3/sQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some errors reported by the userspace PM were vague: "this or that is
invalid".

It is easier for the userspace to know which part is wrong, instead of
having to guess that.

While at it, in mptcp_userspace_pm_set_flags() move the parsing after
the check linked to the local attribute.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b6cf8ea1161ddc7f0f1662320aebfe720f55e722..cdc83fabb7c2c45bc3d7c954a824c8f27bb85718 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -223,8 +223,14 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
+	if (addr_val.addr.id == 0) {
+		GENL_SET_ERR_MSG(info, "invalid addr id");
+		err = -EINVAL;
+		goto announce_err;
+	}
+
+	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
@@ -531,8 +537,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	if (!addr_l.addr.port || !addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing local or remote port");
+	if (!addr_l.addr.port) {
+		GENL_SET_ERR_MSG(info, "missing local port");
+		err = -EINVAL;
+		goto destroy_err;
+	}
+
+	if (!addr_r.port) {
+		GENL_SET_ERR_MSG(info, "missing remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
@@ -580,13 +592,18 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
+	if (loc.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid local address family");
+		ret = -EINVAL;
+		goto set_flags_err;
+	}
+
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
+	if (rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid remote address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}

-- 
2.47.1


