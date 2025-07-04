Return-Path: <netdev+bounces-204014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E171BAF87C3
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7815D1C87800
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D3221DB7;
	Fri,  4 Jul 2025 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IUtPA3Mt"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42423AD;
	Fri,  4 Jul 2025 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609579; cv=none; b=XxbKU5KccllAVq5z8pAX8i7cV5iDrZWQReLcqMYPgv/E4B4QUHjyF834ec2d6W9fZ9MzTDoHOIYO4h3Ob4iZ+ChRTTnB2+chdvpl5uYZl6TGReZKna0EfAsjELQ0T4OjRxJqUTHze+X/ojK4KgRyU0MlT0iEsP98igfHP4w1PvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609579; c=relaxed/simple;
	bh=FUr+Xb3WxEDrAtoPPNYBlU951y0XW5QffGe6nLp4XPc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cguw/WLnsrolTQwpMiUErc+EEtqKkPo7qID/5AmXANmDsyP2PlWgg5XUxzvuMVD7vtUDtW1qIe1Kdr+PlQa0/YSb0gvKJvnF79ClJYavjt+Uau8Kb8i2+egO6j+3Hg/CpNaWRqJ+aNcSlGUggDMWczzUc06N/UHLMUu9hFGT47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IUtPA3Mt; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 525D42085F;
	Fri,  4 Jul 2025 08:12:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nyksZfp8GFx; Fri,  4 Jul 2025 08:12:54 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CB47520728;
	Fri,  4 Jul 2025 08:12:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CB47520728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1751609574;
	bh=cvGkAPsok76h9ESDPJnrzFjrd+eUCTfUrOGizzOH9Uc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=IUtPA3Mtiegl1IrKFDykYEnzaIEc5tAH6S1ZY68RW4XAGYbYB65Bv9vLBzJuSs57B
	 cH0BPKOhoQfXy36faEA0WS5xkvnAlojTKbSQ/VteZalrmyBWnNXiYzgO4uLN1aCC4L
	 9OWpE8DB1jZxijqffn0NGJxTCQlac1qTwfWujsGKGkGQHQmxbKPLvUwjcww7R/hItw
	 OXtGWzni0+EK/JNOgZr9Prmj3afV0hyMQsvYlJOQTQ2Knxosa9QRDqWTdictV/Xj//
	 dAKg/dA9AgoXJefo/7xp/XonihhwWcN7w4FEnBPs+Q2lJcrjKXPPLL04Nh4UkXPgkG
	 W1uQCQK7WK2RQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 4 Jul
 2025 08:12:54 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 08:12:54 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9D46D3180BFF; Fri,  4 Jul 2025 08:12:53 +0200 (CEST)
Date: Fri, 4 Jul 2025 08:12:53 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] af_key: Add check for the return value of
 pfkey_sadb2xfrm_user_sec_ctx()
Message-ID: <aGdw5abpBVdUIVt4@gauss3.secunet.de>
References: <20250703091646.2533337-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703091646.2533337-1-haoxiang_li2024@163.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Thu, Jul 03, 2025 at 05:16:46PM +0800, Haoxiang Li wrote:
> Add check for the return value of pfkey_sadb2xfrm_user_sec_ctx()
> to prevent potential errors.
> 
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  net/key/af_key.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index efc2a91f4c48..e7318cea1f3a 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3335,6 +3335,9 @@ static struct xfrm_policy *pfkey_compile_policy(struct sock *sk, int opt,
>  		if ((*dir = verify_sec_ctx_len(p)))
>  			goto out;
>  		uctx = pfkey_sadb2xfrm_user_sec_ctx(sec_ctx, GFP_ATOMIC);
> +		if (!uctx)
> +			goto out;

pfkey_sadb2xfrm_user_sec_ctx() does this check already.

