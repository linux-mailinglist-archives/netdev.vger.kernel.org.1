Return-Path: <netdev+bounces-241028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C74C7DC95
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 08:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8334EB70
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 07:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3491DF75A;
	Sun, 23 Nov 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OpJx/fyl"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE853B1AB;
	Sun, 23 Nov 2025 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763881513; cv=fail; b=ckPm04UIQKl2u/G27Iiu/+wlWd4fjWTlqYLgROyuOp3s8SII9Ngp9srXgganVUGChwg1Qs4NuUNtEzsaMyx3rHgsaPrdXxpcOylRNSI8+Bvec99E0llWq1urqWcd25gvp29zC0+ltKtAKhgo+t9hFLenYNoCChz+9C0KrOTeAlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763881513; c=relaxed/simple;
	bh=7dl9+m2qZu2tkcfwDL//TfhXFpxOG+jcVcllOiQU9Do=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hpHMe8WqrtOXs9DHtjPdEWmSkCHrTYfM9PiZ2mZ8J+bfZqkTFKAuwqiXpzGky9ms3/6H9Vap9a9xo9KoY1mC0TEFrAvqWa6KEbk+Sqq+tVmiJnMw0xBGsqJg7Tb6SA8aOjqSFN/PcNqv/7hgwsEaeUdYGuTxX/1835ci4oaTKSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OpJx/fyl; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9KiWGTZaa/kqmE//5vFEkQp7Vl/6ir7ZNOOU3pFbk8LPQlAQAGbabvxtms+rUaVEleszbpcH8aQlSu0QXLC7HrTeZvEHv9dRPCextLtGybIlJ2m45EDQejrOHkTXB6PpCVuMlSyrBub3+Zgogxu+4gopuLEinrkvqVtje85rGRP5EGrISfk42i8slh7dipyiL1arJNW5mGuRSlDySETXsMmtBf6bC4otJcU1zKNFAD3hrefJEzpctAiumXMHKE4oxKGlkix6RXUdibOH7zchAgjLsT1KBuoXCg7Gr/ke9bLD3QNDZTgJzHy2XHk+sxObfizwApC5VBA2/HknHUTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwLN/1EnrLnEgaNuBzlSEgzVpy9XFdaH4CKokdOKbBA=;
 b=cIy1kJE+6pFswZ3hiOdLDKgRMIr48kq+X15rvk34dpP2PaFLL09f4aeUeiX8D51OAAlgSheD8GzDFIDH8halmxvcrCDMLqcpZp37KCrRorDUrMZk+DoeWtVALvgBalf9c/0z3Zuw7Zy73iv0DZYPt8lOKgAiP70ZlTtes+mocp/DRXihTa1YCOvX52evvvhtSM0sF3Q2CKpaw7UHV61QceIz8NKRKdJHPxZrnl+Jlqz21Jp+kl/BWyFEsQXCtEx0nwqKOk/benCOLyyGJehTzRrhal0ruCyERx+7whyG+dHlk3qcntZdI9Z9IHDjzBMfbkq9Yz6kuZrDKhRJZW4mMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwLN/1EnrLnEgaNuBzlSEgzVpy9XFdaH4CKokdOKbBA=;
 b=OpJx/fylaxe9Bs8mkkx+0ze8Z6U5X3Kv7gAAEA+HhI6SekbDPFpuE231WrgIIrbY9m4nnC98Az7oFcb8CnOg3eJ5VsFMmPVg5fU/Mgw5Hxh0nwHE88C5eW4U+KkPAvx4PgEmos8mGHsyfdeF1yp0KURTGparIFr718mUYtcXXk3clrt7Lyj8IJdtivhWmSNXUUFsEkzN5lcU4ILOfviTwDb3Bc1WOYZB4iqthok1dUyAz+Kbly8BboYyJJnIfNvUb4rB6sHBcUUJQ6HT1+LrD4i9Z7IcalAugP+1UGLrxsTQHYldKu8vfssDzbn7yv/KUKigAZMgCR+slqsooqw3Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 07:05:09 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9343.011; Sun, 23 Nov 2025
 07:05:09 +0000
Message-ID: <d78d22d3-c8de-4d8a-9990-a66ec9ca904a@nvidia.com>
Date: Sun, 23 Nov 2025 09:05:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/5] net/mlx5e: Fix wraparound in rate limiting for
 values above 255 Gbps
To: Danielle Costantino <dcostantino@meta.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1762681073-1084058-5-git-send-email-tariqt@nvidia.com>
 <20251120214228.1594282-1-dcostantino@meta.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251120214228.1594282-1-dcostantino@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: b67182f6-4db2-41e0-d124-08de2a5ea356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uy9sZy9OQ21YMjgycW8wbE5UbEZYZU5xL3RIbVBFbzkwSUtCcUxnZ2Judlpt?=
 =?utf-8?B?RHRZOW0rK3B5T3NQdEE4Z1lNSzJBNW96eDhSaEFhdGpEcmdsYzBUNjlka3NL?=
 =?utf-8?B?UTBBeTJzZjZlaWdwRWp4OHM3aElXZm9ZRDJSZ2dnQk5QSFp6Z01Dc1dqY2th?=
 =?utf-8?B?SGtJMnBUUXY1dXZHcmR0R0RKZUViNWdCUzBpcWxnNk91T0FhSHRtRHNBZzJU?=
 =?utf-8?B?dHREMXhQazVPUzZ0U1J5Z2R2NDJCZGViNWRPZ21sVnhXSXVySTBrb0lwZHdJ?=
 =?utf-8?B?VE1BQWo0Wm5KbDd5SEQrdXBjSmM5dURGaHc0V0FXTmQwTnFSOUJhVWZNd3Jx?=
 =?utf-8?B?NENEZmVJRUJTRSs2bXNGOWZFUVVDbmsvYk82WFJ0UVkrVWlmK3BON0UvejF6?=
 =?utf-8?B?bkNKbXE1MHoyb2NIZDcwSjluSi8rczIvQXZHdFptRmNwYWY0RWxnS3JYRDlq?=
 =?utf-8?B?TEVrVVJnVnQxL1VYMjBVeW80SmhsdGZGMi83VEVFR3YrSTN6RWM0dkJoa0gz?=
 =?utf-8?B?ekEvU0I5MWJZMm5WOHNrcGdGU21IYXpzRmhXRGUvNkhJNDhzb1l1MTJIN3Zy?=
 =?utf-8?B?VU9LRnMzV28xMS9ZSWJES0tRVDZObHkwZGN5NjRBSXFNcXZBcHpFSWVqM2ZK?=
 =?utf-8?B?dlI3ZVpDU3ZiVkJ3OGJvVENKTkg3L3VVc1ZDK05SZHBlNTFBaFBVbmZudUwv?=
 =?utf-8?B?Ry81OFV1R1MrbGIrWVBxcE5td1NjU2N0Rnp0UTY4cGFYekUzRVF5c21IZXhH?=
 =?utf-8?B?djlVSEs1VmNNanFLUkpITzV0aGFlWnhXbzlraFc0eTBmVVd4S2ZvVVhlU1Vu?=
 =?utf-8?B?Z0hKTHNRc0dKY0s5Zm1qSlRZbnFtd3lwWk00NUY3L3FsZnNhcm41QnhZZmVQ?=
 =?utf-8?B?T21tc3IyQk5zbE1IZ1lkK050TlVLUEhKZVlDUmhFbHQ1WUlHTzFTMERRbmJs?=
 =?utf-8?B?ODNna0VpMFlycVd5eENyQXdPcE1pTUFzalpGRFozc0lyUlFRMnc3a3RsOTFt?=
 =?utf-8?B?Qy82Lzh1Q0EydlhrNHdYZ2QxMndlajZUQkN6Rk5adXE0MEJDRXhKMzJrd21W?=
 =?utf-8?B?cnVDNlJGcUtXNVlFa0ZkaGYzS0JPV0lTQThMSHpQanQvT3VjcDJUb0ZCeFBt?=
 =?utf-8?B?dHJhcHFFcDByelFZUms1ZlZ2cWxYTDZObmUzS1BBRDV3amZJUzVQUStFanNP?=
 =?utf-8?B?V2tUNjZBQ1M2TUJZV3BXN3FXZ2d5TmZGKzJ4b0JnZ1QyWFdvYnk4bFI5YVBW?=
 =?utf-8?B?bENXUUorWHNsWTV3N0VVc0xuWmlpeVZpWmdCSUphUklER1BuZ1VzMzRaODI4?=
 =?utf-8?B?Q1J3aUFQcVJvN2txYksxQU5KU2Q2TGtvTFpJT3FOUWlsRkdwSDlpMklQNi8z?=
 =?utf-8?B?R1BhbjZTMkg0WG0xcUNvUldYSmp5dXJYUmNkK0ljbGJiVjN4aDBOUllrcnpB?=
 =?utf-8?B?bHVMRFlqTURlbDhhdmVTWVdJcG95ODlnQS82aGNBTVNlZ2l1TlExMWxkQlNS?=
 =?utf-8?B?VmtnNTJub1FSVDYrUndFb1JRQUtnZE1rTVJ2WHhpdjg2SlMyci96VGhsWFBQ?=
 =?utf-8?B?b0RCN3c5Zkl0YmpjVUkvUU9USCt1Wm5JK1FzY2FvZHMvWVZUN2JqM09hSjVu?=
 =?utf-8?B?OE5JT2tsN2VESXNXNEYzT2FZYVMzbGdnYXN5bUNoRnY0L2E2QzVqVWgzU09Z?=
 =?utf-8?B?UUN4M0tDN0VzV3lOSmF1MWhrZkNsbjhjK09JSGROVFAvR1RjVW1tQlFISVgv?=
 =?utf-8?B?NlQxUWJHWWVHOGY2aEpFanZ6RTluek9KaktFa1ZQUFR1dzAwTHdMNDByRGl4?=
 =?utf-8?B?eFNHMDZNV0VMRFRIWndDbUd2OFBEdk9iSi9YYlpmMVF1TTFrVGpwaHRPVEdN?=
 =?utf-8?B?UU4vb1dyM2pKWUFseWtuanZOdndHTDRqZ1lXemYxYjVCbkloZzk2Q3pZRFQ4?=
 =?utf-8?Q?fEYW+evviyPwGy2DwMdS4ZepmE101p/o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1NRaVpzL3RnQmdidVlkcTdSK0JFSkRzRU9hM2ZQTm0vUTJWOEJIcnVTU2pV?=
 =?utf-8?B?bVVXN3M4d2VPaU5GT0dnNXNMUHJwYlkwNC82TFpRdjE2clFscjR4M2pFYmxT?=
 =?utf-8?B?K0ZPM2RCODAxdUlJVjkwRnBmdUVGUE1FR1JrN2QwWTZUTUxmbzgzeUF3SmtD?=
 =?utf-8?B?QlRFaVN2Yk94c09ZY3JlaG1vK3FKMFhleTVlN082OG9tdUh3eEl3ZUcyY2pD?=
 =?utf-8?B?QzBxblRrb0p6MjhndUU1bUxMOFNLUkdZSkpuMm5GS2RueStaUmFaSHJnTmpJ?=
 =?utf-8?B?TENoNDRVZ1ZURXh3MlE0WUZoTDZIc2o1V3BsbnpvL2lqNU1maHk1YjVqWFk4?=
 =?utf-8?B?RVN1dCtXTXNZUkpqV0tBNVdhUEJnVXlDRTVSN3VCc0cwRnl6SS9DSFBjQ0d3?=
 =?utf-8?B?cTlTd3RYOG1VZDh3TXRoVk5lcDlxeEVjOTFhekRtY25OTDlCTGRxZEptUU96?=
 =?utf-8?B?bFVJeWR3cStoQWYrN21KTFRVeUVXelAzNFE2dS96RnBVaVJXeVduc3hxRzJj?=
 =?utf-8?B?anB5d0luMCt4T1VuRDhCQjRpMG9aN3dsVklVVDBwQzE4WWFuWldjdWxpRmlR?=
 =?utf-8?B?ZnVPaUlSTURXaC9HYXQzYU5jQ3RCRzREYTVqU0JkcXVpcnEzbFRRcUZJMEdZ?=
 =?utf-8?B?ZTFYUUxpVUVTcHl2Zytkd1pmUm5QdUlGUWZWeHlCWjZyU1JoU2lieVNDN3Bt?=
 =?utf-8?B?OVlRdVVGU1hja2NBNExDZno4SGVZOHdRRGJqZGhUczA4QVdsSy91Y3dwcXZQ?=
 =?utf-8?B?NnlGb21hOWFxVUkydW1HT21OSVlqK3kyVUI5R2c0czl5L0VWeWhGL0M1RlpK?=
 =?utf-8?B?dDNBbHhMSHdqaGptZGR6ZEMzVW5BaUJUU0hmZnI2VTZNTHQwV1Y4ZFFhZC9j?=
 =?utf-8?B?M0N5ZHhGVDcveWJlais0aVdSbTdpUnVZM2xCYlUwaG1IR2pPQlJETXU5Q2pM?=
 =?utf-8?B?S1liYlI3cTB3cW8yMFNlSFg2M3hDZmJvTFlSYm40ZWpkYkR2VWczcm9IenlP?=
 =?utf-8?B?am90YlR6WTRNQm1NbVNYRmNwbXVvcmM3NUV2ci9Na3RrU0R2N0R1YzgvK1B2?=
 =?utf-8?B?S3FVRlk1U0RhUTF6ODVtaGxXSFpDL284bDZpaDBDOFREY0syYTI5YW41MmNu?=
 =?utf-8?B?YS9JQWIwK21KdnlrdnpKMlFhTnJOS2F4VWtnMEN1N3dXRmtCL01CR1pOVjJy?=
 =?utf-8?B?ZmVpRU40Wkh4Yi80T1NJeWJpTTNLMHU4ZjNhcGlTR2E5YUc3bzlNRHd4WC8r?=
 =?utf-8?B?NWpHVDlqYmVVdlk2UGFrL1MrVFEzMkt4Z1k3WDhJdTJxNFJOTjcrbWY1NUtq?=
 =?utf-8?B?azduK3p1bk5jMWpRY3doWFpCZVh6QlIxaUI4SjNyOWVGcGtBSURrTlJDL01W?=
 =?utf-8?B?UEg2OWVFdm1EZlVCem44Rzc5ZFQ0anJWUUk0Z1lnOWF1bTdJeHlTNVlWa2Zp?=
 =?utf-8?B?SHJqT1lNek1hak1Tc3drVzZERlY5WDFoRHVJOHVMeWVZTDlBSGVHMlJZcUMx?=
 =?utf-8?B?VjYwOVZMcXQ3UGtEaU5lZzJreU93bjBIaEtPNlkwMnQ2MVFDNnA0K2RzbEZS?=
 =?utf-8?B?VWxtRzRzVTVac1g4cHJNUkJKaDk4RElkWktVaHBDdEtvTVB1STQ4ZjZhNlhT?=
 =?utf-8?B?M3I3VGxFRlBwaVowb2JWTGQ0M1lDWEVVS2YyQjI3REFJY2pnMzUybm9xRzFR?=
 =?utf-8?B?a3dNTU1oNTR2UlNrMWlabWNHdzFJWnJpc1Y1R0c3MG1aSUtQTmhrdGwvM1Rw?=
 =?utf-8?B?ZEJHc01WME5iYnZGendXaUFaWGNJUisxeTM5clRRdWhOSTFTT3RhYjBCSUhx?=
 =?utf-8?B?ODFsUjdkRGF0SVhFQnB6VE9kT0dVUzZUM3Arc1VaaVhwZFFoc2lvbFVyUElB?=
 =?utf-8?B?anhJNVVIL0tJeUQyNkpCOVdYVHdIaDJzZjg4ZnIwbDFlQkxkak03KzZMRHlV?=
 =?utf-8?B?KzhDVFJ6Vk1MT0MyRkJxbVpyZU5tbGMrYk1zZ2dXTHExWkFnd3pTOVBoL1Nx?=
 =?utf-8?B?Y1pzNkUyWXhPVExjUXZMTU5mSzg2VTlvVXZmcnhTeDg3TXlFdzE4TjJQRk1B?=
 =?utf-8?B?Y0FYK0dYK3dpTjh6L1ZSQVQrM3VaZlNCVDR1WWZkUnZXWkFBK0pQMkNoN3M5?=
 =?utf-8?Q?7rOn0FOYqCViZaPIjHc2wP5dL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67182f6-4db2-41e0-d124-08de2a5ea356
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:05:09.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWW6Nt3HQRFgIR/73S/8I/VrMsZPMjrT9ZK3/lZG3T9x+sZikGcRNUO4I/UjIhal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079

On 20/11/2025 23:42, Danielle Costantino wrote:
> On Sun, Nov 9, 2025 at 11:37:52AM +0200, Gal Pressman wrote:
>> Add validation to reject rates exceeding 255 Gbps that would overflow
>> the 8 bits max bandwidth field.
> 
> Hi Gal, Tariq, Paolo,
> 
> While reviewing this commit (43b27d1bd88a) for backporting, I believe
> I've found a logic error in the validation condition.
> 
> The issue is on line 617:
> 
>     } else if (max_bw_value[i] <= upper_limit_gbps) {
>         max_bw_value[i] = div_u64(maxrate->tc_maxrate[i], MLX5E_1GB);
>         max_bw_unit[i]  = MLX5_GBPS_UNIT;
> 
> Suggested fix:
> --------------
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
> index d88a48210fdc..XXXXXXXX 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
> @@ -614,7 +614,7 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
>  						  MLX5E_100MB);
>  			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
>  			max_bw_unit[i]  = MLX5_100_MBPS_UNIT;
> -		} else if (max_bw_value[i] <= upper_limit_gbps) {
> +		} else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {
>  			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
>  						  MLX5E_1GB);
>  			max_bw_unit[i]  = MLX5_GBPS_UNIT;
> 
> Let me know if you'd like me to send a formal patch for this.

Hi Danielle,
Your fix is correct, please submit a patch.

Thanks for catching this!

