Return-Path: <netdev+bounces-241471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 205BAC84393
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F234E0AA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41F2D5932;
	Tue, 25 Nov 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YPJMcoRc"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507A299A90
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062960; cv=none; b=CMrNzEs7A1sWO4JaBRcfGRu9qIe7WnK/azLR/WHtCLXlg/x+XCUk8/r4da1vktK+8dv1Y3f2l3tMwy3vV0KtCcDK/4+v43OtgAuuDgmdm+W264Q19Dt1qvmItS70qTJmXWClE4/9yI3a3FXk6lWrzCnYJb8HU7WU8aLI+ye+PA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062960; c=relaxed/simple;
	bh=iuHG8qHuLjRksR/ObL7HeW/K/5d1wH+aayicTSqQYis=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEUYrSX8KMJJQmFLTiez+se3x7y3U/9r6gROHJPNlD/o8teH4/lwwNeGkXc1bBOtY6TNTPMSNkHsw0WS5baY4LO4MwoT0s+Y0+/W8EalxRDrMZ0HcM3/oJUNWIJw3UJW3NCQkMaX85ER17O0oGpHDn82i+O6qtuoFnHYqU995kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YPJMcoRc; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 31C512088A;
	Tue, 25 Nov 2025 10:29:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ia9pYMX84w6v; Tue, 25 Nov 2025 10:29:15 +0100 (CET)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 972AB20885;
	Tue, 25 Nov 2025 10:29:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 972AB20885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764062955;
	bh=K5103UaDIZbqUi6iHasXtEhDAVHtHgfrL5HvlIclhrI=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=YPJMcoRcNMBHZRUZMOm0ksB5UOVeUcCWoa9SsDF95d/ncr9z9z3GVy2ZUW9NQ8mUb
	 cqc+Hl1Vd4aj1Zfsss9lRHTCcbRw7g8x4sAiKRdbKzqgjA+BgUs1qRimxs8RpkrL65
	 VnIXPsu6CAFTIm22PVwuUKB/hk6GvzzFPKfNV7MMIv6OB8C5XQfzMxeeSP/DoO58Vj
	 TB7Kiy59ZUH+HN1aEjDMWUudoA0AEPGGYm1JLwC+1uGi1+lDeNszlZRMNaVz4egxcy
	 CB2giMj6slJDu5ivn8dXVor261YMNMPTacdpuAd5EBMNFfvjaspCpNCCRhHbrKyn0e
	 kAColNkDMIOqw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 25 Nov
 2025 10:29:14 +0100
Date: Tue, 25 Nov 2025 10:29:08 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH RFC ipsec-next 1/5] xfrm: migrate encap should be set in
 migrate call
Message-ID: <d587781b6703af40a717d3278fad4bc37c1e91ac.1764061159.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-02.secunet.de (10.32.0.172)

The existing code does not allow migration from UDP encapsulation to
non-encapsulation (ESP). This is useful when migrating from behind a
NAT to no NAT, or from IPv4 with NAT to IPv6 without NAT.

With this fix, while migrating state, the existing encap will be copied
only if the migrate call includes the encap attribute.

Which fixes tag should I add?
Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)") ?
or
Fixes: 4ab47d47af20 ("xfrm: extend MIGRATE with UDP encapsulation port") ?

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 7f70ea7f4d46..1770b56c8587 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2008,14 +2008,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	}
 	x->props.calgo = orig->props.calgo;
 
-	if (encap || orig->encap) {
-		if (encap)
-			x->encap = kmemdup(encap, sizeof(*x->encap),
-					GFP_KERNEL);
-		else
-			x->encap = kmemdup(orig->encap, sizeof(*x->encap),
-					GFP_KERNEL);
-
+	if (encap) {
+		x->encap = kmemdup(encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
 	}
-- 
2.39.5


