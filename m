Return-Path: <netdev+bounces-144841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4BC9C88D5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC633B23CDB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F981F6688;
	Thu, 14 Nov 2024 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="NMSTYb3d"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCF189BA0
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582422; cv=none; b=aUsT9lwFe+xcppJ0+mEUTh1m1+kQgnuGx7Vwl3CbCne3qwBf/ZAIw8MSjc/n++WtcVRlm8r9fjZmznqzRNjAoEi48Wm48bD8rCh+DuztBCg8zHCyBo3f2pTrfn3ZppjraoNQNbECYYMQZw+E2Z48cyO85K0VfO2ggIiDHJxyqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582422; c=relaxed/simple;
	bh=MA4Hnaopf9sdAb+RaajgFFOEWSTiz2WBNDKuEKx0GvE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZuxOD8jfWNGk0s6430Qsu+V1Nemen9d983yJEpS+eZQsaPG4fMCq6GVjaiU/Le8NzN8amcVoB1I5tbSFElfZ5EjWRQlcC1gh7YqNq2t48uqV9MwPjikNlcAC3GLp3JBepm6aRxPhSsKeIWsboumi2bfwnyX5qEjpcxF8FtrjMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NMSTYb3d; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E2C5F204D9;
	Thu, 14 Nov 2024 12:06:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5h4wNbJU4fF5; Thu, 14 Nov 2024 12:06:57 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 633D7201AA;
	Thu, 14 Nov 2024 12:06:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 633D7201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731582417;
	bh=jemhpuiPgcVVHEZ5+RWWWoAM1Jx15i+hWfsj9Y0Ga/0=;
	h=Date:From:To:CC:Subject:From;
	b=NMSTYb3dHdfgzw0I4vSnlavN5Bbdt/QWMheadg5+pX6A7r/DTgsJqbd8IRq1+wXPn
	 +VsYPBtByO67fJnkJ7ibhVUwZJNFGm42BZeTisK4Vb2RBpbf5e35LA2c+uW7bJVEQ7
	 sL8pne4vMer9c6KaZ+LKilJjpROfDli9Q6+BrPgtcPMr2lptVWccL5fo+nYe+r6kL+
	 1wBMQy4GWAPKmSRqGhKU6VzuR/Zqcx1iuKe0UIn0EroVE8uUWDsAdZEP8TfWqoB8X4
	 KPu7pivoAaGGaSsIDCixk1oCejLj671Uz4m+0x/R7CTVgF4YC9LOL+0mz3eOFbIeEx
	 1W/5F5MC43elA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 12:06:57 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 12:06:57 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E050D3181C12; Thu, 14 Nov 2024 12:06:56 +0100 (CET)
Date: Thu, 14 Nov 2024 12:06:56 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH ipsec-next] xfrm: Fix acquire state insertion.
Message-ID: <ZzXZ0BaL9ypZ1ilY@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

A recent commit jumped over the dst hash computation and
left the symbol uninitialized. Fix this by explicitly
computing the dst hash before it is used.

Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the policy.")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e3266a5d4f90..67ca7ac955a3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1470,6 +1470,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			x->km.state = XFRM_STATE_ACQ;
 			x->dir = XFRM_SA_DIR_OUT;
 			list_add(&x->km.all, &net->xfrm.state_all);
+			h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
 			XFRM_STATE_INSERT(bydst, &x->bydst,
 					  net->xfrm.state_bydst + h,
 					  x->xso.type);
-- 
2.34.1


