Return-Path: <netdev+bounces-256458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDPTEY5YgmmkSgMAu9opvQ
	(envelope-from <netdev+bounces-256458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 21:20:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DCADE70E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 21:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC493038F4B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9D36C5B6;
	Tue,  3 Feb 2026 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nNfaWEW/"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9636B04D;
	Tue,  3 Feb 2026 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150027; cv=none; b=E0ud1s8kE2PGgdQQ+6WePB3WfMDuH79H3l/qZBvrIHGXDhOhnp5Ux3uw3aZc1Dw4hdlM9HUTzqEyLHSdio1Exk/CxS7tpNelnygL09s//p/2uBpofgbaMDc96Xu8slpPfJcqccRrX2l1aO+M48+6jxE22sdXp04NwkpEzOBLMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150027; c=relaxed/simple;
	bh=33L4F7RNo3atQ1S4fMCSYZ7DJS6KrDpKINj3LO2RF/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4Moo5Z8JYMsPagAV3J/X29YXPguJumHbsS8E+eib5PlEQFJi6niyR5WJ1JgzzgGSqKSqvfO4XBZ0fxytA+XDcN6GMvm8KRErx9v3MXWMqQy0HcEaiAkiom4Un3Xu015hcBPtBOgEQb+vLh54zLt72ns+bzInSeitiIFMoVVWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nNfaWEW/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f5FGR0xPNz9vDN;
	Tue,  3 Feb 2026 21:20:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770150015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4M8QhIULzNOjoredxH+knY7TXWnO8rNG8M5PaDR6rg=;
	b=nNfaWEW/8yx9z3yzUUTXe0ac+K/PRSDcbM+ssNjXOW+3vn0jFyLcrek0ZLDqcPodVmEJ3M
	EHYbGBKVHvP+jowV7qj8mSDzzKaZWvlynfyxhy3S5U3kcTyvNotExfm7smjriio9z9O3G9
	X0wjUAJbpHwus04dOe60+nV9oLtgTJvpgdP3WjdATP2yOwlaqvGNZVypL/79b2txkuOZUz
	3lp78mnOk3tokKax/x3WF0BFA8A4rgQE/6ErHm/Tv881QqDn/MLle9x2Om7pd4ECEujf8a
	+ceZbMpq+mCoQNeLS74FnGDNMNL6iXWP1bu487ozkvz7KK3dxESJvp+m7O/zeQ==
Date: Tue, 3 Feb 2026 21:19:55 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, shawnguo@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 conor+dt@kernel.org, horms@kernel.org, richardcochran@gmail.com,
 robh@kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, wahrenst@gmx.net, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [net-next,v22,2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20260203211955.23ef4355@wsk>
In-Reply-To: <20260203013909.822898-2-kuba@kernel.org>
References: <20260131233459.1625279-3-lukasz.majewski@mailbox.org>
	<20260203013909.822898-2-kuba@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: d44c323eebd3259a4a4
X-MBO-RS-META: rmcbbu1b5iqm1qmqn76eyusernjeqeja
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256458-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,google.com,redhat.com,davemloft.net,gmail.com,lists.linux.dev,lists.infradead.org,gmx.net,pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim]
X-Rspamd-Queue-Id: C3DCADE70E
X-Rspamd-Action: no action

Hi Jakub,

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see
> https://netdev-ai.bots.linux.dev/ai-local.html ---
> net: mtip: The L2 switch driver for imx287
>=20
> This patch adds support for the More Than IP L2 switch embedded in the
> imx287 SoC. This is a two-port switch placed between uDMA and MAC-NET
> blocks, which can be used for offloading network traffic.
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig
> > b/drivers/net/ethernet/freescale/mtipsw/Kconfig new file mode 100644
> > index 000000000000..a6fbdb59854f
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config FEC_MTIP_L2SW
> > +	tristate "MoreThanIP L2 switch support to FEC driver"
> > +	depends on OF
> > +	depends on NET_SWITCHDEV
> > +	depends on BRIDGE
> > +	depends on SOC_IMX28 || COMPILE_TEST
> > +	help
> > +	  This enables support for the MoreThan IP L2 switch on
> > i.MX
> > +	  SoCs (e.g. iMX287). It offloads bridging to this IP
> > block's
> > +	  hardware and allows switch management with standard
> > Linux tools.
> > +	  This switch driver can be used interchangeable with the
> > already =20
>                                                   ^^^^^^^^^^^
>=20
> This isn't a bug, but there's a grammar error: "can be used
> interchangeable with" should be "can be used interchangeably with"
> (adverb, not adjective).
>=20

Ok.

> > +	  available FEC driver, depending on the use case's
> > requirements. =20
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c new file mode
> > 100644 index 000000000000..45a7dfd253de
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c =20
>=20
> [ ... ]
>=20
> > +static void mtip_read_atable(struct switch_enet_private *fep, int
> > index,
> > +			     u32 *read_lo, u32 *read_hi)
> > +{
> > +	struct addr_table64b_entry __iomem *atable_base =3D
> > +		fep->hwentry->mtip_table64b_entry;
> > +
> > +	*read_lo =3D readl(&atable_base[index].lo);
> > +	*read_hi =3D readl(&atable_base[index].hi);
> > +}
> > +
> > +static void mtip_write_atable(struct switch_enet_private *fep, int
> > index,
> > +			      u32 write_lo, u32 write_hi)
> > +{
> > +	struct addr_table64b_entry __iomem *atable_base =3D
> > +		fep->hwentry->mtip_table64b_entry;
> > +
> > +	writel(write_lo, &atable_base[index].lo);
> > +	writel(write_hi, &atable_base[index].hi);
> > +} =20
>=20
> Can these functions race with concurrent access? Looking at the
> callers, mtip_write_atable is called from two different paths:
>=20
> 1. Static entry updates: mtip_config_switch -> esw_mac_addr_static ->
>    mtip_update_atable_static -> mtip_write_atable (no lock held)
>=20
> 2. Dynamic entry updates: timer callback -> mtip_mgnt_timer ->
>    mtip_atable_dynamicms_learn_migration ->
> mtip_update_atable_dynamic1 -> mtip_write_atable (learn_lock held)
>=20
> The learn_lock only protects the dynamic entry path. The static entry
> path runs during link changes (mtip_switch_restart called from
> mtip_adjust_link) without lock protection.
>=20
> Both paths can access the same hash block in the address table
> (determined by GET_BLOCK_PTR(hash)). If the timer fires during a link
> change callback, both can concurrently access the table, potentially
> causing torn reads (reading .lo from one entry version and .hi from
> another) or torn writes (the entry is in an inconsistent state
> between the two writel calls).
>=20
> Would extending learn_lock to protect all address table access work,
> or is a separate hw_lock needed for hardware register access?
>=20

This is handled in another way:

1. Partial write is not possible as this IP block handles it in order
(with some kind of 'latch' registers):

"VFxxx Controller Reference Manual, Rev. 0, 10/2016"
11.5.4 MAC address lookup table

"Each entry must be written or read with the low address accessed first
followed by the high address"

2. The code for dynamic IP writing will not "touch" the entries for
"static" MAC addresses - Figure 11-70 - bit 49 is "Record Type":
	1 - static entry
	0 - dynamic entry

IMHO, we are "safe" here.

> > +static bool mtip_update_atable_dynamic1(u32 write_lo, u32 write_hi,
> > +					int block_index, unsigned
> > int port,
> > +					unsigned int curr_time,
> > +					struct switch_enet_private
> > *fep) +{ =20
>=20
> [ ... ]
>=20
> > +	/* No more entry available in block overwrite oldest */
> > +	timeold =3D 0;
> > +	indexold =3D 0; =20
>                  ^^
>=20
> Does this initialization cause the wrong entry to be overwritten? The
> function searches for the oldest entry within a specific hash block
> (from block_index to index_end). When all 8 slots in the block are
> full, it finds the oldest entry to overwrite.
>=20
> If all entries in the block have timestamps equal to curr_time
> (meaning they were all updated in the current time interval), the
> condition at time > timeold is never true, and indexold never gets
> updated from 0.
>=20
> This causes the write to go to entry 0 in the global address table,
> which may be in a completely different hash block than the intended
> block_index. For example, if block_index is 8 (second block), but all
> entries have the same timestamp, the code will incorrectly write to
> entry 0 (first block) instead of entry 8.
>=20
> Should indexold be initialized to block_index instead of 0?
>=20

Yes, correct.

> > +	for (entry =3D block_index; entry < index_end; entry++) {
> > +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> > +		time =3D FIELD_GET(AT_TIMESTAMP_MASK, read_hi);
> > +		dev_dbg(&fep->pdev->dev, "%s : time %x currtime
> > %x\n",
> > +			__func__, time, curr_time);
> > +		time =3D mtip_timedelta(curr_time, time);
> > +		if (time > timeold) {
> > +			/* is it older ? */
> > +			timeold =3D time;
> > +			indexold =3D entry;
> > +		}
> > +	}
> > +
> > +	mtip_write_atable(fep, indexold, write_lo, conf);
> > +
> > +	/* Statistics (do it inbetween writing to .lo and .hi */ =20
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> This isn't a bug, but the comment doesn't match the code. The comment
> says "do it inbetween writing to .lo and .hi" but the statistics
> increment happens after mtip_write_atable completes. Looking at
> mtip_write_atable, it writes both .lo and .hi registers in sequence
> before returning, so the statistics are updated after both register
> writes complete, not between them.
>=20

I've removed this comment.

> > +	fep->at_block_overflows++;
> > +	dev_err(&fep->pdev->dev, "%s update time,
> > at_block_overflows %x\n",
> > +		__func__, fep->at_block_overflows);
> > +	/* newly inserted */
> > +	return true;
> > +} =20
>=20
> [ ... ]
>=20
> > +static void mtip_mgnt_timer(struct timer_list *t)
> > +{
> > +	struct switch_enet_private *fep =3D timer_container_of(fep,
> > t, =20
>                                               ^^^^^^^^^^^^^^^^^^
>=20
> Is timer_container_of the correct kernel API? The standard kernel API
> for timer callbacks is from_timer, not timer_container_of. This will
> likely cause compilation errors or undefined behavior depending on how
> timer_container_of is defined.
>=20
> The correct usage should be:
>     struct switch_enet_private *fep =3D from_timer(fep, t, timer_mgnt);
>=20

This seems to be a false positive:

"treewide, timers: Rename from_timer() to timer_container_of()"
SHA1: 41cb08555c4164996d67c78b3bf1c658075b75f1

has replaced the from_timer() with timer_container_of()

> > +
> > timer_mgnt); +
> > +	mtip_atable_dynamicms_learn_migration(fep, mtip_get_time(),
> > +					      NULL, NULL);
> > +	mod_timer(&fep->timer_mgnt,
> > +		  jiffies +
> > msecs_to_jiffies(LEARNING_AGING_INTERVAL)); +} =20
>=20
> [ ... ]
>=20
> > +static int mtip_mii_init(struct switch_enet_private *fep,
> > +			 struct platform_device *pdev)
> > +{
> > +	struct device_node *node;
> > +	int err =3D -ENXIO; =20
>=20
> [ ... ]
>=20
> > +	node =3D of_get_child_by_name(pdev->dev.of_node, "mdio");
> > +	if (node)
> > +		dev_err(&fep->pdev->dev, "%s: PHY name: %s\n", =20
>                 ^^^^^^^^
>=20
> This isn't a bug, but is dev_err the right log level here? Finding the
> MDIO node is expected normal behavior during probe, not an error.
> Using dev_err will cause unnecessary error-level log messages during
> normal operation. Should this be dev_dbg instead?
>=20

+1

> > +			__func__, node->name);
> > +
> > +	err =3D of_mdiobus_register(fep->mii_bus, node); =20
>=20
> > +static void mtip_ndev_cleanup(struct switch_enet_private *fep)
> > +{
> > +	struct mtip_ndev_priv *priv;
> > +	int i;
> > +
> > +	for (i =3D 0; i < SWITCH_EPORT_NUMBER; i++) {
> > +		if (fep->ndev[i]) {
> > +			priv =3D netdev_priv(fep->ndev[i]);
> > +			cancel_work_sync(&priv->tx_timeout_work); =20
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Is this work queue ever initialized? Looking through the code,
> tx_timeout_work is never initialized with INIT_WORK or similar.
> Calling cancel_work_sync on an uninitialized work structure will
> operate on garbage memory and cause undefined behavior or crashes.
>=20
> Should tx_timeout_work be initialized in mtip_ndev_init, or should
> this cancel_work_sync call be removed if the work queue is not
> actually used?
>=20

This is added and handled (properly) in latter commit, when
mtip_netdev_ops() are added.

I've moved it there.

> > +
> > +			unregister_netdev(fep->ndev[i]);
> > +			free_netdev(fep->ndev[i]);
> > +			fep->ndev[i] =3D NULL;
> > +		}
> > +	}
> > +} =20
>=20
> [ ... ]
>=20
> > +static int mtip_ndev_init(struct switch_enet_private *fep,
> > +			  struct platform_device *pdev)
> > +{
> > +	struct mtip_ndev_priv *priv;
> > +	int i, ret =3D 0;
> > +
> > +	for (i =3D 0; i < SWITCH_EPORT_NUMBER; i++) {
> > +		fep->ndev[i] =3D alloc_netdev(sizeof(struct
> > mtip_ndev_priv),
> > +					    fep->ndev_name[i],
> > NET_NAME_USER,
> > +					    ether_setup);
> > +		if (!fep->ndev[i]) {
> > +			ret =3D -ENOMEM;
> > +			goto cleanup_created_ndev;
> > +		}
> > +
> > +		fep->ndev[i]->ethtool_ops =3D &mtip_ethtool_ops;
> > +		fep->ndev[i]->netdev_ops =3D &mtip_netdev_ops;
> > +		SET_NETDEV_DEV(fep->ndev[i], &pdev->dev);
> > +
> > +		priv =3D netdev_priv(fep->ndev[i]);
> > +		priv->dev =3D fep->ndev[i];
> > +		priv->fep =3D fep;
> > +		priv->portnum =3D i + 1;
> > +		fep->ndev[i]->irq =3D fep->irq;
> > +
> > +		mtip_setup_mac(fep->ndev[i]);
> > +
> > +		ret =3D register_netdev(fep->ndev[i]);
> > +		if (ret) {
> > +			dev_err(&fep->ndev[i]->dev,
> > +				"%s: ndev %s register err: %d\n",
> > __func__,
> > +				fep->ndev[i]->name, ret);
> > +			free_netdev(fep->ndev[i]);
> > +			fep->ndev[i] =3D NULL;
> > +			goto cleanup_created_ndev;
> > +		}
> > +
> > +		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2
> > switch %pM\n",
> > +			fep->ndev[i]->name,
> > fep->ndev[i]->dev_addr);
> > +	}
> > +
> > +	return 0;
> > +
> > + cleanup_created_ndev:
> > +	if (i =3D=3D SWITCH_EPORT_NUMBER - 1) =20
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Does this condition cause a resource leak? The cleanup code only calls
> mtip_ndev_cleanup if the failure occurs when processing the last
> device (i=3D=3D1 for 2 devices). If the failure occurs on device 0
> (i=3D=3D0), the condition is false and mtip_ndev_cleanup is not called,
> leaking the successfully created network device.
>=20
> For example, if device 0 is successfully created and registered, but
> device 1 fails during alloc_netdev, then i=3D1 and the condition (1 =3D=3D
> 1) is true, so cleanup happens. But if register_netdev fails for
> device 0, we free that device and set fep->ndev[0]=3DNULL, then goto
> cleanup with i=3D0, and the condition (0 =3D=3D 1) is false, so no cleanup
> happens for any other successfully created devices before the failure
> point.
>=20
> Should mtip_ndev_cleanup be called unconditionally, or should the
> cleanup logic track which devices need cleanup?
>=20
> jakub: not sure there's a bug here, but AI is right that this is an
> odd pattern
>=20

I will remove this if () and call the mtip_ndev_cleanup()
unconditionally.

> > +		mtip_ndev_cleanup(fep);
> > +
> > +	return ret;
> > +} =20
>=20
> [ ... ]
>=20
> > +static int mtip_parse_of(struct switch_enet_private *fep,
> > +			 struct device_node *np)
> > +{
> > +	struct device_node *p;
> > +	unsigned int port_num;
> > +	int ret =3D 0;
> > +
> > +	p =3D of_get_child_by_name(np, "ethernet-ports");
> > +
> > +	for_each_available_child_of_node_scoped(p, port) {
> > +		if (of_property_read_u32(port, "reg", &port_num))
> > +			continue;
> > +
> > +		if (!(port_num =3D=3D 1 || port_num =3D=3D 2)) {
> > +			dev_err(&fep->pdev->dev,
> > +				"%s: The switch supports up to %d
> > ports!\n",
> > +				__func__, SWITCH_EPORT_NUMBER);
> > +			goto of_get_err;
> > +		}
> > +
> > +		fep->n_ports =3D port_num;
> > +		ret =3D of_get_mac_address(port, &fep->mac[port_num
> > - 1][0]);
> > +		if (ret)
> > +			dev_dbg(&fep->pdev->dev,
> > +				"of_get_mac_address(%pOF) failed
> > (%d)!\n",
> > +				port, ret);
> > +
> > +		ret =3D of_property_read_string(port, "label",
> > +
> > &fep->ndev_name[port_num - 1]);
> > +		if (ret < 0) {
> > +			dev_err(&fep->pdev->dev,
> > +				"%s: Cannot get ethernet port name
> > (%d)!\n",
> > +				__func__, ret);
> > +			goto of_get_err;
> > +		}
> > +
> > +		ret =3D of_get_phy_mode(port,
> > &fep->phy_interface[port_num - 1]);
> > +		if (ret < 0) {
> > +			dev_err(&fep->pdev->dev,
> > +				"%s: Cannot get PHY mode (%d)!\n",
> > __func__,
> > +				ret);
> > +			goto of_get_err;
> > +		}
> > +
> > +		fep->phy_np[port_num - 1] =3D of_parse_phandle(port,
> > +
> > "phy-handle", 0); =20
>                                                              ^^^^^^^^^^^^=
^^^^^^
>=20
> Can these device_node references leak on probe failure? The function
> acquires references via of_parse_phandle and stores them in
> fep->phy_np. If the function fails after successfully obtaining one
> or more references, or if a later function in mtip_sw_probe fails,
> these references are never released.
>=20
> The references are only released in mtip_mii_remove which is called
> from mtip_sw_remove. However, if probe fails, remove is never called.
>=20
> For example:
> 1. mtip_parse_of successfully calls of_parse_phandle for port 0,
> storing reference in fep->phy_np[0]
> 2. Either mtip_parse_of fails on port 1, or mtip_parse_of succeeds
> but a later step in mtip_sw_probe fails (e.g., mtip_switch_dma_init,
>    mtip_mii_init, or mtip_ndev_init)
> 3. mtip_sw_probe returns error
> 4. Device probe fails, so mtip_sw_remove is never called
> 5. mtip_mii_remove is never called, so fep->phy_np[0] reference is
> never released with of_node_put
>=20
> Should proper cleanup of phy_np references be added in mtip_parse_of
> error path and/or in mtip_sw_probe error paths?
>=20

I've rewritten the error handling path in mtip_sw_probe() and
mtip_parse_of().

> > +		if (!fep->phy_np[port_num - 1]) {
> > +			dev_err(&fep->pdev->dev,
> > +				"%s: PHY handle not defined!\n",
> > __func__);
> > +			ret =3D -ENODEV;
> > +			goto of_get_err;
> > +		}
> > +	}
> > +
> > + of_get_err:
> > +	of_node_put(p);
> > +
> > +	return ret;
> > +} =20
>=20
> [ ... ]
>=20
> > +static void mtip_sw_remove(struct platform_device *pdev)
> > +{
> > +	struct switch_enet_private *fep =3D
> > platform_get_drvdata(pdev); +
> > +	mtip_ndev_cleanup(fep);
> > +
> > +	mtip_mii_remove(fep);
> > +
> > +	dma_free_coherent(&fep->pdev->dev, PAGE_SIZE,
> > fep->rx_bd_base,
> > +			  fep->bd_dma);
> > +	fep->rx_bd_base =3D NULL;
> > +	fep->tx_bd_base =3D NULL;
> > +
> > +	timer_delete_sync(&fep->timer_mgnt); =20
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Does the timer get deleted too late in the cleanup sequence? The timer
> callback mtip_mgnt_timer accesses fep->hwp, fep->hwentry, and
> fep->pdev->dev. However, timer_delete_sync is called after
> mtip_ndev_cleanup, mtip_mii_remove, and dma_free_coherent.
>=20
> If the timer fires between these cleanup operations and
> timer_delete_sync, it will access freed or cleaned resources, causing
> use-after-free and potential crashes.
>=20
> Should the timer be deleted first before any other cleanup operations?
>=20
> Correct order would be:
> 1. timer_delete_sync(&fep->timer_mgnt);
> 2. mtip_ndev_cleanup(fep);
> 3. mtip_mii_remove(fep);
> 4. dma_free_coherent(...);
>=20

I've moved it up.

> > +	platform_set_drvdata(pdev, NULL);
> > +} =20



--=20
Best regards,

=C5=81ukasz Majewski

