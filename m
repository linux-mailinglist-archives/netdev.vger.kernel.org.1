Return-Path: <netdev+bounces-240052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D6C6FE11
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00D004FC8BE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21422F1FD2;
	Wed, 19 Nov 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ao597va9"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E72E9ECC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567126; cv=fail; b=Vc/23+8sqMBhHORRoeDvJ2qRQkno5mncly2nv79rjmrXj2d93fxZ5+FAh+CeSKCwQcbNoI5a0bxXAik9kD+AUwuRabU8dVyNCpd91kYU9iQ1Bw5+qN9unAMGMF+yi550UiLXGMcimE6Iv2aCsy+X4HdC46e24hE8SWDDSc3YRKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567126; c=relaxed/simple;
	bh=KKHpBEacNkIuzbjxSWWXsAp6BMXJN4qZHKhQ9+Ha58g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8G77iLACTG2ESlBr1MWS/JAnGFSkV0dQpDiHHFQwXxjXz2nXiXfQiNYsBKt4HCQZTIs9TzWq9M5Z19L8YkPpTK9ZuLHVHSxfRtan7TmZB1btIZ9ABaCRYDblUeub9ktmGaFqlG8w3s9+54s3tZnD9dhdDA9bn8kkZCY9e257Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ao597va9; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I27cWc1rr6xAVACCAV6QdfCnQ6uQN1l2nSfwHLNXFC19EIyt5qTvCIiV8Sm+tcwXqHx1ixs+w4svwqAZ8VcyshFmTKPXxr4H+9JHNTSIpnhkR4INMLFMf6dZOpwRIBdXI6qFc7it2N/EYr5XI8q20MgYimhezG24yUfoAxMgm1a4Wy6pBmLu8H0mDWWAt75vs7OegMB/hn6nywJWRw3Sg1SEWS6PsoAEL8WZA4bUiQ3/WPJvc3vo6fMDr3qIMZkhbMM+4acMsWDSJ7VARqC1M1nfsATBaiHeYnem/JX7bBddg7GKhhW6Avc0cXGiD0Cx2ZnM34ZFwBf6WQen3o3z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIyD34aQbVWUOjgCzeIZlCBI10+dwyQ7gcWuEO59Qno=;
 b=bu/Z9ROhb9x5LpZ69fqQBB904UIeQSfmOEEezwkeYad/aR/BrS2QwmZTPtEd9oirZCMGdtkI4hsFKEuU/u2ymZPtgb+q7W9ZzlT+mmw1DUM13qlbj2PJFTv92hBhMXtn8uotedeYZX930+VHQoIr3tBgq/E83PBrM0epk8Qwrs7O9rSDZYnCwilOLZImpu4GAbJHROhK2tp0nwHMGnKTSD17SLOnNz3TxAnryIumdbdPXV3JidNelI7WgUF7lMV0Y1kOS3iu1Z54n27xG9Zqi4xKmgpci2J6Eb2fwTHmYyGqv3RGVBO890AbiQMBPF4pDwPujjhSNVrpFY5jb2cyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIyD34aQbVWUOjgCzeIZlCBI10+dwyQ7gcWuEO59Qno=;
 b=Ao597va9HHz+Bm95sTiirVpVRiMv6wVpRm8BdKWuAcMs6BfjJZVF8MNvqqgsR2NrLuMQjGdQzPXBjdqq75CUPAgxXbhcYqljjLpGxWN05lS5FUzm/NP5k00Jdru3wrPBBsdCTvOirBq3N0dKFwQbRjFf4N5cUim+lm4fABLoi1tlZd98tsnXomqd8GGyxWZJSqyLdHK0vYTtohRx82z8on6qdqwQ+EzbveS9VXluBn923+0y8WnTPxwKbCRmTD523fCDvz91x5QNc/SNIbqx6Yo32ZKDnyZtHe3i6sQPqC65tO0yELggIeJ6dz/PUtkOuCF+PhjQeWDBReqgSkkvng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:45:18 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:45:18 +0000
Message-ID: <c88f7798-996e-402c-97fe-1f8cc8ec172c@nvidia.com>
Date: Wed, 19 Nov 2025 09:45:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier if
 possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
 <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
 <20251119022119-mutt-send-email-mst@kernel.org>
 <e80a7828-f42f-4263-89c1-66512b2dde6e@nvidia.com>
 <20251119023904-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119023904-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:806:27::8) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea3fd0a-78a1-4495-8a69-08de2782a39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1dLWkQ3Um1PelJqOTdYTjQ1V3ZCRWFvcjFZcFFLZGxyQUlndjVLSml1V043?=
 =?utf-8?B?bHlmY0F4VW9Cb3JtRkU4NU9JU0twdTF4ak9vMUpPL29PSXZSMnViK0xRK2JH?=
 =?utf-8?B?dW1wQXhWekRNVFFjVnFRMUlWSzVmNTk4WDFjNlNiRkI4bG5tMmtYZGlpSjRj?=
 =?utf-8?B?dDdhbnRvaEgwSlhLZHBqa2lscnJHQUpQQTcxTng4eTZ3UCtMRm9ibXFSUzFy?=
 =?utf-8?B?d1gwOE1Rc3FVRUtsWDM2MUlnb1A3RTYwRFhScW9PNkR2NjJRaEZLYU5vMmFk?=
 =?utf-8?B?akdKUkMvV2xEbG9YQVpFM2FoM3MycWpOVjRvWUNGbEF2Y0Nwby92UVd0YXU5?=
 =?utf-8?B?aWU5Zzc0enZZVDhKaVptajd4NWxWV3ZicFJEYmRKYkt5eStHSzhTVG1PbXdt?=
 =?utf-8?B?MlhmT0lJVGFoZjRqcFlKVTJNMTVNSVZmZ1RHa3BtdWZDd3d6Z1RVeU9ncmtW?=
 =?utf-8?B?ZTJ0RGZqU256T3Y3YlhUTDI3MzE5OE9ZU3g3M01jNUN5Tmd3NUV6UHZYRnRu?=
 =?utf-8?B?Wmw0dW9Gc2tXbFd2YXNWM0hWbWE3bnE4QkNpTlJ4Q251blgxclhleXUwcDFk?=
 =?utf-8?B?R1dhZmJUMDhlKzk5eXh6Y1RueXJKUlp2NCtJd0JkN1V6c08zNVE2ejltOFBo?=
 =?utf-8?B?V2ZhYXBxQ2FpNTZHSnE4QjhhekEyU0RPUGZqTFYyRmJyZFFJV3ZRK2hpUFQ1?=
 =?utf-8?B?N3VoSWFoQXpoZTd3K1RsQUpnZUtqZUtVa0ZYOUU4LzcwZXh5UEFaSVkrOW5Y?=
 =?utf-8?B?aGlhenVReTJIZE1WVUJHNWlXSUZDNFhyaEVrelp6bjB6eThHVit3aHZPVUR3?=
 =?utf-8?B?dGJ6a25OZnhMRytQU1NTT3VKeEpUNC8xQVRxOUcrVXdGUkExcTFlTFZHa0tw?=
 =?utf-8?B?am9TTnlkK0lFQmJVaWNWTHRCSWdLT2ljZytwN2UwWEcwaWZoays4ZkdzSWFx?=
 =?utf-8?B?ZHZ3Z3NtUFkvTkwwL3FZNFJlVFdSUlpMQ2ZZRk1vWHk3UnhYT3luZWM1MW5j?=
 =?utf-8?B?OFNveFc3MENvdzF6TG9UcjM4b04vc2hwaElSN1pqV2JQaXozNXdsMEROejhV?=
 =?utf-8?B?SlFtMlkxZFI1UXRqczk2RWVmbmFlOVY5c1dBYWJ4cjg2VU15bVhWQjhDbnV5?=
 =?utf-8?B?bTJ6NDdpVnVZNVYwaTRzazRGMFM4S1BZM3VSdE5HMlpYOWNIc3E0c3BIYVVD?=
 =?utf-8?B?QW5SWkVscldHL2FWUmFDamR5djFTVi9tWjZUbk53Q3JpSWQxMnNWL0VpM2M0?=
 =?utf-8?B?MVVVc294cVZVcWkvMGlhdG5peU9RdU5mOTRtRW1OeG51eVVRSW1VdmQwaklK?=
 =?utf-8?B?WVF2cENia1RyQnc5WUMvUlczVkh4T0FsVTJ5Ui9rQXE3bWpmeFN5K2RMS085?=
 =?utf-8?B?V2crWURMQ3VyRWR1TVZvK29BSngweHpBa3NpNys3cmNLRXp3NEVnUzRrYXli?=
 =?utf-8?B?Q2VZeFFMVGhnS0xScitKKysxRjltNCt2aHI0RE4zZnFBaGpGaHpzVkh2N1Yr?=
 =?utf-8?B?TlZtQWhoTTRVSW9PaGswYXJCelp4M0VtRWw0TlRBY3psWFM5aDFnR0FiblF0?=
 =?utf-8?B?ZTkzZVNuRVlidVRUTVRoak84WDFNdmExQWw0QmFKT1U4VFNHRGFsUkhqRHI1?=
 =?utf-8?B?UFZuaWJza1ZndUFoQTBTb3dTclpKeHBqTnliSjZlelliOGV3dDFNUjRNK3pq?=
 =?utf-8?B?NTNMWVBrM09jSlgrRTNTTTJXRkx6aTJJaHZHa0FOc1RoaitWLyswOGMwNW55?=
 =?utf-8?B?VldsWkVFdklveTB3eGFnbWNlM01UV1g3N0YzS2YvQ21pNVpxcWVzbGRTYjFQ?=
 =?utf-8?B?OGl1Qi9YSTgrTmhnblM0RStSdUMxeUN1Mi9IWW1yKzJJVHRKN2N0czlxa0pZ?=
 =?utf-8?B?aHE0clo1aFV4Y1VxRVNWM1lOMFAzS09wcVJyc3diSWVsN2g3R3c4ZTFwd1E3?=
 =?utf-8?Q?g5CNB78YwqgtznRrpf/l2hLLLj58hdKI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a25xY1dDZWRZZ1QyWnFnajBuMHdsNHpBek5EZzZEQ0dRK1V6ZklkTlhzcGJx?=
 =?utf-8?B?U2J1ZktxNjJoR05DRElacW16emMvVTlPUk1oSkYvdUZ4REZVb1c0RlQ3MDVt?=
 =?utf-8?B?SHlRVjRzcktnUm5wTjdNUURuLy9QTU0vUjlCTlpkRTJrMDdlKzRtV2tHaHlY?=
 =?utf-8?B?TjlQNWNxdFFjd1NGdUF2RmdrTjBqWVdXOXN6aEZiaGNWQkwzVTRiNHdWUXZZ?=
 =?utf-8?B?ejhTSExISm9HREQ4NVFDdmRLTnFrK1NlTUM3QWRZck4vOVlDOTdMWW9OaTg4?=
 =?utf-8?B?bHo0Y2IxajV2WVl0dTk4UFpXdS9HT1M1UXZGQlM2VEIvTXlVOVR1QWhyVTRU?=
 =?utf-8?B?UTh6dGdRR25tR3hoWVljKy8zUTRwRC9yVno5QlZBWGlGZlc3TFhZc1kxMVVE?=
 =?utf-8?B?UGNOeGgvcU1SRXV5M29iL0J5a1RaQ3FXbHZwQTZwaFFWZzlPT3FqeUE0QWhq?=
 =?utf-8?B?Q2FWMFZlYU5JNEd3NllGTWN6eEJZc3MyTEgrZTdEazZlVnpNWFlXUU8xTkM0?=
 =?utf-8?B?Rm1IK0cxSVByOFRQaWdnYkVwQncwQmtkNVJEQ05tOG5FZlE5MGpqNmFZUGhS?=
 =?utf-8?B?ejNYY3VwQWc0a1lWQjk0UkdnTTQvbWR1dmtOVm9waG1VNHByZmpxd1JLNnZB?=
 =?utf-8?B?OFpRU0VkL2lFOHNyZmVuY0tQaTAyaUxDbzkyTlA5SWNFc0NMSEQxdTAxR3JC?=
 =?utf-8?B?WGhZUlhuM01OVm04cGthMDl4SkhnSnpFQnFtdXlNMFBGdHVvWE5MOVR2d20w?=
 =?utf-8?B?cE1LN0U4OWNuNkd2MFp2OStBTXp6eWlTV2taSlF3NGxXS0NqblBxZFdTeDZr?=
 =?utf-8?B?UVMwdnE5Qy9rWHUvcGwxbTJDTFlDdlM5YnNHSDQwOHVmQ08wVStQWU4yTVM3?=
 =?utf-8?B?MnB6TmhKakIrWG9QZFVFYmJjbit5d0VMdWRqeXhWSEx0VlhMZDU1ZzFXNnFj?=
 =?utf-8?B?U2wvTVdxTmFnMTJUd2psRTJKSzh1MUQ3eW9rdmtKNVhVSVRHWkVQQXJOdGlP?=
 =?utf-8?B?M2NiZFJDTmhEbm5aZ3lYL2Fab1Vhcms0WVhRRWhqY2FaRTNtZXZoU04zNFNw?=
 =?utf-8?B?Z2UxQzV2Z3k1MU1lQlcyUzN0cTRmbTZwSy9uc0kzREd2Snd1NTM1MHdpaXNq?=
 =?utf-8?B?NGRPa1hZZEY5dFJYYk0rK2xDSDJnMHJFNEtNQ0xpaDQrUlM5Z0VMSmhMQTJi?=
 =?utf-8?B?dXRJdHlDS0EyTGZ5Z25BRC9Va0ZiSzVQTFV4ZkEzdzBOa0lIcnFaTmUySk5i?=
 =?utf-8?B?T21SSXExVnkvQld6ZG1KbTJzZ2MrMWd5NitUaWdQMWNqVGM5UEdRdytYMkNT?=
 =?utf-8?B?TVRIUHc0eEFqcWRVMHJpL1lMdTFNN1BodWI0TzhucVcwM01ZdEN0SnVZUmdG?=
 =?utf-8?B?WFkxUkxFbzhtMkViM3ZmYUxPamxkaVNRQ2k5ZDQvQ0I2dTJmWW9YWG12WUJt?=
 =?utf-8?B?Vis0dzdUVWU1eTdTV0NYQy8vRHZrR3RlTXFSdHAwYVNhL2R5c2tiaWUxQWhS?=
 =?utf-8?B?SC9RSkRoUmo3RzhaUzhuNTF5QmRjZ3RvQS8zK2RWbnNlV2pQZXhuOUxzeURE?=
 =?utf-8?B?MTYrMEhFOGF0SUdJNE9QbmdRTzdBWnZiakFKVGtFSGxFQTh1V29lTUVjSGtE?=
 =?utf-8?B?M2xOZVA4ekowSndVaW9BMkJubGp4RTJrWFZZbGJHOUF3WFdJT0c2Vzhib0J5?=
 =?utf-8?B?YnpKckZWTEFRU0dOTU02dmI4VGk4VU1vVFM0b3Nadm9CdDdBRG41UFBRdHcr?=
 =?utf-8?B?SjdWS1NSaDNUVGpxMWp5cTk0Qm90NWUvOEs4U2REWHg3ZE4ydDRROXcrVHFK?=
 =?utf-8?B?V2xPM0RyYUVGVmR3bFZ1bmJpNSs5ZEpueU82blNqdFFxdENOSVFyeU9LbWJY?=
 =?utf-8?B?Z0pTKzlQV3ZpNkNTVlpGTXJSVUZIS3RkYWdnQ3N0eEtaRGo2TUZCZU1IQVp2?=
 =?utf-8?B?MWdjK2FGNncvVVJkMVVxa204d0ZRNy9pZzdRYVI3YkxIdTBGZVFqdFV2ZWpY?=
 =?utf-8?B?UnJnZVVHdys0YUoralp4YnpnN2R0R1N6WWt4QVcraWdocjJuWVFBZmpMeHkx?=
 =?utf-8?B?ejVucmxvd1JWVFZCcVhpQnhzbU51aUNsT1pGb0FxcE5KSXlnUHVsSGhtZ0Jo?=
 =?utf-8?Q?4/eOVFuf7s3cJxEpvY337sGZy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea3fd0a-78a1-4495-8a69-08de2782a39e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:45:17.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImohvustwhJ1wWs9kjQMkR0h3JiM5/jHEh5rmqKRoFU4xi1+tls/cUUtxXf7SPBu1RzawNSpzxf3GZK5gDQkZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833

On 11/19/25 1:41 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:33:31AM -0600, Dan Jurgens wrote:
>> On 11/19/25 1:23 AM, Michael S. Tsirkin wrote:
>>> On Wed, Nov 19, 2025 at 01:18:56AM -0600, Dan Jurgens wrote:
>>>> On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
>>>>> On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
>>>>>> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
>>>>>>>> Classifiers can be used by more than one rule. If there is an existing
>>>>>>>> classifier, use it instead of creating a new one.
>>>>>>
>>>>>>>> +	struct virtnet_classifier *tmp;
>>>>>>>> +	unsigned long i;
>>>>>>>>  	int err;
>>>>>>>>  
>>>>>>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
>>>>>>>> +	xa_for_each(&ff->classifiers, i, tmp) {
>>>>>>>> +		if ((*c)->size == tmp->size &&
>>>>>>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
>>>>>>>
>>>>>>> note that classifier has padding bytes.
>>>>>>> comparing these with memcmp is not safe, is it?
>>>>>>
>>>>>> The reserved bytes are set to 0, this is fine.
>>>>>
>>>>> I mean the compiler padding.  set to 0 where?
>>>>
>>>> There's no compiler padding in virtio_net_ff_selector. There are
>>>> reserved fields between the count and selector array.
>>>
>>> I might be missing something here, but are not the
>>> structures this code compares of the type struct virtnet_classifier
>>> not virtio_net_ff_selector ?
>>>
>>> and that one is:
>>>
>>>  struct virtnet_classifier {
>>>         size_t size;
>>> +       refcount_t refcount;
>>>         u32 id;
>>>         struct virtio_net_resource_obj_ff_classifier classifier;
>>>  };
>>>
>>>
>>> which seems to have some padding depending on the architecture.
>>
>> We're only comparing the ->classifier part of that, which is pad free.
> 
> Oh I see a classifier has a classifer inside :(
> 
> Should be something else, e.g. ff_classifier to avoid confusion I think.
> 
> Or resource_obj since it's the resource object. Or even obj.
> 
> But
> 

Did you have more to say after that "But"? I did this, also updated the
commit messages and included refcount.h.

> 
>>>
>>>
>>>
> 


