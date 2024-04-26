Return-Path: <netdev+bounces-91640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF9C8B34C2
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE91C21D6B
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E799142E6D;
	Fri, 26 Apr 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARRISlBp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A993142E64
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125616; cv=none; b=eL8u4bl7pylv3ib2gCjDBOqiysw2bMFRb/wsBjQRZN+AzfHzP3wq3TA78VBk9YlL1W3ude1qDV+vBV5/tP48oTlKY26i92ESO+5Vr6IMy0je4EaoQT6nHE7tZxSCGaXwSO88cqagRxI3KjyqhCv3mwiWPoC9lG7iI/gp8hMeU90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125616; c=relaxed/simple;
	bh=ARzQY+Uq1wtVBia8666DWk69aO7KAY7zNdtlmwTgzCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1pBE+t6RinUGMCKCPOxohaZiTajjbDFeoyXToiTtj7X+pFEUcFUfW/tVHO+DnrF7wJFs/y7UHEZfhQXmwOR/29q7JgRMijwZQFcBkI1EwuoM60oNNRCHH0iquSbHnl3/rJmsxm9O488mEfEKT2jPlGXIKkHTzjHbx83Ht32jxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARRISlBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE467C113CD;
	Fri, 26 Apr 2024 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714125615;
	bh=ARzQY+Uq1wtVBia8666DWk69aO7KAY7zNdtlmwTgzCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARRISlBplcyQkjXjaDfZXcoJ1WluTE8ovDJTO4Hc/XjXyhXK1HPWTixsc/mpQN9HR
	 Yv/M3P9kki7K8TZAqhimrjHbdSFkOqdQEvgYn7S/p6peWTvf2ZUs2DXZDv1lj9zLXv
	 8Fq3PlWIt1ZnSREG8Jp0lGggn50lJmL4zCyXoYT3e3xjPDAnwxKf6AtdY8XyzEqLaw
	 n9nBciZTKa9UQZESEmPFabIlq3bVnKLV+aLN17BSZuuiYREM0ZdS6YFX32kpFaagbY
	 gHka3DPKBnodz7QoscYZR7SPz+2m5IHCR/HVPWZiDGlj4MfuKx0heAk+n24zGSvupw
	 Lcts2IrGq5fjg==
Date: Fri, 26 Apr 2024 10:58:41 +0100
From: Simon Horman <horms@kernel.org>
To: David Bauer <mail@david-bauer.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net] net l2tp: drop flow hash on forward
Message-ID: <20240426095841.GE42092@kernel.org>
References: <20240424171110.13701-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424171110.13701-1-mail@david-bauer.net>

+ Randy Dunlap

On Wed, Apr 24, 2024 at 07:11:10PM +0200, David Bauer wrote:
> Drop the flow-hash of the skb when forwarding to the L2TP netdev.
> 
> This avoids the L2TP qdisc from using the flow-hash from the outer
> packet, which is identical for every flow within the tunnel.
> 
> This does not affect every platform but is specific for the ethernet
> driver. It depends on the platform including L4 information in the
> flow-hash.
> 
> One such example is the Mediatek Filogic MT798x family of networking
> processors.
> 
> Fixes: d9e31d17ceba ("l2tp: Add L2TP ethernet pseudowire support")
> Acked-by: James Chapman <jchapman@katalix.com>
> Signed-off-by: David Bauer <mail@david-bauer.net>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/l2tp/l2tp_eth.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
> index 39e487ccc468..8ba00ad433c2 100644
> --- a/net/l2tp/l2tp_eth.c
> +++ b/net/l2tp/l2tp_eth.c
> @@ -127,6 +127,9 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
>  	/* checksums verified by L2TP */
>  	skb->ip_summed = CHECKSUM_NONE;
>  
> +	/* drop outer flow-hash */
> +	skb_clear_hash(skb);
> +
>  	skb_dst_drop(skb);
>  	nf_reset_ct(skb);
>  
> -- 
> 2.43.0
> 
> 

