Return-Path: <netdev+bounces-216468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845FAB33F00
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A2C1A84441
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718632EE615;
	Mon, 25 Aug 2025 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oEHtE/we"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06F2EE601;
	Mon, 25 Aug 2025 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123723; cv=none; b=XzHekOGFhDkwJt6tezlYDawRqtz0NCWkvvB45dN1j9RKoAylyz2XwB+ihvurYkiqwbkqvmjLFgfLqlUZam+GdJxJLuYTkCAxlF2CF3yxHPX4o3HGDJCEbEaT7bVXoL8T44nPcwx6Q2wGP42Bb/u+amMSBxJk3D4BGcxFQQrMXXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123723; c=relaxed/simple;
	bh=40pHvwMK7BcfxlID6AIO9kRTEyjTwNwdnjJttXS4c6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfNaQ0ORtwwpm/QkvNvnFNkyFO6um0hVX7fiJLAzbk+ab5UXZcQllY+OB5COI39SvtLpMChhKab1cobSZIOE+690eah5g3ZRUBXp/yp0MlNJ0OQHOreKChRCprkVqBoP2ROUUVs5iTGhPyZBXOjUohYn5zS4baZEqvA9jRLCqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oEHtE/we; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YLkxYcm5PfbpwrBaYz99xb/BPKFw6g9w/mJk0x8ccdI=; b=oEHtE/we30b00BMf4C6OdWy1ea
	d7aKAlkca/QFEFRqieM96p6tk7QJv0nqU6CAyIRaC6UmBp4FX13aoZDa55OQtDgFUMxkZLEHJ2Wky
	Vn4xOw0NvOH3Ybb+fXIEUyfxOcRiqqfRjElvduUP61Uh0Nj3ejeToxbim6BuaVHEKakg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqVzz-005wBj-7j; Mon, 25 Aug 2025 14:08:31 +0200
Date: Mon, 25 Aug 2025 14:08:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alex Tran <alex.t.tran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] Fixes: xircom auto-negoation timer
Message-ID: <6214363b-0242-481d-9b93-2db9e1ba5913@lunn.ch>
References: <20250825012821.492355-1-alex.t.tran@gmail.com>
 <c6c354ec-e4fe-4b80-b2e5-9f6c8350b504@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6c354ec-e4fe-4b80-b2e5-9f6c8350b504@gmail.com>

On Mon, Aug 25, 2025 at 08:44:18AM +0200, Heiner Kallweit wrote:
> On 8/25/2025 3:28 AM, Alex Tran wrote:
> > Auto negoation for DP83840A takes ~3.5 seconds.
> > Removed sleeping in loop and replaced with timer based completion.
> > 
> You state this is a fix. Which problem does it fix?
> 
> IMO touching such legacy code makes only sense if you:
> - fix an actual bug
> - reduce complexity
> - avoid using deprecated API's
> 
> Do you have this hardware for testing your patches?
> 
> You might consider migrating this driver to use phylib.
> Provided this contributes to reducing complexity.

There is plenty to reduce. There is a full bit-banging MDIO
implementation which could be replaced with the core implementation.

The harder part for converting to phylib will be the ML6692 and
DP83840A. There are no Linux driver for these, but given the age,
there is a good chance genphy will work.

	Andrew

