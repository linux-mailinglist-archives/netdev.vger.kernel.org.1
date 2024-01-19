Return-Path: <netdev+bounces-64408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFAD832F7A
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 20:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66981F242CE
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 19:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFFE55C35;
	Fri, 19 Jan 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dPHeAtF+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC2D53E03
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693458; cv=none; b=Dm7vHhg/3AGaxObKNu0L2aNaUQl0nh+QNRxjpu60wlezP8CmCrV1PpwI5QXBtr5xdQz1b954dJ/+H39qD1ioRyKffMQ9tiEHaJzk/Ij/+5dJvx5Km6RETZ5Un01kkNmsblk5jKjmEj046cA7cFzaDz2HfNeFHo5M2ostOh59nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693458; c=relaxed/simple;
	bh=4bTliHylP7Tey0riMkuw7L7J2zAblWKI8TOPCE4Ow2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEo7HjDHvJfAiKXgAqhNjkn8AZyVkWmkTbCmZYQn5awb7j5LdOSANtFRvNyoHFF1PNrydx2fDDhLqg0hwTT8EkspHBS7RtYQH9UJ/HVv9b98GiyZ6hNfX1E71Ntg3oYpeIYha0hXXnZZ7S72jQyw9IPUBlxNMm4HqxTtoEN7PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dPHeAtF+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AHUEZ2rIPC3BJIatv59YV8Pl6Q4EzzaXn7uBxtdyooE=; b=dPHeAtF+EVuQsBQRQ1j9WT1Bem
	V2tnTDYvTuejyu9aKgg39/MOVm7iJsUuKMOfCWWGESfhIi2r3v4JyKvuI66a0DqkRkaHbktvf9obe
	MkLLCq1kJ8qQho3/nf6z+Sou8xsaO2DP0RCdcVFxQPiGNIbWLY8UMPr7xuHtkbgPgllE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQumg-005aBu-59; Fri, 19 Jan 2024 20:44:10 +0100
Date: Fri, 19 Jan 2024 20:44:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	David Thompson <davthompson@nvidia.com>
Subject: Re: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Message-ID: <a6487dbc-8f86-447a-ba12-21652f3313e8@lunn.ch>
References: <20231226141903.12040-1-asmaa@nvidia.com>
 <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
 <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
 <PH7PR12MB7282DEEE85BE8A6F9E558339D7702@PH7PR12MB7282.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR12MB7282DEEE85BE8A6F9E558339D7702@PH7PR12MB7282.namprd12.prod.outlook.com>

On Fri, Jan 19, 2024 at 06:11:56PM +0000, Asmaa Mnebhi wrote:
>  
> > Is there any status registers which indicate energy detection? No point doing
> > retries if there is no sign of a link partner.
> > 
> > I would also suggest moving the timeout into a driver private data structure,
> > and rely on phylib polling the PHY once per second and restart autoneg from
> > that. That will avoid holding the lock for a long time.
> > 
> Hi Andrew, 
> 
> Thank you for your feedback.

Lets try to figure out some more about the situation when it fails to
link up.

What is the value of BMSR when it fails to report complete? You say
you are using interrupts, so i just want to make sure its not an
interrupt problem, you are using edge interrupts instead of level,
etc.  Maybe i'm remembering wrong, but i though i made a comment about
this once when reviewing one of your drivers. What about the contents
of registers 0x1b and 0x1f?

Thanks
   Andrew

