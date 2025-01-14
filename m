Return-Path: <netdev+bounces-158009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7277AA101AC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F10A3A15B4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD73246354;
	Tue, 14 Jan 2025 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BIZgr5U5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11AB24022D
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736841972; cv=none; b=JZtVmIlPwkVoU0uP934+Z5Ip5nbTqYShTNQy9pQkhXdmOZA0J8G4ckp7ziwdhUdV8qWCKsI6R5wk+yWM/sNF5VRJXB5xQrIu2FmhZTrS7qgCF/kTBi6CuLgZ9i2QwOCF66oI6GszbUjaM6glfdc5A6r/LN4nrgpw7angQO+1DaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736841972; c=relaxed/simple;
	bh=82MhXHYi+LaY1gCgAMLIsS4C5Ihe6HsDyOnHolfJdzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktR6O//qEF9EiSeBOyIijcef1IUkbTq99xb7AbEw23BHFbQfgzwXUDiqIRe46W8fVCo503wlJSOh+0feLrYx1TIBYwmD/RsGQ5sfxM8nz1JWt4wv/10OuFPSDhVWPUCGZuLRULedVhP0Cw9QCranXuptu2O4FSMXeY7s1GRpohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BIZgr5U5; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736841971; x=1768377971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=woWK6e4QRxXhPu6AtMnRwjruMVN5AdHcI21Ae3QlSnc=;
  b=BIZgr5U5w4Y1mX4AL+x8ukTZYzYZrNesphz5ysLYq39Nyhu/NBGOQvHM
   7zwwnVI2JzYn6ho+0Cvu/b7oxdSXoSvVH72dHbwqT9aW2Uw0FZCuLQHyn
   hSifDxN7eU7nI/icVdHXUBu3uY5aTSk4LnUvDcbAv298QfMY/NbyZZZvb
   0=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="262894349"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:06:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:18435]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.236:2525] with esmtp (Farcaster)
 id a54143ef-d9f9-4ad7-9288-576deb3785e8; Tue, 14 Jan 2025 08:06:06 +0000 (UTC)
X-Farcaster-Flow-ID: a54143ef-d9f9-4ad7-9288-576deb3785e8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:06:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:05:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/11] ipv6: Add __in6_dev_get_rtnl_net().
Date: Tue, 14 Jan 2025 17:05:06 +0900
Message-ID: <20250114080516.46155-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114080516.46155-1-kuniyu@amazon.com>
References: <20250114080516.46155-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will convert rtnl_lock() with rtnl_net_lock(), and we want to
convert __in6_dev_get() too.

__in6_dev_get() uses rcu_dereference_rtnl(), but as written in its
comment, rtnl_dereference() or rcu_dereference() is preferable.

Let's add __in6_dev_get_rtnl_net() that uses rtnl_net_dereference().

We can add the RCU version helper later if needed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/addrconf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index f8f91b2038ea..9e5e95988b9e 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -347,6 +347,11 @@ static inline struct inet6_dev *__in6_dev_get(const struct net_device *dev)
 	return rcu_dereference_rtnl(dev->ip6_ptr);
 }
 
+static inline struct inet6_dev *__in6_dev_get_rtnl_net(const struct net_device *dev)
+{
+	return rtnl_net_dereference(dev_net(dev), dev->ip6_ptr);
+}
+
 /**
  * __in6_dev_stats_get - get inet6_dev pointer for stats
  * @dev: network device
-- 
2.39.5 (Apple Git-154)


