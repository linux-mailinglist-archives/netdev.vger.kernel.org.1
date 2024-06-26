Return-Path: <netdev+bounces-106893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60837917FAF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C60F285DC0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73A178387;
	Wed, 26 Jun 2024 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="U2EOZIBz"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39712E6A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401453; cv=none; b=EQjI+xnxm4HV+5OFKKrwCXrGK3KMsUuXqsVz4Q2Z845egFPcx5K3PzF/Gh5myFWL3+xt/kP2V2KIBRAdQ8KfdlUAtJcwiK7smsT6wv1qGZcs2vtmHwOxM89KzGcPxvO/fipZcaw+NELGMA+nBT3ilUovS7dOsBwEcz8UAJwW5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401453; c=relaxed/simple;
	bh=AJR1a8zg3093dNh61Ox69gvZK7Qg1L/P+v9v8VOiVlg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/DuQqIJcKL0fD0NEYAdcISUNVttTTvWnLnFmTGNGp2JlSujELPoTzET54iBGewuduB4kogLtQegUEE0fstj0tQFSLMwsXOt3Vcn1qa70U9G/rTSzkymuPmdPeixTbCGEDvCJ7CLmT0hPyNc5SOJAA5s1MKYvvv3RAzYo2Fp+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=U2EOZIBz; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 170DC207D8;
	Wed, 26 Jun 2024 13:30:42 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FaIPLjYB3i59; Wed, 26 Jun 2024 13:30:41 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8448B2074B;
	Wed, 26 Jun 2024 13:30:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8448B2074B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1719401441;
	bh=fGBxU0BWOrRetptISs0MIrBIbXKKO2KdjJftoKDdfD8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=U2EOZIBzYvSjMCPYs8P4or8bN8Pe3vKcNMMVIG/2dlIJ2Ri293wYldp1ahcLD88UA
	 xXKo7WJlII0RZMseJUDl52UcOGZMPsbdLZTJb7wTfR5E6T3LRaUfuOBHKDQtvVWEg0
	 0hUvC+SZlvxBVTi4Tm/CUDEtOUYfv7sKpOuLT/rBm7Lyx1+i/TBuqD3uvypDTCcQVc
	 ylWd3LASrhV8w94a6g//yaxokOqh7iBUtRUHTIDNHHIhrYaANw+2+P4VE2YUD2lVx8
	 2f9+ZESER6uW6nqNx2L//S4rz02KSwtd6YsunCnO6MU+68sCYot7qscCgno9Z/alLV
	 mmEPIA7VEGHuw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 7529E80004A;
	Wed, 26 Jun 2024 13:30:41 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 13:30:41 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 13:30:40 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9333331819DD; Wed, 26 Jun 2024 13:30:40 +0200 (CEST)
Date: Wed, 26 Jun 2024 13:30:40 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jianbo Liu <jianbol@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 ipsec] xfrm: Fix unregister netdevice hang on hardware
 offload.
Message-ID: <Znv74OG152yuwMBM@gauss3.secunet.de>
References: <ZnPQfG3qsSkAW2VM@gauss3.secunet.de>
 <20240624102751.GE29266@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240624102751.GE29266@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Jun 24, 2024 at 01:27:51PM +0300, Leon Romanovsky wrote:
> On Thu, Jun 20, 2024 at 08:47:24AM +0200, Steffen Klassert wrote:
> > When offloading xfrm states to hardware, the offloading
> > device is attached to the skbs secpath. If a skb is free
> > is deferred, an unregister netdevice hangs because the
> > netdevice is still refcounted.
> > 
> > Fix this by removing the netdevice from the xfrm states
> > when the netdevice is unregistered. To find all xfrm states
> > that need to be cleared we add another list where skbs
> > linked to that are unlinked from the lists (deleted)
> > but not yet freed.
> > 
> > Changes in v2:
> > 
> > - Fix build with CONFIG_XFRM_OFFLOAD disabled.
> > - Fix two typos in the commit message.
> 
> Changelog should be after "---" trailer marker.

I've hand edited it out.

> > Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Now applied to the ipsec tree.

