Return-Path: <netdev+bounces-103712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7530909320
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBA31C21DE0
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C931487C1;
	Fri, 14 Jun 2024 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGmG8AsB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E19383
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395321; cv=none; b=VPNtZ6FVNLDhDwkDerTYFy+QwoR/iJcXp/VJXEKkGYs/4YYCZrTw1kJ5W/mctLnZFG2lvB7dJAUATNcZut3Yl95QqWhjocHPD99H3hgVFMe3x9C4fTPKawhBaEuhI0ngAeYqMC6//mqFXMQ8HvkHnTdJQPssaszz8lnTrHWaRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395321; c=relaxed/simple;
	bh=eiwo4S5OFzCIyaLZcpu5dUH2zdVHhRt8Cpnd0HGSwF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqXLYzdoCUwIFJCSMdz67ib8jFGNHzWBPwQyRKcH1B9sV5UPFNoA4f0D1KjlECMI21iV7eF5ri4get79z9+SsVFZNnEw2LK+BOw7HPuYlIOQt/5x3ftnz5pp+1pUYAyI/EGVg0m4GPi1jOtdgk1Na3N2oDddXJpuJ1aWxe5NeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGmG8AsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D044DC2BD10;
	Fri, 14 Jun 2024 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718395321;
	bh=eiwo4S5OFzCIyaLZcpu5dUH2zdVHhRt8Cpnd0HGSwF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGmG8AsBDlmZHjxbyBSSl6gGS/wSApHJtJ0nv/e+hyEgVul6izdPNiE+n4+JHvtUY
	 ZpWM1PUsL0o9PtUvhKnv6DIkaWQAFJueWc1zwMHgFVYwMtYgbP4iGx1zzCFoVOeNB7
	 6iVH4z5vaGJySwMwpXHUi/sF3iGqdWO46j89A/OAUEzEcZxIAbjDjzoJZ/rXHeXCe1
	 l6AIoAYht2lIKBcg9JpS0N0d7Mj+K8w0WzqsJ3j7tU9h3NGvFnA9Kz8cTF9CkVqZ4S
	 rSgM9syrh5N6YwLPRYgFWrYef7zMmVFBo37RrBuS/pc8W5FzCrIjY6gxzf05jQQvKV
	 1le5+O2AuU5kA==
Date: Fri, 14 Jun 2024 21:01:56 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/3] bnxt_en: split rx ring helpers out from
 ring helpers
Message-ID: <20240614200156.GX8447@kernel.org>
References: <20240611023324.1485426-1-dw@davidwei.uk>
 <20240611023324.1485426-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611023324.1485426-3-dw@davidwei.uk>

On Mon, Jun 10, 2024 at 07:33:23PM -0700, David Wei wrote:
> To prepare for queue API implementation, split rx ring functions out
> from ring helpers. These new helpers will be called from queue API
> implementation.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 302 ++++++++++++++--------
>  1 file changed, 195 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

...

> +static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
> +{
> +	struct bnxt_rx_ring_info *rxr;
> +	struct bnxt_ring_struct *ring;
> +
> +	rxr = &bp->rx_ring[ring_nr];
> +	ring = &rxr->rx_ring_struct;

Hi David,

A minor nit from my side.
ring is set but otherwise unused in this function.

Flagged by W=1 builds with gcc-13 and clang-18.

> +	bnxt_init_one_rx_ring_rxbd(bp, rxr);
> +
> +	netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
> +			     &rxr->bnapi->napi);
> +
> +	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
> +		bpf_prog_add(bp->xdp_prog, 1);
> +		rxr->xdp_prog = bp->xdp_prog;
> +	}
> +
> +	bnxt_init_one_rx_agg_ring_rxbd(bp, rxr);
>  
>  	return bnxt_alloc_one_rx_ring(bp, ring_nr);
>  }

...

