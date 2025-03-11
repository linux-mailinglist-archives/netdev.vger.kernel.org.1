Return-Path: <netdev+bounces-173906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D6EA5C31E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47B73A430D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F224A254851;
	Tue, 11 Mar 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PEpDOO16"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB61CAA99;
	Tue, 11 Mar 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701552; cv=none; b=PnIWzTO1WefkWDjtpswZZupCwZsyK4sCWdTHrvGWkeNIdEjs/yTwhqrcNeTGic83VzaTrdL3YPQxu7u7J3S2NI8UUAgysfs7k/bjgYYNIzRBFz0IHc9dRmIoWCgZJDfKk6fvOkCvikUZgmiHKJ1Zx0BXuETVulBd0NvBX6Ho+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701552; c=relaxed/simple;
	bh=L0ifDHDk8jVbU6MPdEUr6Z/Ptw4jvqh0pLhrSZsBH5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb1iRTZi8aSZ7b9QqezqCT8x77QVe1HqIdFZEbs0fD0i/rb4DZ/fkuqZ1VAde7TThuQ94YKwIQKRHcoDwSHCl/yM915O6+gSzEOjOGYiIIko5ONDP7KhpOcen+P9KXMbC5EwWaZgypXLfwELwol5O1DMRDsMaV3CtmYWKqLh5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PEpDOO16; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c31Au5Z3vjkCmDnoykVdRiiAKpObyn6ZiX9CIg67pFs=; b=PEpDOO16pea+huwGIgozxoDZg3
	36osatx1+RTIwSoOugwM++KacKkpXV3oDurwFLiXm4fv/V4MJoribyeZa+BgxHtxhf3IxDiWnNjHa
	4jVNslKcMFpH1J0MHKPTh/oE5lmLd90Gd4hy5btm0Xsn09dITYR12NJuooMkTTsesFQC14Xt4J1CW
	W815n01d8HsOciSwonZ2nNLaRUIW5rcuPwTo1KeGuVVaY7jTK8M3+vygREE+1YysefOl59mj64OVw
	1vaeGgRbCyByd5Ij8SP+E76I267s58PArPBUObpW8x/iO53qCbK6kwPyaEsvnDxuNKInkRLbi2u3K
	nuhRVoBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41136)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ts08F-00049D-1m;
	Tue, 11 Mar 2025 13:58:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ts08B-0003Xt-27;
	Tue, 11 Mar 2025 13:58:51 +0000
Date: Tue, 11 Mar 2025 13:58:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>,
	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2 0/3] net: stmmac: approach 2 to solve EEE
 LPI reset issues
Message-ID: <Z9BBm6tievFukbO8@shell.armlinux.org.uk>
References: <Z8m-CRucPxDW5zZK@shell.armlinux.org.uk>
 <29bc7abd-b5cc-4359-8aa6-dbf66e8b70e4@nvidia.com>
 <Z8sn7b_ra_QnWUjw@shell.armlinux.org.uk>
 <673e453b-798f-4fc1-8ed1-3cf597e926b4@nvidia.com>
 <4fe02d97-2c38-4d40-b17d-5f8174d2f7cc@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fe02d97-2c38-4d40-b17d-5f8174d2f7cc@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 11, 2025 at 01:25:58PM +0000, Jon Hunter wrote:
> 
> On 10/03/2025 14:20, Jon Hunter wrote:
> > 
> > On 07/03/2025 17:07, Russell King (Oracle) wrote:
> > > On Fri, Mar 07, 2025 at 04:11:19PM +0000, Jon Hunter wrote:
> > > > Hi Russell,
> > > > 
> > > > On 06/03/2025 15:23, Russell King (Oracle) wrote:
> > > > > Hi,
> > > > > 
> > > > > This is a second approach to solving the STMMAC reset issues caused by
> > > > > the lack of receive clock from the PHY where the media is in low power
> > > > > mode with a PHY that supports receive clock-stop.
> > > > > 
> > > > > The first approach centred around only addressing the issue in the
> > > > > resume path, but it seems to also happen when the platform glue module
> > > > > is removed and re-inserted (Jon - can you check whether that's also
> > > > > the case for you please?)
> > > > > 
> > > > > As this is more targetted, I've dropped the patches from this series
> > > > > which move the call to phylink_resume(), so the link may still come
> > > > > up too early on resume - but that's something I also intend to fix.
> > > > > 
> > > > > This is experimental - so I value test reports for this change.
> > > > 
> > > > 
> > > > The subject indicates 3 patches, but I only see 2 patches? Can
> > > > you confirm
> > > > if there are 2 or 3?
> > > 
> > > Yes, 2 patches is correct.
> > > 
> > > > So far I have only tested to resume case with the 2 patches to make that
> > > > that is working but on Tegra186, which has been the most
> > > > problematic, it is
> > > > not working reliably on top of next-20250305.
> > > 
> > > To confirm, you're seeing stmmac_reset() sporadically timing out on
> > > resume even with these patches appled? That's rather disappointing.
> > 
> > So I am no longer seeing the reset fail, from what I can see, but now
> > NFS is not responding after resume ...
> > 
> > [   49.825094] Enabling non-boot CPUs ...
> > [   49.829760] Detected PIPT I-cache on CPU1
> > [   49.832694] CPU features: SANITY CHECK: Unexpected variation in
> > SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU1: 0x0000009444c004
> > [   49.844120] CPU features: SANITY CHECK: Unexpected variation in
> > SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU1: 0x00000010305116
> > [   49.856231] CPU features: SANITY CHECK: Unexpected variation in
> > SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU1: 0x00000003001066
> > [   49.868081] CPU1: Booted secondary processor 0x0000000000 [0x4e0f0030]
> > [   49.875389] CPU1 is up
> > [   49.877187] Detected PIPT I-cache on CPU2
> > [   49.880824] CPU features: SANITY CHECK: Unexpected variation in
> > SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU2: 0x0000009444c004
> > [   49.892266] CPU features: SANITY CHECK: Unexpected variation in
> > SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU2: 0x00000010305116
> > [   49.904467] CPU features: SANITY CHECK: Unexpected variation in
> > SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU2: 0x00000003001066
> > [   49.916257] CPU2: Booted secondary processor 0x0000000001 [0x4e0f0030]
> > [   49.923610] CPU2 is up
> > [   49.925194] Detected PIPT I-cache on CPU3
> > [   49.929010] CPU3: Booted secondary processor 0x0000000101 [0x411fd073]
> > [   49.935866] CPU3 is up
> > [   49.937983] Detected PIPT I-cache on CPU4
> > [   49.941824] CPU4: Booted secondary processor 0x0000000102 [0x411fd073]
> > [   49.948593] CPU4 is up
> > [   49.950810] Detected PIPT I-cache on CPU5
> > [   49.954651] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
> > [   49.961431] CPU5 is up
> > [   50.069784] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/
> > rgmii link mode
> > [   50.077634] dwmac4: Master AXI performs any burst length
> > [   50.080718] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features
> > support found
> > [   50.088172] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008
> > Advanced Timestamp supported
> > [   50.096851] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/
> > Full - flow control rx/tx
> > [   50.110897] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector:
> > repeated role: device
> > [   50.113922] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06
> > 13:39:28 UTC
> > [   50.147552] OOM killer enabled.
> > [   50.148441] Restarting tasks ... done.
> > [   50.152552] VDDIO_SDMMC3_AP: voltage operation not allowed
> > [   50.154761] random: crng reseeded on system resumption
> > [   50.162912] PM: suspend exit
> > [   50.212215] VDDIO_SDMMC3_AP: voltage operation not allowed
> > [   50.271578] VDDIO_SDMMC3_AP: voltage operation not allowed
> > [   50.338597] VDDIO_SDMMC3_AP: voltage operation not allowed
> > [  234.474848] nfs: server 10.26.51.252 not responding, still trying
> > [  234.538769] nfs: server 10.26.51.252 not responding, still trying
> > [  237.546922] nfs: server 10.26.51.252 not responding, still trying
> > [  254.762753] nfs: server 10.26.51.252 not responding, timed out
> > [  254.762771] nfs: server 10.26.51.252 not responding, timed out
> > [  254.766376] nfs: server 10.26.51.252 not responding, timed out
> > [  254.766392] nfs: server 10.26.51.252 not responding, timed out
> > [  254.783778] nfs: server 10.26.51.252 not responding, timed out
> > [  254.789582] nfs: server 10.26.51.252 not responding, timed out
> > [  254.795421] nfs: server 10.26.51.252 not responding, timed out
> > [  254.801193] nfs: server 10.26.51.252 not responding, timed out
> > 
> > > Do either of the two attached diffs make any difference?
> > 
> > I will try these next.
> 
> 
> I tried both of the diffs, but both had the same problem as above and
> I see these nfs timeouts after resuming. What works the best is the
> original change you proposed (this is based upon the latest two
> patches) ...

I'm wondering whether there's something else which needs the RX clock
running in order to take effect.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e2146d3aee74..48a646b76a29 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3109,10 +3109,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
>         if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
>                 priv->plat->dma_cfg->atds = 1;
> -       /* Note that the PHY clock must be running for reset to complete. */
> -       phylink_rx_clk_stop_block(priv->phylink);
>         ret = stmmac_reset(priv, priv->ioaddr);
> -       phylink_rx_clk_stop_unblock(priv->phylink);
>         if (ret) {
>                 netdev_err(priv->dev, "Failed to reset the dma\n");
>                 return ret;
> @@ -7951,6 +7948,8 @@ int stmmac_resume(struct device *dev)
>         rtnl_lock();
>         mutex_lock(&priv->lock);
> +       /* Note that the PHY clock must be running for reset to complete. */
> +       phylink_rx_clk_stop_block(priv->phylink);
>         stmmac_reset_queues_param(priv);
>         stmmac_free_tx_skbufs(priv);
> @@ -7961,6 +7960,7 @@ int stmmac_resume(struct device *dev)
>         stmmac_set_rx_mode(ndev);
>         stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
> +       phylink_rx_clk_stop_unblock(priv->phylink);
>         stmmac_enable_all_queues(priv);
>         stmmac_enable_all_dma_irq(priv);

If you haven't already, can you try shrinking down the number of
functions that are within the block..unblock region please?

Looking at the functions called:

stmmac_reset_queues_param()
stmmac_free_tx_skbufs()
stmmac_clear_descriptors()
	These look like it's only manipulating software state

stmmac_hw_setup()
	We know this calls stmmac_reset() and thus needs the blocking

stmmac_init_coalesce()
	Looks like it's only manipulating software state

stmmac_set_rx_mode()
	This manipulates GMAC_RXQ_CTRL4, GMAC_HASH_TAB(*),
	GMAC_ADDR_HIGH(*), GMAC_ADDR_LOW(*), and GMAC_PACKET_FILTER.

stmmac_restore_hw_vlan_rx_fltr()
	This manipulates GMAC_VLAN_TAG_DATA, GMAC_VLAN_TAG,
	GMAC_VLAN_HASH_TABLE, GMAC_VLAN_TAG

I wonder whether the last two also require the RX clock to be running.

The reason I want to track this down is that we may need to add
block..unblock elsewhere in the driver to ensure that the RX clock
is running when configuration is done elsewhere.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

