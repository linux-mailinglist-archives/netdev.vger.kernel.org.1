Return-Path: <netdev+bounces-226916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB55BA6218
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 19:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D784A6415
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CE01CEAD6;
	Sat, 27 Sep 2025 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YAxPtiZx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D51BC58
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758994571; cv=none; b=LMXBFgPhbYXT7a4ayIAuEGApZgUipQCMC/9JHU7ALmWvZsxnughwJkq9XLdPPuUANJkN2siMwQo7xYAqxjjtpfNbaoLK6bIHXb/FSOMp6YLiXfVodMj6+4tzquvAIUFEq4Mx+ayih4AuRdTkW+uFBTD4na6YRKtC5HG7hrWYQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758994571; c=relaxed/simple;
	bh=NYbLyL1Ta32JRd/r7EHtYmzuB8ZdrAP/l0xJlDjUY2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie6pwA/BVGtwMHNBBZhVH9mcHRkl51uomlM9dZdFqLQdBv2fprfJ+hWYwL5KsGOhi0JBwS31jb2roh9ygFAWJZXK++ZO51BlOtYEgbLkwE9rKp4/7ZlQU5FrAYR6EJum3ku3V3O0MWC9lwj/xltYBTJ2hXr9T2xXGhxL1FTR+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YAxPtiZx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=tcqyK7u9jb2PRpyNKKesbwOPVdpLvVy9mGmVMWMD6Ko=; b=YA
	xPtiZxqP7Li7j5SN9ahpCAnbKBv7PLylYDLI5gJgj3vooMpZj/KjsBA5QBJgFrroaaw8vHt3jNZZJ
	BQjrDjlkI+idFHKMbdVLxH/gV9a+tNpqAcu3jhJCB8jwmYnnQawCkRXI3eoGLL3dGFS+gwVFgh07X
	dotOQZPf4PWHM5k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v2Yq6-009eHQ-3D; Sat, 27 Sep 2025 19:36:06 +0200
Date: Sat, 27 Sep 2025 19:36:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, kieran@sienda.com,
	jcschroeder@gmail.com, Max Hunter <max@huntershome.org>
Subject: Re: [RFC net-next 3/5] net: dsa: mv88e6xxx: MQPRIO support
Message-ID: <d2d289ca-b40c-4e83-8fb6-ccf53d572642@lunn.ch>
References: <20250927070724.734933-1-lukeh@padl.com>
 <20250927070724.734933-4-lukeh@padl.com>
 <79953e8f-a744-457b-b6b8-fa7147d1cbf5@lunn.ch>
 <B2B00AEE-521F-48D1-8290-18A771986AF4@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B2B00AEE-521F-48D1-8290-18A771986AF4@padl.com>

> > 
> >> + *
> >> + * @param chip Marvell switch chip instance
> >> + * @param hilimit Maximum frame size allowed for AVB Class A frames
> >> + *
> >> + * @return 0 on success, or a negative error value otherwise
> >> + */
> > 
> > kerneldoc wants a : after return.
> 
> Should also be for @param then? Seems fairly inconsistent on a brief survey of other drivers.
 
Ah, sorry. I missed you did not start the documentation correctly, so
it is not even considered kerneldoc.

You need

/**

to start the block.

https://docs.kernel.org/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments

> >> +static int mv88e6xxx_avb_set_hilimit(struct mv88e6xxx_chip *chip, u16 hilimit)
> >> +{
> >> + u16 data;
> >> + int err;
> >> +
> >> + if (hilimit > MV88E6XXX_AVB_CFG_HI_LIMIT_MASK)
> >> + return -EINVAL;
> > 
> > Does it make sense to check it against the MTU? Does it matter if it
> > is bigger than the MTU?
> 
> I don’t think so; this is hicredit in tc-cbs(8).

O.K, i've no real knowledge of AVB...

> >> + * - because the Netlink API has no way to distinguish between FDB/MDB
> >> + *  entries managed by SRP from those that are not, the
> >> + *  "marvell,mv88e6xxx-avb-mode" device tree property controls whether
> >> + *  a FDB or MDB entry is required in order for AVB frames to egress.
> > 
> > We probably need to think about this. What about other devices which
> > require this? Would it be better to extend the netlink API to pass
> > some sort of owner? If i remember correctly, routes passed by netlink
> > can indicate which daemon is responsible for it, quagga, zebra, bgp
> > etc.
> 

> An additional flag to Netlink when adding a FDB or MDB entry would
> certainly be cleaner. I’m not sure what other devices do, I suspect
> some support similar functionality but do not have driver support,
> because most SRP implementations have managed the switch
> directly. (Mine [1] uses standard kernel interfaces.)

Having an open user space side helps get such an extra attribute
added.

Would the kernel bridge have any use of this? It is normal to add a
feature to the kernel, and then offload it to hardware. 

	Andrew

