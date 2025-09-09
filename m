Return-Path: <netdev+bounces-221134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70635B4A74D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CCD3AC4AD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8964280A5F;
	Tue,  9 Sep 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPlCUIu5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6727B345;
	Tue,  9 Sep 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409197; cv=none; b=hUYaYgg8TV8Q58o+E/n/zckWIbjiYwLX21P68GRAlQeKFub0SnY1+8Qx4ztrotZlbh6mIan80GXK1Lyq64qvqllmtV8a7ZuZV7FNj73W/arzAeEiA6VXir4XXNgCLLseXozJ0h4as2axfI2gYVGdqlphojd24gtDBjOUaXy+pv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409197; c=relaxed/simple;
	bh=l9nR5OA2l0BquxS1VXNcftbiidgRx3yDXtiFkpEPyDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca6kGuQ8Mm73iwSxqIpkQ5lXFANQRNYjeP5/+IcN4xBoGjcM8GdJwRNfd0Bat2h9z1T1FKuDKd8DMNrKHYxkJAocMZPiTR/Z5+TvDzm7H2pi1KDWK5trk+JgRiLBsSrmLG4K5b336rs+H9xCm05W+hXNesa3E3LVbfzPI1xhx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPlCUIu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C45AC4CEF4;
	Tue,  9 Sep 2025 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757409197;
	bh=l9nR5OA2l0BquxS1VXNcftbiidgRx3yDXtiFkpEPyDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPlCUIu5rVfOY4zP1jUI2NkXlV73vN+2Pg3p3wxxvyyAhEItdgWfJProLqdTeTOjN
	 Aak60KuKSvf4yyNeMBtavSwsuRfZ8eqe9EPkcujJf5t2Z/5I7BBAFHjPo0GHvdR6rZ
	 Nomy575rCm0TXkjRHj+SLn+as/F8H61Uqj4n6yN7FLaWrpJ3EEgsYKT7V37a2nJr4P
	 aoSo/eTLYw86Vt1LEvPCKBxnu1d1BmADNh7kei/9yYVQdYXuIqpVWDlVEFzzV8qlK8
	 ZHiyUy9MK/45rr0usyp9s+pQ/FLLlqgAB4TR3qTybnn4LZTPF8nBVWtdMbXoC3xE0j
	 PnVZfMhvKP41Q==
Date: Tue, 9 Sep 2025 10:13:13 +0100
From: Simon Horman <horms@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: netdev@vger.kernel.org, Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: make RX page order tunable via module
 param
Message-ID: <20250909091313.GF2015@horms.kernel.org>
References: <tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com>

On Sat, Sep 06, 2025 at 09:54:34PM +0800, Yangyu Chen wrote:
> On systems like AMD Strix Halo with Thunderbolt, RX map/unmap operations
> with IOMMU introduce significant performance overhead, making it difficult
> to achieve line rate with 10G NICs even with TCP over MTU 1500. Using
> higher order pages reduces this overhead, so this parameter is now
> configurable.
> 
> After applying this patch and setting `rxpageorder=3`, testing with QNAP
> QNA-T310G1S on 10G Ethernet (MTU 1500) using `iperf3 -R` on IPv6 achieved
> 9.28Gbps compared to only 2.26Gbps previously.

VerU nice.

> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
> Should we also consider make default AQ_CFG_RX_PAGEORDER to 3?

I have the same question.

...

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> index b24eaa5283fa..48f35fbf9a70 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> @@ -40,6 +40,10 @@ static unsigned int aq_itr_rx;
>  module_param_named(aq_itr_rx, aq_itr_rx, uint, 0644);
>  MODULE_PARM_DESC(aq_itr_rx, "RX interrupt throttle rate");
>  
> +static unsigned int rxpageorder = AQ_CFG_RX_PAGEORDER;
> +module_param_named(rxpageorder, rxpageorder, uint, 0644);
> +MODULE_PARM_DESC(rxpageorder, "RX page order");
> +

Unfortunately adding new module parameters to networking drivers
is strongly discouraged. Can we find another way to address the problem
described in your cover: e.g.

1. Changing the fixed value
2. Somehow making the value auto detected
3. Some other mechanism to allow the user to configure the value, e.g. devlink

...

