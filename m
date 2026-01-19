Return-Path: <netdev+bounces-251271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CFD3B787
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAFA73016FB3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACCC2BD597;
	Mon, 19 Jan 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNzJeqk6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71226B2DA;
	Mon, 19 Jan 2026 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851953; cv=none; b=JZJRgKpVm0OSYnFycsFRqBcLKb9Pda0yh2EEi9Z39MfNbxQJ75PFj3hLtef6Bf5NevVwwb66xZzNik1yGNJtBqAg52Nfc+Nh9brzhGyrSrf94LSr9hb5rwqGpR3gi350tD8N6UQB1PCDMiU6X7hHy9FdFY6XLL9Xc2p6wNt2u1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851953; c=relaxed/simple;
	bh=5iF8rd9rwv5q19FHNihsZl4aiMJx7bgWjmDodKvvKZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf1Ff2F65hZweS5LkugUf/LRE8ZxmG/6Qi6qOWiHtitBE5vO4ejkybeq/dZJwBuZAlS6FWnWJe6iPKkByvOL5FT/k4EChNh0jCaQBjlgNK16kWyE2BlLIBi2jZ2ThMzROkfyJKMCY1Y8H90p5gyLH+sPx0Qr3vy5Jv/WPUlIX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNzJeqk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AB1C116C6;
	Mon, 19 Jan 2026 19:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768851952;
	bh=5iF8rd9rwv5q19FHNihsZl4aiMJx7bgWjmDodKvvKZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNzJeqk6DxOrYIIgqDZTLDoj9jmlOpVJlJfPMzZ1nRFs+2Ld5Xt+m7MlYByT4ajEp
	 hACI/sM5r0GAAfIUqA15BFk56WI0WeNp1xgiK5mqlOcuDJjpAGVMBhGR4bvrB9wq6O
	 jZCqHsusRmBkGrQsjskRJKSfD4t7UYKVc7FVgRcw657CoqS1irfzH9ieE6brMX8iZX
	 afHT6lbXr7lXNCc5NRw7oOdARcfzODjtBa+57k2DCxkjJR7NUMy/LhkFEFZTpfj1Ox
	 PyTF1JGE2eEPIOM+2+7DVYPWecFqO6e8SVcVO4dH+PjxFkoD1sS1BPARtwYPDk3bpd
	 Fs9GJVHdZx6xw==
From: Jakub Kicinski <kuba@kernel.org>
To: bhargava.marreddy@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	vikas.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	pabeni@redhat.com,
	rajashekar.hudumula@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	michael.chan@broadcom.com
Subject: Re: [v5,net-next,6/8] bng_en: Add support to handle AGG events
Date: Mon, 19 Jan 2026 11:45:50 -0800
Message-ID: <20260119194550.1264743-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116193732.157898-7-bhargava.marreddy@broadcom.com>
References: <20260116193732.157898-7-bhargava.marreddy@broadcom.com>
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
bng_en: Add support to handle AGG events

This patch adds AGG event handling in the RX path to receive packet data
on AGG rings, enabling Jumbo and HDS functionality.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> index dffb8c17babe..d6c8557fcb19 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c

[ ... ]

> @@ -284,14 +487,25 @@ static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
>  	if (len <= bn->rx_copybreak) {
>  		skb = bnge_copy_skb(bnapi, data_ptr, len, dma_addr);
>  		bnge_reuse_rx_data(rxr, cons, data);
> -		if (!skb)
> +		if (!skb) {
> +			if (agg_bufs)
> +				bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0,
> +						       agg_bufs);
>  			goto oom_next_rx;
> +		}
>  	} else {
>  		skb = bnge_rx_skb(bn, rxr, cons, data, data_ptr, dma_addr, len);
>  		if (!skb)
>  			goto oom_next_rx;
>  	}

In the copy path (small packets), when bnge_copy_skb() returns NULL, the code
properly calls bnge_reuse_rx_agg_bufs() to recycle the AGG buffers. However,
in the large packet path (else branch), when bnge_rx_skb() returns NULL, are
the AGG buffers being leaked? At this point the completion ring consumer has
already been advanced past the AGG completions by bnge_agg_bufs_valid(), but
without calling bnge_reuse_rx_agg_bufs() the AGG ring producer won't be
updated with replacement buffers.

Should the large packet path also reuse AGG buffers on allocation failure,
similar to the copy path?
-- 
pw-bot: cr

