Return-Path: <netdev+bounces-77857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD31873383
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0471C227A4
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91F5F56B;
	Wed,  6 Mar 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rSwNOI0+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0D5EE8E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719496; cv=none; b=mlyM3IrvA6qyQD76nGvo+38px/QLBvLnDwX0hR/Oybul+SYTowhqxpGFwkfSBwja0nSwUjucgC6Gzj3GREFL3ruaROIwMQObk9+SPhHwraMXGj3gyB0bL0A02UOBJYcpqnd/uIoDh9NcwZivlo8uOR+Df8NuxPHg5hDAYnP+84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719496; c=relaxed/simple;
	bh=eb/89zoLezhZh2GWT8FG/tMhWAZ5quNy/76J/6WYi+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCb3MFiyviNtjMnXmdR0ZC4S+b62P57XPK29wP3jnnBHADAZI26gp9T3HDwuwyKFtmr21xwI3ZdNxLGnG6zleL86Ol6+5iyZv7MpnGH0V0XoG0NM9VxnS2qV9cmY5xgbbO7zqsBLD/97mRM0x5dSXcUEM1cnQtDDcMgxnDn0Dyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rSwNOI0+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BC7CB20799;
	Wed,  6 Mar 2024 11:04:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w1kDx9vWZaMK; Wed,  6 Mar 2024 11:04:51 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E4FB620826;
	Wed,  6 Mar 2024 11:04:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E4FB620826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709719484;
	bh=Jd8b6CAdN5EUPhv+G9yyVNy0uzQDuqI3kXdZAwlqFm0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=rSwNOI0+36tab4zt+Tb3vn6m/CAqEVH4qqee2WGrWy64dmAl68v0G/aG2VuvQY7m/
	 LENqgeJLPY9gIFG1U9dyLTU0HCyWMFIKEZoMjcWQEm+9D+PdOYpBoWv1cB5vEDmMBu
	 MCEaJprQ/SqtKoSXf2KIzzyTVOQ5M/UtoNwD1hG/FshUhKLxzsENZHjksPpLuYPqds
	 tFpaOGIW1SJyQiSQi+cw9RDVDuxWlmTVUxsJswqdlM+bNL8h8kPvO9d/E5fq2RcdfO
	 NkhqrL7sFU1yWtnvhjcB61nVK6lCrfl7UQu4GZ3UEZGCb1c6LWzaEvgmIwGKHgVkFP
	 7D4COwKC5hZNA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id D63B380004A;
	Wed,  6 Mar 2024 11:04:44 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:04:44 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:04:44 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CED9731816A6; Wed,  6 Mar 2024 11:04:43 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
Date: Wed, 6 Mar 2024 11:04:35 +0100
Message-ID: <20240306100438.3953516-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306100438.3953516-1-steffen.klassert@secunet.com>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
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

In addition to citied commit in Fixes line, allow UDP encapsulation in
TX path too.

Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
CC: Steffen Klassert <steffen.klassert@secunet.com>
Reported-by: Mike Yu <yumike@google.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 3784534c9185..653e51ae3964 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload || x->encap)
+	if (!x->type_offload)
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-- 
2.34.1


