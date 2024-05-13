Return-Path: <netdev+bounces-96150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC538C480B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330911F22B38
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE97CF25;
	Mon, 13 May 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="svcateWi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3417BB12;
	Mon, 13 May 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630911; cv=none; b=tDMpGrxEq+O5/bgY7ZtE3Bn10U8AOP+voPHU6d/VrAVF71bL2F6PD0xTy23TSD3qfZ0Z/aTgArkZGUkT2hreMEtS2T6N1Kdo533bfCzg7S2efAIkgI+pdMmnI+qb/Z3P1HS1pDbW98DdNhtRmdDlKKt978rVPY4Sg13QnzGn7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630911; c=relaxed/simple;
	bh=EXgu6swCEGC/mWOd4154HwA6kZ1C3Y/hV7wHFjYnz9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW57WRWK1S9qR8i3Vzvuq9en1nu+66uILHIDh8YHUbRjoXi2pi6rgIovDgshnv7CtMi0UYu4qSWLIQEPhdqCGsNj1HvdXokz2b0sJxa9kh0OYY4bxiO5fkSt8gL0nl0j9+qHVFJ+Oh7G7IgrKadQjiHXXN8otlKIsQkFcPUhQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=svcateWi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BBbU0N/GofBCvp79/gpgCjNhyGoIydeQdyHeE8NSkdM=; b=svcateWiUd1keI6Pe8ykjBxrnZ
	f38uSpNWdz4p953/U16PKOwQaahojU8t2c2ssBqOm1iSxuTCyEdKULz/iGzY4EHFDD7Nw/jjJwXX+
	0YHAsedUThfxNba654MD6o4N9bCe7CpSXYxhK5qFmRpVp0H8RMoFrLYftF4lN0gtx7hU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6by4-00FKhM-Jh; Mon, 13 May 2024 22:08:16 +0200
Date: Mon, 13 May 2024 22:08:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <6d3aed83-ee56-4c3c-bb23-0f7d1f471ea4@lunn.ch>
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

> +struct mctp_pcc_hdr {
> +	u32 signature;
> +	u32  flags;

There looks to be an extra space here, or a tab vs space issue.

> +	u32 length;
> +	char mctp_signature[4];
> +};
> +
> +struct mctp_pcc_packet {
> +	struct mctp_pcc_hdr pcc_header;
> +	union {
> +		struct mctp_hdr     mctp_header;

and more here. I would expect checkpatch to point these out.

> +struct mctp_pcc_hw_addr {
> +	int inbox_index;
> +	int outbox_index;
> +};
> +	physical_link_addr.inbox_index =
> +		htonl(mctp_pcc_dev->hw_addr.inbox_index);


These are {in|out}box_index are u32s right? Otherwise you would not be
using htonl() on them. Maybe specify the type correctly.

> +	physical_link_addr.outbox_index =
> +		htonl(mctp_pcc_dev->hw_addr.outbox_index);

You should also mark the physical_link_addr members as being big
endian so sparse can check you are not missing any byte swaps.

> +	dev_addr_set(ndev, (const u8 *)&physical_link_addr);
> +	rc = register_netdev(ndev);
> +	if (rc)
> +		goto cleanup_in_channel;
> +	list_add_tail(&mctp_pcc_dev->head, &mctp_pcc_ndevs);
> +	return 0;
> +cleanup_in_channel:

It would be normal to add a blink line after the return, just to make
it easier to see where the error cleanup code starts.


> +	mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
> +cleanup_out_channel:
> +	mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
> +free_netdev:
> +	unregister_netdev(ndev);

Can you get here with the ndev actually registered?

> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares, void *context)
> +{
> +	struct acpi_resource_address32 *addr;
> +	struct lookup_context *luc = context;
> +
> +	switch (ares->type) {
> +	case 0x0c:
> +	case 0x0a:

Please replace these magic numbers of #defines.

> +static int mctp_pcc_driver_add(struct acpi_device *adev)
> +{
> +	int inbox_index;
> +	int outbox_index;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	struct lookup_context context = {0, 0, 0};
> +
> +	dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));

It would be better to not spam the logs when a driver probes, unless
there is an actual error.

> +	dev_handle = acpi_device_handle(adev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices, &context);
> +	if (ACPI_SUCCESS(status)) {
> +		inbox_index = context.inbox_index;
> +		outbox_index = context.outbox_index;
> +		return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index, outbox_index);
> +	}
> +	dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
> +	return -EINVAL;
> +};
> +
> +/* pass in adev=NULL to remove all devices
> + */
> +static void mctp_pcc_driver_remove(struct acpi_device *adev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_dev = NULL;
> +	struct list_head *ptr;
> +	struct list_head *tmp;
> +
> +	list_for_each_safe(ptr, tmp, &mctp_pcc_ndevs) {
> +		mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, head);
> +		if (!adev || mctp_pcc_dev->acpi_device == adev) {
> +			struct net_device *ndev;
> +
> +			mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
> +			mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
> +			ndev = mctp_pcc_dev->mdev.dev;
> +			if (ndev)
> +				mctp_unregister_netdev(ndev);
> +			list_del(ptr);
> +			if (adev)
> +				break;
> +		}
> +	}
> +};
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001", 0},
> +	{ "", 0},
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +		.remove = mctp_pcc_driver_remove,
> +		.notify = NULL,
> +	},
> +	.owner = THIS_MODULE,
> +
> +};
> +
> +static int __init mctp_pcc_mod_init(void)
> +{
> +	int rc;
> +
> +	pr_info("initializing MCTP over PCC\n");

More useless log spamming... pr_dbg(), or remove altogether.

	Andrew

