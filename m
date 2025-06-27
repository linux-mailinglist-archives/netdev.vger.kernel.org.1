Return-Path: <netdev+bounces-201944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F77DAEB881
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014531C48962
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB582D979E;
	Fri, 27 Jun 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMwyRbIO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C12D6600
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029726; cv=none; b=Q/80JHOH1WD/FthCOSC6FS3frQWmr7zjGgQFdBR0eMSeJc7FGEFZcVC4+fjVxWsXQXOLccVOm3XC07BvrFitqvqCpp8v9wecZSNuFfN8BDcY8ND7JCkg+qAynaKz5jeP7KoS81az/mxEqImb1/m/e4kUp3K2Vw0E5PJQ2UaQKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029726; c=relaxed/simple;
	bh=V4HZxW+yRYHkJFrv7fNxy4YF+7Y6lYIkWDuRCp73aEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sq6JRzEG6QGDqiX3tW2ZQOORx9sBqku2ghxY7cZ7+MuDPiZ/KyaDtvUalnby7AhCNms8YQEAn9AJo5yGkk39qlUPGXCO4zbnC9aPVydCFOO78wKAWUQ1pAjF0Cbjs003TGWKNfvAL8+OM9N1UakhJrXtbu6JWgGMPcQILVAdOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMwyRbIO; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d3e90c3a81so204568885a.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751029724; x=1751634524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LP+ybpHaeNqp2x8LzFTYbkzV3KjoW9LpFycSQFptaE0=;
        b=EMwyRbIOhZla62CWIzqU4EwdJjafS3/iQvZPc91NgMx5ssXKahZG7uckxyuOXEPBxl
         e8G3qh31mGWBK6xkFWhOZT0HNEZZL8NKJ1ietwCvFm8K4nx7UKVPumYsZrkMnNtL9Tp9
         9lqlhOH+nPTngss6HcqGDBgBSRG+MmEFvr6tSSLeefB8GkoErDD0Qu/9lQF5IWMzewM9
         NVjCq4fsNtrO8EtvsimEkgpOScOR3QecdJUHjnyATK1vAu+TfcB6tr6ypFQotwWQf1wl
         frabrV9nl5RlM77IFdwyl8jfwHgj0E2g/BZIe7cBmbogAYbk8WXzQM7RfPt0x+x7rbIR
         vAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751029724; x=1751634524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LP+ybpHaeNqp2x8LzFTYbkzV3KjoW9LpFycSQFptaE0=;
        b=QmG6XVxWD6YA3kwn0t2Uf61p/HveQEN54UeNCuAMcKD0LXFzRPLqg4Dj2TRX2DkTs2
         BfNU28k1RMHC6d5muZYSqOhzJVtB5cvqOju5A0aKPcC8SsnUJ1HFuovtpQFEcZXFIhDl
         2NPMsomvxtcOScwPegJh98oqY2naZ0rzQLW4NHb54wPzeNqlQxk+F5GCm/c6ltQ0PBn7
         Y5RpuE+oCxa6cbxNZy7kmOSWP0SCuFJ+YpmCv8YcTUCizgrb09ijbQ0iSbxgWoUqz0Ga
         Thdjg58wRfCJ1rltLNHoMcW5DENqJ3nWJGPcB6GcLQslpDhbuLw8CEJS993nV9iqISGe
         Q2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWyKoq7YV8Fal5U12VFZrvMhlHbLp5gP+wLGjKTwlu2djF+7OWB1T1k5ZOywXygunr11paAJDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPO2b4/ZaPlAFNogxX5edaP/Qo9PjbbRpfoNNUqT8Ban9NuSls
	HUDJxUeanNiAcChb2+Wc04RY1WCJJ4UDCyJflOKMIiVd01rcsQr/hQTDcepocsnewvxZYmF2SG0
	X2+o6a3uCTCCIuA==
X-Google-Smtp-Source: AGHT+IH7B47YrRhkwww433snlOtoDgzH0pr3nZzVM5Bm0hxoSZ3kJqQVdaOdfTf5s8rJW71S25pk9vdeRyYELA==
X-Received: from qkntr5.prod.google.com ([2002:a05:620a:2d85:b0:7d4:125d:ee27])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f02:b0:7d3:ed4c:fe84 with SMTP id af79cd13be357-7d4439e27b8mr402080485a.31.1751029724061;
 Fri, 27 Jun 2025 06:08:44 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:08:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627130839.4082270-1-edumazet@google.com>
Subject: [PATCH net-next] net: remove RTNL use for /proc/sys/net/core/rps_default_mask
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a dedicated mutex instead.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-sysfs.c       | 15 ++++++++++++---
 net/core/net-sysfs.h       |  4 ++++
 net/core/sysctl_net_core.c | 36 +++++++++++++-----------------------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index c9b96938639999ddc1fe52560e0ba2c4f1adff1f..8f897e2c8b4fe125a941f869709458830310169d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1210,12 +1210,21 @@ static int rx_queue_default_mask(struct net_device *dev,
 				 struct netdev_rx_queue *queue)
 {
 #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
-	struct cpumask *rps_default_mask = READ_ONCE(dev_net(dev)->core.rps_default_mask);
+	struct cpumask *rps_default_mask;
+	int res = 0;
 
+	mutex_lock(&rps_default_mask_mutex);
+
+	rps_default_mask = dev_net(dev)->core.rps_default_mask;
 	if (rps_default_mask && !cpumask_empty(rps_default_mask))
-		return netdev_rx_queue_set_rps_mask(queue, rps_default_mask);
-#endif
+		res = netdev_rx_queue_set_rps_mask(queue, rps_default_mask);
+
+	mutex_unlock(&rps_default_mask_mutex);
+
+	return res;
+#else
 	return 0;
+#endif
 }
 
 static int rx_queue_add_kobject(struct net_device *dev, int index)
diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
index 8a5b04c2699aaee13ccc3a5b1543eecd0fc10d29..ff3440d721963b2f90b6a83666a63b3f95e61421 100644
--- a/net/core/net-sysfs.h
+++ b/net/core/net-sysfs.h
@@ -11,4 +11,8 @@ int netdev_queue_update_kobjects(struct net_device *net,
 int netdev_change_owner(struct net_device *, const struct net *net_old,
 			const struct net *net_new);
 
+#if IS_ENABLED(CONFIG_SYSCTL) && IS_ENABLED(CONFIG_RPS)
+extern struct mutex rps_default_mask_mutex;
+#endif
+
 #endif
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5dbb2c6f371defbf79d4581f9b6c1c3fb13fa9d9..672520e43fefadf4c8c667ff6c77acf3935bc567 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -96,50 +96,40 @@ static int dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
 
 #ifdef CONFIG_RPS
 
-static struct cpumask *rps_default_mask_cow_alloc(struct net *net)
-{
-	struct cpumask *rps_default_mask;
-
-	if (net->core.rps_default_mask)
-		return net->core.rps_default_mask;
-
-	rps_default_mask = kzalloc(cpumask_size(), GFP_KERNEL);
-	if (!rps_default_mask)
-		return NULL;
-
-	/* pairs with READ_ONCE in rx_queue_default_mask() */
-	WRITE_ONCE(net->core.rps_default_mask, rps_default_mask);
-	return rps_default_mask;
-}
+DEFINE_MUTEX(rps_default_mask_mutex);
 
 static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = (struct net *)table->data;
+	struct cpumask *mask;
 	int err = 0;
 
-	rtnl_lock();
+	mutex_lock(&rps_default_mask_mutex);
+	mask = net->core.rps_default_mask;
 	if (write) {
-		struct cpumask *rps_default_mask = rps_default_mask_cow_alloc(net);
-
+		if (!mask) {
+			mask = kzalloc(cpumask_size(), GFP_KERNEL);
+			net->core.rps_default_mask = mask;
+		}
 		err = -ENOMEM;
-		if (!rps_default_mask)
+		if (!mask)
 			goto done;
 
-		err = cpumask_parse(buffer, rps_default_mask);
+		err = cpumask_parse(buffer, mask);
 		if (err)
 			goto done;
 
-		err = rps_cpumask_housekeeping(rps_default_mask);
+		err = rps_cpumask_housekeeping(mask);
 		if (err)
 			goto done;
 	} else {
 		err = dump_cpumask(buffer, lenp, ppos,
-				   net->core.rps_default_mask ? : cpu_none_mask);
+				   mask ?: cpu_none_mask);
 	}
 
 done:
-	rtnl_unlock();
+	mutex_unlock(&rps_default_mask_mutex);
 	return err;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


