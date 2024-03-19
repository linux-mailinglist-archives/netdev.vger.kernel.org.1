Return-Path: <netdev+bounces-80551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A447587FC72
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446B51F22E88
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC5F7B3F6;
	Tue, 19 Mar 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VafvYxyM"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44A7D410
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845893; cv=none; b=fHkeSECXmSGzAtPdOn6DZp9dkDVyAT/XA409VXZYlCHNn2NWh/w/LHovTMnJbf5LTTEqpm83NiqlyjVkzIvu+WLRYW3Voq/5u2/rNR4ij6fcTrsWgViQBRA5ZOO3H2Px6Vat0Wbkbxt5aS0SuZvbd2Q2RotVscKlKGwmVobmB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845893; c=relaxed/simple;
	bh=LGhfstnkxni3znSSqAWcTPiYx2jlblBUuc6cY4a6SN0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEKZToW6+UYqHuxUkc+jZooK3mtGg6n0dxFCUq5TunMEQRs2zhdm4LuN45BYs2UwfUgBNE23cWsjaCRkJKq2CQtdtqel1QM6YQ6Su/OWQQkaOHYbDQ9+p7/p2zwNZDtD3tegTE3fSS8nt4y8jO6pH8wSxGjz6f8qCGt2nCvABcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VafvYxyM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id AAA1D20820;
	Tue, 19 Mar 2024 11:58:08 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uu0-6bI-YDDP; Tue, 19 Mar 2024 11:58:04 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B16AD20520;
	Tue, 19 Mar 2024 11:58:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B16AD20520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710845884;
	bh=l+ZypmfRR70Gs0ZxWi2Tp0V5sxsUxQ1zEfMDODVdnRI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=VafvYxyMcpvvOjWVqlOomojTI8z4GzI0UwosaMP+sUBSV5Z0Fn1pQ4cL6q6DZ+DUF
	 1wZe6d4Bqhb5rjF7kAsz890xJsyibahTQ5qgnjwqEZCTwl5BVOl1PhM8V73fNL8ELb
	 Pqd9QbSNddJYltDzJVMHBJbKAWav2XYYOH+Px/htMv2zAU6ii+rqjyMt/uxS5xmsw2
	 e2DGVFOBXSxjOtLaQPiCpaxBjp1gp1Yb6/oIZRZwsYCFRfzwmGbGQTwD7hxFBMQlJP
	 1iHkJYMSE2LhNRoJHUEXov7vUXp9qbQX4ZX4mdFS+xHV5gqUbZqF3jbr264cHqAiHx
	 V1AvEAC8yARrA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id A416B80004A;
	Tue, 19 Mar 2024 11:58:04 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 11:58:04 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 11:58:04 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A337431849C4; Tue, 19 Mar 2024 11:58:03 +0100 (CET)
Date: Tue, 19 Mar 2024 11:58:03 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH xfrm] xfrm: Allow UDP encapsulation only in offload modes
Message-ID: <ZflvuzaUpRReAtf6@gauss3.secunet.de>
References: <3d3a34ffce4f66b8242791d1e6b3091aec8a2c25.1710244420.git.leonro@nvidia.com>
 <Zfk6AcOGMDxOJCd+@gauss3.secunet.de>
 <235d1abeb92efc486cbecc7ef3b07a53671b506b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <235d1abeb92efc486cbecc7ef3b07a53671b506b.camel@redhat.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Mar 19, 2024 at 11:27:43AM +0100, Paolo Abeni wrote:
> On Tue, 2024-03-19 at 08:08 +0100, Steffen Klassert wrote:
> > On Tue, Mar 12, 2024 at 01:55:22PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > The missing check of x->encap caused to the situation where GSO packets
> > > were created with UDP encapsulation.
> > > 
> > > As a solution return the encap check for non-offloaded SA.
> > > 
> > > Fixes: 9f2b55961a80 ("xfrm: Pass UDP encapsulation in TX packet offload")
> > > Closes: https://lore.kernel.org/all/a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com
> > > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Applied, thanks Leon!
> 
> Steffen, as the issue addressed here is causing self-test failures in
> our CI, could you please send the PR including this change somewhat
> soonish? 

No problem, will come during the next hour.

