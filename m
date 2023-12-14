Return-Path: <netdev+bounces-57611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD72C8139BA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750CE282F7F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186968B66;
	Thu, 14 Dec 2023 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ai3PUq9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDEDCF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:16:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so10668939a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702577765; x=1703182565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbTUWeD75Qq/q03fxzPY6vzlSe3qJgsO2ERBgJjGn4U=;
        b=Ai3PUq9wZQG5Dq7PD6oJ5VoY9QMDb0fDkM0hjSuoJ0Kbx/WwREVoIIEYfKe7I4/fxa
         fppgcH4vQYTLAARdr1SzQc1ay/zOo28yTvhYDEL5pdeR7CEONXgNuUnBsp6gnwOYmaNh
         CJotFhc8Km9a9GwgarUAPKRgXH/UPXmNxe5ylqS1uPPNzBpW96xMF1OBgNN1gpsLfvpa
         4+PQVNR93+rivqwAaXFJj1X2NPFFX0ih+in02EtpRHxQIm6bB4FrOWb4v/s2dCPyDQPF
         33NTGHYJdzx5GRytfzTOSAv6yE/dDi/Ii0K8G80lU/UI9+QGwfkGo8rEVEOGrjL7jukN
         jf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577765; x=1703182565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbTUWeD75Qq/q03fxzPY6vzlSe3qJgsO2ERBgJjGn4U=;
        b=jzEpy4QHwSNUMevA7QxO/yS+4aPJHwK5HDyT3MkWj6KI0rL69JqDzo9/C9SAyLZaz2
         c/w1e3KdhxZklPlaJX9WEpNiRnZVOkXrGwLSQHqqG6CNzufCc8lWMkwD7Fwy65xG8nW+
         Ai2eHeiQBKU3ZISkIFF8ZySHD57LXdoD3TSwN2du1SlkehN+/2bsV2hA+s5FL08QbU2W
         JnE+fMcvHso00ovoVZwUoVieioDDEU0nVbPAf8iGHWVQImHVtwhS/UuEQO9ewuC4K48l
         fHzYMFQvJLjMhRx1Vyed/6NH6NYMD7RXSmXVTnEDfo00aYgGZT+VPdtsR01Lpfi1ZsOB
         k3Jg==
X-Gm-Message-State: AOJu0Ywdg1CvCBf7EpK1sdiisch1lcnylHkSwsvpD2kPeTKYYLAnOLNq
	KHyXm3G+4/ncmq8XuvqUBmVgOtFOiBv2exA2rO4=
X-Google-Smtp-Source: AGHT+IH8GJyuIZnV61TOXT1XQVJyS5Uw16ir617JHe1TnltKPo9b0ED7Y7THYabn8rdQxsIQI+y/2w==
X-Received: by 2002:a50:cd1d:0:b0:552:6257:584 with SMTP id z29-20020a50cd1d000000b0055262570584mr944222edi.44.1702577765117;
        Thu, 14 Dec 2023 10:16:05 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p6-20020a05640243c600b0054c9b0bd576sm6946213edc.26.2023.12.14.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:16:04 -0800 (PST)
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
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v7 7/9] genetlink: introduce helpers to do filtered multicast
Date: Thu, 14 Dec 2023 19:15:47 +0100
Message-ID: <20231214181549.1270696-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214181549.1270696-1-jiri@resnulli.us>
References: <20231214181549.1270696-1-jiri@resnulli.us>
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
index 6bc37f392a9a..85c63d4f16dd 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -448,6 +448,35 @@ static inline void genlmsg_cancel(struct sk_buff *skb, void *hdr)
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
@@ -461,10 +490,8 @@ static inline int genlmsg_multicast_netns(const struct genl_family *family,
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
index 28039e57070a..c19ff921b661 100644
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
2.43.0


