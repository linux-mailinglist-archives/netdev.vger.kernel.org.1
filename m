Return-Path: <netdev+bounces-161687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04FA234DB
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CC3163556
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD9E1946C8;
	Thu, 30 Jan 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sL9aKjXc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23041143888
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266761; cv=none; b=KxDlO5j8dtbitR3iyVC/hrBDfUUn2Vex5OyR8KP2rWbGakX4Ne/H5tJaFC9V7b7A15SF6Rg+2odEujCD12zXbFs4RB7pgeamXpj/3RCf0qrMjJiCb/tt73U6KjMZe/IRB2oCyvsyJgUH5LFXfuPb4x/WmI91c87bdQOmRmPYpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266761; c=relaxed/simple;
	bh=zNrB2GxjzrfJ8hizkyjc9HI/nARSmyUlnF+JzuRJ4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYmHaBYm13wa+V4TJGcePy8Ub+UAChoqfw8aghVhwOfZn1bELk+j6jS0+xnlkKRP+zEtSqIGOGjrDYJyD7Zn6gY10+DAsBTHf2Yut06Uno9M9/TK4GNDpSdbcekec9wtLsd1DoYkJ0cu3+dTgmDoOy1AeTKqHPA//AziHEgwk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sL9aKjXc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WnB8ndnFyjaP3vXmoooGP2vwIIMLPpOecc6Lf7NSRMw=; b=sL9aKjXcK/3C1f96qo81SaPI4d
	TTtZvG28mO4z7Uz9RC60hWLcKLw7MatP2BpDtCAF3iZEBxuBXZFgQQusSI32LXFmr9u6Vnbei+BYy
	41XY8Uhxu+c0dAtPAKHiUiiei/zaZmbhGgMaMbqMIisMIZg/1yUzhB70KvEm0sP69Jbw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdaaM-009Up6-Ti; Thu, 30 Jan 2025 20:52:22 +0100
Date: Thu, 30 Jan 2025 20:52:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Joshi, Sreedevi" <sreedevi.joshi@intel.com>
Cc: "sreedevi.joshi" <joshisre@ecsmtp.an.intel.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Message-ID: <6f9865c7-830a-4f4d-949a-ea073ead994f@lunn.ch>
References: <20250129183638.695010-1-sreedevi.joshi@intel.com>
 <fa054892-b501-4e98-a8a5-6fc9acc68be5@lunn.ch>
 <IA1PR11MB628928A8735D0B5BDBEBB05489E92@IA1PR11MB6289.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB628928A8735D0B5BDBEBB05489E92@IA1PR11MB6289.namprd11.prod.outlook.com>

On Thu, Jan 30, 2025 at 07:10:49PM +0000, Joshi, Sreedevi wrote:
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Wednesday, January 29, 2025 2:14 PM
> > To: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>
> > Cc: hkallweit1@gmail.com; linux@armlinux.org.uk; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > netdev@vger.kernel.org; Joshi, Sreedevi <sreedevi.joshi@intel.com>
> > Subject: Re: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
> > 
> > On Wed, Jan 29, 2025 at 12:36:38PM -0600, sreedevi.joshi wrote:
> > > From: Sreedevi Joshi <sreedevi.joshi@intel.com>
> > >
> > > When attaching a fixed phy to devices like veth
> > 
> > Humm. Zoom out. What is the big picture? Why would a veth need a PHY?
> > 
> > 	Andrew
> [] 
> This issue was encountered when working on a POC to demo the mii_timestamper timestamp
> callback hooks mechanism. We are using veth pairs as we don't have the HW yet. In this demo,
> we connect a fixed PHY to veth and attach mii_timestamper hooks that way. However, as veth device
> (like any other virtual interfaces) does not have a parent, it causes Kernel Oops and on our system
> it needs a reboot to recover the system. With this check in place,
> we could connect fixed PHY and mii_timestamper hooks successfully. I understand
> it is not a common practice to attach a PHY to a virtual interface. However, having a check for NULL
> before accessing the member will be good to avoid issues.

Well, there is a flip side to this. You are doing something which does
not make sense. Getting an Opps is a good indication you are doing
something you should not. And the Opps makes it easy to
debug. Silently ignoring the problem makes it a lot harder to find.

Is there a legitimate use case for a physical network device without a
parent device? It looks like phy_attach_direct() has been referencing
the parent since December 2016, so given its history i'm not sure
there is a legitimate use case.

I assume when you get real hardware you will have both a parent and a
PHY?

	Andrew

