Return-Path: <netdev+bounces-88128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 096138A5DB2
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A689E1F2145F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1907157A45;
	Mon, 15 Apr 2024 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IOTjPFG8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F10157485
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219784; cv=none; b=qa4KuD+rHNKbDJCb5ak/uZxqx8u+X2LQEQRdoqdoKPz135hxL+i5bqyFQ4GDGKzGeX/o0h/4K76Do4gDy4Rw5PbTSQwmKHKFAbDNapQJQ527du7xpTPVq6q2DyB5A4HeAgV9O4Esc3SB2rRQdrux9X2i/XjVpzV3xpMlnVMFkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219784; c=relaxed/simple;
	bh=rZNaumpJL8qQby42EPMBwsW5Bd2biWX7ivgCd0YiQkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcBYbN0UjiaThQwHAHtAoFQWay73suIV6A5IcWdGesXWIf+DNv/90nWSsIxMgE1Rhnr3wgeh8abp6Dt+4I+IsHqXN9uuhTHO+Dpsch/rttvke5x53UGT8v5hTQ/rxYiXthSIwnkuZSGoO/B6+bhb5ItLQ1m2R//t30AFmXWMQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IOTjPFG8; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713219784; x=1744755784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KtIcr0SRhWnHUSyoZdWCkujc54b2qlsMzNxwvJkWJuE=;
  b=IOTjPFG82QDifXpRLqFtC9K6aNNQ0idyQI47qdD2S63iMHXwcvLaqAqp
   BRRQmQJi4LLJ/5FnDmrdRTrVS4QInVnXqt6S4u5RPyaAMgPEsy5kuqlnH
   IoIoEGxhWnnbLddmjKfI1WmekBUkQiPv66v+dZoLgFYEDVd54rBahKzIa
   s=;
X-IronPort-AV: E=Sophos;i="6.07,204,1708387200"; 
   d="scan'208";a="389775525"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:23:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:26230]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.244:2525] with esmtp (Farcaster)
 id 75209ee7-56e7-47b1-b2da-9a8c1b99f0c4; Mon, 15 Apr 2024 22:22:59 +0000 (UTC)
X-Farcaster-Flow-ID: 75209ee7-56e7-47b1-b2da-9a8c1b99f0c4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:22:59 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:22:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 5/5] ip6_tunnel: Pull header after checking skb->protocol in ip6_tnl_start_xmit().
Date: Mon, 15 Apr 2024 15:20:41 -0700
Message-ID: <20240415222041.18537-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240415222041.18537-1-kuniyu@amazon.com>
References: <20240415222041.18537-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller demonstrated the underflow in pskb_network_may_pull()
by sending a crafted VLAN packet over tunnel devices: sit, ipip,
vti, and vti6.

The same warning will be triggered for ip6tnl, so let's check
skb->protocol before pulling the next header in ip6_tnl_start_xmit().

Fixes: cb9f1b783850 ("ip: validate header length on virtual device xmit")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/ip6_tunnel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index e9cc315832cb..81be7a5be6c5 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1424,14 +1424,17 @@ ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	u8 ipproto;
 	int ret;
 
-	if (!pskb_inet_may_pull(skb))
-		goto tx_err;
-
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+			goto tx_err;
+
 		ipproto = IPPROTO_IPIP;
 		break;
 	case htons(ETH_P_IPV6):
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
+			goto tx_err;
+
 		if (ip6_tnl_addr_conflict(t, ipv6_hdr(skb)))
 			goto tx_err;
 		ipproto = IPPROTO_IPV6;
-- 
2.30.2


