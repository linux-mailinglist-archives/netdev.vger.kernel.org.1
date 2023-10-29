Return-Path: <netdev+bounces-45088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C47DADAF
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 19:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95711C20920
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1628F9;
	Sun, 29 Oct 2023 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xCEHKitO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15425D50B;
	Sun, 29 Oct 2023 18:36:06 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70077BA;
	Sun, 29 Oct 2023 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GzMGu35xyfC7Z+Ts/F/Zrka9AWLhYbUKFwPcZiwOZbg=; b=xCEHKitOSU6kliyAFp290mh36S
	QpvEMSvva6z8wSEULh/sNw20ERKEwt14pvcwElHOycX3MfrPD93mhqMfE1hxc7FCPMo5aK+/Jxa3i
	kF18CdqHynNDGJaI+tC+2uC5WvnAUs3FBaArrJYaqi7a/+UmVkpHTsNn/nqdJBaT5AL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qxAdL-000SPf-2P; Sun, 29 Oct 2023 19:35:35 +0100
Date: Sun, 29 Oct 2023 19:35:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v2 08/12] riscv: dts: starfive: Add pool for coherent DMA
 memory on JH7100 boards
Message-ID: <9b8c9846-20be-4cfa-aff5-f9ae8ac2aba4@lunn.ch>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-9-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029042712.520010-9-cristian.ciocaltea@collabora.com>

On Sun, Oct 29, 2023 at 06:27:08AM +0200, Cristian Ciocaltea wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> 
> The StarFive JH7100 SoC has non-coherent device DMAs, but most drivers
> expect to be able to allocate coherent memory for DMA descriptors and
> such. However on the JH7100 DDR memory appears twice in the physical
> memory map, once cached and once uncached:
> 
>   0x00_8000_0000 - 0x08_7fff_ffff : Off chip DDR memory, cached
>   0x10_0000_0000 - 0x17_ffff_ffff : Off chip DDR memory, uncached
> 
> To use this uncached region we create a global DMA memory pool there and
> reserve the corresponding area in the cached region.
> 
> However the uncached region is fully above the 32bit address limit, so add
> a dma-ranges map so the DMA address used for peripherals is still in the
> regular cached region below the limit.
> 
> Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> index b93ce351a90f..504c73f01f14 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -39,6 +39,30 @@ led-ack {
>  			label = "ack";
>  		};
>  	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dma-reserved {
> +			reg = <0x0 0xfa000000 0x0 0x1000000>;

If i'm reading this correctly, this is at the top of the first 4G of
RAM. But this is jh7100-common.dtsi. Is it guaranteed that all boards
derived from this have at least 4G? What happens is a board only has
2G?

It might also be worth putting a comment here about the memory being
mapped twice. In the ARM world that would be illegal, so its maybe not
seen that often. Yes, the commit message explains that, but when i
look at the code on its own, it is less obvious.

> +			no-map;
> +		};
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10 0x7a000000 0x0 0x1000000>;
> +			no-map;
> +			linux,dma-default;
> +		};
> +	};

