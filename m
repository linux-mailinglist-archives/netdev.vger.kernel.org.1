Return-Path: <netdev+bounces-96133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBAB8C46D4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C01282203
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CA33CF1;
	Mon, 13 May 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHn6lwgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AA28FD;
	Mon, 13 May 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625076; cv=none; b=P743XS2riG5+8Bt1WVx9BHJpuCp3nGfI7r1tkrEjctZ7NcJ3QE0dVnJbdW3TddR/IgCV+sxOYmmC3herreV2vGxPKWZVDPOUMPjB5rm+9qvtfPDm9inJP4yh4+fGQ0vkxxybe+dxAZdrypkaFXBhvGg23bclZD5dK6GA/j/IbA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625076; c=relaxed/simple;
	bh=yiPqKMs6hQxmNLnb5Dok/TnU2Xk8ipFhsF5HYnfk6PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibf9sgk3gxQGSdoNHYWVeAYV5gHq1bp8CO09JIIBQBS+ECFQ8jX0gCouYEMLvBo+VTBgkRbp6EhUq1+3IHpXrktt3naK25XQTX0cxuG0H2Px/N/IjLgjHCJwMDH6MHSx5i8d47J0+Edmjj7pYG1cDf2xILwRSJ4YQZj+5IZo5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHn6lwgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC3BC113CC;
	Mon, 13 May 2024 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715625076;
	bh=yiPqKMs6hQxmNLnb5Dok/TnU2Xk8ipFhsF5HYnfk6PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHn6lwgo3XiPEhGFeYNrjQAhOgkT5qiId4xuuqPMf0DnZaqF1+ovN5KDgSeuLKejS
	 uKt3+DdS/Tg4xSzAuco3SweKKdvrpe3nnC68c8Gz/ySrJYzuUsOWdJXrqobCdGLPST
	 cjvyJxMkGkFY6uNXmku9PFMtWx0Ww371lHOfpnl7UX1/M8ibOexlrFBJBETHEAgJru
	 FlDVXWiYYnPnVJKQDS0uX5xcvQrdLhRg4vW9hrCW8nARDlW5hYm1Q8ScC/S+cfM0Ni
	 QUDCOgVE3dhXedZKKEscqs1rtGxpF8QfPpJIDqUFf0e2AntrJF7O5hdRH4a5yJBlj4
	 T3ctS789z/Xdg==
Date: Mon, 13 May 2024 19:31:11 +0100
From: Simon Horman <horms@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20240513183111.GV2787@kernel.org>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240513173546.679061-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513173546.679061-2-admiyo@os.amperecomputing.com>

On Mon, May 13, 2024 at 01:35:44PM -0400, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of DMTF DSP:0292
> Management Control Transport Protocol(MCTP)  over
> Platform Communication Channel(PCC)
> 
> MCTP devices are specified by entries in DSDT/SDST and
> reference channels specified in the PCCT.
> 
> Communication with other devices use the PCC based
> doorbell mechanism.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

Hi Adam,

Some minor feedback from my side.

...

> +static struct mctp_pcc_packet *mctp_pcc_extract_data(struct sk_buff *old_skb,
> +						     void *buffer, int outbox_index)
> +{
> +	struct mctp_pcc_packet *mpp;
> +
> +	mpp = buffer;
> +	writel(PCC_MAGIC | outbox_index, &mpp->pcc_header.signature);
> +	writel(0x1, &mpp->pcc_header.flags);
> +	memcpy_toio(mpp->pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
> +	writel(old_skb->len + SIGNATURE_LENGTH,  &mpp->pcc_header.length);
> +	memcpy_toio(mpp->header_data,    old_skb->data, old_skb->len);
> +	return mpp;
> +}
> +
> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *)

Please include a name for all function parameters.

Flagged by W=1 builds.

> +{
> +	struct sk_buff *skb;
> +	struct mctp_pcc_packet *mpp;
> +	struct mctp_skb_cb *cb;
> +	int data_len;
> +	unsigned long buf_ptr_val;

buf_ptr_val is assigned but otherwise unused.

Flagged by W=1 builds.

> +	struct mctp_pcc_ndev *mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
> +	void *skb_buf;

For Networking code please consider:

1. Using reverse xmas tree order - longest line to shortest - for local
   variable declarations.

   This tool can be of assistance: https://github.com/ecree-solarflare/xmastree

2. Restricting lines to 80 columns wide where this can be trivially achieved.

   ./scripts/checkpatch.pl --max-line-length=80

In this case, perhaps:

	struct mctp_pcc_ndev *mctp_pcc_dev;
	struct mctp_pcc_packet *mpp;
	struct mctp_skb_cb *cb;
	struct sk_buff *skb;
	void *skb_buf;
	int data_len;

	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);

> +
> +	mpp = (struct mctp_pcc_packet *)mctp_pcc_dev->pcc_comm_inbox_addr;
> +	buf_ptr_val = (unsigned long)mpp;
> +	data_len = readl(&mpp->pcc_header.length) + MCTP_HEADER_LENGTH;
> +	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
> +	if (!skb) {
> +		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
> +		return;
> +	}
> +	skb->protocol = htons(ETH_P_MCTP);
> +	skb_buf = skb_put(skb, data_len);
> +	memcpy_fromio(skb_buf, mpp, data_len);
> +	skb_reset_mac_header(skb);
> +	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	skb->dev =  mctp_pcc_dev->mdev.dev;
> +	netif_rx(skb);
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	unsigned char *buffer;
> +	struct mctp_pcc_ndev *mpnd;
> +	struct mctp_pcc_packet  *mpp;
> +	unsigned long flags;
> +	int rc;
> +
> +	netif_stop_queue(ndev);
> +	ndev->stats.tx_bytes += skb->len;
> +	mpnd = (struct mctp_pcc_ndev *)netdev_priv(ndev);
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	buffer =  mpnd->pcc_comm_outbox_addr;

buffer is assigned but otherwise unused in this function.

Flagged by W=1 builds.

> +	mpp = mctp_pcc_extract_data(skb, mpnd->pcc_comm_outbox_addr, mpnd->hw_addr.outbox_index);
> +	rc = mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan, mpp);
> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +
> +	dev_consume_skb_any(skb);
> +	netif_start_queue(ndev);
> +	if (!rc)
> +		return NETDEV_TX_OK;
> +	return NETDEV_TX_BUSY;
> +}

...

-- 
pw-bot: changes-requested

