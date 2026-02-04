Return-Path: <netdev+bounces-256557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIhSCljGgml9awMAu9opvQ
	(envelope-from <netdev+bounces-256557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:08:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843CE17AE
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73DE230A85C7
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 04:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAEE3009D4;
	Wed,  4 Feb 2026 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvs7AmQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337C30101F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178123; cv=none; b=rTtA/VFKju9nOWhQlwDqhLE2+Vdh1JJe1JzAOfo+E1bgdLsFMTU/AgZNLh3V0VUswSjJht/n/EvPYczJwhlsvUIrPkClC1gM08GKjenOLEfaTiplC2DKlQWjQ3dj4ZFYzBJtKEv4ziAVaivxRADS2jl26RXwICuG4fOUfG75kKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178123; c=relaxed/simple;
	bh=61gUnUdIx34c0m2uST15U6rtQWqthFN5N9lvi3RR2WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWesr03WKv145bdt/udt3TNbpSEAaS43FiPlsyZ/zH6f+pMujcQIkNW2NoN1LQHpUxHDxOE9V7Lo4VyeTnZig7GK7zk4WEHwGxKzfj7Ag905RHfrPZrrqoOvUKMhRA99V0jgaseTcYW1XapxP5kVhyYSiVwc6X/aqe93GlQgVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvs7AmQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E95BC4CEF7;
	Wed,  4 Feb 2026 04:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770178122;
	bh=61gUnUdIx34c0m2uST15U6rtQWqthFN5N9lvi3RR2WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xvs7AmQYvpLP5hZO0OwpbUOyJKCv9fCSSiyqoAWDCq38JUZEz6C0MtLR7UIjU3run
	 7ey2ZJ6oZYS7oRMlqiwNn9lmDvGNxKbEiaNQvTqIMLPbWAGsAB6QBMBRDXQpqbmBKh
	 6YjyjBuBU2Ep+Wa91i5tCMsYqtQny6gDgp0Uu+uNxX2u1QEwurAgcTbUkxHc8KfDu9
	 JCtQm7R2ojtnwqFjqVlC7baCBcFpNouc4k4Gd0FU2ftNZlJYOW2Ij1gZQ7yNqIDnB/
	 MEUO+PubqplV8JYV34Bfd85ZUqfYIQ/A0FYEQW8TyjaRU081FVphZo78OlrtbHZIaV
	 2Wjc3AoQ+dltg==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	davem@davemloft.net,
	guwen@linux.alibaba.com,
	lulie@linux.alibaba.com,
	hkallweit1@gmail.com,
	edumazet@google.com,
	lukas.bulwahn@redhat.com,
	andrew@lunn.ch,
	dong100@mucse.com,
	dust.li@linux.alibaba.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v25,6/6] eea: introduce callback for ndo_get_stats64
Date: Tue,  3 Feb 2026 20:08:41 -0800
Message-ID: <20260204040841.1703575-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202090638.46836-7-xuanzhuo@linux.alibaba.com>
References: <20260202090638.46836-7-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,redhat.com,linux.dev,davemloft.net,linux.alibaba.com,gmail.com,google.com,mucse.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-256557-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8843CE17AE
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: introduce callback for ndo_get_stats64

This commit adds ndo_get_stats64 support to the eea driver, implementing
statistics collection for rx/tx packets and bytes. A spinlock is introduced
to protect access to the rx and tx queue pointers during stats collection.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
> @@ -27,8 +27,10 @@ static int enet_bind_new_q_and_cfg(struct eea_net *enet,
>
>  	enet->cfg = ctx->cfg;
>
> +	spin_lock(&enet->stats_lock);
>  	enet->rx = ctx->rx;
>  	enet->tx = ctx->tx;
> +	spin_unlock(&enet->stats_lock);

[ ... ]

> @@ -57,11 +59,13 @@ static void eea_free_rxtx_q_mem(struct eea_net *enet)
>  	struct eea_net_tx *tx, *tx_array;
>  	int i;
>
> +	spin_lock(&enet->stats_lock);
>  	rx_array = enet->rx;
>  	tx_array = enet->tx;
>
>  	enet->rx = NULL;
>  	enet->tx = NULL;
> +	spin_unlock(&enet->stats_lock);

[ ... ]

> @@ -260,6 +264,50 @@ static int eea_netdev_open(struct net_device *netdev)
>  	return err;
>  }
>
> +static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	u64 packets, bytes;
> +	u32 start;
> +	int i;
> +
> +	spin_lock_bh(&enet->stats_lock);

Can this cause a deadlock? The enet_bind_new_q_and_cfg() and
eea_free_rxtx_q_mem() functions use spin_lock(&enet->stats_lock), but
eea_stats() uses spin_lock_bh(&enet->stats_lock).

If a thread holds stats_lock via spin_lock() (softirqs still enabled) and a
softirq fires that calls eea_stats() through ndo_get_stats64, the
spin_lock_bh() will attempt to acquire the already-held lock.

Should all acquisition sites use spin_lock_bh()/spin_unlock_bh() for
consistency?

> +
> +	if (enet->rx) {
> +		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
> +			struct eea_net_rx *rx = enet->rx[i];

[ ... ]

