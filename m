Return-Path: <netdev+bounces-126477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CB9714AE
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8BD1C22DD4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF001B3B3B;
	Mon,  9 Sep 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="iZAWkVt0"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42611B372E
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876219; cv=none; b=UNUlQwHy7AQ8U+8ZOPAJ+WOUhRV4vzgzdeYlhmuc5Glx+986iKMfy8u7YPGOw0fSIjGbtUs4CtMRkeCjdjOx8ft1wThyO3mXVgb80Dt3XCyjKGfZ3s4+fmqVk1Lt8rhVBXNeqZcAlJm5aj+PaBp8dgHQ4AkEZkWY7absOWVrYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876219; c=relaxed/simple;
	bh=+SbKLY9ekWtvCpsoEeDJDea7E3dKxbOXJ6URsTJI7E0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1HT+QfaG7gsWA13aBiCkoWJHToUXW7ksecxMEHQ2mpY+s+9EfEvIYEdeqvH6kDdBDjrdjxKmUTdPtnMmY6g7rQv/NV1MOHnSdE8XJi/qhFvI5T0uxIrzYq9iHC+Munw8amxGlaHq6CoVOS2xn8LSfjdwp6hTny0Ym6F7KW49zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=iZAWkVt0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 34BC920860;
	Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ygir48L341O0; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AE401206E9;
	Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AE401206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876214;
	bh=9DxBnrBqrI1fauykSdDQbfNexO00HM31/1T7Fp35It4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=iZAWkVt0GLVVuxCtOvnEgFktQ1K+UH+hPdjiwKsfWFsHdrHvt8DlZ5mCePfpA9XcD
	 lqRnbHjiK5ujffNkRc87bZ14i3HUD4B8IO6Na8y4FVzShHAnN2qIqUEerKAxdrtXed
	 MwAc1amhFd03e/TnDP0cgHyXlCcvGlPt4z4B3oZpM2+d+Vyfy3cjzfP6K5ect+0Wnm
	 Vz8+yAvWEvbgdBLJgN8QekMt+9Rh+YTW/pgzu2QfINnScgFzc2R26Wu8lzI/zmbb5m
	 AZ7u9jR9oyxtDFvP0W/Kc8ln8ggApzHeSj6hmQr3Krz2hw7U5eMdNwUmyn5BnKTjj0
	 T/xx+8y5FBc4w==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:03:34 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:03:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2E4453182E67; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/11] xfrm: Correct spelling in xfrm.h
Date: Mon, 9 Sep 2024 12:03:20 +0200
Message-ID: <20240909100328.1838963-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909100328.1838963-1-steffen.klassert@secunet.com>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
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

From: Simon Horman <horms@kernel.org>

Correct spelling in xfrm.h.
As reported by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 54cef89f6c1e..f7244ac4fa08 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -79,7 +79,7 @@
    policy entry has list of up to XFRM_MAX_DEPTH transformations,
    described by templates xfrm_tmpl. Each template is resolved
    to a complete xfrm_state (see below) and we pack bundle of transformations
-   to a dst_entry returned to requestor.
+   to a dst_entry returned to requester.
 
    dst -. xfrm  .-> xfrm_state #1
     |---. child .-> dst -. xfrm .-> xfrm_state #2
@@ -1016,7 +1016,7 @@ void xfrm_dst_ifdown(struct dst_entry *dst, struct net_device *dev);
 
 struct xfrm_if_parms {
 	int link;		/* ifindex of underlying L2 interface */
-	u32 if_id;		/* interface identifyer */
+	u32 if_id;		/* interface identifier */
 	bool collect_md;
 };
 
-- 
2.34.1


