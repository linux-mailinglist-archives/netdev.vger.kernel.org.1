Return-Path: <netdev+bounces-250709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E18C9D38F9F
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 16:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99A503012DD0
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141BF1F3FEC;
	Sat, 17 Jan 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jcOeixss"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1768218592
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768665141; cv=none; b=P35EvLyp44xYzUQ2BUOQnbxPfX9S/aHIDpR4HBe9uMFi7OoSg2LuebIQCV8kXdhk5l7TUyAdYFB0MEzrQG4x5ZnQp/IJcOYI+F1Dzg1v7GB8cXESMsDy98IA1M0+MfsGN24qigxMJdQ5MPMgHsGOopXmwf9rbAZQkkVA2gBEJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768665141; c=relaxed/simple;
	bh=mtZUzMrDtDA6a+s7fj2NgKiGIXop2cgjC9AkN+UEQzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISKLSkzVS+Obaan/M3Z9wgw87NnSzRsRJ6bAtP2cB4WoOmv2cGcHRep7Fs7YEJ1n4Uer5qOP5eyBwQ+90Z1AgmE7aXWt14kV+MJ/odvq3JbIuYlo79gULsx782VjjhtLZwJnlsnKorT8N721WkRDkw8R2hvo0NFOFOAlwN7x804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jcOeixss; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fjcLMjup/EL98uyhnXYPPhFWTLcexH36m5E5kSootac=; b=jcOeixss+C56tbrTXIOIjcwq0B
	4E1xaaSDpMEY4HVXdbq/gUHS8BK5PdiW1rvn01bnxjbPe1BkoHyq+J0HgTydqkE+rKb9XVkE6YAUx
	hBaytHQpPccdxZY0RthOKCWPBj23AeQvK4IqeZ8aIqF1TZRB/ZW4SOfXpvQZ3aZhGWEk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vh8b1-003Dl0-Hh; Sat, 17 Jan 2026 16:52:15 +0100
Date: Sat, 17 Jan 2026 16:52:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: macb: Replace open-coded device config
 retrieval with of_device_get_match_data()
Message-ID: <59332b73-2838-4758-ab32-5ba418e4e20d@lunn.ch>
References: <20260117-macb-v1-1-f092092d8c91@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117-macb-v1-1-f092092d8c91@gmail.com>

On Sat, Jan 17, 2026 at 09:46:18AM +0800, Kevin Hao wrote:
> Use of_device_get_match_data() to replace the open-coded method for
> obtaining the device config.
> 
> Additionally, adjust the ordering of local variables to ensure
> compatibility with RCS.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

