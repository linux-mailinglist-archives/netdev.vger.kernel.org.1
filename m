Return-Path: <netdev+bounces-192970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE5FAC1E08
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B268A257CA
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E093289808;
	Fri, 23 May 2025 07:56:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D7289345
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986992; cv=none; b=F6t4zKwuR1CXaTULKTLzxpPARV4D46Rj1c3O00V2sFlWlYUf9atT4cVmuYLgQaCm9pFzzIiBv9cfR0UrEVq5zzhde1NIYSH5GcLZKmb32hrq8yfR+ZOkRsELXYHMnsKTahrH5A1KtwfL7sg3VesRbogSJeB4gJUrtqDazy0p740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986992; c=relaxed/simple;
	bh=omY1gQsTa3f93yzmEHPF8tuQTkdGXprH9NZj+KVkLzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lq3lVr+gr6BKnhTVK9+X9Ff0rxS6pOeqOgR9edWuj/nlKZNo69iZ/9bVBN3tRmG4NDxQ/PAVe8DjVGQYq4Yt9+QPKf4kco2Ly+XBDRShiv3N5va2qyhGOHOaQkHOP1pph7fGG6W42OM4Exp/PYp0eHf+k5UrijOKprZ0ybt36po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3484F2088E;
	Fri, 23 May 2025 09:56:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mt6NwPhPpqLf; Fri, 23 May 2025 09:56:22 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 51C62208B3;
	Fri, 23 May 2025 09:56:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 51C62208B3
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 09:56:21 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 09:56:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 376023182AF3; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/12] xfrm: Refactor migration setup during the cloning process
Date: Fri, 23 May 2025 09:56:08 +0200
Message-ID: <20250523075611.3723340-10-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523075611.3723340-1-steffen.klassert@secunet.com>
References: <20250523075611.3723340-1-steffen.klassert@secunet.com>
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

From: Chiachang Wang <chiachangwang@google.com>

Previously, migration related setup, such as updating family,
destination address, and source address, was performed after
the clone was created in `xfrm_state_migrate`. This change
moves this setup into the cloning function itself, improving
code locality and reducing redundancy.

The `xfrm_state_clone_and_setup` function now conditionally
applies the migration parameters from struct xfrm_migrate
if it is provided. This allows the function to be used both
for simple cloning and for cloning with migration setup.

Test: Tested with kernel test in the Android tree located
      in https://android.googlesource.com/kernel/tests/
      The xfrm_tunnel_test.py under the tests folder in
      particular.
Signed-off-by: Chiachang Wang <chiachangwang@google.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1c5fe1b0b6d6..4bf7a4a8f9d4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1958,8 +1958,9 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 	return 0;
 }
 
-static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
-					   struct xfrm_encap_tmpl *encap)
+static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
+					   struct xfrm_encap_tmpl *encap,
+					   struct xfrm_migrate *m)
 {
 	struct net *net = xs_net(orig);
 	struct xfrm_state *x = xfrm_state_alloc(net);
@@ -2058,6 +2059,11 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 			goto error;
 	}
 
+
+	x->props.family = m->new_family;
+	memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
+	memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
+
 	return x;
 
  error:
@@ -2127,18 +2133,13 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 {
 	struct xfrm_state *xc;
 
-	xc = xfrm_state_clone(x, encap);
+	xc = xfrm_state_clone_and_setup(x, encap, m);
 	if (!xc)
 		return NULL;
 
-	xc->props.family = m->new_family;
-
 	if (xfrm_init_state(xc) < 0)
 		goto error;
 
-	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
-	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
-
 	/* configure the hardware if offload is requested */
 	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
 		goto error;
-- 
2.34.1


