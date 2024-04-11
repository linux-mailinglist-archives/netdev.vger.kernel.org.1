Return-Path: <netdev+bounces-86884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9FA8A0996
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D371F247C6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F813DDC3;
	Thu, 11 Apr 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Pko3hFCJ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56213DDAA
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820194; cv=none; b=PE7DIVoka2yTz2uBUJPqfe04XbgToJ/OorzII1UyT9tg0KFnUBTRFOnqF99OxjL5XBJ3y9G8dgnKql1iTcvB38mM2T6UbJo7A3s600zqYQ0tfjKQCNOpfIALixZuzpnhy5rKiB2cWf16aNFGI/tIJ8FqTEdL2oeyMyYrM8b69oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820194; c=relaxed/simple;
	bh=bu5ueB/OqVkoznllksN9WHiX3HdkUBXBkE/BByxANyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZHf9coS7pqNKeoU/mN8Bue1xUlbfBbrX+tB3mXmClkZZToBSvs1g5e5TMARc+bsDzEuXb8RcNF9TgwLJEVOelGeW6EW0L0UHfTZra9PR+9pem7+G68H1ub/3ydqj9SvOCLLcp1ADEgu8dhlfuP2g43bJW2CUKodqhwxp+dZH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Pko3hFCJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DB98B20847;
	Thu, 11 Apr 2024 09:23:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id soAW0YES-Dgh; Thu, 11 Apr 2024 09:23:10 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5C9E8205ED;
	Thu, 11 Apr 2024 09:23:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5C9E8205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712820190;
	bh=oajVEcDL6H6/fHpIk5w0oQrqJceE4ypu2bkIizHo5mk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Pko3hFCJshoLVGJdv/XBUDGBH8/NM8VSMKDPqdtLY8K4wFrmyz+MuxT9Oucss+dwp
	 qEqbsgw6BV3mKcaBGh717xfZ5WMiv4/RWUeVxknZRWJOqlSmlexk65OEPM4cHW/cCJ
	 AWYxDEdr5lek1qv6wjCtGze7XVx8Sq7YMYSS6WaX1wE4neaYGoZbdupcnBVC6mu5Dh
	 U3Dax3D8DrdvcwobVuUCPUhcvj/RPt7+sli4SGSwsIsqhyC9/WvAqn0OqryF4b6PoL
	 BwwxcD+dk0uFl8CByf1JucoUOfpPiEwe83mQz+1DWojlbQ6iRDRHdFAOpyFu6JLuCh
	 kpRyNrYW1uoQg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 4F5F780004A;
	Thu, 11 Apr 2024 09:23:10 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 09:23:10 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 09:23:09 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 90D323184014; Thu, 11 Apr 2024 09:23:09 +0200 (CEST)
Date: Thu, 11 Apr 2024 09:23:09 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Wouters <paul@nohats.ca>
CC: Sabrina Dubroca <sd@queasysnail.net>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, <antony.antony@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <devel@linux-ipsec.org>,
	Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v9] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZheP3faYW214zYpB@gauss3.secunet.de>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZhY_EE8miFAgZkkC@hog>
 <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com>
 <ZhZLHNS41G2AJpE_@hog>
 <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com>
 <ZhZUcNKD8viY6Y3W@hog>
 <8b27d067-d401-88b9-f784-4589b27f8e32@nohats.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b27d067-d401-88b9-f784-4589b27f8e32@nohats.ca>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Wed, Apr 10, 2024 at 09:52:36AM -0400, Paul Wouters wrote:
> On Wed, 10 Apr 2024, Sabrina Dubroca via Devel wrote:
> 
> > 2024-04-10, 10:37:27 +0200, Nicolas Dichtel wrote:
> > > Le 10/04/2024 à 10:17, Sabrina Dubroca a écrit :
> > > [snip]
> > > >> Why isn't it possible to restrict the use of an input SA to the input path and
> > > >> output SA to xmit path?
> > > > > Because nobody has written a patch for it yet :)
> > > > For me, it should be done in this patch/series ;-)
> > 
> > Sounds good to me.
> 
> If this is not the case currently, what happens when our own generated
> SPI clashes with a peer generated SPI? Could it be we end up using the
> wrong SA state?

No, the kernel will reject to insert a second identical SPI.

