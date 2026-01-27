Return-Path: <netdev+bounces-253634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M15Ap4JeGk2ngEAu9opvQ
	(envelope-from <netdev+bounces-253634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:41:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 960948E830
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C79DC30067A5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969931D63E4;
	Tue, 27 Jan 2026 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0wLd03M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB642AA6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769474457; cv=none; b=JRWPyWRwRAnfI0uh/nHoCLsIpKdIO62TsftKsPLfUKj/nRcNQa1WeVU9rf3CRczZkRx7526/3sBTZm551wUQJF+Hfe3/Hfpc8gR9BrRLxsw9ONbGA9RMRwCNudEWrXRNRQj8S8H7j6t0HSec/L/uW+0K+Xio7rZ7MpyCPhmJaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769474457; c=relaxed/simple;
	bh=FDSZmApZTKLD7bqxE5fcK4gRn51ugRSvMR/vvQBFnWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAKnH3Ew+MKEmrov4agXyFU4vQGlaCrzNqXOdRSQloszrksb6XeBcmkQ8jdJnPXVF/4+sYBD3ZxA+LKeKCllf77prXRzXukNGDYYf97ahSkWuZwBNiXUwYaNqPDQJtP/UxHO+/ofVHx1cTIWx+wHefFdGDka0zff2bnXdL2zQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0wLd03M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DAAC116C6;
	Tue, 27 Jan 2026 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769474457;
	bh=FDSZmApZTKLD7bqxE5fcK4gRn51ugRSvMR/vvQBFnWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0wLd03Mgtol6WxGBhARowmEdA89LnFc0PHMRjf8qlNgKYXb3eMpsPBlZ6e8XwYFO
	 IvqM5UDxe219kUeXSOmepN2HI5MdrL8eCwcI39U5MVHLAkzG/i7anAzgFwa1B700vL
	 3/6zDrsLrTcefDf+bVuFrLUMHiZDSmeJD7f8a7hPMiMiTsPoUqHJ+ObOAFYCJr3pB9
	 vEwEG5akak2+X/ZL91NSPlvDlJ0vWLfNu3EEGO60iu0ML26kuBTQGADJzuanY7iMLK
	 ULRUV/f1CU8SwwzhAI0a24zyuKKJvlFxjx9nFVHQ7HwDvC/ycIyfTqfhvBXgjnz8xT
	 YMfhBE8PvdVHg==
From: Jakub Kicinski <kuba@kernel.org>
To: rmk+kernel@armlinux.org.uk
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	linux-rockchip@lists.infradead.org,
	heiko@sntech.de,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com
Subject: Re: [net-next,v2,06/22] net: stmmac: rk: add SoC specific ->init() method
Date: Mon, 26 Jan 2026 16:40:20 -0800
Message-ID: <20260127004020.3785641-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
References: <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 960948E830
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: add SoC specific ->init() method

This commit adds infrastructure for SoC-specific initialization by adding
an init callback to rk_gmac_ops and calling it from rk_gmac_setup().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 7f8ffd1549bc..4117f6863ff0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1618,6 +1619,14 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
>
>  	bsp_priv->dev = dev;
>
> +	if (ops->init) {
> +		ret = ops->init(bsp_priv);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "failed to init BSP\n");
> +			return ERR_PTR(ret);
                        ^^^^^^^^^^^^^^^

If ops->init() fails here, does bsp_priv->phy_reset need to be released?

Earlier in rk_gmac_setup(), at line 1610, the code calls:

    bsp_priv->phy_reset = of_reset_control_get(plat->phy_node, NULL);

of_reset_control_get() is not a devm-managed function, so the reset control
would need to be explicitly released with reset_control_put() on error paths.

This new error return happens after phy_reset could have been acquired (when
the device has an integrated PHY), but before the function successfully
returns. If this path is taken, it appears the reset control would be leaked.

Currently no SoC sets ops->init so this path cannot trigger, but when a
future SoC implements this callback, the leak would occur on init failure
for devices with integrated PHYs.

> +		}
> +	}
> +
>  	return bsp_priv;
>  }

