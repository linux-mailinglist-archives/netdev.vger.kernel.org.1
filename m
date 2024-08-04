Return-Path: <netdev+bounces-115507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BBC946C94
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 08:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D332818C1
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A78BEF;
	Sun,  4 Aug 2024 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OE5DmCWG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D379445
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722751748; cv=fail; b=gKHex7kGSU+gxLGxn45TIbA6WkUpGg0Wu56yFHYvG6CsaQeo0/en8rAROlt0RYSnymZzUzT79oG+ko0fdv40Xe9Qs3PdPXzurap2XAzdyYxiQPpnjIDoQ37pJ749w8uY2IIOcEVlPtNXOFxMC8N5BnXEJ5wUK9SgZVPc1NmDCb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722751748; c=relaxed/simple;
	bh=vzC7V2XUFbhuEU1xdvpSXn3yq0EFp5kwKjUoIO1KNR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cnpEbdyQRiP1mkf+yWd+cPsNCtWgyJS8Ca89zk/sZfilzhro5VSEboiIe3lLrUQ27k7ibZ6fhuxFs9sImYPZLqW2LW0Hsr2OY0jqi6SfKxlM0BYbYLKg4Y+1yDQn9gIudkvjFThKtE9X/RaWRjgx3fT6LGJWE7GcY2VbNIyrqjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OE5DmCWG; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp0+7k56YIVxl8TYH4aVaLxkXNShor77y7syfbas7hLkCqK0Pv47hAxjYCaqAq+23X5c/P/FOJCHYy9kcq0ynSoJy5XGvgbq7BwYYFSRYDQ5ES32CY0bd+FiM7Y62PNixzQRSydeghscmAKd2jdvdQ3PDNhBs+eco5GWbPQ4FWuMgQWUxpWVM1loCSdYK1rNEaEfUVdvBFxSiuut2Dy6qNg+y25O0A9syzEoLnSm+SmsMGc5VWw3xlumYOKToYTHfXxxVhYq7noCH070zPZko9QB2uIiiy2hgoew2fWh75LIyaEwJBdVzCoHAfYEjQCaXyDDcn6k9bK37B5yqpHEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYoUlgj7/FnTlEt4T5745+C3Hdv/0/rJ4T+KJoHLPVc=;
 b=VmmL71/0Z/ZPR3QDalbLsH6JhZAfDAUIy9NH10iuLoszcZQjYS7qlPZtDOFqd0M+DxCpSFSJQdBWjET2B7s6ck4TMDdgHsRZsWjHujqjaX+DBvRki3nahNrTIoSgsdiapcekYtImb34N2MS6XpO0ofOte5UzBagdpXU7hwlkyhwxp5uBnsQLpC7WZ40Dv2gru8HTrwmwPm+Cwo+wJcdTTo27Ppz0+v/xLmzPCq+l5JisVnhkzEYvf86bgOlbUEVRXEZL8PEqhCMLvd5WXns5l84nN2s4ULfaV1nOlJ45xozSFNcJcLz41N7bfsquB2bgAfugkufHAWv3x46xmRBHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYoUlgj7/FnTlEt4T5745+C3Hdv/0/rJ4T+KJoHLPVc=;
 b=OE5DmCWGyGoEQFZpQyH6O4VwwQIOmkCt7m3+rpH1wP/6VI6Qn/9+gNElvyvkFyNiYSj36WFRGGMzgelgZNhZcK8dPuTV75LqwWb2leNeqcc6Cpwx306jOxdp6AtOsgxw02XlBe7d5LTcYCgHVEIwUCieMsGIvjMqs8/2Lq1QjAt3bWyW1Y4O07rNhzwmFTKA6s945p51Qdm6rTjp9SXvySm5WxoOcQINgIkBa9WtnXn4mwzERAvo0vrSex2hale8YWYDVK+6Fx6UPN1X1bqzidgiLttJffUR48NCd0itk9aMNLcxwoHSQL3wExeb1CUTzH/F546JM/Oi79dJCyPdJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sun, 4 Aug
 2024 06:09:02 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 06:09:00 +0000
Message-ID: <05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com>
Date: Sun, 4 Aug 2024 09:08:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] ethtool: rss: driver tweaks and netlink
 context dumps
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com, Ahmed Zaki <ahmed.zaki@intel.com>
References: <20240803042624.970352-1-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::23) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf83df4-d1e9-4823-9481-08dcb44beee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkZRY1loaHdPTFA3RGd2SnBDSzd6TEFTbSs2TXJKZmpEQ2d6VnhwU212TVln?=
 =?utf-8?B?ck5tN1NjY1hsc2I4T3hxSmpocDFZa05oOUt3dG4xMFdkMFYySWtRd04yY1la?=
 =?utf-8?B?cU5HQzg3UVdnanBTZVFMWDhscEVjbWxML1l0Szg5QmJ3MXo1V3RPcStpOUZR?=
 =?utf-8?B?TnY1REZ1TkRLeGd6NVBpa0luMmRaSjNoSjVtUFg3ZjB3UGFKSGpqZGNjOHBj?=
 =?utf-8?B?K0NsMkFUS09tNERYdjV0TWtiSk05V09ETjV5K01wLytiWnNEZy9iS1RaR2NL?=
 =?utf-8?B?TWYybnlGOGNwYStpSnFGSmZtdWFhSWp6MVkzTWJKcVJDcjM0Y2JCTlZGQ0E3?=
 =?utf-8?B?VllwTkR5QVV1bXF0MTFUV0VZS2FYOVp2RWx2RkpjNXlqU2dkcVBINkxUcU5P?=
 =?utf-8?B?TVRwcHpaQlpBQXYydVBBd2Vjd0xnZ1hNN2tMNWs3Ykg3QXdLL29HRnRJNDEz?=
 =?utf-8?B?N1hHam4vc2FJcmQxemVGSUZiOXZ1UzU0K1pWODdLQndKK3Jza1VrMU1mbHBs?=
 =?utf-8?B?d0p2MnJuVXBmNnNScnB1SC8rcjlUeHM3KzZYbmpjaCtsTU8vOEU5UFZ1YnVn?=
 =?utf-8?B?V3E1bEJ6VXIybEJvRDRVeHB1MDFCb2VOZWtGNjdKWFJmSW5vOGp1a29sZFd1?=
 =?utf-8?B?dHF5dzhiZWFPWXAzaVRkQUJ3TjNSM1FSSlhkKytteXg4QnBZMGIxVE8wYnRV?=
 =?utf-8?B?K1pXZ0tTbEhjWldJOWMvcXlXVmlzT05OR3Fld1ZWMlRQMTdLckhnZkhCWFBs?=
 =?utf-8?B?R2p3U3N1MDNQYlcrWU1sK1NxOEZNRHlNM24xa2pod3Q5L1V4eUZ5VFhPK1JT?=
 =?utf-8?B?ZU5Fd0JNM3drd3dEb3liK28xRzN6dGtBMis1SHBGaU0yUXBzZnBES3lUbGE2?=
 =?utf-8?B?Y29nZXFiQVphOFlJcURUaWFYMXBRTGVsZnJlRU5uZXpLc3hLYkZpRng4cXh0?=
 =?utf-8?B?aVpNSFY5aXI1d0NUdzRDNFRzMjVGMnp6ek5DQmhLVnJVelFZdExHUVM1VlZE?=
 =?utf-8?B?QXlpVXRqL29ZbnJKaGNsVHF0K1Y4cXV3WlY4dG83Z0VHdnYweG8vazZKcHdS?=
 =?utf-8?B?a0s4Q3NiREFqRTVaNklYL1lLMmllZmkxSytzQnVoNUxzSGtJTmFoZy9MODVZ?=
 =?utf-8?B?bjZoejE4bEQwYXJoUm9QZDNHdEFWK3Bvd0hMS0FaY1NGVUNrQ2Q3WUhKcEdr?=
 =?utf-8?B?QUNHYUJUWUxLVXR5NVkzZHcwbTZSYzc1SURMemEvNVcxZFFhWUNyeXJFYzVJ?=
 =?utf-8?B?V3R1dUwzYTgyVlBqb0I5VlMwOXZwRndPZ051cm1kTW1NeWlUWVk3YW1JdGZ5?=
 =?utf-8?B?WTFSS2tBdEhUTHVlcVNWRnRoS1c1cWhqVDNCdWxXbHVCNWxHSjhNQUxLMWtl?=
 =?utf-8?B?MFVhem1ndUFhMXgxN3k4UGE5WGJrdk1XVW8vZGgxcVMxQ3NyTU9kK3pUOXBY?=
 =?utf-8?B?N24xSmZNSDAwTEpiTGkzNklvcTFiQnpBMDR4clAySG05VGg3VEYxVVFNSENF?=
 =?utf-8?B?dVJERzZZdm0wb3FnRW54RGxUNFRITFBBL0VMYkpvbWVmeG11SVMvbjlDR1Vq?=
 =?utf-8?B?dXp2V1MwMVEyTDZqWU9MN1EwcXBJc1NZaGw2SUVBRVowdE8yb0hiVzRyRlR1?=
 =?utf-8?B?NmoxZnFjQk1vbDQ4YUV5d05DRE5od254T1BzbnRzRURlTGcyR0E2MDQ0V2Ey?=
 =?utf-8?B?ZnV0UEJLZkMxby9IYzRsNTVYVmFoMHRweURJT0RSc3FXL0ZnVTRzNUFDdWZz?=
 =?utf-8?B?MWpDdGtuZEJCQk5XSml2VUZuVmxaR0FzaCs3SUgvSWZzajlKSlg2OVkrdVR0?=
 =?utf-8?B?QnRxaFVVWUl1emEwUGkvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdYNlVQUnhxS24zRmhpUjlXQ0oxeTVGQ0ljbjZhNUdOQXdRbWQwNDZFQzIz?=
 =?utf-8?B?S3U4WDc3Q2tRRFRtNWMwcGpVUFhLYTAwOHhUZGJjbXNzQjNFa0ZXMG55OW5Z?=
 =?utf-8?B?SnRsYklRS2d6clZQNjloWWpsOHdkUnFidUFncWNaK290b21OSTlhN1VHdkgw?=
 =?utf-8?B?UmJQZGticFJJSk9NZGJGOXdJVEdCcnNWNkhidlpKdzNUOGRZOUt5VGYxdjhJ?=
 =?utf-8?B?WUNxbW1uT2c2TjZVa3JET0lRNFlKV0UrVnp3NmpzMmVOTmRFcmNwcVI3WEE4?=
 =?utf-8?B?eVVva293TWFKbFhsUVRPcU5zbm1vcjNybVJ4QkF0MWNVZ3lVUm5tRzhqL2pQ?=
 =?utf-8?B?T1doMjhEcnFKNnNiY0RPVUR5eENwajhhMm4yT09RV09MZkJZMEMyQ1hpVTZj?=
 =?utf-8?B?TlpiUFFkSHcwN3dQenMrakpsZnhIdCtFS3RYaUZyNWZPeDlVS0pDZ3Zwb0Jr?=
 =?utf-8?B?N21RY0JjckpXbFlXOWtqQXptUGo3MDNZU25oMUM5NXNoQlNzVU52eVpVbDc0?=
 =?utf-8?B?OVNWZ2tsb1lIYjFNZmRzTC9aamlaelFoWUR2MHRYY29Da1FvN242aG9NNGU2?=
 =?utf-8?B?UXIvRU9BQWF2UzgrRzBhaTcxSjJNRUJWVnNmYzFrR040VW5QYzlRQitNZWNV?=
 =?utf-8?B?czVQV3laVDdEc2dudEpJL1Q1cnhGVU82Q3Y0YTFxSlhFZE81Vkl4ckNVNkdH?=
 =?utf-8?B?Yk5rV0xiVDJZYTA2SXF5MnFUNHgvenhwenkxMUxsQU1kMEhMZDFYeXZVZ1Q5?=
 =?utf-8?B?TkpXWVcrTkJwdTdUSThkb0VqQStnSVFzZ1lEbjZ2RXVkenNvYjNqcUo2ZFFy?=
 =?utf-8?B?UElkNTQxREhTYzNRRFBWSVcwRm90YUtTaDQ1WkRYNWhibGVNQnhoZ0V0WE5Y?=
 =?utf-8?B?cmJjZ2VqSWM0OTNhRnJycDFCcTlING9EeWtZaGd1MWR6aEVTMkxzZ1FDOXFR?=
 =?utf-8?B?bExzWHVhRGdIbG52UnE2bXlWb3U1N1k0b0I2bVlzaGhpTUhtaU5iNTh1MUQ1?=
 =?utf-8?B?T1ZacS9NZEwxRHlVejlxTE1yd2tYZ2d3OUpnc2dCQmhKNVlQcDRHTWY2UVFv?=
 =?utf-8?B?WnRGV01nbHZvK3k1eGJJQkNIY2NSRFVYVXVZQjdIQm1oeU1ITEVhcXdVU2V5?=
 =?utf-8?B?L1dMZExNclFwdk95ZG9aSGsxTElvWDRlWEs0UTdXcHJlcUMrbDRBaHFOWTM1?=
 =?utf-8?B?aVF6ajRoZHhQOXpJMEY1M0Z3L2FybElqc29JQXo0SGVGQUZBOWpuS0owSlRG?=
 =?utf-8?B?MVFlYkJ5dngyc1NFWC9rNkI1aVVrRkJXRldyL1BvNEd0QW1FNmJpM0RFVmc3?=
 =?utf-8?B?TFhON3NEQTBCZUsvbUVzcDhnYkJ3aVk3cWRUWDRZSjFwMzdOK0RPU0RyNjZS?=
 =?utf-8?B?a0I1RUdrZHdzMmlKdEtOUEorbkt1eDUyM2NBM0pkN3VaTFZ1ZytoOXR0REF2?=
 =?utf-8?B?TXVvZFZUbVl6MjFFMkg0TEU0UXAvM0hSeS9TZmtXamR5empuMWNxNG44NExp?=
 =?utf-8?B?ODlxTkFUSUFBMk45OTVrL3lUd2t0QmFHQ2R4ZWg3UGlBY1NjWmlPR1JvM0w5?=
 =?utf-8?B?YWR0UEJueXpNNmtJSlQ3R0w2WlBuc091cThMSnBDdGVDeE5Hdlg2NFVPUFBs?=
 =?utf-8?B?cjRXQmx3ZjVmMm5meHp6SE1IMVh3V2JaSytxNk5QanFSKzBxZ2xlUUwwKzc5?=
 =?utf-8?B?NFdLNHVsTy9OWGZQeXl5OExxcDdqMlE4TGRhV1R2MHBUcEUxR28wSlZwZ1d3?=
 =?utf-8?B?SWVmQXRETzZ2Y1FoTkRTNnZ6SUJhY2dRZ0hMYVlXWFVlaXR0cVJIamM0aWhU?=
 =?utf-8?B?UFk3VjQzN080QkFkMDdtZjdVbW5oZDRDRFRYVEVQOEt5K21EejJ1TUR4Q1dE?=
 =?utf-8?B?WEVab2F5VmxaNVM1YUZqdmZEY0l4MHZUNG1DWFY3NW90aS9PRFBMVzlONVRK?=
 =?utf-8?B?bzlvbVk5ZDY1TW5ldmw4dkgya2Y1VTl3dTI5V0dqNjFzVmszNUFnRzBIdW5q?=
 =?utf-8?B?Nzc1WndyVWtHeHhBYW9yVjAydTliWTMzN09wZERVdkREbzhyYWVQdjFWUnpx?=
 =?utf-8?B?M00veDFzZThyYWl0TDN6QTZ5Y3hocXVPTzJkRzBucG5hQzIySXdSNGVHa3p4?=
 =?utf-8?Q?QSEQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf83df4-d1e9-4823-9481-08dcb44beee9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 06:09:00.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijufCQF3PqmtEn6c+bmAC6cbRV0zoBQdj8JmPdUosKbsk9vAuvHvni8lrjQSZqMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216

On 03/08/2024 7:26, Jakub Kicinski wrote:
> This series is a semi-related collection of RSS patches.
> Main point is supporting dumping RSS contexts via ethtool netlink.
> At present additional RSS contexts can be queried one by one, and
> assuming user know the right IDs. This series uses the XArray
> added by Ed to provide netlink dump support for ETHTOOL_GET_RSS.
> 
> Patch 1 is a trivial selftest debug patch.
> Patch 2 coverts mvpp2 for no real reason other than that I had
> 	a grand plan of converting all drivers at some stage.
> Patch 3 removes a now moot check from mlx5 so that all tests
> 	can pass.
> Patch 4 and 5 make a bit used for context support optional,
> 	for easier grepping of drivers which need converting
> 	if nothing else.
> Patch 6 OTOH adds a new cap bit; some devices don't support
> 	using a different key per context and currently act
> 	in surprising ways.
> Patch 7 and 8 update the RSS netlink code to use XArray.
> Patch 9 and 10 add support for dumping contexts.
> Patch 11 and 12 are small adjustments to spec and a new test.

Very useful, I was messing around with the RSS code lately and was
thinking about these stuff too, thanks!

> 
> 
> I'm getting distracted with other work, so probably won't have
> the time soon to complete next steps, but things which are missing
> are (and some of these may be bad ideas):
> 
>  - better discovery
> 
>    Some sort of API to tell the user who many contexts the device
>    can create. Upper bound, devices often share contexts between
>    ports etc. so it's hard to tell exactly and upfront number of
>    contexts for a netdev. But order of magnitude (4 vs 10s) may
>    be enough for container management system to know whether to bother.
> 
>  - create/modify/delete via netlink

And actually plugging extack into set_rxfh :).

>  
>    The only question here is how to handle all the tricky IOCTL
>    legacy. "No change" maps trivially to attribute not present.
>    "reset" (indir_size = 0) probably needs to be a new NLA_FLAG?

FWIW, we have an incompatibility issue with the recent rxfh.input_xfrm
parameter.

In ethtool_set_rxfh():
	/* If either indir, hash key or function is valid, proceed further.
	 * Must request at least one change: indir size, hash key, function
	 * or input transformation.
	 */
	if ((rxfh.indir_size &&
	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
	     rxfh.indir_size != dev_indir_size) ||
	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||
	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
		return -EINVAL;

When using a recent kernel with an old userspace ethtool,
rxfh.input_xfrm is treated as zero (which is different than
RXH_XFRM_NO_CHANGE) and passes the check, whereas the same command with
a recent userspace would result in an error.
This also makes it so old userspace always disables input_xfrm
unintentionally. I do not have any ideas on how to resolve this..

Regardless, I believe this check is wrong as it prevents us from
creating RSS context with no parameters (i.e. 'ethtool -X eth0 context
new', as done in selftests), it works by mistake with old userspace.
I plan to submit a patch soon to skip this check in case of context
creation.

