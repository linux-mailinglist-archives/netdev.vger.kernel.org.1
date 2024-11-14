Return-Path: <netdev+bounces-144822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD759C87CB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E130281780
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483231F76DD;
	Thu, 14 Nov 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JC63zjcw"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A601DC18F;
	Thu, 14 Nov 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580681; cv=none; b=b2ge8I8BVoHzPI/iXvUI5/r/awy5nBDOGnIn9PUHTNfdgK7zPCDO3hL27LIBzHd8gN2GD5RQ5oWOfBqOZ6wOmLy0+d4xg0mEMic8tDX6yuRdwMrnDoGhLOp/ZjTGMITFGQFx76BpgTyC8MKNd+miSqPDl/80fQ/AlwRC3oImRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580681; c=relaxed/simple;
	bh=U3INflKoTFEQHi4GMTG+NQUhORDGMAc7qj5V5pHHikY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDxDefigM/d92CdK+hG8s/LZk8qO3tAacUQcceHz+YWkykk283x4u5AQLh8M39UNUVY3hJQiYLsYrWHzZQXWMJ75B/CIc1GiP8rvwl+2XxYTfzg3SqWVUfo4a4eXwTM8dgcdnQmzPMQB4WbLnyf+5cMSURZ4Zyxc2dSIdP2xYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JC63zjcw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2096A20839;
	Thu, 14 Nov 2024 11:37:50 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VR7HPC-Gcqfq; Thu, 14 Nov 2024 11:37:49 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 88BA520826;
	Thu, 14 Nov 2024 11:37:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 88BA520826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731580669;
	bh=xWF2G4aqdtqtRIXe18oGJKxH7vHq+f3PUospaf9le7M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=JC63zjcwq87b8+Cypy+KQUrZn4DWMyJFNT7/WeNuq4zXupGPWDCR1eo6WwiYCgOkJ
	 bkNGQp9MOV1GrVI6MHCCPeazqAK0HY4ue12OUSrJkiSarcrFJqERu7ScMgAOherMVu
	 tpUwx3VM7yfxTXib7SClhXv/XjJgknCIcB+vjyi7kj2bVEMx63mvsc/CdOG0eueOZm
	 iIOqtBdyr1ycmu3em8QEvd8eMzao7YRt+tjz0ffYNjZmDRE2XFUEQJP5Ep3ltUvae3
	 Q4uNvVlXyndFCJ/HkiWUBVykhnhu5sMkrcWhepH5fyl3O5TnsmWMXZaxrDQcd+ltO3
	 PgY5Yi1sFOj2A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 11:37:49 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 11:37:48 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7518F31815A0; Thu, 14 Nov 2024 11:37:48 +0100 (CET)
Date: Thu, 14 Nov 2024 11:37:48 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Daniel Yang <danielyangkang@gmail.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, "open list:NETWORKING [IPSEC]"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: replace deprecated strncpy with strscpy_pad
Message-ID: <ZzXS/A/LcKCCDYRp@gauss3.secunet.de>
References: <20241113092058.189142-1-danielyangkang@gmail.com>
 <7914fb1b-8e9d-4c02-b970-b6eaaf468d05@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7914fb1b-8e9d-4c02-b970-b6eaaf468d05@redhat.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Nov 14, 2024 at 11:34:25AM +0100, Paolo Abeni wrote:
> On 11/13/24 10:20, Daniel Yang wrote:
> > The function strncpy is deprecated since it does not guarantee the
> > destination buffer is NULL terminated. Recommended replacement is
> > strscpy. The padded version was used to remain consistent with the other
> > strscpy_pad usage in the modified function.
> > 
> > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > ---
> >  net/xfrm/xfrm_user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index e3b8ce898..085f68e35 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -1089,7 +1089,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
> >  	if (!nla)
> >  		return -EMSGSIZE;
> >  	algo = nla_data(nla);
> > -	strncpy(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
> > +	strscpy_pad(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
> >  
> >  	if (redact_secret && auth->alg_key_len)
> >  		memset(algo->alg_key, 0, (auth->alg_key_len + 7) / 8);
> 
> @Steffen, @Herbert: I think this should go via your tree despite the
> prefix tag.

I'll take it into ipsec-next.

Thanks!

