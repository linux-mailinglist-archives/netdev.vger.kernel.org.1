Return-Path: <netdev+bounces-107053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E7919883
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA3C286643
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28D183083;
	Wed, 26 Jun 2024 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZIcwYDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903F13C833
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431272; cv=none; b=rGtPo4K6+n/CwDaCJW28D9vMRZxPqfOJ5qXPV+geEOmPpm/GCbTN5tPjCjzzhAnz6/51FzuABdtfCaQDJBq9V+EImPZvKjC6YKSOK7WuK1g5sp6Cqj9htvmWevSVFFGr+szQhV5xkFCsDeHuaw1N/n1NXgklB3qnEI03E5EqWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431272; c=relaxed/simple;
	bh=MCN291EWeRARLGuhM17ahE5XoUnmbem2yrdU60EwJJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gyo+TDbaJe+5fQI0WJUhKN/lJiObFsK63JG7TJzPZeTNlg0qLdUOvxqu0RKa3sQ/63fnsSCUDx5BlA5C8BaXdqgyd5/LjobllIhkS62Iym9zVk/Qgxv50PPpvbitBLtPdV2/Qf+P9ltAxTh39jZSVCkd2KXkKpsA+uI58umz4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZIcwYDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC74C116B1;
	Wed, 26 Jun 2024 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719431272;
	bh=MCN291EWeRARLGuhM17ahE5XoUnmbem2yrdU60EwJJI=;
	h=From:To:Cc:Subject:Date:From;
	b=YZIcwYDnrpE0l6afSfuV1pJbfaCxyN51Uw2sFxJax8wha1riG9VTvKjZ39cJi51Y5
	 EqsgARDl50QjvOCxizAsVBi47vIm3VDgyPeUmwXm/TkKzfXRFNXKvg4pLnrAMQYfJm
	 y9BJPzEGQQP47t/IOCWIuUeD1BnfSKzBJnPscYI/wt/vyR4svTkRMp/EWS3ASdCwBv
	 K/5RMdwYGycyYQAgH/U5jbkjjvWegee2YIXtuB4lxY4E95kGF/hk6lQLmeEUaCGGaV
	 XcOgqiBYghqBNkCignWJm7TETsw1VFI4W7i9MCZO2b5ZaU0m8dEKVWPu2EJcEdZ1jZ
	 Cfw5nKjrM4yJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	christoph.paasch@uclouvain.be
Subject: [PATCH net] tcp_metrics: validate source addr length
Date: Wed, 26 Jun 2024 12:47:47 -0700
Message-ID: <20240626194747.2561617-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I don't see anything checking that TCP_METRICS_ATTR_SADDR_IPV4
is at least 4 bytes long, and the policy doesn't have an entry
for this attribute at all (neither does it for IPv6 but v6 is
manually validated).

Fixes: 8a59359cb80f ("tcp: metrics: New netlink attribute for src IP and dumped in netlink reply")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
In net-next we can make v6 use policy for validation, too.
But it will conflict, so I'll send that on Thu.
---
CC: dsahern@kernel.org
CC: christoph.paasch@uclouvain.be
---
 net/ipv4/tcp_metrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index e93df98de3f4..b01eb6d94413 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -619,6 +619,7 @@ static const struct nla_policy tcp_metrics_nl_policy[TCP_METRICS_ATTR_MAX + 1] =
 	[TCP_METRICS_ATTR_ADDR_IPV4]	= { .type = NLA_U32, },
 	[TCP_METRICS_ATTR_ADDR_IPV6]	= { .type = NLA_BINARY,
 					    .len = sizeof(struct in6_addr), },
+	[TCP_METRICS_ATTR_SADDR_IPV4]	= { .type = NLA_U32, },
 	/* Following attributes are not received for GET/DEL,
 	 * we keep them for reference
 	 */
-- 
2.45.2


