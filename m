Return-Path: <netdev+bounces-285113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEZwBKfz+2mMJAAAu9opvQ
	(envelope-from <netdev+bounces-285113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:06:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6104E22B4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F8833007299
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96970282F3E;
	Thu,  7 May 2026 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9TS5AVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23327B340
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119518; cv=none; b=Ck0KfmVPVVUAtDlSMP40hSc84HjGCk2k4E3X5V4lAsWE8lWjNQZBDgW0ShWCgm934GShan0igR7gGQmD54iSJue++lOAR/FAOa+nZ6Y6WyAyjc7WOcmaxqneABMy0UX5m0RVFDvbMlkXd8wJp2PkYtmAYYjdsKJvWLxNChv4bvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119518; c=relaxed/simple;
	bh=X8P3BDdBUCN3S+Y5Vgb7DmOy++ylY4/rZh0LtbSgBsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6BQbZObRny8WpZ2kecxwpFhZIf7p2bYu2F2lfCeXP6Zd7ap0qmmsiDaZZSPu1IjPQurrI7Jl+hoW/O6F4W52i/bHCEyPgnJUKwxjMdDVm4gOA1quKoX1gU+PHwzfAl7Y2mx/qc6WxqxeKK7g6iaO93MfQX5k5LRttNESAKi4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9TS5AVq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-366139223e4so4135a91.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778119516; x=1778724316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v53B5sCY8wU+gZFMEi6YoFYsOoEItoL+JNRsiTSKRrw=;
        b=O9TS5AVq7ykbO+9XIH84lW5uSu126mxPt96RPN3bsaGJL4Jw0GFwAsGwNxyauq9hBN
         ytjcoZoBtIVTyaZ7R4QOE5mBJlTMgyviX5+xRh01pebWqgvi0Z1q/Kxoyn8leQ/Q6fDE
         tmUbLHNGuMUk0FfbxAw/G959vfQl0gkYOxxBwysZG7s7Eo6R1vzECveC99/PQcoDrmrd
         HMdgxx1xF32JYIqdyxGKn0zzp6BAdzz0wu+hQwZOjHoqf0aRxMZLmwWVsrx8Fp0YjvyI
         YjDN4+jn7dmKIv78O3adgoxFtTPVsPLQYk2h3sFLbslv57pP8UOMfC7RlBtileB+i0Vs
         8JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778119516; x=1778724316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v53B5sCY8wU+gZFMEi6YoFYsOoEItoL+JNRsiTSKRrw=;
        b=aqowAz/TYai1hg1SghQzhPtrghvI1Z4qopv3wR5oBKuWpjlChdWBFUVRbe/uITbdfD
         Gd4aBaCxVXNzQcgpUHoXIha+yDeEGT0VSqxxgCVP0phdyOJsWwC8VLYiFu2vh5/PN0Xz
         cj9TfAXQqbj3f5/SszXmkrRdg81vmuWAwGl0b3SdhnBHQ8t0eASAYmUDz9WF8y1npuCl
         uEvOL175UHfh1X4fLsUXLkBPnIwPeMQ9mAEBduJogWmVC8ZDTtSe3x3gZgSmvLB/+2qM
         rAweTuEsQCeX6AVTpVNvDXV19INApScP5XPwsZAYNI4SuUjWkmB8SzfxQQU5NfAphOsp
         97fQ==
X-Gm-Message-State: AOJu0YxYF/TbbZBJ2vIBaKGgfLWqIaC8gnWQZnS72OJRzydbpwoQZ2u2
	d2+eUx1DHNV+hBxF10ztkbrXOiKfeNRKbJCHXzGA/tyAiM+FhLOuxNwu
X-Gm-Gg: AeBDiev3FSKbIk9XLeIS4/0o8nnOoUr1MAx/GsshHFknFmX+33ZJviTIRzOJ/dv+FZ/
	XB6ArXfGGCSLkZ1TP7ggakvw0GofzZZ8rSvTYM0ViwrT0CwXd5amSBjo9d2l7NzjUXN5TyRYBQQ
	Kg63/2SlC/aI5CbGRm6qeH95DYjNpGEu1pglbdUMUecwbXX6mKDBi+RNK93B2pU5QGMVIrrZfCe
	WmCHu5VtmyN26rqKXXtyNAm8eWcvUfn2zM3sC52w6J4VUWOazMRNdhJEgNg9e7I6TLhyUwhGb1g
	GN6aU63eqwpLezeMf9ctgydi9SstAZPedCKhz0VQBQmLX+hLaCIhMmwCatPvJKFb16QqsZSKZHM
	o0+WcuZIlY/LGROhL79XoNBR8kD01En3OuOO8irUZ+yF7RfkZvIEDJj5EJ0dCbX8nlbrWXiLVUh
	WYHBY2ETBbuO4ZbazQBAeHxG3v7oiSxf9TnxAkndQBR3pim2q1+i1KN4NloC25i81FLhPuQcM9D
	dypVp5q0w==
X-Received: by 2002:a17:90b:3c8f:b0:359:8e5e:43de with SMTP id 98e67ed59e1d1-365ac47e3ecmr5981783a91.22.1778119516390;
        Wed, 06 May 2026 19:05:16 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4cba340sm5100204a91.17.2026.05.06.19.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:05:15 -0700 (PDT)
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
Subject: [PATCH net v2 v2 3/3] macsec: use rcu_work to defer TX SA crypto cleanup out of softirq
Date: Thu,  7 May 2026 10:04:26 +0800
Message-Id: <20260507020426.1126254-4-alexjlzheng@tencent.com>
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
X-Rspamd-Queue-Id: 1D6104E22B4
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
	TAGGED_FROM(0.00)[bounces-285113-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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
 include/net/macsec.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index e0862ecd23f2..c3eefeef9526 100644
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
index d6136debe1c8..cf92f57733df 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -187,7 +187,7 @@ struct macsec_tx_sa {
 	refcount_t refcnt;
 	bool active;
 	struct macsec_tx_sa_stats __percpu *stats;
-	struct rcu_head rcu;
+	struct rcu_work destroy_work;
 };
 
 /**
-- 
2.39.3


