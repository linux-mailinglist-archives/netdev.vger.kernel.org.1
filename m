Return-Path: <netdev+bounces-206416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CECB030C8
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1143B3F71
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8AF1A01B9;
	Sun, 13 Jul 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EAp5L7Y5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0312E371B
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752405030; cv=fail; b=iMzIuOJ/KZVu1FExdtZ4VmCcOglTpLt/s/NX4hjMQ8cOawVFaJT5X7hTwwBGi0EfvKEmAHyetJp7VDVOdxH+gN+0LdS350XdZ+E7ICmb1YP9LF/QGI9+cZzp9XD4xvDj/wMfOE/iJtZv5A5gyhJPnzLTkIosY+RkliaTE664A9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752405030; c=relaxed/simple;
	bh=dVMh0Q/ginFGN5pXT9pmKxzq2ddK8AfmOHifWyWj94M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fqSSxj6kR363HTOefMutucIloSqH4QM7MGgi2lAAGH1matP3jx/rDbnK7GdwfHYso9nP1nuOaMH6C2txz8aLy7jXCXJzH+4bPz0hEI/LJx8LWtNl2QsWgi4J88vnXX092lC8Yc7pwYhNA4yT3zTSu5bx63PDUSWidROtKC3YfX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EAp5L7Y5; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+2N9GMfswl32Nfva4Hkt6e9Z8Z7ucko+qFgS1Ru9UVGWpLXWpmuZYYvsgaZY1SfbzA9Q4Y5SkuaDvQjBX+Nbw/6yp3CB2Jdky7q2Cr3itbl8AIZHLD2qiFfFFUSrYHcLxfhapqfVSrxS/ecjF/2sYoy7qwkJtHXd24qax5cOzMvRNzjx+1BFtVj67A3Qj7MamdTCz57Wap8WzXS9cOw7/6SS/xlmvgCqlrgy0BzUszzZoqshlAmxVKeWefEORttsS/esdceQ15Su7+KsmjtPN7IGctyOpgrsI7Ko2sMFgdVdyZJqN0/V6q8vn2qbbm841V/oZe330UZjCCJExhScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i5KQCjjAxAxKx/I9h85IovC3ySgI1IWO62vxnDSL6k=;
 b=YsJdPKTsLQoSgdzQGDwo4FW+uiizoVmTeBjfOh/qYTUAhBSAsPD5pHV1Zt+qh5PIZn3xCJqhVYCPWIeZ1O6Y/OS/s5531X5VJhOZPRONZo/g1qPZL+rBYgdflCnY4AjAi3FSeiTbo8fkVIZxhgRc+fV0TNA2PMw9rS1sT8A6A1wSpB+hLSQBvwUDHqL0fU35GrLH/9HubKTIkwGdwcBxk6zpb6APdA8vj+6d30ij4AHiv370J+b9I7ug50v4BTXacFWw9uVqw3ubh4WkYCbKRy3IM3klQO5VdePYPBfOUb3WZnP1DmKILOjnu1M3U+HhCAcyyqiopUcNwZw+2kwZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i5KQCjjAxAxKx/I9h85IovC3ySgI1IWO62vxnDSL6k=;
 b=EAp5L7Y5UNkfF+iuHlyy6tqbdx9wLu2tMtXju0R4oDJgQn3Cm/mLInMyh6KCFF/tN2gHAHh8h9F2eWPdcGspNRy1GX4vvBXrbOMWanM9F6RHF1yADTBMVYirycdLswApLZ4lU3ZexhkyIRYUF9+yGMmDHZDWQ5FHpxUFWzzq5CcC2b9mu6n6WRMTOobNS6TwVdYnRAwHapCVWFtD5m/HKKUqiliaeJwgzRGHITCkvaGmEIaJ69MBsaZYINAdTJeq9u59Cs2Y9fPzLbVRiXi5o0tNjl+1xb0xL0VgHqDJZ1vCzQUGNUM6VBXM4aQXA2ku2SCUx4yiqi4y1RpWbyQ87A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 11:10:26 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 11:10:26 +0000
Message-ID: <5686fbfb-4e47-48fd-93f9-25443aeb1d89@nvidia.com>
Date: Sun, 13 Jul 2025 14:10:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/11] ethtool: rss: support setting hfunc via
 Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-6-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250711015303.3688717-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: e91994c8-a2c0-411d-2ef5-08ddc1fdded1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmttaVlWYXYvbkRZbEhKUTgxVGlHaFVNSXJSVEFRMyt1eGJURnZVbHNXWjdp?=
 =?utf-8?B?alJUVXArdG9aME45TlB1OTZkZkVOMmJJWjhlUmRtQk9FeUQ0ekZGSWU5Mk8r?=
 =?utf-8?B?YmdPckJjRnorQTJxckYwSWZjNDI5aFo5c2pTTTNSR0NvSjFubXJ4UUdKM3Ar?=
 =?utf-8?B?SXMrT2JkVThyUXdjaXBWWUt2Zk5yOG0vNEwzejk0eWVYdk9JKzR5bXV0VUZL?=
 =?utf-8?B?cEcwTUVoZm5kZVRraUFoSUZmS1k4c2xXeDNoWVNlZXR0cEZRT1huUUtPVzRx?=
 =?utf-8?B?SVBLalEwTTFUby9TL3l3eDhyemJ0YzZiaTlUQkwxdERmSWtMc2xBcCtWSVdl?=
 =?utf-8?B?V0crY3A1T0tnT0MvblNQRnRSa1pMSjNRTTl6eUJTS1ptOWdwUnBCcVM2MDJj?=
 =?utf-8?B?bmlXeUNUY25LTHRDM1diRW9BVmRVeVRzRnVraVVDakUza3RQYTBvKzdxQVYx?=
 =?utf-8?B?U0pBYjJuOGNkeVg5aUE4WWtrZ1h4dGJFblRqbGlFQUV3b2tIVzU2VnZQUGJI?=
 =?utf-8?B?VDloSWRQRzZYV2R0eGZleElpaTFVRnFzSDFTVkF0RHh6QzhiUXBCT2hRRUdW?=
 =?utf-8?B?L3VJdk92OU0yK2JYTkhhUmtIQ1JuRDJ2UzUwTE1TeUxBbThkUk15TVNVVHpu?=
 =?utf-8?B?RE1GRGluanBiSkNVb2o2eTlxMk5RN0xsRlhxT2RNSlV5YkJSSHlkTEkzdzh1?=
 =?utf-8?B?TDd1bTI1ZHQ1L0ZXVlhGZ1Q3UVJId3haL2JKVVZoRGRYZklGaUFzVDJBdlJR?=
 =?utf-8?B?V3NrTDZJOEhaTHFEQWtzQU0xbDJEYU9RMFZlUDI1WVZJQ2V6a2ZUdFpFL0I5?=
 =?utf-8?B?UFN1Q1NTVDN2SmpxNnhKamkyMnVxMHYvWStaZnd5QUZjMmVWdHlnZU1yZkty?=
 =?utf-8?B?Zy9DbFR6dFY0OGUvQmxBMy9FWGExcDA1YlowVHpBQ2hYY0FiRHljbGFac09x?=
 =?utf-8?B?S004cmUxeVprU1U2bHYrYStaTDFTcTR1VUpqYWprNXU2NW94T0poOFJuVndl?=
 =?utf-8?B?UzcyaHJiSkVuYkVuUTFteWZ0cEYyNVlkUjhtcGRmOHEwT1VjVTRTZ0ZGVkFj?=
 =?utf-8?B?TThpVG9XblZDN0pFRlIrWDdrVytyVmRjMkNDWmlUcmI2WUFPU2Q2b3VJbnRG?=
 =?utf-8?B?MjdSZHlTWkMrOWxJVis5Z0JUOUlYVEphc2daYmZlVThwUzJaakNTME90a1VM?=
 =?utf-8?B?Wnkxamd5QUZVQWlKbmdzVzZwN3JkakIzNWFvbmpjendQN1JsWGFkM09TdHlR?=
 =?utf-8?B?TWVDYVFUS2p6YVYzcjFKb0lEaXRUN3BVVnkrUlc1U3BJdXZTMWpkQk51TkE3?=
 =?utf-8?B?VGpGeDkvdFRPUmp5V0VFeFBXUitRWkFjd0Nyem1ESC9OTzZoUndqKzJBZGw0?=
 =?utf-8?B?NWZQc1BteHloQk0yTDI0Tm03NUtYNW1ZM0JDVUQxNE9NREx0OUFtQmljR0lv?=
 =?utf-8?B?Mjk3UnNwNHl5dFpYaTA5Mm1GN1ozVWRRbnNlbzB6UmpMOFRsUDQxUXBYbXRD?=
 =?utf-8?B?V0xhZ3F4cUNZRUpmZ2R4WHZjKzhWenVCdEdsdHdyWXJGdnJYQUZONHF0dkQ4?=
 =?utf-8?B?NzJqQVFRY0NoUlJlRjVEcEhKNVh3a25jNCs0dTE3blRXL0VtNTZTSk4weWJs?=
 =?utf-8?B?N0VaODFlZUlSNWl6dzdXREhEVkorOStadkg5UkNKd1RoVlNueC95cytjNjhG?=
 =?utf-8?B?YnhoQUhYcUhZNlE3SllzUkxLRkVla2JYekNIK1pYOEtJcVgzaTlZdWwyc01M?=
 =?utf-8?B?bDZvNCtEVm9iSmorenlrMVQrbkpVNzVRMjJUOTA2YWRkUTNDSmR0eWtSTXd0?=
 =?utf-8?B?VkxWanhjL2FUWkl6OFlOOFEvZjRWT2ZTdUZZQTBwVTRMVkYyRitjaWZwTVJk?=
 =?utf-8?B?bWpOT3o3Qm9VMUNoNUZDTU5EZVNmUjVOR1ZuZkJOdlRiaWdxYVUwekt0aWNG?=
 =?utf-8?Q?sXV2byOImoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2NIODR3Qm1vWnNYdkdqVGVCSTNCTjE4anhvSU1NUnFFN0pGMG9DNWE1bW13?=
 =?utf-8?B?WFFJdFhVTDd5WGFuNFh0bURBNkxYcDEvVW5xZmJWSVFFM2NhQUtybDhZTjRS?=
 =?utf-8?B?TW9ZeFl5byswMlFjZGNEdzRoNTR1eUNSeEw3NmRlbjhVTElldnFGZnM0RUNy?=
 =?utf-8?B?bGxCQ3pzSlUzNXRNZ1JqTWx3NU55ZG5oK0Z2MWxoaFpQTUhqcjNRdFlHNlpn?=
 =?utf-8?B?WmE1b1ZSQ0xVTlFFbWNtV1ZWK0JKVFhDUFgzRkxIU01IOXNBZ3J2L2o5WExM?=
 =?utf-8?B?QjlLOGNsNnRtbzZQOGFWTVN4aDNmeUpPd1dmTGthSUdBVXl5NFZVRHdtWVRz?=
 =?utf-8?B?NngyVk43K0R4cGhWaHJ2ajBpc2ZaRWg5K3NRTWxLc2p2bFBMT05BQi92bm4v?=
 =?utf-8?B?SkM0S1d1YlRkcm9FTWc5bDQ1SklwVUlZZnJCWTQ2ZVFPYWsyb1I0VFViTTg2?=
 =?utf-8?B?VXJUckhOSDFyTTdyaERSWFh6R2NCVmZ0RDN5ZTJUeHVZcGpkdkFmcEYrdGR0?=
 =?utf-8?B?VFRhcUdNSkR2eGZoRlEycUkzR0FkT0hsUnMxNkJWOFkxMGMxT3FVd0UxemQ3?=
 =?utf-8?B?YXM2ZDNBV0lWeU1iYjhDMXNBbHVaT1JKV0FhKzR0dXBtVzZLUHRQc0x5SnJj?=
 =?utf-8?B?ZUZRaUk5bWp0QVE1ODE3bE1VdkxCK3U1N2FSSDZjK2hOWHZIV2FFc0daMitK?=
 =?utf-8?B?N3Rwb2M0M3l0M0h4OXpqTUdzbHU2dnluUTYrYk0rYmNzeXV6MGtDcUhUVUVw?=
 =?utf-8?B?MGltcXByZ2pldURmbkJmeFZJeFgrY3VQeUdEdUNoMm5paTQ0M2x0cStnYVZa?=
 =?utf-8?B?Zi9yYXhBVHovV3E0d0srMDdLak5wcDVVMUJQaHlUYkRlak5mSWN4bHVCSmRl?=
 =?utf-8?B?cjBKcGo0ZkJmU2hIZmxWdWx2L0ZaZWp5K09QQ0pMSCtqQlRaZHNaaEJpSXNi?=
 =?utf-8?B?eTI5NWNDTnVUVDBGeWRoWnlmWUpBaEE1K3hFUzNXY3dIeHpNOVdtWm44TDNY?=
 =?utf-8?B?RkdKMHp3SXJZM2NVMjNFUUlKZ0RvbDJQcVZPek50U2lLSmhrRkczM0xqT2w5?=
 =?utf-8?B?T0RzZHBsd1NzRlpmK1lhQXRZWktMcWI3b01ZWWlLMGVGOUEvYWE4RmVrWWc2?=
 =?utf-8?B?NVdYeFZpaXpweWcxQ2t4cUxmaXdrSW9CUjFobUI0UHhjQmxDcnJiU3hsaDVl?=
 =?utf-8?B?WnF6SUlGTzlmQ1hQaHgvWkcrNjBvVUZTb01sTHFKS3NnNGtXdXpEdVR4eXBI?=
 =?utf-8?B?MUd2SWhYQ2NRTy9NaEgzbnB4MjlBbzkxNFBRL1h5dTdocUVLY001YzJ1UTE3?=
 =?utf-8?B?cGR2NjNwMzNQc0E0cGRnd0tuWkRpeFdZb25uUzZXWkZHM0s0ZlZKdjB3TjVX?=
 =?utf-8?B?NVRtR1RwaVFxcWs2bTdxR1A3VFR0bjY1aEo0S0R3aFp1TlpQWkJLVnB4UnAy?=
 =?utf-8?B?QllWczUrblZTelRUNklUSGo5VHB2ZnMvUW9GMUxiKzdzL2JRcndORUk3bkpv?=
 =?utf-8?B?QWpHWjdHc0ZkaHRPUlVMb2diQW5QU2diYUorQkxHVllJZUlPNXV5OVhGRngw?=
 =?utf-8?B?UFdFZ1BwMUhJOGdTN3ljQkhKQmwycXZFSmhaWTBqL2tvbkpUV1hOMXE3bkc1?=
 =?utf-8?B?SlI1U0tEM293b1FyaEo0YW1ST3BPSktOTnA0c3R2YmIrMHAyN1lxU0h6MHRn?=
 =?utf-8?B?QkJyZGZxeU9mK3NwQnRzQUZZb2k2NWlBaHgxaTVLNUd4VytNOGc5YVpZS1J1?=
 =?utf-8?B?NWJoWUFkQnFpc1pudFgxUE9xekEvS09GdkkvU3FvblkwL1pHczFHd3FXUU1P?=
 =?utf-8?B?YWFkOGFPSWRTKzBqYUhFbW1BMHZvVStEUlk3YVVEMkk1Ym5WbWMwZUc2cEtv?=
 =?utf-8?B?Vys2NUozMU0zYWROTDYzQXhUWHpDb1BsV0ZaVkRYSHR0VDh0ZkpjODEzdjZw?=
 =?utf-8?B?bDdvKzI0UEw4ZXQzM2VkQ1JKVXk1Ukd6VWNyNWIyVnp6cFVuYmFYZU5OeEZL?=
 =?utf-8?B?aE5ZaHFQRFFvWXM5cnhibnFXdUVIcmg1R2lYQlZuSnUzaDZlcmZDM0ZGWVdB?=
 =?utf-8?B?NG4xSVREU01RSTh4SEVRMkNML1BEUFM4V1dFSFJ5VjVVc3RSVFlBVWFGeWVQ?=
 =?utf-8?Q?O6e8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91994c8-a2c0-411d-2ef5-08ddc1fdded1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 11:10:26.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+MmuSv86B227YOOOmDV5zX/joBoF0UfeGMWrPezc/DaKq0TOZD8+nsED8YZz/Et
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

On 11/07/2025 4:52, Jakub Kicinski wrote:
> Support setting RSS hash function / algo via ethtool Netlink.
> Like IOCTL we don't validate that the function is within the
> range known to the kernel. The drivers do a pretty good job
> validating the inputs, and the IDs are technically "dynamically
> queried" rather than part of uAPI.
> 
> Only change should be that in Netlink we don't support user
> explicitly passing ETH_RSS_HASH_NO_CHANGE (0), if no change
> is requested the attribute should be absent.

Makes sense.

> @@ -487,6 +488,9 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
>  	if (request->rss_context && !ops->create_rxfh_context)
>  		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];
>  
> +	if (request->rss_context && !ops->rxfh_per_ctx_key)
> +		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HFUNC];

Clever, I expected an 'if (tb[ETHTOOL_A_RSS_HFUNC])'.

> +
>  	if (bad_attr) {
>  		NL_SET_BAD_ATTR(info->extack, bad_attr);
>  		return -EOPNOTSUPP;
> @@ -586,6 +590,8 @@ rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
>  			ethtool_rxfh_context_indir(ctx)[i] = rxfh->indir[i];
>  		ctx->indir_configured = !!nla_len(tb[ETHTOOL_A_RSS_INDIR]);
>  	}
> +	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE)
> +		ctx->hfunc = rxfh->hfunc;
>  }
>  
>  static int
> @@ -617,7 +623,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>  		goto exit_clean_data;
>  	mod |= indir_mod;
>  
> -	rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
> +	rxfh.hfunc = data.hfunc;

What is this for?

> +	ethnl_update_u8(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
> +	if (rxfh.hfunc == data.hfunc)
> +		rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;

I think that this is a distinction that we don't currently make in the
drivers/ioctl flow.

NO_CHANGE was specifically used for cases where the user didn't specify
a parameter, not for cases where the request is equal to the configured one.
mlx5 for example, performs this check internally because it can't rely
on NO_CHANGE for requested == configured.

> +
>  	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
>  
>  	mutex_lock(&dev->ethtool->rss_lock);


