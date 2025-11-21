Return-Path: <netdev+bounces-240834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEAC7B016
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13CA64ED5F1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D57F354AD3;
	Fri, 21 Nov 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSX+Q8lg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120323546F7;
	Fri, 21 Nov 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744576; cv=none; b=AecPw9pj6+XhhFiZT6IBySwJ0A1W6dG8lhp0ioZfDwPQmE6SqAmZt3XfgPXN8iEYvGYY9GlqpJnX9XdQTTB0Jw1zYKdVkx4ZVLl6Kct7MznKECNMO3iUFLADW58ZoVfZ7twDZCwprAhWHPNhTWVbUwpWY2u+paOl9fs5oBOiOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744576; c=relaxed/simple;
	bh=gF+aKM/DWD8pO3TJStmjtkBHNQi5DzGMJDiohuFYPlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swwSg40Qan8LjDMPNcSuwygCxxqUOTNB8t2WuIfFnoa3uOBsIlmQNAlrjVsovtlsCmbocnHRoscRtKkALgT0RRHpsuXIpBTI5nkWIszokPHiFYd41T+EUKlAHJN+zEjWLFPkjB4I4M2t44ZFopS+nHGwubUc6xNQ6B9NjpNCIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSX+Q8lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C5BC4CEF1;
	Fri, 21 Nov 2025 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744575;
	bh=gF+aKM/DWD8pO3TJStmjtkBHNQi5DzGMJDiohuFYPlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fSX+Q8lgcIsD01JHS1mY26BjGAxJbhFEztXjpe3M+BV8YsACqdWou2U6gbuL92RvH
	 iE0u/kqUW87FADV1CLVIZwkvy+8vg9LTcqEEaBpGM+l+Xud3RI287ZJ4s/RNTcGtzO
	 P5c7ETF0EOTJh14PG4u91bYETQyzPAA0NrEEWtbDFrJ8Vz4aW1WVRUlIkDv1UR0P1w
	 tN4McXtpRO6dAbcYlOs8WwRmjGuL43xr8HirRh9xDmieKH5hC2rOya7ScsfM6MZ2kh
	 Hfd2T5hVwQ71wE1smZcFCeSp6Ulcr5kZRcV6ruTr8FuyPQakIlIIDSlEnlgq5f6c6Z
	 S9RExzHbxBaOQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:07 +0100
Subject: [PATCH net-next 08/14] mptcp: do not miss early first subflow
 close event notification
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-8-1f34b6c1e0b1@kernel.org>
References: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gtdZKYTiUr42xJypfzFgeFyAQf6xGlVY7RStOQVlKdE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZkv2Laxy1Y83KBFr2qbWxRyWcqD4lVWH/Keq+Cl3n
 eoLNwp3lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATMTLj5HhRMFq1tSIGN4inz+3
 X/DEVpt1v5rVd6C/jof52Yy47crXGRmWO7yprbDcu8Or4c7yVUZT+799n8bF9uyk+4/EupOb38x
 lBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol is not currently emitting the NL event when the first
subflow is closed before msk accept() time.

By replacing the in use close helper is such scenario, implicitly introduce
the missing notification. Note that in such scenario we want to be sure
that mptcp_close_ssk() will not trigger any PM work, move the msk state
change update earlier, so that the previous patch will offer such
guarantee.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index df4be41ed3fe..2ee76c8c5167 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4052,10 +4052,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		 * deal with bad peers not doing a complete shutdown.
 		 */
 		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
-			__mptcp_close_ssk(newsk, msk->first,
-					  mptcp_subflow_ctx(msk->first), 0);
 			if (unlikely(list_is_singular(&msk->conn_list)))
 				mptcp_set_state(newsk, TCP_CLOSE);
+			mptcp_close_ssk(newsk, msk->first,
+					mptcp_subflow_ctx(msk->first));
 		}
 	} else {
 tcpfallback:

-- 
2.51.0


