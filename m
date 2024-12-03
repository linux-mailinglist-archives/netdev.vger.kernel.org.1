Return-Path: <netdev+bounces-148676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAC59E2E12
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1189B2A1B2
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B814205E28;
	Tue,  3 Dec 2024 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QxB75xax"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC042500D3;
	Tue,  3 Dec 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258887; cv=none; b=Ud70/BXk27BtQkAHoyTrVoXQ+l/Pa2UGmCmX2s9wEgrj560GPQB5gjXIqxcKY+JDOFDWYs3/MMJo33C8/K91fq1GayH/pX/AwsjFfQib8/p4hBsg0vU1mH4sdyUssqK+5Gnj3wPowcuTLnr68eBZBomd6Eev6F3f0bo3tyC+qGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258887; c=relaxed/simple;
	bh=I7+uLqqDmjKbqNKNJ/aU4yAUbwyeGsCFnSOZnY9uO5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7cbJ+jxeI+L8HcqkwMpaPBSDjU00ZKMI2OZJMezNQouCfFcIZPxBEanyQyCV5encldtnxwcTjzBYpxfMHD1DtC0q0OD1UYpfqizhd3ZlPYq4LoCEtd1nJheH69NYwrF/GUsVZmhtd0jD673GGC9E9+wuhHOUExZE9K6ivsaXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QxB75xax; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mln7YYQ79Z8h+U1bfKcco3serkkHm5TE+RqjCLA4eA8=; b=QxB75xaxywChnsCbjLOnaohz6a
	WEMWy43TKwdPIEoaZ6Yttac5tvcDmuJvMBTyOHfjtRMLwlHln1+q8+n4u0s9FygE/ofn1O8xeMPTe
	zGkyzPKAyir9o6IHZxy9X5VGhKG4g/XvfDkIQU5R88uddQI2NB/+/Ji6WKabc79pChL0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZoL-00F8Hh-KC; Tue, 03 Dec 2024 21:47:57 +0100
Date: Tue, 3 Dec 2024 21:47:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for local
 mac addresses
Message-ID: <5b93b521-4cc8-47d3-844a-33cf6477a016@lunn.ch>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203130457.904325-1-asmadeus@codewreck.org>

On Tue, Dec 03, 2024 at 10:04:55PM +0900, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
> 
> The previous commit assumed that local addresses always came from the
> kernel, but some devices hand out local mac addresses so we ended up
> with point-to-point devices with a mac set by the driver, renaming to
> eth%d when they used to be named usb%d.
> 
> Userspace should not rely on device name, but for the sake of stability
> restore the local mac address check portion of the naming exception:
> point to point devices which either have no mac set by the driver or
> have a local mac handed out by the driver will keep the usb%d name.

Are you saying the OTP or NVMEM has a locally administered MAC address
stored in it? Is there a mechanism to change it? The point about
locally administered MAC addresses is that they are locally
administered.

	Andrew

