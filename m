Return-Path: <netdev+bounces-234263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71398C1E53C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D93A8958
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62B52E9741;
	Thu, 30 Oct 2025 04:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oelA7xZF"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF7128819
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797415; cv=fail; b=kHUXsNK/crpELIDtcAsvU/dawPSz9KOZ6d2M9fBZ6EQ4OqC3eUJQTyZ17lIHkq1Qs/km5JoSGKvDhWhQVn6jySE+j0nDU0YoudLWJFhGe3bQYfJej3KDCHXwkjDueddY1HbVBV5B+nv3rWcUdRAVjIJZ2pcj+qu+XGfRzKGN3nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797415; c=relaxed/simple;
	bh=QJfrNgAY1g1NJkwuYYZvqF1nS+WszIFvSAU9jXkw+lw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BJbg5WJSqfra6oVEP/FRv7SlrDzpUzHeatom5iGAMZLICv3/MnX+vx2V+GiXWg4E7zI8qZjcOs8RVub+vbfh0f3jhtByjUYcr8b6LUYYtwaVu78CE27O9bkwiKMdKeIVn3Q753tcvK0Ir05JOWvr+oxowQiHO8Zxa3I0qAqVEGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oelA7xZF; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGQW25f75PqE5SlXM6V18SPCX60UAphZURrKELAjLLoTaDcFS9Jh0k6BA8DzgueKDPTnxJ3e2h614+ytkKmYZb7lsQHtmqy9LvMhj7F7aVPVvmlmx7TA7ZjGAwxFTlivjMmygNJWz6udFz8eh4mCcj/nTQH2esTi0g1R9SWMdk4xIt/9LBkY5z/1qqF/F8IEHgv0Mgisy6cNbahnTrFFyiw7LGnLuZp9FTPJYzWbpSFYUljeNuC+hIKKqz5vbykjg7JQ4lnKUmgcyVeTBCwZMPYMWxktFSmsTG+qSpntLojMkt7eJQyPvMhsoF4Jat4yc7HVNQbZdNJ10H13VmZTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmIEODcDHNrY4hegkwCKpktz/xLazQCM23PehyVKa+s=;
 b=xccX/SXQfzU45PL+1Efl5C4ky9tEgvgHk7+7PzQMNI6YyIAw0EbROj+PJlMyFNO90lw05dhbblj5tk7zliEZdJhIz2durIBnLfJStFs3jEzpOtts9RZ0ulElqNDb2ixrXBs8XJqaGYpFjr39yJZqSfQTnTR+KXBrYTPBL4WYZRgB0OjKgC22Z81ja2EFz0/kCXsyUwqujdLJPw8CIoYGzJakYoYOkWD07bJcPyj7JGq+3ZRmhblJ/1Sl0Fx5CAQtqWi/0XuPJI8EoT1aUppnyfBqCXcbyEKjGP86ua9Qgy78qebJuHf6h+fezTYyi+9ArhVHClJxQqwvDawaVRn67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmIEODcDHNrY4hegkwCKpktz/xLazQCM23PehyVKa+s=;
 b=oelA7xZFwwFux35iAeWhAXSah2grCoTR2no+/v0YTgs4r3IPakyXClaVm3+eJDAH8UdgE02/kQdEmXJolAZaUNtSXOYNQCAH8/+JlOTjvFD6YBxynddRPeA7cuY2jCOAfkfkgjWn2sZTZlB0+eSKIB5P4dZtROxHn3S2liYE6o4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 04:10:08 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 04:10:08 +0000
Message-ID: <4376afc2-11e5-4ac6-93d2-0a8170365de6@amd.com>
Date: Thu, 30 Oct 2025 09:39:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] amd-xgbe: add ethtool jumbo frame
 selftest
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
 <20251029190116.3220985-4-Raju.Rangoju@amd.com>
 <462415bb-92dd-418c-9fd6-90f1f3194d68@bootlin.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <462415bb-92dd-418c-9fd6-90f1f3194d68@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 561c47a5-71f7-434e-1d55-08de176a35d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1hEeDhuVWdPTVNLOWN2M2dMZWlHTzN1Zno2NnhIa2xyTE1qUTVmY2ZFbk5n?=
 =?utf-8?B?cFJhdXp1VW1RaTZ2SnNqbUFOYXprVXFGZ2JTZkQ1ZTkyOTgyV0l6cGFvY0pZ?=
 =?utf-8?B?Y0E1UVd0bFRINFB5MDZNM242QXlicW82d2VIR0RNc0F0dGRWQnhXUFlST0Vt?=
 =?utf-8?B?OHJtOTFpVyt6NVhscGhhTjl4bzUyR2pMZXJHKzF2UDA4dTBsMkhUMUR5ckNa?=
 =?utf-8?B?WnFqbGVwYytWRFloVGUrajhsTzJaODQzYS8vWHk2aHVsTWNBTURIaHVBM09v?=
 =?utf-8?B?cW1iRjVtSldVR0g1WXZMemJzcFYySFhnNkYzZ1JOT0Ywb0JiamN1WkdLeldL?=
 =?utf-8?B?b3R4MnpXdUZKODFCYVVrSGFQV25acVVaMGNRL0hmK2sxVzhoS0t0cXRYdEVw?=
 =?utf-8?B?UlJmRTBpaWNuRDRnREJNblQ5Nmt4SHpSMDI5YU9pbTBvNEJ6NTA4WFVRUmNm?=
 =?utf-8?B?cHRQeU9wVHVlR0dYVDg0bEJPald1SzNUdTNuNlBMNEMzOUdsVi9NaU4rQ2o4?=
 =?utf-8?B?eGgzazJkZndWdjZDTGE1dGdJQklMWVRpKzd6SHJMYTQ0bklDcnN6YmVwRVJZ?=
 =?utf-8?B?U1E5ODcxZE9nVkJrZWtjWE1hMDlWUDVoYklTbkdBc0Q3Z0xkSHE3bUE1VUxK?=
 =?utf-8?B?M1Z0R21lQ29YTmJGQnhSYW81TEkzOXIrRTU1bEpMRUpLS1A1OWovaEViQVkw?=
 =?utf-8?B?anY2YjFkNnRkWHVCZXl6ZE01NmNmaEhUZStKMkNJZy9yTm1zRDE3QWszNDE4?=
 =?utf-8?B?Z3Jxc3hJQ0RDS1hvcFcvSkFwbDF3T1pUdkoyWmVUbWRRWk5YTjIwZTE4Kzds?=
 =?utf-8?B?Qi9BUjI5bnJValRPdFpTa3VENWF0K0IyM2kzQ1BlcDFrWjdQSVJ6WXRsYWJC?=
 =?utf-8?B?VXNZUy9VUzQrblpOR3AxVkhzSVZKdWM1MkQ0eis5Sk4rbGRBSnZ3QnVXZ3JN?=
 =?utf-8?B?bjdjZWpPRlBmV0dNY2VpcWpEUEE0TDJzZ0gvc0RXS0IyakUzZzBjWFJEUUYw?=
 =?utf-8?B?TkhSOXR6N3BCbHdkZmcxQ1dEWnE5dnlrTE9mWlc2Z1JZdXVGUnlsdkRSZW9X?=
 =?utf-8?B?ZCtqd3RFeWFvSjU0K1NYc3Q1MmNvTStKMS85S3hJcTRUbGczZ1RBM1c1enZs?=
 =?utf-8?B?VEZoWmEzOU5zNnVUUVFoYW5aVnJQRHlwZXkzMzlDWi9kQ1cxbnE5VWRkYWhh?=
 =?utf-8?B?Q1hwVlZQcm13bytnZUJDR0VKUjMvSkJta09WOGFvN0FvT3JEZ0gzem5KMHJB?=
 =?utf-8?B?MndTQ2c3Y28wWXMrUkRWMHRpOElUc0hERm9GTWNyWXZteThodTk2WjM0UDMr?=
 =?utf-8?B?aWxDMVk2QmJDNTIvS3VrY083M1RwTkJ5NHlIRXhLZWZUVGVhZ2wvcFZmdCs3?=
 =?utf-8?B?Nk94UUJQZm5Da01aUG1VSDFmdU13WlU2a0NyUllGWHlqNWkvRkZEUkM0VFVY?=
 =?utf-8?B?MnBrVXprSlg0Vmh4ZzdyVElSczVnVWd2N0dQUysyejVveVI4SkdyM3g4Y3lU?=
 =?utf-8?B?am1udUcwMXFmK3lUZFBTRm9YbGVxTzRwOWl5MzlQVzl0VEdnVUtWb2xTVXhu?=
 =?utf-8?B?cWJTVXFxM3l0Z0psS1hHSlFJTVhldHBYUUZuOUM0Q1hjbXUwMERUNHpZdjhy?=
 =?utf-8?B?d1NTYTVzK2wyV1F0aEJtN3MvYkNpR3FzdFNsTkY3dGhFMm5QSWMySDhmdXdW?=
 =?utf-8?B?TmhaSjM0NjNzWWNnc0RiZXdhTXRuSlBtQ1RUZGFSOGJBL052Z08vSEhsR1pR?=
 =?utf-8?B?V21PbmM2THFqeTNSait2akthZW90ckl6V3VmcjFNRVdOa2VpR0s1akF6NVNF?=
 =?utf-8?B?V0hnVWw4NkFSc21VMmNWZ1cxaGpONGNOYnp4Qyt3dXdvY3o4RHQrWHc5YTJW?=
 =?utf-8?B?TzZnQTQrQXNDYXNRMWFGdHZtY2RmYXR6dlBhL1BiTzNsYnhjTVo2cjV4eHF3?=
 =?utf-8?Q?c8bqY+gpwbqCim17v62i5aineKzvNf1a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTdXRTJQZ3lGMVc5M2lFVUZVYW9xZWNiekRIN0p4NC9sSXgvZVkxVmk3UE1P?=
 =?utf-8?B?cVlmTVc1OW9zVnNxVEYwcndoVTJKN29zNTM3TzNMWUQ4NnhPWGY5cXJCenVn?=
 =?utf-8?B?VHowUXNzVVRSY1ZnMWZWa1ZwWGc0a0JVNkpydkxhdGo0MTFiUStxSHVWVnpz?=
 =?utf-8?B?a0ZITnN6NnJPaTUxV3FpeWZoNVJKM0pUNVROc0ttelBVN1VXVFpaU0VmTlhE?=
 =?utf-8?B?VkhkbEZyTTZwMHVXTVRJWU1zYnhueTlZVTRVZk9yMzhJUktBWU5aNW0wUE1Y?=
 =?utf-8?B?STdOZ3RiY1BSeTdIakVxRzhueFhEKzlhNXNGeFV3SXdmbFlnakpkZFZkNFU3?=
 =?utf-8?B?Umw4MkJ0SUhhbEVWc2xYeWkrbG9CVEEzL3dybjlPeGtnVWZMV1lWQXIyM3lu?=
 =?utf-8?B?cmtpM1EvTTFtUDFRVXhueVE5eUwrNytaZjA5OWNIdXZyTTVuZG5YemFzSjZM?=
 =?utf-8?B?ekN5UkIxV0l6SFl3cGUzaFZab3JiQS9JeFJEUTdodXBseTk5U2ZmVjBxUkJw?=
 =?utf-8?B?VlEyOXhha0w3NmVVbkMvRVJrUkdVWDNtNFhzSmtBMjNPMHdVSFI2NDZYejJZ?=
 =?utf-8?B?YTZwU0plR0tXUDZXNW0yT05NWTNyUUx6VVJBZXZUTTVaQ3BDeVlwZ3FCZFFX?=
 =?utf-8?B?aU0xWi9IRXN2OUtXQTg5UGRQYUNNYnV2a2tEaXJhVll6U0RWN3F5SkRvUjJP?=
 =?utf-8?B?Rm0ySnN0MUtSbHV2eFladjBRSzNoMkYzdHJBeHFRM056VnJiK0JmMm8wa2Vq?=
 =?utf-8?B?d0srbzFKR2Y4T2s0TVJqQUZZOTMwQVI1TVZ1QnowWWx1U2VaaEY5UisxUXJO?=
 =?utf-8?B?VE9hb29sVnNDQ3NHN1YzS1psZjNBcHN1aStFd0VqWHV6UzdrM3czOXdnV2x6?=
 =?utf-8?B?eVJlVEs3ZzlmWG1RSlUxSk9teC9kLzREY1h3ZEd6aWR0bG8wMjFndFNnallW?=
 =?utf-8?B?VTRzWTk0a1VUZ1NwSm94cVg0UmxjQXF3endMWisxc0ZWWkxVcmlJbC9zRCtH?=
 =?utf-8?B?aU1QSUU3TVFBMmZWZ3V2RU9ENW51dFpvbXNJbGRuazhyNno5RW9qMFQxamQx?=
 =?utf-8?B?aHZ3TnZHNlJ4aGp3dUlRNllPbTg0RG12Wlpra2ZhMGxuT3Zod1dUS2V6NkYy?=
 =?utf-8?B?bTVTNHZZeVpNWU1JakkrQ2IvSkNYMlcxcVNBUE42OWFZVlZ1eWRHZ1Y5c1Nz?=
 =?utf-8?B?R2xoczh4eFBwNlB4ZXZKVHF5cGRCSTk0VnZ1czdtTnZEUnJoYjNYMlNjTGZz?=
 =?utf-8?B?Nlh1U1VXcVhXQnBaeVQrSDM5emlCSEVIU014VDB6TW9jYVdqTnE4TEl2TWZX?=
 =?utf-8?B?MnhYeURtaHdxV2c2MTJrNTRXL2d2QzBBMkxjaFU5SlUvck80U0VGc3RzbG80?=
 =?utf-8?B?b3BrakUxYWtiL3drL2M1VGlSVnhkWU5VbzRBTFFoZUxXUzVEMFQ5UVY4K2RU?=
 =?utf-8?B?bDN6SWJkbmo1K1pwVlk3cDM5NFQvYVR4czQxMGI1Z0JoU2oraGp1R2ViSmlu?=
 =?utf-8?B?dHJGdUZwTm1EdWhpNnFVMURiOTd4YWdrb0xXbXRTdzhiKzNURURqS25JVnVQ?=
 =?utf-8?B?VUxzWnhRczRza3duR2JoWERYUDF3WXBJeG1lT0RFM1hqRlFZdzJaWDhPd3BN?=
 =?utf-8?B?WXNRakhZQkp0ZHI2UVgvS2dTdGJEQmFndjFaZ3BvcElNTzd4aUxEMFdIejk5?=
 =?utf-8?B?UXVCNU5DVTRNS1VxVW9mWG14SlJ5QzJsN2ZoNW5rcStiMEZhQm05a1AyUE1a?=
 =?utf-8?B?dDBaM1hXVHVrMDd5SHc5NG5ZNnlqYkx6VGV3d1hmY2hrazVQeXovellVcEpO?=
 =?utf-8?B?OEFYWTJoNDhzWUlYMWhSdnN6VWhpdGh1Q3FpSkorcUwwb2o1RFdiaC9OOWFy?=
 =?utf-8?B?cVc3NlI1c1BybEs2NGRHM3dHckc1cjVsNTZpdTFLbTR0eGUwTHo3U25NK2Ev?=
 =?utf-8?B?YmM5QWNRQnROQXQrZ3ZkM2NPVzBacW8zZnNnQjVTTFE5eVZKZXQ4ckJPSnJD?=
 =?utf-8?B?YW9JY3B5SHhLVkNjaGxVQkpLcWp6WDNRNWsra2NKMDJFdjhMZWxTK3pZT1J4?=
 =?utf-8?B?MWlQVVBBdzMvQlJVaWNOVms3OVBjZm1nNEdrc21CbElzdm9BZlNMbzVDK1Yx?=
 =?utf-8?Q?a/FeNZQmiEk5M9CX8XXKuXLjN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561c47a5-71f7-434e-1d55-08de176a35d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 04:10:08.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjzcXkEC1iyRlxnHgSPXrHxZkc1ecNrBjE76BtcWmkbb4XiT39EPARF9cCJu1r5Fa0sJaFBJFHAIPvX79OTykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714



On 10/30/2025 1:30 AM, Maxime Chevallier wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi Raju,
> 
> On 29/10/2025 20:01, Raju Rangoju wrote:
>> Adds support for jumbo frame selftest. Works only for
>> mtu size greater than 1500.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>> Changes since v4:
>>   - remove double semicolon
>>
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  2 ++
>>   drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 23 +++++++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index ffc7d83522c7..b646ae575e6a 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -211,6 +211,7 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
>>        }
>>
>>        XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
>> +     pdata->sph = true;
>>   }
>>
>>   static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
>> @@ -223,6 +224,7 @@ static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
>>
>>                XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
>>        }
>> +     pdata->sph = false;
>>   }
> 
> looks like this hunk belongs to the previous patch for split header :)

My bad. Something seems to have messed up with my sandbox. I'll resend 
the V5 after correcting the hunks. Thanks for point this, Maxime.

> 
> Maxime
> 


