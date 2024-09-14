Return-Path: <netdev+bounces-128351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A740979188
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 16:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE072845B2
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C41CF7C5;
	Sat, 14 Sep 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z1X3kYY9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665F1CF5E7;
	Sat, 14 Sep 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324803; cv=none; b=NbJ+7lidmYJ6ovtG4d+qDf9aKNtPHqN5Xjr5SQAOTnKSwsjaEpW+3JV4PXSmAa8Qty/XQhgD2qcy2t7azujsAK1tCJiCb7fUn+lSJFGwNXUcBljRNO72td+x9k05NfROSzW8CwLlqjmmWhHRdwbsBc07WUc6esYRXO55clLwy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324803; c=relaxed/simple;
	bh=CtftJoEDizkOk1RNmYsC+zZozt9oPQCBYqbHu3YFQto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRjdZWcdk/9J9vI1kxSQhbLE9LKhi7xWOWXYN1i/xFwUZiQjEw2YAyr9SQ7a+HVdTgyE4if5Z4JWebvaAHDQ3Na3aMQYVoFYQhSZveABBYnf4G147pcH9y8ZoN9E/GLnrw4hF4BcwXCkMu6h9Agc5CkLAFnAnVsxXfqv6ByiT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z1X3kYY9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hGvbU8s6yeOosPbH2naPV/J2CC0GcYStYJhYjeb56BA=; b=Z1X3kYY9OD8RQZNsY/YFImJfa7
	sTXlFzZzxxKlxXgn94i4LcIOM4NbpPt6LqaZmrNvJ/3EduNEaXAj01qhA5zsRGtAZTIgUL6FHrSpu
	gw1chq3yarlv76wHVjZfUuBHwUt5uufD322gpt5t7TRcw1u9Xp5CNR84iTOIrChiF6PI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spTw7-007Smz-Of; Sat, 14 Sep 2024 16:39:43 +0200
Date: Sat, 14 Sep 2024 16:39:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, Daniel.Machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <7e999f47-b9e9-40e3-b6ac-538e06a63fc7@lunn.ch>
References: <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ZuP9y+5YntuUJNTe@HYD-DK-UNGSW21.microchip.com>
 <4559162d-5502-4fc3-9e46-65393e28e082@lunn.ch>
 <PH8PR11MB7965B1A0ABAF1AAD42C57F1A95652@PH8PR11MB7965.namprd11.prod.outlook.com>
 <867aadb8-6e48-4c7c-883b-6f88caefcaa6@lunn.ch>
 <PH8PR11MB7965462BB26287CB056A5EEB95652@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB7965462BB26287CB056A5EEB95652@PH8PR11MB7965.namprd11.prod.outlook.com>

> As I have mentioned before I am not (and will likely never be) a
> Linux expert. I have just been advising Raju from the perspective of
> how the chip hardware works, the drivers I have written for it for a
> different OS, and what our customers have been requiring from us. I
> wasn't advocating against instantiating a second MDIO bus or
> whatever else makes sense in the Linux frameworks/environment,
> specially if the overhead to implement it is low and allows for
> richer or alternative use cases. I was just pointing out potential
> problems based on my knowledge of our hardware and the information I
> was told (now obviously misunderstood and/or incomplete) about these
> newer Linux frameworks (phylink, xpcs, sfp) by Raju / was
> understanding from your email.

Not a problem. That is partially why we do reviews, to make sure the
architecture is correct. And there is a tendency for developers and
drivers coming from other OSes to re-invent wheels, because some other
OSes do not provide those wheels. With Linux you have a bigger API to
understand, but less code to write.

	Andrew


