Return-Path: <netdev+bounces-133391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA87995C8A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE2FB22B3E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA251016;
	Wed,  9 Oct 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UK5ZlGjo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C944C6F
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435362; cv=none; b=iJpUsNUFiP7VrZubHPAXlnKBAw9MgU+gjIWmF+l2QNl2Hq47T355vcma8czrR+2gAuvDkchkGmSCCzzSKV4Tp6QDRscxdgGdOQ8rMZeDTbam3zH0uVXcczr82VG9bajxQKxZwvL+Aox8PYo5ZBE5K8uThmXRRF/uKqyHirfeL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435362; c=relaxed/simple;
	bh=fmuhBTf3bfBIF3wPJkt513NrrZF6VgNGcvDr2NU+JRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxjUw1mpzteLszpAvNk1TbRGXqmtyHFwqP3ZCYftAchezai9D6BTcPSA5oe/H/33qrkBmo50sLLWbNtdfORGV6bkXQ25THMMIxERqSaud1hCfvhTCwCUheqzGXQb95n45qpxeOY43OHlwsYPZrwkFP14BTwVoW5HnmtUzMlPlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UK5ZlGjo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b5affde14so45486935ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435359; x=1729040159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wozl6FR6jO7LtfNZu3T9/AIWhCZAnrXDluBkWDgGbTE=;
        b=UK5ZlGjok2PnRZ5DCGgpaad4wjQMwclmXoxPRRCbvCUFDrZpCzLYAywVBO7XGGI8cS
         JfWPyzubJ4MgIlQQQ9jr5WT+oS2i4EZCxjggLAFBNqQgkCzl5lT2hh9JrL+xK5Y/TAjZ
         qKgPOV34tKbLsxLO+hE/kmyaH1um2JeB50xGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435359; x=1729040159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wozl6FR6jO7LtfNZu3T9/AIWhCZAnrXDluBkWDgGbTE=;
        b=wXXCkiNchaxjMmyURM5wZNnSKTkIKztUxHlFtP5IJzu+lH/xk4eMgiC9v1i2l36XdM
         Qb9p6vkPjeP2CUBrqqWGDjVtDqmkSQLxurURLUja6WQjCQNJI+7t9ixlAVtB/izfGyS5
         K9eP3tOfnjmWhXxvQ9oVblUl8BFszLUp7kSoWmsZd6HnBALoc4woPd2E7dz+cgZ96z0E
         BDz8l/I0ld0P08ERn4XCIRfDWYf5rcDeSgVsWBsHtXzwZn85Evt6M+A9vKCHlAX/t2cT
         ewIU8+vf2PJ6b6uPod6s0s/lluSH9eIrVGr+NR2tD2gX9HAf6eajIzm+xcI51KH6Uu+4
         LiXw==
X-Gm-Message-State: AOJu0YzK+0wBWCNJE85Kuk8zpbwtVKPrMgyz4QJ6zgcNPp+NoROUz0IS
	3gcHVtTd4f8OCV4ayBH/tJE0fmYmPkKhGiczLj9fS/6nAd1oHkieCrIX6+Nj0AHDWcqR0uAzuHw
	LXc+GCli3NsA2Yh5QNfXNAVide/Hh24xwcFZMfx+rflUxmvUsdCtyT1pBCH/rD5RNH4s9bShbsG
	At0ciKb0HqK8yrfvnrMyMHkDYAAa3YbAlFRWQ=
X-Google-Smtp-Source: AGHT+IEqXufwgSngAKNnN6AE5Vf68UGEK4jh8JF0urWXXFYD7O9enYEJi71s3fUkRUjlzqvzi1A9yA==
X-Received: by 2002:a17:903:22cb:b0:20b:6458:ec6b with SMTP id d9443c01a7336-20c63738e4cmr14191925ad.25.1728435359509;
        Tue, 08 Oct 2024 17:55:59 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:55:58 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 4/9] netdev-genl: Dump gro_flush_timeout
Date: Wed,  9 Oct 2024 00:54:58 +0000
Message-Id: <20241009005525.13651-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
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
 net/core/netdev-genl.c                  | 6 ++++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 585e87ec3c16..bf13613eaa0d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -255,6 +255,11 @@ attribute-sets:
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
@@ -644,6 +649,7 @@ operations:
             - irq
             - pid
             - defer-hard-irqs
+            - gro-flush-timeout
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 13dc0b027e86..cacd33359c76 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -123,6 +123,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index de9bd76f43f8..64e5e4cee60d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	unsigned long gro_flush_timeout;
 	u32 napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
@@ -195,6 +196,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			napi_defer_hard_irqs))
 		goto nla_put_failure;
 
+	gro_flush_timeout = napi_get_gro_flush_timeout(napi);
+	if (nla_put_uint(rsp, NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+			 gro_flush_timeout))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 13dc0b027e86..cacd33359c76 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -123,6 +123,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.34.1


