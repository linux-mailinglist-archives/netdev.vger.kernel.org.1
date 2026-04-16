Return-Path: <netdev+bounces-279065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMjrDavo4GlInQAAu9opvQ
	(envelope-from <netdev+bounces-279065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505F40F22B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE2130022B3
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9AF3A9D8C;
	Thu, 16 Apr 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n6F771f7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50913B7A8
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347295; cv=none; b=YJTVTZlDpFfypyxxEptdLm0jnoFCiFKzNv/L505nAGumkREf37yNLGS9AEC127cSe76d6Ea5J1Se/cRtsvKx8qdYYFtxqcAuRio8/M0ST3nd7AbvPMRRd+e9enBFu5IeNuZgGsVyyQ0nwHyjYOYE3Gri/vav9QO0G20hy4+/VMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347295; c=relaxed/simple;
	bh=c1UXGR9PrQCSMu7xnY+0CAcp2tSZmeijtQ0vnLO21qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDUB/95nLpQlG2uuSDxaQvnn9oii74u1lkEBF4MAk+ebTQ7GVwgT6wzXJnAlpPtXZ325Zx/AdVvK3OXAA2yYooiOqP1rFnMpD6vP/cDWCTqPg4Z6D1+4rJ5oTPgboHXtGgfl1ActeKLtOI94T8FLtsAk+kZTvIbi5BRBri73K0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n6F771f7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zOnYPi75gzmQEwbyZJqH4NCjwCJ3I8rG438d8AQ1+0U=; b=n6F771f72013HJNfmIqPEmVhNi
	QE0xN6gU/HImq42GSRXuZgq3TjaGa1aeKVavGBIdDNRHPsdHZUUoouucS9r/v2FuVAQlDW+l1Gv8N
	Y7iaE43hAGc7wNNDYHUh3DapeKFaYEgnKAQxoGl46yX63qHZNyt0lSXLHMfSvnW/3JkUG6trNUN02
	2C2B2POZuW7NtIFVdNXpYrAzp64+nhJpeK+1zaosi936fktn8foNbfBwpegMLNwxidI3r/bhg6mJT
	mfmRxjueya3O/l0jhchVIxwIbwZvqG43tq/tjFuBe7SZC0njfOuEPPQhvmzqyfVv8OPtoV0TmrW6Z
	/Rrnc21g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53316)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wDN4b-000000003Gr-0UCP;
	Thu, 16 Apr 2026 14:48:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wDN4X-000000003FZ-3ckE;
	Thu, 16 Apr 2026 14:47:57 +0100
Date: Thu, 16 Apr 2026 14:47:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Message-ID: <aeDojTdDTELfpT0X@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
 <5987484.DvuYhMxLoT@steina-w>
 <aeC-tc2CooYDoBok@shell.armlinux.org.uk>
 <2410317.ElGaqSPkdT@steina-w>
 <aeDSTIS9-TDSihbX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeDSTIS9-TDSihbX@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279065-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.081];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 9505F40F22B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 01:13:00PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 16, 2026 at 02:02:53PM +0200, Alexander Stein wrote:
> > Hi Russel,
> > 
> > Am Donnerstag, 16. April 2026, 12:49:25 CEST schrieb Russell King (Oracle):
> > > On Thu, Apr 16, 2026 at 08:20:13AM +0200, Alexander Stein wrote:
> > > > Am Mittwoch, 15. April 2026, 14:59:32 CEST schrieb Russell King (Oracle):
> > > > > On Wed, Apr 15, 2026 at 08:08:40AM +0200, Alexander Stein wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > Am Dienstag, 23. September 2025, 13:26:19 CEST schrieb Russell King (Oracle):
> > > > > > > Move the PHY attachment/detachment from the network driver out of
> > > > > > > __stmmac_open() and __stmmac_release() into stmmac_open() and
> > > > > > > stmmac_release() where these actions will only happen when the
> > > > > > > interface is administratively brought up or down. It does not make
> > > > > > > sense to detach and re-attach the PHY during a change of MTU.
> > > > > > 
> > > > > > Sorry for coming up now. But I recently noticed this commit breaks changing
> > > > > > the MTU on i.MX8MP. Once I simply change the MTU I run into some DMA error:
> > > > > > $ ip link set dev end1 mtu 1400
> > > > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
> > > > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
> > > > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
> > > > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-4
> > > > > > imx-dwmac 30bf0000.ethernet end1: Link is Down
> > > > > > imx-dwmac 30bf0000.ethernet end1: Failed to reset the dma
> > > > > > imx-dwmac 30bf0000.ethernet end1: stmmac_hw_setup: DMA engine initialization failed
> > > > > 
> > > > > This basically means that a clock is missing. Please provide more
> > > > > information:
> > > > > 
> > > > > - what kernel version are you using?
> > > > 
> > > > Currently I am using v6.18.22.
> > > > $ ethtool -i end1
> > > > driver: st_gmac
> > > > version: 6.18.22
> > > > firmware-version: 
> > > > expansion-rom-version: 
> > > > bus-info: 30bf0000.ethernet
> > > > supports-statistics: yes
> > > > supports-test: no
> > > > supports-eeprom-access: no
> > > > supports-register-dump: yes
> > > > supports-priv-flags: no
> > > > 
> > > > > - has EEE been negotiated?
> > > > 
> > > > No. It is marked as not supported
> > > > 
> > > > $ ethtool --show-eee end1
> > > > EEE settings for end1:
> > > >         EEE status: not supported
> > > > 
> > > > > - does the problem persist when EEE is disabled?
> > > > 
> > > > As EEE is not supported the problem occurs even with EEE disabled.
> > > > 
> > > > > - which PHY is attached to stmmac?
> > > > 
> > > > It is a TI DP83867.
> > > > 
> > > > imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:03] driver [TI DP83867] (irq=136)
> > > > 
> > > > > - which PHY interface mode is being used to connect the PHY to stmmac?
> > > > 
> > > > For this interface
> > > > > phy-mode = "rgmii-id";
> > > > is set.
> > > > 
> > > > In case it is helpful. My platform is arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> > > > Thanks for assisting. If there a further questions, don't hesitate to ask.
> > > 
> > > Thanks.
> > > 
> > > So, as best I can determine at the moment, we end up with the following
> > > sequence:
> > > 
> > > stmmac_change_mtu()
> > >  __stmmac_release()
> > >   phylink_stop()
> > >    phy_stop()
> > >     phy->state = PHY_HALTED
> > >     _phy_state_machine() returns PHY_STATE_WORK_SUSPEND
> > >     _phy_state_machine_post_work()
> > >      phy_suspend()
> > >       genphy_suspend()
> > >        phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN)
> > > 
> > > With the DP83867, this causes most of the PHY to be powered down, thus
> > > stopping the clocks, and this causes the stmmac reset to time out.
> > > 
> > > Prior to this commit, we would have called phylink_disconnect_phy()
> > > immediately after phylink_stop(), but I can see nothing that would
> > > be affected by this change there (since that also calls
> > > phy_suspend(), but as the PHY is already suspended, this becomes a
> > > no-op.)
> > > 
> > > However, __stmmac_open() would have called stmmac_init_phy(), which
> > > would reattach the PHY. This would have called phy_init_hw(), 
> > > resetting the PHY, and phy_resume() which would ensure that the
> > > PDOWN bit is clear - thus clocks would be running.
> > > 
> > > As a hack, please can you try calling phylink_prepare_resume()
> > > between the __stmmac_release() and __stmmac_open() in
> > > stmmac_change_mtu(). This should resume the PHY, thus restoring the
> > > clocks necessary for stmmac to reset.
> > 
> > I tried the following patch. This works as you suspected.
> 
> Brilliant, thanks for proving the theory why it broke.
> 
> I'll have a think about the best way to solve this, because
> phylink_prepare_resume() is supposed to be paired with phylink_resume()
> and that isn't the case here.
> 
> Please bear with me as my availability for looking at the kernel is
> very unpredictable at present (family health issues.)

I have some patches which passed build testing, but more chaos means
I can't post them nor test them. I'll do something when I'm next able
to, whenever that will be.

The next problem will be netdev's policy over reviews vs patches
balance which I'm already in deficit, and I have *NO* *TIME*
what so ever to review patches - let alone propose patches to
fix people's problems.

So I'm going to say this plainly: if netdev wants to enforce that
rule, then I won't be fixing people's problems.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

