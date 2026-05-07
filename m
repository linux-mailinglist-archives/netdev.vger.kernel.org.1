Return-Path: <netdev+bounces-285316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN+cJouJ/GmgRAAAu9opvQ
	(envelope-from <netdev+bounces-285316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:46:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699C4E8612
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2306303D375
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E033F0A9F;
	Thu,  7 May 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FHUkH6Al"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C613F20E6
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157895; cv=none; b=RjY1p5WDnqCBX0NXa28TJNTiRd3hPzXcROKCBCU6jSXYDFg4L9eq1RLqzPPLKCnf/6TuGSkTeLBg6fDhgIl17BAuWll7kn7qLhwyeQgsE+k6B2IOfsqSmToqr/VjSMNy62HaAlIfmFOH57R63YAoWEzNAd7P+6O6wyAetelfni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157895; c=relaxed/simple;
	bh=TBjr1uyd/wQGG+6E3XVx9I4/UCqvl2l0Z5ZAqYQxWxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGJUsZZuL5qekAQLNGvjuyGfjy4CUxY2ODLcyN4P4wmNX5gYzxn9qcwgCxoEQ+lFnVtYwg0Ml7n3+psnxBje6NCemedRLp8/VnjFA8oh16emBwnauP4vjF/LWNR8R3bNQ3yQzfy4ZYi5kNwZ9j0UqqpTARGlIlZM6pVAcbIprpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FHUkH6Al; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9D79F1A3556;
	Thu,  7 May 2026 12:44:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6829160495;
	Thu,  7 May 2026 12:44:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9109510819491;
	Thu,  7 May 2026 14:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778157885; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rwIVVjmIEnqDiiPGwYTSnWAaq2tQIAapO4ksJdHV1KA=;
	b=FHUkH6AlB5RFtdLF2lcGxWLZgfOI9EtcurYBu3XqwTTpEdVMSLQjgS+rK10L8XbULOb3Do
	4aFnlg0nHpiHjKvZzQJ0Bm3EoPlikdol42qr68oBNf8uB2zX7+l2FYK475GEFrK0efCbgF
	ZH/wa/ln0vaLISqeB7mS8BNMPuLHcjK4OpEu/lNYeQRw4wEOyIMKF6MOK8mFakNcTzwvUh
	I7C3C/VBIU66Vgog4dIWMMQ0ELmjR9NeciKj060OZYC3xAlgI05Ii2hwh8GbFgCKLoscrW
	J/Da+0HPYsswCYDYB7n26HOGY+49HJ9YLM8rl/U+9dGTVyz8qLH+BpBbgOHxOg==
Message-ID: <6397da3a-4643-4d9d-97e1-70f7a9b8d5d8@bootlin.com>
Date: Thu, 7 May 2026 14:44:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/15] net: dsa: netc: add phylink MAC
 operations
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, frank.li@nxp.com, chleroy@kernel.org,
 horms@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-12-wei.fang@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260430024945.3413973-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9699C4E8612
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285316-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi,

On 30/04/2026 04:49, Wei Fang wrote:
> Different versions of NETC switches have different numbers of ports and
> MAC capabilities. Add .phylink_get_caps() to struct netc_switch_info,
> allowing each NETC switch version to implement its own callback for
> obtaining MAC capabilities.
> 
> Implement the phylink_mac_ops callbacks: .mac_config(), .mac_link_up(),
> and .mac_link_down(). Note that flow-control configuration is not yet
> supported in .mac_link_up(), but will be implemented in a subsequent
> patch.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

The phylink part looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/dsa/netc/netc_main.c      | 243 ++++++++++++++++++++++++++
>  drivers/net/dsa/netc/netc_platform.c  |  38 ++++
>  drivers/net/dsa/netc/netc_switch.h    |   4 +
>  drivers/net/dsa/netc/netc_switch_hw.h |  26 +++
>  4 files changed, 311 insertions(+)
> 
> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 90a2d8cfd3d2..edf50cb32cb6 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
> @@ -44,6 +44,26 @@ static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
>  		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
>  }
>  
> +static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
> +			      u32 mask, u32 val)
> +{
> +	u32 old, new;
> +
> +	if (is_netc_pseudo_port(np))
> +		return;
> +
> +	WARN_ON((mask | val) != mask);
> +
> +	old = netc_port_rd(np, reg);
> +	new = (old & ~mask) | val;
> +	if (new == old)
> +		return;
> +
> +	netc_port_wr(np, reg, new);
> +	if (np->caps.pmac)
> +		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);
> +}
> +
>  static void netc_port_get_capability(struct netc_port *np)
>  {
>  	u32 val;
> @@ -522,10 +542,232 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
>  	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
>  }
>  
> +static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
> +				  struct phylink_config *config)
> +{
> +	struct netc_switch *priv = ds->priv;
> +
> +	priv->info->phylink_get_caps(port, config);
> +}
> +
> +static void netc_port_set_mac_mode(struct netc_port *np,
> +				   unsigned int mode,
> +				   phy_interface_t phy_mode)
> +{
> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII;
> +	u32 val = 0;
> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val |= IFMODE_RGMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		val |= IFMODE_RMII;
> +		break;
> +	case PHY_INTERFACE_MODE_REVMII:
> +		val |= PM_IF_MODE_REVMII;
> +		fallthrough;
> +	case PHY_INTERFACE_MODE_MII:
> +		val |= IFMODE_MII;
> +		break;
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		val |= IFMODE_SGMII;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}
> +
> +static void netc_mac_config(struct phylink_config *config, unsigned int mode,
> +			    const struct phylink_link_state *state)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +
> +	netc_port_set_mac_mode(NETC_PORT(dp->ds, dp->index), mode,
> +			       state->interface);
> +}
> +
> +static void netc_port_set_speed(struct netc_port *np, int speed)
> +{
> +	netc_port_rmw(np, NETC_PCR, PCR_PSPEED, PSPEED_SET_VAL(speed));
> +}
> +
> +static void netc_port_set_rgmii_mac(struct netc_port *np,
> +				    int speed, int duplex)
> +{
> +	u32 mask, val;
> +
> +	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
> +
> +	switch (speed) {
> +	default:
> +	case SPEED_1000:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_1G);
> +		break;
> +	case SPEED_100:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_100M);
> +		break;
> +	case SPEED_10:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_10M);
> +		break;
> +	}
> +
> +	if (duplex != DUPLEX_FULL)
> +		val |= PM_IF_MODE_HD;
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}
> +
> +static void netc_port_set_rmii_mii_mac(struct netc_port *np,
> +				       int speed, int duplex)
> +{
> +	u32 mask, val = 0;
> +
> +	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
> +
> +	if (speed == SPEED_10)
> +		val |= PM_IF_MODE_M10;
> +
> +	if (duplex != DUPLEX_FULL)
> +		val |= PM_IF_MODE_HD;
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}
> +
> +static void netc_port_mac_rx_enable(struct netc_port *np)
> +{
> +	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
> +			  PM_CMD_CFG_RX_EN);
> +}
> +
> +static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
> +{
> +	u32 val;
> +
> +	/* PM_IEVENT_RX_EMPTY is a read-only bit, it is automatically set by
> +	 * hardware if RX FIFO is empty and no RX packet receive in process.
> +	 * And it is automatically cleared if RX FIFO is not empty or RX
> +	 * packet receive in process.
> +	 */
> +	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
> +			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
> +		dev_warn(np->switch_priv->dev,
> +			 "swp%d MAC%d: RX is not idle\n", np->dp->index, mac);
> +}
> +
> +static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
> +{
> +	u32 val;
> +
> +	if (is_netc_pseudo_port(np))
> +		goto rx_disable;
> +
> +	if (np->caps.pmac) {
> +		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
> +		netc_port_wait_rx_empty(np, 1);
> +	}
> +
> +	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
> +	netc_port_wait_rx_empty(np, 0);
> +
> +	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
> +			      100, 10000, false, np, NETC_PSR))
> +		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
> +			 np->dp->index);
> +
> +rx_disable:
> +	netc_port_rmw(np, NETC_POR, POR_RXDIS, POR_RXDIS);
> +}
> +
> +static void netc_port_mac_tx_enable(struct netc_port *np)
> +{
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN,
> +			  PM_CMD_CFG_TX_EN);
> +	netc_port_rmw(np, NETC_POR, POR_TXDIS, 0);
> +}
> +
> +static void netc_port_wait_tx_empty(struct netc_port *np, int mac)
> +{
> +	u32 val;
> +
> +	/* PM_IEVENT_TX_EMPTY is a read-only bit, it is automatically set by
> +	 * hardware if TX FIFO is empty. And it is automatically cleared if
> +	 * TX FIFO is not empty.
> +	 */
> +	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_TX_EMPTY,
> +			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
> +		dev_warn(np->switch_priv->dev,
> +			 "swp%d MAC%d: TX FIFO is not empty\n",
> +			 np->dp->index, mac);
> +}
> +
> +static void netc_port_mac_tx_graceful_stop(struct netc_port *np)
> +{
> +	netc_port_rmw(np, NETC_POR, POR_TXDIS, POR_TXDIS);
> +
> +	if (is_netc_pseudo_port(np))
> +		return;
> +
> +	netc_port_wait_tx_empty(np, 0);
> +	if (np->caps.pmac)
> +		netc_port_wait_tx_empty(np, 1);
> +
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN, 0);
> +}
> +
> +static void netc_mac_link_up(struct phylink_config *config,
> +			     struct phy_device *phy, unsigned int mode,
> +			     phy_interface_t interface, int speed,
> +			     int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct netc_port *np;
> +
> +	np = NETC_PORT(dp->ds, dp->index);
> +	netc_port_set_speed(np, speed);
> +
> +	if (phy_interface_mode_is_rgmii(interface))
> +		netc_port_set_rgmii_mac(np, speed, duplex);
> +
> +	if (interface == PHY_INTERFACE_MODE_RMII ||
> +	    interface == PHY_INTERFACE_MODE_REVMII ||
> +	    interface == PHY_INTERFACE_MODE_MII)
> +		netc_port_set_rmii_mii_mac(np, speed, duplex);
> +
> +	netc_port_mac_tx_enable(np);
> +	netc_port_mac_rx_enable(np);
> +}
> +
> +static void netc_mac_link_down(struct phylink_config *config,
> +			       unsigned int mode,
> +			       phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct netc_port *np;
> +
> +	np = NETC_PORT(dp->ds, dp->index);
> +	netc_port_mac_rx_graceful_stop(np);
> +	netc_port_mac_tx_graceful_stop(np);
> +}
> +
> +static const struct phylink_mac_ops netc_phylink_mac_ops = {
> +	.mac_config		= netc_mac_config,
> +	.mac_link_up		= netc_mac_link_up,
> +	.mac_link_down		= netc_mac_link_down,
> +};
> +
>  static const struct dsa_switch_ops netc_switch_ops = {
>  	.get_tag_protocol		= netc_get_tag_protocol,
>  	.setup				= netc_setup,
>  	.teardown			= netc_teardown,
> +	.phylink_get_caps		= netc_phylink_get_caps,
>  };
>  
>  static int netc_switch_probe(struct pci_dev *pdev,
> @@ -564,6 +806,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
>  	ds->num_ports = priv->info->num_ports;
>  	ds->num_tx_queues = NETC_TC_NUM;
>  	ds->ops = &netc_switch_ops;
> +	ds->phylink_mac_ops = &netc_phylink_mac_ops;
>  	ds->priv = priv;
>  	priv->ds = ds;
>  
> diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
> index abd599ea9c8d..bb4f92d238cb 100644
> --- a/drivers/net/dsa/netc/netc_platform.c
> +++ b/drivers/net/dsa/netc/netc_platform.c
> @@ -11,8 +11,46 @@ struct netc_switch_platform {
>  	const struct netc_switch_info *info;
>  };
>  
> +static void imx94_switch_phylink_get_caps(int port,
> +					  struct phylink_config *config)
> +{
> +	config->mac_capabilities = MAC_1000FD;
> +
> +	switch (port) {
> +	case 0 ... 1:
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_2500FD;
> +		fallthrough;
> +	case 2:
> +		config->mac_capabilities |= MAC_10 | MAC_100;
> +		__set_bit(PHY_INTERFACE_MODE_MII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  config->supported_interfaces);
> +		/* Port 0 and 1 do not support REVMII */
> +		if (port == 2)
> +			__set_bit(PHY_INTERFACE_MODE_REVMII,
> +				  config->supported_interfaces);
> +
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +		break;
> +	case 3: /* CPU port */
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_10FD | MAC_100FD |
> +					    MAC_2500FD;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static const struct netc_switch_info imx94_info = {
>  	.num_ports = 4,
> +	.phylink_get_caps = imx94_switch_phylink_get_caps,
>  };
>  
>  static const struct netc_switch_platform netc_platforms[] = {
> diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
> index dac19bfba02b..eb65c36ecead 100644
> --- a/drivers/net/dsa/netc/netc_switch.h
> +++ b/drivers/net/dsa/netc/netc_switch.h
> @@ -34,6 +34,7 @@ struct netc_switch;
>  
>  struct netc_switch_info {
>  	u32 num_ports;
> +	void (*phylink_get_caps)(int port, struct phylink_config *config);
>  };
>  
>  struct netc_port_caps {
> @@ -70,6 +71,9 @@ struct netc_switch {
>  	struct ntmp_user ntmp;
>  };
>  
> +#define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
> +#define NETC_PORT(ds, port_id)		(NETC_PRIV(ds)->ports[(port_id)])
> +
>  /* Write/Read Switch base registers */
>  #define netc_base_rd(r, o)		netc_read((r)->base + (o))
>  #define netc_base_wr(r, o, v)		netc_write((r)->base + (o), v)
> diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
> index 0419f7f9207e..7d9afb493053 100644
> --- a/drivers/net/dsa/netc/netc_switch_hw.h
> +++ b/drivers/net/dsa/netc/netc_switch_hw.h
> @@ -67,6 +67,14 @@
>  #define  PQOSMR_VQMP			GENMASK(19, 16)
>  #define  PQOSMR_QVMP			GENMASK(23, 20)
>  
> +#define NETC_POR			0x100
> +#define  POR_TXDIS			BIT(0)
> +#define  POR_RXDIS			BIT(1)
> +
> +#define NETC_PSR			0x104
> +#define  PSR_TX_BUSY			BIT(0)
> +#define  PSR_RX_BUSY			BIT(1)
> +
>  #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
>  #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
>  #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
> @@ -123,6 +131,24 @@ enum netc_mfo {
>  #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
>  #define  PM_MAXFRAM			GENMASK(15, 0)
>  
> +#define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
> +#define  PM_IEVENT_TX_EMPTY		BIT(5)
> +#define  PM_IEVENT_RX_EMPTY		BIT(6)
> +
> +#define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
> +#define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> +#define   IFMODE_MII			1
> +#define   IFMODE_RMII			3
> +#define   IFMODE_RGMII			4
> +#define   IFMODE_SGMII			5
> +#define  PM_IF_MODE_REVMII		BIT(3)
> +#define  PM_IF_MODE_M10			BIT(4)
> +#define  PM_IF_MODE_HD			BIT(6)
> +#define  PM_IF_MODE_SSP			GENMASK(14, 13)
> +#define   SSP_100M			0
> +#define   SSP_10M			1
> +#define   SSP_1G			2
> +
>  #define NETC_PEMDIOCR			0x1c00
>  #define NETC_EMDIO_BASE			NETC_PEMDIOCR
>  


