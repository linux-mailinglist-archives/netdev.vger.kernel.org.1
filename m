Return-Path: <netdev+bounces-144190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC39C6314
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DE5B2C0C0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613BC213148;
	Tue, 12 Nov 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzpJ5zv9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32285213129;
	Tue, 12 Nov 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433369; cv=none; b=j5gZX2XaBJ7G6maoJtD7DBpu2O9r+hn/utkTM/FjwOyj2nn0oh4MJXAc01C2Ntx09b0Jnj/ZEjBVjn1T6J9MIJMSQiLqyXECMwjJTmTtbB3JWMOkas39KOM0AA35TGLBGQMK9u/BirZl8cD6cqtDc/l1J12XKRg1RWjm+J8v2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433369; c=relaxed/simple;
	bh=2g9RLk/eByRvc3GAQn2FlMlvwsm275EqT0VhDfAPt+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzwEV/jWgUP3eVWf0ERm6nIHNjPpiqNVDzSEmmOtNoQ9p6/v56vLQeciBMzE6NrzeG7mUOgQDzQir174xBFFZrhhWwMQoQF2n1picCaUbJhoGIfl54CrR/5t9UVrp12uTdcbjN8FN4I2w+qKbVbPjPnLeYjyI9EdVPlfElSDLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzpJ5zv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C5EC4CECD;
	Tue, 12 Nov 2024 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731433368;
	bh=2g9RLk/eByRvc3GAQn2FlMlvwsm275EqT0VhDfAPt+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzpJ5zv9qJkbiZYOmz3PN80bcaMjjjojSSZTuQbhvZkJ8SLHfbJiZJoQWxYRaXlhw
	 Rr/oVDD3e3zSO94h0jpw60oN+5oOGQAUL10y7XuNUjLEHhEE60Eg0TR5jfy6k6Gccw
	 RwxDlgJbhVw9D0QGIQl4X2Gksi2svAjEDW6+crBExBdgy41QOA3Xa0EgzzUHq9/7V0
	 0dK/OncfK+/4BN4877O35q6TMICZVOyvMUd9vIBWbcrO+MAlIShfR6wu09ROqQaNFE
	 mQJuzROLOro5OlT++ySAwYjIZsG3bkScGpd4/Fo5dns4Ebx0gQWLtJSEAEFAuhxvKy
	 y1oXOi9DOJjdw==
Date: Tue, 12 Nov 2024 17:42:43 +0000
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
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] eth: fbnic: Add devlink dev flash support
Message-ID: <20241112174243.GU4507@kernel.org>
References: <20241111043058.1251632-1-lee@trager.us>
 <20241111043058.1251632-3-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111043058.1251632-3-lee@trager.us>

On Sun, Nov 10, 2024 at 08:28:42PM -0800, Lee Trager wrote:
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

> +/**
> + * fbnic_flash_component - Flash a component of the QSPI
> + * @context: PLDM FW update structure
> + * @component: The component table to send to FW
> + *
> + * Map contents of component and make it available for FW to download
> + * so that it can update the contents of the QSPI Flash.
> + *
> + * Return: zero on success
> + *	    negative error code on failure
> + */
> +static int fbnic_flash_component(struct pldmfw *context,
> +				 struct pldmfw_component *component)
> +{
> +	const u8 *data = component->component_data;
> +	u32 size = component->component_size;
> +	struct fbnic_fw_completion *fw_cmpl;
> +	struct device *dev = context->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u16 id = component->identifier;
> +	const char *component_name;
> +	int retries = 2;
> +	int err;
> +
> +	struct devlink *devlink;
> +	struct fbnic_dev *fbd;

Hi Lee,

Please consider arranging local variables in reverse xmas tree order -
longest line to shortest. Without any blank lines. I think that in this
case that could be:

	const u8 *data = component->component_data;
	u32 size = component->component_size;
	struct fbnic_fw_completion *fw_cmpl;
	struct device *dev = context->dev;
	u16 id = component->identifier;
	const char *component_name;
	struct devlink *devlink;
	struct fbnic_dev *fbd;
	struct pci_dev *pdev;
	int retries = 2;
	int err;

	N.B. pdev is initialised below.

> +
> +	switch (id) {
> +	case QSPI_SECTION_CMRT:
> +		component_name = "boot1";
> +		break;
> +	case QSPI_SECTION_CONTROL_FW:
> +		component_name = "boot2";
> +		break;
> +	case QSPI_SECTION_OPTION_ROM:
> +		component_name = "option-rom";
> +		break;
> +	default:
> +		dev_err(dev, "Unknown component ID %u\n", id);
> +		return -EINVAL;
> +	}
> +
> +	fw_cmpl = kzalloc(sizeof(*fw_cmpl), GFP_KERNEL);
> +	if (!fw_cmpl)
> +		return -ENOMEM;
> +
> +	pdev = to_pci_dev(dev);
> +	fbd = pci_get_drvdata(pdev);
> +	devlink = priv_to_devlink(fbd);

...

