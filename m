Return-Path: <netdev+bounces-49130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AB7F0E12
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03700B212A2
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E7ADF45;
	Mon, 20 Nov 2023 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="h+K40tq0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9271BD6
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:12 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso5606877a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470031; x=1701074831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB8pRDpjBJKVYNvoedXvmF/zyOfIVdCrEmjN7Ra0bnk=;
        b=h+K40tq0RQDlCRufx0ADDbwbfc8LbKY2uchYyCsJ1ZX5Qt2aFi8W4Y17fRoVcRoRGm
         vw8KiKrHdjTjQ6V6DjX/n5eZNQSpZT6OjYA8de8a9vdp1hKXtTHZzRiixFJIzEyySHo/
         6qR2p8PeyW9KXOMK2b8pCJFcPgpHuUsls/A9s0m9qE9ZevTqUfKoj2Os9L0ioeRVUFVr
         GCz0WI3P9VZoEa1GNoKnZN6Gb40D4pJA+21qYzh7lHPqbTWO3sLLpNbVuZCF0EE7NWxm
         bS6VhSwIm3Q6lwU5r317kLGlE9G0knEzPBgzXa8zJ5CP9o5cog8V/JJwmnMDjmlud5iJ
         9C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470031; x=1701074831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB8pRDpjBJKVYNvoedXvmF/zyOfIVdCrEmjN7Ra0bnk=;
        b=H4jB/iFS5EgynfKnwzTGNxO6ANO9ntFee8NmKHGAWJJFjD5YEgUu7pdqv7bR3hGvU4
         qTB9njm9sy8ZOeFeLWVAHQ0VRXV2bBGEKgjWTb6PBqANLTFaQhpAHVbakiIggJJiOyIh
         XnjXD5Khl0Ct5NDyL/Jm8nzGRdku8UisH9x6QxKk60y9MDVJ8SyLxN9xvCA3JMNCQH2i
         lZ1KvS+Uhg/CX4vJrk5bYSjYUHX2j2ggwPnpwuKiY/lrr8dhjr+9jy/Rxu9Tenk+tSki
         gUQCsHchaLmnYoffyIQMyOSPbPYyrYefkf9Lo49u97xi1qMWhy3UH00lrj63RJKfp25y
         ekcg==
X-Gm-Message-State: AOJu0Yyndyo9bzZ/59hzgUUIlIRfpyOMX30AhON1T3Mvvn64tnuBFxZJ
	8maUk/xQjKFNG32svO67eRe+Kdds0N46lzh9ps3ASA==
X-Google-Smtp-Source: AGHT+IFLXwss30abruvRcW6VS8hpZjIgGXFSC/18WXLqUR+feS442j2VhGx6S+cV4BopherjbTPn8g==
X-Received: by 2002:a17:907:82a2:b0:9df:bc50:250d with SMTP id mr34-20020a17090782a200b009dfbc50250dmr3642661ejc.54.1700470031170;
        Mon, 20 Nov 2023 00:47:11 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906c19800b009a1b857e3a5sm3702548ejz.54.2023.11.20.00.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:47:10 -0800 (PST)
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
Subject: [patch net-next v3 6/9] netlink: introduce typedef for filter function
Date: Mon, 20 Nov 2023 09:46:54 +0100
Message-ID: <20231120084657.458076-7-jiri@resnulli.us>
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
index eb086b06d60d..c81dc7c60e02 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1520,8 +1520,7 @@ static void do_one_broadcast(struct sock *sk,
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
2.41.0


