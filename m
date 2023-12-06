Return-Path: <netdev+bounces-54570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5FC80777C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC592816D3
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1EF41847;
	Wed,  6 Dec 2023 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="z31cVYNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8754139
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 10:21:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so2463346a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701886893; x=1702491693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+9Re8MPvPIHkS3XLRdqUkErHPRBEm/NXIkcpvf9Izw=;
        b=z31cVYNVllMIYLbXunbXOKEVQ21dHXWva8QpOScuUKKpN1agKktTYkETHEGZlGM2fV
         y2EngVmKCF6LxFmp9PxMqTSEX/Lr25vUo3a3B3CNSrNEmJJxTTfuTMOJXg3hahRJdNsz
         iyOfoao2dNhb3GR7fKFpp7osldmlqxAWb2GFn1qLGHwOMMW3icauy4av0j5FAn8mDiXD
         jSp5cv7pbTaET1C93TW0YVGC1OJds3H05GA9qMrkBinV0R633wz84LtKcblR7srXzwlU
         LczWPUERq5rys+BDTG/uS9E4weU2AuThjskFTEjm87FV9zQxI3ci1QpAj8/TvvexaX0d
         hYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886893; x=1702491693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+9Re8MPvPIHkS3XLRdqUkErHPRBEm/NXIkcpvf9Izw=;
        b=ln4qKttqeciWdm0yLfuY8HIyihvWFf4fLJEOWlB/dQBNr0J3VTUozHwfR30BY4WvHI
         stAWSgELU6zGyee77gEWDU3Eb3BQRCV859Moro9tRPBkvbGwjkXXTZNyKI+ANFNCq8Ts
         b0C2DpQ35imrTSPTh1+KyKO0eGMbCjAN4yq1AEW0RUfPKKDLcoNRZ+hbrxQU6eRg7aoX
         m7aKK6xCPsieVVuSPtMqSlGHUv9GTUN22om4/X5AKIY2pSGACxYgTFgPZZofTc+kruTe
         CUCmTk9HxXNiY1SjhyOhFaGHFu5OMRq6WWV2zWgySSLb/ZwgtPNopJMBCQNVk6EupUaA
         JeIw==
X-Gm-Message-State: AOJu0Yy0ZF0XStK7zbL+gPI/Suq0hgd8YvOZuiEBqlj3a5NJQXCU2Wzd
	cz+xfm5jbB6LjTD0NE6dKJuLMFlitRA0aYwFJaY=
X-Google-Smtp-Source: AGHT+IEu+XR1ZXtl1RAic/EPq9i900MVk7fdYQrXjq4wEv4Sq1npUqgTVyKcYoLe2gGYGi4167HYjg==
X-Received: by 2002:a17:906:297:b0:a1c:4c3e:99e2 with SMTP id 23-20020a170906029700b00a1c4c3e99e2mr4019197ejf.22.1701886893450;
        Wed, 06 Dec 2023 10:21:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d22-20020aa7ce16000000b0054cb199600fsm243411edv.67.2023.12.06.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:21:32 -0800 (PST)
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
Subject: [patch net-next v5 6/9] netlink: introduce typedef for filter function
Date: Wed,  6 Dec 2023 19:21:17 +0100
Message-ID: <20231206182120.957225-7-jiri@resnulli.us>
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
2.41.0


