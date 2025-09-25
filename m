Return-Path: <netdev+bounces-226459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C70BA0B53
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082601892813
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08332E7631;
	Thu, 25 Sep 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VD3vOwdp"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561B502BE
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819239; cv=fail; b=DrmF/1adsaEMVsIJHIYbGbc6wtKMwzzdLOWWqeTVpcJiYBpgPqRxiFxKUBx/gFUt7V/QCKk7ByGsmP8WoeXT4MRrsh97AsBVtAGobaVdKzDJ8PsgtSXfKJ3xhi/Fz/z6ycrMfuFIYDSRFk4Jv31ZRY00LX2caFYzjsJlRBCEO8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819239; c=relaxed/simple;
	bh=bELPJSddlVQgUNQMSZfXyqRPboTcS1YLAKO3rVXXEjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j66EBunefGV79g0eIzXBpF2RzX3bADUtGlt6D9CDaLhPRrrD/lvoy8gsZktpkvVqmhhlXuUFJUeLMIbKsUHoUjV2eEO2HMzh6DA8g8LkN4tDKeKsLEnyuWsALHpvNc0LHmiz65pGRyXM5ocVMUL34zwEQkEXebFrBklK+8Ptfh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VD3vOwdp; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L17UQQEB8ychdOZXlm3kuPEwdEL9kQJTVSrJGxUoeFdJy/+KzwIwKoaaBQ+AE9w3MRlNLkxFu9RGuciStBE/MFRcUyyIyInePtzuOzGu930kHUj9F4xfNUe9ufxBzs9gKtPKJICeFZFFFPd+F+pnc3IZrK/7FiBxZ753beo/dyiwJEGYa7XgXVFKzf+iyr9/uN3bp2oLfNsYPV6jq54X0+ULXHf05yLGUaVWZdzoojZVIW6RHWwZQ6LocheX7NjzlAsfqfZKD6YvnXRyXV6uC2jZvynQZoA4QwL0knirgqUicagcRU/BDquOrF9nFfmkcSr150tnUr5WWKoAZG+7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLlOxp8U+jX3RebOmQLEPCLoqfLs8dEmO9hzVlUv5cI=;
 b=CdhkW1rt4/C6oNjTiDHYeRQeRVPGbRcrewHeoMIlMyN8lGD3vefniiLnWSyXOC8a0HLg+oOWFmIa8yIzZ1+Ph1PW7Dsx7BPBeLnLG8nhrPjcA8PjKxxe3kb/L562yG/BWRpfhBTyfRcjOMHYwxJGC8Z3QEYA3XE/Bv98QBr7urudXz+hwmUpo2aEoGh5RyBqNVRNLKK5YTtCndaiMaF2YjSHIM2OZUajIsgtPlh4Bw348b8x4GwJSXvnwWTdUNKxPfT4d6CmoWoX6On6+78i+/XRhmlbHfCrB8eeRSNb+QbIAFhNi6jViZUvv4g4ZjB+bFKybECP7V0UVeQhUK9eVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLlOxp8U+jX3RebOmQLEPCLoqfLs8dEmO9hzVlUv5cI=;
 b=VD3vOwdpIs6rkG8qVdw82O9eT9G/5ySOBPHnMRcVHbZTR9IoAvn8gdzVlnFQe64qLFEuLij5Aaf1YwCznDw52+RQs8PNKFb/VNckV0Aaq0C/MgrGIdH8OLUntn6+WfyyAuFOlZwwGR1irQnTydheOw+lm/jdn6YSCxvMLxWzJYN2phA7dffD+cRNtBiOuyxzDal2EvJ5Jk+8Y0HkWdblf7rCix8xV0zy8ewoDqiMwnZEGZIMMhY7z6sngqwDzlp2cb1WTYxJ9YmxQhF3qo4wxwFsfhpsl+iuJJPQsFEFS61t+9XOQopm/kBAju2M5yAoEboAISUACQtuLFaN9C3Qeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 16:53:52 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:53:52 +0000
Message-ID: <bc70cd99-31a5-44d4-9648-20dcd80e9f8f@nvidia.com>
Date: Thu, 25 Sep 2025 11:53:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 alex.williamson@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, shshitrit@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 Yishai Hadas <yishaih@nvidia.com>
References: <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
 <20250925062741-mutt-send-email-mst@kernel.org>
 <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
 <20250925074814-mutt-send-email-mst@kernel.org>
 <b3a7715a-5826-4395-9cc3-73bac8c26a63@nvidia.com>
 <20250925085537-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925085537-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:5:177::31) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b7eabb-7af2-45dd-764a-08ddfc541b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzEvUGJoS3Z2M0JnNGR3aHhCbHhrQ05FaU5PQ21oYkRrRUhmamJGUi9qeFh3?=
 =?utf-8?B?c2V4Sk1nOUpqNk5HZlFPQlNOaHBYVkZVK01yZTZObE1tYlRod1FOVzZPTEMr?=
 =?utf-8?B?MEh3L204U05qMkJ3eFNib0pjRzREYkRDL3h0K3VRcnA2YzFPRm1BMW9ncmEz?=
 =?utf-8?B?UWQ2Y3ZpdzBxZXdqQlhDUVRnU0pJcEpWclZ5NGhGYVo0TXNEUXUzZ3ErMktv?=
 =?utf-8?B?TlhoenJvVkM0b0YyVUJXb2ZHVWVEd3lkNWRJWTg3TUl0MUFLNWRTU3RvK0lO?=
 =?utf-8?B?amtXQUtPTDNzUVFremJMcGJlWitIdHhpQU92Sy90RkJQSFpZYmR2R0loTkxs?=
 =?utf-8?B?a2hwTmZobURIdHVnQStjYUJsWS9ydWN5M1BHejNYSzJDOXJ5ZjdRWFM1RWRT?=
 =?utf-8?B?V2xldmNLcWpxWi9KYjdUYjlwWHEwbU9yeFZNekRRSk5Gbm4yVjVoT0wwREVw?=
 =?utf-8?B?Y2xIY0JycU1Zb1ROTlRsdHR0azAyVXJFYU4za052U1I3a1ZjcmozS1FyMkVS?=
 =?utf-8?B?SmhtWTRXSUFRTUpoQWtrZnpPOC9KR1Vnand4bDdFZW1WRjdEZGZHTkpUK0pG?=
 =?utf-8?B?b2JWRk1SdWhDbFBxM09uNDU4MEFoVWhScE84bzN2VFBwaUhhaFhyVmM0YUhB?=
 =?utf-8?B?UmNxa3VKbW5sOWovbUVzVGwydkNUdWp0RkgxYm9vMEcrRmtuOE5HM3RmN3Fo?=
 =?utf-8?B?d3NsWVhaRVZ4V0txWmZ4Qk5KUk5ZYXZVT3cvZ3FjV1pnNWdBSER5RHhSSElF?=
 =?utf-8?B?NTJZY0xqN2xnZjNXbHJmVHNyanN3M1BYTzlZK3Bub1J3TUxvQnZNUmRuUEVY?=
 =?utf-8?B?cHozbmtZMzBpUXIyQTZRTWhibGZJY1l4TGlnVVNSRkRiSHN3VFVVWGZKQUpS?=
 =?utf-8?B?MjlES0FoRWFURUtXeFhybGd6djlZYkJMNmovRUE5ekVIN0hZZUUydnpkaFlo?=
 =?utf-8?B?WFBId1lValBTMTk2am4rWkxrVERNVndoZUFhMHJmNG5uZlBCMG9iaHkybzJk?=
 =?utf-8?B?QWY2bk5LQU9IcFBzS0lzRjBpY2tsczVTZ3FVdHRUSEFMQk8ySWxiZUhNeWdO?=
 =?utf-8?B?TEFCclFUdyswVE5IdnphMHhVajNibzZPMGxFbTR1TE50Q0lpOUZ4NEdsdjNx?=
 =?utf-8?B?WmYwTEltT0lpbDhoYkh2WHQySkswc0M4RTJSc2pGVnFwZFF5b3VSQkRIczAr?=
 =?utf-8?B?Rk1SWjFMNTMyV0pubmhVYTZDSEdWQ1dXR04rRDhnUzJIeHZnbnNOWURodkhI?=
 =?utf-8?B?a2lqekdDOXpJTmY5UWJqTHdFNVhESFQ5bFZOclZhRE9iMG9UNFJFRy9zL1B3?=
 =?utf-8?B?dUFhK2w1N3ZvRVEzUmdRd0ErcTY2RjArU0dVWXNDOEJSTEJaWjg5cEYyZy9L?=
 =?utf-8?B?UGpjbzFid2ppYTBRcTd2cldyMUZVL2owcUZZRjBVS0RXNElSRWNVTllobE5w?=
 =?utf-8?B?OUprbGxKK1hKZ1pCOXc3VU9BenZ2aUx0TmYxUUtWeWVEMVlZUzE1OGRVdXd6?=
 =?utf-8?B?TFIzOEREdUQ5ZVZnbUoweWtWT1BFQmJMRTY2Z0FidlZPbnNpUW5RUjlhVDIx?=
 =?utf-8?B?aFZlWDhrTWVFMVNjTm1xdWoydWlXTVJISU9acFBGbWRtVWZkWkYxSWxlSWZi?=
 =?utf-8?B?S2pVREpNZ1JuTjg4bmk5NzJOVnUrTm9raEVvV2pSZ0VxNCtUaXlaNVpsNkZn?=
 =?utf-8?B?WVprVHZJQW1XRDNVTmNhaDdxcTVBTldKaTRzV3hXZGgxNWowS01DcUFKL3Ny?=
 =?utf-8?B?ZHRVYXhkVFFBL0ZuS2gzSjB2ODRlY1JJMnNPemwxaUhmZ01UcU9iZHdTN3Fq?=
 =?utf-8?B?UEVqaDduRUkzMTVRUVpGQzFDeHRjZWdON2FGQ0gycHp2b3V0RjN6MWhhd3RI?=
 =?utf-8?B?bGp1Z0xlRWQ5cURQMXRGN1V6RnVaUUUrd3BoRVF2UWI3WGhNR1M0M2c1UytU?=
 =?utf-8?Q?BFkhblemIy3eQI1/ltjIJur85SVk88YZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGRVc2dmZ1MvL2k4YzdHSzkvTDlDWERsZEFVOE9iaTRobUhuOFluUDFwcUlG?=
 =?utf-8?B?a3ptZWh3SFJyaGM5SElSd0sxUmQ2dkRpQ3dIUWNad21DcWZ5VHJaNTFzWUFP?=
 =?utf-8?B?eGpidTZtU2ZmcWRTdGhRb3lKN1RFT2JGOWgzOE5nK004cXhsVW1ER0FRdVd0?=
 =?utf-8?B?aUdRTGMrcXN3cjRQZkpYRGtGclpWbVM3Y1IzQ293VzQxYVVxZjJXeC9XejVS?=
 =?utf-8?B?ZmV2RldLaVlpNmtLaVpHaDdqRWpHcU1yenUxRDlSdzltKzN1b0JTR0pOUkdk?=
 =?utf-8?B?NThYTWhhQjV6TTloSVNFUFhkdlJ2Z1piRUR5RndyV0Exa1JCeStXeVd5dnk5?=
 =?utf-8?B?SjFiaE9KRnRhbHllR2Zqc2p3UjNILzBlajBmeWFtc0FmelZyQ3hRRUNDcHRE?=
 =?utf-8?B?cWRNbE1YTTZWZDdJRU02ZDZKOS9OdnQ5amZJajAvVGtGd01UYUdQeEM5bWxq?=
 =?utf-8?B?SU9vZEVzbG4yb0NodjRHdTBaNXJqR1htUDdQd3BsaU9Hc3Z6dHArM0dRQU9k?=
 =?utf-8?B?cUJwVWNNbVA2a0hVaTJjaE5ZK05PTk5OOWU3UzcyODlIUFBEdC9OSlkrVVZC?=
 =?utf-8?B?RWkxMHlEMWdKak5Ca1BleDVlUDFmWldjNkNmUjJnSU5LTVFLblV5N3RWZTJz?=
 =?utf-8?B?Tm4zQ0lLVjJvT3UzN21kWFVPTXdObkExdUwxU3dBUzdKQ0pvcHphckxtMS92?=
 =?utf-8?B?Tm56N1VpdWsrTkgxNWkzbWZaRWtpdmNKWGZNUk40QStMSjVDbXk3Mno1N3Vj?=
 =?utf-8?B?U3RwU3dub3YwNmxsUEREc0NrRUliYmpuRG40OXlBN0IyTC96T1VjczU2WlVi?=
 =?utf-8?B?ZXZBdVFTaGxwNTVhOURwVzFianNhd1RtUGJtQzhFVXR0KzhhMkRqVzEzTDg2?=
 =?utf-8?B?UVhlbTNzajE5RThrNkttOEpaaWtzc1NscWZ2NWZVMFlBWkdOZDdHUzNpV2V6?=
 =?utf-8?B?bXZvOXI3WXl5SVJQc1N0Rkl5RzU5aWdHcW5NdUQ4WW5uZlhBSVhlL3FaWGRr?=
 =?utf-8?B?eldXQWsvU0d5WEV4Ky8vYmVPR2l4RmU2cEphV25MRHdYTGVPK3pXdi8xcGtr?=
 =?utf-8?B?U01Sa3VzTE9EQlJVQTBLOXdXY0lpVWdHTGNKeHlDU1E2a0ZTak9aYmhPaUpJ?=
 =?utf-8?B?WlZST0VGalRmd3BLMkZvcVpySUhlbGtIeGpNeDBYbTJpYnhMbXR3b3N3MVdw?=
 =?utf-8?B?QWhaaW9pZExZblFsQXRibkhYM1JsSTJwVkZrRkZ2VlVKNHRhTmJLT0d6R1hh?=
 =?utf-8?B?cDh2NjhpUldIY1A5VW1SNnRYV0hUM2grbmg2c210YXRocDh0bmFwekRHZE5H?=
 =?utf-8?B?djVIV1BCUEt2b2s1TEE5TVBCS1J1RklmNE5McExPekp2SmlDMStRMU1VTGxW?=
 =?utf-8?B?MWFaYzhvSTdOZ2xRWWZMZ3c4QmdMTGFNRVphNlhNY2kzNjlseTVoUmZvNEpr?=
 =?utf-8?B?N3JYdFdLdXZ4YjE5ZVlXRW83Y0wwb0NLN2xvZFZmRG5qMVBZZzBxMjVLTmo4?=
 =?utf-8?B?QjVoU1kwekRhb2tIZFllRUZ2WVgwd2dqTGE5TWdPWnoxdWxiNlBYWlVMWC9r?=
 =?utf-8?B?aXJmVEVKWVhETEdXUmIvVnF5VFBIQTBSOWpQODJMMzVJUll3T2RHcHNxRWhS?=
 =?utf-8?B?SFBnTzY1Z3dYT1Qra1BaSGxHb0NVNzFEWCtjUHpmUTZNRVh0ZndyMnAzWjlH?=
 =?utf-8?B?bHNUWUdNcjE5ZFVRVS9rOVp5dFRVb3NLdUp0RDJFcWV5OVhrOHF4MllGVnE0?=
 =?utf-8?B?SldWMzJoL0F5Wm13TUlOcGhEdzZVbVBKaVlCTGg3WmZIMk5qRFpiYmUxd1cv?=
 =?utf-8?B?eGJNMEZmbEYwVW1ISnIrODF1VllzM1ZDQW1kRUZmTnYxVFNpVG0veVNCbHhG?=
 =?utf-8?B?NC9vK0tvYmlFQ0pZWUFMNjN0MllUTDBSWFRyTXhMZTE5U2hzTVFpUDNxeExk?=
 =?utf-8?B?ZnJkdGNaeGVZRzljU0puK1huV2IvV0VPeVE5UzJqcFFCbFk2U3AxS0xrVlc1?=
 =?utf-8?B?R2t0NW5CWVhLNFI0VVhpZW1tYUx1Smo2UE1hM29NVTZpaitvQjBzNXRZSzM2?=
 =?utf-8?B?UHVDRTE3dXhiYnlIb3R0WmVtVDBjTDRjOTJtZW5CREJaSjZGQ21FTGgrQWpW?=
 =?utf-8?Q?Py7/xvyiMdWGWuW+55CPkahct?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b7eabb-7af2-45dd-764a-08ddfc541b7a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:53:52.7815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiiU3+kvTjSq8HHZE2jlygrZcJJXwckJDX8/6RwrJpHekAM8aQdKJBcTy2rSaedUZX+67BSP3kh27suXWTOSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361

On 9/25/25 8:08 AM, Michael S. Tsirkin wrote:
> On Thu, Sep 25, 2025 at 05:39:54PM +0530, Parav Pandit wrote:
>>
>> On 25-09-2025 05:19 pm, Michael S. Tsirkin wrote:
>>> On Thu, Sep 25, 2025 at 04:15:19PM +0530, Parav Pandit wrote:
>>>> On 25-09-2025 04:05 pm, Michael S. Tsirkin wrote:
>>>>> On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
>>>>>> Function pointers are there for multiple transports to implement their own
>>>>>> implementation.
>>>>> My understanding is that you want to use flow control admin commands
>>>>> in virtio net, without making it depend on virtio pci.
>>>> No flow control in vnet.
>>>>> This why the callbacks are here. Is that right?
>>>> No. callbacks are there so that transport agnostic layer can invoke it,
>>>> which is drivers/virtio/virtio.c.
>>>>
>>>> And transport specific code stays in transport layer, which is presently
>>>> following config_ops design.
>>>>
>>>>> That is fair enough, but it looks like every new command then
>>>>> needs a lot of boilerplate code with a callback a wrapper and
>>>>> a transport implementation.
>>>> Not really. I dont see any callbacks or wrapper in current proposed patches.
>>>>
>>>> All it has is transport specific implementation of admin commands.
>>>>
>>>>>
>>>>> Why not just put all this code in virtio core? It looks like the
>>>>> transport just needs to expose an API to find the admin vq.
>>>> Can you please be specific of which line in the current code can be moved to
>>>> virtio core?
>>>>
>>>> When the spec was drafted, _one_ was thinking of admin command transport
>>>> over non admin vq also.
>>>>
>>>> So current implementation of letting transport decide on how to transport a
>>>> command seems right to me.
>>>>
>>>> But sure, if you can pin point the lines of code that can be shifted to
>>>> generic layer, that would be good.
>>> I imagine a get_admin_vq operation in config_ops. The rest of the
>>> code seems to be transport independent and could be part of
>>> the core. WDYT?
>>>
>> IMHV, the code before vp_modern_admin_cmd_exec() can be part of
>> drivers/virtio/virtio_admin_cmds.c and admin_cmd_exec() can be part of the
>> config ops.
>>
>> However such refactor can be differed when it actually becomes boiler plate
>> code where there is more than one transport and/or more than one way to send
>> admin cmds.
> 
> Well administration virtqueue section is currently not a part of a
> transport section in the spec.  But if you think it will change and so
> find it cleaner for transports to expose, instead of a VQ, a generic
> interfaces to send an admin command, that's fine too. That is still a
> far cry from adding all the object management in the transport. 
> 
> 
> Well we have all the new code you are writing, and hacking around
> the fact it's in the wrong module with a level of indirection
> seems wrong.
> If you need help moving this code let me know, it's not hard.
> 
>> Even if its done, it probably will require vfio-virtio-pci to interact with
>> generic virtio layer. Not sure added value of that complication to be part
>> of this series.
>>
>>
>> Dan,
>>
>> WDYT?
> 
> 
> virtio pci pulls in the core already, and VFIO only uses the SRIOV
> group, so it can keep using the existing pci device based interfaces,
> if you prefer.
> 

I can make changes here. I'd appreciate if you review the rest of the
series while I do so. Patches 3+ are isolated from this, so it won't be
a waste of your time.

