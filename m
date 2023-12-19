Return-Path: <netdev+bounces-58825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB08184D0
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE38A1C215DD
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4513FFB;
	Tue, 19 Dec 2023 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g203GzoR"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9F13FED
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 635F560005;
	Tue, 19 Dec 2023 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702979396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFwRIbCu773yJM6SoJhaRdgwhYYSLN14HzCIEELJBlM=;
	b=g203GzoRSn3CF1+2MF3Q9E0Paa1Qv5l10q/q6/ipcdH1TSxNrwoBQ9GFKVM6MnQLdJUVA7
	XO42FaR9ulL1VSG1zHqB90X7SFAi9keN5hsPANnrkWTke1HrW3w9Fc4hNVR5tic9l8BDKZ
	GrB2kMUEo7xm+ZFfy6ZgDqn34zAO6Tejw9lIDY9m1SnXXtS8jnuToMrzGlAopVra7nr6so
	Eiu/u1oC4a3NGofLlD6opNwgJNPn5vC/13SlIF3c7FE25esIsB+NVDIQGXHPZmPPYPgs02
	Q9CaxgQPzp1ZSBY0g+jhxpXe/BUhzG6r7NKFf0OaLRRsyUqA1Q1iyspiYgXwPA==
Date: Tue, 19 Dec 2023 10:50:15 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>, 
    Sylvain Girard <sylvain.girard@se.com>, 
    Pascal EBERHARD <pascal.eberhard@se.com>, 
    Richard Tresidder <rtresidd@electromag.com.au>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 0/1] Prevent DSA tags from breaking COE
In-Reply-To: <f4166144-4874-4b10-96f8-fc3e03f94904@lunn.ch>
Message-ID: <cdc38cdf-536c-c23b-46c1-abadf14001a2@bootlin.com>
References: <20231218162326.173127-1-romain.gantois@bootlin.com> <f4166144-4874-4b10-96f8-fc3e03f94904@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Mon, 18 Dec 2023, Andrew Lunn wrote:
...
> Probably a dumb question.... Does this COE also perform checksum
> validation on receive? Is it also getting confused by the DSA header?
> 
> You must of tested receive, so it works somehow, but i just wounder if
> something needs to be done to be on the safe side?

That's a good point, I just investigated the RX path a bit more and the MAC 
indeed has IP/TCP/UDP RX checksum offloading enabled. However, the 
external switch in my setup uses EDSA tags, which displace the "true" ethertype 
field to the end of the DSA header and replaces the "normal" ethertype with 
ETH_P_EDSA (0xdada). So to the MAC controller, the ethernet frame has an unknown 
ethertype, and so it doesn't see it as an IP frame at all. All of the 
ethtool counters related to IP stuff are at 0, which supports this.

This explains why checksum offloading doesn't break the RX path in my case. 
However, other maybe other DSA switches using different frame formats could 
cause different behavior? Considering this, I think it would be safer to change 
the dsa_breaks_tx_coe flag to a general dsa_breaks_coe flag. It makes sense to 
me to assume that if DSA tags break TX COE, then RX COE will also not work.

I'll take this into account when I send a v2.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

