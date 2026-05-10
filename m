Return-Path: <netdev+bounces-286359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ6oCzLCAGqJMQEAu9opvQ
	(envelope-from <netdev+bounces-286359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8299250574E
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7430D30329BD
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999A3B5846;
	Sun, 10 May 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDF7MT8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E43B52E3;
	Sun, 10 May 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434492; cv=none; b=EbN/FodEL930f8hvmMWBGrm5D2Fq2ecG9yxWPE7tCzhEHWJ7sWTHHzp0sZrFiQ40UuRPqyb4p346RLK8VZo261TQJdTjUcLBf9ffC82T8Umh1Kdlx+N9JH8puNfyqH8xxKIHtU2dgbM6D/A+rvvDhwSda6C4+eOXGPOxz9JI0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434492; c=relaxed/simple;
	bh=2zQ02XmrPA32RRjZ2do1yxeo2OarDQMq0p1KRt+WvFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHaZyvvLVUGkYEpHJvH1GfYOBci2Fj5r2+gyMoaO8c87BLctI5+mXTCsH4dZDZSizOo0g4CiVYMGVwddAShB++CU5TdW8s6YHpt/u6quqxWCJPJAS1VJhZeADG1VtFnOwM0OX0XOTyTFjt2LyewXb7Aj0CV7mp9RKqbLjcFpUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDF7MT8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0604BC2BCB8;
	Sun, 10 May 2026 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434492;
	bh=2zQ02XmrPA32RRjZ2do1yxeo2OarDQMq0p1KRt+WvFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDF7MT8n3XcgFyB5NU6FIISaPXWDbiRRC57DJxDoyRTGGMEaWHMYtnC4LMW/lifU7
	 Z4W7IFtlgtUlNQFlC9SKsB8iZ1WxkiSpLd5LfDC9FDXNBImVeJuM+x8HB36e78bAtx
	 rb26nsSSWlGujefoHpovkZWuShSERfcYhRxNd78aMTcLXuQWMAoi41Wu7BwQNqLmsu
	 X20zWnsDKuZyOuSZKNBCCsQePSYCmv0UqpsHAiYqLh4omCytqNjVM9Fy3rckm0+scc
	 6Vrh8h3p/7LZw7rMWU8H24qNjuML1z+b96R7MGYl63LSRjoNH6cTTrrKOrmGvcaqV+
	 I1e5sWZX7rf1A==
From: Jakub Kicinski <kuba@kernel.org>
To: luizluca@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linusw@kernel.org,
	alsi@bang-olufsen.dk,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 6/8] net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
Date: Sun, 10 May 2026 10:34:51 -0700
Message-ID: <20260510173451.3919869-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-6-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-6-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8299250574E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286359-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}

This change implements hardware bridge offload for rtl8365mb by programming
per-port isolation masks and an EFID derived from the DSA bridge number.
The common helpers rtl83xx_port_bridge_join() and rtl83xx_port_bridge_leave()
are added for reuse across realtek drivers.

> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index 2b9bd4462714..3ab91cd82743 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -325,6 +325,120 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
>  	gpiod_set_value(priv->reset, false);
>  }
>  
> +/**
> + * rtl83xx_port_bridge_join() - join a port to a bridge
> + * @ds: DSA switch instance
> + * @port: port index
> + * @bridge: bridge being joined
> + * @tx_forward_offload: if the switch can offload TX forwarding
> + * @extack: netlink extended ack for reporting errors
> + *
> + * This function handles joining a port to a bridge. It updates the port
> + * isolation masks and EFID.
> + *
> + * Context: Can sleep.
> + * Return: 0 on success, negative value for failure.
> + */
> +int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
> +			     struct dsa_bridge bridge,
> +			     bool *tx_forward_offload,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct dsa_port *dp;
> +	u32 mask = 0;
> +	int ret;
> +
> +	if (!priv->ops->port_add_isolation)
> +		return -EOPNOTSUPP;
> +
> +	dev_dbg(priv->dev, "bridge %d join port %d\n", bridge.num, port);
> +
> +	/* Add this port to the isolation group of every other port
> +	 * offloading this bridge.
> +	 */
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		/* Handle this port after */
> +		if (dp->index == port)
> +			continue;
> +
> +		/* Skip ports that are not in this bridge */
> +		if (!dsa_port_offloads_bridge(dp, &bridge))
> +			continue;
> +
> +		ret = priv->ops->port_add_isolation(priv, dp->index, BIT(port));
> +		if (ret)
> +			return ret;

[Medium]
If port_add_isolation() succeeds for one or more peer ports and then fails
for a subsequent peer, this returns without undoing the earlier updates.

Looking at dsa_port_bridge_join() in net/dsa/port.c, the failure path goes
to out_rollback which calls dsa_port_bridge_destroy() but does not dispatch
DSA_NOTIFIER_BRIDGE_LEAVE, so rtl83xx_port_bridge_leave() is not invoked to
revert the partial state.

Can peer ports end up retaining BIT(port) in their forwarding mask even
though port never successfully joined the bridge, leaving frames from
bridge members forwardable to a non-member?

> +
> +		mask |= BIT(dp->index);
> +	}
> +
> +	/* Add those ports to the isolation group of this port */
> +	ret = priv->ops->port_add_isolation(priv, port, mask);
> +	if (ret)
> +		return ret;

[Medium]
Similarly, if this call fails after peers have already been updated, the
peers keep BIT(port) set without any rollback. Should this path walk the
peers again and clear BIT(port) from the ones already modified before
returning the error?

> +
> +	/* Use the bridge number as the EFID for this port */
> +	if (priv->ops->port_set_efid) {
> +		ret = priv->ops->port_set_efid(priv, port, bridge.num);
> +		if (ret)
> +			return ret;

[Medium]
If port_set_efid() fails here, both the peer ports' isolation masks and
this port's isolation mask have already been updated to include the bridge
membership, but the function returns an error as if the join did not
happen. Should the isolation mask updates be reverted (and a plain EFID 0
restored where needed) before returning?

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(rtl83xx_port_bridge_join, "REALTEK_DSA");
> +

[ ... ]

