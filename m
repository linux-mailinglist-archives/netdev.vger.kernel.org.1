Return-Path: <netdev+bounces-158401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C3A11B82
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF693A3C9A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1722F3A3;
	Wed, 15 Jan 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m5dwNavt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1D22F38B
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928415; cv=none; b=TSInQx5U9w9j/MnYiwXgiDL418fubNCcMKuSyIhYkXHiT8dK3XIPXzXCoqk60+IxwT7Ntr8+ITVtOPwuNSyDm9miLaCkgYLTXvRf4eEJqcOg4n821WIrf6FLqeL3QWAdEOtWqzBfPDyUp1wr/ZLkTDZwu2idfC3OTNjLHSFYaXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928415; c=relaxed/simple;
	bh=82MhXHYi+LaY1gCgAMLIsS4C5Ihe6HsDyOnHolfJdzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUYIna+hGvT3g02FwVqPPmG2e3nCwSuueEKqWimnZ+tHEKhcjQOd/r5uaXJUXMEOfgFbhAJCiE6r0Svg0W+JEV5/fDOgFK5ivqJLbAuMIz3RamJG4qr4sUT03Yro1KuHkCQhX145/CCnK1X21V5sUPegG8kYfi23q5cvnnpYa9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m5dwNavt; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928415; x=1768464415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=woWK6e4QRxXhPu6AtMnRwjruMVN5AdHcI21Ae3QlSnc=;
  b=m5dwNavtwEfl/WKyJcTXJJ69+2OMeSOE3LdqXHElK1Avbnk63ylmimin
   l4cuukHw0ViNe4g4AwHmMCK6w9kH8Wy5Eghdtpu7ktPGczsNVsi92puau
   y5AOm+34bSLV85gTbOjifNNqeqbpfmDHSif72NSwyXTDYWZunW0eA7SiA
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="369208068"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:06:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:27351]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.180:2525] with esmtp (Farcaster)
 id 2a4ae72a-6326-415b-9e8c-030a14d86b0d; Wed, 15 Jan 2025 08:06:52 +0000 (UTC)
X-Farcaster-Flow-ID: 2a4ae72a-6326-415b-9e8c-030a14d86b0d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:06:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:06:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/11] ipv6: Add __in6_dev_get_rtnl_net().
Date: Wed, 15 Jan 2025 17:05:58 +0900
Message-ID: <20250115080608.28127-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115080608.28127-1-kuniyu@amazon.com>
References: <20250115080608.28127-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
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


