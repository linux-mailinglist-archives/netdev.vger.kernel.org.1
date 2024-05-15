Return-Path: <netdev+bounces-96586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072958C68ED
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FB4B209F4
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901515572A;
	Wed, 15 May 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d5QztQud"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFE13F44E
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784098; cv=none; b=PinbTpAgoISgio5KRBwDK50s+scJCcLl2QYCWlHLyFfTj6+WGcr/17Y3/MXKyJAbO1P3rfZFEaepPEcFEu4TenTyJIoNw1vAOtVZFR4plKUZocHcRbj0HXYTAasbFrRp6BxksnH2r0HyYANvILZ3WbBmOamXm0jBQ4XsZuCDs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784098; c=relaxed/simple;
	bh=uc2B356NgOd5xziKevFPSAwaBRXvTWkP8ZmbBGMBYGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8g99/3yBFnogjNvTPxmc36WFhscQr3vjXPpxwAtUxpDSrtKo5J3LqlXQ/xJfP6YimY6aaCR8mxtyincNZQLpobTp5CiAhL+Gsw57Gi8kdRbALT46su6q/W8u7vNFx1N+21oztwjJ9E7hy+qMBvYH4NQoj5UDqy7oaqlMKnOSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d5QztQud; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QPwI0ChI8F6aEXFXOSbeXRXlCjThwTzwtVR2a3FOBMM=; b=d5QztQudkDn1DVdRnEOF/+6dqJ
	PL4rdMWGSQXQHj4XVuWHDB+TVj9jLlFO8+U7Xz29mBjES7vVttlU/NG5CIlNBpVWstjef10wEhdg+
	0uMPWpss0sSOpjmSznRT26JkJtjuG3Nx9Nqg3GbFfMMm4A5dmgwTVIlBCFUVI4icRuyg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7FU5-00FSON-L8; Wed, 15 May 2024 16:19:57 +0200
Date: Wed, 15 May 2024 16:19:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <79767d80-4f9c-4eec-8e9d-32ea94d0e06a@lunn.ch>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
 <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
 <9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
 <f7fa91a89f16e45de56c1aa8d2c533c6f94648ba.camel@redhat.com>
 <a0ada382-105a-4994-ad0f-1a485cef12c4@lunn.ch>
 <db51b7ccff835dd5a96293fb84d527be081de062.camel@redhat.com>
 <20240515095147.GB154012@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515095147.GB154012@kernel.org>

> > If I read correctly, allowing each NIC to expose it's own different
> > starting configuration still will not solve the problem for this H/W to
> > switch from WRR to SP (and vice versa).

I also suspect this is not unique to this hardware. I've not looked at
other SOHO switches, but it is reasonably common to have different
queues for different priority classes, and then one shaper for the
overall port rate.

> > AFAICS, what would be needed there is an atomic set of operations:
> > 'set_many' (and e.v. 'delete_many', 'create_many') that will allow
> > changing all the shapers at once. 

Yep.

> > With such operations, that H/W could still fit the expected 'no-op'
> > default, as WRR on the queue shapers is what we expect. I agree with
> > Jakub, handling the complexity of arbitrary starting configuration
> > would pose a lot of trouble to the user/admin.
> > 
> > If all the above stands together, I think we have a few options (in
> > random order):
> > 
> > - add both set of operations: the ones operating on a single shaper and
> > the ones operating on multiple shapers
> > - use only the multiple shapers ops.
> > 
> > And the latter looks IMHO the simple/better.

I would agree, start with only multiple shaper opps. If we find that
many implementation end up just iterating the list and dealing with
them individually, would could pull that iterator into the core, and
expand the ops to either/or, multiple or single.

> > int (*set)(struct net_device *dev, int how_many, const u32 *handles,
> > 	   const struct net_shaper_info *shapers,
> >            struct netlink_ext_ack *extack);
> > int (*reset)(struct net_device *dev, int how_many, const u32 *handles,
> >              struct netlink_ext_ack *extack);
> > int (*move)(struct net_device *dev, int how_many, const u32 *handles,
> >             const u32 *new_parent_handles,
> > 	    struct netlink_ext_ack *extack);
> > 
> > An NIC with 'static' shapers can implement a dummy move always
> > returning EOPNOTSUPP and eventually filling a detailed extack.

The extack is going to be important here, we are going to need
meaningful error messages.

Overall, i think this can be made to work with the hardware i have.

	 Andrew

