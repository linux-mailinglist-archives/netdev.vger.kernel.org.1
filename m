Return-Path: <netdev+bounces-209915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032CCB11506
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10074E4F40
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4AA634;
	Fri, 25 Jul 2025 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hczMoTE8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAD10E4
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402254; cv=none; b=XwAckv/EvLKPA6XNJlUG/p0DKGGmKQARhPS6E5buF/UCh32vEPLJsVWLJX002tlV2f0Ck2m63dq+VFurXMTorEiEsndHCIHCZdXj6X1vpwaZnnAq+XXf7WGTUVARQ6VD17PFlL+O0OQOpfMpb7UmBMEV1PO7GNvqaPAYd4B9sk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402254; c=relaxed/simple;
	bh=7uZYGB0IRkCOjG7D1HMsGV92v6jXCysRu0IW5IwK6w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=snPdhYFn4V0uO9PF0Mevlk0RTuO1V4ZR78eWhekVCvm1PndFfUmuH8JpB8ANFC/pa99rjoRhjj8tJ2yWOwaA6fyhPXidzf8sAuXX2GCHj2AFtChuYwE1EwpuX2FGH2SwSacHNU27uLT4NjooKz8CCKd2S1yYDyTnFzoN/ntLmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hczMoTE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD79BC4CEED;
	Fri, 25 Jul 2025 00:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753402252;
	bh=7uZYGB0IRkCOjG7D1HMsGV92v6jXCysRu0IW5IwK6w8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hczMoTE8RJOGkrEt3000/3jmKm2TmHuJDN28VhMwsE0ONver9cBNOZpRe0dBT2V3t
	 KX723IaBbrCb1CWdmJJAph1NqKn3huLpVkKLf4u21MGxErkFDcm6B1OhBVq5C7NnRv
	 3m9T95w53YdJIEXE3D+vuvv0KsOcNaJs9II1PtrACHAtn5+KTeycii1hE0i8obRw96
	 EuuRhauQNI8YfxV7gS397+7qHC85c+ojxD3f7gFa3l4dPAArtQITPFnGJWzqGWabsr
	 SqIHzWZodCtcZZ+q28oo4vhfE73rUhInetmNLymlDhobjCc7cDZ/JzSuM/9wNwpbcA
	 an83pAb5pg/gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2398C87FCC;
	Fri, 25 Jul 2025 00:10:52 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Thu, 24 Jul 2025 17:10:36 -0700
Subject: [PATCH net-next] net: Make nexthop-dumps scale linearly with the
 number of nexthops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-nexthop_dump-v1-1-6b43fffd5bac@openai.com>
X-B4-Tracking: v=1; b=H4sIAHvLgmgC/x2MQQqAIBAAvxJ7TqjNCvpKRJSutYdM1CII/550H
 JiZFwJ5pgBD8YKnmwOfNkNdFqD2xW4kWGcGrLCtepTC0hP30836OpwwnWpQ9rgqbSAnzpPh59+
 NYCn+NkwpfRp1G29oAAAA
X-Change-ID: 20250724-nexthop_dump-f6c32472bcdf
To: David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753402252; l=2979;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=OGj1vCxWdoON+IaCcR0ZPs8gUo7LoLsrnae+RDRjLoU=;
 b=37Zou509rbRFVibQp3dEhNVLxItcBxrDZ0BMrpj0yL7mEE2SDxSfCANIYqkMEhxqCjhw8hm3U
 gsjlSbfyf78AzMITKoZGUy0Th6HQIKYzZrfrrZGrHC/MN0sH1Z36+XL
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

The approach in which we avoid dumpint the same nexthops is by basically
walking the entire nexthop rb-tree from the left-most node until we find
a node whose id is >= s_idx. That does not scale well.

Instead of this non-efficient  approach, rather go directly through the
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
 net/ipv4/nexthop.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 29118c43ebf5f1e91292fe227d4afde313e564bb..226447b1c17d22eab9121bed88c0c2b9148884ac 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3511,7 +3511,39 @@ static int rtm_dump_walk_nexthops(struct sk_buff *skb,
 	int err;
 
 	s_idx = ctx->idx;
-	for (node = rb_first(root); node; node = rb_next(node)) {
+
+	/*
+	 * If this is not the first invocation, ctx->idx will contain the id of
+	 * the last nexthop we processed.  Instead of starting from the very first
+	 * element of the red/black tree again and linearly skipping the
+	 * (potentially large) set of nodes with an id smaller than s_idx, walk the
+	 * tree and find the left-most node whose id is >= s_idx.  This provides an
+	 * efficient O(log n) starting point for the dump continuation.
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

---
base-commit: 8b5a19b4ff6a2096225d88cf24cfeef03edc1bed
change-id: 20250724-nexthop_dump-f6c32472bcdf

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



