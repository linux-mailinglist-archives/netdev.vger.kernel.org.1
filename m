Return-Path: <netdev+bounces-106245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155D915767
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092011F24F08
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCF81A01C7;
	Mon, 24 Jun 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B+4ANB3K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76318509C;
	Mon, 24 Jun 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258661; cv=none; b=NBXdAMvNEBnGM+ZwRNvhLdEMBcvoSlYa9JUiqlXUxIfBzT8yUOyYmjO40IZPnAQetAQ0IbNgz/IcKO3OYkI0RTNwTxNxATSrYbq9lh8Va49qqpRiLpvCRSBmtuhSDuzOXEYbdcOcb91y8Cum6ErUmyMQ4nwV1XF0bPqYuNEyojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258661; c=relaxed/simple;
	bh=mI87XPE9INl73fw9MMEOAqcszBcFREyy01ZMVBjVTBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bedKMs9duGl6hBllvSZPyNMVplBi+0jmL7t3gioHCDFQ8SLQa7F0MVnglSNx6Snuos2ZktMIc0N5LvEXx1kzaaK+8gkdK29Y0mW/PbpmpvEM8IzPCOgkaC/HaZPRPhd9cf2KQiLAvYn446Zs0kL+2VjHAd+wNKaWpYzuNNYJDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B+4ANB3K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H8zccT7J30O857u42irMMPWhivtN35KYNeKq3itmUgo=; b=B+4ANB3KrEjT8gJEa/cUYxrKo+
	EHQyFEK4ZZpJUaGb4WXLcSnQyE9QP59lvgmwPFJJvGil45VvU/z0URjm8/FHVbyb4d4aWedywRcOp
	4ep0w6GMLAiZA1akwoJvGzWkgXBrftfeUygbV5hzXpdCTJ59B7sYikXPnXRCvSr2jrXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLpi6-000sj6-6O; Mon, 24 Jun 2024 21:50:42 +0200
Date: Mon, 24 Jun 2024 21:50:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <003ca0dd-ea1c-4721-8c3f-d4a578662057@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-8-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624175201.130522-8-danieller@nvidia.com>

> +int ethtool_cmis_wait_for_cond(struct net_device *dev, u8 flags, u8 flag,
> +			       u16 max_duration, u32 offset,
> +			       bool (*cond_success)(u8), bool (*cond_fail)(u8),
> +			       u8 *state)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct ethtool_module_eeprom page_data = {0};
> +	struct cmis_wait_for_cond_rpl rpl = {};
> +	struct netlink_ext_ack extack = {};
> +	unsigned long end;
> +	int err;
> +
> +	if (!(flags & flag))
> +		return 0;
> +
> +	if (max_duration == 0)
> +		max_duration = U16_MAX;
> +
> +	end = jiffies + msecs_to_jiffies(max_duration);
> +	do {
> +		ethtool_cmis_page_init(&page_data, 0, offset, sizeof(rpl));
> +		page_data.data = (u8 *)&rpl;
> +
> +		err = ops->get_module_eeprom_by_page(dev, &page_data, &extack);
> +		if (err < 0) {
> +			if (extack._msg)
> +				netdev_err(dev, "%s\n", extack._msg);
> +			continue;

continue here is interested. Say you get -EIO because the module has
been ejected. I would say that is fatal. Won't this spam the logs, as
fast as the I2C bus can fail, without the 20ms sleep, for 65535
jiffies?

> +		}
> +
> +		if ((*cond_success)(rpl.state))
> +			return 0;
> +
> +		if (*cond_fail && (*cond_fail)(rpl.state))
> +			break;
> +
> +		msleep(20);
> +	} while (time_before(jiffies, end));

Please could you implement this using iopoll.h. This appears to have
the usual problem. Say msleep(20) actually sleeps a lot longer,
because the system is busy doing other things. time_before(jiffies,
end)) is false, because of the long delay, but in fact the operation
has completed without error. Yet you return EBUSY. iopoll.h gets this
correct, it does one more evaluation of the condition after exiting
the loop to handle this issue.

> +static u8 cmis_cdb_calc_checksum(const void *data, size_t size)
> +{
> +	const u8 *bytes = (const u8 *)data;
> +	u8 checksum = 0;
> +
> +	for (size_t i = 0; i < size; i++)
> +		checksum += bytes[i];
> +
> +	return ~checksum;
> +}

I expect there is already a helper do that somewhere.

    Andrew

---
pw-bot: cr

