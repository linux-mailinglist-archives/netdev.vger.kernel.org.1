Return-Path: <netdev+bounces-190214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223B9AB5895
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95907166FD4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2328E5EC;
	Tue, 13 May 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WhKTCaLc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AA1A23B7;
	Tue, 13 May 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150156; cv=fail; b=Ph8eK2QDioiwIYMNlyP/pZIpPua9mbbXuwn3lqdaw7sQnZehdVw02KSXeLDyD0pj+GEFduwco3l5O19UNqgkv4rZ5v7SYEOxk1SZs5ahWybGGMi1BL9XtUk3Qj/nMCWMh7bpgTEO7cqqZ1O3Ban9JPcPe1g6XKcOhyvgxAgIwvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150156; c=relaxed/simple;
	bh=fYQjfCDuUQRyhcA2qPRQwjDFVDZyaqgPy3aJdCmTpoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TfTnzXEqzWlWIAwYyJsCKscG95fuhOdLyaul9xx/bUi2x1QLkMTxOaQWGe1D6QQhI7F/eVb5oMMm7QB8GY5zFNy5GUYH+zlYhleUpSdl14vPj8WaHfkdkTdo+ldi7PaU9wSAE+ph1M9JlwED/OYlOHGzNqrjNMBYAxiFL9jON4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WhKTCaLc; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McAUsYIFvbjUm2DBlEpSwMvUqkfSANGMMnw6XhA+aBMb6WU3r72pzCD1VwZ5QDl0+NS9NQQDOQDEnc7gWvHhjETiQSF8vKu8LhryzyM8tX4kCsDuvooW7oxPMi/A97iLlPwFO8oKlzP7IBHxHDResBq77QTtCwp7z/g7XIc0mBKaWsZk6KqC+1YeIJlgPNXms5FI++59Bi/YTwtjKtRfGsnV5i92HCy5ErNfWW/hp19pgjk1Lb5ry69YWrZNx8y/XJu6I/OwfXf7puJ7Ab3snRn3rlR7En70kHhgtg2BTsu9tIj4xgb/8dBn+N9vt7R96yvwSRCzSBhbxII7OCFcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpNguMNmBijmb3VHfyArpZT1zGWQT+7lX7wEyyJA7sg=;
 b=ws8VHg5nr6Qo2ALpl0eO1O+1rOKWWvKbGaeSdHl5SPnO0BFWf9Ht1ze06yPK29r9LaKNMrJ4m8kiLFPTHKHIJWSHDMQSQfn8sIJUDYVVdV/r7x2kfkuvfCROdu0qordw+Lrb67Qv5KUEPp8ML4arp2DgBC8txCj5FxJR6AU/YcQWPMKnAdEQCfsAkwcZHnGaMIQ/BXN8lNnQG3TqsYGoG5mPUAKn7t3Fb/6vBwAGKHTnG5XePyuTPTW+gmTkxlcO0ICDI3/KBawKcpZ846PHngJDTni5U8KKLOhYL8UFzXqlrXN5EyJnj4a9BDkIB7Tv2jz1BK8s5QAtFNdNS024uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpNguMNmBijmb3VHfyArpZT1zGWQT+7lX7wEyyJA7sg=;
 b=WhKTCaLc8MxyWq+URaxaiKey3dqNM0wpNNPDx/SPSUBWcaW0EN3Zc8v7v6FclCjjL/J94CNJGxG+X6+m8rFW+QqrQn2GOR9fj9vpIlP8swowdxWmDM1LmDgJotZD5SFPzdm8qkxjrftEziD1rV4CL3cyKFtlCu36oiIjmQ3brDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 15:29:10 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:29:10 +0000
Message-ID: <6a8f1a28-29c0-4a8b-b3c2-d746a3b57950@amd.com>
Date: Tue, 13 May 2025 20:59:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 09/11] net: macb: Move most of mac_config to
 mac_prepare
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: upstream@airoha.com, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, linux-kernel@vger.kernel.org,
 Christian Marangi <ansuelsmth@gmail.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161416.732239-1-sean.anderson@linux.dev>
From: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>
In-Reply-To: <20250512161416.732239-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::26) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 602f8525-ebd3-4648-c185-08dd9232e824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXZqd0xLUHM1QXBKSWZFRVpwd2hOSVFsUWZ1R1F0TEx1cm1Sbm1zWFpPRjBk?=
 =?utf-8?B?VTU3UEZ2QXRLeFc3RVNXK2d0VEIyMG9ybFZHSCtrRlc0bVp4L3FzaFhTZEtI?=
 =?utf-8?B?clNlR3Awem1CZVlwQUNWamI2UXlNV0x4OTZpaER5TlNXRkViSW1pd3ZQUTRN?=
 =?utf-8?B?Z0JyY0xLQmc0dnFPZlB0RlpqVjlHempQaXp6bzlFYUxFeFB5YndOZE1UZ09m?=
 =?utf-8?B?alB0bHQ2ZFpYbHJnejB3U3VOZWhVcU9MRUg3VHFMK0UreWNFanB5UWZwOWtK?=
 =?utf-8?B?T01COGtkQ1k3cUMxRWIvUko3K3hMMGx3Uld3M082THFhekFCbzFZdjRkUXZr?=
 =?utf-8?B?MENQOUdiU29VRGQvSDVVdi83ZU1iZTdiWXYrVEJVMVQ0VFQ0dWQvNnAyLy8y?=
 =?utf-8?B?QThoY0d1SjM4VDVqQXFicStiNWllOU9KcUhHeWNINGRzMEFqdmFCdlBoeFEy?=
 =?utf-8?B?VXJzbGdUVjdDcm56b3dWb2VEREs0dTFqN1Z2NC8rYzRtVTdKWmZFTTAyTDdr?=
 =?utf-8?B?dCtlRThnVVZVVnFvNy9Ka01rTlpiT2lTSHRQMXVUVUtEbUY4Y2RxSmlIUEdI?=
 =?utf-8?B?T1llajU4ek1DbHR6dngyeDJ4WlZiRzNWVk1IaEdVWmk0SkVnZFliY1VrRTVO?=
 =?utf-8?B?MHp0dktUZktuaC9NMjFPRnJqK2l2ZlM3Q3JOWUpDWWVDb1RHVGJ3T3V2cVdJ?=
 =?utf-8?B?bU5OY1JibnBSQmFGUTg0eERNOGNRd2VXQk8rTS9IaXVYUjhrSmRPQ1ZSS2py?=
 =?utf-8?B?Rzk2b2RxbnZoTG1aTlArK0k3a09HMC9IQnoyYnRnRDF4bU1DZERZRTFKYzhy?=
 =?utf-8?B?L3VlTVRsdmVKLzVkVTF4YjhudHpjb1pHWjdzNzBqSDNkS083UXFqYmJuTnIw?=
 =?utf-8?B?V1U2VXpZL2dBL3NJdlFuaEdSOFVXN3A0NDdVVHphN2xmSnVTL1JLT1RkeE8x?=
 =?utf-8?B?SXB6Sld0b09WVnliZU9JMzJ6NXVZb28rTERTVHVieDNvZEFyWFIvbElWZTRJ?=
 =?utf-8?B?aVIwYVNBQisya1Y2aFVCUXZDNWV6NmthLzU5VlA5VTJDQmh0ZDU1cFlwdEIr?=
 =?utf-8?B?V3hJVFdXZDY4VHRKSFZuSHZLeDhzN0VUYmFnbkNyNmhTVTVueWxIS0dxdnFy?=
 =?utf-8?B?RkxiSE1nMGJ4MXdEREcwSjd2OTFlS2tNK1hSbW1tMzV5S1NIQys0RmJZcENQ?=
 =?utf-8?B?UjFQY2RvbGJNY3BqTXR4NmFyQSsrSUw2VnNlaWh5bHFFc1BhbmFHd1F2MGpW?=
 =?utf-8?B?ZmRQbk1ucU1JWkdpZGVHTmowMmFNeElpaGRuV3VJVi83alpwVWF5SjUwNmVR?=
 =?utf-8?B?bFFmZWlZRUZsMXVueXVTOHlYRzM4MXdtck5VbCtzRk9yTmg5NmRRRzRhc1dV?=
 =?utf-8?B?NHpaMEo0c1FSYTA3VU1FY093WUFmeUFuYmVXR1JERmZCVkpRNUlRaW9TNnA3?=
 =?utf-8?B?UlpUN0w1aldGZlh1RUl2dDB3RnhyNUUrU0Jhd3VWWm9LSUsvcFB3Z0ppQlE0?=
 =?utf-8?B?K3JkVDJwd01aOG00S1F1WmV0dGtPdW0rNTdHekFjaUEyeVFBaHJTMmhzNHFw?=
 =?utf-8?B?MHN3WDEvRWhsMmVYV2xUaFQybjRaMXkzRVdYb3Bwdkd0Vy9yYWNXbnBncXlO?=
 =?utf-8?B?VmxqNEVNMkorbGM2Uk5FVWJTQi8zMk44M0FrbUwwNG5YTHpNOEdoK1FwSW51?=
 =?utf-8?B?blhjY3FFaFh6RXRlUnVSMWdVaStOTUdZTk1NbjlENnFEdlV4M2NLczhyUHN2?=
 =?utf-8?B?QjJJT0tVZC9WU05TdDI2R09YSjNFK05QaHpvbWt1M1BuWXhoZ25aVS9aR3M0?=
 =?utf-8?B?eGtrTkNFekNQUzF3Tnh0cVowc212U20zdC9jY2t2ZUhSUFpDdkJTSnV0bENh?=
 =?utf-8?B?aVpsamNFRmVSUDdROUlhamg2ZUZRUnlNKzBUc2l0bXkvcjhUbDcySXhKNDI0?=
 =?utf-8?Q?WQv46PdF4+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWhRanhIRjJXUEdxRE5kc05uaTNIYWd1a3Z6MDNCelBBMjc5TEljUU9saUFa?=
 =?utf-8?B?Y29YaVk3UHBDVk5CQUFHYkdzdDNkamZ5UTF1eGlDTWZYbFV1N0J2eS94MjdD?=
 =?utf-8?B?TWVXK2ZIZW0rVUI1K0djSXFjcE5oaHRpclhkU29oYnorcURTMXY3MW1xbjFh?=
 =?utf-8?B?T01lNjNFZEZvRUw1MmUxV0NmUXNnYVVRTmhTKytNKzlQY2l6ZWlWSXV3SkdP?=
 =?utf-8?B?RlZoSFcvQWx1aU1LMU9wN1ZiUE5vbHFKSENvQS90Snd4cXNTSmNUbHBsUXFl?=
 =?utf-8?B?MSs1RlkzbllDS0ZpamtHakQwMlpta2gwak94emQxRGhUZ0IzcHViaE41WTA4?=
 =?utf-8?B?b0EwMHUvVVBLcDJacTltWmJUL2dXckhHTFoxRld6THNWRUxKbE1GS3paeE52?=
 =?utf-8?B?bFlUMXlNUXlReTR4MlJXOHFUVENxeUZiMFQ2WGhsT01Ld2FPR2ZSTEpEcTlS?=
 =?utf-8?B?alRPSndHaTRlOXZwaFpVM3E0cDAyMEZzY0tPYW0xZEJ3Y1NlRzViZjBvTnM4?=
 =?utf-8?B?R2RJK0cwQVcwQTA0VVV0SklENTZXWlVHNjQySjZPOWEwMk1Sc1VwUytIaHU3?=
 =?utf-8?B?dFNtT1BDZ1lKNmRkckxDcGFBWi9Ra2ZUa0pPRkNIRU14eTVOQlJTOWVUeDho?=
 =?utf-8?B?Q2lKVzhhWWtHMW1yM2R4amhvMXFvVE1oQXdNejVzSkYzVWJOSHA3dDJLV3JN?=
 =?utf-8?B?TzQ3R2ZPb3ZJbG9PTlgvcCtKY2RyTDRLOExsYWIrdkQ5ZEhQUDVjQlFZaEVP?=
 =?utf-8?B?bjFrRFBtaHV2bnVxNTcvZVlLZDkzWnhycWYyZjdTZHRERmNDdWcxdFVPRFY1?=
 =?utf-8?B?YzdIWmw3eGJjc3IrU1NHblhFeVg1dGZiRzdmRkw2d3I3MXAvcUVQbnB2OTlV?=
 =?utf-8?B?ZVV6QmpwbFk0K2JZY2lNZVFtblNWdTRiK3NRelVvSm91cFBrOHVsRE1rdGZF?=
 =?utf-8?B?Mlk4Vko0dzJLSW9rMDExMExyaHY3VHFUTklhZ0k1RmJLck16cHcrRHJhMzIw?=
 =?utf-8?B?a1pBZk1YeGRXOGR6NHFPS0hWcXVTQ25xRmRHemdYQXpmVkk5bGJtY3hrU1hk?=
 =?utf-8?B?bG5JT1BrMHlONnRmbjh0clJwWXZ3MEZFa2g2MmJyRGNwSXpVM2pwd3pWemsv?=
 =?utf-8?B?NUZZUnJIOWNlSTFFU1VuVW0vUmRwN280VEoyRVhFbmU1QnZ1K0I0dkN4ZmlF?=
 =?utf-8?B?VDE5d0pOdXBZY0lnc0VQanJhR3MyNDJaRXY1d3VwZ1ZyRm4xQWk4bGZodFVI?=
 =?utf-8?B?SWFDaGZndmo5ZFZrN01JczFSZUg5MHd4OElPZHdBV1BZZEVLTEcrS0QwV3Iw?=
 =?utf-8?B?V24vZWN6K215ODJRd0Nva2R0eHVWVFVVRThtVFVrRTNRWHplMUhRZTBwUEV1?=
 =?utf-8?B?ZDdWT0RWTmJROTZYWUUvNFZWWGxQR0JVMXVXMHcrZW5IWHFrNWg2SDM5Nkdn?=
 =?utf-8?B?cW9Sb2tDbkM5RDFUMEt5REZCaW9MYld5WDJxU3N3R21LMHN0cmwyUVR0VFUw?=
 =?utf-8?B?U2FEWkZEbzlnR0IrS1VGNVoyR1Q3ajRraEJhY1FzVWwyWWFVczZrc1lNU3ZU?=
 =?utf-8?B?ZmwxbXk0MTNCdWJQRDVMajJmU3RvV280TUNDL1NsazNjcjNwbUJvL2c2Skp2?=
 =?utf-8?B?Zms4ZDArRzJmMkFLUUcrVjVOVHBzSkJLRkNzSkVQMm0vWFBDZEZMZk9UKzdk?=
 =?utf-8?B?dXFBeUNiaFB2dnZsV0ZQZ0xnY29wQWFoRkVsTjhRWHZhbHpBTGt0Y1ptTDFY?=
 =?utf-8?B?YS9XSk5Memc1TkRXcU5MMDF4RytDUC9WbWVjOFg3SWRWQ0lQbitnMFFmSFhN?=
 =?utf-8?B?UE5rc25mRDdncmZlUFVPRkExeUtoS2poNzNtUmxHSFJITzI5eFBKYkJrVm9Y?=
 =?utf-8?B?T2QzUjJ2VUhuTjBFK3Q4UTQwaGpublBlVzh2enllYld1WDRJSnY4aWN0K1lW?=
 =?utf-8?B?WUp2Qk9VYk9tWXBSWUNlanQvMElBSThIc0tLZnhpY093T1pENGJVemdjTXQ2?=
 =?utf-8?B?aUNKRGtMVDBuQnNFMmtkamRpZGNicTZJNnJCaENvV3g4ZGNGNHB0Ni9zUjg0?=
 =?utf-8?B?aHphZ3VmNDFLSHgrbG4vT0MrS3Jlc1YreG51WnNsdVBjdDk1dGpiYU9xU1Vr?=
 =?utf-8?Q?UM30A6f7vDkIkMMk3MsqWjns0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602f8525-ebd3-4648-c185-08dd9232e824
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:29:10.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a245pgGAyRxTWP9rJwJPuIn0IaHNh31NFWnhaz2aDecC5LNwn/dlMm9VvgNUmcud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

Hi Sean,

Sorry for the delayed response.

We are working on MACB with two internal PCS's (10G-BASER, 1000-BASEX) 
supporting 1G, 2.5G, 5G, and 10G with AN disabled.

I have sent an initial RFC : 
https://lore.kernel.org/netdev/20241009053946.3198805-1-vineeth.karumanchi@amd.com/

Currently, we are working on integrating the MAC in fixed-link and 
phy-mode.

Please see my inline comments.

On 5/12/2025 9:44 PM, Sean Anderson wrote:
> mac_prepare is called every time the interface is changed, so we can do
> all of our configuration there, instead of in mac_config. This will be
> useful for the next patch where we will set the PCS bit based on whether
> we are using our internal PCS. No functional change intended.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 

<...>

> +static int macb_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
> +			   phy_interface_t interface,
> +			   const unsigned long *advertising,
> +			   bool permit_pause_to_mac)
> +{
> +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
> +	bool changed = false;
> +	unsigned long flags;
> +	u32 old, new;
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +	old = new = gem_readl(bp, NCFGR);
> +	new |= GEM_BIT(SGMIIEN);

This bit represents the AN feature, can we make it conditional to 
facilitate IP's with AN disabled.

> +	if (old != new) {
> +		changed = true;
> +		gem_writel(bp, NCFGR, new);
> +	}

<..>

>   
>   static void macb_usx_pcs_get_state(struct phylink_pcs *pcs,
> @@ -589,45 +661,60 @@ static int macb_usx_pcs_config(struct phylink_pcs *pcs,
>   			       bool permit_pause_to_mac)
>   {
>   	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
> +	unsigned long flags;
> +	bool changed;
> +	u16 old, new;
>   
> -	gem_writel(bp, USX_CONTROL, gem_readl(bp, USX_CONTROL) |
> -		   GEM_BIT(SIGNAL_OK));
> +	spin_lock_irqsave(&bp->lock, flags);
> +	if (macb_pcs_config_an(bp, neg_mode, interface, advertising))
> +		changed = true;
>   
> -	return 0;
> -}
> +	old = new = gem_readl(bp, USX_CONTROL);
> +	new |= GEM_BIT(SIGNAL_OK);
> +	if (old != new) {
> +		changed = true;
> +		gem_writel(bp, USX_CONTROL, new);
> +	}
>   
> -static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> -			       struct phylink_link_state *state)
> -{
> -	state->link = 0;
> -}
> +	old = new = gem_readl(bp, USX_CONTROL);
> +	new = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_10G, new);
> +	new = GEM_BFINS(USX_CTRL_SPEED, HS_SPEED_10000M, new);
> +	new &= ~(GEM_BIT(TX_SCR_BYPASS) | GEM_BIT(RX_SCR_BYPASS));
> +	new |= GEM_BIT(TX_EN);
> +	if (old != new) {
> +		changed = true;
> +		gem_writel(bp, USX_CONTROL, new);
> +	}

The above speed/rate configuration was moved from macb_usx_pcs_link_up() 
where speed is an argument, which can be leveraged to configure multiple 
speeds.

Can we achieve configuring for multiple speeds from 
macb_usx_pcs_config() in fixed-link and phy-mode ?

-- 
🙏 vineeth


