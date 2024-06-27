Return-Path: <netdev+bounces-107486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960791B2B5
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF56283D0D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421AE1A2FB6;
	Thu, 27 Jun 2024 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwgZpVaR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E261A2FB1;
	Thu, 27 Jun 2024 23:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530938; cv=none; b=eaU25wgqXwseivYpBtWkid7Y/COVHVEY/G62sDQ5ig9aezWPftv2Q1qKbW43AKhHsPuqVmh+QkSd0PHW3wpxw1PpEiXjZo7U679I9Irxr7yQETyiE8IN+u84vtnmzQrGsAOeFXvZ+7CScU695gBACNRkvIem+I53wX4eRXNOK+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530938; c=relaxed/simple;
	bh=fDcY929y1dbItvCnjfbE1Bmmgy71kQcGofpj8HonM4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8KE9YP7+R+1mIYJ0a3gv0AU7mDAQMGcBj4xflgMS6S89jVECAE+bhLCH2hJCoaz1+rNQcaejOBEBl0LCzeCw5eE16A/kgfFyMv9bmttMxwz6p5g5lE1enlpLj7q/wzmUpVe2nTgfwZlvRot3bifVnKJsMqQ27spguCorqpxL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwgZpVaR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719530933; x=1751066933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fDcY929y1dbItvCnjfbE1Bmmgy71kQcGofpj8HonM4A=;
  b=nwgZpVaRaSJ0thcV/8y9QGhH58NgnG0xyVWTK7NyOIW9QTZY9dVm5xC8
   IrMcyAgi3/X12b5QWgoLtT/T029JDROoQst59HTS6X59mjH1w+6NMJrGN
   viVxxNxMkFZEecMLcfCr7aQx5EzrdD7hDcBPhTFNIVyUJH8Gn5M1Oj1/x
   rUl/pStdonGhnvmcf0SqM/DY4jGcppZpt5pYHVl83TGOhvx1qxk0lozO2
   Agw30b9f8p7ydGZMZD1CV7hreiy7QE7f9tDS8L72EMGpUEj3fpe3fQT5n
   YZ5pvxP0h11tkZQ7njSRbTK2QjP+iyDzgd3q2MJwV+tH78qS61nV6gkBV
   g==;
X-CSE-ConnectionGUID: /wq1Bv3bTmyH0VAvjupCDQ==
X-CSE-MsgGUID: XVKJ+rHdTy6Dg6QTIb0+WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16825808"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16825808"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:28:52 -0700
X-CSE-ConnectionGUID: zzRpow8RSiS75GHQ6+Hc1g==
X-CSE-MsgGUID: h1laxujgRbujeNMcMbUh+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="75300931"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Jun 2024 16:28:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMyXk-000Gcm-0e;
	Thu, 27 Jun 2024 23:28:44 +0000
Date: Fri, 28 Jun 2024 07:28:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] dt-bindings: net: Define properties at top-level
Message-ID: <202406280720.2jpIQKsI-lkp@intel.com>
References: <20240625215442.190557-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625215442.190557-2-robh@kernel.org>

Hi Rob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring-Arm/dt-bindings-net-Define-properties-at-top-level/20240626-091748
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240625215442.190557-2-robh%40kernel.org
patch subject: [PATCH net-next] dt-bindings: net: Define properties at top-level
config: arm64-randconfig-051-20240628 (https://download.01.org/0day-ci/archive/20240628/202406280720.2jpIQKsI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev2+g3b69bad
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280720.2jpIQKsI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406280720.2jpIQKsI-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: hdmi@ff3c0000: Unevaluated properties are not allowed ('interrupts', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: ethernet@ff550000: Unevaluated properties are not allowed ('assigned-clock-rate', 'interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: hdmi@ff3c0000: Unevaluated properties are not allowed ('interrupts', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: ethernet@ff540000: snps,pbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,pbl', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: ethernet@ff550000: Unevaluated properties are not allowed ('assigned-clock-rate', 'interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: hdmi@ff3c0000: Unevaluated properties are not allowed ('interrupts', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,force_thresh_dma_mode', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: ethernet@ff540000: snps,rxpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,rxpbl', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: ethernet@ff550000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: hdmi@ff3c0000: Unevaluated properties are not allowed ('interrupts', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: ethernet@ff540000: snps,rxpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,rxpbl', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3328.dtsi:732.17-740.5: Warning (graph_child_address): /vop@ff370000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: hdmi@ff3c0000: Unevaluated properties are not allowed ('interrupts', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
   arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
   arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
   arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
>> arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: ethernet@ff540000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: ethernet@ff540000: snps,rxpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: ethernet@ff540000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'reg', 'reset-names', 'resets', 'rx-fifo-depth', 'snps,aal', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,rxpbl', 'snps,txpbl', 'tx-fifo-depth' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: ethernet@ff550000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts:582.31-584.7: Warning (unit_address_vs_reg): /i2c@ff3d0000/typec-portc@22/ports/port@0/endpoint@0: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts:907.7-914.4: Warning (graph_child_address): /usb@fe800000/usb@fe800000/port: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts:576.9-586.5: Warning (graph_child_address): /i2c@ff3d0000/typec-portc@22/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dtb: /i2c@ff110000/audio-codec@1a: failed to match any schema with compatible: ['rockchip,rt5651']
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dtb: typec-portc@22: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dtb: syscon@ff770000: usb2phy@e450: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dtb: syscon@ff770000: usb2phy@e450: Unevaluated properties are not allowed ('port' was unexpected)
   	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dtb: usb2phy@e450: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2180.20-2182.6: Warning (graph_child_address): /dp@ff970000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/rockchip/rk3399-evb.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-evb.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-evb.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-evb.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-evb.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-evb.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-evb.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: bluetooth: clock-names: 'oneOf' conditional failed, one must be fixed:
   	['ext_clock'] is too short
   	'extclk' was expected
   	'txco' was expected
   	'lpo' was expected
   	from schema $id: http://devicetree.org/schemas/net/broadcom-bluetooth.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb: /i2c@ff110000/rt5640@1c: failed to match any schema with compatible: ['realtek,rt5640']
   arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb: syscon@ff770000: usb2phy@e450: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb: syscon@ff770000: usb2phy@e450: Unevaluated properties are not allowed ('port' was unexpected)
   	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb: usb2phy@e450: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/phy/rockchip,inno-usb2phy.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-firefly.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2180.20-2182.6: Warning (graph_child_address): /dp@ff970000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: pcie@0,0: wifi@0,0:interrupts:0:0: 8 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: pcie@0,0: wifi@0,0:interrupts:0: [8, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: usb@fe900000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /i2c@ff110000/rt5514@57: failed to match any schema with compatible: ['realtek,rt5514']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: /spi@ff1e0000/spi2@0: failed to match any schema with compatible: ['realtek,rt5514']
   arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dtb: da7219@1a: da7219_aad:dlg,jack-det-rate:0: '32ms_64ms' is not one of ['32_64', '64_128', '128_256', '256_512']
   	from schema $id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2180.20-2182.6: Warning (graph_child_address): /dp@ff970000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: pcie@0,0: wifi@0,0:interrupts:0:0: 8 is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: pcie@0,0: wifi@0,0:interrupts:0: [8, 8] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: usb@fe900000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /i2c@ff110000/rt5514@57: failed to match any schema with compatible: ['realtek,rt5514']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: /spi@ff1e0000/spi2@0: failed to match any schema with compatible: ['realtek,rt5514']
   arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: da7219@1a: da7219_aad:dlg,jack-det-rate:0: '32ms_64ms' is not one of ['32_64', '64_128', '128_256', '256_512']
   	from schema $id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:1947.9-1956.5: Warning (graph_child_address): /isp0@ff910000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: pcie@0,0: wifi@0,0:compatible: ['qcom,ath10k'] does not contain items matching the given schema
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: pcie@0,0: wifi@0,0:reg: [[0, 0, 0, 0, 0], [50331664, 0, 0, 0, 2097152]] is too long
   	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: wifi@0,0: reg: [[0, 0, 0, 0, 0], [50331664, 0, 0, 0, 2097152]] is too long
   	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath10k.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: usb@fe3a0000: bluetooth@1:compatible: ['usbcf3,e300', 'usb4ca,301a'] is too long
   	from schema $id: http://devicetree.org/schemas/usb/generic-ohci.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: usb@fe3a0000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bluetooth@1' were unexpected)
   	from schema $id: http://devicetree.org/schemas/usb/generic-ohci.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dtb: da7219@1a: da7219_aad:dlg,jack-det-rate:0: '32ms_64ms' is not one of ['32_64', '64_128', '128_256', '256_512']
   	from schema $id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:1947.9-1956.5: Warning (graph_child_address): /isp0@ff910000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dtb: usb@fe3a0000: bluetooth@1:compatible: ['usbcf3,e300', 'usb4ca,301a'] is too long
   	from schema $id: http://devicetree.org/schemas/usb/generic-ohci.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dtb: usb@fe3a0000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bluetooth@1' were unexpected)
   	from schema $id: http://devicetree.org/schemas/usb/generic-ohci.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dtb: da7219@1a: da7219_aad:dlg,jack-det-rate:0: '32ms_64ms' is not one of ['32_64', '64_128', '128_256', '256_512']
   	from schema $id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:1947.9-1956.5: Warning (graph_child_address): /isp0@ff910000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dtb: usb@fe3a0000: bluetooth@1:compatible: ['usbcf3,e300', 'usb4ca,301a'] is too long
   	from schema $id: http://devicetree.org/schemas/usb/generic-ohci.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dtb: usb@fe3a0000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bluetooth@1' were unexpected)
   	from schema $id: http://devicetree.org/schemas/usb/generic-ohci.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dtb: da7219@1a: da7219_aad:dlg,jack-det-rate:0: '32ms_64ms' is not one of ['32_64', '64_128', '128_256', '256_512']
   	from schema $id: http://devicetree.org/schemas/sound/dialog,da7219.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dtb: bluetooth: clock-names: 'oneOf' conditional failed, one must be fixed:
   	['ext_clock'] is too short
   	'extclk' was expected
   	'txco' was expected
   	'lpo' was expected
   	from schema $id: http://devicetree.org/schemas/net/broadcom-bluetooth.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dtb: syr827@40: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dtb: pcie@f8000000: 'pinctrl-0' is a dependency of 'pinctrl-names'
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dtb: bluetooth: clock-names: 'oneOf' conditional failed, one must be fixed:
   	['ext_clock'] is too short
   	'extclk' was expected
   	'txco' was expected
   	'lpo' was expected
   	from schema $id: http://devicetree.org/schemas/net/broadcom-bluetooth.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dtb: typec-portc@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtb: typec-portc@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:1356.21-1369.4: Warning (avoid_unnecessary_addr_size): /i2c@ff3d0000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dtb: typec-portc@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'nvmem-cell-names', 'nvmem-cells', 'phy-handle', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-orangepi.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-orangepi.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio', 'phy-handle', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-orangepi.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-orangepi.dtb: cm32181@10: 'vdd-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-orangepi.dtb: syscon@ff770000: usb2phy@e450: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-orangepi.dtb: syscon@ff770000: usb2phy@e450: Unevaluated properties are not allowed ('port' was unexpected)
   	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-orangepi.dtb: usb2phy@e450: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/phy/rockchip,inno-usb2phy.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2180.20-2182.6: Warning (graph_child_address): /dp@ff970000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dtb: spi@ff1d0000: Unevaluated properties are not allowed ('max-freq' was unexpected)
   	from schema $id: http://devicetree.org/schemas/spi/spi-rockchip.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dtb: syscon@ff770000: usb2phy@e450: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dtb: syscon@ff770000: usb2phy@e450: Unevaluated properties are not allowed ('port' was unexpected)
   	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dtb: usb2phy@e450: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/phy/rockchip,inno-usb2phy.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2098.21-2100.6: Warning (avoid_unnecessary_addr_size): /dsi@ff960000/ports/port@1: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2098.21-2100.6: Warning (graph_child_address): /dsi@ff960000/ports/port@1: graph node has single child node 'endpoint', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: vop@ff8f0000: assigned-clocks: [[8, 183], [8, 181], [8, 219], [8, 475]] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip-vop.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: vop@ff8f0000: assigned-clock-rates:0: [0, 0, 400000000, 100000000] is too long
   	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip-vop.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: fan@18: '#cooling-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: pinctrl: gpios: {'q7-thermal-pin': {'rockchip,pins': [[0, 3, 0, 186]], 'phandle': [[182]]}} is not of type 'array'
   	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: usb-typec@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: /i2c@ff160000/regulator@66: failed to match any schema with compatible: ['mps,mp8859']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: usb-typec@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: usb-typec@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: /i2c@ff160000/regulator@66: failed to match any schema with compatible: ['mps,mp8859']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: usb-typec@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:1356.21-1369.4: Warning (avoid_unnecessary_addr_size): /i2c@ff3d0000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb: es8388@11: 'DVDD-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb: es8388@11: 'AVDD-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb: es8388@11: 'PVDD-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb: es8388@11: 'HPVDD-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: usb@fe800000: 'extcon' does not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/usb/rockchip,rk3399-dwc3.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: regulator@40: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: regulator@41: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
   	from schema $id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: sdio-pwrseq: clock-names:0: 'ext_clock' was expected
   	from schema $id: http://devicetree.org/schemas/mmc/mmc-pwrseq-simple.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dtb: spdif-dit: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: sdio-pwrseq: clock-names:0: 'ext_clock' was expected
   	from schema $id: http://devicetree.org/schemas/mmc/mmc-pwrseq-simple.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb: spdif-dit: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: codec@11: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dtb: sdio-pwrseq: clock-names:0: 'ext_clock' was expected
   	from schema $id: http://devicetree.org/schemas/mmc/mmc-pwrseq-simple.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: sdio-pwrseq: clock-names:0: 'ext_clock' was expected
   	from schema $id: http://devicetree.org/schemas/mmc/mmc-pwrseq-simple.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dtb: spdif-dit: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: codec@11: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dtb: sdio-pwrseq: clock-names:0: 'ext_clock' was expected
   	from schema $id: http://devicetree.org/schemas/mmc/mmc-pwrseq-simple.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: codec@11: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)
   	from schema $id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dtb: sdio-pwrseq: clock-names:0: 'ext_clock' was expected
   	from schema $id: http://devicetree.org/schemas/mmc/mmc-pwrseq-simple.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: bluetooth: clock-names: 'oneOf' conditional failed, one must be fixed:
   	['ext_clock'] is too short
   	'extclk' was expected
   	'txco' was expected
   	'lpo' was expected
   	from schema $id: http://devicetree.org/schemas/net/broadcom-bluetooth.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: typec-portc@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dtb: spdif-dit: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: typec-portc@22: 'connector' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb: spdif-dit: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2180.20-2182.6: Warning (graph_child_address): /dp@ff970000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb: /i2c@ff110000/rt5651@1a: failed to match any schema with compatible: ['rockchip,rt5651']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
--
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:530.26-564.4: Warning (unit_address_vs_reg): /usb@fe800000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:566.26-600.4: Warning (unit_address_vs_reg): /usb@fe900000: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2063.25-2102.4: Warning (avoid_unnecessary_addr_size): /dsi@ff960000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/rockchip/rk3399.dtsi:2104.26-2144.4: Warning (avoid_unnecessary_addr_size): /dsi@ff968000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb: ethernet@fe300000: snps,txpbl: False schema does not allow [[4]]
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>> arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb: ethernet@fe300000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,txpbl' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
   arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb: /dp@fec00000: failed to match any schema with compatible: ['rockchip,rk3399-cdn-dp']
   arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb: /syscon@ff770000/phy@f780: failed to match any schema with compatible: ['rockchip,rk3399-emmc-phy']
   arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb: /syscon@ff770000/pcie-phy: failed to match any schema with compatible: ['rockchip,rk3399-pcie-phy']
   arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb: /phy@ff7c0000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']
   arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb: /phy@ff800000: failed to match any schema with compatible: ['rockchip,rk3399-typec-phy']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

