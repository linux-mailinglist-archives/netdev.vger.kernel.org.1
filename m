Return-Path: <netdev+bounces-296026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E1LoA62BI2rgugEAu9opvQ
	(envelope-from <netdev+bounces-296026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED964C312
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bbfsgX2v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296026-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296026-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17DDA3028DDE
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E18233723;
	Sat,  6 Jun 2026 02:10:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CE1C2AA;
	Sat,  6 Jun 2026 02:10:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711850; cv=none; b=GmsY4aijTZiNYR+R6QoOANHKSBBVjt8xhvTy7vcl2PdlH/vsa1ms5LI/dfN6jZDbMhXzAlmcDIhhK/kkk25+wgYoUx5Hfy05JFGJn4D2dFMUuGj7qGghlLDco/JNSp2lgi10r6xaa/gEzoWYjOu2qwCQH55tGEANJ+gM/YPrJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711850; c=relaxed/simple;
	bh=lNFD03ePlf1Bc6M78coQulpqrgJ5H1v2B8hI1xHsqbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDBhBFe61a0p0Y1dPsIQSrhFcU2i7Me/dy4WVHLSyHSjtpt24HcPoi743ILrnTXkEsRipiQhDWC1z7D6jDePGTKC1qK0mXpCRQGoO0xpXcC1TgD1Dj/leUtiVAtnSjExAt98oPE88yqohO5aA8DTS7UnIi230dDJtUno/t9dN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbfsgX2v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AD91F00893;
	Sat,  6 Jun 2026 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711849;
	bh=HXZvyS4g7zloBoaeVtOb7icNcuXfmlIIKdOSRCzs5a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bbfsgX2viiL2kZoDMs7BqKGIJCCHvIlnJSrYF4cFkc9o2+rC9F0cU1V7UeLzhO77q
	 r0pqt8Ufa9jje2VeFGjn828fSucALqYsOehmXKQF/wv9mUOpOGlaEz31Dia8DKnwMJ
	 ypIaj2IEuQ6z6MCrKDVlEpZmy1O+xoASnwhq2nZTcUgRCMBmK4EZIOmXyW0YRu00cT
	 9FF/g7XcaktRcmijxJCO+noeoNC5ojMxGEFaaR0Go+x6G9Wz85A+daO3Clu6MCfPjI
	 7Uqz0WwcKxdPpHl0sk17rdmlRY4IDXS8t8GAcboy2/taDjPSEWtRAo72eggxoakSxY
	 t7w7vyXx1OEAA==
From: Jakub Kicinski <kuba@kernel.org>
To: ioana.ciornei@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] dpaa2-switch: add support for LAG offload
Date: Fri,  5 Jun 2026 19:10:47 -0700
Message-ID: <20260606021047.4124576-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603143623.3712024-3-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-3-ioana.ciornei@nxp.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296026-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BED964C312

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpaa2-switch: add support for LAG offload

This patch adds the bulk of the changes needed in order to support
offloading of an upper bond device.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index a0bf5b50aae5f..d082ecf9b1252 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c

[ ... ]

> @@ -2210,19 +2300,275 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
> +static int dpaa2_switch_port_bond_join(struct net_device *netdev,
> +				       struct net_device *bond_dev,
> +				       struct netdev_lag_upper_info *info,
> +				       struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	/* If the bond device is a switch port, join the bridge as well */
> +	bridge_dev = netdev_master_upper_dev_get(bond_dev);
> +	if (!bridge_dev || !netif_is_bridge_master(bridge_dev))
> +		return 0;
> +
> +	err = dpaa2_switch_port_bridge_join(netdev, bridge_dev, extack);

[Severity: High]
Should switchdev_bridge_port_offload() inside dpaa2_switch_port_bridge_join()
receive the actual bridge port (the bond device) rather than the lower
physical port?

For ports enslaved to a LAG, passing the lower physical port might cause
switchdev to immediately abort the offload with -EINVAL, since the netdev
is not directly enslaved to the bridge. I see this was addressed in a later
commit adding a dpaa2_switch_port_to_bridge_port() helper.

[Severity: High]
When a port joins a LAG that is already enslaved to a bridge, is there a risk
of dpaa2_switch_port_set_fdb() corrupting the in_use flag of active FDBs?

Since the port first acquires the bond's shared FDB, and then
dpaa2_switch_port_bridge_join() finds a port already using that same FDB,
the code in dpaa2_switch_port_set_fdb() seems to lack a self-assignment
check. This could mark the shared FDB as unused before reassigning it,
allowing another standalone port to reallocate it. I note this was fixed in
a later commit covering bond scenarios.

[Severity: High]
Will dpaa2_switch_port_set_fdb() skip bonds when iterating through lower
devices, breaking cross-LAG forwarding?

When a port joins a bridge, dpaa2_switch_port_set_fdb() uses a non-recursive
iterator (netdev_for_each_lower_dev). If the other lower device is a bond,
dpaa2_switch_port_dev_check() will return false, skipping nested ports and
failing to share the hardware FDB. I note this was also fixed in a later
commit.

> +	if (err)
> +		goto err_bridge_join;
> +
> +	return err;
> +
> +err_bridge_join:
> +	dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
> +err_vlan_add:
> +err_lag_cfg:
> +	rcu_assign_pointer(port_priv->lag, NULL);
> +	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
> +err_egress_flood:
> +	if (port_priv->fdb != old_fdb) {
> +		new_fdb = port_priv->fdb;
> +
> +		/* Explicitly move the port back into the old private FDB */
> +		old_fdb->in_use = true;
> +		old_fdb->bridge_dev = NULL;
> +		port_priv->fdb = old_fdb;
> +
> +		/* Reprogram the bond FDB to no longer include this port */
> +		dpaa2_switch_fdb_set_egress_flood(ethsw, new_fdb->fdb_id);

[Severity: High]
Are we permanently leaking a hardware FDB resource in this error path?

If dpaa2_switch_port_bridge_join() fails, it will have allocated a new
intermediate FDB and marked it in_use. The cleanup block here restores
the original old_fdb, but does not appear to set new_fdb->in_use back to
false. Repeated failures might exhaust the fixed number of FDBs.

> +	} else {
> +		/* Same FDB means that this was the first port joining the
> +		 * bond. Keep using the same FDB.
> +		 */
> +		old_fdb->bridge_dev = NULL;
> +	}

[ ... ]

> +static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
> +					struct net_device *bond_dev)
> +{

[ ... ]

> +lag_cleanup:
> +	/* Recreate the LAG configuration for the LAG group that we left. In
> +	 * case any step failed, at least we free up a LAG resource.
> +	 */
> +	rcu_assign_pointer(port_priv->lag, NULL);
> +	dpaa2_switch_set_lag_cfg(bond_dev, lag->id, ethsw);

[Severity: Critical]
Could this trigger a kernel panic if lag is NULL on the rollback path?

If dpaa2_switch_port_bond_join() fails and sets port_priv->lag to NULL, a
subsequent NETDEV_CHANGEUPPER rollback calls this function. The lag variable
is initialized via rtnl_dereference(port_priv->lag), which would be NULL,
leading to a dereference when accessing lag->id here.

> +
> +	return err;
> +}
> +
>  static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
>  					    struct netdev_notifier_changeupper_info *info)
>  {
> +	struct net_device *upper_dev, *br;
>  	struct netlink_ext_ack *extack;
> -	struct net_device *upper_dev;
>  	int err;
>  
>  	if (!dpaa2_switch_port_dev_check(netdev))
> @@ -2239,6 +2585,24 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
>  
>  		if (!info->linking)
>  			dpaa2_switch_port_pre_bridge_leave(netdev);
> +	} else if (netif_is_lag_master(upper_dev)) {
> +		if (!info->linking) {
> +			if (netif_is_bridge_port(upper_dev))
> +				dpaa2_switch_port_pre_bridge_leave(netdev);
> +			return 0;
> +		}
> +
> +		if (netif_is_bridge_port(upper_dev)) {
> +			br = netdev_master_upper_dev_get(upper_dev);
> +			err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
> +									br,
> +									extack);
> +			if (err)
> +				return err;
> +		}
> +
> +		return dpaa2_switch_pre_lag_join(netdev, upper_dev,
> +						 info->upper_info, extack);
>  	}
>  
>  	return 0;

[Severity: High]
Might this bypass topological checks and allow VLAN uppers on offloaded LAGs?

If a port joins a LAG first, and then a VLAN is added to the LAG, the
event propagates here with the VLAN device as upper_dev. Since it is
neither a bridge nor a LAG master, this function returns 0 without checking
vlan_uses_dev(), inadvertently allowing an unsupported hardware configuration.

> @@ -2263,6 +2627,80 @@ static int dpaa2_switch_port_changeupper(struct net_device *netdev,
>  							     extack);
>  		else
>  			return dpaa2_switch_port_bridge_leave(netdev);

[Severity: High]
Does calling dpaa2_switch_port_bridge_leave() wrongly split LAG member ports
into isolated private FDBs?

When a LAG leaves a bridge, this is invoked for each member port. It will
unconditionally call dpaa2_switch_port_set_fdb(port_priv, NULL), which forces
the port to drop the shared FDB and isolates it from the other LAG members.
I note this was also fixed in a later commit covering bond scenarios.

> +	} else if (netif_is_lag_master(upper_dev)) {
> +		if (info->linking)
> +			return dpaa2_switch_port_bond_join(netdev, upper_dev,
> +							   info->upper_info,
> +							   extack);

