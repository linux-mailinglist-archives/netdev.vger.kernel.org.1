Return-Path: <netdev+bounces-106669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D329172BF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D9C284C63
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F19180A98;
	Tue, 25 Jun 2024 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9jSS65T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089417E47F
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348782; cv=none; b=XinUxp8GxypoMa9jf9x87HLDRKXz5AdUSS4pvQgg7kszUsN4b+wHfq0Ha5BoLzIA1ABZpdDlfmvlw9Pfs8RI6bB4epqycWRi3mdylMeaBiTmaVNGx3iZhYSuEXYc1xiJeIvu3PAQrel8XTHRumtjSscVQ2grGQjbtxXb1pd7kRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348782; c=relaxed/simple;
	bh=TLgXOsnbMBfw+qAM9TZ7UDAPmwpdBqEG2mHftoCbV6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mmoo4w2JjhRhW4ve1BNt3OVum4JHnDsD71Nc/RSY3bXmHi/P6/DigbIMO8ibFthHWgz32Cc865JOWFNsSP0shXm09c9+MZeou79dSD/HA9Nb06Esmj9OKB4H03ma4TXtRgQzl1gLiR9ttAAC6mJQJ93V7siTmbmRf9REdBmC9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9jSS65T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719348780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4tsbBCQ/TpcXkk8fqlOC0aI9jmHAnBjEbttrU1YB00=;
	b=O9jSS65Tvuli4Rb5AAWhLf3EoJA8wQcJvpXhpsk+W11dOiQ0gCWYum5LF+ekWZzeQNqg6k
	ndUtURvR9HhROxBfREEJy68lwNmngU3z/adt10RloIBSKhUMBOJVR5MmyAE2nKVWeiVPfB
	WVjFdxdzu55/6WSJTv5KxCqobRLEHG4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-4tPgqXtXP1SesQMd6zVjyQ-1; Tue,
 25 Jun 2024 16:52:57 -0400
X-MC-Unique: 4tPgqXtXP1SesQMd6zVjyQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9441F1955E74;
	Tue, 25 Jun 2024 20:52:55 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 964E619560BF;
	Tue, 25 Jun 2024 20:52:50 +0000 (UTC)
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
Subject: [PATCH net-next v5 06/10] net: openvswitch: store sampling probability in cb.
Date: Tue, 25 Jun 2024 22:51:49 +0200
Message-ID: <20240625205204.3199050-7-amorenoz@redhat.com>
In-Reply-To: <20240625205204.3199050-1-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When a packet sample is observed, the sampling rate that was used is
important to estimate the real frequency of such event.

Store the probability of the parent sample action in the skb's cb area
and use it in emit_sample to pass it down to psample.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/uapi/linux/openvswitch.h |  3 ++-
 net/openvswitch/actions.c        | 20 +++++++++++++++++---
 net/openvswitch/datapath.h       |  3 +++
 net/openvswitch/vport.c          |  1 +
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index 8cfa1b3f6b06..823f22be1fcc 100644
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
index 1f555cbba312..85a2ff91379b 100644
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
@@ -1062,9 +1065,16 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
 		return 0;
 	}
 
+	OVS_CB(skb)->probability = arg->probability;
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
@@ -1312,6 +1322,7 @@ static void execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
 	struct psample_group psample_group = {};
 	struct psample_metadata md = {};
 	const struct nlattr *a;
+	u32 rate;
 	int rem;
 
 	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
@@ -1330,8 +1341,11 @@ static void execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
 	psample_group.net = ovs_dp_get_net(dp);
 	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
 	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
+	md.rate_as_probability = 1;
+
+	rate = OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_MAX;
 
-	psample_sample_packet(&psample_group, skb, 0, &md);
+	psample_sample_packet(&psample_group, skb, rate, &md);
 #endif
 }
 
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


