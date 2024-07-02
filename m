Return-Path: <netdev+bounces-108608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A285792485B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 21:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D230B22304
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE271C007D;
	Tue,  2 Jul 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LK2+1nh9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F326E5ED
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948802; cv=none; b=ddpvw1iPW/WL/rWGSCNghbHAE1ivLJJSAJd5kepn4x0RLZAdIlqAUYICT4X/4XH1KkT2Vb2s5X+Fr0YhX3EzOyL7KQ9M5DNSekPx5+vuDLi+NcrVo8w2wS6mgfDy8A2/rZoV/HPLVB+MQTlslX/E1EpwEzCXJKsRpRKGGA3krFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948802; c=relaxed/simple;
	bh=uRvrPfVezyFHcX/ZeCoi8rowwbb4plczl2+D9q/ZIRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4ho0fDT0eRYjEdt4agetcjM4wZogCEvjw9M304iLCuK1jNmVKhNdKZD6P3EHcfYmAe4cn82/rJOU8aUdDr6Caiu10PKMzevDwrxaR2TBZ3J72pxIuXwxsbQJGsDHlLfGqCp1RXjzLNRyE3BEThz9/KrEdnSFBGXn+x/wXH/43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LK2+1nh9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=309Rczb1yfKg4vgXLNKEQjCTftmdEEojmcvrhbrS3TY=; b=LK2+1nh9MiKvwEkNCHmuoSVNfZ
	xzyAjh6aBpUAO7ZMnpbNcEMMDKXFtFsLsMXWkIdqnEisqs/hmsRwzmUUl8pKKrH3RFSlJ7EmMcJPg
	u8A5l1czyBa1h6i7fUzq9t4qxGdsBI2tcSi9JRrneye0bVdEVy5uJSu9y4vxR7X4Gbwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOjFa-001fNq-Fr; Tue, 02 Jul 2024 21:33:14 +0200
Date: Tue, 2 Jul 2024 21:33:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	kernel-team@meta.com
Subject: Re: [net-next PATCH v3 11/15] eth: fbnic: Add link detection
Message-ID: <281cdc6a-635f-499d-a312-9c7d8bb949f1@lunn.ch>
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
 <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk>
 <CAKgT0UcPExnW2jcZ9pAs0D65gXTU89jPEoCpsGVVT=FAW616Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcPExnW2jcZ9pAs0D65gXTU89jPEoCpsGVVT=FAW616Vg@mail.gmail.com>

> I was actually going to reach out to you guys about that. For this
> patch set I think it may be needed as I have no way to sort out
> 50000baseCR2 (NRZ, 2 lanes) vs 50000baseCR (PAM4, 1 lane) in the
> current phylink code for setting the mac link up. I was wondering if
> you had any suggestions on how I might resolve that?
> 
> Basically I have a laundry list of things that I was planning to start
> on in the follow on sets:
> 
> 1. I still need to add CGMII support as technically we are using a
> different interface mode to support 100Gbps. Seems like I can mostly
> just do a find/insert based on the PHY_INTERFACE_MODE_XLGMII to add
> that so it should be straight forward.
> 
> 2. We have 2 PCS blocks we are working with to set up the CR2 modes. I
> was wondering if I should just be writing my PCS code to be handling
> the merged pair of IP or if I should look at changing the phylink code
> to support more than one PCS device servicing a given connection?
> 
> 3. The FEC config is integral to the PCS and MAC setup on my device. I
> was wondering why FEC isn't included as a part of the phylink code?
> Are there any plans to look at doing that? Otherwise what is the
> recommended setup for handling that as it can be negotiated via
> autoneg for our 25G and 50G-R2 links so I will need to work out how to
> best go after that.

You are pushing the envelope for current phylink. So far, i don't
think it has been used for anything more than 10G. Although 10GBase-KR
does have FEC, nobody has needed it yet. So this is something you
should extend phylink with.

As for multiple PCS for one connection, is this common, or special to
your hardware?

     Andrew

