Return-Path: <netdev+bounces-113822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5224994002A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D61E281673
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBDB18D4A0;
	Mon, 29 Jul 2024 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QW4wowqy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44D18D4B0
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287405; cv=none; b=WcTn8d93T8cBr4t9js+wVNYpBt8hJxBsEqcskoXBa2C0guNVnsyjkxws4DHoU8ihqYhelhGjLLf3hoknmkbUGwiKCO44IDGuZxzLu/JtA7HSGoHQjGiB5nRMEnjIzdr/tjbuwi6fhNDQAk3qTHneAsI7KigL1JVLSiLnvkdWFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287405; c=relaxed/simple;
	bh=XwbTeBj66PGoXtXKP3qWQGxi+ntZQmtk3JUsIKZCP/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9spahBs28M6paDB18vM4/J+e4GweXnRNyAmyOfMUnVH0+p2wlGIR1kwb2PQXseq5CxeDWczj+bQX76tF7U2dHj3tNSphOJ0u27UNn8ByrFLil770oaXPuDatvOUUQaE64rRocMO3Ndo/w/WW1hupeSz/TJwbtbHAZnCvubvrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QW4wowqy; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722287403; x=1753823403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HjK2Zx9WEb0ZB65G51mRJqtxlVS97+btMLT/uHrQXcE=;
  b=QW4wowqyuyKKAnbjvJoBVX1Fs62cRAG+2dSuAMfhmYAgZ7C+VLjjSwYT
   voAddywzCaSc6r6VW6gR2N0mzlrOKeaSK3VzsWuXbvaaAn9sXjg24oTkY
   qS0Ys+HxngZEw+NpDAEpsMWnV4rhHjhFn4o2YZ7AR6OgvA/vTTX+OxfF2
   4=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="649442433"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 21:09:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:2202]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.88:2525] with esmtp (Farcaster)
 id ce800e82-1cf4-4e80-85ab-b3bc35292819; Mon, 29 Jul 2024 21:09:58 +0000 (UTC)
X-Farcaster-Flow-ID: ce800e82-1cf4-4e80-85ab-b3bc35292819
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:09:58 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:09:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/6] net: Call preinit_net() without pernet_ops_rwsem.
Date: Mon, 29 Jul 2024 14:07:59 -0700
Message-ID: <20240729210801.16196-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240729210801.16196-1-kuniyu@amazon.com>
References: <20240729210801.16196-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
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
index e4e99e7ba9f8..f1b6cea7a9b6 100644
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


