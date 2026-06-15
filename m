Return-Path: <netdev+bounces-299548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 06WAGjoyMGoUPwUAu9opvQ
	(envelope-from <netdev+bounces-299548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:11:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C089F688B6E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:11:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ta6AIdan;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299548-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299548-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9313055DC2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD94411686;
	Mon, 15 Jun 2026 17:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064FE40FD99;
	Mon, 15 Jun 2026 17:00:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542820; cv=none; b=NhA40QGaWUnX/dXb4JGhdjoqEKwCS+YCdutx6zxkVw5eTycRD2/VKN1HiVRTKNQ0OMjvfvD5uDP4udM298M5c4kle+QKqD6ZhLmh9gfteeaBiDe7H1zzg36ynqJEzqJbaDilpcNTc86FKgOf7q0GSJPBa/YTtTY3KH5judIrmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542820; c=relaxed/simple;
	bh=Sd6w5VRl3SL3Qr9gSaw+iIs849Rgsu5LGnjbXsI9V58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmNc/BuwREBd8AptM6BUP5aI2ru6KGazcv5mW3AbmbaI05tZNMlsA2RiKJ6sFisisiM3rpKWKUc0hIs8YT/orP5ImNpbIBgHdhvTnjcQpQBt6m6MdW4TJMA6QkZ8MAi+wNDGMdQuN04vAWrGTA/NZPNCoc4ossJZJFt1WbI1dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta6AIdan; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A00F1F000E9;
	Mon, 15 Jun 2026 17:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542818;
	bh=tYBG4MayEleaY7B0klKDKWaiVmiIUdR7dgj7BdtwCv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ta6AIdan43EkU4nqfuhwVKuMvkz3aMvcsjhrj6XQD72VC3nhbj851qigbnBAJoRjj
	 XGqRQIGrlADjWS6P0ruDy5Eio3sbi+PpUFHKcPFUwbQTFJY1DzzjcHIosxwIHAPwZ6
	 dT/bsfwF+47kWDSmjqU7LaapPCYwRYO1qUuy+n8va/YLNdmw+Jg9h9m7I/lzcTJZCg
	 sXoQHLrmS1SQnU+NjVTCuVJB4rndtfXuVTiKAffNbKrFH0lcKYds9R/b+LYjQpimX3
	 Yjx4VIeu71nOLpPg0mZT4yVHZOUrOOQmcjIuDzRU48M3/h79P2JSdRfND58mPVmZxa
	 9M+X0X3+rPMNw==
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
Subject: Re: [PATCH v2] net: mvneta_bm: add suspend/resume support to prevent crash after resume
Date: Mon, 15 Jun 2026 17:59:06 +0100
Message-ID: <20260615165905.784252-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614103835.2708515-1-yun.zhou@windriver.com>
References: <20260614103835.2708515-1-yun.zhou@windriver.com>
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
	TAGGED_FROM(0.00)[bounces-299548-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C089F688B6E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: mvneta_bm: add suspend/resume support to prevent crash after resume

This patch adds suspend/resume callbacks to the mvneta_bm driver so the
hardware Buffer Manager is drained on suspend and reinitialised on resume,
and adds a device_link from mvneta to mvneta_bm so the ordering of the two
drivers' PM transitions is enforced.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 0c061fb0ed07..cfaf5ea1db9e 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5678,6 +5678,11 @@ static int mvneta_probe(struct platform_device *pdev)
>  					 "use SW buffer management\n");
>  				mvneta_bm_put(pp->bm_priv);
>  				pp->bm_priv = NULL;
> +			} else {
> +				/* Ensure BM suspends after us, resumes before us */
> +				device_link_add(&pdev->dev,
> +						&pp->bm_priv->pdev->dev,
> +						DL_FLAG_AUTOREMOVE_CONSUMER);

[Medium]
Should the return value of device_link_add() be checked here?

device_link_add() can return NULL on failure (allocation failure,
supplier-not-yet-bound, invalid flag combinations, or a pre-existing
reverse dependency). The commit message and the comment both indicate
that the suspend/resume ordering correctness depends on this link
existing.

If the link is not created, the system silently regresses to the
pre-patch ordering: BM may suspend before mvneta finishes its own
suspend, or resume after mvneta and hand back stale buffer pointers.
The surrounding block already falls back to SW buffer management when
mvneta_bm_port_init() fails; would a similar dev_warn (or fallback) be
appropriate here when device_link_add() returns NULL?

>  			}
>  		}
>  		/* Set RX packet offset correction for platforms, whose
> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
> index 6bb380494919..ff2fe4020a45 100644
> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c
> @@ -477,6 +477,52 @@ static void mvneta_bm_remove(struct platform_device *pdev)

[ ... ]

> +static int mvneta_bm_resume(struct device *dev)
> +{
> +	struct mvneta_bm *priv = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = clk_prepare_enable(priv->clk);
> +	if (err)
> +		return err;
> +
> +	/* Reinitialize BM hardware; pools are refilled by mvneta_resume() */
> +	mvneta_bm_default_set(priv);
> +	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_START_MASK);
> +	return 0;
> +}

[High]
Is this hardware re-initialisation on resume complete?

The commit message says "mvneta disables its clock, causing BM to lose
all buffer address state". If clock gating loses BM state, the per-pool
size and ring pointer registers programmed in mvneta_bm_pools_init()
would also be lost:

	/* Reset read pointer */
	mvneta_bm_write(priv, MVNETA_BM_POOL_READ_PTR_REG(i), 0);

	/* Reset write pointer */
	mvneta_bm_write(priv, MVNETA_BM_POOL_WRITE_PTR_REG(i), 0);
	...
	mvneta_bm_write(priv, MVNETA_BM_POOL_SIZE_REG(i),
			bm_pool->hwbm_pool.size);

mvneta_bm_default_set() only touches MVNETA_BM_INTR_MASK_REG,
MVNETA_BM_INTR_CAUSE_REG, and the burst-size bits in
MVNETA_BM_CONFIG_REG.

The downstream mvneta_bm_pool_create() invoked via mvneta_resume() ->
mvneta_bm_port_init() -> mvneta_bm_pool_use() writes only
POOL_BASE_REG, the XBAR target/attr, and the ENABLE bit; it does not
program POOL_SIZE_REG, POOL_READ_PTR_REG, or POOL_WRITE_PTR_REG.

After resume, POOL_SIZE_REG would hold its hardware reset value while
hwbm_pool->size in software is non-zero. Could buffer puts via
mvneta_bm_pool_put_bp() then misuse the BPPE ring and recreate the
class of failure this patch is trying to fix?

Would it be more correct for mvneta_bm_resume() to call
mvneta_bm_pools_init() (or rewrite SIZE/READ_PTR/WRITE_PTR for every
pool) instead of only mvneta_bm_default_set()?

> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(mvneta_bm_pm_ops, mvneta_bm_suspend, mvneta_bm_resume);
> +

