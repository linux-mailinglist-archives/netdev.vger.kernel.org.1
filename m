Return-Path: <netdev+bounces-239851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA33C6D141
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F7094E869A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C0D313E04;
	Wed, 19 Nov 2025 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vr0q6MiF"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290052773EC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536917; cv=fail; b=tDWBphDlKLgx7dvgYqdbMCfTRCVutRBfRg3kN8eIhuoqaYLO96enjrRgVtsCFy+1EvjYvVkYdFbyibHEcTZx2acGMK1RJb4yVqUuLGovRuwj5NdU69NdNZoJRrJGeozCaXKAvBidY5hL4eknpqsjncmfrr5IJoqmXOCv/Nj2Tkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536917; c=relaxed/simple;
	bh=RgIFc1hBW1OeAZ1yMzUz2krZNGFnfj1jIQcy5gwhXBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U0pjybNYQLj7/Y7FRaRUhtWEsPjF9gbBrgy0LYCcnO3IPW9xEYvoaQcaoXVG4Bh2HVDzZF1/NE3FGJyW/CPoK/maGTuxx32vAOwVPC6rJk8/l2mFueED7aTipX8dYWGvdYtBAaZz9Zz1kJwYVu+EIG6hY+s3Vr1jODW1IKt2PbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vr0q6MiF; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgQsV91Z2hIl0J18Vwii9FEPOQWFqTh069XkGQUQSBs8sjID5I27dBwPIvOJzg+cPlZYTzqtVJJbeFgKsFNE4SbndeFVZQ5ER6gpBVJhEM9zsLVhhkXRsGdldiKDIp1l08nHilMYGLgBK3hFr83ssPn7+ajI9ez3V/jC8O5e0mTh+qbkB9kNBZL8TX+wmJowVKC/uhaGDjIlrDxU3TMzrTJS1rqH2Sj6clRAQO6nymuiz3E4jLDo6SMsYIPwtKF504AM5BzTBtbw1u1c8rqt58i5Hrzlu9jQqvsRqEipW4Pd2WBPJCAECUEOJwtzIZIzC0l1BsDdiQzVwU+CNp1LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRU8CpkkycY5FKQ2k2pY6QB3cdVHyql09bCnRvpxEiU=;
 b=IS0ZYYLnYLV12MsDGWlFUQV6pN5WsaHzHoOuaO5k34QSjDwOWPiPn1xSHtMmY9VJOeEXpiSRqSJjTXShznO/o+TjQ4q8EXUiCtO5SMb8F2nTDfSadBZQtsGq2rGA3ekGcTV74a8Jml3CGo4+p8t0+M18fgUKe4v/nLHMp1P1iF1dBNWDJ/UAAA8sILnW1dAsNAVmmOO8MvicJgc1a8AiHp0a5u2RmCKbgVmFCNIhzvXyETwvSNSg0RtBl/08GAK678fkJwMQXtFV2AOT+xpb9l/QUqU3XJMFJqqWISg++8QoxSEwZSrxIu13ZRyxAtff+ZdPjSehxIk5T9eH3NsJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRU8CpkkycY5FKQ2k2pY6QB3cdVHyql09bCnRvpxEiU=;
 b=Vr0q6MiFJ40ddeMKoVKCXfnqyISGdt61kYP4/5IFo7x/maXrXd7fmAdgHspQy5mLlcoG/vnZylxkFgT/pJ9rYH6YZOHWs/Jgs8sij64fj5hBTe57TleX5a1fkmuDXdnbr8az9HGRCKwfxkn1pFobxYetgHADMxAIkRWqg08drC5hRcJ/pudsj7XpI3zwocIRDbIYKsDWju71RANw6JFQEHtp1AwknZgIQLkpJAOz9vevCFDjoUW5BnKl+LZyyoJO164eYRisbWuGrVb/Kie3u6DI5prGOL4EfMOnfn+iEcOMt9RGUNC0tOEfaOzYV2trACaik/Fa0OtVwccfK1IaNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:21:49 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:21:49 +0000
Message-ID: <654889ca-05f4-4147-a0bb-6a54c254c243@nvidia.com>
Date: Wed, 19 Nov 2025 01:21:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/12] virtio: Expose object create and
 destroy API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-5-danielj@nvidia.com>
 <20251118171338-mutt-send-email-mst@kernel.org>
 <e5641fe1-e1a7-4f3f-b4d0-1dde55e47c83@nvidia.com>
 <20251119013550-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119013550-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:806:d2::17) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2cd847-e5b9-4ea6-dbbb-08de273c4de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWZ3cHZmQ1djQksrRWw2bmpIeXFvU1ZIUVZybU8zS0k5THJKS3VPOHBLZDli?=
 =?utf-8?B?T2pCa1pwNmZjWTBoTzJrdmJIQzZSSFdZK1Zib0grOWkrVnh5UnEzdW1NYkdS?=
 =?utf-8?B?NXhta05HL1R1aUthSlJtNE1hRStvaloxVzFxWXFOMnpwN2FNcnk0R3pQMzR1?=
 =?utf-8?B?M1UxWHQ4SmpTY0lzMW5USTdUbVpidXY5TGtFU0E5Qm1GTXJtZGNqSEdGTnBC?=
 =?utf-8?B?Ym1RN2htZXJ2STdmdzFkQ1RRenVQRThsQlBMTnAvWXRIeE9IL0lTd3o3bWR2?=
 =?utf-8?B?ek9rQkIvWm53cFVzeEJ1KzBrNTlINHdJcUx6Q1loYklEeTR3aDZiYVVBaFVj?=
 =?utf-8?B?UkJzK293Q05yWE5VcEwwM2Y1c2RndnBMdElDU2xocXA0YUhETVVtbEFZbm4z?=
 =?utf-8?B?NFk4emxPZVkrZjhzdUpLaU82VnAvQkc3cG9TQ2NSYjhvM3cwYnIvMU1kc3Rn?=
 =?utf-8?B?YVNXcDBKWklnREhJcnhvS3F3NDBrbEhieXZISjljZDZPRVUySzFKcW5Vb0U0?=
 =?utf-8?B?WDlsdDlBc2tGTG5hZlkvMU82dTBwNGJ5NDFIN0ZTRjBjUU5yR2dOemhWUmVj?=
 =?utf-8?B?TGloOWt3eDV3S0FzQURJUXZmSXpsSnJmbDhkeEdyOXBqVUxtZENYYjlZNUUw?=
 =?utf-8?B?RDM0eHZ0WVZRN1FhMDlFaVBtZFJzZHNzV2IxWldDRWhQN2diMjgxcXBlazl3?=
 =?utf-8?B?RXJIWjFqb3NmNTVYeFB0WC9TcThHTG84bGc5ODJZY21iTWRpelhDb3krWGJ0?=
 =?utf-8?B?Ym1iSkI0MDM2M1NjN21ZNXRyVklXTDVKODlEUExoRi8xRTM3Vjgyc2MwaVlY?=
 =?utf-8?B?bXBRRUl2Qm1jak5OVm5tRFhLVGhwaVFTWUxHYW5mcWFiY1daaTh5aHpiWG15?=
 =?utf-8?B?aEVnME1OaDFwdVQ4WFNSdkdWNkFUbDJOZVNwTEJZdFppS2ZFclFTaTMrMHR5?=
 =?utf-8?B?RUM4WWJxZGx2MWhEeW8rZE00Y2lhWWN3dmZCNEtRYnFhb1Q5djUyTzVlNVNv?=
 =?utf-8?B?a0Nnak5adSs1VnduT1FYa3l0Z1NxZHoxVHU4V0RZd3lBZzNTVkZBQThIbVAr?=
 =?utf-8?B?aEN5U2VENSt1d2U3WVlqbkRhM3R1aWdUNyttOG9xWUJwTHdJMkhCZm9WeUE3?=
 =?utf-8?B?NERBRDgxZEEyelJyMVVPYk5lY24rWmVUU241UStjcG4wMzhTSHB6M05mTXZ1?=
 =?utf-8?B?STRobzlGSkxZZ0diVW10OEVrZlk3WnBsUEIzS3B1Mm50N3M3WEtBUi9mQ3Yw?=
 =?utf-8?B?V1RHcnlIcmQyL2x4ZzF3Y3psMFNPQzUybU5NMmRJVXdENmZqcS93Wmt2NnVl?=
 =?utf-8?B?b2FlS1l2aWZsNWVTaC9PNW1iVjlQaDRwT1YzN3hPd3o4cUtGanlHUnJJMmRj?=
 =?utf-8?B?SkMvbmFuUmhrOXEzRzRwTW01bXNFRVZRaFZuZG52QW5HRTZLV0JIZm9uTys3?=
 =?utf-8?B?Tk5yMEx0SkkralZCWWRxbVM5S3BCTHh4d0pYR0pNa0loVENUYndJRXNyd0RL?=
 =?utf-8?B?RHJEUWdzTjNuQXQrNStJOW5zWjJ5WHhSZ1J4QXYzY044UGJTVll4K0YrK2tr?=
 =?utf-8?B?Y0xyVjYrdWlsbWhTQ2F1UXdQQjAySUsyc0E3NDl0MkxlTXhnUkFwZkFhN2VT?=
 =?utf-8?B?WTNRdGRobXdUZy9YNU90dUxpNnBwdTcyYzRCN2luM0FiV21MTVVYTWcwVndF?=
 =?utf-8?B?b25jYmFYMkRUZEdLVVpCcllUY09OYW0xTld4cS80VktQQUFjMXJwYUdlTUNr?=
 =?utf-8?B?bytVUkM1aG5VNnp0Y3NOamtIYXNLTytvNGpFYm1vYU5MdlRxMXBJeXBWM0tY?=
 =?utf-8?B?cW9TOThQZjkzR2ZKTUNSeVJkdWRpZXNYaUw0NHlWcmc5MkNWWHhrdVBJRTRQ?=
 =?utf-8?B?MHZFZXlaYnovemliS0dpc01EQnNTc1FMdFR2ZHU1ci9RblRnQXhKSHRWUVRo?=
 =?utf-8?Q?7ZKAuVE7w2gif/2nADrYsCXzlE8V5gVM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUlUL0twUk9QRTJYT2VSTENHc2pVMmgzYWQ1RW5zMFpOd0V6MWNJZElUUjhn?=
 =?utf-8?B?WGMyV1k4cEluckFySTlDSjhJWHdpTHVBd21keE96clJmTVh2VkJaSTJrSU5S?=
 =?utf-8?B?QzJQbnIzWUxjVWVMWmtqQ0hUQWJXQVJlUm5KTnVNbmw5ajV5b2tKTk5yMzIx?=
 =?utf-8?B?cWRPMTMyRnZaYmF0eTZzNW9MMzVQZjFRMnZqTk1VbXVTZFBaR3hwcHNOTEdn?=
 =?utf-8?B?aHpNSFRCbng2Umh5TjNyVlZWM0c3UU9tT1NiMG9hWTlXTi9UUDgwWUZNVlJ3?=
 =?utf-8?B?ZThwSE9ReVpxZ0VLR0h2d0s4OEZVbU9Qd25iaCs4aUEzcVJoTHVDRjg0aUJ0?=
 =?utf-8?B?c1lZV1ZaaXRqQ0tVSkNUWVRJbWhrS1hmU1pIOFVSUmYvMHpsM0xpRGt1ZEFa?=
 =?utf-8?B?aklKbU93YWVaL2xPZlB6a0hPdmJGTDJ1WHRTR05CZlVERXgwOWJKaWViUU1I?=
 =?utf-8?B?dDJpN1FVRExkZ0R5cjlFbEFHbjEzQzArWFlGOEI5Y0hQbWJ6WVdEWjlieWJR?=
 =?utf-8?B?dDJXdE5xQUtWcUV4N0loL1JkY011Q0U2SnIxNVJrMm1ILytGYjBHMm9qSk9G?=
 =?utf-8?B?NGVLNnN0cUd0Yk15aHYyM3hQY2EzaWpFcGc4ZXdEZ2NKZEZrVXE1L2NNT0tI?=
 =?utf-8?B?TWdSRWJvdFczL2dLcmhYSlJoanpxMWpacG9zbzdkSVVKb0NlcXZXSzFCb2JV?=
 =?utf-8?B?a2pxSmhMUFVjUkJGOTlSQUNlZnhOd09TMTdtVE1tTURxYUhSUHBkZUc4OEha?=
 =?utf-8?B?UmRrUGRFVUxuZmREWG44a1pOVTFpNm5vNjdGUHFSRmt6dXJhQjRpM3EzYk9a?=
 =?utf-8?B?enJ3V0xjZ1I2a0FBdXBGMDBpeklnQ1lLNzhZckZ2bWlKdDRVSGZXVmJQQlli?=
 =?utf-8?B?VUpweGtLeWdHeU1sNmZwdGlETHgwNG5SbEVXV09CREJrRkFyWjVUREFxd2RL?=
 =?utf-8?B?dFB6cWlWdUI0dEpGMDNZN3M5dE9TUkFlaERsa01RM0xGU0ZYV05Ra3k2dVl4?=
 =?utf-8?B?STE2WU9qU21ONWcyaEhpcGkvUGRpMnFmTDgzRmxhalZSdVNMTEhqZm1GWWls?=
 =?utf-8?B?Y3QrKzlPV1FCZ3hCRXdhbU5Ra2VUN3M0Qy9mbm11a0hPSHg1SnhtMWtiU2dZ?=
 =?utf-8?B?R24yNS9YeFQzUjc1UHBWQ2FUR3VmU1ExYk1HY0xqeTI5TlhMRVY5Kzc5bWw1?=
 =?utf-8?B?TFZ2QmlSUFEzUU1Ic3FwOFVZVER5RDBEMGxtNXlnOWtsSlJ5cU5laGRDQ1dW?=
 =?utf-8?B?S2RibHlIaWVSS21LcFVsNXBHRGZjSncyZUluTzdHMDJQbk9RYjRVejNKS1k0?=
 =?utf-8?B?LzdnbnFQY0NrT2JVbkVFYlRaM3lHejJPb2RMbFhqMkpGMnU5R0diSEZKWUlY?=
 =?utf-8?B?RFRRZmFoM0RXd2cvQmZGWTZHT1FHeWVwdXkwWXhSR25pS2J3Q3NiaHovL1Zo?=
 =?utf-8?B?QXhEa3QzdDExN3R1YWxFTURCdnptQ1gyQndXai9adjJNZVg2NVBXMFliUmN5?=
 =?utf-8?B?ZFlXeWxpbUdoY204cWZWODEwOTQ2clpVcFNIZy82ZUdndTRJcGRCMWNpSHhY?=
 =?utf-8?B?d1VTc1VURU95c3diVi91YlphUGxESFlxZ1VHVUNsRlBlMENLcjcwV1hWcFRz?=
 =?utf-8?B?bHBRSVMxS2lMeTdXV3dMTHJTK1lrODdwWUwrR0szeTJ5V1NEYUo3VFQ3TjV4?=
 =?utf-8?B?NTMrL1c2b2xXTm5PZzF4QnNEcDFCanUvYlZ3WHZ3TFZvUHNYamhoY1ZRRDN3?=
 =?utf-8?B?bzRxaUJ6N3FwTUhuZWwvY2M1YlFYRHRYNGVTR3ZnWmxOblBrSVRHamk3K3c4?=
 =?utf-8?B?NzFINFNxNlFhMXdKZm92enVnOVd0NFFWUGpZUzJwMU5aNTBiQS9UMDRIOW5X?=
 =?utf-8?B?OVZkNDlmL0RyMC9wNjBJb24zckJWWWlaM2xOQ005Z0t1MTI1UjRWRGpDVFc2?=
 =?utf-8?B?MWZRQlhVUnhsVThtMFlrbFdDdGNoMnZIUmJNelhNT0VoSzh4UkhEUkhuZ2ZI?=
 =?utf-8?B?eW5uYWIydWpadlBHMTB6aGUxTVlEMnRlS3lZV0ExekpPNDY4djlTN2tERnlR?=
 =?utf-8?B?eUtKYkVQdHlWL25PZlpDZ0RLWUcrd2ZTVjBKZXcyRXo2SUREQUVyMHQ0Zks5?=
 =?utf-8?Q?ACwjEYg4bDJLzdwgPySP1mmRB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2cd847-e5b9-4ea6-dbbb-08de273c4de9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:21:49.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpRg/txtn/GnC6gQ8G34DR4PZT6Iim1pxZwQ4RFvr+XKtOISF5BfSwty7Xf9uIJzOnFVJH6Bsp55BcjNeK2GjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

On 11/19/25 12:39 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 09:29:05PM -0600, Dan Jurgens wrote:
>> On 11/18/25 4:14 PM, Michael S. Tsirkin wrote:
>>> On Tue, Nov 18, 2025 at 08:38:54AM -0600, Daniel Jurgens wrote:
>>
>>>> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
>>>> +			     u16 obj_type,
>>>> +			     u32 obj_id,
>>>> +			     u16 group_type,
>>>> +			     u64 group_member_id)
>>>
>>> what's the point of making it int when none of the callers
>>> check the return type?
>>>
>>
>> It's an API, and return codes are available. I don't have a use for them
>> in this series but perhaps a future user will.
> 
> For starters let's address the existing use which wants it to never fail.
> I would say do something with an error inside the function.
> Maybe just WARN_ON_ONCE.
> 

I can add that, in my case there's no recourse if it fails anyway.


