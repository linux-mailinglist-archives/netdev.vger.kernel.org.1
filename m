Return-Path: <netdev+bounces-271932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN1PKkjvxGnv5AQAu9opvQ
	(envelope-from <netdev+bounces-271932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:33:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9BC331679
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA6A430054E3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945C366072;
	Thu, 26 Mar 2026 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5RLwB4m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634128506A;
	Thu, 26 Mar 2026 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513974; cv=none; b=JZN+kJsrx2euEZDdzzfkdRKObrIisZD6DVd60NQ75C51+Rb4w9VRBYuQGCK3YSKyP4Pvs6hpgcxaoLUF6dhaoIBEpNb0LTMFn0ZTDT58+wtfYXHJYCkKN3Y1rCLWBD+KIR2Cm7mhxAGubTN9mdiAbdtyrg7fUiU0YhzBNhdLTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513974; c=relaxed/simple;
	bh=7N6DCs6w4lwaNrc8nplqZYAKIoynQ0BIoe3R98tHZo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHUOqRPNeFRt+rA04MggF6nQUCkYxNSJOwq8hRi8IvSn+zTg50HtYh4WgncN2u1oxMzOtxNRamBghqlZ6ngVmvGUHC2dfgtAN9uzvfs3j41QxSq+2jVCyjVAWeWw8cHMl1mZ8CNtgaP2TQyj8Iv7FWuNC8pJ3rsvrSZxXiB0W5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5RLwB4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADF8C19423;
	Thu, 26 Mar 2026 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774513974;
	bh=7N6DCs6w4lwaNrc8nplqZYAKIoynQ0BIoe3R98tHZo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5RLwB4mhSjAIbIkojluWbsyoV5NJ8KnCXPIRLdGJowWFWZ6zi8iN0C2sWJ+/IENT
	 64ZGKgjnh3Q0D2BYQJ0gHui4P4WPjnPXb9I97NqAqsmF6/Gxjy/R6CABPzFucg6tZk
	 ObGqjd1m9KFjITbk+Fuc1DcbKtGYTBBD/SE+DXiuD+7JrSs3b760mCaljM0lTOQqj4
	 h8Way9dg8eOJohLIp4ss+wFBKvOeUrdXX7aUioOxzS0ND39ZHBjl+7O7Rur8psRVAG
	 CpoDqH06ONCM565L+wa204itAZx3kYLOsitmc35115imWAuNGSiKDlzAWEIUZGg482
	 co2W62RVQRMiw==
Date: Thu, 26 Mar 2026 09:32:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH V3 1/3] net: stmmac: Fix PTP ref clock for Tegra234
Message-ID: <20260326-gigantic-tentacled-hornet-cbdb8d@quoll>
References: <20260325135811.148480-1-jonathanh@nvidia.com>
 <20260325135811.148480-2-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325135811.148480-2-jonathanh@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D9BC331679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 01:58:09PM +0000, Jon Hunter wrote:
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
> 'ptp-ref' if 'ptp_ref' is not found.
> 
> Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> index b4b39e6a169e..ec18ee46889f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> @@ -9,7 +9,7 @@
>  #include "stmmac_platform.h"
>  
>  static const char *const mgbe_clks[] = {
> -	"rx-pcs", "tx", "tx-pcs", "mac-divider", "mac", "mgbe", "ptp-ref", "mac"
> +	"rx-pcs", "tx", "tx-pcs", "mac-divider", "mac", "mgbe", "ptp_ref", "mac"
>  };
>  
>  struct tegra_mgbe {
> @@ -216,6 +216,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_resources res;
>  	struct tegra_mgbe *mgbe;
> +	bool use_legacy_ptp;
>  	int irq, err, i;
>  	u32 value;
>  
> @@ -257,9 +258,23 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
>  	if (!mgbe->clks)
>  		return -ENOMEM;
>  
> -	for (i = 0; i <  ARRAY_SIZE(mgbe_clks); i++)
> +	/*
> +	 * Older device-trees use 'ptp-ref' rather than 'ptp_ref'.
> +	 * Fall back to the legacy name when 'ptp_ref' is absent.
> +	 */
> +	use_legacy_ptp = of_property_match_string(pdev->dev.of_node,
> +						  "clock-names", "ptp_ref") < 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(mgbe_clks); i++) {
>  		mgbe->clks[i].id = mgbe_clks[i];
>  
> +		if (use_legacy_ptp && !strcmp(mgbe_clks[i], "ptp_ref")) {

Why index 0 is not valid? And why -EINVAL would be considered as legacy
clock present?

> +			dev_warn(mgbe->dev,
> +				 "Device-tree update needed for PTP clock!\n");
> +			mgbe->clks[i].id = "ptp-ref";

Best regards,
Krzysztof


