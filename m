Return-Path: <netdev+bounces-207380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F4B06EF1
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61023A8D68
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614D22068F;
	Wed, 16 Jul 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kcyLebNp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5225274FE7
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651021; cv=fail; b=bh4Un7t6mL1vBB5m/CFF/YgpGdQ2MySR3sHl1AYuv0G1aiFTkFOx7iElgbVLj+O78kf1rBrMTaWqMyl6hTU9zsmpDhvyN7X3MfaRLJ2QSYdTwkIUaPoa5ezFUGGCS74AFdsCyYe6/eJU5yY64kHK9yz9FOFxJ57lU895C+4uOe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651021; c=relaxed/simple;
	bh=Rj/gVBNl6ClbzlhgmeejzsmGrG0ZIcHiiJWEw/rNYXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p41Vnygepj1QZxnkKlOpTApY6as9oGs3E6x8uboN6h6jyhLe/ZOilHgC4YM0REg3WUu1fM4DTp9VDciW6M/ZVY/pomiRleG5G63vYD4EanQxWMHFljEC/udGN6IA9qZOd0Mk4UhIpdpa6tEfvKlNqSez6bvLq9DELJizhAficv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kcyLebNp; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmWN4eMmNh4dtTBA/WigYZP8+/7QBAB4ZfhEljQY2X7MlGzcTvH6sBOpVfYuRWHqg17eXT9tbfjMktrEQ8j0ZUj3wTJmkh3rboL3Xh4ruf40W3hfqH7hCaBJbCp5xwR7acPZTdmjgmihx0ImL2t+fRd+u3YrmftsJuhTif7/MG6I2joFgpLXHrFFP+rO2GEQyYHXAXugtKk2CvkAcrCwoLf/CzvkQfQFlXMKR0TSXbiB0OXEUVbaQzjQbCAhjuaAmOXeEUcA1AEtTVwpTaRy4z+ROUnrgtrWJN54LV4zlo+wNIupP+K8JvRZ0O+agwptynSdMnxUhVidUFv/iLLq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq3fK0oIgISMOMPg7aE87OLvHPSsILYVcGUPweon5yY=;
 b=j3fQ82YUXwRahUHn/rXEyQtuov+Gng4CWuyOJQyeEsk/MJnsHTeFjELvAYF2fjLR3bL21Gr1L7gV8Dj5OA6v6v+69+K/hmGRHNEq8/1mj+N155RhzpsA9CEkuTzuJOcYWVgP0E5q3JipW1qedTLsaezUCwAatzwzA50vXHA5MhNspkx3Z/rGwNHPDrUo85cfXgCtf2SPl3TnCIFYdvCvwFywnUBCUPgMGtBsUIZnxmx1KrMlkKAl8IefCzKs35gV+Av7GvUYk76Mq7lH3hsGZjoJrJ1CQNc4kgbHUsCuMOr48S9LtJJrBTmp8ZknKy7Y0jz3koRs3A/kGZFdz76m1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq3fK0oIgISMOMPg7aE87OLvHPSsILYVcGUPweon5yY=;
 b=kcyLebNp9N0zW3GTsdQU4c6tQ2UMtUs9iBaqbDGbNwgqMd018kYaSUQkuIA5vdEdjCoI8Amw0peCfiqt5kMaNuYY1GcwDZmq7l5KqDBcfmKCag6QBCCGzPrW8q4Dyg14Cc/FzDpkBzq6lCOtlA4dR1XIVeaV/YRfWIVDNALMkbYJpbr4Hms7fgWmcbrAp8Tm4bC9jkgnxgXDvwdg/kLT4lJkAbm4XcxCwf4csjn6tqOegSvWjIJI6PfGpsSj3B/hZxdiyhIZxVEpWh+m9E2Q9rv2bC9sRnQAyXHHF/M8ANdEs0X3ky4+q6eYRVqf/V5YlhoE4QcJlbZIklcXfssLaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:30:17 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 07:30:17 +0000
Message-ID: <83b6e47b-0413-4b0c-9739-9a61656fae14@nvidia.com>
Date: Wed, 16 Jul 2025 10:30:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/11] ethtool: rss: initial RSS_SET
 (indirection table handling)
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com, jdamato@fastly.com, andrew@lunn.ch
References: <20250716000331.1378807-1-kuba@kernel.org>
 <20250716000331.1378807-2-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250716000331.1378807-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d58b463-9f2e-49fe-c7c6-08ddc43a9c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWNiNTBvNWtzTzFzMXpMRjJrTmhmbHFkWmwraU12bUgyRDlwR2MvU1NjanFp?=
 =?utf-8?B?M0Y2dTNhaU9VNjJwODVnblZFRmpHS0tiV2Qvb0NSVndKUGRpejNXVExsVzkr?=
 =?utf-8?B?MSsxN1BJdmo0dkd0ZUxQSENHdURUWmFyc1kxT3liTlk4RVR6eUNERFZSNFh5?=
 =?utf-8?B?RzAvOHFrczE1R3ZVODJ2K1I3b3JBYk1nbXNWMytwamRVc3QyUGc0dTdsbUZh?=
 =?utf-8?B?QmFpVUY3WVprbEFmNmttWG1qN2RiTmFyMC9xeiswZXJrYXFGNWdHbGFWUklR?=
 =?utf-8?B?YS9GQmJpaVp0QnV3ek16OVpGYzZzV0lVUWFUZXNFakgrZmVCaGhGYkh1Yi9p?=
 =?utf-8?B?eUloVWF5Q21oRVFSemtwZm5NNmg1NUlESGpHelMwRGFFMUF5THlJZnp5NGlk?=
 =?utf-8?B?SWdjVytIb2VqRDBDcDRSUHRaL2lwQjB1RHdGSW5Fdk9HWjVDZHFiUjRMbnNK?=
 =?utf-8?B?RDJSRmpseS9hdERiRlZ4cnYvQTNISGd2ZUVwandxU01tMGVKclY3L2E3c0Rv?=
 =?utf-8?B?OXcxK3ZoSTY0OW81WURaZmhUVlRwRWVnbDlHcU14KzdTZ0kvVXdtVWpENnRN?=
 =?utf-8?B?c2IzaFFmeXJQcmZYb1czNkZmYSt4ZDg1RHJqVnk2UHpoOTRmZEhOZFNodnBD?=
 =?utf-8?B?SncyWm9TVnlJRVhwRTkzb2JtWm5EZ0FMa2pFUWFKanBlNnQvdTIydmFhbmJ2?=
 =?utf-8?B?M2s4Yzh1NGNCSlFTSDN3V3p4SGJhYjFBWUUvV0QxTDJCbmlkRHBsNE0vVjhm?=
 =?utf-8?B?VnNjbG82OEZyRlpNUm5PamtrQi8xYUpYWEt4cHV1aWh2UityL2RNVTNpMTFw?=
 =?utf-8?B?QXBsQm8xSGhLTjhYUXZFQWZMY3RvRGpiU1dzaU5ZOGFGVFdwR3JHVGFtVUFR?=
 =?utf-8?B?eXRWbXRYdmtjeGc5cWx4dkJSUEdwazRULzVoZk94QkhmNHpNUmVBYmdWazNC?=
 =?utf-8?B?eHk3aVEzYm5ldWttcm5kY2c4QnVoZkwvNTEvcEJrMzRIdzNWWFFDdkxhKzRt?=
 =?utf-8?B?bC9NVWlyT2IxQ3ZzMnY3M3VoY3BvbmNLbGQyM0xWd0pPUUhMaE9EVnd3UlU2?=
 =?utf-8?B?MWZOT2orU2w2ckFKWWh6R0N5TlUxbGFtV3FyQzBzYUhHSzVlUjRDK2pSeWpF?=
 =?utf-8?B?OWNKOU1QbDJ0T1VKOUlDYnpsMXFVR2VPcGN0ZkZBbmF0RUNwL3o4cUxQZnlh?=
 =?utf-8?B?aEFwYzU0N1BNK2JJMXlqeWlkd2hDSHloU1BDL2tiWTJJSmZndGRxOHowRDI3?=
 =?utf-8?B?ZVhCeUh2ZGJNRjg5U3ZsSHdYWHZLSFRubFFpbWg5a0tMM3JBV2MrUUxqbVla?=
 =?utf-8?B?SGNqV09SbXVYNlB1aG5pTmNlb2Vac1U0b2FZSCtlQ1hDN3FyUlU4WXZIUmVN?=
 =?utf-8?B?Q0sweTFrWlhKRjZCa3l4aGVLQVBZL2tPWndLbWpvUWlPSWFSRlZXQVBVY0dV?=
 =?utf-8?B?OFIwTDlicGhhb0lMNmtmVlpSZGdSNWZyTDdya05GUXU4OXVEa0V0cTN4TDV3?=
 =?utf-8?B?eWlrM096eVE4RjVPYW8xZWRKN1QvWDN6RjZtZ1hZZWJ1K05UbTRJcGNicDl0?=
 =?utf-8?B?TWlYVm5zRWY2dFFGYzJZcTF3V3RJUmdQeHVTd3E5RndMdXU4VTFKdDVrY25h?=
 =?utf-8?B?TjFxVjdIZlV6ZEhuaHhBQzdnN1VicEI0S1JEb0dKTUt3cDR5WHlTYXpuQXRQ?=
 =?utf-8?B?UTRFMWE4YzRuR3BhTmhBZ1VyQ3lBb2d0clRmNnUwSms0S2NzaXQ2b01VS2dH?=
 =?utf-8?B?bDQrNUlSL1pZakk0UytMT21pN2JISC9VRERjeXdqTmZIY0ZrMlFMS2xuUFVu?=
 =?utf-8?B?UEpXaHQrV1BPRmRPRHRsOUlhb1htZUJLSERFbUd4K1E2Uit4OFA0ZW1wdGI1?=
 =?utf-8?B?dnFlRHBFNFhUUk10cGtWeE45WVlDd0dVMDhsQTloakJlR1JLNXVhVUdKK1Q2?=
 =?utf-8?Q?H1pDFanQoOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTF1cjV6UE1nOFFrTHo2eE9BTkRPaWIxNWZBeGdIQ0Qrb3ljWjY4ZFZGWGtS?=
 =?utf-8?B?L0ZLZDJhRXlpMTE2b3U0MkFFT1laOXhyMnFjN1UzMlhoMm1vWjgwWmFjd29D?=
 =?utf-8?B?NG1zRFdrb1RYa2dMYkJJUEV4M29qa2VmYlBSeWZFZUNkcE4xN0ZYUHh2T3h2?=
 =?utf-8?B?cnJYemhRZkpXa2pYOUNDMHRpU08xVURXVmJWWmJWVWk2aFBXanVRNlFWOHF5?=
 =?utf-8?B?UXlSZHIwWmJBRTRpbENldlhiTllldERXaXFxeUpseDhNT3pqeEhwcG5IU0w1?=
 =?utf-8?B?UExUNkxQUnE4WEdZaVVINVN0aURuZktoRmh3MmI3b25LL0ZRb0x4RFlqZnVT?=
 =?utf-8?B?eEh5N0Zxcmt3Z3BqOG1Ba3czcitYYmduZlh1cjNFWWVUaHA4Z1FQQ0l5VVo3?=
 =?utf-8?B?cmhPemZ1cVJ2TDZadTN1MFgzWW14YVFtTmdzZG5Db1h5TlA2Q3l2Sko2RUJM?=
 =?utf-8?B?d2xZcmlzMFlGQXhoMkRnclNOSUh4NldHZmlHRVlHNi9rL3FRbDFKd2N1cW04?=
 =?utf-8?B?VDVPSnI3cUxwRHN0SkpUanIyd1ZxT08vNTVBYS9uQzlUendWVDhCdHl6UmFr?=
 =?utf-8?B?RXpHbXlIQUMzTUVLb1FsT2k0SGkwM0hQRHZwRlczdXFGWFh6VGd3aGdNRzRa?=
 =?utf-8?B?d1VWaTA2TjN1TjhjcU1aM2V6cExublRwWXZCbTdHL3JOTDdrMjltQjJnQTlH?=
 =?utf-8?B?SGs5RVJDSFdmeDhKOSs1K29RQ1BkM2Z5Ni82c0lzL3NjYTlRU1BsSXJnVmdv?=
 =?utf-8?B?VFVDVVM5anB3WGdEUGpqR1FJYmxNMjJqQ1BHOUpFTUpmOW1TNkxuZVdYQy8v?=
 =?utf-8?B?R0xZdUpPbFYyY1FvbzJFU1B2THk3UjFCY1FWVnhSaG5obzdTR0lZZkx6bi83?=
 =?utf-8?B?bXY5TmhEUyswTWdiQThnYk1oREJpQy80ZXE0Uk9vNnlyTXB6WHVzVFdiWVo4?=
 =?utf-8?B?MWlIdlFNT290OVZtT1dlTHBjdEJKMzlWNW9XSUFMdzFLRCtPeHVxOEdkcDdi?=
 =?utf-8?B?YWJRaVk0VGdDUFNZOTdsQVZIYXoydTEzL0VkdFFjOFdWYThySlBIaTdycG84?=
 =?utf-8?B?QWZEbSt1bEJsVzNhWkJCUzNMZGFWZ3E4VFgwem9IK3JVeXNTSU01Z2wyQ0w3?=
 =?utf-8?B?dno0bXJuWUVaclNqeG02YWRJMEU1YVlwb1NkT1RwSi8wRGdXS3JkNUFXeHV0?=
 =?utf-8?B?VFhpdkd2SGtEVkh4TnlIMitBNG1YOW5JMEtXbkY1UVVjTXZ3U0pHVC9Rcmoz?=
 =?utf-8?B?Y2U0TVpCL0gwcnBOOGNidTZjRGFGK2JDWlFxZE5JN0h1TW9zcTI2VUZueGJu?=
 =?utf-8?B?V2ZUSE4wU3hETWhpQmFmOGlQSG04dit3cEQwVUo5VUprZWpQQUwzNkZWb1pF?=
 =?utf-8?B?YXJDcld1cDdXZ0w1WU5tQ1RaZk44bkZOaERiL2l5LzNuSXV3OXpGMDhNTGNq?=
 =?utf-8?B?SlFBY2N2Tlh5MnR5U0pBY0FiQ0ZJaW9mdzMrVko0bHlBN0F4UU1YRm4reWxy?=
 =?utf-8?B?ZTdrUzVQUlVHWkFZMG9obkZqQ0IxSnF3UCt3bFlta1lETk9HeU9abkFqVE1Q?=
 =?utf-8?B?bDh4QTFPNGtUMGNRdjZ1SkpRTkNUdDNsZlBHVElIS3o0RGFQZW9aTHhFeHcx?=
 =?utf-8?B?d3EwdHJwMFRQVkZKakFnRTMyZEJzempzUTRoTmtjWHNxTklxdHpBcFNySlZI?=
 =?utf-8?B?RGh5QVNyMHZLWnlNb0lOeWVhcEl6Sm1hK2R2TmZsdVlGM0NSZkw4d0FlM2lH?=
 =?utf-8?B?UENmZytLMU9FOUVkSVM5TmlLL2Y2bFlnVW9idzRFM2svWVhUVG1xbW0zK1hP?=
 =?utf-8?B?N1U5UzVsNG5PUG5mOGQvVkQ0VmEvUzZSTG5vWWJEbktiWGtMcVlDVlVVRHVr?=
 =?utf-8?B?NXl2ZWlYQ2lGRXV2S1lobHpzRUxuVDRUaDg4YmhBZ3o3ZlhzR1duZEFreGdR?=
 =?utf-8?B?dm9RY09vcFhJMHpBRjNnc3VOUjZLT2tnUG1ORjExT3BlSHFCaUV4MUNPYjJk?=
 =?utf-8?B?QWxpMGx5MkE2T3FxYnNFbHdQL2sxMDFRT2dHSkZTME5EZDc1dUs0aU9ETWxk?=
 =?utf-8?B?cVdyQ3lnS2Y3OFZzbnh2elJ4NEl5Vk5aTkZiV1Z1dTZwRjhVblhyUUdtQjZh?=
 =?utf-8?Q?oceG3FEf2lawj9WlVOwKpj2pG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d58b463-9f2e-49fe-c7c6-08ddc43a9c88
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:30:17.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7Bgn9o+Jy/Sc8ZlSml+Iuu5Bxlz2aumZDpZMkv+izLyJV3VZ6fTA1lpryBK3a+Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

On 16/07/2025 3:03, Jakub Kicinski wrote:
> Add initial support for RSS_SET, for now only operations on
> the indirection table are supported.
> 
> Unlike the ioctl don't check if at least one parameter is
> being changed. This is how other ethtool-nl ops behave,
> so pick the ethtool-nl consistency vs copying ioctl behavior.
> 
> There are two special cases here:
>  1) resetting the table to defaults;
>  2) support for tables of different size.
> 
> For (1) I use an empty Netlink attribute (array of size 0).
> 
> (2) may require some background. AFAICT a lot of modern devices
> allow allocating RSS tables of different sizes. mlx5 can upsize
> its tables, bnxt has some "table size calculation", and Intel
> folks asked about RSS table sizing in context of resource allocation
> in the past. The ethtool IOCTL API has a concept of table size,
> but right now the user is expected to provide a table exactly
> the size the device requests. Some drivers may change the table
> size at runtime (in response to queue count changes) but the
> user is not in control of this. What's not great is that all
> RSS contexts share the same table size. For example a device
> with 128 queues enabled, 16 RSS contexts 8 queues in each will
> likely have 256 entry tables for each of the 16 contexts,
> while 32 would be more than enough given each context only has
> 8 queues. To address this the Netlink API should avoid enforcing
> table size at the uAPI level, and should allow the user to express
> the min table size they expect.
> 
> To fully solve (2) we will need more driver plumbing but
> at the uAPI level this patch allows the user to specify
> a table size smaller than what the device advertises. The device
> table size must be a multiple of the user requested table size.
> We then replicate the user-provided table to fill the full device
> size table. This addresses the "allow the user to express the min
> table size" objective, while not enforcing any fixed size.
> From Netlink perspective .get_rxfh_indir_size() is now de facto
> the "max" table size supported by the device.
> 
> We may choose to support table replication in ethtool, too,
> when we actually plumb this thru the device APIs.
> 
> Initially I was considering moving full pattern generation
> to the kernel (which queues to use, at which frequency and
> what min sequence length). I don't think this complexity
> would buy us much and most if not all devices have pow-2
> table sizes, which simplifies the replication a lot.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

