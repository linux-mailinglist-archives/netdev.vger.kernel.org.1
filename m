Return-Path: <netdev+bounces-66546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1FB83FB1A
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E111C2094C
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69289446A3;
	Sun, 28 Jan 2024 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hELPDoGd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D645954
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706486079; cv=none; b=DH4dzLjsuQnYvvtGpVtX7YtgxBOXZuH2CdwT8EryAkbCd91EzQvr3+r3E3X/zVBwTZHv6eJG1t9Qb8nTUF1KhCTCzwq4Ibwo8EDCGE6JyHMuHQ4SBC95VEspq4QyMTg2VqnN5gNGh/4rtA25qiABsnMgvBdJgWKgXfhXgMlSG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706486079; c=relaxed/simple;
	bh=Ddw4508Wbq2c/pY4vDL30UAxNbk0oa+JON+ap1Z1Ccw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntOcakEH9xVvMhQ3MatpTHD1Ld/Z9NORvskZ7apA7+6Fd70EchPwJrmlJKFi+z+SM4tHOW0GnkzNr2AqAuRrTw2B6tXAqnYdp3g8DW5pXmkI9UXA/rOUxxj9TzDjlJ+Q2RNkdgZiJmQeGLNJXbGQBiFY6olofg+oliY6hrXWmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hELPDoGd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5q8fIwEXMm9D6CYHXgtOYXfIZRSa19Zi7jH17N4n1h8=; b=hELPDoGd7qV2BF9hHy7G81KTtB
	UuZyUDHttyV+tOQipGxuqGXgFN67114Sfb+L6gWlII07EO82SzqjRBcaUghEk1aJdnXXIg6zizH4b
	wMY0v5emHQLBzE488s4/NIycOnZJKITjjSPj1feUN4cfqwXrz53RbguPfSEcRDo8bM6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUEys-006Kjl-40; Mon, 29 Jan 2024 00:54:30 +0100
Date: Mon, 29 Jan 2024 00:54:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/6] ethtool: replace struct ethtool_eee with
 a new struct ethtool_keee on kernel side
Message-ID: <1dc1eba4-d74c-47b5-95db-ad2dfde2cbd7@lunn.ch>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
 <a3842379-1f85-4a62-9bf3-53a17f813668@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3842379-1f85-4a62-9bf3-53a17f813668@gmail.com>

On Sat, Jan 27, 2024 at 02:25:09PM +0100, Heiner Kallweit wrote:
> In order to pass EEE link modes beyond bit 32 to userspace we have to
> complement the 32 bit bitmaps in struct ethtool_eee with linkmode
> bitmaps. Therefore, similar to ethtool_link_settings and
> ethtool_link_ksettings, add a struct ethtool_keee. In a first step
> it's an identical copy of ethtool_eee. This patch simply does a
> s/ethtool_eee/ethtool_keee/g for all users.
> No functional change intended.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Lets see if it passes 0-day. But:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

