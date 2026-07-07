Return-Path: <netdev+bounces-305602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JZCiLc16TWp10wEAu9opvQ
	(envelope-from <netdev+bounces-305602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:16:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D85720009
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:16:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openai.com header.s=google header.b=JvRA+p++;
	dmarc=pass (policy=reject) header.from=openai.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305602-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305602-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C4A4301093D
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 22:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CAC2C15A0;
	Tue,  7 Jul 2026 22:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD93D45DF
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 22:16:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462603; cv=none; b=OcK7MN/0PEP4XW1D/kZoonwEHfUK4pua3Y1AI2OYkjkcEaX6oCDBukQroskEopPhy7LedOZmo8KqgBPy29SMcsPIFI9xt3KFWi9M3446ErYtzXpGvUez7ZyZdrSG/RiR9MpL67TZ/KjGLapm35L1k5MvCxjuq+Ot3iBxEZCqFP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462603; c=relaxed/simple;
	bh=fa7ot51AK4GvjXzjN2xatzNnAuOJJlWeGalMMZcyHX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O61r6JP6u/ZqVVwp41iwnIBVkH3/cV5AwtPlZEGq2nB9hsiYNLirry4wMTTUYUnIIRH/959PuFk7tgGlbI6P9N5TTCNLU9l39Bl3B7ogxAWuPAeptiF4CWTxeqPD7FLnsN6DAVyHOZCVCkPzu+j80ySPfRKlNiN4mWx/qzfrFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=JvRA+p++; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9c80265bd7so2671035a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 15:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783462600; x=1784067400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IdJZd9tQ2oh7Af4gmwWaKxs5ZeO+JiGwmEDefw5S65c=;
        b=JvRA+p++8A69xx9Wd9u1dxTBDJ7ctqpE1queD9KcDmGF5W2nkWw671P3lafa2iIQ+a
         /HPPfxSKxPPNQEP0tsXilyg6P+vDR/yWnsFyPwZCgsPEhFHgmW/7y6WEwws5bdeSnDfY
         WZTGFdI/OyRfCwI472I2cv52MpuYWj81gAoM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462600; x=1784067400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdJZd9tQ2oh7Af4gmwWaKxs5ZeO+JiGwmEDefw5S65c=;
        b=M+S3ILpT+WjtxAVXgfYgJgjKiShVIyU1WeHFKhdGlFuXmGdpLNJ3JmzqlQ+ICSuMeM
         1bZc5kQ4TacYPsCWDthFG+Yt1xcj03HW0UopXjq3BOo1gEkEpPZhnxunRRSGGJ12MLam
         wAyOlPGQgzx27sTmV1rfI0ZWqx3DLHaz0VdyoKg6A5lVnCcqHrY4cGNAVAWdjvHb0mkt
         6ukNE8NIR6XSKaqqWpYZs31DV3T5iCPKzn+wCXCOw2VuS+QoSdflnmg3hFbETmxoCCUK
         m4QTRDGdlt4tZE0n6CqkyluOfMJJjUEpqN5es21AB4o2XrZhr48O8ktwVtisF2hdEG/H
         xHeg==
X-Gm-Message-State: AOJu0YzlROZ5wdG6C90lY5UI/mR/bzUAGFhqcF8twouluh3oa7ZF+8AH
	XHLnZ4ORyo2/a8S3mUEqiisPkKdSTlrGBB0hi6vshTt2+LsTWNHNoU9A108+2K+54zfkXPqLt6w
	4lPgfCEI=
X-Gm-Gg: AfdE7ckP7hAh5F0+dBwtkb4UQ4ZYEa2VAJVfHyvxBb6u/DaVKJEYcehrqAHrldcd3KC
	EbZF2K1+u17W9AXJUtc0zeiCLaYd9M3jzsidHBEGmvNTjM/wK5rsQI3WquvBtVXAhEwsNQCZQ6Y
	4qKdH/GnzcRX3UJj752e97oYqEguOw2BTx26e5bASdqyTMUGefBxo1F/vOt4lW9bMVtMUe040Qh
	fQN0M8bI0ycIw7+H6K3NBc99HkckHEd0nHDWVbaSAj/1e2+grmtA3mvNv3QaMARluWLg8GewU/a
	dfdGhM5JeHt7NnjyOGwCYuXpmQcWKdnIn7nASCrhwkhfJ4/Da4ErF8anfu2p/72VXGyDqxszhB2
	el/eZGpmSSd68OtfUbWIY+sSvH3E6rbyq379NvUgpSNMzRIqg6+DhkVGU4j/F+24cgpIdRRW7ht
	wRAJa6bz95aSDgTw371/mpYEf57XbpsGlcu9krA4Hj6+YJJEiWlh9SYnRsfOy9xLHqE8Szla1So
	G1buXYctBaN21TB4W4=
X-Received: by 2002:a05:6a21:b85:b0:3b4:7b2a:6a0a with SMTP id adf61e73a8af0-3c08ee94f8dmr9535215637.35.1783462600467;
        Tue, 07 Jul 2026 15:16:40 -0700 (PDT)
Received: from com-75606.corp.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm19103665c88.14.2026.07.07.15.16.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 15:16:40 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net] openvswitch: fix GSO userspace truncation underflow
Date: Tue,  7 Jul 2026 15:16:35 -0700
Message-ID: <20260707221635.27489-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[openai.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:kylebot@openai.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[openai.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openai.com:from_mime,openai.com:email,openai.com:mid,openai.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48D85720009

OVS_ACTION_ATTR_TRUNC currently stores a delta from the original skb
length in OVS_CB(skb)->cutlen. When a later userspace action segments a
GSO skb, queue_gso_packets() reuses that delta for each smaller segment.
A segment can then reach queue_userspace_packet() with cutlen greater
than skb->len, underflowing the length passed to skb_zerocopy().

Store the maximum preserved length instead and bound each consumer
against the current skb length. Use U32_MAX as the no-truncation
sentinel so the value remains valid if skb geometry changes before a
consumer handles it.

Fixes: f2a4d086ed4c ("openvswitch: Add packet truncation support.")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/openvswitch/actions.c  | 19 +++++++------------
 net/openvswitch/datapath.c | 25 ++++++++++++++-----------
 net/openvswitch/datapath.h |  2 +-
 net/openvswitch/vport.c    |  2 +-
 4 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 140388a18ae0..513fca6a8e8a 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -837,12 +837,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
-		if (unlikely(cutlen > 0)) {
-			if (skb->len - cutlen > ovs_mac_header_len(key))
-				pskb_trim(skb, skb->len - cutlen);
-			else
-				pskb_trim(skb, ovs_mac_header_len(key));
-		}
+		if (unlikely(cutlen < skb->len))
+			pskb_trim(skb, max(cutlen, ovs_mac_header_len(key)));
 
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
@@ -1234,7 +1230,7 @@ static void execute_psample(struct datapath *dp, struct sk_buff *skb,
 
 	psample_group.net = ovs_dp_get_net(dp);
 	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
-	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
+	md.trunc_size = min(skb->len, OVS_CB(skb)->cutlen);
 	md.rate_as_probability = 1;
 
 	rate = OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_MAX;
@@ -1284,22 +1280,21 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			clone = skb_clone(skb, GFP_ATOMIC);
 			if (clone)
 				do_output(dp, clone, port, key);
-			OVS_CB(skb)->cutlen = 0;
+			OVS_CB(skb)->cutlen = U32_MAX;
 			break;
 		}
 
 		case OVS_ACTION_ATTR_TRUNC: {
 			struct ovs_action_trunc *trunc = nla_data(a);
 
-			if (skb->len > trunc->max_len)
-				OVS_CB(skb)->cutlen = skb->len - trunc->max_len;
+			OVS_CB(skb)->cutlen = trunc->max_len;
 			break;
 		}
 
 		case OVS_ACTION_ATTR_USERSPACE:
 			output_userspace(dp, skb, key, a, attr,
 						     len, OVS_CB(skb)->cutlen);
-			OVS_CB(skb)->cutlen = 0;
+			OVS_CB(skb)->cutlen = U32_MAX;
 			if (nla_is_last(a, rem)) {
 				consume_skb(skb);
 				return 0;
@@ -1453,7 +1448,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 
 		case OVS_ACTION_ATTR_PSAMPLE:
 			execute_psample(dp, skb, a);
-			OVS_CB(skb)->cutlen = 0;
+			OVS_CB(skb)->cutlen = U32_MAX;
 			if (nla_is_last(a, rem)) {
 				consume_skb(skb);
 				return 0;
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index f0164817d9b7..eaf332b156d7 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -276,7 +276,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 			upcall.portid = ovs_vport_find_upcall_portid(p, skb);
 
 		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+		error = ovs_dp_upcall(dp, skb, key, &upcall, U32_MAX);
 		switch (error) {
 		case 0:
 		case -EAGAIN:
@@ -457,7 +457,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	struct sk_buff *nskb = NULL;
 	struct sk_buff *user_skb = NULL; /* to be queued to userspace */
 	struct nlattr *nla;
-	size_t len;
+	size_t msg_size;
+	size_t skb_len;
 	unsigned int hlen;
 	int err, dp_ifindex;
 	u64 hash;
@@ -478,7 +479,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		skb = nskb;
 	}
 
-	if (nla_attr_size(skb->len) > USHRT_MAX) {
+	skb_len = min(skb->len, cutlen);
+	if (nla_attr_size(skb_len) > USHRT_MAX) {
 		err = -EFBIG;
 		goto out;
 	}
@@ -493,13 +495,13 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	 * padding logic. Only perform zerocopy if padding is not required.
 	 */
 	if (dp->user_features & OVS_DP_F_UNALIGNED)
-		hlen = skb_zerocopy_headlen(skb);
+		hlen = min(skb_zerocopy_headlen(skb), cutlen);
 	else
-		hlen = skb->len;
+		hlen = skb_len;
 
-	len = upcall_msg_size(upcall_info, hlen - cutlen,
-			      OVS_CB(skb)->acts_origlen);
-	user_skb = genlmsg_new(len, GFP_ATOMIC);
+	msg_size = upcall_msg_size(upcall_info, hlen,
+				   OVS_CB(skb)->acts_origlen);
+	user_skb = genlmsg_new(msg_size, GFP_ATOMIC);
 	if (!user_skb) {
 		err = -ENOMEM;
 		goto out;
@@ -560,7 +562,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	}
 
 	/* Add OVS_PACKET_ATTR_LEN when packet is truncated */
-	if (cutlen > 0 &&
+	if (skb_len < skb->len &&
 	    nla_put_u32(user_skb, OVS_PACKET_ATTR_LEN, skb->len)) {
 		err = -ENOBUFS;
 		goto out;
@@ -585,9 +587,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		err = -ENOBUFS;
 		goto out;
 	}
-	nla->nla_len = nla_attr_size(skb->len - cutlen);
+	nla->nla_len = nla_attr_size(skb_len);
 
-	err = skb_zerocopy(user_skb, skb, skb->len - cutlen, hlen);
+	err = skb_zerocopy(user_skb, skb, skb_len, hlen);
 	if (err)
 		goto out;
 
@@ -644,6 +646,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 		packet->ignore_df = 1;
 	}
 	OVS_CB(packet)->mru = mru;
+	OVS_CB(packet)->cutlen = U32_MAX;
 
 	if (a[OVS_PACKET_ATTR_HASH]) {
 		hash = nla_get_u64(a[OVS_PACKET_ATTR_HASH]);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index db0c3e69d66c..696640e88fa7 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -118,7 +118,7 @@ struct datapath {
  * @mru: The maximum received fragement size; 0 if the packet is not
  * fragmented.
  * @acts_origlen: The netlink size of the flow actions applied to this skb.
- * @cutlen: The number of bytes from the packet end to be removed.
+ * @cutlen: The number of bytes in the packet to preserve on output.
  * @probability: The sampling probability that was applied to this skb; 0 means
  * no sampling has occurred; U32_MAX means 100% probability.
  * @upcall_pid: Netlink socket PID to use for sending this packet to userspace;
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 56b2e2d1a749..12741485c939 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -502,7 +502,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 
 	OVS_CB(skb)->input_vport = vport;
 	OVS_CB(skb)->mru = 0;
-	OVS_CB(skb)->cutlen = 0;
+	OVS_CB(skb)->cutlen = U32_MAX;
 	OVS_CB(skb)->probability = 0;
 	OVS_CB(skb)->upcall_pid = 0;
 	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
-- 
2.54.0


