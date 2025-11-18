Return-Path: <netdev+bounces-239433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CAC68624
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E51F367C45
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0632D0D5;
	Tue, 18 Nov 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="eaB3xiqh"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6F32C327
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456041; cv=none; b=AAmyxpK++vPFsJ9CHHPU88tZRiwjiFnlYNF8B1D4/6jLs6VGAniCNIkJaMVqe2Avm09UwlvVQ7Jn6MPka4vfDDht9nf+WK1dmU1HsDGNjf3XkIBkO7fvBvCUFZe+QVhr6uZlzXC14huDEN4f1C98kF+Djrd94PWI8dZx0p3UY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456041; c=relaxed/simple;
	bh=6d1ylapIEon9iEinlGM6bjN3tDuRZ1Si0/uYqKMWQ1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVnAjV9AS+hI1bdixVhZ6yjb2KXssYSmktQJv2ULNQ8WK8UHrhhFDmTblDTO+vq0nhBy8DypTH7OfBMtd4btAUkpe3vRnAbJYroz2InHmYykv2cdxY51InW8NRf6wveUN7gVVXo7k9tqmqMAQ/A5gEMcVvvpvKw3sTS7aztFwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eaB3xiqh; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EB471207FC;
	Tue, 18 Nov 2025 09:53:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4jZb_qclpQmM; Tue, 18 Nov 2025 09:53:51 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5981B20743;
	Tue, 18 Nov 2025 09:53:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5981B20743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456031;
	bh=2S+NxRQLC7iJk//p7+dDYtUy+AYmh2Wz9tAxRjnsu10=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=eaB3xiqhisjkMH6ykhcGdVIQV7JtCpjFxvXA/4oUpXLHoAYDEu44pldoQB/F62V9W
	 KfMNCPEaRk2qj7MhtAFnC4uUG6AEVhXu4daVHyeYS9ET/GsnsNUsDguOqaMjCo9moG
	 SSMhAESuQLGciSaSOCDrbbhgm87kx8NGcU74wq3JGY7jix9+vs+jkwR4+fiXWZu4dn
	 iw8T1GlceEvIi8olZK4VcMoDbwX0tn4iR9CODEZ9nBl0qxQHWcHkwLacWX2B6vwexb
	 vluayKcPYNE03fca1r3B9vPQiIFws9h/SlqtTLdMObXrdxudCqqVITIo3l3DXnWzVn
	 0etZdJY+SEAgg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:53:50 +0100
Received: (nullmailer pid 2200678 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/10] xfrm: Prevent locally generated packets from direct output in tunnel mode
Date: Tue, 18 Nov 2025 09:52:42 +0100
Message-ID: <20251118085344.2199815-10-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118085344.2199815-1-steffen.klassert@secunet.com>
References: <20251118085344.2199815-1-steffen.klassert@secunet.com>
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

From: Jianbo Liu <jianbol@nvidia.com>

Add a check to ensure locally generated packets (skb->sk != NULL) do
not use direct output in tunnel mode, as these packets require proper
L2 header setup that is handled by the normal XFRM processing path.

Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_output.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index a98b5bf55ac3..54222fcbd7fd 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -772,8 +772,12 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		/* Exclusive direct xmit for tunnel mode, as
 		 * some filtering or matching rules may apply
 		 * in transport mode.
+		 * Locally generated packets also require
+		 * the normal XFRM path for L2 header setup,
+		 * as the hardware needs the L2 header to match
+		 * for encryption, so skip direct output as well.
 		 */
-		if (x->props.mode == XFRM_MODE_TUNNEL)
+		if (x->props.mode == XFRM_MODE_TUNNEL && !skb->sk)
 			return xfrm_dev_direct_output(sk, x, skb);
 
 		return xfrm_output_resume(sk, skb, 0);
-- 
2.43.0


