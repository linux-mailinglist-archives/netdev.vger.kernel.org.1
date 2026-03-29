Return-Path: <netdev+bounces-272998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBE9KW2EyWndygUAu9opvQ
	(envelope-from <netdev+bounces-272998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:58:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 073CB353E0D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3793011F12
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC09389444;
	Sun, 29 Mar 2026 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1v//S5n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991F3876BF;
	Sun, 29 Mar 2026 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814191; cv=none; b=jP1YprSUyiswAQ2YVz6XlqE6ioxsu5nji8YHyZIFZ18NLZ5H83RjCAMpUe6XpEyUnh3KRcDXlSIfqkjHv0535BLHgxp9Z+t7y/m2Z4bhEqX68QcuYqIV8EzDMMe5h+/PuTN5ys1D7inuIT3JCIGtYNQdvdy6yZnCayLkDmNF3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814191; c=relaxed/simple;
	bh=4p/WaX8te25qMy8WeUumTA75QWOrLvm5o+2T5WSdwl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bb+U7Vd3WWYxplpaUfbGeX1rxuGJOAKTW/UhuCQXQ86brMotrmL2HRCPK5+0SkdURZa17i62xSlWlQgWnhY6H9HiN8/FDMiHsvMKDv6IXCuzbAZzxMZnwTGa88h+IqlQ1hH8kAba6ADehwPE6XGZHUkqTrr3MG9WdCClq1Xb7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1v//S5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B425C116C6;
	Sun, 29 Mar 2026 19:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814191;
	bh=4p/WaX8te25qMy8WeUumTA75QWOrLvm5o+2T5WSdwl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1v//S5nTtdxx3FI6NZKwwlJuLArFAn7Ip3Q46PpPWHGLB9hIt9fa+cpm6QxjayFq
	 rZQfNZ2hhC9DE8bp5S7MdPOK3VGBsCpu9GiHRV6E8aaMQw/qwSMurqiO//OBD+3M2W
	 thtFJZWuM5X/9MPm14vCQIno+iTLTs2FbVcL39ZY9LiApgNq45KCQNSbtdWsuLTJtU
	 b2I/l9sMOl4KnytahtwJ87bCNu/jOg/L8EH4bx7YQK49CLe6QW7Qzafdfu04hwxJfp
	 dir1MVXqzkY97FUPmB4F8HlbY3rOdtIsl2eT5Ts5PzMH7/az17Dr4kxi5KhnlOJe3d
	 gVJ5MGxtd0XPw==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/9] net: dsa: lan9645x: add basic dsa driver for LAN9645X
Date: Sun, 29 Mar 2026 12:56:29 -0700
Message-ID: <20260329195629.2789129-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-4-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-4-f7504e3b0681@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-272998-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 073CB353E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: dsa: lan9645x: add basic dsa driver for LAN9645X

This commit adds a basic DSA driver for the Microchip LAN9645X switch. It
includes initialization, port module setup for NPI, CPU, and front ports,
and phylink integration for MAC side configuration.

diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
[ ... ]
> +static void disable_conduit_ipv6(struct lan9645x *lan9645x,
> +				 struct net_device *conduit)
> +{
> +	struct inet6_dev *dev_v6;
> +
> +	if (!conduit)
> +		return;
> +
> +	/* IPv6 on the conduit will generate frames bypassing our tag driver, so
> +	 * they lack an IFH. This will be garbage in garbage out and we want to
> +	 * avoid this.
> +	 */
> +	rtnl_lock();
> +	dev_v6 = __in6_dev_get(conduit);
> +	if (dev_v6) {
> +		WRITE_ONCE(dev_v6->cnf.disable_ipv6, 1);
> +		dev_warn(lan9645x->dev, "Disabled IPv6 on conduit device: %s\n",
> +			 netdev_name(conduit));
> +	}
> +	rtnl_lock();
> +}

Does directly modifying dev_v6->cnf.disable_ipv6 bypass the proper sysctl
teardown path (addrconf_disable_ipv6) and leave the IPv6 stack in an
inconsistent state on the conduit device by failing to clean up routes,
addresses, and MLD memberships?

Is it a layering violation for a switch driver to alter the networking
configuration of an external upper device, especially since this change
isn't reverted during driver unbind?

[ ... ]
> +void lan9645x_npi_port_init(struct lan9645x *lan9645x,
> +			    struct dsa_port *cpu_port)
> +{
> +	int port = cpu_port->index;
> +	struct lan9645x_port *p;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +	lan9645x->npi = port;

In a cascaded multi-switch DSA topology, cpu_port->index may belong to a
different switch and be greater than 8. If lan9645x_to_port returns NULL,
will this cause a panic when dereferencing p->chip_port below?

[ ... ]
> +	/* Configure IFH prefix mode for NPI port. */
> +	lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_LONG) |
> +		SYS_PORT_MODE_INCL_INJ_HDR_SET(LAN9645X_TAG_PREFIX_NONE),
> +		SYS_PORT_MODE_INCL_XTR_HDR |
> +		SYS_PORT_MODE_INCL_INJ_HDR,
> +		lan9645x,
> +		SYS_PORT_MODE(p->chip_port));

Setting LAN9645X_TAG_PREFIX_NONE means the hardware interprets the first
bytes of any frame received from the host as an IFH command structure.

Does this allow a local user to transmit crafted frames (for example, via
raw sockets or standard protocols) whose MAC address bytes map to malicious
IFH commands, thereby bypassing VLAN isolation or flooding the switch?

Should the hardware be configured to require a strict prefix, such as
LAN9645X_TAG_PREFIX_LONG, for injected frames to prevent this?

diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
[ ... ]
> +static int lan9645x_setup(struct dsa_switch *ds)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct device *dev = lan9645x->dev;
> +	u32 all_phys_ports;
> +	int err;
> +
> +	lan9645x->num_phys_ports = ds->num_ports;
> +	all_phys_ports = GENMASK(lan9645x->num_phys_ports - 1, 0);
> +
> +	err = lan9645x_reset_switch(lan9645x);
> +	if (err)
> +		return err;
> +
> +	lan9645x->ports = devm_kcalloc(lan9645x->dev, lan9645x->num_phys_ports,
> +				       sizeof(struct lan9645x_port *),
> +				       GFP_KERNEL);

Since the DSA .setup callback can be invoked multiple times during the
platform device's lifetime (for example, when the DSA master interface is
unbound and bound again), does using devm_kcalloc here cause a memory leak?
Should these allocations be moved to .probe or managed with kcalloc and
freed in .teardown?

[ ... ]
> +	/* Set all the entries to obey VLAN. */
> +	for (int i = 0; i < PGID_ENTRIES; ++i)
> +		lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
> +		       lan9645x, ANA_PGID_CFG(i));

PGID_ENTRIES is defined as 89, so this loop initializes indices 0 through
88. Since the CPU port is index 9, its source PGID is PGID_SRC + CPU_PORT
(80 + 9 = 89).

Is index 89 left uninitialized, breaking the OBEY_VLAN rule and allowing
CPU-injected frames to leak across VLAN boundaries?

[ ... ]
> +	/* Multicast to all front ports */
> +	lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MC));
> +
> +	/* IP multicast to all front ports */
> +	lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MCIPV4));
> +	lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_MCIPV6));
> +
> +	/* Unicast to all front ports */
> +	lan_wr(all_phys_ports, lan9645x, ANA_PGID(PGID_UC));
> +
> +	/* Broadcast to all ports */
> +	lan_wr(BIT(CPU_PORT) | all_phys_ports, lan9645x, ANA_PGID(PGID_BC));

PGID_BC includes BIT(CPU_PORT) and all_phys_ports (which includes the NPI
port). Will this forward broadcast frames to both the CPU extraction queue
and the NPI port's normal egress queue, causing duplicate frames for the host?

Conversely, the multicast masks and PGID_UC exclude BIT(CPU_PORT). Does
this cause them to bypass the CPU extraction queue entirely, thereby
lacking the LONG extraction prefix and breaking the host's DSA tagger parsing?

diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
[ ... ]
> +static int lan9645x_phylink_mac_prepare(struct phylink_config *config,
> +					unsigned int mode,
> +					phy_interface_t iface)
> +{
> +	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
> +	struct lan9645x *lan9645x = p->lan9645x;
> +	int port = p->chip_port;
> +	u32 mask;
> +
> +	if (port == 5 || port == 6 || port > 8)
> +		return -EINVAL;
> +
> +	mask = HSIO_HW_CFG_GMII_ENA_SET(BIT(port));
> +	lan_rmw(mask, mask, lan9645x, HSIO_HW_CFG);
> +
> +	if (port == 4 && phy_interface_mode_is_rgmii(iface))
> +		lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(1),
> +			HSIO_HW_CFG_RGMII_0_CFG,
> +			lan9645x, HSIO_HW_CFG);

The lan9645x_phylink_get_caps function advertises RGMII support for ports
4, 7, and 8. Does restricting the hardware multiplexer configuration here to
port 4 break connectivity for ports 7 and 8 when used in RGMII mode?

diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
[ ... ]
> +int lan9645x_port_set_maxlen(struct lan9645x *lan9645x, int port, size_t sdu)
> +{
> +	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
> +	int maxlen = sdu + ETH_HLEN + ETH_FCS_LEN;

Does this maximum frame length calculation drop standard 1500-byte MTU
frames that are 802.1Q VLAN tagged (1522 bytes total), since it does not
account for VLAN_HLEN?

[ ... ]
> +int lan9645x_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +
> +	if (dp->dn) {
> +		p->rx_internal_delay =
> +			of_property_present(dp->dn, "rx-internal-delay-ps");
> +		p->tx_internal_delay =
> +			of_property_present(dp->dn, "tx-internal-delay-ps");
> +	}

These are standard integer properties specifying delays in picoseconds. If
a user explicitly disables the delay via devicetree using a value of 0,
will of_property_present evaluate to true and enable the hardware delay
anyway? Should of_property_read_u32 be used instead to check the value?

