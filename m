Return-Path: <netdev+bounces-161390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE577A20E30
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EADB7A1273
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224AF1D5AAD;
	Tue, 28 Jan 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="KucAHQ7i"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023113.outbound.protection.outlook.com [52.101.67.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145531991D2
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080899; cv=fail; b=ll/nwYSqCNZRUP63uoprh5EwFzmvccd3nmFGVfp/iOACr/ZcuJxLYoUrBc7h9bZ4hBT1vuDpZWvUI1Ns2RQECJqDQRno06wbVXDImHB0E+pTzGGFXrwbHJ1ml7qsZWjL5qxTzDtUCvP2gaTr5EGLV+Ah8N0EatWc8e7rQsLMzn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080899; c=relaxed/simple;
	bh=LQD4SDg2/NxrV1TrK+yQgGl5fwh5Bqh5FnAqRoU3h1s=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=DimxybPwX3tPfycFSNVjL1nlJ7MIZwbhAbTXKol6zEZ3x/p+4ReGEusK9WTj5/WkWOTteM4oDHVVK0eoIA0EwbO4wPvAKxKhI/JP79SGC724MY3wpf0D5nNBnqBb8U7274p3PDmFKACcsjUXKqXZpl53at3HT25v1RxXPkNAr5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=KucAHQ7i; arc=fail smtp.client-ip=52.101.67.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAdqzADSGyNMIdG8i/dwh2LEdOahQTjKX1dMPHuXqTTCvvM77FGs0VI/ud3wQV9baWEVEO/+bSelufHX0Nse3GMvxJq/HxZFmYVzF4jFQsZpKYb/c47R3ANxjn4+7KV5BegZLOMAA/egAsQj6JQRDgG3UV3rClcRNVjQ1mGgKlB0CLHLTvF1hnyHgMbvIDI8l7gtfWAsFu58dKV0fVVLjPMeftQbsilWk6J5MHyD7WhT7KWHdeCN29XRfdmVB5hjt3S3zsTZDAImxrwh2oh4dNA0cFJSCGQZKcXAuYGZHDF6+IgivqO6HljnveZuFFiV7iuoRppyioiJ2JBqCUgNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i8kXW8BavpVn05DEcDHTbSq1xeN6wZAQPP7068QRIQ=;
 b=SYYuFOQJ2jO3KOhYF3dey6FUKHNgJiSxF72lQslheFISSeP09FBEOLTWUMq7RowXpdx14am5YW0RpWJTJix3o8M9IPH0uVUMl7AHmEU3HntEgZ17x+TPRn8lAtoz0e7Du1eGhDeGzJPYDv9r7ngMvM/lO64hkh3PUfG23hNyvN6wUglq25k8WcW9UEXXlu68Rd85AmIm2SFkUW7GpCyPH3hjxbWHXTjoS4QxmLK1vI8YwFeuPwJd2494PY4aCPrY0GZ7wQ6NxFeG8y1ibtduvl8yTuPc8xyjJwu3kwdew1sLFr2ZFHx88E32kLxvPstsWPrGizAhLq7kArJgGfW/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i8kXW8BavpVn05DEcDHTbSq1xeN6wZAQPP7068QRIQ=;
 b=KucAHQ7ij9VmcXw9z9jx5hqyZj0GgDcrtVX4QZGw9trsuZFvsPFXPK3qa7Jj/2kpiV1kPB8kDsaf1IHuEx3V08W6QYNWTMeCLWddyCE0i9retUy1UroHQ4h2t7jKywO/3GpHh7VRk0P2p7gGSg0lA9hqUSJnuNFxoR7a6bg5brg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV2PR10MB6209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.15; Tue, 28 Jan
 2025 16:14:48 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8398.013; Tue, 28 Jan 2025
 16:14:47 +0000
Message-ID: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
Date: Tue, 28 Jan 2025 17:14:46 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: KSZ9477 HSR Offloading
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV2PR10MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 62020ff2-f42e-4e6d-94cb-08dd3fb6e24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVDQTlxUFJOaC8xWktpUitoUGlyN2JWbnZNV0VQQkdjSkJxcFl6cUIzeTFZ?=
 =?utf-8?B?ZlBQdWp2VExvdFU4ZkViaTlaVmQ1YWZtWXJ4Q1BHMXEwQTNRS3krZ1AxcDRy?=
 =?utf-8?B?ZDdFc20yVzc4S3lubXNpK0hFRFhiOEV3NTN0R2kyUlRRZnVRV1dTd1pTUzQy?=
 =?utf-8?B?ZDRSMDQ2Y3JqeTZqMlJJWVlkOWNDOEN1TnYvNHgvR0FiS216eGpmNlZ0RFVV?=
 =?utf-8?B?NzgxSUpxcHdFSXJIcFQvbkwrbjJlSy9yVFkyQlFrZmNZa0orcE8waytKcFZP?=
 =?utf-8?B?TmFSQTRqSHpCNVNwU3NyajBvM0tnTkFJUUJPVE5GTnJ1UTBJT0V4bW9EU0hi?=
 =?utf-8?B?WFBjNXJBV3FFS2pWM3NmeCtqQVIyeG1FdmUvNjN0SHQ0dXhvR3RwcVRlK2hl?=
 =?utf-8?B?eGdVNmExakVUcVBSUlVmVXgxQ3hKMDBEZGdMN1pIWThvN2dNN0NmcmxxLzZU?=
 =?utf-8?B?amg4MmFWWmZRSDBSbWRHT0lSWWF1TXErTC92blBseHRVZUJ1M3BzZ2JHNHE5?=
 =?utf-8?B?SWJVNzJUTEhaSldISWlBVXJuRmIycXJabFVYVGlKNWFReDFGYjZHRFNleUFQ?=
 =?utf-8?B?OElUeXpoT3ZDdVdVbU1hVGkrRW9QdWZpWHJiTUR4MWNvUWtUbWhuNHArRGNB?=
 =?utf-8?B?Ump6QnlXN25nQks1R05iMDE5a2k2TVJiNG5VNThjUWgrR1ZHQkprbTY3UkFs?=
 =?utf-8?B?REZvR3lNMExFcXE0K1V3eVc0WU5Cd1ZiMDNFM0dkRzVwZXhqUVpyZ001ajA5?=
 =?utf-8?B?aVNubW1veitCdld4amJJWldOUzhCdHpBMVZwVkxjNXdvVkNpZFgyNEZuTjRy?=
 =?utf-8?B?Z2dablZTdTZPcWhnNUsyTHRKaTNKcnNxUjArSVFVazNYbGFIK0ZkbEJtcVBE?=
 =?utf-8?B?ZHBnMllLdmlPbFZoN0JEMG5YWm5qRFFYYUU0WThxeHlUNE5lbGZzbDBKMEg5?=
 =?utf-8?B?MGFhSUpuZFczdEthZ2luYStTVXc0QTFVVkxsQmd6TU5BbldLNkdzTExLdE5G?=
 =?utf-8?B?MmdRZDZVcjdKMUxaeUZnZ0hJejBJbW1LSEtCODBBK1JmME9jVFZyRTJvaWpz?=
 =?utf-8?B?QjQ2UEF3Wnc4V2tEeHV4dWhyL3RZQXBQU3l6K0h3NytLTVVROWFWSFovanpK?=
 =?utf-8?B?NzFrekg5WDBtNWFMaVpsakFDWnpWSzcyWGYzczdLUkhTeG1iYnJ4SndsK0VC?=
 =?utf-8?B?OEhmaktUem5DQnlQT05IYlAxQ1F3SjdlbkNnUUlWSEswMWFpeHFWMk9iZTJR?=
 =?utf-8?B?YjRCTWt4YVRzcG1sa3R1eDRGWjVDaUF1Nk1uWE5ieEZXNkh0RjZacnVqUVBx?=
 =?utf-8?B?b0VxVnRXalU1Z2lmZklzdmRMVnVsTjNBOVhoZTBFSDNjcmhzczVCc1RLTUlV?=
 =?utf-8?B?MldEaFBKU1BFUlo5dEhzUEhCbGhNQ3Y4VVgvdVBzQlV5YUh3NERnS1d6cUJy?=
 =?utf-8?B?eFQvSko3OFpuWFhoOUJmNFRodVA5ZWtlL2NVUk05QkJGU2xQcmlwYms2RUE1?=
 =?utf-8?B?eHZsaG40aHdhU1dHTGg5OTBDOUhPdG5PeDk5dFg2enQxVXhmcXNkdTNlajRS?=
 =?utf-8?B?TTUzVWhEajhvbUdXZVVXa0tnSjJiam9hYVY3aCtLV0I5aU9HWms0emFmVE52?=
 =?utf-8?B?dEp2UE5YdGxvWFhjbnF4Q0dzTkVEQS9BVWo4NnI2SUIvSVFzRStyTHJZd1ZC?=
 =?utf-8?B?RlRZR09wb2xLV3YzN2lFangwOGZXc2EzR0paVW1ZQ2hiSDlNdk0rM2xXZXJl?=
 =?utf-8?B?VkdyWGJnSzFsaUF3dDFyTUt4KzR3TWswVnR3cWhPT1FZa05zaTJPcWx5dDZY?=
 =?utf-8?B?bENQVHBmWDN4YTNBNVVzT0RXM05LL29YNkVOeUFpV0Z2dmlrQlgxU25EWHlX?=
 =?utf-8?Q?R01ZGBNy5UGWi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVpINHI5akhvYkpqOG4rbHN1MDV3UnJFYTJyQkVhNnFid3k1K1BqNW5yYnBk?=
 =?utf-8?B?bkE3WDIvVmNPNU0rQWU2Y3BiVVJpdU0vVHhhT2d6a3ZEcEVCN3Z1MlNUb04z?=
 =?utf-8?B?Q3RTeU5zYXhZYXRiK00vMkczeWZhclQwSW1NRGh0ZlV2TGxhRzFla2M0SGl0?=
 =?utf-8?B?M1RBTVprZm9qc3ZqSjFNanhTdGJJVHQvV0h3dk54ZHRtOVI2Q1R3OTIwUFYy?=
 =?utf-8?B?K2VhWktyM2JxVDdFMk9YSXZRQkVlZlNlcWREZnptMUk2Z1NSbUFmaHZDS0l0?=
 =?utf-8?B?STJMalhBaUJZUkNzTVNETmtwOHJZY0llNVJZa1lxc0o4MXovLzdCQmp1d0tN?=
 =?utf-8?B?SkYvWVRQbmFVVW9nM0RqUVhvUHNRam5KcTdaRXNkNnhZcTkxaGtjYlVtR0pF?=
 =?utf-8?B?N2ZJTzFsQWZtSGJDWC9USVF1UmpUUG5Ya09LbSthc0Nzb1JTdHJvL25TeGxS?=
 =?utf-8?B?Vm8rbUlNNm16d3BZUTI3UThjeHYwM1FOSlBvRXpCQ2M1SzFXd1Rrak1Na2Fl?=
 =?utf-8?B?VGk2TGZiZ2s1UWlaMEVPTGYrKzJ0TGI2SGFLWEJqT0lMYnMxeEdKS2VmV2M0?=
 =?utf-8?B?dFk3ZXVLVTAxUnJWNW44QzM5U2FjSWFVNlJUdEN0V0lxVFdPNVE1TEIxSjhL?=
 =?utf-8?B?NzZsT2Y0MzZSMS9odWJXTFJXek9NdDdocUJwc1hkcUdrVlJxWjNnY1JRYW9D?=
 =?utf-8?B?aS9YV2U2blphU0VRM3J4djBTNXlXMTJSN2p5cFA3U3MyNWtBZit2eTNnQmxJ?=
 =?utf-8?B?WU01NlZWU2ZSdVVsTjc3bG5uR3Y5dzlzcEtycE8xU2VhTmtEbkNxQnVFOXdE?=
 =?utf-8?B?YUhyRC9XSFArR2ZGQ2psRlBORHVWZzRQSWk4aTdVSEVqa3JsMGZVYmE1REY2?=
 =?utf-8?B?Skw5M042UTY3VDhsODJWV2hWUzMvdXVLM1hRdFkyWFdJTk5IM0RoNUM0b285?=
 =?utf-8?B?MTFDQ3NIYkc1RVJHcHZXajJGMW1IQzJNcEExSi9GYVFDYXoyUDdNRm9qR2Qw?=
 =?utf-8?B?SWIrL1VodHNjTWxyWWlzcDVVMTJRSVQrdGo1cDQwbGREZmdrdGFnN0syMGJj?=
 =?utf-8?B?aWNaNVJvY0Y1RUpndUFJWFIzTjg0VDR0U3VSaHQwVHA5RTM4YkRIQWRZS2J2?=
 =?utf-8?B?M2dSbFBrREZHUFVwcDMyS2UyRWwxdXhGdkdTcy9DOFBkM3V2d3IxQ21GMlQx?=
 =?utf-8?B?TFU5akRFUGZaVHV2VWJBaHpGMFFiWXdGVUFralJqNFNwY1dmd0piWVhpYWNk?=
 =?utf-8?B?Umo1eFVCSFhpa0RRWFhMdTJQb3VLWlF3dEwyMlV1VUtDUlpvSFExeHFvR1ov?=
 =?utf-8?B?emVkRmhoWWtOOUM2OStrWkIvRDVZaUEyR2RUTjhraHppUFV4dGc2anhwZ2x4?=
 =?utf-8?B?RGhVR1lQaFNpZyt0MFN1bFdOb3VVZVVKTkNPSytKS01nSU1iWFJnVElaUkZU?=
 =?utf-8?B?NXpGTjZMUlhSTmpjaHM1anI2ZWxlWWdSeVEvNllTTmxNeEdwdlJ2UXJYdWF6?=
 =?utf-8?B?OU9jNFNVN0NMakxJRjdDSTN1bysvaHFEZ2ZrcXlGb0l3RmdmNnN6ZzhGeW1r?=
 =?utf-8?B?UmRqVmJwUHptL0hvYWcrM3R1U1RzQUkxTWR4REFUQ21QMmI3cXZtWElBdTNG?=
 =?utf-8?B?WVhDdnVza1B4ZnRiV0ZXbWpsVytwTXpnY05kZlh0eEo1TVhiWFFoVDBXYk9J?=
 =?utf-8?B?R2U5SFJySTM1MGlHVjdqRUJLLzQwMHVrWjNXZW4vMFBDWG1saGFNdCswRkZ0?=
 =?utf-8?B?WmQ3b3dSRll5ejY2aXAzZTJlb3lXZDZhVW15L2hhQWxYdmJIOUNKRjkrbjdG?=
 =?utf-8?B?VnpUenVHUjNibVh3elU3NFdic0V4WHNEcVBDU0FvaG5GMWdFUmtWSzVlYWdT?=
 =?utf-8?B?NGhIcG9PQlMzbHBTclRDRGh1NW1raDg2TTBYN3o3azR3TitacTNoSVUxUEt6?=
 =?utf-8?B?U1RoMmZjOEVONkNEMnVzR0czNXViUlVMSmNFVklYOG5NRGhKM2RwQ3FiQW5o?=
 =?utf-8?B?WEZQS1lOSmtBcml3KzkyTFlkcmlrOVVHS0xrSkdyRDBiWHk5R2lUMU5KSFBk?=
 =?utf-8?B?YWhRWGNnSFNFenZJOTJGbXlBWCt6VWFBT3d5RkdwZUpjTFVOQmdkZWJ4Vzd0?=
 =?utf-8?B?eERQVUJDaDRoQ0V3akxHcm1Hdll2amRKdHkzQTZURUlGWDNSanhldGpsakpZ?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 62020ff2-f42e-4e6d-94cb-08dd3fb6e24c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 16:14:47.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yW+SSomp4uIK1q49Dx8T4vm0D6GJKuKk4Od+0WvF2bT7Vck1Tcf5AMHUtCPUKegIC52zV5yGfe2PiLPMlSJl5qV8esB9Giq+EpTMgS2zjb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6209

Hi,

I'm trying out HSR support on KSZ9477 with v6.12. My setup looks like this:

+-------------+         +-------------+
|             |         |             |
|   Node A    |         |   Node D    |
|             |         |             |
|             |         |             |
| LAN1   LAN2 |         | LAN1   LAN2 |
+--+-------+--+         +--+------+---+
   |       |               |      |
   |       +---------------+      |
   |                              |
   |       +---------------+      |
   |       |               |      |
+--+-------+--+         +--+------+---+
| LAN1   LAN2 |         | LAN1   LAN2 |
|             |         |             |
|             |         |             |
|   Node B    |         |   Node C    |
|             |         |             |
+-------------+         +-------------+

On each device the LAN1 and LAN2 are added as HSR slaves. Then I try to
do ping tests between each of the HSR interfaces.

The result is that I can reach the neighboring nodes just fine, but I
can't reach the remote node that needs packages to be forwarded through
the other nodes. For example I can't ping from node A to C.

I've tried to disable HW offloading in the driver and then everything
starts working.

Is this a problem with HW offloading in the KSZ driver, or am I missing
something essential?

Thanks!
Frieder

