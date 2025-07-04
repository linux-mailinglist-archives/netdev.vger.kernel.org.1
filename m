Return-Path: <netdev+bounces-204027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A8AF87EE
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA71CA0995
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ECD248888;
	Fri,  4 Jul 2025 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WaBAC262"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD923F294
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610263; cv=none; b=WpF3C9aUCppVBuDFDryC4i6MMEAM6UEvcn9Q/+54V7uUx2l5Ju0EyKpn3RdfjFNoBSkDIVHomXZLyt8ySOp/MCyrZePPRSwqsieooHZdGqVspN5XcqdtHVy4iM8nzJSd2ilws4jYT0yudnopqKYTOCnw2t9k69x1INB/HPEuX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610263; c=relaxed/simple;
	bh=nprdym8lnYoH6QS/gcxr52cNShMgrqvenQAwOHo0SCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxBIdRvFnqAorAmstla+GdJxZHjX8fd9AURkLIQa+X1od7CnLb49/UfmcYs3XJuGsnYs/37J/X4F8ld1Dyjt0n9L8jON+sdPPLRZVZFKPotnItpOVRpeNJ9RA7MlWu1Peh1vFXzTsmoohGMzNoovkwOsYaGbi+PTcx7LEE69uRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WaBAC262; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b38ec062983so394202a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610261; x=1752215061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tX0ODlfuBNpxt93nlHPh8FzvoEvHjCTM2F+x6GEnUxw=;
        b=WaBAC262za9cQPBA5nv58IUrzbURTX7e45uG73I87/btRoFeTPwaDtitFkDVb14Kct
         /WcAhvawiXwQgxHrXxrj5tUz29SEV+WLF2lSEZStpWVM1+MnaUGcXuyVVU5DIN0Jtpqz
         jPk30ulpj/FgwvDYsWKdRMAOYRjuUUMaOC6aLYC/TRJnUwRrbPxT2JT4N5jV6qGV08Zd
         2Iv7hvnm8coWg29iJZJLSxxdvF/YJUE48j5t0ck7iMRfBAISMvr/3IyA6QxbSCYdEd/K
         qhifJbnVz/95N8kakCS1XhyOZ3oAOhQ8rfjDQvvSXUM2tPTx7QcBsax+RcmGOCoQSh58
         BGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610261; x=1752215061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tX0ODlfuBNpxt93nlHPh8FzvoEvHjCTM2F+x6GEnUxw=;
        b=tIQQtAXuZydl43t9xi/nMgdrwJPtiV5bfMDDdIvw06leP0X4jGxtHfRB/4B4wyhcsT
         4eLUgs9ZGH1Ri9AYDvEVw4XXu2mQ92SFGKcFpXjOL1U70NtExioQCtgsz8/fpPtoLpxo
         MLUYGkrwnv/TCTA6vla6Ue+38r2b+Hpbrx3kUBwCrYxQoqPIPs1gpFKwmuUNSHb/nXQd
         Ln9/WEiurQVU98zGY9d1ZXVB9p0e+o5bZdA166xuMnyxmi2pbm7HpGywtcXuKGrMH6DN
         6dV+AbX5d13xjrEwVPbKW83OztxpVkbJw1T1yOQ43AHLxCwhjjlNoiZxBBrfulQZGq3F
         T4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdnvfuT3rwWl0gyxn6yJaRQsbYopJYOgwFtYLi2kWFZT5nt12y+41ynXbS18ol9XCNPco+apY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9pursayT8YWv/UnKNn6086GzdYXwgSZaWDh+c6UoYEPmLGDF
	TxSA2OlnpLWjHuJ+EsEqf+pXCJXEYeCu9nJbBxtIBVX0mAbrs0gaU2zQHe9eCIN/xgUsjHP0iss
	IlFHghg==
X-Google-Smtp-Source: AGHT+IG6HVGtfCh7vUQ9W+yVO8kfgTsnCjCP7RkYl4DIu40pOjDvSp9GAXeZV1Nk1ftNNkUiHdw5oKOvVVI=
X-Received: from pgah2.prod.google.com ([2002:a05:6a02:4e82:b0:b31:ebae:e100])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:62c3:b0:220:631c:e090
 with SMTP id adf61e73a8af0-225bb8e921cmr2567963637.0.1751610260858; Thu, 03
 Jul 2025 23:24:20 -0700 (PDT)
Date: Fri,  4 Jul 2025 06:23:51 +0000
In-Reply-To: <20250704062416.1613927-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704062416.1613927-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704062416.1613927-2-kuniyu@google.com>
Subject: [PATCH v2 net 1/3] atm: clip: Fix potential null-ptr-deref in to_atmarpd().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

atmarpd is protected by RTNL since commit f3a0592b37b8 ("[ATM]: clip
causes unregister hang").

However, it is not enough because to_atmarpd() is called without RTNL,
especially clip_neigh_solicit() / neigh_ops->solicit() is unsleepable.

Also, there is no RTNL dependency around atmarpd.

Let's use a private mutex and RCU to protect access to atmarpd in
to_atmarpd().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Add __rcu to silence Sparse
---
 net/atm/clip.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index b234dc3bcb0d..f36f2c7d8714 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -45,7 +45,8 @@
 #include <net/atmclip.h>
 
 static struct net_device *clip_devs;
-static struct atm_vcc *atmarpd;
+static struct atm_vcc __rcu *atmarpd;
+static DEFINE_MUTEX(atmarpd_lock);
 static struct timer_list idle_timer;
 static const struct neigh_ops clip_neigh_ops;
 
@@ -53,24 +54,35 @@ static int to_atmarpd(enum atmarp_ctrl_type type, int itf, __be32 ip)
 {
 	struct sock *sk;
 	struct atmarp_ctrl *ctrl;
+	struct atm_vcc *vcc;
 	struct sk_buff *skb;
+	int err = 0;
 
 	pr_debug("(%d)\n", type);
-	if (!atmarpd)
-		return -EUNATCH;
+
+	rcu_read_lock();
+	vcc = rcu_dereference(atmarpd);
+	if (!vcc) {
+		err = -EUNATCH;
+		goto unlock;
+	}
 	skb = alloc_skb(sizeof(struct atmarp_ctrl), GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
+	if (!skb) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 	ctrl = skb_put(skb, sizeof(struct atmarp_ctrl));
 	ctrl->type = type;
 	ctrl->itf_num = itf;
 	ctrl->ip = ip;
-	atm_force_charge(atmarpd, skb->truesize);
+	atm_force_charge(vcc, skb->truesize);
 
-	sk = sk_atm(atmarpd);
+	sk = sk_atm(vcc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk);
-	return 0;
+unlock:
+	rcu_read_unlock();
+	return err;
 }
 
 static void link_vcc(struct clip_vcc *clip_vcc, struct atmarp_entry *entry)
@@ -607,10 +619,12 @@ static void atmarpd_close(struct atm_vcc *vcc)
 {
 	pr_debug("\n");
 
-	rtnl_lock();
-	atmarpd = NULL;
+	mutex_lock(&atmarpd_lock);
+	RCU_INIT_POINTER(atmarpd, NULL);
+	mutex_unlock(&atmarpd_lock);
+
+	synchronize_rcu();
 	skb_queue_purge(&sk_atm(vcc)->sk_receive_queue);
-	rtnl_unlock();
 
 	pr_debug("(done)\n");
 	module_put(THIS_MODULE);
@@ -631,15 +645,15 @@ static struct atm_dev atmarpd_dev = {
 
 static int atm_init_atmarp(struct atm_vcc *vcc)
 {
-	rtnl_lock();
+	mutex_lock(&atmarpd_lock);
 	if (atmarpd) {
-		rtnl_unlock();
+		mutex_unlock(&atmarpd_lock);
 		return -EADDRINUSE;
 	}
 
 	mod_timer(&idle_timer, jiffies + CLIP_CHECK_INTERVAL * HZ);
 
-	atmarpd = vcc;
+	rcu_assign_pointer(atmarpd, vcc);
 	set_bit(ATM_VF_META, &vcc->flags);
 	set_bit(ATM_VF_READY, &vcc->flags);
 	    /* allow replies and avoid getting closed if signaling dies */
@@ -648,7 +662,7 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
 	vcc->push = NULL;
 	vcc->pop = NULL; /* crash */
 	vcc->push_oam = NULL; /* crash */
-	rtnl_unlock();
+	mutex_unlock(&atmarpd_lock);
 	return 0;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


