Return-Path: <netdev+bounces-94960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD978C11B2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B24B1C2161E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44215ECE3;
	Thu,  9 May 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vyKrQ/9l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBC15E1F8
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267348; cv=none; b=RvXTvQzIVLT5s79i8e8ygFqpZuCHLLFsAvt27GuC6aiUItJIPjfB4cfFZnbWa0MWlJ7LvwP7Rdaro/Ix+jWwS8f+Z7xa+xTf+35o/LtdLdqayRsIQ2qP6eLYGD+71n6HE+udyhJyfRh4RgKik8DpQVPKMfyJUn/ovHCD/DNge+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267348; c=relaxed/simple;
	bh=uG5KODxmK0MsnrRd85Q507j5S4JANMDlCSZbRJJUcLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwXd/0J4QiouVDSbcw9A6/BM02LvH+/ZapQdBzMxU5b62uKLMkGZR8dAfXBm7pgqEb3VuMFXFoN3HOc2Pb2np/9p5QparHMCVRsrCqK+yeuQPNdZDOMxgrtLsbXWb41S0tZ/sQ4iOX7xxuMu+yxSgIYy20Dh6Ouc77pO4ffv21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vyKrQ/9l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8BqYucRfgcNv16eSBYpfbAvVjbo3HGj4sQn9A4Gw8pU=; b=vyKrQ/9l5EIZws2MVldKdqec2h
	Y732nLv9R5wC9S/5pwNlVQYRcvvWaRSKuO6akJR3ccvf+vpA5K9fUq4+OkpkmKTrYlMAsNuFYHYRJ
	B1TbTZK43B7ILk5sAcGmM/G3R7lFmR1RpQu6Ki1eUXgw57cafXDYmBcWRPmrn28lBRNU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s55OJ-00F3No-3p; Thu, 09 May 2024 17:09:03 +0200
Date: Thu, 9 May 2024 17:09:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <d5981b17-c045-4640-a15c-32cc662894bc@lunn.ch>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>

> +/**
> + * enum net_shaper_metric - the metric of the shaper
> + * @NET_SHAPER_METRIC_PPS: Shaper operates on a packets per second basis
> + * @NET_SHAPER_METRIC_BPS: Shaper operates on a bits per second basis
> + */
> +enum net_shaper_metric {
> +	NET_SHAPER_METRIC_PPS,
> +	NET_SHAPER_METRIC_BPS
> +};

I think we need a third value. In the hardware i'm talking about, the
8 queues themselves don't do any shaping. All i'm configuring is WRR
vs strict priority order. So ideally i want something to indicate this
shaper does not actually shape.

       Andrew

