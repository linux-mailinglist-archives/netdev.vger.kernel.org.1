Return-Path: <netdev+bounces-118972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99695953C15
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431F21F267C6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10714B092;
	Thu, 15 Aug 2024 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="emq4Trxp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6014A4D8
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754606; cv=none; b=FzuB4qR0j6hQaEDevaBYX/yxDy7alMSLTnijPgDG47nL2OyaBJQum6ZqbyUxv0EBiA2XXG8JHIDbet8NHi6hugkzFhEhHwVIBRfwLqRQ0B2Gvss1DjRsKgk90Dve7PJodE/AKHQms39n1UanE3ErPYp9XScueM18InCdWuDuh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754606; c=relaxed/simple;
	bh=tR6AAtnzr4ifyv4uLfYfeXZrBedBMyCqUHKxzK3IT54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0bmvoBc9cGcb27lkDL8YPpfrbUapBnjwmh/tpDAyVDGAOVD7Maa1Zzzf4zofW6HbHJarSYAeFaj0wFb4ZtRii7OdvV0dKARhBFqJ87JowOr9JgVmFDjp4FVSQ4dF1hfSftwyLaUru3LZKTRsHYus5y2WlhyiaC+AgiwZiwr4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=emq4Trxp; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723754605; x=1755290605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9nqPG81OosFh5oQ2zkH7uqY2XJwp28XZTxuMPCXeiJc=;
  b=emq4TrxpWNKblvScfYOETl7+7FiFpAVYLqX/nTjqQzLqYOCLeTbBfoz9
   Xt4hVLhyl/EAD/PcsH7YfPs4qXmYdnkqutf85QeUtr7XaUGZFR94AB0LM
   nF32snf+PM/xYioJH4EYOlTUn80JySRbcA7R6rE5SLhscqFaAZJbZsQ1s
   4=;
X-IronPort-AV: E=Sophos;i="6.10,149,1719878400"; 
   d="scan'208";a="421496196"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 20:43:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:13673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.29:2525] with esmtp (Farcaster)
 id 08a02d94-07c4-4e91-9e00-671f693b7d31; Thu, 15 Aug 2024 20:43:18 +0000 (UTC)
X-Farcaster-Flow-ID: 08a02d94-07c4-4e91-9e00-671f693b7d31
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 20:43:17 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 20:43:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
	<matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] mctp: Use __mctp_dev_get() in mctp_fill_link_af().
Date: Thu, 15 Aug 2024 13:42:54 -0700
Message-ID: <20240815204254.49813-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
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

Since commit 5fa85a09390c ("net: core: rcu-ify rtnl af_ops"),
af_ops->fill_link_af() is called under RCU.

mctp_fill_link_af() calls mctp_dev_get_rtnl() that uses
rtnl_dereference(), so lockdep should complain about it.

Let's use __mctp_dev_get() instead.

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/mctp/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index acb97b257428..7ffddab01e97 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -366,7 +366,7 @@ static int mctp_fill_link_af(struct sk_buff *skb,
 {
 	struct mctp_dev *mdev;
 
-	mdev = mctp_dev_get_rtnl(dev);
+	mdev = __mctp_dev_get(dev);
 	if (!mdev)
 		return -ENODATA;
 	if (nla_put_u32(skb, IFLA_MCTP_NET, mdev->net))
-- 
2.30.2


