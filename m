Return-Path: <netdev+bounces-146706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C594B9D52C6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 19:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5747F1F2146B
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D41B5829;
	Thu, 21 Nov 2024 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pWhZbz89"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968C200A3
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214978; cv=none; b=PcRJRbqDoMWj0dyQ1oNwqqffGFiUJ2q6TtfCWJjXh7ODyo7Pw2yiq6kHIyP8AWWcsn5/51Gh/afoYziNZcdzcfOC3Zoocye03w484rLMo6H8GpUyqgTJS4/g9OLxHHIjTEzQU12NP72L1zpcknqpmCpEa7e6Tx0aji644onYWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214978; c=relaxed/simple;
	bh=Wc0ZKcB3iv9MPXZcE0WjkapIvTRG8IXCHkhb9YPVfQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX2xMTs+lza14RGQ5PXKHidH3ZXQ6z40Qj59mstfZHxSlzpfTPBeKQL+ard9a48ADvb0kApfe0mGOfcGGhap45/LZXZylcMWmORWTRbP8yfIAmj8yWKC1cckOZRVoTslzkRKZAs3aMZe7o4AWIG2OD20RapG2Mki5KmbZuv3ROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pWhZbz89; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2128383b86eso12722245ad.2
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 10:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1732214975; x=1732819775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQMI0hSDvVmdQQ1OGP+fb8BXhpmdoFrOTrzPs1hsETI=;
        b=pWhZbz893dbf9r0P01WFGLbVEPpwOFVzrPaOy3V7xqNCKk4MKUEbgq2rE2h9sq7ugC
         Hs9GjU5fZCIZ/LbuCdV0GHkO/r9Gvk3YKTLBFrl7C765T1x0dEZxD36RmpZAlZeFTfsg
         FqgjlBEdrXt7Qmyl0kxedIzsKZFYNsb2Kp0ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214975; x=1732819775;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQMI0hSDvVmdQQ1OGP+fb8BXhpmdoFrOTrzPs1hsETI=;
        b=gnvD6z3/FcvkK04bhJ7TVS2LzGAu79je7nxYx8xZb+kCawSggXUC2U+m1RZ7o17ZJZ
         Bjr68KvSPNXhE/vn1vXPw5Xc1DUyS1W9AtFW3QENSltexDTeEKk8dcWRg3VQtiXYTOJ0
         694QDurd8ppAWLr1Z8haqTGoa0kiTpAUxnCBpHKsxHGTmkTQ+ScpYCuVBlJ+8Rfm68u/
         spJ270riLcZdmHBxRX3NPaoR3t+7s/XHtAMw2B8CWVjRBidEnwYa9ye0q77ORAT3osfZ
         b9gM6KXOyy67FE/f8xjBtMHWSrd/QNQOcEi3EIGfdjjUefNjAFu+cDKspoN6KdxAjQE0
         dwxw==
X-Forwarded-Encrypted: i=1; AJvYcCUiqzlTtb9ObCJsrgvWYaX+jEPJ2b0YEHMQ7zXNFS1MtGXqmUvDBeS2WgqzT0Q5636AYoDj1C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6vjx59qujIRbQEevC7wJ5KiDeAYNQRq62EBWnFN60w5l/lb7
	LQuxNYsLB0BAtNmpweeUZznFCYdpTzY877WlOKOzp1pCDyZv+CeRSESSvg4ngb4=
X-Gm-Gg: ASbGncvEeQD4VTLZmK0ckNsbw4w3hM4S13uKAXnN1D/srHGn3Gde27NdU1zhEQvT3Gu
	ZFohWGitCrZu/rX/F1pr6bulii1wpKatEB5coaVtkvkALj8cxCyjwZUxJUddxZRnP+xlQayW4Ys
	8egzsykMCvhwdZuFbTG36kVX192HVuR2/9xq/SQuwptOH/kiDvgP8iB6QfkeiEc9z4eGVtKYacP
	eGbaprGJa54uJf7i2XO6aU5K4kmcEiZOjWficqVC4aGB9nli2Ep4ydRSemRbeOy37CTjRBdYmGT
	9kX7Qk6YdT9De/2A
X-Google-Smtp-Source: AGHT+IEWdxqb7Z8B6G2oePuz9oXeL7SHrZGIzmst0Bh+eGzwmiufVjtTHE05ckkF2orkBNLRL1Pe8g==
X-Received: by 2002:a17:902:d4c8:b0:212:26e:cf9 with SMTP id d9443c01a7336-2129f3be7bemr962115ad.16.1732214975505;
        Thu, 21 Nov 2024 10:49:35 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c9a5sm1643585ad.46.2024.11.21.10.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:49:35 -0800 (PST)
Date: Thu, 21 Nov 2024 10:49:32 -0800
From: Joe Damato <jdamato@fastly.com>
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
Subject: Re: [PATCH v8 2/2] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <Zz-AvBwUgNzMJb7-@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	admiyo@os.amperecomputing.com,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
References: <20241120190216.425715-1-admiyo@os.amperecomputing.com>
 <20241120190216.425715-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120190216.425715-3-admiyo@os.amperecomputing.com>

FWIW, net-next is currently closed so this would have to be resent
once it has reopened:

https://lore.kernel.org/netdev/20241118071654.695bb1a2@kernel.org/

I don't know much about MCTP, so my apologies that my review is
mostly little nits and a question/comment about stats below.

I don't think any of these are worth holding this back, but since
net-next is closed this needs to be resent, maybe worth considering?

On Wed, Nov 20, 2024 at 02:02:15PM -0500, admiyo@os.amperecomputing.com wrote:
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
> ---
>  drivers/net/mctp/Kconfig    |  13 ++
>  drivers/net/mctp/Makefile   |   1 +
>  drivers/net/mctp/mctp-pcc.c | 321 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 335 insertions(+)
>  create mode 100644 drivers/net/mctp/mctp-pcc.c

[...]

It seems like below there are a few places where unnecessary double
spaces are included. Not necessarily a reason to hold this back, but
since net-next is closed and you need to resend anyway...

> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,321 @@

[...]

> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_dev;
> +	struct mctp_pcc_hdr mctp_pcc_hdr;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	void *skb_buf;
> +	u32 data_len;
> +
> +	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox.client);
> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_dev->inbox.chan->shmem,
> +		      sizeof(struct mctp_pcc_hdr));
> +	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
> +
> +	if (data_len > mctp_pcc_dev->mdev.dev->mtu) {
> +		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;

I'm not an expert on rtnl stats, but maybe this should be
accounted for as rx_length_errors ?

And when rx_dropped is accounted in the stats callback it can add
rx_length_errors in as well as setting rtnl_link_stats64's
rx_length_errors?

You've probably read this already, but just in case:

https://docs.kernel.org/networking/statistics.html#struct-rtnl-link-stats64

> +		return;
> +	}
> +
> +	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
> +	if (!skb) {
> +		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
> +		return;
> +	}
> +	mctp_pcc_dev->mdev.dev->stats.rx_packets++;
> +	mctp_pcc_dev->mdev.dev->stats.rx_bytes += data_len;
> +	skb->protocol = htons(ETH_P_MCTP);
> +	skb_buf = skb_put(skb, data_len);
> +	memcpy_fromio(skb_buf, mctp_pcc_dev->inbox.chan->shmem, data_len);
> +
> +	skb_reset_mac_header(skb);
> +	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	netif_rx(skb);
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr  *mctp_pcc_header;

Extra space after mctp_pcc_hdr ?

[...]

> +
> +static void  mctp_pcc_setup(struct net_device *ndev)

Extra space after void?

[...]

> +
> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct  mctp_pcc_lookup_context *luc = context;

extra space after struct ?

[...]

> +
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

I'm not sure but in net/ the general comment style seems to be /*
*/, I grepped around a bit and didn't notice many comments of this
style (except SPDX lines).

Maybe this should be a /* */ ?

> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	rc =  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);

extra space after = ?

> +	if (rc)
> +		goto cleanup_netdev;
> +	spin_lock_init(&mctp_pcc_ndev->lock);
> +
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
> +					 context.inbox_index);
> +	if (rc)
> +		goto cleanup_netdev;
> +	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
> +
> +	//outbox initialization

Same as above on comment style

