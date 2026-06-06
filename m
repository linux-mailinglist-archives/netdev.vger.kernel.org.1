Return-Path: <netdev+bounces-296027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WXJDBgGCI2rjugEAu9opvQ
	(envelope-from <netdev+bounces-296027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4564C321
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:12:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Zku03E/P";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296027-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296027-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9788303EC33
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 02:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8177A2459DD;
	Sat,  6 Jun 2026 02:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51C207DF7;
	Sat,  6 Jun 2026 02:10:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711854; cv=none; b=BlzGVjBi6ve/DopvPOxffUbdebBnVxrj8i2InqYGkKc9z2vuZP4+uJT4vJuVrmGdRtUz+wCs91y8IKf18quxVZY0PqNB2gnO4At6mnQlC3XMswz3zhQUlKVK0EO2NXvPiOgdFcwbUHQDkpvPV1oj1JBgo5LVYWceWuf7OlOWo9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711854; c=relaxed/simple;
	bh=nRSzevO4boHh2qkVUIEl4RPXyF4U8yaIMc55Aodf5Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgwwSn00CuXW8ie7eNfGLnSvQhLZkAeSbyP12JhjoIFnQUpEjWJuEoGXgxuTsyAFT+hewJk8rZUf21zSzKmRx3p6jWyhOqumuOoCaCmjE9njaIm+jNgeIrZNDEP8PElZXG5WYN6wKn1Nr9Z76etHiOyh9YWBn+hT3R4f2xzttWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zku03E/P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0FD1F00893;
	Sat,  6 Jun 2026 02:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711852;
	bh=S2gmTkr6Mhe++4Pcp61CLhd1ZPamrXVBmqrAzOA0ZD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zku03E/Pe5bVdDbFKChwV+45b60Ty4Tx4Sd8YQ0hkmX1VSmJacHVHvjEUDBTZ1BZU
	 2riUbP9ZKq4Kms2GXaFloTdtqDRHZwN8K2ch7FnC2gATjQLYrGjIt539IGJ344pvsY
	 vUshVHbxAIAMf16ISYBsuDr+o4kASEqrOHK4BsjRm3adfkr15I8enlsVXJQxQFINir
	 1ImuBtbeeRSsFrjXGn9SIpHkxvMRkZx8FaIbqZA7HtzgB3ZqqUQAaSXAwFLrY9g7aX
	 dSGpFLco8hu+TgmXx3RPWm+jW60IKolPZTChIPIW+q+gcCERMn2/OyWuoqhLZeWMjQ
	 y4N5L19OBVGwg==
From: Jakub Kicinski <kuba@kernel.org>
To: ioana.ciornei@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/12] dpaa2-switch: extend dpaa2_switch_port_set_fdb() to cover bond scenarios
Date: Fri,  5 Jun 2026 19:10:50 -0700
Message-ID: <20260606021050.4124679-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603143623.3712024-5-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-5-ioana.ciornei@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296027-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DE4564C321

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpaa2-switch: extend dpaa2_switch_port_set_fdb() to cover bond scenarios

The dpaa2_switch_port_set_fdb() function is responsible with determining
what FDB should be used by a port as a consequence of changing its upper
device. This patch extends the function to also cover the circumstances
in which a DPAA2 switch port offloads a bond device.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 8026a50141055..b851376b8e1b8 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -68,15 +68,45 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,

[ ... ]

> -		/* Since we are not the last port which leaves a bridge,
> -		 * acquire a new FDB and use it. The number of FDBs is sized to
> -		 * accommodate all switch ports as standalone, each with its
> -		 * private FDB, which means that dpaa2_switch_fdb_get_unused()
> -		 * must succeed here. WARN if not.
> -		 */
> -		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
> -		if (WARN_ON(!fdb))
> -			return;
> +		if (fdb) {
> +			/* Switching to the FDB of another port which is under
> +			 * the same bond device. Release the previous FDB in
> +			 * case we were the last to use it.
> +			 */
> +			if (last_fdb_user) {
> +				port_priv->fdb->in_use = false;
> +				port_priv->fdb->bridge_dev = NULL;
> +			}
> +			port_priv->fdb = fdb;
> +		} else if (last_fdb_user) {
> +			/* No other bond lowers to share the FDB with and we
> +			 * are its last user, just keep it.
> +			 */
> +		} else {
> +			fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
> +			if (WARN_ON(!fdb))
> +				return;
>  
> -		port_priv->fdb = fdb;
> -		port_priv->fdb->in_use = true;
> -		port_priv->fdb->bridge_dev = NULL;
> +			port_priv->fdb = fdb;
> +			port_priv->fdb->in_use = true;
>  		}

[Severity: High]
Does this code leak a hardware FDB structure on the error recovery path of
dpaa2_switch_port_bond_join()?

If dpaa2_switch_port_bridge_join() fails inside dpaa2_switch_port_bond_join(),
the error recovery calls dpaa2_switch_port_set_fdb(port_priv, upper_dev, false).

Since the port is not the last user of the shared bridge FDB, this dynamically
allocates a new, unused FDB via dpaa2_switch_fdb_get_unused() and marks it
in_use = true.

Control then returns to dpaa2_switch_port_bond_join(), which continues its own
error recovery and explicitly reverts port_priv->fdb back to its original
pre-bond private FDB (old_fdb):

    if (port_priv->fdb != old_fdb) {
        new_fdb = port_priv->fdb;
        old_fdb->in_use = true;
        old_fdb->bridge_dev = NULL;
        port_priv->fdb = old_fdb;
        ...
    }

However, the newly allocated FDB (new_fdb) from the bridge_join failure
path is ignored and left marked as in_use = true. Because this FDB is no
longer referenced by any port, it seems to be permanently leaked.

Could this deplete the highly limited pool of hardware FDB slots, eventually
preventing any new standalone ports from functioning?

[ ... ]

>  	/* The current port is about to change its FDB to the one used by the
> @@ -143,7 +203,8 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
>  	}
>  
>  	/* Keep track of the new upper bridge device */
> -	port_priv->fdb->bridge_dev = upper_dev;
> +	if (netif_is_bridge_master(upper_dev))
> +		port_priv->fdb->bridge_dev = upper_dev;
>  }

[Severity: Critical]
Does this prematurely mark actively shared FDBs as unused?

When a port joins a bond that is already in a bridge alongside another
standalone port:

1. dpaa2_switch_port_bond_join() first gives the port the bond's shared FDB
   (which is the bridge FDB).
2. Then it calls dpaa2_switch_port_bridge_join(), which calls
   dpaa2_switch_port_set_fdb(..., true).
3. This searches the bridge's lowers and finds the standalone port, skipping
   the bond's ports.

Because both the bond and the standalone port are in the same bridge, they
share the exact same FDB.

However, the existing code just above this diff:

	if (other_port_priv) {
		port_priv->fdb->in_use = false;
		port_priv->fdb->bridge_dev = NULL;
		port_priv->fdb = other_port_priv->fdb;
	}

executes without checking if port_priv->fdb == other_port_priv->fdb. Since
port_priv->fdb was already the bridge's FDB, this unconditionally marks the
actively shared bridge FDB as unused.

Once the RTNL lock is released, could subsequent calls to
dpaa2_switch_fdb_get_unused() by unrelated ports allocate this actively used
bridge FDB, causing L2 isolation breakdown and silent data corruption across
the entire bridge?

