Return-Path: <netdev+bounces-175947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB56A680BE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E65C7AB106
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3052206F19;
	Tue, 18 Mar 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vgv4aFmV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF11F7076
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340897; cv=none; b=WsEJSuTp50IhIi45nmCmr7UCmjFkngfRX1nNL2L7gWQwAJ67qZzGR67Xfm6BZ5jvcuLrLts+cpHxASzbch6mcLUCXSFPHcxkzYXLQT6T3HrvfkEVwS4tXW6mdypCqfQZDF7HIchpel63Xc6gHp6RzdYAiBDUs+0o3XtBlOCpI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340897; c=relaxed/simple;
	bh=Rid7cLLB3tLlup+VYdRfGQ+vEUhD98T2Bk9MEslMFh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPHmF1HI249alfNXT5aOpE4/5N6gkggBQlIIIoCmgONlY1H7vbEp/8VlvMKzGOGCC+kFTOBi3++WnHqHQEb0drF4V76via6Hh52+dUKkm29QwZW85Rai0xCgp+9GZWT/Yord3lScbOzoMD8Kn29dXEdRQnzAGnPD7ZX4+eVjxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vgv4aFmV; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742340896; x=1773876896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trSspWxDMxD+GsX7d9lbyC5sGqeOld+2ndIYdMFdr3M=;
  b=vgv4aFmVQGTM+mXn9LF8knwVnM9cZdvQNjkYxe/7x/L+hNnuF9yRevxA
   E1/gXvBaW1FPmTB4HT3NTEINsra1bWUQZWYbJvwOBjaoKGsIkw2sU0LSf
   i5rO5vEoBotPtOZxsG/0sj3H1J4rE55Lw4Ju03r9eAjAEDkUlKCcI96Uu
   M=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="481547199"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:34:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:34008]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id f2716520-2d20-4867-b36c-ea32e53f8cf4; Tue, 18 Mar 2025 23:34:52 +0000 (UTC)
X-Farcaster-Flow-ID: f2716520-2d20-4867-b36c-ea32e53f8cf4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:34:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:34:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/7] nexthop: Remove redundant group len check in nexthop_create_group().
Date: Tue, 18 Mar 2025 16:31:48 -0700
Message-ID: <20250318233240.53946-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318233240.53946-1-kuniyu@amazon.com>
References: <20250318233240.53946-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The number of NHA_GROUP entries is guaranteed to be non-zero in
nh_check_attr_group().

Let's remove the redundant check in nexthop_create_group().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 09f5f31f34a0..409f13d64ed4 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2692,9 +2692,6 @@ static struct nexthop *nexthop_create_group(struct net *net,
 	int err;
 	int i;
 
-	if (WARN_ON(!num_nh))
-		return ERR_PTR(-EINVAL);
-
 	nh = nexthop_alloc();
 	if (!nh)
 		return ERR_PTR(-ENOMEM);
-- 
2.48.1


