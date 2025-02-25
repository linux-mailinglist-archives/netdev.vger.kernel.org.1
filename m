Return-Path: <netdev+bounces-169331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97ADA437D8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E85171CF7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF3254858;
	Tue, 25 Feb 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="kCI9JpUc"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022138.outbound.protection.outlook.com [52.101.66.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224FB16DEA9
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472960; cv=fail; b=qZp6L5GB7iYSOO7K514tsW+OepYDjYEa6SqIjQezmTDMBsP7tIRRIqowf3bZOoyhMYAiUKn52KMTxVddhqtW6zUpijDXrQr6KmcNl82ALVh/lpwkz2PzMmeWEPPrOG2zerv+zBChApphQV3SNT3W6FrbUGu0b5FuepMc3Zlc5og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472960; c=relaxed/simple;
	bh=uWGUBM3Mdfr6EbNjLx4A/nzQHFSzZ4Sl7M/bD+Ecz8I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gWTsbcbT4SopYgR2lICsnIx3OCOvLas9ZbviMwiF0i+Az/cyiSCMLDJ/L6PV0Nqi2uCD6JwRJkjPHjj1Ue80CCm8dZwHveI8WmX+WUA14nAl/IxYHHm2MBwmW12ZJnVWArihoww95s8VrqOpfx8k2u2E0aPkBUR/8GPg2hYenuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=kCI9JpUc; arc=fail smtp.client-ip=52.101.66.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylngyAOXRuauq++rp/KTed52bQVC8/pnWij4NUxR7Jwsgo8+HdkPTmiZQETkl4V5lrKz6Xo85MZQ2h2ZWPNzU27pi5w6bb/Ks8HewLEw+ad/+cD1RNoX5+8U4gw+KbOgKgJ4PNhVq1dYf7nwHd0hquwp0RFyGHiXxe5yH/EDRVKO6JOExIN7ukHrcrluAbRYrbIDWBQ7u2SlBoMVG29idZj+W9CGXV5BUdteiX3lyc6jC71HWBphprkJSigs56k7l5bKAebZdawU1hPlRduJxaOWECoILemB5jYEGOfbmNNh36z82UErznyO4f8h8BtRL1s/+xDeRHapq6nQp/UV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK9Jd4fu6SQe3puaDax/fpPc9/rj6cf5Ucapmgc29os=;
 b=DsUbr/2quVfmtBRB+NF4BGiNqyN2Ephm33awxCfQH7xXwn44dZ4B/Xj5hLQVDky21p0DekRYfGB7uvPCHj0q9CACZ3tVUPcgW8zDG8COg8hcFTFWeXQS/IsJi8qfByAT0OMoGM1i6WdU6/RxLgylYYkmrD4BUHxWx0oYesD45PPsSwrFZRrIaIjivAo0Dyrl/uo67EYDEQ+lXSOsB45rRUX1DfDGm32z6TRBsxy3UCBolCHEFhnj2jjzhgEXfGsjPhkH0M6/+d/stYQyKGal5z9f5/V7go8OK2Bqeim5vxnNYX3jB2CiRaioRLtyIuVWekDVH9dsp2zRlKsz83MvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK9Jd4fu6SQe3puaDax/fpPc9/rj6cf5Ucapmgc29os=;
 b=kCI9JpUcAZdRmoN3i+ica8uCss/Z70rUAr4uDrb8dI0yc+KtVx/EdkvzNn2J5bxDZ/vV3mloxqb76flNSaC0tfz1Cyuj3N0sVjXBgX6W53s9uri+PQCUK0N0SiN3TRUfkNgKGQC3GGrSHUYoXQxDCG6dxp1I1HICuUcXGi2hMiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB9085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 08:42:35 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 08:42:35 +0000
Message-ID: <79ade357-0a6b-44e9-9a27-6722a11842f3@kontron.de>
Date: Tue, 25 Feb 2025 09:42:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: DT options for DSA user port with internal PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d1243bdc-3c88-4e15-b955-309d1917a599@kontron.de>
 <8eb8885f-2307-4ad4-9302-8423ba4db67d@lunn.ch>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <8eb8885f-2307-4ad4-9302-8423ba4db67d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0026dd-8a02-42b1-0d58-08dd55785a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEJwVmcvbEtnei82NkZ4b1dmYTZleFUxNDJobHRNUDcrWk0wQlBRTFNpZ3Fz?=
 =?utf-8?B?eGJWb0dQOWFMeWtsMVppR1lJVFRhUERsTGVXamhPTFh5TGtlNzhjMVgvQ0hy?=
 =?utf-8?B?Q3NPa3dmdDdYbmRzdVgzYTArZmZIelhMNnFTV2h2UVlDUjBISzM4WjAzQ1o1?=
 =?utf-8?B?VFl3US9NbUNNZE83ZjhwcWppVnlYdWlaR0lncXJqVnFacE9LY3Y4OUVKd1N2?=
 =?utf-8?B?SFVmVjhGYWx0SUxKdnphbHFpdEsyT0Y3Q1EyTWlmRU9ldDN6QXlzVjNIS29w?=
 =?utf-8?B?dUFZNHd3aVZsOWlRSENpYlhCSkxmTnErd2FmbklmdmVlM2R2bkNBKzNVTTlG?=
 =?utf-8?B?M2E4UXVBOHoybUxjR2d1bytmZzMvSzVEZnVJTTJaakFWWnk5NU8vSjU0TnpO?=
 =?utf-8?B?b0hZMDJucGFoa25MVlJGVGlaM1BLZWUxem5rR21nNVdpUGg2UEw1UWdnUXcx?=
 =?utf-8?B?WWpPNHBJQ3BtWmowd3IySWs5cXZsYVZKdzN1WXU0TkFMbkRFSkRvSHdERWxF?=
 =?utf-8?B?UEdsQU1USjlFTHhKdVFmZm5FTU9Ia0Z6QStBeFArL29rM3IrVEJUUjJSZDFs?=
 =?utf-8?B?QkViNk0vNmR4em8zbStsbXV5ek9hOTBEdjR3K1ozZmVRUE4rZXBsd0dpd3NV?=
 =?utf-8?B?VjJaR0RQTzBOSXhlN29ERGo4Sm9wLzMrOE8raG41eXgrT1J3ZFkwUXhFd0dW?=
 =?utf-8?B?ZitkNjVpM0J2WmRqR0VXUW5qTkdyU25GNXNUeTBzdmF2bkdYc0h6bWpQUS9L?=
 =?utf-8?B?Z0xsL0JOd1JMNVZOc0lzUjIzdTNjWFUxYUNuODFwWldlU1NpZ3MzZUY2My9V?=
 =?utf-8?B?a3BicDFPSW1aOW9ZNFZEVHdweGxmZGtsOThLUWQ0NUhkSDM5UTZxMWpKSVJw?=
 =?utf-8?B?Q3Jrc0tIVFhEVi8ySlhpaXBWQ0lzbUlHVzFpN0k0NFVZR0tBR1Azb3ZRRXRu?=
 =?utf-8?B?RURTQituTWZMcVpYRFFwL1c2bXNDOVA5WEJselFvVEY5T0RVazJTbytYWlNF?=
 =?utf-8?B?aWlxR1pYOUc1MUtvQkExTlJNaEs3NStZZnBqUE9pQkxUWGthMTVoUjgvZnlS?=
 =?utf-8?B?MCtLRzRreENGOVoxcm5ocDh4a09IaDF2RzhrN3A0cmZQcmdZRU1xaTNaMkpL?=
 =?utf-8?B?UW1ZOElxRVkrSFBSU0V2MmkwOHZZNXZBN0c2Tm5sM1JRQnRsYmFqUStEVGI1?=
 =?utf-8?B?bW5MWkFBU1VnTUpBbHZWNnc3THZlRU9KRUdqb3RYREw5VlM2Z2FXZElCcldL?=
 =?utf-8?B?bVV6WlRVQWlFemMzREJUVUV2UzZhNElFRE5MeDRJNmlCcVNaRk9RbkRQeHh1?=
 =?utf-8?B?T3JtNDNrNklqZGVVVXJXblVWRXhRU0IxVXNaZzc0U0MydjhKWDV4ZEZ0QjM0?=
 =?utf-8?B?YlFNRlk5TWZpdFRWNmUrKzNvRk1IQ3lvZ2ptd1VVSFlkQmtJK2oxN1ZaUUdm?=
 =?utf-8?B?R3htdmR2aDNPd3d5R1BBTEdXM1NOYzZKWEQvNDVDNkpCMWxHdXdWdXhUaXF0?=
 =?utf-8?B?akFkbzBFbmFIcUpTWmlPQXlCWS9YMkZvZnRKeGFXckYxRDljckNCOHBaUi9M?=
 =?utf-8?B?UWFGQ3hyL1VXbm5hWFZxbjIwV2JRdTBoUTVnRXl5U1paeTQvUHlPak9QNUho?=
 =?utf-8?B?ZW9xVjF2Rld4MEZTaWpoaEZjNVprNzZtU1hHWm16UWNUd1BFSlNjdG5odVZF?=
 =?utf-8?B?ZHQxY2d2c0tBcHRlYzRMc2FSRnNSUWg5cWhxL2lpYUVISzhjZUh5cHNpNjZa?=
 =?utf-8?B?WFhtSEd4a3RUWHRtN05nQUpOd29zUmRVVDRSV3RrRExYbGgyNXU5YitlUy9l?=
 =?utf-8?B?dEVjM0NWSCt5Q20zRmxqRlFKNFRUZkU5RmZBVmsxdkdsNjlrc3dRdzVaRU5G?=
 =?utf-8?Q?nXDSYQthmJOLs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlFkNTA0K3RiYUtra0Z2ejIvRm9nUnRJVW52Y1p3Y2lDWlc5RGJ6MThLNkE5?=
 =?utf-8?B?bjhuRTBLT3ZWcXdMQXVxMDE5aVhwWXBHU1BQbHh2M0d0ZHk0cDRFRFEveURV?=
 =?utf-8?B?b3VrZlkxaW5VeHRVNzdKOGhxZzg5eVZ6a3VEenFvZkgzUEw2RHhWQlNXT0Jz?=
 =?utf-8?B?dnRobDd3T3pyUWpydU5vcXo3TUNPWkdpeUtrcFFiMjl3bDVCVk0rbmNqRW1K?=
 =?utf-8?B?MlNUVlF4eEh4N2ZDYjUwUU83OFdQVys0a05HdWpPQjZxMitiWWdiTTlDNkZF?=
 =?utf-8?B?YlBZcjJPZUJQRzM3anVYaDhnRm1xalpaWnZqelgvenRmQkhzY05hMllUSy9I?=
 =?utf-8?B?N0JiL1FkTmowc0VaK0VJU01uY3Q3Z1F0QkhrajcvaDdvVWJLeGVsN2Q0bXo5?=
 =?utf-8?B?eFVZc0U4S3RoQ28wdFhQb2hSSjBWWnZmTjR1Z0FmcFRSZGVZMWovaEhPMzdS?=
 =?utf-8?B?N0l6SS9MMWpyTDU1ZE5lVXViTU5MN1l3Vk9SMThlVUhaTUszVFB4OXpwd05k?=
 =?utf-8?B?a3c0M0lubjdlZlY3WFZuclJScDdaRnV4eGU4dG1LRnp1ckNDRE5HM1NnOGtS?=
 =?utf-8?B?YUZBMWZSR3lYNnlEVFlFK2dmSkdPQVM2MlJrWWNVY0hHNTJ3b2ZwVjFGb2lv?=
 =?utf-8?B?eUdUalM5eGpIdHFadWRnQ0J2anpEelZQNFhGUTlKVkdTbjU4eUhKQXhVamMr?=
 =?utf-8?B?eENCT3EzaEZydUdaKytLdGYzcmJNN3ZxTm1RQUwxOFVkQXN1N0V1RXZEaEkx?=
 =?utf-8?B?NkpjOEhzRERaeC9Rd1QzRUFUZVpMNkNkNXhwMm5rOHQyWThjTjJwQWtKajh3?=
 =?utf-8?B?cU5JOHV2NXBad2t4SmlqT1lmWWZzdzdTcXd4Ky9IUXp6MStycmovZURzY0ZM?=
 =?utf-8?B?Y05zOWdFcjJpMWU3eU4ybDVtUlQ4Z25ScHJFa1Nsd0JkOURkdm5qWEZGNU5U?=
 =?utf-8?B?bnJITWhNQ29UZVoxOUY0dWlFQUNrUUEzRnA4aSsxdGhQVFdLZ2lJNUlrbEZ2?=
 =?utf-8?B?N3hZVlVHOWp3USs1NXRrTlg0S2tGMjhZSThhWmR6a1N4bzJaelZMKzZudlcv?=
 =?utf-8?B?SGxGN1VkNVBlTU9KUUpIZWhiektiM0VtcHFZKy9UYjQ2cTFOMmFwRFArWDBs?=
 =?utf-8?B?QXNSRnlRT01wM2hjSVpwYWlPTHlVMnVLait3VFZodm5IekNkOVhPdXZLMzls?=
 =?utf-8?B?cUs5c1lwNXA1RmVpQzA0QWJhNnM0K0JUZ1ZZNjl6ZGkwek0vUlhnU2JLSjBQ?=
 =?utf-8?B?ODBnanU3L1ZYRWVjbjJlM3BzdFFzNWRpaGt4SCtNQ0RqZUlUbytUamQ2TlVI?=
 =?utf-8?B?NWI2QUVlWVpwNXljOExOc0JKWjdQbXdwd29DdlZFQkR4MWV4YVF0ZDYzUUhk?=
 =?utf-8?B?L0hVaEFnWGtDMHpNNXlxTFgwbk1obk9ZZ0lsVXJaR2pIenZHYXYxdEVGTDlk?=
 =?utf-8?B?MnFPWFc4bHREc3lGcVRWTXZ1Yk1FaVJpL1A3TTB2UHV4NWM5cVgzSmUxRWxI?=
 =?utf-8?B?alJJVkV6RzlvMEJTRDgzajFQQlJsK2RGTVQzOERkOGRlVnIxNllzeUtOSWdN?=
 =?utf-8?B?WE1SMXRwQTIxTzFKallLU3ZiVC96VDRqR21PcWdPMGk3MG9OTmxSM1JaZjVV?=
 =?utf-8?B?U0huaVk2QVF2bEdwMjI3cWlhVE1ZYkNvOTdodC9sbnpXUlJ1Qit0UUhWN3pG?=
 =?utf-8?B?YkJYelh5ZXlWL0RaemxGYXpSOGZlYk5YSmI3b3FKekNhT2lzbjh5Y0pIaW9o?=
 =?utf-8?B?dVE4SGhud1NSTVdpL3pDbmJmdnRLV05yb0YvaEVUT1dlTkFYSVpHWnRHUDdm?=
 =?utf-8?B?R1pGdTRmZEhacHFlcmlESjRtTzlxdkdzQ2xVOWt5ajFKd25VODNmS25GdFhq?=
 =?utf-8?B?L0IreWkrellHbWQ2TmgzZzVFMmFlVG4wbEpZbDI3UHVDMitiVlZPaWFlODQx?=
 =?utf-8?B?NUEraTJ1TFZYMnhma0M4UTZzTHUxcmlWem1oN1FFcXFVcnB6cXFSdTAzVlBJ?=
 =?utf-8?B?bHNORllDRXlIOU1rczZzQi93Y0V6TFRVajRzQ29ISGxEMGpXeGNWTFpGNmdC?=
 =?utf-8?B?MFB1SXVJK20vTG4vMWYwMkZ3NktCdXFZcDlWMW51VWgwbVluKzdVRjFydXI2?=
 =?utf-8?B?UkZaRU5FVjBDdTNoaU1kL014bHFKYkV2OW5tZTVUejFQb3hHSGZYWGJqeWFR?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0026dd-8a02-42b1-0d58-08dd55785a0a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:42:35.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+ivDh1TOlqcWX1lI1YV7P71HQXjjlPfLLp7+XUyzh5MVgwebnOw0cIep5mH6IWoE7Va3SNbHmfa9wfEbYmqbHEWK8ccz68tSm8nAjvRbiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9085

On 04.02.25 2:13 PM, Andrew Lunn wrote:
> On Tue, Feb 04, 2025 at 09:30:23AM +0100, Frieder Schrempf wrote:
>> Hi,
>>
>> I'm using a KSZ9477 and I'm configuring the DSA user ports in the
>> devicetree.
>>
>> Due to the hardware implementation I need to use some options that
>> currently seem to be unsupported by the driver.
>>
>> First the user ports are physically limited to a maximum speed of
>> 100MBit/s. As the MAC and the PHYs are capable of 1G, this also what
>> gets advertised during autoneg.
>>
>> Second the LEDs controlled by the PHY need to be handled in "Single
>> Mode" instead of "Dual Mode".
>>
>> Usually on an external PHY that gets probed separately, I could use
>> "max-speed" and "micrel,led-mode" to achieve this.
>>
>> But for the KSZ9477 the PHYs are not probed but instead hooked into the
>> switch driver and from the PHY driver I don't seem to have any way to
>> access the DT node for the DSA user port.
>>
>> What would be the proper way to implement this? Any ideas?
> 
> The normal way to do this is add an mdio node, and use phy-handle in
> the ports to point to the PHY on the MDIO bus. The PHY are then probed
> in the usual ways, and you can have DT properties.

I see. That makes sense and it works just fine. Thanks!

