Return-Path: <netdev+bounces-221964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07799B526DD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA25A485EC5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE0216E32;
	Thu, 11 Sep 2025 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqnnEqMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915F1F4E59
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559997; cv=none; b=N7fjRkXhdnbfDJnj9FAYITceA9Jgznm1kTOsHLsqRvkXNV/BjccoGjAH2ouovVfDNjZoaNXfSAsVAATLpnIlvZhPk9HStdKzTdGiLa4azhSwwWYsq4jrQWsdyA7FK9mcmwxxASYf9AlcQpcX1VSkU5ViIeRUF18aZcrFTCRICCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559997; c=relaxed/simple;
	bh=ZprQ2DoltrYhWcJN7+3vX+bQ1FUdc4kBAxB6KHRV+Dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fVuld8HFRPskp7iYsq0a5syzDGnvbDTXC4qt2xAO9BdJCKaZW5iKWsJR+d7W6/EswpZ7nhcmy2ndQ3dDRnAGxKKj248ihEsnHXYSoX7Phg2t76z5IC/Q+UUm/8Y+tqtFTJuHkCwpIt0BbZc/p7cfVvLO9TnWvEucz0vJpdxSm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqnnEqMS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32dc9827f5bso213738a91.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757559995; x=1758164795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIhFqCyfogDVlU6hPPKdG/U/PvSbWFFz8KhfdaWVbk4=;
        b=wqnnEqMSOJKmEo4yCAwLGCVrgGtamwVAxjhW40txio3t4tTeBBC3qnnNd5CQnbjBWN
         35eLObqfGkLzFg4tGhtaRmsPJTg69wVkFGUJSqhWX/WpNIc7wnAmIZkbTa9lZ0L0XlDF
         6QGNIW9409LTZC9bWPcgq5XwW7QRhZKtG1DItZTWWSr/l6D5C2v1XxSsZaT3AL3YTTD+
         g8RRYp/yLig76etGrXLIl61lWC/I03fIkntBgtGI9NOHFlGdXZoQjZ9+UoZesSE2mQ07
         yIVzFZdr0YRddUsoq2REB1OFuVIoVmPdEylR9E12EHR7mWMYt3DfJf4TTfFc1egI2h4U
         W1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757559995; x=1758164795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIhFqCyfogDVlU6hPPKdG/U/PvSbWFFz8KhfdaWVbk4=;
        b=dIet/u2VHCrenk0/+whGY48z3YhUn5MHQLIN1hKlFFJHWj/tiqbRDhA/COR7RSNVrL
         JpABRGRXmZrbze20W+rsruaehxC90Lc3XLuuDzi4IOAt+oGpym0i0aLkCMnuqKYelzLw
         J0TM/YS21e1bJYHDY2IFE6konJ0iIisKg2k6XhNilqEuDmh0KMsRal9mMTl9oYY0kfJx
         /UYIqxILPfpOJkyO9v2/Ul3I9anxmooy2w1ZeHxJDc4vNls9GYkqoOit18Amr6jQafi7
         ubor5ZTRg1gZy5f7ZSDVBatMJdJgpuNTy5LhDezseBbdutqPheBR8YUkHkZOlAv6IkjQ
         fpLw==
X-Forwarded-Encrypted: i=1; AJvYcCVH/iyqiIwiRWuehitGoekGPQWY53tsoNlkBKA6IDsSBXDOvU0x8g/4RWqmQZHYRfHdxQP49qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Ia+km478aHdX12U1bo/yHjWciR7mbWP8rSm+bElnGZduq9b7
	DzA3CK43Vkq6al/LHsGzfBWMCutTjRffDLLCrIEZD4a6gtCD/lTw3O8Jv3wgfUJ/UB51/87nbaA
	px81nVA==
X-Google-Smtp-Source: AGHT+IEBLrMSYkoAt6ElqBcT6SL/ZkogiaputPTIo2agzCAT254bHYWmo5zYPvG0Dj3BnDFRLKnNZW4F/Dw=
X-Received: from pjbov3.prod.google.com ([2002:a17:90b:2583:b0:329:8c4b:3891])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1346:b0:329:8b65:25b5
 with SMTP id 98e67ed59e1d1-32d43f82408mr20949018a91.26.1757559995492; Wed, 10
 Sep 2025 20:06:35 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:05:33 +0000
In-Reply-To: <20250911030620.1284754-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911030620.1284754-6-kuniyu@google.com>
Subject: [PATCH v1 net 5/8] smc: Use sk_dst_dev_rcu() in smc_vlan_by_tcpsk().
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

smc_vlan_by_tcpsk() fetches sk_dst_get(sk)->dev before RTNL and
passes it to netdev_walk_all_lower_dev(), which is illegal.

Also, smc_vlan_by_tcpsk_walk() does not require RTNL at all.

Let's use sk_dst_dev_rcu() and netdev_walk_all_lower_dev_rcu().

Fixes: 0cfdd8f92cac ("smc: connection and link group creation")
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
 net/smc/smc_core.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 262746e304dd..feb61018ce66 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1883,35 +1883,30 @@ static int smc_vlan_by_tcpsk_walk(struct net_device *lower_dev,
 /* Determine vlan of internal TCP socket. */
 int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini)
 {
-	struct dst_entry *dst = sk_dst_get(clcsock->sk);
 	struct netdev_nested_priv priv;
 	struct net_device *ndev;
 	int rc = 0;
 
 	ini->vlan_id = 0;
-	if (!dst) {
-		rc = -ENOTCONN;
-		goto out;
-	}
-	if (!dst->dev) {
+
+	rcu_read_lock();
+
+	ndev = sk_dst_dev_rcu(clcsock->sk);
+	if (!ndev) {
 		rc = -ENODEV;
-		goto out_rel;
+		goto out;
 	}
 
-	ndev = dst->dev;
 	if (is_vlan_dev(ndev)) {
 		ini->vlan_id = vlan_dev_vlan_id(ndev);
-		goto out_rel;
+		goto out;
 	}
 
 	priv.data = (void *)&ini->vlan_id;
-	rtnl_lock();
-	netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
-	rtnl_unlock();
-
-out_rel:
-	dst_release(dst);
+	netdev_walk_all_lower_dev_rcu(ndev, smc_vlan_by_tcpsk_walk, &priv);
 out:
+	rcu_read_unlock();
+
 	return rc;
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


