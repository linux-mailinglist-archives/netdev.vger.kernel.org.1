Return-Path: <netdev+bounces-134713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF5899AE81
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141FFB21447
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30241D1E7F;
	Fri, 11 Oct 2024 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M1BIVwaB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82E1D1E72
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684537; cv=none; b=uYCfCY60kZML+6VlG6ROlTBUaYiIrCAClAwK1CXrAAY+iOck8WpnkPikTySDIzeJM+OqX485YxAGLU3GJ54ko6Tkbjm+eFOp0uggh5ZajXL5oQuM260JYpv55NwZBnF/mUwST/ulEYwTuje58GeW74eoE5r8c2cRkPDHXvhtg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684537; c=relaxed/simple;
	bh=wDzyL0up9g+8O6GCJy50C6oR8hAQcVHRkSpL2gV54ZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdpYRoPfESS8Wd2j1eQ2KoFACO+OuMtfBUB2wtDwDesQdsj4YgEUe/0GHgppFZd5ZAMRG1jXmJhddsGIfsoz8P8/dj8Cqm3s/WGq3/A425VGRoVn8lDsLxJA/SosPgSY58dVjYbE/dbcgmLa5ujykfZR/LtVjmgRolQqbAuj+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=M1BIVwaB; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684536; x=1760220536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X6nJomTu47Ltda+1poNuUgwGka5GsjY3n9TMkit5K6E=;
  b=M1BIVwaBuAjqbgOsJTSRrgCRF1Yo56fO93gk3IX+GPHPcd1Ncn9+Z15v
   sZqPqOHTbPN36B1aNq1ME2dmkB+CdLDNHHla+DsaYdn/3mJBLsq/tqnS9
   DsiQdhTeVd0XIzyXt95yYDLdPvsz0cfOedHatFm3k+wjVYwFu1XKrjqiU
   8=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="32613826"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:08:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:19518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 503c4393-d2e1-49ab-a788-e3818b8c2699; Fri, 11 Oct 2024 22:08:53 +0000 (UTC)
X-Farcaster-Flow-ID: 503c4393-d2e1-49ab-a788-e3818b8c2699
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:08:52 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:08:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/11] dcb: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:48 -0700
Message-ID: <20241011220550.46040-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241011220550.46040-1-kuniyu@amazon.com>
References: <20241011220550.46040-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/dcb/dcbnl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 2e6b8c8fd2de..c05d8400e616 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -2408,6 +2408,11 @@ static struct notifier_block dcbnl_nb __read_mostly = {
 	.notifier_call  = dcbnl_netdevice_event,
 };
 
+static const struct rtnl_msg_handler dcbnl_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_GETDCB, dcb_doit, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_SETDCB, dcb_doit, NULL, 0},
+};
+
 static int __init dcbnl_init(void)
 {
 	int err;
@@ -2416,8 +2421,7 @@ static int __init dcbnl_init(void)
 	if (err)
 		return err;
 
-	rtnl_register(PF_UNSPEC, RTM_GETDCB, dcb_doit, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_SETDCB, dcb_doit, NULL, 0);
+	rtnl_register_many(dcbnl_rtnl_msg_handlers);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


