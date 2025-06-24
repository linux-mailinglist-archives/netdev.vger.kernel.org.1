Return-Path: <netdev+bounces-200830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17F5AE70B2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64545A4D08
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843E42EF9A3;
	Tue, 24 Jun 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIO09GR+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D92EBBA4
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796805; cv=none; b=ffRdow8AK5hJAqMq1urqUvC4jL+Rw9bsjgX3pwtPBZvENptiFRvF9vsy3+FUWHXvvhf/cJGQVRO2Sf616wXMkeoq7VH37YMgXNDBYEDT3INm8w+vRjatWzF2QqL44zeApULp6NGWLkQ6//UR1jjYPr3W8MOUHPv/o0JD/7luVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796805; c=relaxed/simple;
	bh=JFCHDMKIc5RQ9pu1EdhuXWBO0LqrsSVgqwZ93qT4wRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lkh/REeGxO6cITlc0xIo6DFk/iVtNDMSwgY2VhwuiuwakX58EUAGIRzH2uaEd+6H8sFa0uqU6lQxYRGBMqJJalPUP7gOGGIcGJaOhWyk+7REh5Y/Zmr+YWnkYgPDqVZ4FTMpA67jCs9GRTKZBqx7/dwUkyzmf3YNP3oebk9yeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIO09GR+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso159409b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796803; x=1751401603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX3cOIeN5Vy9hs5Qq7dGvJEVHWHjACWjbA9GEWYacbo=;
        b=SIO09GR+TtgeQH6xR7S65fSUxeFpvNeX6Xu7CbZ8JMPFiW5qXpCMGwCIdMbxJbhpqD
         V/eE1w6TshDCYSXWrbjH6kSapEdJ0qwsf6sqNGn+04JKuG5ToJN6ZA+q8RN6MdV/pGWm
         5pcTckAwL/HrjCduZC9y2eNflxjk8stqDDTYre9D65qun3mzK2wdKJjjEf4JhmzWRIzf
         8xmIwcHaPmnKuZ9F2YJmIhnRohEig8slj0od3TNGtO9Et14KILiK1W2C8/y/W3T3TBRl
         i1oFvFbYwmYGyo7ksxmzo+kn/xJerUzuzRR19kk65Dhji7tkmqwCN1yXgMC9rUn47wLX
         Mt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796803; x=1751401603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX3cOIeN5Vy9hs5Qq7dGvJEVHWHjACWjbA9GEWYacbo=;
        b=dfqvSfR8iSZyZcDPFgmAfiR3p20qrCjck1z46kQIceGz7kEKtCdG13530RNFcFZhHB
         xtGDvJRe9v5tL6HSJrGWNGQsTnJSg3FiHy81KG0V5CUbLRpaXHZdAcWU6vKgPE3p6xEx
         P3kNH6+zqsTVUYRWyMpaf7efHKdECnibshDS2mHr+KYVb/ahWxLW9g/jiVquamREn26l
         GxMLvZat/fNSuAPM9IEa0U/VJUqIdKmL8EtQ02auQX+l0TMCc5+THTQUsl2IADcT8mm8
         QgkcKED6kfGamp2CP+hIH+A+uiUvKC8RJB6iBGFxP5zFFUc/tBqTlz99G0dpnXqmDhpE
         2gQw==
X-Forwarded-Encrypted: i=1; AJvYcCWwu9FWNjFeut9XAfRz4ew5lz2t/KiQQyLWsFk/m69GACgJngbNaUU7+CsugoStXbEIX/ISN0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgoCXRFP8aaS8lKAKRluvf766JtCQjlXDWh6rjJDUAdF2Ob/C
	D9hevurzVftZE/rnyX9aqNM2ktVClRhIrIRYTUI1NFRCwentvRnSUDE=
X-Gm-Gg: ASbGncuGecedS6hPivwE4zc1tlz21p0s1cJrZ1dztqwM3fbRfZgtan/759jVa7kuo+d
	hCqTBkbzoC+vvXJyfogzyurdLRRZxYfZNwiS4CM3dGsTvCRLcaabdU9tnotLJtIvT9tSs+lK5BS
	5KszFBSjBD3H/lF2BtpZZO7HIMkyyZT9/E71vU0QtsNqBtS0Lcun6nt4R/xUtiV0HKeyvmUhubR
	h9YGRQtLigtGdu3U2PuVLpPxHbKvcyBb3dMgZI6imnpUhYUrJkNMuml5s4YIxybx3cpRTEioZeC
	NUPiC+VqL4HaVTLPrdBq0G+5TRhl+ZFBvKbhn9A=
X-Google-Smtp-Source: AGHT+IEMEKlOz+u+eEtGmNnoTd0JWFUA/cVTtlnwil7eKLlCs3l/kbeuhEG8Sdqv6Ott3ZoLDfiVEw==
X-Received: by 2002:a05:6a20:d706:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-2207f35f220mr399717637.18.1750796803147;
        Tue, 24 Jun 2025 13:26:43 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:42 -0700 (PDT)
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
Subject: [PATCH v2 net-next 13/15] ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
Date: Tue, 24 Jun 2025 13:24:19 -0700
Message-ID: <20250624202616.526600-14-kuni1840@gmail.com>
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


