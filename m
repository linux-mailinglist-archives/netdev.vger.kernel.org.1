Return-Path: <netdev+bounces-147772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9019DBB23
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3662820A1
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648961BCA19;
	Thu, 28 Nov 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="atB6N12+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656353232
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810856; cv=none; b=iBPyVNEaxslb6Sxca2m4sWxHS3bEeW/V5W0j5eOyXVyEQmNP99zR270Ofs5pFH4ndq2e5GO5fq7M9yBQK9V7tEiVS/jxGmrMBr4W/8fdJEcejteTnW+ln1ZeNxXC0H4Yu7ppN59r5ER1FJ0DTP5uGocC3W10YXcV98HEER6vt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810856; c=relaxed/simple;
	bh=s9/kUwU5snw3JAHjnaZ5YG3fr+Hn4X5kXG7BYdBPFrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l17KSNT+jNwAh5/OA6mvJbU3NpqqvtNSqkpQxoNXl8MTb4alalGA5o9kK1TqEHDD+qck1FSSZcpxEEvCYrNE2TjzJ9ny+nE3SSHeTLmvCYv4VsDyRMFKoi8hgj2xb8aISYFnY7XpfutyFB1rnKIeEMAOZNdgmkhH7t1TFcIo3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=atB6N12+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3SkfNj0tBeWabH5cAO7t1sseCMAdoniXbGo5dbRXiPM=; b=atB6N12+pdoA6nCy28x3XNeDJE
	0kdKbbOE4SY9dKMVzXHxOVt0vpmXYvTQLX4NPPBQbDcfDWP3knAKkhVtIz3Bw1tohlAeRhOGf+CUu
	i8kCIbyJhnhT/dPVU4zF0OsqlMLEyPMYN8tUv+EoepEdkNY7Qm8SWcodVXnh6WOlZOyU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGhG0-00EijE-Jb; Thu, 28 Nov 2024 17:20:44 +0100
Date: Thu, 28 Nov 2024 17:20:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH iwl-net] ice: fix incorrect PHY settings for 100 GB/s
Message-ID: <1c95b010-cb57-4864-aa0b-82b7093f44d1@lunn.ch>
References: <20241126102311.344972-1-przemyslaw.korba@intel.com>
 <946b6621-fd35-46b9-84ee-37de14195610@lunn.ch>
 <PH0PR11MB4904824FA658713F78CA404D94282@PH0PR11MB4904.namprd11.prod.outlook.com>
 <6cca6089-ed72-407a-8f23-70bb67b42e63@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cca6089-ed72-407a-8f23-70bb67b42e63@intel.com>

> > > You forgot to Cc: the PTP maintainer.
> > 
> > Who is the PTP maintainer? Is it necessary? This is only Intel's driver,
> > I am not sure if PTP maintainer is necessary.
> 
> I was curious for a moment too, but just for a moment :)
> 
> We develop network drivers in the public, so we CC people which could
> have a valuable feedback. For PTP code it's PTP Maintainer, and other
> PTP folks. I'm not sure how interested they are though, @Richard?
> @Vladimir?
> 
> 
> In general it is similar to why we CC netdev. The difference is that
> this code will not go via PTP Maintainer, but it does not matter that
> much for the review/design purposes.

"only Intel's driver" is a bit of a worry. Part of being a Maintainer
is to ensure that all drivers behave the same. There should not be any
difference between an Intel PTP device, a Marvell PTP devices, a
Microchip PTP device etc. They should all implement the API in a
uniform way. A developer for the Intel driver probably does not know
the Marvell and Microchip code, and so could easily do something
different. The PTP Maintainer however has an overview over all
implementations and can point out when the driver is not implementing
the APIs in a uniform way, etc.

What i have also seen is that if one driver gets something wrong,
other drivers might as well. Being a Maintainer you are not blinkered
by corporate identity. You might take a quick look at the other PTP
drivers and see if they have the same problem. You can then ask the
developer to go fix the same problem in all the other PTP drivers.

	Andrew

