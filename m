Return-Path: <netdev+bounces-87151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1558A1E0D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE31D1C24D74
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4D131BAB;
	Thu, 11 Apr 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="G9FbdKLM"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B89131BCF
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857568; cv=none; b=YNZh+KkkoIxrQuGty5ajVYwscxHs3/zn0oc/rnRjF+m48MUDvdCD2FqxICMHJTj2+vrkUTAtXRHb0lXlK+niWFqt7qQkUJ/9Y4YJZtkKhoXoHzyPngPKri1SHGJLbe3VSuquoNMbjLbIyUFkSfuYXFcA5IdvzzCam4+161S+upo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857568; c=relaxed/simple;
	bh=0KZgB949330pBoOcfr4EXRVG5pPj3wCT9VHslUbkUhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fcra/rCM/rAlj9sxS+CbHqI6scs1leb9KfCYQhlsc1v/YEa+hV/NBZ5heqo/exLTW+oKZU3V0kFlHT0Bil4hI8pIYrWMYLd5ln8K3anx4VJ+7+DcSYuCuNWZ5xmNy9/QdIvY34aZqlT0aT2z5cgHJMwvCCF5RJ43BMerZZ/MRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=G9FbdKLM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 65D9B2084C;
	Thu, 11 Apr 2024 19:45:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBJ2XopomWHU; Thu, 11 Apr 2024 19:45:55 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 69C4C205ED;
	Thu, 11 Apr 2024 19:45:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 69C4C205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712857555;
	bh=u172TINW1w/cpQnDs/5hlUWAKIXJWyn2cKi5X6CSqvc=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=G9FbdKLM7fykD8ufGrnhdCuL/9uqEKhbUoJrYe/6QRm6Yvy3Od7DMKtsKMLxUtl3X
	 6uog76LspVQmK+vZbalR18DCgxEN2zfoxeL+rAb8PfFiov/lb9BZVn0GV+JOXtOFrB
	 ZyYskQvYlzgebCanHv6WakOZ6lACYQRuRvcmA5rPKdBuzjGvljpPK52NdDJMhiI2Y/
	 Trodom+qOfsfcXfp2iS+TLZ0D0ALjO8meyZRf2lOvKhvojd+7vqsBv/8ANiHx1CtiJ
	 U3NGZHjin/z2KM+ur0aRyV7GWDiDt/v1Hmegp8jX1Rdo0wG2r+z98AM/lPwH5FrY7J
	 UAgt3jK7Rg00Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 5A78480004A;
	Thu, 11 Apr 2024 19:45:55 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 19:45:55 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 19:45:54 +0200
Date: Thu, 11 Apr 2024 19:45:52 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Antony Antony <antony.antony@secunet.com>, Florian Westphal
	<fw@strlen.de>, Herbert Xu <herbert@gondor.apana.org.au>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>,
	<devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec-next v2] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
Message-ID: <Zhgh0HsEx0uRiEtd@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <c873dc4dcaa0ab84b562f29751996db6bd37d440.1712220541.git.antony.antony@secunet.com>
 <ZhedyOIndjX3kben@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhedyOIndjX3kben@gauss3.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Thu, Apr 11, 2024 at 10:22:32 +0200, Steffen Klassert wrote:
> On Thu, Apr 04, 2024 at 10:51:31AM +0200, Antony Antony wrote:
> > The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
> > in 2004 [2], has remained inactive and obsolete for an extended period.
> > 
> > This mode was originally defined in an early version of an IETF draft
> > [1] from 2001. By the time it was integrated into the kernel in 2004 [2],
> > it had already been replaced by UDP_ENCAP_ESPINUDP [3] in later
> > versions of draft-ietf-ipsec-udp-encaps, particularly in version 06.
> > 
> > Over time, UDP_ENCAP_ESPINUDP_NON_IKE has lost its relevance, with no
> > known use cases.
> > 
> > With this commit, we remove support for UDP_ENCAP_ESPINUDP_NON_IKE,
> > simplifying the codebase and eliminating unnecessary complexity.
> > Actually, we remove the functionality and wrap  UDP_ENCAP_ESPINUDP_NON_IKE
> > defination in "#ifndef __KERNEL__". If it is used again in kernel code
> > your build will fail.
> > 
> > References:
> > [1] https://datatracker.ietf.org/doc/html/draft-ietf-ipsec-udp-encaps-00.txt
> > 
> > [2] Commit that added UDP_ENCAP_ESPINUDP_NON_IKE to the Linux historic
> >     repository.
> > 
> >     Author: Andreas Gruenbacher <agruen@suse.de>
> >     Date: Fri Apr 9 01:47:47 2004 -0700
> > 
> >    [IPSEC]: Support draft-ietf-ipsec-udp-encaps-00/01, some ipec impls need it.
> > 
> > [3] Commit that added UDP_ENCAP_ESPINUDP to the Linux historic
> >     repository.
> > 
> >     Author: Derek Atkins <derek@ihtfp.com>
> >     Date: Wed Apr 2 13:21:02 2003 -0800
> > 
> >     [IPSEC]: Implement UDP Encapsulation framework.
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> > v1 -> v2
> > - removed defination wrapped in #ifndef __KERNEL__ It would falsly
> >   let userspace appliction build and break when running.
> > RFC -> v1
> > - keep removed defination wrapped in #ifndef __KERNEL__
> > ---
> >  include/uapi/linux/udp.h |  1 -
> >  net/ipv4/esp4.c          | 12 ------------
> >  net/ipv4/udp.c           |  2 --
> >  net/ipv4/xfrm4_input.c   | 13 -------------
> >  net/ipv6/esp6.c          | 12 ------------
> >  net/ipv6/xfrm6_input.c   | 13 -------------
> >  6 files changed, 53 deletions(-)
> > 
> > diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> > index 4828794efcf8..1516f53698e0 100644
> > --- a/include/uapi/linux/udp.h
> > +++ b/include/uapi/linux/udp.h
> > @@ -36,7 +36,6 @@ struct udphdr {
> >  #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
> > 
> >  /* UDP encapsulation types */
> > -#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
> 
> Please don't remove that, it is part of the ABI.
> Typically this is left in and marked as: /* unused */

Where exactly should I add /* unused */ ?

I agree, it is part of the ABI. We should be careful when removing. However, the solution to obselete is not clear to me. Would you please elaborte on the solution? I see 3 options. Which one do you prefer? Or is there 4th option?

1. change the comment and leave the definition

-#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
+#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */

Paul brought up a probable issue with this solution. This means user space would build without error while at runtime user space would fail.
Also kernel would build if someone add it.

2: wrap it in ifndef __KERNEL__ as Florian suggested 
-#define UDP_ENCAP_ESPINUDP_NON_IKE     1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
+#ifndef __KERNEL__
+#define UDP_ENCAP_ESPINUDP_NON_IKE     1 /* (obsolete) draft-ietf-ipsec-nat-t-ike-00/01 */
+#endif
+

Kernel would not build, however, usersapce would build. This is v2. It was not accepeted.

3. comment it completly?
-#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
+ /* #define UDP_ENCAP_ESPINUDP_NON_IKE	1 unused draft-ietf-ipsec-nat-t-ike-00/01 */

This means kernel and userspace would fail to build when is used.
What is your preference? Then I can send a v3.

-antony

