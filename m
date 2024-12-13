Return-Path: <netdev+bounces-151694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08A9F0A24
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A71613BA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BB1C3BE5;
	Fri, 13 Dec 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENFT7XmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCF1C07F1
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087312; cv=none; b=Abs5Ak77la7XPl58t+XvpOwHRtHh1+TFW0ryCyDGHbD4L+OKQDd6IKzYvKC6a+cSn0OVMJFb47eLHnb8kd9lOfkVYy5RcX9lAaQDroNHUYsZcxoyufBVBq3iILBNiYXtNvvK7L3VG1sUalLy8DH1pTJDADRXEAlHZzTfjVSUJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087312; c=relaxed/simple;
	bh=H8/pe6yhJTfI2YXbuijDF/ou2ieErSDWlORL7DNZVnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N45cuTlc9C1mawI254Eu1A0Zo6XLk3+bNSITKt30wNYXwxukuE00lOL84blSm7JgMTyAADxLJTVhi7yvqJi+Hz7mtFxGbsEGIfbmv7lz+IALQskc66wMHB8bla9otVYkC+/jkWbGyYUIH2raQQBkwNLO2BdvtVx4q9YkvCWzQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENFT7XmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB1DC4CED0;
	Fri, 13 Dec 2024 10:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734087312;
	bh=H8/pe6yhJTfI2YXbuijDF/ou2ieErSDWlORL7DNZVnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENFT7XmJSAzTvYpG08V2koHhezpgni3hM11qxthUKWhV6AGixO1OeDwGADlGbiYUG
	 fTX6K4vLB49xDSy4NjvMbu9lWO4GD3Jt7d1aYM2VmzvhohwcHqY/AHuLzKw3rIUyc6
	 wBK7Lg6J8YM1bYP0qY+N2Wyr7YLLAyzpyAOuKS70sFLf5+DbMDHs/r0Z4NRDgH/wvS
	 hb6gBPNvwsjJeVOQVR5vfQmWQ8QMcT4+X9ZtMvUxkdBACLt8Kgkz9lyTj6JjOBJ0Jq
	 JM9kqEMETdcNjvQjVBDp/P9GDDx1OUjnfeUzXcyNZ5ShGGvRu8/2/eDN/+gp0l9G2I
	 POABbnKbgtrYA==
Date: Fri, 13 Dec 2024 10:55:08 +0000
From: Simon Horman <horms@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: rafal@milecki.pl, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: bgmac-platform: fix an OF node reference
 leak
Message-ID: <20241213105508.GL2110@kernel.org>
References: <20241212023256.3453396-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212023256.3453396-1-joe@pf.is.s.u-tokyo.ac.jp>

On Thu, Dec 12, 2024 at 11:32:56AM +0900, Joe Hattori wrote:
> The OF node obtained by of_parse_phandle() is not freed. Define a
> device node with __free(device_node) to fix the leak.
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: 1676aba5ef7e ("net: ethernet: bgmac: device tree phy enablement")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/net/ethernet/broadcom/bgmac-platform.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
> index ecce23cecbea..ca07a6d26590 100644
> --- a/drivers/net/ethernet/broadcom/bgmac-platform.c
> +++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
> @@ -236,7 +236,10 @@ static int bgmac_probe(struct platform_device *pdev)
>  	bgmac->cco_ctl_maskset = platform_bgmac_cco_ctl_maskset;
>  	bgmac->get_bus_clock = platform_bgmac_get_bus_clock;
>  	bgmac->cmn_maskset32 = platform_bgmac_cmn_maskset32;
> -	if (of_parse_phandle(np, "phy-handle", 0)) {
> +
> +	struct device_node *phy_node __free(device_node) =
> +		of_parse_phandle(np, "phy-handle", 0);
> +	if (phy_node) {
>  		bgmac->phy_connect = platform_phy_connect;
>  	} else {
>  		bgmac->phy_connect = bgmac_phy_connect_direct;

Hi Joe,

I agree this is a problem and that it was introduced by the
cited commit. But I wonder if we can consider a different approach.

I would suggest that rather than using __free the node is explicitly
released. Something like this (untested):

	struct device_node *phy_node;

	...

	phy_node = of_parse_phandle(np, "phy-handle", 0);
	if (phy_node) {
		of_node_put(phy_node);
		bgmac->phy_connect = platform_phy_connect;
	} ...

That is, assuming that it is safe to release phy_node so early.
If not, some adjustment should be made to when of_node_put()
is called.

This is for several reasons;

1. I could be wrong, but I believe your patch kfree's phy_node,
   but my understanding is that correct operation is to call
   of_node_put().

2. More importantly, there is a preference in Newkorking code
   not to use __free and similar constructs.

     "Low level cleanup constructs (such as __free()) can be used when
      building APIs and helpers, especially scoped iterators. However,
      direct use of __free() within networking core and drivers is
      discouraged. Similar guidance applies to declaring variables
      mid-function.

     Link: https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

3. As per the end of the quote above, there is a preference to declare all
   local variables at the top of the function (ideally, in reverse xmas
   tree order [*})

   [*] https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

-- 
pw-bot: changes-requested

