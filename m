Return-Path: <netdev+bounces-110774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D692E3F4
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886A2281118
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73053157E91;
	Thu, 11 Jul 2024 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qbxzzscU"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEF152189
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692038; cv=none; b=JZwbLLe0DLxoDDoG1G1ee0pGOxTHKSdW6a8lmerJcin40tHfbRIP3KEh4vsB2dZZSMCZ5huqY6VXq1dI0Ra5vvAIVAIlYXxY+J1vXZ3Rdfxv6wgK3CUduvM6M9pLTMNGZqGX3YNnXDr0uIhSQzb5ktNiQaOBGtXEZ9FvQZ23D3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692038; c=relaxed/simple;
	bh=3rv1EJt6LvZGjPTkd2+llbK12xhPaNAC5HkkEi+ocxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkVyKyaMkqpSvI9VYqwfy6xW/oFTpn1iEAVNUVmwnsCS2yLelhMSsk6bBiG4ZifId0Bcvj5NrlBahZOu5sPrSJn8BPXkuLsOhm6KPNEceaz9FOsBFonjX9a9pC/Wvft2pTaQ+cavC1XtE5bcoDWUyMdJLW1/vwojJJxTca8KGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qbxzzscU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 53543207F4;
	Thu, 11 Jul 2024 12:00:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VdgFcEsuw812; Thu, 11 Jul 2024 12:00:34 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CB0B420842;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CB0B420842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720692032;
	bh=lz3ENUENSBukwoZCDr5Dtl5GUPmng84rif7CCDfOudw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=qbxzzscUs43J9QG+YrBG6cwlhqPRBVtJx3hJa02SjDb+zOmOlDx19emhA9D1vC+/G
	 iILX2+ONHBXV0f6/G6aTKoib0ngsMMUNUjagfl/6CuuJGp7EKOknY0ntLx9nbbp7K+
	 p8m/pw6lnBeXjwKVslcYitk0KMF4QMZj0obHpC4/YjYpUh+uUG5rHrBl0LZhcT2GAm
	 b7TkLb/Appanxnjtvf3jQ4mugGsqBPFiz7MF8/7Q9QFQE3H7EZGfQWIfctWyn+DWWc
	 xWsMWa0+UTZFdFoDOrKlF0wv7dvFeoo3dwvUI7/vR9eRzlDSB6gal+19+Ozui6H2AY
	 vAHHKSMv28M6Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id C5B9880004A;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 12:00:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 12:00:31 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 186F13182C9F; Thu, 11 Jul 2024 12:00:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 6/7] xfrm: fix netdev reference count imbalance
Date: Thu, 11 Jul 2024 12:00:24 +0200
Message-ID: <20240711100025.1949454-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711100025.1949454-1-steffen.klassert@secunet.com>
References: <20240711100025.1949454-1-steffen.klassert@secunet.com>
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

From: Jianbo Liu <jianbol@nvidia.com>

In cited commit, netdev_tracker_alloc() is called for the newly
allocated xfrm state, but dev_hold() is missed, which causes netdev
reference count imbalance, because netdev_put() is called when the
state is freed in xfrm_dev_state_free(). Fix the issue by replacing
netdev_tracker_alloc() with netdev_hold().

Fixes: f8a70afafc17 ("xfrm: add TX datapath support for IPsec packet offload mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 936f9348e5f6..67b2a399a48a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1331,8 +1331,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			xso->dev = xdo->dev;
 			xso->real_dev = xdo->real_dev;
 			xso->flags = XFRM_DEV_OFFLOAD_FLAG_ACQ;
-			netdev_tracker_alloc(xso->dev, &xso->dev_tracker,
-					     GFP_ATOMIC);
+			netdev_hold(xso->dev, &xso->dev_tracker, GFP_ATOMIC);
 			error = xso->dev->xfrmdev_ops->xdo_dev_state_add(x, NULL);
 			if (error) {
 				xso->dir = 0;
-- 
2.34.1


