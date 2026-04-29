Return-Path: <netdev+bounces-282547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOR8OFCY8ml1swEAu9opvQ
	(envelope-from <netdev+bounces-282547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:46:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460049B676
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D31D301A2A1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73953282F3F;
	Wed, 29 Apr 2026 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0PEiJXT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED821FBC8E;
	Wed, 29 Apr 2026 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777506380; cv=none; b=o2rl+yVEC2NtuqhZZ6+HsvysDQOtv2jAPcjwBwBQ3wv96cuwypWE6IHADf4CS0NEbdHBekowEtj7x2NUw5uBdJd+anbdIZbl1guClXrRijAQ/PCRgC5fcAPMmJaZmAyTDGwbDG/oeHygPKAYVI22106Y7bbiULDiaHZXsOKz3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777506380; c=relaxed/simple;
	bh=AKOnTbZ/fLlnqhqvD803u8VOuwIHV1SefABXb7khWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAUWimDK/VUG7heFPdt0pQKu+dlVi5l1QhZV1gd6qK/ZswL1iNcv0/hpmsVnASZG5ddVxSmHOCIen3y75SQ9rhFUvTwNK1cXkuabNC4IWxE4Ve9MayDArWqwkvJbVy0XpzmgFLpx4EI4clx5xItg0xvQNISfA+ECDeM3lHH4M7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0PEiJXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550CFC19425;
	Wed, 29 Apr 2026 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777506380;
	bh=AKOnTbZ/fLlnqhqvD803u8VOuwIHV1SefABXb7khWUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0PEiJXTVUTImHN8honj78SrualSm/j5yLbUEUOXiOK1OjBSPZsl52CI0BNJzqCYG
	 nt2llUvANFTSpjicOlBbOtmpJfwNjyRRbIAsS+IzZncuzvNGPoutdzaTDaxUI1W+iT
	 2p41QuGxnTg2hpBIwpZNliUtdP1y2NEsUcZlA6WOdb7GCeT6jjUw8g/OMrh86E6wYj
	 vA6u+4X20/AGINeIj4OdFJltsygijPsdieLFqgJjgiwi3KXa1EHC18RW3II6S1VKYf
	 OwP2OdCALu6nMSsjEnJSCvbM/79J1OqA1CP4x06eERkhIzdREJQ8chZxK7tYEhFwxX
	 QZIrvewMVCEPw==
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
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix .get_stats64 sleeping in atomic context
Date: Wed, 29 Apr 2026 16:46:13 -0700
Message-ID: <20260429234612.2240476-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <16efd278e4f17776ccfbf8491e5be71a4689c137.1777385305.git.daniel@makrotopia.org>
References: <16efd278e4f17776ccfbf8491e5be71a4689c137.1777385305.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5460049B676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-282547-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: mt7530: fix .get_stats64 sleeping in atomic context

This commit introduces a delayed workqueue to asynchronously poll MIB counters
for MDIO-connected switches. This caches the results so they can be returned
safely without sleeping in the atomic .get_stats64 callback.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b9423389c2ef..66bff861a921 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c

[ ... ]

> @@ -3137,9 +3187,25 @@ mt753x_setup(struct dsa_switch *ds)
>  	if (ret && priv->irq_domain)
>  		mt7530_free_mdio_irq(priv);
>  
> +	if (!ret && priv->bus) {
> +		spin_lock_init(&priv->stats_lock);
> +		INIT_DELAYED_WORK(&priv->stats_work, mt7530_stats_poll);
> +		mt7530_stats_refresh(priv);
> +		schedule_delayed_work(&priv->stats_work,
> +				      MT7530_STATS_POLL_INTERVAL);
> +	}
> +
>  	return ret;
>  }

[ ... ]

> @@ -3409,6 +3476,9 @@ mt7530_remove_common(struct mt7530_priv *priv)
>  
>  	dsa_unregister_switch(priv->ds);
>  
> +	if (priv->bus)
> +		cancel_delayed_work_sync(&priv->stats_work);

Could this call cancel_delayed_work_sync() on an uninitialized work struct
if the driver is unbound before the DSA switch tree completes?

The priv->bus pointer is initialized during probe. However,
INIT_DELAYED_WORK() is only called in mt753x_setup(), which might never
execute if the DSA tree remains incomplete.

If the driver is unbound in this state, mt7530_remove_common() will evaluate
priv->bus as true and pass a zero-initialized work struct to
cancel_delayed_work_sync(). This usually triggers lockdep ("trying to
register non-static key") and debugobjects ("assert_init not available")
warnings.

Would it be better to move the INIT_DELAYED_WORK() call into the probe
path or track whether the setup function was actually completed?
-- 
pw-bot: cr

