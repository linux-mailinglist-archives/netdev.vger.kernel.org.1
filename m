Return-Path: <netdev+bounces-164009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E20AA2C469
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F11188EF16
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF890223708;
	Fri,  7 Feb 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip4gEOcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43EF2236FF;
	Fri,  7 Feb 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936774; cv=none; b=n/YBjeIE/Mp2nYKUEyPSIHF8KCz7rXJ2bfLXrsP5oEQjIi51A65WBy8J5KgwIUgQ0w6C5fbVoNMngP9Mav8U6RAUi/XfHcIMpO3GUTLcwyBEGclEZmVpHVbAzkxsJtbwsoP2+v/yr5zpkitU69DwvBpD6tAHPl4RhS/gLxGbaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936774; c=relaxed/simple;
	bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5k4+8Lwvk+CVF35y2C5lkpYRr3UKtNpIdSZqwrLlXYCiYz8DhjxWrxqSP7cKbDcakUskiSIcNfo/ciE/msrpYcK6ZJ/oS9ecrW9XEGCm7asmqf9H6mS7j+e+OfzpyJpI03+8/ByVcPnDTL0N6MsACWHGq1qDiRZvTl8FapZYnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip4gEOcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28252C4CEE5;
	Fri,  7 Feb 2025 13:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936774;
	bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ip4gEOcbGtWR1tpreBGBnHxNe4WAL8N+x46W2A23uwFWDNnYLMF25NCoFJIYWNfPE
	 V7BkM4ERIbOsQ2yktFVGGW99Ise/JBQtQHYzZubV2zNm/YhcquXUaJcQl4kVJVzsOw
	 GzHQSK858VtaCbzv6W+RE6WkDo+Jfcd84SFHwKR35h5qxsdUfg0rtJopr3n6rWO8Xl
	 PEl+OQkN5mlSK/KNar5Bhd74aB900Rx6sxOJJkhDaUGy+BOFr4bwzydrs+qkUYFg5B
	 nMF4R4+zRtW4foPufqNZI9e8afRkXPrlSsuI5kWIrGfmKqg6MDUQEYbk3jonpJ+R1O
	 tqp4cE3nh2IpA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:20 +0100
Subject: [PATCH net-next v3 02/15] mptcp: pm: userspace: flags: clearer msg
 if no remote addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-2-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9ueOUUFMEVn3mUxWi0jMe61DcX1n1i6nbA
 Daq7s7v6bmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c0OuD/wKwl7YfF2RJ5XEe3lQ6EQYRsT4VD1Zl6f5zaj2NYNTjSIQF9KbmPoxWQcIRnZwRt17tOZ
 OiKuDXcAvj83NNGWxVztSqW0qJyHO7/B1exRsy+X+8OH+7pH0k0uO107uSpBRkAwuKbzF9hAQIN
 O0mEROt3nhyDGDKZXdLrBD7S8K0cOHp3+HwDSwPLh1VvfcgoC+5TuN5BZMk+ggHINP4dwjndsX/
 J9b5GfMKkyYYNhC6i+T57YA9ZYJuHdoElHMq/W2kFLZB3ZicWjtZ3wA5j7iRbnE0bYC91jpFW+2
 889XqYygyF/wRpyJLXVWJfvAxTX74Ko9hva1hZhwzV8VD1EO4HbjKTP82tvr2S/kLFTBoilY33T
 00mejNrV+2K/A5ReTx1oFANzjpJfS7j6qCvf1YJllREtTzrgMlr/DXswt/dEC3R/wiG+ra7KAzP
 YZTARxHGKXjRNMVek6XS8liJBrm6yH4BZRRyh69L0eoMsAfFKCyENlFPg+YYFFuzUZj1j+FPsJL
 nf5va7DOeVWM6xsaiB9pTwjODAJ48rQprX95B/cLoYBqdy4OJQco21A++LtIB2BsUxC9MjJd5st
 gQwrMPyIydrf2ne1lWtfLXfdDFdCb2c4ToZHbv1bVetJyLsrqX9w7WNXLRC00PZ4dbowtsfm1zV
 saW9apHMNdS/TEw==
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


