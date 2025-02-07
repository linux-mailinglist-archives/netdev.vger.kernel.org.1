Return-Path: <netdev+bounces-163992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD90A2C3F5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3FA3A65EA
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3B1F4198;
	Fri,  7 Feb 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qgSUdSPb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E711DE8B7;
	Fri,  7 Feb 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935724; cv=fail; b=O5/6ESACbNRJ1TxZ7T+bGaBjtwTeRrNjdyPBiykSO18Xr+jcVSB1ZMrEpmytz08o7XTyiEry6CDXbW3iuwxaIhp8uOWGm3HkNdgD7plkK8ZDZHGdFB/mfb1CZ4gjlm4LO50ILQLDKiaxo7l+oDJa1pYKmQA6D1QnPLoywUyBF+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935724; c=relaxed/simple;
	bh=lTPD66vVDqUbut/InRx4r2nSOfib70BtY/qaKUWQPSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SGlfOLFFzN7i0FSBVJCXL+GTzNkYzfivIaQ0FTXO1CPsyqMaH4ojajM4RkNrqglJmL2EhmGNYLY+fTJ/ePeq97zss5EZxJxRb4cJHs1C+McnMuG0Hy/Ezw2BfKgqPGftj/8rUr+LD6PEePdSGeYD4cI459VhQu7TTYmxQJDvhZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qgSUdSPb; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS5mEQOTUn/oIXi3I+AbKmdQda/KT4lZV/Na5lFGzZIAq5u02dR+X+QNFcVVfjnykF/cJ4uJpaM53U7ohJ0QexOqB+R/+0Bv14QRyITch5H2hpL4bZ7x6qqc7qNBFCs6fmeiaqBeUuMBQAF3rEXqaKYvbglzPfvCh38g/QcKrtXXC3yBpeAcpwQDdGtykg8qC1fDuyRhZrjGpfXkXWf6TVpjhYKyG94AWxV7zx+cJEjaApSL0+xDWAChZLTPCZ08lORkBOQrL8mfPxxkMYNLzor1w03ctPflYXXgzNUFMaqkMpdTKF9aaApg01o/t4iZkHkVp+uM9FXQqlQPBWETIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N33LzusrNwbFoJ2ztdUF12Qr7ws0KgyZyYfoWt8slpw=;
 b=cATAY2zfh4Axx1UkbJVrJh6yV9SMGfxRshWc/9vwFTW7zfSpTEDue9+uzQPW15LESliaxSH/M/gtf/QotRNltBTJDAExhlAE+sONNy00wSthiUlkOjJjWlXzFBSPo3XV73xOmVPTq51oRjeGFcvHbCOe8UqK3TZq4eGpbWjD1WAidhq0nXVdhLk+J96JFzt7PmB6AHp83i3mR0oo4RJSLTwUvysYIOZctU0dbDyAU3kJd7DQ4Efo1OQ6eO2jO0d6h0NlUaw+UEhFeLFBtCXtdJy4PlbhZDHHCSahxlX6Gl2Y/uV0QcBQvBxl1xZKCrkUfn02v0UfaAPOXUmjPGGxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N33LzusrNwbFoJ2ztdUF12Qr7ws0KgyZyYfoWt8slpw=;
 b=qgSUdSPb5BynkZxBelklWwBUSUxKWctRV6rDSJJ3U4OV9cgG+XqVrJIQ8CeUF6CPne7MAngCBm3oUBiIMzO4Bl/H3OzLJH3mY3j5U1DvV4DIwuHkoV1+fER1mk8f9s28wonP3qVFFhfJ/p1Gn2MLsAUz3KVzQt48Zof0AbLlzBu8zUa4D77kPP8VB/TtRJbk10VkaUFt1jiqbdMIqOTilZO9vBr4h3pgvMjIkGzvGR3BMnGmjmaMYbLdbSQ8YFiVVG+4aKhJHbtzSSRlnWiF5X9IKPz7RKjeREMs+H8kfiX7+CKjkUZSgaCtST14lubhohOXkP7UlF5/97BbF9mO1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 13:41:58 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 13:41:58 +0000
Message-ID: <8fc7c79d-ace8-4e05-acef-1699ee6c4158@nvidia.com>
Date: Fri, 7 Feb 2025 13:41:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: Apply new page pool parameters when
 SPH is enabled
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, xfr@outlook.com,
 Brad Griffis <bgriffis@nvidia.com>, Ido Schimmel <idosch@idosch.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250207085639.13580-1-0x1207@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250207085639.13580-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0125.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::22) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 023b8b57-9581-404c-654d-08dd477d3146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1hybDBQWm04bkM4d2VvWHZoa0ZKaDZrUjB1dmxjT2x3dDkxOHpqaUtGMGU5?=
 =?utf-8?B?QTVHKzBUMWEySWJxd28vTGowalJEQWhvVXVlcUw2N011OW1wNkcwSHhOR2xU?=
 =?utf-8?B?ZzczRFl3c3B3NGZZTjdEdDNYTDBwWThNOUtyNWo2Vm9yVVE5TFoyT1hnL0Vw?=
 =?utf-8?B?ZzN2dFdyOVJNUE5GVVpMUExJRkh1VEJrMlFDQ1BYUmhUNEpJc0cyRWY4S0hL?=
 =?utf-8?B?c1ZuVnNCSGtYR1BRZ3hUSUZMM1hmaFZPdk9hUVpvM2FkWlM4Y2dXbmlRTFp0?=
 =?utf-8?B?UE9PTytIZFVLZitlbVlNcWh5eHNWd01SYXRTckU3dWJxdVU2aVVuZmh3elBs?=
 =?utf-8?B?V243bmptdElDbW0wL1R0Z1phNEdIZjdFaEJTdStaZEZhOWJTS1gzTTlsaFRT?=
 =?utf-8?B?c2F2Vk5XWjJ6VVV0dVJCdnhldHM0T2IwM1MvZzVacG5Xc0FWeUpmUTZuZWNr?=
 =?utf-8?B?VEJPYVNML3hzRWpEMjRCSUpsOFVFeWticTQxZDE4VmVSL01JYkp0eWdsTVpv?=
 =?utf-8?B?Y3A2Nk5LTWtXN21TKzRobGhPNlVINlM4YlJSbHZhZkJ2ME1tNDQwd0JjS2pr?=
 =?utf-8?B?d1JDYjU5cVpzcDk2NGErVldVTlZrOUhzcExqa2psbTZhamZ4T21yQXhuRDRr?=
 =?utf-8?B?UXo3bkRjZWV2dDFsWU5Kd3NxT0MrOTBWVjNTcFltU1B6NE5kVWcxV0Q2cnUr?=
 =?utf-8?B?MFRHaGtzS0FBK2VTMiszWndWSWMxVUo3aVNDeFVjbDFuVlEvTXJOcmtLU2JC?=
 =?utf-8?B?a3dINkFvNjg0OVZlU1JXQ21ZUG5scm1ydFBOUlV6K2FlVWJYNlREZWpjWmNL?=
 =?utf-8?B?c3JYNGxSWU9UK2RZQmswaWZYU3d2RWovb3VFWG9qYVpPSGFPd2thVlRCWGZT?=
 =?utf-8?B?RlJuMjdhUmFaWXY1NnlIcm13dUpyOUIxeENIUlh3V3N4V2tTeExRY3hLZTRz?=
 =?utf-8?B?MEFjaXU3bFAzYzVUUzBkMlYzTSszeXJGVitFemlmWUlMY09kOXJPTkxUZXJG?=
 =?utf-8?B?Z3ZEWjd2ZXNNRFk4V1paNjRZa0p0RFNLYXlLRVIrSVpocWJRRlI5MkhoNHkv?=
 =?utf-8?B?S1ZwWmUvNThSQ0MyN0l5SE1kdGx6a1p6T2xTODlGeDZ3STlCandPSUNxWjZV?=
 =?utf-8?B?azNxT2VWY0N3dnNaNTFLbnlCWkZFN3pyb0dpRXIxN0ZQaHpiR20zMW9DLzR0?=
 =?utf-8?B?OG1ZaHBSV3l4QVkxU3Q5ZS8wUnVzeFJZRGpSMVMvUkhHMnRVRjFMTUVxaWJw?=
 =?utf-8?B?YU9FWFR1RzRLVFBjRDRsOUxRMk9sNjlUYm11RGdaRnE3NlFMSXRoQlBrc3dY?=
 =?utf-8?B?R3QyVmhYRThNWkVxUU1mcU1sVVNvTkU1TWpjcXNtZldYM24vcHFiNjdtVzdL?=
 =?utf-8?B?L3lzeGtkQ2Z2dEErWWJacTRWUjNjZG1iZDB6OEI1OGEwRGYxaXBCWkVhWlA2?=
 =?utf-8?B?NjI0NmtiZ2pabytrc3EvUzVBUVVwUHV6NjV6WGl0VUxVZmlmTGMxMWdRZ1Nm?=
 =?utf-8?B?MGR4eVYwampzRGlJNHJXYWtoR2k4OC8vOVhaSXpuLzZkZzVRd1FIVzc2Vmpi?=
 =?utf-8?B?T0xTUWtPMkJVN0FmYW5DSlI3WVZHN3BVZjlxVjY0T20wR09PK3l4RUkvaHgz?=
 =?utf-8?B?Mk9sU1B4UUFLZkdyTDJVRElrelFPN3JKUWh2MjNZMzQ4TFR5ZFBZMTFpeUFJ?=
 =?utf-8?B?WFhIL3RxcHlOOWs4QkhrMVJDWEt3UXFZRWkydThHbXZUZG4va2Q0aUUxdTUy?=
 =?utf-8?B?T05qeXQyMW9VaVJLbzFGNVRqU3RKL3dyV0dGb0MzZVNoRUs2WlFRclROK1BH?=
 =?utf-8?B?WDFGZDdiNjRHcjRFNXE1cnBTUUN6ZmVIQkNkMWZpd3RVWjJtRURBalpoeFhV?=
 =?utf-8?Q?PSR6prPydh+nv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1hQSElwNGNTd2VwaG5wMitIVTV6RlpqZlNmYXdvUGhvMDVMbXBnSXZ5NWRv?=
 =?utf-8?B?ekZMS1IyVHBmUmNTUTFMV3lqVVlPUmxGcjZ2YUtWcXo0K3ZDK1B3KzJSQTlN?=
 =?utf-8?B?QldRZGRtMGZxcFdQU0ZRRXA0ZmRQemJmclRCbHUxUDZRcURtTUpXelpkWWx0?=
 =?utf-8?B?WUlsdGhOalY5TlVHcVI2elFoNkw4R2NaTXVJVkNuZUN6N0JuV2ViM1pnekxF?=
 =?utf-8?B?QmJ1RHhjMWJUV0N1eVZjMnlwWitpTFFxQ3VlSlhsUVd3MzRKRzRSRjE4Q3ow?=
 =?utf-8?B?MEhnbk9KakFJN091OXZNSkh0TGhVbHRLRnJDTjVyL1Yvd1Z6SjEwaWl3bnE4?=
 =?utf-8?B?L0kyN2lRdGRhYVVnc3JWaUY1ZW9lb2p1ZEJpV0VnbkNwWllJOEFIUUhvellR?=
 =?utf-8?B?SVJ2M2Q3WGQ2dGNvTDNlRVNkZ2VMTXpLcWFzTmdGM2xwMXNzMG5TdWZVRlUy?=
 =?utf-8?B?OHRMUmMvaEU5bExxNjYrWlF6c3J1ajZsTFhYZ0dsdUFLaWF4RnFkbFl6Mjg0?=
 =?utf-8?B?SWc0VWRhOGUxRE5kd2cxS3d1ZE9YQ1lWb2lLODdvZC9rUUlPb2pFcDEySXhl?=
 =?utf-8?B?T0t1OTcvRVdhQldLS2ljanF1bUd5eHFiVzNYOTF5bkxORW1ISlY1a2dFc3Jk?=
 =?utf-8?B?SXF2TGx6YmV3VHZJUnEweEpkdzRHS3MxMzBFTldvZ0xEY3pIOWJobERBakVl?=
 =?utf-8?B?WVpZZG1JZThGWXRES3FVOTcvZ2I2TzNMa1hzTEVWSnFTQUg5Umx5Rmw2R0xk?=
 =?utf-8?B?ZmVhc2VTRXpoQlVJQ2paNm82cTQrQ0ozSi8veTVJNTljMUdzR0M4bVVKL0lH?=
 =?utf-8?B?dzBJNzdPUGY5RFhNYUQyVmNQc09wd0NwZ1RaZHhrU2JkR3lrVGU3OHcxSkJL?=
 =?utf-8?B?U3RoRThOaE84aHR5QUpsanBHdXJKR1BNNzNlb0hzNG1sNWk0K0w0bERyQUhk?=
 =?utf-8?B?aHB0cm9zUDBjbEFmaGFyOEIxcXZYdnpSTnlVVVBkWXZUeG4xUUdrZk5FLzVx?=
 =?utf-8?B?QW01NDh2NlFmbGYzaS9FYU55U0JWeDRlckxaMVY2TGRBbjJZQ0FkQmNxZWJr?=
 =?utf-8?B?NC85MzZhc3FhSEliS3NKTWlnK3JvK2VJNFhTZmRXc1pRaW12Y29jVXZ2TVlP?=
 =?utf-8?B?UUg0L2FTRnlxY1FEWStBYkRHWGd0b1NSa0VIM1kyQ3JxY2Z5MW53SDJyWXBV?=
 =?utf-8?B?Z2FNNm1ucDNUZTVkaUlnVVgrbFRzeDVDVTFFbExVMUphNzlmalVzemJtZy9P?=
 =?utf-8?B?dmtOUlRyN3R1Z1F4SkZyM1h3N3g1UHZGOW9CYko3QnN3U0VnKzljQWRsRHps?=
 =?utf-8?B?d3J0dTc3elMvN3dHTWxCWGc3eml5Wjhmc2laVVJFZnFVS2ZmWHN6d2c4azIw?=
 =?utf-8?B?dXhySUwxU2lCMUNnb0FYaTlXTEx6TVJZNDR4ejJzcm9QaWtxVittZUZweGlC?=
 =?utf-8?B?UVdmb3N0cUVRMWZqY2cwN2ZUUUIwMkVEdjh6cWo1K0tzV3NMRW5UTithOEw1?=
 =?utf-8?B?bW1weVdoYVVwZElTV01FL2ZkalM1V2pUZ3hvT1N5TVhqdmhLdWE4M3hYaEFR?=
 =?utf-8?B?Qi82ZVRDejVDQXRQeEo2TFNDd2FiSUxWRDlyMitFaUlqMk1tTUh0eTVxQXdn?=
 =?utf-8?B?eFFYcXFVaHpuWkRqOTdPMm0wWDQwdEs3cnI3SFRMalhKdlNtMWNqWFZjUFpp?=
 =?utf-8?B?ZVpRNURHUEdEZGt0UENUaVkxY0ZrVk1aZDdGZmlOZ0pzcGJoNHFlTVErOTFO?=
 =?utf-8?B?WU1pSnZVUjJhcW5mYjdSMW1ZUjRmTGZycE56Mk4xOHF2S2poZXVtWHo2T0lI?=
 =?utf-8?B?c3BCVjRXNTlDcFlkbDBxckZYbDhDQjNhY00yRldEb2xTWEVYZ2ptSVV4NTZn?=
 =?utf-8?B?K0t3bGZNeWZKREFXWWhlQzhETFZSb0pSbU1CSzRWS0htaHllb0FFd2JtT1Nq?=
 =?utf-8?B?b0RDZUhhZjZXR0x6Z2xjSjNPK2NmY29KQWpTczJlaUhaTDdpKzAvTnRiQytB?=
 =?utf-8?B?SFE4cUZYVVg5Y0FtMitTZElhSTU5OFozZ2VnZ041NE41Nkw1clJPSnVXQ3NW?=
 =?utf-8?B?aDV5bGlJSFpoeGFsRHpBemlocnFSMUF2NnFaeDRhWEsvbU95L3BEUlZLMERs?=
 =?utf-8?B?VnV2V0ZHcDI0Y08yZzUyS1g2Q1VGV3NwOEFBMDdURGdLeFFPeDU0emNRL3Z5?=
 =?utf-8?B?VjlaUnp5d3Vsc202bzRDUW9VZFd6TXdmV2pIT2M0QnNpeEpoTnB2QnB4d2dQ?=
 =?utf-8?B?bG5mdHdDSVM5ZWV5WmlTVGJNa25nPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023b8b57-9581-404c-654d-08dd477d3146
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:41:58.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoEYXbgpyqLdt/60y09MzIieWZUNSd5wmBNlyw8epLd9Yy+X/VIfCWYgtaEWB/sE36g2tzf4a5j3v3X0h/x56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962

Hi Furong,

On 07/02/2025 08:56, Furong Xu wrote:
> Commit df542f669307 ("net: stmmac: Switch to zero-copy in
> non-XDP RX path") makes DMA write received frame into buffer at offset
> of NET_SKB_PAD and sets page pool parameters to sync from offset of
> NET_SKB_PAD. But when Header Payload Split is enabled, the header is
> written at offset of NET_SKB_PAD, while the payload is written at
> offset of zero. Uncorrect offset parameter for the payload breaks dma
> coherence [1] since both CPU and DMA touch the page buffer from offset
> of zero which is not handled by the page pool sync parameter.
> 
> And in case the DMA cannot split the received frame, for example,
> a large L2 frame, pp_params.max_len should grow to match the tail
> of entire frame.
> 
> [1] https://lore.kernel.org/netdev/d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com/
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Brad Griffis <bgriffis@nvidia.com>
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX path")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b34ebb916b89..c0ae7db96f46 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2094,6 +2094,11 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>   	pp_params.offset = stmmac_rx_offset(priv);
>   	pp_params.max_len = dma_conf->dma_buf_sz;
>   
> +	if (priv->sph) {
> +		pp_params.offset = 0;
> +		pp_params.max_len += stmmac_rx_offset(priv);
> +	}
> +
>   	rx_q->page_pool = page_pool_create(&pp_params);
>   	if (IS_ERR(rx_q->page_pool)) {
>   		ret = PTR_ERR(rx_q->page_pool);


Thanks for sending this. I can confirm that it fixes the issue we are 
seeing and so ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic


