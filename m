Return-Path: <netdev+bounces-261474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHvxK5N7oGmMkAQAu9opvQ
	(envelope-from <netdev+bounces-261474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:57:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F82D1AB73A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF9003295DCC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83840F8D9;
	Thu, 26 Feb 2026 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UX+vC76J"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AEE385539;
	Thu, 26 Feb 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122399; cv=fail; b=EmSBRCka9bGg2r6Mxf5MzGeLQQ8ioFn6/gH/T9NgJH8y5eVE/SF/uhSqAk49smE6b2VmaDFc6sG8hiLD+KCerd0sfU06G3K9OtSpVL8fz/WABXC9iHdGvD8uydItFapglHfIJIQxMx63uMCKCS/C0YgkmLKhbRyBABfHuRPJBEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122399; c=relaxed/simple;
	bh=Brn7CU2bAvT/TNXs4kzXrHWtsAmXJBpMWKkZ4NXBA54=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/X945Gexl1FQuwMKrFveDaOv/6QZg9T1JkP4hwq9OdQtvJgYOlyGHeXstuyyzLZXqhSWmwiTbyFaSx1wHyRJgVPFhFdLSrAyBCIEi8gItDcoEfnj5b74BRwKpJIBl/4Hh+xViWNPpi5SHaNJZSNnNzz2bX/X2Pf/iFW+wv9mdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UX+vC76J; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHKSYBIsHXyrWrO6EM+qi8Yka3F68i1JuwtP9o/UnUlbfjafDISioMhdqF7p3V6uhhu0DhN9k/s846pvK9PDh/6Nu5DjGxBGIOfNAiANmUiLMy1fMycRc0klAT0yxjz4eLTcRrKLexWQA6Tf3kEBQc/hn/chk/orYmzsGQmDxZUJgdwa1lpLYoPV6ha0X557Qkne/eqOzsZ22QJUOjG13i+tszlVP0E22gL7SAAduU9mYyLzetRCX2TNRKkcgDrwHJs4gQ8dERUldHvnmRelgykCSP52GZxYlguEiIREDta18k8JdJJgi7aob18sDGk3RRIu0TvITDeAiWxSC42Kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/yuFC0fkRvVH/j4zfp6LSf1VZI/wjNyaCDlmaC2pCs=;
 b=YkCccstbZ2Z+zp1iLdiJWVcivZoHhfJqWj629OE69wFjqc4w56alPweomhBRlikV4QupOvzno2HIta9c1HkO+gtWg56WXvuzHYRhMrJaEgkdAIbKYzlZXvRzjgOgSR1g+rVp9nBxlQJKNazzHwjq0Vc9A+hagoDL3rKHekeS1IzdWEelxW/gT5EVuNBgRWKHE/57WIY7PtA05bZdNApHSBH3FFLxpPit1GT+53UEVoYvNDGN9vF6fiQHaJMbvuQDvFgI/FHhtPieu2gijtNnJyTa2XEpuCv6e71hIbkZfy0cGM5OgamPYGdkz/d4a1Pbojz+zOa7Vuw7AE0+htoBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/yuFC0fkRvVH/j4zfp6LSf1VZI/wjNyaCDlmaC2pCs=;
 b=UX+vC76JIbtPc9h59zA6K/TMyDI5yEw4uatQMbsTi2/zAobvP9NZkJv2N+R0HqFROBTmhCsJjduUVlcKjFFOpaCuctUVYJ3oVj+ynt+Kd93HiQLDRGmlVEIXhbMUu9NG2af0YZsNRP74dMK2SOs+lFQI09MA9gQBD+mJEoh6HHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:13:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:13:12 +0000
Message-ID: <07ee40eb-39cb-4951-9464-af72b0ae77b2@amd.com>
Date: Thu, 26 Feb 2026 16:13:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 12/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: af7e7fa5-d3ac-471c-6f30-08de7551f042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	z6cpXs1N/qnylZv2i/PO7XT3N2Ti/PzlQ/wRSIQdkenRQmQ6x/XrakJDT56GGYIbRm2xnmAl/a+UqvcVumRV0z8OhBA0yie1nJU6ESOruz6DH8zF/v93VufGOq7uv4/H/sqXxXXqGR5Zhls8O8g3zP6lxtyScSns0JOAfQEYdcH9TPAvk3cY47hPcE/94OGrrw0tTZ1TFRrUDbhin53kLebmfTcOdwEW1+6KYueM11QOajEzWH9uSN357C2QdMaX+c+7oVeek3BMvi+9KgVtAxJsTJJN20odVyx81dQ2PKHPNw74+TJKKBcmsSb2FwH4Qm0JS3pmBmaXxG2TBqN+niB0XoUjHgovGRD/wgCMVwd/+emkafDLZMiB6fiUopJVACHAw8jRMk+Hs5Of8FUTIgqH/NQycLqqclk11vI74Lflr7WohoiDZSFLBrwVyCDQJ39CE9XYzgyT2clRFEmEBptonZTYRFSJsJirgVqXVkenO6MowudWQuR8NNJQDRzWuSWOL0vDg6Uegw/qK+DtI5CaVa4O8Y/bd/9zZry5exWtCPe7DEX6O3wZCyQVjvljtO0aGqD3Pvvnlip712SvrMTEr2gBrDYAB/0pAg6kYePFoWu+z6qbAXTzpxa+5wQYQQDApuW9ivor0X84q/fy3cxU6hNe98/GAyCjMjNi5vXS2YQJ6JvMhkzX+OZp/3dV21gG+mI1bv+9nI5/S30+MMYtXB1IAqrV1wwplKoXZzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm1JMTdjNVRlRUNZQmlDVmpVT3NRd0t5RHBXV29LUHpZWElXN1piSUtucmxV?=
 =?utf-8?B?Zk1oaVo1Qmptd1ZQb281UnUvbG5ZeTB6dlIrSXB6RGM0N2hKNGhjTjZzaDEw?=
 =?utf-8?B?UlBMZUh1VHFZWnJUNWx2K0phUlRrSDdnSWNvVmFMSENobVZKSTg3czZWNS8x?=
 =?utf-8?B?MEw4MVAyZ3hlbE0yUExzdkt5elZPS0UxUG1yWHM2aW9Wc0JlMU1mdXl6QzI4?=
 =?utf-8?B?UmJqSVdWS1I2dE5FZnFUTGMyYWl3anZHcjZKYSt4aXRDQU5ldW8yS1BrVHZs?=
 =?utf-8?B?dEpDdjZReEZsSkxyMngvY3luMEJtdW1DUUZadFJ2bG02a0RrNHdpSldpQVVj?=
 =?utf-8?B?UTVFc0lwU3d3Uld2eVE2N3JWMVVGUkxqUHJtemR1MzZCVlhoM2lzRThiY3Bt?=
 =?utf-8?B?ZzlRbjUrUE0xT1dXdWxRdzROTUNOY1c2elk0OG5jQ3RmQ01uZ1U4RHpqZ3I3?=
 =?utf-8?B?d2poSTRLV01vMXFVRVZWMzNuZXhDbGxLOEJTZk96a0Q5b3l5cGhQUTJvcFZC?=
 =?utf-8?B?d01teFhOQjFLL3NEMTVod1JBaTlhdG5hdWVCQy9aSmY2TWVkZlZlNEROanZB?=
 =?utf-8?B?WEErRDZBc011a3dCbzR5WEdRdEZ1dU1lMGVCcFlTYXJINWgzOFFHUWc0cTcx?=
 =?utf-8?B?Y0s3bkFCVXRyZVVQUjBoQmFVckFYbjdJZmpocU10ejZDWUdZbm5ZMjVTZlFj?=
 =?utf-8?B?aEJsYno3N1ZWVW16WXhoaGxmakpHaDdvV3RrM3U1YnNxRlhJdHVnT3FkS2wr?=
 =?utf-8?B?enIwL3BnZnZySVdWcjRVM00rYlNnaVZDZlVTQ3pBRUVHaDFQN2dSQ29lemI1?=
 =?utf-8?B?SEk1b2t3MkJJLzh6OE1yb2dhZVBEMDdGZE5hL0tmWGpjOTdTZnJ1WldoU0NH?=
 =?utf-8?B?V1RUb3h2UU1ZelIzSnFUaW1YTEl1QnBEeVdSemtleUpPNzJ4M3hRK29tUnBI?=
 =?utf-8?B?UzIvNitOQlY5TUFTNGIzbXdsQmJDMUpLcEFHZm4xNEU4a3pjcStSM1U4WUVD?=
 =?utf-8?B?SXVkRm1kWVd0OUFLQng0V2RYUkRlTXdieUtVb2xtejNOTGJsUzRFNlJmdWZQ?=
 =?utf-8?B?OW1ZWllYdGRORnFkU2k0c2h2SmFwdGp1VGxNK0F3ejBBUlVXaEdyRVRZTFdj?=
 =?utf-8?B?S0pndkx3eUtlUzlieVZFU2MzQ0VEM2txak1pcFFROW44bVAxeU5lbjV6dFRT?=
 =?utf-8?B?VnpBZnhFQ2N1aEJtTk1kMHR6N0ZzSzkzV0svL1h0LzNyY2tNMG1ybUpBZWlI?=
 =?utf-8?B?SUJHWjVLWGlsWi9ONno4UzU2Z280S0NSd1gvL1BjcEZ0NXpHenZXMkdFV2xt?=
 =?utf-8?B?cFpmS3IrZTVUaGdORUJLRm1zSjArNzFTVmFWcjBNMnNOT1dubTlOOVZFWlhB?=
 =?utf-8?B?S01RWnZZVXNGeExhZTMvdG1VWUtBY1VRQjJnSmVPUWNTZlgxL3orZlJVT2Fo?=
 =?utf-8?B?U2Y5VStWV2JLQUo3cGRnSnliTkpwMjYzaWpDR1FZa01XWklRK0c2dlJTQ0ta?=
 =?utf-8?B?WEpXRElZRms3dUJDNUlNbmhpTjJYMWlKZ21rRHQxRGY2anhkSHZuSXdlSjFk?=
 =?utf-8?B?bUtqVGk2THc0aTZxZnRDdHN6Wk54U1NIMXFoZWlneFhYQng4T0tKQU54WGxq?=
 =?utf-8?B?bllIQlVDNGRSckF6UFBLZVlDNlhhLzJjS1ZDNGZKM3Z3Zng5eGU5Syt5ZHQr?=
 =?utf-8?B?eUt1M3lNZzZ2eTV0VDRpWTdCQ0ZGUnRCU1JPQjJpdUE1VTk0UFBlU0RXMmxG?=
 =?utf-8?B?OTVZVUw2YnZmRU5pV1NBOFlDQ3duV3pXSTlZRnFIdk5qRmpML1dwRThyVHdv?=
 =?utf-8?B?MkkxU3pvYjQ4K0hSMDlyb1pITElVNEw5eURyRjR1UXk3Vm5Ub282eXUvRFdz?=
 =?utf-8?B?NVhvMG1lQVU0L0NRdW1ZempJcHJmQ3V6SEZIRHBaR1d2YmNGbFZnbUo0TzZF?=
 =?utf-8?B?cUU4cWpPcEt0djBHTlhJY2pIWjBQSUVWSGtCaE5qK0l5V1ViOUlvV3FidVpP?=
 =?utf-8?B?ZXVCWTB5TnlOczhxYW1jeERwQ2ZxU3lqdzhwWjFyS3BlYkJTT1dRZUtoenRt?=
 =?utf-8?B?TnZFZy9TM3ZUN0FhU204NlFWbStYbU45OFQybmRMbTRVWnFPaStva3pQa1lF?=
 =?utf-8?B?My9jYXhCN0kvRzdqSEVnUmRhek0zcGFzemNUS29Bd3YrQkxQTlpSR25KTEVJ?=
 =?utf-8?B?cGpQbnROcnQ4Y00yakRscU5Xa2Qwc2czYXBiTW14RUdldlB2NTZFdWJ6MmZW?=
 =?utf-8?B?RDRrcE5DVDhYOFY1N3VNQStDekhBbGtDOTlyLzNrUnF1S1NGTVhTSDhzOExo?=
 =?utf-8?B?Y3hOSEpwMTdyRWdGME45UHdpZ1I4S2lXbkRjSTFHNXJPTEllQkdBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7e7fa5-d3ac-471c-6f30-08de7551f042
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:13:11.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4QE1svxsntyGj/ylOmbLeFYai5A/OoZ6dVSZx7TO2/iW0toj0IY5MDRKslwI+TjmBjyHDmAm/hI22yBh2yZkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261474-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 4F82D1AB73A
X-Rspamd-Action: no action


On 2/1/26 15:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> CXL region creation involves allocating capacity from Device Physical
> Address (DPA) and assigning it to decode a given Host Physical Address
> (HPA). Before determining how much DPA to allocate the amount of available
> HPA must be determined. Also, not all HPA is created equal, some HPA
> targets RAM, some targets PMEM, some is prepared for device-memory flows
> like HDM-D and HDM-DB, and some is HDM-H (host-only).
>
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
>
> Add a complementary function for releasing the reference to such root
> decoder.
>
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/cxl.h         |   3 +
>   include/cxl/cxl.h         |   6 ++
>   3 files changed, 173 insertions(+)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 954b8fcdbac6..bdefd088f5f1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -705,6 +705,170 @@ static int free_hpa(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t free = 0;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < ctx->interleave_ways; i++) {
> +		for (int j = 0; j < ctx->interleave_ways; j++) {
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev,
> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_rwsem.region to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_rwsem.region);
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		if (!prev && res->start == cxlrd->res->start &&
> +		    res->end == cxlrd->res->end) {
> +			max = resource_size(cxlrd->res);
> +			break;
> +		}


When working on sending this patch independently, as I'm doing for 
facilitating all this Type2 integration, I did realize the above check 
is completely wrong.

FWIW, I did add it in v22 which was a rush job for getting a version 
before LPC to be tested by PJ, and although "it works" for the second 
time the driver loads after HDMs are reset during driver unload, it is 
embarrassingly wrong and only "fixing" the initialization for the second 
and subsequent driver loads. The real problem was (I found it later but 
not changed here because v23 does not care) the driver unload was to 
releasing the resources of the first region created.


It will not be there in the coming patch for this functionality.


> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	if (prev && prev->end + 1 < cxlrd->res->end + 1) {
> +		free = cxlrd->res->end + 1 - prev->end + 1;
> +		max = max(free, max);
> +	}
> +
> +	dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(cxlrd_dev(ctx->cxlrd));
> +		get_device(cxlrd_dev(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the mem device requiring the HPA
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * Returns a pointer to a struct cxl_root_decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this decoder and its capacity is reduced then caller needs
> + * to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxlrd_max_context ctx = {
> +		.flags = flags,
> +		.interleave_ways = interleave_ways,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_port *endpoint;
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint) {
> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	ctx.host_bridges = &endpoint->host_bridge;
> +
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> +
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> +{
> +	put_device(cxlrd_dev(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> +
>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>   			  const char *buf, size_t len)
>   {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 944c5d1ccceb..c7d9b2c2908f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -706,6 +706,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>   bool is_root_decoder(struct device *dev);
> +
> +#define cxlrd_dev(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>   bool is_switch_decoder(struct device *dev);
>   bool is_endpoint_decoder(struct device *dev);
>   struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 92880c26b2d5..834dc7e78934 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -255,4 +255,10 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>   struct range;
>   int cxl_get_region_range(struct cxl_region *region, struct range *range);
>   void cxl_unregister_region(struct cxl_region *cxlr);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>   #endif /* __CXL_CXL_H__ */

