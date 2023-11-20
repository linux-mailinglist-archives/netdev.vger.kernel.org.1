Return-Path: <netdev+bounces-49131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19A7F0E13
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0451F22C23
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15286F9CA;
	Mon, 20 Nov 2023 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2rbiVbY1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6C1BEA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9de7a43bd1aso544940966b.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470033; x=1701074833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZINPLM47jewxX8k6AZrQ3FkxNVby2E3liigCGzybfzQ=;
        b=2rbiVbY1anDWxRN7LgqqL76xOtSucyHpQjJuia+MMAurObLn1+G3pwRIqUOArmQH9i
         3NTLtTncA/c0DzCTDuTX1wGMsL3iq8At1CcSlh8XdUqIclpl3A+UNlnL9rxtvTyqOPQO
         dHbJQbOKmUI4uabOnmS1dvao9Hq1kN8Fz/zIT2ajZER4rIW1kI+rbXGHBlS8fVVFZ5yR
         UQs6ktCvTNwmja2f0Q5J0SPXIRIsLmN36u99zO5SZVKO0Dxbu1cp/pA3SadcJ9il4FM/
         87CBFPbgODQ+IqDpsQ+0bcrXnE/7KdCtnBfMx0w43lmnooAoLlOt4cGJVm06KXkG2mT9
         sEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470033; x=1701074833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZINPLM47jewxX8k6AZrQ3FkxNVby2E3liigCGzybfzQ=;
        b=aBD/4lAtyFvXTUwhVUVS7iIteKuvGa1I+vv2vFZZ2oOWtB6LzCMhZVdo6pdjeptFxq
         nSEmEXSyM3bm4o0NgT8iAfXSVDw2MaBKjILPBE6J3R+Y7NQnCn4YH53eolZtId1syf5l
         7eKfziOxHhOD5jBMEHWFb9608dKQVU8aITcRNU4uLmh+qk3/Xzkwm7tmfhcFmjO3AM/P
         3CN3jZWUn12Y/RWsL5ZKGTO22pdLHxgBSOMxj/HXSIsvalVp6aU8l7Thl6RdmQwjXroT
         cU7mdqgv06QyqIaqCvopcFESQyMmRQgqX7E9J/uDVSb8V3RJUDScje0TcRYhYqOPB9a0
         yo/w==
X-Gm-Message-State: AOJu0Yx+mNq2ZCmRkCvIuDPJCZ70evCy8/efpjxvBVQ+P9Kd8btDil5I
	Y2O1S2yULyT76UhqPYpsqgdC9kj4YR7zcKUECF86Sw==
X-Google-Smtp-Source: AGHT+IFHZRAh7Lrxc5aHGdG7I6ckxLSoJSRMBR1HOpZuc0/QLmocCYqiYW/gt2EskABy4hoiD/A5Pg==
X-Received: by 2002:a17:906:51cf:b0:9e4:7d6:3730 with SMTP id v15-20020a17090651cf00b009e407d63730mr4168050ejk.11.1700470033222;
        Mon, 20 Nov 2023 00:47:13 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906490b00b009fcf9f8e526sm1405648ejq.25.2023.11.20.00.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:47:12 -0800 (PST)
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
Subject: [patch net-next v3 7/9] genetlink: introduce helpers to do filtered multicast
Date: Mon, 20 Nov 2023 09:46:55 +0100
Message-ID: <20231120084657.458076-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120084657.458076-1-jiri@resnulli.us>
References: <20231120084657.458076-1-jiri@resnulli.us>
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
index e18a4c0d69ee..246912033e77 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -435,6 +435,35 @@ static inline void genlmsg_cancel(struct sk_buff *skb, void *hdr)
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
@@ -448,10 +477,8 @@ static inline int genlmsg_multicast_netns(const struct genl_family *family,
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
index 83bdf787aeee..f5423de36c21 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1073,27 +1073,50 @@ static inline void nlmsg_free(struct sk_buff *skb)
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


