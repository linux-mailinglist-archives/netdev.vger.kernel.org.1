Return-Path: <netdev+bounces-297449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZOe5Ek77KGrHOQMAu9opvQ
	(envelope-from <netdev+bounces-297449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:51:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 942A4666026
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:51:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=MkjRXUTu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297449-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297449-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5564130C462D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0306331ED3;
	Wed, 10 Jun 2026 05:51:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9A328B7F;
	Wed, 10 Jun 2026 05:51:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070667; cv=fail; b=s2xNpQyKqlHsuyWDDPoo4pfp75rR8vmCn+Bg+UZQLP3kbsbOTGlPPLCqAfRSVRieGoG4Wl4zdI1V5Wa2YzLLGNQ2MMdT+a007RvE8DpCVso4w3cyoZY0/Q3toKB41R7gFbJ9ayZI35CayApsCgcf2gPAuPHSl+57fGd1ECRlcDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070667; c=relaxed/simple;
	bh=3ElT4e1ASmfABEJVDLJfeKFRB2gP7YY3j8W6in9/rTI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UL12oWkwCup3ZP5FuN+mcYx9AMYZPa70Es3/TPeOd49fFnOoQh5NQXp2nar55GJ14vapHRHKM/bJhyMJWm4XqtVrZfqzJiYCmL70kMD554m0IxA7okd79Toog8cNOLF6gCa3+16r2KDC1zYWmI2jYa14+RZ3nghM4sOIuE98kGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MkjRXUTu; arc=fail smtp.client-ip=52.101.52.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFQoQjk2zlV3ATrk6dBql3/B5v2SH1qvNX0OWejL2D7uOH2rYXOM/g904wBAWof4Gth2nODi8ev1YJBV+Yu6eFW4vwewFjHJT2fL5+faS0hTkpMhkv1WQYCuMX0KluemP6Q9cJe9haZNn5UWxWOLK9MHztyGgFQp7hlMMjvg3A9WTKO/6Hl1CnqQiOmWCI9aYDN2SpjDsFFV6NvZ0SZamF/fDxjyFLYI+QrFTJ7dmMbu/Q7HSBYHHlSEG7J4nApUHX61IfA8eG8a1gVI8tCOM4KIYcqaTsF6fYLPwG6ah0/DddEUEh2xinqei02K0ZO8CD8tPMPNyA6ZJi86ReesGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTY72MD6MYdTsYviS9696g4Yk4J8I7E9L5ib+xfMWwg=;
 b=R959ZjW553raPDayewcc5Z4RbmlD9ZcpeAnCi+od82lr7EJ5lzPclGgTKlrYw9lGelpqzscyBLFoG/WvrdSOKxZp3nP3byIdUXNe1DU3Bxuc+7vgi/zQXM0uesz60Leh0YnXI8m3inVN3ZeQfnJ9U9MDZugM2w09FzQQnSB/Tw6x7yZhdXZ2NB/PA72RK/Rq+Vsu1YzEg9JsvvFsSII2oJv7s6JDWQa96l2ESk8p/1HBZmlvfXTxAxQr+BlpHnNh3KmjRdrQhn1IAdIPCmm5Qf/5lwWhiYCZTFdWl0BVoxCmDBeFS+MmXvWoGGUvVM+SZxVvIunBID07LiYCYcKiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTY72MD6MYdTsYviS9696g4Yk4J8I7E9L5ib+xfMWwg=;
 b=MkjRXUTu9V0fIorqu31QYaykchI5prbOyQuSbGirNkpgPksAsHwIX1YHNT5XOfygFnVq054K1qyKAPT4+G/mWWDE3jk/yMnuWDe4brz/IcEML8TYHP2K24aB2vAec1RMah5SyVQfdwn76JQ8RCBmZIupV/JxHOL5MU3kaJCwEAI=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 05:51:03 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 05:51:02 +0000
Message-ID: <4b2a5d1b-632f-4685-91e2-4976d679b186@amd.com>
Date: Wed, 10 Jun 2026 06:50:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 5/5] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, djbw@kernel.org,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-6-alejandro.lucero-palau@amd.com>
 <5f3911d5-da9a-4ad7-a42d-765b27f3dfa0@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <5f3911d5-da9a-4ad7-a42d-765b27f3dfa0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: b629098e-9d6e-48fc-4332-08dec6b44161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|921020|56012099006|3023799007|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/H75dO9Q0L1ftwRHtOD2kltF4TQrOSxatiuXSz9m1Tg7bPXsaMoYhw97kppQj/ztyqiGsK2RgUiA49RXn0M/KB1Zv6LtGt0RSpqYuVWwFRRWsJ+yhRjgwQR2dDccsB5mvlRG9PaM2t4zxU4OZUDNUAu+40FqlhuLTwXOL7Bnb45cYSQ3L76fuvYUFO8FyhiKjW+mgntSyGb4s3QcGScRkbuMucpPlqx9LQY9LAf1D7BAwPk//8+yznDQ7v76igRxfjVn+zO13tY72IW7fZynUEbFGsB9gDuCiz+6YfcGUmn0MsRngU5z6xSRQvnHstOw/0x4jfJHUPPHNN5g1ORF188A25WsqRgpqym2cbnKrTVGTKdoksDlBU07Ty038Mj5CqEFrHlfOiXLgpnr1XPdoeL6xPMn0Y+DuhdlU5wxcDV1qk13Gz8XZ60cHdz5D38hIkZAHQ+FDkbR1oWy3DV5hvTd3b/ElzW3P046XOqfnc2izzRxF6jvvsiYB+pDSNkTdl7CrjKC+aa28didconMjBReIf4I/FYsaW1pViJLE1LTqKzFzIHEmQOnJ2IwRhjpSFvuT806Zef0ukEnl0W/9njzURHM2Y32+PhhcjNDUBqrdlBqDIGWCiy29WGBjOj9C1VSnPdsvP35X1J1bFf8VUCIkU4dXd84rpt4dpHlLhKa9TPDH+mSBVzA+rnmWDnmMgmWaa8x7z+SZ6lQwOMKPrs5EaBHAaqU00DPz3xWw7LxeJkrMExCVJEZ+ScOXKWt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(921020)(56012099006)(3023799007)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnFOdyt2UVRYTGZWUzI4ekg0dDJDbmtDSlM2MktXMEVCU0lxcm5wS25lYXNz?=
 =?utf-8?B?QittRC93VlVpekQxc1ZCYVRDdGhjQmluaUUwc3BjRUVrdVVOTkVaTk1SZ2hI?=
 =?utf-8?B?aTdWRmF3STNURG9iZ1kxbkhDSUZpelFXTVk4Ym9JVTd2YzFjTmpFS3ljVlVS?=
 =?utf-8?B?UVJqb01pYzR0NU52b3ZETE1kUWdmQUNrQ01LYmdxd1RsK21FS1B4Y2FyVnRq?=
 =?utf-8?B?WU0rMDFqRFpkRlVUNjdFKy9KS1pvLzN0b3NnUDVsTGpZZndraU5lZTZzUW1X?=
 =?utf-8?B?Tk9VSCsvRlNZZEpRb0xXdHQxZEloalVMYzd2a1RRS1dMQlhuUHpsUm9odita?=
 =?utf-8?B?dk9aNDRwNUg4Z0NkaU0zUjFMTnpRWGJ2YTBBM1RPYnhYVklKZC9rYi83czBj?=
 =?utf-8?B?cmlUWmRIeVhvN0hpN2ZTcEtKQTZZcTdPdmtYY2pNR0tqRVlJRm1UTzhEWHJa?=
 =?utf-8?B?OXRKVzZPbEh3VWcyUlI2dDljRmRvSHB6K1pOS0dxdGFaQk5mOGxCWTlLNFdD?=
 =?utf-8?B?bFhOcCtKTmFlakROL1B5cnY5ODJncEptVDl4MndtNmRhbk9wSW84VjBkaEV0?=
 =?utf-8?B?em5HL2MyU28yMmt4azZiTXV1QmhSQUlPdC84SEZBVDJyQjE1R283YncwdGZq?=
 =?utf-8?B?RkFzVS9CRUtQY3VxT1NKTWJUMGpIbVh6ZWx5ejBZSUI0bFVpTUNIdW9mckVT?=
 =?utf-8?B?b05CTjR4QUZTaStaZDFibUIraDVFU2hYVjVJVzhMalA1VmZVY1NtUVU1S2hh?=
 =?utf-8?B?VUdFM2puYVU2cEl0WUtHR2wyTVl2NEtVMHE1NFk2enB4a1dzUlA0dEtnVDlO?=
 =?utf-8?B?UWs3TVI1b0tTSllDRVJNQVZuMEY1S01BSDdheGtOTzZTOWtmSUhCQWh0Yk4z?=
 =?utf-8?B?RW5abXRRd1RsR05NWVRpaXBpSFBNc2o3VXBVbzRhdzR6ZzV0VDZ5RFJsalB1?=
 =?utf-8?B?bDNZM0VuM1FSUUM1RTI3UTVEQlNCY1laTjFJTm1hTzVDeUZyMXkzU1dCaHUz?=
 =?utf-8?B?Rjdjc01SbFNIUlVWTytzeG40ZWVuVUc0aHFxai9lbGhnR1hkdndHaE5tbDA5?=
 =?utf-8?B?U1pkWjlaWVlucjZ5cnJYVFpOZ3ZPN2R2UjYxdUZMazZnYzBBd3ExaytvZEVI?=
 =?utf-8?B?UGp6M0NYckt4OU1oZnpsdjJEYUhsT25mcU0rUTVabytqWFNPQWtvbldDOTJ5?=
 =?utf-8?B?bXRQZVRHRE81T1cveWc0NFo0WkcwZHh0RTNmT285RThRM0tVY0F1NE95cStt?=
 =?utf-8?B?WmVtd3ZqS0dhMFJ2MnBHSy8vdlRKTlBMYjlybTVMdS9YcDhWa0Npa0YzazZv?=
 =?utf-8?B?MkVjSW05ZDBmalAxTU11THBwR2M1dkhoOG9UaWFBZENOOUc0MWVGaEpmZmta?=
 =?utf-8?B?Y2RNUGpwSVhxK0kxZlBkYlRERlAxN1hkTFhyeFdWb2dYNnRlMlBHQlk2VHE1?=
 =?utf-8?B?UFAyaitZeWV1LzNOdjcxR0RoQnJYekpvd0h3Nld4SUJwZjJoYWt4akFQbjIr?=
 =?utf-8?B?alFiWWNyZFNBMStORkNoUW8vWWYxMTlBQUIzMFAwZ3llcUZLUnhHZE03MC8w?=
 =?utf-8?B?dEVOeEF1ZnNENWQ2ZDdETUNoWmZuVEpyRzRRZEt3SWpabG9ncFhTM1BzUnNu?=
 =?utf-8?B?bllRT3kxcGNPQjFjSExKWHJ5eGhlcmlOMXdhUlJqOVJaZXZIZ0xtWXlQN2s4?=
 =?utf-8?B?c1dSNWtYVys3NmFHR3lRbWkrRHlWZmI3a1drZm9HbEljUEp0OHdOL1FJMnVH?=
 =?utf-8?B?RTVMNFJnVlNiZXIzeUg5ZzdPaXVxQVdtVTltM2pDZnluelFjcnM2K1pwYWxC?=
 =?utf-8?B?cDk1UU1xdmk3b1ovaytlV3ZMVmlKeDk1SkxJWWY4RjhTbXFpaElDSXhReFI2?=
 =?utf-8?B?bTBkMEUvWGhNVU1JSHBVNVhEcXJHNFpEM3lWbHloS0VUMkVIL0hmeUgzOUNL?=
 =?utf-8?B?YTVBWFJIYzQwd05ZL0hKcU81ZksxSldwSEMrcmo2UzlpNXRqTS9yMjJqMjFK?=
 =?utf-8?B?TEVuUlppQ3BGY1l6cXk0NkFKWlBoU0dOTlZhb0JhQmZidWR0MW1WYjFuVmFO?=
 =?utf-8?B?cWs2N1JqVmFTN0ZGVU1mMHRucjluRVJQa2FCbWhMeGxBeTZQOGZTNEJhTXZY?=
 =?utf-8?B?ejdtZEgyZHpMYXNxaVV4STdiSmpXOUhLNk5FYmVubndhYkhMdG9qVXFRYWIx?=
 =?utf-8?B?UXRHVmU1TDFPOS82b1BFSEFWN3JvUkNRU3RBeGtsRXRKby91cjA1T243TmdE?=
 =?utf-8?B?bmh6Rm41eUUzdHQrakdvWWFNZlVRNGRKNGFqdit6eTllVU9lK1psRjhDc2N4?=
 =?utf-8?B?bWF5b1M5bnUrUlg2dmY2ZGVuVm5aVU1LT1ZsYUo1OVBmQk1BS3RQUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b629098e-9d6e-48fc-4332-08dec6b44161
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 05:51:02.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7hnk9Iad101nE4iu294zAE5/6eEkwmqf91ji4cKqVdjUTJDgp5I5KRjPxi+WEMtb7a5TOAfgnrE/jTQkmQx9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297449-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.jiang@intel.com,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 942A4666026


On 6/9/26 23:18, Dave Jiang wrote:
>
> On 6/9/26 2:57 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A PIO buffer is a region of device memory to which the driver can write a
>> packet for TX, with the device handling the transmit doorbell without
>> requiring a DMA for getting the packet data, which helps reducing latency
>> in certain exchanges. With CXL mem protocol this latency can be lowered
>> further.
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Add the disabling of those CXL-based PIO buffers if the callback for
>> potential cxl endpoint removal by the CXL core happens.
> ^ This seems to be missing?


Yes, this comes from v26. That is not happening anymore and I forgot to 
remove the reference.


<snip>

>> +	/* Set up the WC mapping */
>> +
>> +#ifdef CONFIG_SFC_CXL
>> +	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +	if ((nic_data->datapath_caps3 &
>> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
>> +	    probe_data->cxl_pio_initialised) {
>> +		/* Using PIO through CXL mapping */
>> +		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl;
>> +		nic_data->pio_write_vi_base = pio_write_vi_base;
>> +
>> +		probe_data->cxl_pio_in_use = true;
> Don't think this is used anywhere.
>
> DJ


Right again and same reason: this is not needed anymore.


I will fix it.


Thanks!

<snip>

