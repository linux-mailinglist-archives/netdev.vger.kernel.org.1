Return-Path: <netdev+bounces-137293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43A9A54D7
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B61B20DBA
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F1192D83;
	Sun, 20 Oct 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ev5Lnm1q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16E173
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729439252; cv=none; b=WDGnPb57CftnzidUZvTJcIV9Nnxzt8aklPcUfGNek0YHjWCvdgUyRKwoa1OfuMmWfwZMdN4l6UORSmsAqtzzsUaR+yJZrHrBW3jSNyROHSIGewBnlJCxPwfVl4d6CAz8FyVeXNhgL+nEQIjBIXODXt9wfjLvue4YPf3A8ggBt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729439252; c=relaxed/simple;
	bh=re9lroTqnMQNDriJ2+rOSAohApgZlyhJEJxKIDcexkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcTx5DaD72DR1/+4GpnAFIQMlRGS72r5HZkkvgf2MIlqB1bV1xQLoGsW2e9TgpSS6oPRiVecxN/Nv716/YsaqElee09bazg84AMpVl1lUJksy4yDVTn+kLvyRhjBVpzskgX9GJOv/2hm3ZoHcXfCHvXW3YddrUaxLKoOmf7E/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ev5Lnm1q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VD9qS34a4I0PG5PrRhPTE9vKypfJsET8ONOLBc7BFCI=; b=ev5Lnm1qLfxmMPhaUhUaefCi+n
	eMgzK55+Gkh3WnKjGahAtymBBFCaFcRlqs7GNcWbWHNkSpJvR3HLmlYX4blnbTadesEMY3rX1fifP
	WFe7nlC9IzT2W6PvnQ0GDqSJYzMtaOglsEhSs824DswfzHW/zzC9tLjH/UNuZI8y8YGk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2Y9N-00AelY-Q6; Sun, 20 Oct 2024 17:47:25 +0200
Date: Sun, 20 Oct 2024 17:47:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org,
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
	kuba@kernel.org
Subject: Re: [PATCH net v3 2/3] net: dsa: mv88e6xxx: read cycle counter
 period from hardware
Message-ID: <9cc52176-0e9a-48b5-a044-bc13e39d13ec@lunn.ch>
References: <20241020063833.5425-1-me@shenghaoyang.info>
 <20241020063833.5425-3-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020063833.5425-3-me@shenghaoyang.info>

On Sun, Oct 20, 2024 at 02:38:29PM +0800, Shenghao Yang wrote:
> Instead of relying on a fixed mapping of hardware family to cycle
> counter frequency, pull this information from the
> MV88E6XXX_TAI_CLOCK_PERIOD register.
> 
> This lets us support switches whose cycle counter frequencies depend on
> board design.
> 
> Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Shenghao Yang <me@shenghaoyang.info>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

