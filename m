Return-Path: <netdev+bounces-86949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BECE8A1259
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4757228156F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE379146D47;
	Thu, 11 Apr 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rUJ0IhCI"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C9313BACD
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833082; cv=none; b=sHPyLT1BRbAsfDazDuRZnWXcIjyjs7uzlkEdRTa1ibpFhcSwLcDRhpmT17ilx/r78QVVGZd7VjqzNcgLZmcilyGCY4U2vyveULVro7v7tN+K+41oTK02guxfhtd9bf89EN+wFf66+RIU9uR4Q4Ps/c3S16scxT9tLQipAefXrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833082; c=relaxed/simple;
	bh=D7ZCVf3NV/kpSJ5fzCruCZAX75INlSuxGRFjQmAGVG4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moZuKi8ppfMeCT/0v7yuU0DSCCjTFbSTkeN00aU2f61dAXwdGcsgEIB8W3bYGPQALWKPuTfSGorJERwAVDSo2RqRI32UsdAVCHA+rT6pJFTluJhq+9+bj2fXzlzqwPutA8euigb9qf6f36xsdH8I3t854LUcnyqRLkuHeOaLxZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rUJ0IhCI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BDD152085A;
	Thu, 11 Apr 2024 12:57:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jJ7TxKh5cE_C; Thu, 11 Apr 2024 12:57:57 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 37ABB2084C;
	Thu, 11 Apr 2024 12:57:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 37ABB2084C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712833077;
	bh=WQsErnfrILXNlj4OFQfWvIC89+5QOV1riieBIa0P2Sk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=rUJ0IhCIHVzjZY9egl03xdM/DXzExZ72T4UmEmFTMjRAHuEadkaFVQiXV0bRgHJno
	 9StLpj4RIbyXXgacOoLVW21sDw0OPJcIu/VehPIT53cUWo7ZpryMWoWTcJ6kRlnjR8
	 PRMyfnBUzyAyZLG9EUosYI1jJjctdT6QRPuq7x8dmE4aQzt9dT4zgLAT6gMWOQQ6I7
	 0Ffh1PBQSnZ+S+FgyimWh37wGLG9gsoWUNqBfHeaSQ7k5Sv2rBIfhykMaU/UAIafFY
	 MNCeTSJhHLpokAD3nOxWOwQL9HeWXgRohnOSUxF7u8r2GBmSYGcY8y4Y2U9y5j3qEm
	 lXw99FtfxY0vQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 2A8A280004A;
	Thu, 11 Apr 2024 12:57:57 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 12:57:56 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 12:57:56 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 62A9531803D0; Thu, 11 Apr 2024 12:57:56 +0200 (CEST)
Date: Thu, 11 Apr 2024 12:57:56 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony@phenome.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>,
	<devel@linux-ipsec.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhfCNOG550lAWRsP@gauss3.secunet.de>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <ZhV5eG2pkrsX0uIV@Antony2201.local>
 <ZhZUQoOuvNz8RVg8@hog>
 <ZhbFVGc8p9u0xQcv@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhbFVGc8p9u0xQcv@Antony2201.local>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Wed, Apr 10, 2024 at 06:59:00PM +0200, Antony Antony via Devel wrote:
> On Wed, Apr 10, 2024 at 10:56:34AM +0200, Sabrina Dubroca wrote:
> > 2024-04-09, 19:23:04 +0200, Antony Antony wrote:
> > > On Mon, Apr 08, 2024 at 03:02:31PM +0200, Sabrina Dubroca wrote:
> > > > 2024-04-07, 10:23:21 +0200, Antony Antony wrote:
> > > 
> > > Current implemenation does not allow 0.
> > 
> > So we have to pass a replay window even if we know the SA is for
> > output? That's pretty bad.
> 
> we can default to 1 with ESN and when no replay-window is specified.  
> 
> > > Though supporting 0 is higly desired 
> > > feature and probably a hard to implement feature in xfrm code. 
> > 
> > Why would it be hard for outgoing SAs? The replay window should never
> > be used on those. And xfrm_replay_check_esn and xfrm_replay_check_bmp
> > already have checks for 0-sized replay window.
> 
> That information comes from hall way talks with Steffen. I can't explain 
> it:) May be he can elaborate why 0 is not allowed with ESN.

That is because the algorithm on the receive side does not work
with replay window 0. Once we have sepateted input and output SAs,
thereplay window can be 0 on outout.


