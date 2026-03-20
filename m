Return-Path: <netdev+bounces-269998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO9XMwqFvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-269998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:34:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED42DEB52
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5364030097C7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EDA3D0905;
	Fri, 20 Mar 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx3m6l6/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167728A3F8
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027644; cv=none; b=eUPUcnYuV2guY4yS1dqY6j4WE8aaycByGf72GFKaUvvAfSRUFxcIXeS8qRsxa+4BQMJyMqcUnf0VxVhO807/1M3/xEBZ0zNQW4YCgRCbJQxesim/FNOJt+Hc05kTvViF7JJ94fCDG7CW2ED1wH9oo9so0PVbp+Ii4Lr+9GwoaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027644; c=relaxed/simple;
	bh=atA9SOLi40jkAniq9L+icqpeBB20TM6KqWboIHFbF6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoeAK3BWBN7gJtsVFBvR4smsQUcuternrW8Fa9Y+GNV7XLlmlFW0c2TzB0I2s+obFnFzpHHwJCk5xH1zqgKM1RFUTOu/76hHfrRD5SgUP+FQ9eZRHqRd6n8cYhtkX0MNWTXud5DvAR0u9COkQ9OysFJ4Ki0G+LicKo7EFJkCBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx3m6l6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F89EC4CEF7;
	Fri, 20 Mar 2026 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774027644;
	bh=atA9SOLi40jkAniq9L+icqpeBB20TM6KqWboIHFbF6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tx3m6l6/Tg9TpKzvr4cR1mSUJDCLGNm6V9xZnquQ74jlTvuInhiwhH6qNSkvwioxJ
	 R5rbOl657GVnKSWTa9gOWYsGIlhRfP0wZml+QxnT+mJeL0QiOTaf74BqO1+CN7Iw1D
	 Q3PHh1ZZdQ1wozfgmrbO8x2frIR5fsMpi7i/nHfn+0pwlCEP0Vbe++iOiQk6m8Cig7
	 fS4L9r7tor1e90NOLHdOxhMfwDM+EAwX2I0ME+uhUXXqRDxCHMY0ajtc+ENBgV4Vsn
	 b1of7esejU5ch+lIWcfxEjlwRRDs549/UjX3K3yyuFwozItdTwmndMscxvBeKp2Br+
	 MjLZoUuzK5Ucg==
Date: Fri, 20 Mar 2026 17:27:20 +0000
From: Simon Horman <horms@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ti: icssg-prueth: fix use-after-free of CPPI
 descriptor in RX path
Message-ID: <20260320172720.GE74886@horms.kernel.org>
References: <20260319181236.14526-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319181236.14526-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269998-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BED42DEB52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 06:12:36PM +0000, David Carlier wrote:
> cppi5_hdesc_get_psdata() returns a pointer into the CPPI descriptor.
> In both emac_rx_packet() and emac_rx_packet_zc(), the descriptor is
> freed via k3_cppi_desc_pool_free() before the psdata pointer is used
> by emac_rx_timestamp(), which dereferences psdata[0] and psdata[1].
> This constitutes a use-after-free on every received packet that goes
> through the timestamp path.
> 
> Defer the descriptor free until after all accesses through the psdata
> pointer are complete. For emac_rx_packet(), this means freeing in each
> early-exit path and after emac_rx_timestamp() in the success path. For
> emac_rx_packet_zc(), move the free to the end of the loop body after
> emac_dispatch_skb_zc() (which calls emac_rx_timestamp()) has returned.
> 
> Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c

...

> @@ -1057,7 +1057,6 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
>  	/* firmware adds 4 CRC bytes, strip them */
>  	pkt_len -= 4;
>  	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
> -	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>  
>  	/* if allocation fails we drop the packet but push the
>  	 * descriptor back to the ring with old page to prevent a stall
> @@ -1066,6 +1065,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
>  	if (unlikely(!new_page)) {
>  		new_page = page;
>  		ndev->stats.rx_dropped++;
> +		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>  		goto requeue;

Hi David,

I am sorry for not noticing this earlier.

It seems to me that with this patch k3_cppi_desc_pool_free()
is always called before the requeue label is reached.

Would it make sense to move the call to k3_cppi_desc_pool_free()
into the requeue label? Or does it need to be called earlier
than that in the non-goto case?

>  	}
>  

...

