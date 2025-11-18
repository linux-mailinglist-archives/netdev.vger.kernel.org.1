Return-Path: <netdev+bounces-239434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE430C685FA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 70FE72A942
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BB332D0D9;
	Tue, 18 Nov 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QlbRwTl/"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEF32C323
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456042; cv=none; b=Sl1vXGMIwOUitMv28s3bTX1qj4tvCx+LiSDoERQv4FjHbPgsFONyTIhRusvOiOEzxChgqpbk/Mp83Z2miaigZiBybzorN+3+pftowYrFwOEQMfsegyP/fCZ5qWE1oK/+v/2wSAJgbJLAYgzFPHZjOw7Oz2nW3C1A99GTfzW9vms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456042; c=relaxed/simple;
	bh=NZNDZ0V0bIsGo7pJNp0FXJTEZkAuHd8x+UvhyMpHfrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r24ZjFlGHYdBEFgbIJHliPhtG9GxkZEMIk31X/QBV6VAuhuega+t+Fhrb3PfBdP3vmPiPGRNenJ+jR7GyZdGtQmfQc5dFKowrnrZCzs+asqBih/jlaetVrR4AQMChOTqFKdC3PPOnT4o+74FTuXUgOb6lF3NrNoZpNQplp/pb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QlbRwTl/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 842DD20743;
	Tue, 18 Nov 2025 09:53:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fZmKnf-wcjkn; Tue, 18 Nov 2025 09:53:52 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EC04920839;
	Tue, 18 Nov 2025 09:53:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EC04920839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456032;
	bh=UCquora3kYe1F0r0/E8p3XMJAfOr2Qu7w0ORHn4I5xQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QlbRwTl/8XgblmMrmxwv1lee3WXIMLbYh9kNbtjfT7r9kb6EjHVIyLhNSAHcwHkBS
	 SzLrBW5PbzGFPwXt0CnNflIj7BWN2OgVM+veQumBz6BZBuEw/oPwYZAPrM4HPvTKAi
	 WQ2I7z6g2yC52U+Ki8PTwKHoeTRSrMsZiCjpFCW9QBMLv7tvPM7GVR+EutFz9//qvR
	 48SPXU7vgb47QaqmnLhqRia2SvO7zuQrDj5Ms52Ec+blQV8Wq8+/BDhM2XnwBM+Oyp
	 2hJ3fgrH4k/pU4ixK43BauJ6PjyIiWSF9lEpbjlwkEiCnm3jDc8b0kJR58192epRoU
	 CKB9CeY1DmkxQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:53:51 +0100
Received: (nullmailer pid 2200662 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:48 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/10] xfrm: check all hash buckets for leftover states during netns deletion
Date: Tue, 18 Nov 2025 09:52:39 +0100
Message-ID: <20251118085344.2199815-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118085344.2199815-1-steffen.klassert@secunet.com>
References: <20251118085344.2199815-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

The current hlist_empty checks only test the first bucket of each
hashtable, ignoring any other bucket. They should be caught by the
WARN_ON for state_all, but better to make all the checks accurate.

Fixes: 73d189dce486 ("netns xfrm: per-netns xfrm_state_bydst hash")
Fixes: d320bbb306f2 ("netns xfrm: per-netns xfrm_state_bysrc hash")
Fixes: b754a4fd8f58 ("netns xfrm: per-netns xfrm_state_byspi hash")
Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c3518d1498cd..9e14e453b55c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3308,6 +3308,7 @@ int __net_init xfrm_state_init(struct net *net)
 void xfrm_state_fini(struct net *net)
 {
 	unsigned int sz;
+	int i;
 
 	flush_work(&net->xfrm.state_hash_work);
 	xfrm_state_flush(net, 0, false);
@@ -3315,14 +3316,17 @@ void xfrm_state_fini(struct net *net)
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
+	for (i = 0; i <= net->xfrm.state_hmask; i++) {
+		WARN_ON(!hlist_empty(net->xfrm.state_byseq + i));
+		WARN_ON(!hlist_empty(net->xfrm.state_byspi + i));
+		WARN_ON(!hlist_empty(net->xfrm.state_bysrc + i));
+		WARN_ON(!hlist_empty(net->xfrm.state_bydst + i));
+	}
+
 	sz = (net->xfrm.state_hmask + 1) * sizeof(struct hlist_head);
-	WARN_ON(!hlist_empty(net->xfrm.state_byseq));
 	xfrm_hash_free(net->xfrm.state_byseq, sz);
-	WARN_ON(!hlist_empty(net->xfrm.state_byspi));
 	xfrm_hash_free(net->xfrm.state_byspi, sz);
-	WARN_ON(!hlist_empty(net->xfrm.state_bysrc));
 	xfrm_hash_free(net->xfrm.state_bysrc, sz);
-	WARN_ON(!hlist_empty(net->xfrm.state_bydst));
 	xfrm_hash_free(net->xfrm.state_bydst, sz);
 	free_percpu(net->xfrm.state_cache_input);
 }
-- 
2.43.0


