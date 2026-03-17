Return-Path: <netdev+bounces-268502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBVKGycfuWmergEAu9opvQ
	(envelope-from <netdev+bounces-268502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B622A6BFE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1E5131C8BB6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861D839E6F3;
	Tue, 17 Mar 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSfc2nfN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C239E6CD;
	Tue, 17 Mar 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739323; cv=none; b=t3bal63pv2PkVxTaX0pyMC4ARwzlcM+Xa7ewkkJbRzDPPBbsXR7pX8iEypi3KbvfgzlwMLoT3m/wU0VPCYPoGQlxRVM3o5OAAckrqbACZdz+VX49xmgnHNgPEO4dQAFNODty9/CGIuJw9RA+m9J0BEbvOgnqIi4rj8GNF7ZsoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739323; c=relaxed/simple;
	bh=ueAhdp4tIHhCQVgD0oB2O2iTQqI8695/Qx3UsIztXqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URmO5mut+AW3vUSZzovmfB1YF1m9T1Zvu/8OEIsk12f7pGQ7gIgJInHtwkwQTMWjaeW2zOr5ZuoQmW4L3ET1cG8KSlJLCKNviOPlr663NT3dyJS7aRVE3Us3dI6a4Tu+9y7PTTHwlKflrE8O4dF361mAjC8ukEPL4IysaYCVxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSfc2nfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ABAC4CEF7;
	Tue, 17 Mar 2026 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739323;
	bh=ueAhdp4tIHhCQVgD0oB2O2iTQqI8695/Qx3UsIztXqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XSfc2nfN1pUb8Za65N1v6ExlFeQTj29OUZdclKT+atJVDFdPhemhdv0S9z1/RA8L/
	 COXZOIZxzB7I6ewzXxm9ydbsvlEWfhn4OHyO17gkVMRj8QkG2MuXjeN2KsTC0lG2fT
	 FovHfT/g6UCUfMf7EW6E8gBJxenrOg5OHpm/k2LmQVDP+QD+OFCSwrQRGYbYmPAPXB
	 hQWysUr5xEovn1VjcQjH7S9emU3h0V2zefOz+7f/lAZTk/6OuWGwG4c40a0DhVHDK9
	 hq+niRpmv0m+ss5zQz+rBOMXN4FHWPUJrnnbbQ1MptuvNapvYD+VISECnrQXstoAYX
	 UYvDTyvGhoAHw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 3/6] i40e: do not round up result of dbuff
 calculation for xsk pool
In-Reply-To: <20260316174550.462177-4-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-4-maciej.fijalkowski@intel.com>
Date: Tue, 17 Mar 2026 10:21:59 +0100
Message-ID: <87zf46q094.fsf@all.your.base.are.belong.to.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268502-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,all.your.base.are.belong.to.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4B622A6BFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> When programming dbuff on rx queue context, avoid division round up as
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
> rx_ctx.dbuff = DIV_ROUND_UP(3520, 128) ->
> 3520 / 128 = 27.5 -> round up results in 28
>
> dbuff programming unit is 128. If we give 128 * 28 = 3584. So HW will
> corrupt 64 bytes from tailroom. Doing plain division will floor the
> result and would not exceed reserved space at the end.
>
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 926d001b2150..f37cf6ab4461 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3621,9 +3621,11 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>  skip:
>  	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
>  
> -	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
> -				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
> -
> +	if (ring->xsk_pool)
> +		rx_ctx.dbuff = ring->rx_buf_len / BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT);
> +	else
> +		rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
> +					    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));

Same nit as ice.

