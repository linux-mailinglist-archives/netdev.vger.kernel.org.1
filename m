Return-Path: <netdev+bounces-240030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A514C6F8E7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8F653C190C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853AC352926;
	Wed, 19 Nov 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i/uiLr+r"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAD337115
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563655; cv=fail; b=U3etikmfwIidFAcuqxzbmkIH1qIDiayQPXGZE7WmPDcJG5jSc5eOkmYlKHyG2mQE0/LkVv78+gLLUfxpjRcFLzmSsVd4VQOjotxmHn/vsIZ/GY4YgEu9kj95E5jj5bbk9WvfbrSkjVZ8qDF6oRz9JWKrdadXxTH/+5NWZsaDe4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563655; c=relaxed/simple;
	bh=RmkRG18Djacz+3XwpzTNW81IYKi60DUdRgB7hLBkBbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RAASR8txLeAK1VfysmSykVFUgLZo0qgO+q8/fYLyttZ1drq8ZDk6/e/V/p9Fh3LmOPDP2X+Tz3rdxmTHciMxDcXb414ymtYOqLj2jG6qksuMOgG92fyEvjX/hWVPubLeN4yISBgz0otN0o0H1NQNjlpg+hvaG/K+SdMajKbWM/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i/uiLr+r; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZkJAKcetLV701rdQowiFgWv5Zy9sGpXo1R9CPpqYPw0DGWaK3vvO1gneGdXWvswPxbErDtzNgmxeOES46myNFBNU6nuLzOJJs4o/03LgXAr1Jq3ZoqRElNX0vw/K47H7CBdsfXPJSBv3q49R3B7FdSwXGzie3XqJ7eh0+5UjmWsuDRWx565Lg3fNMU6DuTO68VckiuAK8RiibIki2bGs5e0FUEJvMGcuosWFT3tzXaU57iX7udDP44QxfX9csirUmnmoko1FLB+zAv7WyYOkzvMPpwZckDIAHsW+5vBy69/Z6eSlShwOi26kDWPmcIlEqVOvXNIAKZyqY438fefQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3Ii3HKifi+bOicImgObopznRPVAPUFvynIb5/gjqk8=;
 b=ZwIOK8JyxyuGlmomjE9FYXwbNteG3jIIDevv+pnb3v7pYdKRQ0JG84BnG1iMvuxhL/jICbibWnQc8dek3wnsY+H9XXDNVCP+/9cReiC0aYXlHs6wSqUgh/wzQHOjYrLdVnizIXoD7Uht4qK0s+9tTMFqOnyDobwZiER8zPzrR2S/Lvp4Ei5F5D2CYHKA7X7EpP+wsiGrbpvQ+kdiHH4LmH47c77lbkwBvTlz4rPIHkhKqkgBVImrsKXdd6+V6pAE4RaOlnLJWp17TcS01hPmaPTjjkkvF+DDEuUYLkwmPNQPme1S8hKlK2pYPBg4S5phnbm7BxOLwRfeXCi8m9MUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3Ii3HKifi+bOicImgObopznRPVAPUFvynIb5/gjqk8=;
 b=i/uiLr+rfqjNM4JNUk6fQqbRrs9xN03Eb+L0M5YTb/NJdU/XHssuUqz+iDe/qlPOdg1134IcmVx4Q4WQN8VY8AqXH/No8X9bxpjYFl+1hFlmVIffTGOH8+/tHTgoKg3JS0tj0vBVlgp0fPQv6nnVLAia4eEEg9DiyNX9zZxptZZluHqNkk3t3kjXLhrkGeIzEiaTUNXWCwFlEI2ZS8mPRnLeaoNOpEy74e7A1dDiXu21jnrDle0xfHjn9RjlPfMH9/YgvbN2McUqG5YBH3yrotdfTi59sW71kkixf7/aaPGq2ePD2c7jzQRJ6qJKLxw8wJ3t0GxjvWiGui/9j678ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Wed, 19 Nov
 2025 14:47:31 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:47:30 +0000
Message-ID: <b5b414b8-23fb-4e46-9b98-9db2a07940c6@nvidia.com>
Date: Wed, 19 Nov 2025 08:47:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
 <20251119024647-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119024647-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:806:126::10) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 5526627f-313d-466a-9fdf-08de277a9110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHFCQ20yQzVSQUlJRVhXTTByZXYrTjRIcVplRFJaYTRHSjF1OVl0ZlpFM050?=
 =?utf-8?B?NS92OGFUS01Yd0x5L3RobytDVHA2b2dGSmhJZkRXUGRWVlBuVmoweDJaVzNZ?=
 =?utf-8?B?QmFhdmFpSFpBNFFKMXE0b2VvZVI2K2VISzQ4SUlWdkhmTjN2VDZwV2lNQlNa?=
 =?utf-8?B?VkxLcmVUZzdmRS9zOHJpM29ZMUFyb1U4ZTJWVEJRT01kUUlKSThGQmgvWEc5?=
 =?utf-8?B?MmUycFRER1UydytIcGNFdGxFVTIzVzNCVnBoelM0MDRhTzJtc0F1d1Ziekdm?=
 =?utf-8?B?L2VWY0lSRUllbndBc2pTR2JmRE00V1lFSVhLbTVkK3p6RzI1NDd5VGwrbjNH?=
 =?utf-8?B?QzdxSm1ZT3JDSnhnNUlpK0RnZjhHajI4VHFqcU9kR3hLWTJmRUF3QzhDMU0y?=
 =?utf-8?B?bFlndXNybWRmYjRYKzUwREJYR0s0VHF2aGppTXB5ak1KYjZjck4zSHVTU01w?=
 =?utf-8?B?VW93dkh4a3hEK1BGQ05DZmRJcHlWSWo4ejhmUllWMjl6OWRhN2RUbnR2REJj?=
 =?utf-8?B?TDBRR3BCcTNzeGZ6NGV2b3BYZ253UkY2MkUvb0tja2xCMWpKbVRqZU5zT281?=
 =?utf-8?B?eG5TRlppdlJvTWI1QjhtcE1tdWZBb0p4RjRZd3E3YncybG55dXQ3Zk5JaHRx?=
 =?utf-8?B?TXJkNVMyRHlTYmdHMzQyRFIrTnFXcDVIb3I3ZDdZZ0djSmlWMUZsRElmMzZy?=
 =?utf-8?B?RDBGNmJWN0pKaFpUUVRMUTNJUDBxTnh3NkdIby85MWttRFVGdjY5a0VLYnJI?=
 =?utf-8?B?N2MrdmY4NG5hT0p2SFdIMEZSbEhiMTdEak1lZGtkY0VjU2JrUDRjRzlxTm5Q?=
 =?utf-8?B?Yytjb2xQL3htcmEyNnlVRHpWZUg5RXJBbkQ5Uy93WUxNeFJ4YUNzSjZGRkd0?=
 =?utf-8?B?eHlVS0pGeDQwSThiWHRwZytydGFiTDdoT0RPSlU1b3lrb2p3WCtHazdOL1hL?=
 =?utf-8?B?Z21UQnpVYksxSmYrVUU2STlPSFRZZWtWa05xSnRNL21LbVJJT2lrQ2orbHA3?=
 =?utf-8?B?VVJYTjJBeHc2UnhLemhBVDJLZHR4QnhPVjNpcWFYeEVtQXMrY2RnelJzZzBL?=
 =?utf-8?B?cklEdEI1ZEhUcFhVcG1nRmFUVVFGaU03M3FtcU5UQkRBVjZUMmRGRWxCcHdw?=
 =?utf-8?B?Sjk0VXJNaXlCQldLYXhJOVV1K0RkTmg3N1A1ZWZWUXF3QmpiOFViQlhqK3Iz?=
 =?utf-8?B?aG1tRzlTZGhvNDJwYVlEVDh2WmFsTHVkSXBLNGdqcHhYdlF1VXNFTEJkMzhi?=
 =?utf-8?B?dzl5SDVSOVZKbHJDRFEzSmZoemh0b0VXOVRVOTY1VERnb3Jmc0tjL2RPbWRV?=
 =?utf-8?B?TjVlMWZMMCt4YUp0dUF3UFZPNk1FM1NkQ25qbnVGSHFsaWJZTTB1MFhqRU5E?=
 =?utf-8?B?MDdqSU9DRFl0aTdMK1RNdnplNGhOMmVDdG5kNS9XTWorRzF6MVhBYkNEL29J?=
 =?utf-8?B?cGlUd3ZLYm5KTFRva1lTM28rQnZqSE1zV3pHOTlTZnNGelo3SWdUYzZVTklI?=
 =?utf-8?B?Q0lJUitsb3ErMjBhZXBxWkcxOXozdGcxMlpsbWd4bGtqQTM0dEVOUDFpcEtL?=
 =?utf-8?B?TjYvbndVUzA0WTE5S3JHN0EvTGd6Z0ZraVhpQ1ZwcU5JYjU5ckg2RkFCSGN6?=
 =?utf-8?B?YXBGbGJGRE16R0xCSGM1Rmk5V0JITUVNWjRCeWlaNzZLNkhWL0VCZkJxQXBa?=
 =?utf-8?B?REpwQ0xUQkNVRWlkNjV2THFQUzJONm8zS1JTTklMV2dWdU9JNnZVekg5YlJF?=
 =?utf-8?B?TUJyM1B0VXNUdTV0NUpISjBPcE5LelZnbkdQN3JCRzlpaUZiY0lmaWw1RE5T?=
 =?utf-8?B?WFVnR05xMlpxTlBFU2x0b1Q2QmNpR3VEQy9EQTJXeURjN1hVbUxrU3VDeG5m?=
 =?utf-8?B?amlaQ29XWmdHTU1ockgrYzJoNXZybHdaYjRReWpJUzZoVUtXR1lTSVNMdCtr?=
 =?utf-8?Q?vBAOHqc8cSxRkM/yDBENA6OET2vhRpLb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cCthd0ZWLzdEM01GTUFyN0FUOTFsM0wyeUMwdFJkaFkvcndHeCttU3J5eDdW?=
 =?utf-8?B?U3VISnlEZDFiUCt4NWN5QUNNRFRmb1grWk1hdXlPKzFxcTVTaWJxZDRmMmhK?=
 =?utf-8?B?VC9IenR2TGd2SWhmV2JFc0tXTnA3RVp6R1A3Y0FVMnB0eVVURm5TRWp6UzM1?=
 =?utf-8?B?YVhxNkVCUEZoNnhqaW8yVEJtN2VkUHg3bGZkYlUxVEptSzhNUGxvc0ZNbHBr?=
 =?utf-8?B?bG9uSVlab0lRa2N2VkZuNTMvd3Fhdzh4Q3dubWlzK0J3ajNmdENxS3hTK3Jh?=
 =?utf-8?B?UFBmMHlLYml1ekRDZUJMS1JFc2RGa2pHWmZueFpncU5qbnd4cjNaV0I1eVox?=
 =?utf-8?B?YU1CQzVKeElCaC9seVR2SG11UTFBSlV6bFJjZlluRlF2elJJMGY0RXRadWpl?=
 =?utf-8?B?dlpWLzBJdTIyZkpLenhOQkY2b21qN3NZWHJxNkpwYnkzdjAxdnd1WnlUbmRx?=
 =?utf-8?B?TU1iU3phOTI1c2lWSGZSdTNWNGFveXVFMy9hblJLWEJwMHNDUmtCVDNURzYr?=
 =?utf-8?B?dDhCODFIUjhhOFpidDNnUHltRXZMaVQ1MVNYWGVPS09DblgrSXBBdXFEYURn?=
 =?utf-8?B?c3JhZVRCR1ZUeHpZcnFZWmtudko4ZDNBbHFsclVwQnlyVXFYdmJKK1hpM3pn?=
 =?utf-8?B?SUlTR0p1bEtzczdJcWVGZ1FzQjkvWmVDNGRTajZ3NnBPbVlYKzJZbE1Jc0Yr?=
 =?utf-8?B?VG9pSFJvWkVpRjBFT09iZnlBaXcxRnpibWlxT0xZeFhhaUpxZW05S3RKdzZH?=
 =?utf-8?B?K2xXb1FYRnFLVTRtK3h4Q3VzYm40Vm0ydHMrdExzbWxsZFZ5WGg4YkswYUQw?=
 =?utf-8?B?bjV1QjYxd2w4eXlTc0R1S1dBYmFjL05yQUFLbWlhdGJuMjZtUnk0VUFtSGo2?=
 =?utf-8?B?VXU1NFExN2FaVFJvRWhaK0dySmhmT1J1NDRqMWovdmRVL253eUVkL3A5L2F4?=
 =?utf-8?B?MFZ2THFhL1p4UXNMZCtESnhPMHRGSzFaTWVYdUlSVmZCR3BGbnlDSWJxNXBY?=
 =?utf-8?B?NUV0cHFlRlI4Slh3VXd1Q0tyUEIyRlhrZ1NqbFZZbllJWnh0RDgzUWE4MFFG?=
 =?utf-8?B?ZmxXcUNLb0ZFVkRNM3ZpYlRkaVdpbFlzcHpnOFJHdjFlUkNTeG5lSmRHR0lB?=
 =?utf-8?B?SklXMXp3clV3dmRwVEUxK0xyRlVBdlI3Mi9QVHdVMHBXYXRQMjc3bmFLSWxw?=
 =?utf-8?B?MFdlN09lbHBXNGw4Wk45bFJBUUw0V0F5QllDQ2hwZ2F1OHA5dnNwZ3Y4ZU1D?=
 =?utf-8?B?SVQ5VnJOcU5tbXJtMURpZVZvbHNEektlRjVKb3hoREJBZnNyTCtxSm41dWhk?=
 =?utf-8?B?U3J2eEJKb0cxalhzeGROVGNuMmlZYm1Wdnc4cnBNM2wzYXNwa2dmREpRVzU4?=
 =?utf-8?B?ZVZkNnNSRGdyMjc1UVZxQmQySlNyYWFRNUNHRjN6WHMxQzhtTmJicForUmcx?=
 =?utf-8?B?SWhxK3grYzlMTzc2RUxjc3pBUW1DTVZEREdqWE5Td29hOFNxaTNrMW9mU1Vm?=
 =?utf-8?B?NnFvZko0QlB0aC9vNkUxRG03Q3pIUkRSeXI5dFQyb2xDUzhrLytrdkVjcVdw?=
 =?utf-8?B?emIyWVAxV0M2bTg1b3N5VDQzV01DRVVMNHB2RDV4RGpZS0FOZks1Y3lnakhm?=
 =?utf-8?B?czJHMXd4YVpzM1plSFlRYlhZbGFJeEovWWpxMFFXREFucW9xMXJSZlpQT2w0?=
 =?utf-8?B?TTNvTWNRSmhEQXpZQlVQeU5SdEpUcnRsbE1mZk5CNy9TMHZSbVBXS1llbE96?=
 =?utf-8?B?ZWFpcWpPd0E2NzRqeHpRK0VDQlhTWTZoMkdrOVFKalIrSzZ0ai9SRFA3VUVL?=
 =?utf-8?B?ZjEzTUx2czFDaUlPV0Q3VHZwbVNFc1ArMVZYSyttR3U4NVlEMnFscm14N2g1?=
 =?utf-8?B?anVaSWN4bHMxbEEvcXNyckxnbkpudzhtTEFQUnQzUmRtWWI3ajZFbzFVSFRH?=
 =?utf-8?B?YTJHKzVUdjRva3crWDlBcjMxK0tjTDBlWDNKUXh3cVZRbi9wbjhmSUM2Y09E?=
 =?utf-8?B?ang3RjFVU3p1eTQrYjFUK2ZoenFtSU5Xb0pCRmRoVFJ0NGFJWitGRFNrc04y?=
 =?utf-8?B?R2IwWTR2R2t2WnNWMGZ2R095cjAvbFBwS01nZlFNd2NVZERIU0Y5S0hpdWNF?=
 =?utf-8?Q?rFYFujZzqtQ39FWw8APqFQ8Fh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5526627f-313d-466a-9fdf-08de277a9110
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:47:30.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k14JNiyQ6k2LVKcoCn7dWcJcpJMLR9ipU+tpenynbtw/Y3euBUSx81nxi7vl6BA22f96lZ2YIazIPJc6o3cLLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

On 11/19/25 1:53 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
>> +/**
>> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>> + * @groups_limit: maximum number of flow filter groups supported by the device
>> + * @classifiers_limit: maximum number of classifiers supported by the device
>> + * @rules_limit: maximum number of rules supported device-wide across all groups
>> + * @rules_per_group_limit: maximum number of rules allowed in a single group
>> + * @last_rule_priority: priority value associated with the lowest-priority rule
>> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
>> + *
>> + * The limits are reported by the device and describe resource capacities for
>> + * flow filters.
> 
> This sentence adds nothing of substance.
> Pls don't add fluff like this in comments.
> 
>> Multi-byte fields are little-endian.
> 

Done

> 
> You do not really need to say "Multi-byte fields are little-endian."
> do you? It says __le explicitly. Same applies to all structures.
> 
>> + */
>> +struct virtio_net_ff_cap_data {
>> +	__le32 groups_limit;
>> +	__le32 classifiers_limit;
>> +	__le32 rules_limit;
>> +	__le32 rules_per_group_limit;
>> +	__u8 last_rule_priority;
>> +	__u8 selectors_per_classifier_limit;
>> +};
> 
> so the compiler adds 2 bytes of padding here. The bug is
> in the spec.
> 
> I think this happens to work for people because controllers
> either also added 2 bytes of padding here at the end,
> or they report a shorter structure and
> the spec says commands can be truncated.
> So I think we can just add 2 bytes of padding at the end
> and it will be harmless.
> 
> It is a spec extension, but a minor one.

Done, referenced your spec patch in the change log.

> 
> 


