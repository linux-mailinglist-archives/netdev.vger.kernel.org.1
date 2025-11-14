Return-Path: <netdev+bounces-238627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24397C5C3CD
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D67F4F0371
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D9302157;
	Fri, 14 Nov 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="LCGNViVg"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C1301718;
	Fri, 14 Nov 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111654; cv=none; b=nQRS1OUP9l3otfs3cBIPrprjEe66vRA/MBYMPwuJ7irpPRpk2K0K3gm1SSXhRm92OsncKeNN+ITiDPikDsydw+7L/aFJoMh/VV1nc0/ho/+qkJhBCzUgzPhoIBTpQaLKoZ/AIRIyDkPXce2jPpPDPqP0zOK/vXXNql4L+ldgoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111654; c=relaxed/simple;
	bh=NNqnWpOmlT48qim0Eb+FI9I6wGhY4faZqzfxCjYF9JQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKG+4hOh0ATG1kk0EctBJoqNNuJzwRmO+xzuY6ssYW3nB7Std7ZDgVpSlu91xGd1v2IOG5AImCuTdsZebkII2Y2DwnNw8kS/IKDNgdIwQSckfJz3yY0XU6Lw2LQGFjVQyPXMOyuLTmubm2uC2I9cMJB59xrYVqJOzPhzIAtFV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=LCGNViVg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 26FD92083E;
	Fri, 14 Nov 2025 10:14:08 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id stBjovwb_fU5; Fri, 14 Nov 2025 10:14:07 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4E121207B2;
	Fri, 14 Nov 2025 10:14:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4E121207B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763111647;
	bh=7HZcrgU5Rq7F2k17aj5SwZs+2JISsKRoUqGbXr7cnvY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=LCGNViVgN0yeQsjCjOgJ+dV+43sLqGYVX45zeHUYmCerepfaOCyCPN6mdOLAU2JAH
	 ylVR6Lci4RPI/Wjv1fzITeCrXofoW7yeg/0ACNYcOFBE6aTI0ter4GXifEtBCcCrOg
	 jWWLmqwUUvzbGd1bh975FsuvvLuazRfOLeppto/rwO0/E5KJjdk+A19jVgEKVq5GYG
	 /n32Ga2RWnCssinenBTuAxpFBBN+jJAH2PDChMfbMaQqsE/xWcUa3+WRgoYCY7tkpv
	 AQ5L51MyV82SvIPxPfu4YJLTsAYUprT/c0Adqi4Y4NaK27lM4TCfnbhr0OO0IK9XK7
	 lN8Y5piRJJ4zg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 14 Nov
 2025 10:14:06 +0100
Received: (nullmailer pid 2624179 invoked by uid 1000);
	Fri, 14 Nov 2025 09:14:06 -0000
Date: Fri, 14 Nov 2025 10:14:06 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Zilin Guan <zilin@seu.edu.cn>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2] xfrm: fix memory leak in xfrm_add_acquire()
Message-ID: <aRby3noCsM-TKfkZ@secunet.com>
References: <20251110064125.593311-1-zilin@seu.edu.cn>
 <aRJwPMPsvMfxSj1u@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRJwPMPsvMfxSj1u@krikkit>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Nov 11, 2025 at 12:07:40AM +0100, Sabrina Dubroca wrote:
> note: the subject prefix should be [PATCH ipsec vX] for fixes to the
> ipsec tree. (sorry, I forgot to mention that in v1)
> 
> 2025-11-10, 06:41:25 +0000, Zilin Guan wrote:
> > The xfrm_add_acquire() function constructs an xfrm policy by calling
> > xfrm_policy_construct(). This allocates the policy structure and
> > potentially associates a security context and a device policy with it.
> > 
> > However, at the end of the function, the policy object is freed using
> > only kfree() . This skips the necessary cleanup for the security context
> > and device policy, leading to a memory leak.
> > 
> > To fix this, invoke the proper cleanup functions xfrm_dev_policy_delete(),
> > xfrm_dev_policy_free(), and security_xfrm_policy_free() before freeing the
> > policy object. This approach mirrors the error handling path in
> > xfrm_add_policy(), ensuring that all associated resources are correctly
> > released.
> > 
> > Fixes: 980ebd25794f ("[IPSEC]: Sync series - acquire insert")
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > ---
> > Changes in v2:
> > - Use the correct cleanup functions as per xfrm_add_policy().
> > ---
> >  net/xfrm/xfrm_user.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Applied to the ipsec tree, thanks everyone!

