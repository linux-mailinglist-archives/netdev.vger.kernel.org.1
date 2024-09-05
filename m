Return-Path: <netdev+bounces-125621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E096DF77
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6239B282A4A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0001A01C4;
	Thu,  5 Sep 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ElbxNreG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61619FA8E
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553409; cv=fail; b=FBwPczgm5BfUQAycxeniEAtMzHTFzkJjq5UwA7lCAZPtgFe/iQNnUcYQ7nKipa6grLMMX/sz4HEQjeig40zD2eBrhsMLywxq5dNaRdDxfhp3H0oCa9Pv9kclTBE558ORlSHazCie2UlCC4RAJ1Z/1j8ErBPS9jnvHeymk2TxaEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553409; c=relaxed/simple;
	bh=5FKReP5WShI47vyyYrqJb11wJCR45nk9ctgTuNHd9Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLz6l0KqogrGj/ciFRJHp7GscZ8I6HSTXLckGtCGWia64A5MljMdbWi2WskscYUZ8VRMl0Q1JYXMmO+n2+JcuOX3a0sqYobKyb73EaVbQzKJNu8+9oMEtTZhNfECWw3NbYYZdyP/St+9VzX0J0ipC/I/C2xfj5yKVRGa2rfn7zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ElbxNreG; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZWOE2DhHp1sWuxhywKVIbmn0OkNLiDRgXNecyltfnB2i9E2ZXDOi8e4Hj/bsI3hoflzbpY4j0BadsvOAT8uY6nlHKQgANu7vB6AMpHuXrcPs1bUB2mviqHi6a06oexzhGY9WYmcpT8PeH95k35LLKon3BpVs0ADXtRpLhKDbpQiFpvo6CH2ERs4cUGofAhb9XEjJYoFcrQ5vzkiuMEp0Uo2QEtRJZerEcwTgxaypo+tDOqdFHNoiQnx+v9jOQDDKNB37TjI4wpVZHODWxxJS4/IugstvLhkLfoDAhpJmyiAuFsPGH7rHqwKxbWom8LhG/2sMW0IRRsDFgn1SosHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTukjGSH6BH7kFbV73FVmqImy/QxUayHgBHBTuTSgS0=;
 b=MyUrq9EPy6OtfXzUqtHhxOMjEIGqPeoJZcBkAUKB70qIo2UDS3PyJ2kZozvMM62tft0znEMW7Mf8hxX4u3DuMDmRZ0w+TSdcPSIx6Nk8zmH7vgtD3ea6rDG4rn6gASVqU5kX2IWOswItKbewKlet4Mw/gJpPvZVHg7C9VrAUh1oEcfEsk8WLj5gMKO5WQDoaYPus5eGIL2vIhMWSf/rEXSmImpq4Oq4lYy6+Qsd1tImmYXmP5vDFji6zdK6FdHr4QMGT4rTd3duYMY2OWbcCxZaDU3EoLev1WpJ0Wf/Z/e9hHlpEci7FMdwYbfDwl5DAN2v3DGgItZTbok0QfxqXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTukjGSH6BH7kFbV73FVmqImy/QxUayHgBHBTuTSgS0=;
 b=ElbxNreGBcf+mE780Z1vZUsIa3n1DsywZzdz9CLMvAUDZetpMkOeJyXXZ1aRBV4MwN/83JJ90z2feRheKi13W5Lj8epZ+aBYZ1Kdxla9XIaS4MmtIC1yikdOwj6j1MuVD4lzFf8QwAbTj/sleeEPtMjUQY3HqBoT7ZQ68XssxKUZxw+CQk4NZJb6ffwiNhGM39R3j4tJYZ6Kn4sJ3ofkwFpvNa8ZqpbNCgHtlGQItyVMUG51RZS6wvFycIQW7T13gbvSOcvCo2dv0eQD8R48cLNyKL2h0v/WFv99fNMTu515Y+IDyEB7d3cvkq3p5mdS4VX7fTxiTg6zZDxch+iM9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 16:23:24 +0000
Received: from SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95]) by SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:23:24 +0000
Date: Thu, 5 Sep 2024 19:23:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: gal@nvidia.com, Tariq Toukan <tariqt@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [mlx4] Mellanox ConnectX2 (MHQH29C aka 26428) and module
 diagnostic support (ethtool -m) issues
Message-ID: <Ztna8O1ZGUc4kvKJ@shredder.mtl.com>
References: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
 <ZthZ-GJkLVQZNdA3@shredder.mtl.com>
 <b0ec22eb-2ae8-409d-9ed3-e96b1b041069@ans.pl>
 <7ba77c1e-9146-4a58-8f21-5ff5e1445a87@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ba77c1e-9146-4a58-8f21-5ff5e1445a87@ans.pl>
X-ClientProxiedBy: LO2P123CA0107.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::22) To SN6PR12MB2719.namprd12.prod.outlook.com
 (2603:10b6:805:6c::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: de48b8b2-eb02-47e2-c44c-08dccdc710cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2lWTnZWYVpiMlJ2cjl2VGlDczN4VTQxS3hCeDNaWE1ld0E5NDRrditOcHhj?=
 =?utf-8?B?eDRRNTJYMUdLRmVXUFA2VTdJNWQ0ZEQ5WkdFb0RZdnkxL0c0WDRTd01yUHA5?=
 =?utf-8?B?ZUlraDVWNWlrNVhJd2RwMURmOTUvMVM5YjE5Y3drbC9TL0h3TDVXZGZ6Ym82?=
 =?utf-8?B?c2NFUVhpMVNrdDY2aklaVWFXWmVBNnlVV3puQ3p6Mkd6Y0w0dUoyOWJYUnRT?=
 =?utf-8?B?ZW5FRDl6ckNBSC9TQTRWVVFaT0pUQkpMazJuVW1SOG5IM2dqTmlMY214ekoz?=
 =?utf-8?B?OU9yL0c3SWhjaTBzam5qbGhoUkhiSlBQRFFhalFrK0RjUnpZSWJCTFBjNkt1?=
 =?utf-8?B?VlZmU3R6Ni9rNWZpdGlmK2NUczhLcE1ZTXR1ODBLUG43NERLRGlPV1czVERx?=
 =?utf-8?B?ZlV5L2gvS0FzTFN3Q0cweFJHc3YvNTdTTzhEU0lyMmxqVmQrVHdzSUNuMkc1?=
 =?utf-8?B?TldIbVN0TFdaRHZxamhqaGJTcVAvLys3ZllyOHZFRzM1ZTNSanlsK3V4c1JC?=
 =?utf-8?B?enJzWUZSZjhTSzljZ05kdjIxUkcrRVR5WTZ2S0IrVGROUTBDWEhpKzhQYjdH?=
 =?utf-8?B?dnZhNDRYUTVWSHE1WTNKK0FJc2ZGQlBzWVZ6M21FMXVKclltQmZETFZ5RHRo?=
 =?utf-8?B?Zzk3Sjd1ZXRsZ1JyZ3JOeXkyOWNINTBBM1puazBBUkdCdEVsNHhkZmhrWEZu?=
 =?utf-8?B?Vk1lWWlMcnhWVHBCKzFqSzJQM3lmNEhIQlZWcng3UVBSak9zNTZ0R09qUU1F?=
 =?utf-8?B?S2tndytQQWovUW5nYStKQjFwT0lXNWdVYzc3M2E3L2c1Nnk0Ykt2OFJqQlpl?=
 =?utf-8?B?cHFkZERIQmlNa1BBN2c1TTg5THB6RG5wcGpmNnREaHdNeTRGRzVDTmN0L0J0?=
 =?utf-8?B?alo3UkMyekxHbEJtQlpQL3FiY1JMMC9yVGxDU09xcW1yY09URGMyK3ZsWkdh?=
 =?utf-8?B?Qy9EZUdsL2N6cjFWc280b2x6Qk9mZFNTazVOVWlOOVdSMDd2R0toNWtXOXl3?=
 =?utf-8?B?TWdqNG9mYmVUaWtVZU1Xckx5aytJMThBbmlkUWZhb2JxSFZoTGNNVkttVnhO?=
 =?utf-8?B?OG5wV2cwK3dRbXJBMzNkTXZOaUI4Y0oxaGNadmVlN3VWLzlEdjlTaXAyVXZQ?=
 =?utf-8?B?ODhwVFduMCsvaktwMkJRaFI0VEpobnJlWDg0dlVnNFBXNE44L3F0bEhtNW5l?=
 =?utf-8?B?citETTZRQmVqR3h2b2pqcnIwTEVhWit5NS90T01FaWgzVmlPUFpUcjl2ay9U?=
 =?utf-8?B?TnJadGw0d3hQREhqckFueDRZMzRKM3A0RmRLMjBVM3J2OU81L28raHR2TEpl?=
 =?utf-8?B?Vlp5R3hsbnFhOGs0ajIwdVNZamdLaDNxTFp6ZUcwOGJQSWhCbktjYzdOUjM3?=
 =?utf-8?B?c0xEWkJhenJrVGJocldqcEJzMy9uTmxmYjJ0aW96NS9SUGNnZWJTSzJEN1lT?=
 =?utf-8?B?NVVJTGpWYUlHL1dCREN5SUdkY1dTVHdnUTZYS3h1RXAwa1AyM2J4MWY0SEI5?=
 =?utf-8?B?STdDM1VEaGtFTUw5eFFpWGxzc2VMT212WEhvbkRBNjgzRTZhZUxTNklIeFFw?=
 =?utf-8?B?RTBvd0NRV1R0TWJUeGtlU1RVcDhwTzczWjdSUTNMMEpaaG1hK2ptdy8xbkZW?=
 =?utf-8?B?RkV5aDBmOURQeVQ2VGJ5bkVlSnVKNUhwby85T0FhYytCKzhUa0t5RVBKOExP?=
 =?utf-8?B?dzhwWTBENGl0aDRYUzJZdlJ3VUtTQVpCcTN0Mk04bDBkOXh5ZnM4TENqbW5V?=
 =?utf-8?B?ZEFpN3ZYOWxBbDUrcHFEaXE3WjhwT1hJdUhsUzNrQ0FFOWgvVFdDZ2E5ei9J?=
 =?utf-8?Q?y6knI1VsJQxQf3BY7nPAuUA0ESQV6M9qarne4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVdWdUhCL1dYcjBDeVpWWElwY2FUb2Zpd1lpTzVzTDVHN0FpOFZ3dG1HOHNy?=
 =?utf-8?B?aEVFTzNVVWFlVUZSeEJwa0IrdnJRSUNydVAxSG9jSzJoVGJpcnRyWVY5eWlF?=
 =?utf-8?B?VHc0ZGVibFZGNGd6Zk92Q3lLVjJiUFhWQlVlU0R5UElQVGNTUDNhQkpzUzkv?=
 =?utf-8?B?dmZnQmlRanpXSThwRVh2dGZDS3BMNmYxcm1zSTRjdEQ2WlBja0Fxa2p2TEFw?=
 =?utf-8?B?cnpIUDlMV1QrVDB4QXU2M1h4S1JjZlB6MkRLSkN1VHRoMWdUZkJCODErTjIy?=
 =?utf-8?B?TkpRdDEzYjAxNmp5VXlqWEFid0MyVDV0c1BOVHRSVk85cFFTYkxpYStqN21r?=
 =?utf-8?B?a0lta1BZbkQrckpVMWFaUktqb240V2I2bHc0Tk1qaUdwQ3ZKNDRQeFZBamVw?=
 =?utf-8?B?QldWOTZSRHUwYXVMWmk1dlBSRGJ5NUVXYlR1OC9EUFk4b0pJOFhKUm54K3B1?=
 =?utf-8?B?UWxmdVNYdlB5eEVGdExWUjI0WGRkU1FSdWxsYkFoSUsvTVJySklCdGV6ajNP?=
 =?utf-8?B?V2pnWE9CNHpmRUpGTmdqdHdrU0hJQXBSeGRTUnNBY0tmZDVFdWRib1pMU3Vx?=
 =?utf-8?B?V2pVZVBwVDVBc3dqYzdpU2laTTVnamdrRnRDL3M5UjhDRC9USS9YUDdZcUpm?=
 =?utf-8?B?cGo4eWU2VGdpb2JLTFNUK1krZnE2QmM4LytPODhhcFVXTngzbXNJWFlGbmo1?=
 =?utf-8?B?QjlmaXArQ0RaVDViQk0vTW1nMEViME96V1pZdWppQUFIQ0NYVW5YNktqejVt?=
 =?utf-8?B?aVZ3M2s1WUFTWEVNNi8yN2grK1lvSmpsbmxhYjJCTkRSSU5XWVlXcmVGN0Yy?=
 =?utf-8?B?Z1hFanYvaDRzMG5IRnk3WGZrTmtuQlFXSmxWNFU0OCs5a2p0UVM0RkorUTM1?=
 =?utf-8?B?T3hYL3M4SkxHeTV1UE5Sc1BFM0RyWU4rb05iT0NhcnVuYmtLalc3ZkExSVhS?=
 =?utf-8?B?aWZNQ0tkUnF4NzdvMERZRnh3OERzVmpSaGFsUUZLSExjU1pTeGZQQU14RGc0?=
 =?utf-8?B?Z1p6QUwwNmJCb3hBQ2RvV1J3d3ZDYUxudDZWazI3a1ZtOGVlSlRPRVpBMWRi?=
 =?utf-8?B?MWQ4OVp1bHZXa1NjNVUwVFB0SWpnbTVWL3NnNk9GTGxER3dUblJya1BsL1No?=
 =?utf-8?B?U1pnU0pkWVpKQTFhb2NHdHBSMzJGajJCcXFkeGJGelc3SitlMHA0cnN0YjNw?=
 =?utf-8?B?OG5ZeEc0eGN0cFJRTlhnRnEzYXZsQWxFZDJlRXdKOHI4WG1Oa3NIU05FSlMy?=
 =?utf-8?B?S3ZORDdHYVJQVjFPdTFVeVZHWC91QXhGUmRFeFJPVFNyL05UV0RtczdNb04y?=
 =?utf-8?B?Q1Q1RGhyaTZxQXJzdDBtbk5TbEFScUZaZTlRcGpkaVUxUUlueHU4empqck1I?=
 =?utf-8?B?MDdGMS96RDRGS2s1NHhwRytHRmM0UGRXN1RQZ3pUdVhUWTVhQUNOV1JpamRP?=
 =?utf-8?B?alF0cXpKUEkySlJIcnZibUFHU09oWHByUzVaWWRKRlFPT3d3eUhramNvSHQr?=
 =?utf-8?B?cko5K1BUaDJ6RThXQy9LbEhpWGdNd0xqRW1xZmRjZWpUdzk0SEl1Mm9oOGRn?=
 =?utf-8?B?VEMrVEhwUHFpL2VvckFiekZsMC9WdzZXeFNVeVBxOUIvcUN4Q0hYOW1EbTl4?=
 =?utf-8?B?dEFZY2Z4TVh4bnRsbHcrNjlWTTJUaEdna1o3TDlyYXo5elFQNERuQWw4WExS?=
 =?utf-8?B?eWdQc2FPZkgwK054SVZqVjhjRCsvc2F0VmNlWnVBbGlUdTlGaDd5RFYwRGMz?=
 =?utf-8?B?aGdLdmtSY1pSV0JSODVmbVhtQnh6eWw1Zk11cU5qYm9mTXlOQUd1cG5NRmoz?=
 =?utf-8?B?c0tKQnVUaDV2NmZIdTJEcnl4dSttcE1YN2FXaGx3dWc3RUVNck14RW1RT05G?=
 =?utf-8?B?aXo2RHh2S0psS2MrdExWd1NZUlZPdEN3VVJRNjBtWGEwQk8wYkNvRTV2T1VY?=
 =?utf-8?B?U1gwM2x6VENRejJzZjJwNE02M29vMi9DQzZuQS82Z0JnOEtzd0NWeHdrV3NU?=
 =?utf-8?B?cUlPb29yVXN1OHNrUmsrcmFmYVQyaHpvK2NUaURZZWZWM1ZMTVEwRFFXT1N1?=
 =?utf-8?B?eFdGVUkxY2hqOTFvaEtqQWN5V2RpTkh5OE44RnBEelE1NUlSV1dtMHJGenlO?=
 =?utf-8?Q?Os7fgaC8WUS5WdQauyfw9gvPX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de48b8b2-eb02-47e2-c44c-08dccdc710cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:23:24.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABRzwI8Wq6ORywXQIGwPpd9OcWgVwNORjvoDDz92s50IV/FUwJ6f7OzARI4A6+7bsliQK8OqeQPLCBygZFuOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123

On Wed, Sep 04, 2024 at 09:47:04PM -0700, Krzysztof Olędzki wrote:
> This BTW looks like another problem:
> 
> # ethtool -m eth1 hex on offset 254 length 1
> Offset          Values
> ------          ------
> 0x00fe:         00
> 
> # ethtool -m eth1 hex on offset 255 length 1
> Cannot get Module EEPROM data: Unknown error 1564
> 
> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(50) offset(255) size(1): Response Mad Status(61c) - invalid device_address or size (that is, size equals 0 or address+size is greater than 256)
> mlx4_en: eth1: mlx4_get_module_info i(0) offset(255) bytes_to_read(1) - FAILED (0xfffff9e4)
> 
> With the netlink interface, ethtool seems to be only asking for for the first 128 bytes, which works:

Yes. The upper 128 bytes are reserved so sff8079_show_all_nl() doesn't
bother querying them. Explains why you don't see this error with
netlink.

Regarding the runtime "--disable-netlink" patch, I personally don't mind
and Andrew seems in favor, so please post a proper patch and lets see
what Michal says.

Regarding the patch that unmasks the I2C address error, I would target
it at net-next as it doesn't really fix a bug (ethtool already displays
what it can). Thinking about it, I believe it would be more worthwhile
to implement the much simpler get_module_eeprom_by_page() ethtool
operation in mlx4 (I can help with the review). It would've helped
avoiding the current issue (kernel will return an error) and the
previous bug [1] you encountered with the legacy operations.

Regarding the fact that these modules work properly with CX3, but not
with CX2 (which uses the same driver), it really seems like a HW/FW
problem and unfortunately I can't help with that.

[1] https://lore.kernel.org/all/b17c5336-6dc3-41f2-afa6-f9e79231f224@ans.pl/

