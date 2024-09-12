Return-Path: <netdev+bounces-127772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA8976674
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937E6B23B93
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB41A2644;
	Thu, 12 Sep 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L2JOs6KX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01D1A263B
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135706; cv=none; b=KZr9VJrAFVUtUKoztzXOx45YfYVQgJeNkMNAfHU3Wc3+aCqyER5SrIxmsF+/Z9EO9RXae+KR4Ow/0LUUCL2FH227avfotCgY+zcqjVxuS2ClDar8Bv2LMKNoSEaj/YOZzV4r1V/UokR5A48ReEpFKpnyDPpo5ahIKyNh8P7synY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135706; c=relaxed/simple;
	bh=7X1uADLZjCrWywAb/T3yUw6fZRd1yFFwvpgWf8s8fGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBp81+Nyp1XG7gczBO+WEXaxoVz0lT7nQJC5jWEl3xlOqr42yzPrTjTR7mPUe1bM6EK0dhcLMXAJWtP4SRRmbrSL3lM3hVHgZKMOvC7KaODaYa3E8hkcbtZwkpSDtGKvfsPRooFS5omLbtngBtoBNOM5n9gORfHJRfRTM0d3VPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L2JOs6KX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-207115e3056so7523195ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135704; x=1726740504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVBE7Pm7Q5s8a6rlCB82bDuJ6/NcBLKBqVzG1T0Sd1Q=;
        b=L2JOs6KXQbMcwd+3KU8DSQ8IXiDnR+rAznRALbxZLFOXTM9DJoFj0/5wyYf2Yio0uQ
         5NUyO4HoBHiau8g84seNfzTVQi7kXno6HcJX2hooNi4Sr8ztKpZDYvRSRqk3GmSwR5oY
         uUBCebYUw0J8gKqh8lwpj2zvVo+EAAP96E4P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135704; x=1726740504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVBE7Pm7Q5s8a6rlCB82bDuJ6/NcBLKBqVzG1T0Sd1Q=;
        b=nUvQIsIGZqPAqkzJxFQelOXFnS18tUFhd678Sdmi43i6Y0guxg/AE/0d6kcb4sBE9S
         6nOQjVRaRaH6CF6wy8ZALgpg5zJ8sVZ+5TcQpjTqfc+C9OB14/PWRGI+tTuCSM+Yzxg/
         bRQzgrhhkQqcwIPSrmj4j8jMM9lY1xM8Nttd78r4ooLOvLil8HpcWN1jGGZULIgB1equ
         WsWTHjYx7cUwYNoBPpCYnBgJ7BEXvNd9sI+TEH8VuWz1PfnKkGANmyN2/xjMzpftVY1p
         IIrCIvZPlpD1PqwKFpXzwZUIdM17JmLVz1aM3FGImho+jvhmw6qoF7Z4bczzB7hvIS+S
         1sxQ==
X-Gm-Message-State: AOJu0YxjjZq0gQDHqKNUWXkR3AVfbpXTl14nR2ot//jk9yrledW7HnX4
	1WkV7VFbrIflyR/YG8qrahz/NwpNc3MK3uoJhqUBf+HOaS+7Yzq0ODEaV59SskwsXhxUJhCt+Fb
	iU0iG9wZxZ3U3wOjGEDWRGUWybq2YwDiRugMLrB8l4XEBIlM+smEDjg/jRQVqQv8jQ1Ah1NyRZB
	gTrZRSs3H3OqfCT+O2efNJTwQFIitDgVyWNCULsQ==
X-Google-Smtp-Source: AGHT+IEVKBtDLy6qE1gRasnURzcTt8OTaL/9OrC0QY5wEcDhluu8jE5lROOeLxmdOJQ4ZTZ/UCI/vw==
X-Received: by 2002:a17:902:e94e:b0:1fd:aac9:a72e with SMTP id d9443c01a7336-2076e461637mr31643635ad.43.1726135703805;
        Thu, 12 Sep 2024 03:08:23 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:22 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 4/9] netdev-genl: Dump gro_flush_timeout
Date: Thu, 12 Sep 2024 10:07:12 +0000
Message-Id: <20240912100738.16567-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support dumping gro_flush_timeout for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 6 ++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 5 +++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 13 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 351d93994a66..906091c3059a 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -251,6 +251,11 @@ attribute-sets:
         type: u32
         checks:
           max: s32-max
+      -
+        name: gro-flush-timeout
+        doc: The timeout, in nanoseconds, of when to trigger the NAPI
+             watchdog timer and schedule NAPI processing.
+        type: uint
   -
     name: queue
     attributes:
@@ -601,6 +606,7 @@ operations:
             - irq
             - pid
             - defer-hard-irqs
+            - gro-flush-timeout
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 43bb1aad9611..b088a34e9254 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index e67918dd97be..4698034b5a49 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -160,6 +160,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	unsigned long gro_flush_timeout;
 	u32 napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
@@ -193,6 +194,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS, napi_defer_hard_irqs))
 		goto nla_put_failure;
 
+	gro_flush_timeout = napi_get_gro_flush_timeout(napi);
+	if (nla_put_uint(rsp, NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT, gro_flush_timeout))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 43bb1aad9611..b088a34e9254 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


