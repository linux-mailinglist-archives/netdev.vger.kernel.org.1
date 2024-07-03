Return-Path: <netdev+bounces-108829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1F925CFF
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB29D2946A6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5878178360;
	Wed,  3 Jul 2024 11:14:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEF176ADE
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005255; cv=none; b=Kt9V5aK79W7wA1/rv6vog9AaZCuhJlYBwYdP0SD05MLNx+Rf6pjDg9yzkGeAHhh2N6VHL3jua1Kc+0R11tgUsBv2WpVtNPvwIBuPXMdnzV+ZUXBzkUk0hhKUQNOmq0Qc8qc3HSlAgxhstG4K81yQg5x+gU/3I5NWsQRxPB+qQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005255; c=relaxed/simple;
	bh=LwBw1zEKk9wEAd4W8Z0j7/66ozRiQjAGQk2hU6TqGwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jo8PVRxXw4Vj36k71Q2P4onNVB4IcDhpLhXVc+p4fMdI13OABbxVBqkeJA65eHJFNtChC7/W56iKsPSER1eVDQr7oxnLvoCiVyWWEdMcax/r0L0k9YdVaxerjIbUEpPt8uNKsbSG59rOhOUxAB8yGz+JHtAR9AKjAdcFKqnXAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sOxw8-0007cz-Fi; Wed, 03 Jul 2024 13:14:08 +0200
From: Florian Westphal <fw@strlen.de>
To: dev@openvswitch.org
Cc: pshelar@ovn.org,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next] openvswitch: prepare for stolen verdict coming from conntrack and nat engine
Date: Wed,  3 Jul 2024 12:46:34 +0200
Message-ID: <20240703104640.20878-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At this time, conntrack either returns NF_ACCEPT or NF_DROP.
To improve debuging it would be nice to be able to replace NF_DROP
verdict with NF_DROP_REASON() helper,

This helper releases the skb instantly (so drop_monitor can pinpoint
precise location) and returns NF_STOLEN.

Prepare call sites to deal with this before introducing such changes
in conntrack and nat core.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/openvswitch/conntrack.c | 47 +++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 3b980bf2770b..8eb1d644b741 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -679,6 +679,8 @@ static int ovs_ct_nat(struct net *net, struct sw_flow_key *key,
 		action |= BIT(NF_NAT_MANIP_DST);
 
 	err = nf_ct_nat(skb, ct, ctinfo, &action, &info->range, info->commit);
+	if (err != NF_ACCEPT)
+		return err;
 
 	if (action & BIT(NF_NAT_MANIP_SRC))
 		ovs_nat_update_key(key, skb, NF_NAT_MANIP_SRC);
@@ -697,6 +699,22 @@ static int ovs_ct_nat(struct net *net, struct sw_flow_key *key,
 }
 #endif
 
+static int verdict_to_errno(unsigned int verdict)
+{
+	switch (verdict & NF_VERDICT_MASK) {
+	case NF_ACCEPT:
+		return 0;
+	case NF_DROP:
+		return -EINVAL;
+	case NF_STOLEN:
+		return -EINPROGRESS;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 /* Pass 'skb' through conntrack in 'net', using zone configured in 'info', if
  * not done already.  Update key with new CT state after passing the packet
  * through conntrack.
@@ -735,7 +753,7 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 
 		err = nf_conntrack_in(skb, &state);
 		if (err != NF_ACCEPT)
-			return -ENOENT;
+			return verdict_to_errno(err);
 
 		/* Clear CT state NAT flags to mark that we have not yet done
 		 * NAT after the nf_conntrack_in() call.  We can actually clear
@@ -762,9 +780,12 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 		 * the key->ct_state.
 		 */
 		if (info->nat && !(key->ct_state & OVS_CS_F_NAT_MASK) &&
-		    (nf_ct_is_confirmed(ct) || info->commit) &&
-		    ovs_ct_nat(net, key, info, skb, ct, ctinfo) != NF_ACCEPT) {
-			return -EINVAL;
+		    (nf_ct_is_confirmed(ct) || info->commit)) {
+			int err = ovs_ct_nat(net, key, info, skb, ct, ctinfo);
+
+			err = verdict_to_errno(err);
+			if (err)
+				return err;
 		}
 
 		/* Userspace may decide to perform a ct lookup without a helper
@@ -795,9 +816,12 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 		 * - When committing an unconfirmed connection.
 		 */
 		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
-					      info->commit) &&
-		    nf_ct_helper(skb, ct, ctinfo, info->family) != NF_ACCEPT) {
-			return -EINVAL;
+					      info->commit)) {
+			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
+
+			err = verdict_to_errno(err);
+			if (err)
+				return err;
 		}
 
 		if (nf_ct_protonum(ct) == IPPROTO_TCP &&
@@ -1001,10 +1025,9 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 	/* This will take care of sending queued events even if the connection
 	 * is already confirmed.
 	 */
-	if (nf_conntrack_confirm(skb) != NF_ACCEPT)
-		return -EINVAL;
+	err = nf_conntrack_confirm(skb);
 
-	return 0;
+	return verdict_to_errno(err);
 }
 
 /* Returns 0 on success, -EINPROGRESS if 'skb' is stolen, or other nonzero
@@ -1039,6 +1062,10 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
 	else
 		err = ovs_ct_lookup(net, key, info, skb);
 
+	/* conntrack core returned NF_STOLEN */
+	if (err == -EINPROGRESS)
+		return err;
+
 	skb_push_rcsum(skb, nh_ofs);
 	if (err)
 		ovs_kfree_skb_reason(skb, OVS_DROP_CONNTRACK);
-- 
2.44.2


