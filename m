Return-Path: <netdev+bounces-94242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E002D8BEC05
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF961F2131C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337A016DEA4;
	Tue,  7 May 2024 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="px+c7L3A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C816D9C4
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108154; cv=fail; b=ZvUVR5un5wj/umAnFhTO4EnXSIglBtCxUEmTgPIJcWNu79IIaH8D428MHrbr2ovuc3AL07KG2P0nH751BoMKYkHY0Jp72WR2TzwYRJUG/SQ2Jpt6UKNn7cU+JTgKIVRXy/Rx9K0Dk5qHvzjoxr6bvx6xDMN4V7o598u6i7/JjwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108154; c=relaxed/simple;
	bh=OpeTLklH+AgkIQNkPgevCe9YuBICkJL5kl9bMO734Uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AYCW3x5yHOE7PG+ecSmbxGTQz3pJ2qkhPAJ3HMqyWr5DdMlxA2arbFNzMEbL9P6GzdM9Q/Ykn8svtCZKPvJ1FmTJnM++xduQ9Ue0JRbphj7jMTBi6p2aKiYqhT5m/2Y/1f77ME+I/yvsxVzQw0yzRQY1qNUMqPbQXiXE4hLKQIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=px+c7L3A; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNKipSICgeN+NKsgll6dI8xi6DnIVaSWm+HoVLQyaze1ms+fgkpfgTJeoY904raQ/F/OBwxoPHJ1+XYiyUdLRjfITz5rgwhq8ROLymF2yS0sEFKR9jx7huK/889T51gJuf6SGnWyjAmmLXvU0FOoi6ztjgn6394rflMYMQ99ov9AX5yqQvUfF51Z1rdJ2HhyQ/+FVZN5gBEw9DCIIo2gxrZgTk7exXLc+hw+8kQbR9N068eV7ois1mVnymOgwb4rSC5WuzcFSED6BEZHeIwkxQEi+TJz9mVoGrGVM99YqfoNjgsUjrU4YKP9XTi/KPC1HTE69TDcDk4Nd6Ll2tf8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFcakyWY14q37fE7rrkCJGhP8tGYK5eCOMRdj1cBQsE=;
 b=M/RVQ4jumCxvJKTvG+XWOK3svteysshlIvSieaJqlsz3mjytLkN9wJ996mNHLBzTCOFTwsm7FlqKUXx76SOTJw5nYQF9dGkzK9N8zrFu6FtUdDs1/rjRdaSr+dFYbS/gaKloF4Ysx/sBOsyzC0zRRbwDquJuXOvoVxX+4UYRWoWNBS98J57mlQnee5vZ7U4+l6yNpzDNKy/42ucpo7jQjBMO0B+SxLoAoCB6CABoQRcJIYdYhh9bZbyU3qi0T/V1jfzxd69rXNhT8T7y9pdNvSBumirKZBT6Fi8Qd9O6xWfAIxmE+/5wAbSdmIK9qKSDXo+SWQJodqeorn2mysJq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFcakyWY14q37fE7rrkCJGhP8tGYK5eCOMRdj1cBQsE=;
 b=px+c7L3A2HzuVLwnUoMAQjUFSvGTR3HL+0oWyQxEFLpEyfDu6tomU6w9qGnyY0AXej5diJKKwj2BoRJ2jegj5MxIG3q0+bZNLCaJPPLvvCTlLhN/LXabjE4vPmQUehhAVfjzKAl0Qtkuh9KQWFf34cI8TJ775j2jF/ZPXGmAi3u2xY1aXL/a82wZE/eiXt+ZKz/uyz4lt1A0x4rUsNTjh0FlsZwboX36YJwK6DjV2lXQmu+EohzRSYtFR+OfrTfdhJM3VhZGp0sxcOZUvA+3Yily5eWa2q92LGxG/bN7Lp1PFNpomGoOCo/OaIQMydCoecGb1fXLAPUjcBDczHsuog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:55:47 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:55:47 +0000
Message-ID: <103033d0-f6e2-49ee-a8e2-ba23c6e9a6a1@nvidia.com>
Date: Tue, 7 May 2024 11:55:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: cache the __dev_alloc_name()
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: jiri@nvidia.com, bodong@nvidia.com, kuba@kernel.org
References: <20240506203207.1307971-1-witu@nvidia.com>
 <03c25d8e994e4388cb8bfd726ba738eea3c4dcdf.camel@redhat.com>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <03c25d8e994e4388cb8bfd726ba738eea3c4dcdf.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::20) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec2d707-77ea-4bce-c23d-08dc6ec74e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3ZGdG5zTXlyU2Z5eUdxLzJFQjNlU0wyZFY2RUJQeXdWTnlkdTZ6RGN4bkZR?=
 =?utf-8?B?SDNtWFRMWnhaSnFjNGVzMWhDV0UyZE4rbFNMV1Y4bVVaNS9hdkdzUVRpZ1Fo?=
 =?utf-8?B?bDFmem1GOW5uUm1vT1B0b3RMVG8vVVJTcFVHYWFOTG1sRytTZEJPdDNnL2Zr?=
 =?utf-8?B?OGljeHZ2K0FDZ3Z2ZVlLWUN2dHZBQXZmdi9ueVpvNDZtYkF5V3hjMWxzR1Z2?=
 =?utf-8?B?dm9Nb010ZjY4UDFjUlUzTXg1VEZzVGNxbDZ3OUJHNWYrYWhVQ3d5YWlNMjhP?=
 =?utf-8?B?RXZlZ2Y0YmN3YnkrMEIzeHU5K1JpM0orY0dueW1xTXRHWVM1d0h2WFdTUWVE?=
 =?utf-8?B?dUFta1Nydmk2UjZLV3ZvODUwcTA5Y0pzVXlKbHNGTVRmVUt4c2dZVU5sSll1?=
 =?utf-8?B?RHJDaURPMlJjaS9FWkZFRmJlMkZjUFpId0tRd0VLYnVEUmhxNXlWRnE2MEVo?=
 =?utf-8?B?ZUd1UE9nVXRUVkNpTll6NGQyUmlHR3VsOGJ3NnNNdTQxcG81SlZzQWRLaWJ5?=
 =?utf-8?B?eENLOGllVkpTNGNCcmp6ZldCK2h2enpwZWRydFBqdGgxNE9kOVlaZXkrcE5B?=
 =?utf-8?B?NVEzbHBvNjBZY3hXd3BHckNCcWFYQktIUjBCYkQxKzJwZ3NEc1VGWlNubEcx?=
 =?utf-8?B?VDVBcFRpVUVnNlhaczl2aDlNZG9ubE92cDBJRFdYc3Y1UUFuMU41ODVaOGw1?=
 =?utf-8?B?ZmlvNkQzSzZtanhINlc5U2pHVlBRNk5zWmdyVDdkV0dNRjd0QWpPYmNsdTZM?=
 =?utf-8?B?QXlZTjlLbVgwY2VNdkJOdGFpcmI0M21BUVlmQVVDRVdXWW1VcmpTLzNhaHhr?=
 =?utf-8?B?c0FmeE12WFNTT3pKSEtpTFBpZ1lxekR1cnJkTVVncE1YRTRBTjBIaFBqMnNF?=
 =?utf-8?B?UW80VW02SDVkdnRUT3JrWEhUQW0rYXpxMGNoeFZHRzFwRnZZQXZUTzc3Z09Y?=
 =?utf-8?B?blA5N2V2RGlBVVdPY0MweHNRTnRsdGtqMG51U211dnpHVHA2WWwrYW9tdVlE?=
 =?utf-8?B?eEt0SW0vd1NEZHZ1QlBNYmd1aG1NcUNMUXNneEN6Y1ZyNTNpcy9IdURDYjlv?=
 =?utf-8?B?d2lVQjZBTVFWdm1ZR0s0b09BblkyRzYwQnlEQ0NTRDZ0NGRrcFVPZ3RKMHV3?=
 =?utf-8?B?WlgzZ0t2TmNtbDd1ZkNvZmhvdkYvSWZTTmk2R0JmUmxXZUhNSWhGb1dKck9J?=
 =?utf-8?B?Uit2YU51MklyYWpxNjFTM3FGZ3FGWE9PQmRkRG85NDdseTFPek1PRW4xcTZL?=
 =?utf-8?B?SDlIbWZJTFNPZ01OdHc3YkprUGVuS2hid3VxTkUxTWM1VlJ2OTc0YnFRQy8v?=
 =?utf-8?B?MUMydjF5VWpXdTZRdjN4VFpwVVFZb3Z5czZhdllOdnE1VUFhcHd4cUFGTjdq?=
 =?utf-8?B?b1pZWERaUDluUmFiOU1JMlRiVEo4d2NYelRHY3ZtOTAzekRJTWRGaFVrVlNG?=
 =?utf-8?B?YUdRUGwzakNVcnIwSnBSK0drL1JFSVRuakhiMFU3cFdiRnZTNFVuU1E1YnFQ?=
 =?utf-8?B?bmMrYmdMTVlZQ2g5SktoTGFjYTNjaElrcDNCcytWZVNDR20zdHJDL0d4S0hI?=
 =?utf-8?B?cGxWanc4ZlkzUm4rYmJ5SzRIN1R0RElpSWJSY0JOazk1WFN6VG5QaDdHWncx?=
 =?utf-8?B?KzhxZHMwalFsOWkrMlNyQnVpYnBrVzJPRDdEcThmM0dXUVJObnV6VFN4b3FQ?=
 =?utf-8?B?MTRxS0htODFGVXc0eEluWncyYzlpU0pYa0RYdUlDWGxKdTVQOHZQK2F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmtjdmcvWE01b0daTTVxOUFuczIwVldjeTdkL01ja1RJOHY2TmNNeHdQeTkx?=
 =?utf-8?B?ZnNlSW03UDlicEVVbVlOV0NsYmw0ODFFZEJEazAxWUJ2R2ZCWVR5YTFjbnVP?=
 =?utf-8?B?MG1pZExWekE3ZEhaY2dVRS9CY3VKTElJeTBhbG5BTG1FOFpZc3NSWmhEMHBB?=
 =?utf-8?B?dEpsUFI0UVNvazBqM21Id1lRaTU4bnZUaFFUT2tyZHR5K1pTUldJRDRKeUE2?=
 =?utf-8?B?R1BpYVhWczJjTkQ3QkpEUUY2S1pZZUxxNHpVWTNCQit4d2N5bGs1TndSY2xr?=
 =?utf-8?B?SlVUU1NyMk5BWXNweHU3cWR0SnpBWjBqcEE3cDMwZ3g2OHhiSENYNWpUKzM4?=
 =?utf-8?B?Qk9leWJMaE53clVLK215OFJaN2xxVDBkZG8yeDFZTUpmZHkvSlVyUFc2eWxD?=
 =?utf-8?B?WEdnSGg2TXpPZHVOVkNLQThuVWQ5bFRTZ2hrRHovRnpnS1FYSW9mNFJPaGJl?=
 =?utf-8?B?RDN3QVI4SlVOVFBROWZRV3RtT3ZvbUEzUTFoTVE3eVNOWHd5T2RKa3dYV2hI?=
 =?utf-8?B?ZDViWndCM3N5Y2QrRXJiaW1STUlWMitBR29sVmtHdzk5SVVPYU96MjM1UUpL?=
 =?utf-8?B?VmszTFNCbVJmWnQzem5wMjNQa0hlN0gzeDdtMGYvSWNyU2thMXlobU8zMjJn?=
 =?utf-8?B?VndmUDlBVGdERnJMNWdrUnFkTk5Qa3N3ZlJuaUNSM09Fek1XT3VEelB5YlhY?=
 =?utf-8?B?MDVUMk1obnFidy9sWGczTHQ3bmRMaXlPbVkwSVljeHYyMlBEcFVneXdZMDFJ?=
 =?utf-8?B?Uy8xNlM3VEc2cnVQa01LWWFYeGNUenZiSkp1TUhjTjFuQlpQME4vWTJEV3o5?=
 =?utf-8?B?dG5rTkxYSUN4czFvc0JqYkthZzl1YjVoM2V3SHJNNDlwUHhwWTRlLzZmUHZ3?=
 =?utf-8?B?bjVxTFczVnhuZFJ3M0grSGdiRmxQVGJvVUkwbkh6VTBxZ1ZaLzRtcjJtKzlW?=
 =?utf-8?B?U3BzMDFDNVk5dmJHUFBldlIvZHExSjUzRGZmdERuazdqL1NaMDJlRjVTeVd0?=
 =?utf-8?B?UHVhRVh4cmNpWEJLd25yMzNmQm50UVJqcUVqblFRSTMrbjI1UWRhc2ZGV2NU?=
 =?utf-8?B?VGkzM1ZiakljTUtQZ3YvTzFnN0FnaHhGcjlrelFaYTRXRFg0eHh2SU56WjNo?=
 =?utf-8?B?ODBtV01ROXN3LzExNElOOGcxVW01UExHcnRTZHJkbUNCYXBqQ1ZaMzlZMWkr?=
 =?utf-8?B?VENxS21BMnVFalJQY1dZcnAvZjZvd3JibWFySUJVc2JmUXFTcXFnVVA1eStm?=
 =?utf-8?B?R3Nid1ZiVmlxTlFLYWhrTC9KZlJGYUtqYlJWbFlVeGxMWUtuSUFkcHpUQkNS?=
 =?utf-8?B?Y2NtNXlPWDM0MmxGa01DbjFTdVFHMThVT1pkTFEwWW5OL2FWMmVhYWtKakRi?=
 =?utf-8?B?cWthSUs3V0pBalhRb2ZLaUlyWXdrNFVKazNKMy82c3ZuaVY2bUt2eTh2ZEtQ?=
 =?utf-8?B?YTJMMWZTZWdTenJRcFFCbnFOYWQ1V3ArVU53czc2Mk9RNVJIU1dBUE9BTlhl?=
 =?utf-8?B?OVpPOXB1NGdFckJ0czJocXBGQ1JLK3pLWjZtNnplSlNGNUx0SG1iMm5PcGlU?=
 =?utf-8?B?OEpMWkdIU25wS2syUmk1SzR3WHZMbVR2dWtJbGRBdHdOOWZ2OGwwMWlNa0FT?=
 =?utf-8?B?WlM4blZmUi8xWHVhNGpRM0FjRjhnUUkxbVBiaG52cmpOMlNNUE52MDlORmIr?=
 =?utf-8?B?TW5nTjBUajByTmF6QXBxb043cDUva0RNdWVHSVgvSVhmVWFTWFF6QzZiSW12?=
 =?utf-8?B?MW1XbzdaNTVRai9qM1k3K1JDM3dPSXdtWGxMWkFqSGVmaWtVa1ZHa1RBVnZU?=
 =?utf-8?B?U2M0SEVlbk9vUytKSlgwVXc0SVNzcldic3IzZVlER3RyeG1lcUtsZXVTUjJl?=
 =?utf-8?B?eHlpWEdCTnoyWlhOY0RkTXhqWU1IOFE1YS9XQUxXTWhickJKcXNqRkFEYm9t?=
 =?utf-8?B?YmhDQm9aZ3RYMFVkRlJHcjBYT0pMdkdyRlFGZUxUVmdkUEVaSjFkZ3FuMW45?=
 =?utf-8?B?SkNXS25xa0FxNGUycVcwaSt1aGc1U1QvWTVTeUo4SkdJVUdNV2IvejFVNXZx?=
 =?utf-8?B?ODliQ2tBcGp2L08yemppRTYwaXVLV1hDd0grNXFOcFRKNVNDL1JZdTYrZGZU?=
 =?utf-8?Q?Udt/TWFMdyV8d4mN5dYs66kch?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec2d707-77ea-4bce-c23d-08dc6ec74e55
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:55:47.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo+UclN+AGCp/hBTBHsUcmQ+TMlWfNvgU3BaFS4tvpip69+Q3Cqk3t/JA7VhAG6C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446



On 5/7/24 12:26 AM, Paolo Abeni wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 2024-05-06 at 20:32 +0000, William Tu wrote:
>> When a system has around 1000 netdevs, adding the 1001st device becomes
>> very slow. The devlink command to create an SF
>>    $ devlink port add pci/0000:03:00.0 flavour pcisf \
>>      pfnum 0 sfnum 1001
>> takes around 5 seconds, and Linux perf and flamegraph show 19% of time
>> spent on __dev_alloc_name() [1].
>>
>> The reason is that devlink first requests for next available "eth%d".
>> And __dev_alloc_name will scan all existing netdev to match on "ethN",
>> set N to a 'inuse' bitmap, and find/return next available number,
>> in our case eth0.
>>
>> And later on based on udev rule, we renamed it from eth0 to
>> "en3f0pf0sf1001" and with altname below
>>    14: en3f0pf0sf1001: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>>        altname enp3s0f0npf0sf1001
>>
>> So eth0 is actually never being used, but as we have 1k "en3f0pf0sfN"
>> devices + 1k altnames, the __dev_alloc_name spends lots of time goint
>> through all existing netdev and try to build the 'inuse' bitmap of
>> pattern 'eth%d'. And the bitmap barely has any bit set, and it rescanes
>> every time.
>>
>> I want to see if it makes sense to save/cache the result, or is there
>> any way to not go through the 'eth%d' pattern search. The RFC patch
>> adds name_pat (name pattern) hlist and saves the 'inuse' bitmap. It saves
>> pattens, ex: "eth%d", "veth%d", with the bitmap, and lookup before
>> scanning all existing netdevs.
> An alternative heuristic that should be cheap and possibly reasonable
> could be optimistically check for <name>0..<name><very small int>
> availability, possibly restricting such attempt at scenarios where the
> total number of hashed netdevice names is somewhat high.
>
> WDYT?
>
> Cheers,
>
> Paolo
Hi Paolo,

Thanks for your suggestion!
I'm not clear with that idea.

The current code has to do a full scan of all netdevs in a list, and the 
name list is not sorted / ordered. So to get to know, ex: eth0 .. eth10, 
we still need to do a full scan, find netdev with prefix "eth", and get 
net available bit 11 (10+1).
And in another use case where users doesn't install UDEV rule to rename, 
the system can actually create eth998, eth999, eth1000....

What if we create prefix map (maybe using xarray)
idx   entry=(prefix, bitmap)
--------------------
0      eth, 1111000000...
1      veth, 1000000...
2      can, 11100000...
3      firewire, 00000...

but then we need to unset the bit when device is removed.
William



