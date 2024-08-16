Return-Path: <netdev+bounces-119316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C40FB95524F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515CFB22B92
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3151C579C;
	Fri, 16 Aug 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjiE7DOp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF81C37B6
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843370; cv=none; b=p3QKj1l0gJPlfQaXf1Huze5lQJTxl4+h/VsqWWi+9wV4Pw0wOlxbq6OQVteRoV2o9bDQn2Yejpl5lVU8A1SnHovoTbHQ/jv0wMMnSBHzFwn7axtpCYVa0VPyaZwkQK0OzUO8x8ewM0TvYnXc4W2o8JqD77JdCODyef9JvUSATtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843370; c=relaxed/simple;
	bh=xk/T6nNSBSVYSGz1GLdsq9HK71l2sK1gnO89nD7cq9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQVjVa91MENaBCYBBSmBoYWfUbp4ro5Wcs0p4phb4KDO6vAMeQSs26Ew6ww2/QQt6FR//zVkK9hAMnmiUzBiRSw/alsxNDKrvy670keb93HYP4D7fAHYCOPb7wT+N0FQxIBPhEghbwD21huM/W9CvsHWbprY+hj7lqMvDyILz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjiE7DOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29253C32782;
	Fri, 16 Aug 2024 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723843370;
	bh=xk/T6nNSBSVYSGz1GLdsq9HK71l2sK1gnO89nD7cq9I=;
	h=From:To:Cc:Subject:Date:From;
	b=gjiE7DOp/MyJzAlskK2p3NCpnutOtadkvFkox/TUCRCFDtDW/OaIvAdEMh5R9ZUpw
	 Udy4j+tlQFhGnVmQvOCSWXLHnhVovar0xGhYGbWvQbmgs64iSWGQlbdPTfEO23N3AX
	 h7TmC4RDkfhcyRGhHGFRUbya/snaG7mpQ+mdedn4yZnrB6nrub4Ul7USrYVmgYvcgq
	 Ehm9FP+E4LZ2PZaZZTTsS1UfX4hvJVx5Wfua6ikg63LGX/++EUvM8MXHj3wOdWApLS
	 rQPgsMtLJmmz1Bt19qYnA+4YIwNOAaEdbkTMJFuXq7id3lDspOcl2X8euK2cj7j7ai
	 3J5sv1gpcCwNg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org
Subject: [PATCH net-next] tcp_metrics: use netlink policy for IPv6 addr len validation
Date: Fri, 16 Aug 2024 14:22:44 -0700
Message-ID: <20240816212245.467745-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the netlink policy to validate IPv6 address length.
Destination address currently has policy for max len set,
and source has no policy validation. In both cases
the code does the real check. With correct policy
check the code can be removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
---
 net/ipv4/tcp_metrics.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index b01eb6d94413..95669935494e 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -617,9 +617,13 @@ static struct genl_family tcp_metrics_nl_family;
 
 static const struct nla_policy tcp_metrics_nl_policy[TCP_METRICS_ATTR_MAX + 1] = {
 	[TCP_METRICS_ATTR_ADDR_IPV4]	= { .type = NLA_U32, },
-	[TCP_METRICS_ATTR_ADDR_IPV6]	= { .type = NLA_BINARY,
-					    .len = sizeof(struct in6_addr), },
+	[TCP_METRICS_ATTR_ADDR_IPV6]	=
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+
 	[TCP_METRICS_ATTR_SADDR_IPV4]	= { .type = NLA_U32, },
+	[TCP_METRICS_ATTR_SADDR_IPV6]	=
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+
 	/* Following attributes are not received for GET/DEL,
 	 * we keep them for reference
 	 */
@@ -811,8 +815,6 @@ static int __parse_nl_addr(struct genl_info *info, struct inetpeer_addr *addr,
 	if (a) {
 		struct in6_addr in6;
 
-		if (nla_len(a) != sizeof(struct in6_addr))
-			return -EINVAL;
 		in6 = nla_get_in6_addr(a);
 		inetpeer_set_addr_v6(addr, &in6);
 		if (hash)
-- 
2.46.0


