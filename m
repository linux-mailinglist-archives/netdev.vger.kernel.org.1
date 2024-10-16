Return-Path: <netdev+bounces-136256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674D9A120C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DB1B2186F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1B2141A0;
	Wed, 16 Oct 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PH3nJxyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AF212EF5
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104870; cv=none; b=fiCmoQfac2wNuASXTBEwoiKFmmsT0iS8UKmDEQzOliTv7TBAu9wdRDFmL6Yr1eVZ2ChkyB29RehToq+MLn9yHUcUAv5SPPci0Uujlps0dN/lmoR2Bri7FphmBIvu/2YZnIUGmZA0QDM/GQYVX7+7YE8WWiiQIW0jDntkJFiZNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104870; c=relaxed/simple;
	bh=ffT1Y75GxLuCsHaohRqvntwjyCA1CcCOcuUuTEkT/Rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyDHUt85DK1H1014FjmbW6aMMz87DKOm91h0sa8BJf4d5kfFg8Dk2tmJMHmVGqNR2IPcVP42Gb4wBQYO7sWMjZKv7Lw2zjisq2uT4OwcrGIVnfa0YfHnnUqs4eH/xHAPKRa8Ef+zJ2GlL6L7mFMPylslxLlTTbCjclPKTRN27+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PH3nJxyb; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729104869; x=1760640869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xh6NXn+U56xe6ETuyABeMM/A5DxrCneotb9e+/v4qVw=;
  b=PH3nJxyb5AWYU+HJ7/y9VltGot897/6o2K0gi878HwmD9L9VdSjiYkxV
   Yoqc3ffgOIis30wK5mpVt1yznXCs8VnWIJNhWXcyR+Lj38wsgBDwhDJx5
   USGIAUlaOlswmQu8hfhL7JzcYP7ObBwm8fKvUq7PEt4Wj/ExBHs8jWFBu
   M=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="138739113"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:54:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:54488]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 8f36ccbf-bc2d-4794-89d2-12e0f2c0d083; Wed, 16 Oct 2024 18:54:27 +0000 (UTC)
X-Farcaster-Flow-ID: 8f36ccbf-bc2d-4794-89d2-12e0f2c0d083
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:54:26 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:54:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/14] rtnetlink: Allocate linkinfo[] as struct rtnl_newlink_tbs.
Date: Wed, 16 Oct 2024 11:53:44 -0700
Message-ID: <20241016185357.83849-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will move linkinfo to rtnl_newlink() and pass it down to other
functions.

Let's pack it into rtnl_newlink_tbs.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a9c92392fb1d..37193402a42c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3622,6 +3622,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 struct rtnl_newlink_tbs {
 	struct nlattr *tb[IFLA_MAX + 1];
+	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
 	struct nlattr *attr[RTNL_MAX_TYPE + 1];
 	struct nlattr *slave_attr[RTNL_SLAVE_MAX_TYPE + 1];
 };
@@ -3630,7 +3631,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct netlink_ext_ack *extack)
 {
-	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
+	struct nlattr ** const linkinfo = tbs->linkinfo;
 	struct nlattr ** const tb = tbs->tb;
 	const struct rtnl_link_ops *m_ops;
 	struct net_device *master_dev;
@@ -3685,8 +3686,9 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 						  ifla_info_policy, NULL);
 		if (err < 0)
 			return err;
-	} else
-		memset(linkinfo, 0, sizeof(linkinfo));
+	} else {
+		memset(linkinfo, 0, sizeof(tbs->linkinfo));
+	}
 
 	if (linkinfo[IFLA_INFO_KIND]) {
 		nla_strscpy(kind, linkinfo[IFLA_INFO_KIND], sizeof(kind));
-- 
2.39.5 (Apple Git-154)


