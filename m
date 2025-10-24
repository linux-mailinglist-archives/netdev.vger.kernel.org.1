Return-Path: <netdev+bounces-232398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB37C054AF
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F5358C4D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1E308F05;
	Fri, 24 Oct 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="TEU/zPnV"
X-Original-To: netdev@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD557207A22;
	Fri, 24 Oct 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297504; cv=none; b=ai1GPf5eDwb3QPP3OcyVFXPEtIL8MneLf0ykewhpO3ZitaSIwZC7LpEA7VCt9sHUmborVto+sSDo+o/aoXRZpbh3AeEbj06Zdhxlu+jdaHdc4oqtHBMaxTGFVDejZiMiGLMbHWLbmMZ7Ma7yxPJnVlhMOHEbnkHJykiCKJhlxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297504; c=relaxed/simple;
	bh=xm7c8Dsw8MPyPqb+dOrtvNJgMqUCK4R9KEOlRL24vJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYqYKyxjVwAosZM73ryzawnR7efUpOCzKfksSJyJfjm36xREM6FuSthzCfPBcnqJ/Qz27xT+pgnG/QyakHSMaL/Yr8lOzCAW/t76QIYw9Dj824E3N/eaEjQp5I2BaO0CjfkXr/dox4x+XWVg0EmvuJifi9VdxJnhZ4IIJdoc0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=TEU/zPnV; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 438A714894D0;
	Fri, 24 Oct 2025 11:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1761297493; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ckwd49jYJbZJlSP55GshI+aFNobeJwdz0Kh7cY8e4GE=;
	b=TEU/zPnV4c8AEBQz3MYoLSoN10mHgvhAEYUSFXvLwHE8dIxLF7KDDY67si78n/UFfDcgdj
	AALhGtb0kKPBZ6qJkiyy9loEmLvd5pgXvM1l8ZJGvsgwgLv5anadMYgvLxOcVv82VxNuFr
	C27y5PEZucslpDMLOvSaexj9e4G7F1USgzEQNIgV2K5QkQEiUlwok7c/3UKXO78HQJiiIf
	AGojkwl5qJuO1hvFD4N0jTSVxFT4K7+tOHMERjkLY4JDpbJibZYwetgHSA4kfu0nCl0r8n
	AcNRZG5oc9XpPrBqeSLM9CVp7wWVXNoFx342VUCX/zgHZ3W5yMJjJGHYJzO/Ow==
Date: Fri, 24 Oct 2025 11:18:03 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH 2/8] arm64: dts: imx8dxl-ss-conn: swap interrupts number
 of eqos
Message-ID: <20251024-backhand-disallow-75be98bbeea3@thorsis.com>
Mail-Followup-To: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Josua Mayer <josua@solid-run.com>
References: <20251022-dxl_dts-v1-0-8159dfdef8c5@nxp.com>
 <20251022-dxl_dts-v1-2-8159dfdef8c5@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-dxl_dts-v1-2-8159dfdef8c5@nxp.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Frank,

Am Wed, Oct 22, 2025 at 12:50:22PM -0400 schrieb Frank Li:
> Swap interrupt numbers of eqos because the below commit just swap
> interrupt-names and missed swap interrupts also.
> 
> The driver (drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c) use
> interrupt-names to get irq numbers.

This catched my eye, because we are using a SolidRun i.MX 8XLite
System-on-Module on a custom baseboard which uses that SoC.

I had problems with one CPU core stalling when doing network traffic
over the 'end1' interface, which is that eqos interface here.  All I
could see so far were an excessive number of hardware interrupts in
/proc/interrupts for end1.  With this patch this behaviour is gone, I
could not reproduce those lock-up anymore.  Thank you and FWIW:

Tested-by: Alexander Dahl <ada@thorsis.com>

Note: I applied this to v6.12.  The patch has a Fixes: tag, so I
assume it hits stable once it got merged without further action,
right?

Adding Josua Mayer to Cc because it might affect other users of that
SoM.  Josua, would it be possible to upstream the dts/dtsi files for
that SoM? O:-)

Greets
Alex

> 
> Fixes: f29c19a6e488 ("arm64: dts: imx8dxl-ss-conn: Fix Ethernet interrupt-names order")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> index a66ba6d0a8c05646320dc45e460662ab0ae2aa3b..da33a35c6d4660ebf0fa3f7afcf7f7a289c3c419 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> @@ -29,8 +29,8 @@ eqos: ethernet@5b050000 {
>  		compatible = "nxp,imx8dxl-dwmac-eqos", "snps,dwmac-5.10a";
>  		reg = <0x5b050000 0x10000>;
>  		interrupt-parent = <&gic>;
> -		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "macirq", "eth_wake_irq";
>  		clocks = <&eqos_lpcg IMX_LPCG_CLK_4>,
>  			 <&eqos_lpcg IMX_LPCG_CLK_6>,
> 
> -- 
> 2.34.1
> 
> 

