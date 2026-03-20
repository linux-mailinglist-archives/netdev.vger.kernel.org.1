Return-Path: <netdev+bounces-269835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMyrOCYEvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:24:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C42D72A5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D7B83013C5A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987A3596E1;
	Fri, 20 Mar 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv3J4Xhj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6C2E229F;
	Fri, 20 Mar 2026 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994703; cv=none; b=kl4qYvLRGem9YAUrmnAwo6ulmgcrJ2TmUEFs1JkRVUQ90/zjOPoWLIwV//NSvdauXn5duNeCqkan8/e4bGjxUXnZURhcGkTqXwaeFoK2Jz2jVFyJpK6+oiLBFsgPC+1FEfxRL5zA7JC19qaek4jMRYvRJAvIzAcBLk8XC5LgLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994703; c=relaxed/simple;
	bh=9b41iTS4OG966WaokYmFNHqr8n/b67tX64FFt9NLVnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cwbc9f+a/aagbtojjFSaRBWWIFqSmSCH1T21AedHbETHn6IaqlPG3K3qBw1CNtOsuKpt5pJ9Y5N2IjmYmDJD435AsBQ3SIRfMD95rheuhs/EIoevhQ8s+l7Kxht5dqxmrKIz8LZswZMYItYW9xLNQ9qUbxBS7IxO+uUZqBeoywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv3J4Xhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29712C4CEF7;
	Fri, 20 Mar 2026 08:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773994702;
	bh=9b41iTS4OG966WaokYmFNHqr8n/b67tX64FFt9NLVnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hv3J4Xhj8JDPfWKJ7XLL6mzggL3NIn6+j7OF8QISgqJFyy8z1beVI19oP8u3GMt00
	 jTYQVVk6+0sTZodA9fmoJHozPVpckB+bYmw+EJnt4OfPonFwZqo+put+hx0vtMCOpU
	 PEqBkqo/WnANMA/n8R6ec49nfplaApj7Euj9kBdoIJOzPOuY3MHBoXpaKZ3rMkGJI1
	 EjxxpFgofJ3leic/PoLye2EbGeJk1wc93p9CmOprEemRQQhOcPCYHuVmoZWXcVnMp4
	 iqleX8BGwalzsjp06acZuat/N72ZKm601pSidWObErzzUfBxV003eQixzR+G5v4VxN
	 oZYdbufx9FqYA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 3/8] ice: do not round up result of dbuf
 calculation for xsk pool
In-Reply-To: <20260319175538.479139-4-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-4-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:18:19 +0100
Message-ID: <87y0jmoqwk.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269835-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,all.your.base.are.belong.to.us:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE2C42D72A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> When programming dbuf on rx queue context, avoid division round up as
> it causes to actually corrupt the tailroom for AF_XDP ZC. Below is an
> example based on 4k chunk size when xsk pool pointer is valid on given
> rx ring:
>
> chunk_size = 4096
> headroom = 256
> tailroom = 320
>
> ring->rx_buf_len = 4096 - 256 - 320 = 3520
>
> rx_ctx.dbuf = DIV_ROUND_UP(3520, 128) ->
> 3520 / 128 = 27.5 -> round up results in 28
>
> dbuf programming unit is 128. If we give 128 * 28 = 3584. So HW will
> corrupt 64 bytes from tailroom. Decrement dbuf by 1 when xsk_pool is
> present on given ice_rx_ring.
>
> Also, restore ::rx_buf_len setting via xsk_pool_get_rx_frame_size() as
> of now it respects the tailroom.
>
> Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 1667f686ff75..f9514d7bb83c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -500,6 +500,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
>  	 */
>  	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
>  				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
> +	if (ring->xsk_pool)
> +		rlan_ctx.dbuf--;

Hmm, wont this be overly pessimistic? Smth like

  if (ring->xsk_pool)
    rlan_ctx.dbuf = ring->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
  // else round up?



