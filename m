Return-Path: <netdev+bounces-283322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH6hHCVC9WmFJwIAu9opvQ
	(envelope-from <netdev+bounces-283322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:15:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B59114B073C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FBE8300DDE6
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71C3135A53;
	Sat,  2 May 2026 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WunWZdIe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FF4C81;
	Sat,  2 May 2026 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680930; cv=none; b=RkzXuIwTGGrc5GOZNAEQDL0Ki860/K4VVNzs5EtntYIo/ktjolxEN3pvq0q6cANCRjBrFrury/Zc0x3DUPQrHhbOv3TKXu4OurQ/8wz0kLf8lxAWcV1/mAiXiV467ooEbHoKrgAILRtu0f8MupbG9UZcHt+JaGWrAIKWXhL4Yv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680930; c=relaxed/simple;
	bh=1wnHG4DhEEWaHsYbpTUTr9P6ZlzbVGKMECFzT3v6umw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdlj/HKUsirL8NUC6/gKwwGLN8yor2I5XJaczqSC3YXegNbWs8mJldCEEeB5FrBEC6e6RZP2Uk0DLGIb0baKmdfnoUa9Izzt0AiXUEkykX1BTJ17swceMLTTbuVH8A386/IRrDDgaEF19eJwmPvHiHUFDwNzrbyxdBmUZLkAoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WunWZdIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788FEC2BCB4;
	Sat,  2 May 2026 00:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680930;
	bh=1wnHG4DhEEWaHsYbpTUTr9P6ZlzbVGKMECFzT3v6umw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WunWZdIeZJFgZgtbL3geAU1sEoIluVoBwb8CBkaHuPnqzbSukHjdXLDnsn5iqeKFr
	 PVtZMGeJdu8tG10RHBEz+PpDLj6ZH2FOe4gsr8rcXFbZwYcXEL9Bh+Nt7WkNGiM7qp
	 +uLllWxch+WadlDKYMO6NzokyEopRTSUrpbX79CbJMBWPXcGGvK3f3wcCkQPzoI2iq
	 QNxgoN9kbzctoWTPc56Em2hUwRfQigb86qFLgtuyeE/5/GO47XureFsewh7VxS3bc1
	 UZrR1myCgPuew3Tzghum2adGhJEheVzhqtdhDLg06M9Av/PBYzTU/aFgaFVcpTUOMM
	 jJp+sfO+gDLeQ==
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
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v5] net: dsa: mt7530: fix .get_stats64 sleeping in atomic context
Date: Fri,  1 May 2026 17:15:27 -0700
Message-ID: <20260502001527.3603463-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4086098f5333d48221f83fa775607330836336d7.1777590741.git.daniel@makrotopia.org>
References: <4086098f5333d48221f83fa775607330836336d7.1777590741.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B59114B073C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-283322-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: dsa: mt7530: fix .get_stats64 sleeping in atomic context

This patch moves MIB counter reads for MDIO-connected switches into a
self-rearming delayed work, and has .get_stats64 return cached values
under a spinlock. A mod_delayed_work() call on each read triggers an
immediate refresh.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b9423389c2ef..e769914d726c 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c

[ ... ]

> @@ -3137,6 +3187,12 @@ mt753x_setup(struct dsa_switch *ds)
>  	if (ret && priv->irq_domain)
>  		mt7530_free_mdio_irq(priv);
>  
> +	if (!ret && priv->bus) {
> +		mt7530_stats_refresh(priv);
> +		schedule_delayed_work(&priv->stats_work,
> +				      MT7530_STATS_POLL_INTERVAL);
> +	}
> +
>  	return ret;
>  }

Can the delayed work outlive priv on a probe failure path?

mt753x_setup() is installed as ds->ops->setup and is invoked from
dsa_register_switch() via:

  dsa_register_switch()
    dsa_switch_probe()
      dsa_tree_setup()
        dsa_tree_setup_switches()
          dsa_switch_setup()
            ds->ops->setup == mt753x_setup()   /* queues stats_work */
        dsa_tree_setup_ports()                 /* may fail here */
        dsa_tree_setup_conduit()               /* or here */
        dsa_tree_setup_lags()                  /* or here */

If any of the later dsa_tree_setup_* steps fail after mt753x_setup()
has queued stats_work, dsa_tree_teardown_switches() is called, which
invokes ds->ops->teardown per switch. The mt7530 dsa_switch_ops does
not define a .teardown op, so nothing cancels the delayed work.

mt7530_probe() then propagates the error. The driver core does not
invoke .remove() after a failed probe, so mt7530_remove_common()
(which holds the cancel_delayed_work_sync()) never runs. Once
mt7530_probe() returns the error, devres releases priv and priv->ds
while stats_work is still queued. When it fires, mt7530_stats_poll()
dereferences priv, walks priv->ds->dst->ports and issues MDIO reads
via priv->bus on freed memory.

Would it be safer to cancel the work in mt753x_setup()'s own error
path (and/or add a .teardown op) so the work is stopped whenever
setup reports failure?

> @@ -3409,6 +3468,9 @@ mt7530_remove_common(struct mt7530_priv *priv)
>  
>  	dsa_unregister_switch(priv->ds);
>  
> +	if (priv->bus)
> +		cancel_delayed_work_sync(&priv->stats_work);
> +
>  	mutex_destroy(&priv->reg_mutex);
>  }

Is the ordering of dsa_unregister_switch() vs. cancel_delayed_work_sync()
correct here?

dsa_unregister_switch() ends up in dsa_switch_remove():

  net/dsa/dsa.c:
  static void dsa_switch_remove(struct dsa_switch *ds)
  {
        struct dsa_switch_tree *dst = ds->dst;

        dsa_tree_teardown(dst);
        dsa_switch_release_ports(ds);
        dsa_tree_put(dst);
  }

and dsa_switch_release_ports() does list_del + kfree on every
dsa_port entry:

  dsa_switch_for_each_port_safe(dp, next, ds) {
        ...
        list_del(&dp->list);
        kfree(dp);
  }

Meanwhile, mt7530_stats_refresh() iterates the same list without any
locking or RCU:

  dsa_switch_for_each_user_port(dp, priv->ds) {
        port = dp->index;
        mt7530_read_port_stats64(priv, port, &stats);
        ...
  }

and dsa_switch_for_each_user_port expands to a plain
list_for_each_entry over ds->dst->ports.

stats_work rearms itself every MT7530_STATS_POLL_INTERVAL (one
second), and mt7530_get_stats64() can mod_delayed_work(..., 0) it to
fire immediately. With the cancel happening after
dsa_unregister_switch(), the worker can run concurrently with port
teardown and dereference dsa_port entries that have already been
list_del'd and kfree'd, or walk priv->ds->dst after dsa_tree_put()
has released it.

Should cancel_delayed_work_sync(&priv->stats_work) run before
dsa_unregister_switch(), with a guard to prevent mt7530_get_stats64()
from requeuing the work during unregister?
-- 
pw-bot: cr

