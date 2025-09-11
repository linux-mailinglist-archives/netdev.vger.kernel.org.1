Return-Path: <netdev+bounces-221967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A356B526E0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2F21BC6B2C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F62D241CB6;
	Thu, 11 Sep 2025 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7h3S1gU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666422332E
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560002; cv=none; b=qxBd9DTtKZfbbsOOaXItkAWIovGlbg+a0NbgmdVvW7WCwEGFWc3F56DztXDStzpEHOmvaMnF7HL+o4imHU91mGqQFuxeI5Cntl5uK0+R7nK6o83hWH6/72A9O/U8blE6Mpt2IEceQB5uzqR9Og3umCnp4tZtt2nYi7IUMSd9/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560002; c=relaxed/simple;
	bh=9NKo0btnbUX4JBIgKfIVsLUJsd87DmM7PIQ+IFVwPfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Biax0NvtrbnXa6dDMhl+0a9z73YIRZD6bTmsOFVdBCDAEe766TtZ7Yw1kq/oEMBZeZu25IvCqY6fyKaql/e0mImcT4BBYVPAfayMbC1rNI6IIWeV7ydv2PeEemQAi2CDlLHZdn3Q3QdsOVY4Z7ZSDEIH4Wbg342eIvmMcGURTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7h3S1gU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4fa4be5063so239941a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757560000; x=1758164800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4v5UwXcVOcafG69vQUotus11zereAB0v020VAKH1Ks=;
        b=I7h3S1gUhTCGnMjqCAgRVQg4IMFdGAr+JdKGrvYhDM5X+tHNvEFhhQgjGdiH0wemn2
         Zc8fVcEFD2qpcLdDISJUNJY3uuZrL/FHbdAmBuNUIfcWbpjUkOv07jIING1HI1BuJz93
         pzlH08zofFiQL08y5vSh4/DthFWvcSlTmE9i+pdQxxbr3vWbz1YlpWZDs6vdgzqLWBCZ
         MhyyPpYZ4UYUGjvSBc8kA5RfQOjfp9o7Byx8mCuze7SDulMRY+6BexgBBZwjmYZbASwJ
         Xj5k5W+o0kJOO/vV0gTxDfbsSUO5ogfKkeUB2F3Cez0X32bnd7sjLSbQAkD55ng7E8KN
         zIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757560000; x=1758164800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4v5UwXcVOcafG69vQUotus11zereAB0v020VAKH1Ks=;
        b=Lxod2oatsuJFmbgRlYkYpQm7OgPuERfN2qLJyeir1VQQtYLF4sLYN/lSWC5vF39PNT
         TaZZuMymLYnnEyTOMPcg38jdbbl6LpPJaYyXI3HSTx028ldqs2iIu1HOPvI3pSDOaWqz
         68fALZBhGz4kLetJw7ooBWTNvwMfRQIOuIi+1p9r5PO5IqRmL1l2sbahLgVlEkXNHH/G
         VbCTTQF7U1MJVKKgNncrL6qLto7C9zxY/7vZ1nODsnI/rlkZqo+qHdmFElenBmdioWcq
         GGQlf8EBv1qpEDmc4GxyPsD8mTRKtIDDwZ5sYruu8jPWoQw6wRyrytplR7egEMUWViNR
         ya3A==
X-Forwarded-Encrypted: i=1; AJvYcCVqc7BQAqiGkVKVp6KXrUR3ro6mUUGnBzaG3ZYqDmlznKrQxtQDfIt9TOGNca933PM/bzLiWUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkaRY1AQSCwZg/bK86vsK3HMFJoTIxVki7cV7a3zMRtsHloO7
	BF9jfPetFk1nkTeTgQ4jkJ/jhZrwgDk+jrTu5YE3aPhAa7HMm4mCPXGI1OHOlMW9S1Bwl5CEl/f
	0i+MIOA==
X-Google-Smtp-Source: AGHT+IEG2Jife9+9rQUVk1RRX9YwLUb3x3v5dYvZWfFBT5gc8rM1L2ob74eM/ro1RANxcaih/RLVOg6KhaU=
X-Received: from plil5.prod.google.com ([2002:a17:903:17c5:b0:248:96be:d4d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68a:b0:24d:e8f5:13b2
 with SMTP id d9443c01a7336-2516ce60e56mr296037655ad.12.1757559999978; Wed, 10
 Sep 2025 20:06:39 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:05:36 +0000
In-Reply-To: <20250911030620.1284754-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911030620.1284754-9-kuniyu@google.com>
Subject: [PATCH v1 net 8/8] mptcp: Use sk_dst_dev_rcu() in mptcp_active_enable().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"

mptcp_active_enable() is called from subflow_finish_connect(),
which is icsk->icsk_af_ops->sk_rx_dst_set() and it's not always
under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Also, mptcp_active_enable() forgot dst_release().

Let's use sk_dst_dev_rcu().

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
---
 net/mptcp/ctrl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index fed40dae5583..f227415e8568 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -501,10 +501,13 @@ void mptcp_active_enable(struct sock *sk)
 	struct mptcp_pernet *pernet = mptcp_get_pernet(sock_net(sk));
 
 	if (atomic_read(&pernet->active_disable_times)) {
-		struct dst_entry *dst = sk_dst_get(sk);
+		struct net_device *dev;
 
-		if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))
+		rcu_read_lock();
+		dev = sk_dst_dev_rcu(sk);
+		if (dev && (dev->flags & IFF_LOOPBACK))
 			atomic_set(&pernet->active_disable_times, 0);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


