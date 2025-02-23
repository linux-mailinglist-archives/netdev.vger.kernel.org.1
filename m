Return-Path: <netdev+bounces-168819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DE2A40F03
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 13:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250F7176EB8
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883C205E3E;
	Sun, 23 Feb 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tPE52nfL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055A1C84D8;
	Sun, 23 Feb 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740314513; cv=fail; b=HjBBL4FgJ+wI73RYZl+q88gONZDi+sH3tl/6g4blRjdC17DpMacsrh5nlUPMDOSg8aVjQP/B2WBBP//foYHBVZ+Rz2diotzGF+jNaRuB5/wBH6ujTPA0ag1kyJRA+HIrWqoD7qXg5ggQhBuOsSwDX3fhD7ghJ4JCnCpo9R9DbxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740314513; c=relaxed/simple;
	bh=WieEbrXr04O4jzRo82poFNv8tCPGTDsj/osANPq43s4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m13D2LmhhGaNpKTHPbOaYun8ulR5nvdZUsQ/TA2MMiDeCQjgfVSuET0XJRYEvV1NoEGoPai1MTMIDYPjcy35gB4eEBgtC+6s0nszDxZEnI28wUv+pV8PXjx0GIfV0tkuqDTmNqz3MSPm6OosB3MML/ukbiJcJIliTorb2qJLdH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tPE52nfL; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHhL5BQVNdepOU86jRVrFfgTV1o4MF1o716TL3b08V3lrds4Ese+r9fOUEYEwUJVUTG4pM71uMErXKUSl+ONS08O0DbzTO0XzG7scLO8qRDhOu1QDWztU/3H/o5SHMfBJUv73GgnEHFPGMZcrM5GO/JQ5fS6YFEVHt5ykZKj3gH99XHdgwxogbgAiIfAdCYHTtnX38d8nV1xpjGcwyofT4Igg5MKUcv7JvjSmuiQpuHhSM3/keZlPeMI9q5+uxSLXVccpw3rut5g76AdF8GQgyxJsEf8flmcIVracvj/a7IH40YFx0VELtQRKoUwuWA6p4BWZkE/V99RI/0xK+IdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95haYkS4FelGBpSANCtcEMcLi/2XGbx0LtApmwhGoKA=;
 b=RfN+AeZMQoZCoTxCyFmWv10Qsy9N98DZ41TyW2RGlleOe9uzq9hzz3EK1eSsSvwq1IN5hSP9tB6BCeWAukIUiWjqaJFj+RfdE/OTUAPwwEPW9fn3rqrZuOH+2KBoh3bbyFxICLMCbN2Y0N3Q1FvMjtlsgseORLqyjievqjXdsZ5IwIkGMuDvgB4hubAxTkmj5u/VhEkILjC0aGrFwvSXSVZFon5idYfHoX21cTPXby2AxpM3zyhrZ2qcR8DnDJPsUkV3jTb3m+7UJN50HzRLkKzO7azHdux7ynZ6fsEC+jRo3LQ0gvYRpZKkoyHX4TCrB04GiPynqETOemqHKafE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95haYkS4FelGBpSANCtcEMcLi/2XGbx0LtApmwhGoKA=;
 b=tPE52nfLbXwJF8XMTt6qSRfUJfjvtjFL/6+pSuoCECt71qbq7VT0yO2j/JFgNMzLP1TibzzC/CpyVUBE2ka5U57moIUnIDNAmFALBjQge33t3315IUBFcuQqA1GFxJc24ZphJ2Z9aqRncXTMnqUOZ0t8u0qKqY11Ce14JzvIEMaD935X/RJC8JnOQP2rWPSDPQyS3pg9A2z/AxAzumQXRRmovKpgWsqgVFe+OmINZ2LxtGBDpnuCUkppnCZIMvyuBWw/3K15fH1pvweNDNRZT9FbeDe9W2YPy14bn35oXg2OwzYQFMuXK6XJUFuDmazTWoLd651YmhImoNFk5njMnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Sun, 23 Feb
 2025 12:41:48 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 12:41:47 +0000
Message-ID: <4eccb4db-e5ea-4478-a18c-dda9672d8c43@nvidia.com>
Date: Sun, 23 Feb 2025 14:41:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/5] ethtool: Symmetric OR-XOR RSS hash
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 linux-doc@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
References: <20250220113435.417487-1-gal@nvidia.com>
 <20250220113435.417487-2-gal@nvidia.com> <Z7hamnWPXmsD24P-@archie.me>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <Z7hamnWPXmsD24P-@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0021.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::22) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7a7543-e72c-4011-204e-08dd54076faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bENBcXVWbWJOZGZXdDlYTWNybGFGVlh3YmNqcTREMERzTEIxQzB2d3FTT1VV?=
 =?utf-8?B?UEh6RkhOdmVoamJqQjgzYW1GOGl0UGpzSmxXbE1XWFNBeGFWM0Q4cHFnOUd4?=
 =?utf-8?B?WVVNS3FpSm1tdHh1bHV2T3NnK05iK2h5MC8va2dDRzdEOGxlKzdreEtsMzBX?=
 =?utf-8?B?L2lnL1p1Y2pTaTNHR1NmK096a0l2cUNvcHRZdlF5eHRheWpVblRvWTJCUjJw?=
 =?utf-8?B?dFUvd25KWXJ5VHpZT0VVbm5HS2NiSTBoQUtEVldFNHRRZ3BheGRVNWJKOWlB?=
 =?utf-8?B?WWJzb2lJWDMwZlFWTFpyaTc3RkFNeFljQnY1dUJYWStlOFhMRDlVb0E5UnJm?=
 =?utf-8?B?YnZMOTQ3RFEzamRlblZIbDhzMEljSWl3RzJkWnc4SFMrbWc4eFhUeGxoVGZJ?=
 =?utf-8?B?YkFaTjVjSllMYUVaendSR2xtTU5pTkJSRDM3WGlCc2VJakR1MnE5YmF6YnMx?=
 =?utf-8?B?QXRqNlNQa2llSzVPdVhNWHNNRVdpeVd5RU00Ymc5QmpzU01ZRGRXSWRNRUtM?=
 =?utf-8?B?bXN6YjFmOEdPc1pNNTUxMjdmWmhsVlJMTllockJTbUgxOHFhaU03Ym8rRDBC?=
 =?utf-8?B?Sm41K0Vvb2RPUHNKMmdVQ3RLaldhckRnOC90ajUyZXkzUmo3WXQ2ZzdqS1JH?=
 =?utf-8?B?NXlxWWhDcVlVMG41R2lzU00yZXkwQjdGSzc1TXlaSjB3ZUtLTGRKWjluOXA2?=
 =?utf-8?B?L2RBTEVKYWRPZkdoK0tBZXhqSVdydnB3RGU4K3BrMWNNcnNVMnhNaTh4ZnRW?=
 =?utf-8?B?ZXJPd2lSVy82eStVZTE1SlNsdk0wRnRrQ0o1aG8zMUp1bkFpRTA2MDF3UFNG?=
 =?utf-8?B?ZW9Wcm5HWnk3ZDU2ZjM1YkVRbXNWZG01TTdRZE9yWXl1RFQwMWp2RjB1bWdw?=
 =?utf-8?B?UjFEQ0dMcTl2Vyt6V3N3K3p4TUprRFMvd3R3ZFFVN0s3M3ZDUjlNTVVCdTRq?=
 =?utf-8?B?MHJsaWVLdzJyc3hQeUlFUTNyRFQvYVhLdWxNaEl3ME1WR1BTTlBFOTlwMDlx?=
 =?utf-8?B?N3d3Sk53S0daazBXaWFuNFU0d1Vka2owMEtQRFhKSjk3bkpLc3p5V2tldWV1?=
 =?utf-8?B?TkJmRGI3NmxSZGUydURSYU5Fd2lESG5INmU5d0phNDRvMkpxTVZ1R0FrMjlV?=
 =?utf-8?B?Rk5xVm03aGVyR3RMeUQ5THg4KzJ2amR6RHZ3U08wVm1BNG9XMEFqRTkxR3Bu?=
 =?utf-8?B?d3VMV3hBOVFzMHJlRDlPdFd4QWFTQWV1NnZ6QmJQcVpIM3RiUStRWnNOUGF6?=
 =?utf-8?B?QTB6MG9qZ1kyTFJjUktKYVA4TEpNVlp4T3ZFc0g1U044N1AzZWkzSHEybHhU?=
 =?utf-8?B?NC9NVWQ2KzFPSERiZFBodzcvZ05vZFo4eWJvWGl1ditTTHN2WFZMc0NHNFFz?=
 =?utf-8?B?T3NBNUR0QUgvemJTMG9ZK2IrMVRGRXFQbmVGR1VkTjBMd3hMenpFTFA2bW5J?=
 =?utf-8?B?ME8vdTRiQVp3bkdrOXdCN1k0V0lxYU5lSEZ6K2hQUlB2a0k2WXpmS2lEMUNK?=
 =?utf-8?B?Zkxybkk2bk1zaE40bXJUZHpkWFFnK29vVHdoN21iRTAveG4zZVZhd2RCZ0xM?=
 =?utf-8?B?czUvaW5EUEFKbDJzSHVkV1dxWmxib2xNM2F6cGNDS2dGTGdXZ00rdC95aHdF?=
 =?utf-8?B?QldMZ1JybU83Nmd4dWEzNWM4ZEdSR0VkU1czSi9BMkI2bk5SNDBDVEdmWk5a?=
 =?utf-8?B?dmdSbWQ5bmEvSzM2Y0N4K0d0aENvMThKRmh2SEVUZ1g1TWpSVkp3dnp5MWxS?=
 =?utf-8?B?SWxBWmM1eFFPQnIvcEFZNlUzVnErd1drR2NNMlVyNncveWZaeEF2dy9OSXFO?=
 =?utf-8?B?WXU1K2loYmUvZ3o5Z3ljdUU1blpYN0VIVkNISTlSTGpmWFlFd1dtYjloWFU2?=
 =?utf-8?Q?NsfMHMilHq+7H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YiszckprWloxb0l5QUFOQWZCRDVaTDRHRER2cFRZNkNHVTFsSTYyMmptOGt2?=
 =?utf-8?B?TEJHUXJ6d2FyQ3Z3TUI4ZkdjSGtMdEpHM2YrRFFoUFZnWDh6ZnBBcllsUjNH?=
 =?utf-8?B?aE1yOVAvYWY3OXJvcDB0NG9nR3MzcUVCNTJ0WTVlNEZ2dU5XaGNqcnpjL1VH?=
 =?utf-8?B?MXh4MjN2ejk1NC8xaGNYTXREaHFYdnI3VTJ6S1l6MXNpcWU0UGpkSlZSQ3c1?=
 =?utf-8?B?eExRa3lVVENxdHRHYkFQSUJ3ZHR5WUN6L2JES2hVdzlTTVlrUWc4bUFyUG1F?=
 =?utf-8?B?Y3RRaDVNR0Y1aU5NVGtOVlg3RkN1R2puRWswLzJ1emRBMC9wTU5LT3lZYUV1?=
 =?utf-8?B?TFlmL1doMUwyTEIvTHZNM3FReS8rZVpmWGV3VFJRcVpzSy9ncTA3ejFIb0lo?=
 =?utf-8?B?S0JEUGFHd2h2MmNEMkdDcG1OTHBWdHljSXcwYlUzaXp5OWR1SGsvYWJGR1Z2?=
 =?utf-8?B?MCtZR1lGcEJlOHhIbFIzRUgyTmd5azEyVU5TQXN5eGVnK2FKaitScDNYMWwy?=
 =?utf-8?B?ekkwME45ZzhvZFdtbEFvS05kNjRGcFR6ZnFDamdKRXRIbFl6Y25DTjhVNE15?=
 =?utf-8?B?ZERFUm03NnhEVDhwdWdzcDkyV28rSzNEYkZzL3p2bkh5eXcxWDA2N0p5UnV6?=
 =?utf-8?B?MTRndFFDQTJhWWFvclpVWU9JV0l6MS9qNzJyRTRaeTg0cjhubytWNTJzVWcr?=
 =?utf-8?B?dnBxMUU4TEJyWUlRVjVpTDl4Qy9FcWhMWmFSd2pFVnQ3SERjRUVUS2lxRFZC?=
 =?utf-8?B?bExaaTVQOURjQTBoWWdQT2lNSGxpQ3h1bFl3Q1hKUFJQZW9mYVkxMjRaVzlk?=
 =?utf-8?B?VTFOVHVTUDdZbWdvWktrQVc3MW85U1ovTHllYTVnRGJmc1A3UHBVa3NybHZ1?=
 =?utf-8?B?cXZpUldwanFWZ2Y3VWlpVzhVbGdYbVNRdGwvQktGTVVrN0JTMHVQaGVpT0dZ?=
 =?utf-8?B?UGJ0Y2Q5NFRWb1RlbXF2K0J2RWlHeXR5Mi9xMXNHRzZLUTVjalgyUGVGU0J5?=
 =?utf-8?B?MDhPQUxMTFVlZ2UxZVBKZ3BFOHYyNnpPUEV6MW1XTkZYRzRYWGJmYjBUVHF0?=
 =?utf-8?B?eWczT0J2ZklpVTVpZ0pncVMzMllMS0xNVS8vTjJxbTNXOFJSY1U0WDlMMVVh?=
 =?utf-8?B?MVRmRDRwTlI5b1AvOCtKWExJNzRtRWk5MWdqT2tVYkNmTGVrSHVtc1dtR3RR?=
 =?utf-8?B?RjFSU1lIMUhXWldXL0ZHYkVNbmYzWXY3V21FLzBMUXBPRDR2SGFYM2p0UUlP?=
 =?utf-8?B?QlIxLzdONHh6ZXVrdXpJM3FOTDVyVURNWmpIa3NyS09oZHJSL3BYdmdheWZt?=
 =?utf-8?B?YVJ3aFA3QTlCdFBNdlY5Q0xtclpOelpKTnh2QzZYeG5WV1R2SkU5TSsrdGhj?=
 =?utf-8?B?SFB5N1JHd01xTUNCZzY1Y0h5a01oOEFTZEJodUVuVHJoZzE5bkhKdGNyNERn?=
 =?utf-8?B?aWJzMDRuMWJiZnRQV1ByNEtPWnZPcXkxc3B4Mk5CSmxELzBXZ1dCWDF6L3hm?=
 =?utf-8?B?VWhNeUJVY05zbDQxVG05dGJQeDE2c09BeFluVDRpWkh1aGVrckJxL1A5NTJn?=
 =?utf-8?B?N0ttOS9WcHg3dUlhajhOMDZpeHRiMFlYZisyUlRzd2ZoQTNyckVPcmVjdm9E?=
 =?utf-8?B?em01V01KQmN6SEs5a2FtbnFwcWdEWWVsZ08wUXZROHdHK1I0NGdjZVdjOVhx?=
 =?utf-8?B?dnVId3JhL3ZMTWh6Si9lS1N2NGh4T0MvbUpTZUlvZHQvaW5aYmg1SURQMC8r?=
 =?utf-8?B?Z2ZUY3RpY0UxTFVZQng0UkFreUQvb2ZlQmxLOVpQTnpjb0twbUtWSDdTKzQy?=
 =?utf-8?B?ZDRFWTZHaUpJK0IyKzRoSWEyZVFNMzdoTithQXZqK1laMXNnd0RGd0p2TjNl?=
 =?utf-8?B?aEZtQ2Y1RUNhYXVzU2ptYkl3MVRnUC82aTBhUHI2UmZNdDBVQXlXRDVFaUpu?=
 =?utf-8?B?REZ6NXF5Q05NOUczelM0d1RmTnpFVnUxQ2VERG8zSDA3TUlHaFd3VWFSQWUv?=
 =?utf-8?B?U3FUZDM4TEpVTkdwNER3QmZEZjhWTlJYczdhb2Zma04zQ0JaNWk1NGxTdEpN?=
 =?utf-8?B?ejR2eEdjRVVKenlodkpxdDIwWDVlV0FyaFI0OGFma2JNakx6WDRSZncwc1I0?=
 =?utf-8?Q?rQrvtPH4ghedHMB4MplwATFXq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7a7543-e72c-4011-204e-08dd54076faf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 12:41:47.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxcZdKPWKfoU9ywbORb4M0injO0iPboM2imWXHLq+k+a0Ad2dP5iAyz1YAVsB4qy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436

On 21/02/2025 12:51, Bagas Sanjaya wrote:
> On Thu, Feb 20, 2025 at 01:34:31PM +0200, Gal Pressman wrote:
>> +Specifically, the "Symmetric-XOR" algorithm XORs the input
>                                                or transforms?
>>  as follows::
>>  
>>      # (SRC_IP ^ DST_IP, SRC_IP ^ DST_IP, SRC_PORT ^ DST_PORT, SRC_PORT ^ DST_PORT)
>>  
>> +The "Symmetric-OR-XOR" algorithm transforms the input as follows::
>                               "..., on the other hand, transforms the input ..."
>> +
>> +    # (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)
>> +
> 
> Thanks.
> 

Ack, thanks.

