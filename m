Return-Path: <netdev+bounces-117322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B55D494D94F
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F761F20F5D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758416D4D6;
	Fri,  9 Aug 2024 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p/vIaenx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB216D336
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247691; cv=none; b=cFBiWYaxLv1zNYwYTXetUPnvfUHUtGoa+pP+COKBJ04WY6YQROvGlMR5HkzkaXUXRYrD7GE8Z2YB2XS4ARyFTjC+DnKawDL7qe96l6ttX2MP6z9vWb+XpNA8sTsfmv8VfDhJN7QcGozxb7jyXsQ2VazD7YcMgZGgdqWPwcPt8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247691; c=relaxed/simple;
	bh=1am5c+uZfzGwYEUCK6w+DhpL0oasHEbvIb7d9LHrvns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFzPFtayrb7pTNO848Ov4L98A62L4V/NU38Uci0IoTUGjbD9YAEoj1UQDv5wdNQ7CyeJetH1j55jk+dqyY3B5mdRFLu7QaEdncel/zYxmrNFAYnZ2yzUx1iNztDWRuQM751FfFu1sDiuCEkT3r3AnLmq0cgnf1fly7nwCMo1vbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p/vIaenx; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723247690; x=1754783690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeLWdRYJBFdywWu/54/JpExV5I5i449GABvBohOlQp8=;
  b=p/vIaenxiw75dDP9YZraiXKvXPKJrlMydz9AfY7LFfHycBeIAaaDDL9M
   rGKmb4kFTXXkDhkJ5fe6KzlBOfPqoPKpz/G1en40h1bhasJFWwkmrD8il
   7lLbqucEjP5MVThg5q1LC1e074svy15ELaoWKBhrhF7HDSD06p9LFSB/i
   k=;
X-IronPort-AV: E=Sophos;i="6.09,277,1716249600"; 
   d="scan'208";a="673101580"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 23:54:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:12005]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.16:2525] with esmtp (Farcaster)
 id 96101a8a-c94c-4df8-ab0a-bbc8a836c315; Fri, 9 Aug 2024 23:54:44 +0000 (UTC)
X-Farcaster-Flow-ID: 96101a8a-c94c-4df8-ab0a-bbc8a836c315
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:54:44 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:54:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/5] ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
Date: Fri, 9 Aug 2024 16:54:02 -0700
Message-ID: <20240809235406.50187-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

dev->ip_ptr could be NULL if we set an invalid MTU.

Even then, if we issue ioctl(SIOCSIFADDR) for a new IPv4 address,
devinet_ioctl() allocates struct in_ifaddr and fails later in
inet_set_ifa() because in_dev is NULL.

Let's move the check earlier.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index d96f3e452fef..ddab15116454 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -574,10 +574,6 @@ static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 
 	ASSERT_RTNL();
 
-	if (!in_dev) {
-		inet_free_ifa(ifa);
-		return -ENOBUFS;
-	}
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
 	if (ifa->ifa_dev != in_dev) {
@@ -1184,6 +1180,8 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 
 		if (!ifa) {
 			ret = -ENOBUFS;
+			if (!in_dev)
+				break;
 			ifa = inet_alloc_ifa();
 			if (!ifa)
 				break;
-- 
2.30.2


