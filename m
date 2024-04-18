Return-Path: <netdev+bounces-89083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB78A9698
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504A1B21F49
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77C15B13A;
	Thu, 18 Apr 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="CUZ0Q+5l"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367D1591FF
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433601; cv=none; b=ZpH9hmVMUytTnHRF0L9viCoiiRCxwhoSxYAqKcdhJPqH2inFzcmfTNBRLUuM8rs0FIbOeFxSjYDR1qz+U780guUlLv74YTm4mvFpIEMEPtykCNOfYmkgJGDkp8vrtTAloUqdtsbDS9xfqNxDi7FAne8O+elDvfTWHGTfMIV4MZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433601; c=relaxed/simple;
	bh=Sj2uQiUr2Yskis8W4iz8DWR3ycz5PuyzymNwPuw+llU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGV7udZrH/v+c0+W6btpK0uJukJloEwy78I8+U/zDBKz09RZ8YrYVntV6+P04ZjxVbsEmMIIMKs0wCtH2rL2FIXyTdKupMLCsyY12y9uMi+Q77g3Jxy7Y7PjUeT5k4/kwAP7hn+LvtmhfYpBU47DVjU/vvkAdHGRez8X1GKNekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=CUZ0Q+5l; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2C63E208BD;
	Thu, 18 Apr 2024 11:46:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ClQsOrdRupZd; Thu, 18 Apr 2024 11:46:36 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E0CE1206D2;
	Thu, 18 Apr 2024 11:46:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E0CE1206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713433595;
	bh=lB1/7vkkS3Xx4m7Qu4Rjz6J19OON9+foaw3UfVaU/Zw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=CUZ0Q+5lMXzwZ87bnYZwYs5flyf9CJJEnVy2ZpGT99TNenX43VzXwT2zgPnRS6UNv
	 SRvd1NhAsmEDCFwX8Y3BxY27RCtbGfGER6WWRr7E1/KSiESL8SyAVsIyCxZHzqgpHN
	 IEZVBWE85Y/pXd/u0vgnhJDCHe7lwqUxkilXwdvUjFgcxRkzmM8SWgrspQmT9fI96L
	 a49y79OT2ghPDKr+9JAQ/hj8VQai8sqzZTZWeUTbj/kYxdfVyeWHqF4pbPjwnqNW0/
	 3TUl5uRyWQ069glcak5/LD+o3bWvnS0QF9cia7Wcpg9TxL4E5zc5DTlzayyf7QzlCm
	 QeO/sTA3eU+4A==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id D475680004A;
	Thu, 18 Apr 2024 11:46:35 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 11:46:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 18 Apr
 2024 11:46:35 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 34F313183DD9; Thu, 18 Apr 2024 11:46:35 +0200 (CEST)
Date: Thu, 18 Apr 2024 11:46:35 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Paul Wouters
	<paul@nohats.ca>, Antony Antony <antony.antony@secunet.com>, Tobias Brunner
	<tobias@strongswan.org>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH ipsec-next 1/3] xfrm: Add support for per cpu xfrm state
 handling.
Message-ID: <ZiDr+1fsQ6S4thVT@gauss3.secunet.de>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <20240412060553.3483630-2-steffen.klassert@secunet.com>
 <20240414110534.GD645060@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240414110534.GD645060@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Sun, Apr 14, 2024 at 12:05:34PM +0100, Simon Horman wrote:
> On Fri, Apr 12, 2024 at 08:05:51AM +0200, Steffen Klassert wrote:
> 
> ...
> 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> 
> ...
> 
> > @@ -1115,13 +1120,18 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
> >  							&fl->u.__fl_common))
> >  			return;
> >  
> > +		if (x->pcpu_num != UINT_MAX && x->pcpu_num != pcpu_id)
> > +			return;
> > +
> >  		if (!*best ||
> > +		    ((*best)->pcpu_num == UINT_MAX && x->pcpu_num == pcpu_id) ||
> >  		    (*best)->km.dying > x->km.dying ||
> >  		    ((*best)->km.dying == x->km.dying &&
> >  		     (*best)->curlft.add_time < x->curlft.add_time))
> >  			*best = x;
> >  	} else if (x->km.state == XFRM_STATE_ACQ) {
> > -		*acq_in_progress = 1;
> > +		if (!*best || (*best && x->pcpu_num == pcpu_id))
> 
> Hi Steffen,
> 
> a minor nit from my side: I think this can be expressed as follows.
> 
> 		if (!*best || x->pcpu_num == pcpu_id)

Indeed, thanks Simon!

