Return-Path: <netdev+bounces-114676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A89436DC
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C28B210CF
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503084EB5E;
	Wed, 31 Jul 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WAc5P8NQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5C381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456560; cv=none; b=s51ffYYYMsK7A5A3h4M+zOOdM5yJlRe00AJuE1kM8a6I56uWC9jGyTpurN0D4fD44GSlDI1qKhkEk5Aw8pkiZVwX/ppucSJypVeUy8xKZO4E+GFe5JxLkIaEwNwSmGex1wzUeV+w6q5eBV66OZFezdNag6Z/HvFe+ReXQSpsKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456560; c=relaxed/simple;
	bh=J5UqowP4cEjACltpNPKIXgMKy7UhqXvYc6Cxh5QgeMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSnqJJ2hEXzfyJVIFEsslFtr+gsKkjQeCH8xFcDQOIKpyCuVxwkyaRSwZNPQjgniYIsz+NvsdnSnKoQeGNO3lq3SzWrgEZ8sABE1cxqGrppiOzHrRhQiza6FK8jbvkpI1MsK8Sb18ids0PkgCa6J/66HOVRsovWhSIQK3SG0cQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WAc5P8NQ; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722456559; x=1753992559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=idv4Y5IP1/LWej2Vczr9zZBeD/yAR6HkFYoBaYpbY/o=;
  b=WAc5P8NQ2p6shfTKgyleVv3hMGHe6U5F7bTVVFQtWsQY6/s4GU58wX7g
   y8GPdtFP6ZHr3QUZRQDGNSurMnzayHbfnQdxCv0XN2sD1QHp2eSJ9fgmI
   3E5ULhJXAym6j1/OFv1GKEGRauWnlxuT56SYNMxbLUW402wKN6JXmH1qM
   g=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="414431688"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 20:09:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:50110]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.45:2525] with esmtp (Farcaster)
 id f8a430da-a151-4889-9763-6fdf60aa9e22; Wed, 31 Jul 2024 20:09:14 +0000 (UTC)
X-Farcaster-Flow-ID: f8a430da-a151-4889-9763-6fdf60aa9e22
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:09:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:09:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/6] net: Call preinit_net() without pernet_ops_rwsem.
Date: Wed, 31 Jul 2024 13:07:19 -0700
Message-ID: <20240731200721.70601-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240731200721.70601-1-kuniyu@amazon.com>
References: <20240731200721.70601-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When initialising the root netns, we call preinit_net() under
pernet_ops_rwsem.

However, the operations in preinit_net() do not require pernet_ops_rwsem.

Also, we don't hold it for preinit_net() when initialising non-root netns.

To be consistent, let's call preinit_net() without pernet_ops_rwsem in
net_ns_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 6c9acb086852..b91c15b27fb2 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1199,8 +1199,9 @@ void __init net_ns_init(void)
 #ifdef CONFIG_KEYS
 	init_net.key_domain = &init_net_key_domain;
 #endif
-	down_write(&pernet_ops_rwsem);
 	preinit_net(&init_net);
+
+	down_write(&pernet_ops_rwsem);
 	if (setup_net(&init_net, &init_user_ns))
 		panic("Could not setup the initial network namespace");
 
-- 
2.30.2


