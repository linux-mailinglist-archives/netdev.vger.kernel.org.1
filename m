Return-Path: <netdev+bounces-123737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4789665C9
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607721C2238E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C881B81A2;
	Fri, 30 Aug 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6VBKc8l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703371B7901;
	Fri, 30 Aug 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032059; cv=none; b=OuwCMzL3aMmuNL3HNXvpb3x6vnCMH8x/F2dNBejTPiwaKFJCamu2OE5RiQpK8LpIOL6vWFTavY8KYdTt+goqFR2GRLePDEP8doKd7p2UHNgA6grICTDbvZ7CRUWtnKRRPiQ5efsZN8yEcd4w8xKKw5o/ZRGVnubFnYsmDveSIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032059; c=relaxed/simple;
	bh=h5Dh9w2B631NC+SF0BB02Jl/dZ4K6lx7MsnDASvr5tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsjmNrgCAOchpwgYKGwTcTlHabcg9hDPJSCnsbbp6IXBuXv43PQRO4yibnQme3kx6fuoaXeZLn4kkQ37B9ouE/fYT8pGADNb9BCm1VTnTPGABvfG+sRH7WuC0qeYucs69lfIszCvOrywohHmWvzJ08geSl5nmCKFN9mCtXDGriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6VBKc8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6522C4CEC2;
	Fri, 30 Aug 2024 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032059;
	bh=h5Dh9w2B631NC+SF0BB02Jl/dZ4K6lx7MsnDASvr5tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6VBKc8lPgjHp6f7jbf7w0oNckYBnFgYvehEf07A+MY4h6yL6C+/FSAS/unAAC8J8
	 rfybVNdvl2Lz99RcwuIx7BonGginesqKZ1fDMw/TYcepTeVsjSjzR6uXIqXU8mntTv
	 1rIXzNmlUPumIAesKpRsea5/b4cWQQ9Bo4HyXcJuxsIPBw6brlWTSBraXa9BrnPQNs
	 DmteLwUiCGKB631+2XDOAwActb/YbS19+UZoo9e4/9qLc/8Qg+MwJU2lWeIoPHSvEG
	 x1BO0pbc7nL1UEfT2w+KD5KBisOJ+/jWY77RX/vI1fj5/UTqphXW61u6I4MKX2gLHa
	 vCy6TMHMk2Dsg==
Date: Fri, 30 Aug 2024 16:34:13 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com,
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org,
	petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/12] net: vxlan: use vxlan_kfree_skb() in
 vxlan_xmit()
Message-ID: <20240830153413.GQ1368797@kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-9-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830020001.79377-9-dongml2@chinatelecom.cn>

On Fri, Aug 30, 2024 at 09:59:57AM +0800, Menglong Dong wrote:
> Replace kfree_skb() with vxlan_kfree_skb() in vxlan_xmit(). Following
> new skb drop reasons are introduced for vxlan:
> 
> /* no remote found */
> VXLAN_DROP_NO_REMOTE
> 
> And following drop reason is introduced to dropreason-core:
> 
> /* txinfo is missed in "external" mode */
> SKB_DROP_REASON_TUNNEL_TXINFO
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - move the drop reason "TXINFO" from vxlan to core
> - rename VXLAN_DROP_REMOTE to VXLAN_DROP_NO_REMOTE
> ---
>  drivers/net/vxlan/drop.h       | 3 +++
>  drivers/net/vxlan/vxlan_core.c | 6 +++---
>  include/net/dropreason-core.h  | 3 +++
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> index 416532633881..a8ad96e0a502 100644
> --- a/drivers/net/vxlan/drop.h
> +++ b/drivers/net/vxlan/drop.h
> @@ -13,6 +13,7 @@
>  	R(VXLAN_DROP_ENTRY_EXISTS)		\
>  	R(VXLAN_DROP_INVALID_HDR)		\
>  	R(VXLAN_DROP_VNI_NOT_FOUND)		\
> +	R(VXLAN_DROP_NO_REMOTE)			\
>  	/* deliberate comment for trailing \ */
>  
>  enum vxlan_drop_reason {
> @@ -33,6 +34,8 @@ enum vxlan_drop_reason {
>  	VXLAN_DROP_INVALID_HDR,
>  	/** @VXLAN_DROP_VNI_NOT_FOUND: no vxlan device found for the vni */
>  	VXLAN_DROP_VNI_NOT_FOUND,
> +	/** @VXLAN_DROP_NO_REMOTE: no remote found to transmit the packet */

Maybe: no remote found for transmit
   or: no remote found for xmit

> +	VXLAN_DROP_NO_REMOTE,
>  };
>  
>  static inline void

...

