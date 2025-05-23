Return-Path: <netdev+bounces-192963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9B4AC1E00
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF651BC7D0E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99069286D45;
	Fri, 23 May 2025 07:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFC284B29
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986989; cv=none; b=lb0WmsOFM4I6Aavx4Q0gnRF9mKL+pkdqRYMjVPV5kmD8tHKJXFAp66nzIVneO+tm93MbmoV70YwJ5F0hIJnDdgoM5uM2n5ChOmh0T/pisPndOQmep1Ka5I1707tZkbOHGRKWfUMheaguxZC0xtFQE22GoepNUsZ/u0klR/ZWi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986989; c=relaxed/simple;
	bh=S34q7STpq/MgJxmzXrqeTXitYktBMq4H8tI/WECekSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpkMswBCm9Yr32DoO3CNzSQtaalt0O/bmbVx2IPcsEyK4wP09+TqhOaCnhOQlW4ayRiQgsY9HB3xc/hJoNeozxSEIP7EbF2i4kzFKETeEkcp1dPcV7NkEqJLFo4GQbPlb7oW4ZfnZrAqIdKjGS+iUi58wpfLEe8f9IUbtd12RBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C34DD208AB;
	Fri, 23 May 2025 09:56:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tvpQjcJ86SRF; Fri, 23 May 2025 09:56:19 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1577420748;
	Fri, 23 May 2025 09:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1577420748
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 09:56:18 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 09:56:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 239863181DC7; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/12] xfrm: Remove unneeded device check from validate_xmit_xfrm
Date: Fri, 23 May 2025 09:56:03 +0200
Message-ID: <20250523075611.3723340-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523075611.3723340-1-steffen.klassert@secunet.com>
References: <20250523075611.3723340-1-steffen.klassert@secunet.com>
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

From: Cosmin Ratiu <cratiu@nvidia.com>

validate_xmit_xfrm checks whether a packet already passed through it on
the master device (xso.dev) and skips processing the skb again on the
slave device (xso.real_dev).

This check was added in commit [1] to avoid tx packets on a bond device
pass through xfrm twice and get two sets of headers, but the check was
soon obsoleted by commit [2], which was added around the same time to
fix a similar but unrelated problem. Commit [3] set XFRM_XMIT only when
packets are hw offloaded.

xso.dev is usually equal to xso.real_dev, unless bonding is used, in
which case the bonding driver uses xso.real_dev to manage offloaded xfrm
states.

Since commit [3], the check added in commit [1] is unused on all cases,
since packets going through validate_xmit_xfrm twice bail out on the
check added in commit [2]. Here's a breakdown of relevant scenarios:

1. ESP offload off: validate_xmit_xfrm returns early on !xo.
2. ESP offload on, no bond: skb->dev == xso.real_dev == xso.dev.
3. ESP offload on, bond, xs on bond dev: 1st pass adds XFRM_XMIT, 2nd
   pass returns early on XFRM_XMIT.
3. ESP offload on, bond, xs on slave dev: 1st pass returns early on
   !xo, 2nd pass adds XFRM_XMIT.
4. ESP offload on, bond, xs on both bond AND slave dev: only 1 offload
   possible in secpath. Either 1st pass adds XFRM_XMIT and 2nd pass returns
   early on XFRM_XMIT, or 1st pass is sw and returns early on !xo.
6. ESP offload on, crypto fallback triggered in esp_xmit/esp6_xmit: 1st
   pass does sw crypto & secpath_reset, 2nd pass returns on !xo.

This commit removes the unnecessary check, so xso.real_dev becomes what
it is in practice: a private field managed by bonding driver.
The check immediately below that can be simplified as well.

[1] commit 272c2330adc9 ("xfrm: bail early on slave pass over skb")
[2] commit 94579ac3f6d0 ("xfrm: Fix double ESP trailer insertion in
IPsec crypto offload.")
[3] commit c7dbf4c08868 ("xfrm: Provide private skb extensions for
segmented and hw offloaded ESP packets")

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 4f4165ff738d..0be5f7ffd019 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -145,10 +145,6 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return NULL;
 	}
 
-	/* This skb was already validated on the upper/virtual dev */
-	if ((x->xso.dev != dev) && (x->xso.real_dev == dev))
-		return skb;
-
 	local_irq_save(flags);
 	sd = this_cpu_ptr(&softnet_data);
 	err = !skb_queue_empty(&sd->xfrm_backlog);
@@ -159,8 +155,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return skb;
 	}
 
-	if (skb_is_gso(skb) && (unlikely(x->xso.dev != dev) ||
-				unlikely(xmit_xfrm_check_overflow(skb)))) {
+	if (skb_is_gso(skb) && unlikely(xmit_xfrm_check_overflow(skb))) {
 		struct sk_buff *segs;
 
 		/* Packet got rerouted, fixup features and segment it. */
-- 
2.34.1


