Return-Path: <netdev+bounces-162154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7BA25E85
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F08A3B0E7C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECC42046BF;
	Mon,  3 Feb 2025 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RD62k0Sa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8F3595E
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595738; cv=fail; b=CbTmNn6oAogII5t5xDhHDnPZk+rZskejPutJ4NvNdf/Lo64/9ESmo4moKy22OlnGrBf2QRYZOMjIHNbHaWq28O8RR0/L0aUroGJN8xEdpWR+sCVRMwD2iLZlwB+kaZHpUNb6yyz6/ZeqEXsmyvG/WwBZa2q1nTg9/2PgZqb48QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595738; c=relaxed/simple;
	bh=C5MimX+NWt/JE4/MIvyM+IqIeJBvFOd3eUIakCAP8rQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bVm8fgDYJSrJpkz0TZITbUjXSAONAfn2tUBIH5ob5LfLzApSDiy2FbLoglEEyo715JQwTAODPxhVilnHC1J/CeVJyLBEukN6UXq5AUFPxfaE3QPu+GG4rMiymEQOENkpDTmo6FBoejq/OVFHOTPJm0pJCjop6Clre93ctQCSmQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RD62k0Sa; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdC6d1GVv6AuxiRTSgNXHxSht+RNfE77t3QlWHlYiQOrfdcFCpHlIUt3i4yIEmijgRbJguPwbv/3D0F8bJJAGaln88I+eRLTZlOrN/bIFmnlR2v+Rx9p4/5toy6XhGPJzKcQ27tVIz+xf1VpfA9k1QGJnYDpA/qMD4udlivQhOr/HG8pQwUt0XffjJVVN1vrA6LvBxSLwe2ZoqJHNb53VfWwuaIcz98B0cOB97kPZ1LiPiMhQEhYQh5MjK/F5K3QSkSe5gqOkZmq4PC9bIcC362rkqfMZwujjjnsq3XngBODbkmeHNm1UnOLgd9ecl0u132Q/KJx9jV8sNaFQ4Pfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMKW1sRytwYbM1SRUQggmmLOsq+qBNq5ey31C5PS98w=;
 b=YcFYY0kBsiWFjkCuzZOe1EfFAtQvudBNwmpYoIchzkSQxbOhx4OvFw5GKzAYGQPp7SmaT4fdSd8fjjGPv007ILsA3VE/70CNmkGdydpk8Vn6qpeW8XYxJJ4yUjxKds/ODol+dV86vaSStnF8sbF9f0YVX8zb8XzkSaAnB4CTPoTtOyrY4vA+K2+sYE4V7yT1RB/CQP1oE3o007sgDtwF5rpcyD96IiSNafPCG21wpId70i/O57C0qn+1+myqEcZCD43b6oc71W5nJ/7mxQ+Ye0Cyn2MlZ1fnMb+WjU1RfE+JbXkmerJd/M6ww7s+K3H7b+/mzyGj6jGIrldqpcVAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMKW1sRytwYbM1SRUQggmmLOsq+qBNq5ey31C5PS98w=;
 b=RD62k0SaDvWRSaTSbe4c7F0uKCs1sCm+cOU0YI+lGDDSFIp1FNkbeXUSO6OQfJozx4yGDUJR1fOSK1YnZPR7xWWjotIFBu9v6VbVaw0zigZYT4YNs0K1ocTRPj1WciAnJYhRmXXfN8/X1VhgGTIgPdXgU1ey9bKzMc5s37Nbr/MfPnLz2G8AbHDBdYOjEHW1gCa8rl2cBkUYjqp8qxy7GL8+nJyHet6+HSsyf6r5YLhimsUU/qqA8wLZpJU5rw3VZ3EGhTLVNELhgev13+/gx/Qex0O3GW4b139OPDFmtxMeCYst+JUuxLhGc5iTZhdXZNSREju0RwWMLcsCN+H8gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 15:15:33 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 15:15:33 +0000
Message-ID: <9156ba2e-e19f-4be3-ac9e-778ab3df9a4e@nvidia.com>
Date: Mon, 3 Feb 2025 17:15:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] ethtool: rss: fix hiding unsupported fields in
 dumps
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com
References: <20250201013040.725123-1-kuba@kernel.org>
 <20250201013040.725123-2-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250201013040.725123-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: c4085710-5361-4c44-6bad-08dd44659aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkUxMjZmSERkQmFUY3gwWFZhczQvUW5zNHlYYi9Gek9yNlEvVEZtWGxRRUo0?=
 =?utf-8?B?NGp4YXFEcXJnSmd1QVBZSHZXZUhMbkJJb2tPNXJGQzZseDBKVnVGeHFqY0xt?=
 =?utf-8?B?TnYyUjZkSER2bnRLd1NhRlA5Sk4waTIrUjZGNHM1Tm1IeTJreU9GWEY2VzVx?=
 =?utf-8?B?Tm9hU3pCdzV0UGJVOXEvUWpIM1ZUY0dwY0lSMmVnK1Jzd3FWR2xReVJldDV0?=
 =?utf-8?B?KzJjQTgyQXZ0dFY3RFB1cGRhOXdrYzNoR0p6dk5ZTGpBV1Qyb0xVcFp6dkJU?=
 =?utf-8?B?U1lJcFcwZmhLcHpza3l4cDhqcjRMQjJWOUU2WkxNZ3JMVThQcEtLV2ptcHZ6?=
 =?utf-8?B?c09rOHoveW4ya29wMzhWeVlkVmNXSE11VHF6YlNqM2ZkRHY2RzE5NWhqSC9Z?=
 =?utf-8?B?dGdhbjlKZUlzVEFiWGEzVmVPVTBTUnBYa1FPajhjT1hwQlY5a3NETXVIaXJ4?=
 =?utf-8?B?MmN3OHBianFtbkZDQ25lT2x5ZmRpbURjTHlxTXRUdm90TkRyZi82UFdZWS9L?=
 =?utf-8?B?WmxTZHdiUC9BRUUrbjJEL29XRGxtN2haTkpnL08zZnhzMDFVbC9oTFU3WlRH?=
 =?utf-8?B?QzgrZmVqNHcrWFUxYzJCM2J5bkVKakVVQXFqYVJCUUJIS2VoMkhDWGdDU2Nl?=
 =?utf-8?B?MTNtYk5GK2hjMlA4SG45djZyYWcrNW9zSzBtUjZZQUZTbUMxK0xiK04vdUZQ?=
 =?utf-8?B?YkpZZ2QyTnRaOVUzeFNEZjhnRE5lR1k3VEIrdTRtVTRUMW02V3ZocGNyMHVi?=
 =?utf-8?B?ZDBLWElNRmtTLzQrWHJSWGsydXN6QkgvUVpMVG9adHoyRElyMk9QN3U1bHZq?=
 =?utf-8?B?TXRhdDNxbk5RbktRSFhJWDBaSk1SdlNwNEF2cDFpTG02SVR2dkxMbEF2NzVo?=
 =?utf-8?B?clF0eHIxaDMzaW9VVkJidXBwM1d1QzN6eVZNd2VNdTlnZFdjd0FOV0s2NUpE?=
 =?utf-8?B?ZDY1bEd2N01oRDhzUkFOZmdZNFFPQmUvSXZiYm42c2RJdE45VklmOXJaYm16?=
 =?utf-8?B?bGg2eFVENnRDWjdKeWUxZjNzV2JpcWNuWncxRVcxN24zWUdsSit2L01pTmtn?=
 =?utf-8?B?VVh5STJqdmZNWGp2RitHeElBbThNaG9Kc2tBOExicmNQbVcxVjlCQ0w4aE83?=
 =?utf-8?B?Lzd2a2J6MUVXZDdvM3ZLM3dvMmFDeS8yY2cwT1o0c3QzVW9LQTh6RlkvSVZi?=
 =?utf-8?B?Wnp0a0Q2WXUwNHJoUFlUVm1vL3JLSWh3elh1alNsc1hZaE9tbmM1d0QzZHQr?=
 =?utf-8?B?c3ZKczZ1cUxvdFlwR0ZKNFE0MDVlZm13WXkrbkM4clNkRlVKbElmd255ZDZD?=
 =?utf-8?B?cnFidTRkQjlpYVpjK3gxSHZXbHRKUDhBS1FxRExDTVFRTFp2UDIxSlNDYVRL?=
 =?utf-8?B?TWwwUzJtSHhFQ1lOQnR5aE0wK0lrZ2k3VWltYU1UQVJJTWdFYmZoYWRPUjU4?=
 =?utf-8?B?NWl4RU55UktYRm1UL3o1QjlSUlRNd2RnYU1sRnYyVk9hQ09jS0FrUWFvaXJZ?=
 =?utf-8?B?Mk1XWms1NHdXUDgzU3NlK0VJSEYvbFhtaTRUK1hWMjNkbGdKMUNWTDZEOGZI?=
 =?utf-8?B?T2dxdGw4OTUyc2pIODliUnNKajgzUldzazhIOHZVaTlad3NYQWM5WWxlWUI1?=
 =?utf-8?B?bnc5YWRDd3l0Yzd1SjFRMXF4bFNjNy9tTmdmb3FqeHI4OVpQSHV5R2xrcFJ6?=
 =?utf-8?B?ZTJKWTUxN2xrTmNhSXpzc2RNa3dwUUw5N0xTR3ZtS0ZzcG95bzdrZ3J0MDRo?=
 =?utf-8?B?RUxaSjBhYWJJOWFzWGRwdytOQlJCbEZSZDFDa0hxLytmWjhvRjU5WDFaZGhT?=
 =?utf-8?B?UjMrS3hMdkJRTEJUUTNscklicy9welB5WTJ6b3pVNGVDdUtMblpyUUk1VFQv?=
 =?utf-8?Q?hh9KlGWv4MGPg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em4zc0pFenpGUWtIUEU4MDVOa09XRkhON0xJMWVaSVJTWkdrY0RXU3Y4V0V1?=
 =?utf-8?B?VDFsekhwVk9TeG1SbWNleTRUOUFuaUZnZWVTOFNZbmVxVUVyRVNvdUN6anNG?=
 =?utf-8?B?dXk3SXg5cXc5ZDJLSUZBQllHb0RiV3YxL01zaXQ1V2NGYWF3Mnp0cTdVM2J6?=
 =?utf-8?B?bDhUNHdIZHAvUUp4eUplQXVlN1ZNUEVvMVdkYnlpb2NVYlhSUUdEaXIwajhp?=
 =?utf-8?B?TE45WGVqVXg0RkJ5c1NqRFFPbXBmTElyY1RudE9GM0liQmRYYStzU1dqSGhY?=
 =?utf-8?B?RjBBVElpWU1MZmZtY0FBdkFzWkhpbmRXT0dMRENqU3VHb3dGenlYaEdISE9W?=
 =?utf-8?B?ZFNRQVZTRkE4OWhaTVZLUS9aNUNzVGNEemNFZEl1ZnRQK2lOUWppL0p1Zm9H?=
 =?utf-8?B?T0xFTjE3a3lrU2V1WlJ4VVJ6aTdWY3VWdWRXNDB2R1NNR2FMYTg4VU5pc1Fv?=
 =?utf-8?B?NTlpcU9EaDFKSzFXSnIxdWFVQ0wra3NGejNraHgvT1I5dEJQNE00UG51OUlK?=
 =?utf-8?B?TmtrSHVJTHQrU0ZKSVdTTkgrOFZYOXphUWI1bFJTTXFVdnZFNUJOWUxXRHI3?=
 =?utf-8?B?a1luV1h1bGZtRDhCeWdpK3hDb0xGam9wYjIvODNTNzRFTkFhb1JYak9ZY3pw?=
 =?utf-8?B?Y0tPbnRZTnY1b0RxdEZab1l3Uk1SS3JSb2NubmlVVTJVSGFVOVg1UXJMcUEr?=
 =?utf-8?B?ZWFmZm5oQ0VVUDRtNDdnYTVsYVRraytRQ0dycWdCb0thUWNhcnltcmJqYVRr?=
 =?utf-8?B?ZmxTV1M5aXlNK3NqWTVodmpVMFdLK1BGRUFEcGl5WWVzTE9wZjBreUdxNnlY?=
 =?utf-8?B?K3VVVVJLU1FOYzA0UUE4eU9RZUVPMEtPdllxQUI3WFdraG1tcHpFclJ2dDZj?=
 =?utf-8?B?L2xyOWxVbEM2ZlUyai9XdVkxSzg1VnVURitKYU5Bc3JvWE5vQmtEOXM1bGxM?=
 =?utf-8?B?NW45blFnalFsL3VNc3BURFU5U1NZSnBIMmNBd2JOOGZDdDl2cDB4bGh3VmQ3?=
 =?utf-8?B?dXpHcndBczVvelpicElKWUhqZ1VSbW5zU0dKSW1UaU9zajA4OFNjYzc3TUZ3?=
 =?utf-8?B?WnhoN1l3WHVxOWlZQWZhRVJ3MlpIU3BVeUdkRVBRVlgvS3JqOUR3N01NbGxF?=
 =?utf-8?B?Q1RRcjZjbHNwbzZoUVBRT1BJSkFva0tmMlY5S21xd3M5cVlvMDZvd0ErVEQv?=
 =?utf-8?B?Y3cvVlY2UXhYdzlWYVRnWExuQXl4SExxaEU1S3BUQ2hJSTZoN3EyTGdQNlBl?=
 =?utf-8?B?dlRTTmZQNVlab0pMR2FQN3p6VjdtTzRsUlU5UW9OM3V1cUFCM3h3OG1HWjJu?=
 =?utf-8?B?cjdqcDZadVNMRVhOS21oSDlTejYxRVhyMWJPMFB2UGRBSWh1Z3VUUWFaVmhW?=
 =?utf-8?B?MDJGSVIwZjFaS2RTdExsSnNuUFliVFZ0UEY0MGZoYVBvYS9WZzc5MmFZOU1x?=
 =?utf-8?B?em5OY1RwZUNNOXFvUDZJSXQrZnYvZWdhbEhydCtDclI1eUJQanFUQnFDU2pS?=
 =?utf-8?B?QUVaSkdSWUdXd1B5OFg3TFpQV0crUnAwNEU3cmZ2SFFGa3p1OVVjUDJtL1dB?=
 =?utf-8?B?TU1WK0hyeFEvQ0tuYnM1eVpHNllVTFJtMVR3MzBhQitRc1JvVW9zaEljNjky?=
 =?utf-8?B?MUVSQ3NjQSsyd0w5bEVYTVpiYkQ3czJFTW9WSXN4Q2p5M2ErVVU0OGZtUUQx?=
 =?utf-8?B?ckZ0Qk9lVTE4N0RmSGFiQ0hJSnRqU2RzTTB5bVhrRW40RW96ekVkR0ZFNk8y?=
 =?utf-8?B?TTNqbXdMTVpqS3FDK3pQekpmN0p6OHB3RG41eFlzSlM2dmY3RkF0aVhJajVS?=
 =?utf-8?B?cmpHQkdES0doY2NpRlBxSWF2RUZlckRwN1RVSWN1eVJLRWJZY2h0K2cvZUQy?=
 =?utf-8?B?WkNsTmRXeFlHSTh0OHJRSGdEZnB5ZkJoMVRsUjF3OXdQcWJHSnEyWm9oSmZY?=
 =?utf-8?B?U3pEZTNhdmFBdEY0Z1ZuL2tBZmVmdVlTYWxZdFhLclM1MWRlSzh2MHIxK09V?=
 =?utf-8?B?dkFVRDJkalNJaElDMm1OREtjcURIam9yZWIrNWFEdlg0S0d0a1oyTzA0VEZF?=
 =?utf-8?B?WTROUWxMQUlxT3B4ODZIcDNVSk9EbURzOXRidC9xcE5Gb3NZUUdpV2gydHh1?=
 =?utf-8?Q?/31NA7cNeU5Hn2idj+gwuKMVK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4085710-5361-4c44-6bad-08dd44659aa5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:15:33.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 710RX3pgrxFqPI3DrVWPskrEg/pzdnJStqE6/DOMQBDEN4aLnuADTzVuXVg+DBGC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

On 01/02/2025 3:30, Jakub Kicinski wrote:
> Commit ec6e57beaf8b ("ethtool: rss: don't report key if device
> doesn't support it") intended to stop reporting key fields for
> additional rss contexts if device has a global hashing key.
> 
> Later we added dump support and the filtering wasn't properly
> added there. So we end up reporting the key fields in dumps
> but not in dos:
> 
>   # ./pyynl/cli.py --spec netlink/specs/ethtool.yaml --do rss-get \
> 		--json '{"header": {"dev-index":2}, "context": 1 }'
>   {
>      "header": { ... },
>      "context": 1,
>      "indir": [0, 1, 2, 3, ...]]
>   }
> 
>   # ./pyynl/cli.py --spec netlink/specs/ethtool.yaml --dump rss-get
>   [
>      ... snip context 0 ...
>      { "header": { ... },
>        "context": 1,
>        "indir": [0, 1, 2, 3, ...],
>  ->    "input_xfrm": 255,
>  ->    "hfunc": 1,
>  ->    "hkey": "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
>      }
>   ]
> 
> Hide these fields correctly.
> 
> The drivers/net/hw/rss_ctx.py selftest catches this when run on
> a device with single key, already:
> 
>   # Check| At /root/./ksft-net-drv/drivers/net/hw/rss_ctx.py, line 381, in test_rss_context_dump:
>   # Check|     ksft_ne(set(data.get('hkey', [1])), {0}, "key is all zero")
>   # Check failed {0} == {0} key is all zero
>   not ok 8 rss_ctx.test_rss_context_dump
> 
> Fixes: f6122900f4e2 ("ethtool: rss: support dumping RSS contexts")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

