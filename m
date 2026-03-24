Return-Path: <netdev+bounces-271304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC9gIun8wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:06:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D736231CAD7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0761304A13F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B15317143;
	Tue, 24 Mar 2026 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5AwltTW9"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61A2459ED;
	Tue, 24 Mar 2026 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386406; cv=fail; b=XlTrsEp/GQfd1G/Q+DKDx4EW+AvFkEshQFZRkPNWiWY4oCaO7LC2Y/kU19LGFMOHn5rB3wgesZXDBEe38RQbeOop3dWGXGpWarJtNFsrR7tIkmGUqSOyGb4yJFOe/+n9zAGdeFnWYeYJdOyml6q6Md1YVob4qgkq6JNnvh3c5Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386406; c=relaxed/simple;
	bh=+iyuzwMF45GK7vvFwmsY5TeIg9NL80MN6K6kP4sLrJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pCskRS6AVaKE0BVboZgJum6EaL5f2puN0CZNQFsdF5NGH7L5dpd+KDjzR65Azzs3ubXDHztsduO9Ao9F/yVV3lDNUf4I8BmZd79gn5FuNsUNwDELGnddGRve4N6Lu0Jwvz7e9xycIF9S5Smk7DcTMjtJXGP+tbfrCYDPMgmn/p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5AwltTW9; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7zooh8YbBVsPNhe5gns+v44Xz6kvl0gkjRcXYcFXzIHF/Td5uDzwAUbwsj2AR2+sWw4u3lZUIyP44Vwu+nqEClq4w8skrVSg2Hi4udTam6nVqYJegsuXevbvFaSTH5HngOSfY+dS0hcw8IA5RyoMqAdac/E0/xFE+pggKN5M5lv4vpxHuRr0Nfc14oRenTndF4DpTkGan/Qtti8a/4trB47F5Lv/HBC9R7PXxYqBp7rIk94QwWfvwOGpgmEHFIaIPO8j6HQHigFrDZAwdiXxF7lZ30RT+KnEhKPOI9nd3u98gesHjGrEJ2P3blnXwZWr7CMwzYL6PSCCL5hd+P2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6Tl0ze7EXtSEzVx0nZfa7FUemGEHopWFUGj8nLo4eU=;
 b=GGl6Rq/9jgoO85WAa3e/DiCPMd2vEdanx6IhOJKEeFeDFCLbUQ7Nf65UR7xPyhol8DPiZbJLuV0aYguS2U2wVTGsFKBaQ30Q3+YjsIIhhiqiX6qa79fJb+oJBOBNV5c0fWtG84TohnIHJhbOir77P4GZDW904LpW79/1jxevwCHb+c4PKckEXmQjPGr3YuWnX8e8RYNJAycaPQJdWLJBTb3pOtiXxuCsIeBTcBmwJ8TsvxS5+oueYT0dA4BpyDr8qwGYH1fOmjtoCa4bJxSvKQ8XH/gvguxQyS1Fvd+TULpmmy/sXCcWZPqqhGakUbXD5BWd4SnmguGxsfus2B4bLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6Tl0ze7EXtSEzVx0nZfa7FUemGEHopWFUGj8nLo4eU=;
 b=5AwltTW94hamD4mxLWwVTnzrF2MflA6xvFLJW5Z046Q+LN71lGwAPFGtrrSF5Jcj4kk5nTq2t+uCzxTWuqJaPWXf9fKkFQTvt9l3RWeZ4fiRAOP5LDOjxUp/QyRRiBX2uOpF4ltoJZAjbjW9f2oh2Iwf2pAuFcVfijx9XiWJGeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:06:42 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 21:06:42 +0000
Message-ID: <713bed44-0765-4ca0-96e2-7ab3b7078b07@amd.com>
Date: Tue, 24 Mar 2026 21:06:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 02/11] cxl/sfc: Map cxl regs
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-3-alejandro.lucero-palau@amd.com>
 <20260324163355.0000748d@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260324163355.0000748d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba20f31-e28d-49ac-43f1-08de89e93f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	dOfbPio3oQNUn1WGalA4UfNik6yzSC0gsA1ifZyoxmJOjc73sP/Ir4kSrc55Xk/s2hmhNdCKropacw2BWaKA48CwXQ7jbWcG9Gqe8dFsCku1pY+OnR7oTyVxoxip+T/MNzDRd0IZsV2yOG/hE4a7e9wVjjQpQFMOurkN6YLJTYKQU15W2zFIWSS3wk6IQe4s+Eh859EWlzeni/isMwV0l4nLZsQ8YsFcPX7Nbq/KgxZSnlY49rEU1nw1J60hA1du8fqmxOjQNMOkgAmF4ZIPYtcKjbYCeFxg7v0gW63V3/j8L2kMI/bD/68L/CfgKTv7oc8JI3aALL2j3FM2gXaUt2JiQ1FdIx/TLLmmAE6WMsvXEioCRKCHm3+GlJ8s2i6nMJvaDVzL+ybtu8DUXpx7VBsyzSzuewmlCH4HzyJ51yz3koDMHcnZw6bzOqajhiwRfZ8hhHW+rk7Ws51DVU21Sk0qe2muJ9AR4GgLJOt3DhF8stMJ9VAf0HkwlExS1Tt9u7rWcsy4E69+YeD6tIxZT6MjGv5o79g6RiYXtlJbI1l3j5TRThz3WgiyTX3jQgwlNvAZdYKogV2YyCittqKcisr0ARDeNUwKoQUvnC/agEb+RUhbSv03FRnlpTQhd64n7VPUVTdFgt24mETj/wiqFJHfvl5bsTxFBMRvkYoLGwgJXx2wJLNQ1kBzBcaR7vJjJj2U4Fwu0pLVYSLZnvlaBaVasub2ZcjzOT6pujW2vII=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGNxR2lPNzR1ZXhwZG12ZVc3WU9PclFLMHBJVFljblUvWHZNbzRvWVgydi9m?=
 =?utf-8?B?MXNxSkcvSUxDWTlDZnBFQk5iWkNNM1NEYTFnSXdrb2RCdFovNHNFZEJVb1g3?=
 =?utf-8?B?aDF6VmhoMWZ5RGNqbVVoemxma081SjRKSDIrNGhWYU5oYmZKQng4K21kMG9m?=
 =?utf-8?B?ZUxSTGU0aTZSUktLa0x1VGduNEdraEZOUzArQ0laZHZjM0w0S1J2NTBUSGk5?=
 =?utf-8?B?bGxnVllaK2JKNUlodEhMVENRdlgxcWVoRWNINytnWloyYkwwdTAyQVFOUk9n?=
 =?utf-8?B?ZlplNFRwOG9ySmU1UFIwL3EwV0FPTlhzTkptMlRhMElkZmQzUURYcDcvT2lW?=
 =?utf-8?B?TXV0cnUvcUhsMFpsUGQyUmxiV3psbk5MNWNadTNkUHZSUmFGM3gyNkNtTWxz?=
 =?utf-8?B?aVFqTUtFcXJ0UmdKeHk2aWYvSWEwRVNkSWRZd3J0cWtxNWZqZ2lsaVlUNzRV?=
 =?utf-8?B?cVEzaW1tdy8weGplMEZmanFOYWJIOW9USEtnMGZUeXdSSmEvdE9jUU8yV0hv?=
 =?utf-8?B?WG1IZXFTM3BCL1pReXNSWnU4Vm9yT2xtSHBXcjRqTEw5cGZwNGYySEZCMXdr?=
 =?utf-8?B?YmF4NGQyWGI4cXJiMy9LZ2lIenFZU3JDOGNXMmNCMDdMVCtwUWdVWHRVYjJ6?=
 =?utf-8?B?Q3BtNklmdi81QlFJTmdyV1ZoQm5oRllnM1JiS01KQktuNkFlTFk2QnZrY3ZX?=
 =?utf-8?B?RThmSGFxWTMxcHFpRlZDY2dta1Vsako3KzBhVXRPT3ZWbTZtQ2E0SzNUcUdG?=
 =?utf-8?B?bnp3OUdFVE1CdElkMXJlamJ3dTN3SlRSbEtRbkV2TVo5Mmpqd2FKN0ZQQXR6?=
 =?utf-8?B?c2g2MlRWQjM1eDlmdlBGTmNmWUJrUmFISTVOSUJ6dWNCRWNJcFptWElKL3VH?=
 =?utf-8?B?cVBYQklKTVgzVXZabndHMVZhWmM4TUdqTFpCcDg4N25ROGFwNFlEYUppblRG?=
 =?utf-8?B?Y1MvNTI3dXU3RXlYS2c3Ynd4STQyb0YxN2Rja2NQT09LdEYrdmdvZEJIenl2?=
 =?utf-8?B?ZnhOUUhrVzVkY3RMQit4aDd2SVFSRGdLWm96Mnc1OCt3UHp4Y08wWVU0TFhU?=
 =?utf-8?B?cmViQ3ZIdkZUaTVlMks4U0VOb0NTcGJiV1Z0QWNEaGc0NjVOSHFuNjFONzJV?=
 =?utf-8?B?UTZUdjQxWktKMnpDdFlaQXR6bCtDbVJOa1A3bkJoVGlVNUlWczNibzFHWG1O?=
 =?utf-8?B?bkgzZDRYQS96MEJsMFBZQ0JRUHdOWVdIb0NFN09FdXpMSUtnRzZyR1dPcTRo?=
 =?utf-8?B?UUJQY2k5TFA2eVFQaTdMbEU1UWxaYmM1WmUrcitXcHNKRlQ0UlVQYVQyclZm?=
 =?utf-8?B?MCtqUzl3T3htbHMydWNWT1N4dnZKdlhCVkU0SGV6WlhqalhRZ2MvakgxRDNk?=
 =?utf-8?B?SndBd0RpSUhvcjl4THhXVDA5YVIweHEybklIcUEvUHFtTXZMa1ZGcjdxNnM0?=
 =?utf-8?B?dGF1eG1nOExwajBTdTE3eU8rdGZvb3pad294QmlUdE1ISm10T2thWFRFbjE2?=
 =?utf-8?B?VFMvV0pKV2VVQUNDUWN2a0F2OEVpSUk4NUJsUVE5SDUySk4yNHpra1RMSVRW?=
 =?utf-8?B?emp3MnhmQ0E0RHRuWkdpck8zck4wbFFyUHh0WkNvNytvUEhNb3RDMU5iWXdm?=
 =?utf-8?B?Mm1VNmwyNm4xMDhHQ3ZYVVVFc2IzalVicTA2YWtycXgydFkxS1FOeEE1eEd5?=
 =?utf-8?B?VXV3MkVIYW1hc0pJc2IwY0dwOVorL3k1L01pbU50cFp6MklnYmxDZzhIelNa?=
 =?utf-8?B?cEtqWFdQQ2x6ZjVvRUYxRVNLeUhxSlVpN0NrWTVnaXQySEtMdm9sVS9JTDlX?=
 =?utf-8?B?VUpUZzhGUjZLWkFOc2pRZjlYK2x1VXZVbURTSUJyRGlTaXZUVnRXTjQyWHdG?=
 =?utf-8?B?MVhqVm1lbzluZkJOQ0hZVjlRVEFIRncydDNheVVkV1FiTDcvTHNKQ29yTjVt?=
 =?utf-8?B?YnN0bmUrQmJadkV3OW1jeXRKMUZLbFBpMDdBQ3E5SWF0SUVYamZsRHlJbW82?=
 =?utf-8?B?L0xHcEd1TjBlckJGWkxKRUJFVkVJZFBIWjBnUFRmOGM0TUpEcjlWUTFvRFRD?=
 =?utf-8?B?aGh5azI2WnFvMXhKMlM3bW5ndmVJcTI1Q0FVNEswZHQrSmlhYTMyOVV0di80?=
 =?utf-8?B?UG40YlhxdHhjaUFEZkpoYUh2QkNqd2hmeVEvdEFSYXQ1aEJQSFE3MEZBT0tH?=
 =?utf-8?B?aG1obVdFUFB2UWRKNW8wcno5VFp2WjBLTXpURkFSc1M5UG1EaGEzK2ZxNjND?=
 =?utf-8?B?NytQalBhRGxPVHgwVVEzY0dwdEJCTCsyYkFld1BKa0UxMlVwOG9SVTZhRmZB?=
 =?utf-8?B?QW9ac2tKNThzWWtHV0FodlFvSzJuekRwZG0reVlDSWdYc0RGR2N1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba20f31-e28d-49ac-43f1-08de89e93f92
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:06:42.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQ4DEtoPuPA1jF3HA5+YsCgo9sUH30gAYdQAskJ0EK9tpptYBcA1r471qW6X58iYawdh3iBzFyj+t+CG6JeJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271304-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,amd.com,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: D736231CAD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 16:33, Jonathan Cameron wrote:
> On Mon, 23 Mar 2026 11:31:08 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Export cxl core functions for a Type2 driver being able to discover and
>> map the device registers.
>>
>> Use it in sfc driver cxl initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> One trivial thing that you might want to tidy up.
>
> Thanks,
>
> Jonathan
>
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 8e0481d8dced..7917118e4eba 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -7,6 +7,8 @@
>>   
>>   #include <linux/pci.h>
>>   
>> +#include <cxl/cxl.h>
>> +#include <cxl/pci.h>
>>   #include "net_driver.h"
>>   #include "efx_cxl.h"
>>   
>> @@ -18,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>> +	int rc;
>>   
>>   	probe_data->cxl_pio_initialised = false;
>>   
>> @@ -44,6 +47,30 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	if (!cxl)
>>   		return -ENOMEM;
>>   
>> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxl->cxlds.reg_map);
>> +	if (rc) {
>> +		pci_err(pci_dev, "No component registers\n");
>> +		return rc;
>> +	}
>> +
>> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
>> +		pci_err(pci_dev, "Expected HDM component register not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
>> +		pci_err(pci_dev, "Expected RAS component register not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/*
> Networking code. So wrong style.
>
> Ah the fun of patches that touch drivers/net and drivers/cxl :)


Good catch.

I'll fix it.

Thanks!


>> +	 * Set media ready explicitly as there are neither mailbox for checking
>> +	 * this state nor the CXL register involved, both not mandatory for
>> +	 * type2.
>> +	 */
>> +	cxl->cxlds.media_ready = true;
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;

