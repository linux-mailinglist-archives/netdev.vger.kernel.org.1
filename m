Return-Path: <netdev+bounces-221963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818CBB526DC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C94461562
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335BA23372C;
	Thu, 11 Sep 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHbgZh7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F871C84DC
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559996; cv=none; b=Xh2gwUdsLDUJSRQsCCmbg2gu7dl2G75ezhVFNpjORB/RR1wBjXCDnswPX9c/nped+w1eOCj4zL2aL+2dsYutrBA7xxRnLGShcPz3qQz1TVas6IHnoLRqLslXHUIPq77K8xE8wlGPAc4QhElVQuhpEv+/4u5C+9CbsOeEd4mwybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559996; c=relaxed/simple;
	bh=/+jZZrJisJVf6mHWDTTyHy2YACvXsEGwv00noi5wbNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PXDyZItz7/qhq+NDYXSlo34MMduWDLr3lEgcOOzazSaa45z+0oB2rj72QEseViOqCwbVvldWrcNWx85C8Lpe7g+uSly3pLl03iPUKebNMEM9Ju0J7xyz902hmRNy3W2O91HeFO4TBqW1ONqpTDvIAk6D4wQ3M2YEUwgI6pljNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHbgZh7Q; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32da5dbbe9fso193250a91.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757559994; x=1758164794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dDxQ57rfNho4NFy7YMYXRh80GgPUKgKc5SizBXF7T+g=;
        b=rHbgZh7Q7MHUGHcgScddDHPS17bPqDYpwXlvBlervnfiRhmrmdVSoHI2l8oxU0lRIT
         2vB8R4wnEWjyKGNXO5IveLRh+E3D6aCxQUKpdlT7vzPgf2JQcQ/MED1Zh3JGTBhI8wSU
         8sIl23IhS37zNIYYutXQBo7RAjdjwrBLSVTjGf/B+EwxauG72Srw3EDQ4hGbUTwucdUL
         BvTz4ydOisu/ulkK50gWTwgXv4qoLcecZ6JLgiL/VSZvmyGVG7ivSbwUpzMpItCkM84N
         YFcAl0LkKG3q0qfl7cDzyzrctGyafYt6s/iHqQDk4JoHc+I/BljT6w+qszxE6la2qV+D
         kEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757559994; x=1758164794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDxQ57rfNho4NFy7YMYXRh80GgPUKgKc5SizBXF7T+g=;
        b=Srtgih65RSLVbs8RBnuFrVXXK/Y+NPfrWrxANVI9WwxvY18q7OnQVYlfayRNjDR5Dy
         VNafoguVqdrxWZEulAxuA0hquZCQoyoK9LjosS+o1NoMIfx/RA+8na4cPaTHuTKmhF/y
         w2dTjEQEF88wDFtHvQLkJd21ZvA+9FQOmgv91p1m4U4nHW0J6bMtADkkVjUX/JC8OcIz
         zK1H9zN323SWPCSMdQBa70xLrRhsjyo2GoKKtYUCaUiox0iw4MyhNCTAOlOicAJ5bULM
         x7HAFPt9MjNAgwVD8528m+3qq94L1l0FrVaBVIgxJEAWEMLOvAh0ccNNbdzDmSOYbycX
         KvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYkqFuGDWXh03ctx7XENdokNIVcdBHhPbDJM69YVUDIgge7ZmGrtl4ecZ4jYkAsuVgbKuAiJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzThzsghF5GFi4HUgvza4UVuWe/z5oo2W4FvfQHA9HjkMzjzG
	YyKqWKl4YrBmDw+LMj9y3ONdQAOJtyjUTIdnFJU9rp/rU4sItTs6sXQJN1BSqeHePZHzhuXJxzb
	W4YotiQ==
X-Google-Smtp-Source: AGHT+IGl3u7Kb+uDfU6ZgM9Zwij1GTkZ4XQI4EXiBY2ryOguIPsAwBCTcKC101f4y4bembKJxS2PBppILN4=
X-Received: from pjqq14.prod.google.com ([2002:a17:90b:584e:b0:327:dcfb:4ee1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cca:b0:32b:98af:6f9c
 with SMTP id 98e67ed59e1d1-32d43fb7075mr18984333a91.25.1757559993944; Wed, 10
 Sep 2025 20:06:33 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:05:32 +0000
In-Reply-To: <20250911030620.1284754-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911030620.1284754-5-kuniyu@google.com>
Subject: [PATCH v1 net 4/8] smc: Use sk_dst_dev_rcu() in smc_clc_prfx_match().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

smc_clc_prfx_match() is called from smc_listen_work() and
not under RCU nor RTNL.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use sk_dst_dev_rcu().

Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>
Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_clc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 9aa1d75d3079..5b4fe2c22879 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -655,26 +655,24 @@ static int smc_clc_prfx_match6_rcu(struct net_device *dev,
 int smc_clc_prfx_match(struct socket *clcsock,
 		       struct smc_clc_msg_proposal_prefix *prop)
 {
-	struct dst_entry *dst = sk_dst_get(clcsock->sk);
+	struct net_device *dev;
 	int rc;
 
-	if (!dst) {
-		rc = -ENOTCONN;
-		goto out;
-	}
-	if (!dst->dev) {
+	rcu_read_lock();
+
+	dev = sk_dst_dev_rcu(clcsock->sk);
+	if (!dev) {
 		rc = -ENODEV;
-		goto out_rel;
+		goto out;
 	}
-	rcu_read_lock();
+
 	if (!prop->ipv6_prefixes_cnt)
-		rc = smc_clc_prfx_match4_rcu(dst->dev, prop);
+		rc = smc_clc_prfx_match4_rcu(dev, prop);
 	else
-		rc = smc_clc_prfx_match6_rcu(dst->dev, prop);
-	rcu_read_unlock();
-out_rel:
-	dst_release(dst);
+		rc = smc_clc_prfx_match6_rcu(dev, prop);
 out:
+	rcu_read_unlock();
+
 	return rc;
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


