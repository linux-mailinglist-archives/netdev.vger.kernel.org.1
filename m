Return-Path: <netdev+bounces-158385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F148A1188B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 05:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FDC3A499D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942031547D5;
	Wed, 15 Jan 2025 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Mc+BLtcG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E4232423
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 04:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915814; cv=none; b=GMisMZgSBvxp9O5GyXw/RjeDDzBwYTKNaFv7hXw8TZXchf6AVHtY7KuwvUE8/vL69ZDOKakdE0/sVPHyz/CzgJdDkj8l20SC1t5mW/q049OOeFZg73nKeMO3BOaBuUHopuVF3z7wF+pDMX6wHA0gFRxytORe2l9MEFrprJROT4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915814; c=relaxed/simple;
	bh=xdwHXkPrDi8yFdwEqsB1HFtQTx5jUPMiDrYo1QHVs0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJ65hr2xJrajpKaHPkxOZ2FPxq9OYw8aKaTbZLC/Jh78iemEoJiRY5R7hg5eTjyw6wrtJ+yiUb3VaeJVIhfnMmRsf8mP2ZP0ydjZy2HMfHKvSBjyawpcGoG/7quqYb7JGC3chAePLx4Supc1D++P4XMBFkY7u5EBtwGLw5xV0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Mc+BLtcG; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736915813; x=1768451813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/VVSJhzDGKbFbPCSh1jSlgZX8UWgADmLGXti7Py3F0=;
  b=Mc+BLtcGviDuZGBzjCedmknm5zBMj8xHizMcei0+VvG8/cqtHyFbgBrh
   OXrUBg0rARjFdAbwcTEW31QNofNbqC4sCXd8hDpZOoUBv9FABbtTPYMB0
   MgywpUz3U2IHQ6FxNLpKXTn14YjkYrmEw1zxtdfLxmv7/KiuXvr++/E7d
   8=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="454302514"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 04:36:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:59549]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.70:2525] with esmtp (Farcaster)
 id 9529cf20-58a0-4d62-aa22-12f9dc66af24; Wed, 15 Jan 2025 04:36:49 +0000 (UTC)
X-Farcaster-Flow-ID: 9529cf20-58a0-4d62-aa22-12f9dc66af24
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 04:36:48 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 04:36:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stfomichev@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 00/11] ipv6: Convert RTM_{NEW,DEL}ADDR and more to per-netns RTNL.
Date: Wed, 15 Jan 2025 13:36:35 +0900
Message-ID: <20250115043635.4429-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <Z4abUFyLfalEFCfz@mini-arch>
References: <Z4abUFyLfalEFCfz@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Tue, 14 Jan 2025 09:13:52 -0800
> On 01/14, Kuniyuki Iwashima wrote:
> > This series converts RTM_NEWADDR/RTM_DELADDR and some more
> > RTNL users in addrconf.c to per-netns RTNL.
> 
> This makes a lot of tests unhappy:
> https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2025-01-14--15-00&pw-n=0&pass=0
> 
> I have confirmed with a single one (drivers/net/ping.py) on my side,
> fails with:
> STDERR: b'ping: connect: Network is unreachable\n'

Oh sorry, I had to move lifetime validation after cfg.ifa_flags
initialisation, otherwise IFA_F_PERMANENT disappears.

Will squash the diff below to patch 9 in v2.

Thanks!

---8<---
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 721a4bceb107..9ae25a8d1632 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4974,9 +4974,16 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[IFA_PROTO])
 		cfg.ifa_proto = nla_get_u8(tb[IFA_PROTO]);
 
+	cfg.ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
+
+	/* We ignore other flags so far. */
+	cfg.ifa_flags &= IFA_F_NODAD | IFA_F_HOMEADDRESS |
+			 IFA_F_MANAGETEMPADDR | IFA_F_NOPREFIXROUTE |
+			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
+
+	cfg.ifa_flags |= IFA_F_PERMANENT;
 	cfg.valid_lft = INFINITY_LIFE_TIME;
 	cfg.preferred_lft = INFINITY_LIFE_TIME;
-	cfg.ifa_flags |= IFA_F_PERMANENT;
 	expires = 0;
 	flags = 0;
 
@@ -5009,13 +5016,6 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	cfg.ifa_flags = nla_get_u32_default(tb[IFA_FLAGS], ifm->ifa_flags);
-
-	/* We ignore other flags so far. */
-	cfg.ifa_flags &= IFA_F_NODAD | IFA_F_HOMEADDRESS |
-			 IFA_F_MANAGETEMPADDR | IFA_F_NOPREFIXROUTE |
-			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
-
 	dev =  __dev_get_by_index(net, ifm->ifa_index);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
---8<---

