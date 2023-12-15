Return-Path: <netdev+bounces-57863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A7814595
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697131F2133F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE7E19469;
	Fri, 15 Dec 2023 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yI+I7qeQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED71A716
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cHsnSmtS9kGZZZeYF9SJWbAva9OD5wy7J68KbPwQFGE=; b=yI+I7qeQoN0vicSDQ5gqD9MWxV
	8xPcNzR3rM4P/TqPHFujlXgUISNeeqcF/hGByIPo7NJqekRyBp/rSwXWZKgFfUKIhNustc9FyTEyA
	M2pSNAkRKHPixU6PrY+IYGSt+Dz3nk9t4PhSB54vcEjnC4aUUaOnM5DVUUTmWbnbdshY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE5Sx-0030da-H4; Fri, 15 Dec 2023 11:30:47 +0100
Date: Fri, 15 Dec 2023 11:30:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: DSA tags seem to break checksum offloading on DWMAC100
Message-ID: <e431c74f-5f83-4fb8-8246-a0f447a24596@lunn.ch>
References: <c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com>

> So it seems like a solution is needed to prevent checksum offloading by Ethernet
> drivers when DSA tags are in used. I'm not sure how this would be done, since
> DSA is purposefully kept quite separate from CPU port drivers. What are your
> thoughts on this?

It is not as simple as that, because some Ethernet drivers do know how
to correctly calculate checksums when there is a DSA
header. e.g. Marvell and Broadcom devices can do this, when combined
with Marvell/Broadcom switches. I don't know how the Broadcom driver
does this, but on the Marvell Ethernet drivers, there is a value you
set in the transmit descriptor to indicate how big the headers are
before the IP header. Its normally used to skip over the VLAN tag, but
it can also be used to skip over the DSA header.

So i would suggest you look at the data sheet and see if there is
anything similar, a way to tell the hardware where the IP header
actually is in the frame. If you can do that, you can then actually
make use of the hardware checksum, rather than disable it.

     Andrew

