Return-Path: <netdev+bounces-155136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C4A01346
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9BD3A408A
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE39148FF0;
	Sat,  4 Jan 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AhhQnHdo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2235959
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735978987; cv=none; b=hJkyEkTA8yFoeUwa5lvlo8FIh8HTZCb423dDTa8yRbuzrV7+5QINbRO8ZxFaeti9UUMRUVFCBU8/PPl2eNilKXi0+fPYme1HLVr2puhtmv+yjRaCKc6hLCsZUtx+X1SQarv6O/07m9er+FfxbtsXP9NdaUWMr0s8/rXbhYt5a1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735978987; c=relaxed/simple;
	bh=C8/fzJCWw6ZYVHDxK7QpcjuRcv+MmjBN9CJcL/jK2HI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3TXYCAg464YgiCuAf/ftLAnvDn9PXeu7/Vv+TvISN84OqDZLE4E4jvYu1AP4MwDJ6AxOl8KkJ9UHFc7/e4vH0ou+x9Vry8lhvZqDsSZ1eQnQoe2jr0dSTeVa1FukNo4ljHiVTwyxD+de5SyNgjUXDg7/f7BcXiovuVdLFsB80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AhhQnHdo; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735978986; x=1767514986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XlPRY2oSCVdJJyixs2p5IBB6EtbsMvLgDoRkRreTxDg=;
  b=AhhQnHdoLLmoYagsQ8XKpeXyckoGpSAGAbnywLha3D4fNqHrW4on+AmH
   18N1TmXhgeu3A2bqzXSR4fEGqiPmF3fOyt8bs5wm8HZvoa+fBOjQOJA5X
   bJbAAZdl7MhH4rwJR5o6owNR6kMlKw5SF72ulhdP5vJC35leyTapPfAHw
   w=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="161636089"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 08:23:04 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:64303]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.34:2525] with esmtp (Farcaster)
 id 3cbdec48-c547-426a-a79f-5e9efa301e62; Sat, 4 Jan 2025 08:23:04 +0000 (UTC)
X-Farcaster-Flow-ID: 3cbdec48-c547-426a-a79f-5e9efa301e62
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 08:23:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 08:23:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/2] dev: Hold per-netns RTNL in (un)?register_netdev().
Date: Sat, 4 Jan 2025 17:21:49 +0900
Message-ID: <20250104082149.48493-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250104082149.48493-1-kuniyu@amazon.com>
References: <20250104082149.48493-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's hold per-netns RTNL of dev_net(dev) in register_netdev()
and unregister_netdev().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e7223972b9aa..073f682a9653 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10731,12 +10731,16 @@ EXPORT_SYMBOL_GPL(init_dummy_netdev);
  */
 int register_netdev(struct net_device *dev)
 {
+	struct net *net = dev_net(dev);
 	int err;
 
-	if (rtnl_lock_killable())
+	if (rtnl_net_lock_killable(net))
 		return -EINTR;
+
 	err = register_netdevice(dev);
-	rtnl_unlock();
+
+	rtnl_net_unlock(net);
+
 	return err;
 }
 EXPORT_SYMBOL(register_netdev);
@@ -11606,9 +11610,11 @@ EXPORT_SYMBOL(unregister_netdevice_many);
  */
 void unregister_netdev(struct net_device *dev)
 {
-	rtnl_lock();
+	struct net *net = dev_net(dev);
+
+	rtnl_net_lock(net);
 	unregister_netdevice(dev);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 }
 EXPORT_SYMBOL(unregister_netdev);
 
-- 
2.39.5 (Apple Git-154)


