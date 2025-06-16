Return-Path: <netdev+bounces-198339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55674ADBDBB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326677A5FEC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5123B60B;
	Mon, 16 Jun 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfQZRQsI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25523B603
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116897; cv=none; b=fh3CdZiLxZmSOxoymY/onxxH3ZopyATRAdRPb7evhrhBcYfQt7L+nxsxOtdfK5TJKQQsmPJXdM5Vran2jtyZVdn3LDfNg7K/EDSZqR96nC1JQzxu5uONV+Xi3vOFJ6ApNI2KWq9Bw04IIADg28uIYuT97Hgy1M2ue8xvg/VF1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116897; c=relaxed/simple;
	bh=JFCHDMKIc5RQ9pu1EdhuXWBO0LqrsSVgqwZ93qT4wRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNWocUTx9iy/STL5XVYNBKOuLnOowMF9Ennaze1L1jx3X6E1TNqhl9zQ76uj9geQivpoVTsI3M6klOICcj4D8d1DynQxKdeCR13Y8roDupBlwgsBLwEEJBbKjG7/nZXcYesWaP/IoPZQIvvYKAlth9LjR1+w5JkCwu/npw0OUSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfQZRQsI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235ea292956so45715065ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116895; x=1750721695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX3cOIeN5Vy9hs5Qq7dGvJEVHWHjACWjbA9GEWYacbo=;
        b=dfQZRQsI4wYuj5V/dzGuea4BrpEmKcljeOBWBeFKnCXQ4SwbB2loFOas0qf+7aWiC4
         5DZgoHFdFvShEcr70hJhZDBn0xB3OGhWhO1ZHUJfHKBO/MBt7QFVU+2CAfVV88L7gsDY
         VngNGA8GXKttVfZXJ/O6lCEufSbjDKpeKBMbguMA2iovUKYvqtIAFHXfSliSVy63Mp7S
         TOWdb992jHRtHnUvi0j0trZcS7vEInWha4+979Cc8zvwPpRJrCcU+odwgL+peuJx/NBF
         JhmXR1acrETR/zcbxS/72PNzFo17xx6XWdeP/NTMMBcre9LAdQVoDX3Y3HN+SbuvVS8E
         vGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116895; x=1750721695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX3cOIeN5Vy9hs5Qq7dGvJEVHWHjACWjbA9GEWYacbo=;
        b=UjgJ5z/bH9G8IV6F5LasLY8RaiHB4s3xQ57YUsWGliaT//XAlPG4IZQSTFJgHz51X0
         vKGM2adsiNg/72+H8scjRXD27toAcyDrIz6EBjGnfFsc0Dy/DJbhT4+A1/OAovkuyY2N
         /KmQ5vtOCC26+v/bk6dcfe7AMxpED60dcT/ZMfRJLbnIFLJAoBNGRFkfG34gZi5b8MVC
         ejtytskt/kgbaZx8Our3TIzkRm0A1k+Ld1j6oqAoW3T8SPPswg2Dcqu1VkXTRASyO7Lo
         lhVZC0XwRYBbVJAtZnQw18VW62lAlaUjAWHZCrGZtJPRllz+l/zY87Izp8kIZthex33w
         I+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXkmqvx0vdFaWHHXfXPqLkS7BWVtY0wiD2tfqtEnBIhWZnX5ySStr7xfZyvwC8I8Hfa3sjFtws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6Zfi1gUIijN10balPWAA7N9o1ccY//S8zQq+X+dNxDwYqOwf
	0JKnJzGdBuvd5J+Azq51pKz18Ws/EsYYuzVoZVeuW6T3kQE8bx1kqWg=
X-Gm-Gg: ASbGncsBJRkLD0T5qW8P5fuSKi1eVxw7YNxjWaDcnr7jQzwjryI+pdAoJGQR9Ga9UvM
	FZ1HG8f2HSZvjwhHcHiC4aNLRpTCzQ+cjCQrQph4DRyuTSz6qLK5RBwwhOVOvBQU7b6oUeUYmH8
	RKuHKmJ6UZWXxw43o/bcOSdoe+IAt/ktjweR8zTnpLMrtclmJFZUt819aE6ssr+uL4zeHsHUEl9
	l5fLQdxSPtwt3Q+/UiH7rL2lu0i9Dmvv0gIej7Hxn64Nyov8YoxUyjuDdAzFglNKhuwD4R+L43C
	S3u0glEzbAoB5jKuFNRnJe3WOWtQdLS1OWxwZrI=
X-Google-Smtp-Source: AGHT+IFB4s9sczUacZsx6lIfUURUU+XV72VeB7ioSI2XaK2Ct3GIjUZaGoiudoatS5pIsxkRMj1d6g==
X-Received: by 2002:a17:903:234a:b0:234:d679:72f7 with SMTP id d9443c01a7336-2366b010e77mr159973175ad.23.1750116895447;
        Mon, 16 Jun 2025 16:34:55 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:55 -0700 (PDT)
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
Subject: [PATCH v1 net-next 13/15] ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
Date: Mon, 16 Jun 2025 16:28:42 -0700
Message-ID: <20250616233417.1153427-14-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

The next patch will replace __dev_get_by_index() and __dev_get_by_flags()
to RCU + refcount version.

Then, we will need to call dev_put() in some error paths.

Let's unify two error paths to make the next patch cleaner.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/anycast.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 8440e7b27f6d..e0a1f9d7622c 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -67,12 +67,11 @@ static u32 inet6_acaddr_hash(const struct net *net,
 int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_ac_socklist *pac = NULL;
+	struct net *net = sock_net(sk);
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev;
-	struct ipv6_ac_socklist *pac;
-	struct net *net = sock_net(sk);
-	int	ishost = !net->ipv6.devconf_all->forwarding;
-	int	err = 0;
+	int err = 0, ishost;
 
 	ASSERT_RTNL();
 
@@ -84,15 +83,22 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	if (ifindex)
 		dev = __dev_get_by_index(net, ifindex);
 
-	if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE))
-		return -EINVAL;
+	if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE)) {
+		err = -EINVAL;
+		goto error;
+	}
 
 	pac = sock_kmalloc(sk, sizeof(struct ipv6_ac_socklist), GFP_KERNEL);
-	if (!pac)
-		return -ENOMEM;
+	if (!pac) {
+		err = -ENOMEM;
+		goto error;
+	}
+
 	pac->acl_next = NULL;
 	pac->acl_addr = *addr;
 
+	ishost = !net->ipv6.devconf_all->forwarding;
+
 	if (ifindex == 0) {
 		struct rt6_info *rt;
 
-- 
2.49.0


