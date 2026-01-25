Return-Path: <netdev+bounces-253220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hubnLvGOdmksSAEAu9opvQ
	(envelope-from <netdev+bounces-253220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:45:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126A82895
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE84300422F
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F65274FEF;
	Sun, 25 Jan 2026 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJJ2I41Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACA946C;
	Sun, 25 Jan 2026 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377517; cv=none; b=nOa3pR6nLZJzO7b5NQ4jQDph1G7BmMpyushXdaBMG6sJfRCNiQyL3hjXc3ZX5Ugb1ff2tBMv4273w3yCuNchnSjdoSHn0my2NEETNGmANWHvna+BijnnXma9p+TiH6cN5IaIWqKJO2bO2WOS2eMe5j2IsRTuW1oPu3oZRqF+uBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377517; c=relaxed/simple;
	bh=4Hs7D0jZtzJiVBb2yTBmS1/1dpXXOED2Kmh7/H708XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhCj1BOUOL1AfB6rZaSZVU9e3GFK/XtnUdnWwDlL00byka8cIk0LCBSkRtja3uXjzHTtElpdCwUIJUxOz00+7P6MlQEVITwUmcqL3k91RddzCowp0G87vRwJrIPwPWTMmvTotaJQTKAXhdrP6VY1DDTXz9gUxURk6RGGS+HW2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJJ2I41Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF658C4CEF1;
	Sun, 25 Jan 2026 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769377516;
	bh=4Hs7D0jZtzJiVBb2yTBmS1/1dpXXOED2Kmh7/H708XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJJ2I41Y4BI5+qnS++v44VnEqj0Ah43Yehhnp2aZGhb/q7yC3Gjmn+ui80/Y1jvkO
	 PZvjFr2tsv5lH8bCKrhfUQUb/I/JrxnufSO/Utx2Sj/+PxEDw03lPQ+Y4QY9pnHrb8
	 0IN5SZB17WrcHmFZeEgoqmmh9gS1g3GSVtn5Vy1P2giwHbfuRL7xFYXEUK4zPFh2YP
	 crbTSxVUP/4X9tWBv/F+m1TaocZtIHTRUaieVftR/FU0tGcRd87NFrwsUycFTS55Lf
	 GOhpNWXXzP+eO9suspQQosDfo86R3H4XBaxLtpVTVCdczJ2VTXKlV5zotVDswo5dLD
	 auamaCz6PoCuQ==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	shenwei.wang@nxp.com,
	daniel@iogearbox.net,
	frank.li@nxp.com,
	netdev@vger.kernel.org,
	xiaoning.wang@nxp.com,
	ast@kernel.org,
	sdf@fomichev.me,
	imx@lists.linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Subject: Re: [v4,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Sun, 25 Jan 2026 13:44:46 -0800
Message-ID: <20260125214446.3383999-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123022143.4121797-7-wei.fang@nxp.com>
References: <20260123022143.4121797-7-wei.fang@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253220-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,nxp.com,iogearbox.net,fomichev.me,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1126A82895
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fec: add fec_enet_rx_queue_xdp() for XDP path

This commit separates XDP path packet processing from protocol stack
packet processing by adding a new fec_enet_rx_queue_xdp() function.
The goal is to optimize XDP path logic and improve XDP performance.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 0529dc91c981..86447a7cb963 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c

[ ... ]

> +static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
> +				 int budget, struct bpf_prog *prog)
> +{

[ ... ]

> +		switch (act) {
> +		case XDP_PASS:
> +			rxq->stats[RX_XDP_PASS]++;
> +			/* The packet length includes FCS, but we don't want to
> +			 * include that when passing upstream as it messes up
> +			 * bridging applications.
> +			 */
> +			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
> +			if (!skb) {
> +				fec_xdp_drop(rxq, &xdp, sync);
> +				trace_xdp_exception(ndev, prog, XDP_PASS);
> +			} else {
> +				napi_gro_receive(&fep->napi, skb);
> +			}
> +			break;

On platforms with FEC_QUIRK_SWAP_FRAME (like i.MX28), the old code path
would call swap_buffer() after XDP_PASS before building the skb. In the
old fec_enet_rx_queue(), the flow was:

    fec_enet_run_xdp() returns FEC_ENET_XDP_PASS
    -> if (ret != FEC_ENET_XDP_PASS) goto done; // continues
    -> if (need_swap) swap_buffer(data, pkt_len);
    -> fec_build_skb()

With this change, XDP_PASS goes directly to fec_build_skb() without
calling swap_buffer(). Does this break XDP_PASS on i.MX28 where the DMA
delivers data in wrong byte order? On such platforms, packets passed to
the network stack would have incorrect byte order, causing protocol
parsing failures.

The commit message says "XDP path does not support swap_buffer()" but the
previous code did support it for XDP_PASS - the swap happened after the
XDP program returned PASS but before the packet was handed to the stack.
-- 
pw-bot: cr

