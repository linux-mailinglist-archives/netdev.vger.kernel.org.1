Return-Path: <netdev+bounces-170799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D63A49F1E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25501884DAD
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650C274253;
	Fri, 28 Feb 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IqbbpkoF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40980271294;
	Fri, 28 Feb 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760880; cv=none; b=RrJqRD+KnJTb5RRz+vEwWj9WyhObfw73B3pRTFUpy8WV3qYSvIdYGNyvgVyLtWCL+DNUPwg6GC943f4QzIJo8TMXpAFYvZegiLbJqAfebz7jlyO/Fvl5IRNw1ozXvdkPAIxlRB7ucSLQ0lNmjwkO8RWUVNB+uXetcmoedntPVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760880; c=relaxed/simple;
	bh=fpjUFCCaLNsg7DJVDIpyf9j0iJl5WzBPmpRA+BdRS9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbWsphF4nlCXS46AwI6MhKt5nJtVgkuQsSqT8BOtp/EI9BJeapovaTGz3UqTM22YG07M3zkEiQ+6tOwtvJfvk8r28TZ5MK85bEAJgMNcBCYA6O1L2k7QBBSJUdGj5FIa1qPjjbrhKuo3Gxy9ADEpAgYt2pn7KN6M8Lm9WXYeDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IqbbpkoF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jX6Y2tUI8Vfq24KCax/qQrK090rHpiA8peov/U+2yRU=; b=IqbbpkoFo7dHranVeadYYinWQT
	fuPanRw19KxuYEreZcbcMP7+hT8ojOFUWaK0Y5V0JkGy3P+cYIww816MC5dLUxjn3rvj0g1qRd6G0
	8htGZxWfvahEaEnN4+DNOpUfZdpfxCDg43XbSXzFPb834QLXI4KsH3Sewf54hFKnC8fQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1to3QG-0010TF-Sr; Fri, 28 Feb 2025 17:41:12 +0100
Date: Fri, 28 Feb 2025 17:41:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] net: phy: nxp-c45-tja11xx: add support
 for TJA1121
Message-ID: <57c889e3-ad12-41c4-a16a-af18f0816691@lunn.ch>
References: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
 <20250228154320.2979000-3-andrei.botila@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228154320.2979000-3-andrei.botila@oss.nxp.com>

On Fri, Feb 28, 2025 at 05:43:20PM +0200, Andrei Botila wrote:
> Add support for TJA1121 which is based on TJA1120 but with
> additional MACsec IP.
> 
> Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

