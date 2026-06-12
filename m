Return-Path: <netdev+bounces-298734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id or+uDh05LGrXNwQAu9opvQ
	(envelope-from <netdev+bounces-298734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:51:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5067B149
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:51:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fVLorpVp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298734-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298734-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ABFA3001199
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E73A75B8;
	Fri, 12 Jun 2026 16:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9211CA9;
	Fri, 12 Jun 2026 16:51:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283094; cv=none; b=EHDtiHtGoe9QvUcbTBRaM1VFbu08jBYvY2v5sLVukq0zt4ElmIV0BM5F8mVjinCWoioD27YIMc2C5Scy84oa+aUMwi/50sguTbPwkwz5gf+FzNeawqLn2xzcDtgOrTOmUDkpealsfDCSHTlXmeGIr7BTMkYQrqeXPDgGZdzJhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283094; c=relaxed/simple;
	bh=RYU9EuyLUhJTWm5b5sJ1VkrIG5+i8YqpShLiujir5qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtRVtbSGhH8xQuJsx9bA2ZcrYPGdfbypIkmgAtGc0RWG4uCyKfRRu2y/0yZQvn+mn3wYqmaahOX4CeESgj3R11Ru1EOsgFxTKN02Abu5rBiTb9wQWXMahD9jYD5N2xZ8LQGPX2VQXv/PPRcpkp9vF4SjLHv8xBg6IrYzq0Lt7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVLorpVp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDD41F000E9;
	Fri, 12 Jun 2026 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781283093;
	bh=esHSVNaQrm4lfnAN4DrQXTNK+8Hf33HfJ21ebtM3a6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVLorpVpFU2je59TcjAePlgDkJLqn9B3Zxe1Q+qH+QleXHx4KuqQr6SHsC6T8eWR5
	 eeAZ6LPOLjKJAVhO5iHCbG8IGr8MDb/9+y4LPG655+lADoebOsZM3SR8303C2p1wcq
	 JejBIsQ81Jt9RLdfeQbq0/ZbhetM3+lEFeaZl0SF3VIbQxX5Km4xAPFanN2pM6mIMJ
	 ojt0lFYTBeTehq1eUw+tKVv32xvFP0MGdcPxFdrNFF+Cw3IQrxSidHrS67iQAW/QA1
	 v3iL96LeVVksZGYHRKZV6aG6rVijMae4XEVT4c8Qhln5JagOh+Ho6VwcbPFAwITiuI
	 Db7PWL2qROaXw==
From: Simon Horman <horms@kernel.org>
To: yun.zhou@windriver.com
Cc: Simon Horman <horms@kernel.org>,
	marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mvneta_bm: add suspend/resume to prevent crash after resume
Date: Fri, 12 Jun 2026 17:50:50 +0100
Message-ID: <20260612165048.696544-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611020935.1933865-1-yun.zhou@windriver.com>
References: <20260611020935.1933865-1-yun.zhou@windriver.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298734-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:horms@kernel.org,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35D5067B149

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: mvneta_bm: add suspend/resume to prevent crash after resume

This patch adds suspend/resume PM callbacks to the mvneta_bm driver to
avoid a NAPI-time panic after system resume caused by BM hardware
returning stale buffer addresses. The suspend handler stops BM and gates
the clock; the resume handler re-enables the clock, calls
mvneta_bm_default_set() and mvneta_bm_pools_init().

> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
> index 6bb380494919..a0800b99c007 100644
> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c
> @@ -477,6 +477,30 @@ static void mvneta_bm_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(priv->clk);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mvneta_bm_suspend(struct device *dev)
> +{
> +	struct mvneta_bm *priv = dev_get_drvdata(dev);
> +
> +	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_STOP_MASK);
> +	clk_disable_unprepare(priv->clk);
> +	return 0;
> +}

[High]
Does this suspend path leak every RX buffer currently parked in the BM
hardware?

Buffers allocated via mvneta_bm_construct() are tracked only by the BM
unit itself: their virtual address is stored in the first 4 bytes of
the buffer, while only the phys address is pushed to BM through
mvneta_bm_pool_put_bp(). There is no kernel-side shadow list.

Once MVNETA_BM_STOP_MASK is written and the clock is gated, the commit
message itself says BM "loses all buffer address state". On a later
teardown, mvneta_bm_bufs_free() will read zero/garbage out of the now
empty BPPI/BPPE and bail on:

	if (buf_phys_addr == 0)
		continue;

so dma_unmap_single() / hwbm_buf_free() are never called for the
original allocations. Should suspend drain BM via mvneta_bm_bufs_free()
while BM still knows the addresses, and resume refill via
hwbm_pool_add()?

> +
> +static int mvneta_bm_resume(struct device *dev)
> +{
> +	struct mvneta_bm *priv = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(priv->clk);

[Medium]
Should the return value of clk_prepare_enable() be checked here?

mvneta_bm_probe() checks the same call and propagates the error. If
the call fails on the resume path, the immediately-following readl/
writel accesses in mvneta_bm_default_set() (MVNETA_BM_INTR_MASK_REG,
MVNETA_BM_INTR_CAUSE_REG, MVNETA_BM_CONFIG_REG) and
mvneta_bm_pools_init() (MVNETA_BM_COMMAND_REG and per-pool registers)
target an unclocked peripheral, which on Armada 380 typically raises a
synchronous external abort.

> +	mdelay(1);

[Low]
Resume callbacks for system sleep run in process context. Could
usleep_range() be used here instead of the busy-wait mdelay(1)?

Also, what is the 1ms delay waiting for? The probe path does the same
clk_prepare_enable() followed by mvneta_bm_default_set() with no
delay, and there is no comment or datasheet citation explaining what
this is for.

> +	mvneta_bm_default_set(priv);
> +	mvneta_bm_pools_init(priv);

[High, High]
Two questions about reusing mvneta_bm_pools_init() on the resume path.

First, does resume leave BM hardware with no buffer addresses, in spite
of the commit log saying the resume should "restart pools"?

mvneta_bm_pools_init() resets bm_pool->type to MVNETA_BM_FREE but does
not reset hwbm_pool->buf_num. The original probe-time fill set
buf_num = hwbm_pool->size, so the post-resume call chain
mvneta_bm_port_init() -> mvneta_bm_pool_use() -> hwbm_pool_add() takes
this early-return in net/core/hwbm.c:

	int hwbm_pool_add(struct hwbm_pool *bm_pool, unsigned int buf_num)
	{
		...
		if (bm_pool->buf_num == bm_pool->size) {
			pr_warn("pool already filled\n");
			return bm_pool->buf_num;
		}

hwbm_pool_refill() is never called, so no buffers are constructed and
no phys addresses are pushed via mvneta_bm_pool_put_bp(). Meanwhile,
mvneta_bm_pool_create() reprograms MVNETA_BM_POOL_BASE_REG to a fresh
dma_alloc_coherent() region. Doesn't this leave BM started with an
empty pool, recreating the same class of failure the patch claims to
fix the next time mvneta_rx_hwbm() runs?

Second, can this leak the previously allocated BPPE region per
suspend/resume cycle?

mvneta_bm_pools_init() unconditionally sets bm_pool->type =
MVNETA_BM_FREE for every pool but does not free
bm_pool->virt_addr / bm_pool->phys_addr (the DMA-coherent BPPE region
allocated by mvneta_bm_pool_create() during probe). On resume,
mvneta_bm_port_init() -> mvneta_bm_pool_use() observes
new_pool->type == MVNETA_BM_FREE and re-enters
mvneta_bm_pool_create(), which calls dma_alloc_coherent() and
overwrites virt_addr/phys_addr without dma_free_coherent() on the
previous allocation. mvneta_bm_pool_destroy() is the only freer of
virt_addr and is not called from the suspend path.

> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(mvneta_bm_pm_ops, mvneta_bm_suspend, mvneta_bm_resume);
> +
>  static const struct of_device_id mvneta_bm_match[] = {
>  	{ .compatible = "marvell,armada-380-neta-bm" },
>  	{ }
> @@ -489,6 +513,7 @@ static struct platform_driver mvneta_bm_driver = {
>  	.driver = {
>  		.name = MVNETA_BM_DRIVER_NAME,
>  		.of_match_table = mvneta_bm_match,
> +		.pm = &mvneta_bm_pm_ops,
>  	},
>  };

[Medium]
Is the suspend/resume ordering between the mvneta_bm supplier and the
mvneta consumer guaranteed by anything beyond dpm_list registration
order?

mvneta_bm_get() does of_find_device_by_node() and
platform_get_drvdata(), but does not call device_link_add(). Without a
device link or equivalent dpm dependency, ordering between two
independent platform_drivers is determined by probe completion order.
Under deferred-probe scenarios (e.g., mvneta probes first with the
bm_priv == NULL fallback, then mvneta_bm probes later), would the
ordering still keep mvneta_bm_resume() before any mvneta_resume() ->
mvneta_bm_port_init() touching BM registers, and the mvneta consumer
quiesced before mvneta_bm_suspend() stops BM and gates the clock?

Would adding a device_link_add(supplier=bm_pdev, consumer=mvneta_pdev,
DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER) when a consumer
attaches make this ordering explicit?
-- 
pw-bot: changes-requested

