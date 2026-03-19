Return-Path: <netdev+bounces-269331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GpGEwapu2mnmQIAu9opvQ
	(envelope-from <netdev+bounces-269331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:43:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F212C7699
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D813C302003D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB893A1A2D;
	Thu, 19 Mar 2026 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6qJeTy8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9E3A0E85;
	Thu, 19 Mar 2026 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906005; cv=none; b=COa+mJSpsEzadflZOd0nFq/9kkifouxHnc4E3X0aS15DNvej88XZwXpTAWMkg+WZKBcZhsDWq5pvxY0z2QW3iXx61xHt/lkwHS2FtSOwKYD7uDCtSM148+BqRdxJFIlzrBshIb06ppcxlEg5zM1b/1BWIVCQFU1NlcnP54OiyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906005; c=relaxed/simple;
	bh=Z74b+Ki8cTKIwfzaeXDx3eFfRU4uHBqWlOReU6rQuXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm17j7GhvuMzESRPjETw/F0GtPsFUcmVJ/SClUhO22CvEMxDu05X8Cy7kNRCIKaf3uO0rGXwO0pXrFVwQxtbLJ7D0lOYpLbYGu2krWVWefFHN9DTqgkR1iaHdXiG8eOEP9VKOY0t2fnLYEpI3dPbL/nR6p6msGewAbVnyVitRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6qJeTy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90AFC2BCAF;
	Thu, 19 Mar 2026 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773906004;
	bh=Z74b+Ki8cTKIwfzaeXDx3eFfRU4uHBqWlOReU6rQuXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6qJeTy8jlGk5UNWYZ6/BoTiw8cC8A7kGOMxqb5QWpvcf8Ba84QWLlQzscM8dplu9
	 nKjWoazlxcjxvaRcev0EYrsBMvxk8EOvQERevxldPQmECA7o7YXvYsoJ9bewTs0agi
	 3fkCvYTForUN8O0fOMtF85mh5mZJLMHbXdK/5o0qyqdsyBtIZq9bZLJRxLl/FCmPi9
	 zfORXVJgSMa6LWND73DFcL6WwXDEZ08iDaL0EWvOxEVnzM/uNXSdgzN2l1Ly0fEa1L
	 I9pyr84eCEOBrgaCnKE2a9kT3RCGGVnDbpKOUkGFuw+DNf1OQrq7Kin6bQyjGnRQVE
	 LC4WcGjcSYFgQ==
Date: Thu, 19 Mar 2026 09:39:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v3 02/12] net: tso: Add tso_dma_map helpers
Message-ID: <20260319073959.GJ352386@unreal>
References: <20260318191325.1819881-1-joe@dama.to>
 <20260318191325.1819881-3-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318191325.1819881-3-joe@dama.to>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: A1F212C7699
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:13:07PM -0700, Joe Damato wrote:
> Adds skb_frag_phys() to skbuff.h, returning the physical address
> of a paged fragment's data, which is used by the tso_dma_map helpers
> introduced in this commit described below:
> 
> tso_dma_map_init(): DMA-maps the linear payload region and all frags
> upfront. Prefers the DMA IOVA API for a single contiguous mapping with
> one IOTLB sync; falls back to per-region dma_map_phys() otherwise.
> Returns 0 on success, cleans up partial mappings on failure.
> 
> tso_dma_map_cleanup(): Handles both IOVA and fallback teardown paths.
> 
> tso_dma_map_count(): counts how many descriptors the next N bytes of
> payload will need. Returns 1 if IOVA is used since the mapping is
> contiguous.
> 
> tso_dma_map_next(): yields the next (dma_addr, chunk_len) pair.
> On the IOVA path, each segment is a single contiguous chunk. On the
> fallback path, indicates when a chunk starts a new DMA mapping so the
> driver can set dma_unmap_len on that descriptor for completion-time
> unmapping.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  v3:
>    - Added skb_frag_phys helper include/linux/skbuff.h.
>    - Added tso_dma_map_use_iova() inline helper in tso.h.
>    - Updated the helpers to use the DMA IOVA API and falls back to per-region
>      mapping instead.
> 
>  include/linux/skbuff.h |  11 ++
>  include/net/tso.h      |  21 ++++
>  net/core/tso.c         | 274 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 9cc98f850f1d..d8630eb366c5 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3758,6 +3758,17 @@ static inline void *skb_frag_address_safe(const skb_frag_t *frag)
>  	return ptr + skb_frag_off(frag);
>  }
>  
> +/**
> + * skb_frag_phys - gets the physical address of the data in a paged fragment
> + * @frag: the paged fragment buffer
> + *
> + * Returns: the physical address of the data within @frag.
> + */
> +static inline phys_addr_t skb_frag_phys(const skb_frag_t *frag)
> +{
> +	return page_to_phys(skb_frag_page(frag)) + skb_frag_off(frag);
> +}

I skimmed through the patch and it looks generally correct to me. The one
thing that disappointed me is this function. It's unfortunate that you
have to implement it this way and cannot rely on phys_addr_t directly.

Thanks

