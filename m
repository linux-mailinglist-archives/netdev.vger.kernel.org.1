Return-Path: <netdev+bounces-124108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBE968130
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673DD281231
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF3F185B59;
	Mon,  2 Sep 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DubD/SYd"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC9183CCB
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264023; cv=none; b=nQ4pCiO8vYlceQEMTf9GMIfLyAmQnZC2UDxhD69JFwiJ5g83YPNY7pK6J52uH4u09OtXB0+rg4DTEt/jCkD3/zm7T88rJzG5/F9qJ7kJG1zSmK7UpouBfVRdOA1Q3z03rGkjBb71NM6NrY+OW4IBTWYF9e4K5+4RWHGEY7x5unI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264023; c=relaxed/simple;
	bh=yN91DSR/w23G23rQfv7XkanbX7VtXBfjnf/NKSIybWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZiof1Hy3AK/y9nFeHdtuEkQ4CtV1/5wD8GquYTSZi43EVHAQ4ELh6XF1HOsHE4TWGgnUc/mUKNrVLC076IfFkmNbwQn1z9SbcFarV8DmpKeqH0GbVrDQN3iP1PDiYyXsih+RYVjQRufOd3wc3HDjpbjicBMWg1UvEdLHcfEo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DubD/SYd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7158A20539;
	Mon,  2 Sep 2024 10:00:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3R0PVTgUzpyW; Mon,  2 Sep 2024 10:00:19 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ECC89201AE;
	Mon,  2 Sep 2024 10:00:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ECC89201AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725264019;
	bh=mOG8NVGdnTYXNr+Zt8NIaaeNqrLn2UC/g0rbwitgT1E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=DubD/SYdJ5Lz+X91UWgVU9mq/zvzUsow5Rc9XAzeXTIDDty/r/H0PZuD0y5G5GEF/
	 HGAvwmxmEbJFU9Wbzep0ftvJJNSKp5HJ8GssE9Z3fgMKWJKrpczFZpVFD+g6ftPqLX
	 uqwvOb/IcZBjW3OggwcRMGHVXap6pxaWWXvjwmcGpQFWJje7M0yTGWFdjufpyRyHpw
	 ZdGErcLez0TvcCaLg8+Mat1fuVkhini73cwCvTLwh7mFoYS+I95B0dVgHHmQ66rwJo
	 4JdDgENJSEPYO0rJBsojbhV+4bFee+k1f1bc2vRUTxcm3OtNo021mQ8lINISV7Mi8H
	 uFhduKKFMs2EA==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 10:00:18 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 10:00:18 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C5E723180F97; Mon,  2 Sep 2024 10:00:17 +0200 (CEST)
Date: Mon, 2 Sep 2024 10:00:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <dsahern@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec 0/2] xfrm: respect ip proto rules criteria in xfrm
 dst lookups
Message-ID: <ZtVwkW61Nkw0yTcA@gauss3.secunet.de>
References: <20240901235737.2757335-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240901235737.2757335-1-eyal.birger@gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Sep 01, 2024 at 04:57:35PM -0700, Eyal Birger wrote:
> This series fixes the route lookup when done for xfrm to regard
> L4 criteria specified in ip rules.
> 
> The first patch is a minor refactor to allow passing more parameters
> to dst lookup functions.
> The second patch actually passes L4 information to these lookup functions.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> 
> Eyal Birger (2):
>   xfrm: extract dst lookup parameters into a struct
>   xfrm: respect ip protocols rules criteria when performing dst lookups

Hm, your patchset does not apply to the ipsec tree. Can you check
and rebase it?

