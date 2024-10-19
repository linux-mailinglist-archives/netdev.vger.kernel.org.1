Return-Path: <netdev+bounces-137204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8E09A4CA3
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BDE1F2367C
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7E71DE4F3;
	Sat, 19 Oct 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO/gYTPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340920E30B;
	Sat, 19 Oct 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330448; cv=none; b=QENPJOQ0LO61ZKrPfyC0KUPCjCdBs5kXx1tbI9LlVw1TKjrFyMGsaYJQ4CYPdcd51dYeb0/Agl+RTxbKnIMY0DGtgeda9I21HEAu4m1EOOhDIGcGNWCbfFT+IXk15SKJUTxxMyd6bZDAry5foBy3S8Z9REmPPYz/Afjws0F8Fzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330448; c=relaxed/simple;
	bh=wIgGqw4Rh+8ZoDZH34lbZQsu5hpqUW78taz2QwcuK04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOcgoMx7gU7qV1Y7NbQYemvRPkWsItknAAbUrBR/ODidqL3mPnHBR/JP0fs0S64fhaatNuxSBAjqGkdRt0sAKdH5YAlx4DtuQygMkqi/h2OkhQN6q0MTskyCfYwCsBNRBbbEOjYCgEuqzKrEBP5NwH/XJ+Xmd/7vUYFMPuBFsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO/gYTPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87FEC4CEC5;
	Sat, 19 Oct 2024 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729330447;
	bh=wIgGqw4Rh+8ZoDZH34lbZQsu5hpqUW78taz2QwcuK04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iO/gYTPnRsZlVSlDPmGKyKBKJDXLwXwJZHGmSV2wE0SxOg1QcPqL9QYGBq4c+AvMz
	 Ix4aJlEQpMjnwuYbyaMgshn04Y657USw75kIWd08/bDasGpKtcpA8NZeQVnxllgeJA
	 NhBOS3R1WmtLCX80QxpZosaUheW2z6jCN/MHQdBdJKPnmr5NRdXpY+YAml8/tqeBcw
	 BzZh1tzfVGwy9XIfim6fVERWlAgNUgg2wNSd3tBRd3H6MvD9XOQ5oTpH7ewzR/SZ2Y
	 a5wsiafOGaM4etd5rDcVhJiSUvQ6wTtMPNpfZlUSgXDm3ZCfVJb1CPFHEhDwi3MKSj
	 CtzgEFdUT4/XA==
Date: Sat, 19 Oct 2024 10:34:02 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] eth: fbnic: Add devlink dev flash support
Message-ID: <20241019093402.GT1697@kernel.org>
References: <20241012023646.3124717-1-lee@trager.us>
 <20241012023646.3124717-3-lee@trager.us>
 <8502a496-f83d-470c-a84d-081a7c7e2cae@linux.dev>
 <20241015104353.GC569285@kernel.org>
 <61e80187-49d0-4ad8-a66a-0c3901963201@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e80187-49d0-4ad8-a66a-0c3901963201@trager.us>

On Fri, Oct 18, 2024 at 03:48:26PM -0700, Lee Trager wrote:
> On 10/15/24 3:43 AM, Simon Horman wrote:
> 
> > On Mon, Oct 14, 2024 at 12:18:36PM +0100, Vadim Fedorenko wrote:
> > > On 12/10/2024 03:34, Lee Trager wrote:
> > > > fbnic supports updating firmware using a PLDM image signed and distributed
> > > > by Meta. PLDM images are written into stored flashed. Flashing does not
> > > > interrupt operation.
> > > > 
> > > > On host reboot the newly flashed UEFI driver will be used. To run new
> > > > control or cmrt firmware the NIC must be power cycled.
> > > > 
> > > > Signed-off-by: Lee Trager <lee@trager.us>
> > ...
> > 
> > > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> > ...
> > 
> > > > +/**
> > > > + * fbnic_send_component_table - Send PLDM component table to the firmware
> > > > + * @context: PLDM FW update structure
> > > > + * @component: The component to send
> > > > + * @transfer_flag: Flag indication location in component tables
> > > > + *
> > > > + * Read relevant data from component table and forward it to the firmware.
> > > > + * Check response to verify if the firmware indicates that it wishes to
> > > > + * proceed with the update.
> > > > + *
> > > > + * Return: zero on success
> > > > + *	    negative error code on failure
> > > > + */
> > > > +static int fbnic_send_component_table(struct pldmfw *context,
> > > > +				      struct pldmfw_component *component,
> > > > +				      u8 transfer_flag)
> > > > +{
> > > > +	struct device *dev = context->dev;
> > > > +	u16 id = component->identifier;
> > > > +	u8 test_string[80];
> > > > +
> > > > +	switch (id) {
> > > > +	case QSPI_SECTION_CMRT:
> > > > +	case QSPI_SECTION_CONTROL_FW:
> > > > +	case QSPI_SECTION_OPTION_ROM:
> > > > +		break;
> > > > +	default:
> > > > +		dev_err(dev, "Unknown component ID %u\n", id);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	dev_dbg(dev, "Sending PLDM component table to firmware\n");
> > > > +
> > > > +	/* Temp placeholder */
> > > > +	memcpy(test_string, component->version_string,
> > > > +	       min_t(u8, component->version_len, 79));
> > > > +	test_string[min_t(u8, component->version_len, 79)] = 0;
> > > Looks like this construction can be replaced with strscpy().
> > > There were several patchsets in the tree to use strscpy(), let's follow
> > > the pattern.
> > While looking at these lines, I'm unsure why min_t() is being used
> > instead of min() here. As version_len is unsigned and 79 is a positive
> > constant, I believe min() should be fine here.
> 
> clang complains if I'm not explicit with the type by using min_t()

Thanks, and sorry for not checking what clang says.
That is a good enough reason for this for me.

...

