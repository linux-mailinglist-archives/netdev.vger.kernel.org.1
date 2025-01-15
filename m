Return-Path: <netdev+bounces-158408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F9A11B91
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96D43A32B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D8232431;
	Wed, 15 Jan 2025 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ctKFBUtm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A922FAE2
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928611; cv=none; b=Rg4jrBHg1KhP+un2d7ZyAySpYb0qLecJjrBClCa6plA402ZmjPipsffqhEA3vF2oOwulV+tCLTt9bjDo9rowQdkZ4IuQYZLRys0ejMTH26A1wDmnEySr8L7HhgNUxyOa9v0laejXxKMxOGb5neuu5tQHJZ3SlOxe0Lg6yqDJvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928611; c=relaxed/simple;
	bh=nn6LuTRQt2KDxwM1C0hn8PrpsPLsNSxIK98/GWuoNnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAaZRRjnyTjwKYYnqwULn8yQo0uZ7LkCxJtWRD1nef9CaBUXVb0eC3D4MO/CiVaygbpEleowlC8FJRVOQf2tTYVPNUnCssPbLeDITxUAVEUrCHyARx/1SUBmkGrKJJnRbRHbws87gX8vPZOl7JwIonN9JCdy/lHDrEJQUzT8OZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ctKFBUtm; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928610; x=1768464610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SuG13MtF+6G5ADbuArtZ5P/kL8xq3i1uxKTywpVJsWY=;
  b=ctKFBUtmng1B3v9Lz5iLUCAJoYp4ByATQ6ZY8HzhRoqExsoiVRjDnjg3
   sJDrqGcyxKc2wV1MNlsD2kFo8lt1M1JQip8bpXHw5rj4U75gJ0L0ZCJ2a
   q2TPq9MQMEffigM/yJPF2I6H5QhB1WjROjnz/FZGise33M7mF4xRsCWQr
   E=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="454338111"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:10:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:65158]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.236:2525] with esmtp (Farcaster)
 id c7bdd403-86c9-4aa2-a733-b9752778dfd8; Wed, 15 Jan 2025 08:10:07 +0000 (UTC)
X-Farcaster-Flow-ID: c7bdd403-86c9-4aa2-a733-b9752778dfd8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:10:02 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:09:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/11] ipv6: Set cfg.ifa_flags before device lookup in inet6_rtm_newaddr().
Date: Wed, 15 Jan 2025 17:06:05 +0900
Message-ID: <20250115080608.28127-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will convert inet6_rtm_newaddr() to per-netns RTNL.

Except for IFA_F_OPTIMISTIC, cfg.ifa_flags can be set before
__dev_get_by_index().

Let's move ifa_flags setup before __dev_get_by_index() so that
we can set ifa_flags without RTNL.

Also, now it's moved before tb[IFA_CACHEINFO] in preparing for
the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Move ifa_flags setup before tb[IFA_CACHEINFO].
---
 net/ipv6/addrconf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0e7ca74012aa..9720ff17f0a1 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5021,6 +5021,13 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[IFA_PROTO])
 		cfg.ifa_proto = nla_get_u8(tb[IFA_PROTO]);
 
+	cfg.ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
+
+	/* We ignore other flags so far. */
+	cfg.ifa_flags &= IFA_F_NODAD | IFA_F_HOMEADDRESS |
+			 IFA_F_MANAGETEMPADDR | IFA_F_NOPREFIXROUTE |
+			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
+
 	cfg.valid_lft = INFINITY_LIFE_TIME;
 	cfg.preferred_lft = INFINITY_LIFE_TIME;
 
@@ -5038,13 +5045,6 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -ENODEV;
 	}
 
-	cfg.ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
-
-	/* We ignore other flags so far. */
-	cfg.ifa_flags &= IFA_F_NODAD | IFA_F_HOMEADDRESS |
-			 IFA_F_MANAGETEMPADDR | IFA_F_NOPREFIXROUTE |
-			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
-
 	idev = ipv6_find_idev(dev);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
-- 
2.39.5 (Apple Git-154)


