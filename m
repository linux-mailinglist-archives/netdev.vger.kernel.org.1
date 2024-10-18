Return-Path: <netdev+bounces-136975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 231449A3D3D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B091C20DD9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB72010EE;
	Fri, 18 Oct 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="XLVK9ZaH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64B153800;
	Fri, 18 Oct 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250678; cv=fail; b=aorHJaRx2J4XFvMWRJw69j0WEuHx2luM1AqCVepxOjGAwwGDd/Wh/StOShUIWdbP5dIk5/0mv/ri95yq3wJt2CrGc6LIOSwYBYb2RX2ANSrSdbhAnPaF5OzHYv5kJd7c7PCra7A5k2b/vQHrt+TlpzqFJiRCHvNLhVVzHYOsXmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250678; c=relaxed/simple;
	bh=BNrWALyN0eLVonsj4nxQmZgMV4Jzxnxxr//P2MMq+Tg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOzRgrQKCEwciKzL66LY+vPldtRfZJEUmM0UhqCpypns+jgSNdiFUWzbAkdwqaxOIvhSzoXJFE3i0hQg3Ct4K6igm8Sy5eV0YSmjAMDp0re5NDmaMo0Lu4qrDQkjE+3TOB2PmtPYahgIm7yLQ9bEhYxux/Q6CbvgJ2yS88aO8A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=XLVK9ZaH; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipfcrTplVw9tipEgXmf5hIEkS9vxdopQjT7gdvZA7D0EsFIZ4VwbMdxrQWftNCmr+jeIyccw2qwxwyI4z8iBRp+v3vLjNtrj/XUtJMBqst9Np9yFkjvCEBmHhDlmDk1X3zVOmP8NIgNzA5Y8GV9qjJtIxBgixPNMkOLgXY5BHXB3LAi1sC64ibUkCY5rMdHKoFEfv4/ua4G0Olxx0AEaDMjXf/fM/gmNlonmDyO5H6djRny46Xq3AZkoHg3ECCsiKQLbPGxXKxjTVflKU1ozF81t81Ft4fuWWBAFTJz2utfUDlFa/mHOHnlXk5CjPIwXmNnNT0u2X6p0GpetysZpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Je8T1WLROxUFf2tTiRSQ32APk173+dr8YRzbdu4vLw=;
 b=aZqWC9AoLwHr0aXBGKnPzOFC2sPKD1y/97BdFpH7sBD8PgX7RP/42/J9CL9yBX72QWOEhg5V3UjQBYf1nnR3hhBJL24OgChJ+U8M17l0Z7EotCtw0I/thsrXi09EIlUkr3jXgljB1T4yADKmJGOrI2S9/yJkm4+UqXwy6VTUy37YlXSRn1Ln1jHhRu+MNb3S5HgutUih1EIGKtspzIxhxgvvoCyoUM+QGLEbs61fXnF3At5ViffZ+WPQ1sOTEgd2B4r/L4dxrk1fXRFgmvCPUEJft+/FIZuYSGNpChgDnR/Fpt/liipTdPzmQZYztXSM052b86U+ZGMEJz5XldOh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Je8T1WLROxUFf2tTiRSQ32APk173+dr8YRzbdu4vLw=;
 b=XLVK9ZaHD4tbpmKSX9LSl8aIjAV5sJ8xBlz+EYd2oHod9RkPHMFeMWRr/KGhJ1PMCesQG5q4rsGXEqk11jVcyIG6Jv/PRee5PYKxLfjHLAJY2pR+zUq7JJodO1fHr9utc5W4BTiCKCwXxIrie8qMiwierYQMjpW8RmfxcVkJKw0GesmnUx9uJBt4L2jWyi6Jrk1iYv2BlOWO48kKNjb6oEqJXYbpzm8IqA34NEj8ZGYOV5sCvdyBpR4H8u0C+sR/Ir4TQmFnbvFQhLYvVRST26JrqSLe6A/Pi+fuQ2xFU24jbxLtoTJ2fdTwZs0Qocsm1lEjjzsKRCSELKUxmMcw/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AM9PR07MB7777.eurprd07.prod.outlook.com (2603:10a6:20b:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 11:24:33 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Fri, 18 Oct 2024
 11:24:33 +0000
Message-ID: <a7f1f376-3f0e-4455-816e-ae7b4051d501@nokia.com>
Date: Fri, 18 Oct 2024 13:24:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 09/10] ip6mr: Lock RCU before ip6mr_get_table()
 call in ip6mr_rtm_getroute()
To: Florian Westphal <fw@strlen.de>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
 <20241017174109.85717-10-stefan.wiehler@nokia.com>
 <20241017181446.GC25857@breakpoint.cc>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <20241017181446.GC25857@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AM9PR07MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f31e84c-44b0-4e78-bf5d-08dcef6770b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmt2cUtUTjZlUUJaY0psaFgzY1B0THo5Q2hPdStxSklUQWUxWS9CTlltb21J?=
 =?utf-8?B?ck1NdzNtN1VmM0dOd0JubXJ0S09GWGRxWHNBNFlqQjAzWFAxMVdRZ2RXZ2p3?=
 =?utf-8?B?RGdsTkUwcXQ5L0Y3YU5kUUIrWWFodklhekNuUkN6ZHpjZEVyWnhwRVA0dGEr?=
 =?utf-8?B?cXpQYmI0ZFRZS3YwSloyMldpR0wwY3BZNGIvMFg1M0FGenNaZytEVVBkUDNl?=
 =?utf-8?B?MFBaZ0kra3Q5SnNhY1NIMDJldFdQY0lqS0l3R1A3Vm1QQWtsQ1VMQ3BVYlc0?=
 =?utf-8?B?WlZwOUd0TWZMcDdYMjNhR3dVVlV1aVZYZXpxWHpqb3l3ZWlhTjFQNWZDSGFz?=
 =?utf-8?B?Vko3QUo3SUg5blJnWUQ0Tks3MysvT2JOUFBzR0lYNVMwQkZ2NDBIU3VLSXZN?=
 =?utf-8?B?RXVNa093d2dCTi9MQTJVTFVpN1Q4L3hZVHpCK3ZMRHExTUJqSVd0bEpSTU9Y?=
 =?utf-8?B?R0tIb3o2cm9rOVdLU2I3Q2tFRlMvL29ESXFwRkxKN1pKazdJK0NxUzhPMHh6?=
 =?utf-8?B?TFVyWEFET2N6WGdEUlJUL1puRmZ3S2J4Uk5DVXBOVldEclI3bTRIRnlHZkFG?=
 =?utf-8?B?UGs1SjliZC81LzlIZnVYenhFTGpQZi9iRHE5MDlmZStsSVZsdjFyV2tPMEN1?=
 =?utf-8?B?aSt1Qms1TGFKZFh6cUczOWVOMEdsbkZYTmwrVkZxeGlPMDkxMWpwa1d0L3pu?=
 =?utf-8?B?dFNCTGZVa0lDZTlFZCtoUFpLaEtmMTFSNG9ZcnVDNGNpU0N0V3JITURyNTJB?=
 =?utf-8?B?NTMxdXNKZTM5UDRjMkt5ZXdmcTNidzlCejdQN1V0RExnUnhoc2l5MlZXZUk5?=
 =?utf-8?B?SjZLSGNPR3BsVENTZEMveTRtblJzN3RuaFRiTTdLVEpxMDByVldESXA4QkNH?=
 =?utf-8?B?MWRQTEJQRUx4dk5VVXVHK08xQ1l3OU51Z1FTaHhzTWdSM3V1QXA2WExRRkFO?=
 =?utf-8?B?SkhhdldpZ0h0WVBMM0I0dEpaQlJGaVVrTHZDQmpBemRjUmlieWhtaWNvZEk5?=
 =?utf-8?B?REtGTkp3ZmpuVkZ4cnhGa1U1ZEdhNWRKek9ZL1M5VFdIWlVYUERHaWpiZWxw?=
 =?utf-8?B?TUo3Qk5uRTZYa0tWOW9MQXlkRTdQbFVZMFlSWXhCUThWcjlvcnV1VzhKZTlV?=
 =?utf-8?B?dnJqdzZXUjM5WlhxeDRvalFIOUpPTDZpVjhTWHlZK1pUR1JxakRDZkYvb0ND?=
 =?utf-8?B?NzFKNXBxK1pxdS9RTm9tdVVBWkJmSVdBaUt3eENkV3gxdzFoQnMrTnJRaVB1?=
 =?utf-8?B?aDJrbjFpRkdNa0lJbHhUN0tmWERoM1NZOC9va0F1LzFDN3lKenAvdGlRMm1Q?=
 =?utf-8?B?NWJJMy9oTXdJRGMrQjZwWW9QTitWbis0ZXZGenp6T2tNcVhFUis4bkdzeTR6?=
 =?utf-8?B?QU5ieWM4M250T0ttR0pXd0lvVXJ5THVTa3FnczlaL0p6WWkrQkxDOFpxVnp4?=
 =?utf-8?B?S2V4Z09rZnIyUmZzNC9maXhCZDZmQ2RTZlI5NEh4Qjcwci9hckJkT3pFaENv?=
 =?utf-8?B?UnJ5K0kwQll6dmM5T2RibVlqbzNqVjZ2TkpBM0NKalpOSEtXOGNHSXNadFFW?=
 =?utf-8?B?NzZlMlUrUkRwUVAzYzZ5VFNwaGliZUIxNnZIdWp5VE9CQ1FMTjI2U1A4SlJl?=
 =?utf-8?B?MkZqSllLRGNBQlUzR0owS2h3bkFZZ1dXOUZTN3pLcGZLQVhtcXRJb2xHL1NX?=
 =?utf-8?B?TDZqa0huV0ErU0E5RCt1NGFPaXNwYUZHV1Y1MDhmcXNOMEsxaGdmamdmd0FG?=
 =?utf-8?Q?YydUiYo3e1ZfpT39nryUFTNuaNVnLNPF4NamoPQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2Y5eXliUHZTWVkyQVN5L29Tams1UlJNRkUrelkwbWFxRWpuYXVSUXVBQmJL?=
 =?utf-8?B?cjhVNjFwelk3TXpiVGpsUW5IN2ZUNWI5VVlVK1R3YTRBQTlSNkJMbWFLa1B3?=
 =?utf-8?B?bVVHQnlUUmZDVkRJSzM0ZjdtVFU1bDNHZkNzMmlxL2hveTd6disyZDMvWTJP?=
 =?utf-8?B?Nnh3cU1NQ1RXc3FIVWZYRWlmMjYrTUs3Ymp4ZFdRdnZKeGlhUlBkYVpQeW85?=
 =?utf-8?B?U1NhM3VDd2JBVFM4TDNQTmRoMDZKUG9pRThJQllhQWkyMGdVeHNQMzlXbEV2?=
 =?utf-8?B?MU5sakt1Qm1JclIzSnNkeUhuNFdSYkhVVmNrUUxOZjVHZmFMRWlEY0VKVi90?=
 =?utf-8?B?N2VOUFRNOTFObG5GWHExWDArQ2lDdU45K0hON0hRenlkUDVEcEZlMTROTWU4?=
 =?utf-8?B?UXZuc3JuVjViYjhxOVdDTmVOa2RiM3FobjZUZVg5WWYrbHVySTU3TUZybnI5?=
 =?utf-8?B?eGxEWUxQZ01VZWszNUxuSHVSbmZ3ZG01RkliRnpWZXZhcmIxM05vQ1BRWjly?=
 =?utf-8?B?ZUI2eUlkRWlGT1dVZE02aEZNQWlsNld1TDhDM2NTWnhib2RiZjladit4ZEkv?=
 =?utf-8?B?aTdDRGUvNlNpcXJEQXQ4VzJoMVFvZmc5VG1oR2xkbUs1VVFCcEE5cmFIZ3pM?=
 =?utf-8?B?ZDh3SWcrUW1uRXFIbDNOalpjR2xXSWtMempIZDB1SGQ1TER4aVBxZU0vNlRL?=
 =?utf-8?B?SnMwa0tLNDV5bXpPWTI2ZWRwOTVJOWdDSkNkQmRHOEhxNXdKNjErYURTMXQ5?=
 =?utf-8?B?YzZkRi9uaXZWbmRsM1JQZTRsYUFpdWg0Y2pudldTUmxUQWJxcXVDK3hBTlYr?=
 =?utf-8?B?d3dzUCtUdzhyYlE0eDJnYVZVTUJmSVJ6bnUwYW9QcFZvZ2lmOHBNUG1LMUw0?=
 =?utf-8?B?ZHl2bGN3eDVVWERaNEFPSWJrSm9iaUtxVVBpOE5hbUZTVW5NSHZ2b1RtcFpk?=
 =?utf-8?B?WlpSTVlKa3g4STFSVnd1S3YwenBpcTJzMjNNRnpwT3FwSlg1b3J0Z2hHcEtD?=
 =?utf-8?B?N0xYckUrbEN2RW9wUU03U2FrZyt1d0hPajJBQVlXMEpxSkN0dWFMTU41ZVlM?=
 =?utf-8?B?aWxOQ1I4Rzh0YXlGb1Z5dERKZWlSMExRTWRhT0xqeG5WQWFiNHFMcXBLQmNp?=
 =?utf-8?B?U0JUK1FaYS9zVCtXc3F6ejBBd2JHWk9SeDRkWEtZcFBGMjVMc0V5cTh6NnJ1?=
 =?utf-8?B?TUhNdUZHWE5lSnByR1YxOVNaZGdNd01FRnphcEhoaEpuQUVpMm4rTVNXK3ZZ?=
 =?utf-8?B?WmNIYUYrV1VwbDBlQWMydkRaV1JjeVBWaWhuUkFqaWtPaFFaa0FGUFBORGR5?=
 =?utf-8?B?bmhYUEdjVkZLZ0tiZVhwWWp1NHVkWnJmWmxnSERGTjFCdEJDVVRKbGRLREdV?=
 =?utf-8?B?Q29neGdvYmZxZE1rNFVla1NuY1VnejlaR0RoTGxyK1pDYkVBcmd5UzA5VjZP?=
 =?utf-8?B?ZlpSeFhDS244Rjd0cTRZQVJZNTg3T1RQeC9WOWdZV1hqeUdYQ1NENHQxR2FJ?=
 =?utf-8?B?YmxnWXZFSWd6ZlZ1YmkxTVc4RWw2ekpLZUMvMmcrK0RCUkNmTk1xM0pvbG5n?=
 =?utf-8?B?ekZwZjJ4Z3E0NzlGbldWdks2VldvN29lZ1Y4TVQzTndDWnBjMDFCNE9lNFMz?=
 =?utf-8?B?QXBjdEhwZlFKN05oVmt4N1AvckZ2c2c1ZmF2a3UvRVpDaWlmWnFiTTV0S1Vv?=
 =?utf-8?B?eVl4TEtLWlg0WUZ1dFIxZjNpNjBwRUIwWWQ0Mkw5bURaUWxiMytLdkxQb2du?=
 =?utf-8?B?RTAvZ0Z6Mnl2dEEzYmhDR3hlM2xtNnJ1dCtTa1ZkQ2s4RDFCOFlnWmxlMFBi?=
 =?utf-8?B?allEWTNtZmF5STN6UnBscVVhRXlvUVppaDVETWZ1emU2bmNrR0pyL1Z1V0hH?=
 =?utf-8?B?bmFsaHdnbk9XRjcwcEFZZitEUlBseXpvdVNoQTVjUUF0ek5qMjdSb1c4cmti?=
 =?utf-8?B?aUxJcmo4bmU5OWROZmJUWXgrN3JxcFB0SDhGN1duVHFPcUN2TXhTaFB6SFF1?=
 =?utf-8?B?SFUyVTF4bUZ2Y3lCM212a2hPQkdienI3b201ZDlWbitvMFdaK1lSN3ppd0lM?=
 =?utf-8?B?NWUyTm9HZnBnUWhwa3EyWXZkMytLekR3YmdhcExlZHU1MGc0K3JHWG1GUDJ5?=
 =?utf-8?B?MWs2MUFiY3VKeE1kckxuekV2Y1dMQXVpK1AydFk1WmRNMldSTnJRbmVEek1p?=
 =?utf-8?B?T0pEUUxmLzEyVkFUZjZVR1NQTlh6UG50TTZYRG9ESFBSZW83bGhBTDk3S3B3?=
 =?utf-8?B?MlBpaUttaHVYdXV5MEVwQU4rMTVnPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f31e84c-44b0-4e78-bf5d-08dcef6770b8
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:24:33.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fAsKqtLc2VeUiIZ8Xl25CtjYUJtuVT13BbkabLvCbNQi3j7M/skgRXggui6+JoNqXnuaOGNZc0cGJmfvgDEJa13PjepFjx0dpLtyo5z3fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7777

>> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
>> must be read under RCU or RTNL lock.
>>
>> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
>> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
>> ---
>>  net/ipv6/ip6mr.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
>> index b169b27de7e1..39aac81a30f1 100644
>> --- a/net/ipv6/ip6mr.c
>> +++ b/net/ipv6/ip6mr.c
>> @@ -2633,27 +2633,31 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>>               grp = nla_get_in6_addr(tb[RTA_DST]);
>>       tableid = tb[RTA_TABLE] ? nla_get_u32(tb[RTA_TABLE]) : 0;
>>
>> +     rcu_read_lock();
> 
> AFAICS ip6mr_rtm_getroute() runs with RTNL held, so I don't see
> why this patch is needed.

That's true, but it's called neither with RCU nor RTNL lock when
RTNL_FLAG_DOIT_UNLOCKED is set in rtnetlink_rcv_msg():

> if (flags & RTNL_FLAG_DOIT_UNLOCKED) {
> 	doit = link->doit;
> 	rcu_read_unlock();
> 	if (doit)
> 		err = doit(skb, nlh, extack);
> 	module_put(owner);
> 	return err;
> }
> rcu_read_unlock();

I realized now that I completely misunderstood how ip6mr_rtm_dumproute() gets
called - it should be still safe though because mpls_netconf_dump_devconf() and
getaddr_dumpit() hold the RCU lock while mpls_dump_routes() asserts that the
RTNL lock is held. Is that observation correct?

