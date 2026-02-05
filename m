Return-Path: <netdev+bounces-257166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKJGBFSahGmh3gMAu9opvQ
	(envelope-from <netdev+bounces-257166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:25:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D715F336F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C485730166D0
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F663D668B;
	Thu,  5 Feb 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vOlbgeH1"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB03C1969
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297930; cv=fail; b=VTuh1xTTMweTx/uXPj0Bx+paz2f5TvUAw9951XO7/ZcqD+691dnSzluRX/TMOK405OFYAT8Ewym4BHQJgf8sdCpoP5NbFFlxzr47gtguQbSWpEH7iaIlqp3u7sazBifSvIUshjb93KDtMHkVLCWv2mxFHxjwRNNEZEH39yzNdHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297930; c=relaxed/simple;
	bh=yhumLjH0ij2zBCrVgp+u9gzzByEhdeo8WaFAAq08QwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=omb2AckEASsISU64a56T7j7ji3vOa/72E2OZWwIsG05cS9pBHrcdvrpL8VwTdebGsPRFnBXZjsDBCJKE0b6NqZc5m7turbv2jtbL62eGnXq+D5Fjnilyp1jZAqnuI6e69aEuWrc3fx4ss8u2W+llx5WjSt2nK5g2yENOiTgixCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vOlbgeH1; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS3z0aMpA1Z9FCFlSWPJKKbmoGZgcPkx7acap4X/CKTMSoLeDsGEp626TrNmdkl2t9XvVcKohAg/rAwfwYSpL6uht80ee52FovzWivDLcvnvubHNzOFVzyYJWzvuW9b6ATKF0YXWlN3ErjNtOWNxGz9FtX/1p1EHY+YmpfXKc2glWbdYteSaNd2x5lXnSSzFVCB+9T9v4bVks3x/YSXx+Sg+dOhwixuKFWPpOeVD8MiS9vs2BQ4c/A3f1GidRKKdjfVaM/Tzg+7ea6jkYpuOzRv0LmbzK0t4Va0GYrzy8FlNPDhq4Zvhw4JsHpKUpX3UpGdxw5LVvB9ctOBZiRymHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p10qTnJ7wyynWH/4psBvkq5Ej72JAwLmelU6QIi4XTM=;
 b=j6fKP77n5Ac2l58pQFubj503aTkAbvd5XzodpQ9t6wHGopfuaidXO0gQ9oXZB7zhjIQYN6PgtRu39UoREuekTfsLA3tZFvDoYaUXOhTl593cN8fGTMLht3ON+L6GbkEP870kFjeTBlTC6UrxJnVgKaKMiOx0XHjWPfiyIWiXENqm+H8BSJdr97BrbtIpW1YNWp/utOZ6LiKbAldM4WLttMI+ImWdfFfYDdARDA7s0b/F4kaKA2gB/FXpXthcN9ItjhNeAURGSr+7a/dqVncd4uNpkH63pbA3HFmcHZ6Zgk3924UgBifs2JlAv5vMttZCW3IoVuGgWIw4x5cu3XRd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p10qTnJ7wyynWH/4psBvkq5Ej72JAwLmelU6QIi4XTM=;
 b=vOlbgeH1hnBVGYTTZIDZ+kugf09Ypo75GnCAAqQ06Ue4s3dwWNIZwlhGY1yLvLxXIHBA+ptlyso0IqMPcmeJP0iDYuCC10M4wZDqbhVJyg4ovcXucPYrL793f3qbZNQ8xHMMNnF3KouOgS6USdQ4gu7tz4r4FmP/i/A2iOvSHYY=
Received: from SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31)
 by IA0PR10MB7327.namprd10.prod.outlook.com (2603:10b6:208:40e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 13:25:26 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::4e) by SA9PR13CA0086.outlook.office365.com
 (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 13:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 5 Feb 2026 13:25:24 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 07:25:23 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 07:25:21 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 07:25:21 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615DPH0B3048099;
	Thu, 5 Feb 2026 07:25:17 -0600
Message-ID: <4ec089e4-9721-4c55-a90e-a26630ecd91b@ti.com>
Date: Thu, 5 Feb 2026 18:55:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH net-next v2] net: ti: icssg: Remove dedicated
 workqueue for ndo_set_rx_mode callback
To: Kevin Hao <haokexin@gmail.com>, <netdev@vger.kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Himanshu Mittal <h-mittal1@ti.com>,
	Simon Horman <horms@kernel.org>, Byungchul Park <byungchul@sk.com>, "Markus
 Elfring" <elfring@users.sourceforge.net>,
	<linux-arm-kernel@lists.infradead.org>
References: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|IA0PR10MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cf3938-4abf-4fbf-1d29-08de64ba04ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVpMdmZuWGNYbkpmVzkwNGR2SGVMcnFFbElZekVwblFEcUpEM1BOckpuVUha?=
 =?utf-8?B?a0xNNFZFNGVGU1Q1Y0hxcmNNV2ZnVUdnaGpjL1Z5b240ckxyclhXalh6dzdU?=
 =?utf-8?B?KzNtckZyUStFOGxvU0ZWck1zOCtkUU1oMzBZZldkZjBTSGg5eVJtUzVaK2RD?=
 =?utf-8?B?TE9MbnFqL3dURnphUVVHUGdtNm05bk5oV1R2NnZiMlEwZHJ1anRxTWxncDB3?=
 =?utf-8?B?d0ltUG9zRnJuNUNXd0tVbGZDd00xakxMV3BXZm1aallDd3BDSVpFeWlzK3hh?=
 =?utf-8?B?L3FPem5QYldLdFM1d2M5U3NrdGdESlpGVVJxVDc2Tjg5T05RNVdZZTNyYUg3?=
 =?utf-8?B?RkVmY0RqQXQrSUM0aUQxRGZhMGhySE0zVCtqcTJvdStQM21ycEt4S09iV0RK?=
 =?utf-8?B?SW1kVjVMY3padHkxUUlyaGdJSDBvY1ZXaGcwYUtQZW52N0RFQnhDZmg0dWFT?=
 =?utf-8?B?YVlwOFNIRUgrL0U3bll3WjdtaHhGbEtYSU5SK3pVT1hpQzBYK2MwUnlMRUMz?=
 =?utf-8?B?OHcxSVpLakhlNDdWckFkZjN6RG5HaVNTeGlVc0h3RUdwL3ZNYW1TU3VwUFFI?=
 =?utf-8?B?MDRsczlOdC9SQi9ZRnhjWXBDa1M5YUJzOHJsaDF5SmZNUEFvWjJ3SXBxOW00?=
 =?utf-8?B?L1ZhT1dTc0VEUXBIUGJvSVFjV1RXQmdaaksvbW02YjFHNHh1bENwd0ZxQ2Z0?=
 =?utf-8?B?Ykk1NlFCSEdkalZVeWFuVWYrSU11ZThnSXF5d2pLZmtaYkRmMEQxTit0c1Y4?=
 =?utf-8?B?cFdZdlhuVktsKzZMcHVHOGxyWnJWZ0k1dTFDc3hLNWNGcURpZGlTQStmSVBU?=
 =?utf-8?B?UE9tNVVFYmJzejdxVlNlQ1d0bDFnQ3hSV1RlSnNqZHpYZmFMUGs3cGhRQ1ZJ?=
 =?utf-8?B?elJ4UHJPTFo4cXpjeFFHT2hycHdpdTNOMGl2WGpINysrRS80N2QwaE02emNG?=
 =?utf-8?B?SjA2aUpLNUYzYm8xbXZ3TnBjMURhdk5vdXpYUVZDVW4vcklyWiszSm9wdUFI?=
 =?utf-8?B?eTdwb3ZxaHBWTlJGeWF6S1FyaWVNamNhY29MQ0hKRElPU2NWVVFGSm9Ud2tt?=
 =?utf-8?B?NCsrTS82MGtFd1VYbGYrajlUSlZPcDJYOXYvMlJqU2o2bHc5QmZoYzVFN2hR?=
 =?utf-8?B?UjVvUndzSkpXeUUvTmIvU0YraVZXSUUrRHRrdS9ENjd5ZlNvM3VRakZxaWhS?=
 =?utf-8?B?dVlQcFVDMStYSzJRZDBlMnJMS1ZRdDdNVTZJODBla2RJYnU0RlhlMjFPa0E5?=
 =?utf-8?B?VDRTRmtHVGt3KzR1OFlsZURMMDFVUmhqMFI0aE5mQmxQblpObjIvNG84SGRD?=
 =?utf-8?B?YzM4RGJQQVJkUGxwS041a2dmNlFwMjZrZFRqb0pPdWVGeVNUdFpIRUtSQ3hi?=
 =?utf-8?B?SzFtMzZQY2hYanNmWXdWVUxlTk9wRUhPeFVHS1Fyd2NZd2xiTjd3Z1ptaTZR?=
 =?utf-8?B?bUVlTy91TTY4TWFSUUIvdFNNb1hzbCtUY0g5KzJFclVCMm1RaDJJUE9heHRr?=
 =?utf-8?B?dG4vZDVlcFRRWk5oREJVWGRpR0VaTXhmQ3FIOERIWTRMT2xYRmVHRGVWOEVk?=
 =?utf-8?B?ZXFINWZoWFUzVjFzK1RVemFNWlowN1d1MU84Q053SFNWNUZtLzNFZDhkQ3dx?=
 =?utf-8?B?S2dqMkdyWlRwd2VpVW5EMHNTZEJSODlVT0k4TVJORzdRQnBKTm9DMm9jVTR3?=
 =?utf-8?B?d0tXbm1GbTM1Q0FZc1EybUJDVVNyOGpFcjJDY1FyTkFsVnN5R1UzR1lNMkk5?=
 =?utf-8?B?d2NCTVMvZm9naldzMFFIL2lDMmlyNWx0aUtGNTdTd1pRZWJjenQ5RE54dXYx?=
 =?utf-8?B?eHE1YkV4Zlo2VEllbWhuYlI0QWFrdDNVN0tteENlbkhDa3owRzBXaFczNVRh?=
 =?utf-8?B?aHEvNm9vUXIrRGIxczFQdFZZM2IxcGRiekpuL2cvRklBaGNtTWE0YUVWVzJq?=
 =?utf-8?B?a3FuS3RoaDhYRlMrYXFGdWljR250YTUzQlZ6bXZIWURUR2lCVHVGbkFWNExh?=
 =?utf-8?B?N0JIUlIwMHRmdGtja21POWMwVmZXeXNZVXBnc0VydFl1bHQycjJVdEZ4eFQ0?=
 =?utf-8?B?WDd4c2x3NC9XY3p6dlg4bDhaRjZtQVRBUVFWOWlsd21DYjVKUkhyUXhCWVp6?=
 =?utf-8?B?WlVmOW4rRy9NYXk1T24xUFE3VzR2V0FvM3pMdEVjQjV6MFQ4SjVOVW1NZDFB?=
 =?utf-8?Q?/tZXpBmz4TF5IeXyt/5DOSA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RWxrMUQFSGVQwpQJkdY46H/ZN0IQDHayah8kCG9wMWnWYEOM8ySf+PAx66PS/2EL7ETruMBOSVnc3lItngDU8bXco4P4nuLUNvbgcXaQ+a/iFKEAq4aWbJulXlSscSImCEdCAW10derHRfkN5BOAWTP1muFyuN3qoN9x2GvKND8eK+JW1sZgpmdFSdh9gG457fdL5h2fo++5psgRV1v3CV9ZzlTNyQj02Fo8ZWvMLBeFZMN3W/7Fhs/RQfQQbFsN0efCNz2qI+VxpPN1ui5ii6la5OwjZjaONPxQo1kGgNEpazh0WANIVY2uT++rjr6Ql8zOz07XHv6jMjf494xhyWFVK/O0cWE0qLWNnD4Bv+tS8hbNPgT+PFomoOAKE70CS/V41tioJ1HXybBL49MuClDGh9f/bFKd+Hao0OhIW9ERxkaBYnmxP4uL2S4XeXSP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:25:24.1545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cf3938-4abf-4fbf-1d29-08de64ba04ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7327
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257166-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ti.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7D715F336F
X-Rspamd-Action: no action



On 2/5/26 11:55, Kevin Hao wrote:
> Currently, both the icssg-prueth and icssg-prueth-sr1 drivers create a 
> dedicated 'emac->cmd_wq' workqueue. In the icssg-prueth-sr1 driver, this 
> workqueue is not utilized at all. In the icssg-prueth driver, the 
> workqueue is only used to execute
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uxdqXRfPtm1bKqXPFrvrtjTYQ8PpETcsXm4BwzS8mboFbVY11ssua4wfTbejgHbxjjWn8Pd03T8mRUc-C2Ywijhr0alXjcHhfRE3zQch7w8HkSQ$>
> ZjQcmQRYFpfptBannerEnd
> 
> Currently, both the icssg-prueth and icssg-prueth-sr1 drivers create
> a dedicated 'emac->cmd_wq' workqueue.
> 
> In the icssg-prueth-sr1 driver, this workqueue is not utilized at all.
> 
> In the icssg-prueth driver, the workqueue is only used to execute the
> actual processing of ndo_set_rx_mode. However, creating a dedicated
> workqueue for such a simple use case is unnecessary. To simplify the
> code, switch to using the system default workqueue instead.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> While addressing an issue in the cpsw driver, I based my fix [1] on the
> implementation of the emac_ndo_set_rx_mode() function in icssg. During review,
> Jakub pointed out that the dedicated workqueue for the ndo_set_rx_mode
> callback might be unnecessary [2]. I subsequently used the system workqueue for
> this purpose in the cpsw driver, and it performed as expected. Therefore,
> I believe the same approach can be applied to the icssg driver. This
> patch aim to remove this dedicated workqueue for icssg drivers.
> 
> Please note: I do not have access to a board that supports the CSSG PRU
> Ethernet controller, so this change has only been build-tested.

Based on the changes I have multicast and promiscuous modes.
logs: 
https://gist.github.com/MeghanaMalladiTI/9598b33848344027772a5bf759b1bb8e

Tested-by: Meghana Malladi <m-malladi@ti.com>

