Return-Path: <netdev+bounces-106932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1039182CB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F5F28129B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AAA184128;
	Wed, 26 Jun 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L3/t7BkQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130851836C7;
	Wed, 26 Jun 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409229; cv=none; b=WXX2Gtetn39lv6QotRU8YaJbqSZslw5r2E7ItPm9VWzdpYbB0siOp87WxCwDNeSM35pupbFWiY3VCDY9ETCipMraMtkMxXsIhdYAlYH4ETNGubtYG67f6WViROGkdWDtycpBiJfRRAyB5SZQx9yyef5I6Lrt1XZX442yubXd1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409229; c=relaxed/simple;
	bh=UgRd/wKrH/zbcVyYi4i/ecnLIk3NSGtpaiNRr7cKvvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK5a3VsBSQ2bQ2PD1ea7Uq2xcRE18Fdq9ohf6gjHNPL+EAxGJ4eInGXZ5BdOTzOujnOHeUcml9BzyIlgIw4OiPCwnkGdNs5bHF7Uyh6qwXs3VmNVLf2cLc1jVNPb06ML7LvIDsjfcsvPWh6KW7CAOcITNNSsOKehGbH/DuFv/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L3/t7BkQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w+FlyxrUhamZt7jen+f+qeqf7S98tAkMyEN3nNjtVz8=; b=L3/t7BkQHLRqnCmdgdMIkc8wWg
	nb4wOMT+LmwJVXv37EQgkCmH48f9tB2JRCEPHMNHuWZXdFUvaLRoTDr8zCkK4xSAQltqz5nIoooMf
	bRkE1pbr44a4ThoQGvLiQggMNfyg0l4plECPXmgixrlqmL5Ni0/TVY/Jy5Yv2JRw1vVU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMSsa-0012db-HN; Wed, 26 Jun 2024 15:40:08 +0200
Date: Wed, 26 Jun 2024 15:40:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	mlxsw <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <baf84bde-79d3-4570-a1df-e6adbe14c823@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-8-danieller@nvidia.com>
 <003ca0dd-ea1c-4721-8c3f-d4a578662057@lunn.ch>
 <DM6PR12MB4516DD74CA5F4D52D5290E26D8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516907EAC007FCB05955F7CD8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4516907EAC007FCB05955F7CD8D62@DM6PR12MB4516.namprd12.prod.outlook.com>

> > > > +int ethtool_cmis_wait_for_cond(struct net_device *dev, u8 flags, u8 flag,
> > > > +			       u16 max_duration, u32 offset,
> > > > +			       bool (*cond_success)(u8), bool (*cond_fail)(u8),
> > > > +			       u8 *state)
> > > > +{
> > > > +	const struct ethtool_ops *ops = dev->ethtool_ops;
> > > > +	struct ethtool_module_eeprom page_data = {0};
> > > > +	struct cmis_wait_for_cond_rpl rpl = {};
> > > > +	struct netlink_ext_ack extack = {};
> > > > +	unsigned long end;
> > > > +	int err;
> > > > +
> > > > +	if (!(flags & flag))
> > > > +		return 0;
> > > > +
> > > > +	if (max_duration == 0)
> > > > +		max_duration = U16_MAX;
> > > > +
> > > > +	end = jiffies + msecs_to_jiffies(max_duration);
> > > > +	do {
> > > > +		ethtool_cmis_page_init(&page_data, 0, offset, sizeof(rpl));
> > > > +		page_data.data = (u8 *)&rpl;
> > > > +
> > > > +		err = ops->get_module_eeprom_by_page(dev, &page_data,
> > > &extack);
> > > > +		if (err < 0) {
> > > > +			if (extack._msg)
> > > > +				netdev_err(dev, "%s\n", extack._msg);
> > > > +			continue;
> > >
> > > continue here is interested. Say you get -EIO because the module has
> > > been ejected. I would say that is fatal. Won't this spam the logs, as
> > > fast as the I2C bus can fail, without the 20ms sleep, for 65535 jiffies?
> > 
> > If the module is ejected from some reason, it might span the logs I guess.

Please could you test it.

65535 jiffies is i think 655 seconds? That is probably too long to
loop when the module has been ejected. Maybe replace it with HZ?

Maybe netdev_err() should become netdev_dbg()? And please add a 20ms
delay before the continue.

> > > > +		}
> > > > +
> > > > +		if ((*cond_success)(rpl.state))
> > > > +			return 0;
> > > > +
> > > > +		if (*cond_fail && (*cond_fail)(rpl.state))
> > > > +			break;
> > > > +
> > > > +		msleep(20);
> > > > +	} while (time_before(jiffies, end));
> > >
> > > Please could you implement this using iopoll.h. This appears to have
> > > the usual problem. Say msleep(20) actually sleeps a lot longer,
> > > because the system is busy doing other things. time_before(jiffies,
> > > end)) is false, because of the long delay, but in fact the operation
> > > has completed without error. Yet you return EBUSY. iopoll.h gets this
> > > correct, it does one more evaluation of the condition after exiting
> > > the loop to handle this issue.
> > 
> > OK.
> 
> Hi Andrew,
> 
> Therefore, unfortunately in this case I'd rather stay with the origin code.

O.K. Please evaluate the condition again after the while() just so
ETIMEDOUT is not returned in error.

	Andrew

