Return-Path: <netdev+bounces-164395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA1CA2DB93
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 09:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57B5165721
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D261FF2;
	Sun,  9 Feb 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLlnyxeo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52733987
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089061; cv=fail; b=e83/HgwS5PlbOiy7uIQwJ6lOztvAUwmrxaTv47GMwtQj0Vp1kSJDmOKQN2df57lW6Chhpf2F0kiCLUjJUp2H5dYlxkKaUQBMsavus0UoFZCcUThw60XtV2v8iA3rI03Cd3xyqmFRtMusm2i8f+O2jUrjF8f7qoku+YWGtKWTPQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089061; c=relaxed/simple;
	bh=nccNHQZhvqr+pESbAQAEPcjVY5OFyWY9/IfuQRmVEuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KodXvIzRmzTUVVOI4MjuFhd8wBNNHUHptU2672bNbtVQf46kVt190cPh4WuqTkGMGNTHKY34KvjjX1MbPZS1zeb3mPz4qWLtDefXgyIEYuPCi77Mnk/qqetUVoHQCDws3wgw3JPodhE9g5M09j/Fldlop1cLiiybk+M9IKQWEic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLlnyxeo; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfPHQAWvcG0gkeFOV3OrL07CXx0Bx6f8x2icTkYKzd1x+P8mw5s5R3oHUKeT6sWsURzH9BytRqmO5BRhBtn/7TFb544l2hOVfdzY5U6yo8h8Wb/ZKpp1sXHFgyzBvHCF494FTNTfi/7YflEnTOaUggdT3y1kLHpg+pF6ZK9xdl2Yp2HeRfpiKHVpC0GSi92N9Bs2FPWJGEQCUpz08u2j1zpZtF17p+ivPaxNLtoWYpQeQlfS0sXrlU9XESp9whEyQq6pFIA4+jDOs56QNumkrXGTsGwX4EJg4ghJEyMsoP3gDFK9vX6huakzBgz5fqK9KGBpqVeqbee6KZJKiw4UiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayiNH6j1p/8M08AoA0KGS6bpVRO8leG6DW3Kba7cpag=;
 b=y7PQzeT7T27ZkfMzD6uaDuKnGFca2HaxjAyTYXgIsJu+q+2P5AvksYl7dBAJFnIPdb/5agsKP97oMpFNKuqzcIQRv/C5Sc6O9Thtk5U1BghDoymw88KK51bKinCWDKBB6vVblbhl/TnxaeeQBdxq/pMeLgh7JGAdKubWi1UZV2pxUwJkKtsEaFGT5E+bXhCbt5Mf2VXsLRg+2D9rxPajSEXrJVE/yjDQq4W631aQVl/7qGD14SAcih8U+A5Vt9Ak6BgrX5NzyqKjEhx+CI7sj6p2n2ym5p2LmHTNAgxWeNxhbf+yNlhXiW8MdN1TqmSNQd49LB+3/Z39kUtKtnosEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayiNH6j1p/8M08AoA0KGS6bpVRO8leG6DW3Kba7cpag=;
 b=hLlnyxeoeuKKYVSVFOmLzX8sm37sQge4cUEOdwUG9OQbwlqaqGLzuJnpuUxJJswiFXml4nRgGUf0VR99crltvCASwSRNRqHIlcDColRDcLfkBAw3yQ3lUcivP+9pZLn1efjgTKyPuazkQwG0DPuaQJjhQS7Fq/CgpDoUdbuyfqpFYupjkQWXEfZbMZ/01QkdRAOD49tDT99R316ChMNR/IJddQZC5rcOnbGCjxHjOPSj1SRnFcsx/9QeG4V5cI7HyYFnpcJjHLHgtRVEd0fJWEDgxKdG9/5/RBa5DX+fqQjvDIfLZ2nHfN0vq7gNM3f8tVyHC7amJGQm+hyKmUhecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 08:17:36 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Sun, 9 Feb 2025
 08:17:35 +0000
Message-ID: <de4a2a8a-1eb9-4fa8-af87-7526e58218e9@nvidia.com>
Date: Sun, 9 Feb 2025 10:17:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] net: ethtool: prevent flow steering to RSS
 contexts which don't exist
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ecree.xilinx@gmail.com
References: <20250206235334.1425329-1-kuba@kernel.org>
 <20250206235334.1425329-2-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250206235334.1425329-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b02e7bd-238c-494e-4abf-08dd48e23597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzhoUlVibWdFeEYrQ2ZxZWNKRGhVM244N2pjMW5CdUFmWnpqVFRYRmVPb3E4?=
 =?utf-8?B?VmxvZWNQVzgzcEFLQUQxc3l6SWZkdGlQUHNFWGR5K2htSUlmUnBnMTV5bjhO?=
 =?utf-8?B?UkM3dzl0a3hTL0ZVN1B4TFJtN3R6UFVLaUhDd0lHRUFZdUFodUNYeEk3cHlu?=
 =?utf-8?B?OWttOGQybWtJQUpsSEo0Q2VLU25ESVhJQUU1NGVsZVdteDlNMDViNDBlV1dp?=
 =?utf-8?B?WUNEK1I3eDM1R2xXd3JkVTFrWVJvRm9HS3lwS3h6T21jbm9CQkJRdDUwME5m?=
 =?utf-8?B?dmZHYUpBZU92NjA4T3ZHYnhNM29scUtJbFhBRzl6QWkrcW5XTTgxSHR3Y3Vy?=
 =?utf-8?B?a2lqcmFZOWIrU0g4Z3A4aGQvalMwYVpLQURwc3k1bGtnMmgvNGFGSTZiMnVn?=
 =?utf-8?B?M01hYnVRL25ZTW9kYXllV1hwbUxraS9Cb2k3Z1Y5NXU0Z0RraEZ0ak5XYUp4?=
 =?utf-8?B?M3JTeFdOL1JXbjZJUnJ0MGxXYm4ycDZtZnZBVHFVanVVR1VaV2lkWUVCeDNn?=
 =?utf-8?B?cVowazVCTmtCMXFXaFZ5U205dkFuanJoTU1oTk9xcEpzc0JHdlk1WDVrWEpN?=
 =?utf-8?B?bzludy9ZVFlaRXhwc1pJREc1c2JLWWtPTHUvVTV3cHhTRk5LK0Y3emlkaW1R?=
 =?utf-8?B?NVZtNGRBZ1dZa0p5dUJJSjUvS3hMYVhjTVJISGRMMUtTN3NxK3RnQzhaeXlw?=
 =?utf-8?B?L20rQ2JVVXVEOFJqb29ybitYTzIwTXhiQ3FUcElabUxseVFHdE1RNlNybnFR?=
 =?utf-8?B?em1DT2szc2ZwdW5mUC93Z29PZFdyVENRYjQvUmpIR05IL1JPSWNoUGtRZTh0?=
 =?utf-8?B?NVYvV09GQW5yMi9kUEFrRjF0a1BxN3BZcDRTNFVFL0l0aFByRHZQQWpEMnJZ?=
 =?utf-8?B?dUlUbTZKL3YyVnpFWkFsL29qL3lkVGNhMlp3RmZYUTh2Skt2N1h2d3czaE9m?=
 =?utf-8?B?WUhJSlNBOUVXbGYxQ2kzek1zZkRoL3lNYWx1N1hJYWZpaVFWZ2FOQ3FmUVNt?=
 =?utf-8?B?S0JiRmpvemEyUkVoUDRHUmpBemJmUlJPeGJPQW1WOFozcGNpYmdoWG16Zktn?=
 =?utf-8?B?TFdCenpjVTlpZUROcUpoUVdYTzFPdUNkT29GVmM2ZzhKM2x1dDRkTC9aMkVC?=
 =?utf-8?B?UWpsMEY4djJDb3NnVC9YRDZ6anhLQ2Zxdm10Y0pGNUdEdG9EMnd0RHdrQVBr?=
 =?utf-8?B?cWNqWDU0c1Q3ZXR2ckUzRDhCSFJaRGVjeDRIQUJOUlBlY1YxUGFEdXJPSzRB?=
 =?utf-8?B?VUFBeU1qcWQvNEt1aHdKVjNYcjBtRlAvY1ZhL1pUbzhYQkdJN1FoQzJBdlo1?=
 =?utf-8?B?UHdEeTdOdDVxa055NG5kd3Nzb0gxcmNBRFJBT3MzYk96QjVoa3VyL3B6dXEy?=
 =?utf-8?B?am9jbGEzOElPcTZOSGs2WUZTRVg1OVU5Q0ZtN3JQK054OFRyd2hDYThEelAr?=
 =?utf-8?B?cks4UDhRTDVab1lPK0MrMTJ0Qnk2L3FSUTQyQWVubE11Q09hQm1WaHRVbnoy?=
 =?utf-8?B?QU9PREJ3YmJ2VUpvUVA1aXR2UURCbmtveEovZ05mcTU0S0E2Q3dCR3BNQmN5?=
 =?utf-8?B?RHhsOHBha3V4ZERWRHFuUEtzL29TSnRDUERFd0FtVDFLakZNMUVKK2Q3bU5M?=
 =?utf-8?B?WWR6VGdsME5TT3NRL1NuUmdxZWRKY1lwdHQraHQ2UUsrWk5jMHhKalJFeHpF?=
 =?utf-8?B?NWd0ZFVOazh1WU5WVVVzZy9KZHA1NS9wcEhadHNCeSs3MlRDUEJwcVBiMmlJ?=
 =?utf-8?B?ZkkxeDgybU12VWJOL2RVYjlQREs1RjJGckkvcndSSzF2eUFOaHZFOW8vL2kx?=
 =?utf-8?B?b1lRbkZaZTI3Tzc2VTBTRkJFMmJmenYzL0lOOXEySmYzZG1rYVBkOWFOQVBy?=
 =?utf-8?Q?w3qcNhrn9b378?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDhTanFWeUxWZkxDN0tBVW1seithNUx4bEczRWE1QXpSTlZqUlQ0Z25jSkNl?=
 =?utf-8?B?d2RJN0xGWEVDWVY3M3lQZkdCWG53ZUVZOFlKT2wwNkJKZGpYcy9XTmtPbTRh?=
 =?utf-8?B?OTNkV0JWOTlYMHg5V3BmL3BVbUpkMElma01uU3h5dHRaWU9YTlNFcHIyYjFJ?=
 =?utf-8?B?NGQycC9PV1cwcFIySnVNL21lWVRRZUd2T3hNU2ZVNlg0L3FCeFcyV2lKRkk3?=
 =?utf-8?B?QXJGc3ZPdE1veDUxL0srVE5idzZzNzNSd01RZTJSQWtTamE2NEpNRkg2OTMv?=
 =?utf-8?B?OTE3V0g4VE1hVlcwbDhRZk5ZTm8wQkZoK1hYQ09raGFuSGgvWTZDekVOM3lt?=
 =?utf-8?B?Q2diTHhiR1VXcWwxSUhJeGJzeFdMdXJ5MW5vNU56VHZuQTA5TWt4OTNsd2h4?=
 =?utf-8?B?dVIxU3IzN2x1aEtUdkFhbkZkSDYrS0pyRkZMcUFBWTRiOXVVbVhxeGN0RThu?=
 =?utf-8?B?ZHZTUno5R3Q3UlhtUWIzcVVLcitHUDc4K0ErNUlJQjQ3ajRjL3VPMXlFeWFy?=
 =?utf-8?B?blJ0S1c1UUR3ZlZySlh5bVVNZkl2eUQ5WGZkQjhkVDJib1dVSDZlKzZjT3Nz?=
 =?utf-8?B?TVJNMmlXUFhlRmpJTTBXUWZYTDd0ekU1Ym9sUFYrQTdkcHZYQVQ4ZjhtSXZJ?=
 =?utf-8?B?MFU2aTAzZjlLaWpBOFV5ekpJbmRVMktVdzVSRHEycVRId2tNSEFJdWtXMkhi?=
 =?utf-8?B?M05QR2RPRFZvR0k1M2pPbkdwV1VmTHd6T25CUG5PcFJSUC9nQnNPNy94Lzh0?=
 =?utf-8?B?Tlpsdk1QYjR2Z1B2RzdMMUIweG1wdm5ha3FNVEU0aXlpQ28yT1FXbDhiUlA2?=
 =?utf-8?B?ckMxTExZdU1CS3U1V3JaL0ozK0w0S3kvSjNMSmpVQ2RsK2RRN0FGYlZkUmU4?=
 =?utf-8?B?ZUwyM1I0NHVWbXFvdjNaTVNrNUp5R25aSElmbUIzMnRuM3lYTkVDUmx1ZTQ4?=
 =?utf-8?B?b0tqaEZ4dC80WSthc0RJRGJGZ0NzaExVc1lROThkdkVnMXRvMC80cHpuTzBj?=
 =?utf-8?B?SDRSaDFtbHB4d1JYTExkRU9PNjRZN3JoQzdSZFp6WmczdTJoQlMwRkpzSGE1?=
 =?utf-8?B?akR1TWxFOGxVaWROOUQvcnpFRkxSSVVWbmNjNWljL292VTR3SmV0WVk3SmRT?=
 =?utf-8?B?TytpemdNSU5VS2FlUDV4TytwbzdMcDZBdGdCeFZidDlNNENQcFdhZXo5SG5O?=
 =?utf-8?B?aFc4SHRtVmFFeEZ2SkYyTHJYODdOM1FaRU14STFqUnBoeGZQR0FxY1pGMTF5?=
 =?utf-8?B?M2lqWEl2TWZWQWxWZEJJb3YzNzQyVGtUQ3B2TzVvaUx1elViT1BwQUtjSzdQ?=
 =?utf-8?B?L013SUc2aGlVRjJldWdYSm1tVDBla21DdnViQ0RHUUNXT3g0KzRXcHo0Z1gw?=
 =?utf-8?B?T3d6S1hnWDZiUnJlWU5YZDB1VVYxWnNmR0JBdTU1a09yUGdNSFJKbHdrOVV5?=
 =?utf-8?B?QkxLajFRMDVWbmhNNkZGYXQ1WDFmUklSYVR0QmQ0T1ovV3hibWw1T29FelJn?=
 =?utf-8?B?bXBkZCtFOVRxUFZ2a0lKUzNmbVNnc056dnpPRWNiSVBtMmVtUEJ3TS91WkEv?=
 =?utf-8?B?NUtMTjlEMDJkMnBLVXBCbUxoQ1JyRmJxRitSOW1ENmR1WTVDb2t3N3NNdlFH?=
 =?utf-8?B?bWt1bEg4TUFYUm10SEcyb2RXcTNBTDlYVjc4eFdmMER1MEtBbEI4UGxXQWtF?=
 =?utf-8?B?SHR2V2srTGQ4R3N4eG1iY1d3MW5veDY3WkpJYjhVVVhNNnd2WHpMNCtCTkRN?=
 =?utf-8?B?QjVHOGZrTEFGWXkyMURCM1pja2VybDY5Y1c3SFNFUGpqeVoyNy96S3ZJUzUv?=
 =?utf-8?B?SXFwdWZmSlYvdVVwQVNndEtPNzVRc2I2Zkc2c1BsVk1NcXJYZTUyZDJsSXpk?=
 =?utf-8?B?WWhQc2hPQkVtK3RHTVRwN2ZrV1BQLzM5VDQvdkR2SEZnUUtyL0pWVXh2Wjdh?=
 =?utf-8?B?QjlyZ3RuUXBkVkJseUl6K2xjSGdQRWt3MVpVUm5nMVZzejNudXdlMlprQS9m?=
 =?utf-8?B?Znc5MGtMaEpGUzBHQS9TYmJ4REduayszQ0g0Y2Z1amdxNHM2RHdmdDVQMWl2?=
 =?utf-8?B?M0JFQVlsTlNrcnljQ05GTGIxeXAzNzhvRG5HVG0ySDlJV1JDNzIyRXJsdEda?=
 =?utf-8?Q?v71RVVJrowtbqnifWAybFghA9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b02e7bd-238c-494e-4abf-08dd48e23597
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 08:17:35.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s7Bx9iclGDUkj2lS0jD27k4Vvq0Z5koYBttPV0ToZ3FA6c1ZvR2H7yCJq3Pbw9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

On 07/02/2025 1:53, Jakub Kicinski wrote:
> Since commit 42dc431f5d0e ("ethtool: rss: prevent rss ctx deletion
> when in use") we prevent removal of RSS contexts pointed to by

Nit: I would try to avoid the line break in the middle of the cited commit.

> existing flow rules. Core should also prevent creation of rules
> which point to RSS context which don't exist in the first place.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: ecree.xilinx@gmail.com
> CC: gal@nvidia.com
> ---
>  net/ethtool/ioctl.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 7609ce2b2c5e..98b7dcea207a 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -993,10 +993,14 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>  		return rc;
>  
>  	/* Nonzero ring with RSS only makes sense if NIC adds them together */

This comment should be moved inside the if statement.

> -	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS &&
> -	    !ops->cap_rss_rxnfc_adds &&
> -	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
> -		return -EINVAL;
> +	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS) {
> +		if (!ops->cap_rss_rxnfc_adds &&
> +		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
> +			return -EINVAL;
> +
> +		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))

Accessing rss_ctx without rss_lock?

> +			return -EINVAL;
> +	}
>  
>  	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
>  		struct ethtool_rxfh_param rxfh = {};


