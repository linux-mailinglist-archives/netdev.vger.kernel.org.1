Return-Path: <netdev+bounces-164011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402BA2C471
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE18816CB2D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD23234999;
	Fri,  7 Feb 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEBMR0Yd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C38234981;
	Fri,  7 Feb 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936779; cv=none; b=H8tAhjaRe5DxfXwncAB3Wj/yndMqQV3u3RkEaxtKU9eG2K27HHQgPDNA9dNDolFBmvIV4KtFL02uBdIXPFhMQcNxzuZbFR4PJn+9MEeMJZUKDn4VVokIYbeJaoLsywG2pzJK9G/bLy9hAgBckCn4IMW7PO3eASf8xRqjxPJxePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936779; c=relaxed/simple;
	bh=iJKLcXa+lRER20dB3wd7wbKtdem1XltATghiiAeKEiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5us68meWyZKZBTwWz98RyAHvv0PaicrQvGgXVc0HpXkoMj0eQuhmAlfo/+BOjxjA8luijWMBdwDluCDRhpH4C3Elv5rngG6oTiuuIW4xxgu0F3LsYJGYTRK/mvqEjpv05KdxyQ/GxPhhBjB4nrQUyR17SPB6aIOP6bCfOKgIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEBMR0Yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15376C4CED1;
	Fri,  7 Feb 2025 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936779;
	bh=iJKLcXa+lRER20dB3wd7wbKtdem1XltATghiiAeKEiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YEBMR0YdVuR+O7PV1luxE1qxzJ1AyRI+3WkcjACox8rFxCb3f8suoUjKLibfCOz9B
	 4++7YpdKRKYvHikkDkARHrDokjMsddwjWaF/aMyY2t1M9CH+kkvuWatFADZtrSibFU
	 9elDpkqyHUtLR0GzBB4UX+JXgT/aLjRXr9IawvEgTBMofs/PS3bSquhhwqVeTzF3A+
	 QGHXM2jKLDxGPSzn5SYRQrfPVxK5jkeeBdcCulX6Dlawg+oKr+PtdNl0y5R3dPx/+8
	 bqMxGRgGHKnzzfENkvd69bcXiMe5yf9Ph7QwgsFMRmqNsBE3jH6xhk2Rh+kqTGyb9g
	 DId9qwTRNuqFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:22 +0100
Subject: [PATCH net-next v3 04/15] mptcp: pm: improve error messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-4-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iJKLcXa+lRER20dB3wd7wbKtdem1XltATghiiAeKEiU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG972Ida5v20ntBYQ8jspnU3GmaQZdm2zyOy
 r92LMRRYb+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 cxkTEACylQo6L36ElYzdZvmQSrpLPWR0Tbj/0OHkF30VxkJDpfvmr5GhzYLAWjn7mSnhh0NlTPF
 QIXjjkJrSsHSjqP0y7TnDYkp9Kevbf3SHmrnBOKFD62lrdx2PtrtIvq0Ypn+kfofMgf1ewZ/UC6
 u3g9OPFqFEY2ndTBO/afPXSx6EBzgOwhrTl21EDK8oFNJ6P3uwhpv2+6pmxSGx+GPTUk1q5KEZJ
 XziGw2t6q4O03mDQsulXq0KaLwrII+NXsJJTYYhdRgNv7jfVhSbObSVMJIFE02w44ec3ovNUhGE
 jyrP+sfKeGMHWihuYOrXRRtshYhMCAS9ZZHSrZJ/oy/ns5C2RQCtKAea5/jnv9Y9qCdHFtEAp4+
 IYyLZP74ul32+zVaiyn09cjXOjEl7j8UYmg01H7OsZAS5YcKQWMEwr343gy+SAdWJUwkXGTPJ8E
 tMdMf6y3x1h41Ca2LnJuLjkBPB7ujITAXEHjMCpQkl6VmGDfyQ67I7jt2iGm0ol06DNc4GOHMNq
 1HwVUZXa8FBmLBvqatGnubwALDqlbomlg4V+2HRd+NS4m4TVCE3yCqAjrvDI4LCUYWpB4F2h+Vr
 HQpPbNtj0mEzQVvjFT0gvWjk+YBR4ZnDI0KezDQ8B0VO9UJeVdzL3PFcFSHfxT52d9QyfEpuEFj
 MMys03WaqdW3kSA==
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
index 572d160edca33c0a941203d8ae0b0bde0f2ef3e2..1afa2bd8986231ae2eaab3a9c9044f841e2aea0e 100644
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


