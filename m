Return-Path: <netdev+bounces-58224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0B2815900
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB641F23304
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C498B10A1F;
	Sat, 16 Dec 2023 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aKEFYbfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311B17729
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1ca24776c3so500157066b.0
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702729813; x=1703334613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKm4VYXW541UD9zLfrkWeMQGaEXyfaC2EWpyopTpM68=;
        b=aKEFYbfkSU8oCJo6+ls6BrnP3RTK2MZ9cRriGQUjIgrLV11dJl+8bafJYOiS7eGuCQ
         vSD5XNk58xdT/Lik9cw9R5TH74VtYXsBo4f/s5YFf1HQ7vou/9bJqHTnIV0beAcRms5N
         CcJARb5rI1SKMlgZ6/Md02FW6XfZhsuI4olXSEne6vJBqPVfAmw/6alCYYtsFPv3ZzRv
         AuHXR3efUBZtJFh4A7P+x1Et2acFqT+PqNzx9/RAkoZm4fnbk1PtpmYKesxA12BpL2EO
         KMYGvDzNJBH4vTzvfINdyx92+Wb+yB+CBrzCxdrtXvC3wNL4x2jvXIJc8OkbsVjJjEcr
         A/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729813; x=1703334613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKm4VYXW541UD9zLfrkWeMQGaEXyfaC2EWpyopTpM68=;
        b=uTLnspUK2Odmc3wLGLOBY23jEIwTm0nWe6ZNd+M8gHak9LHAZK+PL1Rcv8jLMQ1mmX
         hQx757o6+X8n8oIUNmCr5ZZlPZ3sfP+RZC9mqrZrbS8IZns1BMpeCN2cIsnEpRFoAGT4
         UlXjfp49D6T+aZSweSCX2yFWEdWtdw8WTGZ+x98IbspDKgs2Y2vUY5EWarLs9FFjLo5o
         5v7IZUyFoEWB0zyO0jSiSG2OqHk1Ee+VWazQRmx2TgtIUE33f87ekhwHZNfswjYyrb6w
         68wNto0jGEMQ9EQrL9XBlBL70M8vxfwSE89PQvjcQSC/4JAewKWhbF80RRbHf5mWShFg
         tfPg==
X-Gm-Message-State: AOJu0YwFm6UYePzJdZjr9XrGgwsneYG8e08K36zzKnKvf9rqIWrw2PNk
	sBpaSG4Oauz13XvUPGAs+5nU2NZ5QKKjv3P53w8=
X-Google-Smtp-Source: AGHT+IG6whLFcdkgREjLq0CqpYHMF3jVuGmeC9kbxWoNnbbr4rbU45OOR/TywD4qlQod2wbjPBAS1Q==
X-Received: by 2002:a17:907:8d8:b0:a1c:7c86:8b79 with SMTP id zu24-20020a17090708d800b00a1c7c868b79mr11485633ejb.26.1702729813522;
        Sat, 16 Dec 2023 04:30:13 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id vw12-20020a170907a70c00b00a1c904675cfsm11755535ejc.29.2023.12.16.04.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:30:12 -0800 (PST)
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
Subject: [patch net-next v8 6/9] netlink: introduce typedef for filter function
Date: Sat, 16 Dec 2023 13:29:58 +0100
Message-ID: <20231216123001.1293639-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216123001.1293639-1-jiri@resnulli.us>
References: <20231216123001.1293639-1-jiri@resnulli.us>
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


