Return-Path: <netdev+bounces-94352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD48BF408
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 03:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C46EB2111C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3E8F55;
	Wed,  8 May 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o4sHlZlq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64E8BE7;
	Wed,  8 May 2024 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131441; cv=none; b=lJ9T1arbKy4mhhcy+eHvCQdUhE0QJaD5wAcOSdUZdHo+7WwD5uDavvigoi45S4P40oOoq531yexbZMXmoNcERmPT+UMa5OBS9HlKVt9Ukgo+0iti1G8HU2kO2nApCrSqgDvuQWVCbdhT3c/L8dpEhixJw6ej5L21N6p2qWd4uNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131441; c=relaxed/simple;
	bh=zqONLFMZ+RLV3aTxjTbrd/tY9/NPSf6XlJ1rkIP09Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnCYAtY+KsqShijKd2T2tO3DZ7uUXyfrkobNn27l+yLdvFvfD5iLJdIjdOlxbhxI1jAiVRfe7jsK1+ESdMlpfqHNAlmOFhQwdEvFlh/pAJLDz0RHJnuyXC3BhyuWaf7NjF5Mklnons8Q1SnaSLLfk4+9gD5LregPjvzlE1Og7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o4sHlZlq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jgAq83NBqzd1KulTfybNaWWoEA54VnjIVFptLf0iddk=; b=o4sHlZlqud6Rz3E/RmXQjl0TzI
	DR6VPg+oC5LHlE8LO9ZdJnwhFckAHZ+ru5mqwpUkyInVrysGl60c8xWS+7K2CShlukpQqlCJANJia
	OezspopvMeH2PdM1v4K7qxp1HGnl4n3/rjLoFu5mtQ37LzPNjqFyUAxKLpSeBWCauKXI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4W2F-00Eu8q-Dj; Wed, 08 May 2024 03:23:55 +0200
Date: Wed, 8 May 2024 03:23:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rengarajan.S@microchip.com
Cc: linux-usb@vger.kernel.org, davem@davemloft.net,
	Woojung.Huh@microchip.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net v1] lan78xx: Fix crash with multiple device attach
Message-ID: <11243bb6-616c-49c9-a0d9-05fd80a5d628@lunn.ch>
References: <20240502045748.37627-1-rengarajan.s@microchip.com>
 <1706dd2a3d24462780599f57e379fa2a1e8e15ac.camel@redhat.com>
 <26d7f478dfa81cadd246771fb41c6763a4b19772.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d7f478dfa81cadd246771fb41c6763a4b19772.camel@microchip.com>

> The issue was when dual setup of LAN7801 with an external PHY(LAN8841
> in this case) are connected to the same DUT PC, the PC got hanged. The
> issue in seen with external phys only and not observed in case of
> internal PHY being connected(LAN7800). When we looked into the code
> flow we found that in phy_scan_fixup allocates a dev for the first
> device. Before it is unregistered, the second device is attached and
> since we already have a phydev it ignores and does not allocate dev for
> second device. This is the reason why we unregister the first device
> before the second device attach.

This is not making any sense to me.

What this driver is doing odd is registers a fixup per device. So if
you plug in 42 USB dongles, you get the same fixup registered 42
times.

What normally happens is that the fixup is registered once,
globally. So you probably want to move the registration of the fixup
into the module init function, and the unregister into the module exit
function.

	Andrew

