Return-Path: <netdev+bounces-98521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4758D1A8B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A733B26DC3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFE316B742;
	Tue, 28 May 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zZIb+ycT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48071753
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897772; cv=none; b=c6eEyr3Ru6PCE0HkyXqUH7aQySVEyTTbyKtCyB0afsQ8Ze9yLbS3/hhCw+Hc4MELckDbHds4A9tUkItljLEEkCSyim6BZy/CC5JWqDbxYas+6PyB2trD0fHWodvUawK3TN0zGr9hpQNclHrTJ6Er2I+zszorQJiBOEpHkMjB5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897772; c=relaxed/simple;
	bh=n6tt294L68A2hOV2QBEWKcyTD+B6eHfb+orUlNyFPA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhdVvFCCEsS3wwhuFn+f/jOr2H3wVsixLh5Zm9I9aAWJugIGFjjdKGvO8RX2iBexR0KbkAiI1q6S+ObC9I1ekIgr7pEO18exATmuRYO3KclZOIr3mSC2F5QRBV5JpBjtThpdT7ORhGBCmL92NWkgRD8g5DsKwzTu6H1nq9C43FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zZIb+ycT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t9f6EUwEDA3+6+6SBlbBRn0vayTpSjunCk8SdCSfn90=; b=zZIb+ycThrBpMAtcwJZJ6l0aSm
	ClYoAW9qSVUhExNHY3nWJ65JwyaqGfuzjbBM4U+kvP1AxlVyungui5hGkvxBUfllGEgyBAvrqzCHg
	bi5nQRA4LNxbLa/jf78LSnThTKJ1u87WFfxIraYwiJ3ZmYB1ubGYuFmPatWuA6U1LVSVW4froUMLm
	VTimp7FnT6UHjrj+sSFFeXA1heqsZsGbn/BX6VNA4feofGLaHZboN5Y0SpU9d4LshNKL0rnkbWb82
	qtiKO8VKNhYelYkHr1eoXW9qlKdMc2Rategkq308PusknVq7OJSPw3itUvtdpWfT/r5vNTNGazqxD
	q9dVZj9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45716)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBvXO-0004k7-29;
	Tue, 28 May 2024 13:02:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBvXP-0003Ex-2c; Tue, 28 May 2024 13:02:43 +0100
Date: Tue, 28 May 2024 13:02:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v7 6/6] net: tn40xx: add phylink support
Message-ID: <ZlXH4nl89Z8P3jA5@shell.armlinux.org.uk>
References: <20240527203928.38206-1-fujita.tomonori@gmail.com>
 <20240527203928.38206-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527203928.38206-7-fujita.tomonori@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 28, 2024 at 05:39:28AM +0900, FUJITA Tomonori wrote:
> This patch adds supports for multiple PHY hardware with phylink. The
> adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
> TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.
> 
> For now, the PCI ID table of this driver enables adapters using only
> QT2025 PHY. I've tested this driver and the QT2025 PHY driver (SFP+
> 10G SR) with Edimax EN-9320 10G adapter.
> 
i> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

A few comments - I don't recall seeing previous versions of these
patches, despite it being at version 7.

> @@ -1082,6 +1083,10 @@ static void tn40_link_changed(struct tn40_priv *priv)
>  				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
>  
>  	netdev_dbg(priv->ndev, "link changed %u\n", link);
> +	if (link)
> +		phylink_mac_change(priv->phylink, true);
> +	else
> +		phylink_mac_change(priv->phylink, false);

This is only useful if you have a PCS, and I don't see anything in the
driver that suggests you do. What link is this referring to?

In any case, you could eliminate the if() and just pass !!link if it's
not already boolean in nature (the if() suggests it is, so passing just
"link" would also work.)

> @@ -1381,10 +1389,17 @@ static int tn40_open(struct net_device *dev)
>  	struct tn40_priv *priv = netdev_priv(dev);
>  	int ret;
>  
> +	ret = phylink_connect_phy(priv->phylink, priv->phydev);
> +	if (ret)
> +		return ret;
> +
>  	tn40_sw_reset(priv);
> +	phylink_start(priv->phylink);

At this point, the link could have come up (mac_link_up() could well
be called.) Is the driver prepared to cope with that happening right
_now_ in the tn40_open sequence? If not, you will need to move this
to a point where the driver is ready to begin operation.

phylink_stop() is its opposite, and you need to call that at the
point where you want the link to be taken down (iow, where you want
.mac_link_down() to be guaranteed to have been called if the link
was already up.)

> @@ -143,6 +143,9 @@ struct tn40_priv {
>  	char *b0_va; /* Virtual address of buffer */
>  
>  	struct mii_bus *mdio;
> +	struct phy_device *phydev;
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;

So phylink_config is embedded in tn40_priv - that's fine. What this does
mean is you can trivially go from the phylink_config pointer to a
pointer to tn40_priv *without* multiple dereferences:

static inline struct tn40_priv *
config_to_tn40_priv(struct phylink_config *config)
{
	return container_of(config, struct tn40_priv, phylink_config);
}

> +static void tn40_link_up(struct phylink_config *config, struct phy_device *phy,
> +			 unsigned int mode, phy_interface_t interface,
> +			 int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct net_device *ndev = to_net_dev(config->dev);
> +	struct tn40_priv *priv = netdev_priv(ndev);
> +
> +	tn40_set_link_speed(priv, speed);
> +	netif_wake_queue(priv->ndev);
> +}
> +
> +static void tn40_link_down(struct phylink_config *config, unsigned int mode,
> +			   phy_interface_t interface)
> +{
> +	struct net_device *ndev = to_net_dev(config->dev);
> +	struct tn40_priv *priv = netdev_priv(ndev);
> +
> +	tn40_set_link_speed(priv, 0);
> +	netif_stop_queue(priv->ndev);

Shouldn't the queue be stopped first?

> +}
> +
> +static void tn40_mac_config(struct phylink_config *config, unsigned int mode,
> +			    const struct phylink_link_state *state)
> +{
> +}

Nothing needs to be done here?

> +
> +static const struct phylink_mac_ops tn40_mac_ops = {
> +	.mac_config = tn40_mac_config,
> +	.mac_link_up = tn40_link_up,
> +	.mac_link_down = tn40_link_down,
> +};
> +
> +int tn40_phy_register(struct tn40_priv *priv)
> +{
> +	struct phylink_config *config;
> +	struct phy_device *phydev;
> +	struct phylink *phylink;
> +
> +	phydev = phy_find_first(priv->mdio);
> +	if (!phydev) {
> +		dev_err(&priv->pdev->dev, "PHY isn't found\n");
> +		return -1;
> +	}
> +
> +	config = &priv->phylink_config;
> +	config->dev = &priv->ndev->dev;
> +	config->type = PHYLINK_NETDEV;
> +	config->mac_capabilities = MAC_10000FD | MLO_AN_PHY;

MLO_AN_PHY is not a MAC capability, it shouldn't be here.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

