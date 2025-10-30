Return-Path: <netdev+bounces-234296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D2AC1EECA
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE37B19C120A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E68335BAF;
	Thu, 30 Oct 2025 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="bGulg08Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0D32E733;
	Thu, 30 Oct 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811961; cv=none; b=fINnu3xFBIrROcm6i51HfoNG80SdD0uXvk1GTnsf9yXS+kMq/lmBj7pDnSEepZWyKi0GklfZnP1Allv/s3GAfm/2Q5BcF58lqDEg1FxG2/+oi8K1+ur0W6SqRkC25+y4TQhDfwTxJPa1NsvRwTn++hzRNGb8iiJFb6NhW9BPSTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811961; c=relaxed/simple;
	bh=qUof08cVvZpyI5pyttc7D1uPQ9Ry6bp7QcptSABtIRY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erThUYH/fr9re4dfi8bxHJzMdQCtNflI/fuP0ys76x9ixxBJr6uwRMrT6+pIOSkmbwkP/2ljmp6bqK90KyBnha5EAojDn3bNC3oE27GUDLzfVbc3pU2jx5D6GkOu8SMrmu0GzPHJeeL69Qv9bajYsW6nAd1lilP+Pmz4wt3VZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bGulg08Y; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1191420860;
	Thu, 30 Oct 2025 09:12:37 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9910oo1jPUIX; Thu, 30 Oct 2025 09:12:36 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7C94A20820;
	Thu, 30 Oct 2025 09:12:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7C94A20820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1761811956;
	bh=KlpxZU8es++alJ0W+sTnPbvdyFIjY0cf6QVcV6Ki/IU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=bGulg08YA9llBIt1RWZnBlnizYu0G4gacfmoBKqE5+4CVKh4bXiP8CYxiqAN+T1d4
	 OSUQqyqy4lB7VaN0KoCxk8PNjdsPKkdtMAFI2Z+XXEa0OIhVCHcdfBF2bMnviknA6v
	 MgISJ1Z127ktGUvW0hlo16cS04e54culL2GWC0OZrfMSFYmPHiVR/CAyAgqyIhmTOc
	 BZUVvOl7jEZhiQs54KxiUMvTxwI2MZam09E5a2vxRPVBGtsPYDR4erzczlvbTEBPTJ
	 1CTSYlI2yq5LmHerlsuLh57oF5cwidtBpvODVtxsij6kpiLfYpWCzfpYPNKYfU6f0e
	 Q7gGzztRdHDQg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Oct
 2025 09:12:36 +0100
Received: (nullmailer pid 1011608 invoked by uid 1000);
	Thu, 30 Oct 2025 08:12:35 -0000
Date: Thu, 30 Oct 2025 09:12:35 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Networking
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next 6/6] MAINTAINERS: Add entry for XFRM
 documentation
Message-ID: <aQMd886miv39BEPC@secunet.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
 <20251029082615.39518-7-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251029082615.39518-7-bagasdotme@gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Wed, Oct 29, 2025 at 03:26:14PM +0700, Bagas Sanjaya wrote:
> XFRM patches are supposed to be sent to maintainers under "NETWORKING
> [IPSEC]" heading, but it doesn't cover XFRM docs yet. Add the entry.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d652f4f27756ef..4f33daad40bed6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18041,6 +18041,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
> +F:	Documentation/networking/xfrm/

That means that I'm now responsible for this.
But I'm OK with it if nobody has objections on it.

