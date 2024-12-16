Return-Path: <netdev+bounces-152250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632BB9F336F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D687A1ADF
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3221E493;
	Mon, 16 Dec 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yn/CRSti"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A9B205E1A
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360270; cv=fail; b=etet0UZVmNqNTt/U/R5pRSOug8ET1jVR6X9DeemDAQeIKTKMv8IAt4CGisIgL45SUaBWX2j/yyq6iQbvlYtv7HQ1x+8kQ9xeg9Ao16iR7tAYKiyK6CdQefG26biORMJjVULGoSI0hvztSgc94vUIQ33DfCrP+HMJpkIHOP7mJoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360270; c=relaxed/simple;
	bh=x7nH7lyH513InAdIIivtJGE828MmX+7kG10TzfFsjFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UYvmSyzK2y3PdK/FI8k+GPnftexehSYG2llAUbfnNQ5fHnoDZGk3TojdcteSUYNSLhl+FmlSlQ2FBwCWtJ3C2sAuDI45WUfIncZOrarjb+nWeRqShEMhjd5NLpG7jNW3IBKWiTwFbSIveI6StTTG2H6DmphfaCuJlG1FPckWsko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yn/CRSti; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJB0jXlouyVog3FfE7UamnJIyMhY/vmxcJOe/RI9nTUEk6o+NyqkWr/w5qUx5j4UAyrGnrfxnBiAhIL7sFeTknn8tis805ScEcbWDs86O6HwNAEWSn4JCqV+j8qOh5NmXuEzmY9JsP4/LargnNsUGLfIaqbq4OnUzkR9xcSeQ9fRkCJHDGcaTZto33gD8aA9cEHMNRZWsV60eHh4zq00IjgtZ4sgsqoRXK9sAyyGsqqAqR8b3/mfRkO8psrkeBKZhcoXCot4cnRUeCqTMm89CnrhBwfe+eYOAxAvpjS2V5I/wMi0um7mrdrqrGdShj0ZJzwK5KJflfpfsYzTK/JubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkUx+S7frJ0pZAXPwKBPTDyqwkUQs5uTUdbmCRi96kQ=;
 b=U9TK79aPmAG56FYh5l6PVFyx08x19TXtocKnzCOoIMEE1ilmdm/9MNtJOHZvVbNNHtzI9D8Cykze6RGn+GhOf9l/SWhuwU+G6d36wi5Slq4VG8IdyPk8X/TfLl+ltA5Yl2UtZfoCKzdqpqTK3tz/7v0ds/cOwnOvHJ8OmElSCDOkIHcxRrP/oJJ96hYflhot/sk2b3X22HgQ215CM/2KJf9K9Y47QQ/0/c9yY3jAT5cjezrlwxqaDg2el2UU1+dgINQnRecN0M/N4fisgIvo4sNuRTqtfQwlpt4j23Oa5SRKtu3v1O3TBlwODG3cCKASXzJmeUQTevOa5qw6dY/FXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkUx+S7frJ0pZAXPwKBPTDyqwkUQs5uTUdbmCRi96kQ=;
 b=Yn/CRStibY7Pv1HATNMNEmN5YCu9VZWAd29Cc8C9HJqNDHcQFifW9TcZC87drJc2ClNt9to5MaRG1rQi7hijMgWK8Ce2nEw4GCZBM0oiIRKIDlpQht+9yC19q7Zhd7/jag03aXRyKCPG+WJ2qc/UHrpyqI5nDcWkBoTHHRdKTDI5vHd/wi2uVRWkqGSehC5cL4nurCtX9oneTP5tOAdkW7jfpSExsRP0lnuKb/ww2KIPTF+kbxNHpvXTrRO5Jtu+vCf0Oi0RF/HOihjKVrLDO00jLZZU2GfBTJ+fWgGwzTpN8BzgaYZ0V46talU8HjHBKII6dDUnwhZZPpKJUjv4zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 14:44:26 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:44:26 +0000
Date: Mon, 16 Dec 2024 16:44:15 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	gnault@redhat.com
Subject: Re: [PATCH net] vxlan: Avoid accessing uninitialized memory during
 xmit
Message-ID: <Z2A8vwvlKMqQf8jQ@shredder>
References: <20241216134207.165422-1-idosch@nvidia.com>
 <CANn89iLt9uKxzcceP=xWp5gr+VmghsZROwjHtK=878zDQ+7BpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLt9uKxzcceP=xWp5gr+VmghsZROwjHtK=878zDQ+7BpA@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b3baa4-1056-4751-c996-08dd1de02332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkhBYU5jaTVYM09oT2FMdi9qZ2QyMmFrK25iQThSK1hLZ0o2cU1KOGhQdVdJ?=
 =?utf-8?B?V2d4aHdiSVR5ZWd5V0diYzNLTXI4OWtWU3JFYktIUk8zVUlSWG5VNlZJUVVL?=
 =?utf-8?B?T0srOFRHSWJoT2NKTTZ6K0pKNTBrcmZYTnJzb3hoOTJ4amFxbTVSUGhqM3Z4?=
 =?utf-8?B?UkJQTUtMT3JLRUhDL2k3blNuSzl2NTdpVlIyZ2NCVzJrSW8yZ1o3NjdnZkJ4?=
 =?utf-8?B?U0pQQU8vUzBmb0ZkMkNuaE51VmFLMk4vaFcvcjFvYkV0S1h4UmFWWVg5WnB6?=
 =?utf-8?B?T1IxaDN3SjFyODBLOWNDbXBQMmdhRFZMOWV1VEhKaW9wZFdWNHFsWnF5NjhL?=
 =?utf-8?B?RmZUUDBFSFVxc0RMRUxxcmRneUJkZUUzTzdOay9HUGpJU2xYNy9TZGE4aDBs?=
 =?utf-8?B?amxmQ09ySnF2b1A3R3hpQ2ZvQ1J5S0VhVHlzb01aQlBtMEFaR3MwQVpQUThj?=
 =?utf-8?B?WTZJL3VGMXlZYmFoMGtGVkZudzFCWXIyc2RqaGJZUlVJUHVjbzd6WkY5ZStP?=
 =?utf-8?B?eTN5eTA3VWtVeU9peE5YZU9uM1JqeTdrcGhFTTRYLzZJK2Z3elFCK1Z3cUtr?=
 =?utf-8?B?U0FwSG9LM2pNYW1Pakd2RnQyTnBHV1gyL1NJNG16VXdsakJkb0h6VmpNWTVQ?=
 =?utf-8?B?Z2M3MEs2emFDbU42d05ON1ZaNXl1SEV3L2FJS1BwNGRlSHdVeHJEQWdtaVla?=
 =?utf-8?B?NVpXQlVrN1lZQy9wNHBHRmtPYXYzUWwvZ3dMNWJzcXp0eWdyVjdPTVdBN0x2?=
 =?utf-8?B?cEFsNDViM05GYmdsTTJrb1prU0h0ZUd2M2xYSkNIUjVGRi92UmVSVkpWMDly?=
 =?utf-8?B?N2doelQyVjRGT1plcWJpdTZvcjhvaUVMNHFuUnp5NzNybFZhaTl0UzhlRjhH?=
 =?utf-8?B?UzFwZDVYOG11ejMzaXIyY29HeHBzMkFFbkF2VTVKSlNFeThva1d2Z0plRHk0?=
 =?utf-8?B?SFdEQXh4OE52OGNkV0RxWlJoMEdwaHJod1lJU05pcjY2N3BCYkdZTUV6bkpn?=
 =?utf-8?B?TW5sOFhWOXNnMkJDd3NHZVhiNCtqa1lPcTg1aUJKZmM0TXNQRENwQ3hPQU1X?=
 =?utf-8?B?dVByWW5ySnhuYW92WHpXMU5hSHJwUTJrbTEzWktlcW1lbnQ0bnpUODE0NDlV?=
 =?utf-8?B?NVh3SlZrR1hQbTIyUzEvNy9HSkd5VlF2S3ZhS1R4S21WY2ZYUEtrekpNSHRZ?=
 =?utf-8?B?NTBJNmZhT1BySzZYYlhWWlFzTG16TjBlUnUxY2gyUlVwdnhEdFpxMGxzSGI4?=
 =?utf-8?B?M00yb1IzWkx4VjZxb1RIeFRxY3dCT1plTngraVFWNitiWDhOT1ROSTc0VlZr?=
 =?utf-8?B?cXFDSzZiZC8vSEYrSGFIV21ubmMvemhSRWJxTDk4c0dDa0NvN0t0T25GTExD?=
 =?utf-8?B?cFFqQnNoTzRGRnNYUVJRUURlS0duMG5ZTjZTbDFQa09sVkpTWm5oc3pIMUpm?=
 =?utf-8?B?K1J4RWYvUC9LaFkramdQR0o0R2VYNW0ySGxMOGFYbU1IV2ZuNlU2c0NIbzNn?=
 =?utf-8?B?T2VlaXlvcHdyS1RKNGNwUGdRRis5ZkE5V0huNUdGSEg5blFyZVFCQ0JJVXla?=
 =?utf-8?B?dWh4RjdEdytEQ2l4TUh1ak1xTERSNHl0RHRDY0tPQWRDUGJ4OVNDOWZJSjVC?=
 =?utf-8?B?SWQzZjh5bC8ycXlkU3VaME9QblJnZFNMSFJ0TkcxelNUTnlmVTZEWkxsYW5Y?=
 =?utf-8?B?MDhhSWF2NEhSRXU1aFcxYktDOXJIbU5tUVdJejJGVnk5SExCRmJyY1JvU3lq?=
 =?utf-8?B?RGNoZ2RzK2IrT0xWZWlXLzdxZnJYNlgwckZ2V0hBNmlPeUJSeHlCZmdaYnh3?=
 =?utf-8?B?MC9oZlFZQXlidG9YWHM2OVpDRk1qT1E3ZEF3SWs0TVJZWTRhOCtSVWZiQ2NE?=
 =?utf-8?Q?wialMnOXG9GkX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmZzMUJ2U25yaEt5RkprL1YxQStWa1RjeExOR3BxWms1QjBBa3R1Z3V0aWVp?=
 =?utf-8?B?MmVPcVRIN3p0SWh6dmxETGlYV1VLUGxxblhZTHJEV1pLa3lySWltSklJM29u?=
 =?utf-8?B?WGIraGdLRjZ0aTZ4M0dSalJCTGdEU1VnMDVwNXRRRnZqQWJ6bTFGTHhKTWVT?=
 =?utf-8?B?OC9vTy94aVpJVXF1bnZUZysrMWFZZWVtVk1wR084M3prOGg3dmd2bU1tZFE4?=
 =?utf-8?B?bS9jbVlHR2JDenE1T1cwVEdudGEzSk1oYTV0T3Jsd2hsblh3bHI3U1BZRmpK?=
 =?utf-8?B?MFRZYVB5YU9nWTd0c0pQQ0VtdmtuZEU1U0hQbjFGREJiVmhTVHM4eTA5d2RH?=
 =?utf-8?B?VUNoU3BJanBhaXMzRHpPdThVakpPaklJVnlVWHlYekN2cnJQZXA1WTB0eVpx?=
 =?utf-8?B?TFRwRURyZWtlTFdDekNDUkxlRWo4QmhoRjRvZDRZUDZDZDNHQisvZzl6Rnhv?=
 =?utf-8?B?OVVHY0xWeSt2SEZ4aWl6UG5VQzAwVDU3djdJWURTYk1mSHJaOWp6SHEwak03?=
 =?utf-8?B?WENCOHAzVXJBZDNIYnRSZENMUWtYQjZDNWJsUW1OcWh3ekRGZnE1UHFiSUJS?=
 =?utf-8?B?TnEyNXZqVWtSWDBtV2lZNFNhSHNBd2tBSy9HV3k5T2xxQWljcFVOMXA2SENE?=
 =?utf-8?B?bnRjMkRucXlRcVdROGFVL1NPK3ZMZ05tMFo5L0FVUS9udFBRek1PSWlsNTdy?=
 =?utf-8?B?d3RZOUh1ZEQ5TE1nSEdDYnJBVUY3WVAybjY0QTJWLzg2TktNUEo1TXRPcHN1?=
 =?utf-8?B?Ymd4U1RPM1BvWVJndXpGazdWaEhCUHVnRisycUZSd1p4Nnd2cmhsTzN2KzBG?=
 =?utf-8?B?QWU3dDd1Zkl1MXJVYkcvVzlmUzd4MXBTZWlnNjBkcFVjQUtOT1Y5cEcyOHpT?=
 =?utf-8?B?M21HRTdMTndsVEpOc01vNngzRGc5TEVnOFZ1NVlEV0lGS3RLYTUzY0w1eWpr?=
 =?utf-8?B?bVRETXduTExiTmN1NStla3FoNG1hMUhIN0xqY01ReEdQcUROTEt1b0ZpS2g3?=
 =?utf-8?B?WXNsb1gxaXVLRFhDRmZjclZoWXM4NmZPVnFtOEZlN1BSaTVpR2kwRzZVZ2NH?=
 =?utf-8?B?YVZLeENxT0dUUU8wdVhibXhGTHU5cW9uTmVVWjYzUmRCbGRhWkN4Q3VoYlRq?=
 =?utf-8?B?aGNXN2EyOEYzVURMUkp5TTUzNUhiOG9OOUVqM2lTbFZDYno1TVU3N2I1WEZr?=
 =?utf-8?B?L1lYVGozdG5Ca3lZaHpVeWdtdDdmbmJBaVRFNU9MWU9MVUZad0RnTmlkbFZY?=
 =?utf-8?B?eGxJdUU1VFFUaXhaSmtsY0UwNmwzV3c0TjZ0NEQzTTVrd09DRnMwYmt4OVZR?=
 =?utf-8?B?VHRkV09aTmVSZjRyMTYrUkxqbmNJZWJhUW0wNmtuOGw3R3VIQzFkb3o5OC9X?=
 =?utf-8?B?OUtDTktpbitWb2MxTk1JNDBPMktsTC9OK1QzR2lEamNsN3htRHFKaEZtT082?=
 =?utf-8?B?VzdMSUpTWFdhbHlmVk9IYWRnVWtHRldWU1dyejhZRVpoU0loNXM5VFZsUFlX?=
 =?utf-8?B?WUpkZk9uTFJLRTQxN3pVeW5KV0djQ1RaSjVGZ2MxdDc2OGJKckp0T1VWWVlN?=
 =?utf-8?B?KzQzL21zTkM1aDRmYkQ1L0FFb3dXNVFGa1JmTldkQVBmbHFuVUQzWmVYZXF4?=
 =?utf-8?B?VW5oRWhNbVViNGxUM3FqNnRlQ2FwSzRzRlBHOSs3MTBxa0NWZjd6alpmRCsz?=
 =?utf-8?B?SjNWQmt6TDlVQ0VGNyt4YTBrNVRBcjFZOFg0d1dLSjdoa2hxUXVjVUppT3NM?=
 =?utf-8?B?QUNwcEw1V2tudTdNeFc0V0h2NHhjZytjdVJLUlNmOUswWUxIWHRaUWhESDRP?=
 =?utf-8?B?MXg2V3duZGF5YzYvckhZTHIvZGRmWUpBaGdFZGp4VjVTMUNWbXI1TzVNc1I3?=
 =?utf-8?B?aWdXYWc1dlZISVFKZnI4U09zcnZuOUVobC9Hc0NvNk1PN29LVTMwZXY0c2Vt?=
 =?utf-8?B?djV1U1diblVodXRxT0U2ck90OUlIWkw3eGxXSjkxN29QbnVwTGV5SzBkcnZp?=
 =?utf-8?B?c1ZyQnFiMFIrSGV3K2Q5MW5NWExjcFFDZzZ3QTRsVGRxV2JwMUdjQ0RkYWxQ?=
 =?utf-8?B?NVBpKzlHOTdjdXpkeG1saktFMEsyZ3ZsUEgxTUVxL0RFaXdLQjM2czdKeFln?=
 =?utf-8?Q?xjeFYky9j3Nw8MxVX4TJGr2N2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b3baa4-1056-4751-c996-08dd1de02332
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:44:25.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycp0FciuDr0b/K2/enyUBAJnx0xGAIcFLgQUzsUviX9CMUxgYr/LIZIGRtrXoWisdg8/ld5WdtPvVD7BCo/cbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

On Mon, Dec 16, 2024 at 02:48:04PM +0100, Eric Dumazet wrote:
> On Mon, Dec 16, 2024 at 2:43 PM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > The VXLAN driver does not verify that transmitted packets have an
> > Ethernet header in the linear part of the skb, which can result in the
> > driver accessing uninitialized memory while processing the Ethernet
> > header [1]. Issue can be reproduced using [2].
> >
> > Fix by checking that we can pull the Ethernet header into the linear
> > part of the skb. Note that the driver can transmit IP packets, but this
> > is handled earlier in the xmit path.
> >
> > [1]
> > CPU: 6 UID: 0 PID: 404 Comm: bpftool Tainted: G    B              6.12.0-rc7-custom-g10d3437464d3 #232
> > Tainted: [B]=BAD_PAGE
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> > =====================================================
> > =====================================================
> > BUG: KMSAN: uninit-value in __vxlan_find_mac+0x449/0x450
> >  __vxlan_find_mac+0x449/0x450
> >  vxlan_xmit+0x1265/0x2f70
> >  dev_hard_start_xmit+0x239/0x7e0
> >  __dev_queue_xmit+0x2d65/0x45e0
> >  __bpf_redirect+0x6d2/0xf60
> >  bpf_clone_redirect+0x2c7/0x450
> >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> >  bpf_test_run+0x60f/0xca0
> >  bpf_prog_test_run_skb+0x115d/0x2300
> >  bpf_prog_test_run+0x3b3/0x5c0
> >  __sys_bpf+0x501/0xc60
> >  __x64_sys_bpf+0xa8/0xf0
> >  do_syscall_64+0xd9/0x1b0
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Uninit was stored to memory at:
> >  __vxlan_find_mac+0x442/0x450
> >  vxlan_xmit+0x1265/0x2f70
> >  dev_hard_start_xmit+0x239/0x7e0
> >  __dev_queue_xmit+0x2d65/0x45e0
> >  __bpf_redirect+0x6d2/0xf60
> >  bpf_clone_redirect+0x2c7/0x450
> >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> >  bpf_test_run+0x60f/0xca0
> >  bpf_prog_test_run_skb+0x115d/0x2300
> >  bpf_prog_test_run+0x3b3/0x5c0
> >  __sys_bpf+0x501/0xc60
> >  __x64_sys_bpf+0xa8/0xf0
> >  do_syscall_64+0xd9/0x1b0
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Uninit was created at:
> >  kmem_cache_alloc_node_noprof+0x4a8/0x9e0
> >  kmalloc_reserve+0xd1/0x420
> >  pskb_expand_head+0x1b4/0x15f0
> >  skb_ensure_writable+0x2ee/0x390
> >  bpf_clone_redirect+0x16a/0x450
> >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> >  bpf_test_run+0x60f/0xca0
> >  bpf_prog_test_run_skb+0x115d/0x2300
> >  bpf_prog_test_run+0x3b3/0x5c0
> >  __sys_bpf+0x501/0xc60
> >  __x64_sys_bpf+0xa8/0xf0
> >  do_syscall_64+0xd9/0x1b0
> >
> > [2]
> >  $ cat mac_repo.bpf.c
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> >
> >  SEC("lwt_xmit")
> >  int mac_repo(struct __sk_buff *skb)
> >  {
> >          return bpf_clone_redirect(skb, 100, 0);
> >  }
> >
> >  $ clang -O2 -target bpf -c mac_repo.bpf.c -o mac_repo.o
> >
> >  # ip link add name vx0 up index 100 type vxlan id 10010 dstport 4789 local 192.0.2.1
> >
> >  # bpftool prog load mac_repo.o /sys/fs/bpf/mac_repo
> >
> >  # echo -ne "\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41" | \
> >         bpftool prog run pinned /sys/fs/bpf/mac_repo data_in - repeat 10
> >
> > Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> > Reported-by: syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6735d39a.050a0220.1324f8.0096.GAE@google.com/
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> > If this is accepted, I will change dev_core_stats_tx_dropped_inc() to
> > dev_dstats_tx_dropped() in net-next.
> > ---
> >  drivers/net/vxlan/vxlan_core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> > index 9ea63059d52d..4cbde7a88205 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -2722,6 +2722,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
> >         struct vxlan_dev *vxlan = netdev_priv(dev);
> >         struct vxlan_rdst *rdst, *fdst = NULL;
> >         const struct ip_tunnel_info *info;
> > +       enum skb_drop_reason reason;
> >         struct vxlan_fdb *f;
> >         struct ethhdr *eth;
> >         __be32 vni = 0;
> > @@ -2746,6 +2747,15 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
> >                 }
> >         }
> >
> > +       reason = pskb_may_pull_reason(skb, ETH_HLEN);
> > +       if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
> > +               dev_core_stats_tx_dropped_inc(dev);
> > +               vxlan_vnifilter_count(vxlan, vni, NULL,
> > +                                     VXLAN_VNI_STATS_TX_DROPS, 0);
> > +               kfree_skb_reason(skb, reason);
> > +               return NETDEV_TX_OK;
> > +       }
> 
> I think the plan was to use dev->min_header_len, in the generic part
> of networking stack,
> instead of having to copy/paste this code in all drivers.

Are you referring to [1]? Tested it using the reproducer I mentioned and
it seems to work. Is it still blocked by the empty_skb test?

[1] https://lore.kernel.org/netdev/20240322122407.1329861-1-edumazet@google.com/

