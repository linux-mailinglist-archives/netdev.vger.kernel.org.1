Return-Path: <netdev+bounces-116473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B594A8B1
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50E71C20869
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BD1EB497;
	Wed,  7 Aug 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fn5GoOJ3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2EB664;
	Wed,  7 Aug 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037815; cv=none; b=jjXtTD3cUn6L7onmV/GRuPtsGA8uwXUzjf9ew6xTTnqJs8r7CfZjxPJ1jvUjLXnQddYaAC/IUPkGzF2gABHgZehNT2AcvRh/fLdshxidcna0ROAEQXiEJLju5ayCffChoAsFceCFmPjV37EK6nVyNl1dAPlP+sVPUUotU8CV5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037815; c=relaxed/simple;
	bh=oRW6p8QnLw8cxsnh4q9FbcVBrF0LDmrlfTyxgEBpuJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMaFJxZs4rQzjqTeoEH3+PeVCuED8XX8ECsR0QCItmB0xThjgAW9gGhrVhSVR+VhbtjI/0mFCyLsjaWIvmGbOBXu/lSHeBhLEX23kuIjqThAlY2ZWSU+wQv9T/Vj33TPtTI2HVCG+tZ6iADhwysH6F+8STNlIH2tB6J4i3j6AYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fn5GoOJ3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=70Q31U0CBD5gW7Yc2VyHq7sFK+Q9/HxJowQGpKs3dFw=; b=fn
	5GoOJ3HyvAxSNYGMG5juhCBOTuoX8np3zqRAlbgt5KeTrHs4fNvxDCNrchimkgxOgyt1Eb4cBYLP3
	Eljpo8rRNwoln0fZbREPZxZ0xZt3GW30qHtsUw42lRkt30wwuUa5NASzemBJFdHci3Hh5MSquidSz
	dJHc1cXtpRLFvHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbgqM-004Chq-9V; Wed, 07 Aug 2024 15:36:46 +0200
Date: Wed, 7 Aug 2024 15:36:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Fugang Duan <B38611@freescale.com>,
	"David S. Miller" <davem@davemloft.net>,
	Lucas Stach <l.stach@pengutronix.de>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH resubmit net] net: fec: Stop PPS on driver remove
Message-ID: <30d65bc4-22ae-4db8-bed3-442b18d564b8@lunn.ch>
References: <20240805145735.2385752-1-csokas.bence@prolan.hu>
 <20240807080956.2556602-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807080956.2556602-1-csokas.bence@prolan.hu>

On Wed, Aug 07, 2024 at 10:09:56AM +0200, Csókás, Bence wrote:
> PPS was not stopped in `fec_ptp_stop()`, called when
> the adapter was removed. Consequentially, you couldn't
> safely reload the driver with the PPS signal on.
> 
> Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Link: https://lore.kernel.org/netdev/CAOMZO5BzcZR8PwKKwBssQq_wAGzVgf1ffwe_nhpQJjviTdxy-w@mail.gmail.com/T/#m01dcb810bfc451a492140f6797ca77443d0cb79f
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

