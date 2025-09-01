Return-Path: <netdev+bounces-218707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D89B3DFEA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EE71A807B0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE730BB96;
	Mon,  1 Sep 2025 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z+pZy80z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1E2FF64A;
	Mon,  1 Sep 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721818; cv=fail; b=FTPl5MIt5E5n10CaAEepA3piDa+vYyc6/OR6Kd1B4W1nxAJ9VIpXoPLBHUtmwtnqdTx1Fvj7VKvPN8UYAiJQ4MVi4yj9Mh/MlVgrEEH4P3qsjrkCYNxUDqEZPK11TIGGJ0GfDegA6vb6w8epdx1hqCW3xYEfnSHzDQ3YsrTxpow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721818; c=relaxed/simple;
	bh=oB3IStce23ewL4jg+TRMYaG3DpaswK4fIEjWys5pTnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M7+ztX9kLsTf/O/DIXAqzDTn/cty/BgAdW92/PLr57Hq1BoYQSi38IR/fADyHKks6G+cGufEcBAUTJqOwSo8Yhq1hk57rz2XMWQUtR3f1NLc2fFLegJ2ThSm9BpJIY9eYDGP3d0hz5deFCxsBonTEtXwQCAg5eB5Ue9eQtn8jJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z+pZy80z; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnYL+KaeWiZAbj2jsNRZTSr1O2WXEyDkiJDubxdJoTo3Z2KTtsm1NR6/cURzQsWDZMHZZHwMWdntAPd7uKi+hBM51PQN1K54+tW4qitsdwTpRdp8AGdJTT0c3kpSReKhqfiA6uiDhK9vsIiashq9BRVQoD1prqEONzuJN0v3fCBoE5ElxbLq+QSLx75EMcLN+Ee6I1iHhvw2u9xj0Sea8TXp5r7peQuq6JvaOy5jPe6d50Gsm7zRhwDGK4XG8qYiNyxSQUiz7nw+InUEPjpRdhSiaEjsGxUWpj70QjgA2m+FG0HHAaRjNieF5gv1Oiv3HYHuYqg+vvcTQQlziKn3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy+Mgnd1lljrua6erreeNd3HSwXdhLbBBBfUW4nUz+s=;
 b=i0ZcLCxeb95iwlVLBrZql2pJyddT8F9bQoxk5dNLAPC/TL3XJvJp3MPKetQ8znlTBGCQzc84LApIzsUD3zcuu2S9wwG1/cVB9d5vSutXQak4cvGATXEX/TN1TJz0Dol9vV5E9b5gZ005iKH1Cd9YUC+gc/Uy5AZQIrGO3pkjg+Jt/I/lPhDpjcULBhYFBdtBmAvBpsEm25QHMu+2vKSZWxW0JJUT+oIZxr0TcBbQZfUKYP7sY8InXJKiNORLEBOW37jIBiWF3qBYEjvjERXyR4NqmI68rKZBTjAA9V0KOquq2/rwclc9yM0IcqZRmf1+jdvR8ehMCOhRvN0arglLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy+Mgnd1lljrua6erreeNd3HSwXdhLbBBBfUW4nUz+s=;
 b=z+pZy80z1Jxi35//wZCoGiLayXDMgr4Zosrm3e3R/qyrveT/SHkZDcop+S5GONdksLIC+z9P8ab1uw4raokV7w2UGpCttBN4RwpB0ePC/I3ksSWjk3ACTaJxwci6j3sbuNu64/xMCaPoXh8y1oyoBxwpMS8/K/3rpacI8TB0snE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 10:16:54 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 10:16:53 +0000
Message-ID: <dbcbcd58-855b-4466-8026-7088e9fa8ad8@amd.com>
Date: Mon, 1 Sep 2025 15:46:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] amd-xgbe: Add PPS periodic output support
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20250828092900.365990-1-Raju.Rangoju@amd.com>
 <c3d549db-bc7d-4b89-bc30-7fd4ec6f20e1@intel.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <c3d549db-bc7d-4b89-bc30-7fd4ec6f20e1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c38618d-87ee-47d7-3196-08dde940ac43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTFHbGpLRWhTQ2hZMzQrQzB3YjJXak9vT21MbTU3TXhNQm9VZ21vREp0Unk1?=
 =?utf-8?B?WEw2dmlUbWF1WGJ4MlZpYXB3eHA1bkc5aW5SRXBmMEZVd0dEWlV6MS9oOWkx?=
 =?utf-8?B?SGxOTGdSQy9nL0ZiMVlhNmc4SURSR1pNeDFiZkhmOExBUDJTQWZqU2YwRmpY?=
 =?utf-8?B?cUNvNGF6b0NQc01JalROQkFTbVhzTTI5TkMzd2FqYjlUZFdXb055OWYwa2pp?=
 =?utf-8?B?VkNlZ1FjSTgyMWxmZFpScEY1U3E4OHArLzdHMHlmZGpXV2VaVE1kZFd6V25Y?=
 =?utf-8?B?R1ZvV3p6ZjJtdlE0cysxaEw4QlowUHRDY2I4Q1RzWDl4VlNlMHV1U083WExk?=
 =?utf-8?B?RjFYbHZ4MldiT2U3Z1N0eVY5eWRla2V4WTZ4YXE5b0NKaG85OVY2YkZvV3Bw?=
 =?utf-8?B?a3pLSno3VytzK2QzKyt2KzVyTEk0MFZVSW41ZUxiY1FuTDF0d1BKRkpXaGE5?=
 =?utf-8?B?VTVrRkNCVHA3VDcxU2JhMmtsZlF2SGlGaGZBeVk2VDhDelI0eml4Nk1IUENz?=
 =?utf-8?B?QmxnT1dWd2lleUVjaHNrRW90MnFpNW5sY1pFZVZrOFd5clFqUUJGYXVBOE9Q?=
 =?utf-8?B?NDJlVlZhdW54anIrN242VWlvUDRBWFFGWTB2ZmYzNFYydSt1cGttK0dIQlo5?=
 =?utf-8?B?bGZRanJrOUp6Zk9IK3Y4MGIwaEgwUnBZWHBZWFdtQ0MxQ0FYS2RQTVlUcmpI?=
 =?utf-8?B?RFp4cU1hOStxTFhiM0xOem52WVhIWmU3dGdqWUxHbXRzU3AzRnpUNW1NbVor?=
 =?utf-8?B?cXE3eU9BU2xuczhkZHVpMXM0TGF2ZzIvTy9HYmFtazMxcDFQWS8zRlBlS20r?=
 =?utf-8?B?eU1zNWMyMEdjSHQ1T0RobS9oMnBCNUJlNzhHZUxGN3ZXYXlOZVpKSmx4OE9X?=
 =?utf-8?B?ZUljVlY2RDF1ejk2aFZOWkl1eEpwamwvZkUvdUNsdXhaNDNFV2VpT3JaMC81?=
 =?utf-8?B?cGZNYjI2dXQ3UXVmQTVpN0JmaUZ6TkVMVEhFbEJaejNXdlBsT1c5QUp4THdZ?=
 =?utf-8?B?MXkvU3V5Znd2a1dFRnFOTFFtTWU0eURFYk5HanRJRzUxaVFCYk9PODJYWmpo?=
 =?utf-8?B?Y1ZoSENxbmszdjFpN1FUUytwYzFQOUI0VTVya0ZMMUhDN1h4Z2cxV0dCdTVj?=
 =?utf-8?B?OEhQdnFoVkRVdnRzWVBoOW5raWU1SXRCWDdoWFRvQmtUM0tlTWt1bFlhNE1T?=
 =?utf-8?B?K0gzTlR2UEdQUlJCbVhUOEh1aitYaGtYRytYb3J0MGdVa09aZzhzWWNBeUht?=
 =?utf-8?B?MEUzRWNFenBqSzd1b25GMExneUpJTlVwNlgyMzJ3WWdHZDliblVrd2N2RVJW?=
 =?utf-8?B?MDFQenpyd09hS1F5SDRMN0J4UllNS0NSU2FibnBvQWZhYXpDQ3c1TVhKVjJ6?=
 =?utf-8?B?cmpId29Lb0RTL05aNHFKcDBFS1VtVE9KSjh3S1JqL1RwcE05WE43cW41M2RQ?=
 =?utf-8?B?UGdIbEJFbWJZd0o3OVBnU3lRUEpzTVhqRHM5UVE4RStPY0kyR3ZuVW9KaHdN?=
 =?utf-8?B?OU9EYTFoS1BhSTRGVkdFMFNmcXFLc21WYWxMNStKREhaNWtLcndPSm5HZjEy?=
 =?utf-8?B?VHVDK0RTeWI2WUdBR2Z5MkcwTHVZUDgyNWZEVnNseXliZDJ4TytuTVdweTFD?=
 =?utf-8?B?L0pQdGQvb0ZlWEsxV2NabS8ySUxhbjZJQmtrci9naEFFWG55Q2o4dEJmV3BN?=
 =?utf-8?B?QzA1UTB1OWVGRWlQVE1nY25KVW9sR3NyZ1cweVYwTVFuR2w0a0Zaak1OR1R4?=
 =?utf-8?B?VkxObDM3YVMxM3lIS3Yrc0VCVkxFQ0tFODhWV3JZek5JZjJ2Y1dXaFFCWFhD?=
 =?utf-8?B?RGN2MnBUVWNSeUVFeERYL0NZamRGdk9ubXJwS3d0OExNTDlIRitrNnZOOW1G?=
 =?utf-8?B?WXZOVFYwUTBLSHJkSGRDQmJmaVUzSXlaSnpQNGNKYldGZWdDcW9MYTduVGtW?=
 =?utf-8?Q?sRRysMzJf5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZmQlltYUM2ZG9YRUplY29OYnc1R0dKWlN6aE1ndkpJbjdFTExXdHFHZnpB?=
 =?utf-8?B?R2ZQaTFZa0RueUswd2tTWCt2ZzB0T01iRzFlSk1DU3NPbkp3YStnRG1KSDBF?=
 =?utf-8?B?QUNTalpDY0tCUTFmL2tZSlFFcWZETmV6NFdBUkF5S2NRZ3Q5MGtCQzdaWDVw?=
 =?utf-8?B?R2o1TDFIVjJYcWNRWldWMDgxRkIyTzVpNk1rcUpaVmlZL3U2TWc0cm8yYU5z?=
 =?utf-8?B?bWFVU1p5U2lkUGRQaDd1aWFmRTFaYW5LUTVtVlFTaUpBM1djN0pvdHNFR0E4?=
 =?utf-8?B?NVpLN0F6WlkwYUpyUmlRSkl4Wnk1eE1UMC95cERuR0F2UUIwZ0t3T1E4WXl1?=
 =?utf-8?B?dVNVVXZ5N3BjZy9xb2pRTkF4ZEhyWGtMMnRXRmthMFFmUHI0bzczV1BBWEpl?=
 =?utf-8?B?NWp3bDRTQ1pxMmNPc3krbjMzTWQ3WGk0bGs3UDRIdktwNThMYmd5cFovUCs1?=
 =?utf-8?B?dXdCRnY5WXI2ZEpuV0Y2bVJSLzh5cnptajVDTVJSR0V5VDBVNFhJZU5GL0tO?=
 =?utf-8?B?RElHZkhoN1FNbUdKVGpobTRNRG4vWWNKZUNQak43b3ZXUEdJSkg2dEUvMWox?=
 =?utf-8?B?WHNidmpqN2FJZlpXaGUrZG10NjlzWDNUa09ycWtxTUM3Uk50RDhFYVNBd3RT?=
 =?utf-8?B?NnRkODBFbklGRFlxWGJ1WDloWVhuSkF5ZUhrdkJjRitjZk9mcCtQUU9LY1Zs?=
 =?utf-8?B?MTZlclFNa3pIVlk5cVN3RmRLWmUxYXpYczliTlJZNWk2eUVzZWRMNk13eWxi?=
 =?utf-8?B?TFVoeUJ4NmdzMXUwWDNDOVRFRVliRnIwVzM1VDdLNGI0OVNLQmJOTkZXU0l0?=
 =?utf-8?B?YWh5bWhmL3FLQVlzbkhOZjV1LzlNaDk4VlgxTUF1QXpkZTJoSW0wc3lyQW9i?=
 =?utf-8?B?dGVlb3N0b2VOcHBOZHl5c1BLdGZLSURab3RhM2h6c3JMTVBnZEhFVGpGc1pE?=
 =?utf-8?B?aVhGeGZIclhNVGozbFpuYStpRHFzdXFnd04rRmc3V3dJQ0N5aitUN2k5My9p?=
 =?utf-8?B?VWRsck9ZeWhmREdGdTNYSEhLamtaSjNFUnRxVDA0TkNiV3ZSVVlpVTBFekw5?=
 =?utf-8?B?Z3FlQVdva0VIM28zZm8zeUIrcldEL2hneVA3M0llTHBweElOK3dNSXd6MEVa?=
 =?utf-8?B?ZklzZ0ZFVnJXTXhtZE5uM3ZpczdLaFdKN0NNNkpuajhldlZ4YW1DSENhR0tE?=
 =?utf-8?B?Z1A2a3pCOEl2RmFnS080ZnZncVBta0pVZDNjbjJoS3hXWnJWT2JJdE5qWHVm?=
 =?utf-8?B?dUI2L2d0dHA1bDB0ZGlUVS84dHR3SFZHUWI4OTBUNWw1cDJJaU1kQTJhOGs4?=
 =?utf-8?B?OTBwNlFnQnF4NUV1MEt0cUtYa3ZTV1VUckRCM01hYnJzYllPL3VjaVQ4QWpT?=
 =?utf-8?B?d3F4bktJRUxKSW5PNVluMjdNMXkvcFE1RE4rYkxYa0hHaFhwbmJMcXlrNmll?=
 =?utf-8?B?NjhqdWc0OGNXSWpTNFR3blY0R3h0UzBaL1JzKzhVVS9ZMFlzSkdGRStNQVJ5?=
 =?utf-8?B?T081U2hkMW1ydkRnSmsycnE5RDZNYjFtYm1PY1JaNVVVeThlQmxkZDA0VTk3?=
 =?utf-8?B?c1RaeFNHOWpWNHRreUN0cnJVTTJzZTE4dmhMQTFKOXAzanViR2trcWRxVUF1?=
 =?utf-8?B?LzFjV0E4MlVnK0FtWklCM0tUdEQydzM4a0MvVkttbHIxZ1I1TVBwa2dWbWV5?=
 =?utf-8?B?L08wZW9nWE5HU0RieXRGb2JZZTFtdnZOVi82OE55TTV1VVJoeFJnYTB4RVpO?=
 =?utf-8?B?cGpsYlgxdUg4TURXNHIwekViZ1d5elZrMjc3ZTJXMXgxUW1qUFJCTHVkZVR3?=
 =?utf-8?B?V0VpRVNFb0lsZGJHNkNuYXErdThJMnFuY1MxMWNjVXltbVJKa3FFR1JTNllO?=
 =?utf-8?B?UHBwdXRRc3c2L0IxYWZQWEM3UkhvOWx5WW5UV1BYOUhRY05hZUxHK3p6M2tS?=
 =?utf-8?B?U2xSNVorWHZ0MmNWNTBXODZpMVBWZTN5QjRpWGNmK0lMUEs0cERXOFEvc0Na?=
 =?utf-8?B?ZGcrUlZvTHhjSnZqTHorUE9heVhxY3E1SVlSNTMxNTVub3dOUitZTnhTMGFu?=
 =?utf-8?B?TkdJajRkNTVsM002WnVzcXZENHRqdC9NTjJqVXJkRldMZ2hTVU1SVk5QMFJ5?=
 =?utf-8?Q?FkqTl0ZNYRkqo32nksIndneBP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c38618d-87ee-47d7-3196-08dde940ac43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:16:53.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EqZYqS79WEXTqoP6edo48wMOwYxx15HXzA89e2WReeH9W8sXJrhHKUIiQLHz55pQZi1WFrvjFbDB+5JD3oD4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166



On 8/28/2025 9:58 PM, Alexander Lobakin wrote:
> From: Raju Rangoju <Raju.Rangoju@amd.com>
> Date: Thu, 28 Aug 2025 14:59:00 +0530
> 
>> Add support for hardware PPS (Pulse Per Second) output to the
>> AMD XGBE driver. The implementation enables flexible periodic
>> output mode, exposing it via the PTP per_out interface.
>>
>> The driver supports configuring PPS output using the standard
>> PTP subsystem, allowing precise periodic signal generation for
>> time synchronization applications.
>>
>> The feature has been verified using the testptp tool and
>> oscilloscope.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>> Changes since v2:
>>   - avoid redundant checks in xgbe_enable()
>>   - simplify the mask calculation
>>
>> Changes since v1:
>>   - add sanity check to prevent pps_out_num and aux_snap_num exceeding the limit
>>
>>   drivers/net/ethernet/amd/xgbe/Makefile      |  2 +-
>>   drivers/net/ethernet/amd/xgbe/xgbe-common.h | 46 ++++++++++++-
>>   drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 15 +++++
>>   drivers/net/ethernet/amd/xgbe/xgbe-pps.c    | 73 +++++++++++++++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    | 26 +++++++-
>>   drivers/net/ethernet/amd/xgbe/xgbe.h        | 16 +++++
>>   6 files changed, 173 insertions(+), 5 deletions(-)
>>   create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-pps.c
> 
> [...]
> 
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> index 2e9b95a94f89..f0989aa01855 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> @@ -691,6 +691,21 @@ void xgbe_get_all_hw_features(struct xgbe_prv_data *pdata)
>>   	hw_feat->pps_out_num  = XGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, PPSOUTNUM);
>>   	hw_feat->aux_snap_num = XGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, AUXSNAPNUM);
>>   
>> +	/* Sanity check and warn if hardware reports more than supported */
>> +	if (hw_feat->pps_out_num > XGBE_MAX_PPS_OUT) {
>> +		dev_warn(pdata->dev,
> 
> 1. How often can this function be called? Don't you need the _ratelimit
>     version here?

This is only called once after driver load, so _ratelimit may not be needed.

> 2. netdev_ variant instead of dev_?

This is in the early stages of probe, even before netdev is configured.

> 
>> +			 "Hardware reports %u PPS outputs, limiting to %u\n",
>> +			 hw_feat->pps_out_num, XGBE_MAX_PPS_OUT);
>> +		hw_feat->pps_out_num = XGBE_MAX_PPS_OUT;
>> +	}
>> +
>> +	if (hw_feat->aux_snap_num > XGBE_MAX_AUX_SNAP) {
>> +		dev_warn(pdata->dev,
> 
> (same)
> 
>> +			 "Hardware reports %u aux snapshot inputs, limiting to %u\n",
>> +			 hw_feat->aux_snap_num, XGBE_MAX_AUX_SNAP);
> 
> BTW, these messages are not very meaningful, maybe you should print both
> min and max and say that the actual HW output is out of range?

XGBE_MAX_AUX_SNAP is max supported value, so limiting it only in case 
hardware reports more than max value. Any lower value should be fine.

> 
>> +		hw_feat->aux_snap_num = XGBE_MAX_AUX_SNAP;
>> +	}
>> +
>>   	/* Translate the Hash Table size into actual number */
>>   	switch (hw_feat->hash_table_size) {
>>   	case 0:
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pps.c b/drivers/net/ethernet/amd/xgbe/xgbe-pps.c
>> new file mode 100644
>> index 000000000000..b5704fbbc5be
>> --- /dev/null
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pps.c
>> @@ -0,0 +1,73 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
>> +/*
>> + * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
>> + * Copyright (c) 2014, Synopsys, Inc.
>> + * All rights reserved
>> + *
>> + * Author: Raju Rangoju <Raju.Rangoju@amd.com>
>> + */
>> +
>> +#include "xgbe.h"
>> +#include "xgbe-common.h"
>> +
>> +static inline u32 PPSx_MASK(unsigned int x)
>> +{
>> +	return GENMASK(PPS_MAXIDX(x), PPS_MINIDX(x));
>> +}
>> +
>> +static inline u32 PPSCMDx(unsigned int x, u32 val)
>> +{
>> +	return ((val & GENMASK(3, 0)) << PPS_MINIDX(x));
> 
> Redundant outer ()s.
> 
>> +}
>> +
>> +static inline u32 TRGTMODSELx(unsigned int x, u32 val)
>> +{
>> +	return ((val & GENMASK(1, 0)) << (PPS_MAXIDX(x) - 2));
> 
> Same here.
> 
>> +}
> 
> I believe you shouldn't name these functions that way, also pls no
> inlines in .c files.
> Either give them proper names and remove `inline` or make macros from them.

Sure, will address these and above comments in next version.

> 
>> +
>> +int xgbe_pps_config(struct xgbe_prv_data *pdata,
>> +		    struct xgbe_pps_config *cfg, int index, int on)
> 
> @on can be bool?

Yes, will address this.

> 
>> +{
>> +	unsigned int value = 0;
>> +	unsigned int tnsec;
>> +	u64 period;
>> +
>> +	tnsec = XGMAC_IOREAD(pdata, MAC_PPSx_TTNSR(index));
>> +	if (XGMAC_GET_BITS(tnsec, MAC_PPSx_TTNSR, TRGTBUSY0))
>> +		return -EBUSY;
>> +
>> +	value = XGMAC_IOREAD(pdata, MAC_PPSCR);
>> +
>> +	value &= ~PPSx_MASK(index);
> 
> I'd remove that NL between these two or even squash them into 1 line if
> it fits into 80 chars.
> 
>> +
>> +	if (!on) {
>> +		value |= PPSCMDx(index, 0x5);
>> +		value |= PPSEN0;
>> +		XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
>> +		return 0;
> 
> Newline before the return.

sure, will drop this in next version of patch

> 
>> +	}
>> +
>> +	XGMAC_IOWRITE(pdata, MAC_PPSx_TTSR(index), cfg->start.tv_sec);
>> +	XGMAC_IOWRITE(pdata, MAC_PPSx_TTNSR(index), cfg->start.tv_nsec);
>> +
>> +	period = cfg->period.tv_sec * NSEC_PER_SEC;
>> +	period += cfg->period.tv_nsec;
>> +	do_div(period, XGBE_V2_TSTAMP_SSINC);
>> +
>> +	if (period <= 1)
>> +		return -EINVAL;
>> +
>> +	XGMAC_IOWRITE(pdata, MAC_PPSx_INTERVAL(index), period - 1);
>> +	period >>= 1;
>> +	if (period <= 1)
>> +		return -EINVAL;
>> +
>> +	XGMAC_IOWRITE(pdata, MAC_PPSx_WIDTH(index), period - 1);
>> +
>> +	value |= PPSCMDx(index, 0x2);
>> +	value |= TRGTMODSELx(index, 0x2);
>> +	value |= PPSEN0;
>> +
>> +	XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
>> +	return 0;
> 
> Same here.
> 
>> +}
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
>> index 3658afc7801d..0e0b8ec3b504 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
>> @@ -106,7 +106,29 @@ static int xgbe_settime(struct ptp_clock_info *info,
>>   static int xgbe_enable(struct ptp_clock_info *info,
>>   		       struct ptp_clock_request *request, int on)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct xgbe_prv_data *pdata = container_of(info, struct xgbe_prv_data,
>> +						   ptp_clock_info);
>> +	struct xgbe_pps_config *pps_cfg;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	dev_dbg(pdata->dev, "rq->type %d on %d\n", request->type, on);
>> +
>> +	if (request->type != PTP_CLK_REQ_PEROUT)
>> +		return -EOPNOTSUPP;
>> +
>> +	pps_cfg = &pdata->pps[request->perout.index];
>> +
>> +	pps_cfg->start.tv_sec = request->perout.start.sec;
>> +	pps_cfg->start.tv_nsec = request->perout.start.nsec;
>> +	pps_cfg->period.tv_sec = request->perout.period.sec;
>> +	pps_cfg->period.tv_nsec = request->perout.period.nsec;
>> +
>> +	spin_lock_irqsave(&pdata->tstamp_lock, flags);
>> +	ret = xgbe_pps_config(pdata, pps_cfg, request->perout.index, on);
>> +	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
> 
> Are you sure you need to protect the whole xgbe_pps_config() from
> interrupts? It's quite large and I don't think you need that lock
> (and IRQ protection) for its entire runtime.

xgbe_pps_config() touches the hardware registers throughout the 
function, so this protection is needed.

> 
>> +
>> +	return ret;
>>   }
>>   
>>   void xgbe_ptp_register(struct xgbe_prv_data *pdata)
> 
> Thanks,
> Olek


