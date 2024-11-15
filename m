Return-Path: <netdev+bounces-145191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E299CDA36
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1A51F22874
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E7189F30;
	Fri, 15 Nov 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="pTsQ1HN4"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AECE1DFFD;
	Fri, 15 Nov 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658059; cv=none; b=SFd6GqUbYPpsQJ/0Nmt89dUSbtl8UdGHUpDBQqQ/TXaksbywLCid7dNxtdyv3tsQUquwjQCPPtKPUzjXpDRV8RJ3X6oD9OrO8ZmcARGrWu+CchYjCLfudOmT/zclAHUb0UYE+2GmGf1R/0afvx9iyi4+RLDAquzKYhhsOp+187I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658059; c=relaxed/simple;
	bh=1+p/mscZrLAnQ7sIlEXDO7iW/5pncMsKkAGqXXhzPH0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1ddCK2q8FzoOfPVtzd7X/xEO5PJwNHMbfcKXJBUci8lOfKgbHPkyA0YsGpJ3tLwUJ/DPqI+af4su22HsMMKNdlPvCSPVFqCSH0nVISbDn7zACMCNqV0ceEZQgH1vEjQs+k5CXq3g/xMy6wUWzhTZqrOwZJ/Ke6SSQpX44ATkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=pTsQ1HN4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C7B0820870;
	Fri, 15 Nov 2024 09:07:32 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9Myi-YdyJ_K; Fri, 15 Nov 2024 09:07:24 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D31F22085A;
	Fri, 15 Nov 2024 09:07:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D31F22085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731658044;
	bh=be3MroQoWJ6+StAwpuPSR7YGmORoS7e29Sa3/889s9c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=pTsQ1HN4bkvwM1RUV/HT6FnRwP80/3n1QfcCmd4OjyYzxO1OfbZLeXSNSCGVD72c0
	 fjcmjXPp4Gh13F1sLBKyRqQDyjILj8kc2d9IPl2E3rNQNB0I3Jj7wP2OfX9dPe0CLv
	 Ut84QgDJIp5Ja98vZIrsdkypnvK44fn+mqcxITueCSiekAKX/nZ3XrVmWVak6sNfed
	 dnDHWjPci1sqQpiCuLSAg/bsZ+DFtXmnPXdX7uWH5Xm24+WGP/rqayCim1wvvdAXO1
	 6QpcNj1zj6wDLBgqtxx3k7wdTbLaEQUCxnGrDP/53/0HYh+vpEq8H/qTtWx4/zbXLw
	 83WQlTS1HCSbg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:07:24 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:07:24 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2D97F3182ACC; Fri, 15 Nov 2024 09:07:24 +0100 (CET)
Date: Fri, 15 Nov 2024 09:07:24 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Everest K.C. <everestkc@everestkc.com.np>
CC: Simon Horman <horms@kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] xfrm: Add error handling when nla_put_u32()
 returns an error
Message-ID: <ZzcBPA+8nXwJdGBh@gauss3.secunet.de>
References: <20241112233613.6444-1-everestkc@everestkc.com.np>
 <20241113105939.GY4507@kernel.org>
 <CAEO-vhFzEo12uU7EBOb6r6J7Ludhe4HNNGvfN71fSDQRmR16pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEO-vhFzEo12uU7EBOb6r6J7Ludhe4HNNGvfN71fSDQRmR16pQ@mail.gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Nov 14, 2024 at 12:27:28PM -0700, Everest K.C. wrote:
> On Wed, Nov 13, 2024 at 3:59 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Tue, Nov 12, 2024 at 04:36:06PM -0700, Everest K.C. wrote:
> > > Error handling is missing when call to nla_put_u32() fails.
> > > Handle the error when the call to nla_put_u32() returns an error.
> > >
> > > The error was reported by Coverity Scan.
> > > Report:
> > > CID 1601525: (#1 of 1): Unused value (UNUSED_VALUE)
> > > returned_value: Assigning value from nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num)
> > > to err here, but that stored value is overwritten before it can be used
> > >
> > > Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
> > > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > For future reference, I think the appropriate target for this tree
> > is ipsec-next rather than next.
> >
> >         Subject: [PATCH ipsec-next] xfrm: ...
> Should I send a patch to ipsec-next ?

No need to resend. This is now applied to ipsec-next,
thanks a lot!

