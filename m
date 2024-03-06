Return-Path: <netdev+bounces-77869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F11873469
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26464B27F35
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D01604A0;
	Wed,  6 Mar 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="FBdUOOiA"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A635DF2A
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720671; cv=none; b=L0HlGGqhtifg7ljlEgOoUEXqaoFeg6h8ZneuQRd0E1aue2XgcHcW/3H2EMqp99HSBdgAd2TLs1h38EXrUDxW7TzgCEuNil2yC9MTON46sDfoAftdxsNgOBP5tFp1kFCsI4Ix/6zBqu77RZCRiandd9vigwvd8jYch41U1j8L5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720671; c=relaxed/simple;
	bh=uHqnjvDpRdm9v+VPjrF0gEVQUiMN11pvM6yRZEL+4YQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uul72aqvexy9W30y/GxWL0+d6waeMJHYfoa2KOfB8SakYkZhSKKH6qbN8VSEtqCR/viFkWqf+3KThYCt1mcMVVGejlWaH3xcbjfTHa/BkDc14qnYCjxjLIFizDjJzIkzjSuHFQKB1FlWkgWk8O0G43Ktb9MdxlX6Gvefuw63g6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FBdUOOiA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B02CE207E4;
	Wed,  6 Mar 2024 11:24:28 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cvfHPmHUzZW; Wed,  6 Mar 2024 11:24:28 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 67252207C6;
	Wed,  6 Mar 2024 11:24:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 67252207C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709720666;
	bh=cPn5/K/lb0YbIMsUrk+jA0HgzoSEzLWVjCX15zxpic8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=FBdUOOiACqgHaVhItkBWi1VDJIc+77d6zCe2j0l1fEhqc6Eh6gklVgUMyn1A1KKdS
	 b8lhNrPjp59rUcxON0zKUF/APSY16Zsd9O4gXkiJ00qHnubm4laL6v3R2zhIUpJa6z
	 FdFRVRHy1BtMJvanuCeU4h7VQe+rnvX/l/TrOH4vCGC8FGcd4VSQ9cXz+QZG5ORaKs
	 ocbB1881fFyVAc104o2CtHwe9p+FYTFIO5PTwbFBurlAT7U4pez79Wp05OpzCD1P1c
	 uJo8lUJ5Bln7sLlEWbMSK/qbX0F1XWKJxpypf+NqGdRuMuCY7nTM7z2HXr8LUkFk0A
	 qCuAILxfUqLZw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 5BCD680004A;
	Wed,  6 Mar 2024 11:24:26 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:24:26 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:24:25 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 3CFAA3182A91; Wed,  6 Mar 2024 11:24:25 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/4] xfrm: Do not allocate stats in the driver
Date: Wed, 6 Mar 2024 11:24:21 +0100
Message-ID: <20240306102421.3963212-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306102421.3963212-1-steffen.klassert@secunet.com>
References: <20240306102421.3963212-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Breno Leitao <leitao@debian.org>

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the xfrm driver and leverage the network
core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_interface_core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 21d50d75c260..1a1f6613fda2 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -240,7 +240,6 @@ static void xfrmi_dev_free(struct net_device *dev)
 	struct xfrm_if *xi = netdev_priv(dev);
 
 	gro_cells_destroy(&xi->gro_cells);
-	free_percpu(dev->tstats);
 }
 
 static int xfrmi_create(struct net_device *dev)
@@ -749,6 +748,7 @@ static void xfrmi_dev_setup(struct net_device *dev)
 	dev->flags 		= IFF_NOARP;
 	dev->needs_free_netdev	= true;
 	dev->priv_destructor	= xfrmi_dev_free;
+	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
 	netif_keep_dst(dev);
 
 	eth_broadcast_addr(dev->broadcast);
@@ -765,15 +765,9 @@ static int xfrmi_dev_init(struct net_device *dev)
 	struct net_device *phydev = __dev_get_by_index(xi->net, xi->p.link);
 	int err;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	err = gro_cells_init(&xi->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
 
 	dev->features |= NETIF_F_LLTX;
 	dev->features |= XFRMI_FEATURES;
-- 
2.34.1


