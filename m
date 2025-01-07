Return-Path: <netdev+bounces-155813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F04A03E41
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4773162DD4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE71DFE3D;
	Tue,  7 Jan 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxXk18+j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23BE8C1E;
	Tue,  7 Jan 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250753; cv=none; b=frxC1C9KqL5/Kgk6ssD3+R4xCB+gu6Q0YHhLlY7hCPJJl25vBrn4sW/VriNMcIAlYMB86ik1dgUX8M7s5eUmRAauUyNfStUapZydLYhcO7vl0ef2j9ehs+GX6jxArXOybBO0gA6jfUfGM/30DIGeMlPV/aR+q+nCuuZVDze62kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250753; c=relaxed/simple;
	bh=dPx4UuLThLb85CHF98UhStjY3oscZApBLHT+9QKghkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM6XwupNGQxVf11wyU8RcvG56NsfOvGamKlHh+R52Tb+faS/qpHkRo4WBubhB0Wh7QzwcEh9GwEW680N/n6xqdhX0kBIcdaVMGtp2pwua1MZn+CIqolIp7hhapVYdU2oqYkjhxbAqX9JAuauU3p2x1cuvoieDJCWfz+GHeMoADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxXk18+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B9BC4CED6;
	Tue,  7 Jan 2025 11:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250752;
	bh=dPx4UuLThLb85CHF98UhStjY3oscZApBLHT+9QKghkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxXk18+jOM+pnhomtvgysUTeEiQNCKMMDUMR50E77HwODKq8iFx3LWY/R11Z0naH0
	 0ComnCTdecdELpIplf7ht27oeVMA4vvD/FEaNkBgb41bRUiBvZODdzOCWV5vGPnBFK
	 mD1zh0msWb8BdpdvRNtaojQT0z2yA1YaixM1GpSUlulMq1WD/9NsNZzlWK4kmPXVcS
	 6IEQPx5EvWQSnz+4MvdH/Du5aQoYoxiL8qiGlAucci3nwUU6z2i9N4+fNrcW8L4Vq8
	 PUro05iugGh3r3vpW2zE6XKFBIO/6lON4E4fahp2bM51bBNZzukBs3LIiB7EfzgWM+
	 tRu0MWuwtNenA==
Date: Tue, 7 Jan 2025 11:52:27 +0000
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
Subject: Re: [PATCH v12 1/1] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20250107115227.GH33144@kernel.org>
References: <20250106192458.42174-1-admiyo@os.amperecomputing.com>
 <20250106192458.42174-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106192458.42174-2-admiyo@os.amperecomputing.com>

On Mon, Jan 06, 2025 at 02:24:57PM -0500, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP) over
> Platform Communication Channel(PCC)
> 
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> 
> MCTP devices are specified by entries in DSDT/SDST and
> reference channels specified in the PCCT.
> 
> Communication with other devices use the PCC based
> doorbell mechanism.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

...

> +#define MCTP_PAYLOAD_LENGTH     256
> +#define MCTP_CMD_LENGTH         4
> +#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
> +#define MCTP_SIGNATURE          "MCTP"
> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
> +#define MCTP_HEADER_LENGTH      12
> +#define MCTP_MIN_MTU            68
> +#define PCC_MAGIC               0x50434300
> +#define PCC_HEADER_FLAG_REQ_INT 0x1
> +#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
> +#define PCC_DWORD_TYPE          0x0c
> +
> +struct mctp_pcc_hdr {
> +	__le32 signature;
> +	__le32 flags;
> +	__le32 length;
> +	char mctp_signature[MCTP_SIGNATURE_LENGTH];
> +};
> +
> +struct mctp_pcc_mailbox {
> +	u32 index;
> +	struct pcc_mbox_chan *chan;
> +	struct mbox_client client;
> +};
> +
> +/* The netdev structure. One of these per PCC adapter. */
> +struct mctp_pcc_ndev {
> +	/* spinlock to serialize access to PCC outbox buffer and registers
> +	 * Note that what PCC calls registers are memory locations, not CPU
> +	 * Registers.  They include the fields used to synchronize access
> +	 * between the OS and remote endpoints.
> +	 *
> +	 * Only the Outbox needs a spinlock, to prevent multiple
> +	 * sent packets triggering multiple attempts to over write
> +	 * the outbox.  The Inbox buffer is controlled by the remote
> +	 * service and a spinlock would have no effect.
> +	 */
> +	spinlock_t lock;
> +	struct mctp_dev mdev;
> +	struct acpi_device *acpi_device;
> +	struct mctp_pcc_mailbox inbox;
> +	struct mctp_pcc_mailbox outbox;
> +};

...

> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr  *mctp_pcc_header;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +
> +	dev_dstats_tx_add(ndev, len);
> +
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
> +	buffer = mpnd->outbox.chan->shmem;
> +	mctp_pcc_header->signature = PCC_MAGIC | mpnd->outbox.index;

Hi Adam,

The type of mctp_pcc_header->signature is __le32.
However it is being assigned a host byte order value.
Perhaps this should be:

	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC |
						 mpnd->outbox.index);

Flagged by Sparse.

> +	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
> +	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
> +	       MCTP_SIGNATURE_LENGTH);
> +	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
> +
> +	memcpy_toio(buffer, skb->data, skb->len);
> +	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
> +						    NULL);
> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +
> +	dev_consume_skb_any(skb);
> +	return NETDEV_TX_OK;
> +}

...

-- 
pw-bot: changes-requested

