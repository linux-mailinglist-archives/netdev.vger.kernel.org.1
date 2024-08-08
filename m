Return-Path: <netdev+bounces-116873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7094BE93
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B804FB2398D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951218DF72;
	Thu,  8 Aug 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sELRpCqF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06D18CBF9;
	Thu,  8 Aug 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124053; cv=none; b=qxWY8CDuYi6zrQDZauN1KUDSZywgkrnXEP2izNzBwffy+7DXrrX6YRjgYg7wL8NdqCJkxZbjPqd3OU/X8SiF1Xx5jopmJPpqnOXzXDjyxFRgposQc/Ke6NPu4EA+ClberLEprNuwEMRnhmeNOXz/t9tUh7xHzZrs+Dwo5AMyigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124053; c=relaxed/simple;
	bh=dQPzyySCXLyZFd8NmQ9l/x6DDKkXjc5nUN1HzZcUkAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu6myTe2Ph3TFCIS7M2ggojgVTNpcQfEVcBM/RoQI1SQ4ouarVb1SDeUKjelhFIMSH8CsA8J6jgyXwJW8l84awUSGmmpnhp2aegL3zc/K7G+1T1TwBg1PrLTmwbXj2nmpmqcIPRmLhmTEjI2pJrfPV/KGl9nFTNpAoUlmXo8MO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sELRpCqF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=PzlJ5mngJfIiAjkLx0ehprzUhkgfxcL0aVoE2kvi+1g=; b=sE
	LRpCqFfWeTZY8l8TGI4Qid1RdFr7DHf/TzKQhGHQxy9h7BlCxXBOOVE1byUl4NG6FmDLGwjMahU6W
	M9yg6wUjoBfkGJbPA7q025sEfl+VSvx+Xr7IkrCD7Sq0PyYcIJo5NN78KLbgP6BV8W/Jm2PHfJBxI
	GpzZHMUDtuT9rEY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sc3H7-004I6m-2f; Thu, 08 Aug 2024 15:33:53 +0200
Date: Thu, 8 Aug 2024 15:33:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	Jakub Kicinski <kuba@kernel.org>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.li@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH resubmit net 1/2] net: fec: Forward-declare
 `fec_ptp_read()`
Message-ID: <30145adc-b1bc-46c8-beb2-80799f2f1608@lunn.ch>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
 <1d87cbd1-846c-4a43-9dd3-2238670d650e@lunn.ch>
 <20240808094116.GG3006561@kernel.org>
 <449a855a-e3e2-4eed-b8bd-ce64d6f66788@prolan.hu>
 <20240808113741.GH3006561@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808113741.GH3006561@kernel.org>

On Thu, Aug 08, 2024 at 12:37:41PM +0100, Simon Horman wrote:
> On Thu, Aug 08, 2024 at 11:49:29AM +0200, Csókás Bence wrote:
> > On 8/8/24 11:41, Simon Horman wrote:
> > > On Wed, Aug 07, 2024 at 03:53:17PM +0200, Andrew Lunn wrote:
> > > > On Wed, Aug 07, 2024 at 10:29:17AM +0200, Csókás, Bence wrote:
> > > > > This function is used in `fec_ptp_enable_pps()` through
> > > > > struct cyclecounter read(). Forward declarations make
> > > > > it clearer, what's happening.
> > > > 
> > > > In general, forward declarations are not liked. It is better to move
> > > > the code to before it is used.
> > > > 
> > > > Since this is a minimal fix for stable, lets allow it. But please wait
> > > > for net to be merged into net-next, and submit a cleanup patch which
> > > > does move fec_ptp_read() earlier and remove the forward declaration.
> > > 
> > > That makes sense.
> > > 
> > > However, is this a fix?
> > > It's not clear to me that it is.
> > 
> > Well, it's not clear to me either what constitutes as a "fix" versus "just a
> > cleanup". But, whatever floats Andrew's boat...
> 
> Let me state my rule of thumb: a fix addresses a user-visible bug.
> 
> > > And if it is a pre-requisite for patch 2/2,
> > > well that doesn't seem to be a fix.
> > 
> > It indeed is.
> > 
> > > So in all, I'm somewhat confused.
> > > And wonder if all changes can go via net-next.
> > 
> > That's probably what will be happening.
> 
> It does seem like the cleanest, and coincidently easiest, path.

If it does not really fix anything, then net-next.

   Andrew

