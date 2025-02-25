Return-Path: <netdev+bounces-169272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BCA432DC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFE1189E339
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E570446426;
	Tue, 25 Feb 2025 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRC3M5Y+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F6440C;
	Tue, 25 Feb 2025 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449478; cv=none; b=m/nRznEA7HjDLH5dOkXiLlE9Hk/idkMJUE6k6m5sPpFE7rpB5khWQ1DNMBL3MsFZLrmN3xtM0xtE6ofjzfWK84KaP99RLVqvX0yjxqrpd2T88EqxqD+KCKb4oMbuM46Ob96+V0nDu8poNQxanTbno0YDvc9r5tYvnqFBuIgWK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449478; c=relaxed/simple;
	bh=d3eqK0aEkRk/IZn107FKcXpClMaxinMjhwGUee/i/5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iR1BZwfM+k4wDP1lFhe/SVytpq/e2HwtP5OsmCVIH4w94k/8DKMwkMqCcb4S6DZKE06RFQMLDex83LI+OLyGMYv37pAkSL5sdNUXMePVW0StXjwEeS0lwGa249JVMJJA4USQwVqWgMe9e86yUh/r/kt1/h3yckDtdT3Wd8LV1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRC3M5Y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27D6C4CED6;
	Tue, 25 Feb 2025 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740449478;
	bh=d3eqK0aEkRk/IZn107FKcXpClMaxinMjhwGUee/i/5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fRC3M5Y+t9/nvzMpC8jx+fdTA+d9imccbNLRSWaLasSEPLnjCwRa1LqvHwjhPdQxk
	 TUtDjoy/7WitBrjz3HKbaogjFj71kMjO4hjxEYwHSLKRBuSqudejeDVP/z6sHgE8xA
	 SP1hJwVLrd0Yh3E7qUKvoT7dNz/8A7xBWz6fdQ61bNOdUe6K8sBhbunju5qklHxden
	 90pbBWYEpHT614fdJztdXSFlWXGWaPUIm4xVEFa9CK4gFGq1eYpM1vD4qCUMsd5zhc
	 WBQf7wMxvuAl0Arfs7EkMhl1aJnuCstH+ud4OejEVq2eiGYlK2FatabSsZ4qAnJecH
	 hnMD3KkEPqc4A==
Date: Mon, 24 Feb 2025 18:11:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v18 1/1] mctp pcc: Implement MCTP over PCC
 Transport
Message-ID: <20250224181117.21ad7ab1@kernel.org>
In-Reply-To: <20250220183411.269407-2-admiyo@os.amperecomputing.com>
References: <20250220183411.269407-1-admiyo@os.amperecomputing.com>
	<20250220183411.269407-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 13:34:10 -0500 admiyo@os.amperecomputing.com wrote:
> +MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
> +M:	Adam Young <admiyo@os.amperecomputing.com>
> +L:	netdev@vger.kernel.org

You can drop the L:, AFAIK, it's going to be inherited from next layer
of entries.

> +S:	Maintained
> +F:	drivers/net/mctp/mctp-pcc.c
> +

> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr  *mctp_pcc_header;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +
> +	dev_dstats_tx_add(ndev, len);

To be safe you should call:

	if (skb_cow_head(skb, ..

to make sure skb isn't a clone.

> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
> +	buffer = mpnd->outbox.chan->shmem;
> +	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
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

> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0, 0, 0};
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
> +	//inbox initialization

Prefer C comments, please.

> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,

Enum means the kernel assigns the ID, you're fully formatting the name
in the driver based on fixed device attributes, so NET_NAME_PREDICTABLE

> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;

> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +cleanup_netdev:

rename the label to free_netdev, please, to match with the first action

> +	free_netdev(ndev);
> +	return rc;
> +}
-- 
pw-bot: cr

