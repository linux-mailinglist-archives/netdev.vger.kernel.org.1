Return-Path: <netdev+bounces-158646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC142A12D0C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C8E165ABA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93901DA103;
	Wed, 15 Jan 2025 20:55:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2120.outbound.protection.outlook.com [40.107.121.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC21D88BE;
	Wed, 15 Jan 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974515; cv=fail; b=ctt+8di1x/thTiAEzSibMayz/QMNfTXUaotgQa4iG/MJZNRmAa56Ol3DFJ+rQzwfNhOZHSO+YdKzBWg6cUqYbnOT/y8srJfGM4k3GcZ/HLOQK7ucaky/RGE5BgQ5bb89sK2RUTka75OEHgXv32Tx/SB0PUYxDBKaKI+6dpWGbS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974515; c=relaxed/simple;
	bh=Noc/615wnGhOX6tnLjQaPH+EnWvpGmFGYuboeAix6+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJW9j9RBJAKGD9PLhZ77uVJP15NIPkvi3meZ4S9aeDTxQP3xwpuUKFHAK31enZ6PnjmJ57yKdaUvl3y0mXcYCAfjVVYsg+CGZW9ocpiB1R4mhTWHffAiPSiEJSN7+BV0WfEJj1XosEcuYgJvjQFlBHVAHIhcAIeaZw4JLVWKL6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.121.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKPL/rrsHn4IIlmqIH+zPU/UUWCE4xHEcaeFjxhrMpMcKCNVKi0p1SOkhKPcVdqWHnwGbF1luWuUvt+O+Kx19LsU2z1Xqqd+iey1ZDlcWjJzCbuevNIMMu/z2Y9AF8+M4KX3ypmYa/sHi8ymdPgmQ8XnxJR+fVdHXO8eog6qt73ZA2p+ZeJNInmI7x7K9PWDC+44k57knlu7M/cnFpyXwbkP4qlEtbW1aCXofNsYp0XjKtoqXMfvAa4NywB1jLCtdSEpR3sx7wWAHXeQcH3BGMp3QvhyZ2vm5EzI//+IhsmF7AA8gQxr0NFrZynw+eHYCwoJa4pUWDXTeDvVh+LKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q9P1n+f2/c9d5rGPcBQlfcg7Mj3pLavAWyUfN04OBo=;
 b=PWWB08F456uMHK2cn8qOTL+/rPB7WJkigYjY2lCVd+k5ncP+wQXNktdVvKmz2jdM9XGzVRvIZf1PUsp1FUAW3VJy0WUn6/iCikrpnddYFYkOgihOn/m76iIvMin9m61HV5eGBxwDOh+N4rj+VjtJdFwrHmkf9BZhcFXoS7qoWIUmmc1O+cU0+JarEsiA2YJQeZHBJrZq2qVTUD3panCfk8a5OPWZpvzfjiA9nD6i4xvvV0XvqhhZEO4jQtrb2CUlCavmIq0URGRU4bU5BYlwWhvZSwUPc3oiEgaWZ7Zk/H6DTudGEeyr3cwp4HaRYyUoaWZ592NmXgaTnsm9g/lr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB5761.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 15 Jan
 2025 20:55:10 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 20:55:10 +0000
Date: Wed, 15 Jan 2025 20:55:08 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	ronak.doshi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
Message-ID: <ncpborfj3l7nksueickn7e6vjk55kxddaybvluq24d5rbjvgm7@46rjwzvlkztr>
References: <20250105213036.288356-1-atomlin@atomlin.com>
 <20250106154741.23902c1a@kernel.org>
 <031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com>
 <20250106165732.3310033e@kernel.org>
 <2f127a6d-7fa2-5e99-093f-40ab81ece5b1@atomlin.com>
 <20250107154647.4bcbae3c@kernel.org>
 <71e6ab28-be0d-b85c-900b-537295bc81d1@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71e6ab28-be0d-b85c-900b-537295bc81d1@atomlin.com>
X-ClientProxiedBy: LO4P265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 4015037e-359a-407a-7f9d-08dd35a6e60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkZXUkNVRFFiUGt6MWd2L2NSNENzdnZnMSs3UlB6TFdWNTlweE0yRStGYkdF?=
 =?utf-8?B?bU1pYkVIM0ZFSm5EOGJrNkk2U3NCU3dkQjJVSGxNZ3R3dTY3RUFGR1czMkhn?=
 =?utf-8?B?NVlaeE9YOTRxMWNNTUQrWW1hdU9tTkxpV0t1R2YzWUJObHRsbFhMNy9XRHg0?=
 =?utf-8?B?MXpxWlFxQ3h0V1VQTUVFZFJYOG9HbThzTmw1YmNyUis0cVJvaVNOeXBGVTE2?=
 =?utf-8?B?cUtCdkR3UE5CWnNjSUFXSk9kRWpPTytUVHJESXhOWFhlVlFLZ2tvbWEwNmh4?=
 =?utf-8?B?M2F5aUpMZWpUTDNoYng0Y3FYSkg5cDFrdDNHRHQ2QnUyaTJhV1BDMVBmRWpr?=
 =?utf-8?B?TWZzaFJhUndxQmc5M2djTWJvaVR5MDBEN2pYMkJvSkdmOTJCTTFpcFNlZWZu?=
 =?utf-8?B?eVdoa0twTjJpMk8zTEIwSGhtT0dldFljcEh1T3lIOE8yZVFkendqQ1MxZEpW?=
 =?utf-8?B?WWw3eC9BZ05aUkx0cHhCL1QyWmk0QkxrajVGTVNaR3E0d240WG9JdmNJc3Yy?=
 =?utf-8?B?NFFxSkQ0bXY1WEZVcFliYkpwdHhjVHpzcEcyd0grVzhnekVuTkZOeVVQdSts?=
 =?utf-8?B?MmY3L0J2Vm1qbDJ3aFNlalZYOWtBNGREVGhoRVM0MlVoeFNRMTFvMXZjNHFx?=
 =?utf-8?B?V0MzejNlRU1CZGgrZzZZRWhNaVpTMHova041ME83eE1lY1Nlbllrc3ZyKzcz?=
 =?utf-8?B?dHptOUp1K2hISXZFQS9YYnBGRm02a1JWREhqMlBjYzlPU0tHVW9vdVBEaEJE?=
 =?utf-8?B?RDNSNVdsa2ZnMjBYeitvaGNNWjltZjd2SXZGWW5qUkg4REFBZG01K3VTOEJV?=
 =?utf-8?B?RWZsOWxwZHBzTC8wNHdwY1F2SERvUWkzQWdSY2xuMUoxdGVFeFRCZ3lhSGlS?=
 =?utf-8?B?NEE3bU9hc0ZQWmZBYmVqdmQ3eXlNYjVoRWpjS3VtaGk5WjdTemljUlVyN2dy?=
 =?utf-8?B?MnJZZUFNRkpLZyswMzE5Zm85bjlWUitveEYyTnpPdTBBUDVuM3RmYVhOYWcw?=
 =?utf-8?B?S3UwbitVSkRTRVBLSGN0SFJIWlQ5eUtmaGtCRTRhanZuOUdaTWV3MVR6K1g1?=
 =?utf-8?B?aEJoNm9JVTVoU1NPNi82MW1RUXc0MW43OWN4QTRXV3dOV3NJeFJMbVRWdEtT?=
 =?utf-8?B?YWJsbDhpMFlwZ1JxclhEQlRIaThUVDRkcHkwWngzd3U2enFhelIxbGEvS0ZG?=
 =?utf-8?B?TWhWU1Z0M0dVTW0xNTFKZlQ2RWo5SmJPWDR6QUxnSHpGWEVNTjBDRmZGalVu?=
 =?utf-8?B?enBoT1lYUzdVWXJldnZnQ1N6OFVmNDlZVkE0N2Zsd0w1M3J5Y0RFRkhEUmxY?=
 =?utf-8?B?R0swQ0d5WUFmRnlUemZlaFN4UHhSR2h0VURUZ1VaclQ1ZUJKcWV3SU1IbGdD?=
 =?utf-8?B?Z1hCQ1BRbkw5bWIzKzRlbXNXaHpnS0kyVU1rRGl6K2c2dUFFNFNqMXZGZVQ5?=
 =?utf-8?B?NlRHYUx3VVdkbjE4YTFGUzhFOFJRb01pUW9TamxYL0ZsY0hBOEt2dW80ZDVv?=
 =?utf-8?B?M3RzL0dwSjliR1lUZkxWQmlUUVI3M3lpazZHYlBoVTJoOUE3M2RNYUtlT0dk?=
 =?utf-8?B?UmRtSTNBa2l3S2d1UGM4aDlxUXMxU3F5UG1BQVFiTlFpZktKV0ovb1FyRTZB?=
 =?utf-8?B?MEpkUEx6U0RrbUcvdTZ0Zy9SNkdCNXFodUtoWjlNSEJZVEc1VENmS21FVFpx?=
 =?utf-8?B?ZEZZaXpBbjZwa2RTeDc4aXlFNjd1cW5tZThsaDhKQkRySjE1cnZGR3BnWFN4?=
 =?utf-8?B?UlFxUzJSMGNFazFSUndMcTZBVG56L2lUUDdxbjlka2puZXdESCtSTjhsclVB?=
 =?utf-8?B?RmpYTEtqVlNMQ1cvdldrVGhuM2FyeWV6UVhMNFZ6SSswZ0dVNXFWdGczTEZt?=
 =?utf-8?Q?qrHJzhHrPW50t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBNRXE1S2RDRGF5TDRDOGYzMDVyd0lEUVIxU3BlUDFYaHpYcGpoQjBvandp?=
 =?utf-8?B?S1drY3FIU2pjYW5ZOGYrNEtLZFQ4WEVwenE1aEhwWDJONEFxOE52WWtZY1Yr?=
 =?utf-8?B?ZVJYT2NTUVFhdytnWkVSRWNMYlRsRDdsdFgrTFJVVTdSeHZZeTh5OWtpUnMx?=
 =?utf-8?B?azNaN2R5ODhkTy9MR204MlhJTDRQbHBzVHRYbk4rQmpRK2JsSmo1QWc1cy9k?=
 =?utf-8?B?S0RkYUpVWklnVFBjUVFkRm9PMC9sRUVkUE9CVnZGNGQ4Tkh2RDIxTk5YNTB0?=
 =?utf-8?B?VkdMRTN5Zm1JYnVCVG1ZR2gwZ2hrSHlhMkpnRVhhMFBpaEF0VHNQemNLQXdK?=
 =?utf-8?B?Q1BMQ0tLck45eUhVblJCbDZCUUIyZWxsdCtIUGtVSjhmaDgyUmlHSHBUV05V?=
 =?utf-8?B?VTM2SUFaVGRWQWpXQWZPbW0xaWpWZ1kwdWxMVmZiMjVNOEdCR3NRSGZ0QmV2?=
 =?utf-8?B?dU9OdGlBd0Y2R1dLdDczd1ZmUWpIcHkyOGdOMGlqejd5ZzJielZuRWpjMHgx?=
 =?utf-8?B?V0RXQWdSVzR4TjRaWTExalQ5dUpvcEI2UnllTjJaNnVtTUxqd09na3JKb0JS?=
 =?utf-8?B?MWxqSmkzUEJIc2VrOTk1Qy9sM3lCcjRjQmdTZVM0RHFrZWFleER0bXd4b0lD?=
 =?utf-8?B?ckdoMWszbGc2dFlZMklFOWtxME5yTmpnWmh4V0RBbDB1R3F2a3I1a2xyb09O?=
 =?utf-8?B?SzgyYUZ6SXFqWUV0eXpnVmlLckQzYlRnTVRCSDI2eHZFWDlGMUZZUmNkbUda?=
 =?utf-8?B?dTF4U0ZRTEN2WWthSGJqRmhwUG52SWhaVVJaYm1jbWhMSVRvSWdhUHJaMFdZ?=
 =?utf-8?B?OGtNZUVrMVpXNHRTREczSVludzZseEorMUNTT0RLM21XRExiQi9SNEZRTU5R?=
 =?utf-8?B?WFdpNTM5VThVKzZ6VzBldDgvMnhSTzJKZjVqMFZmUXR1My91Z1ZtQWlhZXVa?=
 =?utf-8?B?NTZzcldnazhZUm9veHZTU3k0bnUvaWs4Q0d4OTJ2ek02WlB6Sy8xdm1nMXJP?=
 =?utf-8?B?NEJNWFdRWmVWOUlMTnI1L2txV3FHRHhDamxQazArMDM3TjhGOXFHU0tNa0RO?=
 =?utf-8?B?bCs0ZEorSGIvNSt2MGlqOWgvUXNEZldBKzVuRTNsT1hNbmZLdnZiWVVmYmdJ?=
 =?utf-8?B?Z3p6TGswcVNGNkhEd0kvczdBQnRhN3RKQlBRR2x6dzJwSUVpOXA5bUhETXo2?=
 =?utf-8?B?ajNSZ2gwOENSR3VCVnowMUV0RzZyaEpZRGJxdWh4Q0tlVytDMkZkaDM2VU1T?=
 =?utf-8?B?OC9YVzRqRU1LTWdxb3lMRlFiZkVNYVhyMDFGNkhTZ3dQWXZtbnVFNjJra2VH?=
 =?utf-8?B?cXV0aEpjOGpJOHRXdXZlL0cwOGgzNjlmWDJiUUtqV05GWllCUnAwM2tYTVgz?=
 =?utf-8?B?WGw2aE1ZRWJIaUo2Mk5PTjNiR0c2WlU3eHJDd2RmSGNkL0tKbEorcUFuaytp?=
 =?utf-8?B?OHYyai9xNWpxRjBJMFo0UFZnc1o3UkdFRXYzNDl0NGJ4ZU1uUWhYSjlZWjln?=
 =?utf-8?B?NTFqYVZJZ3orb2x4cXZOT1NvQW5YaXd1d256QWZRT2ZUSmRLbXd0SXlWQzR4?=
 =?utf-8?B?NUFMYXFoUXlhaFBENnd2czBiYjR0UGlyMzRCSXZpS1pyVXhMT2RxL2h2aEpM?=
 =?utf-8?B?bTZJZ0EzNGR4SHpNOHVva3VFRlJFaWo4OUhObFVCY2xBYXJsN2tVeFgxTHpC?=
 =?utf-8?B?SkdsMjhGMithdDVTQk91YklyblJDSVZtZGI5cGVJM21WV2svZzdZL1JzT3VD?=
 =?utf-8?B?b1ZDWjR5UHk3S0pBT0dDTk5GMXcrTnNrQmJxY2hmdGZLSVlvL28vYzFteWlI?=
 =?utf-8?B?d3ZpTGVPNHR0RGptWlpwTVlmUEg0UG9uOXA1Wmt1Uit0dVdneVViVit6TERq?=
 =?utf-8?B?dlZtWlF0THBDcDJmd1MyOVVqbWtPMDNuYjlvaFR6UXBBKzI3a1ZJMDlMcU9Z?=
 =?utf-8?B?aWUxZE42QzYrVVFtVnBzODgvUFJmUXJHL0ZEelVjVkc0OEVYajFTK3pjMnZn?=
 =?utf-8?B?YXZKK3lpNllQVTdlRXVnUStHTFA2U2l1U1d1dnVNblhFOWhPYmczNGJRK1M5?=
 =?utf-8?B?QlZISlYrdkpTaVZnN0l5ZGhaeTVGQnhBT3lTQm5CZ0JYQURabHIyeFZkNFBo?=
 =?utf-8?Q?om+vKw28Hg6U8Mpl+fKIRyWS9?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4015037e-359a-407a-7f9d-08dd35a6e60d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 20:55:10.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMqnLHkRxmrsVarQbDgpEk4yQk2TnQgyMJ8A3xWXyD+0hkAvRXxrPZvXkgYKlPEgTetXVsX/lKR/C9CVgj20ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5761

On Wed, Jan 08, 2025 at 09:05:15PM +0000, Aaron Tomlin wrote:
> On Tue, 7 Jan 2025, Jakub Kicinski wrote:
> > This is a bit of a weird driver. But we should distinguish the default
> > ring size, which yes, should not be too large, and max ring size which
> > can be large but user setting a large size risks the fact the
> > allocations will fail and device will not open.
> >
> > This driver seems to read the default size from the hypervisor, is that
> > the value that is too large in your case? Maybe we should min() it with
> > something reasonable? The max allowed to be set via ethtool can remain
> > high IMO
> >
> 
> See vmxnet3_get_ringparam(). If I understand correctly, since commit
> 50a5ce3e7116a ("vmxnet3: add receive data ring support"), if the specified
> VMXNET3 adapter has support for the Rx Data ring feature then the maximum
> Rx Data buffer size is reported as VMXNET3_RXDATA_DESC_MAX_SIZE (i.e. 2048)
> by 'ethtool'. Furthermore, See vmxnet3_set_ringparam(). A user specified Rx
> mini value cannot be more than VMXNET3_RXDATA_DESC_MAX_SIZE. Indeed the Rx
> mini value in the context of VMXNET3 would be the size of the Rx Data ring
> buffer. See the following excerpt from vmxnet3_set_ringparam(). As far as I
> can tell, the Rx Data buffer cannot be more than
> VMXNET3_RXDATA_DESC_MAX_SIZE:
> 
>  686 static int
>  687 vmxnet3_set_ringparam(struct net_device *netdev,
>  688                       struct ethtool_ringparam *param,
>  689                       struct kernel_ethtool_ringparam *kernel_param,
>  690                       struct netlink_ext_ack *extack)
>  691 {
>   :
>  760         new_rxdata_desc_size =
>  761                 (param->rx_mini_pending + VMXNET3_RXDATA_DESC_SIZE_MASK) &
>  762                 ~VMXNET3_RXDATA_DESC_SIZE_MASK;
>  763         new_rxdata_desc_size = min_t(u16, new_rxdata_desc_size,
>  764                                      VMXNET3_RXDATA_DESC_MAX_SIZE);
> 
> 
> Have I missed something?

Any thoughts?



Kind regards,

-- 
Aaron Tomlin

