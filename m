Return-Path: <netdev+bounces-258367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHL2BIz+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2DF128032
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22BBE3037781
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE43A33342C;
	Wed, 11 Feb 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C+aQ5UBo"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367933032B;
	Wed, 11 Feb 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847879; cv=fail; b=GrfDS0ckJHsHIxcsZZSJ///NinanVPM1FqIdTAxwOgiQniRNmWr2EudpBWJdg21NDBQSbt5Fim6S+gyHQro6HUPv1p3pNz8nVrTSxaMYcW1M8bFiHMwGCAbgg3OQVNtUjh3g4Btb3XoNve2uoZG1lnxWIYdGZOX9hkJYdBp6ksI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847879; c=relaxed/simple;
	bh=T8YlZS0OoZUFMYcZZieFHgxksJIZGUYzfjYvA3QcrtU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=EiLHmml9fsWOHCq+evdsguWCo1vEke5NJ0zjqFmfDEdd/kVKMZfw3t6x9fXqTLBOuJE9VYBncfdStvUQ8xIw/JefZS33N5/LB00sE0KLwQIbAM/CNWWo9d4x0zzS3dqPizVOmxa6nyGDELGThG5lqb1GU9Ss/hshH5WLtTU7DoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C+aQ5UBo; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl5gDuqLP86+zcK+wqDJCX+ReEuCejjjTBqd3qgNtTgTCF8LCDoxoPc4NXKIovBilPhUh8NZYQm1fUJQWwpl106Ml5xaC8HUtFy+oTk5XrE/xBJebjnwRWYadoyTuHTwnQdH9DE11Q2+LBBmIdAd8MXpqhdg2+2fzSkgqj/lDVrl05vf10oQzDOptcHxBYDcwfSeNtGFqAC+6NBukp09Trb1KNX2S4narJnwz465UUd71jXD09czL6Zl7Woo3zLuWPhrljZ5MxEcoNynUQBuXnYVPpPvY2hnD6PXvmadKOvH5go/vfmRhbmSyvKgohOVl+ABA1z/eqVkTIJ75SE/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEZLibLys633NryK05gK6qXGbAntyCK3m73BwR5fvJQ=;
 b=Bayom7VcSXE+mZ7nqfvhoqvrA53NStqmZBJq/ZqPkETdoR11nh45Dp/0hprSTAYPAg0OZGDhpjpkukXMMRD+UdgkRbaxBPGlJa2T4lzAqhOSLZ1xhjxthu0P2xYkfjMVkHKaaBcdwfhPX6SMGT+hZUIGS6EJYYl9vcoFU0hoUmy0L+WXj2Eux8iKMOzXr0jzUqG7WL4XMMDY+AYolazuMFkKiz3hCoXEU1ElPsoBtsyfiPXI3HK7gDz5DRjeAlJXzcEez/LiWjQGoHll03Ig+o649SlLggPHazcgUiMNw//MOUl4kVtPxDYuQZFJCRWDqviQFzNq3oKduj1se7LLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEZLibLys633NryK05gK6qXGbAntyCK3m73BwR5fvJQ=;
 b=C+aQ5UBogG3Ru0yY8YlHLW+Ze6FvPsX/dlz6AYMGqOcv65rIFgDLP4TVT/5SF4Rvu3lzSwKVeXBuiaux5+EBJOu31OR7yHX5RU0apdty5282slEcCiusHpV+UAGTBmnL5CSLRi3rs/0es789CJRQytwUPT66GZbAiBS4WkYnWi8=
Received: from BY5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:180::14)
 by LV0PR12MB999068.namprd12.prod.outlook.com (2603:10b6:408:32d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:11:15 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::cd) by BY5PR13CA0001.outlook.office365.com
 (2603:10b6:a03:180::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 22:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:11:14 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:11:13 -0600
Message-ID: <474e80b2-fac9-496f-b788-276213a4e8df@amd.com>
Date: Wed, 11 Feb 2026 16:11:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 16/22] cxl: Make region type based on endpoint type
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Davidlohr Bueso <daves@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-17-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-17-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|LV0PR12MB999068:EE_
X-MS-Office365-Filtering-Correlation-Id: c19a5991-b7c8-4d39-b9e7-08de69ba790c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2lwU2x0RTRoV1A5WFVnUlg1ak1JUFZDS2kza1VSSDhuMktwY21FNTNya25J?=
 =?utf-8?B?RDdlTVVzRGhZRThUaVlqeVJha0srQlNJeHorci9TQm05bXdnQ0xGYjFudzRY?=
 =?utf-8?B?NTYyQVd2cHpsWEtVbzUxN3VZRnBVVUw0SEVOekFzMW8zQUxrWWpoZTRFZERQ?=
 =?utf-8?B?WXhQUGx4VTgyZVF6WmtjYStJVXhqY2VzUEp4L3dSQUo1Nmc1QWhhdm55Nnpw?=
 =?utf-8?B?SEZ5b2ppM3J3dDM1ZFdYRCtUY1lCV1p1Wmd0ZURSK0J0c0R5aDg4cW5tSE5s?=
 =?utf-8?B?dzlieHBheldYOEFqQXErY3Z0YlJuZy9jdk5SclpuZGhyeUkxWmtkNXd0dldY?=
 =?utf-8?B?MUlvL0RGcjFPTFY0YzExNlU0RGdRL0FjTFNjQk15V2VHZWpBSjZFUi82bW8z?=
 =?utf-8?B?aU1mSHM5bzFwbGRsNk92Y3JmR2pZVmJuSW82Q2U3UlZVSmltRkkxS0Q0bEQ3?=
 =?utf-8?B?ZloyTVFZWTJOYldKd3VtY0h3ejdOZjYyUUYwc1YrdGhuWVJoNHdqMHhRenV5?=
 =?utf-8?B?NG5NTmtVZTlzOU1iYncwQ1kyakV4WFZtT0dXTUVmaFhSWWZHY0hKaWwyUnVC?=
 =?utf-8?B?TDAvRFkzMzZDUTZ1Sm93S3ZlOEFubzRLZmxRVWV0eDdSWVdPM0c3ck44Y1Zp?=
 =?utf-8?B?YktrMmRBSmplbTAvUVBCTGdnK3Z1UVRtNW9vNmtQamozVUJVRGhMR21VNEYx?=
 =?utf-8?B?NUkxTHRDMWgwc3p6YmYzbXl0KzBzOUQ2SGRFNW5rV2pYRFEwbUwyTWFoYWxX?=
 =?utf-8?B?bDB4UlRSc0M1WHJhR1dyOHlPd2h3Z0tRaG5JMWs2RElpME45amxHOFRpYi9I?=
 =?utf-8?B?cC9vWEdiZ2YwU1pTWGlrT3owaG5SdnhpL0tKTmJjek52eGNrVkF1N1FpeVgz?=
 =?utf-8?B?ZWgwWXVSb0x5bkptZ2Nsdi9ZazE5SWlPOFRxOTV1ZE95ZldRV2tIOHhHMGw5?=
 =?utf-8?B?Yk5YeFZCTklZajlTdkJCTDNJV1d4TFpiQ0liZGk2WkhPejdCY1FSWU43ckpi?=
 =?utf-8?B?RVFjT0pGamE1Sm14YTlTcHNGV1FjQi85ZENpL3UvbWd3WFVzUXV2bDRtZmdw?=
 =?utf-8?B?MWRrMmxaVldXaWNMYnRRcFJROFVYT01zUlRiSWJvd25PUkIvL0EyQWs3dXVQ?=
 =?utf-8?B?dzlSbUg2UGd4aFlkTW5CeThleXZiT3AvMTlGZmtJRUY3L2NjMDlWMnJ6SGVt?=
 =?utf-8?B?S09iVWlJWmVPcnViaGJ2UnFnSlptbldrb2RiSG9vM1NFN1ZkQ0MweEJyRzYr?=
 =?utf-8?B?cm94UG5XdUhYSURJR2doUUw4aENCZWFscldtZWtoVTIrNHBBM0xTeG1GdVhl?=
 =?utf-8?B?SUhHcFNUaVRDWDkwaDhYODZzeVJTUjNBSWZRTzkrVlpKQzNsM0dVcVM3eEVu?=
 =?utf-8?B?SElMOXFMRzUxRWJTYlhMeVRwd0YrUFJ0RERjU0YrZ2R4bERuVTBQN0FRWW1i?=
 =?utf-8?B?YXBRK3Z2Zm5YYWlTUFM4Tm1PRzNMNzBHZ1NFMnJiTXBCc0FSUXhCZGpHY0dn?=
 =?utf-8?B?aG1NL0JZWXc1ZjhhYnFaTE1qRTJkZkt5UjB5ak4yWjdoOUwvUUhkcTlTWFpQ?=
 =?utf-8?B?QTdaUlBHUDk5S08yRUp0K2tENFhCY1NncHpQTHBJZlpJQmRoTDN5cEJNSm4y?=
 =?utf-8?B?cVQ3eU1kVk5UNXlzazRUSFNRVU9UaXpSWThjUythekN5NEp2M2FmQmExaEgv?=
 =?utf-8?B?d01ENlVuV2dYNVlQajE4eHNGbXhwb1hENjBTa0NmNlFYTkR4SWJzMVhkSFpw?=
 =?utf-8?B?bWVrb1RCRGh3R2Q5NGV2alpZb0xJallEaDczc2tPVkk1SnQ0VE10M09idlQ1?=
 =?utf-8?B?enBZTlB6bXFWMUlXYUdTaUtoTkpvODRNR1duY01xS0ZNT0ZTTndOaCtXMTF1?=
 =?utf-8?B?Zi9DSGtsend1RW0zTTdyM2hVR05KM1RRMVR0K0NsMlM0ZmZhUnJJMDVaeW03?=
 =?utf-8?B?dlBQOEZVdzFuWkVjdTRCajVRVlNGdFNNWVdGbUY3dUZjQ2l3c0RtWDI5cUJX?=
 =?utf-8?B?dVJsUk5xaC96Y0RYcHdObHVTVzV5TVpjQkdDQlFQckJIZjJPRWdsa3lVVy9k?=
 =?utf-8?B?QWoxS1VibXhBYytPendPTXlHRnF2aVJEdGs0YmZLaWo3aDhDcmRYOEhqUkNo?=
 =?utf-8?B?cFdWK2NrenF5bldoRnBHMWRtcVRsZzBHdXQ5UVZvRmJkbkVlZCtSV0J5N3Er?=
 =?utf-8?B?cHV2dFZKMVBEZDFjc1BFcnFwUUh5RU1rVE1qSW9JMVM3ZHlpMmZITEtLRVRk?=
 =?utf-8?B?Q1ptRzhXZkwxWmdTNzBjYWFpTVlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+psRx/hty44fGpWd3GGtb7GtsXHTvqyHxfilGzM4msBtNwz6xhjDLdIqcuQ4hXojsgmZy5/Dx2Hkyq+3wdwMRJS0NPjEPgNCvSHQX9FC2ETprgoDLMxAyj/EfvpvtvEDbybDq65/tWHfoeaIA99etnokKkCK2gztSpbhHMNkFsg6m0VSzUMAQ3+spRKmT7XwyWpbhMBTVBzqbqxwUEYYMF7ZTQ2mpTQpMNZ+NkRf0GoE4Zsr3GvZ4m39eXJbZjPlbZX+HPPJLxn9w2eut1hfKBHy/+KKqco4Lb/8lGY29XcR84p5SfpgrIsuD1bFsY9XbSVaQT4+oY9So09y6NDbXw2Z3bvOx2iTnQQltF6/PDCsVl9JZOsjvdNn9BScUqv6iUcIleHzbwzuOx8KuvyQlTqtwD2P6OoFCNakf4OX3wuevf/SkFhfkerHbLMYzBTD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:11:14.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19a5991-b7c8-4d39-b9e7-08de69ba790c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,huawei.com:email,amd.com:mid,amd.com:dkim,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,stgolabs.net:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258367-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: BD2DF128032
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
> Support for Type2 implies region type needs to be based on the endpoint
> type HDM-D[B] instead.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
> ---
>  drivers/cxl/core/region.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bdefd088f5f1..f53b2e9fd9e6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2833,7 +2833,8 @@ static ssize_t create_ram_region_show(struct device *dev,
>  }
>  
>  static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_partition_mode mode, int id)
> +					  enum cxl_partition_mode mode, int id,
> +					  enum cxl_decoder_type target_type)
>  {
>  	int rc;
>  
> @@ -2855,7 +2856,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode, target_type);
>  }
>  
>  static ssize_t create_region_store(struct device *dev, const char *buf,
> @@ -2869,7 +2870,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, mode, id);
> +	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);

I haven't read the ABI docs, but would it be worthwhile to update the documentation for this attribute
to mention it only makes type 3 regions? I'm flip-flopping on whether it's worth the trouble but thought
I should mention it.

Either way:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -4036,7 +4037,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
> -				       atomic_read(&cxlrd->region_id));
> +				       atomic_read(&cxlrd->region_id),
> +				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {


