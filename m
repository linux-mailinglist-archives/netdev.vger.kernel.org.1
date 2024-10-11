Return-Path: <netdev+bounces-134645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220899AB04
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D48B2349A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE31C9B87;
	Fri, 11 Oct 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6jofdaL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B50405FB;
	Fri, 11 Oct 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671655; cv=fail; b=rs35eIUfaMy/jp5Kt44U9OPOOt/zMGzMwPrqSL8plhuapSjJ7499wSE2hGuDt/ZWgHEAhHS/+o7+FvEIwSQcnisbHkE1JqmJrRcYUFhlQrB9V0wC+4+XzJDVzR1b1c1V516jWZre8mlIDSqua8T2XQsXzu3XFP63kfmzMd/E7tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671655; c=relaxed/simple;
	bh=Wicm2UrvJmxLchCWzKKlDuuUO0dk4QJCbv2X80MchS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qraUYJeFhBevdPiTmsvk4z0QMw+HoIizQntgfMwCZX1YABAQAGlNkBBolo6D4uhmgH3huedCmrw84Rjwp/wwQ/aAzmadk01mCsR7W0F4803Avow5Eh6iOSnCVw6LvOsp9fHg14dCvtghUQFhIVSaLO+0IWpvPKcVzCmkte8PIYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6jofdaL; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/xHToVLwq4BePcvbLL70s6KWb90Ob0Yls989yxOGvjpLQf3MJ2cZUxMkcV7pFV+CLEKwf+GHgvCmxBFQm1saYhvDeromFxrMYnINAvG7C2lDBwMOYNlj5bMG9sPjajtw2dygY4YmJcWBCRWN7n9bwf3SEMLaApmMw6RsEPMnLHqkLHFYZ8hsVVM+MWdReAqhN3NTY29xpYU5jQDJnKizYoOgchx5p1HrWWLKT81/TbwSzFjBKmFVQ+Bk+ZO3TJvhw7n+fDsUmby59F5kgDEbqS5F59+Ry6IlOB9pQBSuLIJ2jPMZzfOS30W1187Oh7HH56eNbJvhm7Y0W4UIx8jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjluAKxZ+JV66H9tXpiNv4cd6DSHKoTL/Z7+QlkiRFs=;
 b=NMpBCv1I94ehWZgIDEef7Mc4g/kasrgEbHqKFW7YNKLKJIKOOASG/1bEM1AZILX8yn06ajhmL49/asOj8P2TVwSCjJVwn0UBnA2Si09tWCwlp3ONrAsweX70N7QtYDXE5w+Epk8PcjjyiDRoSL7b4aC3p0CgaKtU7iny6Bxs63FTZYXrZhlAC9KAAezhbxIcp3sMddzaaWYGBBRGBA2cqsmK/mUWopPikxe146VRtQtEjLiBlupoEr3T3SsdacS+s0OA6oZ8OHGiPV2ESd2Yim1ofG6pOC+VLgNqSSx+z51+VOl61kze/t4ehhgq5P6IWjFD6XzAk7q1GJG5BNobWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjluAKxZ+JV66H9tXpiNv4cd6DSHKoTL/Z7+QlkiRFs=;
 b=r6jofdaLlbIx/VepSa08+jyaMzW5jciawVYr8QiUpegD3oeYBQjzgsmNEerTVKPKaD+tkOd8XEGc57HBm8c9SE7sLyKdp1NE9J6E1a0Dm815NDbuehUhDogdJKPd5HzVrPw0bOv+QPbSdZyFcz6K1cslNNBUy/J5GxWY4wgbw86XLj3vteK1mGC48SdXVeyT5/bWY0GV1bJHDSdknN9YA+QldQ+lg4hVBZBiVE9jASEJ5g6v7+jYqEF0wMLbr4fVHtgdRQMIqEjjdTm9qtxSmbuIdSu7DsdiCecdijbXDci8AdhqxnCSyeD2OtZ/49fwWPE4pWqju5ewUdDuf6CTWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 18:34:11 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 18:34:11 +0000
Message-ID: <cd6d8dc3-5f26-4f2c-afd3-c881c1df3160@nvidia.com>
Date: Fri, 11 Oct 2024 19:34:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: phy: aquantia: allow forcing order
 of MDI pairs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Robert Marko <robimarko@gmail.com>, =?UTF-8?Q?Pawe=C5=82_Owoc?=
 <frut3k7@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
 <9ed760ff87d5fc456f31e407ead548bbb754497d.1728058550.git.daniel@makrotopia.org>
 <114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com>
 <795c9b87-ecd5-4fa5-82ae-b88069cbaafb@lunn.ch>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <795c9b87-ecd5-4fa5-82ae-b88069cbaafb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::21) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 6488772f-0bff-47a7-eb16-08dcea234c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHVYL0VjeUFTWXQ1WlVXYURFeTBIbk9zbWl3QTlsZjk5dmJreHlMWVhMblhB?=
 =?utf-8?B?VHRNNFJzZG9odWtvMW9qeDluRjFtSDhZbWZXRGFjbFl5akNQQnErenpsd3NE?=
 =?utf-8?B?R3JUTWJ0cFdWMXBnUkE5TWt5VHJvWEx6a2hOSHp5ODUxeTJkRE11d3pqUURq?=
 =?utf-8?B?dEN1cDZIZTlFV2s0clIrSTJwSTdLVCt5dlluL254aDFuWnBKRWVVQjF2SFRt?=
 =?utf-8?B?WGs5MGFXZDhSTjRpTVoxRXdwd0M3bXZRMnBoTHZCNE1tM1ljS0FWcjV0dkFD?=
 =?utf-8?B?aGJDSjdyem8xUFhnZlpiVXM1YkNxTHdVRmFqRWM0V0ZMZW13NkU3d0xKdjVO?=
 =?utf-8?B?U2NYZzN4MUlkcHBYVkNOdlJUVmUreDhzWWEwUFUxK2pLMFpGclhMUE51ZXBG?=
 =?utf-8?B?elhWbTBlU3ErUGNqL2ZKRG5QdS95U28wR3J0OG5tNVp3SzM3WW9pR0N6a3Zy?=
 =?utf-8?B?Q2pPWnZkTHZtRWpQamJVS0o1ZTNhTVh4bDhZOTFqVE9SQit3NXpNUGtWOS91?=
 =?utf-8?B?OW4zU0hxS3p1My9QcmFLd0xEZ2hIQjI2cHJXTzlIQkR2bkVDaTcyVjFkaVhy?=
 =?utf-8?B?V3lHRERjaXJGcjJ3dEwyZ1hqczJBK1dGemFDck1sOVprZjhhcDIwM2VnMFhB?=
 =?utf-8?B?dGtLeC9xMTUveStHQ2UwcXlxWGJzdWV0eTdMVlBpOVpVdkowcUIwOVJFdnRR?=
 =?utf-8?B?cVBZa0tIcXF5STUxVjA3Z2VtZlpuMk01TGV3RGx5RDNvQ2ZNVTQzekNBb2J0?=
 =?utf-8?B?cEFHTWdjTEh1R3VKbnkzNDVsNzZNRE1CMXJ6bW96QjA2NjBaWENnM0YwRW9u?=
 =?utf-8?B?NURFZ3R1OEdQNFhrMFFIeTF3eG56aEQ0M2tURHRpMGpLMEFRMjd5WWRCNitu?=
 =?utf-8?B?Q1ZzemlLOUpMSWlHb1p2a3A3emNTaXY0dXhzRWVZTlJaUnk2OWxxUlFyTFYy?=
 =?utf-8?B?a1JxRStHYnN1YmZDRTFGVTJPYUFMclg4QnNIL1VnZWZPRk8zUzIvdDMvYlZv?=
 =?utf-8?B?ZTdTNGNQTzB4aUxyMHpiZW9BVEZ4Tjhld3FyOW9JU3IwWVRFSDBNeVBlbzFD?=
 =?utf-8?B?MDBIM2RPWklWc1ZYWklhcnJTVE1ZSldvUHBDWUxxUXlYUmcxY1ZTMk5BNDJ2?=
 =?utf-8?B?MmNGK3UxaVFaVktETEJtR2cwSTZ2ZmRqUWkwQ1ZwSWkvaUd5NGdoWmNyVk94?=
 =?utf-8?B?bmdRQTMvQW83Z214UG1wR0o2RjljMGxKUmJyYXg4VFZyL2h0VURZQ2QvdndD?=
 =?utf-8?B?NlZUL2RWdHhPTkVHYVNJVTdNODFocUN3WWpZNk1xMmhhM1NSRk5lMFkvelRt?=
 =?utf-8?B?QnZhMFl1THhScCtQYXRkTmJKdnU1MkwwdGFPNzF4cjBXTFNVS0lDS2t5OU4w?=
 =?utf-8?B?QWVJdWRRK0E0NnMzODllY2JYVE9nU2xpMFZTZ0VKZEpyOWQwNEVwMEhIc0Z6?=
 =?utf-8?B?Yy9jYTJmVStuVlF5V2o0U1c1QkhIK0tVNVVyaDhLYkNhSHh2aG05dG83TXBz?=
 =?utf-8?B?RFZ5YnFieGZwOTZvckNmeUVWbjVpL0hvUlltMkpCVnVPMmJVc21FRlFZQlNz?=
 =?utf-8?B?ZXk1TjhSNnZpTlhMc2FwR2QyKzQwMVYwV0k3alliSWRXby9PMHpBU3dRcGdh?=
 =?utf-8?B?K08rYUI5cExlVGRUdEh5K01EQmVhMHVKVWRWS0lnR01BcktlZVAzMDNhRURL?=
 =?utf-8?B?ZVZwNzFKbnRXWEhtczczeVl0NlV3M0xkTWlnaEg4c3MxbXFPVVhLaTV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVCRytQRUJyTWp6Q0ZPT0JKYnFzUGVDZXp0MHRIME9xL25IM25FUHBIUDNE?=
 =?utf-8?B?cjJBZEhzYjdORGVGUUc2SHRNTTlkNFArNHppeWpnU3M4WjBtbk9pRXJXYVpv?=
 =?utf-8?B?VWIvQ2ZpanBXVXNNSGpXZ0pUZ1pXSUc3SER6L2VkUzVxRGlVcXVTRFZHZFpn?=
 =?utf-8?B?OCs4Q1V5blBlVjZNZHJ6endmL1N2OWhUVE1XR01UbDVwdW92bFVXbWYrODdr?=
 =?utf-8?B?ckdhUHZvZHNMZDU4Y2FXZ3B1S05YTitEQzBya3hLd0VXUW9tcVQwTlNZZ1Rr?=
 =?utf-8?B?OU4rRVFuZVk2akhKYUFVZTVwQTRTVUJURnhnR3RFd09MdW83d3RlckVkVndE?=
 =?utf-8?B?Q2t1enJGYkpzbDFDUkNDSWN6M2RwUzlFRDZKR2Z0NUxKbUVZRStHVzA3NFlU?=
 =?utf-8?B?amVLdnZlY3JNQzg5NmhFUGNCWEZ0c1ArdDN5ZllDYWVEYWh5RDliUHd1MTR0?=
 =?utf-8?B?RUU2M1F3RWdGSnFiUnZ3ei92MmU3YkM5MTczOFd2WURxemIxQmU4OWczUnZG?=
 =?utf-8?B?Q0Q2RmRoYzA3NnBvL1d3eVd3QzRlQVZFVWZQaVVuRGpXVmYvL0YwdmRrWjN5?=
 =?utf-8?B?ZFNqZ2EwdFV1YlUzK1cyTXB5ZnNwSisvblRlYXJZWE0rUHUwc0kzQzVSa3Nt?=
 =?utf-8?B?bWZweVkvVTdZYi9md0Qza3phWCtlbkoxYWVSd2xlVllzSk4yR3hzU0x1MEFR?=
 =?utf-8?B?d2VQRUpNZm9yRGNDdDV1MjVUUUszdkZ5ZzQ0L1FWR3E4RDZPOWw3REsyMEwy?=
 =?utf-8?B?VVp5bExXNHl5KzBlZ2FncFRqd25VTkFKbm9zSFg2cU05ZnBVb0pWWTg5Wndn?=
 =?utf-8?B?WHRoSXh5ZEZiejhVTWZ1MlpDUG9pbXh5Y3NoZU4xamN6dUE5cFdwUjNHZ0pq?=
 =?utf-8?B?Z0RMSjZyOHJJdU85QnFoWnJvVjAwZEhmWGF6TjVuRkVzcFlhWnFpVkl2disz?=
 =?utf-8?B?Z2NPK2paOW1PZFdTdUJsWkYzYjEySVV6WC9rMFhtOGdwZlBsRWxmcWxWbW5W?=
 =?utf-8?B?R3JRUUc1d2gwS2tnaEloSml6YXFJdkJKQ0M2Wi96aDgyOE8rN1YrUVFVZGdX?=
 =?utf-8?B?SWR2elBRclA2VmZpV2xjdEZraitjOGgxZEk2cVU0L0NuZzd3SWZWNzJkWVZP?=
 =?utf-8?B?S0thcXNueFZCbG9UeUZFZCtlWS9tbG16Z1dQQ3Ixc1F3RXExRlB3SmZvaUxJ?=
 =?utf-8?B?T3dVYjFGZm90SXMwcCt4OXUvcVd1dkVLUHkrOG1ONmtjTGYxOTZramdTQ2JD?=
 =?utf-8?B?VE1BY0FSNkRTaDVaWWZxQlVIVHBJQjdaeEtZRzNBaHVoOE5iZW5zbkVpYUFQ?=
 =?utf-8?B?WDloa083eGN4OU5zOUlBdk5aM3pPTFVVM2xyZlpmZlAxUUdNaWlPaW9kZkRV?=
 =?utf-8?B?cEdNdkRHN1o3YmlMUjNQYTVKME1CcmVPcFNBalVXenp1VnpKaFlNeVNHSEVj?=
 =?utf-8?B?Sk0wTEtjaGxrV2pKQStWRkp0SUJTQlVxZVNDQzdiaDVhSFpPNEhIVXVzbnVl?=
 =?utf-8?B?WE5nVHNsbVJod0RYTXdJczNTL1p4Y1R4RVRsdlRUUmcwZFcvRExCRjl4MjQr?=
 =?utf-8?B?R3hmNSswYjBsemsrejBQT3M4aXlDenl2blowZ1ZLM05JWkN3MEQ3Q3Q2cmlx?=
 =?utf-8?B?Ly9JejFHZ3ZBU2JlTGxTZ2pzQXNybmpMU09Cd1dDSVBkb00xL0JIbUVQN3kw?=
 =?utf-8?B?bWNwOFc5SWpCc0FIWDhGQ0RnY0FGUDhDQXlqZmMyc3p1eTIxaVRRWmdwRTAy?=
 =?utf-8?B?UmgyMjZiUWZDd1ErRjhGem9pb0pLUnp1Y3ZpRzZ2Y0RjSm9CZUEzRVB6ekV0?=
 =?utf-8?B?MWRiV1FNajh1dEs0SW15TDZHNStIM21pUzAzbnhOQ00veEFyb3h2Y3FUb3F6?=
 =?utf-8?B?TXpyOXhkMFN3UUgvalhOdFR3aVNOUlVjcDNxTUxmcjVLQTVXbHBqNzhxcHBt?=
 =?utf-8?B?UjMrekpiN3RkeXZDQjVNSXRrOWVhb2hQTHlqUzV3bVZhSXNpSHMyNUM4cEZD?=
 =?utf-8?B?WnVjVW9BcjdqdTlMUDg4cGQ0WHVCYmIreWgyamtGSXhkSk0zSVBDNXd6bUhv?=
 =?utf-8?B?QjVQZlcreUVOSENodmRrUk05Y2NVaWY5a0lkWGl5NTBob0lSSzBzT3hDd0J0?=
 =?utf-8?Q?LqU/cBzxkAIHGSF49fdwP//sc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6488772f-0bff-47a7-eb16-08dcea234c87
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 18:34:11.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr04ooVUa9aRW5d7HUXmtI1Q/1AaG5TmqvWXvxTFNBwczkB7aW6Nk8njuaARIrLMoOmTEsABA0SSWdJkLXjcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665


On 11/10/2024 19:12, Andrew Lunn wrote:
>> This change is breaking networking for one of our Tegra boards and on boot I
>> am seeing ...
>>
>>   tegra-mgbe 6800000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
>>   tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY
>>   (error: -22)
>>
>> The issue is that of_property_read_u32() does not return -ENOENT if the
>> property is missing, it actually returns -EINVAL. See the description of
>> of_property_read_variable_u32_array() which is called by
>> of_property_read_u32().
>>
>> Andrew, can we drop this change from -next until this is fixed?
> 
> If it is as simple as s/ENOENT/EINVAL we should just fix it, rather
> than revert it.

That also works for me. And yes it is that simple.

Thanks
Jon

-- 
nvpublic

