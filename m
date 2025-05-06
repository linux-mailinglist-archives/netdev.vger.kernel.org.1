Return-Path: <netdev+bounces-188333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D5AAC375
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B1F173907
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991D27F17E;
	Tue,  6 May 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="me/MwPh3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10F27F17D;
	Tue,  6 May 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533418; cv=none; b=NOa0UBWKG0dD+j3LZwOsPKuFime2trl03lPemCEiSu+mzkUMaBhDeY9Ouu+R3eDIzYiYwe5t+L87GMUsfJ/aTy+SCnNe9aAdLbmtKAUKgtWShD1QduYcN5QqIi+7EyJJ6rpA3NRBWczpyK5Nb/HHO8ijHkq6PJXX7II2pm/atzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533418; c=relaxed/simple;
	bh=TfGf41BI+CEpoOqGEKh3oXOKY+QC+CgLE8Pee51SleQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ2fLGqujDjc+3F4TU8V7Wp4OXnk7dATo2qViDmWI8LywNjDQ3Ea51N0yrWr+OYsjG6CCru3QeJyUr8G8LrtLVEolyZ5qE+By1i+yxiI0x7MqzwMu8/Oxz51picBNrMosciiFXppCEborv9jcEDRH1rWDzo8gsqqTjZMkTjYN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=me/MwPh3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LjFg4NzOfHgj1oyywetZuH3fvyYFzX5T7Wr9eejsvHY=; b=me
	/MwPh3urNw/U+weqBX9npRAbNuLn2pVCx5lAmrjCRsvWkQ9hmAV/0A6/YuglFD2cFELRrL/jtrpyq
	TNa9qwVfzmUl48jPFAZXyfT4TGNqlcs00lW94ouJBvKQ29uuDhIdWN4KfnKRXvg2rXuRLgxoCBbvd
	Z2EcZmCZd31OYO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCH7h-00Bksz-7V; Tue, 06 May 2025 14:10:09 +0200
Date: Tue, 6 May 2025 14:10:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj.S@microchip.com
Cc: Bryan.Whitehead@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 net-next] net: lan743x: configure interrupt moderation
 timers based on speed
Message-ID: <e489b483-26bb-4e63-aa6d-39315818b455@lunn.ch>
References: <20250505072943.123943-1-thangaraj.s@microchip.com>
 <e2d7079b-f2d3-443d-a0e5-cb4f7a85b1e6@lunn.ch>
 <42768d74fc73cd3409f9cdd5c5c872747c2d7216.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42768d74fc73cd3409f9cdd5c5c872747c2d7216.camel@microchip.com>

On Tue, May 06, 2025 at 04:02:30AM +0000, Thangaraj.S@microchip.com wrote:
> Hi Andrew,
> Thanks for reviewing the patch,
> 
> On Mon, 2025-05-05 at 14:15 +0200, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On Mon, May 05, 2025 at 12:59:43PM +0530, Thangaraj Samynathan wrote:
> > > Configures the interrupt moderation timer value to 64us for 2.5G,
> > > 150us for 1G, 330us for 10/100M. Earlier this was 400us for all
> > > speeds. This improvess UDP TX and Bidirectional performance to
> > > 2.3Gbps from 1.4Gbps in 2.5G. These values are derived after
> > > experimenting with different values.
> > 
> > It would be good to also implement:
> > 
> >        ethtool -c|--show-coalesce devname
> > 
> >        ethtool -C|--coalesce devname [adaptive-rx on|off] [adaptive-
> > tx on|off]
> >               [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-
> > irq N]
> >               [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-frames-
> > irq N]
> >               [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N]
> >               [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N]
> >               [pkt-rate-high N] [rx-usecs-high N] [rx-frames-high N]
> >               [tx-usecs-high N] [tx-frames-high N] [sample-interval
> > N]
> >               [cqe-mode-rx on|off] [cqe-mode-tx on|off] [tx-aggr-max-
> > bytes N]
> >               [tx-aggr-max-frames N] [tx-aggr-time-usecs N]
> > 
> > so the user can configure it. Sometimes lower power is more important
> > than high speed.
> > 
> >         Andrew
> 
> We've tuned the interrupt moderation values based on testing to improve
> performance. For now, we’ll keep these fixed values optimized for
> performance across all speeds. That said, we agree that adding ethtool
> -c/-C support would provide valuable flexibility for users to balance
> power and performance, and we’ll consider implementing that in a future
> update.

As you said, you have optimised for performance. That might cause
regressions for some users. We try to avoid regressions, and if
somebody does report a regression, we will have to revert this change.
If you were to implement this ethtool option, we are a lot less likely
to make a revert, we can instruct the user how to set the coalesce for
there use case.

	Andrew

