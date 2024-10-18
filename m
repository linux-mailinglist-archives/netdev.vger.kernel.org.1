Return-Path: <netdev+bounces-136792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CA29A3209
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127B7280F1B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B95478E;
	Fri, 18 Oct 2024 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DvWsIvhv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D403A1CD
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214731; cv=none; b=UpjgYXoQJpw7dk5VZgtOQ8rlurefed8q+ybbf/piK0yEBqQGO2cINKLkfLkWeoJwJQrN4qObgoDaszVUGynN6qUyf4a9TVln8rXAch6aIKXuQqxZq3vanaoCxo0PHS7a3RVfDv5gyywrFkfDIJYOuhMati+i4Cqwtvd4tgVnSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214731; c=relaxed/simple;
	bh=pBwulSh9feGnvPdde9jWdZ9D3s5s45GJydm5HgV80iM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2/53wmyQrvEcn9K/jYv5M1upopIlvNUFPCpwheRqGEDh7/cLPSrRExcubjVJEK/c1qcONFcyY7sJMvsIMTgD9O4WVxeQoXC6duX+bF3Y//LBLLebvdyD5WWLW6tss9sfeLLwniNalDNlI7XLrZe9MCz2szBvnrsVw+Q8Emz8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DvWsIvhv; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214730; x=1760750730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gockCXDiDM8O5/W/ViGyDfNHxzMYF0Pp32bq/D9ADjw=;
  b=DvWsIvhvV/AgKnee1GM+/+A8n0AKj1K/fdb2JalPvkrJTTqmrXGBxPmr
   zWvM4PGiohNx0OBl4lBZRDLFCPzFNQC/hdHyG00twSN88RSMlw0gyxqqb
   XPpYIaUp/2phyFBpJqKPqjODRyuTwR5w7bQl68Fi6VP9MaVGFSQfXZcjT
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="767837347"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:25:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:28899]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id e9adb81f-e523-4eb9-90c6-b65db5a1362f; Fri, 18 Oct 2024 01:25:28 +0000 (UTC)
X-Farcaster-Flow-ID: e9adb81f-e523-4eb9-90c6-b65db5a1362f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:25:27 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:25:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/11] ipv4: Convert devinet_sysctl_forward() to per-netns RTNL.
Date: Thu, 17 Oct 2024 18:22:23 -0700
Message-ID: <20241018012225.90409-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

devinet_sysctl_forward() touches only a single netns.

Let's use rtnl_trylock() and __in_dev_get_rtnl_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index f8e232dbb96a..1cc2c2b4a10a 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2380,7 +2380,7 @@ static void inet_forward_change(struct net *net)
 		if (on)
 			dev_disable_lro(dev);
 
-		in_dev = __in_dev_get_rtnl(dev);
+		in_dev = __in_dev_get_rtnl_net(dev);
 		if (in_dev) {
 			IN_DEV_CONF_SET(in_dev, FORWARDING, on);
 			inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
@@ -2471,7 +2471,7 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 
 	if (write && *valp != val) {
 		if (valp != &IPV4_DEVCONF_DFLT(net, FORWARDING)) {
-			if (!rtnl_trylock()) {
+			if (!rtnl_net_trylock(net)) {
 				/* Restore the original values before restarting */
 				*valp = val;
 				*ppos = pos;
@@ -2490,7 +2490,7 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 							    idev->dev->ifindex,
 							    cnf);
 			}
-			rtnl_unlock();
+			rtnl_net_unlock(net);
 			rt_cache_flush(net);
 		} else
 			inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
-- 
2.39.5 (Apple Git-154)


