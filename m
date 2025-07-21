Return-Path: <netdev+bounces-208645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B8B0C7FD
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DA51AA6664
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48CA2DF3F8;
	Mon, 21 Jul 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ScQEEzFe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028872D5A19;
	Mon, 21 Jul 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112879; cv=none; b=HgsW/VmWzQ5zVgVEOGjWoumY+YUsWjZ5z2NL4ki43bBN49DPe5/rbSXVgQgPCc520dtMjEbeg9VEvRy8zK2SCZBA8gJSVP9466CvVUGcmQu1KzPQHan5cI5CuCg1hHUzbUO2rK2ypGmhexs/GDXa/v9AfaFnavYIRpfmvU/WLxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112879; c=relaxed/simple;
	bh=vDdan7DVR29J/sb4vhT0hUMDbwucIugKqzQwkQjGXr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb6lemDkwIA/ePSEoAth7XwuWhTcLgNFyuVXv58QSgAN32MHeCxnQMb5P4t+9tPvhjxR2C2nGQHGGMg8T29SiWApMDP2zsYfoAyFKYNAkw93z8I/0kJ0aq4ZnHWZ8Q5tDdxDieN7Rce3pRSWiqf5DKyBaA/5dab6Egsrqzdx37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ScQEEzFe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eLBSJ9Mu6vUSq4pj9HKgAZiF3QIhRdKUKtFkrANdcsQ=; b=ScQEEzFe+rPUDdgJR1/zypLpfG
	a2gaOTpM1pvMQemSfmETTQvjsdS3FLBaY/udmL8Y4l2bLC6y00p1I41JWmcVchDLWhXpHFgt5H8/3
	FJeIJn1TOn9AxPrwUkeM5bNptNJVhV1JhrCKSlm4Woo3f7G3LeBI8kWhvy4N0K67pAXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udsjN-002NEV-1v; Mon, 21 Jul 2025 17:47:09 +0200
Date: Mon, 21 Jul 2025 17:47:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] net: rnpgbe: Add link up handler
Message-ID: <a77ef7df-537b-49f7-a455-c23295fddbd5@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-13-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-13-dong100@mucse.com>

On Mon, Jul 21, 2025 at 07:32:35PM +0800, Dong Yibo wrote:
> Initialize link status handler
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  53 +++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  26 +++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    |   7 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 139 +++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 187 ++++++++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   7 +
>  7 files changed, 420 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 624e0eec562a..b241740d9cc5 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -26,6 +26,15 @@ enum rnpgbe_hw_type {
>  	rnpgbe_hw_unknow
>  };
>  
> +enum speed_enum {
> +	speed_10,
> +	speed_100,
> +	speed_1000,
> +	speed_10000,
> +	speed_25000,
> +	speed_40000,

Patch 1/X says:

+config MGBE
+       tristate "Mucse(R) 1GbE PCI Express adapters support"
+       depends on PCI
+       select PAGE_POOL
+       help
+         This driver supports Mucse(R) 1GbE PCI Express family of
+         adapters.

This is a 1G NIC, so you can remove 10G, 25G and 40G from there. They
are pointless.

	Andrew

