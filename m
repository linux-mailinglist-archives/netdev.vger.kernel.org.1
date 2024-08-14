Return-Path: <netdev+bounces-118471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31931951B66
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FC31F2291A
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F61B14E5;
	Wed, 14 Aug 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PAMB5WQx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB941B142C
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640899; cv=none; b=K23v3FYaxEdLvNm7T+saRiJnJkNSMfvMrWkIor9wl2oHUw3xRCRSZrutaeIVuKd0aqBQ5a5Y+w+kXwozXvliDBhuyhS50ibJLOvI8QVZJw0lv18D1/e1ngFOo9d586pd90hSGlBRYCUkq8447PY5hfhVFmFXe6O9ZY71wJLFV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640899; c=relaxed/simple;
	bh=KctMPxse9owqidMn71Rsz/8HSq6jPkX+Vt+hjOXLrrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0gNW6YEJYtBL9Mq9c6p2dlca89bk6AGhR895i6llL5qRaUc+E+d1UT8orj9bQiNaNCUcC0wskBA5jbJMuU7Jdyid/AETT+qd7nCYErkjb/C9rkRrzDkH6/LJP3UnYcjqIJzstKkfonWjgMdmYzqxfn3+P+d6UcnBmSSb/hWvzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PAMB5WQx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wOSd+OBDx+0wpZ3WLFWwiHrjC5kYHIOUwP6Cijcu9MU=; b=PAMB5WQxMUDKuruwm64+o4XLFH
	xGRdRT0AI9oqyVx01a3b7XPwP0jMraOLGDiX9+klcn2r+yENfBRVLGExRPlL3vQwutAvb80ybXBfN
	T7ClZRX7dll/+tTulEQ2eifWXPjDSsBs643i5Z0C3QKcrjll4h4HtVBMQtV7WCtqyHL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1seDjT-004lVZ-PE; Wed, 14 Aug 2024 15:08:07 +0200
Date: Wed, 14 Aug 2024 15:08:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org,
	richardcochran@gmail.com, jacob.e.keller@intel.com,
	darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>

On Wed, Aug 14, 2024 at 09:44:29AM +0100, Vadim Fedorenko wrote:
> On 13/08/2024 21:05, Andrew Lunn wrote:
> > On Tue, Aug 13, 2024 at 12:55:59PM +0000, Maciek Machnikowski wrote:
> > > This patch series implements handling of timex esterror field
> > > by ptp devices.
> > > 
> > > Esterror field can be used to return or set the estimated error
> > > of the clock. This is useful for devices containing a hardware
> > > clock that is controlled and synchronized internally (such as
> > > a time card) or when the synchronization is pushed to the embedded
> > > CPU of a DPU.
> > 
> > How can you set the estimated error of a clock? Isn't it a properties
> > of the hardware, and maybe the network link? A 10BaseT/Half duplex
> > link is going to have a bigger error than a 1000BaseT link because the
> > bits take longer on the wire etc.
> 
> AFAIU, it's in the spec of the hardware, but it can change depending on
> the environment, like temperature. The link speed doesn't matter here,
> this property can be used to calculate possible drift of the clock in
> the micro holdover mode (between sync points).

Is there a clear definition then? Could you reference a standard
indicating what is included and excluded from this?

> > What is the device supposed to do with the set value?
> 
> It can be used to report the value back to user-space to calculate the
> boundaries of "true time" returned by the hardware.

So the driver itself does not know its own error? It has to be told
it, so it can report it back to user space. Then why bother, just put
it directly into the ptp4l configuration file?

Maybe this is all obvious to somebody who knows PTP inside out, but to
me it is not. Please could you put a better explanation and
justification into the commit message. We need PHY driver writers who
have limited idea about PTP can implement these new calls.

	Andrew

