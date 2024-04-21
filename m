Return-Path: <netdev+bounces-89875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3678ABFF3
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766451F2106A
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947561B969;
	Sun, 21 Apr 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j7MSXqS6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85215E96;
	Sun, 21 Apr 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713714865; cv=fail; b=Zn4MbNutjvJEpRPwinfvT3Vfch3ijpywOQsO/eCWjKUm73BwZvcqPufShnSQx36YVODQsybn5CTF+UvOvEBOINFc/lghaM93NS2oyMnk5U0aB3SC0ZKtvJdcu6uitdBuOId8JLi6wxnE4aBZjbD6IiA2MGBW87/wuEZEm2tFGcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713714865; c=relaxed/simple;
	bh=5YJH/cSQKuuvDeoFcfGwFWn/qWBrF0/X6Sm8y2gfHWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SIaTnuby6L8YZtPncOU78nisl0iSqjQ6fMbpGvZu8vggdk+X2hCL7Evvjtbu/lrlkAl0qnqWG2rmkk6J0w1djQUqU33Aa1gcQvFUWj2a8kD37snQRXt2vG8ZGG/FdSJlwp1pCsYeP/5Rake8Y4fEhsma9noXpbfwVXAQ/rs11bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j7MSXqS6; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhTw3OVljFWap1h9RAx5rQ4VRkPlP1U6nedhm73Q3L//iNMvooCBvUBCpxz+vormxQDhi4xJl6RPk+7lazuaVaaAo9LwRDjEGNo98iznlclV057lSss5B49eFk5FYzU5oVzOXMaPuq0UCo0Xw2e1KbQyLMsuueE2xzFOBkklkRsxkwQLY3C/u+Y84mlKcwltsUMlGTs7EXHm4+XCJF1gF7m4oJV/iuotVK+6zG7vstvvEhFYR8EgriPsjv1hEw1yGtDLxM7hV5R3zmtHdsGuqW8Tl97pXcVU8d+E0najfFdLW6eIyVEFzNAb9Y1OcaJ3hR491i8KXLsmpK8BhLaQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unmoy4Wsvt3UkWmR7+LT5t4K4bdocTyCkzSH9AynAk8=;
 b=InkifdfL/G3Bb9UA873v55Cgr1bNIXtx6M2/Q5ydgDycADsAMD8KylAugRTPwMGvIO8/6FRA2Dl+Z/eVgVlN2WybMbzhvBCoTNmoWYty9uoJ9+cpGycCUEa4Jr5gYx+q1cPRvUXoDevlMyM6+unjPOqJnMBM5ZmjZ+QxNV2c8KDfpTXMZtHbZEgzu9hFg8DQ9E+EcSPGnOeuZe2dcSXpogtP5Xz2NAonfQ6HHhQDsbQqcCKdIvNPW9xH605FtCDiF0CcFaAhXZ2Q6x+3yih/LlZ45qeZzucauhO31U3PQF6Odu3qrcZptjPCO4AiO5BoKqERwpoLWKl+Ha6zrAdr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unmoy4Wsvt3UkWmR7+LT5t4K4bdocTyCkzSH9AynAk8=;
 b=j7MSXqS64ATzePGe5qFROtMc+vHbmot3h1APqyodqLFegyEkgzcZwsDsl5QUN+KpUjYxIA0bHPGYRII4Ue+V3Jmn/gh9l3kL7Hc24nkMqrQDuK0YKFOGLsM2zBKidSWmCeX5EobhYrpB6x/F9kPAqK7UEYyaI2+J1MFK9UJc4Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 15:54:17 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::2466:719a:448:694f]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::2466:719a:448:694f%3]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 15:54:17 +0000
Message-ID: <c59ebd40-fe9c-477f-9ed5-958163470f03@amd.com>
Date: Sun, 21 Apr 2024 08:53:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, "justinstitt@google.com"
 <justinstitt@google.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
 <20240417155546.25691-3-hengqi@linux.alibaba.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240417155546.25691-3-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 3382d50b-0b21-446b-eda4-08dc621b4ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3ozMyt5cmN3S1BEaDNld0tFczQvQzh5SDNLa3QvMFNCajBmd20zam9yVW9r?=
 =?utf-8?B?MXZLZk15S1RDb2RyRVBBRE5NTjkrTFp4RjFzSGEydWpYckRsOTdWTjZIMlRZ?=
 =?utf-8?B?NUFLVDVhVzIrQVRFTSt2K3l1RGUxUnhwSm5vVEJCSitaemJpMWFGVVFYOThq?=
 =?utf-8?B?NVorU3FoRGpROG96WHpxMnpCcDk3UWltU2Y5ZzdPL0JVWkowK2VHQi8zS3gy?=
 =?utf-8?B?cDRRcEZxVFVvWElvOXVNelYxUkhuMm5POUJncEI4U1U5RTc3MWJvWGRvc0dE?=
 =?utf-8?B?bkRDMGlBNlpFSy9MbjZaTXBzZkNqTTUyQzR3Q3k5MUl4RjNpUVg1M0pXbWFu?=
 =?utf-8?B?bzgrQTJBK0FrZWh4aENQa2ZuZmlUUDdkbFVLZTF2QlB6c2dHRWZLMmFsUGE0?=
 =?utf-8?B?QkdrZFNEbE5uQ04rWTdiNVJsQUE4c1pPREJFTUpHamEyOEYxL0VmdjByM21i?=
 =?utf-8?B?MWxHMk9xSGxISmU3RUprcnFpcVAyNUFoZm1MTC9ybVE0N002eDVnMUpIWEpK?=
 =?utf-8?B?WmM5d0loTjNRMXJRbEpQdHpjRGh1YWliWlVDZkN5akJSWUNodzBkMENNMm04?=
 =?utf-8?B?RTNhYWFYYVdQWVpSbHFMYUlPYkFZREZaVkE4SW4wUFVOandQMUFrTElnRWRv?=
 =?utf-8?B?VU9SZldCWFlxZmovU21XVkwzL1pSTWNVY05URC9SS3R0UEdCcllFb0tEd1Ar?=
 =?utf-8?B?V2tjNnhhL3BPenMwZXNudS9tYXJOdmJxa0N1ZS81QTlNSTVTUzhlRHBpOU1s?=
 =?utf-8?B?QndKMWY5VG94RnFTOWNmMHlGc2NNL1dWMTRVTHlGMjFVK0RxSHdsQ3phY3JV?=
 =?utf-8?B?U25wVWwzT3g5K2RiZFJUZDBIRm9rQTdoeWJCbC9tcHBZdGF2YjB4d3ZuNlYy?=
 =?utf-8?B?elRwcU1iMFlMbkRpRE9hSUliOUZnNWI3Wi9lM3cxODEvNjRYZ0s0NTNNbDNH?=
 =?utf-8?B?d2F4ZEpNMkhtZ3RicDJhWUVtL09lSW8rTG5yeXZCMmVKb1FmcUIrV0dUTW9G?=
 =?utf-8?B?TzcvbzBjSmMrTEJLTkJ6QTJiUTdLaVV1b2M2WmRSOHlna1NneDJJSkkxbEJZ?=
 =?utf-8?B?ZlhkQm1iVlB3dlZEVG1udVJjSlBzdW1Eeno4eWJ3QkduOFZqZkpTNWdzZmtT?=
 =?utf-8?B?akQxbVduS1BNUHJPRTErR0tXQlpHcWE1SUtHZW05NG9xOGtoZ09sNDI0cTBx?=
 =?utf-8?B?b3FLcG0yaTlqdG9SN3pwOWpyckVqdTUrTmFJMnRodzgyd29pVmVSb2EvN0hv?=
 =?utf-8?B?TmFZMmt2SXFhMW5LazhPN0JCaDJWMW9zVHRZQ2pYdXdsZU9kdGgxVVNRMzY0?=
 =?utf-8?B?bU1teUdVRjk2ZWluYzk1R2tnZmRnVXd3bzJzditzMVVuMWl3MFdVeHZrZ2VR?=
 =?utf-8?B?TDg5VGxGTnpXcGxSa0E1U1pvNEh2T3R1VFArUjBxNDhCcTcrdzNHNUo4cEVR?=
 =?utf-8?B?V1c0WmFhSjZhZkhUcjR2dk1NaC9mVHc0VjNLbzZrUG1rK0FrS0p0aWJ1Z0NH?=
 =?utf-8?B?aUJkWmo3R1V1VFUyME1hNElaODB3dFJLaVBSNzhNTjFmR2lBbS9ZUzlyZUtl?=
 =?utf-8?B?OUlIQ2I0L1V0eDVvTk10Z1grT2FjLzU0WFl3aDl4eCt6ZFYrbE1LeVFJYzBt?=
 =?utf-8?B?blRjQ2JSN3NjWnRuOGVvNEdPRFlaeEpxajRBWVdJaWI2a0RvekFqSGRHb0J3?=
 =?utf-8?B?MEI5dTc4QUNMS240S0RCRzBhNWJIM2hheWNNT2hqRCt3b09oa1NlOW1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWNqZTF2Qjhha3J1SFNqRlNPRnVaTlZRZHpSKytWSjVGdGdUbE5xczZaYmtJ?=
 =?utf-8?B?TnpmOXlYV3crczFMaTN5TGdHYmdYeTdFSnRoQ0hObnFhcGFleDRVVzczSVZS?=
 =?utf-8?B?aXptdmplRjJPVDhuZ2NyTTF4RlpCWFVMVEpXOE4ySitjb1NHWHpFTU8xN1dC?=
 =?utf-8?B?MEdLWDhoL3JqSllLR3MwbW9LVzNHZjJxcmhjeVE0dk91NitLUGNWeVVPZmd2?=
 =?utf-8?B?MzEwRCtDN1JFU2p3eWpTV3NoaytEOE44RU1JM1NhOUE1c2l4a01mMnl4a29N?=
 =?utf-8?B?OTBrQ3JFd1Q3MXYzVWFXOEpUUVBZSjdzVkFrQ1ZnNVMvdnJxS3c5eFpSUmdE?=
 =?utf-8?B?QkZiZXN5MjFBRTgrTEdXV0MzcnpOL1F6M3ZXOXI5SklRWFErdUxMOTRsbm9k?=
 =?utf-8?B?ZGE4OWtUSzlQSHRwdVZ5eVh1UDdvS2FoUUZKTjJ3Rk03UUwwUWNGNkRwV3pX?=
 =?utf-8?B?VDlzRnZEcnlpRytUVDNGNlRiM3FkYURXb1ZLdGdXMEdkdkpYWHQ1Zk1OQUlF?=
 =?utf-8?B?bW43My9SdmpmaEIyZ0dxU2U5cmVlbTVrV2pwcFBGK243K2J2THcvR042cDJp?=
 =?utf-8?B?N3Z6YnhDL1FJa2lUWXJuN0ZsTHVoOW1aNGlKeFRzd0hYYnFxVkhjWGtHWnE4?=
 =?utf-8?B?ME5pdU5DNWROVkk1VDJxazlnNTJRZkdPeDJBMmNNZC8vblcyVWF1VytZU1lI?=
 =?utf-8?B?b0VwWmlDZlZZQ01vMUZhZE5NSWNPZGR3dFlDbDBtUXl0d3FiZFAzKzhlc0NN?=
 =?utf-8?B?NmRRSWo1ZXcyRm9pbmE3bURHYlhsaTJJMGNNR2tLdUpCMVMwTFBDT2k1WDRV?=
 =?utf-8?B?K3JQL0FsQmFxRnE5bXBBbDV4Qktrdk1yaFhkNEZHNFJpMDhqaGdyUk5xUjJX?=
 =?utf-8?B?aHZqMTVMS1p2OWExZ0w4WDRrRkx2My9vTWtyazBZSmhuMFR1RHI5bS92WHZ2?=
 =?utf-8?B?WUJHWE5YWU14ZEh6NlVxN2tiWXN3MnhqU1BDc0t3M1VvVm9jR1lPQ1Q0WEJk?=
 =?utf-8?B?UzZPZVUvUjdPUEZTTGNuZlZ3QzBnalFUeWtoMW4welpwekZselgvZitNaU82?=
 =?utf-8?B?aGRBQW5oY1lVQXh4VzNFemlreDIrQUoyWU12a0VSYml4OHpGUHJ6S2NWdjNj?=
 =?utf-8?B?QmU5OXBlMWdYNXRCWkFsMDZRbUdNT3I2RGd2STBxZnJ0T0RKZTZjM05nd0hJ?=
 =?utf-8?B?N0tjd3AxRjh2Uk12L2dCOWZhU0RwSjEybjRsSmN6dUZVQjRURjBhZ2pwUlh0?=
 =?utf-8?B?Tm9pVGprVnQ0L3lVcUlOMXk0M0JOOFhOTnJqUkU0R3hrbCt1cDVtQ1RaOE0z?=
 =?utf-8?B?RkFtTk1DVmFqQUNHbTZ1bDVTOHlGbnJqWFljTllISklyLytxVjBJMkR0RTBK?=
 =?utf-8?B?dHNqdndETG96emNkNkFSS0tWTGNoY2sxbVdXZnFtSWVSUGhQOHd1RjI2OUQv?=
 =?utf-8?B?UC80MHFGaXdKQllpbUZ4RWU4cUZvUktKcVViWTF2NU5EbWE0Ym1CMmpMQ0ts?=
 =?utf-8?B?ZDdQQk5CQUhMWjRoS3I5Qnl4ZmI3MklXbWNBSzArOG5CT1ZQbExDL3p5bTEy?=
 =?utf-8?B?VW9IY2trM1NxRjkrUW1mdHhVeURwTE5PQy9kZTJ4VFJETGprMlpWaWlHMkxS?=
 =?utf-8?B?NnZQYzlWSTVUVjNZVTR4eUdIUUMyU0pTei9xUVdMRTNhWnloV2NEbTV4ZE04?=
 =?utf-8?B?Y2FwYmFJaHJxUC9PZUVwLzdZdnQ5UUFBalRXU3FTelFLV0NBRTFqWi9TYW9X?=
 =?utf-8?B?dzQwQ1dnUXpTUGZmYnhXZGpRSm5QRXFZUUJhNVBWM2JpUU1LUFZwMXh5bi9y?=
 =?utf-8?B?Z1dVTVNUcnd1bnZNbjFwYmlqN3pmbUpRdW1XTTIrVWRSd1J5cWtwSEtRb3E4?=
 =?utf-8?B?SXFqMWJVejJZRnovZEVaNW55OTB1Q0hHWmM5MEV5Q0s1R3NsRHFMcmF4ekl5?=
 =?utf-8?B?b3BNV1ovMDV2QlVVTTNpOGJuT0R2dW4zUDNTWURyeGI4enZGSndBcElTb1Vt?=
 =?utf-8?B?WnVKeXBaYXdzNFFEMlYxZ3Y5T2tFMmxTMjFrSG9wWVEzYi94Yy90Y1k1Q3ZV?=
 =?utf-8?B?R25KZVdpSW9zbndKbForYlhaUmpPcnNKb3d5UmgyYTh5UWxoMlRwWmVmUkdt?=
 =?utf-8?Q?7+YnE6JFtxP61LMhYjkj+uDnr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3382d50b-0b21-446b-eda4-08dc621b4ce2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2024 15:54:17.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsO94Sk24NZ5F1QL4P3QEhcL8wbN5kYX1wAAcA7of5igOmU7RXib2Rn1QwM3kOyvFsnxuFNKoObk1VSqdhbpTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507

On 4/17/2024 8:55 AM, Heng Qi wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The NetDIM library, currently leveraged by an array of NICs, delivers
> excellent acceleration benefits. Nevertheless, NICs vary significantly
> in their dim profile list prerequisites.
> 
> Specifically, virtio-net backends may present diverse sw or hw device
> implementation, making a one-size-fits-all parameter list impractical.
> On Alibaba Cloud, the virtio DPU's performance under the default DIM
> profile falls short of expectations, partly due to a mismatch in
> parameter configuration.
> 
> I also noticed that ice/idpf/ena and other NICs have customized
> profilelist or placed some restrictions on dim capabilities.
> 
> Motivated by this, I tried adding new params for "ethtool -C" that provides
> a per-device control to modify and access a device's interrupt parameters.
> 
> Usage
> ========
> The target NIC is named ethx.
> 
> Assume that ethx only declares support for ETHTOOL_COALESCE_RX_EQE_PROFILE
> in ethtool_ops->supported_coalesce_params.
> 
> 1. Query the currently customized list of the device
> 
> $ ethtool -c ethx
> ...
> rx-eqe-profile:
> {.usec =   1, .pkts = 256, .comps =   0,},
> {.usec =   8, .pkts = 256, .comps =   0,},
> {.usec =  64, .pkts = 256, .comps =   0,},
> {.usec = 128, .pkts = 256, .comps =   0,},
> {.usec = 256, .pkts = 256, .comps =   0,}
> rx-cqe-profile:   n/a
> tx-eqe-profile:   n/a
> tx-cqe-profile:   n/a
> 
> 2. Tune
> $ ethtool -C ethx rx-eqe-profile 1,1,0_2,2,0_3,3,0_4,4,0_5,5,0

With all of this work to support custom dim profiles (which I think is a 
great idea FWIW), I wonder if it would be worth supporting a dynamic 
number of profile entries instead of being hard-coded to 5?

Thanks,

Brett

<snip>

