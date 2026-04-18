Return-Path: <netdev+bounces-279536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBivDuXG42mzKgEAu9opvQ
	(envelope-from <netdev+bounces-279536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:01:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39746421E92
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F81A3006084
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E0175A6C;
	Sat, 18 Apr 2026 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL4xBmWn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403A31352A;
	Sat, 18 Apr 2026 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535262; cv=none; b=UyU/u8EzlH+e+kTX41AmjRneFrYnqOff+PmJeOagElZ+zIcVpKqXpDyIaCPvZIRtFFpuWmMALeY7tCYrDN/JlRe15V6q/edreKYrBNtHvhkcAyGwdIHA1BNBcO7225vsNyBvoxI35wtyYvWdSmuqKC/CrrpVWeimZRN4EPalrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535262; c=relaxed/simple;
	bh=gfCnfVv+6IRcfetQm4ukDI1hhxp2kXNRzZ9OCpuJKNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqT7XELr8O/Cfg7LRx15lQhf7nwkoKPoMv7OD85um1p07Mm5Yu9/dTROz9EtHrDgldcKiyKYEzrTJ3wuXSNsogzfABIIzuHh3GE1HgGhhQVSVqkKonua1sPai8Dj6Q2szFsbammqSBIJoH8bR+AbPxm1iF7GSqyWCBVIxqN/Fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL4xBmWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89E5C19424;
	Sat, 18 Apr 2026 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776535262;
	bh=gfCnfVv+6IRcfetQm4ukDI1hhxp2kXNRzZ9OCpuJKNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SL4xBmWncX6eqD+Qm1sWsTokqcFl7OJjdnW78wvTqznlWwnlGOPgAeYOdt+tSHreM
	 lucAOmker/15lTJ7qHtbOpD8KvLvJ6T/SwIK+MEqob6e8rQLm/OPXS7ARA876Rj4aF
	 3MdICvlTEnFiyfk+e4b1PnnQ2oduHC4CMHzMRBmEIbJ0ti51rSd8GR6jxDfT7BJnRZ
	 ya58Xw3R4RQgt2fQ43dT16NkQkmD/bk5c6E6Ipn9HEJzLtgDPsn2GFuNCIg/+8W0c7
	 oXVvGWTi89TJagM34DfJKpQEK9lNBAZyiEU619mdHuA/fWvdPk13LUq0SGbu/B9bp3
	 qfbmo9fCekeYw==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	chester.a.unal@arinc9.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux@armlinux.org.uk,
	ansuelsmth@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	frank-w@public-files.de,
	john@phrozen.org
Subject: Re: [PATCH net] net: dsa: mt7530: fix .get_stats64 sleeping in atomic context
Date: Sat, 18 Apr 2026 11:01:00 -0700
Message-ID: <20260418180100.131392-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
References: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,public-files.de,phrozen.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-279536-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,stats_work.work:url]
X-Rspamd-Queue-Id: 39746421E92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: dsa: mt7530: fix .get_stats64 sleeping in atomic context

This commit addresses a sleep-in-atomic bug when reading MDIO-connected
switch port statistics by delegating the register reads to a delayed
workqueue. The get_stats64 callback now returns cached values protected
by a spinlock instead of synchronously reading from the MDIO bus.
MMIO-connected switches are unaffected and continue to read counters
directly.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b9423389c2ef0..786d3a8492bcb 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c

[ ... ]

> @@ -951,6 +952,43 @@ static void mt7530_get_stats64(struct dsa_switch *ds, int port,
>  			       &storage->rx_crc_errors);
>  }
>  
> +static void mt7530_stats_poll(struct work_struct *work)
> +{
> +	struct mt7530_priv *priv = container_of(work, struct mt7530_priv,
> +						stats_work.work);
> +	struct rtnl_link_stats64 stats = {};
> +	struct dsa_port *dp;
> +	int port;
> +
> +	dsa_switch_for_each_user_port(dp, priv->ds) {
> +		port = dp->index;
> +
> +		mt7530_read_port_stats64(priv, port, &stats);
> +
> +		spin_lock(&priv->stats_lock);

Are we at risk of a deadlock here?

The get_stats64 callback can be called by dev_get_stats(), which runs in
softirq context.

If this delayed work runs in process context and is preempted by a softirq
that attempts to acquire the lock via dev_get_stats(), a deadlock could
occur. Both paths should likely use spin_lock_bh() and spin_unlock_bh().

> +		priv->ports[port].stats = stats;
> +		spin_unlock(&priv->stats_lock);
> +	}
> +
> +	schedule_delayed_work(&priv->stats_work,
> +			      MT7530_STATS_POLL_INTERVAL);
> +}
> +
> +static void mt7530_get_stats64(struct dsa_switch *ds, int port,
> +			       struct rtnl_link_stats64 *storage)
> +{
> +	struct mt7530_priv *priv = ds->priv;
> +
> +	if (priv->bus) {
> +		spin_lock(&priv->stats_lock);
> +		*storage = priv->ports[port].stats;
> +		spin_unlock(&priv->stats_lock);
> +		mod_delayed_work(system_wq, &priv->stats_work, 0);

Could this unconditional background refresh cause a denial of service on
the MDIO bus?

If an unprivileged user continually reads network statistics in a tight
loop, mt7530_stats_poll() will execute continuously, potentially starving
other MDIO tasks like PHY link-state monitoring.

Additionally, is it possible for this call to re-arm the workqueue during
teardown?

In mt7530_remove_common(), cancel_delayed_work_sync() is called before
dsa_unregister_switch(). If get_stats64() is called during or after
dsa_unregister_switch(), it would re-arm the workqueue after it was
explicitly cancelled, potentially causing a use-after-free when priv is
freed.

> +	} else {
> +		mt7530_read_port_stats64(priv, port, storage);
> +	}
> +}

[ ... ]

> @@ -3137,6 +3175,13 @@ mt753x_setup(struct dsa_switch *ds)
>  	if (ret && priv->irq_domain)
>  		mt7530_free_mdio_irq(priv);
>  
> +	if (!ret && priv->bus) {
> +		spin_lock_init(&priv->stats_lock);
> +		INIT_DELAYED_WORK(&priv->stats_work, mt7530_stats_poll);
> +		schedule_delayed_work(&priv->stats_work,
> +				      MT7530_STATS_POLL_INTERVAL);

If dsa_register_switch() encounters an error after this setup callback
completes successfully, the DSA core will attempt to clean up.

Since mt7530_switch_ops does not implement a teardown callback to cancel
this delayed work, will the work remain scheduled and eventually
dereference freed priv memory once the driver core frees it via devres?

> +	}
> +
>  	return ret;
>  }
-- 
pw-bot: cr

