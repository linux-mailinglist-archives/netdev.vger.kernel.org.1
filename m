Return-Path: <netdev+bounces-149616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A89A9E67AE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C74A1886044
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12C1DA0E9;
	Fri,  6 Dec 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HvYQ1QxI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150A1D89F8;
	Fri,  6 Dec 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469213; cv=none; b=sC+V3XOk9IvPp0IZjsySH0oommNePeUTJ3r93zXpNwZmht3gCS700q49O+qk8Ox1HKETTUL0CgClrRTYZeecPHqtx3/4Op+k/jaH4ohNT9Uj7EQuj1KtG0NXv8YquIdl/2p9/8zMhn38msO1DROd5Dy9ZOOOHgLpaDqwJtjjjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469213; c=relaxed/simple;
	bh=I6togj3rCYdWZizm/vBZ+hpS0EcWywx3tvwMzR/v/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9Pd10DgwR0oihfBY7Fae6l6nwRUj7nI+0BAUndAU4shHM2j3AEVj3bjPFwM+lH6R1TElackWupry1NA87K/2ZBDMZL0Uvm/QgyPH1RVpUsFFO4I7hq4skHV7otEdFM1E2l55Arl22VBAIVmRPfO+qP01R9T3SiBs8FCrhvvCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HvYQ1QxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81B6C4CED1;
	Fri,  6 Dec 2024 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733469213;
	bh=I6togj3rCYdWZizm/vBZ+hpS0EcWywx3tvwMzR/v/Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvYQ1QxIOTib9pAjNiUWByzjxOF8c7ghvkEfuBCoaWWC8LOyet0hvbQ+1/4xCdUbt
	 m8wOq+nCuIftmqrpkfQqfhzWR+kSpVjq53zjheiabEA7rIwrgZI8+KSbwctU/tNB9e
	 Ut7dm3jGijwMeC3kEPhSnaUIfc5/vY/tY769B0sE=
Date: Fri, 6 Dec 2024 08:13:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Til Kaiser <mail@tk154.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2] net: sysfs: also pass network device driver
 to uevent
Message-ID: <2024120613-unicycle-abruptly-02d1@gregkh>
References: <20241115140621.45c39269@kernel.org>
 <20241116163206.7585-1-mail@tk154.de>
 <20241116163206.7585-2-mail@tk154.de>
 <20241118175543.1fbcab44@kernel.org>
 <665459ff-9e99-4d22-9aeb-69c34be3db6b@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665459ff-9e99-4d22-9aeb-69c34be3db6b@tk154.de>

On Thu, Dec 05, 2024 at 05:28:47PM +0100, Til Kaiser wrote:
> On 19.11.24 02:55, Jakub Kicinski wrote:
> > On Sat, 16 Nov 2024 17:30:30 +0100 Til Kaiser wrote:
> > > Currently, for uevent, the interface name and
> > > index are passed via shell variables.
> > > 
> > > This commit also passes the network device
> > > driver as a shell variable to uevent.
> > > 
> > > One way to retrieve a network interface's driver
> > > name is to resolve its sysfs device/driver symlink
> > > and then substitute leading directory components.
> > > 
> > > You could implement this yourself (e.g., like udev from
> > > systemd does) or with Linux tools by using a combination
> > > of readlink and shell substitution or basename.
> > > 
> > > The advantages of passing the driver directly through uevent are:
> > >   - Linux distributions don't need to implement additional code
> > >     to retrieve the driver when, e.g., interface events happen.

Why does the driver name matter for something like a network device?
I.e. why are network devices "special" here and unlike all other class
devices in the kernel like keyboards, mice, serial ports, etc.?

> > >   - There is no need to create additional process forks in shell
> > >     scripts for readlink or basename.

"Do it in the kernel and have someone else maintain it for me to make my
life easier in userspace" isn't always the best reason to do something.
Generally if "you can do this in userspace" means "you SHOULD do this in
userspace", it's not a good reason to add it to the kernel.

And note, driver names change!  How are you going to handle that?

> > >   - If a user wants to check his network interface's driver on the
> > >     command line, he can directly read it from the sysfs uevent file.

The symlink in sysfs shows this already, no need to
open/read/parse/close the uevent file.

Also, where did you now document this new user/kernel API that we have
to maintain for 40+ years?  And what userspace tool is going to use it?

But really, again, why are network devices so special that they need
this but no other type of device in the kernel does?  And what changed
to require this suddenly?

thanks,

greg k-h

