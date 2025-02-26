Return-Path: <netdev+bounces-169654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C01A451B4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77D57A1F85
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 00:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC020328;
	Wed, 26 Feb 2025 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fb6nbj7K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE88C11
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530839; cv=none; b=b2TvkESCLj5ImQ5e16xBRa5/OfQwlfwDZYjbS6B4UhJmYXiQXpVpbCdzWlvn0o/9JE1xPbsc2gdr1jklR0G76b89THAvXV/l4yiFe/t5DDH3/Dm7WzlK75pHusQDrGdJChTSSFDK5crLHneLn5pSwO+Ep8t9Mw9HmKsZZReaDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530839; c=relaxed/simple;
	bh=pnwgXRfOnmpeUM02m1pqK2tJe9N1ca9L31gJDIvn648=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDbsV2pyLF2CRWAURMrwoqj76ShpGkULnB4noZ5sfP6RkBo0tHnX4mNtRKAux1/HIG5Cm6D9wvP6nfWkJ+WT1AnxfOpz8ce5M6wfjx33lozHEbj+LD1qu6jVUFfkzi966iKvvT0bIiolCm2Pt+NPGbkgPLZQEoU52MnXTLeSekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fb6nbj7K; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740530838; x=1772066838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xf009gOFuCYWJAKCOi3v4iB2mu8Gi1+bc5k7o6KSuq8=;
  b=Fb6nbj7KgJfcDllzONIKgqpCYZ+fDOYuAHr5B+p3dO8ogeMS7ra1K+X6
   dT07S13ZPkB+uM/aOwHYQhBD+W6TM+LRpt+NMKWigZx+FxbFJNkcWoAE9
   g7lWlfwzAGNB6jvraJkRIVswLzZTelIAPA13g50+OvSDDxjRzOUzOqZNQ
   g=;
X-IronPort-AV: E=Sophos;i="6.13,316,1732579200"; 
   d="scan'208";a="274349009"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:47:14 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:50295]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525] with esmtp (Farcaster)
 id 83602b6e-f3e4-4981-b50d-6e03fd995bc0; Wed, 26 Feb 2025 00:47:13 +0000 (UTC)
X-Farcaster-Flow-ID: 83602b6e-f3e4-4981-b50d-6e03fd995bc0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 00:47:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 00:47:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Date: Tue, 25 Feb 2025 16:46:57 -0800
Message-ID: <20250226004657.36987-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225162448.3a3c4133@kernel.org>
References: <20250225162448.3a3c4133@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 25 Feb 2025 16:24:48 -0800
> On Tue, 25 Feb 2025 10:22:38 -0800 Kuniyuki Iwashima wrote:
> > Patch 1 is a misc cleanup.
> > Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
> > Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().
> 
> Breaks quite a few tests :(

Oh, sorry... why I didn't notice this silly mistake :/
I enabled kmemleak on my debug config.
Will fix in v2.

---8<---
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index b9ead0257340..34cfea5c127b 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1666,7 +1666,7 @@ static void __net_exit fib_net_exit(struct net *net)
 {
 	fib_proc_exit(net);
 	nl_fib_lookup_exit(net);
-	fib4_semantics_init(net);
+	fib4_semantics_exit(net);
 }
 
 static void __net_exit fib_net_exit_batch(struct list_head *net_list)
---8<---


> 
> unreferenced object 0xffff88800bfc6800 (size 256):
>   comm "ip", pid 577, jiffies 4294699578
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     __kmalloc_node_noprof+0x35d/0x4a0
>     fib4_semantics_init+0x25/0xf0
>     fib_net_init+0x17e/0x340

