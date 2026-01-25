Return-Path: <netdev+bounces-253221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPGgNSiPdmksSAEAu9opvQ
	(envelope-from <netdev+bounces-253221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:46:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA18828B4
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA3253014960
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09230E0D9;
	Sun, 25 Jan 2026 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqUwSyip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5930DED7;
	Sun, 25 Jan 2026 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377519; cv=none; b=MKnghVSleVmncCuDZahhHeY2e1nz8uabqFmnH7pmKwskZ+jiH+Apx9xmfyTUKMTzomDEJZd7uChjLS/n4JBR4L4MXSRJUqtfzhm3IAS0uDzeD9bFk8MNY4OC3lrWlDp45kgTvUz2vZhhoqVmdpmdAFI7aTDhOY44foCPSjbyWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377519; c=relaxed/simple;
	bh=PGoOLqNio3LD9cjsjNmgVUgdmPGeq0f57mM85yor9Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZI+xBP9ZnJJsLEtfyM8nzfKL21DzzZEHB2WdxRKUiY5hJPLD5aLRKwJgg25wAhpVx+lPgrG26D96kdE8zyheLIDPWcf9cAzRr9dDvrLmAt4FXkxBcVQKbqQbhQj7+OUeBcaIR6JoCQM0QvejT9BRH/R863vL43qUkxy2X163kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqUwSyip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB27C4CEF1;
	Sun, 25 Jan 2026 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769377519;
	bh=PGoOLqNio3LD9cjsjNmgVUgdmPGeq0f57mM85yor9Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqUwSyip5gbyjMXOeMooltp2IroSyqdAIA501lQ7r6pMAJoqJi0NfqPpgRKiRY6TQ
	 xTbXg2feAZ1L54viofnHILrTGHsbXWbzSHfnBDG4FbRvOFBWD0Pr4GmhDo6xEi67IQ
	 9Uv0QVrz+mNpzhyoWnMg5Yr5qYOO/JG2U2bp3NrDMMsmuXHao8kO+Ecc2ZseUKkc1s
	 vD87Bm9GVxzxk9WXIu83+4jK/AVNkCURcQuY69LzwyvZu2KBC6xENQ50uWy/N0QO5h
	 G9C9SkturSSnUZoDQpyGNDNX5D3sFVYTb4I5CmpYFMNxe/yRuTfbHwlR6tp7BuSJZ2
	 SiH0+EXL8z6lw==
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
Subject: Re: [v4,net-next,12/15] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
Date: Sun, 25 Jan 2026 13:45:16 -0800
Message-ID: <20260125214516.3384252-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123022143.4121797-13-wei.fang@nxp.com>
References: <20260123022143.4121797-13-wei.fang@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-253221-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,nxp.com,iogearbox.net,fomichev.me,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1DA18828B4
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool

This commit extracts fec_alloc_rxq_buffers_pp() from fec_enet_alloc_rxq_buffers()
to prepare for XDP zero copy mode support. It also adds fec_free_rxq_buffers()
helper for cleanup.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c5ba532e00a8..867694d6d54d 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c

[ ... ]

> +static int
> +fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct fec_enet_priv_rx_q *rxq;
> +	int err;
> +
> +	rxq = fep->rx_queue[queue];
> +	err = fec_alloc_rxq_buffers_pp(fep, rxq);
> +	if (err)
> +		return err;
> +
> +	err = fec_xdp_rxq_info_reg(fep, rxq);
> +	if (err) {
> +		fec_free_rxq_buffers(rxq);
> +
> +		return err;
> +	}
> +
> +	return 0;
> +}

Could there be a memory leak here on systems with multiple RX queues? The
old code had:

     err_alloc:
         fec_enet_free_buffers(ndev);
         return -ENOMEM;

which freed all queues (both RX and TX). The new code calls
fec_free_rxq_buffers(rxq), which only frees the current queue.

If fec_enet_alloc_buffers() calls this function in a loop for multiple
queues and queue N fails after queues 0 through N-1 succeeded, only queue
N gets cleaned up. The caller fec_enet_alloc_buffers() just returns
-ENOMEM without freeing the previously allocated queues:

    for (i = 0; i < fep->num_rx_queues; i++)
        if (fec_enet_alloc_rxq_buffers(ndev, i))
            return -ENOMEM;

And fec_enet_open() jumps to err_enet_alloc which does not call
fec_enet_free_buffers(), leaving the page pools and pages from the
successfully allocated queues leaked.

