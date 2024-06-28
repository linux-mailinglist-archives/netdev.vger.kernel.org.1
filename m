Return-Path: <netdev+bounces-107597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4391BA53
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6AF2840E7
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639C14D702;
	Fri, 28 Jun 2024 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="loXPFda+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144D14F98
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564398; cv=none; b=ZjyzSdlMS6pXUMW/5fFw8i5i0KJ3VXFU9+uvY9+Wz7oH59uiv8GO7rDg7evMF9U7iQUj/N9lQT+e55/VPJCyq6yx/4igz5HNU2VOKEXhhv3vsiw49Y7c62WD21XiGI6oA2DBzegIUdHteIe9dC0yGLGiadDurotaU4/i2Dxg2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564398; c=relaxed/simple;
	bh=dJsUV1DLCbStWgCPAlGDldeSpJ4gL5L8UWwR5UNRoE8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ro7RNJrNxcUIvRKuIhL6WD3ts41fMp3XDWhCF4QDmsZyDZkAZ2VF3QJxV3sfjqhMuN0vfsvhUNlCerrfi7ofL8ASe3H0LJwKhEcKS4Cy5wb2bF29TzePrY6dJt2JYvAeaUNtBUYrJT6113goWPlSS2+nURJ6m2O4A4FhqYcIbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=loXPFda+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E9E1020728;
	Fri, 28 Jun 2024 10:46:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id flpiC7SZocD6; Fri, 28 Jun 2024 10:46:26 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 70B91204D9;
	Fri, 28 Jun 2024 10:46:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 70B91204D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1719564386;
	bh=EZzivE6jjbiWTxAw6Gn7BviIXqhbGJ1k+97AZ38Os9U=;
	h=Date:From:To:CC:Subject:From;
	b=loXPFda++Daa+cnJJFuu5Ip/egbA0bNEXvnL5aCo8TFMzdywHJamYjOVuRe442mqQ
	 j4XxNj0Loaw9EhnzCtjCQ73/7UZAkD9ksDxQNm72Mb0HUh+8UVCVpbkFmJ1YdE3Pxd
	 f/R3xmmaKUNZK9ElcWyDuzp7gJ3xFcOZUBWe/fCh3NtmIzYr1d1qpQctrwfdZIdjBK
	 DWkstkNYO0QtUJjlaa05rmbijWJBz+W0MFaYU0NgHY5ARRMs5zNjZ4lxuAa3yZg+8Z
	 fV24InrRf3cwwN20RL+sXfIuo9zeuyhqnnBvIpOKhFpuQ+/gZWNK9fAMUAts6J1qmF
	 CL4xF3GOF1sHA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 6961380004A;
	Fri, 28 Jun 2024 10:46:26 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 10:46:26 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 10:46:25 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 895AB31804F1; Fri, 28 Jun 2024 10:46:25 +0200 (CEST)
Date: Fri, 28 Jun 2024 10:46:25 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>
Subject: [PATCH ipsec] xfrm: Export symbol xfrm_dev_state_delete.
Message-ID: <Zn54YVkoA+OOoz+C@gauss3.secunet.de>
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

This fixes a build failure if xfrm_user is build as a module.

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d531d2a1fae2..936f9348e5f6 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -698,6 +698,7 @@ void xfrm_dev_state_delete(struct xfrm_state *x)
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
 	}
 }
+EXPORT_SYMBOL_GPL(xfrm_dev_state_delete);
 
 void xfrm_dev_state_free(struct xfrm_state *x)
 {
-- 
2.34.1


