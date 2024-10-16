Return-Path: <netdev+bounces-136257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27A9A120F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DE91F21767
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2822139AF;
	Wed, 16 Oct 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TpOWNwIu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080316E86F
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104895; cv=none; b=WjSdDnbhVMq/9HLLoiI8iIeEb7yBGwKKCo59xsHnFVZgOLo7B0VJ2uaM4mHpZt5Sbcqv337lEyi/cwIWVx8RI2kdt2XwobHQHq7erVWHeTrpZA16LJe+w1tsb/xG8cpHgsExypa6UH7tGKqHtUHYonITNNb1TfkvtBKvTElYGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104895; c=relaxed/simple;
	bh=v7SVuKHHOAbnGyO8I0pEyLEsizxQolUPvjJWz5TRskM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWMdda7uonsYjjhgrAKuwmzRKDYZmMhCpvCDB3IlTMA7+ogaC2vCxTVAwnx5xzaeGwTmI6sEw9C3tog7YZua+pHOZuHmrELBLC/kNUGOFCtR2R98gGpF5FHLPrL1LEP98/qsUv9kwgVp7Z1ODlnJWPdWJ1sYuD/qqqH9BmPkqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TpOWNwIu; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729104893; x=1760640893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0p3jAy+q+VjHr5EsEnUAhuEQSaCiymRFa6aNIOhAjU=;
  b=TpOWNwIung13facgRievPfqOMmY+2LQnAYpdF2Dl8bJINFpNUZuKxrIm
   MlZypLy8gZw67l8H1BFIgcUenumn4qR5NEt/ei/2DQ/Xd4IbrlTdZqITQ
   BsJqiMgpyDTkreqQmxOQ/iHHDgFN1XQ1PkayO2VA+uRE1LABD1jQzls/j
   0=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="666708139"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:54:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:7004]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 64034485-a2ae-4ae1-b283-ddf8f9a1889d; Wed, 16 Oct 2024 18:54:50 +0000 (UTC)
X-Farcaster-Flow-ID: 64034485-a2ae-4ae1-b283-ddf8f9a1889d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:54:46 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:54:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/14] rtnetlink: Call validate_linkmsg() in do_setlink().
Date: Wed, 16 Oct 2024 11:53:45 -0700
Message-ID: <20241016185357.83849-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
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

There are 3 paths that finally call do_setlink(), and validate_linkmsg()
is called in each path.

  1. RTM_NEWLINK
    1-1. dev is found in __rtnl_newlink()
    1-2. dev isn't found, but IFLA_GROUP is specified in
          rtnl_group_changelink()
  2. RTM_SETLINK

The next patch factorises 1-1 to a separate function.

As a preparation, let's move validate_linkmsg() calls to do_setlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 37193402a42c..76593de7014c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2855,6 +2855,10 @@ static int do_setlink(const struct sk_buff *skb,
 	char ifname[IFNAMSIZ];
 	int err;
 
+	err = validate_linkmsg(dev, tb, extack);
+	if (err < 0)
+		goto errout;
+
 	if (tb[IFLA_IFNAME])
 		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -3269,10 +3273,6 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
-	err = validate_linkmsg(dev, tb, extack);
-	if (err < 0)
-		goto errout;
-
 	err = do_setlink(skb, dev, ifm, extack, tb, 0);
 errout:
 	return err;
@@ -3516,9 +3516,6 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
-			err = validate_linkmsg(dev, tb, extack);
-			if (err < 0)
-				return err;
 			err = do_setlink(skb, dev, ifm, extack, tb, 0);
 			if (err < 0)
 				return err;
@@ -3744,10 +3741,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
-		err = validate_linkmsg(dev, tb, extack);
-		if (err < 0)
-			return err;
-
 		if (linkinfo[IFLA_INFO_DATA]) {
 			if (!ops || ops != dev->rtnl_link_ops ||
 			    !ops->changelink)
-- 
2.39.5 (Apple Git-154)


