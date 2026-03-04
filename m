Return-Path: <netdev+bounces-263865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJxAH9xSqGnUtAAAu9opvQ
	(envelope-from <netdev+bounces-263865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:42:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC720303D
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E936D305F49C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8134846D;
	Wed,  4 Mar 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fRE7AH3S"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A8344D9D;
	Wed,  4 Mar 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638388; cv=fail; b=eBxnG2ZyQvao6l2AfeJ4VEmm6boXKkqfpGv59uJc1jsO/tYKZKqr81xU7MkEqGWaHPfNKEw86X6oJTjISwWX2MXueamxG0QeR0wLIWLtzcAAmfFhSBROaZ9lPoV/zygv2YfrwkTeJ1tVd84IdwnAeSO0qNRz8fvIwC0bxuV8N6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638388; c=relaxed/simple;
	bh=GOJqMKuNf/q84rKxliKXDHXAbzBNfCTmEMLndqm8a54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M+ln43efvbYy3goB01fdB4+tcg3a6nBCoe5awiFSM26H9zazuMtuhKxTm2GAf1ESf+CmqoTIZIfFf160f0w7XLBk8EkLOQFS72ZHDDzzO9l36B+Oeim9tGW+FlBvYxC7v5oxnNIsngGwlDLvimwoQZtOJ3YAa+kkYHRTF8QtJhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fRE7AH3S; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNqOXx/5WxeebwUHPWdRcYdczNX7uUqUeRfN1ubI4eUxZ0hwB6+v3H6r2IU/Yf7FcTTNmTKF0SYVwoiaHGpqAzvwfb1kMrFjnGQReiAY5o0vYL5eYeH+8WgCk8qg/mpo5EXXESFIv7MfFdKIpzoXzrDCrRVNphLG8YWx49oQDc0zLRZ3tVrhPNaHDJUFOm6WNv9bcILSzlLi+xfkOMXSZ3eI1VmwhxvAxhsAiAtexbNiarkg3xbxFkLKfLWweoPnFbXzltS5UPkmOdqRXvkT/XmZWMFlVTOFCwQYpDytreHg4oQ46jpNiTKJfvU07KyJxF4Zmd8+A1MNf0okRi/Hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfx+MSjVxPFosW3PhgfKPcE0JyCotNrKDWB8TxDQAQU=;
 b=Dwun/KTPodNFQ7XVMDmqxrw+tZWoTbstJ1CZ5WOul1/OWv1zwunISgym7YysNP2VEaM7B3B1FATYldcufbG6FUjGnjRGvON68YN6i/v+yPPopC1WnFRDRxHEfnNA2SYBTq8PKACJrSgMrSfywaEqseZywx5TUSsq+eCEtphJSkZMeaL3mzuNcNoZZBzoC8DXTTodvwPZnIYCu/i3BM+5smZxUDSXXJ3YvuoKfU2rEaJefQPpzcaK7/BYqbE9hFc1jY98Ual5Z8hvyyNJlNk5+alG4wA31DNI2wDCYFqfGT+IgB9mTk0hPdSQOOHnvdEsX6B9Vb5+YAbv+kiaSmKg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfx+MSjVxPFosW3PhgfKPcE0JyCotNrKDWB8TxDQAQU=;
 b=fRE7AH3St0gnsxXVLFJb4R/QrXRsYyt5XjSk4JzJpR4yPMPSvRSYQj6FTBfqsl47V1zFjDh1/69iHK4n7mTH6LEuT+xU+RxN/M4Yp1jtTBMTARji+y58wiCTrVNaSX9vYpMjOz/15rBKDBFdUvLniFRsRxRKQnlsgaiOhSPDh4o=
Received: from BN0PR04CA0203.namprd04.prod.outlook.com (2603:10b6:408:e9::28)
 by IA6PR10MB997608.namprd10.prod.outlook.com (2603:10b6:208:5dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 15:33:04 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::2c) by BN0PR04CA0203.outlook.office365.com
 (2603:10b6:408:e9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 15:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 15:33:04 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 09:32:43 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 09:32:43 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Mar 2026 09:32:43 -0600
Received: from [128.247.77.204] (a0500327ws.dhcp.ti.com [128.247.77.204])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 624FWhco605514;
	Wed, 4 Mar 2026 09:32:43 -0600
Message-ID: <811312d5-a48a-4ce9-80a2-7c04d0b34a67@ti.com>
Date: Wed, 4 Mar 2026 09:32:43 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add ICSSG0 dual EMAC support for AM642 EVM
To: Meghana Malladi <m-malladi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>, <d-qiu@ti.com>
References: <20260228113203.498839-1-m-malladi@ti.com>
Content-Language: en-US
From: Daolin Qiu <d-qiu@ti.com>
In-Reply-To: <20260228113203.498839-1-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA6PR10MB997608:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d8e225-ac7e-4e9e-c84c-08de7a0353dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|82310400026|36860700016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	iA8bmWxDXcbYoHm+XrI0xARvoIkV1z+tMGhlFylWxCdCqVHqJEP4RAqVOVkG1KwarLRQsRUgndQC8TiNvVHDsEPB8chvSgu8u17MMJtEhqwKiOL+4SnxqcRVhfpQvMb5z9lOwykEAf39sQ6j5xSwkp9JVVSGux9xyqMxeRPNGlIZI2yf5mO//YqFNR26gG7FTm0Qa9Uu+zUriCu8yyDKvI1Nfhfa2Nu8kpeNKjDq/K4DSyFVoUSfNSWoymJrWeDxhx8CxkLJpNkshCUeMaNR6kQ+H5V1Vyb2skYtow+so2csUsxk6kYq/dzPRwWiT0maC3YHWdJNknhWqgQmQy+JCosLDdBf7JAHQCoBARBOAq1IHmV+3BAStry8wC4h/KyojatJTRU+pFhkkUd/V/t+I8X9sv8QAnwhuDV8HnnNbN6sG6ECjVmX8YbWPBC4LlP2RvgV6zdOACjxXMpcTnXRiRKwnARMo9r61mL790UoEJQMqpJ/wYllRhOLbCYKFesv8SZeu1vnPu/TYt3wmM971ARnMkKs2CgBLn1CamdrYj4DIAqwmyDqidTl/jup6Hl/KgkOxuwDDtqv63F6fD/p0lnlIJ9BUY51KbOVpietCytweEpTVMDIaAWoZ0AsgQXMe8op3jiu7psJAuhk5eRx/8ndHy3iVwLuiuCb6+rnvPDz0A3ViPP37rL+mNOQChwV8rtvsjWSaQW38GFCLrieWseML8NVTJmlRK4s4BrJIcKAvlJEnwsgRwVHfMqcYnIn4QIZ22Sb1svpCzVhIJFTBubCJ/oa9IVCHbehU1IItaE=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(82310400026)(36860700016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZmgmmnFPKmrU4R6weLLj74t7QXlmz0mrOxGILwmUUrcsxMz+mX/KGy7+bqjDRfDRfdPHVocAqIGf4RWmmxNj1A2GPglsxAedhDluivgsLScxy2eW5bKuxgSG4su4Fo0dkz+65UvVvPfi3NlAiGknUPL1Xk7acj0GQrepWO/fY75luqFpFSeGCL0CnByGdixYX6EqymC4uyWoj1ndL2uaDXSZNjeIA98PMK8Yh6rEknniu1fRpsRasaHIikD2zrz9K0D1sP3IlBqDt7OSkcoxpU/723AJAE1wsDM6N6R9TW+zLPUP1fKzgo5eV/vTMl2lFNvFBKYmeWBnCdDVRBbkqNIZFv/TTBGOmQqSnAnmbz+2Mipd60apfIikqfwKOx0+Ctpfoi+QXvIycdrv9hTxgIRtozCYDvsYKbbg1HyJM7wMnVWR1BNIqarvvJ36+ay7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:33:04.2542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d8e225-ac7e-4e9e-c84c-08de7a0353dc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997608
X-Rspamd-Queue-Id: 94EC720303D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-qiu@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action


On 2/28/26 05:32, Meghana Malladi wrote:
> This series adds device tree overlay support for enabling ICSSG0 dual EMAC
> on the AM642 EVM, along with the necessary PHY driver configuration.
>
> The overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
> dual EMAC mode and can be combined with the existing ICSSG1 overlay to
> enable all four ICSSG interfaces if needed.
>
> The series also enables the DP83TG720 PHY driver required for the
> DP83TG720-IND-SPE-EVM daughter card used with the ICSSG0 interface.
>
> Meghana Malladi (2):
>    arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay for dual EMAC support
>    arm64: defconfig: Enable DP83TG720 PHY driver
>
>   arch/arm64/boot/dts/ti/Makefile               |   4 +
>   .../boot/dts/ti/k3-am642-evm-icssg0.dtso      | 203 ++++++++++++++++++
>   arch/arm64/configs/defconfig                  |   1 +
>   3 files changed, 208 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
>
>
> base-commit: 4916f2e2f3fc9aef289fcd07949301e5c29094c2

Tested both ipv6 and ipv4 ping to be functional with the following 
topology.

DUT 1 eth3 <---> eth2 DUT2

DUT1 log: https://gist.github.com/dao-qiu/f261147110b6b05d1fb989ee74e1d694

DUT2 log: https://gist.github.com/dao-qiu/3add536e2370d6afe36145f46df784e6

Tested-by: Daolin Qiu <d-qiu@ti.com>


