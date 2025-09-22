Return-Path: <netdev+bounces-225143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4080B8F4EC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B180179C02
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4DD2F6165;
	Mon, 22 Sep 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="G1C48LcS"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE612F2908
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526527; cv=none; b=n9a9dqZ1710LO8tK+rN+8NB2IPXcnQSMROCpz/sM1zEpm6hN6T2kAb0t85weUJcBZwUcxvdYXkjI0RTWzglUD1tw9peAW1l8VKc+ZdBXZilmUG/kYbTRxKq72iI9xsFtj2wYKXFRK/xWN0ZuNQ2oAXyQuque/uB7urs3CnY9t2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526527; c=relaxed/simple;
	bh=nVUGxdGNpX4HPL9+swKaKCBN5uWzyeQ42QloABVDMRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRH0JdK81a09VUQvRIo5evln9KyYJUeMPLGPNCJjy5qpdW5DUw6ydNP2iZafQiU7Rtb7rKS0r10SQgzt9GJs3VZV2x7dHpXQ50qeoTVFb9cc8a/tXlbBybcenRLc1Hd3f10w/+fu7q88WDUIv2SPAulpTFwLXxqNbfI53Tu6Brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=G1C48LcS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 73BAA2083F;
	Mon, 22 Sep 2025 09:35:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GMM5k1JCUSPY; Mon, 22 Sep 2025 09:35:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 96578205ED;
	Mon, 22 Sep 2025 09:35:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 96578205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1758526522;
	bh=/2azVbsA10oOFr5iGW9RMyUfoa3GaT/6FRtuxY+utzE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=G1C48LcSnw5cHhJIHMOE+wmf6yM112pf7jhs8VYYD6VTUrh8w8+VCgZ0E1rAwHjeS
	 2JU/WR/Z6M1HL/t0o1lX/CVfuopszKMGLSxKuewHMZdzrXupWVf2hix3CYWw5gGNoj
	 1SIfTBzxpgJHlMGq6gqIJYL2yOBAo/zoUthb6VFJutKEKdp0cPrCmM8SJdoK8PDWoy
	 EGarModlMYebwk4CSgnExeOV1OVIA7IBX+qggMKDVCk4wp2oBERO6oPuV3O8l0kRw4
	 Ot3auP/QRDOIqziCblGS6gJ6gxqSxnGtmn/jFEDnmMuGNLGHkfnLJdq0DJjesQWX9D
	 GuKq0bvKF9N9Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 22 Sep
 2025 09:35:22 +0200
Received: (nullmailer pid 64932 invoked by uid 1000);
	Mon, 22 Sep 2025 07:35:19 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/2] xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
Date: Mon, 22 Sep 2025 09:34:52 +0200
Message-ID: <20250922073512.62703-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922073512.62703-1-steffen.klassert@secunet.com>
References: <20250922073512.62703-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

x->id.spi == 0 means "no SPI assigned", but since commit
94f39804d891 ("xfrm: Duplicate SPI Handling"), we now create states
and add them to the byspi list with this value.

__xfrm_state_delete doesn't remove those states from the byspi list,
since they shouldn't be there, and this shows up as a UAF the next
time we go through the byspi list.

Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
Fixes: 94f39804d891 ("xfrm: Duplicate SPI Handling")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf32..d213ca3653a8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2583,6 +2583,8 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 
 	for (h = 0; h < range; h++) {
 		u32 spi = (low == high) ? low : get_random_u32_inclusive(low, high);
+		if (spi == 0)
+			goto next;
 		newspi = htonl(spi);
 
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -2598,6 +2600,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		xfrm_state_put(x0);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
+next:
 		if (signal_pending(current)) {
 			err = -ERESTARTSYS;
 			goto unlock;
-- 
2.43.0


