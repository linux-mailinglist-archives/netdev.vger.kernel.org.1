Return-Path: <netdev+bounces-98136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8288CFA48
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72099B20EBF
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BB9200A9;
	Mon, 27 May 2024 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kSoTVJp3"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0D17BCA
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795636; cv=none; b=SgXiLiPjaetMUIqkBVeHx60Ff+bVAtjAgSc+fYjzYAbQrx6EXkMwFtg0KXSe8/AmXjYU+EwFv23wcEJnQErcV1j4HpBkSOct+6bjGDiEZHYOEJXlgrjUsKiPPja4G65dH2r282nrkPbR9+I3na8TMfhDwbjWnkmQV55UsnlXaiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795636; c=relaxed/simple;
	bh=e2QmOlxKqRTlxt8UhRJ3WrXvwG4iwSGF/FVu4jiEeVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjko8tKEeySwsZwzKvKnoct/dc2GuKxXAMFJosv+2SeQ73ux4xbHyRuJAnSRNj3/VQuExPX0YQdFj4V+uNERQ1fdwHxSs37qotUDRwb9FvkpLP5kYahwnuIVLVVcTvazIPCmMSgupzak8vWl6VDv+xffdE+lbQ2Al6JXj/+/Ut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kSoTVJp3; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F3604207C6;
	Mon, 27 May 2024 09:40:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 37ePgzXSK7qg; Mon, 27 May 2024 09:40:24 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7928A2069C;
	Mon, 27 May 2024 09:40:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7928A2069C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716795624;
	bh=MrX/hwVg9QATyn4lHBkL9qeJUkS6qbXKGCdEWa129cY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=kSoTVJp3ZqlH/dz2S8hsIrJTE89RaZmexBTktg9GA1z9fTLnkNLUkd82af8wdZIwz
	 wlsbj19uB09ZSD9BWdv81QLIFHfDvLiy73CtYhPkd9XBl5RQThsqa0ubYPkqpxHpPB
	 v67SiipXnP0dP8xZDiIVGZQ54qXWReuDoXv7x+5Ew80muy/TDw5KCoE4O9Nl3UdziH
	 YGvKtZxwu8QXczMcjANRaixJvDeS/HOpqbFQ+tevoYcS21LoxBJiJPMvCbCQ+fYDTN
	 UWMt9gwCa/o6dteAj/44X7gVODZeEX0toKZhgtHhD3c/zEwMnTRpZ2dtzbNGhbKwPD
	 8dugE+QDNN4aw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 6CC9D80004A;
	Mon, 27 May 2024 09:40:24 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 09:40:24 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 May
 2024 09:40:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8CAB03180866; Mon, 27 May 2024 09:40:23 +0200 (CEST)
Date: Mon, 27 May 2024 09:40:23 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Message-ID: <ZlQ455Vg0HfGbkzT@gauss3.secunet.de>
References: <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
 <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
 <d81de210f0f4a37f07cc5b990c41c11eb5281780.camel@nvidia.com>
 <Zk8TqcngSL8aqNGI@gauss3.secunet.de>
 <405dc0bc3c4217575f89142df2dabc6749795149.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <405dc0bc3c4217575f89142df2dabc6749795149.camel@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, May 23, 2024 at 03:26:22PM +0000, Jianbo Liu wrote:
> On Thu, 2024-05-23 at 12:00 +0200, Steffen Klassert wrote:
> > 
> > Hm, interesting.
> > 
> > Can you check if xfrm_dev_state_free() is triggered in that codepath
> > and if it actually removes the device from the states?
> > 
> 
> xfrm_dev_state_free is not triggered. I think it's because I did "ip x
> s delall" before unregister netdev.

Yes, likely. So we can't defer the device removal to the state free
functions, we always need to do that on state delete.

> Besides, as it's possible to sleep in dev's xdo_dev_state_free, there
> is a "scheduling while atomic" issue to call xfrm_dev_state_free in
> spin_lock.

Thanks for the hint!

