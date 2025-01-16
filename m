Return-Path: <netdev+bounces-158971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EB0A13FEB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0301416B727
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31039232450;
	Thu, 16 Jan 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inGsTxum"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D723243D;
	Thu, 16 Jan 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046485; cv=none; b=jsf7BF3bL7nYiFDI/6/Ifvdr819u7LSIzD60y1+ZpDJDXdCAge2kIgK3yHEpUNVpYBhN+AlwIkANdL5a+JZDA0583pPM5IyT6CWvEQc2Pv0CtUajREKQHt/oPrHfcSUY5kGx9p6EyazjlWKlfptDFxtKAIKJuTkVKck6KLID5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046485; c=relaxed/simple;
	bh=ziY1kNo4JB2WGFwqk/DGfw7wmfDoIoZ2o4P5q2wJOOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rahexGIIb6ojcDhF/v8aJzu4q30/jW66CGVDtAG3ZR9d5j0oFAzG9hsCCfQg/jfI9w4tbiFafdJu0KIBkLJFLJ1R0Q8tkreQzhO6/VdWSx4hNd03f9LvYl7gQdIh3ryd87Ib7x3S1XVBXGJIcIkmF9rXT4/kk3l1UIaGnUpuO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inGsTxum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB36C4CED6;
	Thu, 16 Jan 2025 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046484;
	bh=ziY1kNo4JB2WGFwqk/DGfw7wmfDoIoZ2o4P5q2wJOOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=inGsTxumRBZ7RvrCNVdca+QhtgHIIQZCkmddqaTiKwpcy7KsAbII1C/0uigpDSuF5
	 GsjROws9rKQafYqo3Fl7Df/lF9WTeKgLXTxf8Ss9SD8KnU05/Fd3+vHOCDRiT4H9eK
	 wPf+UzpkFoJhoKfhEsAbtv9hcpCB7L/VrX2Puppw+vbebTK7v+jopFGUSltZdoXMaT
	 zT44MqcreA7ZOCSQBYLuXbDGsYPmy3na0CEQICh2x8vh5LQOzTiQI2EmLBpBUvXqvU
	 8l8a2I1zaAqBP+MMMv6ykEBxTwn28XtfH08qZ4YgSYlEaCZgE6XdlbrblQitYBuyf1
	 4Bx3EWvrwGMOA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:26 +0100
Subject: [PATCH net-next 04/15] mptcp: pm: improve error messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-4-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ziY1kNo4JB2WGFwqk/DGfw7wmfDoIoZ2o4P5q2wJOOo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnG4flcF3NSKxOkKdfa0fwkOjEhqGgpTHxlN
 ELnBh8thjqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xgAKCRD2t4JPQmmg
 cwdoEACKPvWXr2JpO9PR2sJHAvp/i72MjOm6nii1F1GBA3jDcHiPmfuVSh1S0hwFSgStR/3rHHr
 Vkmk14p20H53tJT7SCl0jBdP/7+KuI72b1v0khnlrUlqdVYMDKJXk8Mfi37RP4EZhoO5aPgHNxV
 Ylg85KMYTHs92Wsf0kksGS371hrX2Rhu24CU4YvuOGavjT6dSrUZpWoF3eFa5fPzLLn8ZWEJes/
 Ga3l1lk3uW52qwe/GpIVn1EAl+YQtAOgF2NtL600RbDVf1RazwPOpTR2nEYzEz08/Z2OYX1HleJ
 o5mKwoWD+NdLrp6krAhVk0m3upiiD4tRLW4E2DGEKjIUITAMLKMAKQp57d+vxer+Ds+RMJGVYlI
 7k4eitue+Kc+XQe2K56G5wy5Vyrk8A5YvYkC7g4JF60ui3YMJkomdhuQe3V1lJZS94iUdmMlC6E
 O67K8Q+TTcoidAqImsKYLfKCaLoqnzPll6iLCSnCgYgE//QRYvdPZW+jxjLrmaNALeXiS0dXnMm
 WW9jZ7HjdTJxjRJZDst+9yK5UxpogHNRm/Q3WoJNBf+583VYqfW9yzby/B2PQXUrZE1Ol7ASYTa
 /t8G8UY/pfy0Pwh0y9rdhRzPRTbR9Cmok4dX4D8r7HwQODDFO/SorJR70NiYh343iUHlAFEUBgd
 IT7cMlGu6OtWxNA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some error messages were:

 - too generic: "missing input", "invalid request"

 - not precise enough: "limit greater than maximum" but what's the max?

 - missing: subflow not found, or connect error.

This can be easily improved by being more precise, or adding new error
messages.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   |  6 ++++--
 net/mptcp/pm_userspace.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98ac73938bd8196e196d5ee8c264784ba8d37645..a60217faf95debf870dd87ecf1afc1cde7c69bcf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1875,7 +1875,9 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 
 	*limit = nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		GENL_SET_ERR_MSG(info, "limit greater than maximum");
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
+					"limit greater than maximum (%u)",
+					MPTCP_PM_ADDR_MAX);
 		return -EINVAL;
 	}
 	return 0;
@@ -2003,7 +2005,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
-			GENL_SET_ERR_MSG(info, "missing required inputs");
+			GENL_SET_ERR_MSG(info, "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index cdc83fabb7c2c45bc3d7c954a824c8f27bb85718..e350d6cc23bf2e23c5f255ede51570d8596b4585 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -190,7 +190,7 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		GENL_SET_ERR_MSG(info, "userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -428,6 +428,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
+
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
@@ -552,6 +555,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
 	if (!ssk) {
+		GENL_SET_ERR_MSG(info, "subflow not found");
 		err = -ESRCH;
 		goto release_sock;
 	}
@@ -625,6 +629,10 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
 
+	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
+	if (ret < 0)
+		GENL_SET_ERR_MSG(info, "subflow not found");
+
 set_flags_err:
 	sock_put(sk);
 	return ret;

-- 
2.47.1


