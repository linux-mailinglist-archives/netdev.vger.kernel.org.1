Return-Path: <netdev+bounces-48581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D9C7EEE5C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A621C20897
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D8DDC5;
	Fri, 17 Nov 2023 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B8B9
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:21:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5F97F20893;
	Fri, 17 Nov 2023 10:21:41 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vaY11_8IR_1C; Fri, 17 Nov 2023 10:21:38 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 30FAC207B3;
	Fri, 17 Nov 2023 10:21:38 +0100 (CET)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 2D15980004A;
	Fri, 17 Nov 2023 10:21:38 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 10:21:38 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 17 Nov
 2023 10:21:37 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4CF343182A0C; Fri, 17 Nov 2023 10:21:37 +0100 (CET)
Date: Fri, 17 Nov 2023 10:21:37 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, <devel@linux-ipsec.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 ipsec-next 2/2] xfrm: fix source address in icmp error
 generation from IPsec gateway
Message-ID: <ZVcwoX4clOp3NimG@gauss3.secunet.de>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
 <300c36a0644b63228cee8d0a74be0e1e81d0fe98.1698394516.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <300c36a0644b63228cee8d0a74be0e1e81d0fe98.1698394516.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Oct 27, 2023 at 10:16:52AM +0200, Antony Antony wrote:
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index e63a3bf99617..bec234637122 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -555,7 +555,6 @@ static struct rtable *icmp_route_lookup(struct net *net,
>  					    XFRM_LOOKUP_ICMP);
>  	if (!IS_ERR(rt2)) {
>  		dst_release(&rt->dst);
> -		memcpy(fl4, &fl4_dec, sizeof(*fl4));

This is not really IPsec code. The change needs either an
Ack of one of the netdev Maintainers, or it has to go
through the nedev tree. Also, please consider this as
a fix.

