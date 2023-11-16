Return-Path: <netdev+bounces-48442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EDA7EE57A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE512811EA
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332B3C495;
	Thu, 16 Nov 2023 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nEE1qQo+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED4D5B
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso154339866b.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700153313; x=1700758113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fO2p3N0D6c7mNPVkQ4sVymyjHDlPNhgPBa9Y4HpAGrs=;
        b=nEE1qQo+4ySuxXjy5AoQMZoeVU8MmhXhv5u4OxHmYQXRK7KrbXjS/xNhQgx8s9ZIyu
         Ic+qKK6DPb8ex5G0WJr6sbSuZCo/oHzdmxp4pMpoubDC2WNir3eD2vWy0CEXo1D77YKP
         g5CaUyuKFCxdO73BrsYTeReRQ7KNSAPq1BMTTiommfEKiy0Zbha7N0yfdepgG9YH93Fv
         zQ27x5TtbpKAHWzyc9o+a0cP2uedwPPBu85K9EhioIfWamWtU+FBwh47YHJCsw9/JNcM
         J3aYyqDqqfzqoUt/x+ZcjbLlOd258EUZu/R6GfdYn6KTDQLWUBWM5lyCtVqgfUOaiiV0
         uhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153313; x=1700758113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fO2p3N0D6c7mNPVkQ4sVymyjHDlPNhgPBa9Y4HpAGrs=;
        b=EdF4JzYT34PAs13XsbBXk2lvAd7fGHq17c1+sMYCVuiJ+r6V7mSCBNqqdHkhTIJEDP
         LZgvqSLfdKiKwlafdso5OJL9wzVlre61QC8u29mqyDydnM9ZQ/blEF+4mRQnQmmVg6mb
         XDVpG7cxf68Or+m3uDmbqDK0Rdv4sLDmR/z4S5BrF+S3XJfQh6Z6z4mseKODVZHMMgls
         0lW2Jq/JW8Pj0CHzCAffEuH/ikDwr4iMUSdo9HxSEyW+IaggH/694HRz4e2MN6Qp0AqK
         HqdX0yqGDe3bvt0VgoADGhmMQS97m64wet0R3YOdNlL1MSY7AofTA9Q3XANGhkOBJ/Gn
         ztqQ==
X-Gm-Message-State: AOJu0YyhCywFTYsJQ0HY8hhTBU2xDpklg6tVE9FKGxesHPCkSB7qxLCL
	DwXvcx9GcFT9OjLtoPtnxOauLDJxNNn1zNyjdbc=
X-Google-Smtp-Source: AGHT+IHg2+e+ldeSsQ2tl6/aKkIRBuUJ1STj87nBwuNeAoQaOiPay6ZSk5jJM9CD9QlCrizZ7f4K2g==
X-Received: by 2002:a17:906:270e:b0:9f2:74bc:1f52 with SMTP id z14-20020a170906270e00b009f274bc1f52mr4616156ejc.63.1700153313082;
        Thu, 16 Nov 2023 08:48:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id pj17-20020a170906d79100b009cc1227f443sm8591510ejb.104.2023.11.16.08.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:48:32 -0800 (PST)
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
	sdf@google.com
Subject: [patch net-next v2 6/9] netlink: introduce typedef for filter function
Date: Thu, 16 Nov 2023 17:48:18 +0100
Message-ID: <20231116164822.427485-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116164822.427485-1-jiri@resnulli.us>
References: <20231116164822.427485-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Make the code using filter function a bit nicer by consolidating the
filter function arguments using typedef.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 drivers/connector/connector.c | 5 ++---
 include/linux/connector.h     | 6 ++----
 include/linux/netlink.h       | 6 ++++--
 net/netlink/af_netlink.c      | 6 ++----
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 7f7b94f616a6..4028e8eeba82 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -59,9 +59,8 @@ static int cn_already_initialized;
  * both, or if both are zero then the group is looked up and sent there.
  */
 int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
-	gfp_t gfp_mask,
-	int (*filter)(struct sock *dsk, struct sk_buff *skb, void *data),
-	void *filter_data)
+			 gfp_t gfp_mask, netlink_filter_fn filter,
+			 void *filter_data)
 {
 	struct cn_callback_entry *__cbq;
 	unsigned int size;
diff --git a/include/linux/connector.h b/include/linux/connector.h
index cec2d99ae902..cb18d70d623f 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -98,10 +98,8 @@ void cn_del_callback(const struct cb_id *id);
  *
  * If there are no listeners for given group %-ESRCH can be returned.
  */
-int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
-			 u32 group, gfp_t gfp_mask,
-			 int (*filter)(struct sock *dsk, struct sk_buff *skb,
-				       void *data),
+int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
+			 gfp_t gfp_mask, netlink_filter_fn filter,
 			 void *filter_data);
 
 /**
diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 75d7de34c908..d30f599a4c6b 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -228,10 +228,12 @@ bool netlink_strict_get_check(struct sk_buff *skb);
 int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
 int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
 		      __u32 group, gfp_t allocation);
+
+typedef int (*netlink_filter_fn)(struct sock *dsk, struct sk_buff *skb, void *data);
+
 int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
 			       __u32 portid, __u32 group, gfp_t allocation,
-			       int (*filter)(struct sock *dsk,
-					     struct sk_buff *skb, void *data),
+			       netlink_filter_fn filter,
 			       void *filter_data);
 int netlink_set_err(struct sock *ssk, __u32 portid, __u32 group, int code);
 int netlink_register_notifier(struct notifier_block *nb);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index eb086b06d60d..6bad718c2966 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1518,10 +1518,8 @@ static void do_one_broadcast(struct sock *sk,
 }
 
 int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
-			       u32 portid,
-			       u32 group, gfp_t allocation,
-			       int (*filter)(struct sock *dsk,
-					     struct sk_buff *skb, void *data),
+			       __u32 portid, __u32 group, gfp_t allocation,
+			       netlink_filter_fn filter,
 			       void *filter_data)
 {
 	struct net *net = sock_net(ssk);
-- 
2.41.0


