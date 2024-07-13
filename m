Return-Path: <netdev+bounces-111234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5800D930521
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 12:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006DD1F21923
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9466CDBA;
	Sat, 13 Jul 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="sS1+/c9w"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99151629E4
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866272; cv=none; b=Ani9oRkbhzrqLRiC9Mu04IRmBRnAj9w4axISmwx0XY/yXplzyD5MFE8XtrdP+OhZ8qZQOrqDue7K3ymAd1Ttie0dzkxf6zbbu+BlbGPEYLBQpyNcgOq8bMEtFp1pGtanjGSwDBkRAvmHBABvHNeWdiGL1an/3Lk46WJ1DEC9JEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866272; c=relaxed/simple;
	bh=ufaB8RH9UDMmKj/FOEqW8js70gyfTWYzxgODazLzYJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1zCmxVVIybb459dpjiv1Hraf90pOTBNsqdlTWEVwSfBtjzMK6mHAZls1Gx5Ji7qEClf12t2Jt6CPzFPaersZM0TYpCujmLOsi2UIB1DIaz6qtbu0o4Cenq+kgpluYByqvMcKDbWxI47Y22I1upB0qTN6U4Qt2dmETHyaheYy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=sS1+/c9w; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BD28E20883;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rheoXOJyrX8J; Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3C32620538;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3C32620538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720866265;
	bh=fJ9lX0n45V4K/TpGJoJvmS8bb5vqkaqmJQfsif4zNWY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=sS1+/c9wtfKC509Phi1a/KFD7j4cuchPNHOX4OkdCT73o6ON0IKQJb0gs2Mwkl+dY
	 5VpP3TQq0V1cbwG668LoCtYGlY9FXLMwaSt5QmsYQS07TVOvFbTwRIhWEotOBfLFFe
	 WKZouj9BGQNFUu+cXcPUJDeow9VWs9eH7X1FcDXS/o6uQcHjbc94rwbhyp6KMIWfIQ
	 rbLYxYjgBfDcIvPPRIBEUsXg9gTom7NnPtsaBk8O4rR3Hdr0hadMt59lB+4scfhLoQ
	 /axg/ft/OQgYN9eBLspLK2KEU+vtFuZtPzigPQQkNMUj+nnkvM7BpKtNEVoMhgXCVs
	 kxRJUWxoZGJyg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 2E63180004A;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 12:24:24 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 13 Jul
 2024 12:24:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 56F183182D3C; Sat, 13 Jul 2024 12:24:24 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/5] xfrm: Allow UDP encapsulation in crypto offload control path
Date: Sat, 13 Jul 2024 12:24:14 +0200
Message-ID: <20240713102416.3272997-4-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Mike Yu <yumike@google.com>

Unblock this limitation so that SAs with encapsulation specified
can be passed to HW drivers. HW drivers can still reject the SA
in their implementation of xdo_dev_state_add if the encapsulation
is not supported.

Test: Verified on Android device
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 2455a76a1cff..9a44d363ba62 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -261,9 +261,9 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
 
-	/* We don't yet support UDP encapsulation and TFC padding. */
-	if ((!is_packet_offload && x->encap) || x->tfcpad) {
-		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
+	/* We don't yet support TFC padding. */
+	if (x->tfcpad) {
+		NL_SET_ERR_MSG(extack, "TFC padding can't be offloaded");
 		return -EINVAL;
 	}
 
-- 
2.34.1


