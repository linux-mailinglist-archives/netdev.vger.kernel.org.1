Return-Path: <netdev+bounces-162421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A4A26D52
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6921888F97
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1672066ED;
	Tue,  4 Feb 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="PZTp1oVW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2102.outbound.protection.outlook.com [40.107.241.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E12063FF
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657834; cv=fail; b=BIGfqTJVf1LOngB0QYgUDGzs5lFlZNeYkPO4IKHPnaqCEqYDjcxnkhguhGLgE2IRdkRc7yM9bua82Y6fWl+CpEz57pf8C7McvnVNjOF4slc8XQUkJG1jySullZGqTvBeKmHnGGeV3CHHOc/204TeGlXp0AMbBspxZWcwePhA34E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657834; c=relaxed/simple;
	bh=yGZOBZ7EkLv0pnbdQes0yGDQgehjKwmKANAStatM2E8=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=YKJ8mGwwCNqGXgSFZzaLjq7qvbrLQYroTNUcA6PcZjr1fv+ddBwhhjEP+5kUBVmaiCNh7jKPJv+C4NR9gMK2H+u8dq1f13UzNyoK6tco+vJ62bGiYWswVjx1zXRKw/bujRi2nw8rEO+daF90LgCHz52u02vA9kYirpHF5Y8kZ50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=PZTp1oVW; arc=fail smtp.client-ip=40.107.241.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB4dcYCJ4UFZNY5KadzcUkaNAkySbkHoEpk4BsU3bk2Z8DtPJAJ6zN7LXD81oxA8T81FRRb4naR21JrRGXx6yUdifeihemvplxnfYwh0FLObb2832HZVRWmebpuTQU0y06CQqzj38CDuldNyD88sc+Bc25i4BWswC97T41AJiXPqqil79EkbOirAXOmN1iSPnEAdSIQ7s+qRKopxLJO6JccqnlNFA3IwbtSvneO+OyLYNT95/5Dz9eDxOh7hPRiyZbG97/sKN2H9qyqr2CBcx5RYIYmQvjjrAk7+rbiI10w5hb/vQFCkOIM/TaHjD5N00pxbdlu/qxGvrfOH5OXFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGZOBZ7EkLv0pnbdQes0yGDQgehjKwmKANAStatM2E8=;
 b=OptUbuwyvZZvpuE232lLjyXqgTGblWOhWP7siedys5B5b0qphr9Quwjq3euNpntQQDknWlA72390ecjtr+COIa0TqW82O5OKUIwLuOsw12xUl6DB/GvJdzcMGXdE6hofxrFW5Qltp/I7XLNLjo1DGB5dHdJyi5h6KfUQdISVVaGRLxCPRBj1/vx72CTwWxW0vGjempU3o9GLJP0/byKt+ZsxaqGkDadXkIm6xlUc0JGBt6tk4mJQ2IsZD4yGsZh4C1QM+mQqL1g78IqxkI/o1u/ljdfMGjgvpNj7cgnvUuqImDXiKtp7OTQO+pUxhVYC6XNkaS9zLOAe+jcqOnXg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGZOBZ7EkLv0pnbdQes0yGDQgehjKwmKANAStatM2E8=;
 b=PZTp1oVWC+78H7ZdtuCoW3Ie1Kwd5dOrAnbhH5ZLRxee5RqpymRCpt3faBvn0+86B+8y0/kueDV02xUe64r9caDPNdk2MHwdAQN4tQvD4X822CYWI9+a7gNnlg2ppvFpRbycvMn5gZcmIJaHucetbzY4lfSutPl1C8hdbYOZsn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB3645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 08:30:24 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8422.005; Tue, 4 Feb 2025
 08:30:24 +0000
Message-ID: <d1243bdc-3c88-4e15-b955-309d1917a599@kontron.de>
Date: Tue, 4 Feb 2025 09:30:23 +0100
User-Agent: Mozilla Thunderbird
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: DT options for DSA user port with internal PHY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI1PR10MB3645:EE_
X-MS-Office365-Filtering-Correlation-Id: 27faf78c-efc8-4b11-383e-08dd44f62b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm93UlNlLytyUzVkMUVld3BsamlDQmp0eHBWajlYWjVvQmp0K1VTYkI2Um5B?=
 =?utf-8?B?NUgxWXRwYkc3VEtvUW43TTBpUjVzREZyci9NemdMMjdvZXp6MWdDVVY2VkNx?=
 =?utf-8?B?cklwQW1sclI1Si8yNkFHaXNQWGVjYm5kU29LYTZzN3RUd3NnK2RzWnFlUkZM?=
 =?utf-8?B?RVdjd21ZRFhnL21FcGhUcnZ1WDc3bjhsYUFpSDZpVXUxcDE1T0g1cGt4elRR?=
 =?utf-8?B?dHZWa05TQkdWWXBTVmdMeHhKVDhzYWZIL3hKQWFiNS9qUWJVeTE4RUphVlgy?=
 =?utf-8?B?dDZhRHZuY3MxOS9ZbXgwMkNNT0RkUWFpRkZVWU1EQy9qVGdsS0VycjZKZU1h?=
 =?utf-8?B?alJuMVBqUWhCdUl5Vm1MQ3FSNXBoYzdWbGpmZUdvdFpETldLTjFUTXpHamcr?=
 =?utf-8?B?VWVKR2EzeHZUK2tQUkRIb09Dc3BCaEJ0a3Z1UCtDWEpEeEdHL2hqTW5qcnlV?=
 =?utf-8?B?R1AyTmVlNjgwWGZLM2d6aDg5TXR1SDdTbVI0azhEaTh1aVVwM3A0enZ1aDh1?=
 =?utf-8?B?a1N3TDVUSko2d25PU2Vrd1djYXpDWlR6WmlqbEVqMGRab2gwVG9YQTBPUkRl?=
 =?utf-8?B?bllpUG9GVFRDZStlWnFRVHhUTENFYkVxL0x1SXdjTFNJQ3pQTE85TDJnNVJZ?=
 =?utf-8?B?djEvUDI4UFA5OTJVaVhIU3diRlFWMWhQVEc4UEZCbHdIMTc0bG44MlA0alhF?=
 =?utf-8?B?OW9acjlFbUhMb3FkWjVydnJhaXRYNXJRbCsrVDBWNmRmN3NrR29tVmVWWTJR?=
 =?utf-8?B?Ulo2YlJqeHRNd0N6cHBhMlYxNEFnR3JFbDdNODZYQjBtNUpHTUxuV3pyZDdi?=
 =?utf-8?B?NWZxS1lKWTJFUWxNYUZnZnNVVmJkbUMrSTNJUEtSTXJPdFlSYnVwT2NvU1lD?=
 =?utf-8?B?SEswSFFmMlZia1QzL0pMN0NkWVZiS2dTZEZmV0xtVGlYRlFDNkc4WGkxK0Jw?=
 =?utf-8?B?dlMwOW40YWFaV1Y3b0dHVWJyQkxBR3JQVHFRbVFMV1drRGF4NkpEanRnVjJV?=
 =?utf-8?B?cnJ2MG12blc4Q0FhWVkvTXZpUHBsbkFzYzZLbVM2Rk9ZZEpLVzR5dEZLNHdn?=
 =?utf-8?B?eGlOaDRYd2oycGxBdTZ1allTb2taOW1CY0pIZHJjVU5hOE14WmxTZzBoQjFQ?=
 =?utf-8?B?RVcxcWh0cUN4a080Z0VsdUpkamQzVlVSbkZnejNOUDhQNUEyakFTcDM1V3ZZ?=
 =?utf-8?B?TDNmQitSaTd1dzRQaUZDYWR4cndkdFVmYjVMRzFidXdFRnYxNG13Y1hsa3Vr?=
 =?utf-8?B?Y2xlVWFzdWdHRUR2QksxeWlKSEZxSWM2amlOK0c4OFZCTmUxRGkyMlU2cFpC?=
 =?utf-8?B?bE9LNXhIWE1RTzQ3ZTFMV3plcnJuS1ZEYnVUUXNXdkZPMmZCZ3ZzbEZMcXJw?=
 =?utf-8?B?NjNqWmJQMnhWbnpLbmFiSmdUOWEvakE0R1c3d3FkZm9xWCtZN2UxZy85ZXhL?=
 =?utf-8?B?aStPa09Eajd0a1MwUkduWFAvelluZFdIOVNsT3NydjdldUdOaVl2MTAxUC9M?=
 =?utf-8?B?NHJWZC82Z2dMbHZ0bFYzVCtVYXd4V2hTVzRlQmRpL3lRdlNSRUlYZ1g5blJQ?=
 =?utf-8?B?NmVUOFRiTWlyMVRUakd6TDg5bFQvZU1Db1M0MDRtajUvZk5BVHRwUHlDQ3B5?=
 =?utf-8?B?dGRsYktieVd1UmRiajNJRzZNZHdkaHduQldvbGIrMW10cXVtNDUrUVJRREox?=
 =?utf-8?B?aVE5MkFBYm9WRDdkREsrNnY4Z0RaNHRZV0Y0YkhqYThTRFBIVXNDT1BDaTNl?=
 =?utf-8?B?TE1CQU9NZmJNSTl4NUVVQ0FraEhXM0NzeHhES1RrS0ZFa0VUb1hHM1VYeU1i?=
 =?utf-8?B?bHJ6QmNQSDcxMXBtbGpRV09OSUNPNmJ3dFA3czVic05lMVFFZS9RdGN2akZ0?=
 =?utf-8?Q?V6ye81YXt0bC8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q05LLy8vWHZXRklmclAxbFdjcXROZEE4Nyt2QmxQSHJJejJxWTk3Q05ZeFFV?=
 =?utf-8?B?N0tUUUFSZHduQXVCdFF2Mk9WRWUvOFA2Mi9GVllvNEdFdWxPNk85MkY5Unl2?=
 =?utf-8?B?ODNWWHZpVTdhd3gvZGlEQTRla1BVR0dDbCtKUEh0L0xwektJRFZXLzExbjEv?=
 =?utf-8?B?c3RNWU80U2JTTGNJU2RzeGFvTSt4UGJPRUFhd0krTHpCRUZ3cVpsM0VoWkM2?=
 =?utf-8?B?V2dqMzhkdVZCU2UzMk9NOG1qS0NaRW5tYmJoYS8zUnJUY09IU21uN0JRTDdN?=
 =?utf-8?B?Y3NYcHhNeFY5ejlKR3JxWHlKSGtFd3IzVzVHOVVoYW9ITTIzYkhQOTAzOHl3?=
 =?utf-8?B?d0Y2YVNMRUJqM2RsYmprWDFaRE5RUEVZZU9jaHVjSFMxUkJUdEo0ZlhIL2hO?=
 =?utf-8?B?R3dpMTRQNmRrc0RMcldsTTc4emF0Njd3S2h5OFBhSENYbFRLYi9uQzBjZjdV?=
 =?utf-8?B?aWV5TDVWcEdPVFZ2L3owWWZsQ2Y3QkwxRnZWZUtoUCtwb1dTY3VJcXNSQnla?=
 =?utf-8?B?MjNZNTVNcGpxdFlFdlhQT2M2TWhPWlZDUkdXT1V0Mk1YK252aWRpVTFnL2FZ?=
 =?utf-8?B?anBadStxUVBwdzhPNmhVVGV6RFlWQmdwL2tML1cyYWt1SG1QWGlsSHVZaU1r?=
 =?utf-8?B?SlEyK0prcklaNHpWa0sxZkxRS050emRvY0dJU3NwRnhFWEtYbGNCL1RaSktS?=
 =?utf-8?B?eG1pNmtCNVp3SlY4NjhreTd0R0NkZkRYUHFVUUFhMElsak5reXFNNUUrRWxp?=
 =?utf-8?B?elFEdC9QTGNEd1g2SVNFMnY0UnhFYUVQL3BKWEdqbitkTnZkMWtTL2p2M0Rn?=
 =?utf-8?B?VnBJYVEwSGhDSVZ0WG95ZDB1SE80Y0xSOEVVQVJyazJwdEROa1Y4VTQwTGps?=
 =?utf-8?B?QzZWeFFwckRJaGVad3o4S1RIV21FNjJEVWNETzZYdmFITUlJalZEdEs4MXVI?=
 =?utf-8?B?aS9rSDVST1RGcFVINllDTkZ3QURRbnFuVkMzUHdWUkZmekhnQjF5MjkyUVpO?=
 =?utf-8?B?dnZ5UDJYMTJLR2N6Q2Z2VnM2NG5mMVgvVU9FNW0zTVIyRnVvSmZuQ2g5bzEr?=
 =?utf-8?B?ZW5GTHhHaFV1MTBaSzZFOCtCTFVkTDZrOWUrcERFM2EvTDJtMi9JRWdEUnNp?=
 =?utf-8?B?NnVjNndHQlJqSU5RRkI0UWJYUUJBd3I3aWJJQ2NWcTI4MHhNc0RLeSt0R3RE?=
 =?utf-8?B?cVh4Njdha2ZTL1VWQ08xWDJ3VVFDTisxRS9FVFlGdmJFTzQxeWNYNmRqTHRD?=
 =?utf-8?B?SloxREFac1ZTRW4xK3dReTEyVGFXak0rN2NvOU9nbHo5a1NvZnhtMU81aGRt?=
 =?utf-8?B?T20xWGI5NGRZRUxFSHZwMnkvU0xqZUZTQjFiY3dsZ1BudjBDZ245cExXclZy?=
 =?utf-8?B?Qkp6R3hkd1N3SDN3b0gzOURJSDVkRzBiRXBoaGdtMExMeVRscVcwMzZjMEVB?=
 =?utf-8?B?QitEa3NYWmVTRVcwUm5WV1gydVp5R0VkNkVVNlc2TUYvaW5STXpxbDFVWnZD?=
 =?utf-8?B?ajdTSi9yOVlnTkRPc0tHb0l4WDcvQ1Q3eUpqbko5QVIvUys0ZnJ6bFZFVkRC?=
 =?utf-8?B?MU1jQ2Y2aWpzdDYzbVJieEVTM3J1Q3NYTDR3dkJvNmtRSy9uS0lZN0FFRHpO?=
 =?utf-8?B?cGNIRVE1ZVVpOW9rSjNSbkJaczZPUk85eVphNEJLNDNUWnc5NVk2WFhZNGU5?=
 =?utf-8?B?blMvbXhsREtnY2pTWVJiR084MUNhbmd5U1hvY0ZUY0lVTDRDUkYxa1FrSitt?=
 =?utf-8?B?cHdCWm9VSFJDdlBNK2dmVXVOb0NsVVhHVWJ2a29NeittKzAzNUY3YUhyZFpQ?=
 =?utf-8?B?ckhZdVVZY0E4RXhzWkpOTTBvOVc3bzBlaHFiVHUwN2RWR3UvUDRlQXN4SndN?=
 =?utf-8?B?d2tjWkNCOVZZcjNhdFVLOFRWYk4ydllBUTJLMTJuM29YSEpHLzNiaHRJMzRp?=
 =?utf-8?B?Nnl0cFpCY25QVk1MSmJabzl6aVRHOTNkZHI3QzdubFRaSmNKMUxJTWl6VCsw?=
 =?utf-8?B?NXFtSTB6b1VtN29Pdjd2UXFaaU9wcFYzUzZnRzk4VldmejQ1bWFVSDJYU2Q5?=
 =?utf-8?B?bmZTWTBPRFk0OFZ3eHZpSzY4V2RZRFN5b0dUR2ZKQlRGN2tMVmtHUUFpWHUz?=
 =?utf-8?B?Nk1yYjZXb3FIbmlmU1VoMHgvei9XaWptUCtSTi9NdE9nbm5KZXNrRmt1Szh0?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27faf78c-efc8-4b11-383e-08dd44f62b63
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 08:30:23.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4c8jZpnBePj7M7yxfj24vNMNHf1rEQ8BPHMy3f2K/RKD0Ng79T96toDj688DCv0GFfHYg+1DjSHOcfxcCe1yDd/AoAziY206tB6bCalNG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3645

Hi,

I'm using a KSZ9477 and I'm configuring the DSA user ports in the
devicetree.

Due to the hardware implementation I need to use some options that
currently seem to be unsupported by the driver.

First the user ports are physically limited to a maximum speed of
100MBit/s. As the MAC and the PHYs are capable of 1G, this also what
gets advertised during autoneg.

Second the LEDs controlled by the PHY need to be handled in "Single
Mode" instead of "Dual Mode".

Usually on an external PHY that gets probed separately, I could use
"max-speed" and "micrel,led-mode" to achieve this.

But for the KSZ9477 the PHYs are not probed but instead hooked into the
switch driver and from the PHY driver I don't seem to have any way to
access the DT node for the DSA user port.

What would be the proper way to implement this? Any ideas?

Thanks
Frieder

