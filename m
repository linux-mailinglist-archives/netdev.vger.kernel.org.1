Return-Path: <netdev+bounces-221960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B9CB526D9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CB37AEA5C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D82236FD;
	Thu, 11 Sep 2025 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GSPELr8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558D1F4E59
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559991; cv=none; b=dyU8LusDQcQ4amM20r5aOAV3ihK1pHy+LHxrhZW1RX0pQRWdO1eoQCpxoizNiW8wEHgv2J9QrFLWqtFQUL8pLSNRJ1rZ3URUtIvNZy8ZmTPF5WCdtDwyC8OvuuRm3ifODxKHbZdwZvI2iLWD2iROQCCoRq1HXmSlG5v9PwHMHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559991; c=relaxed/simple;
	bh=8DFzfkHKc5XEPxKJzicwWs/kf4DUFEAYd22KhqaGWOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m+d5YUCVKHGfHyWReY43G+TZaPcMUaxvUZoVkceAMVHEcCHTj5GG6ikRqOsWr8EIQFuArSryiC1edCqCGpziUEmCTUNJniuV510lvySGgZiHkp+iAaVOjjpUCw7elGXHk10oltrHL/2jmb5CSn9iXVWf24CeniXr28R/mKytjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GSPELr8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32dc9827f5bso213688a91.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757559989; x=1758164789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1e8xoN/Shw7ju+/XH66nDT6pGsEPi5iRmCYeCVVsDE=;
        b=2GSPELr8KvaeiMzyXa7qmZs7M8YzLAKFs7XPQqFuSE/Ult2EBzR+ORiOl6fYNbScHY
         xJyldQ7p+EWV/4tJ2aY8xwmzyBGxcI/pG31Me3VhZlVjNBXaJ1n3SYT/WINvHoC1CrdK
         oFtJim2CqxwGLLaKUosJ7KemsDVd1rL7xXOy2YAIhxns9JwNuXrHTftLIMGJs86ogm9w
         AfniZgAcTAveVaSTcH/hNSNFg4/RQIRP3+5YeU5BetMvtF/T83e2QMPxKEIhEJw0AYtg
         G8w9H7D467BIZXkJgSeP1fAuMM87O/YXwzT7srkIOP2fyjbVxyRH4zY1mqgrIgiiPN/Y
         3WPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757559989; x=1758164789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1e8xoN/Shw7ju+/XH66nDT6pGsEPi5iRmCYeCVVsDE=;
        b=ZvPKqJBMhJ4AV/n5m9MSqk3txpxqWcePG5GYoX8vaTx2GMjrBP7CsE/p3x/HcfFgGb
         yszPH6m8cmnCDQJ6fJFJumKlZeH4FP0oTJHFPAsYA6ocF3meJbw/pLYoXtZFJE905ZLf
         h9XR5fDN7xBDsKqFoEM9noeSQmP1tJ+lEXnDgJ3t88bL0YQx/lH8yL9ezwZtsKK9YCeA
         UBJc/NNX22/3QkILCyxqFIGuAwfh0QqXAUUhe/Dd/B2QJ/x2mU6UXyx0s+yY0NS0nbRK
         j/OTx9bbcblp9/seGAzMAcOpAOtye4D9yRyTijBVZSosy8PdBjjd0ewu+wh32SKst+/D
         HPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS3uE3DT+SeFCrF84guqHguNRAfiJUqD34pVJrf6G2nNp++vj7TApoH27vigtjlKYWviGHomo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AY3tEdwMVkScGHLOwRQaCmVeJuE/18Jg0IM6o0ahEVuBGBv6
	tjKhiIHDb1XQslMZeuBPJn9iNx5HTflMcK1Ajfvo8NsXcF175A8L/menljTms0RnfBI7bnqkLcl
	mwaWp7w==
X-Google-Smtp-Source: AGHT+IH/8OtCm3T2ACLKn0vrFKryDHxfl08MgfaDcUOU2+uFjHGhpOGXUIi1TYioqn41bCjopo4lgdw/9TY=
X-Received: from pjboe14.prod.google.com ([2002:a17:90b:394e:b0:329:6ac4:ea2e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33cf:b0:32b:9774:d33d
 with SMTP id 98e67ed59e1d1-32d43f6658cmr23383129a91.20.1757559989446; Wed, 10
 Sep 2025 20:06:29 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:05:29 +0000
In-Reply-To: <20250911030620.1284754-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911030620.1284754-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/8] net: Add sk_dst_dev_rcu() and sk_dst_dev_get().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dst->dev is safe under RTNL or RCU.

syzbot demonstrated that an unsafe use of sk_dst_get()->dev
leads to use-after-free.

Let's add two helpers to fix such issues.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index fb13322a11fc..e1ae975c1920 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2157,6 +2157,25 @@ sk_dst_get(const struct sock *sk)
 	return dst;
 }
 
+static inline struct net_device *sk_dst_dev_rcu(const struct sock *sk)
+{
+	struct dst_entry *dst = __sk_dst_get(sk);
+
+	return dst ? dst_dev_rcu(dst) : NULL;
+}
+
+static inline struct net_device *sk_dst_dev_get(const struct sock *sk)
+{
+	struct net_device *dev;
+
+	rcu_read_lock();
+	dev = sk_dst_dev_rcu(sk);
+	dev_hold(dev);
+	rcu_read_unlock();
+
+	return dev;
+}
+
 static inline void __dst_negative_advice(struct sock *sk)
 {
 	struct dst_entry *dst = __sk_dst_get(sk);
-- 
2.51.0.384.g4c02a37b29-goog


