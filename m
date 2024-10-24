Return-Path: <netdev+bounces-138530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95D99AE02A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F205C283A62
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D81B0F3A;
	Thu, 24 Oct 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZeSZPda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2591B0F13;
	Thu, 24 Oct 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761038; cv=none; b=hhzIKDcyH8DGCbAwYM7lvijd+uKnnIMe9eWMFI4qRi4IfLdcN5OsZfNoW2yHFPoNxeL8N5v039f0PxAV01S3j7A8GzCc9pqmR/B83z+7OiL6O9pybJe3C79w5aeppfDdHMqOIS8Iv8mVH9N9HmA5glaOVariP8Bj+J7hcG73IVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761038; c=relaxed/simple;
	bh=+tAuPuS4qDYyylOvplCLRUauYVB2Q0dEDLIfuASAXaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPu8uTVyuctG7e0z1ogHKqBulWCQQlcXGmSSecqV1bCwJ++PvazO0R/M01C1sEN1yaJHYZjoaiyRCry4+8Si3xdIupi1XVu90A6wMEaDApMjOOzDsP8q6hER1PGyuDMGSN9POqHKHsQ0AHz5ysiol+KrOFN4ERz0WS98EOFHDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZeSZPda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869FCC4CEC7;
	Thu, 24 Oct 2024 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729761037;
	bh=+tAuPuS4qDYyylOvplCLRUauYVB2Q0dEDLIfuASAXaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZeSZPdaL4yerk2j30+PVcGBLiQZAgkoyuopojm123vfC5hY2FYEbRF/tUj6RY1eP
	 ZbsQXGt+uGQCvbd43GfNRLlzEenM6+5fCEYAV+P0bjB9FviTIy0SgzEfgVMNrT7Z2P
	 d37OyOOY++81k6XYVijhanHE5t0IUe0XRZ4xb8s1FMJwGzlRLhci+thp8fWW40Apa7
	 bv4/CCnj7iDLCRvWwNKTpiCwmN0zyAeB2g+H8IxfMdLNcVi7xtGUFK3qtomRUTpltu
	 g4UA5dxeQ3SwoppiWBdnbmdnzplMhsDH9s8DCIP2TSPmS5Bx1+4BB3Nf51JuP75PGI
	 Eq9+Sov8jKj/w==
Date: Thu, 24 Oct 2024 10:10:32 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] eth: fbnic: Add devlink dev flash support
Message-ID: <20241024091032.GI402847@kernel.org>
References: <20241012023646.3124717-1-lee@trager.us>
 <20241022014319.3791797-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022014319.3791797-1-lee@trager.us>

On Mon, Oct 21, 2024 at 06:42:24PM -0700, Lee Trager wrote:
> fbnic supports updating firmware using a PLDM image signed and distributed
> by Meta. PLDM images are written into stored flashed. Flashing does not
> interrupt operation.
> 
> On host reboot the newly flashed UEFI driver will be used. To run new
> control or cmrt firmware the NIC must be power cycled.
> 
> Signed-off-by: Lee Trager <lee@trager.us>

...

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c

...

> @@ -109,8 +110,274 @@ static int fbnic_devlink_info_get(struct devlink *devlink,
>  	return 0;
>  }
> 
> +/**
> + * fbnic_send_package_data - Send record package data to firmware
> + * @context: PLDM FW update structure
> + * @data: pointer to the package data
> + * @length: length of the package data
> + *
> + * Send a copy of the package data associated with the PLDM record matching
> + * this device to the firmware.
> + *
> + * Return: zero on success
> + *	    negative error code on failure
> + */
> +static int fbnic_send_package_data(struct pldmfw *context, const u8 *data,
> +				   u16 length)
> +{
> +	struct device *dev = context->dev;
> +
> +	/* Temp placeholder required by devlink */
> +	dev_info(dev,
> +		 "Sending %u bytes of PLDM record package data to firmware\n",
> +		 length);

Could you clarify what is meant by "Temp placeholder" here and in
fbnic_send_component_table(). And what plans there might be for
a non-temporary solution.

> +
> +	return 0;
> +}
> +
> +/**
> + * fbnic_send_component_table - Send PLDM component table to the firmware
> + * @context: PLDM FW update structure
> + * @component: The component to send
> + * @transfer_flag: Flag indication location in component tables
> + *
> + * Read relevant data from component table and forward it to the firmware.
> + * Check response to verify if the firmware indicates that it wishes to
> + * proceed with the update.
> + *
> + * Return: zero on success
> + *	    negative error code on failure
> + */
> +static int fbnic_send_component_table(struct pldmfw *context,
> +				      struct pldmfw_component *component,
> +				      u8 transfer_flag)
> +{
> +	struct device *dev = context->dev;
> +	u16 id = component->identifier;
> +	u8 test_string[80];
> +
> +	switch (id) {
> +	case QSPI_SECTION_CMRT:
> +	case QSPI_SECTION_CONTROL_FW:
> +	case QSPI_SECTION_OPTION_ROM:
> +		break;
> +	default:
> +		dev_err(dev, "Unknown component ID %u\n", id);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "Sending PLDM component table to firmware\n");
> +
> +	/* Temp placeholder */
> +	strscpy(test_string, component->version_string,
> +		min_t(u8, component->version_len, 79));
> +	dev_info(dev, "PLDMFW: Component ID: %u version %s\n",
> +		 id, test_string);
> +
> +	return 0;
> +}

...

