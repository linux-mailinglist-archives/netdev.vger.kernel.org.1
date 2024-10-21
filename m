Return-Path: <netdev+bounces-137607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D89A726A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3DEB20A6C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909601F9AB1;
	Mon, 21 Oct 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RMK2/HkS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248E1EF0AA
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535646; cv=none; b=hRTpuwXm7jtylx++iGxMRkNGVa+4Dbj7xlWjKAsnXYNO2Dr+HEXJ2IA4qEz+aYyW5B0oQsAG4kNU7zLFpW1/rByzEGKRsIaZX87dER3Zf78IcjPa6XB20UsnfcvEmjL5Egjalo/A3VeBGSAznObwCV1vCpkePi1uJNfBoms/wA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535646; c=relaxed/simple;
	bh=xLWBy3YD6OrOXiw4lSmqZYw1+m0hTnOj2adLH4QBIcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuS3ErCFiDqcwOgXQ83HaxYbCPzAkK/2m+aMniiUFSGVD3cXfishN9RbYbbl3PnGg++uNLz64obdc7yatdVGZsKNRBA8WQ7ErUUwAWfTYFOWmNZvCYbtj1nkRDU4n9qXIfb7FOEQNXxdobgTTmj6akOZMq4raB6TYlsSeABasec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RMK2/HkS; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535644; x=1761071644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+9KUfD0dACdqCFzN11t1wx+9/J4vuqUmM3lJyLyDJI=;
  b=RMK2/HkSx4LQuJKu2xtGX1fRudB5g2bXLya9B3M1AeHbHA24ys4WFfH3
   8u8UZnHG/XL+kgENtAA9m769voNjL4Hy7IjYpb9p2rgIf/xir5ss2jsQa
   uXx22gAF+/ZrSwq/Z3hqBNceDbIh8grQ4yDDaxY4XfF10cQ7oVSuCchAL
   k=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="140306103"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:34:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:54750]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id f49743e9-a882-4b50-a7e7-467e9eaac75c; Mon, 21 Oct 2024 18:34:02 +0000 (UTC)
X-Farcaster-Flow-ID: f49743e9-a882-4b50-a7e7-467e9eaac75c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:34:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:33:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/12] ipv4: Don't allocate ifa for 0.0.0.0 in inet_rtm_newaddr().
Date: Mon, 21 Oct 2024 11:32:31 -0700
Message-ID: <20241021183239.79741-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we pass 0.0.0.0 to __inet_insert_ifa(), it frees ifa and returns 0.

We can do this check much earlier for RTM_NEWADDR even before allocating
struct in_ifaddr.

Let's move the validation to

  1. inet_insert_ifa() for ioctl()
  2. inet_rtm_newaddr() for RTM_NEWADDR

Now, we can remove the same check in find_matching_ifa().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 24af01fcb414..5e43f9f68e4a 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -508,11 +508,6 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 
 	ASSERT_RTNL();
 
-	if (!ifa->ifa_local) {
-		inet_free_ifa(ifa);
-		return 0;
-	}
-
 	ifa->ifa_flags &= ~IFA_F_SECONDARY;
 	last_primary = &in_dev->ifa_list;
 
@@ -584,6 +579,11 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 
 static int inet_insert_ifa(struct in_ifaddr *ifa)
 {
+	if (!ifa->ifa_local) {
+		inet_free_ifa(ifa);
+		return 0;
+	}
+
 	return __inet_insert_ifa(ifa, NULL, 0, NULL);
 }
 
@@ -953,15 +953,13 @@ static struct in_ifaddr *find_matching_ifa(struct in_ifaddr *ifa)
 	struct in_device *in_dev = ifa->ifa_dev;
 	struct in_ifaddr *ifa1;
 
-	if (!ifa->ifa_local)
-		return NULL;
-
 	in_dev_for_each_ifa_rtnl(ifa1, in_dev) {
 		if (ifa1->ifa_mask == ifa->ifa_mask &&
 		    inet_ifa_match(ifa1->ifa_address, ifa) &&
 		    ifa1->ifa_local == ifa->ifa_local)
 			return ifa1;
 	}
+
 	return NULL;
 }
 
@@ -982,6 +980,9 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ret < 0)
 		return ret;
 
+	if (!nla_get_in_addr(tb[IFA_LOCAL]))
+		return 0;
+
 	ifa = inet_rtm_to_ifa(net, nlh, tb, extack);
 	if (IS_ERR(ifa))
 		return PTR_ERR(ifa);
-- 
2.39.5 (Apple Git-154)


