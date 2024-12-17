Return-Path: <netdev+bounces-152563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C0A9F4968
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23934162D16
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B91EC4C6;
	Tue, 17 Dec 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMe6jZ4Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D641E573F
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433128; cv=none; b=JCFhSopzCxj1j1sui3xOKR07Y/gnYLP3Qzss4AL+uI8XLEkBYkEHL8R9E7G0WUQ08vdOOoUsJhJIKk/RKedHozeiyKyeFJHaRIBJPg6KsPDtfDJ7tgQjRMi1wg+52kfmD8tl6bzuXiEbynNQ1QEBOsAyZ1x3zKov14dUOckS2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433128; c=relaxed/simple;
	bh=lCJZwFACueV/abH3Vzl3ufOeTRWW2yeoJAM8Av2WJrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARofNWL5opNjTKZ9IPwEKS+Mo4819axDq5OJFfeDRZhn0LS5xXooa6ccXq244VMX/Q3vA5TAimu/DiLZUl+eKCnvRD7vtZ5Zcq8Sb8aRCBQsa0A2o0GJHZH4dWrBGYTMnvQoMWl0cE703pVLlcfuJwW0QykNmhBGb2e2K2dWxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMe6jZ4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF85C4CED3;
	Tue, 17 Dec 2024 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734433127;
	bh=lCJZwFACueV/abH3Vzl3ufOeTRWW2yeoJAM8Av2WJrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gMe6jZ4ZKH8FJXPSZov2hZPCihwoduf68OmYclDEFp+KEEZgVFFL6zcj8+NPhW1w4
	 pkIXDZwErDewxfS3R3lUHi8mMO4d8VdTC7ETy+SfIFucIiYtPWDfjrqFz9Cdvie7sI
	 r+iwYUZfy1QDMQLnykEU04YRaK7gApTMB2Jrv/v8c0RjL314SKhKR0Ef3m/cqWatQx
	 9FDQS9ShuVKVCXn2F4hLh2UWt2CD4rFLKS35j9ZJbzDGrHZpMXTLj6+kJaXNfRnzRt
	 qSGZSxiayWSK5WHMwG9xye94ffYyIqZ8qEJJ77993HpGMmzvRRFJ/khFSIh5xiU+2L
	 jupLJyyvTGhYQ==
Message-ID: <21d372a2-479a-4ea5-a60a-3693b8f0e8ba@kernel.org>
Date: Tue, 17 Dec 2024 11:58:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: call stmmac_remove_config_dt() in error
 paths in stmmac_probe_config_dt()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org
References: <20241217033243.3144184-1-joe@pf.is.s.u-tokyo.ac.jp>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241217033243.3144184-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2024 04:32, Joe Hattori wrote:
> Current implementation of stmmac_probe_config_dt() does not release the
> OF node reference obtained by of_parse_phandle() when stmmac_dt_phy()
> fails, thus call stmmac_remove_config_dt(). The error_hw_init and
> error_pclk_get labels can be removed as just calling
> stmmac_remove_config_dt() suffices. Also, remove the first argument of
> stmmac_remove_config_dt() as it is not used.
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: 4838a5405028 ("net: stmmac: Fix wrapper drivers not detecting PHY")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 37 +++++++------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 3ac32444e492..4f1a9f7aae6e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -407,13 +407,11 @@ static int stmmac_of_get_mac_mode(struct device_node *np)
>  
>  /**
>   * stmmac_remove_config_dt - undo the effects of stmmac_probe_config_dt()
> - * @pdev: platform_device structure
>   * @plat: driver data platform structure
>   *
>   * Release resources claimed by stmmac_probe_config_dt().
>   */
> -static void stmmac_remove_config_dt(struct platform_device *pdev,
> -				    struct plat_stmmacenet_data *plat)
> +static void stmmac_remove_config_dt(struct plat_stmmacenet_data *plat)
>  {
>  	clk_disable_unprepare(plat->stmmac_clk);
>  	clk_disable_unprepare(plat->pclk);
> @@ -436,7 +434,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_dma_cfg *dma_cfg;
>  	int phy_mode;
> -	void *ret;
>  	int rc;
>  
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> @@ -490,8 +487,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
>  
>  	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
> -	if (rc)
> +	if (rc) {
> +		stmmac_remove_config_dt(plat);
>  		return ERR_PTR(rc);
You now double unprepare the clocks. This is either buggy or just
confusing (assuming clocks are NULL).

Best regards,
Krzysztof

