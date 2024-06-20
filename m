Return-Path: <netdev+bounces-105110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BAA90FBAB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF3B220DF
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 03:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A81C68F;
	Thu, 20 Jun 2024 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="vg988HNv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2127.outbound.protection.outlook.com [40.107.92.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A081224DC;
	Thu, 20 Jun 2024 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853890; cv=fail; b=d3K9XdPDVSWUZmEsMXw13Go7AeMIINjiDRGCrN3SSYb8r6gOAc7EdjIg1yykkFiMHFUayAQESWQazo9rBKmf6X1Ob2e2q7lToaa9C8qc+pXcKHOnLOhpiV4yCqKlWt4kHK++yOusd9ISjhUS7DOKyAXu71jAZMdFXaqMofVvPgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853890; c=relaxed/simple;
	bh=mircmR3r9/PYuFn0r3mWG/fjTHhVzJWwr2QmdzZZc7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U3mk+nR3JgtvwMUZttjto4v4lMkdADYw+8hfa51d/Q11pCmjAoKl3MO9h4/fohpAsTaFC5Ff/jXqlfce9jG+5SaVcqWOeV6O/8xmUUNk8AdHLLybethjqKTDilCb5B5+qB01pxyOFtG4OR3245UWJ1KhanFpNLujbLQfpuVSNcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=vg988HNv reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.92.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I775kjxqM6GSy59w74ZIrII5a4HwO7uP9NBCUeHZz9TSfHIFIu77lVSusD25Xge25lAONsPoT5tfTJ1ncM82M92FIAQ2tmXUR/pwgen4cusPfhKwxlO3PWdG/rGYrhPKPy5GM7allHBAAySTiykjEY87HBwRSgO0y1bst2xgy5A5+njdk4ufFlXkFRxBdzxh8BGJtlWor3809UtzNG/15XNrKEm7hpAku9PTkQhuIrUWJNBI9a21q3FXQBJMqslYYBt+Po2OgY6lxOvBTSho/qhUbSd0BYsC9jfD0XVAHWXtrlIN4dKiCGoxVOBymdJB4dvLDO77NUwskppEWwq/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX02kN7Gksw0Fa7BGwHvE1CIoN6Rd0MoNQxJzgipP+Q=;
 b=DP4pzP+/MX8Mssr5FGZMsugtlW5tkI3ScqJktOXeR53/zXRuFXRivXbK+kO+HGH7/trJA2TgNRsvQ+poQukgIKA24fjP0+Pa8HjFfd3gF9fXwZcsm7ExURbR6LLdwgELfFaSJxyBKBtkR/RANEfPjkv/nqd5EfF1RakK27q8k7NMDZqfSYxjeoIcy4JX5hCg1abkblLlMMsqy0iTah9k73B+lsgadOaYiIKWRvWKCabIXVa4uS6vaQaW/lC3W5XtDzwk+DIVbm4ocPsBAGB380Mut1i8JdL/FCQKriuIsa/Y16DQaSY9c9XM0cCA+jTmjPcypDDlCGjCn0HuBMTGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX02kN7Gksw0Fa7BGwHvE1CIoN6Rd0MoNQxJzgipP+Q=;
 b=vg988HNvFWpHcIrmfknD4krpE7z1r/RcXCQL6YUS3MKHoR7qHTUe0jhcf85Zp9Ct03TFP03fFBDANIsh54blQTrE+WN1wbgkYti6jun/ke3oMZ1Zr1MyLE2B+nHa7s9mOHJvTRTT991wZC65uNKdfkLvirUFrKMV8bQoomfVfhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MW4PR01MB6244.prod.exchangelabs.com (2603:10b6:303:79::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Thu, 20 Jun 2024 03:24:45 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 03:24:45 +0000
Message-ID: <652e2d45-749e-4492-a00c-c0a2d15ab3a3@amperemail.onmicrosoft.com>
Date: Wed, 19 Jun 2024 23:24:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
To: Jakub Kicinski <kuba@kernel.org>, admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240619200552.119080-1-admiyo@os.amperecomputing.com>
 <20240619200552.119080-4-admiyo@os.amperecomputing.com>
 <20240619162642.32f129c4@kernel.org>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20240619162642.32f129c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MW4PR01MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b20acc-a661-4893-5341-08dc90d8887d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVVJcUVCTFZyT3BSd25wMUgvYmFheXUyM0tEMlA3My82TDNwNTVMNkV6UzJH?=
 =?utf-8?B?OEtrTUQwbEhWU2NWcUgySWhrVi9KNStCc1VNcFNNNXJYZ2N5MVRUOVNteGZF?=
 =?utf-8?B?dDlBMk02bDRvU0taVHIrQ3JpMlVaSVpTMDVvQVNBZVYwZ1UyS09qZm9kZHJm?=
 =?utf-8?B?c0ZSV0NMSDlrQmtWcUZMa08xZ29QeWEwTGlQeVVScGZGbnBTMmltTWFCaGFS?=
 =?utf-8?B?ekl2TEthZFFwNk1aemp1TVlaMTdnaHJnRk1JaXRhejd2dlJobGRDZEM5UnhC?=
 =?utf-8?B?alJmUnpicTJreGgzZkVVSEtIU1dmSHR2YTF0Y2J4dXBWdTFiVG9kU3phVG5j?=
 =?utf-8?B?Yis0ck1wVEIyTDFCajhqdTNyditjblVSYmdSVEs2VTkrZHVjRVJVZjg2eWlq?=
 =?utf-8?B?UkVzd3B6L0dybWNEZk5MTFlDRFZKd0I3TnM4WDkvSEhDalJvNUw3VU1tNWE1?=
 =?utf-8?B?cDI4ZXNQVlp6Vm45Z3pBS3JjSE5CRHl1dS93L0NaQWk3R3ZxbGk0ZG5qV3FM?=
 =?utf-8?B?VmpzQ3FYR21sZ3ZuaXkwUkJ2b1dzSmlGbGJ5ZGZySUhvNjVmbExyazJkVXhp?=
 =?utf-8?B?d1M1ZHdnU0I1K3g3eXovNlh6NE95R3BMTGZKWXlyNjg1dE5OL1lJcWxVbVd2?=
 =?utf-8?B?N1BFb1NVcEs0U2V6NGxWMDVlU0hzVzFTUEpqYnhDRUw5M0ZoMndyazBvSXlM?=
 =?utf-8?B?emtub3FXa3V0YS9FS043cGFDYUJPbTQ2RFN1N2cybDZqamQ3dCsvUmdUdjJM?=
 =?utf-8?B?Q2hTMU53Rkx1TkJWdWFSZE96K1pkdEFoSmZYTmZTdFdJbkxFRkxwWkwyeXlo?=
 =?utf-8?B?UkwzRS9Ed1ZWWStkbmRlNk1aeXJtamNpeWRvcnFOejlYZHQxZTFaWWlORzdt?=
 =?utf-8?B?ZHhkcVhFLyt2VHVaSDNtYk5FeXBMVXNGd1VINGExTmgzUEtZUnRMQVFTOHc3?=
 =?utf-8?B?VkFWQjN4bjJmclp3N1hsTTZkSTdQMEljQWhYTmp4Y0YyTGNGVGJQTTVDNGpL?=
 =?utf-8?B?cnJuT2tlS1dLSlVEdEM1RDh6YU8xQlRGcFcxOWx2ZTAwK0Mrd05acnRudG9K?=
 =?utf-8?B?dzBGTUxYS1VBK0lnajFGaklxNjRGSTBsdUEwOVlFMk54bWlEZHJiczNLendJ?=
 =?utf-8?B?eTZnOFFjcXgzalZNS2tVS3BPc25SeGlYdmUxc0owbDVmdXNBRkl2T3hiRS8w?=
 =?utf-8?B?QVdHUnljMkJwSnNlQU9LWUxxR2w1dmd6MXJwZVpndXJ6cWpzaFYybXlmdktP?=
 =?utf-8?B?cURQY0VJd1EzT05KTjlGYjJVU0ovZXlSTXZyNU1Za25HcVpBRlpOdVR1Znkw?=
 =?utf-8?B?akRWQVlobnJoeVIvTjlUT1VIU3ZDbDNZWHJ0R1BqbWh1Y25zaEE2VUdOd2pM?=
 =?utf-8?B?U0hOTDlLSmgwVGh0ejNjTHVmalpBZzBnMldPdWd6T2dabzQxY0g1dDl3K1B4?=
 =?utf-8?B?NnV3bWFLK2tTYkkwTHZUTVNiRGp4Tkw0Y3pCcWYzYlFPR3VManpYTEdGSW1j?=
 =?utf-8?B?REV4OUtGNFNkK3FrNUFkbFBKMGEwV05QWGlQSVRMcVV0NDIyM1puZm1aVmFW?=
 =?utf-8?B?bUx6S2JRbzEwUHNMMnI3Q2NUbEpjSk5uOGFibWozdEFjSW9pWGY0L3ZXdnBZ?=
 =?utf-8?B?d3ovQnFRZXFabWJtQ3lYK0dHQ01NbTcyMVlIbzR5dUNmTjZXWk5XdmVZR3pp?=
 =?utf-8?Q?LcjHIvshWGUvIZEBE7l5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0hqZWh2L3VtVHFmUCtGNW90ZDh2TmhNQkNFUDN6SmJrM3A3T3ByZkd3elAv?=
 =?utf-8?B?T3NKYzdFeS9qODJ4L0Fqb3Z1VjBSeWp6cEZHM0pHNFFXWXZTVENzUnVpNWhq?=
 =?utf-8?B?eThoTTBsakRMOW5yQ3hUaDhMOEpsSStKck1wNDFmcmJPUVB2eEtHOUo5Zmsw?=
 =?utf-8?B?R3NXWlIvbDlBUmFXSnFuclkyMHo1K2xwcHk4N09VMEE3ZUQ3ZjM0UjRwSk9T?=
 =?utf-8?B?VDRkZmtpZml3Ykxwd3J6RHRSR1ZkV1Eyc085aUpTOS9td0xyQlhES2UvYzR6?=
 =?utf-8?B?aHgrOE1JRzZaN1JxVTdrc0U1T3VLQytFcTVLbHNXRnI2cGpmaUp4cHBwVDN1?=
 =?utf-8?B?S2w3elNWbWswNm1xK2tNbHcvTTB1OW0xVmt5am9uZHE3emhqOGVZa1hQUysr?=
 =?utf-8?B?YTVKWVcyVDJZK1VEZVBOc3RHdnJ1NThFdzFDcWlRTXFHaUNnOGtaSnE2Ly9V?=
 =?utf-8?B?VmttckdKVlZpcmxNRm9SY1lmN3RQdHV1d1Zzb3NhNTByQzhHOVpLVE14RmZG?=
 =?utf-8?B?Nmw4REprVTFxelplYUxubkk5TFJlc0RRQ1FtbHNJYjJLT3YzeXdLOG8wc1ln?=
 =?utf-8?B?STZZT1JucVZaWk5oSXg0eWpRcS9Cd1hwUmRqUm9IRFN1dnc1aGxWTE83amF0?=
 =?utf-8?B?NlJSUkMvM3FXZ3ZFbnpReVBrdEQwaXMxU0tyQ1g1OXhNbkloMjdqd1c4MkJv?=
 =?utf-8?B?eWlDcjZWckpaYmZXOFRJcFNJVG11ZEgwRXhyRVpDQkVPYWFZek9icmk1TDNy?=
 =?utf-8?B?RWhLQlN1QnB0dm4zVW9CREg1L3dYK0JYc28vb25qeis2MjI1cFdOQytrTFFY?=
 =?utf-8?B?WG1DT0xZUDJBWlA4N2hPeHY0ZXFqeCt4bG4xbUlONHlLQ3RIdC9DWVZubDhq?=
 =?utf-8?B?aU9WRDFxaW1qMG1XYzNNQk1FRlFTQXZTbHV2ODRIR3RUeHVXMFk5OE9FSUE5?=
 =?utf-8?B?TjBZeWVzUks2MDdubzRkZUJnUGpmSWJKV0xqYTVwQlRlVWJOcjc3eGwyNHEr?=
 =?utf-8?B?cEJnam1GY2xod0lJL0xMbjgwdmp2SlVlc1FoS0ZROTFVNWJBcjRralFZOTB3?=
 =?utf-8?B?ak5QMWk5a0Q4N0hjYVlKMnQ1S2JPbm1hVDhKN3VWaDdvZ0FveHhrdFU4alRo?=
 =?utf-8?B?WHBrb2VFRit2S2Q5U29WdzhtSWxHMytSZnQ3VTRVZHE2TlNNVXZpamkxWk53?=
 =?utf-8?B?R3dISlhRMk85SVpTclJVTlF1M1FrWGNpZ1dXcDUvK1BQK2JmUGh4dVpoeW9h?=
 =?utf-8?B?L2c3dVM2c09UUHVrU2hZd1E3L1Z2YXFlcklIeG9zeFF0M0N0OEw4RndtR0Vt?=
 =?utf-8?B?QnhZdHlFenIzaFgzQkJyQ1cwaGpDVVczdXpLVTdpcWpvRzBpYUtPU1l2WEhz?=
 =?utf-8?B?WkVXOHZPRi9DR3h6VTRXUWV3ditlQ00zSXRiUzc2RjIvbnZVb00vRHp1TENk?=
 =?utf-8?B?M1BVc3lYaER6OHozdFJmYUNGRSt4NHRMYnFyRFhKRGlNTVJoTW51a01HUUVo?=
 =?utf-8?B?Q09TVVF0TFNRZGFqa3FGY2IzZ3lEajhxS2x3aUlFOWY5ZnlPTkpwWDVuY3dz?=
 =?utf-8?B?SGhUdGJXc09GWDlpU05HYWNMZ1g1dTNkSEljdEJjUW40TzAzbUhuN0hzS016?=
 =?utf-8?B?dGVjQ2tVS0s4blowUU9LQlJUd200Z2dKbU1xeWtDb3U2NjRUQXhmUFVxY1B5?=
 =?utf-8?B?bDIxTkY3MDNnUmN3djY5TzBJL09HamtoNUU3d2xZazNSeXJxcXhCRGhNSDB5?=
 =?utf-8?B?cW83U2NYMU9udVFkaUNCRzQzVmZTcGtoUDFzRkNGSlNKdHh0QzZuOThaUGZO?=
 =?utf-8?B?TlBNY1c5ak9WbENZNFE5WDZ6RXNyQVFYRG5CRWFOcldpaUhVSUJHelNqRUo5?=
 =?utf-8?B?SEZUWTh2WTM4dTROb0UwUEIvTkVnK1FEbnhJSEhXRGFoZDZpT0laVkhLUUk4?=
 =?utf-8?B?a1BLbmV2eHVMSTYrMS9EQUJpOGFzS3VKbHVSRkduZVRmQUFXRU4vVmY4NFZ2?=
 =?utf-8?B?Wm85QUdyYWVXWFQ3WHZwdVFLV1VMVFc2enZtVFhQVWZqNFBNbWlPNERnYWk1?=
 =?utf-8?B?dUtHNUFLUVVrZGlMazF6a2pVVG9hajRpcHhnbDN3dG9PdGFTYnl5UVJDQS9p?=
 =?utf-8?B?d3lKQnBiS2pTVWE4TkFnLzNDVlltZDJrMFhobm0zK08vSHRaQ0QxcUZzR25t?=
 =?utf-8?B?VVBTbXdCa1BvK0svaGkwK2FEcjJXUkZhWHRHQ3hSbkJaWVhkYmFQWURVUjgx?=
 =?utf-8?Q?o8DMjcLlXAUdOmObiR7XGljFH4xxCznGiPhBCpLYdE=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b20acc-a661-4893-5341-08dc90d8887d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 03:24:45.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IToNx+W4gexeW9ZfhhHktw7Hz1cUa2hscjhWjin9xsr9gG0jAqzjB/ETkXqdoCF5057BZiX4hu7424ddwc4/cJW2Elrsunaynw+s7Qh8LeNAy7NBIXOkT5AhEUpUTwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6244




On 6/19/24 19:26, Jakub Kicinski wrote:
> On Wed, 19 Jun 2024 16:05:52 -0400 admiyo@os.amperecomputing.com wrote:
>> From: Adam Young <admiyo@amperecomputing.com>
>>
>> Implementation of DMTF DSP:0292
>> Management Control Transport Protocol(MCTP) over
>> Platform Communication Channel(PCC) network driver.
>>
>> MCTP devices are specified by entries in DSDT/SDST and
>> reference channels specified in the PCCT.
>>
>> Communication with other devices use the PCC based
>> doorbell mechanism.
> This patch breaks allmodconfig build:
>
> drivers/net/mctp/mctp-pcc.c:116:6: warning: unused variable 'rc' [-Wunused-variable]
>    116 |         int rc;
>        |             ^~

Funny, I see that only when building on x86_64, not on arm64.  I will fix.


> drivers/net/mctp/mctp-pcc.c:344:3: error: field designator 'owner' does not refer to any field in type 'struct acpi_driver'
>    344 |         .owner = THIS_MODULE,
>        |         ~^~~~~~~~~~~~~~~~~~~

Not sure how you are getting that last error.  I do not, and the v6.9.3 
code base has this in include/acpi/acpi_bus.h at line 166


struct acpi_driver {
         char name[80];
         char class[80];
         const struct acpi_device_id *ids; /* Supported Hardware IDs */
         unsigned int flags;
         struct acpi_device_ops ops;
         struct device_driver drv;
         struct module *owner;
};

> In addition, please make sure you don't add new checkpatch warnings,
> use:
>
>    ./scripts/checkpatch.pl --strict --max-line-length=80 $patch
That runs clean.
>
> Please wait with the repost until next week, unless you get a review
> from Jeremy before that. When reposting start a new thread, don't
> repost in reply to previous posting. Instead add a lore link to the
> previous version, like this:
>
> https://lore.kernel.org/20240619200552.119080-1-admiyo@os.amperecomputing.com/
>
> See also:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested

