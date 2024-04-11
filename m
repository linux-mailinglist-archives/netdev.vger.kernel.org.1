Return-Path: <netdev+bounces-86894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF38A0B0F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 10:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD31A1F22ECA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB5D13FD79;
	Thu, 11 Apr 2024 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="FtNphpy0"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3E26ACC
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823759; cv=none; b=DIr0XKvvyNxECjQ0Dfrr3r+CF9w6Xyu4KIiM6wlBh2h7/Fl3f85lPSyoh/HKvlig4BaB3X+d4vjQiZ4nfwplyQgmJZLzSAWdZ+5tnbgJzhfOHUT+IDpguOH7zghCm4Q8IpaxO61cDzw6zOJytMZAKu8/Zm3AScd2U9zJOb14aJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823759; c=relaxed/simple;
	bh=OftxhjOxbbs4J6I2c0o1x+ZLQX0AI1bFTr5k7uenFsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDiFLiKPpFJKEWf+SXbbz6GrMu3FNA9ofjQ0i4cE2PinZTMyMENlOUln2yvGzOqM2uAlESp0GiRTxYFXws3xVf9sGb5i0x0aFdzeVaLECO43c0OUwAWQAsakMgFiv7xCd0tXVsV0X0rm8MgaY5jThFPpfvf341OEsyFFmUkOgFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FtNphpy0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id AD4B420851;
	Thu, 11 Apr 2024 10:22:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BtB6JWOlXe-H; Thu, 11 Apr 2024 10:22:33 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6D3482084E;
	Thu, 11 Apr 2024 10:22:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6D3482084E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712823753;
	bh=QmR2ob0V3BYOj22T3BEYDVtcvzxdTxyBUAhb0RL/gRM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=FtNphpy0I/NMoDrLuyvt3MA8FEZv8f/PPxq0PqDJJ+eFyOfpiNezdWuGTO3l9ERj2
	 eF0rzNrGpSTetGYf2SJDOhPhfALQw9vCxl5F96Gb7zOxoVtsjnMa+08Laahc42JFHf
	 kPvhKqxei9zY1bS0MJPHsxAhjcrqA7Luc24vyFTlPhifQ25k4wqdGvsHN0PddLAGTf
	 ti77qi8WNdNDvRDajSGhbIV4p5uazCSoF4POlcP7xWwIOviYsrdoCYYlHZbVQek0od
	 kWUMfUP01rLc02b+6yYwG3NdLdDOrpbHYow2wsehAaWx7wjxVX6wngBWwDT7Sg2Q13
	 3e1kn9q9tUMEA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 689BC80004A;
	Thu, 11 Apr 2024 10:22:33 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:22:33 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 10:22:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A2434318093A; Thu, 11 Apr 2024 10:22:32 +0200 (CEST)
Date: Thu, 11 Apr 2024 10:22:32 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Florian Westphal <fw@strlen.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andreas Gruenbacher
	<agruenba@redhat.com>, <devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec-next v2] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
Message-ID: <ZhedyOIndjX3kben@gauss3.secunet.de>
References: <c873dc4dcaa0ab84b562f29751996db6bd37d440.1712220541.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c873dc4dcaa0ab84b562f29751996db6bd37d440.1712220541.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Thu, Apr 04, 2024 at 10:51:31AM +0200, Antony Antony wrote:
> The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
> in 2004 [2], has remained inactive and obsolete for an extended period.
> 
> This mode was originally defined in an early version of an IETF draft
> [1] from 2001. By the time it was integrated into the kernel in 2004 [2],
> it had already been replaced by UDP_ENCAP_ESPINUDP [3] in later
> versions of draft-ietf-ipsec-udp-encaps, particularly in version 06.
> 
> Over time, UDP_ENCAP_ESPINUDP_NON_IKE has lost its relevance, with no
> known use cases.
> 
> With this commit, we remove support for UDP_ENCAP_ESPINUDP_NON_IKE,
> simplifying the codebase and eliminating unnecessary complexity.
> Actually, we remove the functionality and wrap  UDP_ENCAP_ESPINUDP_NON_IKE
> defination in "#ifndef __KERNEL__". If it is used again in kernel code
> your build will fail.
> 
> References:
> [1] https://datatracker.ietf.org/doc/html/draft-ietf-ipsec-udp-encaps-00.txt
> 
> [2] Commit that added UDP_ENCAP_ESPINUDP_NON_IKE to the Linux historic
>     repository.
> 
>     Author: Andreas Gruenbacher <agruen@suse.de>
>     Date: Fri Apr 9 01:47:47 2004 -0700
> 
>    [IPSEC]: Support draft-ietf-ipsec-udp-encaps-00/01, some ipec impls need it.
> 
> [3] Commit that added UDP_ENCAP_ESPINUDP to the Linux historic
>     repository.
> 
>     Author: Derek Atkins <derek@ihtfp.com>
>     Date: Wed Apr 2 13:21:02 2003 -0800
> 
>     [IPSEC]: Implement UDP Encapsulation framework.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v1 -> v2
> - removed defination wrapped in #ifndef __KERNEL__ It would falsly
>   let userspace appliction build and break when running.
> RFC -> v1
> - keep removed defination wrapped in #ifndef __KERNEL__
> ---
>  include/uapi/linux/udp.h |  1 -
>  net/ipv4/esp4.c          | 12 ------------
>  net/ipv4/udp.c           |  2 --
>  net/ipv4/xfrm4_input.c   | 13 -------------
>  net/ipv6/esp6.c          | 12 ------------
>  net/ipv6/xfrm6_input.c   | 13 -------------
>  6 files changed, 53 deletions(-)
> 
> diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> index 4828794efcf8..1516f53698e0 100644
> --- a/include/uapi/linux/udp.h
> +++ b/include/uapi/linux/udp.h
> @@ -36,7 +36,6 @@ struct udphdr {
>  #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
> 
>  /* UDP encapsulation types */
> -#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */

Please don't remove that, it is part of the ABI.
Typically this is left in and marked as: /* unused */


