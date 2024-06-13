Return-Path: <netdev+bounces-103161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5B906A17
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD462812D5
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363213D60A;
	Thu, 13 Jun 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pL0S2ybF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5825632
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274837; cv=none; b=r0/CgaYMmmz88IIpD0OTzrvjr24ccNpCF1f5GVvszKBFNqvYYURh5wTNaVwRoNi+CI8CfAhyN19Vp+jWSlOmZswVIgTRu8pk0qkj/CeFo9nUc/7SiI4kUTODYQLCpcA2BeieImToV3IjiSNd0zdnMR/m8w3vd5+RhMccbuaeahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274837; c=relaxed/simple;
	bh=JiVz5NrJAVrUJG+cmC855QzEcfr4ScBNZbWmtSi/ohY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar6RBJRMeCIt4ZmlfrQVPDLiQvJDtQRzoqJwGZ+3znKeYgHru1nmShAIZkcJWsGNcLMSLtY0vps7clP3LZwYPAfNP/ssYvihNafN/fMv38bUg7rqGeud0h9fk6UXFMqLXI+Jv7JMvgrQypHoblx0ygQCN8KzdPE07LnQc5DQszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pL0S2ybF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wde4ug6Zp2eLAcHoUGrcsFCfdJAv4SylN7RROmxnyqk=; b=pL0S2ybFZTta412SGdp4C2mi1n
	TNzk35n6trNa+1pCnWkC53tabbkuXygJVK4PdpyBR3PRosbx4JemiH0AFwO6nFPJIHOU0DrYKBjpm
	UIXb5NsDnbVY2HrYe8zc0P1aIzdT6xQUvwSbc8d8f73EaRpiu5hMkVHcsLqmuuGKObIwMnwgBN2Pj
	EFF/nZiW2Ey3yEtBEpoVm57cdm0W12orsPUAYthvo6hPzkkCiRx2aq728CIO48tZMEmgSuf1GYZVB
	N+Cc+MfQiyRqsYOUvJOWRChPSxe+wNmoGDIAXgK2aN9c4Q8OOwIP5hLFQLninJGBdqcq6cNnf+ZjO
	21ub9EaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35020)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sHhlw-00064H-1U;
	Thu, 13 Jun 2024 11:33:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sHhlv-000194-45; Thu, 13 Jun 2024 11:33:35 +0100
Date: Thu, 13 Jun 2024 11:33:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/5] net: stmmac: dwmac-intel: provide a
 select_pcs() implementation
Message-ID: <ZmrK/kMIZKTnTSrp@shell.armlinux.org.uk>
References: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
 <E1sGgCN-00Fact-0x@rmk-PC.armlinux.org.uk>
 <572700203.5assNPOG8s@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572700203.5assNPOG8s@fw-rgant>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jun 11, 2024 at 09:40:51AM +0200, Romain Gantois wrote:
> On lundi 10 juin 2024 16:40:39 UTC+2 Russell King (Oracle) wrote:
> > Move the code returning the XPCS into dwmac-intel, which is the only
> > user of XPCS. Fill in the select_pcs() implementation only when we are
> > going to setup the XPCS, thus when it should be present.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

I'll drop this r-b because changes have been necessary. Added all the
others.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

