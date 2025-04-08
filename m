Return-Path: <netdev+bounces-180372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFEA811BD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C567B87B6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5322F145;
	Tue,  8 Apr 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G/blntR4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B522E3E7;
	Tue,  8 Apr 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128642; cv=none; b=iba7uJNLmRXcfu0KiKlu23DQwx7gOltcIa8pGUrQAW/bX7GMgSatXcf9FOvMHdOBqgpwVF8d6HP9RHlRSWiEt/zT4Kix+T7sH54VIhv8gPhFCycFPnTGirb1l1XYHEkRA3YBl3ORE8YUhOO+JJVoDA32Mr+G5SIPAH4bGiq2UAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128642; c=relaxed/simple;
	bh=iG365VUsJjmbYrd2MsyzHwtfg63n3vUP/FuqZWSN6sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBbfIftiBfRoRIgGwhQ0NP6pF2RetbCRMyY9YuTM2gGY7TnZvMlUU6gcdo4finobmGfr4hpxfKbqsA+vZkgREs6hlW25n0jRgRqEY+d15zuXI26cw6Pj0TuJbVl/4fcjv9wcjxhLzOXAHxM1DV8dQBrjvTkwT20DZs1bnhw21A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G/blntR4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gc2itI022s8dW+s9KqI+5JfR2+E5wndR5hXO0nPhlBM=; b=G/blntR4GT2mMoncHyE/hjY+Zv
	NOvxnRYgBX4JWkjvDzSnUG4CjYhiibzDikvqlTcidubSSNr1HIX+rxOx8rP3T0PwT1AblSKGrxzSs
	F2UxzrYwE3fIDJyKUhGYo3ZLoVGB77oBGTJiA6MNxS6Ccqr4WLKlreEsv9X0KDnL3yXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2BWx-008Q8q-Ow; Tue, 08 Apr 2025 18:10:31 +0200
Date: Tue, 8 Apr 2025 18:10:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Pazdan <mpazdan@arista.com>
Cc: aleksander.lobakin@intel.com, almasrymina@google.com,
	andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
	daniel.zahka@gmail.com, davem@davemloft.net, ecree.xilinx@gmail.com,
	edumazet@google.com, gal@nvidia.com, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, jianbol@nvidia.com,
	kory.maincent@bootlin.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com, willemb@google.com
Subject: Re: [Intel-wired-lan] [PATCH 1/2] ethtool: transceiver reset and
 presence pin control
Message-ID: <6f127b5b-77c6-4bd4-8124-8eea6a12ca61@lunn.ch>
References: <8b8dca4d-bdf3-49e4-b081-5f51e26269bb@lunn.ch>
 <20250408153311.30539-1-mpazdan@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408153311.30539-1-mpazdan@arista.com>

On Tue, Apr 08, 2025 at 03:32:30PM +0000, Marek Pazdan wrote:
> On Mon, 7 Apr 2025 22:39:17 +0200 Andrew Lunn wrote:
> > How do you tell the kernel to stop managing the SFP? If you hit the
> > module with a reset from user space, the kernel is going to get
> > confused. And how are you talking to the module? Are you going to
> > hijack the i2c device via i2-dev? Again, you need to stop the kernel
> > from using the device.
> 
> This is something to implement in driver code. For ice driver this reset will
> be executed through AQ command (Admin Queue) which is communication channel
> between driver and firmware. What I probably need to do is to add additional PHY
> state (like USER_MODULE_RESET) and check it when driver wants to execute AQ command.
> 
> > Before you go any further, i think you need to zoom out and tell us
> > the big picture....
> 
> In my use case I need to have ability to reset transceiver module. There are 
> several reasons for that. Most common is to reinit module if case of error state.
> (this according to CMIS spec). Another use case is that in our switch's cli there
> is a command for transceiver reinitialisation which involves transceiver reset.

Now zoom out, ignore your hardware, look at the Linux abstraction for
an SFP, across all NICs and switches.

There are ethtool calls to retrieve the modules eeprom contents. There
is an ethtool call to program the modules firmware. There is an
ethtool call to get/set the power mode. Modules can also export their
sensors via HWMON, the temperature, receive power, etc.

How does your wish to reset the module fit into the general Linux
model of an SFP? Should it be allowed in the middle of a firmware
upgrade? Should the power mode be lost due to a reset? Can you still
read from the EEPROM etc while it is in reset? What should HWMON
report? Should it be a foot gun?

It does however seem to me, what you want should somehow be an ethtool
operation. And it probably needs to be plumbed through
net/ethtool/module.c, and you need to look at how it interacts with
all the other code in that file. And you maybe need to force the
netdev to do a down/up so that it gets the new state of the module, or
you only allow it on an netdev which is admin down?

Your patch needs to explain the big picture, how it fits into the
Linux abstraction of an SFP, and how other vendors should implement
the same operation, if they wish to implement it.

    Andrew

