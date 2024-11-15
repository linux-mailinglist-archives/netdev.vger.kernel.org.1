Return-Path: <netdev+bounces-145204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD329CDAA0
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C6EB23BDB
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A118F2FC;
	Fri, 15 Nov 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QW5K7sWS"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FD18E37D
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659641; cv=none; b=p8vJ3t4b81H4834YlfiZIRdNsfwa2QZLL1KKhoeF2yK6Si5EGRg3uiR1nPNnNw89hbjo0oPfu/viyA8j5r7O+N6XLZ5yf1InSS03iVZW79CbpIlE1CzYRLi+UwWRHYzFlWINJeantJwSBG0MRb8fKZttQLqTfdPu9Fz2SkU0vkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659641; c=relaxed/simple;
	bh=Let4RgQYNsrMllK5eSAL1ffmYGLT9FYVD/kPqiVpryA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FppWQJx2BCDHItq1a4TU/jvJ7BHIheQBzJ/8J3rub5XHLDGuEEje/PjM8vicEQqXf+GWycfg6+cu0TIbiIQL91E4koQ+BspGgFQ58Lg4/bsTlWc6fo9jEK52bt1CzJUZMu6QFH2Bs3/XGgokw0dM66Cc8OopOBkOgQF9lMGAIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QW5K7sWS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6BF7820854;
	Fri, 15 Nov 2024 09:33:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2gr2HtuQZouY; Fri, 15 Nov 2024 09:33:55 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 74D55201A1;
	Fri, 15 Nov 2024 09:33:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 74D55201A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731659634;
	bh=ra6EklCCg1e2xZYQlOv+4ncb1mWIT/htMWwPrOJgx8w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QW5K7sWS7D/cPOsF7dNbBL9XYsR4tkc7uF+r6oIegOclwXjAblDbSlzlNqj9oaan3
	 Hwmam6sa5WEvi3ygUCwmK1Hp/PufGnJvSFCL+rs4oKCw/7Sg98mEA/bDQNuwiojW6n
	 llLdahzz8+Ttfx0ILHCwUhaMZyBTZFBePI62R+ulLWW9ndbNOP+rPKa4Sz4xYnun8u
	 bZGC4JCDV2OHIpNsr/C3oDUeLjbzMs7TnB+ZdqFywUqMQFmtVyn5nqvDOqSWRKZlyN
	 dqn9woj571gfNQpkBh1No3s9zY1VyjglNzEoKUEi1uy5wM6g6vzolLjSsIRfv0QiwY
	 ZfwpcLkgkQeZw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:33:54 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:33:53 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D58F73184514; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 11/11] xfrm: Fix acquire state insertion.
Date: Fri, 15 Nov 2024 09:33:43 +0100
Message-ID: <20241115083343.2340827-12-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115083343.2340827-1-steffen.klassert@secunet.com>
References: <20241115083343.2340827-1-steffen.klassert@secunet.com>
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

A recent commit jumped over the dst hash computation and
left the symbol uninitialized. Fix this by explicitly
computing the dst hash before it is used.

Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the policy.")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
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


