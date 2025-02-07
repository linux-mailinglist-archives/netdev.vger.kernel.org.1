Return-Path: <netdev+bounces-163810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85DA2BA59
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 05:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4F5166DC5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34522154439;
	Fri,  7 Feb 2025 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FQhr30Wb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1B47F4A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738903400; cv=none; b=EnpdU3u228Djmi4UO1HSKT/GN+CpfU4wgmidebuhIxYruAcA+JrgpfwWpuwHZdBbX1+H7GMWiDRMDs9srIpO4cMwZ50w5VLKYUoA417fKecPaxDtpZADAPLoI4vd7SRNXKQcm+mylXCRwqz9lV8kAqMXG6PUttbc3jSzTdRs3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738903400; c=relaxed/simple;
	bh=JtU8AyajcRxKkCY4IjSa55guEej6KDQAuNK26V0YGLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e/yiln8DhrgUHcEAAfFSGP48SrmUHzjmPi/ziEpzgDQ9wHH9a2iGprLU82OD6/QJK8Xkr/OGgsY6G2dsGGKKqLTWINM7o8/Kay+VlRx49pn8cSDLsrISjLciS4f7q23MeYE69Yyp7ijNaLRd4XZtT3yVwbGWS0ce+GUCdwQR9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FQhr30Wb; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738903398; x=1770439398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2k2C/1uSqN6d5nTFlpq37m0h4V0VQifPBNQhtLE+heE=;
  b=FQhr30Wbyg58hXiAWQqX5lO82Q3PYZgQIV7GjwIZawkc3Hc8f1J2pBMm
   4RPSzir9jQQnHUZYUwABxrjuZSko877t6PRsT9NLis5/lOBAYMa/mQyuT
   EW0AhvJ7eXZddHLto6T76t/S1NXU8L2XA8aIgSDlHO9R0wOoWFjYigDFQ
   4=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="406636402"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 04:43:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:35706]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id ac7fa5bc-b033-415f-b305-06a3732203dd; Fri, 7 Feb 2025 04:43:10 +0000 (UTC)
X-Farcaster-Flow-ID: ac7fa5bc-b033-415f-b305-06a3732203dd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 04:43:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 04:43:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/2] net: Fix race of rtnl_net_lock(dev_net(dev)).
Date: Fri, 7 Feb 2025 13:42:49 +0900
Message-ID: <20250207044251.65421-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Yael Chemla reported that commit 7fb1073300a2 ("net: Hold rtnl_net_lock()
in (un)?register_netdevice_notifier_dev_net().") started to trigger KASAN's
use-after-free splat.

The problem is that dev_net(dev) fetched before rtnl_net_lock() might be
different after rtnl_net_lock().

The patch 1 fixes the issue by checking dev_net(dev) after rtnl_net_lock(),
and the patch 2 fixes the same potential issue that would emerge once RTNL
is removed.


Changes:
  v2:
    * Use dev_net_rcu()
    * Use msleep(1) instead of cond_resched() after maybe_get_net()
    * Remove cond_resched() after net_eq() check

  v1: https://lore.kernel.org/netdev/20250130232435.43622-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
  dev: Use rtnl_net_dev_lock() in unregister_netdev().

 net/core/dev.c | 69 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 17 deletions(-)

-- 
2.39.5 (Apple Git-154)


