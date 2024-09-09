Return-Path: <netdev+bounces-126452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149B9712FC
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389CE1F20595
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79E1B29D6;
	Mon,  9 Sep 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gMo7y0iV"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CA1B14FB
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872953; cv=none; b=JlZ7J0GM2YFPLBgvTYnFY03aweiB021FSv598xO+AmJQhXQfldfvUiWDGycrT9I6Pl6MqQxTVj+TJYQ5exd0HqPg+bL/Mg66Wxqjo2687DXU2E46zlUM0yHzCxsOapHlZjuJM8LviOiQu3Fl+hKuZd6OleGDNT46jNPFs1lT20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872953; c=relaxed/simple;
	bh=+v7AZ5xqr72hMnRd/g7FTLMgA1gqyTdc86UnJz6yhTs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abTdtFm2qbb39BDg+Huua5svy4dTMuR3YGibtAHjTRaCc6DRFNIhCc2VTtO76ZgG9H36j9zf2QfVB4Sb/D8PgG8canI6TeFSGsteIi5hrstRZkDXS8+YYFyPjXDI+7pvQEEcvZUsmrRoKNbTITffntQzt+8kp3QmKH3UQIBLYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gMo7y0iV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B470D2084C;
	Mon,  9 Sep 2024 11:09:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D9vR3uzPFc55; Mon,  9 Sep 2024 11:09:07 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A7A282087C;
	Mon,  9 Sep 2024 11:09:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A7A282087C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725872946;
	bh=Nj14FgLC0OTKDq0qEBTGGYbZDj6mNJiEtdAWmWRR/X4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=gMo7y0iVYYVDU8i5KMQxcoqKa1Zw4d/ZHQqfZACtlCoctc3IkTEF7SQY+VzgRc1L/
	 pUoN72tehF89tY47/yTyL4lgqUC8NwE0zERmJVWBwhh/NnWEs122uf+IM5IO5ow0H1
	 d/1QlAwLqc15IXV0MkKZtpWlhFYElN7ZQxnA9IxN+aMdqSuTw2sivtmtdQ/i6XAuTy
	 ax1n6CQkYtNEWSiPhJTs1dH3xmTaidFTaLgLl+2A16MtT4Qdmj5NtrMBOzz9sqhg4W
	 F5Ck/bdKBwVeH8U28NwAdy5GjQ2YXMjNDR7meT+WuvZLDdx7kr31zrdCPw75DNL1gU
	 w4B5tLI25pjCw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 11:09:06 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 11:09:06 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 10FC33182517; Mon,  9 Sep 2024 11:09:06 +0200 (CEST)
Date: Mon, 9 Sep 2024 11:09:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Feng Wang <wangfe@google.com>, <netdev@vger.kernel.org>,
	<antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240902094452.GE4026@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Sep 02, 2024 at 12:44:52PM +0300, Leon Romanovsky wrote:
> On Mon, Sep 02, 2024 at 09:44:24AM +0200, Steffen Klassert wrote:
> > > 
> > > Steffen,
> > > 
> > > What is your position on this patch?
> > > It is the same patch (logically) as the one that was rejected before?
> > > https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
> > 
> > This is an infrastructure patch to support routing based IPsec
> > with xfrm interfaces. I just did not notice it because it was not
> > mentioned in the commit message of the first patchset. This should have
> > been included into the packet offload API patchset, but I overlooked
> > that xfrm interfaces can't work with packet offload mode. The stack
> > infrastructure should be complete, so that drivers can implement
> > that without the need to fix the stack before.
> 
> Core implementation that is not used by any upstream code is rarely
> right thing to do. It is not tested, complicates the code and mostly
> overlooked when patches are reviewed. The better way will be to extend
> the stack when this feature will be actually used and needed.

This is our tradeoff, an API should be fully designed from the
beginning, everything else is bad design and will likely result
in band aids (as it happens here). The API can be connected to
netdevsim to test it.

Currently the combination of xfrm interfaces and packet offload
is just broken. Unfortunalely this patch does not fix it.

I think we need to do three things:

- Fix xfrm interfaces + packet offload combination

- Extend netdevsim to support packet offload

- Extend the API for xfrm interfaces (and everything
  else we forgot).

> IMHO, attempt to enrich core code without showing users of this new flow
> is comparable to premature optimization.
> 
> And Feng more than once said that this code is for some out-of-tree
> driver.

It is an API, so everyone can use it.

Anyway, I'm thinking about reverting it for now and do it right
in the next development cycle.

