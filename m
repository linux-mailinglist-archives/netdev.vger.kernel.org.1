Return-Path: <netdev+bounces-115143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CCD9454C5
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2103A1C22D2A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774CF14E2C4;
	Thu,  1 Aug 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aciPBbE2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68214D703
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553662; cv=fail; b=TUjI+1X6WqXyXWJfyqTiadOGqtjVroiP5dUR5HYXTdBlEqmf4rYSeRoVCD50GMX0mhccju11Kudlx8PZxo8Gib7PgGKGvl4pDPbcrRs84hd1l8+DqRK+QI6h2qCgTFrz/1w9aTaM6Z8SMa7KHcRv1OYjslIwQ0bwzTUWmChZQHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553662; c=relaxed/simple;
	bh=DoXM4pZUS6mxH6xCMqAHO4D2jF9aVIX2iZ5ibsDvaeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=recSIpExHdovarB2YtLGqbS9eaHkvvPtGYx0Y/Ndk92RGTEpf3mW36tY5MHqKw01EJZtB6SsPeJKU/WlYp6Dry2bnQsqCO6f3WoRHeAyPb4q0u9+Sf8xGIar5Ez3SjbM23oYPgcjX1soYcL6vmQtXRqf7ToEenBfULxVEFSs9oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aciPBbE2; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrVICB1zkL+4K3g/ATjj7696jufe/U769W3ItZsuCiMtrUwCxJe2DL/NF7/fqF71jxUjSZmNfGqWlIABMYaRwUOXLmZm3/fmRd/dSK3FJyZfCjsZ3ajKR9Z+8nuwEWMiZPgwGI5CrxaR72KIgfdJSoEb8Z8fbE4wDi+RCQ+RfYf3XYtox/KpEQMjr/TFScAsv8TC9Qz2ktfwUgQ4ySZ7Pay1svIhtZ+naB55zyEp6Jk5b8GxZDEQp5/2/unx3cCQIKe74GjWjbGWamfbSHo/ICPOPWOAgbvSaal7tMY1lCsqD3Vm0Zz0AhTiM+eqrUmkQSZmUdSCEBb/Vbqto6Q1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV7v+AHm3/BzuTLzvBWg0VWNzGZhWbWFs9asdzoNstw=;
 b=WTL3b4l3xjjxhpP2YCwnle+1Rsq9nH1OBPJg72dM5gmrfCCYaZ8w7onx9k1sU2zVANA57/Rb6MvVwbDyGU7aT8NPjmYDCIDbq1pGAT2u+aK6dyOgnKTiGLgB6dBnX4dBEK8NltSbc0WeNtQNo9P52ScxevEqTEuYPuCkfagDjSok84qOs9ZRKNkaUafN83AFJqrBqpcV4FSpwfJA7o08A1rGB6fbdKi0kb06G5vbEdlXnwJdo+OSS0DDDIQmO3apVhJLGb22GoXIEIVni/7+c1Nx76888AMzFiRoQO2jSg5CzdU2bX5EuYaHS2XPcacnBFRp/+4PLQjFFS6y+B5L/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV7v+AHm3/BzuTLzvBWg0VWNzGZhWbWFs9asdzoNstw=;
 b=aciPBbE2XQ2EcTTcoz1Gj3tY3GPcvaDIJ4MMk0KWzMkrslhBPaj61fhTBifFQVrT3YQhB3wNu0GxYq4vnwoh0xcFEzOnZZbF+i62FZ9/v+IriVHg7XiJTvFJ4HZjeUlMF41kZ6pMzgNx5j6LevxGnueqCq3C9UIygS+j1P2LSt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 23:07:37 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7807.009; Thu, 1 Aug 2024
 23:07:37 +0000
Message-ID: <e7878a08-440c-4ca7-a982-1b9a71ea9072@amd.com>
Date: Thu, 1 Aug 2024 16:07:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ibmveth: Recycle buffers during replenish
 phase
Content-Language: en-US
To: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com
References: <20240801211215.128101-1-nnac123@linux.ibm.com>
 <20240801211215.128101-3-nnac123@linux.ibm.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240801211215.128101-3-nnac123@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::40) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: d369fc6c-5d3c-47ef-4c39-08dcb27ebc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VS9pNEZwaWJBaHdwc1dqWFBQSU94bkpOS0VMYjNYOWFMTEFmaHFSY2pLWFoy?=
 =?utf-8?B?Ri9JWHZMQTVEQm42bHIybkQ0SEt2TkRLMld3TG03Mm54VGplWkMrVTE4Mitq?=
 =?utf-8?B?bXRpU0JYSWRUMG8wUS9ldEYrYkU2MFRuRzRzbE5aRUpvVE9qRzVkZ2VqaDM1?=
 =?utf-8?B?c3BjN1FjNkNjUWRzaTBNb3hVM1NBbTRsN3VXVjhvWTJMK1pVQ1pPTlJ2SDBu?=
 =?utf-8?B?K0x0TnFjZkVSbTVBa2lRV1JCbzd6bXJJQ2lDdk9xZ2w3TUE4ZitxRDRNSFRS?=
 =?utf-8?B?ZFA2Slc1Q2tZa21sVGxKNnF5K1IxcUhJUzVOVlVxY0QyV2Q3bko5RzFpSTl6?=
 =?utf-8?B?TGNSbVA2Zm80bW4zMDFsT25KTGIyZlJwYW1rSVBNU0kvQ2ZkRnJ3bjlTMmVE?=
 =?utf-8?B?WXMyVmx1UEhmT0RLM3VGWVd1cDdFd3F2a1cwckNrVFpKbzM2L2x6VnFWWUlp?=
 =?utf-8?B?UlVqTDI3ZzcreldJbFF2QmM0SllxclBXT3hOdm12eWxRNkNxTU4wY0ZSN25R?=
 =?utf-8?B?dk5RbnlkdW1UUWM4QkZBaW9ua1Rkc093dDVkMjh5dHhQYi9veHhqbmUvdTNE?=
 =?utf-8?B?d1h0NmtuYkdXZU53SnBqa0VVOUN1VXpGYmVrdEw4amFMaktYTUkySllldUNJ?=
 =?utf-8?B?ZGJCRnpnOEY0Q0dPelNHb0UxZFlMRGdKdXZ2MHNxNURoUHdib1VubkozNzBK?=
 =?utf-8?B?dWNEKytLdzkzSlNnU0dpMkwyMkRvc1lPQTA1ZG05V1dDOEMvb2lRR1pJRnZB?=
 =?utf-8?B?VG4rQ3E4TDVxbEczVTAwdzVwU2U2WGVXNjN0ZDhwTGxQZmM3d3IyRlNWbTNK?=
 =?utf-8?B?Q1I2c09rWXBlbFFtTmtCbG8wUkEvWVlEblJPSUp4elJZYzVSS3dSbzZJNDE3?=
 =?utf-8?B?bjdnbmZ6OW5yL2JMVDJRRzU2N0hwOW5TY2lWQmYyTmJuRGQ1TEdpU3FaRHB1?=
 =?utf-8?B?L1ZUWWljRE5mVC9ZM1QrVXRDbnhtSnlqQ1JrWUhpcjBmZHhvdFlTTXRNcitJ?=
 =?utf-8?B?NzJ0d1pyTzJ0dk5BaXc4VG1zbjNLUlVTYmVsK2dhdm9XeS9KYmxJUGlYY25R?=
 =?utf-8?B?V1g5SVJuUTQ0c3RyM2hZNVBoM0V6cXFsYnQ1MUVMdlNNNGYzeUFTMzdtYkhm?=
 =?utf-8?B?aVkzY2thOXhYN0t0K2s1ZHN1U003bGJnY3VGcmovUHRwUVF0T1dBVEFhVXlG?=
 =?utf-8?B?bE82SnZhY0phQkwzTm0veDV6b3k5dG4xS0Y5SjNncmxpVlNQNU4zdThSQnc2?=
 =?utf-8?B?NTNtTXIzbkpHS24yNGlwekNyK2xiUUxjUzFMSFhKMHZhbnliQjgxYldUT3Bw?=
 =?utf-8?B?clpyWVhWekQ5V2ZwKzlKdS83SHdtbEgrc0RjOE1XK2EvUlh1blhISG1oelVE?=
 =?utf-8?B?QjEwZkRuNEFlMkNxc1NqWWpUNXlGNGk5VVQ0akVrbko2KytNVVd2aHRzcmts?=
 =?utf-8?B?U1M1UnA3MFlQUGcrRzl1TEZpUk0wZjdHQmswRnBqOU5RZ1l5Y1RtenYrVFdr?=
 =?utf-8?B?UTUrOVJ1UlZ0MG5IZmp5LzZWOVVndmViTGtPMmNXcVBBdStZS1lFbklmTGxr?=
 =?utf-8?B?SCtua2gyckljRFg1N1NCenFEVU81QTUzWnVJZk9VeXJzaytXK1NGL2RhS2FP?=
 =?utf-8?B?Qk1KUlNwL29NVi9SVWRENlNJVjB2Qy8ra3VweGxpTVo1T0dUcWozS2Fnbncr?=
 =?utf-8?B?am1aQnNSMXVvKytrRG9KQ24xclFoTVorTjJwbHhobElQZnRmQkxVYkJaYTJu?=
 =?utf-8?B?NUs4cmRSRk9iejc0cHhBVHRRT3F4Zng2ZzBkMGltc3ZzaDdwNUpERTYxcXVz?=
 =?utf-8?B?Zi9sMVRSbllYUFplVzh5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFNZelU5dnRvdFZNRHpZdTlJT1g2V2NOT3VlSFlSc0ZNdW5FVFg3Qkp0WGZ2?=
 =?utf-8?B?N0NxVVFuMTVIUzFNSkNoa08ybXpHYmh4N2FYZWg5OTJMek1Sb3lzNTZoR0Qv?=
 =?utf-8?B?OUpMSGtyNWdjRXQ5ZnVtWHY4RkwxQ2FpZURpV2M3dCs2RnJ4Q0xUbnZLTlhJ?=
 =?utf-8?B?aHF5eDJPV1JaRDFmVDVJUk1RL0N4emJKOFhoV3g4Z1EzNVA4YjdxVndmRkpR?=
 =?utf-8?B?THpseEJMLzJrVHE5QjBDMDBhcllsKzJoWlpqQXkvcXdKZHdvdlRVVG9DTmF6?=
 =?utf-8?B?QmRNcW0wQlFLRGVRdnY2WFVXYnMwNkNpdHV6ekZPMGFSaURmOXRHbnNoS2NU?=
 =?utf-8?B?VkF1eU5GV2NIL2dvb2k4UzUwYnZOUVp5UmtoeUNnLzlDa0lScnRVd3hBcGpy?=
 =?utf-8?B?NXFQLzN3bHJLc1pJQU16TjRvdFE2anBCWW9GUXlhbVRQdklnQjdOSHJBbFpn?=
 =?utf-8?B?dzhkUUgyc3dTcVQ3L21VUXdSbXAvZ1VMV3lwYTRYUzVaN1dZS2x3TXZ5VEs2?=
 =?utf-8?B?bXFOWjZmVEtqd3dsVVphSCtuUnR1RFNsZVJNNkp2QmpMSUdLVXk3QzYzN3Vv?=
 =?utf-8?B?YXBySlFXaHZESVREaitqZVNUajZUUTgvUUJ0R1JnOVE5cWYvMlVGZTVPbTBP?=
 =?utf-8?B?UjF3M0MydGxGRkxoS2hPR2UrVVpyL242c0I3SXZ5VEF2c1ZJdDRVL2tJaWI4?=
 =?utf-8?B?dDFuam90LzgzMFBuUDlockVmbG01NUdUTDROOFZidDYxTkZoRGdaNEEzZGZy?=
 =?utf-8?B?MVVRd2pVclFBWEtOZnA2Y0FxdkUybEtMZUE1eDE3OGdBWTZVRFIyODFEZWxj?=
 =?utf-8?B?NEJFZXFYYks5dTNIdW9mZ1N4a2xWbEVnalNlUUlveWpocVZiUkM1ZmJTc2ZR?=
 =?utf-8?B?YTBZc1B5OWN4STYvVG9QbmFtbDZGK1BwWmwwTm9KSFdLeWNBWTVucy84NGo0?=
 =?utf-8?B?TEFDYVg5R25VNUlqVDltK2NoWlZZOTdOSG9CZXNVbFF5Z1BCTk9nUnBBWlZ3?=
 =?utf-8?B?NmxQeXYxNDkvMFRrQ1hQNk9pRWFVU1NoVG1HaGpXTU0zb3VKRXV0RDZaM1dP?=
 =?utf-8?B?L01pVS9FZC8ybi8rQ2FKc1R5c09mSkpHNmVqaVFkYUpxUC9mWk56d1JJQWZJ?=
 =?utf-8?B?QnpjM3JabVIycEk1KzEzaEpoOHdnZmV0RW5JZkludXRjN3JxSUpCN2hoL0NE?=
 =?utf-8?B?OWI3QmtGN0U4S3IwS24vNThQYzRrTTJPSkNWVzkvRnEwRmxTMWpFUzU3NFNF?=
 =?utf-8?B?VWEzZGlLZzE3eEhCcm9LMmxWSExhT2Vka09NV24yYTVKRHhYQWxGTVNlek5l?=
 =?utf-8?B?aWIvUkc5UDdGRmFCV0p2MlVGM2dLcCtxdVNEMDhjR25YY254M252cVA3dWU1?=
 =?utf-8?B?dTBKMjdCMmlWQzM0YVpON1pJSmxuR0NIUS9uS3I2YktvZDVQUC9ydkl3a2pr?=
 =?utf-8?B?Yms3Zk55S0hRbXRjcmxITHJvQzdCZnNRbU9sRWpRVVpTTHNNbWdPRkFtL3Zr?=
 =?utf-8?B?L0ZLQ0lyRVhNaFVFS0M2OERSSWxIZWlQdUt2Nzk2L3o3UUxyZkpTSmNOMDB2?=
 =?utf-8?B?bnpRY3VLZ0M3SFE0NGxyM29tR0JucTEybC9jL2FZOVk2dWdBaGNSYStzb0hl?=
 =?utf-8?B?THlyM09sQnBUbXA3VUxqekNJSkxZenoyakFubGxmSURhaWN0SmoxOEg2RHBh?=
 =?utf-8?B?UGdDYXJMSzUvSk5hVzR5TWdsVjdWNGlydlRoOTVDY3NXNlR4TTZjMEJaVW1n?=
 =?utf-8?B?RnZ5MytsTGR3UTRqUFJVenJFRGg5SGhlbk41SkV5eXZsNTdKM2FYT0tNRVZo?=
 =?utf-8?B?NlhiTXl4VHJEMUllcTRaMkZENGowWUFIWG1mSUJLZm9jWXJoSGtVZCtwNjNM?=
 =?utf-8?B?NUI1ZGkyWDB5MlpyWkZrVzlTbWIxWkNhVkUvOHNjblpKMnh4UHhxTG1Cd2Iy?=
 =?utf-8?B?L2JZYkVJS0plV0NiNjE0dDlyekVaNVRVank2NmVZU3Z4aDR5UzJDLy9kelRB?=
 =?utf-8?B?QWFPQkQ2NWRMVThnMGM5OXA5aHNOaGlYVVFGakYrdWtwVjlKTGpWK2tyM3hK?=
 =?utf-8?B?QTgyUGU5V3dLcDFacEZUTis2VXMwZjNhSGdCUTNXUFVpaGxuZVFGYVpGcWg5?=
 =?utf-8?Q?Rq4+DGcLu54kLQR7iUKRIIUn8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d369fc6c-5d3c-47ef-4c39-08dcb27ebc49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 23:07:37.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7qbg44gNJJBQuZhKVPg7VbNmJrBY5kkknPIHtT0PdvWW+gCWQ5fC2Y1MK43YgABJw850hKr4Fjd3vI3z4x1bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971

On 8/1/2024 2:12 PM, Nick Child wrote:
> 
> When the length of a packet is under the rx_copybreak threshold, the
> buffer is copied into a new skb and sent up the stack. This allows the
> dma mapped memory to be recycled back to FW.
> 
> Previously, the reuse of the DMA space was handled immediately.
> This means that further packet processing has to wait until
> h_add_logical_lan finishes for this packet.
> 
> Therefore, when reusing a packet, offload the hcall to the replenish
> function. As a result, much of the shared logic between the recycle and
> replenish functions can be removed.
> 
> This change increases TCP_RR packet rate by another 15% (370k to 430k
> txns). We can see the ftrace data supports this:
> PREV: ibmveth_poll = 8078553.0 us / 190999.0 hits = AVG 42.3 us
> NEW:  ibmveth_poll = 7632787.0 us / 224060.0 hits = AVG 34.07 us
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>   drivers/net/ethernet/ibm/ibmveth.c | 144 ++++++++++++-----------------
>   1 file changed, 60 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index e6eb594f0751..b619a3ec245b 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -39,7 +39,8 @@
>   #include "ibmveth.h"
> 
>   static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance);
> -static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter);
> +static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
> +                                      bool reuse);
>   static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev);
> 
>   static struct kobj_type ktype_veth_pool;
> @@ -226,6 +227,16 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>          for (i = 0; i < count; ++i) {
>                  union ibmveth_buf_desc desc;
> 
> +               free_index = pool->consumer_index;
> +               index = pool->free_map[free_index];
> +               skb = NULL;
> +
> +               BUG_ON(index == IBM_VETH_INVALID_MAP);

Maybe can replace with a WARN_ON with a break out of the loop?

Otherwise this looks reasonable.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> +
> +               /* are we allocating a new buffer or recycling an old one */
> +               if (pool->skbuff[index])
> +                       goto reuse;
> +
>                  skb = netdev_alloc_skb(adapter->netdev, pool->buff_size);
> 
>                  if (!skb) {
> @@ -235,46 +246,46 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>                          break;
>                  }
> 
> -               free_index = pool->consumer_index;
> -               pool->consumer_index++;
> -               if (pool->consumer_index >= pool->size)
> -                       pool->consumer_index = 0;
> -               index = pool->free_map[free_index];
> -
> -               BUG_ON(index == IBM_VETH_INVALID_MAP);
> -               BUG_ON(pool->skbuff[index] != NULL);
> -
>                  dma_addr = dma_map_single(&adapter->vdev->dev, skb->data,
>                                  pool->buff_size, DMA_FROM_DEVICE);
> 
>                  if (dma_mapping_error(&adapter->vdev->dev, dma_addr))
>                          goto failure;
> 
> -               pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
>                  pool->dma_addr[index] = dma_addr;
>                  pool->skbuff[index] = skb;
> 
> -               correlator = ((u64)pool->index << 32) | index;
> -               *(u64 *)skb->data = correlator;
> -
> -               desc.fields.flags_len = IBMVETH_BUF_VALID | pool->buff_size;
> -               desc.fields.address = dma_addr;
> -
>                  if (rx_flush) {
>                          unsigned int len = min(pool->buff_size,
> -                                               adapter->netdev->mtu +
> -                                               IBMVETH_BUFF_OH);
> +                                              adapter->netdev->mtu +
> +                                              IBMVETH_BUFF_OH);
>                          ibmveth_flush_buffer(skb->data, len);
>                  }
> +reuse:
> +               dma_addr = pool->dma_addr[index];
> +               desc.fields.flags_len = IBMVETH_BUF_VALID | pool->buff_size;
> +               desc.fields.address = dma_addr;
> +
> +               correlator = ((u64)pool->index << 32) | index;
> +               *(u64 *)pool->skbuff[index]->data = correlator;
> +
>                  lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address,
>                                                     desc.desc);
> 
>                  if (lpar_rc != H_SUCCESS) {
> +                       netdev_warn(adapter->netdev,
> +                                   "%sadd_logical_lan failed %lu\n",
> +                                   skb ? "" : "When recycling: ", lpar_rc);
>                          goto failure;
> -               } else {
> -                       buffers_added++;
> -                       adapter->replenish_add_buff_success++;
>                  }
> +
> +               pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
> +               pool->consumer_index++;
> +               if (pool->consumer_index >= pool->size)
> +                       pool->consumer_index = 0;
> +
> +               buffers_added++;
> +               adapter->replenish_add_buff_success++;
>          }
> 
>          mb();
> @@ -282,17 +293,13 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>          return;
> 
>   failure:
> -       pool->free_map[free_index] = index;
> -       pool->skbuff[index] = NULL;
> -       if (pool->consumer_index == 0)
> -               pool->consumer_index = pool->size - 1;
> -       else
> -               pool->consumer_index--;
> -       if (!dma_mapping_error(&adapter->vdev->dev, dma_addr))
> +
> +       if (dma_addr && !dma_mapping_error(&adapter->vdev->dev, dma_addr))
>                  dma_unmap_single(&adapter->vdev->dev,
>                                   pool->dma_addr[index], pool->buff_size,
>                                   DMA_FROM_DEVICE);
> -       dev_kfree_skb_any(skb);
> +       dev_kfree_skb_any(pool->skbuff[index]);
> +       pool->skbuff[index] = NULL;
>          adapter->replenish_add_buff_failure++;
> 
>          mb();
> @@ -365,7 +372,7 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
> 
>   /* remove a buffer from a pool */
>   static void ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
> -                                           u64 correlator)
> +                                           u64 correlator, bool reuse)
>   {
>          unsigned int pool  = correlator >> 32;
>          unsigned int index = correlator & 0xffffffffUL;
> @@ -376,15 +383,23 @@ static void ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>          BUG_ON(index >= adapter->rx_buff_pool[pool].size);
> 
>          skb = adapter->rx_buff_pool[pool].skbuff[index];
> -
>          BUG_ON(skb == NULL);
> 
> -       adapter->rx_buff_pool[pool].skbuff[index] = NULL;
> +       /* if we are going to reuse the buffer then keep the pointers around
> +        * but mark index as available. replenish will see the skb pointer and
> +        * assume it is to be recycled.
> +        */
> +       if (!reuse) {
> +               /* remove the skb pointer to mark free. actual freeing is done
> +                * by upper level networking after gro_recieve
> +                */
> +               adapter->rx_buff_pool[pool].skbuff[index] = NULL;
> 
> -       dma_unmap_single(&adapter->vdev->dev,
> -                        adapter->rx_buff_pool[pool].dma_addr[index],
> -                        adapter->rx_buff_pool[pool].buff_size,
> -                        DMA_FROM_DEVICE);
> +               dma_unmap_single(&adapter->vdev->dev,
> +                                adapter->rx_buff_pool[pool].dma_addr[index],
> +                                adapter->rx_buff_pool[pool].buff_size,
> +                                DMA_FROM_DEVICE);
> +       }
> 
>          free_index = adapter->rx_buff_pool[pool].producer_index;
>          adapter->rx_buff_pool[pool].producer_index++;
> @@ -411,51 +426,13 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
>          return adapter->rx_buff_pool[pool].skbuff[index];
>   }
> 
> -/* recycle the current buffer on the rx queue */
> -static int ibmveth_rxq_recycle_buffer(struct ibmveth_adapter *adapter)
> +static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
> +                                      bool reuse)
>   {
> -       u32 q_index = adapter->rx_queue.index;
> -       u64 correlator = adapter->rx_queue.queue_addr[q_index].correlator;
> -       unsigned int pool = correlator >> 32;
> -       unsigned int index = correlator & 0xffffffffUL;
> -       union ibmveth_buf_desc desc;
> -       unsigned long lpar_rc;
> -       int ret = 1;
> -
> -       BUG_ON(pool >= IBMVETH_NUM_BUFF_POOLS);
> -       BUG_ON(index >= adapter->rx_buff_pool[pool].size);
> +       u64 cor;
> 
> -       if (!adapter->rx_buff_pool[pool].active) {
> -               ibmveth_rxq_harvest_buffer(adapter);
> -               ibmveth_free_buffer_pool(adapter, &adapter->rx_buff_pool[pool]);
> -               goto out;
> -       }
> -
> -       desc.fields.flags_len = IBMVETH_BUF_VALID |
> -               adapter->rx_buff_pool[pool].buff_size;
> -       desc.fields.address = adapter->rx_buff_pool[pool].dma_addr[index];
> -
> -       lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address, desc.desc);
> -
> -       if (lpar_rc != H_SUCCESS) {
> -               netdev_dbg(adapter->netdev, "h_add_logical_lan_buffer failed "
> -                          "during recycle rc=%ld", lpar_rc);
> -               ibmveth_remove_buffer_from_pool(adapter, adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator);
> -               ret = 0;
> -       }
> -
> -       if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
> -               adapter->rx_queue.index = 0;
> -               adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
> -       }
> -
> -out:
> -       return ret;
> -}
> -
> -static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter)
> -{
> -       ibmveth_remove_buffer_from_pool(adapter, adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator);
> +       cor = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
> +       ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
> 
>          if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
>                  adapter->rx_queue.index = 0;
> @@ -1347,7 +1324,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>                          wmb(); /* suggested by larson1 */
>                          adapter->rx_invalid_buffer++;
>                          netdev_dbg(netdev, "recycling invalid buffer\n");
> -                       ibmveth_rxq_recycle_buffer(adapter);
> +                       ibmveth_rxq_harvest_buffer(adapter, true);
>                  } else {
>                          struct sk_buff *skb, *new_skb;
>                          int length = ibmveth_rxq_frame_length(adapter);
> @@ -1380,11 +1357,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>                                  if (rx_flush)
>                                          ibmveth_flush_buffer(skb->data,
>                                                  length + offset);
> -                               if (!ibmveth_rxq_recycle_buffer(adapter))
> -                                       kfree_skb(skb);
> +                               ibmveth_rxq_harvest_buffer(adapter, true);
>                                  skb = new_skb;
>                          } else {
> -                               ibmveth_rxq_harvest_buffer(adapter);
> +                               ibmveth_rxq_harvest_buffer(adapter, false);
>                                  skb_reserve(skb, offset);
>                          }
> 
> --
> 2.43.0
> 
> 

