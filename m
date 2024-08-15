Return-Path: <netdev+bounces-118860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E6953489
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CEC1C20D3F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E691A3BCA;
	Thu, 15 Aug 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NC/U8XBm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712761A2C35
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732025; cv=none; b=H2O22N5K9FB/rlHzdSZa+8aH0ndzVkS25SbZkdtus+X8Qtm7FkHdC6052V59BtJS/8NQvlBEjT3UdfWC3PpW6tzb8179SFLdyhd6w7VS/i5U2k8x/gO/Bh+z/nGcVvXQjpui5U3tTKWUNPJmuco8ZMILqCKVi/oWS0RptHG0VgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732025; c=relaxed/simple;
	bh=hdSMf2J9Hr/cKE4Rl9/fu+MBaSuTj/N1mudCEX2bQak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFI4ayfpjvB3TnSUu72R2+cSy88w+gtouCSUmBbzFQlJpOOJu6GV+aX1o71lvCScCZU+5eTcRH/2g8b6ylYycaRrh/F/gBzRg7pyVXZo2CGafBsaFL84B7yALBlQVt4xP5XNjcrRA9sP0OmoDdQWjVax1Lc+2mQwJFkjgvJBL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NC/U8XBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3ninEvBj3BKY/YJXH7u6tbwW+gt3fQsqvRqPhhX3jF8=; b=NC/U8XBmI/rcxv/QXw8+TJcE06
	s/2/bWUaqbNeujLPOE15HRZ4TXLa47ivwGpS2TnCkHaqy9YIqFRLkpKTY3DHoKu5UTTgHAyF9Uwpc
	6l7ISDS2BQNk6/gsA82U576kGj/VgI92Oq/IlcCUV7oHhuq9QbKktK8/r3xTaf6f0/EI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sebRH-004qhH-2h; Thu, 15 Aug 2024 16:26:55 +0200
Date: Thu, 15 Aug 2024 16:26:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <21ce3aec-7fd0-4901-bdb0-d782637510d1@lunn.ch>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
 <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
 <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>

On Thu, Aug 15, 2024 at 11:40:28AM +0200, Maciek Machnikowski wrote:
> 
> 
> On 15/08/2024 05:53, Richard Cochran wrote:
> > On Wed, Aug 14, 2024 at 05:08:24PM +0200, Maciek Machnikowski wrote:
> > 
> >> The esterror should return the error calculated by the device. There is
> >> no standard defining this, but the simplest implementation can put the
> >> offset calculated by the ptp daemon, or the offset to the nearest PPS in
> >> cases where PPS is used as a source of time
> > 
> > So user space produces the number, and other user space consumes it?
> > 
> > Sounds like it should say in user space, shared over some IPC, like
> > PTP management messages for example.
> 
> The user spaces may run on completely isolated platforms in isolated
> network with no direct path to communicate that.
> I'm well aware of different solutions on the same platform (libpmc, AWS
> Nitro or Clock Manager) , but this patchset tries to address different
> use case

So this in effect is just a communication mechanism between two user
space processes. The device itself does not know its own error, and
when told about its error, it does nothing. So why add new driver API
calls? It seems like the core should be able to handle this. You then
don't need a details explanation of the API which a PHY driver writer
can understand...

       Andrew

