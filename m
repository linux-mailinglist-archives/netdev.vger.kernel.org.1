Return-Path: <netdev+bounces-204038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEAAF8856
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E4C5415C2
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3421266EE6;
	Fri,  4 Jul 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="N40+/q9G"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24806266581
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612121; cv=none; b=njFSISJfmPj4cjCZACzG3T9WJqEXtFdpHPwnBno5VkElBiRPPTW76Cxy96N6PxEc56b/DufwI6jfGUa6zYI3GWt6374JYrvsOq9FVyoN96sC17BugwFiBIHuJPPfh/TJbkJ36WDneJ/dLs4SJxOGRCa76/XZccDhAmBmY2VePL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612121; c=relaxed/simple;
	bh=ezo2VJtz3KxrQX5j7kZ6GsPrvyk3zeEj1BwoX/BI9eA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M3eo0Xe6m7/tqQ3kh5gRLBLiAYUij5mEcYvuJV1k1oR9zy9f2oaQRwLFyk+TOwJvPszUhGpGKErRwtr6MSLxD0Lhu5WB3VJZrWjQrGAc3jhieUr7EggH+XxmDlsy5/UXlGqf9uYrS8BsfACHW2XJpMbQjT++slghJbOkkCSL0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=N40+/q9G; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EC56120849;
	Fri,  4 Jul 2025 08:55:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VOY3Jf0_tZcY; Fri,  4 Jul 2025 08:55:16 +0200 (CEST)
Received: from EXCH-04.secunet.de (unknown [10.32.0.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6463320743;
	Fri,  4 Jul 2025 08:55:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6463320743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1751612116;
	bh=TD0SLMVP6zcfd+8kBvtNWesGpGh+wuFzhvZSE7xzVWw=;
	h=Date:From:To:CC:Subject:From;
	b=N40+/q9Gkp0XYSxShtW1K6UiXvEMh61nP8AhzUth+5pI/OfCYJwGRUt4F9Lx9Dxth
	 cBNqa45nMUlDTItfUJD7qZATRWyQO6Bsy3WvhuBUlZoSynIB3sKQqxjVeUi8WhNutE
	 ta5BGPN1hyDG/sp1BnTzThJ4TlDUmfU7XuVxxaHPArBYa4J+HBfUZ8OxJMqtTi1Ad/
	 abWrWJ1+VG7slpSM2J6FcB9jfxPu6tueoVX3DBO69tzE7IC+fP3MVh3ObSrAR1oipr
	 haEquZVszj9uqow2KjzueVjHz24jwBiiv7KemrqaLqBsMCbvXq0EgQ8AxdIn7TceJ1
	 nK34DdCUUHDvw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-04.secunet.de
 (10.32.0.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 4 Jul
 2025 08:55:15 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 08:55:14 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id BE66631800CD; Fri,  4 Jul 2025 08:55:14 +0200 (CEST)
Date: Fri, 4 Jul 2025 08:55:14 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>, Tobias Brunner
	<tobias@strongswan.org>, Antony Antony <antony@phenome.org>, Tuomo Soini
	<tis@foobar.fi>, "David S. Miller" <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: [PATCH RFC ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aGd60lOmCtytjTYU@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

The pfkey user configuration interface was replaced by the netlink
user configuration interface more than a decade ago. In between
all maintained IKE implementations moved to the netlink interface.
So let 'config NET_KEY' default to no in Kconfig. The pfkey code
will be removed in a second step.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/Kconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index f0157702718f..aedea7a892db 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -110,14 +110,17 @@ config XFRM_IPCOMP
 	select CRYPTO_DEFLATE
 
 config NET_KEY
-	tristate "PF_KEY sockets"
+	tristate "PF_KEY sockets (deprecated)"
 	select XFRM_ALGO
+	default n
 	help
 	  PF_KEYv2 socket family, compatible to KAME ones.
-	  They are required if you are going to use IPsec tools ported
-	  from KAME.
 
-	  Say Y unless you know what you are doing.
+	  The PF_KEYv2 socket interface is deprecated and
+	  scheduled for removal. Please use the netlink
+	  interface (XFRM_USER) to configure IPsec.
+
+	  If unsure, say N.
 
 config NET_KEY_MIGRATE
 	bool "PF_KEY MIGRATE"
-- 
2.43.0


