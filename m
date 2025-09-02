Return-Path: <netdev+bounces-219205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BFB4073A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9187C566BD2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A4A338F5F;
	Tue,  2 Sep 2025 14:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE1334385;
	Tue,  2 Sep 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823816; cv=none; b=f4knn8GOnB76eEtd8M7x1Ptg8izzzjsb6r9gPwnGL7t258dOnTHQNUSZlcY9EUi5mKydAMAhC4LItXrZGleJeV/wgqkuYBhBP6FPpqOi19gsGr5aI8QsQMA9wfwYnoap8IgXF22US6j1BPMGEmGMcPY2AC9SAqPkSvbUWxwE494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823816; c=relaxed/simple;
	bh=vsrCuCc+y3e2UkrkHsJWcHRSJIHfaZdVu6TPSorMirA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnkmEFXuVAHUbkvFLaIraCdguesfB5I/1eafR5ePCYqsJZLNO3L3bIAUat8lIsDTeBkYWpPhXBZ5m36wev2xOwE8ISrphxwi/sCe86BJNT75Sr1plj/SA2L+lI7S6W+LAgkUvuBe+vHneGrtCw3zNw9T3rdc5k3UY7gb4//d2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b04271cfc3eso283732166b.3;
        Tue, 02 Sep 2025 07:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823813; x=1757428613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqIPIeQVq0Fjz/lLCF7nvzMdLzgG3+VjQlkd5zloZBo=;
        b=ewbmWdz8MorNOLKbV1ukDwY6cyECdJ39ir3EJgmCiTy/AVdYmtOOUIVH9P9fnPg/60
         UdfVXBtigPZ1zrIbOTlCkARhvaq67mOF3/K8AaXFMOzOpcCF8Sc979VwA1XdxzcWTKFK
         tiv1Hq84wwZRlUORsRkxs35pAzvz9SAZP1xo1Oq/NwCp/cnkqU27cpXhQi28DGrvQ4fI
         FqeTC7wj/XysNNe6YLo0EaFrplhP1GB5fHy+yadbZs3OgjpADUplR9qRenmfbpWFxehq
         pZkgNyYYoeQQIX9YhNeqgaoIkKojKyPcFnaNps+cqOsYONObISsNTaOg5UqRKDBY6pCs
         nSFA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0ovC2l4RySM1l27cxoAnDMeco+SfZBF2VuQluqCOVY+0RyDLJJRod4zuwHSP0fUDuIkpFf4gu+IYPUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmtP0FA/mLwC/Q2YPLWo7XKLRhv6iLezrosEyvH6ZIifKBiwJy
	IKy318Q1E8lUj4lJUWZGpkMFQOrNRmMHPehSKzXxRynjXBaZ74NJK+7l
X-Gm-Gg: ASbGncvdG5wzkNiVoDe9L7ZbttMc2f+Swa3+XhiAAlN8BbYXB9e2xKXEwpOPX6ow+Wa
	5XuiGTr1M4wLy082RDr8IrlpuG8ot0S3mWs3yrok5GbYNiDNIOBmmHbsUCIVB7doohffgI4oHM8
	u7AyPw7wKAc2TtDFgvWP3cULPRvCZ7Ysq/eDI210i1HqRm+WghqLkc3h/9pBRUt+Tpa/+sAeu6a
	PsqNJOyQCovEmpHagqm5/sfRFLJt1K8k/o2LhLWyBQSnNKfj/KrFfvLmpjbIdiXgt6Xl0UYlnTS
	1QXg9heOf0tDP2JazGe+zNzAB41glo9xEOJfjXsqRZkOQRtbwpjg2LlS/jPUgklGSxNwOmlZliC
	USVsmN6vKTUeP
X-Google-Smtp-Source: AGHT+IF8xZJixysxsFusbsE0Ye6Xr4jK/k2DZ2OhraPE7YLKOsg62XcMQkuZLz0FTLgQFbEE7IkJ4Q==
X-Received: by 2002:a17:907:7f8d:b0:b04:4147:9f81 with SMTP id a640c23a62f3a-b044147a275mr500322766b.21.1756823810696;
        Tue, 02 Sep 2025 07:36:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0423ed35e4sm557901966b.25.2025.09.02.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:50 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:27 -0700
Subject: [PATCH 5/7] netpoll: Move SKBs pool to netconsole side
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-5-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, 
 calvin@wbinvd.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5421; i=leitao@debian.org;
 h=from:subject:message-id; bh=vsrCuCc+y3e2UkrkHsJWcHRSJIHfaZdVu6TPSorMirA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5c+qcxpIMfrTkCDp6s6lxxxbSQgY5ysHQM
 vNdoU/AX5uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bbrLD/98wwy4jxs70ben86y7aoFfmrV5I+9qF5baLE8s0DQM6unhSSxAvbk4kzy+EhUyC0DPSnS
 lwNzWyB1uzAJRYSlsl6Pg1tdjxkCCuXyGUbEVJwLMRWbTRKRcNqoU0RiEnAFNY4uCtUt7UQpCE5
 0ypeROqBBoe6wldechrkjzdJey6Yve3RI4gAzmsKtuv9UZ2iQ9069XqHShTjFi+gf+vy+CONUpG
 mk/N2o4pn2MlYg0ZuoG2Z1UZEI2+LNfdDIuuYnsRKiAqqfKzW429FH2X2CWfM+PwzHk3dhtn/J8
 xxAlVdVs5zlDhr2fIU9Y/bgyzuFH982p6wnahSTTRBRwSD/2mS1jmBTK5Ji8sGJoK8Jgqh32viE
 OaB//1b09UTDKylPF9qgJRHu2wMxAKG4Dq/vE3Lhd4/BHw1ed6C2QSEi+iSuqN+VZI9CqCOnXjG
 1H/W0y5Ow4DFMKW1DpOIJaqq+2Ku3Y8sXfmOml2Yp+OHNhdMakLF096An9mZ2S95VwxB8nRavB2
 YXCe92mUUJkUne4jigcUlrhjHB0YgeLCIJowIBVH9zOz0STVPxTA1caWFw98VKkMDpTYsM0wly+
 8s9nR9UGCRnBycyUdVJ38WmvT/gtlYL8Lq3xhk5IcIh6y4cGAa5KHKBmMWv6f+4kmIlqxhywDoP
 yRwCG7kaoGiNb8g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Since netconsole is the sole user of the SKBs pool within netpoll, move
the pool management into the netconsole driver.

This change prevents other netpoll users from allocating and holding
onto skb pool memory unnecessarily, thereby reducing memory usage when
the pool is not required (which is all the cases except netconsole).

The skb poll struct is still attached to the netpoll, but, eventually
this should move to the netconsole target, since it has nothing to do
with netpoll.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++--
 net/core/netpoll.c       | 44 ------------------------------------
 2 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 90e359b87469a..3fe55db07cfe5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -57,6 +57,19 @@ MODULE_LICENSE("GPL");
 #define MAX_EXTRADATA_ITEMS		16
 #define MAX_PRINT_CHUNK			1000
 
+/*
+ * We maintain a small pool of fully-sized skbs, to make sure the
+ * message gets out even in extreme OOM situations.
+ */
+
+#define MAX_SKBS 32
+#define MAX_UDP_CHUNK 1460
+#define MAX_SKB_SIZE							\
+	(sizeof(struct ethhdr) +					\
+	 sizeof(struct iphdr) +						\
+	 sizeof(struct udphdr) +					\
+	 MAX_UDP_CHUNK)
+
 static char config[MAX_PARAM_LENGTH];
 module_param_string(netconsole, config, MAX_PARAM_LENGTH, 0);
 MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]");
@@ -172,6 +185,33 @@ struct netconsole_target {
 	char			buf[MAX_PRINT_CHUNK];
 };
 
+static void refill_skbs(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	skb_pool = &np->skb_pool;
+
+	spin_lock_irqsave(&skb_pool->lock, flags);
+	while (skb_pool->qlen < MAX_SKBS) {
+		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
+		if (!skb)
+			break;
+
+		__skb_queue_tail(skb_pool, skb);
+	}
+	spin_unlock_irqrestore(&skb_pool->lock, flags);
+}
+
+static void refill_skbs_work_handler(struct work_struct *work)
+{
+	struct netpoll *np =
+		container_of(work, struct netpoll, refill_wq);
+
+	refill_skbs(np);
+}
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 static struct configfs_subsystem netconsole_subsys;
@@ -341,6 +381,20 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 	return -1;
 }
 
+static int setup_netpoll(struct netpoll *np)
+{
+	int err;
+
+	err = netpoll_setup(np);
+	if (err)
+		return err;
+
+	refill_skbs(np);
+	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
+
+	return 0;
+}
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 /*
@@ -615,7 +669,7 @@ static ssize_t enabled_store(struct config_item *item,
 		 */
 		netconsole_print_banner(&nt->np);
 
-		ret = netpoll_setup(&nt->np);
+		ret = setup_netpoll(&nt->np);
 		if (ret)
 			goto out_unlock;
 
@@ -2036,7 +2090,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	if (err)
 		goto fail;
 
-	err = netpoll_setup(&nt->np);
+	err = setup_netpoll(&nt->np);
 	if (err) {
 		pr_err("Not enabling netconsole for %s%d. Netpoll setup failed\n",
 		       NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 04a55ec392fd2..94c75f39787bb 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -35,21 +35,8 @@
 #include <trace/events/napi.h>
 #include <linux/kconfig.h>
 
-/*
- * We maintain a small pool of fully-sized skbs, to make sure the
- * message gets out even in extreme OOM situations.
- */
-
-#define MAX_UDP_CHUNK 1460
-#define MAX_SKBS 32
 #define USEC_PER_POLL	50
 
-#define MAX_SKB_SIZE							\
-	(sizeof(struct ethhdr) +					\
-	 sizeof(struct iphdr) +						\
-	 sizeof(struct udphdr) +					\
-	 MAX_UDP_CHUNK)
-
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
@@ -219,25 +206,6 @@ void netpoll_poll_enable(struct net_device *dev)
 		up(&ni->dev_lock);
 }
 
-static void refill_skbs(struct netpoll *np)
-{
-	struct sk_buff_head *skb_pool;
-	struct sk_buff *skb;
-	unsigned long flags;
-
-	skb_pool = &np->skb_pool;
-
-	spin_lock_irqsave(&skb_pool->lock, flags);
-	while (skb_pool->qlen < MAX_SKBS) {
-		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
-		if (!skb)
-			break;
-
-		__skb_queue_tail(skb_pool, skb);
-	}
-	spin_unlock_irqrestore(&skb_pool->lock, flags);
-}
-
 void zap_completion_queue(void)
 {
 	unsigned long flags;
@@ -395,14 +363,6 @@ static void skb_pool_flush(struct netpoll *np)
 	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
 }
 
-static void refill_skbs_work_handler(struct work_struct *work)
-{
-	struct netpoll *np =
-		container_of(work, struct netpoll, refill_wq);
-
-	refill_skbs(np);
-}
-
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {
 	struct netpoll_info *npinfo;
@@ -446,10 +406,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
-	/* fill up the skb queue */
-	refill_skbs(np);
-	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
-
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);
 

-- 
2.47.3


