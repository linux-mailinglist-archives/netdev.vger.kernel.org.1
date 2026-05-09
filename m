Return-Path: <netdev+bounces-286102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNWeNlar/mkyuwAAu9opvQ
	(envelope-from <netdev+bounces-286102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:34:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B834FDE9C
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F7AC300B9C4
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 03:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08692773CC;
	Sat,  9 May 2026 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1ZMxb3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049C37BE6E
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297662; cv=none; b=krz8UiU/RbIZygTVuJg530TtstVy0GCTeTIgMPZYhccQ7vNXdMVubmcl4axC5X9gsUrLa6bYYk2C9jHsRA/swuubKTQ9D6ZEst1rR9+G9b0SIbQBol0wkO6her4DfYt5rnHwkjqXYi0rQO+7xLZW54bxAnF6HBM1Y8igvZSxkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297662; c=relaxed/simple;
	bh=PXc1G+ZTTRKH42MY07f1jLVVwPn7wjVFioe55m2UKl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2KOEaeP2ZiyIRoXVlvpDdf7YENnMhDPiI9A4EpFpt4EOJ1n54JOJPpSwyoPb2zSA6Pl/fbrcZ/2O+C9I1kcbLLXJ+hRMLmz+aOJvq+ubfQpyesvpC3smm8pwVieVB+qPeGqg88oLK/5daKAZpJqe5dRLByBQ3au9/iSyMS/XAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1ZMxb3j; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8ccc7755so4092292c88.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 20:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778297655; x=1778902455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwEvoJ8dtU6cGI3ewdei8t2ZAPBHtdSFFFMs2CrwJ6M=;
        b=K1ZMxb3jgb9344k0rd8WB9/mM0bnTTmT8LkNx8S7I64nwyrJijcNmMrvBLSZZKswnS
         LKowScs2/OIv/EgeIiLu/YpUNilYAvEA+H3Ie6T089roCvBzj7+06dhGirjCN6yCc3jb
         Uqqo69sDnv6sbZr2WToxG/KT7I3zoK7KBpG5BjQ9woXQXdgb2mpcvTqWMJZMbJaRcAPP
         5jJbocTDcpkaXbe0B4CjmDn+skIngC1vm5zELGrqxq2c2hPVvzHFyc9X7Ixw+Xmo5xAc
         jsIStaiSDTFMbTlplCoZPBow9LJ10my10BqIpQLLDE9AJ6mnMR79GdO8oz/Ql4K2U4MJ
         DgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778297655; x=1778902455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwEvoJ8dtU6cGI3ewdei8t2ZAPBHtdSFFFMs2CrwJ6M=;
        b=itSstikDiKkSsfS4fkUaAM9PWJK8KnWlfss8QOBZechJ09WIGCmM6YPcl4e4lg3yAn
         Vv/yPghrpZV6chcnPEMBzrBpUhVoGnnxjUts5yz41+9d0BoQBUZdfE5SsjSgZpbty8mB
         GBETogmZth25AJf/okBMQO67xPwUlNvCzFZJTFxb3VnT7yxShm/hj4VxeBZIgz4B7hFi
         0WFjn9QH8AHPOPcl1UcZyAGEcvpGfGM25EGlHpgiLPk5sSFcZDljvR1LPQjISgoVQc00
         dbqmwuc94j95X/92bC8vkw7sZRjfcLZlt2u7/uu2Nvh5hGKqiTZ00sxB3Uz5MvIqm545
         bqog==
X-Gm-Message-State: AOJu0YwAW5ewyZRkwOjSgc2kMcaJ4KQ+MBOciF0qemZMMz7boqw0y+6E
	BK+dCVaL9qOW+XN1sxuT0NMOIBbkNfnaNuJ+fV8c0cK/bKAjYa0fJ7nu
X-Gm-Gg: AeBDievNu8B49gtZSZ1JU7jnsGIZZiKiq431neXXvTogbkirTSC380TKxcopFLmVX24
	ReTMZQ8Q4KLf4DluIdAKKI5YyQ1WJq+lSp0fgxOyAfzU0FJjtsetOhU+GBbkwYlRROWQIpD+V0W
	ytyiyIs6rsh0PVtEfgNFkhRDTmH8BAx/MiTxUOClAAPEP85CVtsmIKfvCmFqSzOzdE6l9gWWdbk
	y34d15NioSoqHsSmra1yF7DgYy2m5kh4yoS6prze9pVO46PTl3uPt7xAZ/9+LxujfnOCdbMHemz
	DY9yAVDIWG6g5ynz7geID+PJUnl/uZRcUurA08h3doyU1DEHauGUfrMnyBApTua2th39XLeNFAH
	gQPuEaR2PCcl9uZySbA3zW2nkhtofzT1F2aa+3ZSSgCwTHBNJbGwgd/tzhT6SkdeoaeuNklWPad
	jYjpur/YGW6NPTduQdiXiSMUU8GEYomdIFr0c=
X-Received: by 2002:a05:7022:605:b0:119:e56c:18b1 with SMTP id a92af1059eb24-132a83f77e5mr562283c88.25.1778297654865;
        Fri, 08 May 2026 20:34:14 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm5500989c88.7.2026.05.08.20.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 20:34:14 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hannes@stressinduktion.org,
	albinwyang@tencent.com,
	shenyangyang4@huawei.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH net v3 v3 3/3] macsec: use rcu_work to defer TX SA crypto cleanup out of softirq
Date: Sat,  9 May 2026 11:33:47 +0800
Message-ID: <20260509033353.1814289-4-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260509033353.1814289-1-alexjlzheng@tencent.com>
References: <20260509033353.1814289-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9B834FDE9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286102-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

free_txsa() is an RCU callback running in softirq context, but calls
crypto_free_aead() which can invoke vunmap() internally on hardware
crypto drivers (e.g. hisi_sec2), triggering a kernel crash.

Use rcu_work to defer the cleanup to a workqueue, for the same reasons
as the analogous fix to free_rxsa() in the previous patch.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 drivers/net/macsec.c | 8 +++++---
 include/net/macsec.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 67e4e3f439c7..e91d853c8d45 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -205,9 +205,10 @@ static struct macsec_tx_sa *macsec_txsa_get(struct macsec_tx_sa __rcu *ptr)
 	return sa;
 }
 
-static void free_txsa(struct rcu_head *head)
+static void free_txsa_work(struct work_struct *work)
 {
-	struct macsec_tx_sa *sa = container_of(head, struct macsec_tx_sa, rcu);
+	struct macsec_tx_sa *sa =
+		container_of(to_rcu_work(work), struct macsec_tx_sa, destroy_work);
 
 	crypto_free_aead(sa->key.tfm);
 	free_percpu(sa->stats);
@@ -217,7 +218,7 @@ static void free_txsa(struct rcu_head *head)
 static void macsec_txsa_put(struct macsec_tx_sa *sa)
 {
 	if (refcount_dec_and_test(&sa->refcnt))
-		call_rcu(&sa->rcu, free_txsa);
+		queue_rcu_work(macsec_wq, &sa->destroy_work);
 }
 
 static struct macsec_cb *macsec_skb_cb(struct sk_buff *skb)
@@ -1510,6 +1511,7 @@ static int init_tx_sa(struct macsec_tx_sa *tx_sa, char *sak, int key_len,
 	tx_sa->active = false;
 	refcount_set(&tx_sa->refcnt, 1);
 	spin_lock_init(&tx_sa->lock);
+	INIT_RCU_WORK(&tx_sa->destroy_work, free_txsa_work);
 
 	return 0;
 }
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 0980ef36fbf0..d962093ee923 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -176,6 +176,7 @@ struct macsec_rx_sc {
  * @key: key structure
  * @ssci: short secure channel identifier
  * @stats: per-SA stats
+ * @destroy_work: deferred work to free the SA in process context after RCU grace period
  */
 struct macsec_tx_sa {
 	struct macsec_key key;
@@ -188,7 +189,7 @@ struct macsec_tx_sa {
 	refcount_t refcnt;
 	bool active;
 	struct macsec_tx_sa_stats __percpu *stats;
-	struct rcu_head rcu;
+	struct rcu_work destroy_work;
 };
 
 /**
-- 
2.39.3


