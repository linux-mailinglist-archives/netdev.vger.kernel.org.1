Return-Path: <netdev+bounces-230563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CCFBEB22E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AE854EB7DE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2811C84BC;
	Fri, 17 Oct 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mrchkv0b"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990F2A1CF;
	Fri, 17 Oct 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724035; cv=none; b=XQxQohv7nkp+GmX2g14KB7QbZ4pNkgcqTsNQRyIam8iMRZ0D/RZYMMCgBcmK220rsNujo6TrPwMn2NKm64p/gvPxdBMklkUZTBQMpt6n9PM16MaNzBF9Dw31JY/c/jKQ7q4ZypCOFD4raN3vjiLvkvFYi54uRUgLdRhyWxQucNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724035; c=relaxed/simple;
	bh=GZ7v0lVVO4ZixjnVSc9SgJ1rH+QvUcanWIv9AQ5xrxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP0uNhWBBNBVZeeR7GIQk80JTuHm/6jB5/02UXJn7M0LLXSP06HUunixhGF+CmaotFxHUyNY6WNlZuzpgnJG5rEG9TFrXe+Grn4qwVh2LtQNV+CeFYBIp3UI5W+W5ZMnQN/JZlCb6zeyQ9Ip0MHr4Nc+7JzeRdUl6ITCJUAkJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mrchkv0b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=a8e1nHNRNY+fRq9VzrMFLdqyFf97VXcTRyEF3zJS7I0=; b=mr
	chkv0beppn3xXjua1HaNtMpoiS4Mz7tbQX9/zDtbcKUM3m/QOpeEzWzDXS9H+8Ss8Nla456Pl1+hb
	3PJm1IStYj+WRNj48bOZuXq1/SdvzdqkL/qGRKGuFs23XEHfpKF+EFzK7JZvCVpHVjwXvlox/4RXf
	kUd5U/lPjOhbveg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9oka-00BJTC-W6; Fri, 17 Oct 2025 20:00:24 +0200
Date: Fri, 17 Oct 2025 20:00:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 07/15] net: macb: simplify
 macb_adj_dma_desc_idx()
Message-ID: <3a36ff13-893d-429f-b46e-ade24836d27a@lunn.ch>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
 <20251014-macb-cleanup-v1-7-31cd266e22cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-macb-cleanup-v1-7-31cd266e22cd@bootlin.com>

On Tue, Oct 14, 2025 at 05:25:08PM +0200, Théo Lebrun wrote:
> The function body uses a switch statement on bp->hw_dma_cap and handles
> its four possible values: 0, is_64b, is_ptp, is_64b && is_ptp.
> 
> Instead, refactor by noticing that the return value is:
>    desc_size * MULT
> with MULT = 3 if is_64b && is_ptp,
>             2 if is_64b || is_ptp,
>             1 otherwise.
> 
> MULT can be expressed as:
>    1 + is_64b + is_ptp
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 7f74e280a3351ee7f961ff5ecd9550470b2e68eb..44a411662786ca4f309d6f9389b0d36819fc40ad 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -136,19 +136,13 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
>  static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
>  {
>  #ifdef MACB_EXT_DESC
> -	switch (bp->hw_dma_cap) {
> -	case HW_DMA_CAP_64B:
> -	case HW_DMA_CAP_PTP:
> -		desc_idx <<= 1;
> -		break;
> -	case HW_DMA_CAP_64B_PTP:

I _think_ this makes HW_DMA_CAP_64B_PTP unused and it can be removed?

  Andrew

