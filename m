Return-Path: <netdev+bounces-107459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3091B183
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F02818A5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7671A01AE;
	Thu, 27 Jun 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDWD6DJn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AC13FF9
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523506; cv=none; b=rHhCmE6caBYes/LNetowVFqkylv4qbbjys5mJCkRE2TFWekG+fMxpAfwxw9LslPWgzkxsewwOjLZQi+QcpqX6F2QPi7UD9SbwqJNrjjv/SEdT375kT36p5/hHpXpQaDjac5hSrLPm9HBjvuAnVXJIeRtmuRKvcN6wFWFVk5mVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523506; c=relaxed/simple;
	bh=X9aiujd8kYp9QJTgMAMMkfSZrl4cOwhxz+r5UfkVEzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UerZkgn1pxInvpVnyfnrR4CbMT/LKkmVn+LehzE+3QXv7QAxBLE5da+jjdFSqLNLF1A3WtbGIFE5BmL8UflYHsWtWz4KochpAfw60y8ZDsxWUieRgpciFLhVRH8gP3+mIQmazZK6bUFrdtR/4qLor3cWEzCkyHpFs/3cVragYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDWD6DJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D27C2BBFC;
	Thu, 27 Jun 2024 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719523506;
	bh=X9aiujd8kYp9QJTgMAMMkfSZrl4cOwhxz+r5UfkVEzg=;
	h=From:To:Cc:Subject:Date:From;
	b=HDWD6DJnxFgTuis16MkMsJZo6K0R7xtCaspmbZkqj1SjPLdxij4qPiQE9Bf8VLoZl
	 fE16CKGL8iYXTnUVvVeBq3muPtKDpuqxEEpnT4FeWcqYtjy8X3ecbCwDJ6ETGgLlQW
	 rmA4MGk5HTVE75S+LLaYbGdMZV6qu/dj5H0IuUOxCWE2bqD7paJKb5+uYbvujxlj7d
	 K6y3wymo6nVtbK9Jv1v4jDFKOCYHDASDgzm8gnBuRulBLgddNAag8BSkcfpc7tJ/f0
	 x0P0Ve7VJ99EimzoQXpz+UokeEg0cCcGQ2M34eKLlnxp8d9CY5k78rxTPsoFeW/wdf
	 /wu/9rVrvdQyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	christoph.paasch@uclouvain.be
Subject: [PATCH net v2] tcp_metrics: validate source addr length
Date: Thu, 27 Jun 2024 14:25:00 -0700
Message-ID: <20240627212500.3142590-1-kuba@kernel.org>
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

Reviewed-by: Eric Dumazet <edumazet@google.com>
Fixes: 3e7013ddf55a ("tcp: metrics: Allow selective get/del of tcp-metrics based on src IP")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
In net-next we can make v6 use policy for validation, too.
But it will conflict, so I'll send that on Thu.

v2:
 - fix the Fixes tag
v1: https://lore.kernel.org/all/20240626194747.2561617-1-kuba@kernel.org/
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


