Return-Path: <netdev+bounces-139627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451559B3A50
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0902B282077
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6B1DF96A;
	Mon, 28 Oct 2024 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="buZIfPtd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA711DED5D;
	Mon, 28 Oct 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143165; cv=none; b=GWVDgZmTIn3RIJR9b8BEGc/k4U/Ts2KF6hfEFdEhBCFs3Si4b8JmIHD9SRTq8A/1nLMLVdF3D4KUHcg989CiGwbaccbzs1OZxboKbBVqrQl/n8ZwDCrOxJfN9qdQZcPpuHfMHgNxdawZPHTjfctWFWJHwWrEUNmDHaxsLasrrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143165; c=relaxed/simple;
	bh=YOhFJudoWKITSumFA9L1MS25O6AQWfwCQtZmUQt+/nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tga11SQ+x01ga3nSQBKG16rtdrXWMzOWva5CPVgZrIJYT5ZiB1EEAqoLgbmrEG1Kv1lci4qPQzp1shV3Hba+K9ZguDgPrb6xXfvkE1gEWokIR7N9lHE3H3BtujNu3djuDmaHgPCYN+dP2MdUe5wFlhN5HKpvyDoNux4baPsgVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=buZIfPtd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j5Hm+cdKOPmGk6I+GthLiMX+5qze8QN9PBg+oM0pU7k=; b=buZIfPtdaRSu8VgAlbDO1Kibxr
	syA5y3dx/dt06CUBDmRKqSHgHJ0v8o8vw8a3OCzypKVcW6/SfxJhXnvhfUBIn/u0qEODLX38rnzv5
	UJ0aC8R8R9fa58IIt0UriftsgZfi6OQcl35b/vR8q3NHczdzznFUt3+UWA/epTzyVZOs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5VGa-00BTkR-1h; Mon, 28 Oct 2024 20:19:04 +0100
Date: Mon, 28 Oct 2024 20:19:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ronnie.Kunin@microchip.com
Cc: Fabi.Benschuh@fau.de, Woojung.Huh@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] Add LAN78XX OTP_ACCESS flag support
Message-ID: <a0d6ef0c-5615-40fd-964d-11844389dc29@lunn.ch>
References: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
 <c4503364-78c7-4bd5-9a77-0d98ae1786bf@lunn.ch>
 <PH8PR11MB796575D608575FAA5233DBD4954A2@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB796575D608575FAA5233DBD4954A2@PH8PR11MB7965.namprd11.prod.outlook.com>

On Mon, Oct 28, 2024 at 03:02:44PM +0000, Ronnie.Kunin@microchip.com wrote:
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Monday, October 28, 2024 8:38 AM
> > 
> > On Sat, Oct 26, 2024 at 01:05:46AM +0200, Fabian Benschuh wrote:
> > > With this flag we can now use ethtool to access the OTP:
> > > ethtool --set-priv-flags eth0 OTP_ACCESS on ethtool -e eth0  # this
> > > will read OTP if OTP_ACCESS is on, else EEPROM
> > >
> > > When writing to OTP we need to set OTP_ACCESS on and write with the
> > > correct magic 0x7873 for OTP
> > 
> > Please can you tell us more about OTP vs EEPROM? Is the OTP internal while the EEPROM is external?
> > What is contained in each? How does the device decide which to use when it finds it has both?
> > 
> >         Andrew
> 

> This is pretty much the same implementation that is already in place
> for the Linux driver of the LAN743x PCIe device.

That is good, it gives some degree of consistency. But i wounder if we
should go further. I doubt these are the only two devices which
support both EEPROM and OTP. It would be nicer to extend ethtool:

       ethtool -e|--eeprom-dump devname [raw on|off] [offset N] [length N] [otp] [eeprom]

There does not appear to be a netlink implementation of this ethtool
call. If we add one, we can add an additional optional attribute,
indicating OTP or EEPROM. We have done similar in the past. It
probably means within the kernel you replace struct ethtool_eeprom
with struct kernel_ethtool_eeprom which has the additional
parameter. The ioctl interface then never sees the new parameter,
which keeps with the kAPI. get_eeprom() and set_eeprom() probably have
all they need. get_eeprom_len() is more complex since it currently
only takes netdev. I think get_eeprom_len() needs its functionality
extended to indicate if the driver actually looks at the additional
parameter. We want the kAPI calls for get and set to failed with
-EOPNOTSUPP when otp or eeprom is not supported, which will initially
be 99% of the drivers. And we don't want to have to make proper code
changes to every driver. So maybe an additional parameter

	int	(*get_eeprom_len)(struct net_device *,
	                          struct kernel_eeprom_len *eeprom_len);

struct kernel_eeprom_len {
	int otp;
	int eeprom;
}

Have the core zero this. After the call, if they are still zero, they
are not supported.

I know this is a lot more work than your current patch, but it is a
better solution, should be well documented, easy to find and should
work for everybody, against a device private parameter which is not
obvious and unlikely to be consistent across drivers.

	Andrew

