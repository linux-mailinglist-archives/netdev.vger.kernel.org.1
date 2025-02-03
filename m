Return-Path: <netdev+bounces-162149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348CDA25E0A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB661645C0
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB22F2080FD;
	Mon,  3 Feb 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTAGMqwk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20822205E32
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595208; cv=fail; b=Qrdor5sYUz/vdukxI+K/mDTB31w4imFRb5+zOdRaEyztzqRCrlQinJKn2MzhLRAhAokTib/IPF9Q2Fefz2PFZyWEwMLxHNIhQMpotaaZs0TTkG7skwOMUGMn9lG021qCpAxR9pCaBdRBvQTNtUTreDQa484hu2Cc2uYmZd7PIw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595208; c=relaxed/simple;
	bh=rnaQG5Q+C3NfG2W5faIcxEANRTBMPi9LPIYtuAQKPM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mVppzq8l5UqK1REJEMC3eRP1bBpJF6U8iVL8cJXwYgJiT71dBqGluEqC8cbTIEktb81bx30Qz2UZFM2HP1bCVFaXR6YALNMahTqPq6GUefJ2KMidyG7k6FmedeP8qoBuY8txey4gNy2MBxCdnWuXYQKo8Yz+IavgizhorpSQdZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTAGMqwk; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTeWDsIz5y/PTx0WvCLfef7fMoYkbMFHxB45bcPEUAkWK2kHnhkqC/ccSHurAD6LEfjWvN1kgM41/3s0ZCKFXZPqkqPfnuJH3WXYnMRBiq9WGROZJZlQnW1uIADEwyomoEtYNjkci1LZGJ0Qu5jQCRL4WXcFbLCgXB0twUgw2b1vFr2XYDCx+g59mm+D56u+/jA++lsDEU2t8MFv8nN8Ls9EZGyhA12ConKNeRYpd8tx/58JKMFy+I7/Fbl7gTUvXxSNP08OmpBF0aRmauEki7smaHaZ5wX5CZ/pL7dFHEUIfNZDA5yaAr85a4xeP6qyChC5+YP9YfqciIpkfbRKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf33JlJ5myVOeSiuVzLjEx5ZlzVneLzGE/TYHPvKyJI=;
 b=aqf1OET2cGRO8UIlFvKXLt6Vf7ykDVf3Jy6bsXz0Y8WGaSIST42XaX8vWCpuqILkweMFyuOyzantR4hztR0m0cZG7l2M4XmXOW1L3s0rzF5LPbUfzM7q0x9Nh1E722BJGtT38EZEf6iOMmMwL1HdZsZAjhkhJWuof61BD0T+bc3qeDcamrZogB4n0VaZn+FtfI+zg2lm4ogYmfAKCE9H1ju/SVjsTH4kj6dHMt91eVlf5EHNhe+Fyj3DAGNjlpE3JWgWMN6p9zKd/WP0tvvD/j4HYEkTN5ZovQOkIwmtGVuYOOYb2iJYuFq9igAVzjpwGU9hSEQJI8cKVlPDJ8Io1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf33JlJ5myVOeSiuVzLjEx5ZlzVneLzGE/TYHPvKyJI=;
 b=DTAGMqwkq4jdSqZ56oZHolt8L6D/i0X6Z6QT7fwHIGYOZ+3+gCvhI5UCqL65xf40bfWt1H7sZWFUrgvaUM7ppDRxC5Bac2WyIpv4kbC+cPH7wtHzneTHUD7Zv/YZi77vfkiJfuydHCBrFW7FndDSAex83+xSSWytkD15sCNeIOp66UkglJ9i8/HI+yHPkLkoG7IBCmAMmvfcl1lpryeGdzWYeOYpQ7+8jOFjkApEjBDyxH/IUvPwfEh66aLwCDnFdpBCSMcMjI9qKObSR2d1vllRS6s9gCGYd3dvzfcxbmjQ57krYiPpWgmmOurmm2az2Wkk1WcoCr4ynWveInpRjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 15:06:42 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 15:06:42 +0000
Message-ID: <8542d991-7af5-4871-9ad8-e60e93d15e93@nvidia.com>
Date: Mon, 3 Feb 2025 17:06:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] ethtool: ntuple: fix rss + ring_cookie check
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com
References: <20250201013040.725123-1-kuba@kernel.org>
 <20250201013040.725123-3-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250201013040.725123-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::10) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: fbad1cec-47b4-4fcb-ef24-08dd44645def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEhEWWVYSjk2Y2FONVJVaHNKbHNjMExidUl1YnVlVGtlckM5bDQzdEpwRTlB?=
 =?utf-8?B?SElDQmE2Q29WcDBGRGZQTVl4Q1lTSW5yOFhxdkVuMDZSa0NuTUdHcXdLb25h?=
 =?utf-8?B?MUpNTU1VWXdtY2d4UmYvWXNjczlMNWNrUEM5RDBKeUxLTFhNRG9IOUV2aFdv?=
 =?utf-8?B?YWQzKzVDTS9DS1BsL0thTXNHZG1FR3pmQzljdThvRGdrYXJzSHozUTVkZks4?=
 =?utf-8?B?bVFzWGdPRFNrVWJtTVZ6RWx2eVBWU2M0QVNIbURLeTY5S0R2cE5PNlNMbFFn?=
 =?utf-8?B?bm5sT1Q3ZFZHU1BZSlZveXY4akl0eXNlTVVzVTM5emJMZmQzb3Z2UlpmS2tF?=
 =?utf-8?B?OE9VSDZ5ODdLeE9aQTJ2a1VEQ1JNeVNOeEp5K0gybkgwYldFNHNoZDE0RHNS?=
 =?utf-8?B?SUpsOWhHRVNZTmEvSGxSSUdTcXY4SHFzZ0ViRG9GaXhMNXo4NkhqVXJ4T01O?=
 =?utf-8?B?ZVY5KzBjdGtXTTRGZmVQN1MrK3VoTXphMTJ4YjlVTWQvZTlHaVI3bnlaZ2dD?=
 =?utf-8?B?Umt5LzcxRkxTL2ZqNHpSbnBvTFJqVUEwWnhvSnFOWTZKK29VNVBZVlJodjVV?=
 =?utf-8?B?a2srOUw3VkVORk1GRmJOVy9uUmRqMUVGaUhiUE1RS29vM0VqTzZ2eW9hVkRG?=
 =?utf-8?B?bklRRmNiRGZVQ3dhbjRyVytEcjgxcUxESGxxYnBPVytIaFV3WG9zb0JONi9P?=
 =?utf-8?B?QjFRSVFVQ0xld1Z1N2d3TlFENi9LRDJYTEoza2V6MWV3bU16RlcwNmR0QVVz?=
 =?utf-8?B?RkpvY0JQR3VObzhqV0pEN2t2Yy9JVkNsNnJSaHZQcGFhTmsvT1JiNW1sb0tE?=
 =?utf-8?B?TWVyWDE2S29jVmk5ZjRFbWpYYWNnOE5UY3RJV1FPejIzbUFuNjE1TEY3SkQz?=
 =?utf-8?B?aHRMRDhaWitCMGJyVkxuSW1vZExuNURvRjFWMmZZb2h6TXR0Qm5COW12ODhr?=
 =?utf-8?B?RVhybkpaTGZJS1ZmcTYrTTcvRUI4VHdST1RLblM3WkxuRzJzRm95ZkFwNmx0?=
 =?utf-8?B?cWxYWTVxd0pGaStrUEtoUHBXeEhVSzZwNjZudlU1SmpnZmVCU24xTkVOQVR4?=
 =?utf-8?B?cGR6cVBCTkN3eTdzWW9tcms4bXU0ZDM1d1lvdjlmRkd6bzVLMkRiUG93UVJh?=
 =?utf-8?B?cHlLL0J0dnJpcmFmTkhOZGs2WWZ3b2pSeVFEYTB1aEFoTmZBMFVwVzNRR2tF?=
 =?utf-8?B?dlJZU0JNeGFtbTluUnNzdVhSdHNVWnA3OEE4cEh3MHJTT213LzJ4cGFLbjJ0?=
 =?utf-8?B?NDRnMkRTK3V2VTBVVkRUNFNrK21IbGhTSDdRbjZXT2ZUMjZSa3VudW9DYTVJ?=
 =?utf-8?B?ckg2UFRSaVBLY0Z2U2RlNXRJZk01K1hRQm14TWx5anJFMTR0MEViSWwyU0Nt?=
 =?utf-8?B?djU5Tm9ORWNISzNCK2JFQ25UcFRTS2dBL2E1ZG1DWnhHNnFsQk0yK1cxeG44?=
 =?utf-8?B?eHpMbXd1V0QweE42L2F6eHpycGZiZDlDQ3RnUmV6blZvWVhJZ3RvRWttRU5T?=
 =?utf-8?B?ZlpncHU1OWZ6Q295K3RIckhJWnZZV1hOS1gyVkU3Q1M1RERBcVdXZjYzOU9a?=
 =?utf-8?B?L2NIVGdXTXRqMklxUWVycmd0L3krSkptSHdMOHVCZ21VNWI2N2ZaZnY2eUVF?=
 =?utf-8?B?VG9kQWJueFpGTjR1a3ZoREhuNUpVTHZsZmxmMFZMVGZwemV6akhvWVlHZFVw?=
 =?utf-8?B?VDNQeHVtemNtN21zRjhzU1FXWmFuNzlHeHRFdlordjgyN1p2cW0rVllESS92?=
 =?utf-8?B?b1o2VUxaYmYwaDdBTlM1U24xWmFrdDdldmk0Qi9xT3h6SHd3ZDhweWZIRG0w?=
 =?utf-8?B?Y1lLMzlHRTQ0SEZzSzRqSDBRb2MwbGg0dXhhODZQTEp5ek42S0htN21QK1ZH?=
 =?utf-8?Q?M8uEOlEhyEFZo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXdjUm52eS9nQXUwMkhsdmZJUG9uWWNNc21IRVhlSDBZbUxuNDhSZE1uU3Vr?=
 =?utf-8?B?NEsrNFBhTUh4Q2RMNHlsSzgxUlVFSzhkNStXOFFDUkkzVXh2MitReEd3Uklo?=
 =?utf-8?B?M3ZlNXFvbzJsZmhUNnRYb0lQN3NMZTJDdnRhUGlvK0EwbjBJcnExL3YyUUgz?=
 =?utf-8?B?by80bW52RW1wdUc4OGo2TENRWkloSlVCSU9ES0hSYzgrOENqd2JOUllxOEEy?=
 =?utf-8?B?ZzJVby9jMk5KcjR4dy9ndko3VzIzcXJlM3pGdWZRRDdUMG9rNUFlaU0rTm1R?=
 =?utf-8?B?dHJLTzFkSWNEWUpweVBhMndyZkZuMThiUmtVMlMvTExUTzdmbUJVNTJUNjE3?=
 =?utf-8?B?VmRJMzlHSkQ0NlJYL0UwbnltQUtyVlVGK0lXSGZGeXVPdCtLS29La0tHTTRw?=
 =?utf-8?B?RWpxOEw3TG8wZjQ5YTU0SXF4cjBadXM2WHU5YndYRU5rR0tzZmJXd25YZXpZ?=
 =?utf-8?B?SmQ5QXhCUWw3QTdIdm9TM3BzNjczM0dtaDUrdmF2dy9aQ2NVNUZKcytHcFVP?=
 =?utf-8?B?UXM2MFBJVG9nOEsvOTRXM0N4SjJpbGVzQTBuZkJRdlJpUjNsUTVFSXNYOVhw?=
 =?utf-8?B?RWk3QytvVERGL2NMMFJPYVRORDBJYVZXNkpuajhHZmQzd20rZEtoQzJyT2x0?=
 =?utf-8?B?RUJyVzlPeWZNZG9BL3psMjlZYllFd2lyd1d4YVlHTDMwSWJYWENLOEVDbVJH?=
 =?utf-8?B?V3RKeG5uWEtqblpNRzdjVFJ0S3NXV3JzdW1Nakdhbmc5bXRUaVNIZVIyWHB5?=
 =?utf-8?B?NC9xcUM3azF5UlRkczN0d24zdEQ2TkIwZEpheE0rbnJMUEhtNElmbit2SmN3?=
 =?utf-8?B?bC9nZkY4Zk00SVBCUHlvcm5TanRyYmNEenV1Zk9VOU5NYUhtYXdPWUNKVXdB?=
 =?utf-8?B?T1pmMGlBTjhQck5Hbng1akpNNUlzSFYvT0hOOXd2OHdzTzBkRWlOZHg4RTlS?=
 =?utf-8?B?S0Q5QXZvSi9EQmliNlFIOUlHc3h1Zng1M3c1UG9nTlFEMHlCdTBVNnE0MDVl?=
 =?utf-8?B?RVpEd0VOZWYwVEc2Y1cxZzVDdHJvTStmQkJGUExpMFNqWm91OEVaeEtNL3Bj?=
 =?utf-8?B?R2g4bC9Nc2F0NTNST0tsTVQwbldsclFQK3hlWmhra1V1czE4S2hrZ3FSdm5h?=
 =?utf-8?B?bENnczJZeHpOUjErdWFmRFZBQjk2K2NkcDhMRVJIdlBzMUtXdVUrUm96cUhO?=
 =?utf-8?B?TVB0Wi9Bb0p2NXpIUmZMMkpuSmJCYWdLbWJ3UndUVWlSVGFoM3pQa3gyQVVu?=
 =?utf-8?B?c0g5ZTdkeTRtbVp3bEFHRldldTVKOHdJcGw5SWJEU1czYnI1eCtJM0xvYTVF?=
 =?utf-8?B?THV6VGUydGZGVWl4a29IRFdyYysySjVRYjJkcEkxTDJWb25GWnZKMWNuNHlX?=
 =?utf-8?B?bVg5UzdLN0tvaXN5eDhtZmNUOGxrNjVMZCtHOUR0MDVZK2V6RjZRMlhwQ3Vr?=
 =?utf-8?B?ZGI2bjU5a1RJWnNydXY4YmV3UTBFSy9lSHBjbzhaWkVwLzQzWjdqUjJsT01F?=
 =?utf-8?B?Q0ZZRldyQVRYbnA3N3VqVFREOXA5L0o2Uk5KeGlZTnkwbFJOelJ4dlRia2g5?=
 =?utf-8?B?NEtxblRUQ1hIYzh5MHBuK0ZyWkNXM3RBZXhLKzdBWXRNdmQ2SXJoak5QVUFi?=
 =?utf-8?B?WGNtdHhJUmZsOHl2VlcyamZKNzBjTGowdVFWdC80cDlLWEFvY21JVTNhZ2FX?=
 =?utf-8?B?dDJkeE5jYzVTTUkzR1JxRmJNSDFYMWNuZ1JSdjVlYnlWZUp2TTV0OU1EdVpU?=
 =?utf-8?B?SUU0WTRHN2Flc0o3aEJ4dklHUUh1Z2lhUHJsQzBtNEcrYkZSOWxBTlIzVG5M?=
 =?utf-8?B?WjhrN1d5Q3QwZ0RYQWNqR3Q4LzJBMWh1N2xIWVNRMEtoWkhZUTA0OGRyWTFX?=
 =?utf-8?B?UUtXL3E2T3lpMFY5Wm9wNWt5T010QjF5ci8wa1lxN2taSXlvUXA5MUwxS3ZK?=
 =?utf-8?B?YjVLZGdXRHFWSFFQNE5EeFBVcnVycUNXWWZOQTV6dlQxMFNNMVkzSWFESzRi?=
 =?utf-8?B?Y2tjK21XVm9aNFNjajZKY0JjK01WQzZwdy90dCs5c0hiUW9VczdQTVd0NHQ5?=
 =?utf-8?B?NVBCM2dFcFRIVkppdld5SWZDcm9tdkRKUGo2N3dQK0UyczlHMzZHbGNxU1RC?=
 =?utf-8?Q?nvXYdt+N1/+xI8qRRotPOrUxW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbad1cec-47b4-4fcb-ef24-08dd44645def
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:06:42.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaEtGJ9znciWzV25Zy2qbfeczidFbsgP2NKZQyzLrkxSEvmEF0Pp+ZDvfsB0b5My
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

On 01/02/2025 3:30, Jakub Kicinski wrote:
> The info.flow_type is for RXFH commands, ntuple flow_type is inside
> the flow spec. The check currently does nothing, as info.flow_type
> is 0 for ETHTOOL_SRXCLSRLINS.

Is it zero or garbage?

> 
> Fixes: 9e43ad7a1ede ("net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

