Return-Path: <netdev+bounces-107653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4291BD15
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075CB1F23032
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1C157E91;
	Fri, 28 Jun 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZKuoOqx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C7157E6C
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719572807; cv=none; b=eyHqZfOm6GCUc7Wy4yzVeFWYrRBJ/5rwg85q4OW60RrZ140oyLYCMdWM8PH1tRkV3tVuYkvYc+OSHiDjuCZtXR3Qfr1Uat4Z5VpvOBxdJIdLeuC0WMuVxhHyiPxIPrO+lcpPDP0o3TXOp01e2nB27RE+LQH0etGLHogamnPQUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719572807; c=relaxed/simple;
	bh=TABk/sPwPsO49HzErTC442bpk9kaDGICGo2AxbE4Wng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUqjyaeBvhoiDv+6KXuLiXkMlTn0J3gUS9HVOepC3wC4gOnxZCdCuBsLJgRzT0IiVl7ybTyMSWK4XFoNnOQAp0kkbJ93rIOqqWG/+58csraZfcH3NW9XuoB8/mwfJhLiYjRSLjRlvmqafuhx6X2HxOgKE5eedTy+jsJHmiIvJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZKuoOqx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719572804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o48aZPj5afh6j2WWxAQ/iIn+F6mQG7B00MuxSjSerCs=;
	b=iZKuoOqxi6BvAK0CcbwCVprnWR6ZzkQnuiRbgtSxNR8eIqTAHYRKEWsYy+8UZCbDEvjlfq
	C5x+YiDkxbvWsvt3PWKetlkxZLCInJrcb0fk8plhhtvhjIJEy8Ud/6OSMNkqFLi4IuIGbE
	wWDXtDtMgnbdgfUEEVFLFzwnarbXHC8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-ze3Pv0flMqudEqM5Ujw1JQ-1; Fri,
 28 Jun 2024 07:06:40 -0400
X-MC-Unique: ze3Pv0flMqudEqM5Ujw1JQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 363CD1955DCE;
	Fri, 28 Jun 2024 11:06:39 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA61D19560B2;
	Fri, 28 Jun 2024 11:06:34 +0000 (UTC)
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
Subject: [PATCH net-next v6 06/10] net: openvswitch: store sampling probability in cb.
Date: Fri, 28 Jun 2024 13:05:42 +0200
Message-ID: <20240628110559.3893562-7-amorenoz@redhat.com>
In-Reply-To: <20240628110559.3893562-1-amorenoz@redhat.com>
References: <20240628110559.3893562-1-amorenoz@redhat.com>
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
and use it in psample action to pass it down to psample module.

Acked-by: Eelco Chaudron <echaudro@redhat.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/uapi/linux/openvswitch.h |  3 ++-
 net/openvswitch/actions.c        | 20 +++++++++++++++++---
 net/openvswitch/datapath.h       |  3 +++
 net/openvswitch/vport.c          |  1 +
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index 07086759556b..8a0cf8060c37 100644
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
index a035b7e677dd..34af6bce4085 100644
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
@@ -1311,6 +1321,7 @@ static void execute_psample(struct datapath *dp, struct sk_buff *skb,
 	struct psample_group psample_group = {};
 	struct psample_metadata md = {};
 	const struct nlattr *a;
+	u32 rate;
 	int rem;
 
 	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
@@ -1329,8 +1340,11 @@ static void execute_psample(struct datapath *dp, struct sk_buff *skb,
 	psample_group.net = ovs_dp_get_net(dp);
 	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
 	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
+	md.rate_as_probability = 1;
+
+	rate = OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_MAX;
 
-	psample_sample_packet(&psample_group, skb, 0, &md);
+	psample_sample_packet(&psample_group, skb, rate, &md);
 }
 #else
 static inline void execute_psample(struct datapath *dp, struct sk_buff *skb,
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
2.45.2


