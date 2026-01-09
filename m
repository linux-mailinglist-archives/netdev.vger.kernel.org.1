Return-Path: <netdev+bounces-248509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CEBD0A76B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B728C3051E86
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498AA32471A;
	Fri,  9 Jan 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="F/m6GjBG"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7231B808
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965840; cv=none; b=OmDcmLGVD14yIcD3hQf8lQyMAmZC9NeWuo/v1yCVzqScN9kVzmYZ1CzxcaQhnBN+8G8ehKU40Zah6sb/AzZevzbZALlPZh9/nfk1OLfAzqlDuUei87IbntyfpT9RevEVfS+qBAVg+3LdjvG434jJEvMPTO9M+9+DhPgWoxoj6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965840; c=relaxed/simple;
	bh=HDZGXuP1K2GKCWJ2fbvVeWaPAhcIjCwuB8Xw/ArsrlA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASnvPxOkb6az+demhNOs7gwgCuBx82KT4w7Jn+N1YXB2eRvezBDbxFAbStku7yZqKlEGZDgx8wJkFG9kXDJswPsH6cvm3KpCrWeirspJ/yK7T8thHnTqAN149Ngg4YSFcy3XT7BMCzteVwzD+mZG/GXnkqUcutPe7JYKe0gXBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=F/m6GjBG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3509420844;
	Fri,  9 Jan 2026 14:37:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Njs4EEuirwLi; Fri,  9 Jan 2026 14:37:15 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AE69520684;
	Fri,  9 Jan 2026 14:37:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AE69520684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1767965835;
	bh=BL6C4yROMpcwTaRCVXVGhoJDAv0gIaSvYoN9j3XkgZg=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=F/m6GjBGr2eSIDOnejaxkO9ev8zo48Nprmz89W6O9XcO8OEvhw/ukyYkfBvtgfNDR
	 doNiglXYiFd3uq6iEYC8q9ExDwmX+9YLxQOo5AGdj52ctX8Ll7x0WLedTISG1vdFrA
	 TAEj33RrOzBmiKl0+o0Whneq5VJI0ABdLH4b0SZd1E+TPTzik4tkobuqJEb2IWpSWB
	 WetzvfojnNWEey4OFxeI4W8ApWugGkWVFKIj+gQpO8g4SRqnXMu72gdC7JfFgEy8k+
	 Jk8xRsNeLuBOpc2ZRLz7ov2IJVD47jU4Spwo0+v7v/Ph3kWgRSS940RX+nu95NNJcR
	 IMj/0QNdDYHsw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 14:37:15 +0100
Date: Fri, 9 Jan 2026 14:37:08 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next 1/6] xfrm: remove redundent assignment
Message-ID: <393387273f8a903a6205f1faeb020ce92ddd61b9.1767964254.git.antony@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <cover.1767964254.git.antony@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1767964254.git.antony@moon.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

this assignmet is overwritten within the same function further down

80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")

x->props.family = m->new_family;

e03c3bba351f ("xfrm: Fix xfrm migrate issues when address family changes")
---
 net/xfrm/xfrm_state.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9e14e453b55c..5ebb9f53956e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1980,7 +1980,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
 	x->props.reqid = orig->props.reqid;
-	x->props.family = orig->props.family;
 	x->props.saddr = orig->props.saddr;
 
 	if (orig->aalg) {
-- 
2.39.5


