Return-Path: <netdev+bounces-234617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A35CC24B3C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 189484E148D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24A343D8F;
	Fri, 31 Oct 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUjVSJhg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AFA324B2D;
	Fri, 31 Oct 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908989; cv=none; b=UelWbha8zmIKUzZPTuHP7AGfY8KOym3QSVSaBe5Hc1wHB126rfRIQNy17ZPIToOw9evSKMTrJ5BqyjU1VAHneY2CFeslN92oJL5bKmBRocczBeQD7c80RypPschlC/yDuuBeDCLo4x5befQS4R0jNoh4MlVvjXqqSCOY8PpIKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908989; c=relaxed/simple;
	bh=I7rzIGhL8xOCEwjsSLVh7bEj5BilIr1yhKEWjb49+sU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KoBjap4wYVTAqK+6REDtGcFkb3W8hlohV7CpjhzJXNENERogAUUxaQN4ttidnKKd3piiM0zwn0fOph10/CBi9OJZ4BbmKWHm7RlClDXCa9MBbaiq72NeyxCOa2azPRptcUmyTSpI+5nKhCmz3AcwgKCDOKZFGaxrQcJ9a3qasOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUjVSJhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9919CC4CEF8;
	Fri, 31 Oct 2025 11:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761908989;
	bh=I7rzIGhL8xOCEwjsSLVh7bEj5BilIr1yhKEWjb49+sU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DUjVSJhggL+MIhCfTYxlHlZ6dS+T8pcQycIa9IRczO/3FIGe/wO2IifwIaNys5NK2
	 BboHfUyOPBXi8OmZjQitgIZe6ZvEH8+NCckKqO547SZvXW9fvt/hq3K0HYlgeB4vjl
	 3MKx3balmoI/1JfVJUv6yvv4tf26x1P+8E/d1zxUMqvLuTE/r0sh4H3UARc0ALOiK4
	 +WnE3GshC4coJDUehLB2xuPs8GRQk+yfZe6tuqR6+R7TWgxf8I/h5qjWxDA77B6Zq2
	 EWQu/rz7d0btKSr8ndLszUeubQwRlZnvJ0HSYZdBSw7dgUz7je0mkKiRUvMNH8klss
	 dHGh+gTtMZMgA==
Date: Fri, 31 Oct 2025 06:09:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
 Conor Dooley <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 "David S. Miller" <davem@davemloft.net>, Longbin Li <looong.bin@gmail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Eric Dumazet <edumazet@google.com>, 
 sophgo@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yixun Lan <dlan@gentoo.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
 Yao Zi <ziyao@disroot.org>
To: Inochi Amaoto <inochiama@gmail.com>
In-Reply-To: <20251031012428.488184-2-inochiama@gmail.com>
References: <20251031012428.488184-1-inochiama@gmail.com>
 <20251031012428.488184-2-inochiama@gmail.com>
Message-Id: <176190898726.569389.4934903700571310952.robh@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction


On Fri, 31 Oct 2025 09:24:26 +0800, Inochi Amaoto wrote:
> As the ethernet controller of SG2044 and SG2042 only supports
> RGMII phy. Add phy-mode property to restrict the value.
> 
> Also, since SG2042 has internal rx delay in its mac, make
> only "rgmii-txid" and "rgmii-id" valid for phy-mode.
> 
> Fixes: e281c48a7336 ("dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml:93:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251031012428.488184-2-inochiama@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


