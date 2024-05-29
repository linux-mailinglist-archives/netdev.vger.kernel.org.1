Return-Path: <netdev+bounces-98926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103468D323B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B837C1F219DE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD816F293;
	Wed, 29 May 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c8CaiQOj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7865168C2A;
	Wed, 29 May 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972433; cv=none; b=ACeLYyrmlQdMGW9HBdRE3nJO/xUTHSFu6uSXLuzLxAiqWEJcUnUxuqOgibwBJBTkQijoQ64QFt41qQldygrROlP3Pxe39PMXrYbyFIe+x9mBZe6OoM3jiY/eUQnSIFBQ8KDJNd0b5bjZioMM6fLjKsrigBQxCKo9bQHeHTXKu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972433; c=relaxed/simple;
	bh=i012pIJmMwpVMNC0wVzKWfXKqOZHs0negPRQdj4uoV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHDG5fym91F0v0Lu+fAlI8SqwRaKkgas47pHlMx0jmDVvWlZtBHw4WROZ5eymrS/7WOLp508Huhb645gjB4aQMdg52mqaOP3n6b3swG59wRAeY1cIBFRKvZM/k5zU5N6QZC3ZVd8Y8DP31qq9Xeh6okn8Wpx5JScOLeH01zX9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c8CaiQOj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NDBP5MjscEqYWSfB6IwDfvlV49qbL9VUtfUm5r9opnU=; b=c8CaiQOjxsu+TIUsAK5E2w+ydd
	FUFKddMHwkoZbFRpXmCCrbcFGj0VCWJtJuofeH4T8i0u5YHKfsrpCnS1Ffgz5KbCq6BkfugA/Bmr7
	BcQnArMqOQ3DueMHpPiesrUuV3jyoievmpMITqHgN52uTgOFdyvJ8xIoQmS8Mb+oRogtnCd1mgr8a
	Jv/Fpz6b+quoMVKOIjxrfO10NHhpfshcYr8sWWCo1BftTDEGFUhm6xvOgEZljYlGIcI76PKva+rmK
	bkb3BAY0lmDsMzk+6bH/IAvydsr5BdS5teIEZYZaNZFBOcxL3s4v6x5POVHQ1VNxiOPpzyVn/BF/D
	DmLXQesQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54206)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCExT-0005pQ-16;
	Wed, 29 May 2024 09:46:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCExT-00045H-Nq; Wed, 29 May 2024 09:46:55 +0100
Date: Wed, 29 May 2024 09:46:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: update priv->speed to SPEED_UNKNOWN
 when link down
Message-ID: <Zlbrf8ixl9jeTTIv@shell.armlinux.org.uk>
References: <20240528092010.439089-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528092010.439089-1-xiaolei.wang@windriver.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 28, 2024 at 05:20:10PM +0800, Xiaolei Wang wrote:
> The CBS parameter can still be configured when the port is
> currently disconnected and link down. This is unreasonable.
> The current speed_div and ptr parameters depend on the negotiated
> speed after uplinking. So When the link is down, update priv->speed
> to SPEED_UNKNOWN and an error log should be added.
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

So what happens if stmmac is connected to a PHY that can negotiate with
the link partner, it has link up at e.g. 1G speed, one configures CBS,
and then the link goes down and comes up at a different speed?

I can't see any way in the stmmac driver that this is handled, which
makes this feature way more buggy than you're referring to here. It
also means that with your patch, if one attempts to configure CBS
when the link is down, it will fail.

To me, commit 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
just looks very buggy.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

