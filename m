Return-Path: <netdev+bounces-167085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70378A38C28
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD991891417
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB364236A84;
	Mon, 17 Feb 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fF2SxzH8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23942228CB7
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819591; cv=none; b=MtnjmZcoLUMfCmvuddAWMb8jAvaPSs6FtikkHQy9V5/RdpxSQnDVs0SGSyqvwiPjfjMO5s5TDOgSnr0KPfwatXaVjKIVE70wb3pxVf9k/cSKyZIIJEMfLqE0hyua5SBx1iXbUusNPk2IB/8GZ0Wq4LCLpSE1QJg1A96hSID+wcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819591; c=relaxed/simple;
	bh=VwZ+8w5saKzyyeYir2ctH5t0wMhHbJlVLyjOG3LEBdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py2mzeabwnlRuE1yr5C09aEpdCRet+8Rzse87NXviCvJ11xMYoFAXj2pjT2QkP952fRsUVgC3OM1DX1xBhJPj78BvK+iY37A5XuGVCt0NRvrfFXs/TLkcNZTgBt0vetDw855jaCoXFj4OKN+lS+D0qG/b3l2dCTByh+Ke4mGdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fF2SxzH8; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739819590; x=1771355590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysE8Xi061vRqso7Gk1KkOeuKy7eA4Vkpyg+ofmdpFgQ=;
  b=fF2SxzH8psNs6yU+n2xwmyWxjak8LVQcG9tu3fl/p4H73uyRGsoau//r
   Q0g9kNmWV7xFtmXXoQqBEaue+cstG97WG6CCgeOk6P7uLd76pskZ4J0Pm
   0VfTq0GS8V58973Oiu/+/6FGFd6BTkvrL2ra2HWjSiwDSrqYX6in16R63
   4=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="23375572"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:13:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:10582]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.245:2525] with esmtp (Farcaster)
 id 54854648-77a3-4e4f-9461-5128c95838f3; Mon, 17 Feb 2025 19:13:07 +0000 (UTC)
X-Farcaster-Flow-ID: 54854648-77a3-4e4f-9461-5128c95838f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 19:12:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 19:12:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net 3/3] dev: Use rtnl_net_dev_lock() in unregister_netdev().
Date: Mon, 17 Feb 2025 11:11:29 -0800
Message-ID: <20250217191129.19967-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250217191129.19967-1-kuniyu@amazon.com>
References: <20250217191129.19967-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 19e268568282..fafd2f4b5d5d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11920,11 +11920,9 @@ EXPORT_SYMBOL(unregister_netdevice_many);
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


