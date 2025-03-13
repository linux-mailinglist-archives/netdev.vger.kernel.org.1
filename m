Return-Path: <netdev+bounces-174465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BFFA5EDB5
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A9D189DEF4
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA41FC7DF;
	Thu, 13 Mar 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Kyt6mnhc"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E86260370
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853482; cv=none; b=Kt1XCkFXLzPZkEqr8kkdsSWegKNUlciDlX6cNr8zpf5i0PrUNh5+14+y6nd/bdWnsUjEn/rpKm95Ii1YYOv8CpLaJaFL86X7Oca/bvP2qxUKCqWWSfrQYlLMvqiaJuwvzaTioONWjmkn6vlzaRR5/I+wR85qVEPwQlB5Ft1/sDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853482; c=relaxed/simple;
	bh=ZC19aoU0J1V2KEDdu69vSLcxl186Gf5C7aeK+LWEmcA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dWDLZFQaXUchtNPjWTkHP1j8rafi2reP3sVbtkg1T2/9vB92r4XA42PF3KygTwnD/yPgErgb/Mlc/S6j277i0T/W6N/PP6Rh/M0BugBn195yaCTCtNuc0W9aHDFimD1XFff4GoxhFFIp0d3ivjTYiF53WMj2RpsXaHgF4WEgM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Kyt6mnhc; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dqXcrVtJR1aMKddV8xr+/ZVzFDp+B3KiJDfpbRIGgx0=; b=Kyt6mnhc/Xex/C53l/rBHqpVKm
	57kCGrP8qmTheryHARsX6ARbMnNt0O5LcnbxmkesEd5nQV1QP0mh9hwZVzOza1wzB8Y+W3+Nco2gx
	vtPPEUAnVf5SnJjGlntRTQrdb4leLLDwDX0J55Dd95i1yZrJ2jnerRVR/zAEljq+iTG+xRtRRNTPL
	3wOe4afqiyyyM6v+SdXPhr01VTIEmaViBipZGgaS+h7sze6+pEZdzJ35zwkGw92pZZqOofshUYO1W
	c8sJU7ZW7DoJl7/AjDSzrSAxxhi3DLq7qJ4R12XjnaMgLt1oFcTRZ6xv9IJ12vFRfIvhgHJDEyZdn
	pEtzhv5g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tsder-006AHh-2A;
	Thu, 13 Mar 2025 16:11:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 13 Mar 2025 16:11:13 +0800
Date: Thu, 13 Mar 2025 16:11:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Subject: [PATCH] xfrm: ipcomp: Call pskb_may_pull in ipcomp_input
Message-ID: <Z9KTIYVFwEIYXgd7@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If a malformed packet is received there may not be enough data
to pull.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 net/xfrm/xfrm_ipcomp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 9c0fa0e1786a..43eae94e4b0e 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -97,6 +97,9 @@ int ipcomp_input(struct xfrm_state *x, struct sk_buff *skb)
 	int err = -ENOMEM;
 	struct ip_comp_hdr *ipch;
 
+	if (!pskb_may_pull(skb, sizeof(*ipch)))
+		return -EINVAL;
+
 	if (skb_linearize_cow(skb))
 		goto out;
 
-- 
2.39.5

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

