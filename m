Return-Path: <netdev+bounces-127678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7EC9760EA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061C2B21DB3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03954765;
	Thu, 12 Sep 2024 06:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AA2D7BF;
	Thu, 12 Sep 2024 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121006; cv=none; b=VzJ2q1RMXY0UXluDmcY0DFTzlnE34D5MED/+DuJ0csb6yOj9iNaHdtxjRblfCPoNGE6yWdO611uapaabqRrPOLJP066mTiJvMmE2gbnrdwnJfh4wmmeFofLuSGvA0j0L58J+m3EscCXHCLqY6+AF/U6KxkJ5aha7CJ5w05Zxelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121006; c=relaxed/simple;
	bh=uUUR3dtE4Kf4BXkkIJjOT8bDWswo2vCLF3eTJUx2644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyQVK59n4kIbNHuZQtpVkGddHwM7pLTBn0uCOaabgaQmYVbGVGS1hSN7HrI/A6qftuEgBFRwzsGMIzdpN0iq2k8ZP7GuGgH5ABSjBeOi7NVl/zDo9j0vaAN8tF3AWCQ2NDYJCaG51iivI8qAmcJM7YqIPSGqV7uICqCcjuiODGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1socv5-0004rn-1K; Thu, 12 Sep 2024 08:03:07 +0200
Date: Thu, 12 Sep 2024 08:03:07 +0200
From: Florian Westphal <fw@strlen.de>
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kai.heng.feng@canonical.com,
	chia-lin.kao@canonical.com, anthony.wong@canonical.com,
	kuan-ying.lee@canonical.com, chris.chiu@canonical.com
Subject: Re: [PATCH ipsec] xfrm: avoid using skb->mac_len to decide if mac
 header is shown
Message-ID: <20240912060307.GA18251@breakpoint.cc>
References: <20240912033807.214238-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912033807.214238-1-en-wei.wu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

En-Wei Wu <en-wei.wu@canonical.com> wrote:
> When we use Intel WWAN with xfrm, our system always hangs after
> browsing websites for a few seconds. The error message shows that
> it is a slab-out-of-bounds error:
> 
> The reason is that the eth_hdr(skb) inside the if statement evaluated
> to an unexpected address with skb->mac_header = ~0U (indicating there
> is no MAC header). The unreliability of skb->mac_len causes the if
> statement to become true even if there is no MAC header inside the
> skb data buffer.
> 
> Replace the skb->mac_len in the if statement with the more reliable macro
> skb_mac_header_was_set(skb) fixes this issue.
> 
> Fixes: b3284df1c86f ("xfrm: remove input2 indirection from xfrm_mode")

No, that just moved code around.

> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
>  net/xfrm/xfrm_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 749e7eea99e4..93b261340105 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -251,7 +251,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
>  
>  	skb_reset_network_header(skb);
>  	skb_mac_header_rebuild(skb);
> -	if (skb->mac_len)
> +	if (skb_mac_header_was_set(skb))
>  		eth_hdr(skb)->h_proto = skb->protocol;

I think you will need to check both, else you restore the bug fixed in
87cdf3148b11 ("xfrm: Verify MAC header exists before overwriting
eth_hdr(skb)->h_proto").

