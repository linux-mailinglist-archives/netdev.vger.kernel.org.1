Return-Path: <netdev+bounces-125462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40996D277
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB391C20C16
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528E1898F4;
	Thu,  5 Sep 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgkHV5nI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4B5256
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526153; cv=none; b=qW4kejzs+JEEnD3pUiURr4F6XQF0kTPvoK/zG9giy6+4PiA93Levqyv2s8//jDZU04drWlKTXWrm8v6x/SWmoTczGj+mPAs/yhb459utg1nmUqdIjumBOVxj8dhxqCUT5TvVp6JgC5QJIzK6S/9roekrmiaR12EHYtxkvEyWFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526153; c=relaxed/simple;
	bh=Y7qGo0VcnCXRUYmEqMuxrBe7puUCbfFeBEXQdH9WR0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Do84FBh3tEGJgGBJl43l/Dr8durLpvqSa+5FQvlvRl7MA3LxI9d7wCt60mqjKUxEKMUzYUdFZ47cIGy4tm2HoJlof2gJY4eenTmFXOq43KwRTcHUNpsYViCsNpGj8n5bAaWO1itxZLLgk+UD2hjw2VGnO03onl6Vxpd9K+hFohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PgkHV5nI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1ce191f74fso1345787276.2
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725526151; x=1726130951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4WQNEuN7hXg+n6b7FCHhgO1I+wbPSIM4i2h2aYso6ZI=;
        b=PgkHV5nI5zD6f4dwqknezd9dki6CbAONxB/adTv1gCjziAg38vxD2PQmVsVHZ86wb9
         kvI5hIO91sbsLVY2xJUVCiPEkW8hYZjz9MecsWyrc8J6V5lQMefkADm5iYVIqJUNHKve
         263QPhHgxKPDnc++xmGAM1gexO25ztGuczlQszzzMiOYUVIprZ83vD3adRvmXp5l29yL
         XbQ7cDUYWIjLpX7/bXHzoh9bxRleMeW0Znadidtjs9+Joe/oQrRMK/vHYR6ak3Iszedh
         CQNcXeO7GIE3+5R6yjkTVfrCFH4aca82GQoviolRSBSpuwbvqlDoHoMNfVgDcHK5pv4j
         VbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725526151; x=1726130951;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WQNEuN7hXg+n6b7FCHhgO1I+wbPSIM4i2h2aYso6ZI=;
        b=PoSun2FhnQdPoUDbcoCvbUTeZUBmXnUbi/lOCl9tNLXIpEQWgGTCiYTr+NLxnCLxbV
         K1io8hLwaVDX5RiaAtzm3NhlJxT+NNVrs3teJirS0V+0gislTv6NJkio9ggm/J6nDqig
         Emd1qKfMYDIA0WoQFb1+0L2AblDHXQoDvL67M+3pEocFDyJzgiAbtMFYfWDFrbNBEAjY
         aihqDVxdLS+uQp3gPaL6+IyveTNKDu7FPZGIn0nxYPbzxyFhbhkq86V7zSwwKp5wyaGx
         B8Moal2zWWZl/W3M7WE8FFcEm+n4itTUZHk7M6+5HN4SvCpv+MeJFlDOKSZ6n8ETVgGF
         hoCQ==
X-Gm-Message-State: AOJu0Yyz4zH1n1hRq8sARAFPiXDHV9tuXoAKF971GpRMT+SB+TugUFaO
	q0R547DlSt87DuXhX+OassM+K385k4LV72sAhPvoD+Q7ROUFcpmRUic2TKNywClF45wySIHsfzJ
	yeNo8vR0+bw==
X-Google-Smtp-Source: AGHT+IGEyEOKwX/xpHJ/c14+Ff+rA3HCfeXnAXIOKaomKonI3G8Vmfad5zZAkcsanwf5rGDEKeEKOr7UPg/8gw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ac4f:0:b0:e11:6a73:b0d with SMTP id
 3f1490d57ef6-e1d0ea4bbd6mr7446276.6.1725526150478; Thu, 05 Sep 2024 01:49:10
 -0700 (PDT)
Date: Thu,  5 Sep 2024 08:49:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905084909.2082486-1-edumazet@google.com>
Subject: [PATCH net-next] netpoll: remove netpoll_srcu
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"

netpoll_srcu is currently used from netpoll_poll_disable() and
__netpoll_cleanup()

Both functions run under RTNL, using netpoll_srcu adds confusion
and no additional protection.

Moreover the synchronize_srcu() call in __netpoll_cleanup() is
performed before clearing np->dev->npinfo, which violates RCU rules.

After this patch, netpoll_poll_disable() and netpoll_poll_enable()
simply use rtnl_dereference().

This saves a big chunk of memory (more than 192KB on platforms
with 512 cpus)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e0720ee6fa6206c44f996065f11261012da0fb6f..ca52cbe0f63cf6ae394da3cf1ed4cc7cd8a7254e 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -48,8 +48,6 @@
 
 static struct sk_buff_head skb_pool;
 
-DEFINE_STATIC_SRCU(netpoll_srcu);
-
 #define USEC_PER_POLL	50
 
 #define MAX_SKB_SIZE							\
@@ -220,23 +218,20 @@ EXPORT_SYMBOL(netpoll_poll_dev);
 void netpoll_poll_disable(struct net_device *dev)
 {
 	struct netpoll_info *ni;
-	int idx;
+
 	might_sleep();
-	idx = srcu_read_lock(&netpoll_srcu);
-	ni = srcu_dereference(dev->npinfo, &netpoll_srcu);
+	ni = rtnl_dereference(dev->npinfo);
 	if (ni)
 		down(&ni->dev_lock);
-	srcu_read_unlock(&netpoll_srcu, idx);
 }
 
 void netpoll_poll_enable(struct net_device *dev)
 {
 	struct netpoll_info *ni;
-	rcu_read_lock();
-	ni = rcu_dereference(dev->npinfo);
+
+	ni = rtnl_dereference(dev->npinfo);
 	if (ni)
 		up(&ni->dev_lock);
-	rcu_read_unlock();
 }
 
 static void refill_skbs(void)
@@ -829,8 +824,6 @@ void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
-	synchronize_srcu(&netpoll_srcu);
-
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
-- 
2.46.0.469.g59c65b2a67-goog


