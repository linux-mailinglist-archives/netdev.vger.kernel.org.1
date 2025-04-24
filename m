Return-Path: <netdev+bounces-185472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE4A9A93A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF92188B92F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0310F1D516F;
	Thu, 24 Apr 2025 09:58:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2FD528;
	Thu, 24 Apr 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488680; cv=none; b=OZ1Rny5m4tf4RtXMZr0PcNQbj+yxxeKAsDMsBrO7XS6rekNo0dQbOcLFMDBzGb1B36CQbhDU3Wi5CVc67zV4hYlWcAUFRTJCyCLJfVuO7PXavvOD9a66Uw1I3iUAlYLdPDgcIeb5xj7UqQGttbUsXCVmyGcxRvRSrX4zXtUA4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488680; c=relaxed/simple;
	bh=X8NiDrNs8HDQF1N5ISic7R5uPwBw+A62TPPaXMb50fw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dY085wn1wbwUbAZFZ+iVGuX5dTTN5Lzo4d+UmcwbHdBNXVfvw/8ZUrc1gQorYw+LJc2HzQNpg0gP5InW8V26ZYEqKNOe+lJUOZHJVGCC2EkqXzcKu2ey1h/2/1z3wTQeDXDD0s4IuruA7KC0EMuRE9IxZEkgTXSLia/KfhYVBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjrvr3ztTz6L5Gb;
	Thu, 24 Apr 2025 17:56:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EE7E140519;
	Thu, 24 Apr 2025 17:57:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 11:57:53 +0200
Date: Thu, 24 Apr 2025 10:57:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <admiyo@os.amperecomputing.com>
CC: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
	<matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
Message-ID: <20250424105752.00007396@huawei.com>
In-Reply-To: <20250423220142.635223-2-admiyo@os.amperecomputing.com>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
	<20250423220142.635223-2-admiyo@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 23 Apr 2025 18:01:42 -0400
admiyo@os.amperecomputing.com wrote:

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
> in the PCCT.
> 
> Communication with other devices use the PCC based
> doorbell mechanism.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
Hi Adam,

Sorry it's been a while since I last looked at this.

Anyhow, some fairly general feedback inline.  All minor stuff.
With that tidied up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  MAINTAINERS                 |   5 +
>  drivers/net/mctp/Kconfig    |  13 ++
>  drivers/net/mctp/Makefile   |   1 +
>  drivers/net/mctp/mctp-pcc.c | 317 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 336 insertions(+)
>  create mode 100644 drivers/net/mctp/mctp-pcc.c

> new file mode 100644
> index 000000000000..589ba4387ce6
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,317 @@

> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr *mctp_pcc_header;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +	int rc;
> +
> +	rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
> +	if (rc)
> +		goto err_drop;
> +
> +	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));

I'd use sizeof(*mctp_pcc_header) for these to avoid the reader needing to check
types. There are a bunch of these you could do the same with to slightly
improve readability.

> +	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
> +	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
> +	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
> +	       MCTP_SIGNATURE_LENGTH);
> +	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
> +
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	buffer = mpnd->outbox.chan->shmem;
> +	memcpy_toio(buffer, skb->data, skb->len);
> +	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
> +							NULL);

Slightly odd alignment.  One extra space?

> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +
> +	dev_dstats_tx_add(ndev, len);
> +	dev_consume_skb_any(skb);
> +	return NETDEV_TX_OK;
> +err_drop:
> +	dev_dstats_tx_dropped(ndev);
> +	kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}

> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct mctp_pcc_lookup_context *luc = context;
> +	struct acpi_resource_address32 *addr;
> +
> +	switch (ares->type) {
> +	case PCC_DWORD_TYPE:
If unlikely we will ever care about other types could simpilfy to
	if (ares->type != PCC_DWORD_TYPE)
		return AE_OK;

	etc

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


> +static int mctp_pcc_initialize_mailbox(struct device *dev,
> +				       struct mctp_pcc_mailbox *box, u32 index)
> +{
> +	int ret;
> +
> +	box->index = index;
> +	box->chan = pcc_mbox_request_channel(&box->client, index);
as below
	box->client.dev = dev;

> +	if (IS_ERR(box->chan))
> +		return PTR_ERR(box->chan);
I'd put a blank line here...
> +	ret = devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
> +	if (ret)
> +		return -EINVAL;
And here.

Why eat ret?  Which incidentally is normally -ENOMEM for these.
Why not the simpler
	return devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);


> +	return 0;
> +}
> +
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0, 0, 0};

I'd be tempted to use simply {} or { 0 } so that if we have
extra context in future we aren't somehow implying it should not be
intialized to zero (as it will happen anyway).

> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct device *dev = &acpi_dev->dev;
> +	struct net_device *ndev;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	int mctp_pcc_mtu;
> +	char name[32];
> +	int rc;
> +
> +	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
> +		acpi_device_hid(acpi_dev));
> +	dev_handle = acpi_device_handle(acpi_dev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
> +		return -EINVAL;
> +	}
> +
> +	/* inbox initialization */
> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
> +			    mctp_pcc_setup);

I'd use sizeof(*mctp_pcc_ndev) so we don't have to bother checking types...

> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	spin_lock_init(&mctp_pcc_ndev->lock);
> +
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
> +					 context.inbox_index);

I think this should be responsible for all the setup of inbox. So that
includes setting inbox.client.dev as set below.

> +	if (rc)
> +		goto free_netdev;
> +	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
> +
> +	/* outbox initialization */
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
> +					 context.outbox_index);

Same as for inbox.

> +	if (rc)
> +		goto free_netdev;
> +
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->inbox.client.dev = dev;
> +	mctp_pcc_ndev->outbox.client.dev = dev;

As above. I think these should be part of the initialize_mailbox calls
given they are part of the mailboxes and we are passing in dev anyway.

> +	mctp_pcc_ndev->mdev.dev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_ndev;
> +
> +	/* There is no clean way to pass the MTU to the callback function
> +	 * used for registration, so set the values ahead of time.
> +	 */
> +	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
> +		sizeof(struct mctp_pcc_hdr);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	/* ndev needs to be freed before the iomemory (mapped above) gets
> +	 * unmapped,  devm resources get freed in reverse to the order they
> +	 * are added.
> +	 */
> +	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
> +	if (rc)
> +		goto free_netdev;
> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +free_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001"},

Bracket before } for consistency of spacing.

> +	{}
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +	},
> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");


