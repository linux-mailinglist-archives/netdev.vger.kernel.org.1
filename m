Return-Path: <netdev+bounces-247142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06DCF4F29
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4035931A9104
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2199322C78;
	Mon,  5 Jan 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zRa4bM80"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853B323411;
	Mon,  5 Jan 2026 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632977; cv=none; b=T/0KACanUyP9c51V1/IivpulhG+rGN+61379FjkKT9cAOBfr8yy9Q1NbjGvA7pwG0KvMMogOaJFiC0an9JmUzb/WiXDaaw+0WE9vVR0udKN0QEaNdxPW+AtT3ee1Z6O6VnvTFjrTVSOHODjVVoEISWCauPjuLBqQQzOf6zBhvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632977; c=relaxed/simple;
	bh=Gq9ZQsejFWgbt/cznYIkZJ9e4Kdlhi4OnV/LwodtYMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYHOtl6YLnesZq+EIh4mIDP4792/S6E8Bs8culRG5CN3br4Qh6v4qQKe17umfpLiL6jLqf7t6h1FBPn/1toRa46v9h+5bStrnFXaJUrq0VfvdKYhPij2wceM6WHaaktYhlrMLZEO7m+bUbzy2BJr6DItwbEsVGY8p6CeGcXAN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zRa4bM80; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p1gzXDkRAfSsLirw5BNtPwUstkVTvPynwJOx+2Xmj98=; b=zRa4bM80CQpDZhryMbMzsFsCkX
	nSTrr0PLgUmgV2ncgRTwnc7GCglwhlJuPqwCo0qudRA6hSdqBLskS4xVzUzIHSQFGY4hz9F7INgoq
	mfiGiiYOVFDGpT7cZtMJKkzRa4Do8Jp1sKQPyavQBrAr51ZNWYlkSqQS0vTcZu9VaClmpLXXtiE6d
	W/kVKKKyM7BJD/6EVps8zWXtA//ja5QMDs+yQ9TBJE7d9aQeNEfaNa3UV87WUdAYthrne9uLs0IzV
	ogILDDhFXIYbFwnmnKEbcsuAxq9Ru/0wRcENC3s0BRpsOkPUu4l/Psa6D0FG01cyrcTI+nbfX7pki
	NYIOAJIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60322)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vco4z-0000000089f-29LL;
	Mon, 05 Jan 2026 17:09:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vco4v-00000000822-2qhH;
	Mon, 05 Jan 2026 17:09:13 +0000
Date: Mon, 5 Jan 2026 17:09:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	robh@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for
 the Micrel KSZ9131 PHY
Message-ID: <aVvwOYce1CFOLiBk@shell.armlinux.org.uk>
References: <20260105100245.19317-1-eichest@gmail.com>
 <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
 <aVuxv3Pox-y5Dzln@eichest-laptop>
 <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>
 <aVvp70S2Lr3o_jyB@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVvp70S2Lr3o_jyB@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 05, 2026 at 05:42:23PM +0100, Stefan Eichenberger wrote:
> Yes this is correct. ERR050694 from NXP states:
> The IEEE 802.3 standard states that, in MII/GMII modes, the byte
> preceding the SFD (0xD5), SMD-S (0xE6,0x4C, 0x7F, or 0xB3), or SMD-C
> (0x61, 0x52, 0x9E, or 0x2A) byte can be a non-PREAMBLE byte or there can
> be no preceding preamble byte. The MAC receiver must successfully
> receive a packet without any preamble(0x55) byte preceding the SFD,
> SMD-S, or SMD-C byte.
> However due to the defect, in configurations where frame preemption is
> enabled, when preamble byte does not precede the SFD, SMD-S, or SMD-C
> byte, the received packet is discarded by the MAC receiver. This is
> because, the start-of-packet detection logic of the MAC receiver
> incorrectly checks for a preamble byte.
> 
> NXP refers to IEEE 802.3 where in clause 35.2.3.2.2 Receive case (GMII)
> they show two tables one where the preamble is preceding the SFD and one
> where it is not. The text says:
> The operation of 1000 Mb/s PHYs can result in shrinkage of the preamble
> between transmission at the source GMII and reception at the destination
> GMII. Table 35–3 depicts the case where no preamble bytes are conveyed
> across the GMII. This case may not be possible with a specific PHY, but
> illustrates the minimum preamble with which MAC shall be able to
> operate. Table 35–4 depicts the case where the entire preamble is
> conveyed across the GMII.
> 
> We would change the behavior from "no preamble is preceding SFD" to "the
> enitre preamble is preceding SFD". Both are listed in the standard and
> shall be supported by the MAC.

Thanks for providing the full explanation, it would be good to have
that in the commit message.

The next question would be, is it just the NXP EQOS implementation
that this breaks on, or are other EQOS implementations affected?

In other words, if we choose to conditionally enable the preable at
the PHY, should the generic parts of stmmac handle this rather than
ending up with multiple platform specific glue having to code this.
(This is something I really want to avoid - it doesn't scale.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

