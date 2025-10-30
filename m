Return-Path: <netdev+bounces-234294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9984EC1EE8B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8FB1895965
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8002FFF9B;
	Thu, 30 Oct 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="HWXdQYUv"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80D21D3C9
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811704; cv=none; b=JtUbqyeD36m8h+SzMrmKu3g1uGu/IzYY8ontJKckh4YF+zGB7beA+b3Bc7VcOhrOtm6f76GQtwhDwRmMdXFx07br/fohV3mLuaiD+k0GagqF9HDWkgANAeTW74USIlVNY53AVCFsxgeCwYpOEXmAyGsMUP2EzOwP0UjFQibp9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811704; c=relaxed/simple;
	bh=iYmSRn54aVNb5cInRyR2epoXsk8M+oHPrtX+OlZJLhk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT6Z/SjKkWy+xLyKd5Xt+azKxWXcXWVuvYTAWBgoqVQuUhR3TZI22Mu8QWw57XrqJUcK/1SW7OX8nXOe1ya3m3ZxZ9zHBoYxgMiiFPo9d1zIX/4N55qdKwd4GRXGTdwzJcxj7FaBDxHa4VLMNYahRvPAzRAS+ruek+ZidxgFcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HWXdQYUv; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DCCEA20891;
	Thu, 30 Oct 2025 09:08:12 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZcLPqL8usikz; Thu, 30 Oct 2025 09:08:12 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5740E2083F;
	Thu, 30 Oct 2025 09:08:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5740E2083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1761811692;
	bh=XZ8vwGAWf1a2UoylOo0fa3gnmQ0Co9koDKimV5Qtnd4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=HWXdQYUvimHyZxg8jY8w58XHzfgWO2IlTETmHE+kX2upfty9BL43hGogXVi9x5Xi1
	 5XwFz3CTL4kpl9RwJTpjSAS/9CriKsdq/XpjvZxoHcWJA+KRpP0Hpwj6k50eDVCP/E
	 MvLRLcLobSx1DVmt74QdyN2weLnNBDcsDE6nWVhihNjtNlonoZQhW5VY96VlEJy63B
	 Fs1Dn1apsjcXk/hG5Kc19/xaYhAuD8nOw1+uN3a68/effy/ai9V0PhN0luZHhncb/8
	 KDY6V8ifAzhkIJT77PJjQ3qRNNBR8JdwsGHeU36RnLBjI4RFrMLTLL8hjBGKfx2sPt
	 s2tZDsvhitO5w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Oct
 2025 09:08:11 +0100
Received: (nullmailer pid 1008396 invoked by uid 1000);
	Thu, 30 Oct 2025 08:08:11 -0000
Date: Thu, 30 Oct 2025 09:08:11 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>
Subject: Re: [PATCH ipsec v3 2/2] xfrm: Determine inner GSO type from packet
 inner protocol
Message-ID: <aQMc64pcTzvkupc1@secunet.com>
References: <20251028023013.9836-1-jianbol@nvidia.com>
 <20251028023013.9836-3-jianbol@nvidia.com>
 <aQCjCEDvL4VJIsoV@krikkit>
 <c1a673ab-0382-445e-aa45-2b8fe2f6bc40@nvidia.com>
 <aQDbhJuZqFokEO31@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQDbhJuZqFokEO31@krikkit>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Oct 28, 2025 at 04:04:36PM +0100, Sabrina Dubroca wrote:
> 2025-10-28, 21:36:17 +0800, Jianbo Liu wrote:
> > 
> > My proposed plan is:
> > 
> > Send the patch 1 and patch 3 (including the xfrm_ip2inner_mode change)
> > together to the ipsec tree. They are self-contained fixes.
> 
> So, keep v3 of this series unchanged.
> 
> > Separately, after those are accepted, I can modify and re-submit that patch
> > [1] to ipsec-next that removes the now-redundant checks from the other
> > callers (VTI, etc.), leveraging the updated helper function.
> > 
> > This way, the critical fixes are self-contained and backportable, while the
> > cleanup of other callers happens later in the development cycle.
> 
> The only (small) drawback is leaving the duplicate code checking
> AF_UNSPEC in the existing callers of xfrm_ip2inner_mode, but I guess
> that's ok.
> 
> 
> Steffen, is it ok for you to
> 
>  - have a duplicate AF_UNSPEC check in callers of xfrm_ip2inner_mode
>    (the existing "default to x->inner_mode, call xfrm_ip2inner_mode if
>    AF_UNSPEC", and the new one added to xfrm_ip2inner_mode by this
>    patch) in the ipsec tree and then in stable?
> 
>  - do the clean up (like the diff I pasted in my previous email, or
>    something smaller if [1] is applied separately) in ipsec-next after
>    ipsec is merged into it?

I'm OK with this, I can take v3 as is.

