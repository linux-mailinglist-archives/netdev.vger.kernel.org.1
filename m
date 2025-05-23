Return-Path: <netdev+bounces-192972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C763BAC1E31
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65A63B4FE0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08628689E;
	Fri, 23 May 2025 08:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158F27FD7D
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987469; cv=none; b=NTNmeYiAGYYRtsD2SelCzi2hxWQrpFQt9BaqYLMnfKPxOeeo70A6etRyU8J/hy0YRBqVbegXdNJI51oYRFLuG+uvBKaSw3xHvFbgn4SWdIUjcD6pS7Uhkmr+2mNnmXM183oIKepmk36Rp1GIzU0cJkgVuKVLPH1umjs0Uv7hAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987469; c=relaxed/simple;
	bh=esucwVikj1hyyI5PGCMK8Hc9G3LEBZrKgsxdDPzBhs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCeKnp6uvkdj9II5bdb5Vf6V3fw70M9fzHPSnD4F3uLfLmk+8rBX0cGpVBPSnXpaNQ+RwrLI7sjydGEJStPNKR3newkRU87ijmnnDIFVqL7RHrYHNSHs9PozyrVpBKYI1eqs0MvbmpgGoALx5qhWxJKMAs7jc7muKIxCt5SrVCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9336420748;
	Fri, 23 May 2025 10:04:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ej_6GQVENi8; Fri, 23 May 2025 10:04:25 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C2EDC20826;
	Fri, 23 May 2025 10:04:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C2EDC20826
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 10:04:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 10:04:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4227A3182B12; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 12/12] xfrm: use kfree_sensitive() for SA secret zeroization
Date: Fri, 23 May 2025 09:56:11 +0200
Message-ID: <20250523075611.3723340-13-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

From: Zilin Guan <zilin@seu.edu.cn>

High-level copy_to_user_* APIs already redact SA secret fields when
redaction is enabled, but the state teardown path still freed aead,
aalg and ealg structs with plain kfree(), which does not clear memory
before deallocation. This can leave SA keys and other confidential
data in memory, risking exposure via post-free vulnerabilities.

Since this path is outside the packet fast path, the cost of zeroization
is acceptable and prevents any residual key material. This patch
replaces those kfree() calls unconditionally with kfree_sensitive(),
which zeroizes the entire buffer before freeing.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 4bf7a4a8f9d4..5e1c736ea708 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -599,9 +599,9 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 		x->mode_cbs->destroy_state(x);
 	hrtimer_cancel(&x->mtimer);
 	timer_delete_sync(&x->rtimer);
-	kfree(x->aead);
-	kfree(x->aalg);
-	kfree(x->ealg);
+	kfree_sensitive(x->aead);
+	kfree_sensitive(x->aalg);
+	kfree_sensitive(x->ealg);
 	kfree(x->calg);
 	kfree(x->encap);
 	kfree(x->coaddr);
-- 
2.34.1


