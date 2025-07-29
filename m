Return-Path: <netdev+bounces-210766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD63CB14B85
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0387A5B55
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5572882A5;
	Tue, 29 Jul 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ahb0btml"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9D28851B;
	Tue, 29 Jul 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782162; cv=fail; b=Qhr27jJvCKonRpy+4oSnv4gtBCgFPR8OdCHMsnU9eBFM5f/LTYvEiAr9jw9od+TBqyGGgsp1jSwoSxsbJo2s7zWQUpZDhqk9bTEgIQzG0zofTRZR+ArX6lU2UsKqjMDHWkBac0WUGn1YDhqTSCiVipCLkUKF7nwmOu31bzvVC6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782162; c=relaxed/simple;
	bh=lY/N7/3kceBIHvs5ETb3ZdzsnlMw+idh4hggdRvMMxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iEH1ko+1hXOX3bujz5c6Folw0ZEgfgg97RhMvGkxKJAw7EdyP0VB0jXEMSeSzZYbRpz3m6lcz3lUbjPZWYkMAMsAUI/hb9YJqeAukoN221bgm9Rafa8SfmVHvfMKlqiO3U5FDeKijynmEuWd/HfadOcOGoWOd3cWoOIebwvNzXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ahb0btml; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poYJz6VkqyK0b94ba0nCJbMCyrNt1yfDsPufmy6/6YDLC11wBYHqom8N4kRsUflEp6qRerNT7ga+iHL+agyjUt4YhvIqGpKTPU6qoQP5DvxXm9ncfQ1o4TgmYKjhGr+Xu5Vs2oCUuuLUuowCMVGgR79dy1QwLebYQNIbRDP84ioNtiYCkuMYjGjPkvo6FDOvT1rs4ytL55kPjIbDG5Yi5+8ktVal7qq4/QAI6p+CZILLB7cVuWJBupu7mUAXVUsj++P7nzT4NNc0xufwi0RPS7F9nppvbNmnF/OEqzBqDnklwcPBeBGc+UmBxCB6Y4zPWEdEawtQss+hlyQWgkdCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3pGM2SxU8Hi9sF9k0dpW3HwoiBGBSEZSiiTYU5zC10=;
 b=sCEnYzNSijnZ0oz/UAbbVcE+gzw308g3rc9o+3Zt9a23u/FDKCTkVp9inlLFQTZQM59GI3g3tYqhjSoabZIihLEMzZgFEwEXdGSjqDkkQsu0aXJFLmlb1S0G5/qj6GxFoecU1IhbUUckrK7CRpxtKiqD/xEmhGnoW+QTE+GNJcF4N9afoYPAGQgMQ5mo2tAbfa9LZJLNJweC2LA6rMtCOcwVso90Lf5pUt0sAbeC45ezCCk1YegVIAf4uHIsryW8DRHfxisCaJiwq+xIbWrkwcXFLs9+XLm4H8/Tcg6en9eLYIiIKoS12+ojsYEPn9nL1bKiRBGdsywDU1JJoGeqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3pGM2SxU8Hi9sF9k0dpW3HwoiBGBSEZSiiTYU5zC10=;
 b=Ahb0btmlOemPblZTDCjG6diQaw+gJ0dVaNvwKhmtCndUvVaS98dCpWP9bZjYzLKn+cKLmT/AQykco+NaAitH7dgUIWK7JWLOXn7Rq2LSv1o5VFP63GETw0/LFp38YOhAVzSyAoi7IuRV543kGybuQmqCPEYTkAkMx/+TazmC4ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 09:42:36 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 09:42:36 +0000
Message-ID: <53ee7054-6cdb-4f2e-a4b5-16bfa590df44@amd.com>
Date: Tue, 29 Jul 2025 15:12:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] net: macb: Add MACB_CAPS_QBV capability flag
 for IEEE 802.1Qbv support
To: horms@kernel.org, vineeth.karumanchi@amd.com
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-7-vineeth.karumanchi@amd.com>
 <20250723190500.GM1036606@horms.kernel.org>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <20250723190500.GM1036606@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0061.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::10) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec7ec70-5f3b-41a2-b5a1-08ddce843ffd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVF3NDRjM3lIQkRxQzQ1WVVpL0xCdkV6QWh2Z0MyTTVEVmc0QVFFTi9VQkdE?=
 =?utf-8?B?ZXpGYUM3bVkrVTFBVk1UVnB2ZW9oR1BvV1daSjFCbjhLL3NhVnZxZjA3OFE3?=
 =?utf-8?B?MCttYWRsVlNQQm16RHZlU3FNRGxsUVpEWmlFVVVYU3F4VkkrVFNhLytxZGo4?=
 =?utf-8?B?aXFWVlhqQnMzSkRzMEdWMjk1aVVlVWhrZDlORVFEdEx0NkMwSXNRWit1VE5C?=
 =?utf-8?B?S000U3d3YjdWek1XK1Z0YXRWejBhSUhGbTlVVHVVVkE2UUNZcVdRRGF3R2lj?=
 =?utf-8?B?RTR5NVpoZGFOcHBpU2p1YllQQzZaQzkvenhybno1V0RRUVNqM0toZlFjaUhP?=
 =?utf-8?B?TlVubGJuQzRpZXpsaUtrM3F4ZFgwL2lOdG5EakNBRmRaTi9qUHU5QWNTVDdT?=
 =?utf-8?B?RXdnYTBpb3VaZ09lVE9aSWZSWmdZSVdRZGpZSmdxZU5qWURxVFdGT1FReGky?=
 =?utf-8?B?cUJrM3Zpc1ptQ0NNMDRZbnlFRlpNVWZZSDE4MmZHOExwS3FsWStLSUo4clZT?=
 =?utf-8?B?VTQycWI0WkxlOFZZS0ZidmFDZzFTN01LMy9mcnJrUDViYUxmdEFFUmlYdXlm?=
 =?utf-8?B?K1hpVGl0UENKcC9rVm9MVStWSXJpeUFZa21OdTVHSVk3aURFcG84MVc4L29B?=
 =?utf-8?B?WjZsUHdkTG9qbXBXYkRkS1lQSUs3NmZpN3RDcm5lcFU2aVM5Vy9pa2NVYlBH?=
 =?utf-8?B?UjA4a0xjY2taVlEzT2FSUnZQbDltWnkwek5NQlFIcUFzSWxKTkUzZnRwNXdi?=
 =?utf-8?B?M0tRTCtTME9TMEdOSi9OamUzVHNMMjJrNU1PWE55VG5CWmw5aFlFcWxEMG1C?=
 =?utf-8?B?d29rRWlxc1o1T0RobGRxMklwZnBCVjhsZU9qODFrZElVSmJLYnNQZjg4UFd2?=
 =?utf-8?B?MXdmVFlrbFRlcEFJdWVRUVptUW5XUGhLWnFnc21uZ2tDdjNGS1FzWjBEc2Fp?=
 =?utf-8?B?cjVBMkFHYW5nQkhmaVpFTnpaS1hDRnY4c2k0YmNVSmNjVkRJRU83Y29kTVBr?=
 =?utf-8?B?ZGM1MFhhTnVEMk5OdWJ2S01BVHZtUHkvL0VvVkZoUTFEbXNLMHBCTXpPRGFW?=
 =?utf-8?B?Qk9GTW1TcUJmU0J5ZmU4Mlh4cUZoU1RGMjlzaXpUbktUUjFDYXY1eHV1SkhI?=
 =?utf-8?B?b3pBeVllbUpyNXFTRE1raC9Wa2lTOFJ4VitnM0tNaFBHb2lHZlkrNjFRVWEr?=
 =?utf-8?B?WTBSdEM4Mnp0LzJPMWorOVZGaEU2VVpocndOQk0rNTJrdlhGTUcyU2NWaEZn?=
 =?utf-8?B?ZmNQNkNrcnhWOUdxTTFmZkR6MmZqaWpEdWVsSENwdFBhUmNQTFhVYU54YU54?=
 =?utf-8?B?Tk9IdWZnWEdWY3NCdlFjWGppd0NGQU82VTdSdHlxWHl2VWE3TmdvcVA3RG5k?=
 =?utf-8?B?Yi9rT05pMFErNkZtZi9DQitkTWo4dUsyczArNk1qdU9ET0dQT0NxeUVUTms4?=
 =?utf-8?B?ZW94aTBYOUl5bGViZHhlMVl4bVRHanJtMXkyS2RMTFNvT3B1UDVnRU9LQVRk?=
 =?utf-8?B?enJ2cWlRWEdlUW5zK2VYMjVuVFFzSWREQWoxbXpXVzZ4Y0ZjbURlR1VyNHZm?=
 =?utf-8?B?Ry9PRUlRZ2poeUpUNytiMjVLOWZ1eUlPVGZHTC9CUjd6dEJzTmhMU2JiNGdj?=
 =?utf-8?B?UnVqRTVKNyt5bHhSQk1kUkJOQzArV3IxalVwazhvaGVic25YMWoxakFzcVhI?=
 =?utf-8?B?SDA3NDYyYXdaVGlQN0owd25Zbmx0dHZlSXJEcW5tVHg1ejFEckVGQ0g4Nllt?=
 =?utf-8?B?MkYzd0Q4OVlSMmlFVy80eTJqYzRBUWM3Q3B4UVJJSjBGSG9vVmc0SU5OcTVp?=
 =?utf-8?B?NmZUQ0VwMXpUYWVHeUdIbi9IcTZlamE1ZTdXdGtUa0hnOHcwUzZqL0dscTgx?=
 =?utf-8?B?TmFVcEVwR1dKT0xwS0lDZmVCamZCa1FhTSs1MVFtV2ZYZXZxYnkrd2kzRUls?=
 =?utf-8?Q?YWBdd/Jhwfs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRBdHVxcXpncXc3ME5hWlBvUnE0TXpSUVQ0eWNJWTJ6aG1OcEtaeVU2Qk9S?=
 =?utf-8?B?bGJrNlVXb3dtQndvbzhocXhJekFOenpOTjJpdnZvYVprRG5zNGRQN3BGN2pK?=
 =?utf-8?B?ZTNNRVE0R3RaWmp4M0MyRm5uT0EvQklBUTV6dXkyRlh6QSszU0RKZkpON2dN?=
 =?utf-8?B?Nk1qdUw5R3ZnN2pDWFNNcTdWbmJrYThCVW90dXBrY1VZNGZEcUFKajZ6VGRn?=
 =?utf-8?B?ckRTL3BpOGpoQTA5dVRzMVBJYUx5U3h0RmMzb29BdEdnb1JwWTRBWlN0YnVH?=
 =?utf-8?B?SGhPMTgzWUU4ODVmTTJVN3lEdEMzM2F2Q2p1NHN3b2M3ZmMyVFhwa2FpMTRa?=
 =?utf-8?B?WkdTeTZBbTU3SGdCSksyVDV6UmZsbmJHMWU3S2tJN2dtU1pHL0ZRYUhRRW5u?=
 =?utf-8?B?eVVQTjY3MDRlRStCdmZMbmZaRW40MmZSMjJUelpXelZYbzAxN0hJN2xTMW8x?=
 =?utf-8?B?bEpjWHZUTmpuR2xFSXQvRXlrUkJVcnY0cnhNWEJIcE1TamRHQTlXTHIzMlNr?=
 =?utf-8?B?SDVEY3BPOVEwWHZUN3pncW8vbmJJOGxnZStCSkhaejNBQ1hKV0ppMWhEUzZv?=
 =?utf-8?B?OFZXSG43OUxJM0RDU1BVc2V3cWZiamg3RjUwRUFxck1BWENKWkVHQnpiakt5?=
 =?utf-8?B?NE1yK1lLdERGSjFRRjVGR3pRNVRZK2FrWGxHUFY2UEZWcWIwSVdLeExXUFBj?=
 =?utf-8?B?TTREdUIycC9pbURZa1NxeFJkb2hveXh3aGpIeEt3czYvdzZ6RDhyZGtGbEwy?=
 =?utf-8?B?UGtlckpWUEhWTXIvM2J2UStwV1dPcHNtUVF6dHpyS0kyTi9zMEozdUtlMHRN?=
 =?utf-8?B?dXNSd3I1NlhtNkx1a3docklqUmNwNkNSU3RuYnNkVzYrbmJFZVJsZVZDMllC?=
 =?utf-8?B?M0NIYjZ3OCtqVDdlY0JveW10NE5FZkprQjExWWJvOXBSS3BNMzZyaFlJejBz?=
 =?utf-8?B?bnVnT2F0emc2dnhkV29iSlNBLys3T242WkxHY3dqZUpZdWFLalhCMGNIYUxq?=
 =?utf-8?B?SG9qWUU5aVdGczljWmtndkNHUlVLTFBFNTJFb0RnVHFzTHN2VTNENnBFWVNI?=
 =?utf-8?B?NjRtSitMQmliVjl6QzduWnRNWm5GUDNIUUhNTklPMlJ2WnZIMS9mVlp4RHhG?=
 =?utf-8?B?cnY5cmlCT0pwY1B5Q3JqRTJQNWVWeFQrTzNudXBoMnlUK3hnM3J1TnkrMGNp?=
 =?utf-8?B?T2FyUlRtaGt2cFVzSENsYmxwVEJRNWhTcVpqR3h2UUNQcjlCZmZxRW5CZjZC?=
 =?utf-8?B?NkkrZ0RvYmsyY1pWTGNVUENqdk56VGM1UTFITGgzdkptTVFxUG5kSWZVbW1S?=
 =?utf-8?B?ZldPQVhMdGpvWmI5aWFvZ1Y1dUxmWnJFajd3YjlhK0JIRHI5QWNtVlRRb1Rz?=
 =?utf-8?B?Z2EzN1RsM0V1bDVxN1hOTnZrL29lOTltUTdpTDV3VW0vdzhtMmxLWjlwQk05?=
 =?utf-8?B?bE9tLzhVa3ljeEJHc0VhYXoyY01oUXE5TW5kaUl2Q1hwRnh5a0I2Z2E2VG5Z?=
 =?utf-8?B?a2JIOUlPKzRINVhmQlJQWDEzQnBObklGVDJ3d09mVlhRNVRQVWRKMmd1emNV?=
 =?utf-8?B?RUkvTlJlTVNobVhNWnNiT1pSbGJUTGdCNDhUelZZTWtObVpVWVdOVXp0S252?=
 =?utf-8?B?a1lieC9GQVJmNi9RaHFGMmZkSmdEaXlaK1dzcENucmRUUlZTb3lEblRocUsz?=
 =?utf-8?B?MklpY2xWbWkyU2tRemFnOEJqTGIxRWN5UHN5aVhJUGlZZVV3dHljRnZjMmlF?=
 =?utf-8?B?eFhuTzlwdHE3ZTJuZndvRVhHTFpiaXJ5YzlLN0JMSjNPbjQ0QWNJUis3Y0Uw?=
 =?utf-8?B?NGQzdlRUaDNHdWFMWlZLZjROV0xONmM5L0xVcnFiWVZqZXNMNzRDdEJzaWJC?=
 =?utf-8?B?UWl0TGQvSEtCVUVjVkhRdVZUREJkbDFacGpYRzFFd2tWUExyUTBOOE1ZSmxC?=
 =?utf-8?B?TUpqTFVHRXNDZXQ0WWNQdmlOakp2d3VGOEQ5aHd5OS9jSGRUaTJ0cGQ2NjlD?=
 =?utf-8?B?NUtrbEtBbmZkTEVOSUhpV243L2R1NTlqMTZ2SnVQdG9NVHJ3VWVVWGROcnJR?=
 =?utf-8?B?ZVFFQ3VnNGYxS3hHTzA2TjlUdUJSS0twQWE3TWQwcHJZNnVoWDdLSENJVzU1?=
 =?utf-8?Q?tOSF3QpoqWsJWVEvjA8rDbzPi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec7ec70-5f3b-41a2-b5a1-08ddce843ffd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:42:36.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mywcSu1f0Vt3khXa1TpCB09sVDRV6JJLgpdJtnPbrhE3Fle2ljxg8fjwpmZbuTaD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

Hi Simon,

On 7/24/2025 12:35 AM, Simon Horman wrote:

<...>

>> @@ -5345,7 +5349,7 @@ static const struct macb_config sama7g5_emac_config = {
>>   static const struct macb_config versal_config = {
>>   	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
>>   		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK |
>> -		MACB_CAPS_QUEUE_DISABLE,
>> +		MACB_CAPS_QUEUE_DISABLE, MACB_CAPS_QBV,
> Hi Vineeth,
> 
> TL;DR: I think you mean
> 
> 		MACB_CAPS_QUEUE_DISABLE | MACB_CAPS_QBV,
> 		                       ^^^
> 

Yes, since there's no strict validation for the presence of 
NETIF_F_HW_TC, the tc add/replace command succeeded. I've submitted an 
RFC patch to enforce stricter checks for NETIF_F_HW_TC within 
dev->hw_features

> I assume that the intention here is to set the MACB_CAPS_QBV bit of .caps.
> However, because there is a comma rather than a pipe between
> it and MACB_CAPS_QUEUE_DISABLE the effect is to leave .caps as
> it was before, and set .dma_burst_length to MACB_CAPS_QBV.
> .dma_burst_length is then overwritten on the following line.
> 
> Flagged by W=1 builds with Clang 20.1.8 and 15.1.0.
> 
> Please build your patches with W=1 and try to avoid adding warnings
> it flags.
> 
> Also, while we are here, it would be nice to fix up the line wrapping so
> the adjacent code is 80 columns wide or less, as is still preferred in
> Networking code.
> 
> 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
> 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
> 		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
> 		MACB_CAPS_QBV,
> 

OK.

Thanks,
-- 
🙏 vineeth


