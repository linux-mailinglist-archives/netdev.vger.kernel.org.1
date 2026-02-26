Return-Path: <netdev+bounces-261548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK10ImueoGlVlAQAu9opvQ
	(envelope-from <netdev+bounces-261548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:26:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E17CE1AE4FB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50DAF30880D0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38544266AA;
	Thu, 26 Feb 2026 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aneUitLm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794C28850C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133640; cv=none; b=nrPAbPmaSODX6pCENIesVqLXp1PstY5CJVj1sbFawvUR1C1ToqIAyF9vAipRkEV9Zoq3mQftFHxd89yhqidsrvNr+4XkGLNPJUmNBRxpwcHhpJb4lcddunaSDDZUVYZNCgMs8UoswAVwjbPvZI6kdfk3aAitv27YSA8Le1lozZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133640; c=relaxed/simple;
	bh=IH82CZWzXLu6IPJZwxdwz3oIPHY88p983vrCud2TCV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXu0GCATi93AkjbYOykY/JtWIoA17BkXiHO2HJbMe2uHrYfq9ZqSBvXkpuREvql1j1lAhmeMfwt/BqEKvK3JoMaQRusbmomMq3s/jdUHvgp+eJgIsOHFBm9SnALI4ZvPPC6T5rxokNw3Ruqzf78xP9XLZszMZb0b/UZxGYP/G9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aneUitLm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0JRXUjLKDgtadEi9V5u/y+iAHVrvNf83A9b1xHD5VYY=; b=aneUitLmfompVwolaS3zHId++A
	L/iOV0m99sUxcbDgCE918nOj9LEzbZ3rKcFTRlCiYb51Uf8B9sJph6GESgtMsx9+WiKuRCmCemFC9
	y0vpGV/ZZ5hNnzCuL7srGb7nE7opXay86eDPVKYGucK3lSnS83ESAG+T/5628swJmVRXsVzplNrDt
	/56bTg70qX5Djo0j3VQz7B1qTvrThYE5Um7+6XEpPDyOvNLv1GYZEr/pRlC90ZY0SCb+PISXAS6lc
	ycOXFu9uGCy2UIw70dG31rMKTsVhjDM9JLWJDr8WuXGmnOMme2TiDOOWYHN3bj/AaNHm4F3ueVbRF
	iQpFyFvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49406)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvguY-000000008N0-1kri;
	Thu, 26 Feb 2026 19:20:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvguU-000000002Gf-1tCk;
	Thu, 26 Feb 2026 19:20:30 +0000
Date: Thu, 26 Feb 2026 19:20:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	nicolas.ferre@microchip.com, pabeni@redhat.com,
	theo.lebrun@bootlin.com, phil@raspberrypi.com
Subject: Re: [PATCH net-next v4 3/4] net: cadence: macb: add ethtool EEE
 support
Message-ID: <aaCc_pfAheT9VoUd@shell.armlinux.org.uk>
References: <20260226090608.54802-1-nb@tipi-net.de>
 <20260226090608.54802-4-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226090608.54802-4-nb@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261548-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.937];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: E17CE1AE4FB
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:06:07AM +0100, Nicolai Buchwitz wrote:
> Implement get_eee and set_eee ethtool ops for GEM, delegating to
> phylink_ethtool_get_eee() and phylink_ethtool_set_eee(). Both
> handlers return -EOPNOTSUPP when MACB_CAPS_EEE is absent, keeping
> the ops safe to register unconditionally in gem_ethtool_ops.
> 
> Phylink owns the full EEE lifecycle: PHY advertisement, link
> partner negotiation, timer management and ethtool state; the MAC
> driver only provides the mac_enable_tx_lpi / mac_disable_tx_lpi
> callbacks wired up in the previous patch.
> 
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 6b9c63195970..a7e00b99e9a8 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4034,6 +4034,26 @@ static const struct ethtool_ops macb_ethtool_ops = {
>  	.set_ringparam		= macb_set_ringparam,
>  };
>  
> +static int macb_get_eee(struct net_device *dev, struct ethtool_keee *eee)
> +{
> +	struct macb *bp = netdev_priv(dev);
> +
> +	if (!(bp->caps & MACB_CAPS_EEE))
> +		return -EOPNOTSUPP;

There's no need for these checks, because phylink implements them
(phylink's implmentation is designed to relieve the driver writer of as
much burden as possible.)

You already tell phylink that you implement LPI support by populating
the two operations in struct phylink_mac_ops. This results in
pl->mac_supports_eee_ops being set true during phylink_create().
However, if you then don't supply both config->lpi_capabilities and
config->lpi_interfaces, then pl->mac_supports_eee will be false. This
will cause both phylink EEE ops to return -EOPNOTSUPP.

As you're already conditionally populating those depending on
MACB_CAPS_EEE, you've done everything already for phylink to return
-EOPNOTSUPP when MACB_CAPS_EEE is not set.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

