Return-Path: <netdev+bounces-44972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746457DA5D2
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA4DB20D8F
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D628E2;
	Sat, 28 Oct 2023 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963179444
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:31:11 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF201F4
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:31:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C2105207CA;
	Sat, 28 Oct 2023 10:31:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QQqLaXuUtvJw; Sat, 28 Oct 2023 10:31:05 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5B342206DF;
	Sat, 28 Oct 2023 10:31:05 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 56D7980004A;
	Sat, 28 Oct 2023 10:31:05 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 28 Oct 2023 10:31:05 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sat, 28 Oct
 2023 10:31:04 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 590633182A90; Sat, 28 Oct 2023 10:31:04 +0200 (CEST)
Date: Sat, 28 Oct 2023 10:31:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>, Antony Antony
	<antony@phenome.org>
Subject: Re: [PATCH ipsec-next v2] xfrm: policy: fix layer 4 flowi decoding
Message-ID: <ZTzGyIFyfnKgklSv@gauss3.secunet.de>
References: <ZTp4dDaWejic16eT@moon.secunet.de>
 <20231026144610.26347-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231026144610.26347-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Oct 26, 2023 at 04:45:42PM +0200, Florian Westphal wrote:
> The commit shipped with two bugs:
>  fl4->fl4_icmp_type = flkeys->icmp.type;
>  fl4->fl4_icmp_type = flkeys->icmp.code;
>                ~~~~ should have been "code".
> 
> But the more severe bug is that I got fooled by flowi member defines:
> fl4_icmp_type, fl4_gre_key and fl4_dport share the same union/address.
> 
> Fix typo and make gre/icmp key setting depend on the l4 protocol.
> 
> Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
> Reported-and-tested-by: Antony Antony <antony@phenome.org>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  v2: decode_session6 must use IPPROTO_ICMPV6, not IPPROTO_ICMP.
> 
>  I normally do not resend immediately but in this case it seems like the
>  lesser evil. 

This was indeed the better way to do it.

Applied, thanks a lot!

