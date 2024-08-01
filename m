Return-Path: <netdev+bounces-114922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42261944AF3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6645A1C20CA0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511219DFBF;
	Thu,  1 Aug 2024 12:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2419FA99;
	Thu,  1 Aug 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514067; cv=none; b=maaxWtBh8AChaQl1h4gsOuGY2FGG/PYD4IionB6V4viPqBmzu19CofaVh+b1SKNXXnl14FnH0EvF0W9eQHoo+j3wqntwc0LU9ZAhNVhgOozwKP43ka08ggArZCgQmlsWoJK+9kveZDVt/AR4fKT4Lg3+ThfwSJzP/v0gZ4r7R5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514067; c=relaxed/simple;
	bh=S2Ld4zqVru1Eb6DBlUOEnlO22P6er1R3l65gmLzJn38=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hF3aVRNlaLc8R6x40WCRT2fPzBT8GdFcQ34FaEI3ud3MCF2O4gDpW6NWK6kU+4v1aWyxSDxMfkUnKl5RyuzfmGvF7F8KiHAchmZIY6xu5Z5JxEqII0VQmE2ximk40ZAPNwj2t5KuI8iceJk3U/doIi32sINeEazYo2ntNRuLqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WZSMM6cbYz6K9xx;
	Thu,  1 Aug 2024 20:05:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DE2A4140B2A;
	Thu,  1 Aug 2024 20:07:39 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 13:07:39 +0100
Date: Thu, 1 Aug 2024 13:07:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <admiyo@os.amperecomputing.com>
CC: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
	<matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Huisong
 Li <lihuisong@huawei.com>
Subject: Re: [PATCH v5 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20240801130738.00007563@Huawei.com>
In-Reply-To: <20240712023626.1010559-4-admiyo@os.amperecomputing.com>
References: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
	<20240712023626.1010559-4-admiyo@os.amperecomputing.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jul 2024 22:36:26 -0400
admiyo@os.amperecomputing.com wrote:

> From: Adam Young <admiyo@os.amperecomputing.com>
Hi Adam,

This will be fairly superficial because it's a while
since I last looked an mctp driver..

> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP) over
> Platform Communication Channel(PCC)

Oddly short line wrapping.  Aim for 75 chars limit.

> 
> DMTF DSP:0292
> 
> MCTP devices are specified by entries in DSDT/SDST and
> reference channels specified in the PCCT.
> 
> Communication with other devices use the PCC based
> doorbell mechanism.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

Various general comments inline.

Jonathan

> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..055d6408e1d7
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,325 @@

...

> +
> +#define MCTP_PAYLOAD_LENGTH	256
> +#define MCTP_CMD_LENGTH		4
> +#define MCTP_PCC_VERSION	0x1 /* DSP0253 defines a single version: 1 */
> +#define MCTP_SIGNATURE		"MCTP"
> +#define SIGNATURE_LENGTH	4
> +#define MCTP_HEADER_LENGTH	12
> +#define MCTP_MIN_MTU		68

Spec references good for this.

> +#define PCC_MAGIC		0x50434300
> +#define PCC_HEADER_FLAG_REQ_INT	0x1
> +#define PCC_HEADER_FLAGS	PCC_HEADER_FLAG_REQ_INT
> +#define PCC_DWORD_TYPE		0x0c
> +#define PCC_ACK_FLAG_MASK	0x1

This is defined in patch 1.

> +
> +struct mctp_pcc_hdr {
> +	u32 signature;
> +	u32 flags;
> +	u32 length;
> +	char mctp_signature[4];

Use the MCTP_SIGNATURE_LENGTH define to ensure these are kept in sync.

> +};

...

> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_dev;
> +	struct mctp_pcc_hdr mctp_pcc_hdr;

Use consistent naming. Not sure why it is mctp_pcc_hdr here and pcc_header
in the tx function.

> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	void *skb_buf;
> +	u32 data_len;
> +
> +	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->pcc_comm_inbox_addr,
> +		      sizeof(struct mctp_pcc_hdr));

sizeof(mctp_pcc_hdr)

> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_hdr pcc_header;
> +	struct mctp_pcc_ndev *mpnd;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +
> +	ndev->stats.tx_bytes += skb->len;
> +	ndev->stats.tx_packets++;
> +	mpnd = netdev_priv(ndev);

set at declaration.

> +
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	buffer = mpnd->pcc_comm_outbox_addr;
> +	pcc_header.signature = PCC_MAGIC | mpnd->hw_addr.outbox_index;
> +	pcc_header.flags = PCC_HEADER_FLAGS;
> +	memcpy(pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
> +	pcc_header.length = skb->len + SIGNATURE_LENGTH;
> +	memcpy_toio(buffer, &pcc_header, sizeof(struct mctp_pcc_hdr));

sizeof(pcc_header)

> +	memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
> +	mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan,
> +						    NULL);
> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +
> +	dev_consume_skb_any(skb);
> +	return NETDEV_TX_OK;
> +}
> +

...

> +static void  mctp_pcc_setup(struct net_device *ndev)
> +{
> +	ndev->type = ARPHRD_MCTP;
> +	ndev->hard_header_len = 0;
> +	ndev->addr_len = 0;
> +	ndev->tx_queue_len = 0;
> +	ndev->flags = IFF_NOARP;
> +	ndev->netdev_ops = &mctp_pcc_netdev_ops;
> +	ndev->needs_free_netdev = true;
> +}
> +
> +struct lookup_context {

prefix with mctp_pcct or similar.
Very high chance of a name clash in future on something called
simply lookup_context.


> +	int index;
> +	u32 inbox_index;
> +	u32 outbox_index;
> +};
> +
> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
prefix the function name as well.

> +				       void *context)
> +{
> +	struct acpi_resource_address32 *addr;
> +	struct lookup_context *luc = context;
> +
> +	switch (ares->type) {
> +	case PCC_DWORD_TYPE:
> +		break;
> +	default:
> +		return AE_OK;
> +	}
> +
> +	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
> +	switch (luc->index) {
> +	case 0:
> +		luc->outbox_index = addr[0].address.minimum;
> +		break;
> +	case 1:
> +		luc->inbox_index = addr[0].address.minimum;
> +		break;
> +	}
> +	luc->index++;
> +	return AE_OK;
> +}
> +
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct lookup_context context = {0, 0, 0};
> +	struct mctp_pcc_ndev *mctp_pcc_dev;
> +	struct net_device *ndev;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	struct device *dev;
> +	int mctp_pcc_mtu;
> +	int outbox_index;
> +	int inbox_index;
> +	char name[32];
> +	int rc;

I would take all registration device managed. It makes error handling
simpler and drops need for remove() function.

> +
> +	dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",

Use local dev variable (init that earlier)

> +		acpi_device_hid(acpi_dev));
> +	dev_handle = acpi_device_handle(acpi_dev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
With dev being set earlier as suggested below, use just dev here.

> +		return -EINVAL;
> +	}
> +	inbox_index = context.inbox_index;
> +	outbox_index = context.outbox_index;
> +	dev = &acpi_dev->dev;

Do this at declaration above.

> +
> +	snprintf(name, sizeof(name), "mctpipcc%d", inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
> +			    mctp_pcc_setup);
There are only devm versions of the more complex alloc_netdev (ethernet etc)
so best bet here probably to use
devm_add_action_or_reset() and a local bit of cleanup.

> +	if (!ndev)
> +		return -ENOMEM;
> +	mctp_pcc_dev = netdev_priv(ndev);
> +	spin_lock_init(&mctp_pcc_dev->lock);
> +
> +	mctp_pcc_dev->hw_addr.inbox_index = inbox_index;
> +	mctp_pcc_dev->hw_addr.outbox_index = outbox_index;
> +	mctp_pcc_dev->inbox_client.rx_callback = mctp_pcc_client_rx_callback;
> +	mctp_pcc_dev->out_chan =
> +		pcc_mbox_request_channel(&mctp_pcc_dev->outbox_client,
> +					 outbox_index);

> +	if (IS_ERR(mctp_pcc_dev->out_chan)) {
> +		rc = PTR_ERR(mctp_pcc_dev->out_chan);

with devm throughout, use
		return dev_err_probe() here and in 
other failure paths in probe() and functions only called from probe()

> +		goto free_netdev;
> +	}
Use a devm_add_action_or_reset() here as well


> +	mctp_pcc_dev->in_chan =
> +		pcc_mbox_request_channel(&mctp_pcc_dev->inbox_client,
> +					 inbox_index);
> +	if (IS_ERR(mctp_pcc_dev->in_chan)) {
> +		rc = PTR_ERR(mctp_pcc_dev->in_chan);
> +		goto cleanup_out_channel;
> +	}

And one here,

> +	mctp_pcc_dev->pcc_comm_inbox_addr =
> +		devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
> +			     mctp_pcc_dev->in_chan->shmem_size);

That will avoid ordering issues with the devm calls as we will know
that tear down will occur in opposite order to setup.
As it stands your netdev is registered long after you've ripped out
the stuff it uses.

> +	if (!mctp_pcc_dev->pcc_comm_inbox_addr) {
> +		rc = -EINVAL;
> +		goto cleanup_in_channel;
> +	}
> +	mctp_pcc_dev->pcc_comm_outbox_addr =
> +		devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
> +			     mctp_pcc_dev->out_chan->shmem_size);
> +	if (!mctp_pcc_dev->pcc_comm_outbox_addr) {
> +		rc = -EINVAL;
> +		goto cleanup_in_channel;
> +	}
> +	mctp_pcc_dev->acpi_device = acpi_dev;
> +	mctp_pcc_dev->inbox_client.dev = dev;
> +	mctp_pcc_dev->outbox_client.dev = dev;
> +	mctp_pcc_dev->mdev.dev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_dev;
I'd set all the simpler parts of this (ones without
allocations) in one block rather than some before and
some after hte allocations.


> +
> +	/* There is no clean way to pass the MTU
> +	 * to the callback function used for registration,
Wrap closer to 80 chars.

> +	 * so set the values ahead of time.
> +	 */
> +	mctp_pcc_mtu = mctp_pcc_dev->out_chan->shmem_size -
> +		sizeof(struct mctp_pcc_hdr);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	rc = register_netdev(ndev);
devm_register_netdev()
> +	if (rc)
> +		goto cleanup_in_channel;
> +	return 0;
> +
> +cleanup_in_channel:
> +	pcc_mbox_free_channel(mctp_pcc_dev->in_chan);
> +cleanup_out_channel:
> +	pcc_mbox_free_channel(mctp_pcc_dev->out_chan);
> +free_netdev:
> +	unregister_netdev(ndev);

mctp_unregster_netdev()
but all this and remove() below will go away if you follow
suggestion on devm throughout.
> +	free_netdev(ndev);
> +	return rc;
> +}
> +
> +static void mctp_pcc_driver_remove(struct acpi_device *adev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
> +
> +	pcc_mbox_free_channel(mctp_pcc_ndev->out_chan);
> +	pcc_mbox_free_channel(mctp_pcc_ndev->in_chan);
> +	mctp_unregister_netdev(mctp_pcc_ndev->mdev.dev);
No free_netdev()?  Anyhow, devm will handle all this so you won't
have a remove function at all when you are done with that conversion.

> +}
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001", 0},
Can skip setting the zero as C will do that for you anyway
an you don't care about the value.
Space before }

> +	{ "", 0},

{} should be sufficient and would be more common way of
terminating such a list.  Note no comma as we don't want to
ever add anything after it.



> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",

Perhaps one for Rafael, what should this be?

> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +		.remove = mctp_pcc_driver_remove,
> +	},
> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC device");

Stick ACPI in the description. 


> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");


