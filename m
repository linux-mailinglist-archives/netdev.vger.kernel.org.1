Return-Path: <netdev+bounces-200826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E038AAE70B1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EFB3A9F6A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8962EE5E9;
	Tue, 24 Jun 2025 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZeum7Mv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241D4C9F
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796800; cv=none; b=ZlrSem2zEjp/5iad/+DDxcGWPgDH8erdYjLEXsobAKf4cI7V03VJxYOflDNF0x4YKnZi+tvOgBf/hKAN2xvFgPN+x1xdBV33f0xuqmj+gp8qTb7+L75oCS+ka/FLF70mM7EGVC2vP11PP1vp28TIOso7gheHNyjvD1MENrXm1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796800; c=relaxed/simple;
	bh=st65MW2f5244kOaC3KoxRxKOhFO8rvIOWtMydbyv4g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkYSDL2ahbGR/N0ZIEb6Pa8W7GJDFV7Jq41SjCTP/O9UJojfzlnHKx1jXagcN9z2J2Nv7dkB/CdGEXcUhyJORTNSx/CP5wJX5cJZ1/bM+YciGpwuz2FVIVSMTavGKq6UV5TvqPTaQjN57ly1mEY0IQvnyNUVpjay8wKnozICwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZeum7Mv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748ece799bdso3828522b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796796; x=1751401596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIXEASeWNyKycbmG6zxeINKMmshF5fF04YLDHWXFaes=;
        b=HZeum7MvFCRSatYU/Bg+0zWALzYOmoFhOR6Rbkgg+GCKuEkl+G6D+rFCgp0fPFGtb/
         Krjx+4VwC1P7KRXv7Ds6Zuj0u6SUHZIlXhTmwmK2DhLbZcDCUB4Vf/7b9UFwOMNXS4Aj
         ikc+CpcVbfr8eneOmPenF+mD91+5C9pcpUS8SWfdLFaYEXzfhEaRiW+R/sdPacUf7Ffp
         CXHosONjwX0VxMwopmRiSLHMzNvf4/aP/46QFrwIIEc+8taMgEdQu7gugBZgTtjRctO/
         LddvyxUVtV1T4CJFuBNn2bMTwcY91BrbYNmf8QU5T5cxgAWEN0uYJhB/W1SGe1Dfkbku
         JpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796796; x=1751401596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIXEASeWNyKycbmG6zxeINKMmshF5fF04YLDHWXFaes=;
        b=sZzFQ59m6xHfcAghrgbq5WLRiLslQDpUi2G6tcgWo+a5+g+toHVt8mPad//RHAvxb0
         ir6IhhZTsfju5NETUnmnEjAeUTZWPHjf9ZEfsPm7pkFCjot8n+quXQhpjnqrOPtGo0T4
         wm8lYiSVT0hocTMF0nbE4QO1gMJ0SSilHLa5Xfpo2zk5Hv3JAqCNFva/86yqHFR+5YCs
         pth7YbtOTc+hF6GWnTo8uRx3Gv2ZTOZVvZhmhrLW0dAk5RJWN5RWDOJlsvFTHKP78mpr
         Jvg1yPZhvxEXPO0XZ+OsCsESLz1r+bt6eVgLbcPC2+5+5BGekxQCwz146X/oesRUxPjT
         cLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaPn3vVSpUahT660hQEXnSr1vOIt2apMzsfamryk8vaopb/yZFCWuBrLDZjWejuCv38XbSXFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XVNV2KOFrWJK6MzmG5VDnd9aGN3cJO7jZ70MpFHllVnniSr+
	sHe6fpjZ34uFL5VYlg/VTfyhfkw9o+Q1eN1qwRu1bu6oyQn8hfMXFanI/TgeclJav6qB
X-Gm-Gg: ASbGncsD8UiyS1FdYL7Ug3rDGhNp0P6EqyqZ7fxdzgjCN0jaeVMzNsK3Mbg8F6KgeGI
	m4jb38oqFP6EU5PCTTYHyHcnSP6vSaTWxp4q8l4FdNNK02FLEKpKSMZy5SYXFaiNo7DfxjPIPHZ
	JfYkZlDJ9gMUKwuzjjorWJ13/izQPcEy619ffh4gVp5sxQWAmvWMKNbtaGZZc6GbtIGJk8VpS2U
	kiK4wCzJYvrusq2miEzyuL24+c3KS3XlAefr/j5ZNI+FrDK21pFHHt3bLgUryvhBvHqLW7675Zj
	fuZ3091Ff7HzpLGU83e4fUAGoB+XTQmLOZNeWrs=
X-Google-Smtp-Source: AGHT+IHS7fKECDbP4y/2zpbGl8LkhmLizIv0D0K8R09+lWkLw7Zsy07kzzrBJF6jt72Zwuqshq3X6A==
X-Received: by 2002:a05:6a00:92a1:b0:730:9946:5973 with SMTP id d2e1a72fcca58-74ad443da00mr626628b3a.5.1750796795758;
        Tue, 24 Jun 2025 13:26:35 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:35 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 08/15] ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
Date: Tue, 24 Jun 2025 13:24:14 -0700
Message-ID: <20250624202616.526600-9-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

In __ipv6_sock_mc_close(), per-socket mld data is protected by lock_sock(),
and only __dev_get_by_index() and __in6_dev_get() require RTNL.

Let's call __ipv6_sock_mc_drop() and drop RTNL in ipv6_sock_mc_close().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/mcast.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index afa3ff092702..e47d3fd7f789 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -334,28 +334,10 @@ void __ipv6_sock_mc_close(struct sock *sk)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct ipv6_mc_socklist *mc_lst;
-	struct net *net = sock_net(sk);
-
-	ASSERT_RTNL();
 
 	while ((mc_lst = sock_dereference(np->ipv6_mc_list, sk)) != NULL) {
-		struct net_device *dev;
-
 		np->ipv6_mc_list = mc_lst->next;
-
-		dev = __dev_get_by_index(net, mc_lst->ifindex);
-		if (dev) {
-			struct inet6_dev *idev = __in6_dev_get(dev);
-
-			ip6_mc_leave_src(sk, mc_lst, idev);
-			if (idev)
-				__ipv6_dev_mc_dec(idev, &mc_lst->addr);
-		} else {
-			ip6_mc_leave_src(sk, mc_lst, NULL);
-		}
-
-		atomic_sub(sizeof(*mc_lst), &sk->sk_omem_alloc);
-		kfree_rcu(mc_lst, rcu);
+		__ipv6_sock_mc_drop(sk, mc_lst);
 	}
 }
 
@@ -366,11 +348,9 @@ void ipv6_sock_mc_close(struct sock *sk)
 	if (!rcu_access_pointer(np->ipv6_mc_list))
 		return;
 
-	rtnl_lock();
 	lock_sock(sk);
 	__ipv6_sock_mc_close(sk);
 	release_sock(sk);
-	rtnl_unlock();
 }
 
 int ip6_mc_source(int add, int omode, struct sock *sk,
-- 
2.49.0


