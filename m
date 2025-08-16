Return-Path: <netdev+bounces-214353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C22B290E8
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 01:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2192AA75A8
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 23:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F323E338;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVGKbf2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38518C011
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755385988; cv=none; b=aUbvy3AoytHeZLBXwR+tCJpYkrI2BzISliP2QCvESlEDLMgraaO3u86FwL1Bhg+N8fd5dUO/O8dCDbxUZXVY+O0EGkHjBmllhTIAsUrym4hBGL5hyza9I7e+sp46q+JLijQJAPDPgL9K9M7jbo/MsJDmgA/7xCyM4DHYgh8lCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755385988; c=relaxed/simple;
	bh=dUT+AKMECEjjKwRSBjYeE/erEE1PQvyNQceU7o5gvjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+mT6j/tFVDRPIFp96FcrIw87n2zkegVE0Xroocn9TUgYW3JbUMYVhYSjCk2zeKkKYo/wYZru4oaIQtSedcagLJFsAqk20nxDSPFsmgbQiQIcw8ymoDS5Q0nVM6utU/noxgc3ouAHp81HDOVlflk4z2l5L5JP8x9H7UQ+0zU3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVGKbf2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 350E7C4CEF1;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755385988;
	bh=dUT+AKMECEjjKwRSBjYeE/erEE1PQvyNQceU7o5gvjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PVGKbf2wNiXVsx0oKQfp2jB2Dgtu4QZ2cnPDFWuoXZmp9KhB47dtPSKqiHsBwiDVT
	 wwTFxokMxNgespaBNAEZOkVVwZ87scOksGvrkLQ+30dlL4w66Bv8O/CQGyQi2Gr/r5
	 wfzlnW/jvOeGu4yLCzsXAb+ly0cC07lkJz/idvEpTqtH0/kLU+B1crrWIfTlaqbFkK
	 AdsoL39IQ5VeGHkXFVyF1WxX61qRNQTrkO4O36IIuAtIP2cssC9thhPNBrjV9VlD8L
	 3EL73QsvQd+EvU2Myjpdo1iXGsUEmSfwZF1jOA1iQQZNVPUiFuzXymshlE2LJ1oRn7
	 I8rPFkoh6svwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24167CA0EE9;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sat, 16 Aug 2025 16:12:48 -0700
Subject: [PATCH net-next v2 1/2] net: Make nexthop-dumps scale linearly
 with the number of nexthops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-nexthop_dump-v2-1-491da3462118@openai.com>
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
In-Reply-To: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
To: David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755385987; l=2925;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=apKNtEHwkr4v5/jPGvEtuEPYhIYZl9VTHDdTthjYsCg=;
 b=bf4ina5rN8+11TYjqY0Aqd6HmpsYSES9LNWSEvriUY+/pe2q6HlhdiZHmEzwCseWNcQMcJ27G
 OFSIaSAvuDtDTmL9FHZ/S/JH9cRoFcnr6t0fvDZGD9ns8lrIvH3OPaM
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

When we have a (very) large number of nexthops, they do not fit within a
single message. rtm_dump_walk_nexthops() thus will be called repeatedly
and ctx->idx is used to avoid dumping the same nexthops again.

The approach in which we avoid dumping the same nexthops is by basically
walking the entire nexthop rb-tree from the left-most node until we find
a node whose id is >= s_idx. That does not scale well.

Instead of this inefficient approach, rather go directly through the
tree to the nexthop that should be dumped (the one whose nh_id >=
s_idx). This allows us to find the relevant node in O(log(n)).

We have quite a nice improvement with this:

Before:
=======

--> ~1M nexthops:
$ time ~/libnl/src/nl-nh-list | wc -l
1050624

real	0m21.080s
user	0m0.666s
sys	0m20.384s

--> ~2M nexthops:
$ time ~/libnl/src/nl-nh-list | wc -l
2101248

real	1m51.649s
user	0m1.540s
sys	1m49.908s

After:
======

--> ~1M nexthops:
$ time ~/libnl/src/nl-nh-list | wc -l
1050624

real	0m1.157s
user	0m0.926s
sys	0m0.259s

--> ~2M nexthops:
$ time ~/libnl/src/nl-nh-list | wc -l
2101248

real	0m2.763s
user	0m2.042s
sys	0m0.776s

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 net/ipv4/nexthop.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 29118c43ebf5f1e91292fe227d4afde313e564bb..509004bfd08ec43de44c7ce4a540c983d0e70201 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3511,12 +3511,42 @@ static int rtm_dump_walk_nexthops(struct sk_buff *skb,
 	int err;
 
 	s_idx = ctx->idx;
-	for (node = rb_first(root); node; node = rb_next(node)) {
+
+	/* If this is not the first invocation, ctx->idx will contain the id of
+	 * the last nexthop we processed. Instead of starting from the very
+	 * first element of the red/black tree again and linearly skipping the
+	 * (potentially large) set of nodes with an id smaller than s_idx, walk
+	 * the tree and find the left-most node whose id is >= s_idx.  This
+	 * provides an efficient O(log n) starting point for the dump
+	 * continuation.
+	 */
+	if (s_idx != 0) {
+		struct rb_node *tmp = root->rb_node;
+
+		node = NULL;
+		while (tmp) {
+			struct nexthop *nh;
+
+			nh = rb_entry(tmp, struct nexthop, rb_node);
+			if (nh->id < s_idx) {
+				tmp = tmp->rb_right;
+			} else {
+				/* Track current candidate and keep looking on
+				 * the left side to find the left-most
+				 * (smallest id) that is still >= s_idx.
+				 */
+				node = tmp;
+				tmp = tmp->rb_left;
+			}
+		}
+	} else {
+		node = rb_first(root);
+	}
+
+	for (; node; node = rb_next(node)) {
 		struct nexthop *nh;
 
 		nh = rb_entry(node, struct nexthop, rb_node);
-		if (nh->id < s_idx)
-			continue;
 
 		ctx->idx = nh->id;
 		err = nh_cb(skb, cb, nh, data);

-- 
2.50.1



