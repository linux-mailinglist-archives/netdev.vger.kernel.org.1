Return-Path: <netdev+bounces-94979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2028C129C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68CD281A76
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D78B16F83F;
	Thu,  9 May 2024 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2l7afX+z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F216F84B
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271435; cv=none; b=qK7xOsAnfA9OjpJL/rGXAZ07haPh43pJ2VQMPsMpPQn0ImGtJutZCMmVHGJ0/+giIE9BgRhUGScCHTE1uAS3BFPXga2JHNTGQarpBx7jqlKnPPVXkXDv45N3FdvhqE1BBsAwD3OTnbYqg6JUgDJinh12lGUWxU18Js5N2u+Y8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271435; c=relaxed/simple;
	bh=sYL+tm5cKkY8dZSO20Vahj+h/Jf7ruvKKYNgnnb1SIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z66FYpvaMYJ2qVRwWIcKreU9KotmkZ9/zyre9diCkXDvtEDJmk5/qK3ysgfaqkwZG36PZNpU6l5KVoVPJ4EFIj/oXN5WVkKo9FBRUpKUuMvgwl+hcaMqG4OZVcY8795I4Df6MsKu6btZRKH+BzNV1bNI+bOYz+wn0BFHY4i8+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2l7afX+z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fSGYK3Osj+/uFmjgHX8YsyvjdvHRLEUz/pi2ug1calU=; b=2l7afX+zfWPH65o0aDKnBuDR2E
	iuJfL5rjaLIKL0ltGKY/FO9tbFhLaxJbeHxZCSadJh6X+yWMfc9u6AQh+MgWDl4nnvxtPxQbE0uDr
	UmlzkVSthIHTIvBhQ8uPblBxlxeO+WmqnsA+dD9XZ5IvdOY26T0xFHo5sOmf3/JM1FvQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s56SC-00F3iQ-Lr; Thu, 09 May 2024 18:17:08 +0200
Date: Thu, 9 May 2024 18:17:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <a0ada382-105a-4994-ad0f-1a485cef12c4@lunn.ch>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
 <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
 <9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
 <f7fa91a89f16e45de56c1aa8d2c533c6f94648ba.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7fa91a89f16e45de56c1aa8d2c533c6f94648ba.camel@redhat.com>

> > Now the question is, how do i get between these two states? It is not
> > possible to mix WRR and strict priority. Any kAPI which only modifies
> > one queue at once will go straight into an invalid state, and the
> > driver will need to return -EOPNOTSUPP. So it seems like there needs
> > to be an atomic set N queue configuration at once, so i can cleanly go
> > from strict priority across 8 queues to WRR across 8 queues. Is that
> > foreseen?
> 
> You could delete all the WRR shapers and then create/add SP based ones.

But that does not match the hardware. I cannot delete the hardware. It
will either do strict priority or WRR. If i delete the software
representation of the shaper, the hardware shaper will keep on doing
what it was doing. So i don't see this as a good model. I think the
driver will create shapers to represent the hardware, and you are not
allowed to delete them or add more of them, because that is what the
hardware is. All you can do is configure the shapers that exist.

> The 'create' op is just an abstraction to tell the NIC to switch from
> the default configuration to the specified one.

Well, the hardware default is i think WRR for the queues, and line
rate. That will be what the software representation of the shapers
will be set to when the driver probes and creates the shapers
representors.

	Andrew

