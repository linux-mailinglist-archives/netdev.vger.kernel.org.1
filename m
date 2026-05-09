Return-Path: <netdev+bounces-286101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN5JAFCs/mkyuwAAu9opvQ
	(envelope-from <netdev+bounces-286101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:38:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A98E4FDEE8
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84CFF307B07D
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 03:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B9381AFC;
	Sat,  9 May 2026 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv/xpnPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52095382281
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297656; cv=none; b=mt8o815squhv9MLplDpSxBrPdvYN972BHLlVshdOYnLQEuSE5Uq2p9L+eKLG/s3q+MwAeKh4NT7at5+S5Nrsx4VCgt/B/Q7i5s41xCdnH9jhJMkDpO3LpRmcu/MWT4je693Hdz1yp8PAPsmk9l/ksR7gYAWS4PLNNaMuIuKgicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297656; c=relaxed/simple;
	bh=RC7KUDm0vfRUyDesE9Dh/S40NqhnzqFOOKvD/Z5ywuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEomjd/qhcZlcWmY50iTLaAqN4rAent/U1zBDtT5DI5ES2lSVbdtag/s9ksKL4iJt/bny3RHa/q98OMbQzCowbgbPdd/Jc801IQFcpHEefHU8N5NmKVeNrUqlnw8AFdO6UtH2Mb8NEWk1VD8Sb7MB5xdfyhX13HLanxDcMbr5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv/xpnPv; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c1a170a50so3741999c88.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 20:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778297653; x=1778902453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwTDmMVV2Hq2IQrp233SiuNlHmlaz9y7w8F+WJgS2+o=;
        b=Jv/xpnPv5lTxI2dcRuAIubpTOpamRbBxhgXdmB0XU8v27BI0GkZc5CxV1UI1izoVtK
         DI3QGCsGhRYVVpS5AkMvq/VVjERMzcK5EMQJTjdR9q5cSw39vP69eKrgKliwe4sguAxO
         1Uguncp13OJn3vNG492wlgWpUnObQedjPfiLhys1xmUesnpQdFr/cDCZhwCC2SlWNsgw
         xeIQQJvh/YkYFvI5QWK6I+AErAR5NFY9RhbmW6Y3TULi15+BrOXiiT+/b5CmVs4nZlLG
         cW2GpH5/XX7EsTxEy8KM5n1n6ja5XnR60FfJJJv9lpyx+ryDazbinsDqW7fYGQPhtBaZ
         46qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778297653; x=1778902453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qwTDmMVV2Hq2IQrp233SiuNlHmlaz9y7w8F+WJgS2+o=;
        b=NIcOlnPYOToIq3WINms6MMsveOU7rjQtDz3rI+3IUL9teIgOlHWjQLSXILPc18RNtB
         vVbhCluvlU26WIboQ7Z7SlgA0LBcgGN2doIFO2DGXznmJ1NR490KWLaxQjut3/bH/HaD
         a3yyd/ucU4ekGDDx0iYOyMS02ayZ6utm9oWNZlC3jcs5Q6nelUnm5blEpjWG8wqI4q2Y
         st1yEWDTedz38PiM/S0P43Qwcn6VVU7ocPeT3MLqnQkaK2m0tKztc3E03d4ExB/RkCC2
         5WxX5pR+V1nY0AlLW8+h9DekHaA+krW8iu+ktT9xjDnI19mfG4H+E5zhbprtSABe+Nu7
         uPdw==
X-Gm-Message-State: AOJu0YyPtMM6Fo+5vSlRK54rVKrrbraWKvmDf7T65rCPajy38vQxYMRR
	CnF1fJgcXvKq6S7gtGM8Z1IW5eMwoGvsXS6H5nmpdjQXFr3WDx2ku7P4
X-Gm-Gg: AeBDieuWIz8KMAr6yWB5k6pFb6nTlJXRL5qVtw/xxZtCForgwtvyGYyT/Za1paBtUVd
	iuSAdK20DOqx5Zqon/U7jgcN2jzo0RWCPzg3kupNm5gp8lz4O7lp3hI/Gvs3x3pA2IojGFiviYd
	hK10p0B2ppI2ZwdeU4ZEQ2qbiqE9SXbudTz1OINFZ1nhSHt7cHzt9XHGmzhWHgz1tRwuI/cwyTD
	ABW1ZTURnb9IiDFsU8iDekic6JMrGICeWN5cV75Ej8kBCPGp8eFK7jVNLaAztSvucLhBUhCjHV8
	HTPsLzwK3tnePn0MlLS2HBBhHme/uuUV8tO9R9TZSIfdRlZIQi0tTkh+j9aVVfQbiWoyaeKwRSW
	aob1JJ6ylija3sVNaendkJEa6POwE03VHaFH5MdKoFKgX2s0YnWN66nUM9wsiVNZpkQ3njfItR1
	MjGYG2hG0ts+rH43qqCuL8v9MxBgtt+7lVUc0=
X-Received: by 2002:a05:7022:4182:b0:130:73ed:214 with SMTP id a92af1059eb24-131967d5111mr7372756c88.1.1778297653213;
        Fri, 08 May 2026 20:34:13 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm5500989c88.7.2026.05.08.20.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 20:34:12 -0700 (PDT)
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
Subject: [PATCH net v3 v3 2/3] macsec: use rcu_work to defer RX SA crypto cleanup out of softirq
Date: Sat,  9 May 2026 11:33:46 +0800
Message-ID: <20260509033353.1814289-3-alexjlzheng@tencent.com>
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
X-Rspamd-Queue-Id: 4A98E4FDEE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286101-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

crypto_free_aead() can internally invoke vunmap() (e.g. via
dma_free_attrs() in hardware crypto drivers such as hisi_sec2).
vunmap() must not be called from softirq context, but free_rxsa()
is an RCU callback that runs in softirq, leading to a kernel crash:

  vunmap+0x4c/0x70
  __iommu_dma_free+0xd0/0x138
  dma_free_attrs+0xf4/0x100
  sec_aead_exit+0x64/0xb8 [hisi_sec2]
  crypto_destroy_tfm+0x98/0x110
  free_rxsa+0x28/0x50 [macsec]
  rcu_do_batch+0x184/0x460
  rcu_core+0xf4/0x1f8
  handle_softirqs+0x118/0x330

Use rcu_work to defer the cleanup to a workqueue. rcu_work dispatches
the worker asynchronously after the RCU grace period, so no thread
blocks waiting, and concurrent releases of multiple SAs naturally
share the same grace period.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 drivers/net/macsec.c | 8 +++++---
 include/net/macsec.h | 4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 52d6dd03ac92..67e4e3f439c7 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -176,9 +176,10 @@ static void macsec_rxsc_put(struct macsec_rx_sc *sc)
 		call_rcu(&sc->rcu_head, free_rx_sc_rcu);
 }
 
-static void free_rxsa(struct rcu_head *head)
+static void free_rxsa_work(struct work_struct *work)
 {
-	struct macsec_rx_sa *sa = container_of(head, struct macsec_rx_sa, rcu);
+	struct macsec_rx_sa *sa =
+		container_of(to_rcu_work(work), struct macsec_rx_sa, destroy_work);
 
 	crypto_free_aead(sa->key.tfm);
 	free_percpu(sa->stats);
@@ -188,7 +189,7 @@ static void free_rxsa(struct rcu_head *head)
 static void macsec_rxsa_put(struct macsec_rx_sa *sa)
 {
 	if (refcount_dec_and_test(&sa->refcnt))
-		call_rcu(&sa->rcu, free_rxsa);
+		queue_rcu_work(macsec_wq, &sa->destroy_work);
 }
 
 static struct macsec_tx_sa *macsec_txsa_get(struct macsec_tx_sa __rcu *ptr)
@@ -1409,6 +1410,7 @@ static int init_rx_sa(struct macsec_rx_sa *rx_sa, char *sak, int key_len,
 	rx_sa->next_pn = 1;
 	refcount_set(&rx_sa->refcnt, 1);
 	spin_lock_init(&rx_sa->lock);
+	INIT_RCU_WORK(&rx_sa->destroy_work, free_rxsa_work);
 
 	return 0;
 }
diff --git a/include/net/macsec.h b/include/net/macsec.h
index bc7de5b53e54..0980ef36fbf0 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -9,6 +9,7 @@
 
 #include <linux/u64_stats_sync.h>
 #include <linux/if_vlan.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/if_macsec.h>
 
@@ -123,6 +124,7 @@ struct macsec_dev_stats {
  * @key: key structure
  * @ssci: short secure channel identifier
  * @stats: per-SA stats
+ * @destroy_work: deferred work to free the SA in process context after RCU grace period
  */
 struct macsec_rx_sa {
 	struct macsec_key key;
@@ -136,7 +138,7 @@ struct macsec_rx_sa {
 	bool active;
 	struct macsec_rx_sa_stats __percpu *stats;
 	struct macsec_rx_sc *sc;
-	struct rcu_head rcu;
+	struct rcu_work destroy_work;
 };
 
 struct pcpu_rx_sc_stats {
-- 
2.39.3


