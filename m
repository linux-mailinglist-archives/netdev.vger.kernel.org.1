Return-Path: <netdev+bounces-254874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO2CGkuae2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:35:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7CB2F6E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA77330036F2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F21346E6C;
	Thu, 29 Jan 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C9TYwcLd"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DE1DF73A;
	Thu, 29 Jan 2026 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707902; cv=fail; b=fHADtMJC0zfzziygwkTt+F8qv6ZrpRiZQnFuMDav42uQymzUULq70FrACQ3CC/iLMlskQHclzCMN31u2NPo2fg/XMf01+xknYlVN9cHZh7zxseS9F0vw7hY932AKGrd7MbDzzXCqsS93AA37eXIXXlFuRMILflEvhGtPvlNTLB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707902; c=relaxed/simple;
	bh=kGlaJjltJVE99fg4p70oUEBbKvu/xlsbYaT6omeFcco=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mAfXwJ29RFo+I1FEp+vGFF89GXfbMws7pUQ5onnULeZzYUIR2TDvV1LKFN18SKJ7Hk9wxmJ9aDNX0e/XiXkfJ5gLhFQmEUw1Oj23hmOqAWO7G/TXy8wedDNELIIclWU7WqBk7DVArKg+g7v2vZ70cNi78O49/NYGPqPxrk95SHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C9TYwcLd; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT4AZhM+p1j6yKXYst85olJt6Y9Ac3aCf41HCkwbqqknJMlZJE0kpNj8wSmOejVcqAwp+0jOO7pgki85HNUo/AP/Go1u/g0a7v4qT2hs4o97n2fL+CUdB2iV5YDy5746JTc2BRkZ2XoDaJo+2le2fuDLTCeNiXY0Op5TpiE331MCOiimJdTpoc2BG3lXMKWjQ4NA0O2ZqSqk8QqaOR4qlllfS+ATytCeo6yqfVxis+4iH0PnDpHtCt1LBiHxmLP1ZpuP3qqS1G6C++Tcog33VrLPtDlLzmo3800lh9RdYFBgqy3HSYJkyLPT1devDDhdP+vk3Aln4yN0ZlrdRhGWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djM7YEFuqPTMn2i5CgjwsanHHMItEMxm0XAfTXNVk+U=;
 b=yqbOCG/sHNXCilN9NFUX53FOWUJsDfsYFBEcg4RSyB7oKDcypxDsEaQMpa9jNlUDbPBvL8VnuIW+vZx2WVmUYPqkQOvjgvxNeSkExF4y4G+oAC9zygc6aqj0BKbvu6gZHXeexjtSej+8TS6HZj+CKS6w28bS83P0tA7Ot0WxppMEeRPkwz3tMGT52+LNLSDK7aYJzPG9Yiq3rk+cNXaJwhUbX5+XpmdKCOf8CCD/azvr79QIA9a3anmjJ8gRhjoG9tjQahuZsC/961ytBM1cwpNOuBALeDLsUo7D2ksobYK7n+NPgR1UiMU5TLjenPmdF3yBbcNnyQ6LFm5874010w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djM7YEFuqPTMn2i5CgjwsanHHMItEMxm0XAfTXNVk+U=;
 b=C9TYwcLdkhE+20DZnHTB22R+VYDG3jtKihj+iMUHH4+4xLvjyzf9NbVSSf43yutdNqbcoCSaXq5Xlz4ZcYfR4JxuT7dtVezrInagCxW7/dTfyMCRS1JVyCrit/I+18QNT6a4Gb4glsBz7Sb06II25sF3G09XvuMtoqMzBeXv6qo=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 17:31:37 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::3f) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 17:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 17:31:34 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 11:31:30 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 11:31:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 11:31:30 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60THVT804118949;
	Thu, 29 Jan 2026 11:31:29 -0600
Message-ID: <b7b8f855-bf38-41ba-96c4-1bdc3a1c2cc8@ti.com>
Date: Thu, 29 Jan 2026 11:31:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net: phy: dp83867: add numeric impedance DT property
To: Teresa Remmet <t.remmet@phytec.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>, Benjamin Hahn
	<b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
	<j.remmet@phytec.de>
References: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH0PR10MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c7e133-1279-4909-9c0b-08de5f5c4009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUozMmpzOWpkQlpNUGh0MFdsRGNqOHIvS2hzTVdibFI2OThLUTdVTW9yY0Zq?=
 =?utf-8?B?alVQWFU5YmZ4OFVEd3hkUC9ON2NXN1Zjc2Vmc3UzVi9BRUl1VXh6YkxrSk9q?=
 =?utf-8?B?NHhGVmZuekY3aUV3ZWVlbzcvYk8rVVMzMmhRa1BRcTdlNEdLRDRsOWZvRVdC?=
 =?utf-8?B?ZHJxSTJrczc0LzdjaDEwS2Y0K1JubW1tU1JzQjR3R05qOWg5aGpaVzQxcVcr?=
 =?utf-8?B?K3BuYW80aGVPVnorUVRIUUNmYU1xOTdFQVYxRkhQS3RUNG40V2lQQ2x6aFo2?=
 =?utf-8?B?VnBKTStNSTY1RVJXUStNeVZnRG03YkQzNnVkalBmSWxvRWxRZ05CMEpsclJL?=
 =?utf-8?B?RHpydWMvNWlESnZNZGJvSG5UVU9kTkl1eEZ5bW00UWhuZy9meDAwQXFFMzVY?=
 =?utf-8?B?cGpHbDcrTHZKUzd3TXZUZWpwbCsrb0tPa1ZtMWtKL1RMblFZc1FJNzczUXdJ?=
 =?utf-8?B?MktBWVhrNmdtUFFxRCswS0tlTitzcERpZGFRMElWRkdBVVJkQkFhVUdlM0xX?=
 =?utf-8?B?RVlCNUZaMC8xTHVra1VHZFlvbjZIWHFyK3pLZEhkSllCdjFlbm9jbTNqZFpr?=
 =?utf-8?B?c3FGZEVyRS9Vc2liUmhXV05GQVBUMWY5dlovTVArb1YrRTgwVjRwVWRkMDVJ?=
 =?utf-8?B?RnF2WE9WM3QzQVpKNjVtZ2RMS3Yxd0kzZHpOWVllWi9KODd2dDdpc295aVlT?=
 =?utf-8?B?aDEwTG9ReXh6ajkvWE03bUN3OENrY2tuV0ZoUHRUZlBiRjB6WlE2SXpLdlZR?=
 =?utf-8?B?TUcyd0xzYWdUNlBjS1hwZFlReng5MUNGRkJxZ2FpRVJOZ2gxcW9uRDh5UDha?=
 =?utf-8?B?bzAvSnpob3FxMXBZcnpXQ3pRdDhxRkJIdlExc04xT3ZyZUV1SVBIdWF1dkhp?=
 =?utf-8?B?aW9FQTU0Y1Jxemc3eGFhZW5HQ1FmanJpdjdyOWdWa3VNOWJUSTJWQTgxSDlp?=
 =?utf-8?B?RXVNb0VtT1dmYThlbHljc1VHNlBLN1lLR2U5NjNsdUtHRjBMWHpUY2t3bnQ1?=
 =?utf-8?B?aDhqZExETjYwbHJ3akU4allOZEZ1TXB1ZWlhM2p2UzVCVU9PVkhET1VVUFhU?=
 =?utf-8?B?elZuOFlIZWhkdml2N2dsbEpTTmtBVU1vUEpMejR2bU9tRDR2eGU3QjdZZm10?=
 =?utf-8?B?SFYvNEQvbitiWnJmZC9PWE1TSDZlMGJZem1PL0xXZUxXK3NYT2FDdzQzYmV5?=
 =?utf-8?B?ZnRjL0tuUUlDYlRNSmt3cFZlYjdMem82WVNES0Q4UXVXbTFLUVhVc2FZT0pN?=
 =?utf-8?B?M2VDK2krVHovdkJGZWRrSHFxa2tRWUZrS0hjTnI5Yy9Gcnc4NmtMOWwzMkFN?=
 =?utf-8?B?WTA5YzlqaTZVUmZ0L0pWaFg1blJ5Vlh2bUdSZlYrNTlveHFNRzBuSk45azcr?=
 =?utf-8?B?YXphangzaXFYa3phZkFYNEZGVEdUSTJ6Tm4wUWt4VFc0dGtqNTFFelUrUytL?=
 =?utf-8?B?Mk9IZTFjb3YvSE9tcG9Gb3ZWV2x3dXpVVkcyYmo4TlpyMjJKVVdzQTBpd1A4?=
 =?utf-8?B?djlxTmdWai9qdkV1WWphQTN4a29QY1hjTkJHd0sxLy9JSVBSTUp2c3VQQm5K?=
 =?utf-8?B?OXovUFN1WHN1T041SWhPWHo3cXU3dG5Sa3ZyOTZ2alNiVng5Wk5SYVI3UVlL?=
 =?utf-8?B?ZHo0VE5JNkVZMkJvSHMwTEMxV1MwSGZVaW0xMTd3K04xQm9RYW9xRDBKRTNh?=
 =?utf-8?B?U1kvUlc3dEE3ZVd1S3hkUHZrMjVxcGNyc0RlZDZqSGRlQ0lONk1FNXlmbWJJ?=
 =?utf-8?B?T2Y4UWVuVUdwNFBZV3FHU1o5YWR6QTlhTHFsVHp2eDNsdSt1OFN5Q3BTMHZv?=
 =?utf-8?B?ZHJhTUZxRU85T0xwZ21jczNjUWUzbnpPaXR1NXAvVmZ5S2IrK0U1aUoxYTBo?=
 =?utf-8?B?UWRMWDhWMzNKVk9uWkxwRXVUeXMvdHNUZEsydjZKSEk5ckhnTkFkbXI5UGpC?=
 =?utf-8?B?Y2h2THA1ampRZFBGSHhqa1Nac1lsYjFTUTVZN3JLcEdwZDBTNmhTaUxCeWtZ?=
 =?utf-8?B?WStlUFZzMWVpYVp0T2o1b0dqcU84WjlyWXpjLzhZWUcvNUpZYk56dVN4WHhD?=
 =?utf-8?B?bFpwcGpzQWpWOUQybDJHalhNUlkrbnVmQWx3TWJ3QjhPKytCOU5aY3ozZmpr?=
 =?utf-8?B?SDVLajN0TTMxenN6YStJY3hXOHVQaS9HQ05DdWd3a09EV1ZOd0FiVlhOVUNV?=
 =?utf-8?B?N0RyY3NoRWdXSEdBd1BhZ3lKazYyK2VEWXBjKzY2RitiMU1wT0JOZThGVHRD?=
 =?utf-8?B?WVR1UnZVT2dhQW56UXNjV0VRamhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XV1UHOzIgPkIzIlozZ36t5h5bpOo/oYjJ5n28ZSWZQwgQdTAkpkcMk0zkN+uzKjmGGsgXwc1hTRff2IvSgA+TbyF5xdxqg6bNfC+zhNRBocqy/3iyQViHoS9D2OQ2pe6UkDn6i0+PHrQz0+L/DRgw64DVxkKJ45IRYAEKkl7uA79XIEjc3rTQsaRI/pojhRTS2TZzvH6LF7t1E1SW3upst9lRkGtgscAaULowYXmSJlfp1yeUNTvHx1rifDlU8D3pX0ml/5zaO6U0yEdtd+WjN/qFp+8Xh+Df0yz4GSjH1yxQL89XMULmuri+M6nTqJBse/YZie+iNB77W547gMamXp6uHVTJl9s+YJYMnCVlExcmgPIXQy4S0YP2M6a6zmLxb3E2eNC8eW2H5o0KPByNEPhveNxM63IqmmNBqpAHAXRFgm3vzhkZn03FYx/6nVq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:31:34.7974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c7e133-1279-4909-9c0b-08de5f5c4009
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254874-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[phytec.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,armlinux.org.uk:email,lunn.ch:email,phytec.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afd@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C2C7CB2F6E
X-Rspamd-Action: no action

On 1/29/26 8:13 AM, Teresa Remmet wrote:
> Introduce a new way to set the output impedance over device tree.
> So far it is possible to pass the value either over an nvmem
> cell or to set the min and max booleans over device tree.
> 

We have a similar issue in our networking driver, we can either get
the MAC address though a NVMEM cell, or when that is unavailable use
fallback to using a hardcoded value in DT.

I wonder if it would make sense to add a new type of NVMEM cell that
encodes the content of the cell in DT itself..

That way we can use the same NVMEM interface in both cases, without
adding all these custom fallback properties to every NVMEM consumer.

Andrew

> In our use case we want to be able to set the impedance over
> device tree but the boolean values are not the right fit to
> provide best signal integrity for the hardware.
> 
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Andrew Davis <afd@ti.com>
> To: Andrew Lunn <andrew@lunn.ch>
> To: Heiner Kallweit <hkallweit1@gmail.com>
> To: Russell King <linux@armlinux.org.uk>
> Cc: netdev@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: upstream@lists.phytec.de
> 
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> ---
> Teresa Remmet (2):
>        dt-bindings: dp83867: add binding for ti,output-impedance property
>        net: phy: dp83867: add numeric io impedance DT property
> 
>   Documentation/devicetree/bindings/net/ti,dp83867.yaml | 19 ++++++++++++++-----
>   drivers/net/phy/dp83867.c                             | 17 +++++++++++++----
>   2 files changed, 27 insertions(+), 9 deletions(-)
> ---
> base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
> change-id: 20260128-wip-t-remmet-phytec-de-bspimx95-132_upstream-48188a567544
> 
> Best regards,


