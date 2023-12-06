Return-Path: <netdev+bounces-54571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68F80777D
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878E1B20FA9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53941854;
	Wed,  6 Dec 2023 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1PY/b8AV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251A818D
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 10:21:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1e116f2072so25907466b.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701886896; x=1702491696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlRSrg5smOW6dTCpma/Dwa5aq4EiIbE5VTt52Y7H/Ao=;
        b=1PY/b8AVJB2my4Jcl5EgB8e8Rzdb46E9sX6+EpUM+JZ/PWOTOX+R4XxhhOV6JS94TD
         Nu22/axunNxV+FncAk18BtDqOSi2exzzbY2LbqMvVyqrd05DGyXB0mpdZLL9XGfJddcL
         oiMygTXCVcu9yIMEkd3ks5Krmj+aUNUoY7j56pJw/eTLpkFdvuoPbsZJLn93NsrNWucd
         Lqfx9SEX22i1bgqIqpYe8L3HDO5sDrs/XAhsgw+m9Lt+jiM23RhtCgABwO0NyM8/diCo
         GPK23dEdn8geB5QhRIn6unWISUYCUM2TnmIsPAzVWhIvjM19hF+c3fAXOyMsNyXy7plR
         8cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886896; x=1702491696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlRSrg5smOW6dTCpma/Dwa5aq4EiIbE5VTt52Y7H/Ao=;
        b=WVBWQfJgcy7bD8+tG+4hUYaRtxRrFkEzClW7qpzyg4AJs2szg21MDc4rIaSmvaebQq
         /36pxIWi18RKr3FGzGubIFgy/jMuyvmthGuoG77Xrn/IMfhF4mLzaF9VtL4c9XD8G8jG
         KMftvkp4LHM8U8hzLP0EkQcmWnLnbhW+a5qyst8yQWravB4SDon61V+Fu9BQ4jNJBnPE
         nIMh9kVFqC7dH0w2KplEyWFSTxDIHWXNelgflR0RVAZpd4vpTBuRLEoeqEo8DjhOE6Wa
         vCmlYOXL00HPDNvbUJd9G/MTj3Np/4Uu56s0YJvLxLoPWpxiE5X9mxOM43i254XkP33u
         VGtw==
X-Gm-Message-State: AOJu0YybywmVKYTYOX/BoGQwwOg9Lp0BGsbDG0xdp2RosJC94zEDlfB5
	TpcLe65+Aqo6Lb03aeFvyteDNhrDs5rwWAOwiIU=
X-Google-Smtp-Source: AGHT+IG2gwJ+rzWbYer/yZeheUCQrHmE8qaL0m+Gge6ZphRCG466jJXWqRj2obRt0R3AYGPJKPf2Aw==
X-Received: by 2002:a17:907:97c3:b0:a1b:760c:e4de with SMTP id js3-20020a17090797c300b00a1b760ce4demr4820749ejc.15.1701886895342;
        Wed, 06 Dec 2023 10:21:35 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ss26-20020a170907039a00b00a14311b5c5dsm252852ejb.185.2023.12.06.10.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:21:34 -0800 (PST)
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
Subject: [patch net-next v5 7/9] genetlink: introduce helpers to do filtered multicast
Date: Wed,  6 Dec 2023 19:21:18 +0100
Message-ID: <20231206182120.957225-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206182120.957225-1-jiri@resnulli.us>
References: <20231206182120.957225-1-jiri@resnulli.us>
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
index dbf11464e96a..c3fe1d5b4254 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -441,6 +441,35 @@ static inline void genlmsg_cancel(struct sk_buff *skb, void *hdr)
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
@@ -454,10 +483,8 @@ static inline int genlmsg_multicast_netns(const struct genl_family *family,
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


