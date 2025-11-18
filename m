Return-Path: <netdev+bounces-239457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BDC6885A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 26BDF2A71D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7ED317711;
	Tue, 18 Nov 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="F+mgHQXa"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C83101C0
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457985; cv=none; b=gzmhAnfP87JSsKiWSiJqj9SaY14Q3eh+jbFd9bAftE8Qe1MAvgB14bqSpivseXWZ48rux4ZBF1EAA5pgw5zvAlLTxXQHjk60n/0w8QaMxtzNCWFa3YGtg67SoFl8X2R4HtzcMblO137IJJua20LVKpYwlAPRgNM6MYvYlHu46ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457985; c=relaxed/simple;
	bh=tG0OD5/iwv0NbvoqF9T3b85ZCSL5u5uAI5eM+XIexCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmIcER+HaeTuMVg+XzZN4Kb9dN9m+vox8Qd0j4CA9DO37KLo/iR3JFUp1uLo759Z7y2xSMy1zPRUI2hs1Jder8vnBRF8/majDV1Sgi6dy94z0nhK9QjlpCQepB+LvRccBj17TvgWiQldQ/Qp+OrD5a4xtjusHbO9T+N86tLGUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=F+mgHQXa; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7F03520841;
	Tue, 18 Nov 2025 10:26:19 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p-QLBeKf1BCB; Tue, 18 Nov 2025 10:26:18 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D20D4207FC;
	Tue, 18 Nov 2025 10:26:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D20D4207FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763457978;
	bh=CT5/2dm2GZCsgSZ05/cqD/oJB1WlmoxMhNvMfPACDcE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=F+mgHQXaRp5pLet/zQrxjRPZwVUeg/F318smtKOLsXQZgKRG0nZM1n7z4gfp6NicE
	 2XU0brHJ+h35gycv3qDoAvBJSMcr/xrE0hdHQm+2AIEixGnHb8Gdp5mT9rSB4/IKlZ
	 vLuUJsNQPlj8sNsdHi897IVaYCk0CewDhZef3tBzu52fLegTs27c3t8WYvLobPnQmS
	 9gpMNDUFG5twpHoDBZw+0qQ8p7UmGow47939B2zFjazwFgLywY+fkRu62xvFpxHkmb
	 mICJD+y/4WeX1ni2ab2HgZlV1zRqSMj0CSGsYUvNMDb4A3Z+xuQxBrqXQ9SaOff05o
	 z5nCxng+Uhl+Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:26:18 +0100
Received: (nullmailer pid 2223962 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/12] pfkey: Deprecate pfkey
Date: Tue, 18 Nov 2025 10:25:40 +0100
Message-ID: <20251118092610.2223552-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118092610.2223552-1-steffen.klassert@secunet.com>
References: <20251118092610.2223552-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

The pfkey user configuration interface was replaced by the netlink
user configuration interface more than a decade ago. In between
all maintained IKE implementations moved to the netlink interface.
So let config NET_KEY default to no in Kconfig. The pfkey code
will be removed in a second step.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Antony Antony <antony.antony@secunet.com>
Acked-by: Tobias Brunner <tobias@strongswan.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Tuomo Soini <tis@foobar.fi>
Acked-by: Paul Wouters <paul@nohats.ca>
---
 net/key/af_key.c |  2 ++
 net/xfrm/Kconfig | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..571200433aa9 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3903,6 +3903,8 @@ static int __init ipsec_pfkey_init(void)
 {
 	int err = proto_register(&key_proto, 0);
 
+	pr_warn_once("PFKEY is deprecated and scheduled to be removed in 2027, "
+	             "please contact the netdev mailing list\n");
 	if (err != 0)
 		goto out;
 
diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index f0157702718f..4a62817a88f8 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -110,14 +110,17 @@ config XFRM_IPCOMP
 	select CRYPTO_DEFLATE
 
 config NET_KEY
-	tristate "PF_KEY sockets"
+	tristate "PF_KEY sockets (deprecated)"
 	select XFRM_ALGO
 	help
 	  PF_KEYv2 socket family, compatible to KAME ones.
-	  They are required if you are going to use IPsec tools ported
-	  from KAME.
 
-	  Say Y unless you know what you are doing.
+	  The PF_KEYv2 socket interface is deprecated and
+	  scheduled for removal. All maintained IKE daemons
+	  no longer need PF_KEY sockets. Please use the netlink
+	  interface (XFRM_USER) to configure IPsec.
+
+	  If unsure, say N.
 
 config NET_KEY_MIGRATE
 	bool "PF_KEY MIGRATE"
-- 
2.43.0


