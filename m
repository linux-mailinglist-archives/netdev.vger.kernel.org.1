Return-Path: <netdev+bounces-302866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ztsvE7ISQ2qSPAoAu9opvQ
	(envelope-from <netdev+bounces-302866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AD66DF737
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:49:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VnLh+17y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302866-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302866-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F39A302B3BE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 00:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A11FF7C8;
	Tue, 30 Jun 2026 00:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815871A0712;
	Tue, 30 Jun 2026 00:49:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780579; cv=none; b=dGiitqoFEFNkUnBQqhCnoB7nqt/Me8/DUaLyPjqCftU1D3jYV87NopFeog6YJCmKPQYA7SYKlCI/M/ybrTiyGOfdIqrVOX/JQRE3BF1/JYaf5dMSA49lFfNvIak6nAENTR2YeFI2GzluYxW8y4khJZ1z+xVW1u1hl16T1FPjBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780579; c=relaxed/simple;
	bh=VMOUGsQgwQaA6cIYlgVOPIuJcEs6lZJAx9KSb6ElPtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTYf3HyDvvE1KErl1iss/3adVa9oQs9SytoZzMk0yqNSKzeDEdqL0nnWVsc0uQWBeQhO6NifQ9U/8rb7dRHhnP6w3jABH2/YCN0sP7xglDqS9NrHCUb3nBJeXWf3m8n5fkcYLSyd40GEEGQG62s+60bYhgXdVb/SbSsRX8C6kSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnLh+17y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7171F000E9;
	Tue, 30 Jun 2026 00:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782780578;
	bh=Zof0jopAn7x+s0cuQEES7bZ2HEtdi52fhlQDCm29N2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VnLh+17yELpPOLHLoJwfatYSfg2lbeaP5YMmmwsL9CfdWLGEs67tIwuSYVXhEQS5Q
	 Hpq+bFKE8NPcZYqwaDD3ldqj4pOLbEogA8KKdZVrOl/08tNBsVushEyP9VEM28KPt1
	 B1fwIAJALowXfxZfIFOQho5Fh+Im+5n8J6yMBi1J36m8AaDnVnxQ/umqxk+duIdSd4
	 J+rpWhstmRpTLZw4nAh2ilhfdI2Wd0Ht/R0RL/Fe+9mvwqp5JEzml3WBrWlwbtU2hr
	 p7UckCpDeoXew3DB6cgVGsxgwftZidH9w5HCsdLRiCrkmM7X5yCytkBvHwuQFrOtSt
	 mKdljkBA/u8rQ==
From: Jakub Kicinski <kuba@kernel.org>
To: yun.zhou@windriver.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] net: mvneta_bm: add suspend/resume support to prevent crash after resume
Date: Mon, 29 Jun 2026 17:49:28 -0700
Message-ID: <20260630004927.2247546-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625030925.956765-1-yun.zhou@windriver.com>
References: <20260625030925.956765-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302866-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:kuba@kernel.org,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2AD66DF737

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mvneta_bm: add suspend/resume support to prevent crash after resume
    
This commit adds suspend and resume callbacks to the mvneta Buffer Manager
driver to safely drain and reinitialize buffers across power cycles. It also
adds a device link to guarantee correct PM ordering between mvneta and the BM
hardware.

> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
> index 6bb3804949190..c23982bfc20b8 100644
> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c

[ ... ]

> @@ -477,6 +477,68 @@ static void mvneta_bm_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(priv->clk);
>  }
>  
> +static int mvneta_bm_suspend(struct device *dev)
> +{
> +	struct mvneta_bm *priv = dev_get_drvdata(dev);
> +	int i;
> +
> +	/* Drain buffers and free pool resources while BM is still clocked */
> +	for (i = 0; i < MVNETA_BM_POOLS_NUM; i++) {
> +		struct mvneta_bm_pool *bm_pool = &priv->bm_pools[i];
> +		int size_bytes;
> +
> +		if (bm_pool->type == MVNETA_BM_FREE)
> +			continue;
> +
> +		mvneta_bm_bufs_free(priv, bm_pool, bm_pool->port_map);
> +		if (bm_pool->hwbm_pool.buf_num)
> +			dev_warn(&priv->pdev->dev,
> +				 "pool %d: %d buffers not freed\n",
> +				 bm_pool->id, bm_pool->hwbm_pool.buf_num);
> +
> +		mvneta_bm_pool_disable(priv, bm_pool->id);
> +
> +		if (bm_pool->virt_addr) {
> +			size_bytes = sizeof(u32) * bm_pool->hwbm_pool.size;
> +			dma_free_coherent(&priv->pdev->dev, size_bytes,
> +					  bm_pool->virt_addr,
> +					  bm_pool->phys_addr);
> +			bm_pool->virt_addr = NULL;
> +		}

[Severity: High]
This is a pre-existing issue, but does this introduce a double free during
suspend if mvneta_bm_pool_create() partially failed?

If mvneta_bm_pool_create() succeeds at dma_alloc_coherent() but fails a
subsequent check, the error path calls dma_free_coherent() but leaves
bm_pool->virt_addr as a dangling pointer:

drivers/net/ethernet/marvell/mvneta_bm.c:mvneta_bm_pool_create() {
    ...
    dma_free_coherent(&pdev->dev, size_bytes, bm_pool->virt_addr,
                      bm_pool->phys_addr);
    return err;
}

Since the caller mvneta_bm_pool_use() already set the pool type to something
other than MVNETA_BM_FREE, won't this new suspend handler see the non-NULL
virt_addr and call dma_free_coherent() on it a second time?

> +		bm_pool->type = MVNETA_BM_FREE;

[Severity: Medium]
Will this cause a lockdep warning by re-initializing an active lock class?

By setting the type to MVNETA_BM_FREE here, the resume path (which calls
mvneta_resume() -> mvneta_bm_port_init() -> mvneta_bm_pool_use()) will treat
this as a completely uninitialized pool.

This causes mvneta_bm_pool_use() to unconditionally call:

    mutex_init(&hwbm_pool->buf_lock);

Because the priv->bm_pools array is preserved across suspend, the mutex
was already fully initialized during probe. Doesn't re-initializing the
mutex across suspend/resume cycles reset its internal lockdep state and
wait queue?

> +	}
> +
> +	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_STOP_MASK);
> +	clk_disable_unprepare(priv->clk);
> +	return 0;
> +}
-- 
pw-bot: cr

