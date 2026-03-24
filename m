Return-Path: <netdev+bounces-271320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHf7G5kIw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:56:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3C531D0B4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0789130E28ED
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E233B389B;
	Tue, 24 Mar 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jCzwrjD6"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E163B6341;
	Tue, 24 Mar 2026 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389338; cv=fail; b=JfQ2FAM6s/BsY8e98t4ZmUe0oYd8iUnbQZeiAnKNvCTFPoHHV9IQzAOSqpKmQBwfmDjf80DS7VQG+ZwJ5WsFUez9fi16qf76KBQsjuEwqpCb5bKQeDUOE/0WyuofXw4azUPmp2xfLHeLs9Nt+0UGWIjzOzHaQsDzCfdKC13uDes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389338; c=relaxed/simple;
	bh=Sfaq60wYHfK3ufdS+E9bt/6cXgNWOigBajgV6AVe794=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fpbfyewXLhNDaa7jPIp+2wos2kM3eoQdL1xncjTStSzgOs1sF8nrkFOy+b0rUzmLna0Azpp9A0f7Pxki2ima9PW5u5wWJjfRHMcaCrYy5UMmwPn+VZkGRS0zRAKYJRA012+3f0edKBoqPVj9HkjbsDZOr9u/CgS7jBsWKoQfDIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jCzwrjD6; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRmpKWQShqWm65rYfW2finMDx2zUsp8jfkuHaqbANfkEotp8hFdDTsctypQ5lUuY/E0trQVZVWwph1aqTJDGFJMpVhNOAh0CitbWZsYDXrQZNbfbesV5GKsNeTT7ids5ANVQWBSZiRCVDsan/rcxIdglyyvyB7PiShOeuTsA2gzeE8lI0d5201CM+H7p6Xp0m3Xu1/WMRkAVyShV2bZ3tcZsOgDjTmu93dLOfypEwnbA0N8Kr+EE9NnQfqM7zYhVN2RiBra6gC6EqLNiXRBL7xkrG4XblxpsAMvWorGvDIeDID8TmW16J0rHf0DU8PQrcqLD+HEKk29vs4bupAuH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxJfjLfzFiZoAeL4HmbVs4ygKMHMNJSJNmQ/BnqNC2E=;
 b=twzShhGu9i2Vqn4+iwj0f/vdIqCKthxIeCyWVH31LOqFp1UqJ6RaC3xGO722KjMiJwYsua+mJndbmo5ZdEgnZmge4xbP5DuPvdmbnvnsdeq3yTShHx7LIlPpLkL+fAqFkUrXkEQWj3sntlgLi1IxwTL/KXaUEngMWyyaEthZ8AWF/mr0FO+cBLyCyVTGrq2Y+izeM8SPi0XSNHq0aw7Ues3ObAACBCJa47+ns4d9fGYUbOL9COCTbBOlgzR7qwCfZvj7dW2kMQt6CpHqC/dcfiuS5SxRdVdRDltoq/FI3gmoY1lNtQ2BJS0r8S6bZdDt4J/I9qWOVAtCkRkPm6yKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxJfjLfzFiZoAeL4HmbVs4ygKMHMNJSJNmQ/BnqNC2E=;
 b=jCzwrjD6vuBRydV3/fSsWtpaV/NbJE5igqcthGG+CGnlsqwU/xWX/IMNr4g9poJeUH1PvN9r1gOUInbHGv6ghJbsid7ToiP5g1EVeQXq3nmrQGCwYpl5zw1Jn+eSMNjKg5cfXeL8hOW0xPYiJxifFeJMxqXgpSXWz6g0+nmuzpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:55:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 21:55:33 +0000
Message-ID: <af072bf2-0861-4698-9304-d46e1ddfd3b5@amd.com>
Date: Tue, 24 Mar 2026 21:55:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 06/11] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
 <e9d16c75-edcc-4c83-8861-223c18c979e5@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <e9d16c75-edcc-4c83-8861-223c18c979e5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: e0104edb-3127-4ac4-27b4-08de89f012ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	SwzkcnKF0r8qyDZEXfzUgawbyFWaH/RDo5+UBSq35Ty/MLTc13NJiYmqlL/gME+3I27hlQHH3bcIE6tEx345B0m5U+A/l1imW1HN7662v4LyihGiRnSenRP5QSmnwkw7tU80dR8X8UE1IksPbb1vcR4z1PWETrzu1d/hoej1NgNdhzp0d6SrAJYS/VK7O1qnLB97Pe9P6pSBqE5CpfKC3XN88eG+WqlUG8cevjsMMgo+5jftcPrDT+yowAk6NUofdd20QtMRFG4XcdTujMcpQxMEsc2Y9AM+/KfMe39jn6oOdD+3rhG+gTFD+dk972Llvq7ibKVRBxN2Z9kmfiXkcBkZBVJR/1SM9IipjwPpx3u+25AngRDZeIaIYEKq0wXXUc2Cmx0sWMiGeiNJjU1Ut+FWC6ApS5jCSvvf7Arp8FaxvrY86DGlr6HIyfpJXq4HRq1VfJtUHDv1U20tS3mxtwISLSq3qwryA3rqpuUFsx1NX4V4E5tpGaRWM65uiCM9huKClzybWLO3oTy+kZk0nHtytYs8Ynd686FU6pGaqgPl48dILuC5ncqt9qO6JDsj12xpA5mOPSYs8yzrb3+5Of9BIP0JXP3cu7SBHRPWc6ec2AqNUWV+TgXKCXztkAdm4vIX0iTlFEmtM0JKfwKQuREObDcXavZTGP5XY2O0saNSBCJSFuAGix89q1KL+ZEELsy4bPoUili7uOCQGVtwVhS1uIlC8DqYegwweCp2vqYgdKFwkDu/jDUXpuuC5TvSKMOIG/Co0xnjfutqTX6YxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWo4ZEpTRnVrQXo5TGVwa2piampSM216ZmNEM2J0TTBoazRYREZQbm1rVjIz?=
 =?utf-8?B?bmc2c0RuL1Y0RXYvbWlXOEp3Q2M1dW9vdVBiYnQ2cW8rNVhmNUxNTnZncTVW?=
 =?utf-8?B?dGd0d2tjTnVWK0dVWEl3dmo4RXVwUng3OE5wZzd5RVk0UzNEdlNkZXJSbVIv?=
 =?utf-8?B?YUVxTyszTUIxYkJBTmpCdk5ZNm1QcytzTXVuS3EvWmpac1I1Rm01U1ZmbkxC?=
 =?utf-8?B?TnJWYXRRQVB5d05mVUZKRU1OWTlLTUk4VHVTSnpUSTkwdlg1VDBvYVNyaHIr?=
 =?utf-8?B?S05IcEtob2dCelRMMWtldkcxdGFJdVcxL2NFY2YzYWJtK1FTRTlVUHRvM1ZQ?=
 =?utf-8?B?dDRWeVVrQ2NFQmZOT0dvYlpDdnAyTFRjRmlFeVF5aUZ1NTdWWldkeU5CQWo5?=
 =?utf-8?B?VEtnZW1xeXovYzFHNFBkdGpqSlpCYURmNDBjMjFyUEt4UC8zei90WHJhUFlz?=
 =?utf-8?B?VFdSQldQbmJoTW9lVnhxUEVnbytzMzA2aEQrN05tZVIraFlLTjhENEEwR3Z3?=
 =?utf-8?B?aTBsNjJ5RnhXc1E0TlltVncwK285cEQrZGNYSFhNYVQ3bE5XME5oZTNhdXNw?=
 =?utf-8?B?alVOWEJyWmpNQTlaeU5PSWEydDBYSTRDS0JNaXRVYUJKd01tK3djV3htYi8y?=
 =?utf-8?B?cWNyY2t4OW51SWVzS1VLUFRDdTFpVUwyVDE4VUZmbUhuZFFjUmZhZXZZYWlE?=
 =?utf-8?B?S0VJOXpEcHFLNFkxMHZSL01Cank1b296YzBLdmtQU1ZOMGROVjZvdFBMeXZ3?=
 =?utf-8?B?ZXF3aXFLZldOVXRvZnptL0IwZGtkTXlKV2VZRHNlU2p5KzZHUnlsTnNoRkRv?=
 =?utf-8?B?RXdwSTRjZ1BwL0lNUWZNbytBK2VzcVorL09Sd21JOG9VWkZGN3hsb3R3YXU3?=
 =?utf-8?B?Sks4a0U1aTZIaytiNkgrem5ZcmN6ZHpkUmN3Q3hRUlJIakFoQU9HQXVwNkpu?=
 =?utf-8?B?ZUtoOTZ4Z3BOVDhkV0t4TXUwTnFNV2FQSG9RbkVYMDY3QUg4bXB4OStjUXRv?=
 =?utf-8?B?NFNOUi9oVXdQZWsvUStYc2ZSMWJoL3huRFkxTEM3UU0wV3FIVm9hN0NxNHZj?=
 =?utf-8?B?QmVzczdreGlVclB4QjJ1V1pac1hqUFY2QTNUenlHTTkxT1VOZGpUWjJFOU91?=
 =?utf-8?B?QWlJaDZvSU9QNTd6SVdESGtKaGRKSTZPTmhWQmlreTB0K3U3d2hLNmhxbjVR?=
 =?utf-8?B?eU1TNDJ3bGJDN2RNdHhycEtUaVhoQlZaQ2J1U3ZwbDdKaG92cysrbmRVTmt3?=
 =?utf-8?B?MFZZT0xKbUlXTHB3QnVsYXpTM09XcG5oMERaZExjdko5K0Z1bVB6eG9MMmJN?=
 =?utf-8?B?Mk5qaUhFcFlHSWpZa0tJNkVpUUZSV0ZhNExnRGRKU0RrSjg1bG8rSTdpWUUz?=
 =?utf-8?B?TVpZcVRGc091VmxXU3p3ZEhpM3FhRHkzSHFDb3JTaHBUTkNrQ05hUlNsbEJJ?=
 =?utf-8?B?R2wyeUM2dE9iSkEvSVJFbC9QdDNFcXJFRnpjUS9mN1VlTng4T2FqazNpYWNZ?=
 =?utf-8?B?aGNhN21kSWlnVFVNZnlLNU9scFVRRFhwZG1sZmpNenZFbzIwNHlxMHRiU3lt?=
 =?utf-8?B?SkNwRkQ0RmNzQ0NQd3RPWWJLWk9XZ0U3cS91MDlTMzd0WnBRSk9Mdk4zYTcv?=
 =?utf-8?B?dC9Fbmg3VmVjMUVJTEJDQXVnYjQ0Vld0WUZyUjE3WHpxK1lJRzZOY05FYVRF?=
 =?utf-8?B?cGY5eXpxZnYvR2E5enZaUllWS0dEWXpINGRNa2J2YXJ2aklXU20zbVE2RHdL?=
 =?utf-8?B?WW8rcjhYQVR4d1dtQ0FGWi9DTGd1bzRxYUJHeTdMenR4QmxuYWxEZlN4QTRP?=
 =?utf-8?B?RWFGS0JFUlBCNnRJQW9JQ0ZldkxQTGE2SjdiWXgrS2pqeW9JRlI2end4REJm?=
 =?utf-8?B?T29hR2Y4U0gyTDlUaGVFbE8yeTZKYmV5VTlRZHR6RW81eGNsQW5WbjFUTGtv?=
 =?utf-8?B?ZE43WmJSbzdMcmxyd3RURjgrZm5uQjNHeWFJV1JDUHpWdkZXcGI0QlVMZHJ2?=
 =?utf-8?B?YnNnTlVJampsZVBSRWlyTE1pL3F2QWNVK3NlL2ZlRHduQ056MDFTeUtEOVZ4?=
 =?utf-8?B?bXYxdm1PcEh2TTV1YnNRanZiOFN1dXJTeXpzV3NOM0FNL0tlaVRNZGxqd1Bl?=
 =?utf-8?B?U2I2T2dkeDMvdkNDRDluUjFYc2svTUtBUEwwWDh5bjBoNjZWRU5NcUxKUlo0?=
 =?utf-8?B?UmU1RjRBZVo0ZUNvMUUrWGt1Q1UyRzVjNTJqeU54Tm5PVTI3MDJlQUNTUFM5?=
 =?utf-8?B?ZHd5Vm50dWI0UlpCMGg4UUVWZ3lISEFJU0syS1l3ZWd4d1ljNUN1VkFpK1hm?=
 =?utf-8?B?WlFyMWRxZEpoYUpOQk0zaTAvZGFoNXFvL2c4dy9qMWx6Y1Zzc3E1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0104edb-3127-4ac4-27b4-08de89f012ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:55:33.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wzes0S0ZYs0qFBjhX0NfICuJuhlxUiyBjOpSBTz0t90M4PRvg9vuNj75rtXdcPNoKFKmCVDzT3c0rdyk/Cj7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271320-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE3C531D0B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 17:32, Dave Jiang wrote:
>
> On 3/23/26 4:31 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
> Maybe subject should be "Add helper function to retrieve a committed decoder and its region"?


Uhmm, now that you point this out, I think I do not need the endpoint 
decoder at all, just the region.

I'll do so and change the commit message accordingly.


>
>> A Type2 device configured by the BIOS can already have its HDM
>> committed. Add a cxl_get_committed_decoder() function for cheking
>> so after memdev creation. A CXL region should have been created
> Sentence doesn't quite make sense to me.


I will adjust it for the mentioned change. I also realize that I did not 
remove the reference below to the other potential path if no committed 
decoder.


>
>> during memdev initialization, therefore a Type2 driver can ask for
>> such a region for working with the HPA. If the HDM is not committed,
>> a Type2 driver will create the region after obtaining proper HPA
>> and DPA space.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  3 +++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index c222e98ae736..006be88efaa5 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_committed_endpoint_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == port->hdm_end;
>> +}
>> +
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr)
> kdoc header for this exported function?


Sure.


>
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct device *cxled_dev;
>> +
>> +	if (!endpoint)
>> +		return NULL;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
>> +				      find_committed_endpoint_decoder);
>> +
>> +	if (!cxled_dev)
>> +		return NULL;
>> +
>> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +	*cxlr = cxled->cxld.region;
> Should SFC take a ref on the region device?
>
>> +
>> +	put_device(cxled_dev);
> Maybe should let the caller release the reference? I think you will want to hold the reference by SFC until you no longer need the decoder?


I think this is not required as it is already referenced after the 
memdev creation triggers the port allocation, hdm initialization and 
region auto discovery.


Thank you!


>
> DJ
>
>> +	return cxled;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
>> +
>>   static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>   {
>>   	u16 eig;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 10a9b8fa2f6b..2a61138e2a73 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -231,4 +231,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>>   				       const struct cxl_memdev_attach *attach);
>> +struct cxl_region;
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr);
>>   #endif /* __CXL_CXL_H__ */

