Return-Path: <netdev+bounces-203105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723DAF0841
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE711C01113
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C019CC11;
	Wed,  2 Jul 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrqKX7tW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112E28691
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421886; cv=none; b=tecwuHbDXgJpMCVBwvkgTdaYZPs56yrDyo/dEEtiz13+hcBWxB3RL4PLt1xrQxuUVZzQMjDFBYdBB2uM76+w6DY5x6ugc/d6h1e2+CkAIS5OaHVuV5vvPzEaEF7C7vnXtF33fghzVZpA2EhHGkfELZ0SShLo5/2OgPjnivZKvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421886; c=relaxed/simple;
	bh=sSWplzMoPgFolfi8P57r1kHflhAlExwNFq5yOVqobjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vFrPr4LtQuHutB+/V64paa+dRi5iSvPj2GhGgnJ7PuvurO2n9h8nMCJLT9WZ5XSvS2yTqD9ENCmk+AMq1rFwjuwJnFwxVFQDfLMxs4C9BKVX/XThYXTdU8MOMtWwXZXXz3Wbw5kSAV+NvuOx9xNGdjN8W0wIrAXDdyFEcNas0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrqKX7tW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234f1acc707so30333315ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 19:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751421884; x=1752026684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d19bk1GsiF+CXUbm8KWra/DzxukqJQ72hUNlC7fylpg=;
        b=VrqKX7tWHt49iUQjV7qRP8VRzZbY6NdeKbE1yXaydU9GaauhGPbFuiEUT58Pu0vFpO
         Gh+8p7gQkGyiC3NkSaLH6/vV/tRAhMCvgPT/zpxFW7n/72im2XbtWfu6W3AxJPGKfycP
         jaqokq16Upf8Ae/Nugew7XCkr0OxF/v8EXBTWupEmFllSu+uKQSZBF1CVp5seE4rxais
         o7oRHuuaAJwveyVQzEly8YutEZYnaX1pd97xd13JIDHIhznFV4T/hNvN3ENE3pC35KA0
         6/PfhdqUllItzMULgu/sLuhY9cTr2V2BxwBfH1zX0O/EibnJ2B3yfq29LjkF3j+MxqpU
         g3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751421884; x=1752026684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d19bk1GsiF+CXUbm8KWra/DzxukqJQ72hUNlC7fylpg=;
        b=ovAdevvdZBm6cXz3PriFVGwbXfooCH/dy7P/U6HfCLJzEjYDe1NdGuLdPt5qvXhMXV
         nY/UiP7EztgIUvG0jSnkaJoOvQ823YmHOKmns0UlGMYyqGHlGkFTwxuiRZ8joiSg2izE
         awoyfPU+OFnN226mYTMg/FG5+i8WR9ZAQqHAUrHYIvm7MMlYcF8nzjclmImySVq9kWFT
         gobtEG1CTPeMOCwSY9PBvrrqYCNyCDcY21vuVwU9r5NmEYY2ZPzl+sqzaw4awy5Rav0a
         PjHA4scQS+XBlfCP3PwFo8wzoEQESvRrAkeT0MG0guqj20d3gvgtHWz0k1hI2DvPiBk7
         0d+w==
X-Forwarded-Encrypted: i=1; AJvYcCXmks74ZmViNd3Kao5CtzX31L9dnjgldh6mT5JC21Zz5ZI4dLeNPGQeSVi241VjAxeUSsO6N5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1Zg9sP5J1V9VPfyLV3WFLVIIqP0qw0QRe++4UKF8HO1WyGUP
	IoZd2xjqI1Polp6wBMPi7F3il8WTz9j1Gey7qVkKzaXADF7y8h+V/TyFGSZuSXvzn6kT6sTYAbX
	ZDZkGNw==
X-Google-Smtp-Source: AGHT+IHTleCO8G/kvfIrB4MIdDqpq/NAB6Bjv6jLWMKR4R2E/MiYt4+ora2KQF8Kp2VIgOXVmbikEG4SYB8=
X-Received: from pgc1.prod.google.com ([2002:a05:6a02:2f81:b0:b2c:3d70:9c1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70b:b0:234:b430:cea7
 with SMTP id d9443c01a7336-23c6e51015fmr13832775ad.22.1751421884266; Tue, 01
 Jul 2025 19:04:44 -0700 (PDT)
Date: Wed,  2 Jul 2025 02:04:08 +0000
In-Reply-To: <20250702020437.703698-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702020437.703698-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702020437.703698-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] atm: clip: Fix potential null-ptr-deref in to_atmarpd().
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
 net/atm/clip.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index 250b3c7f4305..84d527a9398b 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -46,6 +46,7 @@
 
 static struct net_device *clip_devs;
 static struct atm_vcc *atmarpd;
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
@@ -609,10 +621,12 @@ static void atmarpd_close(struct atm_vcc *vcc)
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
@@ -633,15 +647,15 @@ static struct atm_dev atmarpd_dev = {
 
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
@@ -650,7 +664,7 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
 	vcc->push = NULL;
 	vcc->pop = NULL; /* crash */
 	vcc->push_oam = NULL; /* crash */
-	rtnl_unlock();
+	mutex_unlock(&atmarpd_lock);
 	return 0;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


