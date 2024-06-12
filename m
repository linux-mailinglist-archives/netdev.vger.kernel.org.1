Return-Path: <netdev+bounces-102992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3460905E38
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750741F221FF
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 22:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B786136;
	Wed, 12 Jun 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CcbBKjLi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F414315D
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229879; cv=none; b=D/N84AZUjZg5opGhyOFE9P9wPEuET6iKIn+RpOIHedKqYS83VlcgI4a4YO1YsfKr3Z6Rkgle0aKTUJbwf18qg5jju1BFI88lRHRxxqMBnB/iwICvur3kOqj5LNrYzixEm/ZTURVr44qbgIol4ZEdNEdPHMvACuS6dWUIIMYMpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229879; c=relaxed/simple;
	bh=ljrkMCySMmigiB30pjroq1nnDst3523AjRjOUCQPHQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3+WBPI93D0EDUgwCpeWhJJFpC5GNybMBM3smXf9EX9CllQzOwDOaZNO9kU7c7KYIzz0kM9X2qIwnmgecaZEPOERUXQU3yTOMLVZ6ESUTmugbkZe1qTtTP5s1caTCFL3IkxUUE+TtXtSNbXjc59K3qfDU2/cTClhSrwDQ+fvXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CcbBKjLi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kcM7+sEl2fFtdltwBxi9L6LdwhXB7vjNBltenta4eBs=; b=CcbBKjLiXhLREV1DtlLUuXLQWG
	Lkgv/zS+RKzvgZr6Hp9nxNfB7O0+apKF7edBOOYqoMJHuKsgbfjED2tFL98Cv5769y2JLYcaOM81M
	J+CyhYO///NBcralWWbtz/j1gRfMPOq4owKPgPDIC5dW9jSAFKJOnuYTVhFK6y4a4+5tUuwntPyh0
	PIDf0oZCPiroRD0Ta/yi3NosUmU8eRttqUZLeBX3ItcKhlOnmA0gLRCbeO6BlBNCRXjnhVrl/M8ut
	oOG2K/KjuuiHK6GQ71EtgGLqBcF+g6t/eBsuEoAYRpupTDiDcgaxqriq2I6CG6QN2ih+zb74CexwC
	8/SJ0O/g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38598)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sHW4h-000580-2f;
	Wed, 12 Jun 2024 23:04:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sHW4h-0000bC-Bq; Wed, 12 Jun 2024 23:04:11 +0100
Date: Wed, 12 Jun 2024 23:04:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Message-ID: <ZmobWwS5UapbhdmT@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
 <ZmbFK2SYyHcqzSeK@shell.armlinux.org.uk>
 <dz34gg4atjyha5dc7tfgbnmsfku63r7faicyzo3odkllq3bqin@hho3kj5wmaat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dz34gg4atjyha5dc7tfgbnmsfku63r7faicyzo3odkllq3bqin@hho3kj5wmaat>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jun 11, 2024 at 03:25:14PM +0300, Serge Semin wrote:
> Hi Russell, Andrew
>
> Should we have a DW IP-core-specific getter like
> stmmac_ops::pcs_get_config_reg() which would return the
> tx_config_reg[15:0] field then we could have cleared the IRQ by just
> calling it, we could have had the fields generically
> parsed in the dwmac_pcs_isr() handler and in the
> phylink_pcs_ops::pcs_get_state().

pcs_get_state() is not supposed to get some cached state, but is
supposed to return the real state at the time that it is called.

There's a good reason for this - dealing with latched-low link failed
indications, it's necessary that pcs_get_state() reports that the link
failed if _sometime_ between the last time it was called and the next
time the link has failed.

So, I'm afraid your idea of simplifying it doesn't sound to me like a
good idea.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

