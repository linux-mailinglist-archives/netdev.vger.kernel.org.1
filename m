Return-Path: <netdev+bounces-275102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCIkBAnbz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC6395BBA
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D8CA3009576
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583723C73F3;
	Fri,  3 Apr 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mle45kw2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FCF3C6A43;
	Fri,  3 Apr 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229423; cv=none; b=POs27y26DxWQvX7NnRYvCswEiSSbB3v5jeyq51ujrPntbaKKSaYbeJEeuEsWOW4ghjQhwELqu1Vv18gkgIwgL1MNbpp98PrOq8rZ75Gazq4u4GKGsu5wRr1GBu2rynaLoLfXX03EWeQsFdC2OSxaWmcnyVKd+rp1C1wdsi/fHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229423; c=relaxed/simple;
	bh=1QQFvoKpB2XfX6yKZk+AT0LvHS6NlKPqN9M6hnJ43Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA4qCMqkPurCdiyU6jYAdo+jiuoDcukzOoRZuumjN9LnRbPoAbuIY1dmldWLUsn9KEKHpe0SUSr4CBTZMe7YeezJtD2sx1O+DS1f7LXLbNnec7X98C5Xm+CwN06FB1XjjlD7Ck3fDxb2XYyObli1r1bS9cJ3i9t6v3BNvBkc8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mle45kw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B5C4CEF7;
	Fri,  3 Apr 2026 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775229423;
	bh=1QQFvoKpB2XfX6yKZk+AT0LvHS6NlKPqN9M6hnJ43Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mle45kw2ZXDtkpPYYWnrA5tWz+iaxFnJTA8l99IFfQxYhs4OACwmfnxPrrGTHeo0q
	 GPKleLrXkmSbi3NHtH5laYXPKS1xTqzy+WhtLr21b36imt7mTiYG2Vjd6BrPHpiQ7u
	 8CPTjg+/LIKDhZ279mvghiILU+CFWmMAykyhGnwYiRK1iHp/7n0jx7G3AMqpTO4Sy/
	 MvyTRuSm1O6CrLtwEPsLjWTYXe3b8aZXwaZ6G+fGlLzEOoltnFoBgn/TNlbX/AFnyA
	 yEJNYmDAww6n6Wcphl3qWVoLsxkcxhWz/TuEr3c+IimHUF61FWYo0QN8RH5RA7irkY
	 s2VvE2MP2Pm5w==
Date: Fri, 3 Apr 2026 16:16:58 +0100
From: Simon Horman <horms@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V4 1/3] net: stmmac: Fix PTP ref clock for Tegra234
Message-ID: <20260403151658.GJ113102@horms.kernel.org>
References: <20260401102941.17466-1-jonathanh@nvidia.com>
 <20260401102941.17466-2-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401102941.17466-2-jonathanh@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 6CDC6395BBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 11:29:39AM +0100, Jon Hunter wrote:
> Since commit 030ce919e114 ("net: stmmac: make sure that ptp_rate is not
> 0 before configuring timestamping") was added the following error is
> observed on Tegra234:
> 
>  ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
>  WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
> 
> It turns out that the Tegra234 device-tree binding defines the PTP ref
> clock name as 'ptp-ref' and not 'ptp_ref' and the above commit now
> exposes this and that the PTP clock is not configured correctly.
> 
> In order to update device-tree to use the correct 'ptp_ref' name, update
> the Tegra MGBE driver to use 'ptp_ref' by default and fallback to using
> 'ptp-ref' if this clock name is present.
> 
> Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

The nit below notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> index b4b39e6a169e..3af2f001fada 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c

...

> @@ -216,6 +216,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_resources res;
>  	struct tegra_mgbe *mgbe;
> +	bool use_legacy_ptp = false;
>  	int irq, err, i;
>  	u32 value;
>  

nit: As this is Networking code, please retain reverse xmas tree order --
     longest line to shortest -- for local variable declarations.

...

