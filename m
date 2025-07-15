Return-Path: <netdev+bounces-207157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DF4B060FC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209895A1ABB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D528A1C4;
	Tue, 15 Jul 2025 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSbq2+vo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CE2746A;
	Tue, 15 Jul 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588491; cv=none; b=mEMhpXUMt+umtX0v0jilCBk+5BtPCHT0+VB1g1FzQuMOKl/eKCo5IA2qpazg5nFPzXFsswjCHUTcEasuG/MtkSL8oDYkpZgEQ7kpWv8gBVdpyzIqk0+tyWfGKfltQHOAWh3xFT9px8Edl842nUntMS9SrLLxkn9bVGNDEi/5Wv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588491; c=relaxed/simple;
	bh=5y8izVHmuwxYOWtoR6LzYD6G7YtB3g2aIkDCsDooNTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3z8F9FtgSc4f82LsCxrBuXkfUIeQa1WZyoRnQdINNhcvHK2oPi/TKS5mRHQGkR2a3kqOCvxNAzWWw6/qc3ZfQWFIuiDgUI26JPGKMbmJ9P38Kj8xbce2WamwEkGL6Se6aviH6qP13RU9b+kqTCUCYMPLOdwQnEZ2N/selbP3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSbq2+vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADDBC4CEE3;
	Tue, 15 Jul 2025 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752588489;
	bh=5y8izVHmuwxYOWtoR6LzYD6G7YtB3g2aIkDCsDooNTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSbq2+vo85eed8+IacB0mvMHcUUQaN3liu0GDoSAvDZHU8iXSc1JcjLXnMYU1++d0
	 luHKbweDZSqQTvxrUjywbqWdivPZs861R784fWWUTrCePeLCxTJdhQmMVLGExnGf3+
	 9ehVDb/gNK0ICSiZmS1/L7zOtLM4ItSozL7lzmR2T/lj6WUJ7Rb0gLBa0fWoqGt9LF
	 /aM6X8dbxsXzQTbOXo1BN42yBDRKkdRqFx3ONhG7jmKwne7vXT2EZ5qFe9NvyexYL5
	 ZwjpnL47rHHHrvb6HJM9nX3oMwHzksXR+ySb0tAbfP3tsqn9MdfTbSLUFfRymiAr+T
	 Li/bGlxO8yuzg==
Date: Tue, 15 Jul 2025 15:08:05 +0100
From: Simon Horman <horms@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v23 2/2] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20250715140805.GA721198@horms.kernel.org>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715001011.90534-3-admiyo@os.amperecomputing.com>

On Mon, Jul 14, 2025 at 08:10:08PM -0400, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)
> 
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/\
> DSP0292_1.0.0WIP50.pdf
> 
> MCTP devices are specified via ACPI by entries
> in DSDT/SDST and reference channels specified
> in the PCCT.  Messages are sent on a type 3 and
> received on a type 4 channel.  Communication with
> other devices use the PCC based doorbell mechanism;
> a shared memory segment with a corresponding
> interrupt and a memory register used to trigger
> remote interrupts.
> 
> This driver takes advantage of PCC mailbox buffer
> management. The data section of the struct sk_buff
> that contains the outgoing packet is sent to the mailbox,
> already properly formatted  as a PCC message.  The driver
> is also reponsible for allocating a struct sk_buff that

responsible

> is then passed to the mailbox and used to record the
> data in the shared buffer. It maintains a list of both
> outging and incoming sk_buffs to match the data buffers
> with the original sk_buffs.
> 
> When the Type 3 channel outbox receives a txdone response
> interrupt, it consumes the outgoing sk_buff, allowing
> it to be freed.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

...

> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c

...

> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct pcc_header *pcc_header;
> +	int len = skb->len;
> +	int rc;
> +
> +	rc = skb_cow_head(skb, sizeof(*pcc_header));
> +	if (rc) {
> +		dev_dstats_tx_dropped(ndev);
> +		kfree_skb(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	pcc_header = skb_push(skb, sizeof(*pcc_header));
> +	pcc_header->signature = cpu_to_le32(PCC_SIGNATURE | mpnd->outbox.index);
> +	pcc_header->flags = cpu_to_le32(PCC_CMD_COMPLETION_NOTIFY);
> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
> +	pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);

Hi Adam,

There seems to be an endian missmatch here: host order values
are being converted to little endian values and then
assigned to host endian variables.

Sparse says:

  .../mctp-pcc.c:146:31: warning: incorrect type in assignment (different base types)
  .../mctp-pcc.c:146:31:    expected unsigned int [usertype] signature
  .../mctp-pcc.c:146:31:    got restricted __le32 [usertype]
  .../mctp-pcc.c:147:27: warning: incorrect type in assignment (different base types)
  .../mctp-pcc.c:147:27:    expected unsigned int [usertype] flags
  .../mctp-pcc.c:147:27:    got restricted __le32 [usertype]
  .../mctp-pcc.c:149:28: warning: incorrect type in assignment (different base types)
  .../mctp-pcc.c:149:28:    expected unsigned int [usertype] length
  .../mctp-pcc.c:149:28:    got restricted __le32 [usertype]

> +	skb_queue_head(&mpnd->outbox.packets, skb);
> +
> +	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
> +
> +	if (rc < 0) {
> +		skb_unlink(skb, &mpnd->outbox.packets);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	dev_dstats_tx_add(ndev, len);
> +	return NETDEV_TX_OK;
> +}

...

> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{

...

> +	/* ndev needs to be freed before the iomemory (mapped above) gets
> +	 * unmapped,  devm resources get freed in reverse to the order they
> +	 * are added.
> +	 */
> +	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);

nit: please line wrap to 80 columbs wide or less:

	rc = mctp_register_netdev(ndev, &mctp_netdev_ops,
				  MCTP_PHYS_BINDING_PCC);

> +	if (rc)
> +		goto free_netdev;
> +
> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +free_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}

...

pw-bot: changes-requested

