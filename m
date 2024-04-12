Return-Path: <netdev+bounces-87268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9061C8A2677
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 151FEB21959
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7263E23778;
	Fri, 12 Apr 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="iISYnZ/o"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47E210F8
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903106; cv=none; b=F9UPNeUdxJqnQQzzheGvxgRfQJq57vpe4mWotDvmfP4P2CUasb3T8pp0D2LSZDD8MXL0rgDYumQnovryHxy3IU+1Yr/pc5jQeayITYnGsbHmbkjuVHv5AQDli06ciba/TuPbVoQx6ZTnfpVhC5toOcAG+a9KfZhwUcR1KUFHY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903106; c=relaxed/simple;
	bh=FLSIhme68GUo41N/pNG+7lFa+GwWTuC+unQlJQlISj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHw36YaWReokzDPcU510a9In20BQpz3+kJE2+Xfz8d1KsAB77v1Gfx9Y9ounfmFOnvFqYzmSXvqxskQuOKFWs+dBOnStsPYuGFsaNITGWMWmo47tab5sH2ZHvB4AK4WuILR7wvAno5F7YrkenkoeETipzV2DDIrVd6Fj28puXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=iISYnZ/o; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1CDD3207D8;
	Fri, 12 Apr 2024 08:25:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCFuy-dhNu0T; Fri, 12 Apr 2024 08:25:01 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 834A12085B;
	Fri, 12 Apr 2024 08:25:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 834A12085B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712903101;
	bh=M8RSbWa8KJCLjjBOi2JFvD++thmDdjrGP4taFz1xm4A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=iISYnZ/okM+9ZN77Y6/hhJZqDGp9AgK4fQzRdCrbiIEpxhyD8wP7BC3ftx0TU7/xX
	 r/RZOeWPtYTYkJwevw8l3jROVvk3h3gdKnR2sh2XAJ9cs2/TNUUjgg7MZ03+UFY1Ge
	 CSVDX+qwYtwcV6w3f1GVid4cnLLl8dLqF15A5jTdT4FlnsqGuvkpX4nLDWlSf1XfBl
	 Nv4J211nkgFA4ZwedNuS1yB3/FKHAUcHQSTPQYKkEQFXUV0UGxU2WAWE9lKJ0U2JbR
	 pdk9C55VNlPWnHjSUhINgwAwzfOGG5+OWVbRdd4n9XXGnpcnj+yv7CKXBUgXtRLz8q
	 nip8ncawoMrvQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 70ACF80004A;
	Fri, 12 Apr 2024 08:25:01 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 08:25:01 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 12 Apr
 2024 08:24:59 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C70213181F49; Fri, 12 Apr 2024 08:24:58 +0200 (CEST)
Date: Fri, 12 Apr 2024 08:24:58 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Florian Westphal <fw@strlen.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andreas Gruenbacher
	<agruenba@redhat.com>, <devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec-next v2] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
Message-ID: <ZhjTugJcluEXH3Vz@gauss3.secunet.de>
References: <c873dc4dcaa0ab84b562f29751996db6bd37d440.1712220541.git.antony.antony@secunet.com>
 <ZhedyOIndjX3kben@gauss3.secunet.de>
 <Zhgh0HsEx0uRiEtd@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zhgh0HsEx0uRiEtd@moon.secunet.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Thu, Apr 11, 2024 at 07:45:52PM +0200, Antony Antony wrote:
> On Thu, Apr 11, 2024 at 10:22:32 +0200, Steffen Klassert wrote:
> > On Thu, Apr 04, 2024 at 10:51:31AM +0200, Antony Antony wrote:
> > > 
> > > diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> > > index 4828794efcf8..1516f53698e0 100644
> > > --- a/include/uapi/linux/udp.h
> > > +++ b/include/uapi/linux/udp.h
> > > @@ -36,7 +36,6 @@ struct udphdr {
> > >  #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
> > > 
> > >  /* UDP encapsulation types */
> > > -#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
> > 
> > Please don't remove that, it is part of the ABI.
> > Typically this is left in and marked as: /* unused */
> 
> Where exactly should I add /* unused */ ?
> 
> I agree, it is part of the ABI. We should be careful when removing. However, the solution to obselete is not clear to me. Would you please elaborte on the solution? I see 3 options. Which one do you prefer? Or is there 4th option?
> 
> 1. change the comment and leave the definition
> 
> -#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
> +#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */

I prefer this option. The kernel will return -ENOPROTOOPT if userspace
tries to set that option.

> 
> Paul brought up a probable issue with this solution. This means user space would build without error while at runtime user space would fail.

If this still has users, it is not unused :-)

> Also kernel would build if someone add it.

Hopefully that will be catched by the review process.


