Return-Path: <netdev+bounces-72466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A2858391
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513811C209EF
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09A132C1E;
	Fri, 16 Feb 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IvPMsUPI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB5132C1C
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103342; cv=none; b=qHkxsT/BDiQBh/7QZxbGX+mgLDh6wm3eMQl+LV3Uz4SuQ/7DwFC1y9BFKX8KrokhfExMe+Wmvjanu2bdWOj6+lewhucIHNKQ1IR0vz/cBjTpkAhR23JAv+/YfVqPHEMAXU9/4SVL1IVhdYGrHcC7TCKMiFQrN4ayQhiacyOdix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103342; c=relaxed/simple;
	bh=mwcIZ8VaHZlxdXJtTQRsoato/BRA7EPIPqOaUKJhG9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJNTMs4vpqJG6cYEJ3tmdQyvgHn7/94ZAxBhGfv0sRBZ2MYnHW12FRf+YBS7wK4IVOJMCGxrY4PddkXW/Hja/iBG2sWHrU3xO3Lquy8ZmSBxrGsypxSGVTszEY+nLFFzKlWXDtDNRWCaeGtWBFcsR9EeYlx9em+Dx7k3hsacmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IvPMsUPI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n6Y+ufwBSCHTehVAd4FmUyt5EOEPwFwQlTOCxOoQxoM=; b=IvPMsUPIp0uMcWq9ElkGRx4nxj
	8BZDJWGagTIBHt02CS2+3mTQko6hrLpN/k6R7L5lMamsJ1L+TDZT/YEmHvEx4icAdrAMIheUtCJbF
	l0/voIT9g5HrYPc6L9Beb0empA08Bd8frY419JXyCcn3XNSmgXjlxfUNvHz0L/fY3shI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rb1hp-008022-SF; Fri, 16 Feb 2024 18:08:57 +0100
Date: Fri, 16 Feb 2024 18:08:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Question on ethtool strategy wrt legacy ioctl
Message-ID: <4c6221c6-6c14-4799-8cc6-0f8129a8dcab@lunn.ch>
References: <77a48e2f-ddb1-44d8-8e3f-5bc5cb015e9f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a48e2f-ddb1-44d8-8e3f-5bc5cb015e9f@gmail.com>

On Fri, Feb 16, 2024 at 11:53:26AM +0100, Heiner Kallweit wrote:
> When working on ethtool functionality on both sides, userspace and kernel, the following questions came to my mind:
> 
> - Is there any good reason why somebody would set CONFIG_ETHTOOL_NETLINK = n ?

An embedded kernel might do this, to slim the kernel down a
bit. busybox does not have an implementation of ethtool(1), but it
does make a couple of ethtool ioctl calls in some of its commands.

> - If for a certain ethtool functionality ioctl and netlink is
>   supported, can the ioctl part be removed more sooner than later?

Depending on what you removed, that would break busybox. We cannot
force users to make use of netlink.

      Andrew

