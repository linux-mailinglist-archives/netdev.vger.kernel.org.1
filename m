Return-Path: <netdev+bounces-124105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF79680E5
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2191F20C3D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ABA1581F8;
	Mon,  2 Sep 2024 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="LiFxge1b"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6191547EE
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263241; cv=none; b=dAuDFpYLnOWsG2eS/4mWaIJ36bgZyiRyqqk3jeQByRqmAAJ8ASzcETWWXlSVcd+z4UK6Hp51LlRhcIlyWmLJ4uAaCFOATfZQCOs0jBeNC4ka56ucsf48zcGBpZKlsP4j6ATNY+lrvf1rzTfq+89NHO1yOxsCOAu17NGYMsFLBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263241; c=relaxed/simple;
	bh=eTRNkBb/wxolr8H9yhgNurQtrhH0WZ7dvpjHR/oWdfU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=synEp0cn1Rl95ONzvYdgQ2y5zrCVmUA94dj2YGVa6CL80UgKazbMcZ3HhUCBwIT+SsfY1nq5jjc7yyx2At6rJN/wZY5Uc0nyKeEDNapcva/UTAWLepp7K1oXBFo9Z03wCMoKieDagM77mSXk0fseN+9JHpVqfQrJZUvCcv5Djz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=LiFxge1b; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5E322201D5;
	Mon,  2 Sep 2024 09:47:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sAe1ctLFe2ll; Mon,  2 Sep 2024 09:47:16 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 90219201A0;
	Mon,  2 Sep 2024 09:47:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 90219201A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725263236;
	bh=3S6CNoB3MHs0sZ6WhdVK49ibmFJMimoXcmv39HgcC+0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=LiFxge1bmZ5LZHkNQWOCcaIjHeh0Dsnp49C6q+Q6JBmT7AYyS9qsGcSWb7uvoGpYT
	 BpGbPRhB48Nw/8Vq6DCymdt5mjAVCcfEkWCuD0nO9ICtNfwIm5qam7pIVjjmwy4rSn
	 vhn9cnsFV0bQ7ZVKt1A1msseGpgmIKq+hFVKIhMsH6SY3mx3srGUh4YOc5156awyI+
	 sc8zMpzHy9Fa/V4K4Ut7XF73FQlyKhe5YhySv4xiqCHJgwiIFD0nIZIJ7TlQ3ajTTp
	 scEwvKGNGT1ur8TgAL3yqf9/dPjJd+9UOsUmnNcTL8yFS9N6DSeXYHiQUMMvX2pmLY
	 X8LkwQrpnsJVA==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 09:47:16 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 09:47:15 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 99E353180F97; Mon,  2 Sep 2024 09:47:15 +0200 (CEST)
Date: Mon, 2 Sep 2024 09:47:15 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: <netdev@vger.kernel.org>, <antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <ZtVtg7Ik5AAqjorA@gauss3.secunet.de>
References: <20240822200252.472298-1-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822200252.472298-1-wangfe@google.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Aug 22, 2024 at 01:02:52PM -0700, Feng Wang wrote:
> From: wangfe <wangfe@google.com>
> 
> In packet offload mode, append Security Association (SA) information
> to each packet, replicating the crypto offload implementation.
> The XFRM_XMIT flag is set to enable packet to be returned immediately
> from the validate_xmit_xfrm function, thus aligning with the existing
> code path for packet offload mode.
> 
> This SA info helps HW offload match packets to their correct security
> policies. The XFRM interface ID is included, which is crucial in setups
> with multiple XFRM interfaces where source/destination addresses alone
> can't pinpoint the right policy.
> 
> Signed-off-by: wangfe <wangfe@google.com>
> ---
> v2:
>   - Add why HW offload requires the SA info to the commit message
> v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@google.com/
> ---
>  net/xfrm/xfrm_output.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index e5722c95b8bb..a12588e7b060 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  	struct xfrm_state *x = skb_dst(skb)->xfrm;
>  	int family;
>  	int err;
> +	struct xfrm_offload *xo;
> +	struct sec_path *sp;
>  
>  	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
>  		: skb_dst(skb)->ops->family;
> @@ -728,6 +730,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  			kfree_skb(skb);
>  			return -EHOSTUNREACH;
>  		}
> +		sp = secpath_set(skb);

Maybe we should do that only if if we really use xfrm interfaces,
i.e. if xfrm if_id is not zero.


