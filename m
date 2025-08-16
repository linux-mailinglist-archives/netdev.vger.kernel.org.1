Return-Path: <netdev+bounces-214355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8D5B290EA
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 01:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3397B0028
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 23:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F3923F40F;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3P1QIBy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034D215175
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755385988; cv=none; b=omOvgV/UXO3JHPU+MgIE6VYtLpRNWPPJmiOXNUC4/OL6Z/jVEz/bfCUc7kN0enQYUE5KJh8qerigtle5DQa8zpIZWsUaToJ3F4APbHL0Wi4cljvcn0t7U7/0FEvlv56Qqk1iNqZrfKyKC0qoYm//oZWRfW78HX42Cp1vVRP4sRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755385988; c=relaxed/simple;
	bh=Rl3t65V3dFEsQ1RYW/qCkHJ2p9s2rpLl9Z7RXkazzNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkoTg1L4bknLJN0OTR7vvDiI29zbTkh8BhSD4wecfz9BZAO+eetU2btsRqerFPGB5ctOTfVRBBao+r9Wo/mniEVbRbLD2sCfXhCMQyttugF5wWHbpcbHGpEaUjr/6S9G2sbk7X5IkYKTLVH1Oex95hahEXfadE0BYsVuURwcZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3P1QIBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4154BC4CEF6;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755385988;
	bh=Rl3t65V3dFEsQ1RYW/qCkHJ2p9s2rpLl9Z7RXkazzNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X3P1QIByY0hkhtbabt2iUdVvanO4wEpjj8EeD4x18B9UCBVDyBt6q2HbJrkYUopBq
	 MiCD38jnm+dQXoWQC7jrt1tYUqvyQv0dzwf1dHgUvz5MmbzK2W8sgnhcn9zD8JOA+w
	 EknR0Hb5FIcc+n5mmN0SWjP1B0yI7HbQS4FpVMg9Fsex0BzolBzN9dy7E4CDYsB5wt
	 rVXuhDJ5dZOdtf78fcfr/RIhoYlY3lCDvXRBPrQqvgYq2byBYOGuEkNrudyZqKUGpt
	 5bXtAKfBeHQqaE96dHlzJesdYrvcwWvPeNxgwgi4tPqwOX/gupBX4EJMcZqEQdqmum
	 6Vn47/GjH9cLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31724CA0EE6;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sat, 16 Aug 2025 16:12:49 -0700
Subject: [PATCH net-next v2 2/2] net: When removing nexthops, don't call
 synchronize_net if it is not necessary
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-nexthop_dump-v2-2-491da3462118@openai.com>
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
In-Reply-To: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
To: David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755385987; l=2230;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=pWb6FXe0Ufgtfgh7z1wN5oRm8vc3NP0L20N8nbaldKw=;
 b=JDaQ3c73msDslVitWgfYMnSIdzVaUTZ4eHgoaMk1GrIM8kEr3DmL1cTQ9s4IMhMCY6sBopZ8B
 fXFz4BsFtrpCxPY5dm99gHwt3XSwY5yBecaZKvykJGPd+iQ8seJzmno
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

When removing a nexthop, commit
90f33bffa382 ("nexthops: don't modify published nexthop groups") added a
call to synchronize_rcu() (later changed to _net()) to make sure
everyone sees the new nexthop-group before the rtnl-lock is released.

When one wants to delete a large number of groups and nexthops, it is
fastest to first flush the groups (ip nexthop flush groups) and then
flush the nexthops themselves (ip -6 nexthop flush). As that way the
groups don't need to be rebalanced.

However, `ip -6 nexthop flush` will still take a long time if there is
a very large number of nexthops because of the call to
synchronize_net(). Now, if there are no more groups, there is no point
in calling synchronize_net(). So, let's skip that entirely by checking
if nh->grp_list is empty.

This gives us a nice speedup:

BEFORE:
=======

$ time sudo ip -6 nexthop flush
Dump was interrupted and may be inconsistent.
Flushed 2097152 nexthops

real	1m45.345s
user	0m0.001s
sys	0m0.005s

$ time sudo ip -6 nexthop flush
Dump was interrupted and may be inconsistent.
Flushed 4194304 nexthops

real	3m10.430s
user	0m0.002s
sys	0m0.004s

AFTER:
======

$ time sudo ip -6 nexthop flush
Dump was interrupted and may be inconsistent.
Flushed 2097152 nexthops

real	0m17.545s
user	0m0.003s
sys	0m0.003s

$ time sudo ip -6 nexthop flush
Dump was interrupted and may be inconsistent.
Flushed 4194304 nexthops

real	0m35.823s
user	0m0.002s
sys	0m0.004s

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 net/ipv4/nexthop.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 509004bfd08ec43de44c7ce4a540c983d0e70201..0a20625f5ffb471052d92b48802076b8295dd703 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2087,6 +2087,12 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 {
 	struct nh_grp_entry *nhge, *tmp;
 
+	/* If there is nothing to do, let's avoid the costly call to
+	 * synchronize_net()
+	 */
+	if (list_empty(&nh->grp_list))
+		return;
+
 	list_for_each_entry_safe(nhge, tmp, &nh->grp_list, nh_list)
 		remove_nh_grp_entry(net, nhge, nlinfo);
 

-- 
2.50.1



