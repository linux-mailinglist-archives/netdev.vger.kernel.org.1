Return-Path: <netdev+bounces-302029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DimcJ8hTPWql1QgAu9opvQ
	(envelope-from <netdev+bounces-302029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:14:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 405446C7612
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:14:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b="DZA/5Csi";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302029-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302029-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72DD9302497A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F93AE71F;
	Thu, 25 Jun 2026 16:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020075.outbound.protection.outlook.com [52.101.84.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A852571C7;
	Thu, 25 Jun 2026 16:13:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404033; cv=fail; b=UQOyN6KkDHUEkokvM/1N/t20NWnR2iZwJsE2oD8gUJM7HaVq5gzmwbmWDoHrHU7RAvVjvu8/ND2+l8oY9jpwnWB/hgrs5eQQN/Bf3AqVz1Qb80fUX5oj0VlGde3p2OdPnfIltkoNtwFDXH3DP7Q2NXFAztGpqt6Re5VR3CF3jVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404033; c=relaxed/simple;
	bh=WI0QcVCgwbg6KqibjFG1fellQniZngeEeXROwyZ5aH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=buRudAjCBvJOZQdGPsqfNgxx+hLR19vz7aQBhxxYR/ZNd4y84TdOFL5R6Xe5+alyPD4HhNFaFkXlEonmFAXQek+5yqjO5yHoAWZ6d1kl79rZAPsDe584IZvoHXkdOJYotwT4XOU090eiAQWTxyXXRUhIAAP91lbMWvMHuwLtxa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=DZA/5Csi; arc=fail smtp.client-ip=52.101.84.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIH1NYYCUiHLzRmcfj2pwRGF5ZFvPkQz2tDRKZxKuVO0+R9SLIVFaTbBrEUBUTbcmK71KIBvwtBLoh03NyzGgjXQxIvvGLCu05kUrs9MjNO4Mf2hPPKpfUHRNwzYoDiDDr++gJkcw7Mo8WBwdFM3oi+V1rZv3T+S2F31WnkLqAiZXH0Upf/08V8aux46VUHBMGOapi2o9miXSkYOHWWTD8ETVCz+DMoCwmh9OaduAgrcUWiSalKVyahEbgvLfeImcqfqXC4KyeUYgIRGVM7X04yZGGiCLRZS3N8tsxo+ygaX8ob9pY8fM3/H4WdaBDVqKq+zlN69yFdKogFSsVSEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omf4GhcyuN2oFEetKL8Eo4DaXSTN70NfO/HfMWEeZXk=;
 b=P3jSQ6jGhDzirn0s1lsCqnbKsAaavIcKdFeKyRMU6XTMt8EQFYOa4cNKJZe2Zle5/8CYhfG1BPHLSa83Lr0+HcfeRtAERAZEqWfe62XwU4dkvYUIJw0LsvSphsafwH2wCnuEVNofFBu+54CvthouLgm7XSBUpS4Id4LOC11jk9rymQ2utU/8P/8By9LdzUJVWGpUKsdvUFb2fBwEGYcyczcJSTZ6YKp8FUvbzeXVVHXDPfLGhxFpX2oZLfDfk1+YXXbmCQ9fYtjs74EwLh7OezBztkqZlb+yzSuvWoRxDij0MKfrpKAHDaG/1qDqAhl0tbJeuQYtjELBU7+wGp+N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omf4GhcyuN2oFEetKL8Eo4DaXSTN70NfO/HfMWEeZXk=;
 b=DZA/5Csip0YGvgCDtXKKTmLklK+nleJcRszJQpC66G6dF/yySZNLpDgNct6IActxxQGv2rpxuRaVGZuCTADReMN4bb5J92/G7NWHv3k7NaYb/wFGL5ciZ+o2ottwlfB0J7ZcFyuxYkfNKlZZS9BGnCts7T3sBH9/Tgy96oKnFhbywkG1j4AxEp5N4A9R/p8kdgeWjrHk5lyykwh9fBDjYgkwKuRKFEde921s85YVIcYconvYqLc82NOGlslQxnxMgY8q6be/t7j0x0+hgR9hC6QFoqkEJ8nERin553kV8KKOfF4mvW1V81W67rqL8yZ+i7YtHPeW+u4r0g7XkJ4p4Q==
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14) by AS4PR08MB7807.eurprd08.prod.outlook.com
 (2603:10a6:20b:51a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:13:46 +0000
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a]) by AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a%6]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 16:13:46 +0000
Message-ID: <de5fa7c0-0734-4ef3-8f20-e761095c8dd1@virtuozzo.com>
Date: Thu, 25 Jun 2026 18:13:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, sgarzare@redhat.com, mst@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::10) To AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB11804:EE_|AS4PR08MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a01cff4-ed78-4c3b-c4e6-08ded2d4bc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	daAyFChWjrotbnz1LtbfK1Jjo4A03aSyLfYeSoh75epAxiQbpWxffWIXbnBvOiEfNCh5gaw4dkoSJhK/PbWeqV+toZWg6m5QRCrPqgthrSeFbXpfl4CvDAUn6KZOp3G+Lcsq548qtMXrNf3gUg3RWjtGLwHKHhoT8aWB/2WDgEFkpjAfbT5Wr2m9hMenuLHA36mOeBHIxc6qDLyj/JO5sR14jv9HMqBKkYwhfQSktwDM9xVSfmxDHYOAHgYO2p9I67mZTDkLNL8GfcqDRX+/lkARoa1IyuFQmolIuBZxX6ry9EOCn22+JAo7SISyYzra3UeI+du05Lldlk40Pi+VNORRVI0iCCDip5C8n6Gj5a8ofCY0WuZG/oOf60yQU1p2jAo7m0pZUQ6WJe9SJCBVF+Htncup9rFYI7aHlvzJTRljn36rGeHiKwBWajIac+qUaw37k6CiKQjm30ICsQe8/lfeDqeQC4EcPIW3lw6EU4snzCR5v8gqeR3nEpl3Kx3InL8Nq4jpJLUxrzEElvmp02vARF0B1/al2hzjXL+TJvlim7eATl+9O6thPxIzEDoPRASMViUwG3fpySSEXvlHcxHNTXDWkOJIhQpmSVqF5/uD+KKAJGklb8lwH1Illr9L+0wh0WG/m9oudZtvRk+b9i0VzkF8omyxGyvomEbOxbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11804.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3NQRTdHVjlQbUY1YnpmbXpmOVZmS1kwMlB3OFNmSm0wTTcyeTJVekxYOExD?=
 =?utf-8?B?d0Yxek9lYzFYb2F1TG8rTllxYmlibDlvc2piYm9JNkZXandSdE9tU2pabzFE?=
 =?utf-8?B?UXdDT1VCTFdkQW5kV1cvZk81VExWOWh6R2pOcHE2YXErTlZjRnZybHF4TW1L?=
 =?utf-8?B?QXlSVld3azdpRkx6RHd6akdyaWpvcWhrOXBDTVQwdFpNaTd5MTh0aWhBSUZr?=
 =?utf-8?B?NW9oNnBpRkl1UEMrVkJJS1BpZkwwZnc1Y0tUSENaU0JDbjZDakNKRXBnNUR0?=
 =?utf-8?B?NXNKTXVYc3lCR21IL3BvVlM5QWZtd3lzWUFRNStNRVNsekNoMjNnd09jaGhI?=
 =?utf-8?B?cG9oZEFsMmtkbEZzc240Q0RUaXA5SXdCWnZZZ3J2NFV0N3RDTXlrUm41ZEFz?=
 =?utf-8?B?a3NXeHJFNUplcHU5R2twczcwdTY5MFdBYkxONm5KaE5ROU4rc2NCdTZiQm9Z?=
 =?utf-8?B?K2tUK083Rzd5Qks0SUlCS080NVBEQVZrQlcxV1BIYmFIalVXZ1FOc3NZZUhN?=
 =?utf-8?B?UWVWQlhMZ2tWYXBoRW9JWkxKeEkrYmlLTWxCK25HdnJOUld4TTV6SmdLTGlu?=
 =?utf-8?B?K25FTDZoR0xLUE5tcHhkUnlEVUNGekNBVUpoaTkvSUVtOW9LZ1B5eStLSndB?=
 =?utf-8?B?SkNnLzRlMGdOMjZiQ0ZRbGVqSis1N01ZamdObUxsOWd3QjRZUVJLZFg1aWly?=
 =?utf-8?B?VnI2QTN3VW1mMEN1b01NWjRUSFdiK3diWDcwYUxJN2ZTT3M1cXZZZllqc2c1?=
 =?utf-8?B?b29oRXA4bmRhcFY2UmxQZ3E5NCtYdDJPZ29QZ0pxRDNWTDBvNlJqYWZoNkk1?=
 =?utf-8?B?NEVlMnBEc2F2YkdKcXc1ZWJEVng4aHJzb2U0dnIrdldqM0RyenpXNzhuWGRK?=
 =?utf-8?B?UjVvVUFrNHJ0WXNGQW9rQ1FvUXFhUmgxSnBweFhCYjBHNnFvTGZvaEhUSU5D?=
 =?utf-8?B?ZzBMWnZtaEE5d0Z1d1VqU21LRGx6NFpwaWJzTnZ0bGtIMGNPVUt6bkNVeWFN?=
 =?utf-8?B?b0tJWngvN3ZkcG1xaDJvMTR3NHdGWnlhVzkrUmFvVHJJSThvYU5rcmZNQm5s?=
 =?utf-8?B?Y2JkRjMzWWFXNmg5clU3WThzVEVnUmNyYnFJQ0VueW1yOEExUWdNTU9Xb28x?=
 =?utf-8?B?MU03cTRGRFIyQmJjdjRZd210bUwwSFBNVm5VUHNuNHppZXFrdksrQmdpU1JN?=
 =?utf-8?B?bW4vUE5qbG5zL0hvRmFLWERobmFhcmE4eWhJdTVXZ09CdkV2VGRNYk9JSXF5?=
 =?utf-8?B?UGZyQkZ0T3J2NVVzYjlXYVBwNHoxaGVTNFdxcmJKM3hNTEtPRmxJZEJkSnZ6?=
 =?utf-8?B?bHVOcnJLdzRSYStRSHdDMXBlM0ZZeEVnSmRjZ0hHKzRvOUdrd1pZeVV5KzRs?=
 =?utf-8?B?VTBOSnQvWE13bFpJOGlzeklJU0F5Z0VFakJ0d0p6OEhucERSYnJlZE5nNTlR?=
 =?utf-8?B?eU5abERDallQTjlod2dZNE1NRDMrY3NkY1Fxamp4cDJ0WXdWcEI0cytnc050?=
 =?utf-8?B?OWdOdklpbWZGcHRXNWFwcjI5WlErUG9xVU1aK1preTZJWFhURG84bDQwdUsz?=
 =?utf-8?B?UGxhazhnSFFXelRVUmRyeHV6a21kdWxYTTEzMXpjdUg2R3lweE1lNXVmNFpG?=
 =?utf-8?B?WjJra3ZQVUdKOUhPeURDZ3MzaUx6TG1hQ0I5WmdkNmJDbTl0ODArY1pXWllr?=
 =?utf-8?B?am1KYW5McjVoaHJGNUFtU0RPQVJqRjZFdy95bFZNZ0kzUUViSnR6R3JTTVh0?=
 =?utf-8?B?UzJZZDBlYXE2UTU0NDBvUWJaOWdpRnNqanJnM0hEVjlOSGh1Y0MxZkZxQjFp?=
 =?utf-8?B?RDNGS0VBVjkxSHZ6YklJRlVzQkpseXpESUMyV1oxb2k2dmZWd09ZU0E0V2Nv?=
 =?utf-8?B?V2NtWWRUR0RwVXZlbUx2cFpjN3BQdC8xaEJiK0FwTHYzbHpadi9acTdLcUYv?=
 =?utf-8?B?anZZR2RoaVJKM095OHBnS2J1UitVMUREQitlWmRGZmNzUy85REpFZDFCYTZi?=
 =?utf-8?B?SmhYYklFb0pZS3NtbmFxb0dmN0drcW0zaE5WTWFRU1pqY2NDekt3cjNFdjJP?=
 =?utf-8?B?dmxaUk5OaFNLVHNFM20wOU9xU3RBTUhxMXBaNXZnU0hvdk0rK0VkckN3RXlM?=
 =?utf-8?B?S2hsYUN3ZXRzSTJQaDc4a0pVdXphRFN4Sk4rZmNFTXdsdko0UjRvclk4Z0ZH?=
 =?utf-8?B?a2Y2S1Q1SWJGUkJERGgrMjBSNnFyNUlUa1pvR2RpekFYMkY2cTRYL1lWNnox?=
 =?utf-8?B?WnZZcFNCRnpLVktsSngwZ0t0eTNsVWM5b0RvQXoyM2U5USsyNHBQRUg3dFFs?=
 =?utf-8?B?VExab0RqSHlRdG1NTWUzSmVLOXRTZ2RobWZCeGxmVFIrS21PbTRHNE9PSWJ5?=
 =?utf-8?Q?QEyuod5y7EEBfSp3ljQBX4hDoh5hS/j51z+HqnesV6b9E?=
X-MS-Exchange-AntiSpam-MessageData-1: BfqyijSYEUfrfCqKH4EYyZ1IcFZQ24OHtDw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a01cff4-ed78-4c3b-c4e6-08ded2d4bc34
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB11804.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:13:46.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qG9JGtaPSZR/yARGI7eTzbEKiArXQlM5Ol3Q4WeXw//zvv2CqA/hZxvnRDE+0Ls1br1VwiscrxOjndiqxbTkvpuV9gm1KvIgZ4vtGpdNBcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7807
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302029-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrey.drobyshev@virtuozzo.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:den@openvz.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ptikhomirov@virtuozzo.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptikhomirov@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 405446C7612

Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

On 6/25/26 17:54, Andrey Drobyshev wrote:
> From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> 
> This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
> the guest with vhost-vsock device.  For this to work, we need to reset
> the device ownership on the source side by calling RESET_OWNER, and then
> claim it on the dest side by calling SET_OWNER.  We expect not to lose any
> AF_VSOCK connection while this happens.
> 
> RESET_OWNER keeps the guest CID hashed, so that connections survive. That
> leaves the device reachable by a lockless send/cancel path while the worker
> is being torn down: a concurrent vhost_transport_send_pkt() or
> vhost_transport_cancel_pkt() can call vhost_vq_work_queue() as
> vhost_workers_free() frees the worker.  That might cause a use-after-free
> of vq->worker.  In addition, any work queued onto the dying worker leaves
> VHOST_WORK_QUEUED stuck, stalling send_pkt_queue after resume.
> 
> Fence the send/cancel paths around the teardown: send_pkt()/cancel_pkt()
> only kick the worker while the backend is alive.  And reset_owner() calls
> synchronize_rcu() after drop_backends() so in-flight send/cancel finish
> before the worker is freed.
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  drivers/vhost/vsock.c | 51 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 81d4f7209719..f0a0aa7d3200 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -318,7 +318,14 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>  		atomic_inc(&vsock->queued_replies);
>  
>  	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
> -	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
> +
> +	/* Skip the kick once the backend is gone (stop/RESET_OWNER); the skb
> +	 * stays queued and vhost_vsock_start() drains it. Pairs with the
> +	 * synchronize_rcu() in vhost_vsock_reset_owner().
> +	 */
> +	if (data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))
> +		vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX],
> +				    &vsock->send_pkt_work);
>  
>  	rcu_read_unlock();
>  	return len;
> @@ -346,7 +353,15 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
>  		int new_cnt;
>  
>  		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
> -		if (new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
> +
> +		/* Skip the kick once the backend is gone (stop/RESET_OWNER):
> +		 * vhost_poll_queue() would touch the worker which is being freed
> +		 * by teardown, e.g. on RESET_OWNER.  Pairs with the
> +		 * synchronize_rcu() in vhost_vsock_reset_owner().  The TX VQ is
> +		 * re-kicked by vhost_vsock_start().
> +		 */
> +		if (data_race(vhost_vq_get_backend(tx_vq)) &&
> +		    new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
>  			vhost_poll_queue(&tx_vq->poll);
>  	}
>  
> @@ -903,6 +918,36 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  	return -EFAULT;
>  }
>  
> +static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
> +{
> +	struct vhost_iotlb *umem;
> +	long err;
> +
> +	mutex_lock(&vsock->dev.mutex);
> +	err = vhost_dev_check_owner(&vsock->dev);
> +	if (err)
> +		goto done;
> +	umem = vhost_dev_reset_owner_prepare();
> +	if (!umem) {
> +		err = -ENOMEM;
> +		goto done;
> +	}
> +	vhost_vsock_drop_backends(vsock);
> +
> +	/* Let in-flight send_pkt() callers stop touching the worker before the
> +	 * flush + free below. Pairs with the backend check in
> +	 * vhost_transport_send_pkt().
> +	 */
> +	synchronize_rcu();
> +
> +	vhost_vsock_flush(vsock);
> +	vhost_dev_stop(&vsock->dev);
> +	vhost_dev_reset_owner(&vsock->dev, umem);
> +done:
> +	mutex_unlock(&vsock->dev.mutex);
> +	return err;
> +}
> +
>  static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>  				  unsigned long arg)
>  {
> @@ -946,6 +991,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>  			return -EOPNOTSUPP;
>  		vhost_set_backend_features(&vsock->dev, features);
>  		return 0;
> +	case VHOST_RESET_OWNER:
> +		return vhost_vsock_reset_owner(vsock);
>  	default:
>  		mutex_lock(&vsock->dev.mutex);
>  		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


