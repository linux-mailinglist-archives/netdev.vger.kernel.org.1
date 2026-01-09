Return-Path: <netdev+bounces-248332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF09D070D2
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1C530198C6
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6480274650;
	Fri,  9 Jan 2026 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slVyBZCC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A74236A73;
	Fri,  9 Jan 2026 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931151; cv=none; b=Hhn/eMIoCJpJo+HeEA4bw+aOhjbhsjPCch3xRdtx0UaHKUG9yMNpVnjqmLavTsU3V7tDS8f4+Hl8yNx2YJPrg7okNBd+Mw80g1cVt/p75wRrCLsLw2rUopvPniSi092wj5MK1Zvur8Qjpd44JNoCTJzdgSKlE4zItk2AXpHJYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931151; c=relaxed/simple;
	bh=JHjSYuE4PtfO/NPVUjN260lbv/+4kvRBXk9xa2jwUCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRAHVeWGr/gC5yV1Q9kK/tPjdKuQlIlAruVbnfF5Dz+4kKBAIAwArpiUO/GEVxFCk8tnIGJnY7x/CqujY4hOg1jgYFrO6bQNo2k77Z3x9tpTRIoCNK1fTzNbZBQN4+uGLc+y26d6DOsMOLEoQ4xSpbGJEnXdQyZ3IpwG9wuJ0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slVyBZCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2742C4CEF1;
	Fri,  9 Jan 2026 03:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767931151;
	bh=JHjSYuE4PtfO/NPVUjN260lbv/+4kvRBXk9xa2jwUCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slVyBZCC8X+SkjEK4PnUP2UBDr1XlJiZPo4MscSZ6EVlu/v3UYQKPghCuuhm5do2t
	 4rsmJdZ9MkkfLKS+y9GFuZ5loG8OEaegLZRaVlqzn+1STCNI/1F6AzBkmPT1MPVdNn
	 DV/KeE2RoVr/EzIF6xuSogYaygXJSHQM3PTHsn2LsPVNHMxRRnNHzrLpyZwxITNppH
	 MWPb8WY5Hz+4b4yqVtqxEVHmtSP1U/CTTIOIJYPk3lEw5BiW2azc2MTjUdq8RqwEj7
	 eoe82asZUP2wH3n1w1DQS34pXvGOFBlzlqdGkfSM6Mhz3aHTMNbvXDongIzjlNaFQS
	 dYODE5DoF5DKA==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	andrew@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	david.laight.linux@gmail.com,
	olteanv@gmail.com,
	dan.carpenter@linaro.org
Subject: Re: [net-next,v4,2/2] net: dsa: yt921x: Use u64_stats_t for MIB stats
Date: Thu,  8 Jan 2026 19:59:04 -0800
Message-ID: <20260109035904.2904127-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108004309.4087448-3-mmyangfl@gmail.com>
References: <20260108004309.4087448-3-mmyangfl@gmail.com>
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

This patch converts the MIB statistics from plain u64 to u64_stats_t and
adds a u64_stats_sync seqcount to provide atomicity on 32-bit architectures
while remaining lock-free on 64-bit architectures.

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

The new syncp field requires u64_stats_init() to be called before use.
Looking at yt921x_mdio_probe(), the port initialization loop only sets
pp->index and calls INIT_DELAYED_WORK() but does not call
u64_stats_init(&pp->syncp).

On 32-bit architectures, u64_stats_init() calls seqcount_init() which
initializes the lockdep tracking. Without this initialization, builds
with CONFIG_DEBUG_LOCK_ALLOC may have lockdep issues.

For reference, the xrs700x DSA driver does this correctly in
xrs700x_alloc_port_mib():

    mutex_init(&p->mib_mutex);
    u64_stats_init(&p->syncp);

Should u64_stats_init(&pp->syncp) be added to the port initialization
loop in yt921x_mdio_probe()?

