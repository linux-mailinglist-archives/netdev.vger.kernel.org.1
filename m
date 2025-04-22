Return-Path: <netdev+bounces-184810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F2A9744D
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ED2170101
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16091E47A8;
	Tue, 22 Apr 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SgZgq42Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025385931
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345630; cv=none; b=VN35oLEWlzvUbLaFWk0haTbFn1+10+6qL7ktMwmQ/brtWK4rHumzVwK5V9c3npqtYmT5d8t3ZUwzjqoD3Sizmt3WLSvyj+C9wBQIB9srkpBLrZtb645+O4WZgBZpBioEOnaF9fPMI4L8nQYVvfyrVUwuJKBK4FbjTNuridjnVPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345630; c=relaxed/simple;
	bh=fHFyBTAGfghKXtEBgbbNU34CxwdlSVHtXnO2PFAfq5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWVzmDMr8u+2ks6R/I2HM+E4OZn+wbQumUb8T9fUDqu9zKWrXogH9L/lFIuqxAz+gbUbPqIlzWz9Vcw20L5Wc84b4xgU7M3pnLbUoPC4lr84gZa/3I9Sc7oBIFfo7V4o3pz4Av5T8cr+H2R2yHxGr1MS/8IsLYQ4/JXnuCg+eKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SgZgq42Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jeBpvjiSIig3bxI+NnygWDQqjOKOZGJvrMMqJdLb2v0=; b=SgZgq42Z8axshu4lpL8FYDvK5K
	ihXXR+Dt5ktaXLrTWPgCYPR2IH4qScuc/O8tUs9+VpJjrQG4DjsbTzRcPf9iFk/I2cFfG6Kn/Imtu
	YKPz11VODIU1jiY2DtyZCT6pZExyPh/0YNduDd3GZ83hf1LJW6Dup1o/ay4/3hJ9hBAs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7I7r-00AEgN-6X; Tue, 22 Apr 2025 20:13:43 +0200
Date: Tue, 22 Apr 2025 20:13:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <e7815c91-e047-4b3e-b3e4-371f30c9dadd@lunn.ch>
References: <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
 <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
 <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org>
 <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org>
 <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <aAfSMh_kNre5mxyT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAfSMh_kNre5mxyT@shell.armlinux.org.uk>

> Should one host have control, or should the BMC have control? I don't
> actually know what you're talking about w.r.t. DSP0222 or whatever it
> was, nor NC-SI - I don't have these documents.

I gave a reference to it a few email back in the conversation:

https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0.pdf

Linux has an implementation of the protocol in net/nsci

      Andrew

