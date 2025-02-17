Return-Path: <netdev+bounces-166994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC21A38435
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEFD1897B47
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6C21B1B4;
	Mon, 17 Feb 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TwaF+1C5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7721C173;
	Mon, 17 Feb 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797830; cv=fail; b=nlsP9OckCpBX/mvwd0thbpWdVipwWftkS90XmShkeJg45gIALkRySXn+5BsqkqplqVPw6EbZ9zSw2DhLA/B8/jad99Rg7B1OzSqd9EcF7ieLrffsexvdrT8JNZCRXN3OCW50XnUQXhQS9MqAq/cojycdJ4OPtrEwlSy7bc65Cn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797830; c=relaxed/simple;
	bh=JKPB1mZGpHD/eQJbLegGIMUBITF2YRb9V6+f9xasFDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lH3VPOdyMsq4UPKcApyLIgRFQCId8fPsQTQnBRuTFYw88QQp8a6nEJWGEJJE4l8ACmq9GBHd7fOscBKA7jtg3Rf5/Kt5jFNK9gkerNNFvu0p0BoogZrZKfrMD4uf2BrO9UcCfsIAiifhzvk7ix3qtPdF+e9jFB2x1QHwQ4/pm0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TwaF+1C5; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D421NwUYcyZcSlO91O0xDnl4bWN0mLuOoYQSHGGX8cyTsla5lDT/dH/P6mCHr5PsFs6HDoce7cy7LbluHPGgghvysuFQ0L9B2iZpQ5pgXxn2fAkgNDvsZ8OHqWAIkcG3TJf0dC0TYqEZzGTPI6NC046fc9p/c97x5VlohzFVz51ACIgO2o2wNlp+w/6Gp/CgzyoMxJu3RA+ukNiz3t63t/UvwNNVoEgainDagylYFcsLuXHPKqZBB9fFlJpk5SggwivQxwphNsnAuJ3NMFAZYh9rKqFybTZpgdjHzOkCuMBgwOyq4FrHjX4cEQbf5neBeGBAInY8EELaysvkBO7WpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMVWN4ctxASgxk5ZAlDPYrHd3qncSQCuYJsBXka/Hwo=;
 b=QxBU6ZLlY2xGJKDD29KOde3HMWieCJnRxsAjws/fYOI/+W5ZkO5xAIAgmfO8Y7X1yknmn4y90xKlSHa3wHDsuA2cWfFkh1kgDlgkSXsxUtxvwu8nLYyoLedKe9PW0stIJLkXz4VB96gi1RBPEg59e+gTjx23a9ORJzqXIW0I0r3VOpQDO1nIxTFT+4k8uTuQNCiLl/Bm4BXdfdD7LK55uKl0dyncmIv1bvWTrCnjOnZvUn01+Cg7vIooi5STQ6XBQyxaZQQXME/1Q+KdGfpNC2lHDs+sysWnFG4D5msUA3ioLOrsrzx/z/7agA7YLfwZjuEWclkpxY94Wlcs/ZcTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMVWN4ctxASgxk5ZAlDPYrHd3qncSQCuYJsBXka/Hwo=;
 b=TwaF+1C5PUM8ytGuwj7LsNGq3TSUvqnxbOuWvAYamyphUads4nvPWrbmLaUeSzgtVYb0olJ2Rb3UVpxDkF2z9nG5CvIa8GesPELLOP5GwWtoxJLDQSIjZqc1k/4icQztNEql1NoXMIVXPv7d00XG8dbKAuHlNS0Y37qSB2TlBXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Mon, 17 Feb
 2025 13:10:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:10:26 +0000
Message-ID: <7ba1c660-8981-4cc2-afa6-b930cbc60235@amd.com>
Date: Mon, 17 Feb 2025 13:10:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/26] sfc: add basic cxl initialization
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-3-alucerop@amd.com>
 <20250207124846.GP554665@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250207124846.GP554665@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0036.eurprd06.prod.outlook.com
 (2603:10a6:10:100::49) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e49a389-a8c2-4a65-6f51-08dd4f5471b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?US9lSU1nTWFsWE5MOWhtS0ZEUGhOVlFOQTdXTjZOV093bFY2SXhERmVEc2hB?=
 =?utf-8?B?QWtxU2EyRkhhWlRkWE12bjdIV3lDS0o3Y0lmSSsrRUZ2elN0ZjZOSTVqUW9G?=
 =?utf-8?B?bmpDK3hpbEV6UU9lMENtM3V0bFRtTU91ZzRiMnRSbUFidkIzd1dUMHNXM0FC?=
 =?utf-8?B?TXN3RkxYM1prQmh4ZUd5OXhIeGNkMm5pTkIraExKbWZRUW5CUGRaL2FFVU9l?=
 =?utf-8?B?RmkxdmJnVm5ZWUF5clZiaVoySDVhSzY5VTJ0cURhNXdXMGRzVk1iYk5XTkVK?=
 =?utf-8?B?L0R2bkY1NHhIVW1ycjlPcjdoaWJmci9DT2F4YTUvaW94Vyt2ZmlvLzJxTmpU?=
 =?utf-8?B?UFRvb004UUJkNXJtL3RIRStiK3VVREd4bnVHNlNoeURmUXZXVzkzR0tvbUNW?=
 =?utf-8?B?VEx3SFZxekhJR3dTamcxbWxrZkhpR0dYbmlTbzFoRG9IRERNdFdtcTQ5a1Vi?=
 =?utf-8?B?aG5hY2lqU3VGZm4wNUpUc1B1clBHMW5EZXJIejRxaHoyWmpNSlJuaGdBemtu?=
 =?utf-8?B?UlU3SHRVM2pOU3Q5ZFc1NE9VaW8vbnBvY21oR0FZV0twdEJnWnJROFlRc2xi?=
 =?utf-8?B?TXpCRDFWelJBM3dyaHZJdzI2VHUvdGwwWFZIamtZbFBKWFpndkNHS2hzRjEx?=
 =?utf-8?B?WHVqSzZLR2xlMmVqNW5sZEFIREtyUGwxSE13V3FPdk9USldpczl2dUxLOWxl?=
 =?utf-8?B?Tm9XMmt2amprelpmbFI0Q2w0d1VuL0gwemd5Qk5FRVFUQ1RUWlJTRW1VVG5D?=
 =?utf-8?B?S29DNHFIbTZ3YnBEQmRSV1doMTRVbUhYNkxNLzZIbElDR1huazBzQU9PZG85?=
 =?utf-8?B?NzRodCtpN1JvNGRwZG5GalZzRG1pNmJhMFNMWkZEdDVvR3F4cXc0SkJ4VzdG?=
 =?utf-8?B?U0g2cUs2aG1CNE13eFhQZlBjMkJxR1VUNnhINnpCcEcwWWsxazdrSzJhcGVm?=
 =?utf-8?B?bHFUWmNRaVZ2YnFLSzRybjR0QmdHUUtJS2JpbzRXQVdueEIwWmV3OTFYN0Nk?=
 =?utf-8?B?ZDUzWHhTempHekhiT2lMcnBqZ1Fxc1RIMGdRVVpQaUNCdTNRbWxnWjJKcVUr?=
 =?utf-8?B?TVBwcDR6cHBSZXJJUTNLK29NTGhuK29GMVI1a0JOaXNCYUhpbEFVdzRsdHo1?=
 =?utf-8?B?cWUxQ1hjOUhzQWVaL1pwRGIxcHVtSWZRNjA5VHZWS2wxaGhSUVNHVUw0UFl5?=
 =?utf-8?B?alFlWVpoRGZSRXN4K3JUZHlOdEJaR09jZ3pFTnF2U3FYamVUZkJyMnlQc2tU?=
 =?utf-8?B?ejl2RzI4dVk2NERQUExuWm4wM0dKY0ZOK3Y0aVd0UktXcE44S1kxNDNEcVdX?=
 =?utf-8?B?M1FyekVkM3czWlNPZUV3WGovb1BOdnJoYUU3ZlM3TGtyTFJGcmdyVTJtVUVB?=
 =?utf-8?B?Z2M0NDZjSFpoMjN6aXhlMUVsTzl2ckFOU3FMVEV5cS9VZDlWbExIM0ZHd08r?=
 =?utf-8?B?SmpXa2VCS0syQUlGMGtOTGZOaXkyN1VhNkVBbGZLR01DOEtXTUlXbGN1Tm9R?=
 =?utf-8?B?ajRKdWh3YWFwaDJTZHRWNGdvaGxENG5GRDg1TDNwazNZaUY4K1V1alRRazI3?=
 =?utf-8?B?UjcwRnpQTGE2UjgybGdlRkVnbFNCMHkzZE5UVEk0bFpZck5hUkNBZnlwQ2Zp?=
 =?utf-8?B?K1FpMGN3OXlidmJoK2VweFlwZE8zSDk2MUNsS01sUnpkTjRKdGk5QW5Ob3d1?=
 =?utf-8?B?bS83aTQreko4SEJpTVVVUWZWTlUxakNjS0xlWW0zeGZCekdWSFJIekpaL3NX?=
 =?utf-8?B?cHNydExXWGJPK0cxVjZReW9xbWhiZFhiUHhWeEEvOCt3Nlc5MGQ0USsyM0I2?=
 =?utf-8?B?dmtPYzZFN1UyWXBSUWM1SW5XYkovS2tacDY3VG9UQjlIQ3VNejhsYWpCTGtB?=
 =?utf-8?Q?zMoOTwfaSTl34?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUdpYmNEa2szSTZmOWRNdjdQQTVpeC9FV0VBbkxRbXBHNXE1RWpjWFlSSWNB?=
 =?utf-8?B?Y1BvV2k2N0xpdkxVdnNLRytFSzJJdGRiRDlsa3MwanljZVdaUVd1ZlJVeUZF?=
 =?utf-8?B?NG5vLzJMTzBaanJJZXBzdW9qU3hWVGtxa0pSUnN5K0dTNEJjTWl2YldLallt?=
 =?utf-8?B?aU84dzhGbXd1K0t2Y2VBSjVGRnM3a0w1Ti9QMStuQ3ZzLzNJYi9MYVRHelZF?=
 =?utf-8?B?T2ZQQURWTEdVNUMzZjBEMHIzanJuejlTZVpneXJ2c3VkQ1p5cENKR3BFNmgy?=
 =?utf-8?B?Wk1BVnVDZURZY3QrNlJneUhham5VOGxzcmdNWExNTjNyYlZUdXNEdVA1WUlP?=
 =?utf-8?B?SEdWRVJvdU9OZHlFbUFudHFmb1VaREpTQmZMcENhc09qbDVkaDFaWmkwMU1D?=
 =?utf-8?B?UkhqUXlsd1F2OEh1TnVwU2xwNThIanF0QUllZmx4aFpkdmNWREs3NzE1M1Jz?=
 =?utf-8?B?UGE1V3lmQWxZK21PVjJUNkJvYnBhZEl4M250U1o2dWhWSmswMUxBNklQN3F0?=
 =?utf-8?B?NWV5ckFHbW9oOW9zU1IyeDBLRW10aVNmR1Z6K0Qvc1JRZlhTY090US9nQ1Vp?=
 =?utf-8?B?TDhPZ3JyM2F1TzBwMnJEZHRraWFPaVYrM0NoemNtWkVMVDd1Sk8xV1RTSnVj?=
 =?utf-8?B?L0VLK3U4NEozMVoveEdIRHhJaU9PUUNWV0ZVNzlDZGwxcnkwSHdQSHlQN3V1?=
 =?utf-8?B?K1dCVnQ1WW9hV1QyeVUxWUVDdkUrS3k4NjV6b3JWK1VDWDZvVkFVYUVRdVRW?=
 =?utf-8?B?UnkrTXZOc0x4M2tXTElUSkxoTHEzeVNpMUxudno2OWVXUTVjU05pV3Jnd3Ri?=
 =?utf-8?B?YlQ1NjBxZlNFQzVVek1FdUFBYk5pY2E2ZmxQdWd1VjZJamQ0SDYyUHc0UFJ0?=
 =?utf-8?B?YXp1aXIraFA3Z1paQWN1RWUxMVE5TWV1cjRPM08yelFWMy9qOFZMZUhSQi9J?=
 =?utf-8?B?TytHVCt3cXVuMDNOWjdXVFFiZ2g5OWRCc21oL2xydEVScXRSZUxSQVVkM0ZQ?=
 =?utf-8?B?S3RQQzM5djhQdG9rVWJScE5OeHU3WFIxRDNRTE1VTjd2OEZGNzZhdXVPVXFx?=
 =?utf-8?B?c1VRQWpSbTRhbVJXWUJJaXFNVDJvQjFYTFlzSm1UNEpsYk1yWmVOcW9PK09V?=
 =?utf-8?B?MTVqb3c4TU51NUdmUDdNUXhtWnAwb0xuVmxRR245RGJZaTcrckYra1MrdWxJ?=
 =?utf-8?B?Mk5SaDZJMnpyQ1duWFVGbmIvNFhMaFdzWDBFSTFRRk4zQUYrV1p3UWZpWVBL?=
 =?utf-8?B?TG1hc0JycVRoSXRHcFQxTUZBNmEvVjZOR0Y4emZDeElpTkdldE1xUnhjSWRa?=
 =?utf-8?B?OFlIUlJxNmZJbmpTUXBTYlhhbXJmd1JacjdiQlpGaWFCNkU4K1pMY3Y5Nk5Q?=
 =?utf-8?B?Kzlta3R3cktJSkFlenM3WFJuYm4yc29oalN5a2NoOVRjcWJpNG1vQWptNGhT?=
 =?utf-8?B?Rjl3eGFYZU9nZFJrODR1UEd1T2prUXZuUHpzNXhOV3JVKzlDenUxc3J5cHZQ?=
 =?utf-8?B?bkpCb1BmWHdHVENLK0JKb2daNFVmaDRoUlJ1NCtMRWN4NVpvUUJibWd5ZENK?=
 =?utf-8?B?Y21PQjF2R3piZ0hoNnZpQjBTbS9OQWhtL1VZYU9HMzA0RzBTTForY00reUVl?=
 =?utf-8?B?Rk5TcTRrbDlHTG4wcWphL2Ftd0tKOFRoTlNPQlQxeDBjN3p1ejRHNHNhcjJE?=
 =?utf-8?B?ZnUzNlV2MUhXR1JpSUFHMmNwelZSRFVPVDJtMlg4dEtHOGF5V0pCLzE4Q0Z1?=
 =?utf-8?B?M3p0OUJ1cUNuZDRHWk1Jcm1BSEhiZzE1TU9XVVduQjkySzBkL2dwYU9LaTZX?=
 =?utf-8?B?MmkwL3BFU09kRG5YeGlXbnFlaE1vamJqZTFwZVZuaTYrL3Bad3RXNlZJVWx1?=
 =?utf-8?B?Wk9ONk1Ub2VGdWRkZnQxUGp2Q2syKzBlTDFsSFVLVHdjak5OV0dGYXliWVRN?=
 =?utf-8?B?YkJ6Q1JPWmk3emUvQkhQY0dzMEdvQ1lBZnUvVkZOWTBZd2NXWUg2VGxNRXhC?=
 =?utf-8?B?OFd0WGZBYUJacmNWU2pQVVJRczVGelhBVVhFRi9xTGpadUFTWXl0WWVZN1E5?=
 =?utf-8?B?RDJ0bFNuRzMzQkpTblo2cmtleSt0bmRMZnM5Si9EWW5qVDI3YTFFTzk1UHVY?=
 =?utf-8?Q?PfnNC7sPBWAbR6tvMnJYyWZ2L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e49a389-a8c2-4a65-6f51-08dd4f5471b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:10:26.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgOC8UOMcAlHXpT/go7mpecWRHC8qalk3bjVxqbx+3k+2SN6dinbHz4uUEllMtuViyNL57CFa6zhRrI+yxxKzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864


On 2/7/25 12:48, Simon Horman wrote:
> On Wed, Feb 05, 2025 at 03:19:26PM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a cxl_memdev_state with CXL_DEVTYPE_DEVMEM, aka CXL Type2 memory
>> device.
>>
>> Make sfc CXL initialization dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ...
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..69feffd4aec3
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,60 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#include <cxl/pci.h>
>> +#include <cxl/cxl.h>
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	u16 dvsec;
>> +
>> +	probe_data->cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	cxl->cxlmds = cxl_memdev_state_create(&pci_dev->dev, pci_dev->dev.id,
>> +					      dvsec, CXL_DEVTYPE_DEVMEM);
>> +
>> +	if (IS_ERR(cxl->cxlmds)) {
>> +		kfree(cxl);
> Hi Alejandro,
>
> cxl is freed on the line above but dereferenced on the line below.


Right. I'll fix it.

Thanks


>> +		return PTR_ERR(cxl->cxlmds);
>> +	}
>> +
>> +	probe_data->cxl = cxl;
>> +
>> +	return 0;
>> +}
> ...

