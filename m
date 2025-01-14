Return-Path: <netdev+bounces-158016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8648DA101C0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5357188386C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69137246327;
	Tue, 14 Jan 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ys5PRgUp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255024635B
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842129; cv=none; b=XvPM8ibC0fJhV5dNl1qj+tGott9+g8mWT/GZRW+zAvhHZrGNF+SLKRteJjgpcp0s8JN2tmEa/GMbl8lt/R8d1XUAI6V7MznpWXQG+l10OIOsyp0BlY9b5XvtZHq1FvVqt795Y+GQm7CKMwe3J79AfGoEL5ogOwf5yE6PcGy7xW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842129; c=relaxed/simple;
	bh=BhKq9Jtvpd7UlsIEqqewKZuyT5TRXRMdGJUs0D6rwAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/GNNJMHajUEquhyy0HfB9LQTdht3GJlUTPj7ATr+z6LKh0RcxJkA3w1TY/AMaQ5XuAYWoog6KPdujad2JD7wJ61hBEK+uyFAuSrGUnZf5aeptGZxvm0ZC8tf73CNpmjKRbViD69Ju4WS5/Wc092qshPiSihQ+n2bo4rKXmH5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ys5PRgUp; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842128; x=1768378128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLoW25UkqWbVDZs5glu4nZZda0wirZl96FdfKOEHjbA=;
  b=Ys5PRgUpRHshHEkbZnJSB3f18ZKAYSUD2ywabrU8BWiKOHbd3mdQaDB1
   xWXqGCTX6LE/igf5tt7N8V/VVgmf7PSq2u8e+jkNmTHXOXIZT+6FwGcU5
   RzHAO2jrjPh053RGc8BSJdHiIQHeERbIg3Nl2U1njcubPOQRnv39d377M
   o=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="400676163"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:08:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:37035]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.5:2525] with esmtp (Farcaster)
 id 8f0deb36-63ca-40a4-aaf6-b587883d563d; Tue, 14 Jan 2025 08:08:47 +0000 (UTC)
X-Farcaster-Flow-ID: 8f0deb36-63ca-40a4-aaf6-b587883d563d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:08:46 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:08:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/11] ipv6: Set cfg.ifa_flags before device lookup in inet6_rtm_newaddr().
Date: Tue, 14 Jan 2025 17:05:12 +0900
Message-ID: <20250114080516.46155-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will convert inet6_rtm_newaddr() to per-netns RTNL.

Except for IFA_F_OPTIMISTIC, cfg.ifa_flags can be set before
__dev_get_by_index().

Let's move __dev_get_by_index() down so that we can set
ifa_flags without RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9c7257b28a84..0daea381d541 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5032,12 +5032,6 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg.preferred_lft = ci->ifa_prefered;
 	}
 
-	dev =  __dev_get_by_index(net, ifm->ifa_index);
-	if (!dev) {
-		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
-		return -ENODEV;
-	}
-
 	cfg.ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
 
 	/* We ignore other flags so far. */
@@ -5045,6 +5039,12 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 IFA_F_MANAGETEMPADDR | IFA_F_NOPREFIXROUTE |
 			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
 
+	dev =  __dev_get_by_index(net, ifm->ifa_index);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
+		return -ENODEV;
+	}
+
 	idev = ipv6_find_idev(dev);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
-- 
2.39.5 (Apple Git-154)


