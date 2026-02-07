Return-Path: <netdev+bounces-257770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE+dOhZ4h2nYYQQAu9opvQ
	(envelope-from <netdev+bounces-257770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 18:36:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E07106B9F
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 18:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E11A43004F04
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AEA33A9E5;
	Sat,  7 Feb 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J8FxDoBL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472723EABC
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770485779; cv=none; b=HmG2sCSp0OT6cY4mh1yGNxqILdo0mYePgJih66Fer0nVxUF7cDNzJr3jQqsr5EGDmlGH2EhDcl3xMMwwquc6nhMuk//5ZK80V5bPBYCXoS06+3wcBzWAX/uN9zLIgpYPuacnw2eU3a1P77jXy8JDuyV1ux8gdOFNiaw8XMmgpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770485779; c=relaxed/simple;
	bh=2jVwicLOGfmENXm+CDhrMjWP+ogh/zuv8Upiygrf4RM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MQ+6UzeutQ4PyJzzay02uD1+5ntfKdkcPWf4BwCOs32SkQKg8nAZ8WcBIflX1U4+lQhKkCIBWwxUhRsy1Iuhj+7WMo327OOKk0RLamZLcrYhkwi+w49FSoNH3PCqGvv0+Xy/OY/KcxczDcBFAJ9eERJyoxruaiFqWWekq303zBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J8FxDoBL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iy2b3cVVjU6U6f7MW7RiPPlWlY70Br9fWBbdYmSTN6w=; b=J8FxDoBL+rJk6dsmeQySgEYcUx
	sYjl/b9OLVE2pe4yrVF+NMKOeEUrPf1t4dJmAVJ0flIn4ryYLOERodn85U5gZwGTBoc5tJGScMiED
	9q0OXxsDkW7e0pOkL6rrKRE9s/7oCXC2Q7S2cGDRamazAmo/x+VtvHKY6vo1oJoyRMN+LU4jNvoX2
	7nAsWlI//tCBgwY/IsSlufGvkOKBdoYL5kJTbyPSTADlRaSCQAm1s/E1QS/JdfzNoYlLt9pX/3+ls
	b5L6CA1KLrdQs/r/6A1AaloRtnS8IVZ490rLoAwjbQJF3/v3iarvnUyRA9S61ZNcvwqo6kTuqS3FR
	23XJervw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40810)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vomE4-000000000T7-4APF;
	Sat, 07 Feb 2026 17:36:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vomE2-000000008TH-2hRJ;
	Sat, 07 Feb 2026 17:36:06 +0000
Date: Sat, 7 Feb 2026 17:36:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thierry Reding <treding@nvidia.com>,
	Paritosh Dixit <paritoshd@nvidia.com>
Subject: RFC: stmmac RSS support
Message-ID: <aYd4BkAeNW6d0iIC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257770-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70E07106B9F
X-Rspamd-Action: no action

Hi,

While looking at the possibilities of minimising the memory that
struct plat_stmmacenet_data consumes (880 bytes presently on
aarch64), I came across the RSS feature in stmmac.

In commit 76067459c686 ("net: stmmac: Implement RSS and enable it in
XGMAC core"), support was added for RSS to the core stmmac driver for
the dwxgmac2 core. I can only find socfpga and tegra as the two
platform glues that use the dwxgmac2 core.

RSS support is only enabled when both the core supports it, and the
platform glue sets priv->plat->rss_en.

However, the stmmac-related results of grepping for this member do not
show any platform glues which set this flag:

$ git grep '\<rss_en\>'
Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst:        int rss_en;
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:      if (!priv->dma_cap.rssen || !priv->plat->rss_en) {
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:      if (priv->dma_cap.rssen && priv->plat->rss_en)

So, as no one has decided to enable this feature during the intervening
six years, is there any benefit to having this code in the mainline
kernel, or should this feature be dropped?

If a user appears, the code will remain in git history and could be
restored.

Thoughts?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

