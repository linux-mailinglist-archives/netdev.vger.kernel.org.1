Return-Path: <netdev+bounces-182766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7630A89DE6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52E7189F599
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4752973B3;
	Tue, 15 Apr 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qWSdu+Gr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576F2973B4;
	Tue, 15 Apr 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719746; cv=none; b=CwyCUocmadJxj7q6CyxeyV+PkCp3tz7hjSz535v9tfOr1seXjzI+kwv0USoL3kKhq1TwlJFBZseI2WV1WIvM5g6mNLdbF0UxsnQII0hvfRgzKXCX0ASrCshxR/iOa/TJWBfngyv2q3yqLTlqsxkihnSmInwpP8ZFzjHTsiBP864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719746; c=relaxed/simple;
	bh=P69d4t3uTzEaL8pixI08c4ueZR4A84sPyfjBKO4liU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezag/NCgauku05Sk7YM2AW4gz3ozdcwTAiba2vcYN87TBlnpuS8M3GmWRqkOhNvujzmeOQ7YQL2xH6AQdx+FlU/hk0Kf9l+Ww8cn8+kXg0LPXyFCSGWPe7AhWW8kLDvXcsDfRwmQBqcpt9StrY1Llp4G32ISmJXnf6/2S5auoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qWSdu+Gr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y8lpbTPAkY0NkhqZrI9H7LIS4Glm8nL74Un5yAiDLec=; b=qWSdu+Grn0OHVEsBLXaUgdSsH5
	Zcz/jdVJAHgF6SdZ+fyR55ehTFeFWOXvn+mbxRTvpWmJ5zV24QDixY9I+v6x67Z1S3wG4y2XBwmSJ
	oz/BiFL2pi+cd+2vpQ9eoYj8OvEgmpPNks4tHnm5H+EIjdeE8oikuedEPwt+bIOfLpm8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4fIm-009Qup-6J; Tue, 15 Apr 2025 14:22:08 +0200
Date: Tue, 15 Apr 2025 14:22:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chris.chenfeiyang@gmail.com>,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biao Dong <dongbiao@loongson.cn>,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: Re: [PATCH net-next 1/3] net: stmmac: dwmac-loongson: Move queue
 number init to common function
Message-ID: <62da41f9-2891-4c63-94b4-83230cd7ddae@lunn.ch>
References: <20250415071128.3774235-1-chenhuacai@loongson.cn>
 <20250415071128.3774235-2-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415071128.3774235-2-chenhuacai@loongson.cn>

On Tue, Apr 15, 2025 at 03:11:26PM +0800, Huacai Chen wrote:
> Currently, the tx and rx queue number initialization is duplicated in
> loongson_gmac_data() and loongson_gnet_data(), so move it to the common
> function loongson_default_data().
> 
> This is a preparation for later patches.
> 
> Tested-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 39 +++++--------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 1a93787056a7..f5fdef56da2c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -83,6 +83,9 @@ struct stmmac_pci_info {
>  static void loongson_default_data(struct pci_dev *pdev,
>  				  struct plat_stmmacenet_data *plat)
>  {
> +	int i;
> +	struct loongson_data *ld = plat->bsp_priv;

Reverse Christmas tree please. Longest first, shortest last.

    Andrew

---
pw-bot: cr


