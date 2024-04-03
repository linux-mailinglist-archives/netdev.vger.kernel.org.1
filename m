Return-Path: <netdev+bounces-84511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD61897156
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5C1C25CDD
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FE14830F;
	Wed,  3 Apr 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hXVfmlFH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADD146D41
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151616; cv=none; b=AcICpHjwdfMmw5ihkduorSfGnlqLTI14AbNh2ZZJle3zHBakJIG0dDigZKAREcxnrNwD0JTNqLlfqwMj+LK1zzsvhOZ5X1+us4SF9/tZBggE3sGMEpskQ7+sg9zcRP6b2OwCZrIZ34xVt/ts07EdRTQxiUkmDdIQOmNOIBZA9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151616; c=relaxed/simple;
	bh=/NmoWUd2wFZgqSLZjmhnsRrfstqyn5vH0Qstwr4qKlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u38ZTYqE2ljggqqojQo1I8nH23KA4OL/CpH7JCf38oF8dovqkBewHbAtoAsBop7bTTalmVaTbXraMk9Jqa0zSYdRIpmCtvIlxK61BeVOVZeTu47PpI4A4lRG6jGgu20+fA1falXdkRsIxEyFsQqOCxu4OUC6oPQrLPKCwindN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hXVfmlFH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u8sbv7OhCWTzdUmHM6hfOPKlrc7untzhQsAD3ri/EUY=; b=hXVfmlFHIk5JMt7p++pZrTxAiP
	6IVs8+h3VpIBOs5t0fMS84AdqOE7ix0d11SXeIewczp3QWbbnW4vqil1lLWY1N5NX3EqBFy3D9Otg
	ujsI5S1ZB9nfaGzP7QR2tpZaIysLJDWVVMLOWxFEAdvFugaBGIcQVS/Pml5RK2yLACP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs0qV-00C54I-HE; Wed, 03 Apr 2024 15:40:07 +0200
Date: Wed, 3 Apr 2024 15:40:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, edumazet@google.com,
	marcin.szycik@linux.intel.com, anthony.l.nguyen@intel.com,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <7b0b3d27-c21d-4765-875b-2dd4681a2ba4@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
 <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
 <dc601a7c-7bb7-4857-8991-43357b15ed5a@lunn.ch>
 <ad026426-f6a4-4581-b090-31ab65fb4782@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad026426-f6a4-4581-b090-31ab65fb4782@intel.com>

On Wed, Apr 03, 2024 at 03:18:44PM +0200, Wojciech Drewek wrote:
> 
> 
> On 02.04.2024 16:46, Andrew Lunn wrote:
> > On Tue, Apr 02, 2024 at 01:38:59PM +0200, Wojciech Drewek wrote:
> >>
> >>
> >> On 30.03.2024 22:57, Andrew Lunn wrote:
> >>> On Fri, Mar 29, 2024 at 10:23:18AM +0100, Wojciech Drewek wrote:
> >>>> Some ethernet modules use nonstandard power levels [1]. Extend ethtool
> >>>> module implementation to support new attributes that will allow user
> >>>> to change maximum power. Rename structures and functions to be more
> >>>> generic. Introduce an example of the new API in ice driver.
> >>>>
> >>>> Ethtool examples:
> >>>> $ ethtool --show-module enp1s0f0np0
> >>>> Module parameters for enp1s0f0np0:
> >>>> power-min-allowed: 1000 mW
> >>>> power-max-allowed: 3000 mW
> >>>> power-max-set: 1500 mW
> >>>>
> >>>> $ ethtool --set-module enp1s0f0np0 power-max-set 4000
> >>>
> >>> We have had a device tree property for a long time:
> >>>
> >>>   maximum-power-milliwatt:
> >>>     minimum: 1000
> >>>     default: 1000
> >>>     description:
> >>>       Maximum module power consumption Specifies the maximum power consumption
> >>>       allowable by a module in the slot, in milli-Watts. Presently, modules can
> >>>       be up to 1W, 1.5W or 2W.
> >>>
> >>> Could you flip the name around to be consistent with DT?
> >>
> >> Yea, I'm open to any name suggestion although I don't like the unit in the parameter name :) 
> > 
> > That is a DT thing. Helps make the units of an ABI obvious. However,
> > milliwatts is pretty standard with the kernel of user APIs, e.g. all
> > hwmon calls use milliwatts.
> > 
> >>>> minimum-power-allowed: 1000 mW
> >>>> maximum-power-allowed: 3000 mW
> >>>> maximum-power-set: 1500 mW
> >>>
> >>> Also, what does minimum-power-allowed actually tell us? Do you imagine
> >>> it will ever be below 1W because of bad board design? Do you have a
> >>> bad board design which does not allow 1W?
> >>
> >> Yes. in case of QSFP we don't support 1W, 1.5W is the minimum.
> > 
> > So if i plug in a 1W QSFP device, it will let the magic smoke out
> > because it is force fed 1.5W?
> > 
> > Looking at
> > https://www.optcore.net/wp-content/uploads/2017/04/QSFP-MSA.pdf table
> > 7 it indicates different power budget classifications. Power level 1
> > is a Maximum power of 1.5W. So does your parameter represent this?  It
> > is the minimum maximum power? And your other parameter is the maximum
> > maximum power?
> 
> Exactly as you described, minimum-power-allowed is in fact minimum value
> which maximum-power-set can be set to (so minimum maximum). the other
> parameter is maximim maximum.

Table 7 in that document is titled "Power Budget Classification". So
how about

minimum-power-class-allowed: 1000 mW
maximum-power-class-allowed: 3000 mW

	Andrew

