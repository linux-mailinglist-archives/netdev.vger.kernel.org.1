Return-Path: <netdev+bounces-137604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A339A7265
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF2A281CFA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690A1F9AB4;
	Mon, 21 Oct 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H+zckunK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604941F9AB1
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535591; cv=none; b=iVXx3KfqbJ4Glu1tzKjHvCtsm994aYCwHSeH4Ewyar4ME9jPKkjpycqJt/WIoev6OzAMOZfM0RKv5RgAJotJsD1ql5ybb4xQM3QmvCE8cuoY95K6VQoR4Umn6M5cFdcCMicuh3j1nOfCfOrXSRkkmtJks/MQLxUbDgQ5VTev8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535591; c=relaxed/simple;
	bh=7tP5PYf7ym+mdgfNXUzCUt8AZvaclDZzA0il9MkBV00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMjtUeCu4ohK6pkNP6M1Rdjyx8u5NLGJoU2KvMoskxehULTCZoiq1+iahkcjiv9ad2tm9khz6/9tuYrdjh6fg7Zw2ZzuZ3NFiRddcI/SA+zH9xLJQiT0VTRVUACLz2mtuWIiqQjiXFT31+7CG97+Kz9JFu2mtUVC9SphbkmOWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H+zckunK; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535589; x=1761071589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AecA/gX3pBxT0tBzVfIB+2jl7iiXBAo+MRFT+7Jv/Q=;
  b=H+zckunKjTzcX/854zumgnKHH6FjuEYyaonwFqtbuSSwWBn2TtcdyT3l
   oZPPUFEI7CWGnyx0x7WzC1/3KTSrTZsoaOa7H4TfQcSI6Ug3zHI4ssjC5
   OWS4NeYBCAgN1lU+jSpgyPUCjE1i4ssPBMpAInSKxj+UA4bubHomFcbvQ
   4=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="241197147"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:33:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21701]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 19c65a6a-63f5-4b8b-ac0d-61a49e5273c4; Mon, 21 Oct 2024 18:33:05 +0000 (UTC)
X-Farcaster-Flow-ID: 19c65a6a-63f5-4b8b-ac0d-61a49e5273c4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:33:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:33:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, kernel test robot
	<lkp@intel.com>
Subject: [PATCH v1 net-next 01/12] rtnetlink: Make per-netns RTNL dereference helpers to macro.
Date: Mon, 21 Oct 2024 11:32:28 -0700
Message-ID: <20241021183239.79741-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When CONFIG_DEBUG_NET_SMALL_RTNL is off, rtnl_net_dereference() is the
static inline wrapper of rtnl_dereference() returning a plain (void *)
pointer to make sure net is always evaluated as requested in [0].

But, it makes sparse complain [1] when the pointer has __rcu annotation:

  net/ipv4/devinet.c:674:47: sparse: warning: incorrect type in argument 2 (different address spaces)
  net/ipv4/devinet.c:674:47: sparse:    expected void *p
  net/ipv4/devinet.c:674:47: sparse:    got struct in_ifaddr [noderef] __rcu *

Also, if we evaluate net as (void *) in a macro, then the compiler
in turn fails to build due to -Werror=unused-value.

  #define rtnl_net_dereference(net, p)                  \
        ({                                              \
                (void *)net;                            \
                rtnl_dereference(p);                    \
        })

  net/ipv4/devinet.c: In function ‘inet_rtm_deladdr’:
  ./include/linux/rtnetlink.h:154:17: error: statement with no effect [-Werror=unused-value]
    154 |                 (void *)net;                            \
  net/ipv4/devinet.c:674:21: note: in expansion of macro ‘rtnl_net_dereference’
    674 |              (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
        |                     ^~~~~~~~~~~~~~~~~~~~

Let's go back to the original simplest macro.

Note that checkpatch complains about this approach, but it's one-shot and
less noisy than the other two.

  WARNING: Argument 'net' is not used in function-like macro
  #76: FILE: include/linux/rtnetlink.h:142:
  +#define rtnl_net_dereference(net, p)			\
  +	rtnl_dereference(p)

Fixes: 844e5e7e656d ("rtnetlink: Add assertion helpers for per-netns RTNL.")
Link: https://lore.kernel.org/netdev/20241004132145.7fd208e9@kernel.org/ [0]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410200325.SaEJmyZS-lkp@intel.com/ [1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 8468a4ce8510..0e62918de63b 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -137,21 +137,12 @@ static inline void ASSERT_RTNL_NET(struct net *net)
 	ASSERT_RTNL();
 }
 
-static inline void *rcu_dereference_rtnl_net(struct net *net, void *p)
-{
-	return rcu_dereference_rtnl(p);
-}
-
-static inline void *rtnl_net_dereference(struct net *net, void *p)
-{
-	return rtnl_dereference(p);
-}
-
-static inline void *rcu_replace_pointer_rtnl_net(struct net *net,
-						 void *rp, void *p)
-{
-	return rcu_replace_pointer_rtnl(rp, p);
-}
+#define rcu_dereference_rtnl_net(net, p)		\
+	rcu_dereference_rtnl(p)
+#define rtnl_net_dereference(net, p)			\
+	rtnl_dereference(p)
+#define rcu_replace_pointer_rtnl_net(net, rp, p)	\
+	rcu_replace_pointer_rtnl(rp, p)
 #endif
 
 static inline struct netdev_queue *dev_ingress_queue(struct net_device *dev)
-- 
2.39.5 (Apple Git-154)


