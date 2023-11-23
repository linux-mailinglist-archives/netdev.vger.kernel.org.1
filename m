Return-Path: <netdev+bounces-50636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A237F6611
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD1D281DB1
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021324C638;
	Thu, 23 Nov 2023 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NDwvz2X/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD01B3
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:16:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a002562bd8bso224929766b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763359; x=1701368159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peEH7/aKHtykJGwoCx00LRwUqswO9g4wbyqhvIC9pTM=;
        b=NDwvz2X//8EWJmLBiDyqtT8eFzSNGqdMkStCUeWFAoIXsJkM2uXxJkAIObBb2S9ChE
         lkgwLMnoyItmIML8cqGLE3ACvdvND3juzNnFM69CigBmy/O191X4bhERUCJag8mVrkCx
         n+a/b2GYS+h+0Tv4ZDx8u9XhY3RWUnszAMaolaaeZd22ZN/pnTqnzrYC9/aMB/jirSU7
         HB3VhGOWvi4CX2ow/vmHmbVPW50Hm8on6UL1IejL4b0iZgJkEPC/hGfaksnR+SfkA8YY
         88MTg2/U5HeIcDngh3ey3dUXwCyIVh7dpmQFx+UJB2yu4utx+mwY2v+MnM/T6bCknORk
         s4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763359; x=1701368159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peEH7/aKHtykJGwoCx00LRwUqswO9g4wbyqhvIC9pTM=;
        b=uFX4dUWcyRpj2699PGs/SaONVsdVpzrRPB0S/gJxIHko1WYs2W2cbWg8WCIbZwzym0
         x46DGW4ZfpFdaNaQ6PXpFfnOK5BRMozXX+bT5cqJKEhq3AdI86zUa3nO7NRzU1a1h9M2
         QQF2qaAy8FYQ2hR4rT3w1Q/DdhA6s81WshK271+1yOjYPv9EzQo0Yj+F8GfyFnSddBud
         fWxdKpE1dSX7p2x6E73IfKH+Gs2EF/YzQVRkv4aRL/fw+6Kk4B98DfbGVP2gDwNuqK47
         BNh5MW2wplIPLprT36KlqnASN0CRtcjZ+s/70IZTQu3iUNI3uSSdqE/jBZ4HXGftnuq5
         7Ynw==
X-Gm-Message-State: AOJu0YwmQTeQ0Wzdfe+B6eStnEKuAVptILM9OUjVAYpt0afQ0HfLEbay
	dtWK5kayZLnqeK6n0SVwrGVmz3+kf0ByrzMiZmI=
X-Google-Smtp-Source: AGHT+IHMVEgeV34xuxw7T4e/Bq3Tpvdu2TKeSex15aKE/PhzOFR6hHMPB6T2wMuDbtpjW+mFnUgOEQ==
X-Received: by 2002:a17:906:ca49:b0:9b2:b37d:17ff with SMTP id jx9-20020a170906ca4900b009b2b37d17ffmr2737907ejb.19.1700763359161;
        Thu, 23 Nov 2023 10:15:59 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id mf12-20020a170906cb8c00b009a13fdc139fsm1064534ejb.183.2023.11.23.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:15:58 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org
Subject: [patch net-next v4 7/9] genetlink: introduce helpers to do filtered multicast
Date: Thu, 23 Nov 2023 19:15:44 +0100
Message-ID: <20231123181546.521488-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123181546.521488-1-jiri@resnulli.us>
References: <20231123181546.521488-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently it is possible for netlink kernel user to pass custom
filter function to broadcast send function netlink_broadcast_filtered().
However, this is not exposed to multicast send and to generic
netlink users.

Extend the api and introduce a netlink helper nlmsg_multicast_filtered()
and a generic netlink helper genlmsg_multicast_netns_filtered()
to allow generic netlink families to specify filter function
while sending multicast messages.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- used netlink_filter_fn introduce by the previous patch
- added return comments to silence scripts/kernel-doc warnings
---
 include/net/genetlink.h | 35 +++++++++++++++++++++++++++++++----
 include/net/netlink.h   | 31 +++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 66c1e50415e0..f1173e9ea50b 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -438,6 +438,35 @@ static inline void genlmsg_cancel(struct sk_buff *skb, void *hdr)
 		nlmsg_cancel(skb, hdr - GENL_HDRLEN - NLMSG_HDRLEN);
 }
 
+/**
+ * genlmsg_multicast_netns_filtered - multicast a netlink message
+ *				      to a specific netns with filter
+ *				      function
+ * @family: the generic netlink family
+ * @net: the net namespace
+ * @skb: netlink message as socket buffer
+ * @portid: own netlink portid to avoid sending to yourself
+ * @group: offset of multicast group in groups array
+ * @flags: allocation flags
+ * @filter: filter function
+ * @filter_data: filter function private data
+ *
+ * Return: 0 on success, negative error code for failure.
+ */
+static inline int
+genlmsg_multicast_netns_filtered(const struct genl_family *family,
+				 struct net *net, struct sk_buff *skb,
+				 u32 portid, unsigned int group, gfp_t flags,
+				 netlink_filter_fn filter,
+				 void *filter_data)
+{
+	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+		return -EINVAL;
+	group = family->mcgrp_offset + group;
+	return nlmsg_multicast_filtered(net->genl_sock, skb, portid, group,
+					flags, filter, filter_data);
+}
+
 /**
  * genlmsg_multicast_netns - multicast a netlink message to a specific netns
  * @family: the generic netlink family
@@ -451,10 +480,8 @@ static inline int genlmsg_multicast_netns(const struct genl_family *family,
 					  struct net *net, struct sk_buff *skb,
 					  u32 portid, unsigned int group, gfp_t flags)
 {
-	if (WARN_ON_ONCE(group >= family->n_mcgrps))
-		return -EINVAL;
-	group = family->mcgrp_offset + group;
-	return nlmsg_multicast(net->genl_sock, skb, portid, group, flags);
+	return genlmsg_multicast_netns_filtered(family, net, skb, portid,
+						group, flags, NULL, NULL);
 }
 
 /**
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 167b91348e57..2ba1438b7066 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1087,27 +1087,50 @@ static inline void nlmsg_free(struct sk_buff *skb)
 }
 
 /**
- * nlmsg_multicast - multicast a netlink message
+ * nlmsg_multicast_filtered - multicast a netlink message with filter function
  * @sk: netlink socket to spread messages to
  * @skb: netlink message as socket buffer
  * @portid: own netlink portid to avoid sending to yourself
  * @group: multicast group id
  * @flags: allocation flags
+ * @filter: filter function
+ * @filter_data: filter function private data
+ *
+ * Return: 0 on success, negative error code for failure.
  */
-static inline int nlmsg_multicast(struct sock *sk, struct sk_buff *skb,
-				  u32 portid, unsigned int group, gfp_t flags)
+static inline int nlmsg_multicast_filtered(struct sock *sk, struct sk_buff *skb,
+					   u32 portid, unsigned int group,
+					   gfp_t flags,
+					   netlink_filter_fn filter,
+					   void *filter_data)
 {
 	int err;
 
 	NETLINK_CB(skb).dst_group = group;
 
-	err = netlink_broadcast(sk, skb, portid, group, flags);
+	err = netlink_broadcast_filtered(sk, skb, portid, group, flags,
+					 filter, filter_data);
 	if (err > 0)
 		err = 0;
 
 	return err;
 }
 
+/**
+ * nlmsg_multicast - multicast a netlink message
+ * @sk: netlink socket to spread messages to
+ * @skb: netlink message as socket buffer
+ * @portid: own netlink portid to avoid sending to yourself
+ * @group: multicast group id
+ * @flags: allocation flags
+ */
+static inline int nlmsg_multicast(struct sock *sk, struct sk_buff *skb,
+				  u32 portid, unsigned int group, gfp_t flags)
+{
+	return nlmsg_multicast_filtered(sk, skb, portid, group, flags,
+					NULL, NULL);
+}
+
 /**
  * nlmsg_unicast - unicast a netlink message
  * @sk: netlink socket to spread message to
-- 
2.41.0


