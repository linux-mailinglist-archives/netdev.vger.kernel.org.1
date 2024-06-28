Return-Path: <netdev+bounces-107816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F191C705
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0AA1C21DCE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E107407D;
	Fri, 28 Jun 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzK5kkWy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659C54662
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605192; cv=none; b=M4inyATh8HmrgOpyy1l9+Q7Bz4AaJZrQyIFSPeFdxQ/3YMt5DGYnReCY4jmlttVpHcpAii7pXXVJo6G864oZYdiE3lqnyAGdS7PTDS0D14ZaDOZGchTMjN1APzOkTf7Z3HZzIJkNfPJARuT0g1y0DIM+nxVh9n9GeJhQWqXQJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605192; c=relaxed/simple;
	bh=HhgH3/4MRvPkkluwzxezBQOLm0SqOpAzwNtPKb9p2+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d60tJR/BcJFJyGAKFH9h1jj4m5YhgwRn8cbv1T4njwWS8+O/GKBy1hL3XlocJAwO+BdDbtR4qxAAkS6fzkQwX2/qDkdoeOw5dgyO5w9XYh5svwEQEqkvTq++apHCSsx2vOuPO5XttuQKCw3/jTD7b/tHNizjeC5gy/+BkZlhGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzK5kkWy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605191; x=1751141191;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HhgH3/4MRvPkkluwzxezBQOLm0SqOpAzwNtPKb9p2+k=;
  b=TzK5kkWyZPf4dIIIEfpHMTGaQGsduFdAx2/5qd4iSRO0iSn6qk9eLudS
   /NUOuMKt+mVrXDWG173T//73t4r6U/kfqoa9ajpQIaBBJSDrSGlUIK10j
   qQLQ4+8iJg/0t/DRq5GtfXHer6tFmjmkBZbQf2rMBx3k32+wtxemDsqrh
   XkrHhDYW0EsCVmj4oKYEq0O3Ssto5h6RMTL/KAPqGoV+tblZP6RLp7ZnT
   hb473aHN6ulHx8eaU+FQzgeGvudRWvhgFkFjBe2l56ELUmSjN5cPwAxzt
   VDT00wQi9DfToxr+7VjZ06bgxGyUD0MCkluXEMRr0PmoS7T6kozxjZcLG
   Q==;
X-CSE-ConnectionGUID: 1aNPUeObSXyk5FeNOurxtQ==
X-CSE-MsgGUID: ZLB3kLvFSiW6t8AxMr/3Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="19703864"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="19703864"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:06:30 -0700
X-CSE-ConnectionGUID: wVkbdKI8SU6qDS53J4oJUw==
X-CSE-MsgGUID: asEyVRoJSHe/2rDUjJ5Viw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="45260436"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Jun 2024 13:06:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNHrW-000IHm-02;
	Fri, 28 Jun 2024 20:06:26 +0000
Date: Sat, 29 Jun 2024 04:05:42 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Vasut <marex@denx.de>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [net-next:main 1/24] arch/arm64/boot/dts/apm/apm-mustang.dtb:
 menetphy@3: $nodename:0: 'menetphy@3' does not match
 '^ethernet-phy(@[a-f0-9]+)?$'
Message-ID: <202406290316.YvZdvLxu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git =
main
head:   748e3bbf47212d5e2e22d731328b0c15ee3b85ae
commit: 8fda53719a596fa2a2880c42b5fa4126fbbbfc3d [1/24] dt-bindings: net: r=
ealtek,rtl82xx: Document known PHY IDs as compatible strings
config: arm64-randconfig-051-20240629 (https://download.01.org/0day-ci/arch=
ive/20240629/202406290316.YvZdvLxu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326=
ba38a991250a8587a399a260b0f7af2c9166a)
dtschema version: 2024.6.dev3+g650bf2d
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240629/202406290316.YvZdvLxu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406290316.YvZdvLxu-lkp@i=
ntel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/sata@1a000000: failed to m=
atch any schema with compatible: ['apm,xgene-ahci']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/sata@1a400000: failed to m=
atch any schema with compatible: ['apm,xgene-ahci']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/sata@1a800000: failed to m=
atch any schema with compatible: ['apm,xgene-ahci']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/gpio@17001000: failed to m=
atch any schema with compatible: ['apm,xgene-gpio-sb']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/rtc@10510000: failed to ma=
tch any schema with compatible: ['apm,xgene-rtc']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/mdio@17020000: failed to m=
atch any schema with compatible: ['apm,xgene-mdio-rgmii']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: ethernet@17020000: phy-handle:0=
: [36, 37] is too long
   	from schema $id: http://devicetree.org/schemas/net/ethernet-controller.=
yaml#
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/ethernet@17020000: failed =
to match any schema with compatible: ['apm,xgene-enet']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/ethernet@17020000/mdio: fa=
iled to match any schema with compatible: ['apm,xgene-mdio']
>> arch/arm64/boot/dts/apm/apm-mustang.dtb: menetphy@3: $nodename:0: 'menet=
phy@3' does not match '^ethernet-phy(@[a-f0-9]+)?$'
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
>> arch/arm64/boot/dts/apm/apm-mustang.dtb: menetphy@3: Unevaluated propert=
ies are not allowed ('reg' was unexpected)
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/ethernet@1f210000: failed =
to match any schema with compatible: ['apm,xgene1-sgenet']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/ethernet@1f210030: failed =
to match any schema with compatible: ['apm,xgene1-sgenet']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/ethernet@1f610000: failed =
to match any schema with compatible: ['apm,xgene1-xgenet']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/ethernet@1f620000: failed =
to match any schema with compatible: ['apm,xgene1-xgenet']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: /soc/dma@1f270000: failed to ma=
tch any schema with compatible: ['apm,xgene-storm-dma']
   arch/arm64/boot/dts/apm/apm-mustang.dtb: poweroff_mbox@10548000: compati=
ble: 'anyOf' conditional failed, one must be fixed:
   	['syscon'] is too short
   	'syscon' is not one of ['allwinner,sun8i-a83t-system-controller', 'allw=
inner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller',=
 'allwinner,sun50i-a64-system-controller', 'altr,sdr-ctl', 'amd,pensando-el=
ba-syscon', 'apm,xgene-csw', 'apm,xgene-efuse', 'apm,xgene-mcb', 'apm,xgene=
-rb', 'apm,xgene-scu', 'brcm,cru-clkset', 'brcm,sr-cdru', 'brcm,sr-mhb', 'f=
reecom,fsg-cs2-system-controller', 'fsl,imx93-aonmix-ns-syscfg', 'fsl,imx93=
-wakeupmix-syscfg', 'fsl,ls1088a-reset', 'hisilicon,dsa-subctrl', 'hisilico=
n,hi6220-sramctrl', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl',=
 'hpe,gxp-sysreg', 'intel,lgm-syscon', 'loongson,ls1b-syscon', 'loongson,ls=
1c-syscon', 'marvell,armada-3700-cpu-misc', 'marvell,armada-3700-nb-pm', 'm=
arvell,armada-3700-avs', 'marvell,armada-3700-usb2-host-misc', 'mediatek,mt=
2712-pctl-a-syscfg', 'mediatek,mt6397-pctl-pmic-syscfg', 'mediatek,mt8135-p=
ctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8173-pctl-a-sys=
cfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,=
sparx5-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,=
wpcm450-shm', 'rockchip,px30-qos', 'rockchip,rk3036-qos', 'rockchip,rk3066-=
qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', =
'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3568-qos', 'rockc=
hip,rk3588-qos', 'rockchip,rv1126-qos', 'starfive,jh7100-sysmain', 'ti,am62=
-usb-phy-ctrl', 'ti,am62p-cpsw-mac-efuse', 'ti,am654-dss-oldi-io-ctrl', 'ti=
,am654-serdes-ctrl', 'ti,j784s4-pcie-ctrl']
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
--
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb: clock-generato=
r@6a: 'idt,shutdown' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb: clock-generato=
r@6a: 'idt,output-enable-active' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
>> arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb: ethernet-phy@0=
: compatible: ['ethernet-phy-id001c.c915', 'ethernet-phy-ieee802.3-c22'] is=
 too long
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
--
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb: clo=
ck-generator@6a: 'idt,shutdown' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb: clo=
ck-generator@6a: 'idt,output-enable-active' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
>> arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb: eth=
ernet-phy@0: compatible: ['ethernet-phy-id001c.c915', 'ethernet-phy-ieee802=
=2E3-c22'] is too long
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
--
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb: clock=
-generator@6a: 'idt,shutdown' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb: clock=
-generator@6a: 'idt,output-enable-active' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
>> arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb: ether=
net-phy@0: compatible: ['ethernet-phy-id001c.c915', 'ethernet-phy-ieee802.3=
-c22'] is too long
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
--
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb: clock-gen=
erator@6a: 'idt,shutdown' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb: clock-gen=
erator@6a: 'idt,output-enable-active' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
>> arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb: ethernet-=
phy@0: compatible: ['ethernet-phy-id001c.c915', 'ethernet-phy-ieee802.3-c22=
'] is too long
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
--
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb=
: clock-generator@6a: 'idt,shutdown' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
   arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb=
: clock-generator@6a: 'idt,output-enable-active' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
>> arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb=
: ethernet-phy@0: compatible: ['ethernet-phy-id001c.c915', 'ethernet-phy-ie=
ee802.3-c22'] is too long
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
--
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1682.12-1692.7: Warning (graph=
_child_address): /soc/video@e6ef4000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1710.12-1720.7: Warning (graph=
_child_address): /soc/video@e6ef5000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1738.12-1748.7: Warning (graph=
_child_address): /soc/video@e6ef6000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1766.12-1776.7: Warning (graph=
_child_address): /soc/video@e6ef7000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb: clock-generato=
r@6a: 'idt,shutdown' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
   arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb: clock-generato=
r@6a: 'idt,output-enable-active' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
>> arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb: ethernet-phy@0=
: compatible: ['ethernet-phy-id001c.c915', 'ethernet-phy-ieee802.3-c22'] is=
 too long
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
--
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1682.12-1692.7: Warning (graph=
_child_address): /soc/video@e6ef4000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1710.12-1720.7: Warning (graph=
_child_address): /soc/video@e6ef5000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1738.12-1748.7: Warning (graph=
_child_address): /soc/video@e6ef6000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1766.12-1776.7: Warning (graph=
_child_address): /soc/video@e6ef7000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb: clo=
ck-generator@6a: 'idt,shutdown' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
   arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb: clo=
ck-generator@6a: 'idt,output-enable-active' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
>> arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb: eth=
ernet-phy@0: compatible: ['ethernet-phy-id001c.c915', 'ethernet-phy-ieee802=
=2E3-c22'] is too long
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
--
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1682.12-1692.7: Warning (graph=
_child_address): /soc/video@e6ef4000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1710.12-1720.7: Warning (graph=
_child_address): /soc/video@e6ef5000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1738.12-1748.7: Warning (graph=
_child_address): /soc/video@e6ef6000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1.dtsi:1766.12-1776.7: Warning (graph=
_child_address): /soc/video@e6ef7000/ports/port@1: graph node has single ch=
ild node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb: clock=
-generator@6a: 'idt,shutdown' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
   arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb: clock=
-generator@6a: 'idt,output-enable-active' is a required property
   	from schema $id: http://devicetree.org/schemas/clock/idt,versaclock5.ya=
ml#
>> arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb: ether=
net-phy@0: compatible: ['ethernet-phy-id001c.c915', 'ethernet-phy-ieee802.3=
-c22'] is too long
   	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

