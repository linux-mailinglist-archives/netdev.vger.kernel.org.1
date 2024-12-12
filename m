Return-Path: <netdev+bounces-151367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27029EE6CC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CD1884A52
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B78212B2A;
	Thu, 12 Dec 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="7Bv2IC0B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A63210F4A;
	Thu, 12 Dec 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006842; cv=fail; b=Z6fmmZpcX5ykrBnFMt3C+VUjt2tpxI7inGaPCy9rNuj1BrLrUa5JU4B1R3koibxpos0CzzPEzcm+X8vsNqwJEtPfHthSFBmxj/Sd8QKK6Q0/2uUCxu/peGXZPfPHVwnFPszy8QZlgEOmks+Hik4y5YN/XoMhymafPLUucTuVBu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006842; c=relaxed/simple;
	bh=lX2tsg573kdr59SrGO9pcq0SjUtBI17sN/Oonybnzng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JK8X8u546T7izQXAuf1tKrwRo79oSRX5+VsfY59xryv3JrFvI+0qO1dYDJgry1Vg1SNC26vjZgtUq7RAgCKslwKSivCnJq/PA35dN8+hnQDsHCkassEwmLh5S4DrOQLy510e1cbamTguKIU8l7ozq36ZD8YL7nO6TCPIdHbvEIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=7Bv2IC0B; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=by+tMbMLbvdzfTFv2LTPunqzo4kipaQgg4jy64AJmFib5giiGoahTw+eqcdT8LMFCI1rMFslW3hV2eFqpieTGrEOhLxhTKbLe5FNVLFwLRgCmdTNiDaYO/JNE+wlHZA3SjJsUjHjbRg16R1q5jj3kYBANsZNyPdlcXM67Bw7oDGwmik/iO3ZbVysl27NfZj7SaxjzKNcz1v5mJFcSU2l61x9RxeVIhcc3nMw4HfwywB7Kb1ddGSmY+Mf0xT0pij8eIaacmNdJQt3mIRxtemOMwu+bKJS1Yb4PpStunz1Z/YKbaCx/w7Ctjwc10Uytawwu3BVJczGttOH/62+jEFcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX2tsg573kdr59SrGO9pcq0SjUtBI17sN/Oonybnzng=;
 b=NUdkmN8y7v551jtyCTyWNgngNzSSBylssEMP2vwrRMc8PazREUIuxnm9n6zAZM3+ctJjP55ucnMS1FxSM7b30bXkjamk3uNhK2NA2nwudzkBNlu4OUmI3AVpAs3kIonR8tl+FDKsIt7ZqCVPC3LAfho4tHFQA5oQai4LvGRUK9f3GLnioLHe/BFM7yDQGJ9KrbeZOdYydurLdaHNW2NQc5m5fvCJHy+V7ea2hiOXvUQT18q+OdyG8EOS5eZN4/8DgnxGu3ZkoY8/fSECi3BG0dQOQE9IvHaiDWEXW/CNw+QUw53uCDSzGHD0lfucptxM3QPPyIr96rDEC3sj1cTSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX2tsg573kdr59SrGO9pcq0SjUtBI17sN/Oonybnzng=;
 b=7Bv2IC0BS77wzxmaAs8sm/l6zl22eXZXVPfbWtedG49zNULuvT+c5wTmiDAuisuGlSUtJvMxxiUsfG+QBtQ7JCh3V6JcDyeKqNjDJsspPxoUEUqAZd5oslLolOotKK3hI2Kf6yDhCo2FMxlbje5SnRBKkypPuNbWIQ3WDyMps9E5XvA0piR37smp7ByQyHd9GK1V4eQqHRFIkXbNQhlKTlDeUTmikcDGAQ07s1hKw90B0c8C80ieevwsZ6Tp6qfo4F7dS3w0vUcZO1pw0AIZA4sTdE/gU1j2UaiI8Fpa9QE/Di8JOv49QbIJVeY9huGw5MeA8KVIlyp56Mmrw1HgAw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW6PR11MB8310.namprd11.prod.outlook.com (2603:10b6:303:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 12:33:55 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 12:33:54 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: Re: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Topic: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Index: AQHbRlFobveu+PlKfkaa7qgOKnJVrLLeo4gAgAP0CwA=
Date: Thu, 12 Dec 2024 12:33:54 +0000
Message-ID: <5670b4c0-9345-4b11-be7d-1c6426d8db86@microchip.com>
References: <20241204133518.581207-1-parthiban.veerasooran@microchip.com>
 <20241204133518.581207-3-parthiban.veerasooran@microchip.com>
 <20241209161140.3b8b5c7b@kernel.org>
In-Reply-To: <20241209161140.3b8b5c7b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW6PR11MB8310:EE_
x-ms-office365-filtering-correlation-id: 420e3c0c-a0d7-46b9-0349-08dd1aa93e04
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnFYLzFCaU8rc1ptbER2NUw3dmZyZnZvZDArRVYyU0JUNGg0cnNGRTl6NEkw?=
 =?utf-8?B?a0wya2V1aTFzdDFEREFJOE1BTFFhNjAza054dUFhUlZQRjYvUGhMemdoRmpu?=
 =?utf-8?B?WGsvaS9IL0hPZE5YWlBkUFIrdDNUQzk3V2ljS2l0ZWxoNEx2WHV6ZUpxYW9Z?=
 =?utf-8?B?UU5IRHJmenVMeVd4L1Zva0lyd0krNmIwSXZHZDRsaVJPTmNUaVJ2ZlVjdDV6?=
 =?utf-8?B?dlN4Wmg4d0tzRkZSb3BpZHB3RTRGckg1NW14Z2RqcTFzTjRzcmZhNjdyVk1Z?=
 =?utf-8?B?all2dUpabzVEMk5GdE1zQVVwUEZMYTZsajdDZ0RUTTNvWWw0MGVuZi9md2xS?=
 =?utf-8?B?YjE1eDMrRFZXWmk2SHBPQjFJUUw4Q1JPb214UUo0dWh4Q3FTWHg4NC9MSVFB?=
 =?utf-8?B?ZGlCaWI1bCtpKzFVZ00xWDFGVVZheVh6WDh4QXdkQ2VPOWcxNldpQUlVaXVK?=
 =?utf-8?B?Q09VcDd2Vm1mNTZzUEdnOXIvdmVRWjJlY2xFSVJzT1lWQ09SOUoxZFprRERx?=
 =?utf-8?B?M1gzUE8zZ0VsNHJiT2U3dy9CeEdIUlhtcXJ3amNveWVRM2V1YTUvVEZaNVgr?=
 =?utf-8?B?M05oZUU4UktCREJyWUFvNFl6V1FoMW56bkxYS1F2STJ2Rk5BMzkyOVdpYXNr?=
 =?utf-8?B?SG9EcmtVNTd0UEpRWEcvUXVmNU4xTVE4c1prbmFxMWZkR2JUdmIvTzZlelZw?=
 =?utf-8?B?VHBlVzI0aitOMWRYeW5pU3BJcStWQjQzZUVCWDhrVTUvd1BKbVRBTFdBVVdF?=
 =?utf-8?B?NGh2bC9ORDZqR2Z1cDl1UkpxMWtyOGZ0OU1Qc2FZU0Y5eGNCZEJTNTJSM0lY?=
 =?utf-8?B?azRzTGNVSGVkSyttUU9pSnM3am4wazhkcjJzcXFzQVFkbTNXNlk4KzB6dGQx?=
 =?utf-8?B?K0JnYVFabElLMkU0L283TFdnY1NCNXNIK3p1SWFYeFBxZHc4NFIyaEN0N2F6?=
 =?utf-8?B?MGxzRlkweDY5T215WlcrU0ZOcC9FVlRKV3I5WE8vNVJiYkR0d3JYTWhHSXJm?=
 =?utf-8?B?UzV2NzN0ZlBxdmJCakxWUEtTd3NkWE1NejFaWTRZQWZpM0VzQW1yZjVHb2Qw?=
 =?utf-8?B?MnNJS1psRjlMUE1vaHduS1laRTJXMjh3THBtZlMwNldWek84VTFDRlNJb2dC?=
 =?utf-8?B?WWVPNGlzWXFoOU80RU5rYnlwek5XWDAyTDd3MXZGdVdRZFZaNXRCaDlFeDVM?=
 =?utf-8?B?Y1k0K3k1TGdyaXpTcTZuYXB1cGxRVnVGMk5GbkVhWXNqcTZqTDFObWFGVlkr?=
 =?utf-8?B?WDdQWkVFdEdmZi9IL3cwYVduNUo4Qy9SSnpjRnF5d1R1Uk8zWjRhNUNiay9O?=
 =?utf-8?B?d0hpRGpZbng5NmhiYW5DTnFhMHBLVkZLa1V1R05ZYVF1Ync2dU9JZG5HM3VH?=
 =?utf-8?B?d0FFbGQxNkVXVnJNd29GbWt5bXl2bmdlb1hUSnk3aG5kbjVlQ0Q1OXFya2ZY?=
 =?utf-8?B?c21MUzl4a01qS0d6a2dGZ1NUdnNKMHJSTjVwUkxhQWpBSklaM2RjOGFOSTdr?=
 =?utf-8?B?UzRtZGkzeTVhcGhwcnJHeG5TUzB5MEE5Q3RjUUg5VnhrTUNraHYybEQ1eTlp?=
 =?utf-8?B?VmEzd2N5LzJLYTIvUktTTWtNZXYwR0o1UWw4d08wNkpxa2lSMFVORGZKRWRz?=
 =?utf-8?B?THZGTDlEYUVzUVZtcWUzeHoxdmxaVG9ISWdJRCtUWWU1cEx1bG9lb0lnaVdv?=
 =?utf-8?B?L2ZyV2cweEIzQTIxeUFuNWx1NHVwN0FqOWNtQmhUcHVSNDAyQ3FVczRxVDdG?=
 =?utf-8?B?WFJ2eEdwK3JqMnhaNHIvS3QzN3hPV0NZUzgxUVVRSmt3cVIvVm1mZ0RFcktu?=
 =?utf-8?B?TWFNYkxjdXZLSTd1eVFKMGZoRlptazZDa1hkKzVCa3F1TVRrdFdZN29HejlT?=
 =?utf-8?B?cEFiYUVjOHlaVEhzSlArTkovNUN5ZCs1Q21sMVdQNmdMaUE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3lON2EwZmZqd3ZFTjlDK0NFa3BWS1NTNzhpOHgydjRMeWpKV1d4V0w1VERw?=
 =?utf-8?B?U3ZLL2pjcWszZ1B6ZlZpQXpPUHc0K29ORWg2SytDajBOWHczQVppWlZDNWZX?=
 =?utf-8?B?bVBOWW4vdldvRSt6ZllZL21vbENjTENSNURHVjV4ejlQeTBFbXJ6TEZ6dEts?=
 =?utf-8?B?RlJBMGx1S1RsVXpMcmV0ZWlxYlRId00zNjNDNk92dWwxa1Z4d3IwQTR4VGVj?=
 =?utf-8?B?eURLam4xY0ZSczNURVZvMkpiQTRBc3Q1TURMdUlvdUV0NUlJd1N1Ry9GcXNI?=
 =?utf-8?B?dlBjWCtmT2I3RnhIK3g2ZFNYa2xnN1JxckRGcFp2MUFGUzNDSFRodXpmRjR0?=
 =?utf-8?B?OUZHOTZZeHlNZlZVVUVia1FnaVFSWkt4OFllNVFyamlmU0FMUVZlU2NRWkxG?=
 =?utf-8?B?NjYyaTcrak9MRG9VbXJlbUl5eWdjakdFNTdXdU1hcnFLdjhBbVlKNXRrajMz?=
 =?utf-8?B?QVlhTGtISDZzU0lDdDF3cVVhb0dFUTZtL1B5TFNkNVlTNE4vc05KaXZVVSs4?=
 =?utf-8?B?dEh3dUoxT29FdjBkZjVLYWJ1OWFXazUyb0JBTEJHbzl6dzg3bVIxbkpKbmJ3?=
 =?utf-8?B?ZFdzWjBzQVNjbzBmTGVObUZRRVVrclFhekhaUDlmc1dWZzl3a0NNenBXV1NV?=
 =?utf-8?B?SW1iRUJJQjdqYnk1WnVlenFBMFVTQ0N3WDF3TE5weHBZR1FMVEszUlJTdGtE?=
 =?utf-8?B?RzdFSVAzcmJlTWZnOWlBVzN6YWQvSjROR2VyL2x6VlBmamNtNzVlQ1ZSVEw1?=
 =?utf-8?B?R3RUZUJjQ0M3a08zemlVZGhETk1ENGhMZmpOOVMyQlVWdFVJY3c1TkJOcEk0?=
 =?utf-8?B?QXdBa1VVNDF3aFdqMC9pcEkxNXduQnE0YVlpenF3QkIzY05zaWN4ay9TclFu?=
 =?utf-8?B?dnBreEtTK3d1K3dRaENYVWdsaTdnVTJSUExNeWZmbFc5VVQ3K0hNRzlDelJQ?=
 =?utf-8?B?NjR5NXFMN0JURTBJNjE3ZlJLaDBLaXZjNTJpNTBqWDVtTDZIT25BMXNnSTNQ?=
 =?utf-8?B?UWhnejNiSFZmc25KUFcvMWtFRG9VOGVhZjNKS3RMcjJFQlhpWmZpUndGNExk?=
 =?utf-8?B?UVlPN3laY1dKQUxLZzhqR2lRRCtXbzV2L0dZQTZOV1RJaFVXTUtIc20vZ2Mr?=
 =?utf-8?B?UWpqNzgvWW1Fa051ZHJtOXRRcmxMSTNOeDJ3SmR0S1NGd2NLODh0Zy90SFhR?=
 =?utf-8?B?eHVPN1p3OEw0RWNoSndkWWpDSEtxOTJTbHB2TUd4a0lpWlpqbkdCMzhYVUtr?=
 =?utf-8?B?d3FFdGNqWExrR0hVbnFaNnZveDdpREpMMUdJZWNrUGJwSkdHeFB6VGRUaXBN?=
 =?utf-8?B?Z3VOeHRmWG1RV2VmamlXalJHNGlZMHZnVHJMV3A0VWZyY2o1MUhhSllHRXQ3?=
 =?utf-8?B?aVdDbDIvMk5BeCttb2FJVUgzNjJ1aHBtaitqZ2l6bkNmT3RCd3JKdktxRmR2?=
 =?utf-8?B?aGg1VzdSL2g1NkxZSFg1ZmVvTTVpcExMWHpQNXJESXB0Q0lTQUVIT2o1YXlZ?=
 =?utf-8?B?WjRxbHVSdVpTWFNPWk1UTEJyVlFGekYvU0Ivd1hRRVo0dVJjdklPZDFaM3RS?=
 =?utf-8?B?QTJKWFI0b1IwUURTV1BWdENSa2gxb0IvNE4rbkZaMHBjU3RoT1BEVE1lbVIx?=
 =?utf-8?B?ckNnNHo0QTB0bitSeUhXaUFodk5MNWRnV2kyTVNTWG1XOExWa0xZZnBKcTZz?=
 =?utf-8?B?UlVJem9oUURBbE5wUlc5NTZhZTA5aHJrc00xeTZMS1VocENDVVBXVHhVRWtw?=
 =?utf-8?B?SU4rZ253aEdDMHJwVk85azEyZGNnZ0pJMWFsZlJTUnB2VGk0TU5wOENWZUtW?=
 =?utf-8?B?NmdSZEJwRXk3S000dE9KU0x1VlJiL3N5a2t0eWlmaElFeGJsZitqbEZPTkRR?=
 =?utf-8?B?V2w3ODd6RXl4UVU4ZG9VVGxjK1IwMkJVZFl4TEltN3czL1VWemRWSXp4UGR4?=
 =?utf-8?B?eElHQlEwYWdBQjBWdWM3OFN6WUovKzlWRXFGa1l6b2tOY0V1VTBXOXNtSzBN?=
 =?utf-8?B?ODRORHJsN3NtWlJlSDFlb2p1LzVMQUg0WWtVcjRlenE2RURSbHVlU3hUMFhS?=
 =?utf-8?B?VU1jSzZ0UzFmekZxS0c0WGt5ZzNLWnJrVW5NdjdrMXJBK1I3OFZkUnJZRlEy?=
 =?utf-8?B?U3I3TW15a0tpNFVwdFVCWFFoMHNCcThwK2YxaEg0Z1hFYitrVWRQNWtBMGxn?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <103DF54E81516E4BAC1711E53B71C370@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420e3c0c-a0d7-46b9-0349-08dd1aa93e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 12:33:54.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L12NIYlNWGmhPAOOhhu/1giZesbI8iVeTA1kUdq/HADcnuJ9GnfdzTvQ0pfHTcrgFogh5h5VnSgYycOHf79v1kPGsAREbbZkkygKIfgz09jzCStkkF1hUSMpPjWQPd4u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8310

SGkgSmFrdWIsDQoNCk9uIDEwLzEyLzI0IDU6NDEgYW0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgNCBEZWMg
MjAyNCAxOTowNToxOCArMDUzMCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBAQCAt
MTIxMCw3ICsxMjEzLDkgQEAgbmV0ZGV2X3R4X3Qgb2FfdGM2X3N0YXJ0X3htaXQoc3RydWN0IG9h
X3RjNiAqdGM2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPj4gICAgICAgICAgICAgICAgcmV0dXJu
IE5FVERFVl9UWF9PSzsNCj4+ICAgICAgICB9DQo+Pg0KPj4gKyAgICAgbXV0ZXhfbG9jaygmdGM2
LT50eF9za2JfbG9jayk7DQo+PiAgICAgICAgdGM2LT53YWl0aW5nX3R4X3NrYiA9IHNrYjsNCj4+
ICsgICAgIG11dGV4X3VubG9jaygmdGM2LT50eF9za2JfbG9jayk7DQo+IA0KPiBzdGFydF94bWl0
IHJ1bnMgaW4gQkggLyBzb2Z0aXJxIGNvbnRleHQuIFlvdSBjYW4ndCB0YWtlIHNsZWVwaW5nIGxv
Y2tzLg0KPiBUaGUgbG9jayBoYXMgdG8gYmUgYSBzcGluIGxvY2suIFlvdSBjb3VsZCBwb3NzaWJs
eSB0cnkgdG8gdXNlIHRoZQ0KPiBleGlzdGluZyBzcGluIGxvY2sgb2YgdGhlIHR4IHF1ZXVlIChf
X25ldGlmX3R4X2xvY2soKSkgYnV0IHRoYXQgbWF5IGJlDQo+IG1vcmUgY2hhbGxlbmdpbmcgdG8g
ZG8gY2xlYW5seSBmcm9tIHdpdGhpbiBhIGxpYnJhcnkuLg0KVGhhbmtzIGZvciB0aGUgaW5wdXQu
IFllcywgaXQgbG9va3MgbGlrZSBpbXBsZW1lbnRpbmcgYSBzcGluIGxvY2sgd291bGQgDQpiZSBh
IHJpZ2h0IGNob2ljZS4gSSB3aWxsIGltcGxlbWVudCBpdCBhbmQgZG8gdGhlIHRlc3RpbmcgYXMg
eW91IA0Kc3VnZ2VzdGVkIGJlbG93IGFuZCBzaGFyZSB0aGUgZmVlZGJhY2suDQoNCkJlc3QgcmVn
YXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiBQbGVhc2UgbWFrZSBzdXJlIHlvdSB0ZXN0IHdpdGgg
YnVpbGRzIGluY2x1ZGluZyB0aGUNCj4ga2VybmVsL2NvbmZpZ3MvZGVidWcuY29uZmlnIEtjb25m
aWdzLg0KPiAtLQ0KPiBwdy1ib3Q6IGNyDQoNCg==

