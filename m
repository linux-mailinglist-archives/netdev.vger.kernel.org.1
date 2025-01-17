Return-Path: <netdev+bounces-159426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D757A15768
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34CB188BFDF
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD91DED69;
	Fri, 17 Jan 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qchWTjq3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED301DED5B;
	Fri, 17 Jan 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139315; cv=none; b=L0As+3Vu+sOB+Jnj8t82mxCRljQX08gGtJvoYjESpso+Fu6hs0BiH1sq+hgl8bnJa/NenCWxDGOkZjRs7M7I9pKVempavqEEaETuGYGEdzpmzYtqJS5bZiZBH898UdfnWfwK/QIpnuiNEAsxiZ30ZqFpU1a2EmbnED/sVhXBGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139315; c=relaxed/simple;
	bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8FBu9j5dfulug3T9+POyzDttCRiMkLgVOz38WWM1oOJyskUEa+iU6JUQk79plKi1fAP+ezI+LWpNGGciUf7BR2gxSM+GyXm+HNOgnxRLrdLKpy388FADbwPXDsMrdTJypcDsZgvXTAE7T/QFeyOd+lUw0sytyVQ/3Ydp8rIgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qchWTjq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA40C4CEE3;
	Fri, 17 Jan 2025 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139314;
	bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qchWTjq35Lx59D3Xdpt352QjqNAaiYdHgrlquJmI1nbwN+he8id1k/hwEIxz/CeRI
	 1hQwhb1JtVccRxhFdQ2oOQFVAPr8w3oI3a9tI0wBaz9e53W3m1dnHsbpLn+wMsPr8o
	 /RNoJxVAdJjChxjYxghBK8xHO/HWPOT/gcBAjNAgOXYuJorIEn/lceHHIFpziZnXm1
	 5FV9vdjRtE2RE2ijc0DDrfWLkTmpy6UVNvxjqrsAH7LJdFRUHnX1TgUrEfhvIgR/A1
	 DX9VhhOItqbYuXMjTFobvGxlgChHdRA/H0wO258m3XmrbsKAvoAnAaQhnpoyaCNYs4
	 55d8gJ1cmQdow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:34 +0100
Subject: [PATCH net-next v2 02/15] mptcp: pm: userspace: flags: clearer msg
 if no remote addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-2-61d4fe0586e8@kernel.org>
References: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqMkeDFlGyFD9y1D25BUIA1PxmPY2+vyqoV
 f/Pnx+Mmn6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c7Y9D/4kM4rXqFeBi/oCbJW6H4SS2s+wLC25GCp1/MHHKmmTd7vewD2Mq34uZrpbJsKfjoac5Uh
 B+Ex4FsxAg1ucssZeA4LJMX1BMw/E4F8FdVm4cgGAB75Z+p6mzpAieJt55CZdKfxDFrvqZ/JJh/
 ppZJoMdh4V2OUIG8d9esB593dGAzpOysqvAZ2R7bX0vLU9Zm7N6aqFIW9vKp8WNvdv4jLf0CG68
 +BRihNsbTv/HK7g2uhMGHUjHZZ3CdDnX5w4e+hxS/wHrXNLAKkoRhXGETrA3gN6F4e9Wf+drVOR
 cC5bNGaGuLqOQudUhXNrUcy1B5B0DfXAJe+oMaYkBkhen9bzWrmThfUTFyP7t/j4a077MYSI2mf
 21GpHFvgJ59aP8FX6W0D5I36E45HB2rQ8Bd6xyG1LNE3kG4BZ2kpMoZJCsOIwWduuMlvNL5uJLc
 NnVSAFmS3hJXE401AKBKcF4Ch1sUsm/AICTTblCE79qpfUY4k1p+GqxytqetAYafqfLNnoC7L8R
 wwbOrYoXzsUDin101lyKjVoJnxpgN0q26YwGYz/1OGXgXrXpwbfP3n1o47365DjcWn0gL1tkYQB
 byJ8V1fEl9XwHhIkwzkBpy3frJKDpTTa9//3l+8U7+YD9yJ3h5sgRxj4TwFgMgEpRoKxevmSomP
 Di7k4+DqE0f972Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since its introduction in commit 892f396c8e68 ("mptcp: netlink: issue
MP_PRIO signals from userspace PMs"), it was mandatory to specify the
remote address, because of the 'if (rem->addr.family == AF_UNSPEC)'
check done later one.

In theory, this attribute can be optional, but it sounds better to be
precise to avoid sending the MP_PRIO on the wrong subflow, e.g. if there
are multiple subflows attached to the same local ID. This can be relaxed
later on if there is a need to act on multiple subflows with one
command.

For the moment, the check to see if attr_rem is NULL can be removed,
because mptcp_pm_parse_entry() will do this check as well, no need to do
that differently here.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4de38bc03ab8add367720262f353dd20cacac108..b6cf8ea1161ddc7f0f1662320aebfe720f55e722 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -580,11 +580,9 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
+	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	if (ret < 0)
+		goto set_flags_err;
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {

-- 
2.47.1


