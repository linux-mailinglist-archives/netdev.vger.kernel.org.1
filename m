Return-Path: <netdev+bounces-109033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248492692B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237152866B2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA0184116;
	Wed,  3 Jul 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiGX+rgZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C1130A7C;
	Wed,  3 Jul 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720036423; cv=none; b=IebcOYYv1fUl33n2XtXIFQLjWBePMGHVJCKXeedT5HoQv+8wkzOadi/yOI7VfpyzBvof9/wsv1DSUqZbtFjVsbT05ARVvSCb5Kv6EQipPv+iaMoNNWuuAMJuu5wo1Vye4m382TGcPHmGIGij4qenJp8Q3YLb/Op3YxhiYX24Rks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720036423; c=relaxed/simple;
	bh=gpPnxAmH7YVYAIk7U213xERaCKNz7L4XQJjxdiVAonk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3dyGp1LGYzHvwLiNMuzdIrYHUcGG2BSSzqa0TsLoSf/hZ1DyFZjFipZJBUikKSLmzfXKMD8wIr40oKxbxZ4wenw9ipays2QfP1+gL1kEKPL19L35c5v1yg+MlwtG9KepK0d5Jg97YpuEDCFOxUHtIpksZMsf1YcNXWHjpus+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiGX+rgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA5FC2BD10;
	Wed,  3 Jul 2024 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720036423;
	bh=gpPnxAmH7YVYAIk7U213xERaCKNz7L4XQJjxdiVAonk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiGX+rgZd6oGXSuPDvKT9AAvqCDq4dPYsWAaoI+jNnrRCLVUFFZX2juyxY+OcT8Yp
	 uLFx7o7jX6lBOygGof4KiKtlIvzzV8c9ujI+8SHQowycUA7hyqo6FaZ4bDOTIQT7pG
	 wG4kjuYpIF/0NC/LE7euV9CB7xlpYOZjh+w70oqcawcX0eBOskJJ+ueUlhD1IHUx+x
	 jW3kB8CyYA9pkNGBRpaVPl4/6i5ettVDvtVPRUZJTva4fqEZtqlJYiv846hf7LcAcE
	 J3q3B8XeoOW5BZ0zHSsS1sTXH0wN1gvydLmNrahzDXw/XnIwzwCjNhpgK7mUZ03fiv
	 Bz9Oj1aqp4RMQ==
Date: Wed, 3 Jul 2024 20:53:38 +0100
From: Simon Horman <horms@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v4 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20240703195338.GR598357@kernel.org>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
 <20240702225845.322234-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702225845.322234-4-admiyo@os.amperecomputing.com>

On Tue, Jul 02, 2024 at 06:58:45PM -0400, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP) over
> Platform Communication Channel(PCC)
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
> ---
>  drivers/net/mctp/Kconfig    |  13 ++
>  drivers/net/mctp/Makefile   |   1 +
>  drivers/net/mctp/mctp-pcc.c | 322 ++++++++++++++++++++++++++++++++++++

...

> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c

...

> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +		.remove = mctp_pcc_driver_remove,
> +	},
> +	.owner = THIS_MODULE,

Hi Adam,

Perhaps net-next isn't the appropriate tree to apply this patch.
But, due to [1] the owner field is not present in net-next and
thus this fails to build when applied there.

[1] cc85f9c05bba ("ACPI: drop redundant owner from acpi_driver")

> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC device");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
> -- 
> 2.34.1
> 
> 

