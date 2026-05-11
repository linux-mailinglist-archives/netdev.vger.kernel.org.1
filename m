Return-Path: <netdev+bounces-286713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIPpEEH6AWrjmwEAu9opvQ
	(envelope-from <netdev+bounces-286713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:48:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 473D7511859
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAE7F30B3517
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA82402B85;
	Mon, 11 May 2026 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOhyoAIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270D407574
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513473; cv=none; b=FTVZobvtXBQ17SUHNneP/0CptH2ucmpZ/oE7Rm7W2qkNiZ6LCEQb/q7L66hDN98Z51VLgX/fXVPPNJHX47szhiod1n3KOgqgjsJsieWm+OmKyyet6MwYL61LO76zqL/HPnUoJDq9bIPBF4rf7KDfUu271FkCJf9ezKYti+HMfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513473; c=relaxed/simple;
	bh=FwOeBbgnonXRJl9KK0wJJNsebKrXtMEBkQeaUcnAtqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4PDRHZ2eLFyU/5eicXMFdPtaErbMZ4iMFC8P1+vPBodsfSd63qhZAG5+sXc2y/bY9xjyh+bSHQDw4SXzo7gm7ERmc7ioCxmyauf/4nbQ4NQ11Lt8J6hUIngxFZO/vHrDq42dVrLpEsKDc2VESoCk9fDYnDs3ecli3shsnCNM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOhyoAIn; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ee990e8597so7774379eec.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778513471; x=1779118271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg4K9woFMxvavcEFvbUNjCar5G8JN7StQ4W5UeFBilU=;
        b=OOhyoAInl4lUyQNz0AXZsGXMhAT1iaeBr1qMvlrQ0k2giAmRLQB78ef32+tC9cDA2D
         tj5cEIKc8DoP7ScMvGLx3LrF59ldXCauR4IyqzXJj29C9cMkyIz2FOew6z7FQYRIZoee
         Vibl78GhrVadqSrcl/X+UXnxNTbMzeXqKgBSBL4r4iMPDh/NMwUxLgCcQsTee25za1G5
         Ki1Y+NZUcQ+SoG14agH/pSNzAR6Q6yIHHskAt/SPHFIWB/PCchCytGXAbpG1t9ntH3da
         5Pd67nmZPB/KIxdbyHmdzYRwaNia8ihuA7Q/IsVsR8Cy1Ptp0G68UA92nVrk7X8Ehg5W
         nsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513471; x=1779118271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mg4K9woFMxvavcEFvbUNjCar5G8JN7StQ4W5UeFBilU=;
        b=Tf60aBbSGVk/9oNsVbdrEAkWCSfDFXejK9Xk9Bx86UozbHP1DzrsdazDW6G2lUGPg6
         dg1yM5myr1B0Yvizbp5TMQCZ3XY3QWiI6elGfTofeQetUshO4d6qtfySP9bmNjFhmKBD
         VSAwwlytNwYjVLEE8vvYOvKsEkuoSmKcsOR2cA7rII5dxyEZfGJGereTJ0KVMbkSDwqX
         M07ZFV3aeDCCMJgxld+1MaqVslpUefc/HeFq0MeZhlk1uQDEL8EU+Gkwvlw4REH43yka
         3HemrPFOFVeweWF9aDZLbse4e09BKVONccjJpfdovrlwC099qpV9zAg0hNdkzFAUubJT
         nU+Q==
X-Gm-Message-State: AOJu0YyWTiIGqgZAKVSgAAoTCZWGYWG512aQZ2RxBGNt1Rf+fnGFgx1L
	tDegGZLcrLcMsswsBd9YMILFXKlKKjVc53nt0exy2M1ZcHEUMZczOmyw
X-Gm-Gg: Acq92OGNPZOmA6aSBnou4wtFiEhDJs8DTILO9sQDMsY/zGx2DH3tcca0i/7egkiCLBp
	xS5ENSou92prBXNdE5jYzr9z5i0K4zl9IXnXaWrO2R0hyOnxJcPvm8RAhg/yDFB1jAR8U3gzlO1
	XnVGv6lTmXfKmAaslIutASne9WpLozGwjXHjKPF7r1WqHkwnTTe1rUhFuhM9PidAf9XdymSdSyi
	qkd8xZCUA5sPHk1hu7EdQVyg/1TGd+uHaitiCgnDgYU4YYpxlN3AXqnz6KjxHijQNrSOs9PxY87
	x95g5hSeAsTAfwVNcVk38cr7iwhC4z7TRGj4poXbVwZ2IGuKClL+r2HWPPqq5adCNF34i70turg
	Rpdl9MIl5TrvvtJ8etKFunsES+i2M2jNXaK2DtbebGXWf7KqJiheBHFiQc23FMDe810sLMuV3hv
	JBRPMUkJnPS85uiCUyRrAMsTPKCis3i4IPKZA=
X-Received: by 2002:a05:7301:6790:b0:2da:44ac:6d0d with SMTP id 5a478bee46e88-2f54ac74af7mr12622919eec.20.1778513470769;
        Mon, 11 May 2026 08:31:10 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm17464080eec.6.2026.05.11.08.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:31:10 -0700 (PDT)
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
Subject: [PATCH net v4 v4 2/3] macsec: use rcu_work to defer RX SA crypto cleanup out of softirq
Date: Mon, 11 May 2026 23:30:59 +0800
Message-ID: <20260511153102.2640368-3-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511153102.2640368-1-alexjlzheng@tencent.com>
References: <20260511153102.2640368-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 473D7511859
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
	TAGGED_FROM(0.00)[bounces-286713-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:email]
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
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 8 +++++---
 include/net/macsec.h | 4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 35284ff7a17e..1b0ff7fa5ec6 100644
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


