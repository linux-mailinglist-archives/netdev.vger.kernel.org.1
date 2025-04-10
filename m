Return-Path: <netdev+bounces-181025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84AFA83671
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA57B13D2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507FF1D5CDE;
	Thu, 10 Apr 2025 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k7UJyR/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD631C8639
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251814; cv=none; b=OrYL4BCJVUb8uIwBg2WB5+qJpsj7x2CphW5CiF5BBfdEgjY7n8qqM1uJlpxEYAvBjbLe/gyQ6i3EB7vfdfnbTUcVlzG7KKAMpRIuSwUsMRJmyQ6+Sl4x6MluVfsZScZ9m5G4CCTjjqwltghZo1OITdMuIzdQdlqkIi8Z7xyircs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251814; c=relaxed/simple;
	bh=1oeHfGNCftJ5RBBOyF7t3j35x1FqZvGnmcYRRhoKGWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3FGajVxa3Kvj459R/ltUPA4EDWOee9bLkb+2/MXu6fUvpFsubc6ZA4jUsa6IyvRDEcDyKlDcvJnujzkpICmZXeRTJeR4Y+l4E0GpCFq/t9vm7MYh0eXF6ITHLJyajPA+oIUqCL5cMOf9eGKs4bCumUcFjrlF7pRwS1hH9O8J2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k7UJyR/G; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251813; x=1775787813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sm7voc4g1xj5HEOgePXdtw83ogx80WoJvuQ7m8Wrbpo=;
  b=k7UJyR/GnHPVT53Lhb2p6dR4PMCuDKFj6FoAPWl2V8Uu6HFpTht9nWu8
   ZxabLUgISWozaDz06bKqVpUKSBLql34QFkRkYaf7LrSSCQ2A/lul1jK03
   4raXnebMzRTmAZgSzNxsIaI+KvfXD86H3WvWafvflLPswIRNIo3nSiW13
   o=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="39349648"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:23:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:29558]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 07b69934-1751-433e-8b8f-e55d59c814b4; Thu, 10 Apr 2025 02:23:30 +0000 (UTC)
X-Farcaster-Flow-ID: 07b69934-1751-433e-8b8f-e55d59c814b4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:23:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:23:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Steffen
 Klassert" <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
Subject: [PATCH v1 net-next 08/14] xfrm: Convert xfrmi_exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:29 -0700
Message-ID: <20250410022004.8668-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410022004.8668-1-kuniyu@amazon.com>
References: <20250410022004.8668-1-kuniyu@amazon.com>
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

xfrmi_exit_batch_rtnl() iterates the dying netns list and
performs the same operations for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 net/xfrm/xfrm_interface_core.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 622445f041d3..cb1e12740c87 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -952,32 +952,28 @@ static struct rtnl_link_ops xfrmi_link_ops __read_mostly = {
 	.get_link_net	= xfrmi_get_link_net,
 };
 
-static void __net_exit xfrmi_exit_batch_rtnl(struct list_head *net_exit_list,
-					     struct list_head *dev_to_kill)
+static void __net_exit xfrmi_exit_rtnl(struct net *net,
+				       struct list_head *dev_to_kill)
 {
-	struct net *net;
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+	struct xfrm_if __rcu **xip;
+	struct xfrm_if *xi;
+	int i;
 
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_exit_list, exit_list) {
-		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-		struct xfrm_if __rcu **xip;
-		struct xfrm_if *xi;
-		int i;
-
-		for (i = 0; i < XFRMI_HASH_SIZE; i++) {
-			for (xip = &xfrmn->xfrmi[i];
-			     (xi = rtnl_dereference(*xip)) != NULL;
-			     xip = &xi->next)
-				unregister_netdevice_queue(xi->dev, dev_to_kill);
-		}
-		xi = rtnl_dereference(xfrmn->collect_md_xfrmi);
-		if (xi)
+	for (i = 0; i < XFRMI_HASH_SIZE; i++) {
+		for (xip = &xfrmn->xfrmi[i];
+		     (xi = rtnl_net_dereference(net, *xip)) != NULL;
+		     xip = &xi->next)
 			unregister_netdevice_queue(xi->dev, dev_to_kill);
 	}
+
+	xi = rtnl_net_dereference(net, xfrmn->collect_md_xfrmi);
+	if (xi)
+		unregister_netdevice_queue(xi->dev, dev_to_kill);
 }
 
 static struct pernet_operations xfrmi_net_ops = {
-	.exit_batch_rtnl = xfrmi_exit_batch_rtnl,
+	.exit_rtnl = xfrmi_exit_rtnl,
 	.id   = &xfrmi_net_id,
 	.size = sizeof(struct xfrmi_net),
 };
-- 
2.49.0


