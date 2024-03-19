Return-Path: <netdev+bounces-80554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4E87FC7D
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2B91C211D7
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AA7D416;
	Tue, 19 Mar 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SjKarloD"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A832C857
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846120; cv=none; b=PG7FfaH8kWp1Y4LXEc3nwK2gR3FKjT3eYYVVeMfRJkYDUhtOgnHtbg1MkN9kqIlOW8gy5MK9N0WOG7KLgeA+Du/3NkU6+uqiurfoTyMchPfvDvAmtP2ju3JYND+0CxmHuup/TDpC23urMRmSyOJRs73OISz9gqYCg049lUho+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846120; c=relaxed/simple;
	bh=4Ji0F+6DqSVzmEtsTGDJ2n41s2VgpF8cKBJ+TEEDY/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NusuGqa5xWxv/Dc/WFcc18EkU2j6Ohuq/85YOFcmR/1mayaxGQZTE/R4KdmazL3EqvyA2vz19BJDo303388PBMbdBgBkaWnB2WKOIBZPtx+U+PMxYPy0FpJBlLScA/clkIi2urPMt0jHzx3a6vHQRgWBGd/C/6ns63h7L2/Tkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SjKarloD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 125292085A;
	Tue, 19 Mar 2024 12:01:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XbihLTTq13HW; Tue, 19 Mar 2024 12:01:56 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 45F6520561;
	Tue, 19 Mar 2024 12:01:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 45F6520561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710846116;
	bh=M0t9GFkwr2lDZo1W/5tOqhZpPFBL/aOC9aKiwhE/g+Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SjKarloDSdspBkf1yeAO+pTZ/EgFsuV615tzq0wxaHfom7jm+VV30wpyJBAxhdokG
	 zCiQEC2mjpo88oFFngxfXCN1fSxvm4/7jlRQ27I7to6BOxS0SdT++KLa6CRigfP18r
	 91gCCDSRpepmEupDdUXJ+jUPf2HGKB74tNQ5jQfJBnAvAyomX5AGW8EBpkTayUiCHF
	 Ii0JNRbCRQ5troSX2jK5BoVDOdy2Znt5za8CY9LtPRCNNAjS20VJqr5ZVmaQ/cpySO
	 AK3vNakRHeX219UGs5Z+UfAoAJYiS8mRFOCOJbd8fBE5R7ogsi3HQ5bgt4m4JJmJdR
	 FYDyGIiOSjjEQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 3894180004A;
	Tue, 19 Mar 2024 12:01:56 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 12:01:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 12:01:55 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7BF0C31849C9; Tue, 19 Mar 2024 12:01:55 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/2] xfrm: Allow UDP encapsulation only in offload modes
Date: Tue, 19 Mar 2024 12:01:51 +0100
Message-ID: <20240319110151.409825-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319110151.409825-1-steffen.klassert@secunet.com>
References: <20240319110151.409825-1-steffen.klassert@secunet.com>
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

From: Leon Romanovsky <leonro@nvidia.com>

The missing check of x->encap caused to the situation where GSO packets
were created with UDP encapsulation.

As a solution return the encap check for non-offloaded SA.

Fixes: 983a73da1f99 ("xfrm: Pass UDP encapsulation in TX packet offload")
Closes: https://lore.kernel.org/all/a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 653e51ae3964..6346690d5c69 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload)
+	if (!x->type_offload ||
+	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-- 
2.34.1


