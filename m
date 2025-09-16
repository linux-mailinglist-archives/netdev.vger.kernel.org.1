Return-Path: <netdev+bounces-223750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E34B5A43E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAF852470A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB131E0FD;
	Tue, 16 Sep 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqNxm9Kb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDE31FECA
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059298; cv=none; b=dkvcRm8RrMFXw1z8Un0nmTAvN7gGYYNjgElfgGcCaJvwxC1+CcctlLAWH9o3plG7D2LisjU8j+rNhVog8uvLyq8fWjIQHMjOUnYQuoKO3yIVOqbSdEN6PyFCMS5JISuuGUNzbUMEjQBHJS4V+uaME7V+MTU6VmiuGvfkLhGZdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059298; c=relaxed/simple;
	bh=YSSulxDP6s1Wrz4iDsg9JsJkoY2Nm053uEUy1N4tYtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnmgZfD/85NoJR8XOoQaXECSGoLSMDwmtGcISR2G7G1kNBqlT+34Fz3rcEZIN3Vtcksh8Q1ObXX2ObxWh1vz3K5eM1bSdWoq/9fjEg+KeSiclUAZYGP4Gf4ZUl+lc5O0a4/aOuPI8r/Cl/b2f5Gk8xDqrD+IeyN+f/qJCCLigO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqNxm9Kb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4e796ad413so7579649a12.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059293; x=1758664093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYA3HnzQOBu6R3F9r2KwX8kmxhTDpMCfN49huqtLQ6Q=;
        b=iqNxm9Kbeug5G+sC+2ST5ZpDXpfBMsabDg90ZUGnW6sA4BIiMkQLvRoNzd3ukkT27a
         vvyaHjANDZT6CsJSZEMsFJIvX644SF1oGLFa46cIO6iXOTi+Buk79mPxG0wGWf7UBa54
         7Nb2ERPDam5fwbOi0iYSafQyiT2lN6DFBMt2RvRP6sNm24FtTn//rNfGKeBBOZrNKrVt
         DwePnGh0/7OS8c/We0swV2gerPrzan5fm5R/aAmT6YCfzoA9q1VfHXiU1iTKwJJ4JRBf
         3Upwex5PBCysgjdGJTcHh4hfaAc3dp37kwZTfQCDODzm3DaNs2cYOXDJMIM67CbEcnme
         99iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059293; x=1758664093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYA3HnzQOBu6R3F9r2KwX8kmxhTDpMCfN49huqtLQ6Q=;
        b=qzldlFpvXfV1rZZeM47/Zx7oooq0HJCOQuGmJVqG3nITKO9gJOmx4TeZBqgIkgIyYq
         QRKTzD9H3j8WpL1EtqmkYbxlJ2t/riUJ8p9B8v+MG+4k+//8NJVROyGtQ8w1oBfa6c82
         A9NFJsPwpcxTAgNywZJatrLBIiGKDJ5iGgYdCpRFQOisD7gCPwfJWW4cIZOr8zqx08DO
         lhQ4tI90kaGLBL6VtbiZxUS81hZbPBb1z+l4oHsFABcbtX/DTAl4hgjSnQmW1YU5KHJd
         ENY7Tk4xCzPQcOAxZ+W2yel8RT9aEPtc0RiVw1WaaqaH+PSb4PH9Xey+yIoF2YFcVunU
         Zhow==
X-Forwarded-Encrypted: i=1; AJvYcCX/YRM69FCBKSsKCJM+A2FSKY1BFtOn0xulgsJcd88YtHkI6Tmksqkb68A2d/WpfZxj35GzyXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMqUaH6rXijYC/HbaigcHgEUr4iiVCVeF6v86cHKlqdf//N5S
	61RuxXriafFn4snlIYvG7shC5w/m2UFyJzrpTv0W+66p/ZaDy1oOHULV2R2xbcy3lXXbhMusy37
	wqOKsLQ==
X-Google-Smtp-Source: AGHT+IGCiZRhStZbsGgcBUZOeZjjNRqlhkYFi3NqH85Hc/hM8KYu2P/kGQ1wV5UKozmiFv1pHaBoJ8aCzb0=
X-Received: from pgq3.prod.google.com ([2002:a63:1043:0:b0:b52:3192:18e1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1584:b0:245:5765:dd5b
 with SMTP id adf61e73a8af0-2602ac8422fmr23954327637.25.1758059293325; Tue, 16
 Sep 2025 14:48:13 -0700 (PDT)
Date: Tue, 16 Sep 2025 21:47:25 +0000
In-Reply-To: <20250916214758.650211-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916214758.650211-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 7/7] mptcp: Use __sk_dst_get() and dst_dev_rcu()
 in mptcp_active_enable().
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

Let's use __sk_dst_get() and dst_dev_rcu().

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
---
 net/mptcp/ctrl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index c0e516872b4b..e8ffa62ec183 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -501,12 +501,15 @@ void mptcp_active_enable(struct sock *sk)
 	struct mptcp_pernet *pernet = mptcp_get_pernet(sock_net(sk));
 
 	if (atomic_read(&pernet->active_disable_times)) {
-		struct dst_entry *dst = sk_dst_get(sk);
+		struct net_device *dev;
+		struct dst_entry *dst;
 
-		if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))
+		rcu_read_lock();
+		dst = __sk_dst_get(sk);
+		dev = dst ? dst_dev_rcu(dst) : NULL;
+		if (dev && (dev->flags & IFF_LOOPBACK))
 			atomic_set(&pernet->active_disable_times, 0);
-
-		dst_release(dst);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


