Return-Path: <netdev+bounces-98446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC18D173C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE20283B65
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC788153BD7;
	Tue, 28 May 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uK+xa0IR"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521C153BFC
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888366; cv=none; b=EHJsaya4iz3g/6TrDD2GXky64Hfba8ZM/UPL9KeJN+eneL0NSYRoMB+Wmo/VUIGkwObdzGy68oxpNyWtNHFeQ0qbralPsO/nAC2J+Mt3/iCqeoaZy10KA+3IJxxw0JCG6AZeRRBNGzQVt5wJFixrsNam6qq1/+JezXiH6KRArS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888366; c=relaxed/simple;
	bh=H/XcOBCNM6XY9zVSkoufzpBzv9seDAyd8I3Eg+jKJNw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZG59uK6/s2JZhaMcvLvxwG+/BBRqNBCbb8yShsGCNgD1N683jZiKqDin3MfcPrxRlXmCmeSFzOuwt5CqKk7y/uVgi4cEPgyMD2T2KxfEal1wPfKDRSWsZ2hyN+hGvUxlx/YoN/6itH45/dPxQR3MOLccps77xDa1zU9Ngv/VJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uK+xa0IR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D94EC2065A;
	Tue, 28 May 2024 11:26:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MVSAyQSEidwd; Tue, 28 May 2024 11:26:01 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5564420184;
	Tue, 28 May 2024 11:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5564420184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716888361;
	bh=IRC8GMQ4Xf9euYnpQBUoHoHxLL71dV1kiZXtLQuLN94=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=uK+xa0IRK8kG5D5vlQfhFcetfnjWZuBWPN0SRr/mVOUr6hBhgXkzfCojwOuFCgvw4
	 ZRdbE46z2rQek1J74gwgxzZC+jklhSSFEO62tQcOXxEFH8pRPTMHg+2vCaaGsqmJLm
	 BJxOxnXgP/DRsuP7LbZ7kfAM01iBEfMSYAbBRwFY6kMvhmhZpc5bzoxs8s74GyEN07
	 0gFqIlw1/LiS+EIYktdydUqYAID8+QLfLqo4OKobbxRyjRn7+Z92N59yAlXhCMA6qR
	 +rSI6gI7w/cG5Y5/qZOEK03ouBNePWFgTV4q7FpUSRQ7EjJ5FKsV4QAVBRwmyHBBFf
	 B7bsHHGCLjTwg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 4912780004A;
	Tue, 28 May 2024 11:26:01 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 11:26:01 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 May
 2024 11:26:00 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6FE44318295D; Tue, 28 May 2024 11:26:00 +0200 (CEST)
Date: Tue, 28 May 2024 11:26:00 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Message-ID: <ZlWjKHseiI+cfHiR@gauss3.secunet.de>
References: <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
 <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
 <d81de210f0f4a37f07cc5b990c41c11eb5281780.camel@nvidia.com>
 <Zk8TqcngSL8aqNGI@gauss3.secunet.de>
 <405dc0bc3c4217575f89142df2dabc6749795149.camel@nvidia.com>
 <ZlQ455Vg0HfGbkzT@gauss3.secunet.de>
 <ZlWZYOMaiAUE8a3+@gauss3.secunet.de>
 <e6f70384717d85fb1604566530afd02a594f427f.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6f70384717d85fb1604566530afd02a594f427f.camel@nvidia.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, May 28, 2024 at 09:02:49AM +0000, Jianbo Liu wrote:
> On Tue, 2024-05-28 at 10:44 +0200, Steffen Klassert wrote:
> > On Mon, May 27, 2024 at 09:40:23AM +0200, Steffen Klassert wrote:
> > > On Thu, May 23, 2024 at 03:26:22PM +0000, Jianbo Liu wrote:
> > > > On Thu, 2024-05-23 at 12:00 +0200, Steffen Klassert wrote:
> > > > > 
> > > > > Hm, interesting.
> > > > > 
> > > > > Can you check if xfrm_dev_state_free() is triggered in that
> > > > > codepath
> > > > > and if it actually removes the device from the states?
> > > > > 
> > > > 
> > > > xfrm_dev_state_free is not triggered. I think it's because I did
> > > > "ip x
> > > > s delall" before unregister netdev.
> > > 
> > > Yes, likely. So we can't defer the device removal to the state free
> > > functions, we always need to do that on state delete.
> > 
> > The only (not too complicated) solution I see so far is to
> > free the device early, along with the state delete function:
> > 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 649bb739df0d..bfc71d2daa6a 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -721,6 +721,7 @@ int __xfrm_state_delete(struct xfrm_state *x)
> >                         sock_put(rcu_dereference_raw(x->encap_sk));
> >  
> >                 xfrm_dev_state_delete(x);
> > +               xfrm_dev_state_free(x);
> >  
> 
> Still hit "scheduling while atomic" issue because __xfrm_state_delete
> is called in state's spin lock. 

Grmpf. Yes, apparently.

Unfortunately I don't have a NIC to test installed currently.


