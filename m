Return-Path: <netdev+bounces-200150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BECAE36C3
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DC13A4526
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF71F5617;
	Mon, 23 Jun 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RM91PLVd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3191EFF9F;
	Mon, 23 Jun 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663619; cv=none; b=DMRVhi+rJjr7OX5rhxKlO+JVF7QHhtKQBGBJaze7pFe+jsy/fBPHu7SdZ11OMn+CqLrtG/Fm8Ha/Zz3mYmZ+Xa+R035o7AMQYngyTtpc6ShXyuQPOkFYpcN1rQDjT71sVYFacfwElyVcX8HxHwzIID1DHMs+0u5P/LcQTe3LYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663619; c=relaxed/simple;
	bh=PrmiFlnUXWUSiWNTv2xaiY/o4S3vaZe/dqM1S2sZKv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGu9D0EGYsAil+iRZf95d6/bIQe7B1ioSQTWiH2MsAHr5VFC+ndhedqPAM3X0EgoqE986QkZWuMsAoGqf++mfPpFxN+b4vBLPrXJI9mHtgecCQhDoRyyIqZ0t25JO8sgp0jPzyFl18+489fYHgtrhmHs/c31Xoo+g+Bi+gZuPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RM91PLVd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j5uT5DWaYtpQ2U6usaprpgbgjh4e7uOTUA89hl1Rr7I=; b=RM91PLVd+vFdJAn3Amhhq9fLnp
	78a0HZ43BM06fd7yO6f7errbSVBB/F89x+pLm80wcJJ7vAcTafJfay8RxIN8snu5DaYDpXQp/yveI
	33pQFPD9vdU2NyT8x/9cUNgGI0JffYC76/fMqIz88BHR9qFKF7VJTIPNgxWNTz770UPA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTbZj-00GfK8-Gc; Mon, 23 Jun 2025 09:26:43 +0200
Date: Mon, 23 Jun 2025 09:26:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC v2 4/4] riscv: dts: sophgo: Add ethernet
 configuration for Huashan Pi
Message-ID: <bd1485c7-e6c3-4360-8e3c-e584ea0b8040@lunn.ch>
References: <20250623003049.574821-1-inochiama@gmail.com>
 <20250623003049.574821-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623003049.574821-5-inochiama@gmail.com>

On Mon, Jun 23, 2025 at 08:30:46AM +0800, Inochi Amaoto wrote:
> Add configuration for ethernet controller on Huashan Pi.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> index 26b57e15adc1..86f76159c304 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> @@ -55,6 +55,16 @@ &emmc {
>  	non-removable;
>  };
>  
> +&gmac0 {
> +	status = "okay";
> +	phy-handle = <&internal_ephy>;
> +	phy-mode = "internal";
> +};

Since the PHY is internal, it should be part of the SoC .dtsi file,
same as any other peripheral. The board .dts file can then enable it.

    Andrew

---
pw-bot: cr

