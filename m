Return-Path: <netdev+bounces-217653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A576B396FF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D52118824AF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C92DE1FE;
	Thu, 28 Aug 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O/pWTo+R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29002205E2F;
	Thu, 28 Aug 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369831; cv=fail; b=J2p5ag2mp7tlXHnYrAHJjQ+NtUumYBtuLdVooOcBelf64TpHedaSLE0L8tywRHFBAL8y6lpDd/1QavIUV2ZsQW9akE3TADjMWizuqDJIzIxLwDXrWRxx/pJ1dd0pHYZ7KJFYaKBNFafmvlaLWtCGHQGkVaM1DJ0x65aMdA+7M9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369831; c=relaxed/simple;
	bh=ZQVUoLEsJQ4mbXkPg7q4XIHiBAxIhio5vSpPgLJJffg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Twjb8klnRhwvD30ZrWw1WGbl/WCY3Xii5lzPjIIoPCAmI2SjJBTD0+/4pxEAc468YJWw4eRfkLrFAqbZ4534qDptXzLIMqXUQ1CUGUEaakCseuyKm37hpNKTJdIntRQjhzfXPg0s91kZ9OIQePN2hQ+DszoEJm7uFH/CVQLtHnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O/pWTo+R; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6qJV/+x0G+nSQDYo4ikt9uFXcq3mW/1Lvezjswt0E1EcUqi1siq68W3QQITOiW6j6+Hzwwgr754YkSCx9iRg1mDBgT5I8tv9rl36VwA2Bvjd5CBih+6dk73SzGb/c8VLfSy2tudjAmrBKM9Zdcel4MA/Fd6Jqod7SCRr73DWK0VHI2W+2hmjcYzlyyilhAWR35S38qWMzsDpVaeLRFWShO0cXUh+UCx68Vnhue7YpbZ94pibuOCKnDF63hc3hvrVDpy4qwJuE3XB0LM8FmUfj9cPvKirryAeTzeURa2GN67dp4DjhBV4GAmMr8CWSboTDV5/WoUIr4Nn30ylgziaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQVUoLEsJQ4mbXkPg7q4XIHiBAxIhio5vSpPgLJJffg=;
 b=dSoZfORL65s49n5OtqXvWpZZMv3U39RSGK/CDexjmmxS6wdIqyHSLVaG13aBsLlB25YcrijvT/P4wh0lRIFP3XTQJBId9E4f3w0ML/micNP7iJibURimDdNv2kC7+R8xyFV4fETAmJvuxCtogRPZNBAs+kqdXtdoq3KbXRgRdU+/zWLC+wnK76Rnwlr3sWC0Opvuck+4PTpVZteBKr+havxrQukVygaOgRIFRTq0wtk/3On0023Bn9UXCM1w6bLmSk5LJh09Pil+wmEcNY+BiFiRs42in506Sxw0upHRZhRrWjH/OJkhE6puBerDIL1Sdj+srHn0sfivQJ2pMOmsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQVUoLEsJQ4mbXkPg7q4XIHiBAxIhio5vSpPgLJJffg=;
 b=O/pWTo+Rrrk3UcHSBvXvkdQw9pHs5pXZEriBdzngygO/HVA3TcMha7MieZYqlMLNT4+lV7wSqlU0tMSfBu5w8Im4ElGz5nNiKz73I7ESBVXoROEocXyw/TdQbMJ0paNsPZII/6NjdKGUR0MQqNsAa/zV+9alSjMRD4dSx3PD1v/yCgWygJY7WUJCF1TwLlZpd9EUgimhYCfsQD7AR8kJUJ4cfex3lD79V8GemGEn41fho/2DRyI/l7YV6DNW+2wKQyScizi3qQ2yubl2qK1lCnjGT8QcwiO/aG2Dsgr6BnveqapHd/M1A9wbwEFfD11eGigxsvj8/HbP2p9nI8ui6Q==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 08:30:23 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9052.024; Thu, 28 Aug 2025
 08:30:23 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] microchip: lan865x: add ndo_eth_ioctl handler to
 enable PHY ioctl support
Thread-Topic: [PATCH net-next] microchip: lan865x: add ndo_eth_ioctl handler
 to enable PHY ioctl support
Thread-Index: AQHcE0HXFWoKGDAWSUmG4iBarppuCLR3swKAgAASdwA=
Date: Thu, 28 Aug 2025 08:30:23 +0000
Message-ID: <6ef06c2e-c661-4f85-a61b-57974121c192@microchip.com>
References: <20250822085014.28281-1-parthiban.veerasooran@microchip.com>
 <646c6431-274f-4923-ab9d-bf0116645745@redhat.com>
In-Reply-To: <646c6431-274f-4923-ab9d-bf0116645745@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA2PR11MB5036:EE_
x-ms-office365-filtering-correlation-id: a8cadc16-0695-4867-287a-08dde60d21d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWNTSGhBTXpVRVA5SzhWd2NMeTk1Nk9DTUVvRkkvTUJQc3hFR2FhNjM5RlRS?=
 =?utf-8?B?bW9nVnpUVGpGaHF1Qlcrd0pjM2t5YWxycWxEdExXZVBXcWVUaW5TcGlmWlcw?=
 =?utf-8?B?RktzcFJBK1cvTDcyVDJjYnVSb0JFMFA3SnJWQkRWK3NlVkhheWNwdWVmcjBv?=
 =?utf-8?B?c1FuVklSQUROaUlUTXhRdEllZ0J3VThSUDBQQlk4NkpTdmdmR2g2eU96NTV2?=
 =?utf-8?B?YXIzRnpwZmZYUVRuaUNpSzB1emlBZWdUYy9TQzZHV0NBWnZPVDFpblpHNUQ5?=
 =?utf-8?B?MkxlMlJHRWIwNkE5ajJ5RDBzOE9haWNzM0Nla3lTTFdPd3ZVNG4yd0s3Wjhs?=
 =?utf-8?B?eWJNeTJMTHlSOS9rTEx4emdlQnNWV1NNeEhBekFPRUtJUXh6amhKanRVQTFB?=
 =?utf-8?B?NFZoM3poREthRmlPRGU0RFc5VW5Fb0hhb1hFMC9rQ0tWNjVQL0IwT2d6Z1VC?=
 =?utf-8?B?RFp6THJHZUJDVysrMWVtVmxxV0c4N0JQUG1HcmM5cXd4T1ZFZDJ4bmdsa0w5?=
 =?utf-8?B?cVlwL0MwS3hxWG9qRlNXRm5Mby9vdE41dWlxNEEzU040NG5OTEZnUDlYQmd1?=
 =?utf-8?B?TG5xOVcrM2preDh3WDZaWGw3UkNnTEtxaFEvK29mQzl4dkxVZ1ZhS3BDM0Fz?=
 =?utf-8?B?aUg4OGl4TzU5YmRadEJCc3RiNGhnQ21TTmlHV2M3WWh2NVRiZFYzR3pXNjRt?=
 =?utf-8?B?TFJqYzJ0Tnp6eUd0Ri8xZWRnR0NWNkdVSHNFQ3lwVkM3ckpPMWsrYjdjdGRx?=
 =?utf-8?B?eFJTektSekMrRHZMbUIySGtaVnMrU1Q2SmRWVUFVNU1SaHBsbFdnVW4rSEpN?=
 =?utf-8?B?U1hpZkJTcUtuZ1VZUXpMWUVLTyt2TU9nSytzeVhjOVIrL2V0LzU4eEVKRUcr?=
 =?utf-8?B?QUZzbGlrKzU5STNSdzVkTUV2WjdnR2pMYXpoY3RWbkpHSzJsQkF0VmFxbStD?=
 =?utf-8?B?aHhVM2RRSC84VitLaWdFR3NmQzIrbklBOUNCaVVldnhMRWhCZWlEYWUwWmYz?=
 =?utf-8?B?QU9meUY2MVN6TERKWXVXcm5UV1gzWmtId1k3WmprNnJXTGZiYXkzYWgvODR4?=
 =?utf-8?B?NkVjSVQ0eFNBWTN2aE1qRnYvT242MkdjMEtONkw5c1N6Y3FXWTBDZzlRZlJK?=
 =?utf-8?B?ZlhlZ25ackJMeVFSUjlOaWJEQnh1YXdQeWZYeXkxd25ZZ09aUHZiOXRVbDFn?=
 =?utf-8?B?cGVpNjJ4ZWg2WDB2YTIvWS9Bd08xeVZXRDg4YmxMdkRCMTJraTk3bW94SGZk?=
 =?utf-8?B?UUpNVVhvdldjYVFKdTlzOGtnZFF0ZldlODFIcTNMVWhCaEsvRjU1dHNZUGxQ?=
 =?utf-8?B?eTlkd0plWHp2ZXd5WFFXdXlQUGNIQVAxc1hnYXMyV2JRZXBNRTcrdjZ3ZXhL?=
 =?utf-8?B?YVJKRnZlS0dZeEk5SVlrNzF6Z1JiSVA4bmJJWkpLK2xrWk5XY2pPRzFObko4?=
 =?utf-8?B?NC9mdTBsQXNLRDh2RnVTQ0lpYXA3b0o5bVhpcEFKTFBBTTA0K0RCWDRoVS9D?=
 =?utf-8?B?aXlCV2RnM2ZxY0xMOEl3eC8yTUlzQVNQOUdIc3hmVnMwOEVvRjlCRzBlVTc4?=
 =?utf-8?B?QitMeFBOMy9kYmFRVlUwaWl1VGFMLzRPQm9nRHZMRTdXUDJmNzM2eFpBUXBB?=
 =?utf-8?B?V0hmSkVNckwrcWJkN0cyYlFrWGNBZFpLcUZvWlczNThHYmNkUUxhTnRHbGYw?=
 =?utf-8?B?NVVHQ2syK2ZTemMzRjlDKzYzRkNsald4TE5vaVFuRFEwdGNvdDdrZEx4aDFG?=
 =?utf-8?B?WVdMR0gwbXpObWlkdlpXeGdSUENUNkFwdGFzM1NYL2E0NTI5alpmNEp6TVUv?=
 =?utf-8?B?VUhVSzZINmlzNklxNld6alNWZ2dKc0hxWUpBUW5MckNMM0gyTXpVelVtekJl?=
 =?utf-8?B?YU9aWXE0SGswZFV1Rm5MQUtnTFNvdzhCUHl1WFJhS25uWGJNSng2T1Q3RDFk?=
 =?utf-8?B?VDVWT1U0bUd0ZUFxaklyaUhKY0p2Z1pBaG9HdXJyZ01LSm5vMlhTZ1dVZ29P?=
 =?utf-8?B?V2FpNUcxbkt3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym5pSkx0V1pycm9ScGk3Uk5xNjRwckFYNE8vNDJObEtUblR6SGJTRmttQWgx?=
 =?utf-8?B?bXpMV2g5dFhpYy92RlJDVXFOSm41eWVEdUhUV2QyQVlIajhhSk82U09UNVJC?=
 =?utf-8?B?Z2l3bXU3cDFqb1IzNks5ZmhNbzFWOUhJc2hKMFU5QzZEd2ZJMUF3RW1PVWRL?=
 =?utf-8?B?NnYvV2ZkdDYvYkMzMVFyVmI3ekpEQnhIYkhSZWR6S3NReC8vYjVtWkVqQlJN?=
 =?utf-8?B?ZnNGUkQ4WndQS2xBT0VrdjVHZkRjbkFJZFlSV2Q2L1Z5OTV5ZGJnNFBwZEs2?=
 =?utf-8?B?ZEx5NDVOWE02NFJpcXB6OFByWkQ3aU1HS1JCbkd3WjlIdFdKcHlKVkFBdWlK?=
 =?utf-8?B?MEt3T09aVzhSZmx0ajV4Ky9BV2tkbmdTZXFSYnJRalBvL3RleEE4WHgrL01O?=
 =?utf-8?B?VmRERGozTko5NXBCT0o1U2VSZHc5eTBZN1I4T2tJcXgveVFtYjFwUFVNUnhu?=
 =?utf-8?B?WjlHaklFT2JDUHJTQmtNQkliTmpxcnY1cHVNSnFnYXJRUGZYNE9ZQlNoa0xG?=
 =?utf-8?B?RnNEWjJlTkNpTVkzelVMSHBUUnpTM0ErTVd3b3M1V2hHVk9KVTRKNDFhSk5s?=
 =?utf-8?B?dlYxZmNjc0FNOEdOd2twUHpGZEJEQ3VmOGUyVUVVci9GN0ZGc1pHbUZrQTcx?=
 =?utf-8?B?ZlV2K1FyTkk2blV1UCtDSVFvYUtxTTVVdDI3K2xETkgwSWJuRjdPOXhna0RI?=
 =?utf-8?B?N3I5OGZjWkNHS0RVanBMUHFGbmg2cVIyeDJldWpyMW9VOXMzMXNjWVVzejZY?=
 =?utf-8?B?OVVVMzEyVExaNnpmRTRtc1VXcEZRSEJ3YmZES2xQTDhiUWhUdGhQc2F4VDJs?=
 =?utf-8?B?dmMzNVdEL1FpbHMyTXd4QjRnZVBJdFd0UG5ROS9sT2FhbTk4eXZEcnVOYU1x?=
 =?utf-8?B?NG9na0dPWSthTjB1bDBaNVpUa0pxeXFKQlZyL0xuNytGczhhbzlmQ01GMklS?=
 =?utf-8?B?OS9kL1l1UUI5MTdpOGpnRXdkVDRWNHVScVNRUjdjVHcyUWNTcWY2TUhQYWRR?=
 =?utf-8?B?eHhnRHdYR2hUNzhteG11eXgvak92RGN1ZWNGTk5BT244cm9KSStETk10RXo2?=
 =?utf-8?B?SXFmNTROVWpNZk5vUFdES3licmJZNkM3VzBYTkxkTTNRWVBNcklBYVRKSlpz?=
 =?utf-8?B?bEZwbXJGYmljeDhqemlqZEpQT1IxWklreUIzSmI3amtkRTJwclNWVFpnYUJ6?=
 =?utf-8?B?emtvSjltL0R1M2R5UElQR1lzUkZUYTRQdWk3eFRsdXpqRWlSSW1RcVdpVWFz?=
 =?utf-8?B?djFlY2w2Q3BZbFNvUWlkd0kyUUNZNzRBNjNLOFY4M2ZHWFBJZ0piM2ZUbDdL?=
 =?utf-8?B?Z3JUZjFMbm1tZFJiM2hHWk12NzJ1U1A4MDc0QmZncjhPTGVNZkQ1UjU1aDJu?=
 =?utf-8?B?aHRvZDhIcDNzeGx2N2tYV3dya2JzWFNocFhDNExwYXA4M0NFaURONEF6c0NH?=
 =?utf-8?B?MngwcnZOQjZKL3gyc0JwRHRZTE5vSzRTM1pCMWF4M2M4YkNQZzRTdU5lQzlF?=
 =?utf-8?B?UytHNzQ1TFB4UzFBWC9QNFhWREt3czFxM3dqMEQvWVlvMWhOTTBCdjJyaWg2?=
 =?utf-8?B?U0JoUENzQmVub1lLeXVjajI3UHNPVHRQWWtEN0lVbzVJN3dDdGVMNGlha284?=
 =?utf-8?B?bDhEMGlJbDh6RTBIbE5aN3NRMThpbUpJdExBa3FKMHZQMW8zNjVKbGhvQXNZ?=
 =?utf-8?B?Y3lQWldVSFRkWk1SaDNlMlFDVjFhL201dkNPOHo2ODNoWFFHNFd4ZDZTcTk2?=
 =?utf-8?B?ckdEK0ZHazhxc0lVSGF2RTM2YUtxZ0MrM3RnWWQvMlI0WTJxTFV1Z0VjY25n?=
 =?utf-8?B?aUdiZXhpZGM2d2dWUlJ3YktZcmwzdDkxc1A2SEswNTQwY0VnU2ZrUlVtdnky?=
 =?utf-8?B?bVdZcWFwb25nWkdLT0ZTL2k4d2hna3MvRi9uS0p3MytkSTB5UHNoa2RJQzBj?=
 =?utf-8?B?SW9KSmRzYXZiRmRud01rV0dXSTRGeEU4eG81QkZuTFhwdVN5aTFCb3VpTVRs?=
 =?utf-8?B?ZkxVRURQd3lqTDd5bFJ5c0hCbGZaeE4zdGZVM0NKR2lST1ZwUjFJSFZUaTNI?=
 =?utf-8?B?RVRxTGhlWjFsMTZYbnlxYnBvM0RobldBbGxMNUh2bGxpajZpU1hHWkZ3MTZV?=
 =?utf-8?B?aDRBektBUTYyOWdDZi9WUWwyelZob2h2TXhnMzhTNWc2Tkh5em1iNWIva2xC?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E344D7B7B623B6488EA4C97CEDD65E7F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cadc16-0695-4867-287a-08dde60d21d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 08:30:23.2610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: em7uS23ikZVdg0NPX1j7PTzQ/oQ4vU0mCcc68zhYkWwjOzBwJgrLbbhHni/Mu1r5U8hpXPypXLGAuomOXnSIzvj/HMcGWAWM7lATNXq+/YaqFY269L6umzdMzhIk+OMN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036

SGkgUGFvbG8gQWJlbmksDQoNCk9uIDI4LzA4LzI1IDEyOjU0IHBtLCBQYW9sbyBBYmVuaSB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA4LzIyLzI1
IDEwOjUwIEFNLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXgvbGFuODY1eC5jIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXgvbGFuODY1eC5jDQo+PiBpbmRleCA4NGM0
MWYxOTM1NjEuLjdmNTg2Zjk1NThmZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21pY3JvY2hpcC9sYW44NjV4L2xhbjg2NXguYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWljcm9jaGlwL2xhbjg2NXgvbGFuODY1eC5jDQo+PiBAQCAtMzIwLDEyICszMjAsMjIg
QEAgc3RhdGljIGludCBsYW44NjV4X25ldF9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYp
DQo+PiAgICAgICAgcmV0dXJuIDA7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGludCBsYW44NjV4
X2V0aF9pb2N0bChzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2LCBzdHJ1Y3QgaWZyZXEgKnJxLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGNtZCkNCj4+ICt7DQo+PiArICAgICBp
ZiAoIW5ldGlmX3J1bm5pbmcobmV0ZGV2KSkNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+PiArDQo+PiArICAgICByZXR1cm4gcGh5X21paV9pb2N0bChuZXRkZXYtPnBoeWRldiwg
cnEsIGNtZCk7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZp
Y2Vfb3BzIGxhbjg2NXhfbmV0ZGV2X29wcyA9IHsNCj4+ICAgICAgICAubmRvX29wZW4gICAgICAg
ICAgICAgICA9IGxhbjg2NXhfbmV0X29wZW4sDQo+PiAgICAgICAgLm5kb19zdG9wICAgICAgICAg
ICAgICAgPSBsYW44NjV4X25ldF9jbG9zZSwNCj4+ICAgICAgICAubmRvX3N0YXJ0X3htaXQgICAg
ICAgICA9IGxhbjg2NXhfc2VuZF9wYWNrZXQsDQo+PiAgICAgICAgLm5kb19zZXRfcnhfbW9kZSAg
ICAgICAgPSBsYW44NjV4X3NldF9tdWx0aWNhc3RfbGlzdCwNCj4+ICAgICAgICAubmRvX3NldF9t
YWNfYWRkcmVzcyAgICA9IGxhbjg2NXhfc2V0X21hY19hZGRyZXNzLA0KPj4gKyAgICAgLm5kb19l
dGhfaW9jdGwgICAgICAgICAgPSBsYW44NjV4X2V0aF9pb2N0bCwNCj4gDQo+IEl0IGxvb2tzIGxp
a2UgeW91IGNvdWxkIHVzZSBkaXJlY3RseSBwaHlfZG9faW9jdGxfcnVubmluZygpIGFuZCBhdm9p
ZA0KPiBzb21lIGNvZGUgZHVwbGljYXRpb24uDQpZZXMsIHRoYW5rIHlvdSBmb3IgcG9pbnRpbmcg
dGhhdCBvdXQuIEkgd2lsbCB1cGRhdGUgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBy
ZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IC9QDQo+IA0KDQo=

