Return-Path: <netdev+bounces-182383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03CBA889A8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF1F17B11A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D73028936B;
	Mon, 14 Apr 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gGUwrz09"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F4284698;
	Mon, 14 Apr 2025 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651284; cv=fail; b=XZB9nIDrYo2YcrOaxADUWgw1e3vXJdJu0wu+A1RuUe+MJCwhi+a3uScM5Bw0kipxFwH5URYQ+HJ1GljthESRAHtvPS0n9vyNi+WLaQHR2E1ueyDB678+R5FOCn27aAKEcx5plY7h3FWXrP3sjj4j1bRJpbsEd4kyGaW/1p4zGzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651284; c=relaxed/simple;
	bh=KJ+J9+l2vkOPik6i41ybdddz2AQkMECqampdwt0efFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ly93JJ4rUbhi+YSsS+JC9h6veFnBmEN1o/cUndxIZXB5NUp63SOA51w0edNo04p3hHovAyJJbaoFp3K6D62KIknbFTBC1gx50QHP0BCV4kcvRvR53kuZHntHwZ4g8J8lOIOQ5KzWFP330AbwSsaav0Vb9WoGsC4AaeIFCC0odlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gGUwrz09; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hvyy0HIdoOSDzwIMRqvqS6uSGP/2ilnS1nf+j++7mcFlvcfOmKvrnHJbwK1pyboC4ubvhUJcIQMCvCn6NDJaElvgLPs4wVkpJcfh43YtaqcEuY6oESMZOmbWLy0NLAuYwprqiSXCsh8PnFr0L4gQYkmVgTB39W7Eu+dbTVFyaraZbaF7xyj1iX3I7dABU6jkN/JKKKbpeOnUTRzreT/qcT6nEKD8uR6Fi7EN3tw5iARfLZUoI/hZKWuO8gJ6aUSiSnacZVDf+r9paxS/ic02wxJFZYzL8gOl1z0b+YfU4+q/CrqnLipP5/yvXuYGJ5nup1pW/qx9BoX6M9SAX0smfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0BbBMnsb7Ea+bNWrouKGsQNI8QTtreT0WxKNOPs+e4=;
 b=Fp87G7ynZClPTFsYs0kF2Xy6u/0zfbhKWC0YsoK7SbJj/L8b+Ol6lo3x13llJINsTdPLG4p/gXWBPIKuksE5BQecyn+IOKqfqiHe2V4u58bAvvtEXmHu0SOHuq0k7DdBsAhCdO3cx9vp8AFDLMJl6nO3W1xK1/KhHI8pJE3+nLcNNMeGu2PbbdtCgRr2nD+CpdSQLpfYQM+5EsuHGXPqaB2x1Ui0CfY125N8bbih8YDzWhDxEhMMKt6I0EhfM7zUIZFM0EeN42lUk7OpMewBa6O7Hw4x/0rcaBpLfOINWk4Q3C1jXkSUA5ekBbrGakelmN7M/+Bgn+pYhU+y0QoDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0BbBMnsb7Ea+bNWrouKGsQNI8QTtreT0WxKNOPs+e4=;
 b=gGUwrz09bohnWTTuoLNLYC9IBnplgUbVJqUoGOTgCw9DEHgrsqwNNd1TkUGYmluXYeJc6dHc2B3sq+8q2Tli3Q2QamMGP/zOvv9iJfL6fLADDb5YUme0EXhNtuDbhG36Jj5F2lT1oubBaz2ZWADErA3Gb8XKfI05I/It7vOVF4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 17:21:18 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 17:21:18 +0000
Message-ID: <f3812d7e-5931-4ad6-b0b5-67cbe514fac6@amd.com>
Date: Mon, 14 Apr 2025 22:51:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] amd-xgbe: add support for new XPCS routines
To: Tom Lendacky <thomas.lendacky@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
 <20250408182001.4072954-4-Raju.Rangoju@amd.com>
 <f60f7f48-ae0d-2b16-6333-ffddb05ed792@amd.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <f60f7f48-ae0d-2b16-6333-ffddb05ed792@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce74736-2eb8-440a-da74-08dd7b78c4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG1pN1ZYN1FHVm41OUI5Tk1aVVRvWktJMGR5aVcrNVBhTXNNbXVtOFU3WlNS?=
 =?utf-8?B?dmt0Z1ZUNXh6dStXU0E4M1c2VmY2M3QxVkVkdUNyTVVoY0dPQUVsVm9EaTky?=
 =?utf-8?B?bzZxVzl2MWpsUmtsNHVmbHVzWDBNdzJuZ3RpU3VyaWU2ZHVGWnZNdDZFd043?=
 =?utf-8?B?WEtkdDRNMmpvN0JFS2hHcGVjVWUrS0V1elNFZEpydlBvbHIrYm9yTEo0UHlF?=
 =?utf-8?B?b2tMSTZoNjYzSHk2NklaVXIxRDFGbktsTTIvT0FkNjI4UkZRSnlpSEZnWWxG?=
 =?utf-8?B?TnFBY0Y5aGFxM1loSVE1dTk1dHMyalRqUG1zcXBHamJyYUp1Qy9QTjZqVXpN?=
 =?utf-8?B?VDVxQkRKb3R5MWtOVEl2WnpQNUlSNW9GaFQwVXlHM3BFNW9zZTJTdkp1K3kz?=
 =?utf-8?B?MlZCS2s5ckswRVhsN1haRG5URURMMVJJeGJvaVpUUnl6eHdVNnp3UVRzblZ1?=
 =?utf-8?B?YVE2QWc2clBrM2tRU2JKVE43cTJlRU81dHozd0U5czcyTm1vSkFuRTF4ZmMr?=
 =?utf-8?B?RDE0MElEWGxUUy8zbnovNi93ZEdrNkh0ajM2azMrVXlGUXhSOExCSHRCZWwv?=
 =?utf-8?B?ZEZDdHpMbGwvOTBkUU16TnY1L1NtcWtPYkNUSTFwY0xabWV2S3kvZWpoVXk5?=
 =?utf-8?B?amZOSWhNMHBHYVJiZG1qVmFkYnRlVWMweE5jZTFzU0ZYMWlFdUN5OXgvQmcy?=
 =?utf-8?B?VDN5eVNoakd2d2RtRVR5bTIrVGxtaC9sdVNIWU1uZFFoOTdFSUxJRGZpdHBT?=
 =?utf-8?B?Q3NoVzJ6cityOGlLN3VSd2dXU0lSVEFEdmZVYjAxZHRzTjJ4NEhyNHJQL3Zp?=
 =?utf-8?B?QUNDZ0lOY3FtWCtRbm5Cam5FaWZyaTJzcHErRU1rZWRLSk9haHRJRHFYRnQx?=
 =?utf-8?B?aG8rS0YwT2tQY3JwM00yMTNBaW96eU9iZk1Uc0E0ZzhyVDA1amRmeUdWb0o4?=
 =?utf-8?B?K1dtb1BZTHNBbUdWc3k1bFYvSC85M1pjTVBIYkdQZEFCa2d5eVBrOXNRUVBv?=
 =?utf-8?B?WjZ2UjZ6bnVsMkIwMVVacmVKb2hZWWpZRUdESkJKSGJZeWJRZG9OcDB6T3JW?=
 =?utf-8?B?cmhXOUo2UGRONERSaHh3SmgrOCtDaXJrSTRFODZhK21IUzJFRGhQS1JuNmdB?=
 =?utf-8?B?dklLZzdPeVgzRVVnWmFTYSt4VDhDQlBvUE9rRkhWbVR6T01Nd3pUQWJrRVdL?=
 =?utf-8?B?MlBVYWxJTVFCb0RsdjJOSm55VmtVNnMvTE15RHJ4TU9COTVEeXpxeTFKNzBU?=
 =?utf-8?B?K3VCRWN5ZW9GQnlydTFWdG4yRWVhbDgwN0hYc3BYeEVFUHQ4Qlh4dUVPTG03?=
 =?utf-8?B?Y2krKzYzU3dhMVlmU0hkZEZTQys3a0hib1BjaFp1SWk3T1NHN215bFdPalRD?=
 =?utf-8?B?TlA1aGVaYTl3SUM4Ym9IUWdUanRTZlpMWFI2Mncrakh3TS9GVnNRZkZzMDQz?=
 =?utf-8?B?Yk1GeEMrbVVPdUkydE1aNVZaOUs1bzRjODY4bHBYemxzK2NpQlNzOXBzZFhu?=
 =?utf-8?B?VksvdnpsbUpraE1lRDlrK2swMS9uZkZkcEZNNHJuaEFLdUUvTDROWURUK08z?=
 =?utf-8?B?eDhxTTNleWFpZDR2MnYya2svTXFoOENZU04zWmRwZVhNcnJlbFBoZG5wU01T?=
 =?utf-8?B?NzdLbEpIUVNEMjRBSUZZc3h2ZnlHcDF3aHQ3YTlKWGs5bFNlRnoyNlYyYnVB?=
 =?utf-8?B?blZKcCtjRUt4VjMybW9Kd0FkL0Jaa053VU04dE5TckRwWFBUTDVldkdmWERB?=
 =?utf-8?B?aEdLcGJmOEdrVVFQR3RLTWpEY2p2YnRRZUlJbmxCOWNIQUlRYTRFWU4weXpa?=
 =?utf-8?B?TkhHN0JxaEp2NUUraVVZRldvNXhQTUp5NHVpTzZHRkt5bkllRUd5QUhzT3dx?=
 =?utf-8?B?RUp4djk5TVgwS0xnbEpGNTU1WFVGbGFMRlBVR1ZNLzY5dUlBemlTemRhbno4?=
 =?utf-8?Q?AYfMbvd3SGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1ByVWxNN2V0Z3huZFRtM0ZwNGNlS0dKVHR2TkwzVXR0MCtHdFFxUDdnZVY2?=
 =?utf-8?B?R1VEVlAyZUp0NVM5NnRPTWhSMkFhdUU5RDZTV24zYXJZNFdYZWI2RE1yVGZs?=
 =?utf-8?B?cTlYam1OcEx1UXorYlRZK1pIZU9wWFYyUnplRjRyQnNpOGhPZG8zT1JYMndv?=
 =?utf-8?B?Q2hud09GM2ZCWkEwd3JPOEdmVG5sc2R3QkRNUWxmVkpoSlYrUDMvMUtHekgv?=
 =?utf-8?B?WFk1bGFYQTh4eHZmQWViNStFK3MrellOM1F2UHBDcHVmeGJ2MkFvSkoraW5S?=
 =?utf-8?B?dXNBR1BrNk5palYzelI1U3dseXZsK2VBeFg3aFd3OGJDQ1lndW44eU4zVXdZ?=
 =?utf-8?B?cERrdkRrbDFwUHI1c2piNE9DTHI1Q1pycXd3VUMxWmRyclc1RGdneW5PczZQ?=
 =?utf-8?B?V1dVZkF6R0JyaW5SNURkUlJ6OW9PU0J5ZFZ4TUs5OTlnYlpXU0crZ2c4aTJZ?=
 =?utf-8?B?NE5JWWR2S1YvdllQNGE5N3dxVEpPNGFKTk56TXBpOTNndEx6MXRCOXUyMmQv?=
 =?utf-8?B?bTNXRVZkMGFwdjlOSURlM0dUS3NnOWhSYVYxSjZZdkhzTWpIOXBHRnVCalBS?=
 =?utf-8?B?ZFB0VWMxbTFvcFliMTRjZGdwY2NQbW5jKzNUNFA1UVJuZ2xieS82R0xWTTNK?=
 =?utf-8?B?N3MyQnoySVJubkZ0bDNvY2NpZi90WEdQR0dROHFsV3NVUFJZM05xODNPQ21w?=
 =?utf-8?B?bVdoR1o4bHdLUnVHNW5hQVBFNWloN1p3K0FDTmVWcDk5Y3RTeUJIQ0FUb3hv?=
 =?utf-8?B?a1VtOFA2bEF2MFdBVkN1NmlRc0hhL0tkZDIrUEtGYkl5dnBRTlJqRVlCVVc3?=
 =?utf-8?B?Nm9jSkozN2hoTXJlN056YUF4WkFZMTFGNVJJanZwTDVFb2pBMnE5ZkpCUU9W?=
 =?utf-8?B?N3N6NzdxR1dueTZFUGw4VWwrTzRjZ3g3L1dPL3dGNnJ4a25PMzFYY1hvS1ds?=
 =?utf-8?B?VjBCazZsdEFTaE81UDIvbCtpN3hNaHVYd2xmQnBVYlRySERHaTVPZVNRSVQy?=
 =?utf-8?B?NlJWNlBwZXRON1pUWlR4WWE0dElDeDZ0anR4UENCaU5jMWY1b3dHZzdJQjdC?=
 =?utf-8?B?Y0hGd3VHR0U1NkJUaVJITTdUWU9TWkpIUmRzTG9RMkxzMHU5ZHllVS96Sm9r?=
 =?utf-8?B?SUlTTHg0ZFNPMEV6NzY0bDBlbys2bDVtckZEcjl3eHFPd0NVTFBValN6ZEhM?=
 =?utf-8?B?VVVBajlvdmZZZWJYMXlXYndCZkVEWkxSWDUzRTZWNDVtZXRKMmpoWS95ejlR?=
 =?utf-8?B?d2YyNkRDaEkzNmgrTDdKSGlTT3pnbTAvWVYzMjNuaXdYbWZ0TWpSUXY0Rkow?=
 =?utf-8?B?dEUrOURtajM0OGMyaGl6OEdWdFpseitKMXk0bUxZcEZMNDZEMnYydjdSNGhY?=
 =?utf-8?B?YktQZkpOYXhhRUZac2lqT1lWNVJxT08rVlRDVWxVMno4TnVBNDhqdDZiZks3?=
 =?utf-8?B?MmFnSXNWWFJ2RUJJNU5IM2dGdU5HQmdPVllaOWRtZDFkaDVDQk0wam9ZWFdP?=
 =?utf-8?B?bytaVlNNcFpRd0Eyc3ZWSXo4V1BuVE04aWpsM1UyTG5rRmZLSnNxSVkzYll4?=
 =?utf-8?B?Y2kwRTRyQm40eWxqRDVWajJjK0pBU2lHbUtTaWgwbC9mNFYyR1Q2RXVaWXNi?=
 =?utf-8?B?NmNFRkNUZERqZU9vUU82b21sU25GUzJaRjF4M0hwT0xHSlY0YWtyQmtKeWVO?=
 =?utf-8?B?clAxRHJnVTJDdFlkVlMzaGx0bFM0YmE2TXA0YVQxVkxaR3YwZDZVZFg2aFhO?=
 =?utf-8?B?ZHZMSEV6Y2hsYmFzaHkydmh4aEl4eUZYLzVFUE02OFBwQkJoMVZqTDRhcmtT?=
 =?utf-8?B?NFQ1dEdnb3pFQXJwamdmaHN5WlhNR2dwUnFWNStZbzhaT2d2SjI2QVZnZFlh?=
 =?utf-8?B?MTFzeG4wOEpqdW5yWVNEc2p2cHJ2OEhFbS9iOWN6WUNLcG9xdENUL25XbHlw?=
 =?utf-8?B?QTFBc1RKNmZNNVpJNGNPNDZRSEFxbGRrbnhmSG5pM0xQTGRDSGNNSkhqcFpJ?=
 =?utf-8?B?MmpoQmtrT2VMdmVaY1dodmltRTJlbjNtZ1FUR1lZQ2JEbFlaYWJJUm5ydllX?=
 =?utf-8?B?Z0U1dm15djlkRGdSdzAyWTI2VGZlWllzdXhWR3pDL0xBNDlESU9LK2pucTJ4?=
 =?utf-8?Q?kTx+RvYFMr3jAkkk8ENLDJ5Fa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce74736-2eb8-440a-da74-08dd7b78c4b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:21:18.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXgWcILrW0EU3WJNG4ICG/oKwzpcP5qAa2LYctKPg2KneyTUQ0Ms34yR8upvvRr7B2C6MopJ1kwx37wmfQMnig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849



On 4/14/2025 9:11 PM, Tom Lendacky wrote:
> On 4/8/25 13:19, Raju Rangoju wrote:
>> Add the necessary support to enable Crater ethernet device. Since the
>> BAR1 address cannot be used to access the XPCS registers on Crater, use
>> the smn functions.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 79 ++++++++++++++++++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
>>   2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index ae82dc3ac460..d75cf8df272f 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/bitrev.h>
>>   #include <linux/crc32.h>
>>   #include <linux/crc32poly.h>
>> +#include <linux/pci.h>
>>   
>>   #include "xgbe.h"
>>   #include "xgbe-common.h"
>> @@ -1066,6 +1067,78 @@ static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
>>   	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>>   }
>>   
>> +static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>> +				 int mmd_reg)
>> +{
>> +	unsigned int mmd_address, index, offset;
>> +	struct pci_dev *rdev;
>> +	unsigned long flags;
>> +	int mmd_data;
>> +
>> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> +	if (!rdev)
>> +		return 0;
>> +
>> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>> +
>> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>> +
>> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> 
> These PCI config accesses can race with other drivers performing SMN
> accesses. You'll need to make use of the AMD SMN API (see
> arch/x86/kernel/amd_node.c, amd_smn_{read,write}()) to ensure protection.
>

Thank you for your observations, Tom. Initially the patch series was 
using AMD SMN APIs. However, there were problems when accessing these 
routines from atomic context.

> The AMD SMN API uses a mutex to sync access, if you need to protect
> these accesses with a spinlock then you are looking at updating the AMD
> SMN API, too.

I'm working on updating the SMN APIs to use the spinlock to allow access 
to these from atomic context aswell. I'll submit that patch after these 
patches are landed.

> 
> Thanks,
> Tom
> 
>> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
>> +	pci_write_config_dword(rdev, 0x64, index);
>> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>> +	pci_read_config_dword(rdev, 0x64, &mmd_data);
>> +	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
>> +				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> +
>> +	pci_dev_put(rdev);
>> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>> +
>> +	return mmd_data;
>> +}
>> +
>> +static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>> +				   int mmd_reg, int mmd_data)
>> +{
>> +	unsigned int pci_mmd_data, hi_mask, lo_mask;
>> +	unsigned int mmd_address, index, offset;
>> +	struct pci_dev *rdev;
>> +	unsigned long flags;
>> +
>> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> +	if (!rdev)
>> +		return;
>> +
>> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>> +
>> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>> +
>> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
>> +	pci_write_config_dword(rdev, 0x64, index);
>> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>> +	pci_read_config_dword(rdev, 0x64, &pci_mmd_data);
>> +
>> +	if (offset % 4) {
>> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
>> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
>> +	} else {
>> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
>> +				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
>> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> +	}
>> +
>> +	pci_mmd_data = hi_mask | lo_mask;
>> +
>> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
>> +	pci_write_config_dword(rdev, 0x64, index);
>> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
>> +	pci_write_config_dword(rdev, 0x64, pci_mmd_data);
>> +	pci_dev_put(rdev);
>> +
>> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>> +}
>> +
>>   static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>>   				 int mmd_reg)
>>   {
>> @@ -1160,6 +1233,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>>   	case XGBE_XPCS_ACCESS_V2:
>>   	default:
>>   		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
>> +
>> +	case XGBE_XPCS_ACCESS_V3:
>> +		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
>>   	}
>>   }
>>   
>> @@ -1173,6 +1249,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>>   	case XGBE_XPCS_ACCESS_V2:
>>   	default:
>>   		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
>> +
>> +	case XGBE_XPCS_ACCESS_V3:
>> +		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
>>   	}
>>   }
>>   
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> index 2e9b3be44ff8..6c49bf19e537 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> @@ -242,6 +242,10 @@
>>   #define XGBE_RV_PCI_DEVICE_ID	0x15d0
>>   #define XGBE_YC_PCI_DEVICE_ID	0x14b5
>>   
>> + /* Generic low and high masks */
>> +#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
>> +#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
>> +
>>   struct xgbe_prv_data;
>>   
>>   struct xgbe_packet_data {
>> @@ -460,6 +464,7 @@ enum xgbe_speed {
>>   enum xgbe_xpcs_access {
>>   	XGBE_XPCS_ACCESS_V1 = 0,
>>   	XGBE_XPCS_ACCESS_V2,
>> +	XGBE_XPCS_ACCESS_V3,
>>   };
>>   
>>   enum xgbe_an_mode {
>> @@ -951,6 +956,7 @@ struct xgbe_prv_data {
>>   	struct device *dev;
>>   	struct platform_device *phy_platdev;
>>   	struct device *phy_dev;
>> +	unsigned int xphy_base;
>>   
>>   	/* Version related data */
>>   	struct xgbe_version_data *vdata;


