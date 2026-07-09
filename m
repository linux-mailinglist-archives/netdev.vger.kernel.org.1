Return-Path: <netdev+bounces-306079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id byyODPpIT2oNdgIAu9opvQ
	(envelope-from <netdev+bounces-306079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 09:08:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84A72D768
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 09:08:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=GWIfDSAw;
	dmarc=pass (policy=reject) header.from=windriver.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306079-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306079-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C822231479EF
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A863D7D9C;
	Thu,  9 Jul 2026 06:57:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A783CB2FE;
	Thu,  9 Jul 2026 06:57:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580275; cv=fail; b=ioQaFTqhMsl7+1YBMxSdVmGp953YT9+qbYRYoGyQxeHFbtyeUvetE0H/AG19W4x7xlJpMs++XS7yDcXIX63jA78p2DCi5z+clD01QZop5ws3rZvfA8Y7x17Bn2TWtHqn/atOJz9/+Fh8HkPRjIpWzKl53rwRaN1A+7jfkQ67nCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580275; c=relaxed/simple;
	bh=GgGB4KIb6wEnt3VIFDW0w7hqipM3UhGFdQdrVIEH+/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rt55XEq1fi/buqUlD9lUhzRK+Wu+kx9m3ETOpwmnme+5oW7/lfskxexDv4zmqqBGKfjYTwwwV5H+wu5NbVF8rw4NZWmdcFgMfo3z6Hga2QGPJM8YVPorFhqlictHTq2eQDhA2tQvWfQZa2iNWsYMpYe2gusCDiHW75V4H6rvo3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=GWIfDSAw; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960q2G1594888;
	Wed, 8 Jul 2026 23:57:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=iiFTh53PkS6gUFWZUOR9Fe+IJuWNrE7Sqk6KCjKP3sY=; b=
	GWIfDSAwhd07H1Jk2arzV9JWy+BDXv7dfTPTQ0aJOWuE+qDVfAJyK+ywgjQFGlz6
	eK9PEmhR0CGpnR9z46v7mNvXvyDpkhJ34U7lgqXlCr4bnIiFJ3X03vN9zyi/HF0B
	EHFEpYjv3GRS2Qvxh23/xO3wbvRqybVWhaPvkKXK3o73nwwb07wYHndqMzXi1KLR
	fuzL3IgAiHShnamh8DKPZV9CecrIQ1VZQxxqtGqUUMGdBqJnvvBJLOYVcMr7lYPr
	JzbpBtrEftj1M78F/eny7bAIi/s8xxs6Uo0GTkpbDgDR1uveCwioZRo6KyRzxQok
	g1pbUm+WYoEY+a8Y72Hs8g==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1atrdj5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 23:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChmMMuLMhczo7KhRzWHnfEdvXWj5nqMzmE1/HUB1y5v3qpAAyPY0NVFx8jB144m0JGQxEHuCNIv79Ac0ujkjDRi2bA7XKCzmXLf+ZFyxpP2AVJQsrFNMx2S3MqBU6y7YeGsMmRn11JFWoz53Opty3nL4IuhHQrWlMwYj+hdjudyOdPEzMMa5tgOGbaIe1HcSUYc1cXU3Nglrr9qUK8ncL7n8UXO/l5zOvodmL9KnCswLcw48zp2fMUGQxamGw/VV7OgamGiaafvtuCle1HZvain+AknI3iZ6cGVMdZcVCKAkA+6woKC97Mz7YkvNR8muV+9reGCSWyxZWQaYqUrgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiFTh53PkS6gUFWZUOR9Fe+IJuWNrE7Sqk6KCjKP3sY=;
 b=Mk85Qd0n2qBk0z2WFNSnDQO+69uEahQycY3fZU5rmFx2wg2HAv5tlzsfrb4sX+VePkxRXSKfOwG/zSZhDPJRx4xzYwPWc90amwHzqTbvT26g7LC6ZQPbiCnhDvUWte6eQ5raF1xFVgSe7ofjnZtSzwhSJftF5AQd89phyoybYMsfDCQPjXEZrcB3ZJznzwiCGeyUxjVA4dVEADHSqnmWZPqcZVWv87TtJT0tqCSHbdyIkFf+7FC0/rlgbjvsko/04eumOjQVJvlUQeQWpAHS1sv3szR93HtZ5pw2IeiLA2ANFl34qLHRS5IKscgMD6WBq8GJ/BqQEM0lbW86TQ7iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by MW4PR11MB7150.namprd11.prod.outlook.com (2603:10b6:303:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:57:44 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:57:44 +0000
Message-ID: <135419f8-9b33-48e1-ae66-f15599fd9997@windriver.com>
Date: Thu, 9 Jul 2026 14:57:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260709065400.3467803-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260709065400.3467803-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|MW4PR11MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 101dc15a-9111-4467-5452-08dedd876025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dJR8+WRjndHcqRoggHsM/L7vYh3mFKRykC47+47Bn8HtRIIb3yq3YD+/nCymIqtHERdW+UyAjU07uTh75ndRQ6SHAh9lVkm/hs718ctBW/aFfECbb61KiB+j2uVQl/olrFXFw+Fm4ogbH2/yAPDNSvvlHTVFwhU8v68cB6F2pnqmrt09ek3lw2uKPoSEVaW8/QTMarkwwhbTIQc/29AxLkuQTQXlRz/lmgl+75eBXIepLvjOt/Mgyk9txsdebxmw8AhU4FyfUuPPKVNnMWfVsfFyR110Hly+d1hJ62mVlGv8+k2d6th7V3ef6l9bl8umHCOapWNAfbbh8bTUMjruuTgIB9CJqrLnvxHsDk7nhJxYzuzIvKNpQGH7Rx22DWGHhENuCi7CTpgRWG+pg5nudoHfNi80n2r7yi+tNj94w8fu00CHnLxQtPpuny52no//7wdwMM3KTZ20o7YXrnURVNrasu+0vdzza9t1bd9QV58tDTqX1GlJQ4kMZpjeaav7230Gcnt6Faco8t9oZOCcAocAAr0BnLwNNT5jPog7AaiU6uGLvmoyaNYq+mam0BbJRUhJJ8AJUKoX0Apvze2G6uZNofgQnWvXLYSsELYhhbZpvf/QscF84vOlCogyco7C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OElBaldrc1VBTzNtK2hNTDlWT0VMeUxsdGJBNm1JSjdrLzhKZFVtblYweXFk?=
 =?utf-8?B?RzMwZTVXaDd5TUNBZHNkSzFWejJRL1U4ZytEYWNveExxM3pNeGgwc0djN3I1?=
 =?utf-8?B?eVdiNWc2MHNPeEdORmdQanJGQXRUd3VXeDlFemgxdWtMRnVkbXFLUzJEVUlX?=
 =?utf-8?B?TmltY2tNS2YwUDMvTGNBdFA0d3RLcitSSEFWS0ZEeFV1RVNDTjBtL3h3MnZB?=
 =?utf-8?B?WHRWelVrenZHRVZLU3FidEhoNnk3b1BGUlVFZkt3NG1WRWw3OTA3MUk3MzdL?=
 =?utf-8?B?RmdBVUZOVDdnVHpPbFhHRlJHU3YySHU5RFEwNjR5d0VMbUdKRWkxZ2RuTnNJ?=
 =?utf-8?B?WWFaaERKWUJhRmg5VWpkTDhqclM1d0hNSHp5NkttQzRVek8xUkg2VjczYUZt?=
 =?utf-8?B?UHdrblEwRFZONEQzTmtRK2h2ZytGWGl1ZFpRRE5lUU5UTzEyZUlxamlLaFNG?=
 =?utf-8?B?MzFuSTF3cHl2cmwvMDloUkV1YVpoaGpDVnI1OFkzVi90WlNNejhJZXdJQW0x?=
 =?utf-8?B?czNtTU91djQyOTBPZ0xhQlJLV21VQXhNTzlleWx6YmdxZW1NdjJLQ2hQWkRI?=
 =?utf-8?B?TjZnN0RHOU1SaFgxU1g3VGQwd0NDbWFyNXF1ejh6czRxditGM2RWcmxnNU1q?=
 =?utf-8?B?QWp5TUF4TDFFejlsdWp2eXRWak1JN0k1ZXUyTUZCM2hZU25WZ0ZXNUNlNEVw?=
 =?utf-8?B?Q0o0Umg2QzJLd0VmMVBrWTJkUW9mRFhyc3RDeWFMZ1QyZjJqMGRlNGU3dHJa?=
 =?utf-8?B?T3RHRHJLYW9Xc3JKZVAzZWxQRDhkNjJZVGdJWWhPNnZBU0lvZlFjRGQzdVdo?=
 =?utf-8?B?byt6ajdwcHB5S0RuQWxydFo2dTNWUVJlOWtxamorSklUelF1aXNpaGZQQVM0?=
 =?utf-8?B?S2VCanFYdlQxenZDZW1HV3Q1OGtiZkR0TEZvS2lWUFU3M1BWMTlWM2RGdEo4?=
 =?utf-8?B?aXZiMzJ4OHpEem1tZkloZDZqSWdmTm5rSEt0ekJOb3BVQXpBK0FIY3dqWDlK?=
 =?utf-8?B?eUE3YWhiNEh4enJxMU1HSC9OSFBwWS91cXFsdk5Od0EzYWpIeGFMd2tHdU1k?=
 =?utf-8?B?S1ZrempPNng3OElIMmhURlRvcm9zLzd5dkVKMitNTUlpVDNrRTlKU0k2eFRJ?=
 =?utf-8?B?NnlkSUltTmQ0Nlc4YUw3WHpHaHkzT1hFMTVVY29Tb21INnU3RzN6NnhQZUow?=
 =?utf-8?B?ckJFemVBS3ZXUTkyOGNaYWJ6K090KzFoaVUvbC90a2Zlb1RwU0MwaVZYUmhk?=
 =?utf-8?B?Z1VZTWpVbjFNaEpwRjJFdzN2aUttdEk0ZUxFTEdkSUpBNEcwcmk0c2g3RTY3?=
 =?utf-8?B?NVFNMjlUNzRDYkVMeWgrdDhZVklBOWtiZWo1MDIwYnN3WDV0eldaMGF1ZEEx?=
 =?utf-8?B?emhBeUFkZzRTSUNFdUdXa0RGeGF4UHc3VXIzVm4zRWVIdWNGblF2REJyZE1a?=
 =?utf-8?B?NlpRdWlmemdNb0RubVpVQm9GYVgweFJ1akZHOHdIZGl2aWN2dExmM3p2eFVW?=
 =?utf-8?B?WWpud1hzRUVCcUsrV1pYMDNaZklTZWVLY3hlaWVWcmIvbVpxWklaNWROYit6?=
 =?utf-8?B?WmttYUUwVWFhWDk4RDNKRHQ0d0hlTWRXdm9renFEaDRzVFp0U0ozQlNaVW9U?=
 =?utf-8?B?VFJjbkxHcFppTFV4OTh4KzVPcUZiWnp0SFhzcU5qMEdzS3NCcjFFSW1WQkVO?=
 =?utf-8?B?aEZYRFFqcDhuVDhwUGZwa2hYQkRSckdBanlkNTgrVEt4Z0VabEtOSi9DeDhl?=
 =?utf-8?B?cjlrL1p4cDh0ZTFUZUJIempTdXZ2b2FPS2E0ZFl1a2NBeTFOVXZZajZoak5r?=
 =?utf-8?B?SS96amdkZnMwcXNxY1FTSC9zRXV2SFBQK2ppUkhIZWZhQnNpbUhLS3Q4QXJn?=
 =?utf-8?B?NklXSTZiVkh3N1h2Z2J3NHA4R2dtczZaNWZlVUFENVI3VW1OS214VFF4NTNk?=
 =?utf-8?B?ZU02VjV0SVpRR3FXdkhidXZFV0FTWWRqaGNkeFlXNjloQlA0ZHg2UDJ0bkJV?=
 =?utf-8?B?a094d3c3bElkTG0yZjVFT3pRN1QzcHVVaXBHQ2F6UFo1akxtU0NpcXdxNkhq?=
 =?utf-8?B?ZVR5dVR5SDBIVkoyYmVvc2ExOEZvZzFtMEhNZGRvU1cyT25MKzFMaXdrZ2dj?=
 =?utf-8?B?VEEwajNkTEc2MEJsYVdFcHR6Rm0yQllZUkFYMkVvcG8xSUxCcVFyUlJYQXhI?=
 =?utf-8?B?R0ZQOVRUYStTbmFzU24yN0NFYlBIbnh6OFRqR0t5NzhZZUpMRFplNVlscnJ5?=
 =?utf-8?B?cU9LVG01eG9FRldUWlNhQWRlYzllLzdCZGFVYlZtYlNKdjh5RFAyYnViNzdh?=
 =?utf-8?B?LzhJZ0s3WmxxU0JYMk9mMzc3alpManFvRE5Iemg3dU5sMlFOMWx2dz09?=
X-Exchange-RoutingPolicyChecked:
	HZeQNYbgtcbroSFJTgZW7yNQfAcoc+47yky1D+AGWz22nMhlYKJsDhJN50TJwcY/x8A2KD10KveBnPBg/02GjQAZqlwU6IzCq55xkbUEFPtPGKikXUmsAm8L1cbSig42tsjBkSRNEfz2Y/8MyUvht9N+5iem+unPVCYYt86RgHFE+gRDDCPl9aAJeHDvuzWYUd+uXxABX1gkQDasgWtcroRwREv7SXXTdbmXn2wN/qknNlYWgmgeB8uFo8Va13t9ly30JgJDTWp8O1sMpePZZorpdbJ2B0wf+6Udx+NATEn4eePi2b7xIYw1nHo0nu1Y4emjcK477y7fHCPsvWgKuw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101dc15a-9111-4467-5452-08dedd876025
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:57:44.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwSn5UxVcrNzMJ60kvPSJ54oSHCUCLiPbSen5nqFWYm6cnO5euiHjeeD4vP8LmGYDbYviMtOe9vABv55NGOejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7150
X-Proofpoint-ORIG-GUID: 8u-ruGInSrwlf9gxDwkj1hlTcKayJBjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2NCBTYWx0ZWRfX6Daabm5GlPh8
 qm5wUq4o89X5iQe2n0Y4itCwC3A7KGujbmU3E/zbvoWXshSMmetVTm5YqvjaOW2mnPmTOAmsUvV
 ACmMeYLuIqWVaHidnMTHFdfIh4RAcy0HtSfWI0gTvxMT4hPh2RJ4kyXY5J1fYOaul2QYYYn2XBn
 /9sFMLVzq7QnStIdG+9k/mI1Miu8Ojy6oFJsdQ7cmCJLx75CLEVDawbzN1A7OutFTeAd0b93PW8
 pt+3bG3CsTwKsjXUe6Dm3DybtvLsftrV2GlFTj28V/VIh41IkXwlu18g/pH4WPBwU5ENW9ZXXwa
 GwoTtBPAx5XDrG47dXwIWzsLhdkk6fU/5KSS4Y4tadwMu5Kr/8prZ6sYrAFBpsK1ntJUTbtX1El
 O4My3iEVGbQQXcbxWEhbwlrwWmffe0yPTkyGm4jbG3Npj/ERVowprDsJXsp1Dkfx40xlX2bjSZC
 O+9GPzFPoniIppdUdNA==
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4f466b cx=c_pps
 a=TofqhMGnQVwdh0HkHXulOg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=edf1wS77AAAA:8 a=A1X0JdhQAAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=OxmsxxJHNjWuO1D9JxYA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 8u-ruGInSrwlf9gxDwkj1hlTcKayJBjR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2NCBTYWx0ZWRfX9kox7o7zsW7q
 ms/KKh4hWRxaKs2IWpQe3xebTfeXWOvC39sWjcIfl/alYwmQRjPi+d2kHcNv4mWfCOArG3jxI1K
 qHnUGCv/yRtmidSvV+o39FPde5hWugdQNlVDyivvNKvCMlMolYFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090064
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306079-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B84A72D768

Superseded, please ignore it.

On 7/9/26 14:54, Yun Zhou wrote:
> From: Your Name <your.email@example.com>
> 
> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
> nested acquisition of _xmit_lock on the underlay device while already
> holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
> the same lockdep class, creating an ABBA deadlock:
> 
>    sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>    ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> 
> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
> atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
> the sibling device with identical xmit structure, already sets lltx.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
> Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>   net/ipv4/ip_gre.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 3efdfb4ffa21..9fbff16cda1d 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1363,6 +1363,8 @@ static int erspan_tunnel_init(struct net_device *dev)
>   	dev->features		|= GRE_FEATURES;
>   	dev->hw_features	|= GRE_FEATURES;
>   	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
> +	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
> +	dev->lltx = true;
>   	netif_keep_dst(dev);
>   
>   	return ip_tunnel_init(dev);


