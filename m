Return-Path: <netdev+bounces-100332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C108D8923
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996402847EB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C8139CF2;
	Mon,  3 Jun 2024 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOjqpEFt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8D13B798
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441062; cv=none; b=DKAPpxn6qYKBV+UcjLfr9KnNrDGHQhjCRMsrlmEu/XVc8FXobwR8W0rNosGmxtbIsRYRoU0Po67hLE0Ysz7+naD1UGa4ejBeJhc8jFm5MdjH9hjB1xV+qA2eKm2Gu68ktqzXk9D9aLBVnc9Tpvt4zY9wpJDE2BfFITwFXCPhV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441062; c=relaxed/simple;
	bh=mVwwYMl1OdGzNy/Wsg5IEmizpoOZ6mCPt5pefo278mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXeuFih18wG5WBJzhVzek4dD1zVlXhR91WlSSr+JucbumlRENp4se3NAUrfpsKEgRPl7Df+MlY/oi9hV5qDD4ZjpbnBiv6MQzO2w14+c4b7nMlZLZgwsZpVsr31J9d/FhgfTrE5IHhKmh7AMcpFdI3+fXiKtd0LD9a7gPErdf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOjqpEFt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717441060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIT6bpi+QA6lCG9sj/bdR00vB8OkBUOOPJlemYB4yWU=;
	b=DOjqpEFtXysQVmK/pYbcEoCck/5t4QV4pkpIw3iWRKbjLgShAMB69AUXRWJim9c5BKBxfa
	DCafJ+eHejpuWrvkpkwmDCEOPGSzIeAqpe0paHli1oyXdc+mdzd/871ZrtKZ4Es+OYV0lN
	VyQyp4p5gT2CvU3NzASa8fSrNZX5LdI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-Ff_xJSlDMEC6qRHJ4q03sw-1; Mon,
 03 Jun 2024 14:57:37 -0400
X-MC-Unique: Ff_xJSlDMEC6qRHJ4q03sw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CCA118FF92F;
	Mon,  3 Jun 2024 18:57:35 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 361A11955F6E;
	Mon,  3 Jun 2024 18:57:30 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/9] net: openvswitch: store sampling probability in cb.
Date: Mon,  3 Jun 2024 20:56:40 +0200
Message-ID: <20240603185647.2310748-7-amorenoz@redhat.com>
In-Reply-To: <20240603185647.2310748-1-amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The behavior of actions might not be the exact same if they are being
executed inside a nested sample action. Store the probability of the
parent sample action in the skb's cb area.

Use the probability in emit_sample to pass it down to psample.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/uapi/linux/openvswitch.h |  3 ++-
 net/openvswitch/actions.c        | 25 ++++++++++++++++++++++---
 net/openvswitch/datapath.h       |  3 +++
 net/openvswitch/vport.c          |  1 +
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index a0e9dde0584a..9d675725fa2b 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -649,7 +649,8 @@ enum ovs_flow_attr {
  * Actions are passed as nested attributes.
  *
  * Executes the specified actions with the given probability on a per-packet
- * basis.
+ * basis. Nested actions will be able to access the probability value of the
+ * parent @OVS_ACTION_ATTR_SAMPLE.
  */
 enum ovs_sample_attr {
 	OVS_SAMPLE_ATTR_UNSPEC,
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 3b4dba0ded59..33f6d93ba5e4 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1048,12 +1048,15 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
 	struct nlattr *sample_arg;
 	int rem = nla_len(attr);
 	const struct sample_arg *arg;
+	u32 init_probability;
 	bool clone_flow_key;
+	int err;
 
 	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
 	sample_arg = nla_data(attr);
 	arg = nla_data(sample_arg);
 	actions = nla_next(sample_arg, &rem);
+	init_probability = OVS_CB(skb)->probability;
 
 	if ((arg->probability != U32_MAX) &&
 	    (!arg->probability || get_random_u32() > arg->probability)) {
@@ -1062,9 +1065,21 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
 		return 0;
 	}
 
+	if (init_probability) {
+		OVS_CB(skb)->probability = ((u64)OVS_CB(skb)->probability *
+					    arg->probability / U32_MAX);
+	} else {
+		OVS_CB(skb)->probability = arg->probability;
+	}
+
 	clone_flow_key = !arg->exec;
-	return clone_execute(dp, skb, key, 0, actions, rem, last,
-			     clone_flow_key);
+	err = clone_execute(dp, skb, key, 0, actions, rem, last,
+			    clone_flow_key);
+
+	if (!last)
+		OVS_CB(skb)->probability = init_probability;
+
+	return err;
 }
 
 /* When 'last' is true, clone() should always consume the 'skb'.
@@ -1313,6 +1328,7 @@ static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
 	struct psample_metadata md = {};
 	struct vport *input_vport;
 	const struct nlattr *a;
+	u32 rate;
 	int rem;
 
 	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
@@ -1337,8 +1353,11 @@ static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
 
 	md.in_ifindex = input_vport->dev->ifindex;
 	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
+	md.rate_as_probability = 1;
+
+	rate = OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_MAX;
 
-	psample_sample_packet(&psample_group, skb, 0, &md);
+	psample_sample_packet(&psample_group, skb, rate, &md);
 #endif
 
 	return 0;
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 0cd29971a907..9ca6231ea647 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -115,12 +115,15 @@ struct datapath {
  * fragmented.
  * @acts_origlen: The netlink size of the flow actions applied to this skb.
  * @cutlen: The number of bytes from the packet end to be removed.
+ * @probability: The sampling probability that was applied to this skb; 0 means
+ * no sampling has occurred; U32_MAX means 100% probability.
  */
 struct ovs_skb_cb {
 	struct vport		*input_vport;
 	u16			mru;
 	u16			acts_origlen;
 	u32			cutlen;
+	u32			probability;
 };
 #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
 
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 972ae01a70f7..8732f6e51ae5 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -500,6 +500,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 	OVS_CB(skb)->input_vport = vport;
 	OVS_CB(skb)->mru = 0;
 	OVS_CB(skb)->cutlen = 0;
+	OVS_CB(skb)->probability = 0;
 	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
 		u32 mark;
 
-- 
2.45.1


