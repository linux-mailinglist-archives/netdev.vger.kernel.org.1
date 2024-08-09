Return-Path: <netdev+bounces-117326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A794D954
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB6D1C20A30
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535216D9AE;
	Fri,  9 Aug 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eYT1YY0/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7DF16D336
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247786; cv=none; b=s2ArBd5Vr4YUxA7UCo9JQ/xTbNUDqlabaxFlnu+HoAF+oUug/BxfZfZp8VLlYw614vZ017U2ot2Q+5oMb/IxrTtqNPEI1aCssGv0jScw7lQHfyC5A/EUmIO1RZ2pGFsMUnxtVMU8UFspjiwj/1WTJtMRMriImHY87ottWnEJZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247786; c=relaxed/simple;
	bh=bpuyTRT77VWyVVGOz0OjW+SMwVd0ftiwTB8b/jiHsDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2mDxrRKrpCaWBIYvnEK/lKuwZv8UVN6RvimMgSYyusB05ZIdrt86o0cmwXx5+i5LkfV0gG8YUNQvvV5E0lkbWZFerNZ/9LVmkwuVanEYnfPO0LVcu3/ijIVK2LiCgKgJ/KOfSYGL2F8jUU70zhWuWw1bSnJU7tuY1etJB4h+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eYT1YY0/; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723247784; x=1754783784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EFPPYa5I/R32csNNDxGn12aoB4Umg23VRmVdp+4veI=;
  b=eYT1YY0/HYeNyRarmOZE5XYfCsHc/2E4PUfEWRhltzIcDF+9HcmT9Beh
   z2WUiiajHG+NzshMsuNfmKnABN4WFCSDxf+9rX8mvH+pSN8INpihMa1KJ
   GujTGy2DaWq7/aa2j/R5LDwRDd8IPf/ERotn7Ov03RDB8g0S0IQla/Im0
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,277,1716249600"; 
   d="scan'208";a="114210950"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 23:56:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:6709]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.111:2525] with esmtp (Farcaster)
 id 51cbbbfb-5bc8-4123-8091-9c3048f737d7; Fri, 9 Aug 2024 23:56:23 +0000 (UTC)
X-Farcaster-Flow-ID: 51cbbbfb-5bc8-4123-8091-9c3048f737d7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:56:21 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:56:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/5] ip: Move INFINITY_LIFE_TIME to addrconf.h.
Date: Fri, 9 Aug 2024 16:54:06 -0700
Message-ID: <20240809235406.50187-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809235406.50187-1-kuniyu@amazon.com>
References: <20240809235406.50187-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

INFINITY_LIFE_TIME is the common value used in IPv4 and IPv6 but defined
in both .c files.

Also, 0xffffffff used in addrconf_timeout_fixup() is INFINITY_LIFE_TIME.

Let's move INFINITY_LIFE_TIME's definition to addrconf.h

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/addrconf.h | 4 +++-
 net/ipv4/devinet.c     | 2 --
 net/ipv6/addrconf.c    | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index b18e81f0c9e1..c8ed31828db3 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -187,10 +187,12 @@ static inline int addrconf_ifid_eui48(u8 *eui, struct net_device *dev)
 	return 0;
 }
 
+#define INFINITY_LIFE_TIME 0xFFFFFFFF
+
 static inline unsigned long addrconf_timeout_fixup(u32 timeout,
 						   unsigned int unit)
 {
-	if (timeout == 0xffffffff)
+	if (timeout == INFINITY_LIFE_TIME)
 		return ~0UL;
 
 	/*
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index b5d2a9fd46c7..61be85154dd1 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -703,8 +703,6 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-#define INFINITY_LIFE_TIME	0xFFFFFFFF
-
 static void check_lifetime(struct work_struct *work)
 {
 	unsigned long now, next, next_sec, next_sched;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c87d008aefa4..04ee75af2f6b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -92,8 +92,6 @@
 #include <linux/export.h>
 #include <linux/ioam6.h>
 
-#define	INFINITY_LIFE_TIME	0xFFFFFFFF
-
 #define IPV6_MAX_STRLEN \
 	sizeof("ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255")
 
-- 
2.30.2


