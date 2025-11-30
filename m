Return-Path: <netdev+bounces-242835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1979BC9545C
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 21:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52C753424DD
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B1221545;
	Sun, 30 Nov 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jTLmQRdf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF97640E;
	Sun, 30 Nov 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764533866; cv=none; b=enlxHkNBIr54bD/3xY+kb1l7bzxja8eQOFn/u7MmerrySPs31hV5rg5A1jgfiEYjGxRz22uVWKUOdNOsoYbGwnkCp/0DqrwjmXyMqWfVPvf1J8TIr3fWwOz20SoGSoMyhpNnfbcKOZknayRKpdqwJPBGVWOto2USEfczo+Fs+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764533866; c=relaxed/simple;
	bh=DYRAh9KflgXV1PkjrqXZyEYkWix4qtvJ4wy1cspUhKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khxzQgpt1MsWBynRXcnFVDEDIN/NHs5cD/VEtDjtE0DjtKCMZDpljc1rzdPPyK57UUlbKDkWKjTl34jq1/G9e3FTH6jVo18TkoC5FlybRz76TFHHkmLSEJSn+R8Q9wzR94pa7gOaJEdIPWecqSKOS4zTwVA6Ggrh+79/0SjP6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jTLmQRdf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TMeL4JyWTglPNStJrCnRRegNxn7l/H0tOrgAzvtGHzw=; b=jTLmQRdf4HJhzV66zMbIIGcOdK
	tId1vBslJDT5vLxueql2nfF37y4DcGRxg9XZzVq39KHCFivb6Wss3r05d3u42f6zeYCNL8m4ZdVzC
	vnmIDC1OUSjYLAF0q0O1/cJR76fWo7sltq7jsWObxvu3GpoHrxbP9zO7Cq13IjSaF7MU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPnrH-00FTH9-QN; Sun, 30 Nov 2025 21:17:23 +0100
Date: Sun, 30 Nov 2025 21:17:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130080731.ty2dlxaypxvodxiw@skbuf>

On Sun, Nov 30, 2025 at 10:07:31AM +0200, Vladimir Oltean wrote:
> On Sun, Nov 30, 2025 at 02:11:05AM +0100, Andrew Lunn wrote:
> > > -		gpiod_set_value_cansleep(priv->reset, 0);
> > > +		int is_active_low = !!gpiod_is_active_low(priv->reset);
> > > +		gpiod_set_value_cansleep(priv->reset, is_active_low);
> > 
> > I think you did not correctly understand what Russell said. You pass
> > the logical value to gpiod_set_value(). If the GPIO has been marked as
> > active LOW, the GPIO core will invert the logical values to the raw
> > value. You should not be using gpiod_is_active_low().
> > 
> > But as i said to the previous patch, i would just leave everything as
> > it is, except document the issue.
> > 
> > 	Andrew
> > 
> 
> It was my suggestion to do it like this (but I don't understand why I'm
> again not in CC).
> 
> We _know_ that the reset pin of the switch should be active low. So by
> using gpiod_is_active_low(), we can determine whether the device tree is
> wrong or not, and we can work with a wrong device tree too (just invert
> the logical values).

Assuming there is not a NOT gate placed between the GPIO and the reset
pin, because the board designer decided to do that for some reason?

So lets work on the commit message some more, but i'm still not
convinced it is worth the effort, unless there is some board today
which really is broken and cannot be fixed unless a change like this
is made.

	Andrew

