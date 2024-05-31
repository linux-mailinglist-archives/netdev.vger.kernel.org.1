Return-Path: <netdev+bounces-99597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7EA8D56DD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 02:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D750128A0A3
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327B1367;
	Fri, 31 May 2024 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2z/xM3GY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C4A3D;
	Fri, 31 May 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114914; cv=none; b=ROng1vCCN0cCZieCLkS9pheeS1R3JIivO5hX154qDMKvFIPgMprVwEWPioFew81OLm8YhIIiqsCGFB/a3xIEp0suU3srPw3DrHu4e6b3PQfg/esK+2JTytDolhbssHSjwjNC7QoruAqpUdnlN6qNDui2cufQChD9R/7jvL2+rHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114914; c=relaxed/simple;
	bh=rm48JD8+zTQAEVtlC6KRVk0RK56MJgDn3fJMxSO/ivI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDXLxE37/1XkRwjoMjl9iW789riCe1swm/G9wuf153tB9XcEmYTGCIznAC1SmxDd+QUiT0yxIgqq892mERNGNR1Nm6zSjyIUugyOc+T5mLA3307Isx72PG5f3GAruY6HxWdQHz53wO2bXYPE26Qmi5d05RyxsluJ3slckEizEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2z/xM3GY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vp67wFYTbUwXuSwLjkdoCHGgsqLcjt0B0qRwZL8jd6c=; b=2z/xM3GYZDbajIFLk3vtUBEX1v
	eIJvVNVuK0I4Fqhcthga6J4wnrB3L45RNQZ9/NuSua/4rTw1fOp+8Z6K/R/VVXXEktwzc/YjIzRqM
	52L7d9u+3LSIYNXE1WBoLOe4BWGGBmUsCoBZFFu70p+Odu4ODEYJtOGZl2VkgYl9KWrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCq1X-00GQ74-Oc; Fri, 31 May 2024 02:21:35 +0200
Date: Fri, 31 May 2024 02:21:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arun.Ramadoss@microchip.com, Woojung.Huh@microchip.com,
	vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ9477 set_ageing_time
 function
Message-ID: <78e2e9b1-e980-4e67-b2a2-352a06619411@lunn.ch>
References: <1716932192-3555-1-git-send-email-Tristram.Ha@microchip.com>
 <4a467adcdb3ca8e272bd3ae1be54272610aabc9b.camel@redhat.com>
 <BYAPR11MB3558F5B1EEAB802476D36F9CECF32@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558F5B1EEAB802476D36F9CECF32@BYAPR11MB3558.namprd11.prod.outlook.com>

> > Is the additional accuracy worthy the added complexity WRT:
> > 
> >         mult = DIV_ROUND_UP(secs, 0xff);
> > 
> > ?
> 
> I do not know much accuracy is expected of this function.  I do not know
> whether users can easily specify the amount, but the default is 3 seconds
> which is the same as the hardware default where the multiplier is 4 and
> the count is 75.  So most of the time the rest of the code will not be
> executed.

Are you sure it is 3 seconds?

#define BR_DEFAULT_AGEING_TIME	(300 * HZ)

Fast ageing, after a topology change, is i think 15 seconds.

     Andrew

