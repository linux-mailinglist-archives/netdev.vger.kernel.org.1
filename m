Return-Path: <netdev+bounces-161060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4437A1D0CD
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 07:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E173A6B4A
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A843A1FC7D0;
	Mon, 27 Jan 2025 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="sF4VNdi7"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3421FC7CE
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958086; cv=none; b=PFPheuq2ubHTOTl56qABunHEczWdQGHunSUmSbdHVlTiZ+jmFI43Q1F8XRxslayeJj2H812tvCeDAv58Cb5uUzUhIw2tvEDGnH0XEDJPvLv+5swolzhRVuO8HkP0WUIqLzXaGq5i0hdbyHmWB1f1wyriIekTypU67N6ehqiFmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958086; c=relaxed/simple;
	bh=aWWohmYw2H9P//PGTeMTRlcBDUV7hhrycorrD8bAnN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKgYpIzqbfPO/UIAFYz12kM95xUqud6CFg4WcNThZMH0Rds/dd2ip7dv3TONYSA6RkWnHrZ0pHJoaCI7H9fR5lzlmqDdl0sG2VyJnLskIAQSQJg/A2bTjDRyjYxM0a82qDntjXfsPqNaxsdFAP3aTfCT6R+eHtBqEiI04HloPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=sF4VNdi7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DA39020518;
	Mon, 27 Jan 2025 07:08:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TyRTom4vjm6a; Mon, 27 Jan 2025 07:08:02 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D8092207AC;
	Mon, 27 Jan 2025 07:08:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D8092207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737958080;
	bh=UeOskQ6csRAAogDjKy0FM27y5bnGyr9x/0vNP5OdCvA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=sF4VNdi7NeCZ7ZZvgyHUxjFFQxwsO4EelFi357QYHRsNl1Ey6NcrZjGqBhMg5OUJJ
	 hbZ0P5mZj8mekoqOFxI7Jxg8mUtF5Mcaw/ZfOTxKMrJjOIOX3bJ9B0k5KAP287mABF
	 6GHCD1zgCnWE5YLAoU5nKqqjefJisRGaNbMAyVsEzVzXqQgTcFNSTgCUA74R5Lrhtv
	 Wmexh6RVaMpTCfXA/OG2CgTsq6PXDLw8wyrfhezJrO986brTr8dJ/LSdA0TczjbJWX
	 jxUHDmc5acxralb/oB2PqxxR7+0RiRwMcg0Oy1vNRpK4TXXAVywDbivhWvUy4HVZaW
	 isQhOp+mh6+0A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 Jan 2025 07:08:00 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 07:08:00 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C7BFE3180585; Mon, 27 Jan 2025 07:07:59 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/5] xfrm: replay: Fix the update of replay_esn->oseq_hi for GSO
Date: Mon, 27 Jan 2025 07:07:53 +0100
Message-ID: <20250127060757.3946314-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127060757.3946314-1-steffen.klassert@secunet.com>
References: <20250127060757.3946314-1-steffen.klassert@secunet.com>
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

From: Jianbo Liu <jianbol@nvidia.com>

When skb needs GSO and wrap around happens, if xo->seq.low (seqno of
the first skb segment) is before the last seq number but oseq (seqno
of the last segment) is after it, xo->seq.low is still bigger than
replay_esn->oseq while oseq is smaller than it, so the update of
replay_esn->oseq_hi is missed for this case wrap around because of
the change in the cited commit.

For example, if sending a packet with gso_segs=3 while old
replay_esn->oseq=0xfffffffe, we calculate:
    xo->seq.low = 0xfffffffe + 1 = 0x0xffffffff
    oseq = 0xfffffffe + 3 = 0x1
(oseq < replay_esn->oseq) is true, but (xo->seq.low <
replay_esn->oseq) is false, so replay_esn->oseq_hi is not incremented.

To fix this issue, change the outer checking back for the update of
replay_esn->oseq_hi. And add new checking inside for the update of
packet's oseq_hi.

Fixes: 4b549ccce941 ("xfrm: replay: Fix ESN wrap around for GSO")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_replay.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index bc56c6305725..235bbefc2aba 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -714,10 +714,12 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
 			oseq += skb_shinfo(skb)->gso_segs;
 		}
 
-		if (unlikely(xo->seq.low < replay_esn->oseq)) {
-			XFRM_SKB_CB(skb)->seq.output.hi = ++oseq_hi;
-			xo->seq.hi = oseq_hi;
-			replay_esn->oseq_hi = oseq_hi;
+		if (unlikely(oseq < replay_esn->oseq)) {
+			replay_esn->oseq_hi = ++oseq_hi;
+			if (xo->seq.low < replay_esn->oseq) {
+				XFRM_SKB_CB(skb)->seq.output.hi = oseq_hi;
+				xo->seq.hi = oseq_hi;
+			}
 			if (replay_esn->oseq_hi == 0) {
 				replay_esn->oseq--;
 				replay_esn->oseq_hi--;
-- 
2.34.1


