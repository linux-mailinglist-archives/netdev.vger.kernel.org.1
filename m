Return-Path: <netdev+bounces-111231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41193051C
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618371C215C0
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76BA71B40;
	Sat, 13 Jul 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VtUFwioe"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DF6BFCF
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866270; cv=none; b=JeQodtTyAXkD+ksGyTagVRVHjEMKcyc5Nhd1RlpfCuCSkoexkJZi55Cs2w7ZcPwCfvVCA3ydyaXrhJtx/TxneA2aW9rSMKYmt/vT053bgylySs63uiWU1nrkiE8IWQVTJT2GKDiWGbSwCGrU1d0LpipQBQS5MmIIOEH4Mz1x1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866270; c=relaxed/simple;
	bh=QjskaQmNmdgrtIiOdD7889XEnpBEGtd4eWXl1AR8U7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRbhv5rqllZzxcwYbTu54wwJuC7UHlU197woBYwXV96vPi5lR1ni2jswUZCInnc7727JjyniteHwnv5DTMiZPFa/n+nkhrO0VJaZuKtrIzlAnX5C7Q6+Hov7/nvEbLTOG/z40EP9P1iJ3X3DmOuR/6R8cMelLqccsGuxaBm9Vsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VtUFwioe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BA74620872;
	Sat, 13 Jul 2024 12:24:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id or-dWHSUzeAx; Sat, 13 Jul 2024 12:24:26 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BC19920882;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BC19920882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720866265;
	bh=N5uX60pis/qXj+Z6pM2+dYfeU5SiLYzDvdwAM+8ZdEs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=VtUFwioeanzAaa2E4meoMxJt+vShTCl6ClKcnLqQVHtckuVhjLiYvBSv9pH7+UV9b
	 Wowf9AHEKtV0CuHf2sE980xSPjjvx6K5Y4/3cI7bn3EmDR9HveU+ILHBqtvcbiGaHZ
	 CwC4ab6J1K4LZGbwAKRGZ1p8TR1JjhIa9i2K3gnK+vYrjJxGLp8+RrMtssARPl5t8N
	 HUnHe9jljzcluHaLgI02e5P4p7f26lPPJGUDND2Adnm6zPx7qzg/e7f82R2JpsVWbB
	 GgqEbHq48v+S+FpDRJgaNYXR/Mlh/XLiO2mAGY8kpbW17x98p3jpz+ztw2wwdC233U
	 xxT86nFmlKlAA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id B08F480004A;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 12:24:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 13 Jul
 2024 12:24:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5B64E3183EEF; Sat, 13 Jul 2024 12:24:24 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/5] xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP packet
Date: Sat, 13 Jul 2024 12:24:15 +0200
Message-ID: <20240713102416.3272997-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713102416.3272997-1-steffen.klassert@secunet.com>
References: <20240713102416.3272997-1-steffen.klassert@secunet.com>
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

From: Mike Yu <yumike@google.com>

If xfrm_input() is called with UDP_ENCAP_ESPINUDP, the packet is
already processed in UDP layer that removes the UDP header.
Therefore, there should be no much difference to treat it as an
ESP packet in the XFRM stack.

Test: Enabled dir=in IPsec crypto offload, and verified IPv4
      UDP-encapsulated ESP packets on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index ba8deb0235ba..7cee9c0a2cdc 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -471,7 +471,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct sec_path *sp;
 
-	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0))) {
+	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0 ||
+				      encap_type == UDP_ENCAP_ESPINUDP))) {
 		x = xfrm_input_state(skb);
 
 		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
-- 
2.34.1


