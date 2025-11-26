Return-Path: <netdev+bounces-241786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE8C88388
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419AE3A7DFD
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D9315D52;
	Wed, 26 Nov 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ppF1503Y"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE330E855
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137515; cv=fail; b=sTmaPtyjiASdv/kA+z6JEaFWiTHgQ9yCiiLcEJTnHVI1gPCSSzdfidFCrRqAh3EnYb1bdCFBldpQKq+MQk5o2H53pyIqlGKsq0SfhpGQbvcnrhuOV/QZ1rE9MHPGFRM2YJfyD/9AsRuRaOYeQXtQDHcrZ4yF8nw+Xs7C8dGqdww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137515; c=relaxed/simple;
	bh=1bAI46EHFPvOrh1lng5R2yjzFr0om+O5dv/LOysYZsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o97GEj04xRFbjw5vwbSdl95iAQA2QdmHnF+uRM4ISS5m4JFp9NxSDjvcIF36bwz0Gfay70d72mSL/WkaGXr4SCzmajTuziraGcBsS9oWbtfN//7diPOvjANTtyQgMYWe6mjaPVoLXes0ajvWbwqpG7YxYROhOpOyzsSfu6g7Aww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ppF1503Y; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuTRWT8LG+GIYGqIWhWLAoFvmkMCxb3y+WXPh+xYeGiURk/56kpPHq7oHNArQpt7eHnYGu433xK4ProjJ7f9aPmiJH+ms/7vb9Zbz10kpNZaiuq72s3pgjMHjToBS/X43Lk4bsBkl/hhQKWZUjad7wQGDAIXPrvE1hgkBcl4TKmCeVYS7tHQSMKUKdiZ1pKTQSnTGM+k5D3lW0NXnQOSMsivo38HA0B/IQWDsk0ryIyPnbChp1voQC/L6Nu87S1b3GZOidR5hVFpYyB8uAL65LEq8Qv6x6w9Lr3ZONahvJmwQG9NuStOPCY2hA2TezczflAtv1QWYS/X2WJrZbxiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VzhvtEA5mc4Eh7//NaVsO/u8c1SA9gEla/xOXI46Yg=;
 b=l7N7BaCymY2bhKODeI6uFD+HBEZ3DBSTe2rlXjFYQMcqRdmz4zcq/wQPtHarmyOBlnhrCX/LZ7s7mEsxRweIEY58+fcB4k+nu9n0BSUaZmnzUGs5SPWDo1jU0KkY0P62Mms4hKQN/ssSClqt6T9d+roxRoovsHAEJmtUVefTqXCYbfO9GpJRV/NNUHwi+zYq9e+YE3XtCmw5u/KeHsRaXKG9rf2oAMSagJSS1Go2buvxOEjDMJnbl7wlWHQM+O4SFtdoeDQP1LUNJEXp4gaZaLbGwcsmpwiP87WxE+IkxeSlef/X3BlI9uFoAVamSQkz8mMYlR1X8Pdy/3A8lr8gTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VzhvtEA5mc4Eh7//NaVsO/u8c1SA9gEla/xOXI46Yg=;
 b=ppF1503YxsqrPi24R1X0xDBZQm+4X+qBPuBtibybXrO5DIb9G0FUuWVe6no7Tvo51wuBKpWpS5C3XRVSAQfPVawKNkbXAB5WKOxQ3c0KF7smlMWZyri04BqOTKsqSrH/jfTnyEF4xyQue9es/LDIIJya4Jb3TrbMMU/yq615iqBY40zlzviXECApkLpv4ccd6eWPxD7h+v99hs1iF+63Xe6tmdjKPq6V0P+oJc7qwYcuqoQkhhEox4bY5EKM06o/SIxt9Rt9rFH1UgMtSm13J03ZjToBcIn3QGEarhlZLtHstnyRCTTEkOuGuln/x6gnBrmd/J1nxVIZoREo1GM7dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 06:11:50 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 06:11:50 +0000
Message-ID: <94c24884-4784-409f-99af-2d39efd3a81b@nvidia.com>
Date: Wed, 26 Nov 2025 00:11:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/12] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-6-danielj@nvidia.com>
 <20251124175247-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124175247-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bdff93-9329-4054-0100-08de2cb2b007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGYvc1ZzZTlWLzZpblJ0YTlZaHNySW0vN1NIeVh1cG56alBBMDNHUjIxaTQ1?=
 =?utf-8?B?a3JBdlBSZ2syS002MUV6ekVHemFQQ0tCT2hKQ0hSNmN4ZDcxS0wrOWVmcFMw?=
 =?utf-8?B?VzdaSFhCTTJtbDNkQTZhK3lUQzFlcmlBY0RKeTg5bE5zUHNtU21LYjJtbmNu?=
 =?utf-8?B?TFRZTXdCSnJoblExSmxtN1hzdUZ1WFY4TmhQUzZmbWxxOWxFOWNqb0EzZG9r?=
 =?utf-8?B?U0RMOS9tb1dBcTZlaDk2R011UVhSbUZZL0dHeTlpbk9mbDJrY05BWE9tRWRx?=
 =?utf-8?B?QlNmQm5IN1IyclZQRzlYODk0UTViekRtMW1Sa0RBemtEM1NPK2RZZkxLSlBp?=
 =?utf-8?B?UEdmZ0FVWVUrSDJGWjdnZHJCMStjZFJ0c1ZGb0psVU9sTmR4T28zTkdDWU5N?=
 =?utf-8?B?OWtBKy9KY0ZZZS81SnJOT1lhc29KT1U3N1dSRm41R3FEdEVZZ3M2VkVUZXlY?=
 =?utf-8?B?WGxWbzM5cDVqVWFsdE1tenRURG41OFRuZG90YUhRMUNiaitKZWttWDRneitE?=
 =?utf-8?B?a3R5VElvdkVxcUtYNThBVDBwQnRHaEdDenMyV0pQWFM4KytYRVRsWDY3bmJl?=
 =?utf-8?B?dkdnTE9sL3ZqcEVBWGtpekxpVzdZWjdsVTBHZHhqSXdocEswbUo3VFgwaElG?=
 =?utf-8?B?dCtuYzlvU21IR0ZzVEUyOFdEa05DZTdxbitTWW14Mmg2ZEVZMFU2c2RTMkhj?=
 =?utf-8?B?VVJIZ2NxYnJrUFVlMlJQNHQwZks1VDhqa29HcFBTUk4zd1laRU5MNHh5TTh3?=
 =?utf-8?B?L054WG0zSmdaeDVMZzZrVGtGcDQ2VnVWRVZ1dmxQZ050djUrak0vdGRHSHFj?=
 =?utf-8?B?aFcxSk1LQ1dmWmtzeE4zWnoxVVRiSGRnU2N2UWRpWE5ISzRsbHRoK3FuTG5W?=
 =?utf-8?B?a0hQR045L2ZGZmhBYUYzZXVsZ0ttSnArc040eTdiL000cGN5N0J0WjRnMnhO?=
 =?utf-8?B?azYyRndrKzVpdDRvNjNjb24rWFM4b3hSMUdnS1FUOTJGUUlYUC8rN29udGNr?=
 =?utf-8?B?cjBHeUVwU3M2SkJLREJ3d3VSbnBKSGFTUVBvYzhTWFYweDg1WG9WUDBzQ2xp?=
 =?utf-8?B?dGR5b2k4WmtqSjliTk5iM1ltd1JmcWIvVUZWWDZ0STRvM3N3TnlPOTd2UGJ0?=
 =?utf-8?B?c1pxY3ZSY2NaL3E1MFI1SGFZcTFnUDY1dURPaFpBWVZkZUl1b1lnRzFCWW93?=
 =?utf-8?B?bE80bkdvYlI4MkpaZDgyaUpwNEhJbDBWNDZ4Z1hIR2VIRUlCTXBVOFU3S0JO?=
 =?utf-8?B?OEdPVjRTQ1ozMWJoMkJkYmFGczdaRUpCWnhuZjdyOGtERC96RWhpdmk2aFRZ?=
 =?utf-8?B?NytieWdOTFRoZmM5WTBPRWV1UzFVeCtpMVRNNTdrSnFEU1pleWR0MlZWRTVk?=
 =?utf-8?B?RldtOTU1aHNOdDVFTElDaDFHR081cE1EdzNFcDdSYmU4dnBWNXZsY0N1Snpp?=
 =?utf-8?B?Y1p0aDhCQkpHeSt6QmdzdVdVbWRJUUJEbWpPMEVDWUxtcWZwWGVQVHZsK09I?=
 =?utf-8?B?U09reC9razlVTFc2SjgzVzBDWENDcjdBeHl0OG5KbTU1cHgxaUgrdEx0YkRN?=
 =?utf-8?B?UEs0QWc2SmhKdzlFdFhyNDR4M2lBUkdkditWM0xyU2JOS1h2YTFUdnZGaDJh?=
 =?utf-8?B?UnhqZ1VYZDJHK1JWUFhRWlBYZmg3U3orREpOTkVpWFZsblBzc3gxTHBEM2Nw?=
 =?utf-8?B?ZkoybENSaitVVzFHT29xYzczWkxFeHp2b2hnS0w1MllmN0t2dTlyQWFDTTZ2?=
 =?utf-8?B?bk1nQXFVUnhURm12YjdtbWNzZFVTWHMydFRLNXBYV2Y5YUp2dHhKUDNGZmpr?=
 =?utf-8?B?NVZkbnc5MmJ6eHVuZVpDYVN2bHVqVzVVTnNaVFVIemRib3lxYjZVajYxRnQ2?=
 =?utf-8?B?bGQrb29OaXUyNWNKRGhxUTdERmd1Y3pnM0M4NTNsTW50empDRGlHcGhQV2xq?=
 =?utf-8?Q?Jcgvpt1r6+hNTwqqrvow43D/ZiFHX9Ab?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXpDdXRFcUY3KzFIeGd1N1BTc1VDWUhweDIwWENFTFQ0SURnVk11dk93bzZC?=
 =?utf-8?B?dEkzc3ZNVXA3ZWQvV1ViMlVWbzBoclhreGtXQy95eUF5ZVVQMFhsTGYrZjV3?=
 =?utf-8?B?WmFsdjVtMEg2bEJyN2ppeGszOEx3WXEyT242dytaNXBiU2dXQmlLVDI2am5m?=
 =?utf-8?B?UFRtRVBXUHVoclROSEV0UFpCR2UyOUJsdmp1TEpDUGdkMzYwVGFTUHA1YWpG?=
 =?utf-8?B?UWVSU0Z6cmtVRzJmMEx5QjhsdWsvZnBCUk91R1FMVEZKK1lZS2VWY2xpZ0Za?=
 =?utf-8?B?MkxKcU8vZlFEdnBaUTVRVU5QUjNVTk1CMDdqUk52SzNOQUVYVkdDRjRwVnBH?=
 =?utf-8?B?U0NSbGgvU1BuRTBNUkNkcmtVcTFmRWJvZkZKaVI0WGoyeXlRN1RENEVPZVVr?=
 =?utf-8?B?SHJIb1FhTlBvaXhYd1pzTlovekc3NmEyc3ZEdDJYQ1RUdHVZRGFmajB3V08w?=
 =?utf-8?B?TWpSaGV3NlJTZDcxQ0Qwd0JrTitST0JCNlRJQVlycmxFbTR0T2JOWXlQb2ZJ?=
 =?utf-8?B?VUhpWEtQMUNtZGMrQldIaU53anBjRE9PaXQ5bDFzQVdkVm0zb1FacFhReGVO?=
 =?utf-8?B?SkZhcjFXQjR2K3FCZnFaYktLRUFBT1JlVWNKUW45bDhtMHpWU0t2emYyVnZS?=
 =?utf-8?B?MmZDK3F4R0E1cExON1VTdnFmSWoyKzdnekpBeGFhWHhDK3U2MHlTSHJQUEgw?=
 =?utf-8?B?aGhvS0ZTaEswenNDZXNaN09uekNSSzNtcVo5RjdMcFFwSnhib1pBV1NLdjdz?=
 =?utf-8?B?eThLSHB5UUZDaFlFQTIzWSswUHorWmdXTDFDMXpoTFZUVEU5c1VWNDcvZVdt?=
 =?utf-8?B?cVA1TEh4d2FVNUpFaU9iRGJyMmNuRG9qUkJud3JXVklyMzBzWDJ4ZzIyV2NT?=
 =?utf-8?B?d1VmSVZxcVFKRTBtNkJGYjZnZzR2UzI3YUVjTndwVDNrUGlPYkM4b2hlY1RM?=
 =?utf-8?B?eitlN0lQbmVHUVM1dXl2UmNsNXJVRGpENmdOYmUrd3orYXVhU2tacUkyWFF6?=
 =?utf-8?B?dlZUNTBZNEVPQ0M4RTRSYk1SM1RpaW9jOUhUa1F4WGhxR0dUSTlDWk8zeTJZ?=
 =?utf-8?B?R1BCZUJwZVhWbWxGbFR6aWJXakxONFcyZk5IQnJBQVpuMENYS09XUGMxS1Vy?=
 =?utf-8?B?Q1hNRU5VWnhSRmpvTkM3aERwbnhpZm5ESkYxVld5M3RYZWdMQ1V5OUgvL1Ur?=
 =?utf-8?B?MTRvSmJQb25ZWkFnZ2ZQQWhWVVgwdHA1VHluU1lhNld4dDBFbUhjcHhsaE5x?=
 =?utf-8?B?K1Q5WXAxS3VFSkh2NXU5VEJkektpT0x1aVltWFdLc0pCSGdvV1d1SkcxRzJj?=
 =?utf-8?B?NTdMUzRadWZGR0JkdEpDa0wwVm1TUDRuMlNPRG5rd0pSRmF6cmZ3UjQvZmQz?=
 =?utf-8?B?bmNOUUZHd2dvNUtFcUR0QmhHZXhvRkdnczlkdHg4d2E3SHF6UHYzY3dUM0ZF?=
 =?utf-8?B?U2VmWEhHbkpJcjgvSnVDM21NK2hpZnJ3SnNVUkFzd05hY0x1NTIxWnB1M2d5?=
 =?utf-8?B?SDBibER1OXJvSzUzOEU1OFUwRzZ2TjJnM1BPWnp1OTBHTDlBbHZ1MVAyMXM5?=
 =?utf-8?B?M3VtL0V0cFRVNjNyYTRkVGM0U0tlYVdHdWhHVkdXMmNMTkxDZlA0Mk5PbW1F?=
 =?utf-8?B?TkRURlJwVlpTNjQxZ2dlM2Zka3pYeld1NmJLNWN0OVoyOUJwbk9vYnorWlBN?=
 =?utf-8?B?TUZBZGQrV3c0UUJkeXNmUXpwTWh5Z1JSMDJadEc1RWpEMW1GWWNtOEExR1li?=
 =?utf-8?B?YnRkUXdKWU8vZ0NydUlnT0FBb1REaGtIRU85OVloT29VTmdMVmVjdEx5ZkxW?=
 =?utf-8?B?bGw3b0haMWFRM3hxeTV6OEFLTXk3bEtmOEFnTDBsZUxpdTRuL2FHODdDM3U1?=
 =?utf-8?B?eFp2eUhmOWh6dVpvVnU0Q01MdW5zWEI2QldNUDlUVTBVWGkzZFRCY0hkT0ww?=
 =?utf-8?B?TmovTi85aXRDSFRrR3AvWTRzcjR1c2JIS1hIYTJidUo5dTlNcHh1bXlRbTZj?=
 =?utf-8?B?VitOeU5pSnBJSjVKdXppRytqelhrQ3VhaFB1Nms2NXZtZjRnQnIvb0hoZnI4?=
 =?utf-8?B?V0NabVFjQjVQYW9SRU80THZReUlnRGRUbWFON2hIK3RJcHdLZ01zVWhBRjRS?=
 =?utf-8?Q?Si9s3wBTARdkbkpq3ZZg73oVg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bdff93-9329-4054-0100-08de2cb2b007
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 06:11:50.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcUZ1tugnePp1MvA+EJa69s+0ybrcXxpiaGpQ3PlWK3hMiSGqiEZr8ywona6cqxHycVDIGYe+LmQG2Men+Zyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099

On 11/24/25 4:54 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:16PM -0600, Daniel Jurgens wrote:
>> index 4738ffe3b5c6..e84a305d2b2a 100644
>> --- a/drivers/virtio/virtio_admin_commands.c
>> +++ b/drivers/virtio/virtio_admin_commands.c
>> @@ -161,6 +161,8 @@ int virtio_admin_obj_destroy(struct virtio_device *vdev,
>>  	err = vdev->config->admin_cmd_exec(vdev, &cmd);
>>  	kfree(data);
>>  
>> +	WARN_ON_ONCE(err);
>> +
>>  	return err;
>>  }
> 
> 
> The reason I suggested WARN_ON_ONCE is because callers generally can not
> handle errors. if you return int you assume callers will do that so then
> warning does not make sense.
> 
> Bottom line - make this return void.
> 
> 

Done, also, this hunk was misplaced, moved it to the patch this function
was introduced.

