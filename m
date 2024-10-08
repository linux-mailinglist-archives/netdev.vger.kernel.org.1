Return-Path: <netdev+bounces-133099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398F994A10
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCF11F26087
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFD1DE3D6;
	Tue,  8 Oct 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLhNSrcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80515EEC8;
	Tue,  8 Oct 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390531; cv=none; b=S13LTR5IeYKoRgpxgxrDYkhKpwldbtKJ6E/FH3fk4/HQP+q7iVIKpSRIFsWKd9dBsHNkoikmYmRtMbaq/5Zv7srudcNpg03SMXgRbXBUgzirHoQHgMhft/w7ePKbPpjkr+z4plR3mpBpNMCcNubxyQ+M+YtqrBf2prciq1nMxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390531; c=relaxed/simple;
	bh=Q7N76+AWHNR7gMKRHOPlqluVHjC0C/n5Vfh5vNbLs0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl36BNeDFXEuqDckRZN1OKZsObzV4bc+aLxXMHc46Z/5SHfETTVJNRCk/PT3QXDHGKZVazZCPtc44xj6EUZY5UoW957dSBEYwOSc+mRvdx28m5wq7QY8BbemYQJa+HNPAprgORwcB2SV1nq0dgvd2ZqMu7GQKZpC0TsaYSwCqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLhNSrcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ABBC4CEC7;
	Tue,  8 Oct 2024 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728390531;
	bh=Q7N76+AWHNR7gMKRHOPlqluVHjC0C/n5Vfh5vNbLs0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLhNSrcNhO00FM0q1wt7KRdPE51L6lLHaBL0jHwDS4fwdblUUmY7ujpjp3ZjNf71U
	 /tYNjtuy9jbhOeLxjDpvmXinEvA5drNf7VAYOq7zomM4JKzDHCbstbABq0NOWdut0G
	 NByWG0LlycZe3TAJCksvVngcfv9lgmVFhGloEhIhBjmvbJjXDBEujBM7z9j6aWNmGY
	 lz/Ip/foaqJddMnzixm0U9Ypm0gte7az0Ck4Tn55erFI9teE8HyFGRexd8XYsKKcA0
	 g22PoiVAvz2CQWvtf/SRdGSlpmJI6AunbZbsBri2LM4lwXxHfAcIQ70LtqA/RiuPvk
	 fNlShXObS3dQA==
Date: Tue, 8 Oct 2024 13:28:45 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <20241008122845.GK32733@kernel.org>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
 <20241006065616.2563243-9-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006065616.2563243-9-dongml2@chinatelecom.cn>

On Sun, Oct 06, 2024 at 02:56:12PM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> new skb drop reasons are introduced for vxlan:
> 
> /* no remote found for xmit */
> SKB_DROP_REASON_VXLAN_NO_REMOTE
> /* packet without necessary metatdata reached a device is in "eternal"
>  * mode.
>  */
> SKB_DROP_REASON_TUNNEL_TXINFO

nit: metadata

     Flagged by checkpatch.pl --codespell

> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h

...

> @@ -439,11 +441,17 @@ enum skb_drop_reason {
>  	 * entry or an entry pointing to a nexthop.
>  	 */
>  	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
> +	/** @SKB_DROP_REASON_VXLAN_NO_REMOTE: no remote found for xmit */
> +	SKB_DROP_REASON_VXLAN_NO_REMOTE,
>  	/**
>  	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
>  	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
>  	 */
>  	SKB_DROP_REASON_IP_TUNNEL_ECN,
> +	/** @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metatdata
> +	 * reached a device is in "eternal" mode.
> +	 */
> +	SKB_DROP_REASON_TUNNEL_TXINFO,

nit: ./scripts/kernel-doc would like this to be formatted as follows.
     And metadata is misspelt.

	/**
	 * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metadata
	 * reached a device is in "eternal" mode.
	 */
	SKB_DROP_REASON_TUNNEL_TXINFO,

>  	/**
>  	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
>  	 * the MAC address of the local netdev.
> -- 
> 2.39.5
> 

