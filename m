Return-Path: <netdev+bounces-253222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC76AViPdmksSAEAu9opvQ
	(envelope-from <netdev+bounces-253222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:47:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4E828CA
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC0E7301FFBC
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732F30DEBE;
	Sun, 25 Jan 2026 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7BXWbJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432130DEB8;
	Sun, 25 Jan 2026 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377521; cv=none; b=gZ7iPy2Dyciz/HaFeiQVpU9ga7FnXdlyIG1DVdXhztOULnYGw8AacCiPXIr56K+qJgqPSW7sK+it3YCgN5S2g0VaopWcIYwwLJr98OSZyJ/9LMgS5ayAVer6r2u6vAEnPxDJ/rtH95u4CyxuiAUbiR39kxkjYQ53TbPnVereYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377521; c=relaxed/simple;
	bh=+XMaW9KHF5jK8JykWaSX8el6KsQSrR6xUKWXs8AAIkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MidlqClqDMIkn7+uSiUBMBpwb/u2iIn9nc8z4FjmRI6yNOMahTuPPgKWWpb/eoGG0ils+dnHUhJmMzsE2lpkSuqa1tJZWJ5uyTY2MaJsEBjWu7BXJTDBa1t2RCmwXE7bnmsxKfwFR0bZsGRk0mR2mouzHklM6cTGPDmTMQU246M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7BXWbJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60AEC4CEF1;
	Sun, 25 Jan 2026 21:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769377521;
	bh=+XMaW9KHF5jK8JykWaSX8el6KsQSrR6xUKWXs8AAIkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7BXWbJV/dV6xwKtkCcUcVcOT4iiglrG3CONMsP6lYnsm/DhuRyfMOX1RBBz63HB+
	 Hhkn11jzoXryWdMLHppgoYNbTCTu5H1IFfaQ5/avc8Bobfz0v17M6lW5px1WM2Ua1i
	 Kj4bberT5Ly9di/oYjCX/fxxS61dL8qNOCS2vQj5BCAzobHn8oRETHKM/lwdc7KVBx
	 rFuZUxZPJqdpeXHMrZ3oD4v/c5anrN5jh+k1Cg0YAmC2jhzLc1/mu65rJsIHASll9T
	 TG3IgbsumALDnG2w0Gc4mwoe0XQlC3atmrqN1mlIqg5VjwHxTBaQ546i3Oy5oqpeEf
	 nNfH68r+UH7tA==
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
Subject: Re: [v4,net-next,13/15] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Date: Sun, 25 Jan 2026 13:45:19 -0800
Message-ID: <20260125214519.3384279-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123022143.4121797-14-wei.fang@nxp.com>
References: <20260123022143.4121797-14-wei.fang@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,nxp.com,iogearbox.net,fomichev.me,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-253222-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A4E828CA
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fec: add AF_XDP zero-copy support

This patch adds AF_XDP zero-copy support for both TX and RX on the FEC
ethernet driver. RX buffers are allocated from the XSK pool instead of
the page pool, and TX supports both frames from AF_XDP sockets and
XDP_TX action.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c19ae60b04d7..d3e54dcf6a4c 100644

[ ... ]

> +static int fec_setup_xsk_pool(struct net_device *ndev,
> +			      struct xsk_buff_pool *pool,
> +			      u16 queue)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	bool is_run = netif_running(ndev);
> +	struct fec_enet_priv_rx_q *rxq;
> +	struct fec_enet_priv_tx_q *txq;
> +	bool enable = !!pool;
> +	int err;
> +
> +	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
> +		return -ERANGE;
> +
> +	if (is_run) {
> +		napi_disable(&fep->napi);
> +		netif_tx_disable(ndev);
> +		synchronize_rcu();
> +		fec_enet_free_buffers(ndev);
> +	}
> +
> +	rxq = fep->rx_queue[queue];
> +	txq = fep->tx_queue[queue];
> +
> +	if (enable) {
> +		err = xsk_pool_dma_map(pool, &fep->pdev->dev, 0);
> +		if (err) {
> +			netdev_err(ndev, "Failed to map xsk pool\n");
> +			return err;
> +		}

If xsk_pool_dma_map() fails here when is_run was true, NAPI has already
been disabled, TX has been disabled, and buffers have been freed. The
early return leaves the device in a non-functional state with no way to
recover except manually bringing the interface down and up.

Should this error path restore the device state by calling fec_restart(),
napi_enable(), and netif_tx_start_all_queues() before returning, similar
to what is done after fec_enet_alloc_buffers() succeeds?

> +
> +		rxq->xsk_pool = pool;
> +		txq->xsk_pool = pool;
> +	} else {
> +		xsk_pool_dma_unmap(rxq->xsk_pool, 0);
> +		rxq->xsk_pool = NULL;
> +		txq->xsk_pool = NULL;
> +	}
> +
> +	if (is_run) {
> +		err = fec_enet_alloc_buffers(ndev);
> +		if (err) {
> +			netdev_err(ndev, "Failed to alloc buffers\n");
> +			goto err_alloc_buffers;
> +		}
> +
> +		fec_restart(ndev);
> +		napi_enable(&fep->napi);
> +		netif_tx_start_all_queues(ndev);
> +	}
> +
> +	return 0;
> +
> +err_alloc_buffers:
> +	if (enable) {
> +		xsk_pool_dma_unmap(pool, 0);
> +		rxq->xsk_pool = NULL;
> +		txq->xsk_pool = NULL;
> +	}
> +
> +	return err;

Similarly, the err_alloc_buffers path cleans up the XSK pool state but
does not restore NAPI/TX or restart the device when is_run was true.
Does this leave the device in the same non-functional state?

> +}

[ ... ]

