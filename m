Return-Path: <netdev+bounces-164021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CBA2C488
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1193AD326
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1354F23A577;
	Fri,  7 Feb 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVW6iDix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49C239091;
	Fri,  7 Feb 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936804; cv=none; b=M08oCIhvFuFoRu3rCi5dEIn57F8BFJ9jYQXjl/X9XtDayL4+l1ZI2rOlhTH6vYTPwy6HVgELHtJfXUOVO4GdAf09yga++A/qnjV4RwKsiTdXaAPQuM5HTss0LwnDUIdHDxyOd10wjH8q/a95EdlPHxW7NjJ7YC/OwHQtMKALbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936804; c=relaxed/simple;
	bh=gBNXX9ppG946EXfwDDL/S6hzfb1PJK8Xt2CCfsMNeRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kckF/OWK730eErbAy2EdkVNlVt31h0KxOY7zYIq9To47ztGtd6g5RYCszQun6meYCoxWHZMaeLESlMeQN3A74FB5r/R1bDCd65IfXBgQRBajgksq+HpatFa10X0nPDmhokFPfo0h/bOobBs6rPrxtguB+jpTjrlQS4bES6Lg4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVW6iDix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3820C4CEE7;
	Fri,  7 Feb 2025 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936803;
	bh=gBNXX9ppG946EXfwDDL/S6hzfb1PJK8Xt2CCfsMNeRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UVW6iDixZPM03snWEoDWVl0eqsINxQsqqq6ETYVoi9K06dMeEgy2Zf3MVRvS2zY8u
	 LbSNqvOFfkoVCbgajrrAONMI4ZEteoKyOhkXV9at90QKQb5zvupDr0P6AP3/+AzBql
	 OD7+Vj3Krwl28YdSWtHGERNIGR4NEUrXxGu+Z01hhY/pjPCxeRF+lD0kgdFSy38unk
	 Uw/jvvuRroOA+Nuqb0Jtfcwt9gFly7sDiRbB8mlJW7c1+cx7miN/jZNrPVZO+PNmxZ
	 hPm/jz8mXcoPy/odakSc8y9JlJh0c++fHeIO6gJUOuAnAmvFD2kIbSpOluo24XKy9N
	 hE7V2WXHrX3DA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:32 +0100
Subject: [PATCH net-next v3 14/15] mptcp: pm: change rem type of set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-14-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CVowOfogh0VIETqdYsiGlawSG6f73txjSRWz/bdF42w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9Li8/Ot5614PI27kR6K7q+MxvlhgH13OZW
 aF4FxbTATuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c9mwEACHu4bBv+3KvVU4nQyKc0bVuUDh3YE64bHYtrJ806d3q7laAgrc5ekgiabtdsHG00y91r8
 Fi4hFDY/hloDZ0u+WHKQlYjzBhOl1REsS7UzFG2ESQTT2hP4TFAnYmJxlndAR4HEkPmW23kGr3a
 RLTVvIwVZgSgZy6ACKL/JSFjkHoR6CFPorKu1JLtYtbgbXdkD+m8DM2UQZYbNxBWter0CknwevI
 yozM6T6BJO5Ed5rKaBG1uFu5GkmBK0dQNMtOfbP7eenWMm/L/npuZgtUty5e60FWzF/D2NcgL90
 bpzIBBbPUWWTOWymIqwWzXml8Cpm+CC0n0Dxp40dTsa0t5TWp2urdr046huwPrs2wr1p0vEzIQQ
 xUyRPyODOFjXY6TVZiGkkT2UGqlzQLjs2vVC4qWS53F/PpRsh+9FD2Oqdvtp90XW+MhtAmPA2dm
 OP9ZNDZajrFMf+GeenYQ68R0wpsVDasN2yrzugQ+KRBqNLXbrXdPIelj6G3e1S+tRLPL3ciCHVO
 UX1FWCruMqPjFs3KY3Ul8mWMHa771Redl+tvwax3oIOam95blaZyRYIVYKI+t5os7tfOvdbY2UI
 jYQA1+cmam47dPqr9++bIyjc826zRKw9e8mpdudXI+daspS7kWPXQ8DKZZtOebUi3Okk/Q2JMVB
 xAPwWNwBGUlDZrw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined
as an mptcp_pm_addr_entry type address, while the remote address is
defined as an mptcp_addr_info type one:

    (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the set_flags() interface uses two mptcp_pm_addr_entry type
parameters.

This patch changes the second one to mptcp_addr_info type and use helper
mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4fa3935c5b477dcb50260b3a041b987d5d83b9f0..1af70828c03c21d03a25f3747132014dcdc5c0e8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -567,7 +567,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
@@ -598,11 +598,11 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	}
 
 	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (rem.addr.family == AF_UNSPEC) {
+	if (rem.family == AF_UNSPEC) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
 				    "invalid remote address family");
 		ret = -EINVAL;
@@ -623,7 +623,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */

-- 
2.47.1


