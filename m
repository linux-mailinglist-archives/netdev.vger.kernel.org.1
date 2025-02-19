Return-Path: <netdev+bounces-167810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C506A3C6C4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCCF179DD2
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BD3214232;
	Wed, 19 Feb 2025 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SRWUulU7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CA1F2B8B;
	Wed, 19 Feb 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987569; cv=fail; b=ODTod7UKlc1uYTnvhfVOwufIuceH9Ypjlb8GNEDlUD2coctNUXFzNOvvit75hJSujuXkTQyc5TO82K2rvnTSDthjP49DY6YRFLA/qkNv61bXOztg17lCUKhqqNKeLJ2bomppN68yOueW1ocpR31LPrsEI5tBmDaGwkRa57FCl0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987569; c=relaxed/simple;
	bh=MXK9GiiCx/yjge3RBY2tF0HNC2XA4fhuQJMtaCGH/1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NPWLe6iA/5E6m34uIU+radUd/fWzrse+Q3q7xUg/WHwaCKAVKMnKfdDez42pE+tST6/faFsYwa5MJsoCjHux7pAD/TT65OoGm6S3UykHTqpcCTCRDgbEXeSZOdhBW2TRIKZgDVI+BsymFuKGF/8aqrL+nVcw85ShTgT5abunncw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SRWUulU7; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9xbNdG3ys3WPG+XoafNTUQcF0GZrDtpPa1iIjMkUDMG3MkR5rx7r94OXk+QoblDnWGKBUaOBkD2x/APlyXiiufcoLAk79Dd0I/z1OmHGbCnxldbInHXO1cxIOEwoNWdU5SqMVG5TrNbjK+D75P+XDuoF5wYWv70BhH8NPFwm//BJZR6qUyHkBHEZwzweoNeP40H7gD0whfdBI+JZLUCcFFd28BegqXcexZx7uLF6WTAxBxgYDNpb8qHD7/pU2QF/uFreqHHO9z8AtNJFRzDpzM38ZRpsoLz+IOcKaoMis4XKUP+Ry50drQk4p2xRzEwOy88RDkoWstx68w+lAe4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv0ZUmReCUiGy2nBxYCJ2IgNBPt8d9nCTdQpoxkasXA=;
 b=LSfGmjFaEihf2wrXzBMftRRzT1SG17mWCisIin5LZz1+kOkH5CRHZJZe6PDJDpW4EPVrmoQIIPY6ZF64O5xUjHzMYJ7DsDKzG8M6s0zkYVN5s2fUQuk9hDLpl0IVrIE3QSiEV5MXCBPtRY+43bvJWvxd3O6Ya0KfFUZiwJlicfkodFuOGPxIQptM22nSrlIWFzOxkcFKFolENLiCR3OMHU1MrxjsNIz6qXY4zevoapfkkvUtUB22kWd37rF1+U/r4F//EVXioGuLt8GrALb+f3H9EU79GThXA3yH5kEkKtyFwQ0ioo2pXfrKpCvO8OiayKbEinIBq0vIJuNT9lq2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv0ZUmReCUiGy2nBxYCJ2IgNBPt8d9nCTdQpoxkasXA=;
 b=SRWUulU7kBH8GBc5vypxTTKKYP36hf1HNzKlXJrBvj1YnUz6hskp+tFpLJls6BpEM+WQmU0xaiqzPf6YOHCjxs5cO7/PIdKWSkBfHWhrS1m7e8UnM9trPx81s2JSGub9CokOieGD/6pIZlNXHW9WnTBGldMQYRyAYvpo2K57I7vxZwy3VX3ZDaTfK2rQToYgWOHrDy1FrZrWBlDPR6QgKK1D5Yj1jWtQVTS30LMT6v6HWlFrW8qkqzvqCeOyWLTbqlyscnhvH/1K22ab5w30xlgI1ATiOMQhrcUpJ5+5bGEfCDQnnIpn/5xyBUzq68DWFYdvP5jMwRCXVUBHKGEZFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 17:52:41 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 17:52:41 +0000
Message-ID: <203871c2-c673-4a98-a0a3-299d1cf71cf0@nvidia.com>
Date: Wed, 19 Feb 2025 17:52:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
 <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
 <Z63Zbaf_4Rt57sox@shell.armlinux.org.uk>
 <Z63e-aFlvKMfqNBj@shell.armlinux.org.uk>
 <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
 <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
 <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
 <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb4afbc-cd9d-4bc5-0adc-08dd510e34b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVLVVFVakxGdGV5R3ZHK2VhaWgzUDJIRFZPWDZ5TTE4aUFVY240U3hoSGor?=
 =?utf-8?B?SERkeTI4L0dtcEpaREVpSWRUQjEwOXJFL0RtV0o2OXFieVRhc3VINFFaUzNH?=
 =?utf-8?B?UXdZTUJnRWUzMnlTWXV4RHhwZTJOTWtUbDBmNmQ5TmRJUVd3YmsvRk1CVEgr?=
 =?utf-8?B?SXNlTk9qVlg4amdkWDViVmw1MVY1Mm9ydVd2VldkMS9wVmlhcW5mcU1zOE1N?=
 =?utf-8?B?Z3VzL2trTjhCa1lpRHkrRWtyd0RIbkJHM1dHNUd0bUZzUU1FbHFtc1p4UGI1?=
 =?utf-8?B?S0VLU1ZLZFlFNGhtNzFYWmNiaXVhNkJubGROSmkwcnJabmt4QlZGbHk5cmx6?=
 =?utf-8?B?UjFCcG1CblkrTXlYbEMrSkwxeTRZZ3lHcDNGTnh1aWs5NUFwK0FpcFI1bWxs?=
 =?utf-8?B?elpTZUdQWjQzSmdkaEdVSWNJQjhsZnJZZDhjYTRjUUdEQjVJa3VDZUZyc2NB?=
 =?utf-8?B?azhycDBqSkE3WDFmS201V2c4V2ZGZHZGcjZVS1dUYW5SV2l0cTNWZEYvdmdG?=
 =?utf-8?B?d1Y3UnV5TENuNTNNTkRvcXRDR0p0WmsyNDhUZU1OVUhEUmlnbTJsaUhOeklr?=
 =?utf-8?B?amdiZjdPRmRWOHc4MWpFbFdBcnZUbzQwSlhXOFF0YnFIUUxnVWFCSmFNVXpr?=
 =?utf-8?B?MHVIVkhiZC9OY2hIUnpWNFdhVGhJa0piSEs2Umc4V3hRWS9aMjhKZXZkZkNJ?=
 =?utf-8?B?dTJUM1kxQ1BrOWt0N3VrV0w3RnAvRjRyQUFYVXV4UjhudTIvQS85S0FRTnNQ?=
 =?utf-8?B?RjJsWmRzZWR1NzZMMmlhQ1JJRS94VGRsS05WUjQzeXRtd1NMbGkvcm9QWjlF?=
 =?utf-8?B?Q0lWenBYbVB5UGsxRVlHUkc0LzJPdnNKUUFiQlJVeUpoaUJOZk52NG5FNlNJ?=
 =?utf-8?B?YWFveXo1NTdBdTBkeTBpcDFVQVpkOW82OFNXSWNwTlZNMURudVJaOEFmdkZB?=
 =?utf-8?B?NnBtVEZjTHNESWdoRzVzaGNZckUwYy95c2d4SEJkVTNnYUlNNENyRk96R0h0?=
 =?utf-8?B?QXpSRGxtSDQ4MW90NzdHTXBnZVpNM043T1g4M3c3OW81OEpKZ01mN1Vnb3hO?=
 =?utf-8?B?WTJ2U1REdEJhN2k3WUwrNmhGS285VjhZNm9rMlRzSXdSelZvNEg0MGVRUUwy?=
 =?utf-8?B?ZDU2OWdHbXBCRXZIWTAxdjJVZGNvdkZQZlhwLzk1NS9FTmtnL3VNNnBGcjVN?=
 =?utf-8?B?YnY1SERJTXliVnFZNEkyaXg4Y3ZhWllUakNSQnMrNGhqSHBodVNkZUdkbWRC?=
 =?utf-8?B?TzU0SlZpZWUvN1BScXRKaW1uVEFuTmVSNU1JZUN3dit3b2ROMXJlT1ZreVFF?=
 =?utf-8?B?aDFJZHhxWjFiWGJiWGxZSkdoUHdsOHRqcHRqMm4xRkpjaFR3MHREMWZpOXZk?=
 =?utf-8?B?a3JIaVBINzN0bDROS3VRUXdZMnZLZzdlWlR0Z25HVUtOOGlrblNPeDl1S3VD?=
 =?utf-8?B?aUlqVW13K08xdmViYXNkcENlK3pTb200YU0yVU1yUFgyZTRsc3AzQkRuNTZw?=
 =?utf-8?B?M29YT1NLM3BXK2hoR3BPa1YvdnN3WWpPZ2trWEhXbjZqN0lESlZVaUJRUysr?=
 =?utf-8?B?TWdFSnAvMzVob2RDRFRTaWUzZWxpbng5bFlvc3Q5RnRhdFVBOEdoRlZlM0Rs?=
 =?utf-8?B?d0ZQWnlNSWpNYlhXUDZkbTBFdlk2Z2FYZGpQS1I3MEszVUdZOEs4ZnVzOTFv?=
 =?utf-8?B?UkFlMkNOcldtd2ZBaUp4dUdpQTM0WkhzUncrNXgxNGw3UUttTUdJK3c2T1lS?=
 =?utf-8?B?YURLWEd4WkhlbEp2aHE4cTg2SU02UW4rV3VQK1N4YlRkWkJBTEs1UGdhS2R2?=
 =?utf-8?B?N2RHSFNiVUt0RTdRNFdKTzhibEtGbTM0VzNQMzFjSWhkeWloRHMxeG9zSmdD?=
 =?utf-8?Q?oEHeFtu8tdVgy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmlpTGw0SGdEdG1RTmIrWExpTW1NMHNMSms4RjZtQ0VScDlmbmtBaHlWQ3NF?=
 =?utf-8?B?KzNKK0hWTndSRGtCeTRRYUpzaWs2ekZvSTFlaTVPQ1E3TGQzbW00S3N4K3di?=
 =?utf-8?B?ZERWZUwrYWxkQXZPU29GK01SamlkMVBTa3Y3NG5PWW1xaFdjaU4xcjhoZlpJ?=
 =?utf-8?B?M015RHRyeGwxVEVTc0oybm9RL2YzTDR6RWZydTVxWnhGdmpNNWdzcUdkUWpL?=
 =?utf-8?B?aE82VGJwYmtuN3BWVUlTV1ZQUnFLMk81RTJOVThOcU5KNDBJNDFjY2NyR0hu?=
 =?utf-8?B?b3VBY2lFRjY0TnR5SFVWNGY5dTYrenFnVytCRmJqUHBUOWgwSyt5V042c0N1?=
 =?utf-8?B?OGp6MGdtdE5zV2krU3FnZ0tWQm1jQjBsdmwyUXBPS0NjS1pDamZzNzRvS3lD?=
 =?utf-8?B?ZE44QjFUeklIajBteFl0dTdueXhFa1Y0aGhmOWpwREZNcVIxVDBONzJqZnlK?=
 =?utf-8?B?bFN1bXNmS0NCZHpVdVRNRkdBZGl3U1R0bUI2YzFBTStKQXJIdXhkWWE5S0NH?=
 =?utf-8?B?OHFLSmkrS2JITHpka2xuOUVqZTNtTHc0VnV3TEN6MXcxQnVLM2lJSUd0Z1Uw?=
 =?utf-8?B?NXc0SnJuTzBVMTN3NlcvQ04vaTJzWTZLYzRCdFB5TmcyUjhQbStjaGFEMHpa?=
 =?utf-8?B?TmhVenVlTGNCQldCRXZvY1NUTEVZMTk3dWVuYTFTSUpYSFF1WXVoeHpJR3RV?=
 =?utf-8?B?N0czZk9kVHdEM3VtRGtPdzRjWWJHNEEyTkNhOWwzNUhOTFFBMHJ6ckwreFBs?=
 =?utf-8?B?TTVtTXdFQ1BPaXF2ZWlnQTVQYmdsNitKWk9rUnNTY2l1L1o1UU0wSzB2dlpl?=
 =?utf-8?B?NDQxNjJYaytiV0lUZTBYcXZnWlhzbytYV1BuZ1BvQStPcnhXQ1V3d1dlLzJw?=
 =?utf-8?B?Z3poMFR4M3hiM2xoQzBDc2NGb3J3QjRaVEh2bmIreWQwR0VSRnZ5K3RyWEhD?=
 =?utf-8?B?R0pxT3ZiRXdpL29UbHhRbGwzVDB2UTJVNWNvNk9BUVNsU3RnZWNGSHJ6OGNn?=
 =?utf-8?B?VVpmUUhObXRKS2NlZTl3N2QyUVJ1QzJ5NHFsRFFjaTFLb0JBOXkzZW1mUUpr?=
 =?utf-8?B?RHExajBtbFJCOCs5UklLYU9XZkRuTXJsbGhlaTVnYlUzMnMzek9lQVc2ZE1M?=
 =?utf-8?B?b0drZzNuV3NxUWVmZTlMc0FKVnh2L0NSSHArd0RVVHBjcFA3bDJ6V0pPNWJx?=
 =?utf-8?B?Y0g5c201RC9HeEtVNWVhOW1zZWRHSFQxMFBHTW5QYnpDSW1YQTFxekpJMXVq?=
 =?utf-8?B?ZFl5Wno0VThZbmM3SmlnQUp4YzEzUGFuZ2FTVEdiTGNTcUJ6d294eVRUemtI?=
 =?utf-8?B?M3ZGZVZPZjdCdmNYRGsvdGYwWE9uQVBWb2Y1QndpY2g2M3FkQTFYZC9ma0xT?=
 =?utf-8?B?OVF6eDYwUEFqdlVpK3dHWFBmU0ZIK2w0dWVneFhGV05aZU1tVG5XTEJNWW9w?=
 =?utf-8?B?d2t3L2E0SFdxcUZBVVlpK2QvUngvdTM1NEFrZ2NkZlRUTENtbEFzaWZabUtV?=
 =?utf-8?B?UVdTWlhMUnF0MjE3d00yVktZT3JMbXIzdzMwM3RiMFd0d1VEQ0VrOTZGdFUr?=
 =?utf-8?B?UFdqVWg3dXh5THFLSkJMNVBISkhyMDErd2tuY2UvYTFlZTg2NS9lcFVVV3p4?=
 =?utf-8?B?UVl5RkpEbURhV0lyK0hPVlcvK2N3TDkwMlhnWWZnR3JlQnArRytpYzJqWFlU?=
 =?utf-8?B?dTFpaE5jcktsK251RFcyRDF3V291R3o1SXhMKzVoQXptbGtaeUgvbDFHSkE5?=
 =?utf-8?B?ajZZaDZTVU9YeHVZd3Y4SS9EM1pTdGtRWWszRHRRTktJdGdONmdhN1hUY2Zx?=
 =?utf-8?B?aTlTNllHREtFTE1mdkhPRWRuM2RleE54MHJlMnZCQ0FIZGhrdGVvZWV2WnBH?=
 =?utf-8?B?aUQzMUttRG03NlJ3d0lMYmdPdUk2UzVFKzZhV28rVjhYdnQ2WnErVFdxZFdB?=
 =?utf-8?B?QjI4ZkREVm85Q0lmdC9iZ3g5bWNDbFRsMmRQcy9pcnM2cnFGcWVTK2ptaTVi?=
 =?utf-8?B?N0VBakIrZExralBJMEdoY3BCZFpFN1NxSkExcUxianVGbDVqeEw1dVFWdEFw?=
 =?utf-8?B?dXA3OXdYYlVBQVNVTmJaNGIreW5NWEV5Njc2TER2UkV3Q0ZFcnYrcVRmOExL?=
 =?utf-8?Q?J1DBHFp+dFyi8b9V6FFMlFMu9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb4afbc-cd9d-4bc5-0adc-08dd510e34b9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:52:41.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hPefGwhXr53+Q4myt+9ngS/NHXsQ2qIvINjVSZqC8DN8C01r6A+6lzFYbTtwY/i+pHOary4cP510dJ3MDfc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493


On 19/02/2025 15:36, Russell King (Oracle) wrote:
> On Wed, Feb 19, 2025 at 02:01:34PM +0000, Jon Hunter wrote:
>>
>> On 14/02/2025 11:21, Russell King (Oracle) wrote:
>>> On Fri, Feb 14, 2025 at 10:58:55AM +0000, Jon Hunter wrote:
>>>> Thanks for the feedback. So ...
>>>>
>>>> 1. I can confirm that suspend works if I disable EEE via ethtool
>>>> 2. Prior to this change I do see phy_eee_rx_clock_stop being called
>>>>      to enable the clock resuming from suspend, but after this change
>>>>      it is not.
>>>>
>>>> Prior to this change I see (note the prints around 389-392 are when
>>>> we resume from suspend) ...
>>>>
>>>> [    4.654454] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 0
>>>
>>> This is a bug in phylink - it shouldn't have been calling
>>> phy_eee_rx_clock_stop() where a MAC doesn't support phylink managed EEE.
>>>
>>>> [    4.723123] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>>>> [    7.629652] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
>>>
>>> Presumably, this is when the link comes up before suspend, so the PHY
>>> has been configured to allow the RX clock to be stopped prior to suspend
>>>
>>>> [  389.086185] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>>>> [  392.863744] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
>>>
>>> Presumably, as this is after resume, this is again when the link comes
>>> up (that's the only time that stmmac calls phy_eee_rx_clock_stop().)
>>>
>>>> After this change I see ...
>>>>
>>>> [    4.644614] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
>>>> [    4.679224] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>>>> [  191.219828] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>>>
>>> To me, this looks no different - the PHY was configured for clock stop
>>> before suspending in both cases.
>>>
>>> However, something else to verify with the old code - after boot and the
>>> link comes up (so you get the second phy_eee_rx_clock_stop() at 7s),
>>> try unplugging the link and re-plugging it. Then try suspending.
>>
>> I still need to try this but I am still not back to the office to get to this.
>>   > The point of this test is to verify whether the PHY ignores changes to
>>> the RX clock stop configuration while the link is up.
>>>
>>>
>>>
>>> The next stage is to instrument dwmac4_set_eee_mode(),
>>> dwmac4_reset_eee_mode() and dwmac4_set_eee_lpi_entry_timer() to print
>>> the final register values in each function vs dwmac4_set_lpi_mode() in
>>> the new code. Also, I think instrumenting stmmac_common_interrupt() to
>>> print a message when we get either CORE_IRQ_TX_PATH_IN_LPI_MODE or
>>> CORE_IRQ_TX_PATH_EXIT_LPI_MODE indicating a change in LPI state would
>>> be a good idea.
>>>
>>> I'd like to see how this all ties up with suspend, resume, link up
>>> and down events, so please don't trim the log so much.
>>
>> I have been testing on top of v6.14-rc2 which does not have
>> dwmac4_set_lpi_mode(). However, instrumenting the other functions,
>> for a bad case I see ...
>>
>> [  477.494226] PM: suspend entry (deep)
>> [  477.501869] Filesystems sync: 0.006 seconds
>> [  477.504518] Freezing user space processes
>> [  477.509067] Freezing user space processes completed (elapsed 0.001 seconds)
>> [  477.514770] OOM killer disabled.
>> [  477.517940] Freezing remaining freezable tasks
>> [  477.523449] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [  477.566870] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
>> [  477.586423] dwc-eth-dwmac 2490000.ethernet eth0: disable EEE
>> [  477.592052] dwmac4_set_eee_lpi_entry_timer: entered
>> [  477.596997] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0x0
>> [  477.680193] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
> 
> This tells me WoL is not enabled, and thus phylink_suspend() did a
> phylink_stop() which took the link administratively down and disabled
> LPI at the MAC. The actual physical link on the media may still be up
> at this point, and the remote end may still signal LPI to the local
> PHY.
> 
> ...system suspends and resumes...
>> [  477.876778] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
>> [  477.883556] CPU5 is up
> 
> stmmac_resume() gets called here, which will call into phylink_resume()
> and, because WoL wasn't used at suspend time, will call phylink_start()
> which immediately prints:
> 
>> [  477.985628] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> 
> and then it allows the phylink resolver to run in a separate workqueue.
> The output from the phylink resolver thread, I'll label as "^WQ".
> Messages from the thread that called stmmac_resume() I'll labell with
> "^RES".
> 
>> [  477.993771] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_enable_tx_lpi: tx_lpi_timer 1000000
> 	^WQ
> 
> At this point, the workqueue has called mac_link_up() and this indicates
> that that method has completed and it's now calling mac_enable_tx_lpi().
> In other words, the transmitter and receiver have been enabled here!
> This is key...
> 
>> [  478.171396] dwmac4: Master AXI performs any burst length
> 	^RES
> 
> dwmac4_dma_axi(), which is called from stmmac_init_dma_engine() which
> then goes on to call stmmac_reset(). As noted above, however, the
> MAC has had its transmitter and receiver enabled at this point, so
> hitting the hardware with a reset probably undoes all that.
> stmmac_init_dma_engine() is called from stmmac_hw_setup() and
> stmmac_resume() _after_ calling phylink_resume().
> 
>> [  478.174480] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
> 	^RES
> 
> Printed by stmmac_safety_feat_configuration() which is called from
> stmmac_hw_setup().
> 
>> [  478.181934] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
> 	^RES
> 
> Printed by stmmac_init_ptp() called from stmmac_hw_setup().
> 
>> [  478.202977] dwmac4_set_eee_lpi_entry_timer: entered
> 	^WQ
>> [  478.207918] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0xf4240
> 	^WQ
>> [  478.287646] dwc-eth-dwmac 2490000.ethernet eth0: Energy-Efficient Ethernet initialized
> 	^WQ
>> [  478.295538] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> 	^WQ
> 
> So clearly the phylink resolver is racing with the rest of the stmmac
> resume path - which doesn't surprise me in the least. I believe I raised
> the fact that calling phylink_resume() before the hardware was ready to
> handle link-up is a bad idea precisely because of races like this.
> 
> The reason stmmac does this is because of it's quirk that it needs the
> receive clock from the PHY in order for stmmac_reset() to work.


I do see the reset fail infrequently on previous kernels with this 
device and when it does I see these messages ...

  dwc-eth-dwmac 2490000.ethernet: Failed to reset the dma
  dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: DMA engine
   initialization failed

>> For a good case I see ...
>>
>> [   28.548472] PM: suspend entry (deep)
>> [   28.560503] Filesystems sync: 0.010 seconds
>> [   28.563622] Freezing user space processes
>> [   28.567838] Freezing user space processes completed (elapsed 0.001 seconds)
>> [   28.573380] OOM killer disabled.
>> [   28.576563] Freezing remaining freezable tasks
>> [   28.582100] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [   28.627180] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
>> [   28.646770] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
> 
> Same as above...
> 
> ...system suspends and resumes...
>> [   29.099556] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
>> [   29.106351] CPU5 is up
>> [   29.218549] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> 	^RES
>> [   29.234190] dwmac4: Master AXI performs any burst length
> 	^RES
>> [   29.237263] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
> 	^RES
>> [   29.244732] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
> 	^RES
>> [   29.306981] Restarting tasks ... done.
>> [   29.311423] VDDIO_SDMMC3_AP: voltage operation not allowed
>> [   29.314095] random: crng reseeded on system resumption
>> [   29.321404] PM: suspend exit
>> [   29.370286] VDDIO_SDMMC3_AP: voltage operation not allowed
>> [   29.429655] VDDIO_SDMMC3_AP: voltage operation not allowed
>> [   29.496567] VDDIO_SDMMC3_AP: voltage operation not allowed
>> [   32.968855] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> 	^WQ
>> [   32.974779] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_link_up: tx_lpi_timer 1000000
> 	^WQ
>> [   32.988755] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> 	^WQ
> 
> So here, phylink_resolve() runs later.
> 
> I think if you run this same test with an earlier kernel, you'll get
> much the same random behaviour, maybe with different weightings on
> "success" and "failure" because of course the code has changed - but
> only because that's caused a change in timings of the already present
> race.
> 
>> The more I have been testing, the more I feel that this is timing
>> related. In good cases, I see the MAC link coming up well after the
>> PHY. Even with your change I did see suspend work on occassion and
>> when it does I see ...
>>
>> [   79.775977] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>> [   79.784196] dwmac4: Master AXI performs any burst length
>> [   79.787280] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
>> [   79.794736] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
>> [   79.816642] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector: repeated role: device
>> [   79.820437] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
>> [   79.854481] OOM killer enabled.
>> [   79.855372] Restarting tasks ... done.
>> [   79.859460] VDDIO_SDMMC3_AP: voltage operation not allowed
>> [   79.861297] random: crng reseeded on system resumption
>> [   79.869773] PM: suspend exit
>> [   79.914909] VDDIO_SDMMC3_AP: voltage operation not allowed
>> [   79.974322] VDDIO_SDMMC3_AP: voltage operation not allowed
>> [   80.041236] VDDIO_SDMMC3_AP: voltage operation not allowed
>> [   83.547730] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_enable_tx_lpi: tx_lpi_timer 1000000
>> [   83.566859] dwmac4_set_eee_lpi_entry_timer: entered
>> [   83.571782] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0xf4240
>> [   83.651520] dwc-eth-dwmac 2490000.ethernet eth0: Energy-Efficient Ethernet initialized
>> [   83.659425] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
>>
>> On a good case, the stmmac_mac_enable_tx_lpi call always happens
>> much later. It seems that after this change it is more often
>> that the link is coming up sooner and I guess probably too soon.
>> May be we were getting lucky before?
> 
> I think this is pure lottery.

Yes it does appear to be.

>> Anyway, I made the following change for testing and this is
>> working ...
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index b34ebb916b89..44187e230a1e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -7906,16 +7906,6 @@ int stmmac_resume(struct device *dev)
>>                          return ret;
>>          }
>> -       rtnl_lock();
>> -       if (device_may_wakeup(priv->device) && priv->plat->pmt) {
>> -               phylink_resume(priv->phylink);
>> -       } else {
>> -               phylink_resume(priv->phylink);
>> -               if (device_may_wakeup(priv->device))
>> -                       phylink_speed_up(priv->phylink);
>> -       }
>> -       rtnl_unlock();
>> -
>>          rtnl_lock();
>>          mutex_lock(&priv->lock);
>> @@ -7930,6 +7920,13 @@ int stmmac_resume(struct device *dev)
>>          stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
>> +       if (device_may_wakeup(priv->device) && priv->plat->pmt) {
>> +               phylink_resume(priv->phylink);
>> +       } else {
>> +               phylink_resume(priv->phylink);
>> +               if (device_may_wakeup(priv->device))
>> +                       phylink_speed_up(priv->phylink);
>> +       }
>>          stmmac_enable_all_queues(priv);
>>          stmmac_enable_all_dma_irq(priv);
>>
>> I noticed that in __stmmac_open() the phylink_start() is
>> called after stmmac_hw_setup and stmmac_init_coalesce, where
>> as in stmmac_resume, phylink_resume() is called before these.
>> I am not saying that this is correct in any way, but seems
>> to indicate that the PHY is coming up too soon (at least for
>> this device). I have ran 100 suspend iterations with the above
>> and I have not seen any failures.
>>
>> Let me know if you have any thoughts on this.
> 
> With my phylink-maintainer hat on, this is definitely the correct
> solution - maybe even moving the phylink_resume() call later.
> phylink_resume() should only be called when the driver is prepared
> to handle and cope with an immediate call to the mac_link_up()
> method, and it's clear that its current placement is such that the
> driver isn't prepared for that.
> 
> However... see:
> 
> 36d18b5664ef ("net: stmmac: start phylink instance before stmmac_hw_setup()")
> 
> but I also questioned this in:
> 
> https://lore.kernel.org/netdev/20210903080147.GS22278@shell.armlinux.org.uk/
> 
> see the bottom of that email starting "While reading stmmac_resume(), I
> have to question the placement of this code block:". The response was:
> 
> "There is a story here, SNPS EQOS IP need PHY provides RXC clock for
> MAC's receive logic, so we need phylink_start() to bring PHY link up,
> that make PHY resume back, PHY could stop RXC clock when in suspended
> state. This is the reason why calling phylink_start() before re-config
> MAC."
> 
> However, in 21d9ba5bc551 ("net: phylink: add PHY_F_RXC_ALWAYS_ON to PHY
> dev flags") and associated patches, I added a way that phylib can be
> told that the MAC requires the RXC at all times.
> 
> Romain Gantois arranged for this flag to always be set for stmmac in
> commit 58329b03a595 ("net: stmmac: Signal to PHY/PCS drivers to keep RX
> clock on"), which will pass PHY_F_RXC_ALWAYS_ON to the PHY driver.
> Whether the PHY driver honours this flag or not depends on which
> driver is used.
> 
> So, my preference would be to move phylink_resume() later, removing
> the race condition. If there's any regressions, then we need to
> _properly_ solve them by ensuring that the PHY keeps the RX clock
> running by honouring PHY_F_RXC_ALWAYS_ON. That's going to need
> everyone to test their stmmac platforms to find all the cases that
> need fixing...


Thanks for the in-depth analysis and feedback. We have 3 SoCs that use 
this driver and so I will do some testing with this change on all of them.

Thanks again.
Jon

-- 
nvpublic


