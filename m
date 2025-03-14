Return-Path: <netdev+bounces-174822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E01DEA60C81
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89FA7A5115
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50A153800;
	Fri, 14 Mar 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LGHUEe0z"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7653CA4B
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942855; cv=none; b=p7v2/J8powXdJICLsIuJwe0lwuzS4ed3LDJrQzr3VnteI65PdzGOQy6tEPv5Da/EoEZOuLKYhQblcVxRKGAroE6or4Jo2Gmm0mGvG20fqTln+QtI2sZWi7qRLPv7D9QfkP+lw4+GE35OsZxq4K/kRpNwD9vfMBzGV18eY/dwLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942855; c=relaxed/simple;
	bh=jPyU3kErwnr7TtXw6/rza5V1Ow7+zDP49bFnbjOy2gg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EKy/wYbhFw1F4IxU+8tlHd527agvhdV0lYzlRRU5B9/vfbV1S/bv1nhf6sZxpu4RA/3Gfh4vb1dDNSM/Lgur6C/guay/GfonpwFF91s2B6EMDV40jBEjA0lebvAB29b2guzvOpJuCIUOqz3tZ2ahlQwd3cZvJBIe1bSWSWtT5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LGHUEe0z; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EEUK3Igpsz4/v+Onr8NFcR5nPg8DotBJSjcnA02plEY=; b=LGHUEe0zSDJ7L7f9Tg1Xuv48+I
	GeouzSJHDtP9uu7rW5Y8PDYjo+zdJY0YPq+ljLq2vwlNMdqv4MghcikkvjT+FCQFR/QkGbtgicPo4
	PFxz4og1MORyIlgwxVysyEvGYy3O6sT8lO63O0POn1ibs5rgD+iqBbdumGrJAhjIAFg42712i2ufj
	ex6agiMqs3GCPPVC9gA5JpyUPFOmagEhpDDumSH2Ryg4EYYap+6mhcDkPoEt6qagr2cc7DRgQu8v3
	bT5evlgioTr4at9Igfa2kP0EI5xVwvl5y1H5qYZXCY+1ta1Mr8bw+yCqcXg1YK99/WlR4y+Zwmb/i
	nTnZxRVw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt0uH-006Wj7-0E;
	Fri, 14 Mar 2025 17:00:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 17:00:41 +0800
Date: Fri, 14 Mar 2025 17:00:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>, netdev@vger.kernel.org
Subject: [PATCH] net: mctp: Remove unnecessary cast in mctp_cb
Message-ID: <Z9PwOQeBSYlgZlHq@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The void * cast in mctp_cb is unnecessary as it's already been done
at the start of the function.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/net/mctp.h b/include/net/mctp.h
index 1ecbff7116f6..07d458990113 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -212,7 +212,7 @@ static inline struct mctp_skb_cb *mctp_cb(struct sk_buff *skb)
 
 	BUILD_BUG_ON(sizeof(struct mctp_skb_cb) > sizeof(skb->cb));
 	WARN_ON(cb->magic != 0x4d435450);
-	return (void *)(skb->cb);
+	return cb;
 }
 
 /* If CONFIG_MCTP_FLOWS, we may add one of these as a SKB extension,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

