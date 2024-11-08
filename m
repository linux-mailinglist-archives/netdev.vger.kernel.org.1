Return-Path: <netdev+bounces-143336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8190B9C217B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435AC286705
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2A190486;
	Fri,  8 Nov 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jiyse7sZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A5137750
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081697; cv=none; b=Wvz6abHIoqIuKi5aKEtUQFUUAt+dbFbeKJUpTsUktj46YCgBcrSefqmhgrZ0uz5t1KY9S8WdMG23gJisT56ZarBh5uKGMJL3wsNC2McWxOog1Qa59WRmuhY0px+M58KNtXvvIUBa6G4vzyqEjFPcqE1fzV6c1DAXGQIlrsVG+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081697; c=relaxed/simple;
	bh=Y3WfQRI9/NTbWxOwZRg38MqnjNoJXc9d1NSZl/NW6fg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LNv1pkCGCe6rgKlI4ROOvgACUMtQSTHk5j4U6c3aMsESXSR3tpDcKmSU6OfnQs2A1Ab0bmpxNkWkZ5iK3mNwp+ZE7WcSoeQ0V8bkvUpy8BFVrHtMr4omJleDkZq8YP47os9tmtSEb4zuqayfT+ESXOq/AnDXgw0d6fqHON/xa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jiyse7sZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qLq4gyl3R5H1fAoTPOPvNw5zvvc0SyamtcSXC0jJ+Ho=; b=jiyse7sZwtv2rUERmEdmA1GImr
	HKS4NbTbCQHEj2lqxLTlHpjSRktq/NTXn3wjCEvjGuMR4zyl2xDbxmQuHfXsChHPG0OAM5b4bX6BV
	owMDvqUR+fEx/7LbjCgDy+f45PP6EuYryFlatUlj8dzrVR7kbv6jhAi90SD1Dl2tjQ6REvzUOfQpA
	od4quGMsesrfrnhwWweuV9uWciAD/J9MvNXer73zkzrwmqJ5+laMCRsE9IaEMhysi2oB5pccQTst8
	yKVb8vm2RP178DUDm9vhMn27a0HHafvkkmT+jky9MjQ1YkM26IX7OhkmBMtxJBBAOoLU1sEf7jrIw
	8SfMgBpw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51838)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t9RQO-0005Ze-2N;
	Fri, 08 Nov 2024 16:01:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t9RQM-0002P5-29;
	Fri, 08 Nov 2024 16:01:26 +0000
Date: Fri, 8 Nov 2024 16:01:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/5] net: phylink: phylink_resolve() cleanups
Message-ID: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series does a bit of clean-up in phylink_resolve() to make the code
a little easier to follow.

Patch 1 moves the manual flow control setting in two of the switch
cases to after the switch().

Patch 2 changes the MLO_AN_FIXED case to be a simple if() statement,
reducing its indentation.

Patch 3 changes the MLO_AN_PHY case to also be a simple if() statment,
also reducing its indentation.

Patch 4 does the same for the last case.

Patch 5 reformats the code and comments for the reduced indentation,
making it easier to read.

 drivers/net/phy/phylink.c | 106 +++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 58 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

