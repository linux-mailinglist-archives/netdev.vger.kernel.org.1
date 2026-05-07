Return-Path: <netdev+bounces-285112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDeBFo/z+2mMJAAAu9opvQ
	(envelope-from <netdev+bounces-285112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:06:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED454E22AC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5368E30167A9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A335F280A56;
	Thu,  7 May 2026 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abaK/mp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B923D283
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119507; cv=none; b=AdZ/JdT6afDAOsz+0RH+ubkEy0apbqNCR3CYyC2QFIYDHCpPRkVCF7rHfKBte4cygo5RmXk5vqDXj64Fc0Iq+w49q8qfmpZAXJcyowNIoomQupAnGnmlVW1c7P+WIcvKJ2V3YQRTDfiNv3EiqNZcGc9gh0F/OaY3ejpaJqBgDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119507; c=relaxed/simple;
	bh=9+g2zk4x4olHwlJLPRosLYgpZONxo9J9FF9pSp8Q6Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZO/kYd1kJrmocu4HQTYdoLElGaN4A3E/5LkdcUaQPyPF1vWkRm6F3ToBS9rtCWZOnNr75TmNVEr9HZk9v1wlOtAAw+bWYoT/Vx3m27jlsNPW09QG7gjuEXaSotrnuFJrlFv2wJ59IpsMtEvaCCwbGtvYbqw64wAtUv7B1MZ94FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abaK/mp8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-364f65f6eaeso357380a91.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778119505; x=1778724305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u7krB9HatPzz4Tgv9WAIlMUE+1bSmsd922wqFTiVHI=;
        b=abaK/mp8AEvfGPDT+2CK1n/YtLjGVOqdeAvRn3tjaeBlKF64jkCrD3xvyzLxVrndPt
         SHSvexWtmZHML2RNa+PNmvjwJ7iAM7Vzz/b9fq4Y5X5AnYqK+k0AvnRrWnDwbDR6GK2q
         0wPD/ext04vzny8MwPr7JEZc2nPAgEEf0opNBFv3CvjLZI48q2BtlkcDte6nt8I62dbF
         N4XCaJQ4kv2AfpHupH0hybqbpvEZFqePizTOkywpulpDmK3vf+G/nD9tEvpWl3Db6Obd
         E58EveGmqICAheg+4iX4o0SoReJ3Kmm2WA+H1B1sbYSp8cJFzAZIJwaNuCNmhdnRzUDn
         g9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778119505; x=1778724305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5u7krB9HatPzz4Tgv9WAIlMUE+1bSmsd922wqFTiVHI=;
        b=oMawGh6hrIDp/OS7GgdUWsb6cwE28M0WsSQg1M/MAap1fto7NXhvdp7oiE7FOFgTsG
         k31dntD1yTeLeXWTWxJj8zTn0YkWfxDtWa1nPh8bfpW+wJaFbiCxZp/BlFQwjTo4LnuH
         TBj45cuWq1gTdZ8qISf64xoEpXSVHXoWIxwW3kPCycRa/KULoW1wKETwwpQ4XcYevmyL
         sGMotZXNUS0qWpZusIvHZ1edwNuXp6veJNveSZcEJGguqnrdz6cq6HIS1FbLKp6ab83C
         2cBXH95e7FDvPYj3k1mwgQNMN/fsYpWMPpDTYV83HU5VXoUfAlz1dGMi1yrzreNZI5Te
         yeFw==
X-Gm-Message-State: AOJu0Ywwi4nF/lLkpdTpxwL8LEvp3dqF0dljd5UUIstGl3CzJSJWFWKH
	ZpMZAiWypdDSWsUjzz/JJwOdIdu9L3U3o8AVKl0sETtMfVUhNvrFCQkK
X-Gm-Gg: AeBDievv/OkKD1NVO8uNromcMkZhWQ5/fZflVZsZm+bx58SykvK/BN0dh6dRzb2B1Ws
	w/4bgdB39Ap/c6JrZylhw/XgmjzsW0Qro0DmGDgE9r6/UtTmRzDbkSA/CBoLNW5fGhSPr+tMiC+
	9InH8J0fR77JMNc4ggn0yfBlfQ1RBoTxyn4S22fJTvvx1EYOLtP3M8v925R+gMweVqLtU9QZ7QN
	Rx9QAkvm5+tDxWaQEBn5VDFmo/qgm8lzLYqGENwChJ0UNgUtWl6J63vqyg1dHElbXBxibB3HYOM
	omn/FslKa95TxVxha+lv20EK9jEkUZnkzsE+8W421NuH7x1WHLiDq+YpB0WCK8CcC63YrzuF+fQ
	P2EIeiBOyc51eFhEKJyN7eaJ3qXDFphNCGcKgs04PnWsnoN4zo6TEj4xEknNYNWhkI8R152Pzkx
	Rn505XId25mUalxCe+mZw3yJLJ5SEFqvIgR810znsB91qLxezzHrdcIyNq5JdM6dRiFnHj3+Y=
X-Received: by 2002:a17:90b:2248:b0:35f:b348:63e with SMTP id 98e67ed59e1d1-365abbe373cmr5738132a91.9.1778119505310;
        Wed, 06 May 2026 19:05:05 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4cba340sm5100204a91.17.2026.05.06.19.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:05:04 -0700 (PDT)
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
	kuniyu@google.com,
	shenyangyang4@huawei.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH net v2 v2 2/3] macsec: use rcu_work to defer RX SA crypto cleanup out of softirq
Date: Thu,  7 May 2026 10:04:25 +0800
Message-Id: <20260507020426.1126254-3-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260507020426.1126254-1-alexjlzheng@tencent.com>
References: <20260507020426.1126254-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6ED454E22AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285112-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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
 include/net/macsec.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ddb22473e701..e0862ecd23f2 100644
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
index bc7de5b53e54..d6136debe1c8 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -9,6 +9,7 @@
 
 #include <linux/u64_stats_sync.h>
 #include <linux/if_vlan.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/if_macsec.h>
 
@@ -136,7 +137,7 @@ struct macsec_rx_sa {
 	bool active;
 	struct macsec_rx_sa_stats __percpu *stats;
 	struct macsec_rx_sc *sc;
-	struct rcu_head rcu;
+	struct rcu_work destroy_work;
 };
 
 struct pcpu_rx_sc_stats {
-- 
2.39.3


