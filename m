Return-Path: <netdev+bounces-50635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358F7F6610
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E5281B1A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888BF4C3BB;
	Thu, 23 Nov 2023 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="t1ry1g+U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C0E1A5
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:59 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548f6f3cdc9so1728572a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763357; x=1701368157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUVpumJEMKlIV3v0TPxPq6FHGtEDKA9wZkXmeuh2z+w=;
        b=t1ry1g+U/jyyAtPfzvTVrjmnhkfh+4nQj/p43dWaVeZ19PbFb4WmHixgA83EDyywcj
         pdwGg0axA7WA6u8yXpksuqqu3qjpkP2aRqRyQlJAenyrNvMfCw4roqmzIVqz4n1u3tr6
         yhoZaJy6o1RutWjwXB5CACIg0a8bDY1xmYZEb2oXVM0NQi8wBd7AWhmjkcMixc6E2M7y
         PZLX8GY6MDtq56iShtWUr9rq2Gqfq5D2oJCwmFQd0WqfZDy7dkHzQlQVAuM//aRkvE4z
         KIUkyLE+bncFfCP/ZmjmLnuXO/VIUiAB+fBhQsS5BsqUx04peqVlTGWaLSZUa4dOBK1W
         yhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763357; x=1701368157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUVpumJEMKlIV3v0TPxPq6FHGtEDKA9wZkXmeuh2z+w=;
        b=LqMffB0oE8B9GlnykrZ8rpAPOUYrrkKnUDGlIEd/k9m+mh8GWzI1wjVRg2guUGMhhY
         bnE7H2L0uWTEJniwSn09I8NbIpTKcNLpdO/TMwAXFzjQVrH7Pay5XYyLMivOw7Mq6rJG
         faBIRL62A5DAICNbtwWPBNjJQoU/DKv09eYqq4/2y7MrVxO/DpeWdRCrsGzMu6dODByE
         HNvi6/7Q/LAN3cjjvsm/3jWrNNd88Yie5OeYIoo1qvkKZQx/3oBmIs3AlOxbGXgVP0Vg
         /QPJlSjkemgtV5ZxKdy97imtFqPXqiRlOeIBFVleNu4jKEA7WgWzysPmLFNr7inGKy1w
         pb5Q==
X-Gm-Message-State: AOJu0YwOR6WFy7SHI2sE4tsrd5lEpIuB+VERobtsyvLjGfbRB5PFDmlX
	ceBmj43RGuGjlWdh8Hg6FCTuEUAghsfsj4RqNHQ=
X-Google-Smtp-Source: AGHT+IGmhlH922ntZry+TKbfC2tC9fNCjNrjru5g4Ja1R8pG6dUp0ZWq32RvD2Dki+h0aAhW320ciQ==
X-Received: by 2002:a17:906:3053:b0:9f8:a07b:4adb with SMTP id d19-20020a170906305300b009f8a07b4adbmr89355ejd.18.1700763357648;
        Thu, 23 Nov 2023 10:15:57 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rv4-20020a17090710c400b00a047ef6f2c6sm1072158ejb.135.2023.11.23.10.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:15:57 -0800 (PST)
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
Subject: [patch net-next v4 6/9] netlink: introduce typedef for filter function
Date: Thu, 23 Nov 2023 19:15:43 +0100
Message-ID: <20231123181546.521488-7-jiri@resnulli.us>
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
2.41.0


