Return-Path: <netdev+bounces-203658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16585AF6AC0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8961C2715E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 06:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B78F29293D;
	Thu,  3 Jul 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="SB08K3Up"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF5157A72;
	Thu,  3 Jul 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751525398; cv=pass; b=r4lmWI4wVdtx57mLZ74DI0bSS2yc7A1mWlP8srFYl2lOhe0iT0psFJ+OwYHHNAbUx7ZqpCpfjOVGYKZceMzjHR8Uaf03ldkKf9LJN9YsCVh5u9gn9IlXnEuzOhNNjNW7TNRjML1OTFk0La4pB7PKjaQF4tMDsPRlT/GuiiP7E1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751525398; c=relaxed/simple;
	bh=CZQd9iOOxuAR4GYOSoR4dRo+S6LB4QgGgQrm5oC59Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aP/g81qMKdYkiWgO29nG6PWEaoGnjxVdMWrFSqOGPQzUiO/ju8JfowlBt0wC2MP+1VeurpgQs/E1LddmFEnsF8TV94yENbmoYTvN5yhjg7j3IRN/4ax1uy4qSzRdK20I5gsF0U1BN0ixfVNdQHLkjhI8pwXsojrFXj/q/hysIWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=SB08K3Up; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1751525332; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mD8uUny1XYdpWeQP6SVaqolbEt3RDJk6TvOGlAxAVadzbU58ua9UfPewBALDrj9LYp7jYGK1+PDyQTEt18mkEMKhNXJKrTSXJHsjdFe0gSdCH563YyLSeocKbSHgcSdg+PB38ZTlCGQat5ox6UxRlDvsGNKq9840PPfmH+k3cQY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751525332; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JHSQpMjUPCAOTe05SvkTtkx5uWkYFZS0xHWecOXz3R4=; 
	b=iXQOgr+YJdkGpSD4cOaIkMRqrM7MVn7EjI+s8IgbNXDk3oc3E2jImPpM7zP66LansiUnvJ22x+0pQBhf7+rRMoA0NTKtaut2QVNS8hk2e4L1VvFa3C2NcJE7AtwmPy1JEb/PaYd1iDT+kp3y59MhwTWihrr45fqVq4/hXiZedLw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751525332;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JHSQpMjUPCAOTe05SvkTtkx5uWkYFZS0xHWecOXz3R4=;
	b=SB08K3UpsvQeF1hLVykmZ5rpp7nw7Io/5oOUFGLAyhb5sqp5oIF8BpXHxGS42wWf
	pTZS5fB+YK0aauSLEzaKS8xYdDrcU9wqgZESra8Y7iUPB1E5OrWxjE2YxTbKjtIA/Gy
	UJND0pWB0MXSctpwf236kTpk5St/yU7YfyTI80KM=
Received: by mx.zohomail.com with SMTPS id 1751525328226725.9805381687908;
	Wed, 2 Jul 2025 23:48:48 -0700 (PDT)
Message-ID: <a2284afb-ee61-457e-aaa8-49a9ce3838f9@pigmoral.tech>
Date: Thu, 3 Jul 2025 14:48:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] riscv: dts: spacemit: Add Ethernet
 support for Jupiter
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn>
 <20250702-net-k1-emac-v3-5-882dc55404f3@iscas.ac.cn>
From: Junhui Liu <junhui.liu@pigmoral.tech>
In-Reply-To: <20250702-net-k1-emac-v3-5-882dc55404f3@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Vivian,
Thanks for you work!

On 2025/7/2 14:01, Vivian Wang wrote:
> Milk-V Jupiter uses an RGMII PHY for each port and uses GPIO for PHY
> reset.
>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Successfully tested with iperf3 on Milk-V Jupiter.

TCP Rx: 941 Mbits/sec
TCP Tx: 943 Mbits/sec
UDP Rx: 956 Mbits/sec
UDP Tx: 956 Mbits/sec

Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>

> ---
>   arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts | 46 +++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
> index 4483192141049caa201c093fb206b6134a064f42..c5933555c06b66f40e61fe2b9c159ba0770c2fa1 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
> @@ -20,6 +20,52 @@ chosen {
>   	};
>   };
>   
> +&eth0 {
> +	phy-handle = <&rgmii0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_cfg>;
> +	rx-internal-delay-ps = <0>;
> +	tx-internal-delay-ps = <0>;
> +	status = "okay";
> +
> +	mdio-bus {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;
> +
> +		reset-gpios = <&gpio K1_GPIO(110) GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <10000>;
> +		reset-post-delay-us = <100000>;
> +
> +		rgmii0: phy@1 {
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
> +&eth1 {
> +	phy-handle = <&rgmii1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_cfg>;
> +	rx-internal-delay-ps = <0>;
> +	tx-internal-delay-ps = <250>;
> +	status = "okay";
> +
> +	mdio-bus {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;
> +
> +		reset-gpios = <&gpio K1_GPIO(115) GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <10000>;
> +		reset-post-delay-us = <100000>;
> +
> +		rgmii1: phy@1 {
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
>   &uart0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart0_2_cfg>;
>
-- 
Best regards,
Junhui Liu

