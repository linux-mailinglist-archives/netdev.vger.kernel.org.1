Return-Path: <netdev+bounces-152247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648939F335D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BFC7A1CC4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36545205E01;
	Mon, 16 Dec 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="Yr9ctiSy"
X-Original-To: netdev@vger.kernel.org
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294317BA2;
	Mon, 16 Dec 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359982; cv=fail; b=IeAbovZbTcQkq+mR2TGMMKAb4elJJ7uC/ZzFGXiRQzSj20aatdoDZtbc3ju1HBGW4xltC0+qRilOIwPwDsfropdYUYwJGrzMCIjckbaYLWfMJ+Wim1NwpTg39Ona+YeBdLLlpMfVcfEqqykMNmjxl2XQOKF48+omdHKKBhQTp7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359982; c=relaxed/simple;
	bh=Duxl53HF9rX69t3kAbdpaYzrtp7BCZiGK8BSgxhYWiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sD+hr+txHbdRRnjCO4BSMpo3MuoJjhNCZ3/5ZLAjnHhdpQSHJGzOAAb2QPm+bKFNeDYQohuXTHGSjjP2jIOyqFHiKh51WknukXQGNMrjxw1NoRmTZ7LhFKHetD7B33dLGf77drErTm4Q4cD2tPs3M/tQDVaJ4GpB4J9H9l3TLo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=Yr9ctiSy; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48]) by mx-outbound42-213.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 16 Dec 2024 14:39:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imLnFcjk32MHUgEGWPw7uaSDrc2NQoIJ+KMEO+4Mcuxic17NmFC0ER+/ZvKv2vd3E6GGtgAS0gMunSU2skJwKD6pebzgX/r3n8YMmAUQSMi4pqDE0uYUeJw9SAb+m6wuJI25YUOrgqVx9cqsb/8HPFvQ799sxzb1jOHZDeqM/nyP08S7i7/fZf/xYaIos8ieHcDs8+TyrCtp/DufqXhLcYT3ArUSjCn4tSW94AlP2hXuAumJDVpZBJeoeMplPLrOOZLZwaMrCOJPl9Crwzcio3K1orriLdBaFetkQdMXS+81BW4sQVea/8MPxhASh4I85cXRAywYJQuWsn813hal5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77wPSf5xCrxItAJgTkA2MPt6aPAENyRpyPtSLL9WEqM=;
 b=vpvcDcMF4XaIrzICMwKiNs9BAD60kaD1j1STDfuZm5gmgFOT6nJHajQNGPc7u7NY+fQHMS4tUaI2p1dKeNRCRRVMxWY4/BrTSsZhaAmlqEgkn3IwAkXol6b8xvLHdbYSObLNBilGBUbeQsiFLbcY2M+5mciYgjPbZdU9AgPoH2W77d0zf8pxnIllX1CuXK6+FOTnvv7npPwk9qYi5FcJFk/H6iFyclXGqReGjx2+6QGAaiQR0vDGRv8uTHTiTO5eSMhrdMV/+UjIBCU1m9X1eS1GxTkmunRAoPi37h+A8JzbNyr7dRWpuUm76tRiWm1GdP3J5Ny3l4eHd11asx2IGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77wPSf5xCrxItAJgTkA2MPt6aPAENyRpyPtSLL9WEqM=;
 b=Yr9ctiSybO/2xZPJI/OcC8423f0Wjmt2z1KVt0uXZBbYOItSKs1JIKbRJoan8EUDCYnIX9HucMjCUZEliO96s4X4Ml3GjVEOzBtupmvydugyAfj5VXW0/mfhfZJIeBH8HRxO76D+PYV7h7FOIAoTLwg5AAJ0N0+tGdRisEf7Dd3Xd4/xBjCGflNdds3Uh6g6mXRS1Vygo9rSzwzY13Q6I+husmvHWD2EmQGC+IgYkwH7FS50D5anmtbqB04rv6eGBXtblkBh9+tI2b6BnPbdrvm3ZTmGUFJvfjwWCE5sLt0kA5tVEH69NEPuZ2Evn2Rl/OBnZlrSvkKOQ8yMGQyvjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 14:39:23 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:39:23 +0000
Message-ID: <49d10bde-6257-4cc0-abaf-3bffb3a812c0@digi.com>
Date: Mon, 16 Dec 2024 15:39:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net 0/2] net: dsa: felix: fix VLAN-unaware reception
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20241215163334.615427-1-robert.hodaszi@digi.com>
 <20241215170921.5qlundy4jzutvze7@skbuf>
 <908ec18c-3d04-4cc9-a152-e41b17c5b315@digi.com>
 <20241216135159.jetvdglhtl6mfk2r@skbuf>
Content-Language: en-US
From: Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <20241216135159.jetvdglhtl6mfk2r@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|BN0PR10MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc86e16-da3f-452d-34c0-08dd1ddf6f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGt3ajRLZ0w4UFBRYUpiUHkvSFFMMDMzQ1BsWC9BdUpJemZnRmxGdk9UNXhP?=
 =?utf-8?B?MVY1TkxhK0h4SXJEU2YxVUo1RWxOMDM2cUJYek9TY1lSbzJEUW95Z2VEbDJw?=
 =?utf-8?B?WW43MCtaa1RMOHlPMlJBQVpkSnZFQXNyREpLV1NVOHdPb09SNkhUbFF0Tkxo?=
 =?utf-8?B?bDVMN21BOGt6WG1XTklSMGo2ZjRCU1ZtMGNoYnN0UmpHZ0RidnRoUHJpY2w3?=
 =?utf-8?B?N3pBOXErSE4xdHRNWndPMEJFd1lrWE5IQWlyelFWMVo4NTdKak1mbCtHa0F3?=
 =?utf-8?B?am1QMGpCUWlCL2JsNTI1SVgzN0NvQ2o1MWdJaTFCb1VSR0dyTHpObUUzazlp?=
 =?utf-8?B?TE5CS2pDa3ppSWRRTVpRZFNKd3ZaTnhWbWR1OFJWNlUrNHFtR09VVEYzU0Z6?=
 =?utf-8?B?blVFZnFGdkh6Z0FCeTN3NkVkVlpZQmN5ZmxzemI4dU1JYk1YZ1lHSlgwSTZI?=
 =?utf-8?B?TXZzTG52dGs0VnFkdkdvOWVaNU4zZU9SL21zVkIrQWd6a1lLL1ZreHllQVVV?=
 =?utf-8?B?bS9YS3BhTTJOQURUckkyUFFQaWZ1cXhSRXZpakQzRmRzdldFcmpDenRneTlh?=
 =?utf-8?B?eVc1QUZXMmx6MFcwTS9iOHRVWkhZNHRLOE1uZTROUUVSckE5Q091alcwa2Nh?=
 =?utf-8?B?Uk1MdzNPRVRmeHdvay9ES2NvZ3FtR3NTSHlaRTdYbjA4L2NkMzlLQ21Yenpv?=
 =?utf-8?B?REZKWGJLVElvUncrMzBwMk5lOFdKS05WcW8rU2pXQ1E3WThYZjJ6S3NBY3k3?=
 =?utf-8?B?WGpvNnE5V0FKRHJwSTUrN2dOMHdyOXIvMVIyTVkxbGhZR0pjSlNYTXR1UXc0?=
 =?utf-8?B?TVJaSkxhMGo1bjZRRFBIZjVkazkzWmNJdWxsbW5sdzJKaWZkb3QrQjFONzln?=
 =?utf-8?B?UzJnaDdXSmhnTHR4ZE9ub2xsZTJiUHJCRzUxU0pENkgrb1RUMjFYY3VlbFk5?=
 =?utf-8?B?QWd1QS9vTGFFZzdOUzA3OFhpUTlhUHhpTnJhdzdrbXN0dVA4Ty8vdzZpRmhq?=
 =?utf-8?B?ODRUSnhVRUdpWCt2djBRRlAydCtWVFJQUVh1SU13cDZBVmtpL1locndHMENX?=
 =?utf-8?B?NzRNeE1rSkZJdm5hN0dOV0x0NE9INUV3QzJCdndlWU41Y2lOTlZyaDJTY3NS?=
 =?utf-8?B?TUVMQmYrOEZuOFZpUnZobDFoVGVldUNvUk0zb04zbHNBZ3VxYzRRRkszLzRK?=
 =?utf-8?B?NWZwTW41aElxemFieHJDOXRWWFRleExPRHNQOGJLQUxsOEplbzJ6RWJ2eVlm?=
 =?utf-8?B?eXpEc1RLbkJ5RkFjNlFFMnN3NmtKWEhsYWx6MzEzTFlzVzhJTXVCZk5xV1d5?=
 =?utf-8?B?TGkzamNqaGsvVGh2YlIrbnVyeEhNTU5VNW1jOCszNDZyTG1VeWo4dXNxSG5q?=
 =?utf-8?B?MkNLVHpWVi9heG45MHIxL1lmZGh0a01aeVd5RjFCMlo2NjZYSkxTbFlTMWlE?=
 =?utf-8?B?UnozWkUxeEhKeEdwZzBMWis2QTQ3bjAvYjNzUHQyUkRCek9DK3REZ0xKb0ZJ?=
 =?utf-8?B?b3RWaGFIWFUyRkxQL3FmT3dtalhWbU9xMG5HTU5jRGJyRnlLcHVYd1R2L1NU?=
 =?utf-8?B?eVFDbkhPdEtvakJ3YzdIRGZwTThCL05zdTllTzhCc0x4bnAvQmpWRG80MU9C?=
 =?utf-8?B?ZVdzblVzQTJCeDFnSzZFV2x0MXZqMm9DTVNZSUFjcjIyNXFmVHpmN1FVa3gr?=
 =?utf-8?B?K2RCOC9qSGFEUm1EL3NIV09kUG4zSWl4dEllakthQUphNC80RDQ3dkxNbHRO?=
 =?utf-8?Q?Q8Rqzf9kbMnm5+a7wTKVbaHtusTxvNWj9wRgA1s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXV0V2MwbHZuR1dsSGlwVjRldlZiL1BSZDdsY3Q0ZUIvN3Brc2ExK0cyOWZJ?=
 =?utf-8?B?M2FUUUhoY0txWnovQWJwV3I3bERHQ2I0T1g2MG1qSGFFdDF2dWRJa2ZieVpG?=
 =?utf-8?B?TzlUNlphYUJ4NmV5YnQ1QVBsY0tRMVh6SkZBeU45NXZMb1hteXJtd3BkcWRh?=
 =?utf-8?B?bjJmUmNiektYR0M4dTJkdFI4TmhtcTdPamhSWjZiSmdZamsyZ25YWmhrdXJv?=
 =?utf-8?B?L0l2SU9CNEN6SEpMR0pFbHFXc21ha3JwWmRyMEJvMHo0RjZsOTdISHZmRGZp?=
 =?utf-8?B?WWV0L2tMK1ZZZW9wN1FHR29KQmhLb1lqWVpSK3o3eDcyM1IxQ09XTFE3ckFu?=
 =?utf-8?B?NWxMM1dlNEJlcWg4NHE1M2JUVHY2WWpZVEVwNlJiMFVKWGNaMExXemxQc3JT?=
 =?utf-8?B?ZXpDQktJUzFZRVdacGhyd0JRRG1zQkIyZ0Q5aU1UdjlkbGhyek02djYreWxG?=
 =?utf-8?B?MHNhZ2J3WU41L25wTC93Z2Rmb1haSjhyd1E5SFlBL0FJRCs4THUrSFlpMEha?=
 =?utf-8?B?d2ROeGhaSnk3RVFWdTdqcmxGeTZoWkVPKzB6THVhelg4aXp6cUgwbnRnallO?=
 =?utf-8?B?S0RzUjgwQlNtcXVXNXI0eTB5VFFqVXpydDNucy9BWkVQVzV3RnVIWndOUmtL?=
 =?utf-8?B?alNDLytHclVPVmhIL3lmQm1IeDhZWXRoYnYyZVJTRGV5aEpLVDFSN0tDMTFT?=
 =?utf-8?B?SDBLeURRT1JkOFFHNVU3SWNrZEZScWhZcXdBZnJsVWVwOFB0UW9HbzBRNWxO?=
 =?utf-8?B?SC9nTGtrQTBMSWRpOFRhN3ZIeTVRWk9CTjVuRmNqVVU2TkszbkhyNzNwUjFS?=
 =?utf-8?B?SXljdFFPeVhsNlpqSjIwMDFNMEVTSXNyVXNaQTlnRnAwczNIK1phZU0vMjA2?=
 =?utf-8?B?cTVmZUQzODB6Q0FkWTJMMHNmR0lZL2NlNDROMFYrVFBVVTFRVlZncUJjVlNW?=
 =?utf-8?B?YW1yemdEa1p4NzlmVzNkTVhOMmVGWXZPbnF6d1JQR2x1UWpnM1NGUWZiVHZE?=
 =?utf-8?B?b0xqa2dZV3ZLSXArdXZOUkNwc3dzbFlqQXFzY01FaDRDNStVcHN6cE55bk90?=
 =?utf-8?B?RmttYjJub3l4YXhFRFZKSHFWNmhMeGIwd0RyN1cyNm5PWGNCUVUzTlV5M29P?=
 =?utf-8?B?R0V0NnRUcUVsYSt2dytKYkhRSGlPcGxPZXJlM2dOYy9WdVVQNC9uVm8zazZC?=
 =?utf-8?B?TGhobXMxM0lEMitXYmdGVUREbUhHUkZZL3BEYXJsUEhGcFdFc0J2YUJxZG45?=
 =?utf-8?B?WVYvR3BKNlRZODM3Z0laVmNXMlpXQXJUcVlOMHlRME1XdzhOd1ZTbnhINit0?=
 =?utf-8?B?S3RJSjRodkdJOUFLVWErbkhsK1FlNDFVSThTWGlFMU9MOVU4RkRVL1d0ODNN?=
 =?utf-8?B?QWdYZGg1TzRXbUJtMnlBKzZDUWFlM003SC9rTVNlMi9KRGNCWUJZT0xuRzBm?=
 =?utf-8?B?b2ZDVEJFTHdabkhkZTVqWjlPb21hd2N6NmRPUVJiRTF1NWFqZ2owNTkveXht?=
 =?utf-8?B?VFJWYU1OUUFhSG1JTGVZUHZaWXdnU2JtS0o1ZVNvZU9NaEQ0RVBOUjFHcVJH?=
 =?utf-8?B?bTc4L3NPTnVHSnhmbEJEa0UxZkk0bVJNRSt2N0pHeEw1ZHJpaFJzbXQrTFV6?=
 =?utf-8?B?YWxaK0NiZTZ6cCtVWS9yL2FKMFh0a2FRanpSaDJMMWsrM0QvakFhUTVtZWhk?=
 =?utf-8?B?eDFnSFFna0lORSsyakZybklWVzVwMU1STjcvQnFXL0VhcWZnVnQ4UUROUHEz?=
 =?utf-8?B?T3VMU3F5VUl2Qm8wT3VrZWVraHNBcFpZYldvUjBvT1JiNXZka3A4RzUwVnoz?=
 =?utf-8?B?SWtaSjU4ZVdta1NQVFduajBHK1IwZ2NTUHVYV3lPM0U0ZmU1UEl3alpWeXgz?=
 =?utf-8?B?RHZqNEFJNnRtekg5VWhuVmR2VDlWVlZHaU5PcktjOVRwOFBnczI5ZWFkMHpw?=
 =?utf-8?B?bDZ3dU5jY3VvRGxTMmc2bEkzenExam83ZGJCZEZvOERmOGkwdHBEeHdDUnJP?=
 =?utf-8?B?WnVadFVqWGtoTThTNTI4Z3dvbjhMTkNiZmo2R0E4L3FEUC9YekhsVndGVHBZ?=
 =?utf-8?B?MnMzSmZacjJBNngzUXRJa0FIZVIwM25qM1BNQlpmK1h1ejl1dHNYdjJhOXpJ?=
 =?utf-8?Q?YUcsG1cLJ8rvmNAz3EhmYwJke?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc86e16-da3f-452d-34c0-08dd1ddf6f0a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:39:23.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BnjfnBm8egnO2lFKakZkZMD8ZfADLtmQORgvaqTDp+dPWF3HcEe/dR7rx69WPispraLoPELLebDByvq4YYJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-BESS-ID: 1734359966-110965-13342-8490-1
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.58.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqZGBpZAVgZQMMnCMtU80dwsMS
	3FODXNzCDZPCnR0jzN0NQsyTQtJTVFqTYWAOjJhalBAAAA
X-BESS-Outbound-Spam-Score: 0.90
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261154 [from 
	cloudscan23-55.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.50 BSF_SC0_MV0963_2       META:  
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.90 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_SC0_MV0963_2, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1


On Monday, 16.12.2024 at 14:51 +0100, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> 
> The memory is starting to come back :-|
> 
> Ok, so the good news is that you aren't seeing things, I can reproduce
> with tools/testing/selftests/drivers/net/dsa/https://linkprotect.cudasvc.com/url?a=https%3a%2f%2flocal_termination.sh&c=E,1,Ez0FDT_USqvD0083KxZU7x7ffGuJDoeCC6xMtetczJrwErBfCEyO1pnImOnY_ifhHDMKhhPtJGv8MpKk1zKoqa6Gm1JP-zTkotP2AOShxr3N&typo=1
> 
> Another good thing is that the fix is easier than your posted attempt.
> You've correctly identified the previous VLAN stripping logic, and that
> is what we should go forward with. I don't agree with your analysis that
> it wouldn't work, because if you look at the implementation of
> skb_vlan_untag(), it strips the VLAN header from the skb head, but still
> keeps it in the hwaccel area, so packets are still VLAN-tagged.
> 
> This does not have a functional impact upon reception, it is just done
> to have unified handling later on in the function:
> skb_vlan_tag_present() and skb_vlan_tag_get_id(). This side effect is
> also mentioned as a comment on dsa_software_vlan_untag().
> 
> The stripping itself will only take place in dsa_software_untag_vlan_unaware_bridge()
> if the switch driver sets dp->ds->untag_bridge_pvid. The felix driver
> does not set this.
> 
> What is not so good is that I'm seriously starting to doubt my sanity.
> You'd think that I ran the selftests that I had posted together with the
> patch introducing the bug, but somehow they fail :-| And not only that,
> but thoughts about this problem itself have since passed through my head,
> and I failed to correctly identify where the problem applies and where
> it does not. I'm sorry for that.
> 
> I've just posted a fix to this bug, which I would like you to double-check
> and respond with review and test tags, or let me know if it doesn't work.
> https://linkprotect.cudasvc.com/url?a=https%3a%2f%2flore.kernel.org%2fnetdev%2f20241216135059.1258266-1-vladimir.oltean%40nxp.com%2f&c=E,1,iMsl_DfLMdZXF3FfFIT1CISQcjOL417WIsr7z01GodEy-1vyX9d_6X-8hFJih2CA2zAax4kx2mFdtftzn-ELRkGDBCa9lxIWU_wEN8dtO2aVO7NS7ck,&typo=1
> I posted it myself because I don't expect you to have the full context
> (it's a bug that I introduced), and with yours there are still a lot of
> unanswered "why"s, as well as not the simplest solution.

Actually, what you did is exactly what I did first to fix the issue, but it broke my setup when I sent VLAN-tagged messages to the device. Now I tested again, and it is working fine. That made me think it's happening because it is stripping incorrectly the VLAN tag. Probably it was just an incorrect setup, maybe something remained set either on my PC or on the unit from the previous test.

One thing is different to my change though: you're calling the br_vlan_get_proto() twice. You can tweak performance a bit probably, if you rather pass 'proto' to both dsa_software_untag_vlan_aware_bridge and dsa_software_untag_vlan_unaware_bridge instead. So something like this:

diff --git a/net/dsa/tag.h b/net/dsa/tag.h
index d5707870906b..3d790d8e16cd 100644
--- a/net/dsa/tag.h
+++ b/net/dsa/tag.h
@@ -57,15 +57,11 @@ static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
  */
 static inline void dsa_software_untag_vlan_aware_bridge(struct sk_buff *skb,
 							struct net_device *br,
-							u16 vid)
+							u16 vid, u16 proto)
 {
-	u16 pvid, proto;
+	u16 pvid;
 	int err;
 
-	err = br_vlan_get_proto(br, &proto);
-	if (err)
-		return;
-
 	err = br_vlan_get_pvid_rcu(skb->dev, &pvid);
 	if (err)
 		return;
@@ -103,16 +99,12 @@ static inline void dsa_software_untag_vlan_aware_bridge(struct sk_buff *skb,
  */
 static inline void dsa_software_untag_vlan_unaware_bridge(struct sk_buff *skb,
 							  struct net_device *br,
-							  u16 vid)
+							  u16 vid, u16 proto)
 {
 	struct net_device *upper_dev;
-	u16 pvid, proto;
+	u16 pvid;
 	int err;
 
-	err = br_vlan_get_proto(br, &proto);
-	if (err)
-		return;
-
 	err = br_vlan_get_pvid_rcu(skb->dev, &pvid);
 	if (err)
 		return;
@@ -149,14 +141,19 @@ static inline struct sk_buff *dsa_software_vlan_untag(struct sk_buff *skb)
 {
 	struct dsa_port *dp = dsa_user_to_port(skb->dev);
 	struct net_device *br = dsa_port_bridge_dev_get(dp);
-	u16 vid;
+	u16 vid, proto;
+	int err;
 
 	/* software untagging for standalone ports not yet necessary */
 	if (!br)
 		return skb;
 
+	err = br_vlan_get_proto(br, &proto);
+	if (err)
+		return skb;
+
 	/* Move VLAN tag from data to hwaccel */
-	if (!skb_vlan_tag_present(skb)) {
+	if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
 		skb = skb_vlan_untag(skb);
 		if (!skb)
 			return NULL;
@@ -169,10 +166,12 @@ static inline struct sk_buff *dsa_software_vlan_untag(struct sk_buff *skb)
 
 	if (br_vlan_enabled(br)) {
 		if (dp->ds->untag_vlan_aware_bridge_pvid)
-			dsa_software_untag_vlan_aware_bridge(skb, br, vid);
+			dsa_software_untag_vlan_aware_bridge(skb, br, vid,
+							     proto);
 	} else {
 		if (dp->ds->untag_bridge_pvid)
-			dsa_software_untag_vlan_unaware_bridge(skb, br, vid);
+			dsa_software_untag_vlan_unaware_bridge(skb, br, vid,
+							       proto);
 	}
 
 	return skb;


Robert

