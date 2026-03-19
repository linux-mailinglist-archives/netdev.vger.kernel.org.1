Return-Path: <netdev+bounces-269375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INBfMkjFu2n1ngIAu9opvQ
	(envelope-from <netdev+bounces-269375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:43:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF12C8E90
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C7373092A1E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C869E3B582C;
	Thu, 19 Mar 2026 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5LCEGft"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342613B47D0
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911810; cv=none; b=L/yzE5FUbbP++SM0+f6MTkpSShphICyVNtTsVGrvjqJK08yZG4QS8KifenXAep++pujzeD1kZlCg7deP4o0bh8Jbega9yR+uApv8zzWQr85Gi5uulpUOTz01Mae7sqgPv2XxiyOUpjkUZd4/Iq77nIQOOAkAP+BasbkgOTxMDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911810; c=relaxed/simple;
	bh=EbYbtbxeuya+Ay51v+Jzncijx1e58TLX0Q2QWFRrQHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl4EFZgI9CVSVwohuyBH6obuNcW1S6F2tPM+nMYyQmXlzJ0dKEP/GW/aJ585DGubOogvmTL2TBl12EIZuxSjsN2jnnx4hBvbJlbU/SzBIPTf44TDav4GJeOE8cSONimhwtSHQwDF66OEtgL7cENIyKW2dA4LDZSxHA610k+ccng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5LCEGft; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773911808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr6Jt1lrU+MaN3MnhqKuiUasJhPBdxOQ/Vdi6dmcTD8=;
	b=a5LCEGftGIorGcXeVnkF1rrT87ggV5FZpg4yU3eBd81IpanZWs/XhK/wLsWpmd1aqgF9dN
	T+NaypxML5FUteyquQthjjun6VU+yujUhBMZq2NSke5k7C3etGVzsjRBaI8EJJfZ9+0nUn
	PuYB47wOGS3Y8sTmndXPn1sZsTMnWBc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-luOZ9ogTNRGee2rFD0NMVw-1; Thu,
 19 Mar 2026 05:16:41 -0400
X-MC-Unique: luOZ9ogTNRGee2rFD0NMVw-1
X-Mimecast-MFC-AGG-ID: luOZ9ogTNRGee2rFD0NMVw_1773911799
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 373D91944F05;
	Thu, 19 Mar 2026 09:16:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10E9A1800351;
	Thu, 19 Mar 2026 09:16:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: liuhangbin@gmail.com
Cc: horms@kernel.org,
	pabeni@redhat.com,
	bridge@lists.linux.dev,
	kuba@kernel.org,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	razor@blackwall.org,
	edumazet@google.com,
	sd@queasysnail.net,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	jiri@resnulli.us,
	sridhar.samudrala@intel.com,
	davem@davemloft.net
Subject: Re: [net-next,v3,2/5] net: use ndo_update_offloads to set offload features for bonding/bridge/team
Date: Thu, 19 Mar 2026 10:16:23 +0100
Message-ID: <20260319091623.107634-1-pabeni@redhat.com>
In-Reply-To: <20260316-offload_compute-v3-2-a5d4a07d86d3@gmail.com>
References: <20260316-offload_compute-v3-2-a5d4a07d86d3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269375-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.880];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4FF12C8E90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: use ndo_update_offloads to set offload features for bonding/bridge/team

This patch converts bonding, bridge, and team drivers to use the new
ndo_update_offloads callback, centralizing offload feature computation
during port add/remove operations.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 90b71bd53040..ea6bb20f9348 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c

[ ... ]

> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index b7282f5c9632..affbcc6fc130 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1247,7 +1247,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  	port->index = -1;
>  	list_add_tail_rcu(&port->list, &team->port_list);
>  	team_port_enable(team, port);
> -	netdev_compute_master_upper_features(team->dev, true);
>  	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
>  	__team_options_change_check(team);

[ ... ]

> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index d39571e13744..030248bc94c5 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -680,8 +680,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>
>  	br_mtu_auto_adjust(br);
>
> -	netdev_compute_master_upper_features(br->dev, false);
> -
>  	kobject_uevent(&p->kobj, KOBJ_ADD);
>
>  	return 0;

[ ... ]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index bbd532aa6a1b..8bcbf7c22830 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8923,6 +8923,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
>  	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
>  				    priv);
>
> +	/* re-compute all features after adding link */
> +	netdev_change_features(upper_dev);
> +
>  	return 0;
>
>  rollback:

Could this netdev_change_features() call happen too early for team and
bridge drivers?

The call triggers __netdev_update_features(), which invokes both
ndo_update_offloads() and ndo_fix_features(). While ndo_update_offloads()
works with the netdev lower device list (already updated by
__netdev_adjacent_dev_link_neighbour()), the ndo_fix_features() callbacks
iterate driver-specific port lists.

For team_port_add():

drivers/net/team/team_core.c:team_port_add() {
    ...
    team_upper_dev_link(team, port, extack);  /* line ~1231 */
        netdev_upper_dev_link()
            __netdev_upper_dev_link()
                netdev_change_features()  /* <-- triggers feature update */
                    __netdev_update_features()
                        ops->ndo_fix_features()  /* team_fix_features() */

    list_add_tail_rcu(&port->list, &team->port_list);  /* line 1247 */
    ...
}

team_fix_features() iterates team->port_list to compute features, but the
new port hasn't been added to that list yet.

Similarly for br_add_if():

net/bridge/br_if.c:br_add_if() {
    ...
    netdev_master_upper_dev_link(dev, br->dev, NULL, NULL, extack);  /* line ~628 */
        __netdev_upper_dev_link()
            netdev_change_features()  /* <-- triggers feature update */
                __netdev_update_features()
                    ops->ndo_fix_features()  /* br_fix_features() */

    list_add_rcu(&p->list, &br->port_list);  /* line 634 */
    ...
}

br_fix_features() calls br_features_recompute() which iterates
br->port_list, but the new port isn't in that list yet.

If the new port lacks support for a feature the master currently has
enabled (like NETIF_F_SG, NETIF_F_IP_CSUM, or NETIF_F_TSO), that feature
would remain incorrectly enabled. The old code path called
netdev_compute_master_upper_features() AFTER the port was added to the
driver list, so the new port's capabilities were included in the feature
computation.

The bonding driver isn't affected because bond_fix_features() uses
bond_for_each_slave(), which maps to netdev_for_each_lower_private() and
iterates the netdev infrastructure's lower device list rather than a
separate driver list.


