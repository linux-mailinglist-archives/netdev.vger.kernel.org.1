Return-Path: <netdev+bounces-126824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E59729D3
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B001F2538F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FD17B50A;
	Tue, 10 Sep 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qamaNpMH"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BFE17ADE1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951325; cv=none; b=DKrkfIoMefvFgEOqXxyBboYcOyyWuBenHoIzNyVgspK6DiaxB2rvFSlmVKIiopGIW015exes9Ui5C0Amp0iMwC3Zpgnv2fDbUJWqY87UNRp05qLqFWImMDvKUZEUttY6AsravQqT5PmVU0M6r5Z6lkHsGI/RiyKcEqBXOEWxaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951325; c=relaxed/simple;
	bh=+SbKLY9ekWtvCpsoEeDJDea7E3dKxbOXJ6URsTJI7E0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgcv/7qcRB1k9sEj0jEKehQkr3s+KVuyudvyAhEuf5w31hYdwoolcclhi9GfNFPDc1iyir7S1DIrc5gkPx4TQpVcKUMMJUkDdrzLHo66GplcNNynWca2Dr1dERFPdrJPkR0A0soXE7kZv6NtWF4IHTnhAOHboZLtaU1XYrStdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qamaNpMH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EFCFE20894;
	Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zwd8_cz2V3a1; Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 40927207D1;
	Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 40927207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951321;
	bh=9DxBnrBqrI1fauykSdDQbfNexO00HM31/1T7Fp35It4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=qamaNpMH8WplFI6+oe8dTyUyXx6WL0q+pCNVAaWOCz6iM5M/Sw87gdfeaol0vOVmA
	 qlf3hzrzi6ZXShg1TiKG4nav209v0ThnvwHQ0zaTyYIi6WUL4cHhYxcK0ZcvQ9ePIb
	 q4iWg1WI2i2UD583IgWo3qKh8oDwQe+edNAK6wdSafJQfjJnr2pAJ0b8TksAeyLKz3
	 MUKYcvtEGTCqcsgch0CBRPRdKVHCJubOYynNqW4YUMJwkV6UALMVC11LJn70H6RgOF
	 1WcyyFIOYWTb0Rm17HYHBb8Fg+TztEjTVHqfMjuaE/ehPME4Jq+3tCUyrgR6zUslpn
	 JLhHOfwJKBYCQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:21 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4AAE53183D5C; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/13] xfrm: Correct spelling in xfrm.h
Date: Tue, 10 Sep 2024 08:54:57 +0200
Message-ID: <20240910065507.2436394-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065507.2436394-1-steffen.klassert@secunet.com>
References: <20240910065507.2436394-1-steffen.klassert@secunet.com>
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


