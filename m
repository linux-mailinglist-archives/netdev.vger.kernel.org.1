Return-Path: <netdev+bounces-295586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nZG+Hq4yImoSTwEAu9opvQ
	(envelope-from <netdev+bounces-295586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:21:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EA2644AA2
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:21:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SnaSb2a1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295586-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295586-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92DE2302F240
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B013B7B98;
	Fri,  5 Jun 2026 02:19:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6463CA48C;
	Fri,  5 Jun 2026 02:18:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625943; cv=none; b=hZIbkx46q9ji/izqgjJGPK+GCJp6vxgRgibqcoucEBdk0A8cBEMdBqYRJ8Gz9B3leTOUQi8+uh4yIcdpAjw5cHrQWGSatYoN/ATsXs3CVp37oQHEYJxvjvJaUv5RDhUV9vinUWiiCO1yA4KFQEL/iahFzhRYFz7Yu7RP2HFTCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625943; c=relaxed/simple;
	bh=L0j99wFpCUAUr0Qd1c9SCo0ktKiz0H9ld7dt4nJL69k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9X2vejCbG8MmDhfhMBtBew+Mrofx0V+xM3p4TraUhrEtgSzehW+wDkytG7QoF9/MdDSObktCWUpJEZqNc6ZcVImVQKUNWThD3lAVkWdVBQhseX7H9rK6DTKtW2KBgWACo4SQ+Z20F8i+g45B8WkS5+QEb+Wdqu75WHnlKDKBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnaSb2a1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20B41F00899;
	Fri,  5 Jun 2026 02:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780625937;
	bh=mIZRJWfB9uIoT21u274B0cnlZ9ADp5gVESO1zB5LtY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SnaSb2a1NiGHKTNUDDVS/xqHJAY6OKx82UAQ6E8istkspZEghE6Lr1pXt40a3G1+N
	 coX3EKFfTlYu2Q7zgoJpqob88M/Zl8yJx5JOuzSE0m/i/LQCFDxHrv0gofIciiyj0e
	 0kdOOXHnFVZ9c1863hF8sUwzlnwJ0F8khi4oI0rgmL1pXgSnYQrIYknCK80+FAyuli
	 EfLcMlBLYeDOn0gJbycNJ5YoEF7BAVNooKBjioXeE8BaXviHhZGeWx4VkB4gl6aL+E
	 JPSXYKwWGiVcUxtdAY5agkHqu8A+xBMf1E0DZdFVB8ck0NoU3h/WZvpo2CEK+N8A5x
	 Gw8uX74FTenkg==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	lgirdwood@gmail.com,
	nathan@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	krzk+dt@kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org
Subject: Re: [net-next v24 4/7] net: mtip: Add net_device_ops functions to the L2 switch driver
Date: Thu,  4 Jun 2026 19:18:55 -0700
Message-ID: <20260605021855.3594587-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601112437.2216043-5-lukasz.majewski@mailbox.org>
References: <20260601112437.2216043-5-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-295586-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukasz.majewski@mailbox.org,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:lgirdwood@gmail.com,m:nathan@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk+dt@kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:robh@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6EA2644AA2

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mtip: Add net_device_ops functions to the L2 switch driver

This patch adds the ndo_start_xmit, ndo_set_rx_mode, ndo_tx_timeout,
ndo_set_mac_address, and ndo_get_port_parent_id callbacks to the MTIP
L2 switch driver, along with helpers and a tx_timeout work item.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 5b5229ee411d..7dfeda230e3f 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> @@ -617,6 +740,76 @@ static void mtip_switch_restart(struct net_device *dev, int duplex0,
>  	mtip_config_switch(fep);
>  }
>  
> +static void mtip_print_hw_state(struct net_device *dev)
> +{

[ ... ]

> +static void mtip_timeout_work(struct work_struct *work)
> +{
> +	struct mtip_ndev_priv *priv =
> +		container_of(work, struct mtip_ndev_priv, tx_timeout_work);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct net_device *dev = priv->dev;
> +
> +	rtnl_lock();
> +	if (netif_device_present(dev) || netif_running(dev)) {
> +		napi_disable(&fep->napi);
> +		netif_tx_lock_bh(dev);
> +		mtip_switch_restart(dev, fep->full_duplex[0],
> +				    fep->full_duplex[1]);
> +		netif_tx_wake_all_queues(dev);
> +		netif_tx_unlock_bh(dev);
> +		napi_enable(&fep->napi);
> +	}
> +	rtnl_unlock();
> +}

[High]
Should the guard here be a logical AND rather than OR?

	if (netif_device_present(dev) || netif_running(dev)) {

netif_device_present() returns true unless netif_device_detach() has been
called, and this driver never calls netif_device_detach().  So the OR
collapses to "always true" once the device has been registered, and the
work proceeds even after mtip_close().

mtip_close() does this on the last close:

	if (fep->usage_count == 1) {
		napi_disable(&fep->napi);
		netif_napi_del(&fep->napi);
		mtip_free_buffers(dev);
		clk_disable(fep->clk_ipg);
	}

After that, can mtip_timeout_work() running due to a previously scheduled
watchdog still call napi_disable(&fep->napi) / napi_enable(&fep->napi) on
a netif_napi_del()'d napi, and call mtip_switch_restart() which writes
hardware registers after clk_ipg has been disabled?

Would gating the work on fep->usage_count (and/or cancel_work_sync() in
mtip_close()) be more correct than the present netif_device_present() ||
netif_running() check?

[ ... ]

> @@ -1095,6 +1288,98 @@ static int mtip_close(struct net_device *dev)
>  	return 0;
>  }
>  
> +#define FEC_HASH_BITS	6		/* #bits in hash */

[ ... ]

> +static int mtip_set_mac_address(struct net_device *dev, void *p)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	void __iomem *enet_addr = fep->enet_addr;
> +	struct sockaddr *addr = p;
> +	int ret;
> +
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	ret = mtip_update_atable_static((unsigned char *)addr->sa_data,
> +					7, 7, fep);
> +	if (ret)
> +		return ret;

[Medium]
Is the previously-programmed MAC ever removed from the switch's static
address table?  mtip_update_atable_static() either updates a matching
entry in place or fills the first empty slot in an 8-entry block:

	for (entry = block_index; entry < index_end; entry++) {
		mtip_read_atable(fep, entry, &read_lo, &read_hi);
		if (read_lo == write_lo &&
		    ((read_hi & 0x0000FFFF) ==
		     (write_hi & 0x0000FFFF))) {
			mtip_write_atable(fep, entry, write_lo, write_hi);
			...
			return 0;
		} else if (!(read_hi & (1 << 16))) {
			mtip_write_atable(fep, entry, write_lo, write_hi);
			...
			return 0;
		}
	}
	...
	return -ENOSPC;

After 8 distinct MAC changes whose CRC8 maps to the same block, will
further mtip_set_mac_address() calls return -ENOSPC, and will the stale
MACs continue to be honored as static entries with port mask 7 and
priority 7?

> +
> +	eth_hw_addr_set(dev, addr->sa_data);
> +
> +	if (priv->portnum == 2)
> +		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
> +
> +	writel(dev->dev_addr[3] | (dev->dev_addr[2] << 8) |
> +	       (dev->dev_addr[1] << 16) | (dev->dev_addr[0] << 24),
> +	       enet_addr + MCF_FEC_PALR);
> +	writel((dev->dev_addr[5] << 16) | (dev->dev_addr[4] << 24),
> +	       enet_addr + MCF_FEC_PAUR);
> +
> +	return 0;
> +}

[Medium]
Should fep->mac[priv->portnum - 1] be updated here as well?  The driver
caches the MAC in fep->mac[] and mtip_get_port_parent_id() reads
fep->mac[0] as the parent identifier.  After a userspace MAC change
fep->mac[] stays at its boot/DT value, so ndo_get_port_parent_id keeps
returning the old value while dev->dev_addr and the hardware registers
have moved on.

[Medium]
Does this sequence need to disable the controller before reprogramming
PALR/PAUR?  mtip_configure_enet_mii() programs ECR to MAGIC_ENA only
(no ETHER_EN), then writes PALR/PAUR, then enables ETHER_EN at the end:

	writel(MCF_FEC_ECR_MAGIC_ENA, enet_addr + MCF_FEC_ECR);
	...
	writel(... , enet_addr + MCF_FEC_PALR);
	writel(... , enet_addr + MCF_FEC_PAUR);
	...
	writel(readl(enet_addr + MCF_FEC_ECR) | MCF_FEC_ECR_ETHER_EN,
	       enet_addr + MCF_FEC_ECR);

mtip_set_mac_address() writes PALR and PAUR while ETHER_EN can be set
and traffic is being matched, and it does not take fep->hw_lock either,
so it can race with mtip_configure_enet_mii() / mtip_switch_restart()
that touch the same register block.  Is that intended?

> +
> +static int mtip_get_port_parent_id(struct net_device *ndev,
> +				   struct netdev_phys_item_id *ppid)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(ndev);
> +	struct switch_enet_private *fep = priv->fep;
> +
> +	ppid->id_len = sizeof(fep->mac[0]);
> +	memcpy(&ppid->id, &fep->mac[0], ppid->id_len);
> +
> +	return 0;
> +}

[Medium]
Is fep->mac[0] a suitable choice for the switch parent id?  fep->mac[]
is populated only from DT via of_get_mac_address() in mtip_parse_of();
when DT does not supply a mac-address for port 1, fep->mac[0] stays
zeroed (it is kzalloc'd in probe), since mtip_setup_mac()'s bootloader
and random-MAC fallbacks update dev->dev_addr only and never write back
into fep->mac[].

If two MTIP switches both lack a DT MAC for port 1, both will report
ppid = 00:00:00:00:00:00, which switchdev/bridge code will treat as the
same switch (offload_fwd_mark, bridge offload decisions).

Would a switch-wide identifier (a register-derived id, the platform
of_node phandle, etc.) be more appropriate than a port MAC?

[ ... ]

> @@ -1158,10 +1448,14 @@ static int mtip_switch_dma_init(struct switch_enet_private *fep)
>  
>  static void mtip_ndev_cleanup(struct switch_enet_private *fep)
>  {
> +	struct mtip_ndev_priv *priv;
>  	int i;
>  
>  	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
>  		if (fep->ndev[i]) {
> +			priv = netdev_priv(fep->ndev[i]);
> +			cancel_work_sync(&priv->tx_timeout_work);
> +
>  			unregister_netdev(fep->ndev[i]);
>  			free_netdev(fep->ndev[i]);
>  			fep->ndev[i] = NULL;

[High]
Is the order here safe against the netdev TX watchdog?  The watchdog
timer is only stopped inside unregister_netdev() (via dev_deactivate),
so between cancel_work_sync() returning and unregister_netdev() actually
disarming the watchdog the timer can still fire mtip_timeout(), which
calls schedule_work(&priv->tx_timeout_work) and re-queues the work that
was just drained.

After unregister_netdev() and free_netdev() complete, priv (which embeds
tx_timeout_work) is freed, and when the worker thread later picks up
the queued work it will dereference a freed priv/fep.

Would the sequence

	unregister_netdev(fep->ndev[i]);
	cancel_work_sync(&priv->tx_timeout_work);
	free_netdev(fep->ndev[i]);

be safer, since unregister_netdev() quiesces all sources of new work
before cancel_work_sync() drains what remains?  The same concern applies
to the rollback path in mtip_ndev_init() for ports whose watchdog is
already active.

