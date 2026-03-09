Return-Path: <netdev+bounces-265373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKD1LVVQrmnUCAIAu9opvQ
	(envelope-from <netdev+bounces-265373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 05:45:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD50233B89
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 05:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEEEF301992B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 04:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B92628FA91;
	Mon,  9 Mar 2026 04:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CxctiYZA"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C432BE7DB;
	Mon,  9 Mar 2026 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773031507; cv=fail; b=OLrikiyw2W3XfFpjwKOhDinvGb9ljF9qwfZcHnMPD6kkLmnL90OxR6A8j7FMavjoP2zUFpJbIBFjOEoMwCDl2bU4n7qjtRYaBOdKLEez0EEFMgLkmSzFBcHsGn5nSPu2hW/Vvjh0RAg2xh2JpBZ4+NEN72+8stGViLFcRJkk6Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773031507; c=relaxed/simple;
	bh=jLLq5HvMJVSM/ptVADGq4+5jFwkLKbQ1u03iyoE4Qrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G8Qi2EAHPLZwX2Of1dDsxwATszmQsMNxWvKcet8gF7V6AXr0llt7gKkt1Zq2694/w9IZCNVVYPSg41EUtIO35O2kNT49umwzLBxMjkHxBAMPfX3EuYABQZPHeeGPcMLig6aEvMNGAtL0/Zjpy47sKtbukmojaSUM3ItPLIP/Cxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CxctiYZA; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xh4eHnkRhQEG+g/BY5AbYa7nvWbc66jaPQu/mMriPFBx/D0tCyd/96IJFlOwR4LG7WIvN4we7r+dI3BMCvQwvydUmD5pDBta5wbKoKFc4pHICnBLBKCuIovENW//1lK2DxsnN7DzmKhG/Z1D8HlTwkqB+eF3az1EXZEJ1dCJ9U74suKkXUHR3z9ME+DQ0V1Yx2nT9YiE08HHk2SRobxshO9HZV809yK0OJhNGS/BJ40iYImCVvZ7Tn5SfOc4U+/9jULyHn7SKS8ALmCiooSH2VA1OBLA1Jg2pp0k5w1KGR5r1Z5IOzfOMgJTLFXmWgdtDHvORgqPesHWODQ8Bwu/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHEdEOxGByr6bGA8sg6khd2bdgx9Enw39YnWx6fUXYI=;
 b=VhzxzdFatZTo1cPqfnNs3pwKB1NspbhznuKaHFV4A3yi9+vbetOp2UzLQ3JwVDmYKgC4M+tESrmD12XImqHEQAdzv+3wfrhPleMUOovnDYkRWxhHXitst9v8I5VKWM7TUsD81TvLxymsfGnSdVgfGt1W2RbjaaxZ3eEIYP3nIQ1JyKupppK9NoF4TKc3Q9z6oaNO2i+V6NSfgP4CZ+fONrzjjLf7qAanteCLtlLbG4UAF8SW8PzRKrQ+dPzKTttvMEiqr5mgBp7iLv+vXbmtPX7Fg5r4qBuGPQKNgudDnLXqn0/vFUaIcsJvK6r7eiK4RCSYLykjXgIpbAU6mbF9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHEdEOxGByr6bGA8sg6khd2bdgx9Enw39YnWx6fUXYI=;
 b=CxctiYZA9u4rVx1vYEfRzxxc8l4T3SJfMmjdDz12mzW8c9oGp+cm/2BPwNCbckfH+vC2T+dQv/2XGtNZMEobHxoURMYt8Pqgz/3gMcARoezHmzsMVMGREEgDRthnidItpatwhBXXIctbxoDfdN9QUeAAuYBHrL4vCONjzdo9KiE=
Received: from DM6PR12CA0033.namprd12.prod.outlook.com (2603:10b6:5:1c0::46)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 04:45:01 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f) by DM6PR12CA0033.outlook.office365.com
 (2603:10b6:5:1c0::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 04:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 04:45:00 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:45:00 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:44:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Mar 2026 23:44:59 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6294itqq4087808;
	Sun, 8 Mar 2026 23:44:56 -0500
Message-ID: <6eecd173-0a58-483e-9af3-881118576b44@ti.com>
Date: Mon, 9 Mar 2026 10:14:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay
 for dual EMAC support
To: Meghana Malladi <m-malladi@ti.com>, <nm@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>
References: <20260228113203.498839-1-m-malladi@ti.com>
 <20260228113203.498839-2-m-malladi@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20260228113203.498839-2-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3410a0-b4dd-48e9-ed03-08de7d969f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	jEwzfniLIpsdXOerTOcCttsIa/mZ+hrpnj5af6D0hrw1vH2FPR/OqW1c1ONsQuKptibRMjgo0nKUcfCXmDcCgM/QQvV0QfrKL1b8KXIPk7ZOjw3F8nuLtSDhImfyf/cqYlhhEVG/1LHsgS22SWO/Whi7eobbMp56NO3WosFs+yNSBCudd04nv8lARKb7YMzptHrrKJLtu9xXTVI3fRMSKNywKjUhDeV81HDNk8MLg2hKy3qARZeJ1k6ZVN0BGJ/MQ9tkDctKYNsZ3tlqAAe9Vki+Cv0Tkm06GgKQ+cQRWbvECnsv29x32ffjBFtrZfrCNF9HwZY3X1RHLKKsFA3vpi2kAl+BRQHoAaYMT/JROHR4HWkm8w816AkO4jGNA6pkNg2pp153moozDIDy+mphooVztEHzVqWeYR+kqnWcG4FlNAKQHTPQCoExou1xNNmKAZl4CU4iWJ/JlRoYV7YbNgvr/9WP3GeTFd3vvnvOQCr44Jg4ZdboYhm5oqvO5eeAX3F6qiXqLT9JXcvDV90JPWDHIv24zskTzqg1Y/iFxC/e0UZ3snmlxaTulG/YSKGKlZFh2l7h5ClTN2epRhymVBHx+KILZvnh0ltcl/eLNGHoBC0ZaKVF6/Ljvxqy+BKRSqw7PtdDPWDeFNZ0RPSfVPKH8GDtOEg024S/dAOhiCQjg1YLFV8jl8PuamqAQwbOn2rQji0sn6wzNpxuUhnMy5CSlEP2DWxXs9Pb0PcgUZI=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q7OXTix6Sai8fUMjIUKhwOeXFGv4UD+kqzYgIvJGUWHYR6YcwvPF02TNB2DrldBSLFjhrdnew4l0Gw33Wu26G3QUimiPvkAkchw9QvVGDOwyjDlF5vbFwa7eWuqEZki0uZ+w9smRXObxWlaiD6L8tQ3F76e8a9C4GqQzzTaX+CK5/j7iM5wss/qc/GoQs1UBLDauRo+cVeG/o2gRYdVAoTp4YZcx+SGbvlON2pwsv8xmiSKcuTf9dCiXJ92y//R0fUiOCsMw9M+JsYNS1zFBUIwv1p7tJh7y9kkT8qmYyI58mWc5h5jpTUi8lGMogkI73w4Jy9ZYGxU8d7etVdgZygn2qgtogxfvASV4Tgmzda9WmT6NZ9ErjkOBzq4PE8j1QWqzJih/X+LTnSRN8MeDlqlGGlb2Zr3P8zvOu6UTzLmLi8B13vgyKZfDbzY8R7kk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 04:45:00.3395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3410a0-b4dd-48e9-ed03-08de7d969f4b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Rspamd-Queue-Id: 1CD50233B89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265373-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:url,ti.com:mid,0.0.0.0:email,0.0.0.1:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



On 28/02/26 17:02, Meghana Malladi wrote:
> Add device tree overlay to enable ICSSG0 dual EMAC support on AM642 EVM.
> This overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
> dual EMAC mode.
> 
> Users can combine this with the existing ICSSG1 overlay to enable all four
> ICSSG interfaces if needed.
> 
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> v1: https://lore.kernel.org/all/20260226115454.1730618-1-m-malladi@ti.com/
> v2-v1:
> - Drop bringing up ICSSG1 support in this overlay as suggested by
>   MD Danish Anwar <danishanwar@ti.com>
> 
>  arch/arm64/boot/dts/ti/Makefile               |   4 +
>  .../boot/dts/ti/k3-am642-evm-icssg0.dtso      | 203 ++++++++++++++++++
>  2 files changed, 207 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index ba01a929e06f..d2cd124a5b08 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
>  
>  # Boards with AM64x SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg0.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-pcie0-ep.dtbo
> @@ -218,6 +219,8 @@ k3-am62p5-sk-csi2-ov5640-dtbs := k3-am62p5-sk.dtb \
>  	k3-am62x-sk-csi2-ov5640.dtbo
>  k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
>  	k3-am62x-sk-csi2-tevi-ov5640.dtbo
> +k3-am642-evm-icssg0-dtbs := \
> +	k3-am642-evm.dtb k3-am642-evm-icssg0.dtbo
>  k3-am642-evm-icssg1-dualemac-dtbs := \
>  	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
>  k3-am642-evm-icssg1-dualemac-mii-dtbs := \
> @@ -306,6 +309,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>  	k3-am62p5-sk-csi2-imx219.dtb \
>  	k3-am62p5-sk-csi2-ov5640.dtb \
>  	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
> +	k3-am642-evm-icssg0.dtb \
>  	k3-am642-evm-icssg1-dualemac.dtb \
>  	k3-am642-evm-icssg1-dualemac-mii.dtb \
>  	k3-am642-evm-pcie0-ep.dtb \
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
> new file mode 100644
> index 000000000000..425a16948cc1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * DT overlay for enabling ICSSG0 dual EMAC on AM642 EVM
> + *
> + * AM642 EVM Product link: https://www.ti.com/tool/TMDS64EVM
> + * DP83TG720 daughter card link: https://www.ti.com/tool/DP83TG720-IND-SPE-EVM
> + *
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/

		    2020-2026
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&{/aliases} {
> +	ethernet0 = &icssg0_emac0;
> +	ethernet1 = &icssg0_emac1;
> +};
> +
> +&{/} {
> +	icssg0_eth: icssg0-eth {
> +		compatible = "ti,am642-icssg-prueth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pru_icssg0_rgmii1_pins_default>, <&pru_icssg0_rgmii2_pins_default>;
> +
> +		sram = <&oc_sram>;
> +		ti,prus = <&pru0_0>, <&rtu0_0>, <&tx_pru0_0>, <&pru0_1>, <&rtu0_1>, <&tx_pru0_1>;
> +		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
> +
> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
> +				      <2>,
> +				      <2>,
> +				      <2>,	/* MII mode */
> +				      <2>,
> +				      <2>;
> +
> +		ti,mii-g-rt = <&icssg0_mii_g_rt>;
> +		ti,mii-rt = <&icssg0_mii_rt>;
> +		ti,pa-stats = <&icssg0_pa_stats>;
> +		ti,iep = <&icssg0_iep0>,  <&icssg0_iep1>;
> +

Please Sort properties as per
Documentation/devicetree/bindings/dts-coding-style.rst

Example vendor specific properties come after generic ones

> +		interrupt-parent = <&icssg0_intc>;
> +		interrupts = <24 0 2>, <25 1 3>;
> +		interrupt-names = "tx_ts0", "tx_ts1";
> +
> +		dmas = <&main_pktdma 0xc100 0>, /* egress slice 0 */
> +		       <&main_pktdma 0xc101 0>, /* egress slice 0 */
> +		       <&main_pktdma 0xc102 0>, /* egress slice 0 */
> +		       <&main_pktdma 0xc103 0>, /* egress slice 0 */
> +		       <&main_pktdma 0xc104 0>, /* egress slice 1 */
> +		       <&main_pktdma 0xc105 0>, /* egress slice 1 */
> +		       <&main_pktdma 0xc106 0>, /* egress slice 1 */
> +		       <&main_pktdma 0xc107 0>, /* egress slice 1 */
> +		       <&main_pktdma 0x4100 0>, /* ingress slice 0 */
> +		       <&main_pktdma 0x4101 0>, /* ingress slice 1 */
> +		       <&main_pktdma 0x4102 0>, /* mgmnt rsp slice 0 */
> +		       <&main_pktdma 0x4103 0>; /* mgmnt rsp slice 1 */
> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
> +			    "rx0", "rx1",
> +			    "rxmgm0", "rxmgm1";
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			icssg0_emac0: port@0 {
> +				reg = <0>;
> +				phy-handle = <&icssg0_phy00>;
> +				phy-mode = "rgmii-id";
> +				syscon-rgmii-delay = <&main_conf 0x4100>;
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +			};
> +
> +			icssg0_emac1: port@1 {
> +				reg = <1>;
> +				phy-handle = <&icssg0_phy01>;
> +				phy-mode = "rgmii-id";
> +				syscon-rgmii-delay = <&main_conf 0x4104>;
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +			};
> +		};
> +	};
> +};
> +
> +&main_pmx0 {
> +	pru_icssg0_mdio_pins_default: pru-icssg0-mdio-pins-default {


These pmx nodes will fail make dtbs_check

> +		pinctrl-single,pins = <
> +			/* (P3) PRG0_MDIO0_MDC */
> +			AM64X_IOPAD(0x0204, PIN_OUTPUT, 0)
> +			/* (P2) PRG0_MDIO0_MDIO */
> +			AM64X_IOPAD(0x0200, PIN_INPUT, 0)
> +			/* (P16) GPIO0_32 - GPMC0_ADVn_ALE - GPIO_ETH0/1_RESETn# */
> +			AM64X_IOPAD(0x0084, PIN_OUTPUT, 7)
> +		>;
> +	};
> +
> +	pru_icssg0_rgmii1_pins_default: pru-icssg0-rgmii1-pins-default {
> +		pinctrl-single,pins = <
> +			/* (module-sitara) */

What does this comment mean?

> +			/* (a14-y1) PRG0_PRU0_GPO0.PRG0_RGMII1_RD0 */

What does a14-y1 mean?

> +			AM64X_IOPAD(0x0160, PIN_INPUT, 2)
> +			/* (b14-r4) PRG0_PRU0_GPO1.PRG0_RGMII1_RD1 */
> +			AM64X_IOPAD(0x0164, PIN_INPUT, 2)
> +			/* (d14-u2) PRG0_PRU0_GPO2.PRG0_RGMII1_RD2 */
> +			AM64X_IOPAD(0x0168, PIN_INPUT, 2)
> +			/* (e14-v2) PRG0_PRU0_GPO3.PRG0_RGMII1_RD3 */
> +			AM64X_IOPAD(0x016c, PIN_INPUT, 2)
> +			/* (e13-t3) PRG0_PRU0_GPO6.PRG0_RGMII1_RXC */
> +			AM64X_IOPAD(0x0178, PIN_INPUT, 2)
> +			/* (b13-aa2) PRG0_PRU0_GPO4.PRG0_RGMII1_RX_CTL */
> +			AM64X_IOPAD(0x0170, PIN_INPUT, 2)
> +
> +			/* (a11-y3) PRG0_PRU0_GPO11.PRG0_RGMII1_TD0 */
> +			AM64X_IOPAD(0x018c, PIN_OUTPUT, 2)
> +			/* (c11-aa3) PRG0_PRU0_GPO12.PRG0_RGMII1_TD1 */
> +			AM64X_IOPAD(0x0190, PIN_OUTPUT, 2)
> +			/* (d11-r6) PRG0_PRU0_GPO13.PRG0_RGMII1_TD2 */
> +			AM64X_IOPAD(0x0194, PIN_OUTPUT, 2)
> +			/* (b10-v4) PRG0_PRU0_GPO14.PRG0_RGMII1_TD3 */
> +			AM64X_IOPAD(0x0198, PIN_OUTPUT, 2)
> +			/* (e10-u4) PRG0_PRU0_GPO16.PRG0_RGMII1_TXC */
> +			AM64X_IOPAD(0x01a0, PIN_OUTPUT, 2)
> +			/* (c10-t5) PRG0_PRU0_GPO15.PRG0_RGMII1_TX_CTL */
> +			AM64X_IOPAD(0x019c, PIN_OUTPUT, 2)
> +		>;
> +	};
> +
> +	pru_icssg0_rgmii2_pins_default: pru-icssg0-rgmii2-pins-default {
> +		pinctrl-single,pins = <
> +			/* (e9-y2) PRG0_PRU1_GPO0.PRG0_RGMII2_RD0 */
> +			AM64X_IOPAD(0x01b0, PIN_INPUT, 2)
> +			/* (a8-w2) PRG0_PRU1_GPO1.PRG0_RGMII2_RD1 */
> +			AM64X_IOPAD(0x01b4, PIN_INPUT, 2)
> +			/* (c8-v3) PRG0_PRU1_GPO2.PRG0_RGMII2_RD2 */
> +			AM64X_IOPAD(0x01b8, PIN_INPUT, 2)
> +			/* (d8-t4) PRG0_PRU1_GPO3.PRG0_RGMII2_RD3 */
> +			AM64X_IOPAD(0x01bc, PIN_INPUT, 2)
> +			/* (e7-r5) PRG0_PRU1_GPO6.PRG0_RGMII2_RXC */
> +			AM64X_IOPAD(0x01c8, PIN_INPUT, 2)
> +			/* (b7-w3) PRG0_PRU1_GPO4.PRG0_RGMII2_RX_CTL */
> +			AM64X_IOPAD(0x01c0, PIN_INPUT, 2)
> +
> +			/* (a5-w4) PRG0_PRU1_GPO11.PRG0_RGMII2_TD0 */
> +			AM64X_IOPAD(0x01dc, PIN_OUTPUT, 2)
> +			/* (c5-y4) PRG0_PRU1_GPO12.PRG0_RGMII2_TD1 */
> +			AM64X_IOPAD(0x01e0, PIN_OUTPUT, 2)
> +			/* (d5-t6) PRG0_PRU1_GPO13.PRG0_RGMII2_TD2 */
> +			AM64X_IOPAD(0x01e4, PIN_OUTPUT, 2)
> +			/* (b4-u6) PRG0_PRU1_GPO14.PRG0_RGMII2_TD3 */
> +			AM64X_IOPAD(0x01e8, PIN_OUTPUT, 2)
> +			/* (a3-aa4) PRG0_PRU1_GPO16.PRG0_RGMII2_TXC */
> +			AM64X_IOPAD(0x01f0, PIN_OUTPUT, 2)
> +			/* (c4-u5) PRG0_PRU1_GPO15.PRG0_RGMII2_TX_CTL */
> +			AM64X_IOPAD(0x01ec, PIN_OUTPUT, 2)
> +		>;
> +	};
> +
> +	icssg0_iep0_pins_default: icssg0-iep0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x01ac, PIN_OUTPUT, 2) /* (W1) PRG0_PRU0_GPO19.PRG0_IEP0_EDC_SYNC_OUT0 */
> +		>;
> +	};
> +};
> +
> +&icssg0_mdio {
> +	pinctrl-names = "default";
> +	status = "okay";
> +	pinctrl-0 = <&pru_icssg0_mdio_pins_default>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	icssg0_phy00: ethernet-phy@0 {
> +		reg = <0x0>;
> +	};
> +
> +	icssg0_phy01: ethernet-phy@1 {
> +		reg = <0xA>;

Small caps for hex digits.

Please run all DT checks before posting. reg doesnt match node address here.

> +	};
> +};
> +
> +&icssg0_iep0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&icssg0_iep0_pins_default>;
> +};
> +
> +&main_gpio0 {
> +	phy-line-hog {
> +		gpio-hog;
> +		gpios = <32 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "phy-hog-line";
> +	};
> +};

-- 
Regards
Vignesh
https://ti.com/opensource


