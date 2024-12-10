Return-Path: <netdev+bounces-150456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8AE9EA49F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922B216383B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDE5FDA7;
	Tue, 10 Dec 2024 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q4N9QmxI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6993233129;
	Tue, 10 Dec 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796147; cv=none; b=StlGYSMRncsh/w11JKIr4yITF+Z8WjQmxgwcKEhNJvjfAXUNZ9rGL4edDtOSFVAPZfjbEM0PV45Bs3CrtEW/nqqXWG1SZkYR9SJJtvoVfCiDDvViSd11vkTiqA6Hy0MnrXalaw87aWM3soFL2vASHxkhD+cT0i7yEzv6Naq4MSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796147; c=relaxed/simple;
	bh=UFoymMTYhp4BrXm5rKK4w1maaS3tC928FwxsMlM8VNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWNYoSBfCwfBSa0py1hccTN672uTZFS//TKwHjP7rxURVT+sINZFHpuspiJujLCI0yK+1XOlmTHSgPdUA8VAVjHKcaKZlcH0xVTzMHCy25kwadwSA5WRJULGzbMF8MiFhKCDwdTPZb5dWNk1dUEgyHEh2AzLLw8t7Mr6Bkl5E04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q4N9QmxI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bmv3Q6D6zEF40A/0kf/Fu9s6MEuaLWegZcE2Ra29lQg=; b=q4N9QmxIbFWMUDM3InsXZeT1XA
	g5N99NcHuwm9d5ZCYUguqrvBA4ARmn8AlaILobBKahk7CeGPykycz4AGK9nGUr07QHTQZfQhul8Zj
	MHATmFTyLu1ZexebjpQSIWV4Dv4IDr4FT87t8O1RDMRRpNAAch7l+1ANYA+6WZ+lVp4s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpZr-00Fk2p-Ar; Tue, 10 Dec 2024 03:02:19 +0100
Date: Tue, 10 Dec 2024 03:02:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 03/11] net: usb: lan78xx: Add error handling
 to lan78xx_set_mac_addr
Message-ID: <9716f2ce-ca03-4c93-b9da-a3235df5a541@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-4-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:43PM +0100, Oleksij Rempel wrote:
> Update `lan78xx_set_mac_addr` to handle errors during MAC address
> register write operations. Ensure that errors are properly propagated to
> the caller, improving the robustness of MAC address updates.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

