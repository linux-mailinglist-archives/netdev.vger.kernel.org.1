Return-Path: <netdev+bounces-223747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13855B5A43B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41842A0262
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2D7307ACC;
	Tue, 16 Sep 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xqneV3gB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420E323F66
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059291; cv=none; b=Lvvls+FV5FVF3jOtiQPUK14/diMC0PX2mTGzd8LAnizwP++DXQGpd6ceH/YPwDV/gwpcRAs95OrnDdZzl7RfRr0XvW0CCNAXz6QipfrqX7cjecoG4babALWmEJhCauzL1XFrGymErR2jFMfk4CafHs1MmzrCOQ9uhOT2JT39M+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059291; c=relaxed/simple;
	bh=ISUTxH3KBRJ/hLAqxxtiCXziqQaSY+AFoZXRVI9fx7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TqBznfHtdg0QHf6RWuNLdpl0IZst8kOYrMDTBP0kSCCLOMDOC8YSWZeZT7OklSpsnHiQw/KXjmrXthIWmV2pvUYzo80wv4jSHqXanZeenQBXqYFWVQBr+nxsyK6Lht3hmdmYGnYzB8/boOtRRMUEqLyQlBPZhR9rjCjSZYmXL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xqneV3gB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c72281674so4181313a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059289; x=1758664089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLnJ00CGYCau3TqDaF4rwQzqPipVMF4v1bzsVsUM2dQ=;
        b=xqneV3gBqD+/ZRZO6rjW7uXIhNmUiId5/Z4MX6en4yP2lCFNsao5/ah1apUE0XrZpU
         RA4H2qC+hScjXeYLmZbcjjkfAgK8P/rXDWCfNtFgjbnLn7Mztr+pHe+4CrBiNBHh50RJ
         CYpiI/db2wEjbaLuiEHEIJDYffoa9C7mA/PucxH0sSf2K7gtNTQ00mXwSxawtuv/KpyK
         AF/qdmbPl/xKWxkAqiDip4zdebLdHZGeDipscKdClCOnBih7w6k8hZryVePtbGGRVf1t
         yps9vEG4XgHLuS1JzXZuJBMu/nT5RGF7eQeufIHWiAAr+aU/TZr9WTta2tOwWD4fOZCo
         O3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059289; x=1758664089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLnJ00CGYCau3TqDaF4rwQzqPipVMF4v1bzsVsUM2dQ=;
        b=ISnVcl97AI6asYh+r+/7uEv68IfsKCUZVVlmheDGoD6Y9KAC12XsZSETw0JFNsW+Ll
         rCc5zQybv4D+LPxzPcYDao1hNyBpsvoV0eJDYwDoXEnJoTfrbt2N6sG+4ufDEW1BpiN2
         kIlPQuEacZ5p7nuYpqsYAhAIDPs9EXZw9iDLm6fQo3uV2jdZEhkpY0LcoysUCDT8A83t
         E+JzIOLt3kTMNw4bWnf4edOg2qNhHb65Hc4X9v6K4DFM3xW6i6hzOx2iLVAJ6XaCAUgU
         vPKrzK1vXeFxTotb18aF67VI7HkBMFk+aHpjXyRQC2sGi0LPCEV+SUpatR/B8WSlhXYM
         OLrw==
X-Forwarded-Encrypted: i=1; AJvYcCVAl8UKE+tB0VHhoX4ZEY2+ptYwv/NJxi4Lrk+mxFvWDAIzvkH64lDQrj4AnG6XXhxZxXr3nWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrPkverdL70tXsW4ImM6Kr1Kir/NbNICPEIe41M363BQcsoMH
	qf1aUBjhO5/wm/RLfmu6WsMeJgwdDnLW0Pz6aXdtr5B8Y80QO0tfYUUWJPyCXbuzz2q3DuTrl9m
	pWiJfMw==
X-Google-Smtp-Source: AGHT+IETalBQzyzEHtrECjU84UXFiZy1fQvu0C9Em3QvGr1R8DFPOBE5DbW4kOpq3tPQXcffqfIQilh2rXI=
X-Received: from plmm2.prod.google.com ([2002:a17:902:c442:b0:268:cfa:6a80])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:384f:b0:248:a642:eec6
 with SMTP id d9443c01a7336-25d26e498d3mr211110615ad.50.1758059288853; Tue, 16
 Sep 2025 14:48:08 -0700 (PDT)
Date: Tue, 16 Sep 2025 21:47:22 +0000
In-Reply-To: <20250916214758.650211-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916214758.650211-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 4/7] smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().
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

Let's use __sk_dst_get(), dst_dev_rcu(), and
netdev_walk_all_lower_dev_rcu().

Note that the returned value of smc_vlan_by_tcpsk() is not used
in the caller.

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
 net/smc/smc_core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 262746e304dd..2a559a98541c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1883,35 +1883,32 @@ static int smc_vlan_by_tcpsk_walk(struct net_device *lower_dev,
 /* Determine vlan of internal TCP socket. */
 int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini)
 {
-	struct dst_entry *dst = sk_dst_get(clcsock->sk);
 	struct netdev_nested_priv priv;
 	struct net_device *ndev;
+	struct dst_entry *dst;
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
+	dst = __sk_dst_get(clcsock->sk);
+	ndev = dst ? dst_dev_rcu(dst) : NULL;
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


