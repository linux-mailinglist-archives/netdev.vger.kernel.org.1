Return-Path: <netdev+bounces-175007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A7BA62581
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 04:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A5D17848D
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 03:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D216F0E8;
	Sat, 15 Mar 2025 03:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="sN9W19Vn"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F7A41
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742010212; cv=none; b=JVbZIO/izi8lG6Bu2KDLv9pJ84P77oTB302jtnr2gtEJfv6z4u/NHyLNt4/3e6F1cm0UFEcSpeHKLwcOLAS2APLqKgf5fwLWysluLyk2wZwPQu3BwEUIdUs/1/In2ExZ+YTkOIHIqMuq11a20cCLT5NUScZ4vSgT8gOs1ZqW99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742010212; c=relaxed/simple;
	bh=LBiejvDN1Ki7klwL/t6iTdtqactmqq3d6FeJkHMkXOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO0ZsClC4//VYJtSCTD1kCrNF14JMYvwwq1byjvwltXu6a0TUEBb3bW9aqXJHzwFLNhzZjDo7wF3S+UAl7bhl97gy5fsh4dAnXa6fbisIvcGZK2SBcwautFKkvdu3xbhccAql3eOYqhNZYMUXsRDeQqTplECAWcmZPKUSEaeaqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=sN9W19Vn; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 150AF207FC;
	Sat, 15 Mar 2025 04:43:21 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SaGd3OB5hjFL; Sat, 15 Mar 2025 04:43:20 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 33DA920748;
	Sat, 15 Mar 2025 04:43:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 33DA920748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742010200;
	bh=1E4nIPIYR7svbuHjg+91L1zYZo+78SZiTvOENSJGJnc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=sN9W19VnQhPEeQAwVFxftUPZ8PHjFqNQEtdbvX6rr6/spbHs+SBM+wD/5jYrDCN+d
	 R2XLfGsVEqp7FYTTdnhy7eTa0is5/nZJTmUJ/7WpgvIhNrQLL2bTXQ9mcmdIEnBtKq
	 o7QuEBb/nsR53dYJm61eccAJ5m5d0Sq8U8EUw1lgIplTuRPxvVuX2rQ7iZjT5OWPsH
	 /bCS2VOwpyJH4VN2AsZsfEYzoDA9FBCVfwfgSFjV2emndgLf2N/HK+E1QAc3a58cl3
	 sdS/RJ1E5MQcyaiq+DQ0mT3lBKyQtSVtVBJOdGo76ehW+qLms5D1JqolHhJpjli20k
	 XLt5Q6pfXafww==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Mar 2025 04:43:19 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 15 Mar
 2025 04:43:19 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 299723183D47; Sat, 15 Mar 2025 04:43:19 +0100 (CET)
Date: Sat, 15 Mar 2025 04:43:19 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH] xfrm: ipcomp: Call pskb_may_pull in ipcomp_input
Message-ID: <Z9T3V/M0hXIiHsLB@gauss3.secunet.de>
References: <Z9KTIYVFwEIYXgd7@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9KTIYVFwEIYXgd7@gondor.apana.org.au>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Mar 13, 2025 at 04:11:13PM +0800, Herbert Xu wrote:
> If a malformed packet is received there may not be enough data
> to pull.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  net/xfrm/xfrm_ipcomp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
> index 9c0fa0e1786a..43eae94e4b0e 100644
> --- a/net/xfrm/xfrm_ipcomp.c
> +++ b/net/xfrm/xfrm_ipcomp.c
> @@ -97,6 +97,9 @@ int ipcomp_input(struct xfrm_state *x, struct sk_buff *skb)
>  	int err = -ENOMEM;
>  	struct ip_comp_hdr *ipch;
>  
> +	if (!pskb_may_pull(skb, sizeof(*ipch)))
> +		return -EINVAL;
> +

This looks like fix, right?

Can you add a Fixes tag so it can be backported?

