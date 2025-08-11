Return-Path: <netdev+bounces-212423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C03B20325
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C86420E38
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B92DEA96;
	Mon, 11 Aug 2025 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rHzL5BdB"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308E2DCF5A
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904032; cv=none; b=G5DtioQu1QELQqj5oQSHmp015nNrkPgMxWVznxX6MFWTbfu+KB3fSrGWEAg7sgxKsKNsKTyfoOrrQo3JKagCNH2Ey2Fm26oZ2tNIvhr3YG2smfaUjtmlw5gs1CmxEB0omg55y8YZRkHVwTAqZEkF94X9E3HJnSBIvC/nvIPQL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904032; c=relaxed/simple;
	bh=eyy47c5TSVKZPA9kTxrXnIdO2aJ0GHdsrMvMARq3OBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exaGCKXzgfpS+X01IcEDNUOp/N1XoPTwniZPm2c7CkpsoxCByXzRCqkjdN4RF+2uZj9weVatyA4L80CPuVZF8TkCuiGoQ5W39ZwmktXfG3yt7QYOZq4B3JYz/vJ/iwna+hxiiQCeAprfFMGU/8yAibBIHSrLGaupc9u18or1LnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rHzL5BdB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 66A02201D3;
	Mon, 11 Aug 2025 11:20:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UcBngrIYN-cM; Mon, 11 Aug 2025 11:20:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D0EF320799;
	Mon, 11 Aug 2025 11:20:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D0EF320799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1754904020;
	bh=1bVo67Bl65kLb68Kk2oSyRUTfJiBIbnWvC5i7snnBoc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=rHzL5BdBReXnFsrPb6wkGjFx695ejCzo9bN0AtAmredYTlDD//TofbTWoCXLcL0zP
	 mb2DSMEZULTpL7R8xHlPdofs1AG80qn55ibS4Q1geQKFKuw5FFKDdA+4d6Lfwk3k/K
	 1PBs6tdgC9Ah6QmOx4sJwGBcWlEz26A5eC33ddZG/YBrhVN9ErKX5huuU+ewFSIYck
	 Bu4n5dqQp4vPa4L7MsFKCONL1tAi7amLrLK0jm1SRcwCsUSZwoHlZg8CLpUTDHp5yX
	 3dZFz3xlT8OI4ZlV4ZQe++bNHAsGLOLyy5PS4br0LW2dhveBeYhTP1eAIhzfkS9gcI
	 K5NgKicjPn6wQ==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 11 Aug
 2025 11:20:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 116F33182A66; Mon, 11 Aug 2025 11:20:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/4] xfrm: bring back device check in validate_xmit_xfrm
Date: Mon, 11 Aug 2025 11:19:31 +0200
Message-ID: <20250811092008.731573-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811092008.731573-1-steffen.klassert@secunet.com>
References: <20250811092008.731573-1-steffen.klassert@secunet.com>
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

From: Sabrina Dubroca <sd@queasysnail.net>

This is partial revert of commit d53dda291bbd993a29b84d358d282076e3d01506.

This change causes traffic using GSO with SW crypto running through a
NIC capable of HW offload to no longer get segmented during
validate_xmit_xfrm, and is unrelated to the bonding use case mentioned
in the commit.

Fixes: d53dda291bbd ("xfrm: Remove unneeded device check from validate_xmit_xfrm")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 1f88472aaac0..c7a1f080d2de 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -155,7 +155,8 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return skb;
 	}
 
-	if (skb_is_gso(skb) && unlikely(xmit_xfrm_check_overflow(skb))) {
+	if (skb_is_gso(skb) && (unlikely(x->xso.dev != dev) ||
+				unlikely(xmit_xfrm_check_overflow(skb)))) {
 		struct sk_buff *segs;
 
 		/* Packet got rerouted, fixup features and segment it. */
-- 
2.43.0


