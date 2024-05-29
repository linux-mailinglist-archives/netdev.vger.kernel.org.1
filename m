Return-Path: <netdev+bounces-98850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1CA8D2B2C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 04:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA25A287311
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6515ADBB;
	Wed, 29 May 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr7aLzOu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113228E8;
	Wed, 29 May 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716950759; cv=none; b=PIGcwskIuQ+h3+zLUNK0LUBiXet8mmQZWTlcre8CDzFoqnYxU1KK1F3XeakoXnueXyVh7roaknIOrOzhf/sRJZxM+UNfgNh3XtPILcPYOxXhT+eC7KU0w+D+pcWoF5VA3ZPftHK8so51NqlZHNBDksOwX1QmaBO00D7zOpw6YRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716950759; c=relaxed/simple;
	bh=YNB+3eDBjI3xG8Rb1/MLEq3QCHjbZGBsVk7x/zHsfRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvl44gfpPylBIN6ATVbsTTJ2UZStW+lrWwLihHLFCpahLD4p2SpA+JA4sKvSDoHGYkVfQOE31ER2RZo3HIwqgPA2o4+hjt0BKVlEfGy3OMyTNMRabQS12f47j4VCbjy34zrR6g9xiT/GYEzCYU7LOnBUgUkDw1rEvCi9f2fHuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr7aLzOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9810FC3277B;
	Wed, 29 May 2024 02:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716950759;
	bh=YNB+3eDBjI3xG8Rb1/MLEq3QCHjbZGBsVk7x/zHsfRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cr7aLzOuZvv9maRdMkD+mou4kKjLCYDyTEGdehFO3Mniifm3DP26fooGwDqSL2FXK
	 wEF03DlOnkkt2iHPG4hK5/qUz/QRc96yd6JXBHYz8Iz7QU6lpNej1sWc8JK70t9IRU
	 kvbW8NW2QK3URk929xOEEzLsgRfnCovq0E4ZOpCtMScSyi/Tyl1A8nxmFed37glRSh
	 lAECehfRSCIu+q7VviTSZOsh7HzHIcZ85xdhjxEgJJ6ukecOOX5VD4XdR/K0zBSs9U
	 Se4r2TIdvHnps8Zv5Ex5IL0GeKuge9Vg35a5kX33z87cGxhGcVf+VaFF+B32ca6rE8
	 /kFNA90dKdt1A==
Date: Tue, 28 May 2024 19:45:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20240528194557.7a8f522d@kernel.org>
In-Reply-To: <20240528191823.17775-4-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
	<20240528191823.17775-1-admiyo@os.amperecomputing.com>
	<20240528191823.17775-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:18:23 -0400 admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@amperecomputing.com>
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

Missing your SoB, but please wait for more feedback before reposting.

> +#include <net/pkt_sched.h>

Hm, what do you need this include for?

> +#define SPDM_VERSION_OFFSET 1
> +#define SPDM_REQ_RESP_OFFSET 2
> +#define MCTP_PAYLOAD_LENGTH 256
> +#define MCTP_CMD_LENGTH 4
> +#define MCTP_PCC_VERSION     0x1 /* DSP0253 defines a single version: 1 */
> +#define MCTP_SIGNATURE "MCTP"
> +#define SIGNATURE_LENGTH 4
> +#define MCTP_HEADER_LENGTH 12
> +#define MCTP_MIN_MTU 68
> +#define PCC_MAGIC 0x50434300
> +#define PCC_DWORD_TYPE 0x0c

Could you align the values using tabs?

> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_dev;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	u32 length_offset;
> +	u32 flags_offset;
> +	void *skb_buf;
> +	u32 data_len;
> +	u32 flags;
> +
> +	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
> +	length_offset = offsetof(struct mctp_pcc_hdr, length);
> +	data_len = readl(mctp_pcc_dev->pcc_comm_inbox_addr + length_offset) +
> +		   MCTP_HEADER_LENGTH;
> +
> +	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
> +	if (!skb) {
> +		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
> +		return;
> +	}
> +	mctp_pcc_dev->mdev.dev->stats.rx_packets++;
> +	mctp_pcc_dev->mdev.dev->stats.rx_bytes += data_len;

Please implement ndo_get_stats64, use of the core dev stats in drivers
is deprecated:

 *	@stats:		Statistics struct, which was left as a legacy, use
 *			rtnl_link_stats64 instead

> +	skb->protocol = htons(ETH_P_MCTP);
> +	skb_buf = skb_put(skb, data_len);
> +	memcpy_fromio(skb_buf, mctp_pcc_dev->pcc_comm_inbox_addr, data_len);
> +	skb_reset_mac_header(skb);
> +	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	skb->dev =  mctp_pcc_dev->mdev.dev;

netdev_alloc_skb() already sets dev

> +	netif_rx(skb);
> +
> +	flags_offset = offsetof(struct mctp_pcc_hdr, flags);
> +	flags = readl(mctp_pcc_dev->pcc_comm_inbox_addr + flags_offset);
> +	mctp_pcc_dev->in_chan->ack_rx = (flags & 1) > 0;
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_hdr pcc_header;
> +	struct mctp_pcc_ndev *mpnd;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int rc;
> +
> +	netif_stop_queue(ndev);

Why?

> +	ndev->stats.tx_bytes += skb->len;
> +	ndev->stats.tx_packets++;
> +	mpnd = (struct mctp_pcc_ndev *)netdev_priv(ndev);
> +
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	buffer = mpnd->pcc_comm_outbox_addr;
> +	pcc_header.signature = PCC_MAGIC;
> +	pcc_header.flags = 0x1;
> +	memcpy(pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
> +	pcc_header.length = skb->len + SIGNATURE_LENGTH;
> +	memcpy_toio(buffer, &pcc_header, sizeof(struct mctp_pcc_hdr));
> +	memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
> +	rc = mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan,
> +							 NULL);
> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +
> +	dev_consume_skb_any(skb);
> +	netif_start_queue(ndev);
> +	if (!rc)
> +		return NETDEV_TX_OK;
> +	return NETDEV_TX_BUSY;
> +}
> +
> +static const struct net_device_ops mctp_pcc_netdev_ops = {
> +	.ndo_start_xmit = mctp_pcc_tx,
> +	.ndo_uninit = NULL

No need to init things to NULL

> +static void mctp_pcc_driver_remove(struct acpi_device *adev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_dev = NULL;
> +	struct list_head *ptr;
> +	struct list_head *tmp;
> +
> +	list_for_each_safe(ptr, tmp, &mctp_pcc_ndevs) {
> +		struct net_device *ndev;
> +
> +		mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, next);
> +		if (adev && mctp_pcc_dev->acpi_device == adev)
> +			continue;
> +
> +		mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
> +		mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
> +		ndev = mctp_pcc_dev->mdev.dev;
> +		if (ndev)
> +			mctp_unregister_netdev(ndev);
> +		list_del(ptr);
> +		if (adev)
> +			break;
> +	}
> +};

spurious ;


> +	.owner = THIS_MODULE,
> +

suprious new line

> +};
> +
-- 
pw-bot: cr

