Return-Path: <netdev+bounces-142211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 337839BDD09
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0621B236A1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5F1DB95F;
	Wed,  6 Nov 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bnMI0JQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E681DB953
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859982; cv=none; b=cF/pEVVa5ty/R1fx37iEBOUhX6U05ggwcla0I1VKrs/oSsB9yLwL6HPSMH9tC/lcPxaJVWtvOQ1CUhob9cIwCIUn90mz0V6Djn4qG8v2fUTdfJS9Z7IMidY1Izu0picUPA/XN/IC0EBau0k2sXyaUj5SdXHsbFcZZpRFU6sKf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859982; c=relaxed/simple;
	bh=VuNecQo3mx9aLISMkC0M40uaKNs2cZg3Kzdi9OEVfdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3JeNC9w45v6WnpDtQ5rPZSStgAmDKHNt8Ivy5zniXyM7KPrbp5bRNeQpezUwQDvkXj8KirPeibbkhZ/mSbJx0vKyPOwLTXsUGRGGlXXl6fPeMVFXc6WgYrfLekmy3D5P1l3afAFVGD4szBvOJgHF/zkPdAldUUKOU1t/A4E57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bnMI0JQk; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730859981; x=1762395981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rC3riDVCLTfZwQpH7iimkYigy0/rNxfcF2Fnn+zmbXI=;
  b=bnMI0JQkxOv90pC/NNbTsbgPEn7OkymlhHvLedOwhntcwkbO1yJgBeBp
   irIR8PGk7WQgM+F2YGtKtSh2qqUh1fQ/unsNXgZkWI1h1+l8OMz8SMFSD
   GMFQLad7zJADeUWJa3iQyqBG6IaTvHLmvTp33smk813+AALHQjGNQK9Xt
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="349723884"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:26:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:62551]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.121:2525] with esmtp (Farcaster)
 id db5477f9-8595-4d0c-b169-7c0e3445f0cf; Wed, 6 Nov 2024 02:26:19 +0000 (UTC)
X-Farcaster-Flow-ID: db5477f9-8595-4d0c-b169-7c0e3445f0cf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 02:26:17 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 02:26:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 5/7] netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
Date: Tue, 5 Nov 2024 18:24:30 -0800
Message-ID: <20241106022432.13065-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106022432.13065-1-kuniyu@amazon.com>
References: <20241106022432.13065-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/netkit.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index cd8360b9bbde..bb07725d1c72 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -351,12 +351,7 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 		if (data[IFLA_NETKIT_PEER_INFO]) {
 			attr = data[IFLA_NETKIT_PEER_INFO];
 			ifmp = nla_data(attr);
-			err = rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
-			if (err < 0)
-				return err;
-			err = netkit_validate(peer_tb, NULL, extack);
-			if (err < 0)
-				return err;
+			rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
 			tbp = peer_tb;
 		}
 		if (data[IFLA_NETKIT_SCRUB])
@@ -391,9 +386,6 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	net = rtnl_link_get_net(src_net, tbp);
-	if (IS_ERR(net))
-		return PTR_ERR(net);
-
 	peer = rtnl_create_link(net, ifname, ifname_assign_type,
 				&netkit_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
@@ -978,6 +970,7 @@ static struct rtnl_link_ops netkit_link_ops = {
 	.fill_info	= netkit_fill_info,
 	.policy		= netkit_policy,
 	.validate	= netkit_validate,
+	.peer_type	= IFLA_NETKIT_PEER_INFO,
 	.maxtype	= IFLA_NETKIT_MAX,
 };
 
-- 
2.39.5 (Apple Git-154)


