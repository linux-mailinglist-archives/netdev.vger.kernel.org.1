Return-Path: <netdev+bounces-181028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B20A83678
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04781B64F75
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA571CAA90;
	Thu, 10 Apr 2025 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QO0BRo3S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856F1C860A
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251891; cv=none; b=tCY2HSvM0yo93z9Sat24y+FxKYRD62ouL9gYBFakKmiWlDJvCACEgglyQqW/xjYRTcpfCp6z0NC/wgy5Ms0ovkjJhGlukTJVsUn0GAsyiHDdeIMaYtEAiDgf6mTHD2WI+fVcMoDUrfMNGLT+wWcEX/kKKRMGn9uM/xt1ej2x1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251891; c=relaxed/simple;
	bh=jKn38DERdttngiJf0ePS3R++UNzTyeI/w7cyvrpPu6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9sjXY0taP8QZp92IfLV6fwF53rAospj/LXAingVRYc8CEgByOljGtDYJd04ANAfXncnYCb0mhiFG3IeRoN1e+tT0ffhHtnWNd/tWwXZTF3cwDQu2QuEKrh7npqSaF6fpJSDET/ZPjawEs2DfLmw7UbyLLSIfjEivmtVpLWPPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QO0BRo3S; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251887; x=1775787887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YcJ+su2tNb3Y1FuQWYoLbDxko03k2TA6X+6yRzoTo4Q=;
  b=QO0BRo3SduVR/cOQd1+VBXh/i7UwPPIbOiZ2cheeiGOyf6/aev4fwFVv
   dMNT8aDk0QU0210h57UGcdbFdwcHYIGXXyQbjVb07rzbO2eSTjbdgbhY3
   2NwowzgfUwOk40C7/1e7CdFRaM91Dm7rgAb1ECsFIKCsNRDeWara+V7H2
   M=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="394585612"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:24:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:57604]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 2b5022b0-2855-463b-8033-ae1eec2f83be; Thu, 10 Apr 2025 02:24:43 +0000 (UTC)
X-Farcaster-Flow-ID: 2b5022b0-2855-463b-8033-ae1eec2f83be
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:24:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:24:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Pablo
 Neira Ayuso" <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH v1 net-next 11/14] gtp: Convert gtp_net_exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:32 -0700
Message-ID: <20250410022004.8668-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

gtp_net_exit_batch_rtnl() iterates the dying netns list
and performs the same operations for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/gtp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ef793607890d..d4dec741c7f4 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2475,23 +2475,19 @@ static int __net_init gtp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
-					       struct list_head *dev_to_kill)
+static void __net_exit gtp_net_exit_rtnl(struct net *net,
+					 struct list_head *dev_to_kill)
 {
-	struct net *net;
-
-	list_for_each_entry(net, net_list, exit_list) {
-		struct gtp_net *gn = net_generic(net, gtp_net_id);
-		struct gtp_dev *gtp, *gtp_next;
+	struct gtp_net *gn = net_generic(net, gtp_net_id);
+	struct gtp_dev *gtp, *gtp_next;
 
-		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
-			gtp_dellink(gtp->dev, dev_to_kill);
-	}
+	list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
+		gtp_dellink(gtp->dev, dev_to_kill);
 }
 
 static struct pernet_operations gtp_net_ops = {
 	.init	= gtp_net_init,
-	.exit_batch_rtnl = gtp_net_exit_batch_rtnl,
+	.exit_rtnl = gtp_net_exit_rtnl,
 	.id	= &gtp_net_id,
 	.size	= sizeof(struct gtp_net),
 };
-- 
2.49.0


