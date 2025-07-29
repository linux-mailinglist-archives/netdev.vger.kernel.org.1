Return-Path: <netdev+bounces-210864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD77BB15298
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 20:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3117ABFFF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D723A9AD;
	Tue, 29 Jul 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZE21ZVYP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007B238C03
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813204; cv=none; b=LMSrHU2HbLuq9z/3QitkPIth6ASMOU2Hbu/4bxsomqknaBSK1LMUZYH13jQ6zGcZ8C1hBkISxdhgKXbv49sTFe9Kw5ILLBtoMm+gRClWzvamg5O5sR6mTqGg5y9wnaC1Nd+lUa+FMiYDzOG3l6rog00HpXTwVKKJ4JdpAEQYyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813204; c=relaxed/simple;
	bh=WHIkGaAe4P/mq0lQvzGxD3XQ9fQx/8X0+muhT4hNFLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyMWNxQPwI5WPq6HisWlTC0egMvVm6Y7Zy4FVfWweH8Etf7hD6yFCM9QWJLbR/dMnYbleF7GsqRI3F58/J+aeYebEsrdDW5TK2OmeDQBgrr6yI5iz1DVccP2biip7xlMVDoQgmtIuCW/iMr9P4k+z49jP+7yyH75oqfgF4Q/tAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZE21ZVYP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b0ZxO4zaTBDiZ70aFZFCdiOcnI2dippFCSPeeEmtK4A=; b=ZE21ZVYPFB2jAHQsq8YihIXAYh
	FH+BI3PDBCZslICCC7CKweHWy7PdUAm3UtMvyFtuEfJyfGbqSWApdp4cMM0jfL5zeM9Gr2W6Ifxek
	wqd233XaxmNsMdVvrzh15z19q0PCGgWB/vlfOoyY5sslW+Iw2oXZCVZ0v/pRcRocG/WtPjXDyO4cM
	G9Ee3BS1udYhI9EAECfxCZFt71y7bN750e8a5RUeS9cafyDXrZnvYNpC1aagzH09LhxKyXAVq2lUo
	KuCa/FTLGu0zCu6x5eFNuCv7XEpQ/+KtKbvF31+aq/5XbEMKlZUwqZo+bHpMpXyR/SaZ1cI3RP+FK
	cLO9fegA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46032)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ugovb-0002KX-21;
	Tue, 29 Jul 2025 19:19:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ugovW-0007cp-1f;
	Tue, 29 Jul 2025 19:19:50 +0100
Date: Tue, 29 Jul 2025 19:19:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
Message-ID: <aIkQxlqmg9_EFqsI@shell.armlinux.org.uk>
References: <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
 <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
 <d300d546-09fa-4b37-b8e0-349daa0cc108@foss.st.com>
 <aIjePMWG6pEBvna6@shell.armlinux.org.uk>
 <186a2265-8ca8-4b75-b4a2-a81d21ca42eb@foss.st.com>
 <aIj4Q6WzEQkcGYVQ@shell.armlinux.org.uk>
 <b88160a5-a0b8-4a1a-a489-867b8495a88e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88160a5-a0b8-4a1a-a489-867b8495a88e@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 29, 2025 at 07:27:11PM +0200, Andrew Lunn wrote:
> And i did notice that the Broadcom code is the only one doing anything
> with enable_irq_wake()/disable_irq_wake(). We need to scatter these
> into the drivers.

It's better to use devm_pm_set_wake_irq() in the probe function, and
then let the core code (drivers/base/power/wakeup.c and
drivers/base/power/wakeirq.c) handle it. This is what I'm doing for
the rtl8211f.

IRQ wake gets enabled/disabled at suspend/resume time, rather than
when the device wakeup state changes, which I believe is what is
preferred.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

