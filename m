Return-Path: <netdev+bounces-56344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC1A80E8EA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010DC1F21976
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E7F5AB88;
	Tue, 12 Dec 2023 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rvE+nqWp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE9A9C
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so7757041a12.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702376268; x=1702981068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6p6PhL6pJJB1VojYjKvy33GJM9rz1keLAcljTX9SbA=;
        b=rvE+nqWpwqTckTStifewI9yqKvZrpelscKj/wOQ5tpmHJxUPrtLkqpo40OzJFoDFhQ
         KuWth9hh9lCXlWOTFZL80h/HLZLgHL+7XRDaI2gIQ+/iJCxug97hgTchfTo6puOqq9/J
         C/AVK6+4Eq2+kDp51eLHZESVgsjC/fhH+kn2addWzg972ZuWe13KbupmYd9TsuB/unJH
         XU/DAIUM4mr44o7b3YMeFi60eeLGQ8glwBr49+rEGvlwSl7uO32WCHUGlyTgTyvDfnRS
         j4lTjGLxibmUga0juumf98yFivrM/spRjUUM2fbVhNOSch3je1yDW5wMRecyxlUjnugK
         ZDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376268; x=1702981068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6p6PhL6pJJB1VojYjKvy33GJM9rz1keLAcljTX9SbA=;
        b=YZpPX5uI31f9GeL4BqUCt3Z94/08Agev8fUDa006+Fx7dBfO5YDxMEqKRx42aHAD/3
         QpEEG5YcoKYYGe7Yz6Q063qEIgZ/YyesZ+CsgTXt6FGqq6Mweqm5NMUqZL8U/6gJ530J
         AS9ElhDn223zJkRSN3mX1iOMSZX8nHFODyoz5amlxWKPh2ie/bmgpHQXzoRzwDkP2Caj
         YSpg/gcQUGgoEnJTkmrdUlFORkh2/16vx9oexzJwhWpUTpMcl2ULlng6rFPtrVsiEWIJ
         2cbp0SMU00bBqbMwaxdpwN3Uq6JYob/J6djzdJmw01ExIwifVad6ti0WuH0T7XlkZbvl
         dKag==
X-Gm-Message-State: AOJu0YzbBAfFQ9sLxa6hXeLwEO790gbpIE2eSFNslOvAT6YTH4G/VS7T
	z3boTHUdfmK2brYIsDhnhNAjVHKdeGHpsw05kv8=
X-Google-Smtp-Source: AGHT+IEccQ3er4ntByT3BHLOUspHUHzCL8OAfed6JY7w6x7ObvgEIl/Rs0ZgwaeAe829VF5rhS07yA==
X-Received: by 2002:a05:6402:2152:b0:54c:4837:7d0a with SMTP id bq18-20020a056402215200b0054c48377d0amr2083720edb.73.1702376267956;
        Tue, 12 Dec 2023 02:17:47 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s28-20020a50ab1c000000b0054c6b50df3asm4740868edc.92.2023.12.12.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:17:47 -0800 (PST)
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
Subject: [patch net-next v6 6/9] netlink: introduce typedef for filter function
Date: Tue, 12 Dec 2023 11:17:33 +0100
Message-ID: <20231212101736.1112671-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212101736.1112671-1-jiri@resnulli.us>
References: <20231212101736.1112671-1-jiri@resnulli.us>
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
v2->v3:
- left the original .c and .h arg names and types
  inconsistencies for cn_netlink_send_mult() and
  netlink_broadcast_filtered()
v1->v2:
- new patch
---
 drivers/connector/connector.c | 5 ++---
 include/linux/connector.h     | 3 +--
 include/linux/netlink.h       | 6 ++++--
 net/netlink/af_netlink.c      | 3 +--
 4 files changed, 8 insertions(+), 9 deletions(-)

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
index cec2d99ae902..70bc1160f3d8 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -100,8 +100,7 @@ void cn_del_callback(const struct cb_id *id);
  */
 int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
 			 u32 group, gfp_t gfp_mask,
-			 int (*filter)(struct sock *dsk, struct sk_buff *skb,
-				       void *data),
+			 netlink_filter_fn filter,
 			 void *filter_data);
 
 /**
diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index abe91ed6b9aa..1a4445bf2ab9 100644
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
index 5683b0ca23b1..0efc1bd451fc 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1519,8 +1519,7 @@ static void do_one_broadcast(struct sock *sk,
 int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
 			       u32 portid,
 			       u32 group, gfp_t allocation,
-			       int (*filter)(struct sock *dsk,
-					     struct sk_buff *skb, void *data),
+			       netlink_filter_fn filter,
 			       void *filter_data)
 {
 	struct net *net = sock_net(ssk);
-- 
2.43.0


