Return-Path: <netdev+bounces-211785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E640B1BB7A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C135A620D9D
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09E0230BFF;
	Tue,  5 Aug 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri6Zp74n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96413222562;
	Tue,  5 Aug 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754426356; cv=none; b=NIbw1mQDVl7O/mmy2G4gxTeU33JQSs3QDHg17KUaS51kh9xG2gaNlX0sEAJ9vydqESMF5LHwSBZsBPYtEP6zqra80SC0XU+HPds42W01+2AFCW6KewjQNmDex02NFqgbogA3BD7a8+L4h9WZxtLElasx5mIPKA2gO6jTDgPQHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754426356; c=relaxed/simple;
	bh=VC9sMCvyq68QKkGDQO5hx+0ig5esATmGOVbDNnZWolQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhNweAGRtXwx0Hv4w8Y2eLlcaVd8eWieOceHaXaVLFhF2XmC3GD4EBQQ6MCPNdoy3pCp7SGIExGR6ri9oPgf1ro2JTUqAPOlQajq457NnnLiFFRwxk7oRv2oAg9/we8HFKrN/+5PbksHX6gSHbAzQGmbSUmU8MYsKhdrj330VgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri6Zp74n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071A7C4CEF0;
	Tue,  5 Aug 2025 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754426356;
	bh=VC9sMCvyq68QKkGDQO5hx+0ig5esATmGOVbDNnZWolQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri6Zp74nT46FUbiLR+aaF791iBqAIektiiglVIX3fe2E/4UfAV9nH0toKROhO/swk
	 GQbqDMw6bDNyW/cMs55U8fZaFdSXVneaKyoeneYYe5OECAXd7YUo2m+lppas/4dfH+
	 lNdFXgn/KCiau605XR1FMYrrxdJdWOu3Z6TS3hhOa6/4JhISFXdtxlHARbe4+AOJrI
	 HCXHFo/wzPdQtzClZ1RhC2Vo9VU3aLXN42leZlVAjhcrqfs/uAARMhlNqqKb5LlpWO
	 3ul5jSm5+E4LEmvvVmgrKk4NYJb+PcvRMYHaUuijNFWOHZVU/vPt3xWwcTAX9bevNw
	 LvNJ6P6LlK0Pw==
Date: Tue, 5 Aug 2025 21:39:12 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next v4 6/7] net: axienet: Rearrange lifetime
 functions
Message-ID: <20250805203912.GE61519@horms.kernel.org>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153456.1313661-7-sean.anderson@linux.dev>

On Tue, Aug 05, 2025 at 11:34:55AM -0400, Sean Anderson wrote:
> Rearrange the lifetime functions (probe, remove, etc.) in preparation
> for the next commit. No functional change intended.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

...

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h

...

>  /**
>   * struct axienet_local - axienet private per device data
>   * @ndev:	Pointer for net_device to which it will be attached.
> @@ -549,6 +572,7 @@ struct skbuf_dma_descriptor {
>  struct axienet_local {
>  	struct net_device *ndev;
>  	struct device *dev;
> +	struct axienet_common *cp;

nit: Please add cp to, and remove axi_clk and regs_start from
     the Kernel doc for this structure.

     Flagged by ./scripts/kernel-doc -none

>  
>  	struct phylink *phylink;
>  	struct phylink_config phylink_config;
> @@ -558,13 +582,11 @@ struct axienet_local {
>  
>  	bool switch_x_sgmii;
>  
> -	struct clk *axi_clk;
>  	struct clk_bulk_data misc_clks[XAE_NUM_MISC_CLOCKS];
>  
>  	struct mii_bus *mii_bus;
>  	u8 mii_clk_div;
>  
> -	resource_size_t regs_start;
>  	void __iomem *regs;
>  	void __iomem *dma_regs;
>  

...

