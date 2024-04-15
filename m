Return-Path: <netdev+bounces-88122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F68A5D94
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD2B2B2267A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6E1157485;
	Mon, 15 Apr 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sq/IyNDJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16424156F31
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713218640; cv=none; b=MYJcRAzwhzWJtnR5KF7SgGit2G/9sWPISbxKqyPvdKNNP1/0twJL+2EsQptleuT1o4EViylHpoSXsUQCV4ad/7ndVFvxzhJSySypQ2W6pdz4/9gpjuPycH2UEm2npfwEm3EcleCcwIL0CF/pn1oNQ71bxMl3sqcH0eR4aMCVzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713218640; c=relaxed/simple;
	bh=J+fYbj3a7gasvITQzaPd5JI1Op9dd0PU05k09NqZ2Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDHysV2FS4+91l6dy+/owbTz7JySXey6P10BuPlbaVBM9nqEQrVEe/Y99QSGKyj4kBIXeAthpokVsaiQjIxW9Ue7VooMjCMLZjPY+I9GLvv4jGuPKdtTaQxJfWqshpTnsdCAShrMlECpV77r0DINAQEmdLgVNRlAzLem06x7EE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sq/IyNDJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oxrf3akoGwRFkimu+tMKpVP07mO1UfmnTsS0nQnyHfI=; b=Sq/IyNDJQh2Gef61+STytwjNgn
	BraETNwrzA9KCNdttNOJNcNoQNUEm4BwQEdimN4KGyGffheiJrpVi9V7+EoYQt4su9gKmSy5jPO2G
	YIynYSYALfGDyCX3HoKx2BcuaTOSqvPDwhuQ40GIRa99CddjtyzWQ3Z61D/culTrIwuk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwUQX-00D52B-Eo; Tue, 16 Apr 2024 00:03:49 +0200
Date: Tue, 16 Apr 2024 00:03:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com,
	marcin.szycik@linux.intel.com, anthony.l.nguyen@intel.com,
	idosch@nvidia.com, kuba@kernel.org,
	intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <6514e6a9-3b4d-48ba-b895-a12c5beff820@lunn.ch>
References: <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
 <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
 <dc601a7c-7bb7-4857-8991-43357b15ed5a@lunn.ch>
 <ad026426-f6a4-4581-b090-31ab65fb4782@intel.com>
 <61a89488-e79a-4175-8868-3de36af7f62d@lunn.ch>
 <206686dc-c39b-4b52-a35c-914b93fe3f36@intel.com>
 <e4224da7-0a09-41b7-b652-bf651cfea0d0@lunn.ch>
 <cf30ce2e-ab70-4bbe-82ab-d687c2ea2efc@intel.com>
 <c6258afd-2631-4e5d-ab25-6b2b7e2f4df4@lunn.ch>
 <fb1a53ea-d5cd-45a1-9073-450f6a753f87@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1a53ea-d5cd-45a1-9073-450f6a753f87@intel.com>

On Fri, Apr 12, 2024 at 03:21:24PM +0200, Wojciech Drewek wrote:
> 
> 
> On 09.04.2024 15:39, Andrew Lunn wrote:
> >> This is something my current design supports I think. Using
> >> ETHTOOL_A_MODULE_MAX_POWER_SET user can get what cage supports
> >> and change it.
> >  
> >> This could be done using ethtool_module_power_mode_policy I think.
> > 
> > All these 'I think' don't give me a warm fuzzy feeling this is a well
> > thought out and designed uAPI.
> > 
> > I assume you have ethtool patches for your new netlink attributes. So
> > show us the real usage. Start with an SFP in its default lower power
> > mode. Show us the commands to display the current status. Allocate it
> > more power, tell the module it can use more power, and then show us
> > the status after the change has been made.
> 
> Ok, but do we really need an API to switch the module between high/low power mode?

Probably not. But you need to document that the API you are adding is
also expected to talk to the module and tell it to use more/less
power.

> Regarding the current status and what module supports, there is -m option:
> $ ethtool -m ens801f0np0
>         Identifier                                : 0x0d (QSFP+)
>         Extended identifier                       : 0x00
>         Extended identifier description           : 1.5W max. Power consumption
>         Extended identifier description           : No CDR in TX, No CDR in RX
>         Extended identifier description           : High Power Class (> 3.5 W) not enabled

So you can make this part of your commit message. Show this. Invoke
your new ethtool option, then show this again with the module
reporting a higher power consumption. The reduce the power using
ethtool and show the power consumption has reduced.

Also, in the ethtool-netlink.rst file, clearly document what the API
is doing, so that somebody else can implement it for another device.

Please also document hotplug behaviour. Say I use your new API to
increase the power to 3.5W. I then eject the module. Does the
available power automatically get put back into the pool? When i
reinsert the module, it will be in low power class, and i need to
issue the ethtool command again to increase its power?

   Andrew

