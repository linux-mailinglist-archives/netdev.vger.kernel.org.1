Return-Path: <netdev+bounces-133951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96519978FD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0180B1C219EA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0919005B;
	Wed,  9 Oct 2024 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J/m3dcB5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4401885BE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515849; cv=none; b=B7XxAF+GXPJ4lO10INgwz/IDINyNCRRrEp6vMPknxO+nJhhuPNFrvCFOU8tUyCbYaw/Q/XZTLJLJQ/EjHQZGN0D09/KBEPtwZwYVHtupwvWMn+xUDoFEEoAKS0DP5SCtruT7D/sTOzqWohEHHxo0hmccG9lIjbKQwrsEGtErXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515849; c=relaxed/simple;
	bh=JHreDSpVat6/rTNOD90DaC49h0u1Z6fCAKwJNSRydq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0jbgHWy37UVPe076rCrbP2fyTYGRdF4W76GOLvK0SnNEZXqzCbHjNPEzXQ7xzaouodV3jVMeY/+exf4+wPTb5wbyKq1c5JtEm6lPWGGkPMn35hzHZ1omAEkvKqex+MikvIXRxhgF3XZbhO+Jpklfw3+uUaqK2TnbLHMxUh2o5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=J/m3dcB5; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515848; x=1760051848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/g6yoKOcCHebJk8k9ETW+E9qleF16n31DwMou/6MDw=;
  b=J/m3dcB5UZrQ6v+OvISxYBmbUzbMsrRfPU6piWHUz3w+giU0yThPuEpu
   EI23v4q+ZDPTacSKJE3s9Vqn9ee0jpqtI8V+ho2/hBDl07UT/LF8hj27P
   hPTFHGeAoKdl6zEY4l6aIsi4jOCp2+yZ+ZNfi3OjHfEODLeC3VwsFPyWS
   4=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="765253742"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:17:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:18265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 4038dce0-f800-4d8f-a6de-0ca7516042a2; Wed, 9 Oct 2024 23:17:22 +0000 (UTC)
X-Farcaster-Flow-ID: 4038dce0-f800-4d8f-a6de-0ca7516042a2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:17:22 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:17:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/13] rtnetlink: Allocate linkinfo[] as struct rtnl_newlink_tbs.
Date: Wed, 9 Oct 2024 16:16:44 -0700
Message-ID: <20241009231656.57830-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009231656.57830-1-kuniyu@amazon.com>
References: <20241009231656.57830-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will move linkinfo to rtnl_newlink() and pass it down to other
functions.

Let's pack it into rtnl_newlink_tbs.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6d68247aea70..abc44ee018a0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3621,6 +3621,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 struct rtnl_newlink_tbs {
 	struct nlattr *tb[IFLA_MAX + 1];
+	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
 	struct nlattr *attr[RTNL_MAX_TYPE + 1];
 	struct nlattr *slave_attr[RTNL_SLAVE_MAX_TYPE + 1];
 };
@@ -3629,7 +3630,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct netlink_ext_ack *extack)
 {
-	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
+	struct nlattr ** const linkinfo = tbs->linkinfo;
 	struct nlattr ** const tb = tbs->tb;
 	const struct rtnl_link_ops *m_ops;
 	struct net_device *master_dev;
@@ -3684,8 +3685,9 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


