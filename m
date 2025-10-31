Return-Path: <netdev+bounces-234697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9518BC261A4
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8641F4FB76A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435D42F290E;
	Fri, 31 Oct 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ow9X0/AB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D1263C8C;
	Fri, 31 Oct 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927469; cv=none; b=NQ4/Af/3k/Ev69XZk8OBI0kGbXLZMfbcwWo+Xcf2tqSck7jjdC5b8Q27Yn2lW3n+DOahVBp2OgDYnm8PEe+tSiyvT/R/t9m1q1aEHQ/rbskcb+3lzOSWM0u2W0o9p05Ejq+6wG/42bFwCgtqn3zmqVgiX9nbxZxgsMcRNs3f3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927469; c=relaxed/simple;
	bh=wQABP+Dh6FYEU7p9fJ1yWyublXy4uswTWru1FsjP5+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZgvzQMPfu73iz7fAkdqss7oB82aPBYgEbuOHezPKi9R/hD0uxw1UuEeZhnFsw2NZVQup+mrPTNoWxv3NbiZlBTFBRzFvKOExXf9XxC1uKo+o7HU9unaKUXMbQMicb2jANm0Eu4WMkAA0m52T+HloZyMfPWtEhaEhJrHiEQ2fc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ow9X0/AB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=roafZkZWewZsYCQZCghd/+pRCfB9REddQFj/JcoKv2I=; b=Ow9X0/AB6DyPbpW+TJ4tCbWALE
	nr4EJ16lxZ0U0GmG8BgfD/dtxCTNa9HrtEvuThntVYfl73unICSJYgXo6K/p7W1Sjc8YOiGrON4Hq
	KL6YKDquHAdIKb+hNnpiG58T1EWQwN7flQlQ9WMorlXp8ic4CHh8YAD8zF+Wk3LHMrFs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEron-00Cc6g-F9; Fri, 31 Oct 2025 17:17:37 +0100
Date: Fri, 31 Oct 2025 17:17:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: altera-tse: Don't use netdev name for
 the PCS mdio bus
Message-ID: <89b97635-1e3a-489b-be99-67c76c46ca23@lunn.ch>
References: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
 <20251030102418.114518-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030102418.114518-4-maxime.chevallier@bootlin.com>

On Thu, Oct 30, 2025 at 11:24:16AM +0100, Maxime Chevallier wrote:
> The PCS mdio bus must be created before registering the net_device. To
> do that, we musn't depend on the netdev name to create the mdio bus
> name. Let's use the device's name instead.

The name does appear in /sys/bus/mdiobus, so there is a potential for
ABI breakage. But it seems unlikely.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

