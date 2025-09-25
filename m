Return-Path: <netdev+bounces-226215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9422B9E21C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA2D34E20FC
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF77278157;
	Thu, 25 Sep 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI3TEtiJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD41277CB8;
	Thu, 25 Sep 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790343; cv=none; b=GIVOjVvKfdQB+38P8bm47j5liirMFta2IjQweYxbIoqtJpLB3OQtW3svoTt1DUDMQyCfqph7PO69ojKnxNqNx/kU96l8eVfAbqcXAIEKBsScRo/uet+i9BsLnrmpZH4vt6p1n7MudUOfj8jMeiiu1uX7EE/r06RwsvLbTpL1fiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790343; c=relaxed/simple;
	bh=y8a31ywg7K1T6phegLTitm+mtrMJPQoBFPEmdBsnRpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaWzLfY6Q0tiryo+22wPmdYRkY5570g7qynnenfl2F44zokudaKLqTtErf5lmUHjoOFXOPaFtbUSc+xsPGH9U4Op6xGgPDjMfOc9al9hnZsmPYC0d2lkqGEi7T/1urRRZD0pN/4b45CQUaP8F8ii9vCcJFDY2peIQhT1ijkRFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI3TEtiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE19C4CEF0;
	Thu, 25 Sep 2025 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790343;
	bh=y8a31ywg7K1T6phegLTitm+mtrMJPQoBFPEmdBsnRpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uI3TEtiJyilkuyqougffYyDZn6T6hDMCzF1LQUi+vKTDcaJfY9T/zT1UH/CLnUatX
	 Yab/gV+xJSb3NEhRIZbwHsF9lByu/mbu30tukXXgBEzrgEObHgtt8AsJ7lmF1ElTsE
	 +RYlj4XeIAnsxu8n6CGTfUDqk5k7C73dwQviB/47eHMEpqtWQTH7S7HI2+Qo6BpDzF
	 Df1E9ekTF2H5vbtqwpmUMA1HQcIp2H8pIadYr5WrzkI7B4cUle+0Mb7VEAZN+7dpKD
	 dr2XAYvAQ8gzNo86oFoaOx6El1HB0cS/mAfkjc3GsWuDqCWd8hxhzEDag+PkYP6ePB
	 l9LBdqsyzReHg==
Date: Thu, 25 Sep 2025 09:52:17 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Harini Katakam <harini.katakam@xilinx.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH net v6 5/5] net: macb: avoid dealing with endianness in
 macb_set_hwaddr()
Message-ID: <20250925085217.GX836419@horms.kernel.org>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
 <20250923-macb-fixes-v6-5-772d655cdeb6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923-macb-fixes-v6-5-772d655cdeb6@bootlin.com>

On Tue, Sep 23, 2025 at 06:00:27PM +0200, Théo Lebrun wrote:
> bp->dev->dev_addr is of type `unsigned char *`. Casting it to a u32
> pointer and dereferencing implies dealing manually with endianness,
> which is error-prone.
> 
> Replace by calls to get_unaligned_le32|le16() helpers.
> 
> This was found using sparse:
>    ⟩ make C=2 drivers/net/ethernet/cadence/macb_main.o
>    warning: incorrect type in assignment (different base types)
>       expected unsigned int [usertype] bottom
>       got restricted __le32 [usertype]
>    warning: incorrect type in assignment (different base types)
>       expected unsigned short [usertype] top
>       got restricted __le16 [usertype]
>    ...
> 
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


