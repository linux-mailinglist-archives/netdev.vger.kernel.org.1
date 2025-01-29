Return-Path: <netdev+bounces-161477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60413A21C60
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A421885860
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B6E1ABEC1;
	Wed, 29 Jan 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="lXMn0ZG7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2129.outbound.protection.outlook.com [40.107.22.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8819597F
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150539; cv=fail; b=KY5MWMzNOJWpBoj10eBInurOj9fNThnb08BDvdP7Oaot88GXh9DRA9UAIAeh6rGEobaGujNQUSamskAGJe9es1SlPORegbeSCg0CXY5tcvAvlqZG8noXrBxJBaZXsjvEFw+mMI1CFsJNrbF6z8jCtZbAtifTiSVqYZX0qkGaNHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150539; c=relaxed/simple;
	bh=PdwAgfaaCwxkeHD+PaKO3ObfzKg08vIz3XV0t+bv3lY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YZuGEW8AkhKYMzDAgI9wHQW7292L5PShDgbCmGTSeSVbgYH99oGtfEhR3098fNPHCi2gsT2Ti3D20g7+rsv0oUeFd/flc7VxCmdsR4JDgKUTyNdeV8FA06h7Ui+xWTFKiyyDUXLdaORA50FSPKbVl70bsbz6X0L6gmcofJzfuKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=lXMn0ZG7; arc=fail smtp.client-ip=40.107.22.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwhdp5bjrvsP18qLFegrPrOSQgrk24V/uCnSZ9nTBkrtBJ6sIBAxK32XIBW1JoCw9sTFG6gWiY7ruemixLfjsds+uW44BEW5oroe1fOZqwcXe+kAzn3bhFUUF28TR5XLDgvkpicAD6bRvwAydrlqm94CBIBM0XLO3wPmzV94ztry9ay4IsQWUO52a2vEASH2OlKjtMEk1hUlLsroWEdO16pl1Y5qR+EcHUNM74RaTnm9ZTH9J8dynby8JxVG3JpT91pOlbh+5N3l3qaFBIjP6yWMO+IVx4DaM2OrDilTix38oaXlaNuNfVNQVVdyOgpFDeweD/Zjw9r6TMfYaeFkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VQL4HeRC91QqSjGaLDHvzFHCJ3/nrPrynIfUtuzmoo=;
 b=vaR2VgZhzo1A9lkJFCikhwnGUuW7MmqmGJPJ3AspCxxuedueMRH06+22MLLnD7NSnubLIb58BkZT3jQfJBaq/mJmkoB2jS5bpJo4IMi1NS3LB0hlNYnP4XZGg9j8pNHrh3Mf2ZhsPLfg8uRbFcFAHQUkBuMc0mraFmtXrGX5kJR0i0OGk2OsA2E2TkrT2LBIo/5y+NiwYIZ/NZ4mfsz0JFoYW9Xk5cxiDWQP8mk1MhIYWl9K2zm9/S0wggwFUxzRilQV5tjfC5CORxwRqHAfAAEmg3e3q3VZeTmCDcoH26RjXXXeqc2aUCuWAvW663LH9QhWJmlvNsoyMZQJkICBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VQL4HeRC91QqSjGaLDHvzFHCJ3/nrPrynIfUtuzmoo=;
 b=lXMn0ZG7SXpYgs4ndVtKh3MNwZyZGjOS8xu57BUA1Uk3HbPv+ux54KBhhMyhUhyJqv9YWPsTCepZHM1sOg2Kgc7R7MaW6Qg6lWD11kXkyA+jAKObHnR8mhKPshcZlkJk+a8Y4lp1XEjvgW7M9RgmzFJ9ljjK8c1GoLR81HcL/pM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::14)
 by GV1PR10MB6292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.13; Wed, 29 Jan
 2025 11:35:31 +0000
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95c1:ff1e:275d:26aa]) by AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95c1:ff1e:275d:26aa%4]) with mapi id 15.20.8398.013; Wed, 29 Jan 2025
 11:35:31 +0000
Message-ID: <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
Date: Wed, 29 Jan 2025 12:35:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250129121733.1e99f29c@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4f2::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB5671:EE_|GV1PR10MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba466d4-6540-4473-d02b-08dd40590972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFN4NHU1ZUkxM2c1MlV5K20yeG9CbFdEYVJid0ZzNFljY1d5UlZ3a1lpVDBy?=
 =?utf-8?B?RjF2T28wL25BdnpIZlJ4cHlYdUo2enNQMnBsTG5rSzRxUWZTRWpBeFIyRHgy?=
 =?utf-8?B?MGgrMXJwY3NBNVRCcWRiNytPaGcwemprSEVjU2t3U1hOVjNycXlBSzNVYnVV?=
 =?utf-8?B?ZTFZZ21LZXJ4Q1hJZGQzeUdCZW1aVUJ4SENFMjJ4cjk1Zy9qRUVtd3RCVnpO?=
 =?utf-8?B?VGEzY04wazVuYWZFdlhGZHB6ekNNRVRNM3JmeDA4SU1raFcvQTZqSVpzK0pJ?=
 =?utf-8?B?MCtmaHFKQm5hYi84N2xvckZKeWtnK3JwbmxIaUVxRWpSeHVibFpqd1pkZUla?=
 =?utf-8?B?bmtKVEo1UU1JYS9tSWtLZXhCRVY4UGZHL1dxQi9iVEEzM2VnQ2RqSGx0UEk5?=
 =?utf-8?B?dGpyb3I2amhOY08zQU1vZloxSVlhY3duSzZNa3JQZEdGbWpPR3pRaHJWaGU0?=
 =?utf-8?B?UTFOM2xLMklFVDBiSUl4UDN2WmpYZ21DNTlHQkpHR1IzRUl0WTBtaFZscTZT?=
 =?utf-8?B?dXNvTmFBaTU4U0hCendnTUUxQ05xQ3M2OXZvb1l0Z1pZYlZNaVZXVGc0TXc2?=
 =?utf-8?B?c0xleFVrcjUybmpEcmFtS2UvbnJUZGhuSyt3cGdWSC9VcEUrYlhYZkRYU1Ja?=
 =?utf-8?B?R0NvUnVzQ2l5WkliSzA5VWhVN0VtV0VPa1NoYkhWbmJSbGpXL0pEdk9ZY0Jp?=
 =?utf-8?B?SVQ5TEIzZ1VlbERlSy8wWEZzM2VaUnhYL3lqdUhyWXo1WVRFSEVMTW0wU1hV?=
 =?utf-8?B?L1NQWkFaWTBWRlc4aWNpRmQyeXhnenJNWWlMR1VaQ1ZCcU1uZzl3Qjg5M0Y0?=
 =?utf-8?B?VDJjekZEeFZJdDJDT1d5SnozNHZsbWt1emNYSGJUZGJlODRlS1J3Tnl3cXJs?=
 =?utf-8?B?Y2hzNUFiMFJ3amhPM2VpNEpob0FkTlNTZVJYL0pjNkRmY0JTWEFVd3p2L3Zh?=
 =?utf-8?B?WFVCMkhybUxqWDJCV1l3cnpua3R2REpMRUwrelhqK25WTkErdldqUXR4UWxy?=
 =?utf-8?B?OFJSOURTaXJWL1VseGZaekRyUnpZNkZsOXZ3N2lYcDdYeTdIZGlhTk9VM3NQ?=
 =?utf-8?B?cmZ5THZZNjhKczk0eVpOSURJaUtBK3dVbEk2Vng3clJmbUdOWHdlQVJXVkd5?=
 =?utf-8?B?ZlVyZHZMUU5nZzl2bXhMSVNyNWlIUzR0T3NUNkhSYkU2RzhxbEkzV25tM3Jy?=
 =?utf-8?B?NnZEOU43Umh1aktya3Y3aTJpS3A4L083aWFSOGFVcDRuNGNDR0VtY245ZWlu?=
 =?utf-8?B?UGptV3dhbEM0QlgvK1NMQ0h3SHZQd1FsMEpKRk9Pd3BWUUdXM2FXRkhlaEN5?=
 =?utf-8?B?dS8wSXNld2RrOTE2RUN0ZGNuQStkRkhtdkJIWEl1c1NydktMdGszTlVmNFBp?=
 =?utf-8?B?MmJTVEVRTjJDODVSUFlLZkh3SEJyem1XTmM2ZDZ6Y3ZlOWFjbG95KzAveHJQ?=
 =?utf-8?B?aUw0MFpEdTN3RjQxL1VuY0hMSjBlenhVd1daUFRiQXQxcnZoYmZHOU5FVXRq?=
 =?utf-8?B?ZERHWUw0eDNZMmlyT1Fjbk5CV0VvTXFtbyszeEh5dGJlZEdHRk1Nd3ZlUnAw?=
 =?utf-8?B?UkI5dTY1RFgxWVdUalk1QWsvREtBYUdpVDRkUFg1NGEwUUJHUHV1a3Z4aDlL?=
 =?utf-8?B?MjRHajE4Mm05aHBydTlWYlloaVVUSG5YaWJxdmRWcW82Wmh0aTVWQVZGQ1Vp?=
 =?utf-8?B?c0JzU0wrci9jSjdKTEp1cFZFYW5yZm9LY3dNOTh3cWZPSmlTVUVYZmt2SFFP?=
 =?utf-8?Q?4sKCFGne57nBKK5hshlkmhkYBL1imMCRNIP+Xml?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzFHa2FmUGNQN25qSmlyVXVDZVV5ZHNBLzlheWIzemVnOXBTUnBaTHhKRmd4?=
 =?utf-8?B?c0NEZUtZZmRGMStHT3puTkV4U002N2dONmQrcTJNSnNGOHFSdjVBZ3BWcG9p?=
 =?utf-8?B?eExiL0FHcGtBRHVpdkNsdUZ5WDFaczF3V1AvYUNKNW0yQ1liYTJJcDNEZWxv?=
 =?utf-8?B?bkJ3ektDRnhrUVNPSDdNL1lMNjN1bUdURmVqTnFOV1JuZzcyWVZzbDIwYlFm?=
 =?utf-8?B?ZmZtSW0wWmlKaDhiR0F1bDFEVmZxNFJkSDYxK3djMXZkdFFMb3BINEpnZDJ4?=
 =?utf-8?B?cU1udjlZeVNtVVNkR1hHMHRDaDZhaU1rRk5SaEYxa1pLQ3JtZ0dqS241UWlq?=
 =?utf-8?B?VnExRThnaFhQN3N6ZEhvRCtiYm5qNUwwNjM0L2VLSThWcjc2aVFsK05PWGFv?=
 =?utf-8?B?emFxQ09HZXEzSE03djFWZmZncFdZYUpuazhadkZTcXdkNzJDUE12dUIwYzBN?=
 =?utf-8?B?Umhkb1czWDVFeUptb2cvNFlUK3UzVlUzbFFmUlM5TUdabGt2eTlLN0NzSEww?=
 =?utf-8?B?aHRiYVYvbHBpSTZ2R1gwUERBWG5DUnhZOTY2cWxiRHZvM1U4ZC9SajZYdVZu?=
 =?utf-8?B?RkxDM1RLaGx0ellYQS9MSnIzWm9UZmxxV0VYcFNaZEFTbVo1UzdFOEoyMUta?=
 =?utf-8?B?VUlYQkVaVnpxWXV1THZTUk5lVjl6WE92SHlLU21lOFVRMVJQdXhPNTltbmZl?=
 =?utf-8?B?QytkVFQ4VjBGTnZwRG0zS1l1TlhpRk8wQ09ycTdqSzlSK1VVaXVnQlRNNStC?=
 =?utf-8?B?NndZeFpmRlcwbFRSM0QrQVVWNFBiSUNXRUs0R2svYkJNRmI1b2pTSDJJSXNN?=
 =?utf-8?B?QVRjRW8yTEtTOC9tK3Nwd0JMckZHdjJBWjNZYkZYRHo0T09lUUovNzRvcXhj?=
 =?utf-8?B?MDlXQXA1VU9ac0dyMWtib0pLcGxRL3JLRStUbnFjN2cvbkU5NVJnMnFUWCt3?=
 =?utf-8?B?bTBKOE9MSGlxclo2Y1AzNExrRGowN1Via25MSkpsbFdreTVUTmE5MklIdk1t?=
 =?utf-8?B?UGhoNVVkQUFNVjh3a0JIaDJBRGN6UHl1UDZQM1lEWmpYRUZoY2VvTEJ1Z3h3?=
 =?utf-8?B?WnJFQkpNTmplZDVHOU9GV2RkMUlNd2E5bTNmMDFES3JHY3l2QXZEcDE5QnJF?=
 =?utf-8?B?ZklUNC9Wb0d6MUJvSGtONUNOcUk3Q1BGWnRmNWZLLzdBOThsTTQ0cnZwR0t4?=
 =?utf-8?B?SXNzTEZXb1M3bUxpRHVKc0k5OVRPZFp3Rk0raHB5b05RNXJ5UEJJZjVYUXNC?=
 =?utf-8?B?WmZKRUdXRmVYeHJUR21iTno1alVEOWE4VGpkQjRkZmh1c3h3S0g1YVdSUEVh?=
 =?utf-8?B?cW9LcGhJb3I2R2JRRWZneEIyWjh5TVJJTHVWOHRCMTJsSjJpMzNyY2JTWDgv?=
 =?utf-8?B?YVJOWWFsY2ZHNUFkSVdsSXpkK3NIVWFob1BGaHBzZitrc2JUdjlWNVZCYkRQ?=
 =?utf-8?B?V1JUWGFlekQ1NGd1NnhzVUNtTDJuak9YUmtiTEF3UmVHZTczd29IM2Z4U2pu?=
 =?utf-8?B?YzF3NFVRK2JnWGpBTzRLWGU2TmRRQUs0RmhSbm1aazMwRGxQWG5HbXFVeWlM?=
 =?utf-8?B?aTBtUjBuM2wyMDEwWCsyLzE1WmlDd0J3dEJDMHplOU1VYTR2TU1WOXdPMC8x?=
 =?utf-8?B?UlRwbzV2Sno0Q29hc1F2bDgyQXRMbGpCV3pPc3dsNnU2WTJlOU5UVXN4a2hp?=
 =?utf-8?B?ZEVEYnpaUThxR01iZ2dNelVjWXdzU01TSlVYbjhNbjdhYXQ2Uk9PVDE2SVlK?=
 =?utf-8?B?Sk5wZ1hOS1VtZWNRd2hCQUZsdW5vVG1iNnRsK2ZCRWpxSllVaG9ob1N4S0JT?=
 =?utf-8?B?cVZLNmgwZFlWcGJ0K1JiVGVGL1B4SGxkbjZ0MURyeEQ0cUZaTHNJcURkRktB?=
 =?utf-8?B?bk1GOURyYmU0K29UVk9JbVd2elZyakVIbDBQQmRVc2xBUnNCTHIvV21xS3Jr?=
 =?utf-8?B?SGRKQy9NTTBBbEtYd3VPTWMySTBvK0lOVXpyclVLQ2xXMzlJV25VRENPdmsv?=
 =?utf-8?B?YnFRcGNPOU9Rc2ZpUTRXdEpaQ0lJaVVKKzE2U0Z1UjJiczFpMTJZRklNcVVH?=
 =?utf-8?B?cExrM3lNVDVaNTJ0anVRVTRDOC95SGRUTlJsS0Y5NnNSK0VPWGN2RHB4S0s3?=
 =?utf-8?B?UTZJamJzRzJaNVdtWWcyZmkrUzBVd0FUZ3RuMU1VeVRxR1d6cTRFZjUwOExt?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba466d4-6540-4473-d02b-08dd40590972
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:35:31.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNPJlCvp05ITXpFpijh+U6NUZ7RjeCMEGnmfZ3NolzwN3KZcwalesv5u7vXaaIGkOZ0qfMr0dRM4WLjN28TUrl8pWNtevD3qDzp0rSYCHFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6292

Hi Lukasz,

On 29.01.25 12:17 PM, Lukasz Majewski wrote:
> Hi Frieder,
> 
>> On 29.01.25 8:24 AM, Frieder Schrempf wrote:
>>> Hi Andrew,
>>>
>>> On 28.01.25 6:51 PM, Andrew Lunn wrote:  
>>>> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf wrote:  
>>>>> Hi,
>>>>>
>>>>> I'm trying out HSR support on KSZ9477 with v6.12. My setup looks
>>>>> like this:
>>>>>
>>>>> +-------------+         +-------------+
>>>>> |             |         |             |
>>>>> |   Node A    |         |   Node D    |
>>>>> |             |         |             |
>>>>> |             |         |             |
>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>>>> +--+-------+--+         +--+------+---+
>>>>>    |       |               |      |
>>>>>    |       +---------------+      |
>>>>>    |                              |
>>>>>    |       +---------------+      |
>>>>>    |       |               |      |
>>>>> +--+-------+--+         +--+------+---+
>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>>>> |             |         |             |
>>>>> |             |         |             |
>>>>> |   Node B    |         |   Node C    |
>>>>> |             |         |             |
>>>>> +-------------+         +-------------+
>>>>>
>>>>> On each device the LAN1 and LAN2 are added as HSR slaves. Then I
>>>>> try to do ping tests between each of the HSR interfaces.
>>>>>
>>>>> The result is that I can reach the neighboring nodes just fine,
>>>>> but I can't reach the remote node that needs packages to be
>>>>> forwarded through the other nodes. For example I can't ping from
>>>>> node A to C.
>>>>>
>>>>> I've tried to disable HW offloading in the driver and then
>>>>> everything starts working.
>>>>>
>>>>> Is this a problem with HW offloading in the KSZ driver, or am I
>>>>> missing something essential?  
> 
> Thanks for looking and testing such large scale setup.
> 
>>>>
>>>> How are IP addresses configured? I assume you have a bridge, LAN1
>>>> and LAN2 are members of the bridge, and the IP address is on the
>>>> bridge interface?  
>>>
>>> I have a HSR interface on each node that covers LAN1 and LAN2 as
>>> slaves and the IP addresses are on those HSR interfaces. For node A:
>>>
>>> ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45
>>> version 1
>>> ip addr add 172.20.1.1/24 dev hsr
>>>
>>> The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24 and
>>> 172.20.1.4/24 respectively.
>>>
>>> Then on node A, I'm doing:
>>>
>>> ping 172.20.1.2 # neighboring node B works
>>> ping 172.20.1.4 # neighboring node D works
>>> ping 172.20.1.3 # remote node C works only if I disable offloading  
>>
>> BTW, it's enough to disable the offloading of the forwarding for HSR
>> frames to make it work.
>>
>> --- a/drivers/net/dsa/microchip/ksz9477.c
>> +++ b/drivers/net/dsa/microchip/ksz9477.c
>> @@ -1267,7 +1267,7 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device
>> *dev, int port, u32 val)
>>   * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as HSR
>> frames
>>   * can be forwarded in the switch fabric between HSR ports.
>>   */
>> -#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
>> NETIF_F_HW_HSR_FWD)
>> +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
>>
>>  void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
>> net_device *hsr)
>>  {
>> @@ -1279,16 +1279,6 @@ void ksz9477_hsr_join(struct dsa_switch *ds,
>> int port, struct net_device *hsr)
>>         /* Program which port(s) shall support HSR */
>>         ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
>>
>> -       /* Forward frames between HSR ports (i.e. bridge together HSR
>> ports) */
>> -       if (dev->hsr_ports) {
>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
>> -                       hsr_ports |= BIT(hsr_dp->index);
>> -
>> -               hsr_ports |= BIT(dsa_upstream_port(ds, port));
>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
>> -                       ksz9477_cfg_port_member(dev, hsr_dp->index,
>> hsr_ports);
>> -       }
>> -
>>         if (!dev->hsr_ports) {
>>                 /* Enable discarding of received HSR frames */
>>                 ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> 
> This means that KSZ9477 forwarding is dropping frames when HW
> acceleration is used (for non "neighbour" nodes).
> 
> On my setup I only had 2 KSZ9477 devel boards.
> 
> And as you wrote - the SW based one works, so extending
> https://elixir.bootlin.com/linux/v6.12-rc2/source/tools/testing/selftests/net/hsr
> 
> would not help in this case.

I see. With two boards you can't test the accelerated forwarding. So how
did you test the forwarding at all? Or are you telling me, that this was
added to the driver without prior testing (which seems a bit bold and
unusual)?

Anyway, do you have any suggestions for debugging this? Unfortunately I
know almost nothing about this topic. But I can offer to test on my
setup, at least for now. I don't know how long I will still have access
to the hardware.

If we can't find a proper solution in the long run, I will probably send
a patch to disable the accelerated forwarding to at least make HSR work
by default.

Thanks
Frieder

