Return-Path: <netdev+bounces-146851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B088C9D64FF
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE13B21E54
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D82818991A;
	Fri, 22 Nov 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IQKbZQIj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58D187FEC;
	Fri, 22 Nov 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308276; cv=fail; b=nTyVawAji8pC9/9fzYzgLri9BRK07XQmk3pe47QKyO3CmBS6Y5OKBxKKGr18Bjql5SCdmCMdaMeGVHoGUlHHU23UkaFggf5pSXWnUMTYn0+QyDnf6Q9Lg7U6oVzz4uewdDXRA4glOEnxYL4KyzjPcQOfqYFkyeZTzLkGKZGR+tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308276; c=relaxed/simple;
	bh=qSjkbriobfWERAhieAuP/m8LrDgYivzwVaYIIRzCim0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=D1YOmxn+NPiiVUuheH1aKXOu6218uwhUkKJ8mOtYp4cc2rxGax6eErJFL/bNuFOW9m3dFppw+Y8oc+P1CgSuZ+I9W4qIYBSBWO9B2adyweNo8lzCPWayn4vHNux/plyP4F6xsMXTMKJdaElpbFLVuelGAXEsr176Y9Hh0eEZKF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IQKbZQIj; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOA+ArKw/TptIEvf8JfcVU/7fNHLqpy4VSh5dMV76lvJHZfRPDMu/F20HXjl4n9WROamdnfYK8Y4MQr4tINltNSXgt8zZEj4BNKFpC9JddVhTgk54UjJwwkdP7jnIaPk/GKQQkn9MBJuh04Zktt8ErudaiPowAPHnWTjdz6va1QayravWBAdVQTfy2zowjbpDZkGp++97b9jW0YYX6ZbvNUljBVaKj8JoQ+jQ1AzSGXNEXttiRm3BwXX0X/emxGLTCss+Tnxv15emfEksjP8EY0XR/DEGGGdHE9valbkVzT48jmku/bnjbcca13r31FCxiNUgtGlXV6K36zzOpX55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na9fWMj9QHHxHfr8nh2rzeOpOse026hi6F0nm3JnIa4=;
 b=QGCQtBSApWxc/9z0PTzKBNt9EqyPqcWBFrvGzDZNvJPtmXFzcZn5Nxbob4S/N+SU2CF0ZWrFIE685aLhrZWyTR/TpT6mrVFx7FtupnNdlKXatciHmMlNw2/ZCvdzTeTRwsy8RRdQ2wzkSRrHQeFourh4kaJxNDRWaMJDz3dV9RB9+S+PHOoolSCObAaX/tZiOfHsrOblcjpNxfhJmWcWsL30JSnJ4WSYZAMrcrhNvctUl3fjXqmj9XrqRMRPvEr+RlqPNcxZrigqpY+UB8WchJ8u+f4vTe1ugKrvyYecDKryYfgcPwJ6xpVXUwwMVLCNGhnk3m15cQ6Pice+Vb3Bpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na9fWMj9QHHxHfr8nh2rzeOpOse026hi6F0nm3JnIa4=;
 b=IQKbZQIj5VYjkemiqBc1OpnbdP5O0t2RtBBTrqGdu74RVc1T6k5YiNhOUsWvnT2LczLI7pwLH/PVIxI2lbzuijkFAt3zPIfzbME92Itdd4zh2+V8DJHtQOXa0veqoSw0bOsIg0W3biEZ0ZS32rLEKtkemGyzhc+21c47F88IilA=
Received: from BL1PR13CA0417.namprd13.prod.outlook.com (2603:10b6:208:2c2::32)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 20:44:26 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::40) by BL1PR13CA0417.outlook.office365.com
 (2603:10b6:208:2c2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 20:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:44:26 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:44:22 -0600
Message-ID: <ee18b2a0-35ac-4fc7-8e88-82319c3cf765@amd.com>
Date: Fri, 22 Nov 2024 14:44:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, "Cheatham, Benjamin"
	<bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: a0957363-0227-476b-f024-08dd0b367446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2NVUDNMWnR0RkR0dFgwTTBPcmNEcFo3SVZ2M1BGMnl5UlpteDArSElsSWtw?=
 =?utf-8?B?dyt5eVhVU1NqRks3WDFWeExtWko2cFNwUjV4V1hxeG12dGpqRURFbGpFbTNB?=
 =?utf-8?B?aTI4b3d2cVdnZlZrc0QxbWc0bnRqRTVmVEduY2VJQ3Q2YWxEOWkyYmRnVzdk?=
 =?utf-8?B?VzRBT0l5eEplUCtHNmVqRE5ZZlFqdGpqSGNEa3paeWc2RE9xRWM0SHluSlRJ?=
 =?utf-8?B?djM3RkU5TW9YMDhtSm03MFRoZTZwVitBVFBFYWIvUkd2QnIvbDBOTGZqdEc2?=
 =?utf-8?B?bWlnaUhWRUNTdUxzSFMxenJjRlBUc3g0Vk1aRVBQS2hHSkcrTW5PS1U4YnYv?=
 =?utf-8?B?RGJhUTRHWWZJeXFaVW44K0s2ZmRrZit1RTluYkR0Mk5yT3hvd2NNZGxqaDNJ?=
 =?utf-8?B?ZkkvbHJWRlBmejc4Y2hTRXBUUXNBNVArZmFWdFZhVlVFWGJXWC9lOTdYeFN1?=
 =?utf-8?B?bWpFS0FncU5SblpxVVRpVTlZRVM0RFZpZ1NjSUp2bHRPZUNRak1iZis3Q01m?=
 =?utf-8?B?YWJEdDQzWEdIUWNqckNBb3pFbTRhYm5hb0tyRTJVRE5lRUh0RHZpdkNMN1NK?=
 =?utf-8?B?cE8vb1pITW9Qak4wQzdaMWtqdzd4L1labWEwRm5qRkNuazdtZ211SDRZU2JE?=
 =?utf-8?B?QkYyaUdSNGdTQldPM0htZDNOVXNEaFZYb2l6bEl3VDY5M3RxODQ5ckdNcmhv?=
 =?utf-8?B?YWNSS1F3QVRNRkg1OVptdk5ST0x5RGNTSmZtUXk5ODJ2RDZlNG5ncXBHSGNL?=
 =?utf-8?B?NFZpMnpZS0Q5MHlKQ0tqczE4NGxCOEdaK3IzME1mdktPYU8yb2FubXV1SkdY?=
 =?utf-8?B?RjhrUDE2V0haVGhJeEJTNFB3TFl6Rlhpc09HMFdWOTc5K2xnRWtkQWorT2sw?=
 =?utf-8?B?QVA5bExGRnU1NFRwc0YwcDV5Z2lmZDNhMnd3eUJ0N3h2OXZwMjNhc2lIRk8x?=
 =?utf-8?B?akc0RUFqdWFOVEdRRUZPdGloQjRpTFBqbEs3NGZhSWdyS20rWnl4TjdlRmZP?=
 =?utf-8?B?a28wSSt5V0l6Z3NPblhaVDNCejg0SE1sd1pCbFFQczU4dldUdXRHUXJYckZ2?=
 =?utf-8?B?TTF3U3FVRHlTckpFYW9HVkRvQlhQcEtMMEQzT2JRNE1hMUltM2N0WTRrZjI5?=
 =?utf-8?B?S3N4YXNzNHJaTzM1STdxSkZYb0RJZE5zbzBabmVGMDFjWFJTTG9NZE1la3ZD?=
 =?utf-8?B?VDVSRWcwSnRYb2pzVEMrWWVSK2lFbUkyY0pKRUk2UDVIaUZ2Z0tWb2tkQVY0?=
 =?utf-8?B?YkVRNWw5U1lJTHNmMnlMUVoyUUZkSjdBcW9sdjdTVU9jQmlmSml3TVJQaXFh?=
 =?utf-8?B?TGFqT09jOFpVVnRlNWxyelZieEZqTUwzS1k3LzlTY2VUcWJ0Q1lMSi9GV1gw?=
 =?utf-8?B?RktCek1EM1FpL2YwWGh6Mk9Fekxuc3pZWTVWMHJscmdnSDAxditGdUZKYjU2?=
 =?utf-8?B?QUtucWVJUkh5cGhaTittUzRtUUdJcm83ZHFoeUJwUTB0bVhsV2JxdmJBdWlN?=
 =?utf-8?B?V1NucExlNUhpa2hPcDJ6QlBnRk5yNlNMVm5iQUdzMnJDaGozMFR6QW9Nb2hr?=
 =?utf-8?B?ZC9Xd1R3eE14WjJ0K3hEdXFyczVraENUR00rSzFMWSs0b1BtN3NiS3ZNa0Va?=
 =?utf-8?B?b09Qa3ZnT0xMdTlmZDBncHRodUVIQ3VGeit5R05GbDRWQUI0L1pIMythb3RF?=
 =?utf-8?B?clBuWlRURkNkR1dwbTBXM1BRVnJqM1NzQ29HSEluQm5uUDRnbVZQc3ZPWENo?=
 =?utf-8?B?SENoSjJFcGd4QXkrZWRuMXcrMi9HWVM0NVBkWkFuL1NRUm9YN01LWDY4YldL?=
 =?utf-8?B?eEYzcW5KN0MzdTFiZTl6c1ozb0o2Lyt6SU1YeEM1UnFrTzJaU2FKeGRYWFJZ?=
 =?utf-8?B?VWJDQk9HQ24wQ0pEOXp2cHBCV2NROHBycnFXRXRMV1VuMEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:44:26.2642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0957363-0227-476b-f024-08dd0b367446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
> implements.
> 
> Add a new field to cxl_dev_state for keeping device capabilities as discovered
> during initialization. Add same field to cxl_port as registers discovery
> is also used during port initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Dave already mentioned the one error I saw. With that fixed LGTM, so:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> ---
>  drivers/cxl/core/port.c | 11 +++++++----
>  drivers/cxl/core/regs.c | 21 ++++++++++++++-------
>  drivers/cxl/cxl.h       |  9 ++++++---
>  drivers/cxl/cxlmem.h    |  2 ++
>  drivers/cxl/pci.c       | 10 ++++++----
>  include/cxl/cxl.h       | 30 ++++++++++++++++++++++++++++++
>  6 files changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index af92c67bc954..5bc8490a199c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  }
>  
>  static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
> -			       resource_size_t component_reg_phys)
> +			       resource_size_t component_reg_phys, unsigned long *caps)
>  {
>  	*map = (struct cxl_register_map) {
>  		.host = host,
> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>  	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>  	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  
>  static int cxl_port_setup_regs(struct cxl_port *port,
> @@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  	if (dev_is_platform(port->uport_dev))
>  		return 0;
>  	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
> -				   component_reg_phys);
> +				   component_reg_phys, port->capabilities);
>  }
>  
>  static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> @@ -789,7 +789,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	 * NULL.
>  	 */
>  	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
> -				 component_reg_phys);
> +				 component_reg_phys,
> +				 dport->port->capabilities);
>  	dport->reg_map.host = host;
>  	return rc;
>  }
> @@ -851,6 +852,8 @@ static int cxl_port_add(struct cxl_port *port,
>  		port->reg_map = cxlds->reg_map;
>  		port->reg_map.host = &port->dev;
>  		cxlmd->endpoint = port;
> +		bitmap_copy(port->capabilities, cxlds->capabilities,
> +			    CXL_MAX_CAPS);
>  	} else if (parent_dport) {
>  		rc = dev_set_name(dev, "port%d", port->id);
>  		if (rc)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e1082e749c69..8287ec45b018 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <pmu.h>
> @@ -36,7 +37,8 @@
>   * Probe for component register information and return it in map object.
>   */
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map)
> +			      struct cxl_component_reg_map *map,
> +			      unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u32 cap_array;
> @@ -84,6 +86,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			decoder_cnt = cxl_hdm_decoder_count(hdr);
>  			length = 0x20 * decoder_cnt + 0x10;
>  			rmap = &map->hdm_decoder;
> +			*caps |= BIT(CXL_DEV_CAP_HDM);
>  			break;
>  		}
>  		case CXL_CM_CAP_CAP_ID_RAS:
> @@ -91,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  				offset);
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
> +			*caps |= BIT(CXL_DEV_CAP_RAS);
>  			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
> @@ -117,7 +121,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
>   * Probe for device register information and return it in map object.
>   */
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map)
> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u64 cap_array;
> @@ -146,10 +150,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>  			rmap = &map->status;
> +			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>  			rmap = &map->mbox;
> +			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> @@ -157,6 +163,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>  			rmap = &map->memdev;
> +			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
>  			break;
>  		default:
>  			if (cap_id >= 0x8000)
> @@ -421,7 +428,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> @@ -431,12 +438,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
>  		comp_map = &map->component_map;
> -		cxl_probe_component_regs(host, base, comp_map);
> +		cxl_probe_component_regs(host, base, comp_map, caps);
>  		dev_dbg(host, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
> -		cxl_probe_device_regs(host, base, dev_map);
> +		cxl_probe_device_regs(host, base, dev_map, caps);
>  		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>  		    !dev_map->memdev.valid) {
>  			dev_err(host, "registers not found: %s%s%s\n",
> @@ -455,7 +462,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	return 0;
>  }
>  
> -int cxl_setup_regs(struct cxl_register_map *map)
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -463,7 +470,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_probe_regs(map);
> +	rc = cxl_probe_regs(map, caps);
>  	cxl_unmap_regblock(map);
>  
>  	return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a2be05fd7aa2..e5f918be6fe4 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -4,6 +4,7 @@
>  #ifndef __CXL_H__
>  #define __CXL_H__
>  
> +#include <cxl/cxl.h>
>  #include <linux/libnvdimm.h>
>  #include <linux/bitfield.h>
>  #include <linux/notifier.h>
> @@ -284,9 +285,9 @@ struct cxl_register_map {
>  };
>  
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map);
> +			      struct cxl_component_reg_map *map, unsigned long *caps);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map);
> +			   struct cxl_device_reg_map *map, unsigned long *caps);
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> @@ -300,7 +301,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, int index);
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> @@ -600,6 +601,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -623,6 +625,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..4c1c53c29544 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -428,6 +428,7 @@ struct cxl_dpa_perf {
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   * @cxl_mbox: CXL mailbox context
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -443,6 +444,7 @@ struct cxl_dev_state {
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>  };
>  
>  static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0b910ef52db7..528d4ca79fd1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -504,7 +504,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  }
>  
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map)
> +			      struct cxl_register_map *map,
> +			      unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -521,7 +522,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	if (rc)
>  		return rc;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> @@ -848,7 +849,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxl_set_dvsec(cxlds, dvsec);
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
>  	if (rc)
>  		return rc;
>  
> @@ -861,7 +863,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 * still be useful for management functions so don't return an error.
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map, cxlds->capabilities);
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  	else if (!cxlds->reg_map.component_map.ras.valid)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 19e5d883557a..dcc9ec8a0aec 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -12,6 +12,36 @@ enum cxl_resource {
>  	CXL_RES_PMEM,
>  };
>  
> +/* Capabilities as defined for:
> + *
> + *	Component Registers (Table 8-22 CXL 3.1 specification)
> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
> + */
> +
> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_SEC,
> +	CXL_DEV_CAP_LINK,
> +	CXL_DEV_CAP_HDM,
> +	CXL_DEV_CAP_SEC_EXT,
> +	CXL_DEV_CAP_IDE,
> +	CXL_DEV_CAP_SNOOP_FILTER,
> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
> +	CXL_DEV_CAP_CACHEMEM_EXT,
> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
> +	CXL_DEV_CAP_BI_DECODER,
> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
> +	CXL_DEV_CAP_CACHEID_DECODER,
> +	CXL_DEV_CAP_HDM_EXT,
> +	CXL_DEV_CAP_METADATA_EXT,
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MEMDEV,
> +	CXL_MAX_CAPS = 32
> +};
> +
>  struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>  
>  void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);


