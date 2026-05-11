Return-Path: <netdev+bounces-286714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPLqJ9H4AWq7mwEAu9opvQ
	(envelope-from <netdev+bounces-286714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:42:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57C511660
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EC9B30F6FF1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFA940B6C5;
	Mon, 11 May 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/eNtuNH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D43407582
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513475; cv=none; b=PrtHe/rvT59J9WUIjhanaOmtcxt8dVN9OzBdp+1TIBFZHRgBuMY+5xw5bvXTU1FCuupYYlsKAa4O05cMb7szxRTlNuB2GjPuebxFqtnt4OACFUj5fpBIBu9XXMapMSXgu4N8OtmbYZh28ICfIbCYSPchjMrFDwN54PrK26qoa5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513475; c=relaxed/simple;
	bh=W68e0LS3CuTxVaht5xKpgNF9uIgkcuE0pI3z2nIF8Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2zhJXKWhcGTLbhzNSEVdqRM5/ZVLT4ADYK+uUHJxuFXUDBHu3d4fFC/sKtPFg9UjwuH3GSed1ovNNr2Dkg33wYgluiWIslbttWpQWCOxFVB7LBpOKQyQwi4rBCZX5XvjOdj6rBZdNKXoSVNny67zjL80BNIWdMB6oz90yvm1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/eNtuNH; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f68f3b075fso5464094eec.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778513473; x=1779118273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXUsnIND6jZt3LMKLUJVPK7kDj+i0r4kYH0SJOIDOAY=;
        b=n/eNtuNHQjknjBOmwgIH5ECQlx4J7VT+tXtjlOI1fBBwzs3ADcO7hfwK7sp7LX1lZv
         09216FCxe5hXcNeRwmG+06MG+NjNnRqm3M5fW7f1a+iTmldVirqRLLj3628UeysgTi72
         m3VtGysB9E3HchgYawxq8xv5D/h8ZyRbqC+g1ucVIXknND8yJwGyCDWF7NCj3pYFMcji
         HKta0z1kjAJNNigsIVKmWFdFH2V8gQpHHhxuiSbWZYmi7+jJFpfsczLI0TSpffIbn4Gh
         lOP7l56YTkcG3oB18xZ07rktvKMepgzpxTbjoSkyNs9EBe22hA1AZGn1NcTlGbTQjIhT
         w0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513473; x=1779118273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXUsnIND6jZt3LMKLUJVPK7kDj+i0r4kYH0SJOIDOAY=;
        b=rLUlxBQv0xQQaNn4M71PHzv0pAo2HAjJ6BLDsDkQVebwW4xw23A2EPm1uvs9rZCIR4
         +HCi0gndrsVMEiirLBSIJCpuJV8/7YsUwjiwouykrMLT4E7dvmEqESNIBkCk1623F7lZ
         gvxxPd9NfPjmvpgGFL1jja7aWKimq0JfzKTsW7ZVwO5FJKUDHWm8JPl62oOLJeqrtQol
         x6BCEmaGG834tL4oZ9w0OxkFbZPTQnbpTGZ27gdZHV5ns5R4QJ6egCUtsI5atnoPENR0
         k/Lsv7L6wQLX2UTRqiYOmpDdopKWEnEoPJQZdSUuwCtsxiPLxMiKmhZQHAhQ1GONTthW
         usIw==
X-Gm-Message-State: AOJu0YykG5ApoaG6D4q5VsaHOP4Yu+sS/fnzhUyBjsHrrzBsBku/9FK0
	9hYvDnHzGB/RkjQTI9ysK5lpspTxSDbremAQsToBoEy7JPtTAZ2yZ5D0
X-Gm-Gg: Acq92OHL0DidYJATliwqi8hjMZsTpgNP5XQ+oOZ8kC49vCPh5sXvnfJRuiAfzy+kJPI
	q/2BC3C57aqNzeDE453MIzAJr+DwNDeDysYcDx84OgidiflTcdCDhaUem4FiJ3HyX66+GD9m1jt
	cL1aywhC2x50xjMIDs7lB2sFo+EBLF4EEorxY32i/kOkK6ei+WLC+HXOz7rJDqXtT2wgHFHHow8
	6RzKap5jSV73IfapcEqaLFss/wsZwuST7Oh9a/5OKRcWzc661O1aNHIoi/9H7K6CJn1h58vjXlt
	n/saKpUjGVj0/aIWmUIErV1Pt0jJkvuEvGvZU3bLax4GY7mRKPj1BKd8h2XIomOjpVEaKHmT9vW
	c8wNENvmvBT5SI037RuyHmFvwVxTugqSBMx9EoA/Dm9/93oKiXeSR49UO91JxA3XZdhNnWM2It2
	2jbFf/Td79dCwK+uzVmFBIOZbE+G1P/4iD/co=
X-Received: by 2002:a05:7300:bc0c:b0:2c5:ed1b:ca9 with SMTP id 5a478bee46e88-2f85bb72d01mr7274260eec.1.1778513472689;
        Mon, 11 May 2026 08:31:12 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm17464080eec.6.2026.05.11.08.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:31:12 -0700 (PDT)
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
Subject: [PATCH net v4 v4 3/3] macsec: use rcu_work to defer TX SA crypto cleanup out of softirq
Date: Mon, 11 May 2026 23:31:00 +0800
Message-ID: <20260511153102.2640368-4-alexjlzheng@tencent.com>
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
X-Rspamd-Queue-Id: 4D57C511660
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286714-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email,tencent.com:mid]
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

free_txsa() is an RCU callback running in softirq context, but calls
crypto_free_aead() which can invoke vunmap() internally on hardware
crypto drivers (e.g. hisi_sec2), triggering a kernel crash.

Use rcu_work to defer the cleanup to a workqueue, for the same reasons
as the analogous fix to free_rxsa() in the previous patch.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 8 +++++---
 include/net/macsec.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 1b0ff7fa5ec6..79df71ea9edb 100644
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


