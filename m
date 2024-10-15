Return-Path: <netdev+bounces-135584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7C99E466
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987561C22762
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13B1E412E;
	Tue, 15 Oct 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2ASM1MS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B72FC52;
	Tue, 15 Oct 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989039; cv=none; b=bX/rjr3rBDBE/eb8wHTXm1PCRVz0c+d9snvQAYLKjI9nKImc7EF66X8NSUrbj/LPep8/14rtyv7SsZRslWEOX8/enO5XIST8CyhEUwbRf1vVvevB081enZSCWCO0xIoXgUlgEE2QZ+dZDHI2vNdOe+P8lB7fIT7VMi+lt6sl15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989039; c=relaxed/simple;
	bh=/G/Q5eALeFqEjfAGFW6b6pAIrUGg9FMOG0K7xZO3Gps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0GaOOIxUdZBXluMHMaI9dCcMXMAdyOK6D2mdmEN3YyHyDpWL4fcShlAYLP3jsfSyZGJwqmTI8UAk4eWWkcYKDTn8/C13JUNEhDmFgIV8OuZEFE1FIU1qlxO+brD9F/L7aSPKX5mTYPkdkcbo3CLbcxFsjZ0ElvcBBvA7ZOWChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2ASM1MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9E4C4CEC6;
	Tue, 15 Oct 2024 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728989038;
	bh=/G/Q5eALeFqEjfAGFW6b6pAIrUGg9FMOG0K7xZO3Gps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2ASM1MSxcYS1XVUlom2B9HpA4sTgg6zkTzvV76z0kN98YDIZ9aXa9Y6skJHHV58H
	 UCgkasc4Iq08zUYH0cCvNqlTgNTimAr3JlG57Z6+RK0Qp5jPJqg2Cxb3ZMjIit1oYq
	 NLyJ4yD8guY6RvAc4Gdy0cvsdr4y21Zz4ac6YC8JoCK8aEXgsfxb7zbBYH9EXX6Ghh
	 oq0H5fWVG3qvfGkVVasFL+nG5ANnEQ3iL1OcJqve2TGlh8G9cKEzYgydzPnj7FPmfz
	 DAAKRANBPuHZ4c31vo4TIR96Li1doZARmPqawiwrmWRSY6c+8gcXhviHQtVbt4fu1+
	 ZzEGgjlj5q2nA==
Date: Tue, 15 Oct 2024 11:43:53 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] eth: fbnic: Add devlink dev flash support
Message-ID: <20241015104353.GC569285@kernel.org>
References: <20241012023646.3124717-1-lee@trager.us>
 <20241012023646.3124717-3-lee@trager.us>
 <8502a496-f83d-470c-a84d-081a7c7e2cae@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8502a496-f83d-470c-a84d-081a7c7e2cae@linux.dev>

On Mon, Oct 14, 2024 at 12:18:36PM +0100, Vadim Fedorenko wrote:
> On 12/10/2024 03:34, Lee Trager wrote:
> > fbnic supports updating firmware using a PLDM image signed and distributed
> > by Meta. PLDM images are written into stored flashed. Flashing does not
> > interrupt operation.
> > 
> > On host reboot the newly flashed UEFI driver will be used. To run new
> > control or cmrt firmware the NIC must be power cycled.
> > 
> > Signed-off-by: Lee Trager <lee@trager.us>

...

> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c

...

> > +/**
> > + * fbnic_send_component_table - Send PLDM component table to the firmware
> > + * @context: PLDM FW update structure
> > + * @component: The component to send
> > + * @transfer_flag: Flag indication location in component tables
> > + *
> > + * Read relevant data from component table and forward it to the firmware.
> > + * Check response to verify if the firmware indicates that it wishes to
> > + * proceed with the update.
> > + *
> > + * Return: zero on success
> > + *	    negative error code on failure
> > + */
> > +static int fbnic_send_component_table(struct pldmfw *context,
> > +				      struct pldmfw_component *component,
> > +				      u8 transfer_flag)
> > +{
> > +	struct device *dev = context->dev;
> > +	u16 id = component->identifier;
> > +	u8 test_string[80];
> > +
> > +	switch (id) {
> > +	case QSPI_SECTION_CMRT:
> > +	case QSPI_SECTION_CONTROL_FW:
> > +	case QSPI_SECTION_OPTION_ROM:
> > +		break;
> > +	default:
> > +		dev_err(dev, "Unknown component ID %u\n", id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(dev, "Sending PLDM component table to firmware\n");
> > +
> > +	/* Temp placeholder */
> > +	memcpy(test_string, component->version_string,
> > +	       min_t(u8, component->version_len, 79));
> > +	test_string[min_t(u8, component->version_len, 79)] = 0;
> 
> Looks like this construction can be replaced with strscpy().
> There were several patchsets in the tree to use strscpy(), let's follow
> the pattern.

While looking at these lines, I'm unsure why min_t() is being used
instead of min() here. As version_len is unsigned and 79 is a positive
constant, I believe min() should be fine here.

> 
> > +	dev_info(dev, "PLDMFW: Component ID: %u version %s\n",
> > +		 id, test_string);
> > +
> > +	return 0;
> > +}

