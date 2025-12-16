Return-Path: <netdev+bounces-244925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14853CC2986
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 13:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 964143029B6B
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795713502B0;
	Tue, 16 Dec 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X51dFIIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7B34F250
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887224; cv=none; b=ciWZc8FT+S7kOKoZZv+Joxb9d8/DiBkj/T+T05L8m1v727xbFaBR61SHDGwkFct6dWIcvTyrUx5X59ODV9HYzlZlT7sfO1lYGeyXkxMi0S/V0Fmv7n9yh/BX2pk58qyhUgsYzLHkorI7CVHq552KyAThelOOenxYr//XImYo7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887224; c=relaxed/simple;
	bh=/4kyx6JuTUj4HqQDL5fD0YXB3s5ROcvNO+Gc0P+Ys1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWxANmw3gtEXXMuNU/di54Umm8gaFZ3cqlvp4RKRatBek+XxbKAYMzTOUuTsM0YgKioXuGcU3vimViPHZW0w+MIC0PzsY9xaGJLwigf5Ojlq3HLCMXNaH/IgjdDDtDTXD0mbZOrKLupoHu19IVALz8ZLN9fTPYZ0AB+ewKIAIsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X51dFIIX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso1283421a91.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 04:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765887222; x=1766492022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+ncE4gPE3ALMb2f5l4z/btioNlvQ97Fqg7z/7QtpPQ=;
        b=X51dFIIXwIYa/FsVLHctR1tCr40JZPqX2Wd2RfeIBFM7b6OGD7NnxMJoTbEu4pExcr
         Zdab90+lKfuixHS/Y09Sktf/BuXgfHDXj6Z8xar43dzqaiSIHLtafOPOJn4U0NqN2k9o
         bBCOAAVhX9QXdmBNNWcV24IE3Bjs5Vgq0yev2buKZfHGNFpdpPYN4YAHj8mm9MXKe4C0
         HZNkKx2N0gNBYiJZVS5APltk7qJG/MnWmmfbVKVGhGE8jHxN/pNOtl0fiPEsnRaF7n7O
         Qewh1qgU2FWmUDw3KC7nDkgZEg8OlVU77b2CgupOQPdNEcPrLqG2S753/29lUWWRfGY3
         Kz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765887222; x=1766492022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+ncE4gPE3ALMb2f5l4z/btioNlvQ97Fqg7z/7QtpPQ=;
        b=sPSc8aYTb6rxEcK9Meqw0Yfuo6lQX7nO2N2Pttq0AQ5X/tXy0Wj+TXcqZVs+MshX/O
         jZ4a+VDPsjBPH6pZY2Xt/ovVYkX0gO1TKdX8kdxs+H0Xg0M3rqWK5xnf3H9lVCO315cE
         QkH7ceYzqx1qMhHhw4uCysj4JzW0lE6xfstSZ6ksJj5oLwEY6s//dLLeaiIsXks2/Lea
         puKLlw9Y3cuW5ylNBChPVu3ztqYsJmOWV8gpP267kR99hERs6ZHw49+0MgrPge+D/hYt
         q2aoqmXuHsUpqyAqFTH0aEv+xm9KFpUlprqglPPWEBuWJrBLiw+9XYSq55falHsvYjWS
         juwQ==
X-Gm-Message-State: AOJu0YwfqK7kHAIYBqhL94mMnTWTHbe4AVtjfwppmIHyGfZ9fL4WpqMj
	nmwoY/Adf+Zomhx9x7o5hcJ/u8pIPDFzQB3mxZV0shlqGhMFBKtRH+AH848QUA==
X-Gm-Gg: AY/fxX7Qjjku/D7dNI1SECHcdrhJJBU6W0KkcwMFMx4L6zlOiRhhbv+xvSDiT0IXzhI
	JMwj/N3rGguxPOezdGThvBYrYExkKXF7zM+Chj+6LcXyNCrYPC3FyCrFwnYplu7jWsS8lxO6jfJ
	anjSbGxK1+wbrlxIVtXFa8b8MYPZIHSPTnq2VF8Z/UbDtEtZe2ObkLDqPRGPjyySaPbjELILbzF
	q65Y9XBrm/1bPa9hv8OacgOn28fNrWumefQKmHQoqRZ0EnSmulVIlEjozZWr9aGbWrnhcR11/no
	mE6//oVj2tZUoplMUDtfbRhwJSBx5/A3jwMRMfclvJ0eJzz4C1GWk6iCEIl9FuLff02C2C0OOAZ
	Zw0q+dMMZ+/xnZiRXDHmoZobLX2uu0BqPUVj1L0Ubt/hsQAkrhPpgj4GF4HhMgw8/3Jg3wlVcyJ
	Rv+DygYg7PLEReuVuAaipbyGkcT2G9
X-Google-Smtp-Source: AGHT+IF2W1U+zEhuQpD9htDknN0GiwzPBhppXNc52n2TKoBe4Bb1WzM+z5TXw+Szfy2wyWGjocRong==
X-Received: by 2002:a17:90b:3bd0:b0:32e:72bd:6d5a with SMTP id 98e67ed59e1d1-34abdc4b083mr14168682a91.1.1765887221481;
        Tue, 16 Dec 2025 04:13:41 -0800 (PST)
Received: from DESKTOP-6DS2CAQ.localdomain ([211.115.227.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe200077sm11770023a91.3.2025.12.16.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:13:40 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v4] atm: mpoa: Fix UAF on qos_head list in procfs
Date: Tue, 16 Dec 2025 21:09:10 +0900
Message-Id: <20251216120910.337436-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204062421.96986-2-ii4gsp@gmail.com>
References: <20251204062421.96986-2-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/proc/net/atm/mpc read-side iterates qos_head without synchronization,
while write-side can delete and free entries concurrently, leading to
use-after-free.

Protect qos_head with a mutex and ensure procfs search+delete operations
are serialized under the same lock.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 net/atm/mpc.c       |  9 ++++++++-
 net/atm/mpc.h       |  4 ++++
 net/atm/mpoa_proc.c | 11 ++++++++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..c198381281fa 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -9,6 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/capability.h>
 #include <linux/seq_file.h>
+#include <linux/mutex.h>
 
 /* We are an ethernet device */
 #include <linux/if_ether.h>
@@ -122,6 +123,7 @@ static struct notifier_block mpoa_notifier = {
 
 struct mpoa_client *mpcs = NULL; /* FIXME */
 static struct atm_mpoa_qos *qos_head = NULL;
+DEFINE_MUTEX(qos_mutex); /* Protect qos_head list */
 static DEFINE_TIMER(mpc_timer, mpc_cache_check);
 
 
@@ -246,10 +248,11 @@ void atm_mpoa_disp_qos(struct seq_file *m)
 {
 	struct atm_mpoa_qos *qos;
 
-	qos = qos_head;
 	seq_printf(m, "QoS entries for shortcuts:\n");
 	seq_printf(m, "IP address\n  TX:max_pcr pcr     min_pcr max_cdv max_sdu\n  RX:max_pcr pcr     min_pcr max_cdv max_sdu\n");
 
+	mutex_lock(&qos_mutex);
+	qos = qos_head;
 	while (qos != NULL) {
 		seq_printf(m, "%pI4\n     %-7d %-7d %-7d %-7d %-7d\n     %-7d %-7d %-7d %-7d %-7d\n",
 			   &qos->ipaddr,
@@ -265,6 +268,7 @@ void atm_mpoa_disp_qos(struct seq_file *m)
 			   qos->qos.rxtp.max_sdu);
 		qos = qos->next;
 	}
+	mutex_unlock(&qos_mutex);
 }
 
 static struct net_device *find_lec_by_itfnum(int itf)
@@ -1521,8 +1525,11 @@ static void __exit atm_mpoa_cleanup(void)
 		mpc = tmp;
 	}
 
+	mutex_lock(&qos_mutex);
 	qos = qos_head;
 	qos_head = NULL;
+	mutex_unlock(&qos_mutex);
+
 	while (qos != NULL) {
 		nextqos = qos->next;
 		dprintk("freeing qos entry %p\n", qos);
diff --git a/net/atm/mpc.h b/net/atm/mpc.h
index 454abd07651a..35719b5c5e88 100644
--- a/net/atm/mpc.h
+++ b/net/atm/mpc.h
@@ -7,6 +7,7 @@
 #include <linux/atmmpc.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include "mpoa_caches.h"
 
 /* kernel -> mpc-daemon */
@@ -54,6 +55,9 @@ int atm_mpoa_delete_qos(struct atm_mpoa_qos *qos);
 struct seq_file;
 void atm_mpoa_disp_qos(struct seq_file *m);
 
+/* Protect qos_head list */
+extern struct mutex qos_mutex;
+
 #ifdef CONFIG_PROC_FS
 int mpc_proc_init(void);
 void mpc_proc_clean(void);
diff --git a/net/atm/mpoa_proc.c b/net/atm/mpoa_proc.c
index aaf64b953915..b91676187dd1 100644
--- a/net/atm/mpoa_proc.c
+++ b/net/atm/mpoa_proc.c
@@ -253,8 +253,15 @@ static int parse_qos(const char *buff)
 
 	if (sscanf(buff, "del %hhu.%hhu.%hhu.%hhu",
 			ip, ip+1, ip+2, ip+3) == 4) {
+		struct atm_mpoa_qos *entry;
+		int ret;
+
 		ipaddr = *(__be32 *)ip;
-		return atm_mpoa_delete_qos(atm_mpoa_search_qos(ipaddr));
+		mutex_lock(&qos_mutex);
+		entry = atm_mpoa_search_qos(ipaddr);
+		ret = atm_mpoa_delete_qos(entry);
+		mutex_unlock(&qos_mutex);
+		return ret;
 	}
 
 	if (sscanf(buff, "add %hhu.%hhu.%hhu.%hhu tx=%d,%d rx=tx",
@@ -277,7 +284,9 @@ static int parse_qos(const char *buff)
 		qos.txtp.max_pcr, qos.txtp.max_sdu,
 		qos.rxtp.max_pcr, qos.rxtp.max_sdu);
 
+	mutex_lock(&qos_mutex);
 	atm_mpoa_add_qos(ipaddr, &qos);
+	mutex_unlock(&qos_mutex);
 	return 1;
 }
 
-- 
2.34.1


