Return-Path: <netdev+bounces-165043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A5A302B2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D715E188AB3D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 05:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0691D6194;
	Tue, 11 Feb 2025 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OA+GaQYC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209D26BDA8
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739250762; cv=none; b=YCZgDxujWpsJiRWe5IFeyv2SICLd22HCe3hsbZgp7OrOUnkaGceeGpHEpxz+XKx16qbSNAaWkGulGEMPDPxZVdHWyeP9mbUUS0WlucYhksyto7i1RfmvkE/Cc4+ondeSVhTlzrTxu2wFUOxmU5Y805lO2unU4BzRyJi+b4qubio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739250762; c=relaxed/simple;
	bh=hfCXppj1rauDuVBhYWqoCnCof6oaonz9754ryUFvo2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VMPdFrN2kXQxEn6Fqcz+l20wBA7UrlGsZQyblUiai8wAUC6513mRKOmqz+rU37g5W9KLlMO7c/KCz3ryn9g4ik6Dlt/qsmIsq/FDfKU3lGTI9c/iURj+4hkmGnEiLeg7+tLdH2fyWzdfnvbUrjGGZFE7X0RRWmx7Om58wMal410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OA+GaQYC; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739250761; x=1770786761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XvLA829JmDh+XuNfFME5YpSOctf+V6dfToA+elqDQXI=;
  b=OA+GaQYCOXwFsCUqm4yaiTxW7wkSh48NX+KT9UyXXqmBasIbhwLarvrJ
   E3fSPzkjhrEDPID+/FKtkbEE3ACAajrLGtwM8OMX933fur4zHTxbFPGFv
   pL2AGDS44FzOXj+HSgmfPQNEixGypAvh3TcgA9xKJSC08tCm5K6Sue3Gz
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,276,1732579200"; 
   d="scan'208";a="64909689"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 05:12:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:5671]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.246:2525] with esmtp (Farcaster)
 id 5e3bef58-edb8-400d-a9dc-dbbcf81b1e8c; Tue, 11 Feb 2025 05:12:36 +0000 (UTC)
X-Farcaster-Flow-ID: 5e3bef58-edb8-400d-a9dc-dbbcf81b1e8c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 05:12:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 05:12:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net 0/2] net: Fix race of rtnl_net_lock(dev_net(dev)).
Date: Tue, 11 Feb 2025 14:12:15 +0900
Message-ID: <20250211051217.12613-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Yael Chemla reported that commit 7fb1073300a2 ("net: Hold rtnl_net_lock()
in (un)?register_netdevice_notifier_dev_net().") started to trigger KASAN's
use-after-free splat.

The problem is that dev_net(dev) fetched before rtnl_net_lock() might be
different after rtnl_net_lock().

The patch 1 fixes the issue by checking dev_net(dev) after rtnl_net_lock(),
and the patch 2 fixes the same potential issue that would emerge once RTNL
is removed.


Changes:
  v3:
    * Bump net->passive instead of maybe_get_net()
    * Remove msleep(1) loop
    * Use rcu_access_pointer() instead of rcu_read_lock().

  v2:
    * Use dev_net_rcu()
    * Use msleep(1) instead of cond_resched() after maybe_get_net()
    * Remove cond_resched() after net_eq() check

  v1: https://lore.kernel.org/netdev/20250130232435.43622-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
  dev: Use rtnl_net_dev_lock() in unregister_netdev().

 net/core/dev.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

-- 
2.39.5 (Apple Git-154)


