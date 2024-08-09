Return-Path: <netdev+bounces-117325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12C94D953
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C941C20C9C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3181716D4FA;
	Fri,  9 Aug 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uLkdQN0J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71616D4FB
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247764; cv=none; b=I6yDVAaGPfb3F0+62i04tiu36RYy0MqG3nyG0rRCChc5kHL70z91RXzeOJc+xNsavqIX404eNViHzmNgjnc70BHWSQGIQtl+LqqAcPEjQKT0y7PIYaRsChY157bNuRp7HFpIsJF+Ii8C0faqEd7z5LXHrDd8fDBfS44EXy/pjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247764; c=relaxed/simple;
	bh=5WdufGY5aAUlFDNyCF4nwcDqk8SRbOsJDESG0eGJTVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTEoW0+TY1U2SSo0haquVlqOW7BlCrQSkY7VDxm8ym50keFOWCYaM9xI9SaJ78oOQdjNgb4WrtPZkbOOKz/cFsQbOTXnJ4p1NcjK3ZpS9yHIsaPjPi+MPY/ej/TbA407/vQ1NcksPoEdsqYQiFBzy5aCkl2YQqzKBojlJFu52fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uLkdQN0J; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723247763; x=1754783763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZ5oQlmFDPhL7qojrnZLQOI/0NrEB6zGvvH7SY/Qq/A=;
  b=uLkdQN0JCJJ5wopRQ0VwkyGmYMkBQVuJdIJZ44vfuTeipsFikYxRtoL1
   HzncEnOmqX16tkJW7OQ8Ba9qKBrc1qhBZBFBWlqwQdrDTfbtWHX2sLuud
   F/I1ery+/loN1lY+lRxaeEdneSWukbzPqq4YfuoVOn+jBSsay/mpBm19E
   g=;
X-IronPort-AV: E=Sophos;i="6.09,277,1716249600"; 
   d="scan'208";a="420427493"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 23:56:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:23563]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.16:2525] with esmtp (Farcaster)
 id c03be7dd-b1ee-4000-9c9f-54bcd2718c08; Fri, 9 Aug 2024 23:55:57 +0000 (UTC)
X-Farcaster-Flow-ID: c03be7dd-b1ee-4000-9c9f-54bcd2718c08
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:55:57 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:55:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/5] ipv4: Initialise ifa->hash in inet_alloc_ifa().
Date: Fri, 9 Aug 2024 16:54:05 -0700
Message-ID: <20240809235406.50187-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Whenever ifa is allocated, we call INIT_HLIST_NODE(&ifa->hash).

Let's move it to inet_alloc_ifa().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index baf036bfad76..b5d2a9fd46c7 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -227,6 +227,8 @@ static struct in_ifaddr *inet_alloc_ifa(struct in_device *in_dev)
 	in_dev_hold(in_dev);
 	ifa->ifa_dev = in_dev;
 
+	INIT_HLIST_NODE(&ifa->hash);
+
 	return ifa;
 }
 
@@ -889,7 +891,6 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 	if (!tb[IFA_ADDRESS])
 		tb[IFA_ADDRESS] = tb[IFA_LOCAL];
 
-	INIT_HLIST_NODE(&ifa->hash);
 	ifa->ifa_prefixlen = ifm->ifa_prefixlen;
 	ifa->ifa_mask = inet_make_mask(ifm->ifa_prefixlen);
 	ifa->ifa_flags = tb[IFA_FLAGS] ? nla_get_u32(tb[IFA_FLAGS]) :
@@ -1186,7 +1187,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 			ifa = inet_alloc_ifa(in_dev);
 			if (!ifa)
 				break;
-			INIT_HLIST_NODE(&ifa->hash);
+
 			if (colon)
 				memcpy(ifa->ifa_label, ifr->ifr_name, IFNAMSIZ);
 			else
@@ -1588,7 +1589,6 @@ static int inetdev_event(struct notifier_block *this, unsigned long event,
 			struct in_ifaddr *ifa = inet_alloc_ifa(in_dev);
 
 			if (ifa) {
-				INIT_HLIST_NODE(&ifa->hash);
 				ifa->ifa_local =
 				  ifa->ifa_address = htonl(INADDR_LOOPBACK);
 				ifa->ifa_prefixlen = 8;
-- 
2.30.2


