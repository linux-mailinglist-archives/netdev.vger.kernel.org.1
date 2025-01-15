Return-Path: <netdev+bounces-158507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A5A12425
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E505616933D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7852419EB;
	Wed, 15 Jan 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjMZT8RS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3C2419E3;
	Wed, 15 Jan 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736945461; cv=none; b=uq00q/0iJGFzUganUiA9GpTP7OFGxGB7lef3h4l1998PEjTpt0i8Zn2Pj2QDeXtdptvs4/nlrCgb/BETQjhBF+nEnDylKv1c3Wef259X1b8uMdflOLWlLovjBXPRpKaK3XqxmKMXVAT3NimH2oRJIlXaLlVAaURb0XcdsL4gMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736945461; c=relaxed/simple;
	bh=7qfNLhuzHQrHoK/3velqrvN0pWAzyUzeirGQf1QEOXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn71sUJVTxyHeFlY4WiqW8n+VMx5V7mvPfYaRRsbEDjAcRqBGWO6NRzC35+nAZIw9N3dfJwbQqtNolyBLdJTB//Y8SCXmC1sB7EZ0+z0CphaUKW5m/JYkmMY2JDymKZrCji+e0Sor2dqYGe6Tw6OVehhbVQ5LCGpp0MwYhhLTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjMZT8RS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B7DC4CEDF;
	Wed, 15 Jan 2025 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736945460;
	bh=7qfNLhuzHQrHoK/3velqrvN0pWAzyUzeirGQf1QEOXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjMZT8RS8BIfWr8DdIBlVpeyE4V/VXer1y4GgU84o/SNTnn2753GCOdS59swJpuGZ
	 p4wMQRQ4RKoGTHyTxRTQ1Zfo1CYDF9JHMvGjAcP0qVHynHe0bJC8FOr/ZA4sGxjOeO
	 XSQSwCmuLb6e4MAiR9pU3gvGTXT7yPSvIlGMYplJlQj13oT3OtQpUbo8iPoaAA8RFT
	 BCDwsUJFCasHwDGzIcddJ3kdDhZB/EMiJNazkeddQZSoj7nxYu8aXJxTL/oZzoLsgb
	 if5tFsMv4411ZaWN4ZAF5TNDXkCvM6Ul+rgQO+4gxzWt3r9YWwfMh7KyLbvTJbL4nl
	 s+LCjnDBfrRug==
Date: Wed, 15 Jan 2025 12:50:55 +0000
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
Subject: Re: [PATCH v14 1/1] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20250115125055.GN5497@kernel.org>
References: <20250114193112.656007-1-admiyo@os.amperecomputing.com>
 <20250114193112.656007-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114193112.656007-2-admiyo@os.amperecomputing.com>

On Tue, Jan 14, 2025 at 02:31:11PM -0500, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP) over
> Platform Communication Channel(PCC)
> 
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> 
> MCTP devices are specified via ACPI by entries
> in DSDT/SDST and reference channels specified
> in the PCCT.
> 
> Communication with other devices use the PCC based
> doorbell mechanism.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

...

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
> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	spin_lock_init(&mctp_pcc_ndev->lock);
> +
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
> +					 context.inbox_index);
> +	if (rc)
> +		goto cleanup_netdev;
> +	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
> +
> +	//outbox initialization
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
> +					 context.outbox_index);
> +	if (rc)
> +		goto cleanup_netdev;
> +
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->inbox.client.dev = dev;
> +	mctp_pcc_ndev->outbox.client.dev = dev;
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
> +		goto cleanup_netdev;
> +	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +	if (rc)
> +		goto cleanup_netdev;
> +return rc;


nit: the line above should be indented by one tab.

> +cleanup_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}

...

