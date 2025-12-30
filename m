Return-Path: <netdev+bounces-246357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1505FCE9A9D
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD2C300B980
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9502D94A0;
	Tue, 30 Dec 2025 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MMJsmdKy"
X-Original-To: netdev@vger.kernel.org
Received: from iad-out-005.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-005.esa.us-east-1.outbound.mail-perimeter.amazon.com [3.211.80.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004633D76
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.211.80.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767098004; cv=fail; b=HCPtHfcqQEpIj8zu9ue8tx1/w05KOBSnNhRDM3oZTRcGmqZx/ekiIsLwn72ar3l5HSq4wLJYtdQkh3z+GssIoBHLmN+hkzP6o/zYz6FK9Z4FibvWd9TC12HKng1So3CJ7jYuh9zaNSXTMvJQdcesODd5MsETbYzUSPvwXtlVNs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767098004; c=relaxed/simple;
	bh=uAwNzpb73VCh8nKuFkoovWom3zhjF6MtBdV7g1lkRK8=;
	h=Subject:From:To:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KtobqV2clhx/RTKoneWv5HR6NRZs2hrtIScnLjBf7vEwMWosOqkYSo2L/sNxNOC9vbnmQKBOI0flCuEMvImLlGOzZzZpPP8wMIZdhTyQOmoeFJ1AV/Ui/OzTFuz0ENaIDFLAA5zcwwEbeaOiqrC5om+diDal3IjBXWeuYej2CqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MMJsmdKy; arc=fail smtp.client-ip=3.211.80.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1767098003; x=1798634003;
  h=from:to:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=uAwNzpb73VCh8nKuFkoovWom3zhjF6MtBdV7g1lkRK8=;
  b=MMJsmdKyRwfPCXhTbnVkCb4+RFwO8Jo8wB4GgeugNKijk746cqI+Cesi
   hpo1mq8DxNfZX9S8k6hz6GnwPwZMRoOdxuFzN6VzArbqWeVS9N9w6ULH9
   mLJx3S5y8Zu2o/5T+n8Jw+fOYELrtiM3Wnab/XuDPY/KshgMGApouwO5H
   ky6EMkVNgrzEI1kZNe3k0dpY9E5ZQsARsIUTUkP3EMeTte2BKOhuZrkA6
   gJI1lPDNFW5iBG25xAVXHycVv6zuUw+ssruNdFkAxcJfxXV7IcGX61Joq
   JU3NYaH70brgmyg6MsmFiG5HqNAVV1svBt7OSsNaUEIpEjTiBLyrDzohG
   A==;
X-CSE-ConnectionGUID: VuP8pgpIR7aIKujU721Z4w==
X-CSE-MsgGUID: EGsPaad/S7ePgJZLhL4H8Q==
X-IronPort-AV: E=Sophos;i="6.21,188,1763424000"; 
   d="scan'208";a="9179302"
Subject: Re: [PATCH] net/ena: fix missing lock when update devlink params
Thread-Topic: [PATCH] net/ena: fix missing lock when update devlink params
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-005.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 12:33:18 +0000
Received: from EX19MTAUEA002.ant.amazon.com [72.21.196.65:12526]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.27.172:2525] with esmtp (Farcaster)
 id bb9caf07-d0b4-41f7-b194-a08404096d5d; Tue, 30 Dec 2025 12:33:18 +0000 (UTC)
X-Farcaster-Flow-ID: bb9caf07-d0b4-41f7-b194-a08404096d5d
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 30 Dec 2025 12:33:18 +0000
Received: from EX19EXOUEA002.ant.amazon.com (10.252.134.207) by
 EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 30 Dec 2025 12:33:18 +0000
Received: from DM2PR0701CU001.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEA002.ant.amazon.com (10.252.134.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35
 via Frontend Transport; Tue, 30 Dec 2025 12:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFkApfXtNjazZfHCDf2sDo83tbKGFHkF8Oik2yNY+2V8GWco6YjJaJGFF55E7U5OsjrBBmbWjDjYyk/b7CRU3WrQo2PZyzkeVHJruuodCF1/hS22aahZ8gvS+Bgs5PMri3ipqQocs/qUFyPU4OTznRLPL99qHgAFwOQ7KJiNHTg2tBpQUimQZKKIpu+8cMoq1UmZCcUH0XaFwscMI/Sr9N5XmTLCNthRprqpZjvj6ChzXnNOZEMtscMjMc9XRa8lsqCmTKmps3N3V+V5hKrEry3aaffJbbQ3/HmvwWIsicdXqAY6KbbK+j7i5vtVIEMX+bEgBwTISh+KtzPAq2uEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAwNzpb73VCh8nKuFkoovWom3zhjF6MtBdV7g1lkRK8=;
 b=k/KP06MYaMWVxC8wLUNxohvHLEKx4vHfqs5CH6mygU4o3Ynjc5Yr0Wcq19wqOWlmBCDpt/2hAqmk6cKmDF1i7NOgvmIyg0wcLEs4Se6vzCwG98+gQsS1LxNFw8+QtYS4wtoxZ88wSMxGIusj2Fkj/vPPb06RldFcyICjOSBn7TjgWfD7dqcTZnuH2zeOzJRXh0lUv5ehLaluE/dkx6WVCZWQr/CGvmuBV1zQZU6Cre0w1CHD+Ias2uwZZqJFnaCp+BVxUR2lXqyJPGVHh6Lc8804RmJ30DM3piRpd455o4h32k/CtZfRWPG+RLNZ7J2/98zx+5xHgWRQl4nEPFHcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MW3PR18MB3692.namprd18.prod.outlook.com (2603:10b6:303:5c::7)
 by DM4PR18MB5100.namprd18.prod.outlook.com (2603:10b6:8:49::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 12:33:15 +0000
Received: from MW3PR18MB3692.namprd18.prod.outlook.com
 ([fe80::8b33:29d:1fd3:8c6]) by MW3PR18MB3692.namprd18.prod.outlook.com
 ([fe80::8b33:29d:1fd3:8c6%6]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 12:33:15 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Xiao Liang <xiliang@redhat.com>, "Allen, Neil" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Thread-Index: AQHceNOpT3OLXN0A1UOCdjq9RvDBV7U6QM4A
Date: Tue, 30 Dec 2025 12:33:15 +0000
Message-ID: <CE7F3E29-4D6B-4709-B991-0885C84F3020@amazon.com>
References: <20251229145708.16603-1-xiliang@redhat.com>
In-Reply-To: <20251229145708.16603-1-xiliang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-12-30T09:14:34Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=f311dc6c-e035-49cc-a993-8345d4bc0cce;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR18MB3692:EE_|DM4PR18MB5100:EE_
x-ms-office365-filtering-correlation-id: 2af6a75c-56f2-4ad7-afa6-08de479f9af2
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dnpDYjRJemUwN1pPVGtUQWkxQzJTZnhwbnBnRXJubEsyQ2pJYU00UHNUc2J0?=
 =?utf-8?B?aVJSWHVTUWorNzg1OW5IeTdidnNialUzbEd4WUF5SHVJZjgvbmNGazBrTHVY?=
 =?utf-8?B?MzEvdzFzbVVXVEdwbElxM0NqcHYxTW0rQmVjVXR5YmNCcHZjMk9VS0craUFp?=
 =?utf-8?B?ZWdVV2UvbnNhcjBPanhPVVNKcHk3TWtBK0Z2NDVZMVBkckNXbTJzb25NL21Y?=
 =?utf-8?B?QUJyV1JNOEEyZXMzeXZ5VlNtS2kyZEhZekJ2VzlQMWdOMjBuRjdyS1VVUkh3?=
 =?utf-8?B?aGVJUEhwSDQ2a0FVdFpSb2YxSWxJc2Q3VVFJcUhUaTR5bkFENmcvN3Y2bWxH?=
 =?utf-8?B?azd6YktKYXJYQ0dEL1ptVnFONjQ2aWJZNGpHbHF3MjRKOThKNG01QXVJUXBX?=
 =?utf-8?B?MjNyN3E4WDRiZW9NQmtjOGVLK3VnRmlGRXQwdTVOZ3cwV2IzRlpHQ0h4c21o?=
 =?utf-8?B?TFdqMk5vcUhzbTFVeEJoeUxBL0Rzam5GcUpWVDI0TFVSYUdGWUgvUjZmR1Ar?=
 =?utf-8?B?enZ6RkNyc0RRUERkdGVvaW0rb1ZOc0xsbkZCcjNtUFl6K0VPV0QxSllEb0ox?=
 =?utf-8?B?REhpSnV3WkdDQ0trOTg5YU9DY3FCL0ZuSnltZDBIT1pPT3RlWUk1Vittd1lY?=
 =?utf-8?B?YzB3M1FhWGtNVHFDTE9EUjFSeW9BZS9jWG0xSmg1ZUNhV3lMVU9RWW50WmFt?=
 =?utf-8?B?UlRKRWM1OGxsZmc3aEdvdHlyOXZSZXpPTDNZTEI0alB2TVRJRlVzdkQ3Zms1?=
 =?utf-8?B?cCtNRDNYZFlJT1I4ZE5PMVFoeVF3RHJvNzNHamowbXA2a3I5djlSL25CeUJx?=
 =?utf-8?B?UkpqUmQ0WDRyakFCQy9HZktlZjlZR2JhQ3Z0bCtxdXRia3oybHVtOTlLbHdw?=
 =?utf-8?B?WlJUd2hZTDFsV3QvUFgyMllvZnZmbVdaMXJabXh3c2hlQnhFUmtuVUVGYVZ5?=
 =?utf-8?B?ZkJQK2ZkRWtxc1c3aHJGcGRzdHAvRkRxL0p2dWdBZm50NWQ3MGNBZWZRY1d4?=
 =?utf-8?B?alA4WTZ6U21menBacXYzNmJGNndpWXhpUjRmdnhwRldaUVFNYytBdzk0S1Jq?=
 =?utf-8?B?dXE3YlJlN3N1MEhyNjQvL1NNSWExb2pWWkZpOThxZzBIdnBlaW1VYWR5QXVp?=
 =?utf-8?B?ci9DQXRDSnFBRTRFRTJ1VUlwRlA2ajJIbDBRcHhYNHBlNXhSdE9FM09XMGhS?=
 =?utf-8?B?dWsvTzRJdktManJJZ3l3TzBuUCtVbFlFTDh3TFlSR2pFU0cvWlpmditsajVG?=
 =?utf-8?B?Q2lCR3lhVXBINUEyZUpxMFpiSkJwSnBnejhCWG1DQW5Nb1ZzTldhUE9NTmNR?=
 =?utf-8?B?WHZBYUZVNjRHMFhzYm5HQkNCRzlWT0E1OUhZUHJlaHo1eUl2aGwrNG9oSlo3?=
 =?utf-8?B?RU5wOGJwZ1ZPMXQyYkVVdU1KRzNCSEpLYjVnbUdvNTd2Q3NBeEtKMEpYeFBW?=
 =?utf-8?B?SExHeXpJMHdDUHE3N0RXSmJwUGU4d2JSbElMOVFoMyt0T3hhWXcrNkFsUVJI?=
 =?utf-8?B?U3YwU0ptS3VBRVBLMHoxMGZOUWJsZDJ4MSt5UUQ5R3ZXTmNDUHpwYm9UcjZ2?=
 =?utf-8?B?MVFEZ1RSY0ExT0VqTHlyRXU5UWh1WTduTmE1bTZFQkV1RXovRUJ5RldjNk1D?=
 =?utf-8?B?SVdKQ0pxZC9DaUhYYzQ0eVgxaEJIN1MrVE9VVVE4UzhSaDUxSzNZanMybEZr?=
 =?utf-8?B?S2JYNDB3dWRJYWhNZ1pzN3ZXbFprTGRSUkhjOGlmcGFTN1RZd0wzSHRJc01q?=
 =?utf-8?B?QStwNG5sdzIwWVdYNzJkUmt2OHc0RktRWUFqY0hwZ09GYTdDV1E1dGkrby9s?=
 =?utf-8?B?enlhVGptTHRldUdsM0U5VnFuc2FHWEJkYXF0UHd0eTBIY1dlRTFIRG5hUkw0?=
 =?utf-8?B?ZTgyZm5VRUlvY0xGVXJtRVlUZmE4T2ZCRzVZN2JRcFVtbTZJcWdiODE4TFA5?=
 =?utf-8?B?bStiMHY0M2FPclFSVzF3dnhaSFoyQ0wvSWdLc210VzVOVXdkMnhLMTFXN0dl?=
 =?utf-8?B?RC9MZFRmU29EVExuOG1FWXgySndaL0o2b3l2bC9SVVRHZ1dGbHNtazJvUUlJ?=
 =?utf-8?Q?GHPOVC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR18MB3692.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2hpbFUrK0ZsekJvMVVYckoyNVJUUGZtNEJUYWVYN3Rlc2hNaXlKWVZYYjJ3?=
 =?utf-8?B?eEVEd3RBb05JY2h6UmsrTllXNXJza2hMUmRSbk9wU2RGWDBqOVpMMFZ1dTJy?=
 =?utf-8?B?MHFBbC9GN1dLajlkTkxMNFBiRUErTHgxTFYvUjA1cXBWTWVoS0laZE0zSHpW?=
 =?utf-8?B?SUxra1VaeldsMGdEY0pJRmRMYXlHdDVQUDZLa3c2aE9KL3h5cytGQVIxUm5p?=
 =?utf-8?B?RzhrVEdyQXNYSjZ4Yk5NTHhaZ01MMHhaSU5JV2NtVHpaYlhGVEtEUWVpTG5T?=
 =?utf-8?B?RGRoUHpwQjR5MnVkdC9EWjdQMXRMa3RVSnJXVGpxM0lYSCtWbzNCcEpUOVNq?=
 =?utf-8?B?c25LZnVLSFp0SlFFc0V4bkhHVTBLZGMyM2RBWVpDdGxEM0N4bmQ5OFUvM2ly?=
 =?utf-8?B?a3cyQzgrRjVQRzJiVWk1TTZxMXdzMjNORFRXRGZoYkdZOTRxZllNL0RCUEll?=
 =?utf-8?B?RFNCdmZoaUxXNzl5amJFbGxRYUNmaThjWmhmMlJqMEpYbzVlYVlEaWxQaVNh?=
 =?utf-8?B?aDVidHo5Y3FDTHdkRVBoUDZMVUZrblYyaTd1eDVVa2RSdVZieGtZZnU2bHRY?=
 =?utf-8?B?RFJRTTROL2gxek9kZHJ6S3ZiNkFTWGE3aXlFK1d1OHlQdnhrQ3ZDSkdER2Rj?=
 =?utf-8?B?OEl0ZXAvRFBvcW1DYzJyMmJ6WkpXZGlDeW9EWStQcVdyY0tKUC9rL0hPZ2M3?=
 =?utf-8?B?eVA3YWFKclhWdUhqdER4ekdsNGtYOUdyWE9oRmVONDlNbHZ3emtYVVJvRlBH?=
 =?utf-8?B?TitqeDNmZHg1dk5uR2xMekFOK1lSSVZKOXVTQ2wyWWlQbkljWUU3bEVJQUJJ?=
 =?utf-8?B?QzF4UGFIb1BraC8ySFdDdExpcW1yekppVW91ZGV1RkFQZjBhaUtzR1J0b3pI?=
 =?utf-8?B?K1hCa3NiZ01wY0NXRTVETnpidlA0ZXc2VGlrODhiTlhIK3dmVVlpK3NtaFdX?=
 =?utf-8?B?TlJtMXRWR2ZKanBJRzU1THlaVVZaRGpmWXRMelZCUjdwMTk3ZWdFUUd0U1po?=
 =?utf-8?B?VjdEeW5VT1JiRHVsbGdBbnhjS3hMQWpTWGw3bE5STStrQWNpUlNBR3pTOFcx?=
 =?utf-8?B?Q1oxSUYvTTg4ems0dW12NldLdWgyc3gvY0l3YVZKUVhCc3pUa2pwV2Q1Uk9B?=
 =?utf-8?B?RkxtTDJ3cTJtU0ZUZGdXNkNYQ1Q2VlRHbXBlVk52Z1dOMnRzK2NrYm9rUWsr?=
 =?utf-8?B?cnYzbStGTG9RUDA5U0xMNUZ3eTA4blJZRWFhdVpqbzczdk9Za0duT3JKNVAy?=
 =?utf-8?B?V0RMTElCcEE0K2h3OHAzYnVYQ2djenFBMGIyYVpjbDExYndQL3diSHFDeEln?=
 =?utf-8?B?RkNka29PblZrekVVVXlINGQ3cFJRNVdIY0pEZzR3RjYxRkxGTjFzTnloV0Nt?=
 =?utf-8?B?K09QejRPRVU2Q1hJdU10RGp6SitHbkw1RWpETVIwUlNYTEJKT1BiLzdaRk96?=
 =?utf-8?B?UXd5VHk5VkxXVVIwcEpybWlNT0ZGSEtNSTc4WlcvbHo0ZkdNQnIxNXFTRW8y?=
 =?utf-8?B?U1AxdHFXTW5VcC9xZnBIbXJYTXJXaXN4MzdVamRWOUxhb1d2bnlxSCs3Vkt3?=
 =?utf-8?B?TkNPSFgrZ0ZFUGNSS0traDBsaHJaQXBBcVVnS1dsZkkyaHRwdGVON2kxc3NT?=
 =?utf-8?B?NDhYR25kRnVRZjJYaTNlNzFwcjdFUDlhMHRTUjFhRmVTUUUyVm5rWGRUaVlO?=
 =?utf-8?B?WUx1MDFVZk95VmFiU1ZzTVZZYlZ6Y3JYQmYzcDFJMENwaGRnUy93ZjVFSUxJ?=
 =?utf-8?B?TlhiYXltZWJHVmtoWFNMOExWaGNlQUxFdVlRM0VZaFNtamxxQzhTVEhURVAx?=
 =?utf-8?B?akc3SU5SeTlTVzRWOEllRkFYNmNXbmxMSmxEaG9qN1lvVkU4NnNHOFZzZW5s?=
 =?utf-8?B?TSthWEZ3Nmo3Rmo5SzBtalZ3YnNWT0FudUJUcEN4QmtNMTRDKzFuV3V3L0lG?=
 =?utf-8?B?ckg0U25vSloyeFRGaWpOSzBudUg1bjdTTFhNT01VNDRnWGp6dG5sa1ltVm9p?=
 =?utf-8?B?Y3JCeHB2dFBOczQrN2ZmM095NmJWZGp6eDNCMHZzVVNrTE5LZUp0dlVTMzFr?=
 =?utf-8?B?UFhhejRuZytSaHNUZVhoWXNNcmVVQzNGK2xPR0lzREIxSCt5eldud0RIT2Rx?=
 =?utf-8?B?c3M3QWpKTnJQMEF6S0JwQS9ucnZNL2VyUHo2N0xYMzRJTHRnZ3ROcmdBandw?=
 =?utf-8?B?SER2NEd5R0l1cHNFcG1ycHlNODVaeTFIRXV5L2pCZU54dERKRVVvaUNSMUU2?=
 =?utf-8?B?dTk3LzM5aHhFWEN1L1cySGlCeUYwVHhyTVpERFRUVnk2TU5lSEdkQnM5SHNn?=
 =?utf-8?B?bElnOTZSenVVRmJQSmxYTVRScUVPbGowMWtnL1cxVm54U0w4TWt0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0456C729C54AD24E8BB29FCEA077AFB3@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR18MB3692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af6a75c-56f2-4ad7-afa6-08de479f9af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 12:33:15.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s61rh2czhZZN+j7/5qVpj5BrHHOOnLqg0do+hcerD61LbAbvg8jffxBSlpke72AZPiklEHa94DCNfRgsA7xsIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5100
X-OriginatorOrg: amazon.com

PiBGaXggYXNzZXJ0IGxvY2sgd2FybmluZyB3aGlsZSBjYWxsaW5nIGRldmxfcGFyYW1fZHJpdmVy
aW5pdF92YWx1ZV9zZXQoKQ0KPiBpbiBlbmEuDQo+IA0KPiANCj4gV0FSTklORzogbmV0L2Rldmxp
bmsvY29yZS5jOjI2MSBhdCBkZXZsX2Fzc2VydF9sb2NrZWQrMHg2Mi8weDkwLCBDUFUjMDoga3dv
cmtlci8wOjAvOQ0KPiBDUFU6IDAgVUlEOiAwIFBJRDogOSBDb21tOiBrd29ya2VyLzA6MCBOb3Qg
dGFpbnRlZCA2LjE5LjAtcmMyKyAjMSBQUkVFTVBUKGxhenkpDQo+IEhhcmR3YXJlIG5hbWU6IEFt
YXpvbiBFQzIgbThpLWZsZXguNHhsYXJnZS8sIEJJT1MgMS4wIDEwLzE2LzIwMTcNCj4gV29ya3F1
ZXVlOiBldmVudHMgd29ya19mb3JfY3B1X2ZuDQo+IFJJUDogMDAxMDpkZXZsX2Fzc2VydF9sb2Nr
ZWQrMHg2Mi8weDkwDQo+IA0KPiANCj4gQ2FsbCBUcmFjZToNCj4gPFRBU0s+DQo+IGRldmxfcGFy
YW1fZHJpdmVyaW5pdF92YWx1ZV9zZXQrMHgxNS8weDFjMA0KPiBlbmFfZGV2bGlua19hbGxvYysw
eDE4Yy8weDIyMCBbZW5hXQ0KPiA/IF9fcGZ4X2VuYV9kZXZsaW5rX2FsbG9jKzB4MTAvMHgxMCBb
ZW5hXQ0KPiA/IHRyYWNlX2hhcmRpcnFzX29uKzB4MTgvMHgxNDANCj4gPyBsb2NrZGVwX2hhcmRp
cnFzX29uKzB4OGMvMHgxMzANCj4gPyBfX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKzB4NWQv
MHg4MA0KPiA/IF9fcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHg0Ni8weDgwDQo+ID8gZGV2
bV9pb3JlbWFwX3djKzB4OWEvMHhkMA0KPiBlbmFfcHJvYmUrMHg0ZDIvMHgxYjIwIFtlbmFdDQo+
ID8gX19sb2NrX2FjcXVpcmUrMHg1NmEvMHhiZDANCj4gPyBfX3BmeF9lbmFfcHJvYmUrMHgxMC8w
eDEwIFtlbmFdDQo+ID8gbG9jYWxfY2xvY2srMHgxNS8weDMwDQo+ID8gX19sb2NrX3JlbGVhc2Uu
aXNyYS4wKzB4MWM5LzB4MzQwDQo+ID8gbWFya19oZWxkX2xvY2tzKzB4NDAvMHg3MA0KPiA/IGxv
Y2tkZXBfaGFyZGlycXNfb25fcHJlcGFyZS5wYXJ0LjArMHg5Mi8weDE3MA0KPiA/IHRyYWNlX2hh
cmRpcnFzX29uKzB4MTgvMHgxNDANCj4gPyBsb2NrZGVwX2hhcmRpcnFzX29uKzB4OGMvMHgxMzAN
Cj4gPyBfX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKzB4NWQvMHg4MA0KPiA/IF9fcmF3X3Nw
aW5fdW5sb2NrX2lycXJlc3RvcmUrMHg0Ni8weDgwDQo+ID8gX19wZnhfZW5hX3Byb2JlKzB4MTAv
MHgxMCBbZW5hXQ0KPiAuLi4uLi4NCj4gPC9UQVNLPg0KPiANCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEZyYW5rIExpYW5nIDx4aWxpYW5nQHJlZGhhdC5jb20gPG1haWx0bzp4aWxpYW5nQHJlZGhhdC5j
b20+Pg0KPiAtLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfZGV2bGlu
ay5jIHwgNCArKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfZGV2bGlu
ay5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfZGV2bGluay5jDQo+IGlu
ZGV4IGFjODFjMjQwMTZkZC4uYjFlZWQ0YjNiMzllIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV9kZXZsaW5rLmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfZGV2bGluay5jDQo+IEBAIC01MywxMCArNTMsMTIgQEAg
dm9pZCBlbmFfZGV2bGlua19kaXNhYmxlX3BoY19wYXJhbShzdHJ1Y3QgZGV2bGluayAqZGV2bGlu
aykNCj4gew0KPiB1bmlvbiBkZXZsaW5rX3BhcmFtX3ZhbHVlIHZhbHVlOw0KPiANCj4gDQo+ICsg
ZGV2bF9sb2NrKGRldmxpbmspOw0KPiB2YWx1ZS52Ym9vbCA9IGZhbHNlOw0KPiBkZXZsX3BhcmFt
X2RyaXZlcmluaXRfdmFsdWVfc2V0KGRldmxpbmssDQo+IERFVkxJTktfUEFSQU1fR0VORVJJQ19J
RF9FTkFCTEVfUEhDLA0KPiB2YWx1ZSk7DQo+ICsgZGV2bF91bmxvY2soZGV2bGluayk7DQo+IH0N
Cj4gDQo+IA0KPiBzdGF0aWMgdm9pZCBlbmFfZGV2bGlua19wb3J0X3JlZ2lzdGVyKHN0cnVjdCBk
ZXZsaW5rICpkZXZsaW5rKQ0KPiBAQCAtMTQ0LDExICsxNDYsMTMgQEAgc3RhdGljIGludCBlbmFf
ZGV2bGlua19jb25maWd1cmVfcGFyYW1zKHN0cnVjdCBkZXZsaW5rICpkZXZsaW5rKQ0KPiBuZXRk
ZXZfZXJyKGFkYXB0ZXItPm5ldGRldiwgIkZhaWxlZCB0byByZWdpc3RlciBkZXZsaW5rIHBhcmFt
c1xuIik7DQo+IHJldHVybiByYzsNCj4gfQ0KPiArIGRldmxfbG9jayhkZXZsaW5rKTsNCg0KQ2Fu
IHlvdSBwbGVhc2UgbW92ZSB0aGUgY2FsbCB0byBiZSBhYm92ZSAidmFsdWUudmJvb2wgPSIgYW5k
IG1haW50YWluIHRoZSBuZXdsaW5lIGFmdGVyIHRoZSAifSI/DQoNCj4gDQo+IA0KPiB2YWx1ZS52
Ym9vbCA9IGVuYV9waGNfaXNfZW5hYmxlZChhZGFwdGVyKTsNCj4gZGV2bF9wYXJhbV9kcml2ZXJp
bml0X3ZhbHVlX3NldChkZXZsaW5rLA0KPiBERVZMSU5LX1BBUkFNX0dFTkVSSUNfSURfRU5BQkxF
X1BIQywNCj4gdmFsdWUpOw0KPiArIGRldmxfdW5sb2NrKGRldmxpbmspOw0KPiANCj4gDQo+IHJl
dHVybiAwOw0KPiB9DQoNClRoYW5rcyBmb3IgaWRlbnRpZnlpbmcgdGhlIGlzc3VlIGFuZCBtYWtp
bmcgdGhlIGNoYW5nZS4NCkFkZGVkIGEgc21hbGwgbml0Lg0KDQpSZXZpZXdlZC1ieTogRGF2aWQg
QXJpbnpvbiA8ZGFyaW56b25AYW1hem9uLmNvbT4NCg0K

