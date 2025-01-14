Return-Path: <netdev+bounces-158021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D53AA101D4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DF13A7536
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD12500C3;
	Tue, 14 Jan 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PPdB/VNL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22342500C8
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842455; cv=none; b=gE4lIiR/0P+LfrDYHP9Ht7qQdQCKQklmajYXDEMafcqko6WQ17S3+iPLpJHQI3Du3sZXUzp8pWspavz+w2mSPRHM85kIh7yeJbrEMxnyKB7XvtOS9X+4Renu+ftUCBdqUeogdGLzjS6tVhcM9Pt9Cw6JNK4d2VYRCFBfsmtTAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842455; c=relaxed/simple;
	bh=QoCdRlCUyzkAPnuiLvluoUZrJph8le4qX279QshU7Jo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ef/jwbqXljaixKWDqPIfMKqaAjh18emcDNN80v9sf/AG7OnThQs5V4EfH35LJgsFrb99rgTRYsmlH6/axTsCQKXQrB6tEzVTdp0cnxyaG/Q1bobhGBkm53lAr27EMrx9HONlgBu8e7vqy87GeuObVDcI/DR+78rnM4ZKKLoBa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PPdB/VNL; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842454; x=1768378454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lf/QlJkTcHOKSledkrOyDbAVS6vKRGaDlVYqVjWTuqs=;
  b=PPdB/VNLTKMov3w5AUH84rSnxJ18WDh9AUhokjsjLlBLedtNjXcyoaTi
   nDMjB0O+l1+cE0Jos8R1skOs/5I0rcw0qpAzqha++j592vxNoS0CkPH4+
   4fq7Ngd0iD5EuZ1XnPvo48GpIFMUUMM6T/vssIlPYq288GeYH58vGMcLH
   M=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="454038485"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:14:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:27829]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.70:2525] with esmtp (Farcaster)
 id 054f0fa6-67f0-48f8-b59d-98e4564abf55; Tue, 14 Jan 2025 08:14:11 +0000 (UTC)
X-Farcaster-Flow-ID: 054f0fa6-67f0-48f8-b59d-98e4564abf55
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:14:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:14:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] net: loopback: Hold rtnl_net_lock() in blackhole_netdev_init().
Date: Tue, 14 Jan 2025 17:13:52 +0900
Message-ID: <20250114081352.47404-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

blackhole_netdev is the global device in init_net.

Let's hold rtnl_net_lock(&init_net) in blackhole_netdev_init().

While at it, the unnecessary dev_net_set() call is removed, which
is done in alloc_netdev_mqs().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/loopback.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 1993b90b1a5f..c8840c3b9a1b 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -264,13 +264,12 @@ static int __init blackhole_netdev_init(void)
 	if (!blackhole_netdev)
 		return -ENOMEM;
 
-	rtnl_lock();
+	rtnl_net_lock(&init_net);
 	dev_init_scheduler(blackhole_netdev);
 	dev_activate(blackhole_netdev);
-	rtnl_unlock();
+	rtnl_net_unlock(&init_net);
 
 	blackhole_netdev->flags |= IFF_UP | IFF_RUNNING;
-	dev_net_set(blackhole_netdev, &init_net);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


