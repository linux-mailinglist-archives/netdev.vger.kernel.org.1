Return-Path: <netdev+bounces-148650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB789E2CF7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271411637CD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48493204F78;
	Tue,  3 Dec 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SzBAn0cc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF21A2645;
	Tue,  3 Dec 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257403; cv=none; b=RQ9f1jU2lpiENlG/rW5Af+Mys0Fnx43F8TojA9BxJqsmGd761V2MfFaG395rnyeIk3xTyTfSLha8NvcsoeUYzV1oLIzSLC222Rd0MRrkNVfbDsyto54SCQRaGGuKR2eu7MgGd9kv1XasIY3dv6TIAxg0xQpBS3uDb6TkMWjlGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257403; c=relaxed/simple;
	bh=umzR+Pabnu4PhPhfhwuk/Jjhm1kGG7QyR3afr8nJjc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGzTQD9dH2QAsk4Sm7mNgrqfUz50wWBXhemchFVzsQIP4m1GdNlc07r4C+4ppPAw+yXHnWtbp7m150I5zeHYmbiLWFpuqPK82dCwPf8aKFXjOG4tJbCm43/BwtPSefVugiWyVvLmzhJQY/bw9sO5f9gdZoStAwRuX7o6BsiMcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SzBAn0cc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YR3Q8dOCtBzeMkmIEt1GQjB6YaBram6Lazq4KAifsfk=; b=SzBAn0ccV7tBxaijmOXdXvz1Ey
	u3NWaRLNKvICrtbHp0la9sRrXXJyOuk2qZiqWICI+gdpQtxWytLxRNdPViL93sZqc181Oz3HqhUlz
	4zJE4+tO4U03EYAFc81RGq60Dj22oNQbeW1lSyPYgEW9hzTdBSNHQlCsv5pq9aJ/FZM4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZQN-00F809-6G; Tue, 03 Dec 2024 21:23:11 +0100
Date: Tue, 3 Dec 2024 21:23:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 00/21] lan78xx: Preparations for PHYlink
Message-ID: <0fe2388c-c12b-4957-b4f8-6d576caab789@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:33AM +0100, Oleksij Rempel wrote:
> This patch set is part of the preparatory work for migrating the lan78xx
> USB Ethernet driver to the PHYlink framework. During extensive testing,
> I observed that resetting the USB adapter can lead to various read/write
> errors. While the errors themselves are acceptable, they generate
> excessive log messages, resulting in significant log spam. This set
> improves error handling to reduce logging noise by addressing errors
> directly and returning early when necessary.
> 
> Key highlights of this series include:
> - Enhanced error handling to reduce log spam while preserving the
>   original error values, avoiding unnecessary overwrites.
> - Improved error reporting using the `%pe` specifier for better clarity
>   in log messages.
> - Removal of redundant and problematic PHY fixups for LAN8835 and
>   KSZ9031, with detailed explanations in the respective patches.
> - Cleanup of code structure, including unified `goto` labels for better
>   readability and maintainability, even in simple editors.

We generally say no more than 15 patches in a set. It seems like these
could easily be two sets.

      Andrew

