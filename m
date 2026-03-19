Return-Path: <netdev+bounces-269240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONOvIV1Ku2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:59:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E32C4401
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEB72302C36E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD06255F28;
	Thu, 19 Mar 2026 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnDrQc30"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30A2AD00
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881938; cv=none; b=gpEcD2tVaFG0A+KQJNqNYfBqneHof3lFduX3FYm8ZGsoSvaD2UxaWdNzGMkCbDOlCR+6VhWRhC5dorLFUHafy+kG4jw/pFQYIsDY6sB4i2rXHBMo0yF7F9sPTSfQmLtne3CBocxpHU6xodl5kNkXNGjlh6sPqeO+g78AZLRemaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881938; c=relaxed/simple;
	bh=Eosp1wr0nc9fzlCkuTGjQHGUhg6PQUMdciDYX6bg9Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edevIB1sglQtmphA6SXgcBTX0zG9rwp4+Cw7mvKsOV+rwmN8R4hvvntwcSHifpY8efE7IQDTqoobModvWSlXKIElm+t5fnvALZkXhGab1c+5yzrL9NXLh4Z4sLfTWa3OGAZDvqjICDRFT5PWVYJNylyUYhygRBZuz5riWA4rO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnDrQc30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5510C19421;
	Thu, 19 Mar 2026 00:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881938;
	bh=Eosp1wr0nc9fzlCkuTGjQHGUhg6PQUMdciDYX6bg9Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnDrQc305r0Tc6X1ZOiolymW9SCNweQ9tA42PHGttIlGJsBFGFTr2z7ghPO0AQGcI
	 eWmAgNq009JlR3tPNLHakcseyeezfPmrZ5lV+W3Q0ydUnEasfrkLBssMXKkDz00OrH
	 iZBfs2XwCsTFFaGdI8M81V5GjWFSH9XTFEnEq27j6yrN/rSJBPl+7MjIxpGntH8tEC
	 9JGBNPVeudEmDWozj4PuGnWRssQPkf6CRD9nC7LTFhjyHZRtlYy1Vy5XXuZCgleCuC
	 57dsQdTePodvFze6RfGklLI7A2JwsterDqmodXM3EUEJOqSyoqotiN7haukJ2zaixF
	 TzDp2m0GY2XSw==
From: Jakub Kicinski <kuba@kernel.org>
To: justin.chen@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	florian.fainelli@broadcom.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net v2 2/2] net: bcmasp: fix double disable of clk
Date: Wed, 18 Mar 2026 17:58:51 -0700
Message-ID: <20260319005851.2145991-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316180202.3371477-3-justin.chen@broadcom.com>
References: <20260316180202.3371477-3-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269240-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: F20E32C4401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: bcmasp: fix double disable of clk

Switch to devm_clk_get_optional() so we can manage the clock ourselves.
We dynamically control the clocks depending on the state of the interface
for power savings. The default state is clock disabled, so unbinding the
driver causes a double disable.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 2034a1593db7..dda89afb2917 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -1249,7 +1249,7 @@ static int bcmasp_probe(struct platform_device *pdev)
>  	if (priv->irq <= 0)
>  		return -EINVAL;
>
> -	priv->clk = devm_clk_get_optional_enabled(dev, "sw_asp");
> +	priv->clk = devm_clk_get_optional(dev, "sw_asp");
>  	if (IS_ERR(priv->clk))
>  		return dev_err_probe(dev, PTR_ERR(priv->clk),
>  				     "failed to request clock\n");
> @@ -1277,6 +1277,10 @@ static int bcmasp_probe(struct platform_device *pdev)
>
>  	bcmasp_set_pdata(priv, pdata);
>
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to start clock\n");
> +
>  	/* Enable all clocks to ensure successful probing */
>  	bcmasp_core_clock_set(priv, ASP_CTRL_CLOCK_CTRL_ASP_ALL_DISABLE, 0);
>
> @@ -1288,8 +1292,10 @@ static int bcmasp_probe(struct platform_device *pdev)
>
>  	ret = devm_request_irq(&pdev->dev, priv->irq, bcmasp_isr, 0,
>  			       pdev->name, priv);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to request ASP interrupt: %d", ret);
> +	if (ret) {
> +		dev_err(dev, "Failed to request ASP interrupt: %d", ret);
> +		goto err_clock_disable;
> +	}
>
>  	/* Register mdio child nodes */
>  	of_platform_populate(dev->of_node, bcmasp_mdio_of_match, NULL, dev);
> @@ -1301,13 +1307,17 @@ static int bcmasp_probe(struct platform_device *pdev)
>
>  	priv->mda_filters = devm_kcalloc(dev, priv->num_mda_filters,
>  					 sizeof(*priv->mda_filters), GFP_KERNEL);
> -	if (!priv->mda_filters)
> -		return -ENOMEM;
> +	if (!priv->mda_filters) {
> +		ret = -ENOMEM;
> +		goto err_clock_disable;
> +	}
>
>  	priv->net_filters = devm_kcalloc(dev, priv->num_net_filters,
>  					 sizeof(*priv->net_filters), GFP_KERNEL);
> -	if (!priv->net_filters)
> -		return -ENOMEM;
> +	if (!priv->net_filters) {
> +		ret = -ENOMEM;
> +		goto err_clock_disable;
> +	}
>
>  	bcmasp_core_init_filters(priv);
>
> @@ -1316,7 +1326,8 @@ static int bcmasp_probe(struct platform_device *pdev)
>  	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
>  	if (!ports_node) {
>  		dev_warn(dev, "No ports found\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_clock_disable;
>  	}
>
>  	i = 0;

[ ... ]

> @@ -1358,6 +1369,8 @@ static int bcmasp_probe(struct platform_device *pdev)
>
>  err_cleanup:
>  	bcmasp_remove_intfs(priv);
> +err_clock_disable:
> +	clk_disable_unprepare(priv->clk);
>                  ^^^^

Does this double-disable the clock on the register_netdev() error path?

Looking at bcmasp_probe(), the clock handling sequence is:

    Line 1280: clk_prepare_enable(priv->clk) enables the clock
    Line 1352: clk_disable_unprepare(priv->clk) disables it

Then register_netdev() is called in a loop starting around line 1358.
If register_netdev() fails, it jumps to err_cleanup which falls through
to err_clock_disable and calls clk_disable_unprepare() again.

Since the clock was already disabled at line 1352 before the network
device registration loop, calling clk_disable_unprepare() a second time
in the error path would unbalance the clock reference count.

Should the err_cleanup label return directly without falling through to
err_clock_disable, or should a separate error label be added for paths
after the clock is already disabled?
-- 
pw-bot: cr

