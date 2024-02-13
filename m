Return-Path: <netdev+bounces-71517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF897853C3B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5AC1C2213C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB860B97;
	Tue, 13 Feb 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w/6UG637"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD13608ED
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856103; cv=none; b=ajikPj3tV3jKZzPx1gHYn942I8EoI7nqfAJGwj923V4u5pVSvzORc76mfk48NZmd/uOyghO0/Hq5Znq3D/+JAA/6pIx6ycz0z/tBTsz5JKy8q+Ti53EQd5ey/wtikTwjmvyjk2TmvKj0lNq2HPFKqbM0+Soa4DVvc27sulGo3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856103; c=relaxed/simple;
	bh=T8PA1XdMBOggWrgJtKBQ8c4G18TS+Wd2XBXlYTQc5e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6uezMqvKGesqqghV6+BPsIXFppXL6ntgGwAeK5TlTl6cJ/StfMraIMJv5EDDQud4pVmFHXkNVMD/PX1NYPDdkoqYoHV8o5uXxicacx3NC6ndZrpoR4Obgz1K3Tawp3B580/EAhtWmUaiSrwhWnLKbCy8JlU9GXV8Wh6WRWrpXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w/6UG637; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IVlvzgchdZNsysjz26rX8IDAM7duKjov5A4oVto7PWM=; b=w/6UG637kEvh1j6rMcMuj0kahX
	wOoBLmL4YV7AGrfTAPez5oJq27M2KzTrVwNK7hR3L9zo5BuWn6JbFo7ZSZZON+yzZH6XgSoewXWRa
	8/yXAjaM2oa2Fw5XxAoyY6MGdCIn6mGeFlY415S7HQWh+HPFkNs6H0CHo7NDS4KjGZlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZzO8-007ihT-Ax; Tue, 13 Feb 2024 21:28:20 +0100
Date: Tue, 13 Feb 2024 21:28:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>, sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net-next] igc: Add support for LEDs on i225/i226
Message-ID: <c4f66726-1726-4dd5-98a8-4f8562421168@lunn.ch>
References: <20240213184138.1483968-1-anthony.l.nguyen@intel.com>
 <7a6ae4c1-2436-4909-bb20-32b91210803c@lunn.ch>
 <24b89ed0-2c2c-2aff-fa59-8ee8f9f22e9a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b89ed0-2c2c-2aff-fa59-8ee8f9f22e9a@intel.com>

On Tue, Feb 13, 2024 at 11:09:47AM -0800, Tony Nguyen wrote:
> 
> 
> On 2/13/2024 10:49 AM, Andrew Lunn wrote:
> > On Tue, Feb 13, 2024 at 10:41:37AM -0800, Tony Nguyen wrote:
> > > From: Kurt Kanzenbach <kurt@linutronix.de>
> > > 
> > > Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> > > from user space using the netdev trigger. The LEDs are named as
> > > igc-<bus><device>-<led> to be easily identified.
> > > 
> > > Offloading link speed and activity are supported. Other modes are simulated
> > > in software by using on/off. Tested on Intel i225.
> > > 
> > > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > 
> > Hi Tony
> > 
> > Did you change anything? I'm just wondering why you posted this,
> > rather than just giving an Acked-by:
> 
> Hi Andrew,
> 
> No changes from me. I normally coalesce the IWL patches after our validation
> and send them on to netdev as a pull request. However, there's no other 1GbE
> patches in the pipeline so I'm sending the single patch. I believe this is
> the preference vs adding an Acked-by and having the netdev maintainers go
> back in history to pull this patch out.

I don't normally get involved in this, so maybe there is a process i
don't know about.

v3 is still in patchworks:

https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=393838

State: Awaiting Upstream

Does that mean you? Would not just giving an Acked-by be enough? Now
we have it twice in patchworks, and you did not mark your version as
v4, so is there a danger we get the different versions mixed up?

    Andrew


