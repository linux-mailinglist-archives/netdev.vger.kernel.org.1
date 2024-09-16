Return-Path: <netdev+bounces-128566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2139297A5C3
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B9E2816F6
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152315AD9B;
	Mon, 16 Sep 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TSw9iQYE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72115A86A;
	Mon, 16 Sep 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503156; cv=none; b=j/qIArJ3bZgLeOckg2J2BKGdp76Jx5iVd+MjsbUcs84y242lSK0ZRiHo8exRyXPfysWTKxX62XCtBniEdfKXv0sY6t/06JFfJQlDvI+zvNyAdaWVYiNzZYf5a2ztusaIzEBbSyvuLqrxFQgrSjA83yM6fZeN7LhMp3uU+JXk5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503156; c=relaxed/simple;
	bh=OWHALRxsDAhwA9MWEDNc0g4EDGEUWclSAU/zrZ8JBfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx2Yb2sGYq7O265IsCTDU4BjLD16M+9HckIH+db6bMmNA650MgEEf6XliBIX/hnBshyKzbbGXFsX4lHc5YCxtdtPJEFKumS0UO/cWyesWGip6rHficAaw1QsUHcNyr9Chh0X9z0DyofDUyv+FEyV7tuErMxv1v+6+flabT5olJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TSw9iQYE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n8HF5c5PNO9o6nzRymPyEzlV6lHywqHBIQya8yOQMyQ=; b=TSw9iQYETGvMPBuveRzwTG+6gU
	RwTGb8jxFLSbW7th6IJRgLjKInqzzdEOFS1NCJDa3DCQcvgFBEtLhdnLp7mU2pRQUu+K5Yyqhp7wv
	5ZWkfq+m+fkih8JKFbKxqribvjB7AkR2YXVjeQ8NVCwDQ6sN+X1ncBewVYjatSsABtGM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sqEL2-007Zl6-Ce; Mon, 16 Sep 2024 18:12:32 +0200
Date: Mon, 16 Sep 2024 18:12:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Crispin <john@phrozen.org>
Subject: Re: ethtool settings and SFP modules with PHYs
Message-ID: <ccf7ea15-203e-4860-a85d-31641a26c872@lunn.ch>
References: <ZuhQjx2137ZC_DCz@makrotopia.org>
 <20240916180224.39a6543c@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916180224.39a6543c@fedora.home>

> A notification would indeed be better, and is something I can prototype
> quickly. I was hesitating to add that, but as you show interest in
> this, I'm OK to move forward on that :)

This might need further brainstorming. What are we actually interested
in?

The EEPROM has been read, we know what sort of SFP it is?

It happens to be a copper SFP, we know what MDIO over I2C protocol to
use, it responds, and the PHY device has been created? Does the SFP
layer actually know this? Are we actually adding a notification for
any PHY, not just an SFP PHY?

	Andrew


