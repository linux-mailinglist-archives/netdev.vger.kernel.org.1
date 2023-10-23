Return-Path: <netdev+bounces-43562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5057D3E50
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4DCB20BDD
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0521340;
	Mon, 23 Oct 2023 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Oh5Lik/M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2712110D;
	Mon, 23 Oct 2023 17:51:08 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF97D73;
	Mon, 23 Oct 2023 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3/iUMEFKo+Sriw48TJmEW/W6vROCpBV4Feg7wlAPFQ4=; b=Oh5Lik/MMbUmhez2xPGcULw1FX
	oryyjioVyG+fhTipbc2g+Gl+a28EygKtCQTQPgFp+xoT9CuYZ57bCzc0j8xod7xE06qvAPXJuYOS0
	yVdvaUgJa5SLxzg679Wv7j5fT8Hrmlu3exh4xc1sa7CEV9cuCJ+KiY78fgy7EI4sTGgE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1quz4o-0033TQ-0V; Mon, 23 Oct 2023 19:50:54 +0200
Date: Mon, 23 Oct 2023 19:50:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS
 driver
Message-ID: <b8ac3558-b6f0-4658-b406-8ceba062a52c@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-4-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023155013.512999-4-romain.gantois@bootlin.com>

> +/* locking is handled by the caller */
> +static int ipqess_edma_rx_buf_alloc_napi(struct ipqess_edma_rx_ring *rx_ring)
> +{
> +	struct ipqess_edma_buf *buf = &rx_ring->buf[rx_ring->head];
> +
> +	buf->skb = napi_alloc_skb(&rx_ring->napi_rx,
> +				  IPQESS_EDMA_RX_HEAD_BUFF_SIZE);

You might want to look at using the page_pool code. Its shown to be
more efficient for some drivers, e.g. the FEC.

> +static int ipqess_edma_redirect(struct ipqess_edma_rx_ring *rx_ring,
> +				struct sk_buff *skb, int port_id)
> +{
> +	struct ipqess_port *port;
> +
> +	if (port_id == 0) {
> +		/* The switch probably redirected an unknown frame to the CPU port
> +		 * (IGMP,BC,unknown MC, unknown UC)
> +		 */
> +		return -EINVAL;
> +	}
> +
> +	if (port_id < 0 || port_id > QCA8K_NUM_PORTS) {
> +		dev_warn(rx_ring->edma->sw->priv->dev,
> +			 "received packet tagged with out-of-bounds port id %d\n",
> +			 port_id);

Maybe rate limit this?

> +static int ipqess_port_set_mac_address(struct net_device *netdev, void *a)
> +{
> +	struct sockaddr *addr = a;
> +	int err;
> +
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;

I would be surprised if that could happen.

> +static int
> +ipqess_port_fdb_do_dump(const unsigned char *addr, u16 vid,
> +			bool is_static, void *data)
> +{
> +	struct ipqess_port_dump_ctx *dump = data;
> +	u32 portid = NETLINK_CB(dump->cb->skb).portid;
> +	u32 seq = dump->cb->nlh->nlmsg_seq;
> +	struct nlmsghdr *nlh;
> +	struct ndmsg *ndm;

It looks like you can reuse dsa_slave_port_fdb_do_dump(), if you
export it.

> +static int
> +ipqess_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
> +		     struct net_device *dev, struct net_device *filter_dev,
> +		     int *idx)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	struct ipqess_port_dump_ctx dump = {
> +		.dev = dev,
> +		.skb = skb,
> +		.cb = cb,
> +		.idx = *idx,
> +	};

And with a little bit of refactoring, you should be able to use the
core of qca8k_port_fdb_dump(). All that seems to differ is how you get
to the struct qca8k_priv *priv.

That then makes me wounder if there is more code here which could be
removed with a little refactoring of the DSA driver?

> +static void ipqess_port_get_drvinfo(struct net_device *dev,
> +				    struct ethtool_drvinfo *drvinfo)
> +{
> +	strscpy(drvinfo->driver, "qca8k-ipqess", sizeof(drvinfo->driver));
> +	strscpy(drvinfo->fw_version, "N/A", sizeof(drvinfo->fw_version));

If you leave this alone, it will contain the git hash of the kernel,
which is more useful than 'N/A'.

> +	strscpy(drvinfo->bus_info, "platform", sizeof(drvinfo->bus_info));
> +}
> +

> +static int ipqess_port_get_eeprom_len(struct net_device *dev)
> +{
> +	return 0;
> +}

Is this actually useful? What does it default to if not provided? 42?

> +static void ipqess_port_get_ethtool_stats(struct net_device *dev,
> +					  struct ethtool_stats *stats,
> +					  uint64_t *data)
> +{

...

> +	for (c = 0; c < priv->info->mib_count; c++) {
> +		mib = &ar8327_mib[c];
> +		reg = QCA8K_PORT_MIB_COUNTER(port->index) + mib->offset;
> +
> +		ret = qca8k_read(priv, reg, &val);
> +		if (ret < 0)
> +			continue;

Given the switch is built in, is this fast? The 8k driver avoids doing
register reads for this.

> +static int ipqess_port_set_eee(struct net_device *dev, struct ethtool_eee *eee)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	int ret;
> +	u32 lpi_en = QCA8K_REG_EEE_CTRL_LPI_EN(port->index);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 reg;
> +
> +	/* Port's PHY and MAC both need to be EEE capable */
> +	if (!dev->phydev || !port->pl)
> +		return -ENODEV;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	ret = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &reg);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->reg_mutex);
> +		return ret;
> +	}
> +
> +	if (eee->eee_enabled)
> +		reg |= lpi_en;
> +	else
> +		reg &= ~lpi_en;
> +	ret = qca8k_write(priv, QCA8K_REG_EEE_CTRL, reg);
> +	mutex_unlock(&priv->reg_mutex);

Everybody gets EEE wrong. The best example to copy is mvneta.

I also have a patchset which basically re-writes EEE in all the
drivers and moves as much as possible into the core. Those patches may
someday make it in. But until then, copy mvneta.

	Andrew

