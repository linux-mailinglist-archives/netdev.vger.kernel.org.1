Return-Path: <netdev+bounces-152144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EC09F2DDD
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC7A16157C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A3C202C27;
	Mon, 16 Dec 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="vS4sjPro"
X-Original-To: netdev@vger.kernel.org
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0FBA49;
	Mon, 16 Dec 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343832; cv=fail; b=e+D++g5wXP9hCMWfTCeajrj7J2J9dcckDCajO/37imSfhGPZUnXwMppVwVDt1JBgpJCUpoOMf6YmvRbBBo3gM2OAmPJWdJA4MJ1TAohrf6j7dqrbs7foQl5yYxbJnsacPgceRT7nUCDTdLR25542ep6vAXOOWVRbZjHX6wZOeAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343832; c=relaxed/simple;
	bh=nxEuByl7T+aRFKDSoofWn+vtiLfKtOreIxN4XYg4hzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qOK3gkc7CenheAHxsCjhzAFg1rRweIQIPDzYxxjZIH/C69+t3iR8yBvvgWdN2/G/hSxQc5FbNfcm2BhywStPia1cXhBGRnt9i1WSGHl4Gy0hbLrcvynJ+dkY8Q8SMT9/H/HtKvh4zUf6fjlN1fgKoV5Rxza0qx0rz84xry+lkJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=vS4sjPro; arc=fail smtp.client-ip=209.222.82.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44]) by mx-outbound-ea22-15.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 16 Dec 2024 10:10:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLrPEY/E92QCyTjQSkPZ3x8umSFD83XUqpkiOo9pl4Xi8ZFHUNbXQBcMMhcA2X1arR7mD4ilI0AnYPQeFjHU2JZr4SO9mfW4TUwX+as30VQxkZZDDwLW9aVclPWOzz3FqMYVDqvHYXfQ63lfl8yW9sDWPdHLGUq4GTs+up+LqqSA9LWlCEYcmNDYyYP4I1wDD4l70ohVOLb3vbgh+pq3Sf5/JUmGD4PEHX1EsdZgjQJ6wVy8WEOAqh1ljIzC3hfeyUNobRmlnqoI+zmP1i4Yay3kS2HOY1Dh/TFygn4QENKT9zEjxM6fuXrBv9XV1r42vnbrxT1NbVVbEcdbW+ppFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjtAdSNVH/C1Qmx7hZNZCUqJb1TCXPNK5F6bS+ibYRk=;
 b=f+ZKO0JHaJLnYyn1fYqwm0DbypxOYmlEi15DZrc0YoCkglkG16yRoO/ew17r/97inVPMqbqJ6cqCQrXRDheGNpJo3VguTwb3lkRvSnR8gUaSNLMe+rA4vlkqwCHRLSnsWuypzyE1u46HoXk+QSLSXFdMBY6Vx0LaCm1zPH0jb2qCKKpyA3631cszv/DyPtU3LyKItDqtheSq+e+rI5AzET2Cp3BYtLgBCJS50a5uBu9nkE5bpuQFci4ux46M3D6r5ciJf/jDGWDvb3cv+0xU95okPXf3CBi8R4031XBQS63YdEsel/m3Zd08gOyITetgxUFTD1d8sEj5JTXq8MC+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjtAdSNVH/C1Qmx7hZNZCUqJb1TCXPNK5F6bS+ibYRk=;
 b=vS4sjProiAKbaeyYD/nznJSqmOe0W3Gsj84rPpQM22kugJ+LzQm52Fq1diA72XPIL/n1nlE8JBvwXMMJ2d509cdU+QzCJ63+uiKSKZLCQJAF5BNAJ3+JIZFJaRvfyJI1BMl5twHLHgGPPmP+r5Z3/6Qpv2Ocyi8MyRxCETj4d81XbjpOWEh3w/3MnTW13QEQaCWuUIOlWzlm42XQLjaS4uSzsBv799laYyWKq9grh03dKzSXMntjtM1DqJfqKYcJDF62eXPyTZoACKbj04jwcVB5GrU5hNvw5sYvykppVdj4CTPzjjlscV139AF+3ud1RsCeh6Up6+5aAP+gQKhIBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by BN0PR10MB5047.namprd10.prod.outlook.com (2603:10b6:408:12a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 10:10:13 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 10:10:12 +0000
Message-ID: <908ec18c-3d04-4cc9-a152-e41b17c5b315@digi.com>
Date: Mon, 16 Dec 2024 11:10:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net 0/2] net: dsa: felix: fix VLAN-unaware reception
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20241215163334.615427-1-robert.hodaszi@digi.com>
 <20241215170921.5qlundy4jzutvze7@skbuf>
Content-Language: en-US
From: Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <20241215170921.5qlundy4jzutvze7@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0221.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::29) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|BN0PR10MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc16dd5-6d8e-4362-35ab-08dd1db9d368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEpkTVJpRExmVDFsc0hsUGFIZ3Z0cExGTE1ZanlXRGxEMUlFZ2VWQUZ5SUZn?=
 =?utf-8?B?OVRYcW1leC9kdTBoczJ5M0Y5QTVRbzlLRWc4WnFqbjdVckZTWERLcWxMbWl0?=
 =?utf-8?B?UDNML0RDMWo1THBSSkNPNEFoL3hsa014L212U2Q2OTM4YWlrU0JmNkZ5OGJs?=
 =?utf-8?B?ZGFhemw3TnNSZHlOa1hSOXNGdTRBS0YyUzNWSmMydzdkT2F1MjBSR252RXA1?=
 =?utf-8?B?TkUzNE43SXkrUXBsTUN5NXR6dzNBTVlCWWxXM1NWQ21RdWtzUENRQkRMd0Vq?=
 =?utf-8?B?ODN5K1FhWFVyV1p6WFpkRGw0MXhuSkRVd3JLL0NHT1NjNVQzcEQ2VG5VMlVQ?=
 =?utf-8?B?Y0E0ckx3d0lHdC9PUHRWc1JwVWNaWkl2aGZQd0lPT1hqYnRKdGV6SzZXQW5r?=
 =?utf-8?B?dmwrU014bHpvSlBjZjlpc050VzlseGNsQ2dvN1c1SlpTcCtPNWxGK2xaV0VG?=
 =?utf-8?B?aHp4VGdxM29qdkNCdFNNYzh3empDY1crUnlKNFV3YXV2SmlOZ1VWd2R1WkNJ?=
 =?utf-8?B?OXQ0L2JieWNvWEh2TndWNFUwTXlYMW9uL0REZGtKN2FVSGlYWkg4N0QxZTZm?=
 =?utf-8?B?bmd3Zkw1N1hlN0dHT2JZMlJFUmtNRS9RT3BHN2NhWTA2WjNuOFQ0eC85REhK?=
 =?utf-8?B?enlpcUlqMDNDUUM4VnNtelpua1BRZHN3S0JjMmpaMlozdjdxS3JDOXRNUmJu?=
 =?utf-8?B?K1JucEQrTHFieTlxYmJTbElvejdrTjdiQ2c1R1NWSzNWbEJVMFk3QnQ5UmJW?=
 =?utf-8?B?UnVzR0JFa2hUVmpWYUhwRVBCRlNPVy9GOFZhSmRkMEFpNEhkTTBIQitSTzI0?=
 =?utf-8?B?dW02UFJBZVRNZUhUeXY5ZVRIMEg3K2JQejNiYXdOYWtqY1lya2hqTnhiUlZ6?=
 =?utf-8?B?S1dVZE1yWSsvcDdLTnVySFZkN1FiK2dQcmpaUmpDOFd0Y1M2eTdIUGR0aW1W?=
 =?utf-8?B?MWptV3VHcVBUaWloeS9jbGFvcTJsNlM2OU1WYVJUV3BNV2NsclhkamxrejM1?=
 =?utf-8?B?bGtDdEk0SkpMcGFvbmp0L3dtSk83T1lpem1NRldoTi9TZU5xdEk1WjNrSUJ1?=
 =?utf-8?B?dzNRR3RRUG1iTy8wWjlraHFsY3VONVdwMnY0c2huaE9EcHpXM3psSG0vNVhC?=
 =?utf-8?B?b3JiaHlyTmlrR3hDNFVwL0FpcWVoN044b1lUbXhwUGVjamVaNDJWSlNnOElR?=
 =?utf-8?B?NXV3TURIQ1BIMlc1Q1NVY0F6cVhUdHRKemFDaUJMOWorYXN6SGRGZjRTZ1kx?=
 =?utf-8?B?WVJrSVJzT05HcXp5UkhNVDJ6bXhTVkRlY05IdE43MlVaazdpSGZFN1BIZHF5?=
 =?utf-8?B?blZ0cEVSRzF0M3JpRXdwQUFGMDh6MzNiM2lGSlBRRzNsenE4eUpKVTRHdnVC?=
 =?utf-8?B?MnZRWXhKdHlZandQbzhOTW50a295R1NTZHBkdG1RbWNQZE5mSGh5K0VvcUo5?=
 =?utf-8?B?SSsvb1hHSU9vdTl1ejJldS9QUk1TMHF4VTYrVFFsalJpMWZMS1lQaUFacStp?=
 =?utf-8?B?SFNaOVluZHAwKzkyMWpZTitnSng1dnRZTHpnV3BFUTd0dms5SE9kQmwyVzNj?=
 =?utf-8?B?LzJkWHF0RHdqUE9DaFdCSTUzNnFYWnhqREErcU83aTJzZEtEOFRFeTJnMzhH?=
 =?utf-8?B?R3VxV3dWb0MvTGpJRDBSZmhKK1ZLK1h4cnI4c2gxaStMTUM4SzAyOC9zbWV0?=
 =?utf-8?B?K1ZsWUU2L21XeTRrekVMOTg2VUdyWlJCQzdIWlZZL0FUQW1uWnMrelIvd2hh?=
 =?utf-8?B?WVNhbXY5K2JzTGV2QnB3YVBmT3NDZjF3OUxVQk52dlQzbkNsdWpZWE9neEtr?=
 =?utf-8?B?SUE3SCtvYTRmNFB0R0hPNHhjUlUzUjZoSGJrU0U1ZlVvWHZ2VHRKNExiWFJK?=
 =?utf-8?Q?BdA7e9MryijCE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWYwTThBRmRTZFVmWnY4YUdXamZTZjVoNmRSM2FhVnpQMjE3clpGTVp3MW9y?=
 =?utf-8?B?OGkvR0FFeWE5SDVhWU54RWRtTWZSbnVNQmdoVHk5blVITGU0Z0NIOEZNa1VN?=
 =?utf-8?B?T0V2NWhHTVg1MFpLMzFIS3Y2RlFmS1F4Tkx4VXpSdzFwZktWczVDLzZpR0Vx?=
 =?utf-8?B?cldNUFVFQVFITUUxMGMyaXZXS0oxQ0Nxa2RLQ05pcFR3Z2dFZU4va2dwZElw?=
 =?utf-8?B?Z3k4YmxuQXJzN0dOOHp5OWE2L3psUEJXbGVwYXZCODZqTEdsOVBMNzFIWXFY?=
 =?utf-8?B?NnZnTTJsRUplU3NQVmthRllzYU11Zzc1ZUNacXAxRytuYU9HdnRRNHdMcThB?=
 =?utf-8?B?eTdkQlYxR0RNL3NaMXpuM01sZWhyNXBPNmhiNjRQaWxRUXQ3Qks5MzNGRU9L?=
 =?utf-8?B?ZmthaWdUVlI1VkJyVmJ3RDQxVFAweWxnM09wODk4cEdhbGJ5Y0hPYkJvMmxo?=
 =?utf-8?B?a3dNQUhhbngyU243UW55L2x0dytqdzhTWUViWDR2ZjF6c0I3VmZrY0VZR1Jt?=
 =?utf-8?B?TmQySGhCcFQ4SGlrdnpocTc0VEhUaEU3V2xuUWUxM1plNk1oeWJYTDhYZDRY?=
 =?utf-8?B?MGpxbHY5emJGUDJEOUZBdkZVbnFMV3FnQjNHSzZTQ2p6dngvdElNck9tcjdO?=
 =?utf-8?B?RFJSY25vUW01UlN6am9NMko4T0RWQXZiai9hNUhFTXFnSnVHRm51UFd4MEx4?=
 =?utf-8?B?RFpjZEJOUm9vMHpobXFEaW94N0g4SllNb2Z5MUtoYjNyRjdpYm1jYW9DNjJ2?=
 =?utf-8?B?NjFQOXlJcUxjT3NoS3BGYjFCNFFZZDBGdGNVN0wva3U0QzJpcC91WnZDY2hU?=
 =?utf-8?B?RnU0VjNCazZxaWw5YzdKRjNkVFB6UTFUdS90YjZ1RjRXOVZOQUM2UmtnZDU0?=
 =?utf-8?B?Yk85SDBUZkgrNFoyY1ljd0J6aWJFZHFhMnFyckFkSFVQdEVNbmUvZFlmSDRs?=
 =?utf-8?B?U1V4cWNFTStsZzlHU2FjcWV3WGE2MDk5VWhTbjk2ck1neHdSaUViTXFxb2lS?=
 =?utf-8?B?M1JGSVBpcENTb2M3WVpUcDBvMTRMQWNDZXBWZy9DRDBQVzJSM0UxdW1OZm44?=
 =?utf-8?B?eFVnRFc1dEtHOFB2VENHbmZ4RlFOTm50Y3dJTlFCUm95TVFHbU90MGF3Q0hu?=
 =?utf-8?B?enZZekhTbGhlNUg2WVFSdDJ5YzMyY0VjTUsrU3ZBcXhQMERmU0FKbkM1eEhG?=
 =?utf-8?B?QU5McS9IUE5wME9jbDhjRFdZMXorOG1vNElFSTVnVG9vK1R2SkxTekpFcHVR?=
 =?utf-8?B?UzdpWkhHM1JpV0pITnljNVliSVBmZ1NSVVhCZHBmUklHOTB2WDQ2NWtFNUR0?=
 =?utf-8?B?UkpDVVFUQ1czbGw5emZHVGZINHlLR2JVMnFMOHc0VVlDZCtpaXFBeWw0RGli?=
 =?utf-8?B?MUZGUzdwa2Z2UW9GSEhvYnhzemZYWWg1ZjRVZVRZU1hDbzdZZ28rOVFJS29l?=
 =?utf-8?B?NFZ1ZDlSanYwOFVKNktuRjB2RUdONWpPZ3VlZjdSWU1CcGdnQVZtdUh2dHpr?=
 =?utf-8?B?N3U0cSsxOWFER3lOVUc0SDFwQXk3blZjR2R6aWVPRU9EeHpib3ltaFdEZEtQ?=
 =?utf-8?B?YmtpZTdlQ0xRVG9Vc0lpeVZVMU05bTA1NjA3L0FZdG5jeVhkY3FMS1R2bXBY?=
 =?utf-8?B?c3V6OEdVZGY5RUNGQUt0ZFVrVjNFd29wWWZSL0JwQTNPdHZHenRycEdMbjJE?=
 =?utf-8?B?cWxjOGlGMFVwdDZMeTd5ZUFBT2FUMVdQU1NtOVJPbXZEZ1NpRUNCOTRSVUdp?=
 =?utf-8?B?L3IxM01sL3UwbVZtRjdSYzZXV2pMektQRXFIUHlZbHpxd1liVVRMY1EvUzBX?=
 =?utf-8?B?TkN1a29pTGtCRUpzbDh0aTRBb2t0bng0TWpyT2k3RHhvY0VtdjU1d2VxZ1Mw?=
 =?utf-8?B?Y21LUDRNV2xQWDRTNEwxbGlOajZmMndPcUFZb3BueFZTSE1Td2tjWHMrSjFD?=
 =?utf-8?B?VDN6UHFDTnRwVndhV3RsM3dtcEd1eHJ4cjF1Z1pIZnBYOVN2TE0zcTFMdmV0?=
 =?utf-8?B?VEJUWmlxajdEMUlOQzR2UkgzVlVkSjJJSWhDYjZuRVFPU0IrV2tPVmtBZmdi?=
 =?utf-8?B?Q1oxSFh3N3Vuc3M5L0xYTlo5clFGR0o2ZTRvaFZtNHkyajI5VCtzaVRJRHpC?=
 =?utf-8?Q?VuhcbrOzrhIBAkXKG1J54VKY7?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc16dd5-6d8e-4362-35ab-08dd1db9d368
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 10:10:11.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhQET1KTrZrm8zJmbXc5xz+7UXC0gP3NBUlsViQfmhMGzHxbS9fXFEq1jBSvmKtqFI1zpz7P1DfbSvni19JApw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5047
X-BESS-ID: 1734343816-105647-22390-9508-1
X-BESS-VER: 2019.3_20241212.2018
X-BESS-Apparent-Source-IP: 104.47.57.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaWZqZAVgZQ0DLFzNDIKC3NwC
	QJSFokGqeYmhilJZkbJqVZmidbpCrVxgIAAOuATUEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261150 [from 
	cloudscan13-48.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

On Sunday, 15.12.2024 at 18:09 +0100, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> 
> Give me an example traffic pattern, Linux configuration and corruption,
> please. I spent a lot of time trying to make sure I am not introducing
> regressions, and I have no idea what you are seeing that is wrong.
> Please don't try to make assumptions, just let me see what you see.

The config I'm using:
 - Using the 2.5Gbps as CPU port in 'ocelot-8021q' mode, Linux interface name is 'eth0'
 - Using 2 downstream ports as external Ethernet ports: 'eth1' and 'eth2'
 - 'eth1' port of the device is directly connected with my PC (Ethernet interface #1, 192.168.1.1)
 - 'eth2' port of the device is directly connected with my PC (Ethernet interface #2, 192.168.2.1)

DTS:

  &mscc_felix_port0 {
    label = "eth1";
    managed = "in-band-status";
    phy-handle = <&qsgmii_phy0>;
    phy-mode = "qsgmii";
    status = "okay";
  };

  &mscc_felix_port1 {
    label = "eth2";
    managed = "in-band-status";
    phy-handle = <&qsgmii_phy1>;
    phy-mode = "qsgmii";
    status = "okay";
  };

  &mscc_felix_port4 {
    ethernet = <&enetc_port2>;
    status = "okay";
    dsa-tag-protocol = "ocelot-8021q";
  };

LS1028 unit's Linux config:

  # Static IP to 'eth1'
  $ ifconfig eth1 192.168.1.2 up

  # Create a VLAN-unaware bridge, and add 'eth2' to that
  $ brctl addbr br0
  $ brctl addif br0 eth2

  # Set static IP to the bridge
  $ ifconfig br0 192.168.2.2 up
  $ ifconfig eth2 up

Now at this point:

  1. I can ping perfectly fine the eth1 interface from my PC ("ping 192.168.1.2"), and vice-versa
  2. Pinging 'br0' from my PC is not working ("ping 192.168.2.2"). I can see the ARP requests, but there are not ARP replies at all.

If I enable VLAN-filtering on 'br0', it starts working:

  $ echo 1 > /sys/class/net/br0/bridge/vlan_filtering


So basically:

  1. Raw interface -> working
  2. VLAN-aware bridge -> working
  3. VLAN-unaware bridge -> NOT working

I traced what is happening. When VLAN-filtering is not enabled on the bridge, LS1028's switch is configured with 'push_inner_tag = OCELOT_NO_ES0_TAG'. But ds->untag_vlan_aware_bridge_pvid is always set to true at switch setup, in felix_tag_8021q_setup(). That makes dsa_switch_rcv() call dsa_software_vlan_untag() for each packets.


Now in dsa_software_vlan_untag(), if the port is not part of the bridge (case #1), it returns with the skb early. That's OK.


  static inline struct sk_buff *dsa_software_vlan_untag(struct sk_buff *skb)
  {
    struct dsa_port *dp = dsa_user_to_port(skb->dev);
    struct net_device *br = dsa_port_bridge_dev_get(dp);
    u16 vid;

    /* software untagging for standalone ports not yet necessary */
    if (!br)
      return skb;


But if port is part of a bridge, no matter "push_inner_tag" is set as OCELOT_ES0_TAG or OCELOT_NO_ES0_TAG, it always untags it:

    /* Move VLAN tag from data to hwaccel */
    if (!skb_vlan_tag_present(skb)) {
      skb = skb_vlan_untag(skb);
      if (!skb)
        return NULL;
    }

As the "untag_vlan_aware_bridge_pvid" is a switch-specific thing, not port-specific, I cannot change it to false/true depending on the port is added to a VLAN-unaware/aware bridge, as the other port may be added to another bridge (eth1 -> VLAN-aware (tags enabled), eth2 -> VLAN-unaware (tags disabled)).

Also, in the past this code part looked like this:

    /* Move VLAN tag from data to hwaccel */
    if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
      skb = skb_vlan_untag(skb);
      if (!skb)
        return NULL;
    }

So we had a protocol check. This wouldn't work 100% neither, because what if a VLAN packet arrives from the outer world into a VLAN-unaware bridge? I assume, that shouldn't be untagged, still, it would do that.


I'm not that happy with my patch though, as I had to add another flag for each ports. But that seems to be the "cleanest" solution. That's why as marked it as RFC.

Thanks,
Robert

