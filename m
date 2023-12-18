Return-Path: <netdev+bounces-58609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FB68177BB
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7E61F232C5
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780651E4AF;
	Mon, 18 Dec 2023 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qme3P9fJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551F1E486
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=050EqGmVCVUNmEMi4n09ihXv28lZpEFwZCiQLfcsttA=; b=qme3P9fJPXSo+DXDdDUMS5iZsK
	nqWHie2/Fpb1X00Bf+9009jmjkLFAWlXCt5v0QRUzCUXE9B4aK8yFdYTKvGsX9DsxLoEpcuaW7ctl
	+KqYMVh98MsgNopKqzPaC8CXC62GMhewOZJsCPK22m3CSB3nD+YBp5ihEV8uqaR6QMQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rFGgS-003GXN-7B; Mon, 18 Dec 2023 17:41:36 +0100
Date: Mon, 18 Dec 2023 17:41:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 0/1] Prevent DSA tags from breaking COE
Message-ID: <f4166144-4874-4b10-96f8-fc3e03f94904@lunn.ch>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218162326.173127-1-romain.gantois@bootlin.com>

On Mon, Dec 18, 2023 at 05:23:22PM +0100, Romain Gantois wrote:
> Hello everyone,
> 
> This is a bugfix for an issue that was recently brought up in two
> reports:
> 
> https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
> https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
> 
> The Checksum Offloading Engine of some stmmac cores (e.g. DWMAC1000)
> computes an incorrect checksum when presented with DSA-tagged packets. This
> causes all TCP/UDP transfers to break when the stmmac device is connected
> to the CPU port of a DSA switch.

Probably a dumb question.... Does this COE also perform checksum
validation on receive? Is it also getting confused by the DSA header?

You must of tested receive, so it works somehow, but i just wounder if
something needs to be done to be on the safe side?

	  Andrew

