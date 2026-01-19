Return-Path: <netdev+bounces-251324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFBD3BAFF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E9A230049DA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010C3033DE;
	Mon, 19 Jan 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFVdWwd1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A01A256B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768862549; cv=none; b=TV+CjWeRVetapeJ+bMss2UAY4qtCjS+gnox7bRUCIirKr002bAeqriyF5w1CPinXPrY7ZsNb+cRJnwryBHBCzyjIXpWazFT6Ks+jvPwz6K7uQJMtr7FC/6dckIaOumolTquSsWa+m/YmZG1WfN2OwtwnAralDNBD/zh2UsM0ePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768862549; c=relaxed/simple;
	bh=lAMAP95ZqXxCSN4yx8liWUf7aaeGECTBKXoNnKqG2to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slVUqibytTx/Drplaoo4bpvLIEThZZqh/qXWHBsB8pY9uG25Gb7AgLQmAUBr2rmUMh3D0mCcaALQf31kuw4PYk7HoGWpiyyxnafEF8Ehs+BTLwnzfDFKSzmvCA4GPR+9IxyF2WVkjXvFcmNi7GDdEuhp8yoRfV0Bd0/E6dheHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFVdWwd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E6CC116C6;
	Mon, 19 Jan 2026 22:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768862548;
	bh=lAMAP95ZqXxCSN4yx8liWUf7aaeGECTBKXoNnKqG2to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFVdWwd1i7fnj/hWbSiMNa3NG0wN4aY1BjnWwRaW9gRccisu15VVjDeCJsl2E9omg
	 2tl6ddUK9GkUzm1OcuYkt90xE4tods7keyA4mclGRspTNIWvp/AKmG7ix9CEvVBjuI
	 bNA8sHpJ/ePEYlxbmTlTJnQxfNkx1IA8ydQdkRME4LjktYWGk/Ps9bDnulGbmRALFp
	 XG46bCVgeeZDNdxNddc22Fi6hrZWMIR4okVC6naLvVpHrjw1uIjouFMX9I++yAxwRW
	 NKSU0kHvmwobeDdG4dQP6N22eooLGv5HmnXBMNKSBHWyYN+uYtrh3g3zMc1J88Hiel
	 t6tvUpAO2p2+w==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	dust.li@linux.alibaba.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	dong100@mucse.com,
	guwen@linux.alibaba.com,
	lorenzo@kernel.org,
	edumazet@google.com,
	lulie@linux.alibaba.com,
	lukas.bulwahn@redhat.com
Subject: Re: [net-next,v20,6/6] eea: introduce callback for ndo_get_stats64
Date: Mon, 19 Jan 2026 14:42:25 -0800
Message-ID: <20260119224225.1363113-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115031042.104164-7-xuanzhuo@linux.alibaba.com>
References: <20260115031042.104164-7-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: introduce callback for ndo_get_stats64

This commit adds ndo_get_stats64 support for the Alibaba Elastic Ethernet
Adapter driver. The eea_stats() function iterates over RX and TX queues
to collect packet and byte statistics using u64_stats_sync primitives.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> index 2eba43a82ebc..440f5f11e055 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
> @@ -269,6 +269,52 @@ static int eea_netdev_open(struct net_device *netdev)
> 	return err;
>  }
>
> +static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	u64 packets, bytes;
> +	u32 start;
> +	int i;
> +
> +	/* This function is protected by RCU. Here uses enet->tx and enet->rx
> +	 * to check whether the TX and RX structures are safe to access. In
> +	 * eea_free_rxtx_q_mem, before freeing the TX and RX resources, enet->rx
> +	 * and enet->tx are set to NULL, and synchronize_net is called.
> +	 */
> +
> +	if (enet->rx) {
> +		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
> +			struct eea_net_rx *rx = enet->rx[i];

The comment states this function is protected by RCU, but enet->rx is read
without READ_ONCE() or rcu_dereference(). Since eea_free_rxtx_q_mem() can
set enet->rx to NULL concurrently (before calling synchronize_net()), should
the pointer be loaded with READ_ONCE() to prevent the compiler from
re-reading it between the NULL check and the array access?

Similarly, enet->tx below has the same pattern. The RCU documentation
recommends using rcu_dereference() for pointers that are accessed under
RCU protection and may be concurrently modified.

> +
> +			do {
> +				start = u64_stats_fetch_begin(&rx->stats.syncp);
> +				packets = u64_stats_read(&rx->stats.packets);
> +				bytes = u64_stats_read(&rx->stats.bytes);
> +			} while (u64_stats_fetch_retry(&rx->stats.syncp,
> +						       start));
> +
> +			tot->rx_packets += packets;
> +			tot->rx_bytes   += bytes;
> +		}
> +	}
> +
> +	if (enet->tx) {
> +		for (i = 0; i < enet->cfg.tx_ring_num; i++) {
> +			struct eea_net_tx *tx = &enet->tx[i];

[ ... ]

