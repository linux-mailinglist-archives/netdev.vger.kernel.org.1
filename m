Return-Path: <netdev+bounces-133283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150DA995721
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F5C1C24CB3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF5212D2B;
	Tue,  8 Oct 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UQi/xWlI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95D20ADC6
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413395; cv=none; b=KHxUm+ZDt//bjuLvNJaE4hNYFZBAqQujt2a5dieYyXuVYzTiuFUwhemClvI+nrNVUVsfY/sLX6ZIyeK3GmJvTnS/05D7a4RiP91Q0HpyPwdDHxo1TrNb5jxrLIEO8QmV8pKGu4ZOXAQHTsati0S6wUFfTJMSgo+GzHxErRxOVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413395; c=relaxed/simple;
	bh=5XGrwqzMnsnNtTt5B5VFCaNb6vLYWvY9QE7hiK+NEIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxYlpHevYIFQLoP6DFBvRVyhou2mUo2hAKILdoRz8fIyx9vnRNUnH4AYTWjeLycF8QDuBOteHfsAEPN4a+QBhqKRQRpqr4LD4vjB7B9PRlZgjDDeq4kr16noOt+NlIoBVzhTt5em+1ra2XrzkbOGIOenwL/DMKnnAmV3y2ndu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UQi/xWlI; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728413395; x=1759949395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xcVZ1r6R5xCh0ziAoJRfRomoBeQpCGmn5Gs8U5NJ7NY=;
  b=UQi/xWlI/v3wqyOuPwnIsTZMAyOmDPxRud7jQ5khZG01pSFjWl7oM72J
   Dc7a/RrDe2Cut1LPZWD402VFJIh/XFHGyrViJwFwKi9r1/Zdaj936zIW7
   KtrArm3trx+a1nyMnJNVbli/R8iNMtz2/2/JcTWSTDnQ28ZLC3sKdRE/y
   8=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="31627329"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:49:52 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:49010]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id c67e3715-75fe-4231-b229-f0092545bbd5; Tue, 8 Oct 2024 18:49:50 +0000 (UTC)
X-Farcaster-Flow-ID: c67e3715-75fe-4231-b229-f0092545bbd5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 18:49:50 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 18:49:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Eric W. Biederman"
	<ebiederm@xmission.com>
Subject: [PATCH v4 net 5/6] mpls: Handle error of rtnl_register_module().
Date: Tue, 8 Oct 2024 11:47:36 -0700
Message-ID: <20241008184737.9619-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008184737.9619-1-kuniyu@amazon.com>
References: <20241008184737.9619-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, mpls_init() has been ignoring the returned
value of rtnl_register_module(), which could fail silently.

Handling the error allows users to view a module as an all-or-nothing
thing in terms of the rtnetlink functionality.  This prevents syzkaller
from reporting spurious errors from its tests, where OOM often occurs
and module is automatically loaded.

Let's handle the errors by rtnl_register_many().

Fixes: 03c0566542f4 ("mpls: Netlink commands to add, remove, and dump routes")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: "Eric W. Biederman" <ebiederm@xmission.com>

v3: Add more context in changelog
v2: Make rtnl_msg_handler const
---
 net/mpls/af_mpls.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index aba983531ed3..df62638b6498 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2728,6 +2728,15 @@ static struct rtnl_af_ops mpls_af_ops __read_mostly = {
 	.get_stats_af_size = mpls_get_stats_af_size,
 };
 
+static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_module = {
+	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
+	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
+	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes, 0},
+	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
+	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
+	 RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 static int __init mpls_init(void)
 {
 	int err;
@@ -2746,24 +2755,25 @@ static int __init mpls_init(void)
 
 	rtnl_af_register(&mpls_af_ops);
 
-	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_NEWROUTE,
-			     mpls_rtm_newroute, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_DELROUTE,
-			     mpls_rtm_delroute, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_GETROUTE,
-			     mpls_getroute, mpls_dump_routes, 0);
-	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
-			     mpls_netconf_get_devconf,
-			     mpls_netconf_dump_devconf,
-			     RTNL_FLAG_DUMP_UNLOCKED);
-	err = ipgre_tunnel_encap_add_mpls_ops();
+	err = rtnl_register_many(mpls_rtnl_msg_handlers);
 	if (err)
+		goto out_unregister_rtnl_af;
+
+	err = ipgre_tunnel_encap_add_mpls_ops();
+	if (err) {
 		pr_err("Can't add mpls over gre tunnel ops\n");
+		goto out_unregister_rtnl;
+	}
 
 	err = 0;
 out:
 	return err;
 
+out_unregister_rtnl:
+	rtnl_unregister_many(mpls_rtnl_msg_handlers);
+out_unregister_rtnl_af:
+	rtnl_af_unregister(&mpls_af_ops);
+	dev_remove_pack(&mpls_packet_type);
 out_unregister_pernet:
 	unregister_pernet_subsys(&mpls_net_ops);
 	goto out;
-- 
2.30.2


