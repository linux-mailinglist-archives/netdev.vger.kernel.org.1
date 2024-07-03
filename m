Return-Path: <netdev+bounces-108650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37516924D2C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D15284444
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6A10F7;
	Wed,  3 Jul 2024 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z/DPd1F4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C41804
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719970049; cv=none; b=f3dv0IAIOqgK67FXhVZi1zEiXG3lELALpYxMjWcOuQ9vptu2io4y5sQ1MOmh1zdYlFR51Bg0ugrTzmXkmtRdNXtmz8gP5bgoq5wXoFI8rovsz459cBmwRnd0Z9nucvUZ1OaSfrP7YqOwEb+GZ0KdGQ109ZoY29TporDjr8fZPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719970049; c=relaxed/simple;
	bh=7L960WFOZ5xrpVpGSameSKuR0TTS5JzbeC+Id3Y3AYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwSHXE8F6nJpwY6FP547AjQiY3H9p8CxllMLezsTwSQ/ZYoWM+YUWS+9YKn7AFuk6GV+ZIJOV+AmaJN1t0W5coaVMF0abB7u04Wh7i4urqad+LZYEsVw5V66pJJhJgsQx7g86onwQ9xozR5WDT5qg8gq9IOZxVhbmxG1lswXOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z/DPd1F4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9I9eBGa3q2xcXc9FOmzuahPpktre4U27TwuqQO1e9EQ=; b=Z/
	DPd1F4ygc94nmTe/WnNICU+sgXfOB2Xo7+00j6p5gB7hPE6qy4BsFiKJQh6n5JfCxSDLJNQnBZu1f
	I5EmG5i5Sr+DnnxtxIAJg/yxYOu51eIW4Lztbo0UH1bAJHPD+jrIJCkdjeM++JdlxfH1C4dSubumE
	JgxIPm+bGrUywPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOomJ-001g90-SL; Wed, 03 Jul 2024 03:27:23 +0200
Date: Wed, 3 Jul 2024 03:27:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	kernel-team@meta.com
Subject: Re: [net-next PATCH v3 11/15] eth: fbnic: Add link detection
Message-ID: <d2bb35c5-8c88-4d59-9e6f-4f49625317b5@lunn.ch>
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
 <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk>
 <CAKgT0UcPExnW2jcZ9pAs0D65gXTU89jPEoCpsGVVT=FAW616Vg@mail.gmail.com>
 <281cdc6a-635f-499d-a312-9c7d8bb949f1@lunn.ch>
 <CAKgT0UcAYxnKkCSk7a3EKv6GzZn51Xfrd2Yr0yjcC2_=tk9ZQA@mail.gmail.com>
 <e7527f49-60a2-4e64-a93b-c72ad2cc4879@lunn.ch>
 <CAKgT0UfbUrVR6U-cbNxufQ0MN9Cna0tdC6dPMBJRAHSdj5=C8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfbUrVR6U-cbNxufQ0MN9Cna0tdC6dPMBJRAHSdj5=C8Q@mail.gmail.com>

On Tue, Jul 02, 2024 at 01:59:41PM -0700, Alexander Duyck wrote:
> On Tue, Jul 2, 2024 at 1:37 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > As for multiple PCS for one connection, is this common, or special to
> > > > your hardware?
> > >
> > > I would think it is common. Basically once you get over 10G you start
> > > seeing all these XXXXXbase[CDKLS]R[248] speeds advertised and usually
> > > the 2/4/8 represents the number of lanes being used. I would think
> > > most hardware probably has a PCS block per lane as they can be
> > > configured separately and in our case anyway you can use just the one
> > > lane mode and then you only need to setup 1 lane, or you can use the 2
> > > lane mode and you need to setup 2.
> > >
> > > Some of our logic is merged like I mentioned though so maybe it would
> > > make more sense to just merge the lanes. Anyway I guess I can start
> > > working on that code for the next patch set. I will look at what I
> > > need to do to extend the logic. For now I might be able to get by with
> > > just dropping support for 50R1 since that isn't currently being used
> > > as a default.
> >
> > So maybe a dumb question. How does negotiation work? Just one performs
> > negotiation? They all do, and if you get different results you declare
> > the link broken? First one to complete wins? Or even, you can
> > configure each lane to use different negotiation parameters...
> >
> >     Andrew
> 
> My understanding is that auto negotiation is done at 10G or 25G so
> that is with only one PCS link enabled if I am not mistaken.
> 
> Admittedly we haven't done the autoneg code yet so I can't say for
> certain. I know the hardware was tested with the driver handling the
> link after the fact, but I don't have the code in the driver for
> handling the autoneg yet since we don't use that in our datacenter.

So you currently always force the pause configuration? Or is pause
negotiation not supported in these link modes? What about FEC, is that
negotiated?

I suppose i should go read 802.3.

	Andrew

