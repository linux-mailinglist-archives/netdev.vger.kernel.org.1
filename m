Return-Path: <netdev+bounces-171643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB6A4DF79
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C217A9A49
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535C20469E;
	Tue,  4 Mar 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i48j2a7i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF14204697;
	Tue,  4 Mar 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095686; cv=none; b=s3CzTE2oQT1onJ4mysU8HEXP61sEHwtEI/CJbSXj0WricanU+3/2M2PsQNSg7P4gKYIg48KyKgMypqS/IksFNLXo1L8Hgfme2F950JVfzhx4JH96Ym+p5kDa3RTlyAob/6bWTid8caDgSiyW0IkMnq1FFvxrT6mNaKFm3FxRH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095686; c=relaxed/simple;
	bh=G6IU9EP7KNz6G5yw3RpSAZ9Q7pyx+yKosTGBE2+ghpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M202O9GIPVfwmRHVPknRSJAzLO39lPU0NnNICludKMHdVZ3gXcBeVB1pUSdMLe63tdwHf1wL9aSk2Bl9wL5z/2hC0HH69fLQYFhnzTHLcEaxwdkstHd3XJyl2HrzqRCp7ieGTFve5AsGFIKvj8pF6JQRWVZ2Rs7H77Og8gja/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i48j2a7i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mIe1g7wRJzTWHrk0KluZ5semFFoVlRkgZaZgEsIxn80=; b=i48j2a7ixm9NaBiLJryYlHBRnM
	jUGOl1OOd492N8Fo/cSNPhcyQeGYeG+YL5I45hF5RcNXTASeL649g0g0ksSsvZBQUdRktwKrtrDSk
	Xd5kzAOvOZf44ChXAKwnSOdIHq2Rs72fkKZWArFriaHiykyFAIklVfhF5KYNhRXywq8Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpSW9-0029IZ-Jd; Tue, 04 Mar 2025 14:41:05 +0100
Date: Tue, 4 Mar 2025 14:41:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Link flap workaround option
 for false IRP events
Message-ID: <fbee86b8-fbdd-42ac-a7f9-efc934d59672@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
 <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
 <9f460418-99c6-49f9-ac2c-7a957f781e17@app.fastmail.com>
 <4b5b0f52-7ed8-7eef-2467-fa59ca5de937@intel.com>
 <698700ab-fd36-4a09-8457-a356d92f00ea@lunn.ch>
 <24740a7d-cc50-44af-99e2-21cb838e17e5@app.fastmail.com>
 <316a020a-aa49-700e-3735-f5f810adaaed@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316a020a-aa49-700e-3735-f5f810adaaed@intel.com>

> > > However, that does not really help explain how this helps prevent an
> > > interrupt. I assume playing with EEE settings was also played
> > > with. Not that is register appears to have anything to do with EEE!
> > > 
> > I don't think we did tried those - it was never suggested that I can recall (the original debug started 6 months+ ago). I don't know fully what testing Intel did in their lab once the issue was reproduced there.
> > 
> > If you have any particular recommendations we can try that - with a note that we have to run a soak for ~1 week to have confidence if a change made a difference (the issue can reproduce between 1 to 2 days).
> 
> Personally I doubt that it is related to EEE since there was no real link
> flap.

I tend to agree. Despite the group of registers being called LPI, it
appears this one has nothing to do with LPI? It would probably been
better to have it in page 776, General Registers, but that region is
full.

> > > I don't follow what you are saying here. As far as i can see, the
> > > interrupt handler will triggers a read of the BMCR to determine the
> > > link status. It should not matter if there is a spurious interrupt,
> > > the BMCR should report the truth. So does BMCR actually indicate the
> > > link did go down? I also see there is the usual misunderstanding with
> > > how BMCR is latching. It should not be read twice, processed once, it
> > > should be processed each time, otherwise you miss quick link down/up
> > > events.
> > > 
> > > > We communicated that this solution is not likely to be accepted to the
> > > > kernel as is, and the initial responses on the mailing list demonstrate the
> > > > pushback.
> > > 
> > > What it has done is start a discussion towards an acceptable
> > > solution. Which is a good thing. But at the moment, the discussion
> > > does not have sufficient details.
> > > 
> > > Please could somebody describe the chain of events which results in
> > > the link down, and subsequent link up. Is the interrupt spurious, or
> > > does BMCR really indicate the link went down and up again?
> > > 
> > 
> > I'm fairly certain there is no actual link bounce but I don't know the reason for the interrupt or why it was triggered.
> > 
> > Vitaly, do you have a way of getting these answers from the Intel team that worked on this? I don't think I'll be able to get any answers, unfortunately.
> 
> You are correct, from what we saw there was no real link flap there. Only a
> false link status change interrupt.
 
So if BMCR shows no state change, why is the driver doing anything?

I really would like to understand the chain of events. Once we
understand the chain of events, we can probably come up with a change
somewhere in the chain to break it, so the spurious interrupt is
ignored.

	Andrew

