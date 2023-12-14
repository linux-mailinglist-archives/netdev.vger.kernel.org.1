Return-Path: <netdev+bounces-57610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19F8139B9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDD11F220CB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA968E83;
	Thu, 14 Dec 2023 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="G50OvnCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A288B10E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:16:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-551f9ca15b4so2876754a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702577763; x=1703182563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKm4VYXW541UD9zLfrkWeMQGaEXyfaC2EWpyopTpM68=;
        b=G50OvnCfgVg4U9u41Dsmuu1tT6D+lZLxAUu0YhkhXv/1Kz9nx9xGlDHt7X+WW2rg/C
         yLHzpH/hUtpG94lXsuX3k9owfDGZr+HSmOmyDzf7RZeJHJMY01Bcjv1++aFnI4A7gSLp
         7axSnbaZGZBeRdijtCAIWjqRU2kxSWSMK7+bL7LEhXH2Z+ZvIBKlgakep/gA/LAhkLjd
         bSbDTkE/zDuguWDwS1omiNDxihedlroyRro8O/WjsAYr1ebfEnKZlA2FgryJZ0WfKgIn
         q46aa/41lRf6z+MlfdNrsxIY/6Wn/iX+B5uYYfT+5mogVJ3LRCYcQ63vb1F+EwLR05C9
         1gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577763; x=1703182563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKm4VYXW541UD9zLfrkWeMQGaEXyfaC2EWpyopTpM68=;
        b=WBsQfCN+JR3YwRPJb4jNNc90vUqX9Ql8d1jQIASNWViLVyyj9XQWySZUaPQ2tqkY8E
         16eA8GxwGB1vqxgv0RtjgEsmLOKQADfOll0TO+Au/P2VhApd2DMgWJvj+N+0GjZ7pEur
         mijsz6Oadq0dE16yFmOqORstLLxNxgVrAt0IZ9zzaZn+oZCfWuZ0LVd10fOuqyzSDhCv
         bnPmt8mg4Ve5UyxwE4kxZvtyc2JPI1HvfI7Q2VE6c23VjreEjtAWjdfgXheEw6Mn58I4
         o69iyrZ/Jaum2dwm0osLjlthaL1+K2MHy6Bn4aTqcwq0pNcRbysCfTNrmqndxI6jVy6b
         1GRg==
X-Gm-Message-State: AOJu0YwcS0kFAEs+kKQr+aZlynIvdqLc1c7jX6OSNhLzSGsSbOpE1YjN
	orbp1nud3x9M9f8+t25jVLZUJmUvA6fj+MTxEio=
X-Google-Smtp-Source: AGHT+IEd+K3whaXT9c7VHp//KBXa33G6e7TMyfa1zsR/sjhGQqyS2eCSG5pWbfHBcsLRa8uOxlfNKw==
X-Received: by 2002:a17:906:a054:b0:a19:a19b:c72f with SMTP id bg20-20020a170906a05400b00a19a19bc72fmr5356980ejb.127.1702577763051;
        Thu, 14 Dec 2023 10:16:03 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id vo10-20020a170907a80a00b00a1d17c92ef3sm9723781ejc.51.2023.12.14.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:16:01 -0800 (PST)
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
Subject: [patch net-next v7 6/9] netlink: introduce typedef for filter function
Date: Thu, 14 Dec 2023 19:15:46 +0100
Message-ID: <20231214181549.1270696-7-jiri@resnulli.us>
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
index 177126fb0484..4ed8ffd58ff3 100644
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


