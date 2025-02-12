Return-Path: <netdev+bounces-165421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE0A31F49
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B601884FE6
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0711FCFCC;
	Wed, 12 Feb 2025 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r/r3uBQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220521FCF62
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342625; cv=none; b=sSaxCtNyM+IRFqwS4qZIrZn0FjEAGQG/kugGyeyuwpouwiWXPF0AyssAZ97vuKiznZEy7lWu34kw+qbRifesrrCEBX19XNtx/dRXBaicrMgvHSimHuhk6tk8DGqdNQ5dVN2OEy3bCTaB3YcBbXXTV+m+RDolqnwHUejT426gKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342625; c=relaxed/simple;
	bh=bjAxE1UC+GY8fqxNhsT12qZqR6zho0lnV3KUsBXvROc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co9f4u6wqzWvgjxWJW0MNMIAWYAnVzmYfhSh3bzws1umy2vFJQbkdYWfte0lfFSLgudP3HgnOQeKbSu5P4hz8WjPak/tJUOd6h4IHL5CIoTfe/dnr9sEMer08nEBEroM7QvMS1viMaZp8cSwhbHJeTv0fzaeaIaPfUWYV3aHpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r/r3uBQ3; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739342624; x=1770878624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJeWCIGbj7sXuPDq5hkeCmotTu86gVs7RrHtI2TfCw4=;
  b=r/r3uBQ3ltU81kr5toICpay2R4cxcZdyKSqs1o2XSNAxKlr/jXIOfwDL
   eU6MpUydWf8t66g2HjMx4AY4Y9YuYfynRHpCi8hl6heIb0xDIFSUVPb5u
   1AFzZKDt8Cib3EbU8tQDekptzsOsNQ6kN2tJFRzXz/Zm/5ttD4EJTfnGA
   I=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="168946493"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:43:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:36066]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id cd18ea10-519a-4a24-9d36-383ae673211d; Wed, 12 Feb 2025 06:43:42 +0000 (UTC)
X-Farcaster-Flow-ID: cd18ea10-519a-4a24-9d36-383ae673211d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 06:43:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.86) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Feb 2025 06:43:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net 3/3] dev: Use rtnl_net_dev_lock() in unregister_netdev().
Date: Wed, 12 Feb 2025 15:42:06 +0900
Message-ID: <20250212064206.18159-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212064206.18159-1-kuniyu@amazon.com>
References: <20250212064206.18159-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The following sequence is basically illegal when dev was fetched
without lookup because dev_net(dev) might be different after holding
rtnl_net_lock():

  net = dev_net(dev);
  rtnl_net_lock(net);

Let's use rtnl_net_dev_lock() in unregister_netdev().

Note that there is no real bug in unregister_netdev() for now
because RTNL protects the scope even if dev_net(dev) is changed
before/after RTNL.

Fixes: 00fb9823939e ("dev: Hold per-netns RTNL in (un)?register_netdev().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6a39fb5baa92..b6b1f597935f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11934,11 +11934,9 @@ EXPORT_SYMBOL(unregister_netdevice_many);
  */
 void unregister_netdev(struct net_device *dev)
 {
-	struct net *net = dev_net(dev);
-
-	rtnl_net_lock(net);
+	rtnl_net_dev_lock(dev);
 	unregister_netdevice(dev);
-	rtnl_net_unlock(net);
+	rtnl_net_dev_unlock(dev);
 }
 EXPORT_SYMBOL(unregister_netdev);
 
-- 
2.39.5 (Apple Git-154)


