Return-Path: <netdev+bounces-137434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDF9A6448
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D751C22040
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27A1E7C29;
	Mon, 21 Oct 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="bUm9qV0G"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B651E1C11
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507167; cv=none; b=qShcRt2/zBs2aPNwkk/AP+8e3YYZOADZV3lL/pg+qYA2e6vCv70ndGx9+aOcnRLRGdDzDcH/ZPbgVMn2H+g2LhsStameyeSssAtfb5GoholRg8pTsscAVRFl5+DBMUPQGqyKmK1EZ+UcCzchK8M61lXfiCXq8S2Qo0p8AEnMCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507167; c=relaxed/simple;
	bh=/yTgAFdZjMiFVf2j2sTFHqiRQqrEYTgfxOLCDfj7AIk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6rkgqb3LA2Urv6XcH1syQNi928Oq8AFiEmrGWm/m3XqxVKYm6eqDhaXcTbCv5qT7w+HVGlKQDVNQnjqtGQJZdV4Hf79XhayGyhwAW9WcuxO6dHLDCKx3IY04XjfeI6nNY1fi0bo1Nj9P1hSFHwjQKPDoG/QkFYYaDCk7+QowAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bUm9qV0G; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6CDDE20508;
	Mon, 21 Oct 2024 12:39:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aZLHYSNPaOoR; Mon, 21 Oct 2024 12:39:21 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C292020190;
	Mon, 21 Oct 2024 12:39:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C292020190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729507161;
	bh=WCT5iOkcTuJwjPr+L5SoDf7/ScWmQPs3coLDyb3amG0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=bUm9qV0G5IBRs8AgNJHR0BHwT5us1B3nIBrc3zLnDQm1RUugRDlUWQDoxQycpMzEw
	 VrCeZ5olp0fTFAs8onMumplld9hSJ4BjHY3vxzhTRwLP6cPPpT4HbVBN41Y/uk8N/r
	 ymxiEKGnc8DSvZKiarK+s7T+wqOpv0zdye78wsvtkxyWG9nEM8lNRBfzxhNZIi5JYp
	 0TmwdGVfGolK/sL3hwsTyjzQtlwCgOTF1EpsjUnJyyZbVBKW5dhPHVfwV1l8GOMokj
	 4w8bTPj/6EVJ+ASyXVyBGlqgO/YstYaUzhO0hBG5kHj6zsYCZaU9c1QQrzU9PELkYi
	 ebxyZyewStcHg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 12:39:21 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 12:39:21 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id EC2AF31819D0; Mon, 21 Oct 2024 12:39:20 +0200 (CEST)
Date: Mon, 21 Oct 2024 12:39:20 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 14/16] xfrm: iptfs: add skb-fragment
 sharing code
Message-ID: <ZxYvWDFrdSMn8iVF@gauss3.secunet.de>
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-15-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007135928.1218955-15-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Oct 07, 2024 at 09:59:26AM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Avoid copying the inner packet data by sharing the skb data fragments
> from the output packet skb into new inner packet skb.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/xfrm_iptfs.c | 312 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 304 insertions(+), 8 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 4c95656d7492..ef4c23159471 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -81,6 +81,9 @@
>  #define XFRM_IPTFS_MIN_L3HEADROOM 128
>  #define XFRM_IPTFS_MIN_L2HEADROOM (L1_CACHE_BYTES > 64 ? 64 : 64 + 16)
>  
> +/* Min to try to share outer iptfs skb data vs copying into new skb */
> +#define IPTFS_PKT_SHARE_MIN 129
> +
>  #define NSECS_IN_USEC 1000
>  
>  #define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
> @@ -236,10 +239,261 @@ static void iptfs_skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
>  	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
>  }
>  
> +/**
> + * struct iptfs_skb_frag_walk - use to track a walk through fragments
> + * @fragi: current fragment index
> + * @past: length of data in fragments before @fragi
> + * @total: length of data in all fragments
> + * @nr_frags: number of fragments present in array
> + * @initial_offset: the value passed in to skb_prepare_frag_walk()
> + * @pp_recycle: copy of skb->pp_recycle
> + * @frags: the page fragments inc. room for head page
> + */
> +struct iptfs_skb_frag_walk {
> +	u32 fragi;
> +	u32 past;
> +	u32 total;
> +	u32 nr_frags;
> +	u32 initial_offset;
> +	bool pp_recycle;

This boll creates a 3 byte hole. Better to put it to the end.

> +	skb_frag_t frags[MAX_SKB_FRAGS + 1];
> +};


