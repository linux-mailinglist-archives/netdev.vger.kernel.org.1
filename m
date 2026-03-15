Return-Path: <netdev+bounces-267932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IivL0LctmkQJwEAu9opvQ
	(envelope-from <netdev+bounces-267932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:20:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1F291605
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD03301466C
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B07370D60;
	Sun, 15 Mar 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6v0bcg1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5B1ACEDE;
	Sun, 15 Mar 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591605; cv=none; b=GYtq1pn1L/9Fx95vX1bAOgiX8+OirGQbXHisK/Zo2xHdjboZw+5+EjyNkPfQLvWZgN76SR7+Eud2qYdpOkEUG2uw9YOxQGHbBgSY8pqNDwii88HaCkKVZ405z8dFi+xxLwRVkA1Wzoso74yd2FCuqG5FbsU2tMJ/azH79yzNN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591605; c=relaxed/simple;
	bh=xKcg+NTA0s52zOEQyQVg1Ut0WOeVb7Uq3enq4JxfLQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOE0NcWdD3yWySdlYtWSa3qSDMlM0Kh++eGX8ugLZ54whKVsIrGLOVpvBO0kRab42S0RMQvQbFMCv+w6DbDh2jsvDUqM30L2v8hZ2lgT4x/cog35tbwq1JESwSUD4dmI5Jgf/iR/F9HOn8YhY2HLZPh/mqs45//CWCK1HF38X6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6v0bcg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20446C4CEF7;
	Sun, 15 Mar 2026 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773591605;
	bh=xKcg+NTA0s52zOEQyQVg1Ut0WOeVb7Uq3enq4JxfLQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6v0bcg1/4c6og5Yc3zBqP0okAf48DeD4p5YEPR/28oEiJN9DO58EKVa0HALzsRWA
	 lsclwYR5gx4iC/fIeuVlhRMA/adZU3buCFevMTjlVjIlLx112mez8ivwwPlSGYWDSj
	 BNz839tnkybucvN7sigl9DXMA0NVXbnpCELHWoUKuLM/+q6MFansR6zZVsY1gFNTVK
	 Pg/gnradb3OMNQFVYBZqzbnrIYutSG5DY46LSUu6SvGRoM7E/pWLFWYZqp8WDYCsQr
	 yQ28Bi28p+KEjP11xh2lpDtgxiLwlorvSSOqdiPpfkxRV7dpNzec1PE9lRnGo9SZNr
	 06xiqcq/4DKQQ==
From: Simon Horman <horms@kernel.org>
To: liuhangbin@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	jv@jvosburgh.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	sridhar.samudrala@intel.com,
	jiri@resnulli.us,
	bridge@lists.linux.dev,
	edumazet@google.com,
	kuba@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com
Subject: Re: [net-next,v2,1/4] net: use ndo_set_features to set offload features for bonding/bridge/team
Date: Sun, 15 Mar 2026 16:19:43 +0000
Message-ID: <20260315161943.1419237-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313-offload_compute-v2-1-ffbc8ce5d50c@gmail.com>
References: <20260313-offload_compute-v2-1-ffbc8ce5d50c@gmail.com>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 40B1F291605
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: use ndo_set_features to set offload features for bonding/bridge/team

This commit converts bonding, bridge, and team drivers to use the
ndo_set_features callback instead of manually calling
netdev_compute_master_upper_features() during port add/remove operations.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 90b71bd53040..2c84d3ce3b04 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c

[ ... ]

> @@ -5953,6 +5957,7 @@ static const struct net_device_ops bond_netdev_ops = {
>  	.ndo_add_slave		= bond_enslave,
>  	.ndo_del_slave		= bond_release,
>  	.ndo_fix_features	= bond_fix_features,
> +	.ndo_set_features	= bond_set_features,
>  	.ndo_features_check	= passthru_features_check,
>  	.ndo_get_xmit_slave	= bond_xmit_get_slave,
>  	.ndo_sk_get_lower_dev	= bond_sk_get_lower_dev,

[ ... ]

> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index b7282f5c9632..4906ea3717b1 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c

[ ... ]

> @@ -2007,6 +2010,7 @@ static const struct net_device_ops team_netdev_ops = {
>  	.ndo_add_slave		= team_add_slave,
>  	.ndo_del_slave		= team_del_slave,
>  	.ndo_fix_features	= team_fix_features,
> +	.ndo_set_features	= team_set_features,
>  	.ndo_change_carrier     = team_change_carrier,
>  	.ndo_features_check	= passthru_features_check,
>  };

[ ... ]

> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index f7502e62dd35..f82082050e36 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c

[ ... ]

> @@ -456,6 +462,7 @@ static const struct net_device_ops br_netdev_ops = {
>  	.ndo_add_slave		 = br_add_slave,
>  	.ndo_del_slave		 = br_del_slave,
>  	.ndo_fix_features        = br_fix_features,
> +	.ndo_set_features        = br_set_features,
>  	.ndo_fdb_add		 = br_fdb_add,
>  	.ndo_fdb_del		 = br_fdb_delete,
>  	.ndo_fdb_del_bulk	 = br_fdb_delete_bulk,

[ ... ]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f48dc299e4b2..16b3fc620807 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8920,6 +8920,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
>  	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
>  				    priv);
>
> +	/* re-compute all features after adding link */
> +	netdev_change_features(upper_dev);
> +
>  	return 0;
>
>  rollback:

Can the feature computation skip updating ancillary fields when features
don't change?

The new architecture routes computation through netdev_change_features() ->
__netdev_update_features() -> ndo_set_features(). However,
__netdev_update_features() has this check:

net/core/dev.c:__netdev_update_features() {
    ...
    if (dev->features == features)
        goto sync_lower;

This skips the ndo_set_features callback entirely when computed features
match current features. This means netdev_compute_master_upper_features() is
never called when dev->features doesn't change, even though it updates
several ancillary fields independent of dev->features:

- vlan_features
- hw_enc_features
- mpls_features
- gso_partial_features
- tso_max_size
- tso_max_segs
- hard_header_len
- needed_headroom
- needed_tailroom

For example, adding a second bond slave with identical dev->features but
different tso_max_size or vlan_features will not trigger ndo_set_features,
leaving the bond's ancillary fields stale.

In the old code, netdev_compute_master_upper_features() was called
unconditionally and always updated these fields regardless of whether
dev->features changed.

> @@ -9012,6 +9015,9 @@ static void __netdev_upper_dev_unlink(struct net_device *dev,
>  	__netdev_update_lower_level(upper_dev, priv);
>  	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
>  				    priv);
> +
> +	/* re-compute all features after removing link */
> +	netdev_change_features(upper_dev);
>  }

The same issue applies here. When a port is removed but dev->features
doesn't change, the ancillary fields won't be recomputed.

> @@ -12874,8 +12880,6 @@ void netdev_compute_master_upper_features(struct net_device *dev, bool update_he
>
>  	netif_set_tso_max_segs(dev, tso_max_segs);
>  	netif_set_tso_max_size(dev, tso_max_size);
> -
> -	netdev_change_features(dev);
>  }
>  EXPORT_SYMBOL(netdev_compute_master_upper_features);

