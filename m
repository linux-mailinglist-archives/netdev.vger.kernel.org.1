Return-Path: <netdev+bounces-192257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD91ABF21B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE654E4BEC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113F2397B0;
	Wed, 21 May 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4CKa7ONS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C372309B9;
	Wed, 21 May 2025 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824661; cv=fail; b=JBmLfhHNXwxtM57jhXpUFTVRnH2HbRQXWndjXbqqMRskVc/SRtCSRJspMyw8quL0r4v51TKt4KWcZhd6lby4J/BnINxWHieZGF49iU/wXfuvNN2h20sYFAgujjjYoyayyyRL4DZNok4VOe8CH8Vcae0dbbuGAy/cvqd6YeKmnZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824661; c=relaxed/simple;
	bh=ZXcAIekx2Mrh9ctq/52SeeyMpZKgJ1LNr0MaqCA+IyM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lkhgh3+iQTWzx/jjxU+oRC4JT8diI52c3Uoz5yzbWJFdrwooM5OUJdVhXYORPXDT+SjWACwKzk8wIWPEUNTkA+0GTf0vPq9Y+EY6Ya78v1cFx8bbp367rI0E6oQifrYwogXIm6hcd+oFO6sOql5dgzt8AMySAZMXjUdlHID1m8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4CKa7ONS; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TySl7bjTXG3Huq32tyGWpVqL/NEaP0UNs74JWrJLz6RNRs8lmwRw1Eipw/VbpMm/M0ofddVaYXj/V8u6czZWQNRIKXN8eJKQ/NdrXs/uW4I6mwhxjFKdLEB98QtdCz05D7b3mBZCA8FPrrjzG5he0lEqA3MsKIHQ/im9ubaekyr/+gZ73ExMxjmhuSDrH949AP3aQ3RSrYXF6c37VS6iqyINj2Fld5aAZfaqWgfyY2EP1skhP6nYWqH7Aiun2Q953pu0uKxT9U8/UBO8RMEt4Qzw9mCs1Zf5TpQN5LVX5MLrf/0h0ed5DVcAMwPaosGBjsAhqWJD5XC+DtKzmfB1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6g227+FjTmlHRz8o2eqCwnei5bFH5sQm2mgTE/y95E=;
 b=bqaDXUl9QiX8hrPfOOcEzwO3swQpyUendiOhWiR6anjrq+gBkaMQpJBPz804XKkC22iYlIXSIR3amQKurF0beKKRTUqBh8oq8XK+RaLeLFWuXerLGZ+oIv75hBRiHu99nWIThPwDj3fyhmCSp3QZmnsOQnW59MSZtB2I2+hR3N2qNdK6pNgjWIzn/RGOHtzivtx1RPgJyqMVQ5ztQaTcU9CdetSvKiOE+CxBNUOdau1hEfIH6105xM0I9tT2B66rVsr7vFHcA5o6u0HK8f0TG/E39NjCcFssnKa8t1tk+/MroReb3ZVgt86Rtocgu96AGyPG27NR8VnuKqpvo5nKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6g227+FjTmlHRz8o2eqCwnei5bFH5sQm2mgTE/y95E=;
 b=4CKa7ONS5yczJLC8BQcPFDzmIYBF0oRGJXpBcMZl+3k2MsnrhoeTq4bVs8LRTbFQX7DjfuLp53kaU9+3W0vaJJQ7i8lORGt8VxK5M/Tz5Y8LZMjs0RIXxV3N4mX49JvQFV0rHHcv+3PeRi2hQ2k1YSLE76lxoX1XUNPrE1TEn/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 10:50:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:50:57 +0000
Message-ID: <172834c6-0cc7-479b-be04-5ccd5cf8aae0@amd.com>
Date: Wed, 21 May 2025 11:50:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 02/22] sfc: add cxl support
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-3-alejandro.lucero-palau@amd.com>
 <682c3129d6a47_2b1610070@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682c3129d6a47_2b1610070@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0100.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: bd662875-62c6-445b-777f-08dd98555dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUJwM25aU2p4OXAvaWNVL3VZMmJTRXVZSWJNZWt5S2syN0hYaFFFRHZVa0pC?=
 =?utf-8?B?dUtwR1NkL3BxV1I3K3FGQS91SWpzbmhuWHptdXo1cG4yT3FvcEZ6YWRTQytI?=
 =?utf-8?B?OGtCMWhDL1BkRGgrWEwyc09ZNkhVU0ZENlRkQmVaNU43clpibFIxM1c3b2NM?=
 =?utf-8?B?NCt3N2MwRnVkdjRqcXpVOFBkM1RPYWt4bnVkQkFVd1p6aGJFamtVeGtQd2pk?=
 =?utf-8?B?ZnJWUUZjZklaTWZQL3pHNmRwQys3L0plTkNLdDhhTDc5eGN3Zy9sSTVncVNs?=
 =?utf-8?B?RjlWMENlTGgvTWtsc0RZV2R4TlNkU3hkSXpFSWM0RVdVSlc2NW4rUjNiUUZa?=
 =?utf-8?B?N1lMd2l0OG5ueFJlenJxSUpvcGhsUUhkODBYWWJZQ1VQTVhmMTFkTWJheHFa?=
 =?utf-8?B?dXo2alVSdW96MEloazVRVG80dzkybWlUazdIVWN0MS9lTldLVEw5T1ZXYm9y?=
 =?utf-8?B?YVpxeWVta0Y4aXdqOXlxclFibEZSNEJORWQ1R2lDMHAvQUJPdFBIb1RrUmJq?=
 =?utf-8?B?RGJrZUg0SlVST0F0WDI0dlhaNHBHSmxYd1RvV0E0ZWU0dWlJczFRRG9RVEtw?=
 =?utf-8?B?bHBIa0c4c3hqT1dDRmQ5WStnVGJ2OUxRcTFkMFE2ak8yTWhFOGRLU3czR3J4?=
 =?utf-8?B?MUp2TEdiTW1vckh1NUFvMHRlOHRUL2o2TEcwOHdaRHBwQ2wyZ1lOWlc5ZDVF?=
 =?utf-8?B?Q2hiM29rRkwrdFRqV3VYbDBwZVpxUWdWRjJZU3M2NEpLdjJ0a0FEUFUwSHQv?=
 =?utf-8?B?QUwrejg1cFFqc0hKd2M1dlJRV1ZrR3RVVXZGT1VNZmpBZUFYQW5yMzJiVXo2?=
 =?utf-8?B?UHJNQi9LZjBad00zdi9NZGE5ejFTOGUwTjA5N1ovaW9KYjF2M2l0YUFjdThY?=
 =?utf-8?B?N1lhdDZwMXhxY2pZc1RXYU1lYnhEUEhNWTlBL0txVzNYL0RGYisvRjFkUmpn?=
 =?utf-8?B?UmJPMjR2RzZsekpsTnVyUlZVRHJvWmZRSXIwWFV3R0ZGWUczVkUrTndqOGEy?=
 =?utf-8?B?OThSMTNvVEhnSGdmRTVpV3A1NWx3RjZBQktSWE40WFN1Zyt0OUsvSG9QcS9w?=
 =?utf-8?B?Y2YrNGJyOHRIdG43ZThPYml2WXl5dDhBeGJGNmNsZC8xZGp5bVFXVXdlTHBH?=
 =?utf-8?B?NlVoUmR0bkZkSEoyZitQWWt5TDVhdTdUaXZxLzBoSTQ1MnBCL3R4M3VHNkta?=
 =?utf-8?B?Wk9xMEVGNXNqZDRqRHNzR0xJQ0JOQzlqSTA3QjdnMlBCR3d4NzVSTlo0SC94?=
 =?utf-8?B?YzJxejI5UTl4Y2wxT0FLNmVRbHpWL2R4SFVLL1lvbGQ1MURwVzJ4VEQzQXZZ?=
 =?utf-8?B?eHg1TU0zYjl1NTdnR0QyejJLWFhuQlJQdXpMekU4TEVIY1F5MEIvelJrUTg1?=
 =?utf-8?B?VXFRckw1UmpBdVV6OHpCZVNtUlI4VExHY09SRFNBM21lQ3ZwZmF2a1VsYzU1?=
 =?utf-8?B?V1VuUUQrRVJ6R2wzcUdjV3ZLM01EZzBvbGJROTk1TGRiQkdIUnJxTUNHMUpV?=
 =?utf-8?B?Nk1OUkE2U1Z6eWhKWXp5aHFISnVYS0NuYnZiZFY4RU1JMzkxZ1ZrcHlhQlFV?=
 =?utf-8?B?RFRjN3ZlSHhHVERVaEdPOS9aNVZRQng1bUFEOHpocVR1bjU5dkhUdDhKZ2Q2?=
 =?utf-8?B?Z2I3bUppZWV2djBmSUFqTGY2L1RvaG1Ca3JUZGZ2NnE4RE8zTkg3dDl0S1Az?=
 =?utf-8?B?aCtFeXhhUmZkcmNockVnaWpBU3FlWGZiaU5DelR5VFIrOG84QXBoUWxoV2Jk?=
 =?utf-8?B?ZG1TRDlWK0pDbm1HNThLeFQ4WjAvYnlXdWNrVzJrcFVsVFB3VXFCeXM4OWVl?=
 =?utf-8?B?b2VNVVVtVUhTa00zajJqOFAwN3JnY0xGVm9vSDdHZDNYRWZSaDZIc3VGNlhy?=
 =?utf-8?B?aHlWN25VVEpyRHFBRVZJQWlEQVhnUmI0WXNhUXplTjM5RnJZOVdpVTZ5bXJj?=
 =?utf-8?B?aVRSWlZjVmNvNlN2eVVQMXV0bWl2UEU1aml3TVhJL3BITXVwNURvSnFDbm9O?=
 =?utf-8?B?dUVjbCs2M0dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUNZUlRnZHBCMGxwUDZ5aEVCZG4zajZab2YxQS9aL1VTUFRXWG5jK3huNmZE?=
 =?utf-8?B?VlpTY0FHbEFUQW9Kc0lsdTZVY1R2TjVwN3BNWTQwTFZSbEc2UU0wQlJIYVYr?=
 =?utf-8?B?V0FyZm8wUVhDQnpUTXNkMGVmcWtLRG84eHl6MkJIRFA0QW56bTA5MTJWWDJa?=
 =?utf-8?B?bWdUZDFXWStMYkc2dkprNGNlajBQSVN2S25GMlBzb0lJTTY3U01qVC9wdWVt?=
 =?utf-8?B?cXp1eVlRRGtrcVdhdFZzQ3NmclVuSVNzRytqWHdiaWdpT1NaQ1N0UkMzTTBR?=
 =?utf-8?B?U2s4Nit5N3FtcnJIMm5jMU1LZ0xZZWZ3d2wrak4vb0llK1JSZWZyamY4ejBQ?=
 =?utf-8?B?RUJCK2tTenJKdllkYXlvbFBJWUJ3QWVYYzlrckoxNSs0b2xwSzB3T1ZGUGlH?=
 =?utf-8?B?YnN1NnFTb0lwY2ZESkpLQWlmTTl1MDdRTGRyRGxhd3ljRlJoc0ZVcndzYnJs?=
 =?utf-8?B?amN4MlVRRlNUdTBTbVRWd0JBRDB2N2svcVBQWGNKQVVsY3Q5bW5zWlJwbUNi?=
 =?utf-8?B?bjU4bkdBNXZ4c3Z3SGs5TjdENUYxVlF2Mm1PSndjcG8wMitxTW5Rc2ovSy94?=
 =?utf-8?B?M2VXNTRobmx4cVlqU0xObXlOWWx2RDlCUGNRa1V6cis0RTBkRUl5MVVpOERt?=
 =?utf-8?B?V1ZPNkJQdk43K3JVZmp2TXFoRENtOFZqTnZERXVwZ293b0dHNytsdW5lektr?=
 =?utf-8?B?REdKQ1AwNWZ6M0JjOFlROUlZbkRjQk5BbUQxY1BmMFFRaGJXZmkwbGF0UVFL?=
 =?utf-8?B?WkF4NXlYT1JDVDV5RXRtNy9pbU9mLzlRVE8rUTZ1V2dJZCtFN3U3UkNqSzlI?=
 =?utf-8?B?a3d0TXZrWDVLbkRmTTNjVXBkSHFGdGpOMkdPTjlGWHdYL2FvaHUyODVvUEJL?=
 =?utf-8?B?QnlRVldnbjNpcG1TaXNCQWNtRUdtRkRtM3lhSXJ6cWJOM2tBS0ZRM0xNWTJ2?=
 =?utf-8?B?R3Y1dWs3UWVidTdPZjhrMm1XV0xZOVNoK3JZc2RjZHBSV3kwRi8rWVNQTFda?=
 =?utf-8?B?aWxwdWI2Mkxia1ozZkNleXdQdUx4bTlLaStUeGVoa0ZCMExJeEg5Mm5JR0RB?=
 =?utf-8?B?RE5nWngwK2d1NWFnd25NTHJZWXpWV0ZCaVhjTm9OcUtKTVo2S0RKMWNHZmVK?=
 =?utf-8?B?ODBoWnNucFhUNlBwSWdVYlA4NmdpT1l5TU5BN1BDZ21iNWdwaDhhYzREZ1JZ?=
 =?utf-8?B?V1R4UGdLZ28wQW91MVkvNWFZbXNsN0RrYThKKzlMYUNvRWh2T3FhNk45VUpq?=
 =?utf-8?B?SERQR2pJOWhrTXFUdXJqeUZ3RHA4SGZtR2VuVHlFN0txY1AreklnblFCWm8y?=
 =?utf-8?B?bmhvRVhnRFNYYkp2YTQyR2hpbjBTSk4yQ2VOWWpSTDBKRkk3emRET3A3SStY?=
 =?utf-8?B?NjM5VmRLcERoSGt1ZzhqL081QkZZNnkxWWFDclpIdTFpRkRVcm03QlA3dXBT?=
 =?utf-8?B?M0JVRU5RMWxmU0VobkhKZXRUTVgzUk5kMDBPQkR6MUJFcExaZVE0Y2lVbHhN?=
 =?utf-8?B?WSs3ellmT1hFMVF1b2cxNXZoKzRoQ0VHL01KRE54U00zL2E0Z2VYMjJJNVNP?=
 =?utf-8?B?cU9XdFpYZGR5Q2NNVG1FZ3JiZXpHei8xdHFldmF4SVEzMm9KZC9vWEZSVldV?=
 =?utf-8?B?T0FrZUUxUmNWS3Z1N0xpTDE1Tk10WWtOQzFNUklINjVveCtFQmVRVlZSd0hi?=
 =?utf-8?B?YXhFTzNhQkV5TUVkOFJsM21sTlkxTldPeFVHNHMxTEEyYStBb0tvZ2RCb2ta?=
 =?utf-8?B?RjdxYTRKaUdwYW9ERHYvNkRRWmdSTC82VHVDOXJUZzk1OGVJVEpQOGN2c05v?=
 =?utf-8?B?TkR6disrelFUdnE2VGxqWk9lWktiVjdjRTUrOHk0RjVSdE1ZNmhQRXZ5TTlF?=
 =?utf-8?B?NXYwVGYwbVJId1ZvTnczU1cyODF1RFMxdzU4bWNNTkxqNlBuUzBCUTJBNGN2?=
 =?utf-8?B?N2g5YWRLZVUxRlArbXYvbDUrUUJFTzd3M0hGZVFkTmNzQVl1QXRzZURUZ1Rt?=
 =?utf-8?B?OThLSlcvNzNFNWJiZGNNRXV3bzBYY1FtODduY0kwZWY2OFVXM2cyVU1ha1g5?=
 =?utf-8?B?MFFtVTRoOERyTzFuYkRscVJ5bi90dGZIU3hpY09lNjJTM2JRSDZ0TDk3ME9F?=
 =?utf-8?Q?lPFDWiIinvIOzaroG1ThdResa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd662875-62c6-445b-777f-08dd98555dbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:50:57.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8uZKygGdY4ydYIBAlyXCHWVy/4wJS77HfLqTs7AMx9eEO8r0V1Djkl5/ku6ZPz7EVuugOk3dfhxkaYFS5AsTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795


On 5/20/25 08:37, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  9 +++++
>>   drivers/net/ethernet/sfc/Makefile     |  1 +
>>   drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
>>   drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>>   6 files changed, 129 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>
> [..]
>> +int efx_cxl_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	u16 dvsec;
>> +
>> +	probe_data->cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
>> +	 * specifying no mbox available.
>> +	 */
>> +	cxl = cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
>> +				   pci_dev->dev.id, dvsec, struct efx_cxl,
>> +				   cxlds, false);
>> +
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	probe_data->cxl = cxl;
>> +
>> +	return 0;
>> +}
>> +
>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
>> +{
> So this is empty which means it leaks the cxl_dev_state_create()
> allocation, right?


Yes, because I was wrongly relying on devres ...


Previous patchsets were doing the explicit release here.


Your suggestion below relies on adding more awareness of cxl into 
generic efx code, what we want to avoid using the specific efx_cxl.* files.

As I mentioned in patch 1, I think the right thing to do is to add 
devres for cxl_dev_state_create.


Before sending v17 with this change, are you ok with the rest of the 
patches or you want to go through them as well?


Thanks


>
> The motivation for the cxl_dev_state_create() macro is so that
> you do not need to manage more independently allocated driver objects.
> For example, the existing kfree(probe_data) can also free the
> cxl_dev_state with a change like below (UNTESTED).
>
> Otherwise, something needs to responsible for freeing 'struct efx_cxl'
>
> -- 8< --
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 112e55b98ed3..0135384c6fa1 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -1149,13 +1149,22 @@ static int efx_pci_probe_post_io(struct efx_nic *efx)
>   static int efx_pci_probe(struct pci_dev *pci_dev,
>   			 const struct pci_device_id *entry)
>   {
> -	struct efx_probe_data *probe_data, **probe_ptr;
> +	struct efx_probe_data *probe_data = NULL, **probe_ptr;
>   	struct net_device *net_dev;
>   	struct efx_nic *efx;
>   	int rc;
>   
>   	/* Allocate probe data and struct efx_nic */
> -	probe_data = kzalloc(sizeof(*probe_data), GFP_KERNEL);
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (dvsec) {
> +		cxl = cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
> +					   pci_dev->dev.id, dvsec,
> +					   struct efx_probe_data, cxl.cxlds, false);
> +		if (cxl)
> +			probe_data = container_of(cxl, typeof(*probe_data), cxl.cxlds);
> +	} else
> +		probe_data = kzalloc(sizeof(*probe_data), GFP_KERNEL);
>   	if (!probe_data)
>   		return -ENOMEM;
>   	probe_data->pci_dev = pci_dev;

