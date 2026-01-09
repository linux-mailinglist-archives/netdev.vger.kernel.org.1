Return-Path: <netdev+bounces-248331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33200D070C6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 156123008F1E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE008270552;
	Fri,  9 Jan 2026 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3mLF+y4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BCF236A73;
	Fri,  9 Jan 2026 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931072; cv=none; b=a2unCqcdaiZDRTfrdvdOKxwmMMlmGdJJDwpinhHmw+Mv3r4GL4g7B4v2Nfx+Dfvk1jUOuaLPMqLir/P8+FOPjL4C0USJST4qp1MmqJxWZJucylbWch845P9gZAR9u/vR3m0akmAaghUSpFSSuKwISVN/Q43OiBR13aPWmxIJwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931072; c=relaxed/simple;
	bh=Nmf9zXoeCyIwIw5E73xyMm2SNdNXQJ01rBTJXi0wHbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNWFXhZjCTwVNemFXPF++ZX5pCor+J9+BREr/rYynqyyb9tVAgZewW96AQiat458xtGYbsx2vrGaeXGHsImFk8rf0l2U19mYIqWNTnSr2jPNOZnzpnDbGc5VCjYKEoDztO0u4ytP6O3L81xoiAkINpuLo2AaBzI3dr9JtwG+HHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3mLF+y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A1AC4CEF1;
	Fri,  9 Jan 2026 03:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767931072;
	bh=Nmf9zXoeCyIwIw5E73xyMm2SNdNXQJ01rBTJXi0wHbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3mLF+y44uvtzoVTKnGRFO3aCo3tZ82awwOCz37kI9P4I8IkrHSqK8/ONYQsL6fmA
	 0M1WGN1DhsFkA3Z8hdOgANmBjriDubNEOag37b/aEtnIoMUcfbZJdpy4bKdfjihGsj
	 B1ul2edYgVIujAVXnugRyScw4GbH5GTzu7Lz9kfllvqwKtG76Z/6WcnX8+sNFS+RuE
	 lM5AuGXTIyagC59bD5I5Evmtnnp6lbD3zJKAFlScO6y3XHwd3ZBvi8cqIMLBDZCTB5
	 MXxtQez2rYKkBjNSOVnbZYQFqMIg8z+WO5CqIEcds1wzxVu8y01cx42//3QOJtHjl1
	 RfMNGCVqIEQTA==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	olteanv@gmail.com,
	david.laight.linux@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	dan.carpenter@linaro.org
Subject: Re: [net-next,v4,1/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Thu,  8 Jan 2026 19:56:43 -0800
Message-ID: <20260109035643.2902417-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108004309.4087448-2-mmyangfl@gmail.com>
References: <20260108004309.4087448-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: yt921x: Use u64_stats_t for MIB stats

This patch converts MIB statistics from plain u64 to u64_stats_t and adds
u64_stats_sync protection for atomic statistics access on 32-bit systems.

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 7b8c1549a0fb..3d87944830f6 100644

[ ... ]

> @@ -762,22 +779,27 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
>  	struct yt921x_priv *priv = to_yt921x_priv(ds);
>  	struct yt921x_port *pp = &priv->ports[port];
>  	struct yt921x_mib *mib = &pp->mib;
> +	unsigned int start;
>  	size_t j;
>
>  	mutex_lock(&priv->reg_lock);
>  	yt921x_read_mib(priv, port);
>  	mutex_unlock(&priv->reg_lock);
>
> -	j = 0;
> -	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> -		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> +	do {
> +		start = u64_stats_fetch_begin(&pp->syncp);

This uses pp->syncp via u64_stats_fetch_begin(), but the syncp field does
not appear to be initialized with u64_stats_init() anywhere.

Looking at yt921x_mdio_probe(), the port initialization loop initializes
pp->index and pp->mib_read but not pp->syncp:

    for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
        struct yt921x_port *pp = &priv->ports[i];
        pp->index = i;
        INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
    }

On 32-bit systems, u64_stats_init() calls seqcount_init() which sets up
the lockdep class. Without this initialization, CONFIG_DEBUG_LOCK_ALLOC
builds may produce lockdep warnings.

For comparison, the xrs700x driver at drivers/net/dsa/xrs700x/xrs700x.c
initializes its syncp field with u64_stats_init(&p->syncp).

Should u64_stats_init(&pp->syncp) be added to the port initialization loop
in yt921x_mdio_probe()?

[ ... ]

> diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
> index 61bb0ab3b09a..17fee83952c2 100644
> --- a/drivers/net/dsa/yt921x.h
> +++ b/drivers/net/dsa/yt921x.h

[ ... ]

> @@ -533,9 +535,13 @@ struct yt921x_port {
>  	bool isolated;
>
>  	struct delayed_work mib_read;
> +	struct u64_stats_sync syncp;
>  	struct yt921x_mib mib;
> -	u64 rx_frames;
> -	u64 tx_frames;
> +	u64_stats_t rx_frames;
> +	u64_stats_t tx_frames;
> +
> +	/* only used by read routine to avoid huge allocations on the stack */
> +	struct yt921x_mib mib_new;
>  };

-- 
pw-bot: cr

