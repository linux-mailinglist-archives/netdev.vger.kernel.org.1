Return-Path: <netdev+bounces-156528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551F6A06C85
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 04:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881BA3A6181
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13E487BF;
	Thu,  9 Jan 2025 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="i8Dkzi1s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7713A26D
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394839; cv=fail; b=K0wsLI10rIOv/lzEGjoEspTHVh7zuEQbugmbldRF+pKtJo0Jqvc+wNKnXC2H9/c00x3fyLXMgxEX0UrXUCSiszNwltmQytLckgwiPeMGwGqBu66BzWyQUm3T/JyK0lJI4L6jhM34mdcvFQcy2bE1H2IMf/Dt1tad2OZi4t7HcX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394839; c=relaxed/simple;
	bh=iwblWNhy6rkdZekYjwy+EpSXq5C8MF86BVojcxTGfTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IMQgZKp71SH0HTtI/O32W8sexxmz1y/WFKvFUtdqOqgfj0q2b67htLBxVT1Pn1rXTBUC4FMjrFnw+jc5a+0nWfVwn1YXpcQks0kNFgQPXxVHBItnhV1w/zAthQ0mGOnUiPf226mGqcTT9+yXPGlOhZSjyqUZSKhP8Xg17ES7VEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=i8Dkzi1s; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ8hGB3p7McbFVNbf2N+A7PoWx7vPGRsByx/0k5+7IzkAChl8/gfDn8Cw55cONEnW5MYAODM/mtGBN5Xy+pOMb+ZcSKWnobET4L2VzpX5Lcik2GCiuDq5+KV13kt2LyKzdayxIMBoFUpej2iXuRurzABT3lel+lIymGgfwMysSNmOhx6Zqe+RKZOyvScQueR0wR+0ftnn3ncflQ1dFcmN06sZ6iNi1H9ABjoFIKs8ZD6p/9sVmd4ZNlgRjfPJ+d/lPjm9rua1EyYgSzCV9wQ01jPrc3EdjuL9BozDw/Ct1pQsnfQuXb20NmfK3exDXZMSY0wlY93uWwxPr4RXmOMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwblWNhy6rkdZekYjwy+EpSXq5C8MF86BVojcxTGfTo=;
 b=xdJdaHv0s0eo8oR93lRsJ7txexrFi9k16fkVvAf2P8oJxmvfkkrYOvOuROId5yf7uMdf/lO/AQGpvFk1QX98mtI9992sW2Jz1PSOdbX9+q5Q0fNIPyXg9rED88bxWYurgJi9zSEPiS6TU60gxoTrPm6nDjUKche7g0bqXVD/GrOINR+C61WmA3swktbIMFyPHBDClR3CmDX/zVBFp0jt8CofzYVvJiVedYKKrfN0kOFDC6ug+Ng8lDAkiwKJ5NTCht6RjB7MJ/splLJcZL1v+A5v1SSp5qV2HN2pVw9ImEPk4T0zaAmvdcFJHYTgGyOW1ZZK8CAOn7UqkNP413wHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwblWNhy6rkdZekYjwy+EpSXq5C8MF86BVojcxTGfTo=;
 b=i8Dkzi1sfejzV0mOjVk+6KeW0BBBVQKoNoJAvaBKb2nUspNcxP2JYh8tMWXzvvlNCGyYEodlqkhHlbovK/WfJIirxKdfW4p9NKxVMXnKPnRm909zEfwBizMEg/2RgtY5WPvsbEP4Yi9YkuzBGpfJQjuEUkHxWchplev2iJt3yNTcHD0zxve8Vl3Vxm5hrVSexTicDVPQWIlmyCbqPNRhKTiP3QXqlOxkhCd9cn+YDMvYDK/d0t55WcpoY32LbxyqMrzfcCVPdWyKPIw8qsacUbhlQdkdxkgXVFOgpZ3RfWDwlQHyDk370A84wIF+4HFfNdXvRbsxhg7blc5PQWP91Q==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 03:53:55 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%6]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 03:53:55 +0000
From: <Rengarajan.S@microchip.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <Woojung.Huh@microchip.com>, <Thangaraj.S@microchip.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net v2 2/8] MAINTAINERS: update maintainers for Microchip
 LAN78xx
Thread-Topic: [PATCH net v2 2/8] MAINTAINERS: update maintainers for Microchip
 LAN78xx
Thread-Index: AQHbYeVfX/I+HGjbc0Kp62CZGmc1a7MNz6oA
Date: Thu, 9 Jan 2025 03:53:55 +0000
Message-ID: <43dd36b3397eab1d5a3b1dbc380bb303612914a2.camel@microchip.com>
References: <20250108155242.2575530-1-kuba@kernel.org>
	 <20250108155242.2575530-3-kuba@kernel.org>
In-Reply-To: <20250108155242.2575530-3-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|CH3PR11MB8563:EE_
x-ms-office365-filtering-correlation-id: 4d376f1b-8d15-4970-6655-08dd30613d14
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?anB2RVdDMllyNUtxUnllcUhZTW5uT2JmTUY1QjVmc2pBQ0hPdm5ObmpRR2tU?=
 =?utf-8?B?d2FnZ3A2c1VLVmx0U3NhUDIwbkVFbWJ1MFF2YnM5ZUZTNzlvSzA4SW5uRVZT?=
 =?utf-8?B?eEhVUUIybzB5UUVRbGM2OWJCM1NRNFpBTVhUcFZsTktKRlRSRnJlMDNYRDUr?=
 =?utf-8?B?ZUJNTFlzUWdVYTZTdHJ5UDl4N0NBQyszQmdKRFc0S21hd0R2bERRZzZScWY2?=
 =?utf-8?B?b2h4TlVHMmd2dlIwOGlyRUtrUlUvVkxjNng3UEZvdUd0V2luUFM3NHBqVzlI?=
 =?utf-8?B?SHNVUUs5M0ZQWXY2cFpPVFhOczkrVSt5V25OeEljZ3FOS1VIaDN1L0c0M1JF?=
 =?utf-8?B?ZGJxd3NjclVYRHEzMndhN1JKZzAxeHZpRjhDTEdGRE52YjU4ZmFtNHZGMUlM?=
 =?utf-8?B?Uk5kTUhPaEVUUGFFZXlIbDB0L0xFRDlTZ3F3UEJ3Z1NxcC9DL0lTZ2JlTk8r?=
 =?utf-8?B?clQ2TUU5cmhaenlPVVh2VEpmbGtCaUw1TjF6QmhSN1p3Vm5qSVRiR1RlWnht?=
 =?utf-8?B?TEFqYTFzQVRmZTNoT1VocGt4M3ZlZWw2b1NWRW1ob2kxYW5JdnlOSEVycnM0?=
 =?utf-8?B?bWNObVdHOFZ5RzVNZFBFVDh5ZXN4QUxEZThsUk5yOThwUFN4QkRxeGVyZmZT?=
 =?utf-8?B?WmREcmVJdEtTTXBUWVRKM0NDd0dIekR5SWZ4RDFaWlpHQ2MzbVJYalhLVHFh?=
 =?utf-8?B?SHNJbkR5a1JoekdsNi9NOWpnWGlpVXh4bzZ5Wm94ZU5uLzcxTURaU1FXNldl?=
 =?utf-8?B?R2FpSmM4ZTdsSmpvSHNGSHpkR1AwQ3k3ME9vVmtNeDJWUWVyQXJzVExnTXk0?=
 =?utf-8?B?d05heXNNNzYvbFV6WlF1RlVTQWZneVFldkVhRGZVakpFSkM5OHR5cDFXYm9H?=
 =?utf-8?B?UDJ6WkJROVRUTmJIaWdWdFQ5dWJBQ1dWR01HSFQ2U2l3WkorSDh0UjV3K0N3?=
 =?utf-8?B?R1hxbjluMG44RWdYR1l1dElNT09YbS9kOVVFeUxWSEZDK1JKYTZ3RTRvM0hr?=
 =?utf-8?B?aExQVU1ORHY5eitxcXE2Z0JJU0tyWDJ3Ymo0UkE4THgyM2Q3TkpKeWNwN2V4?=
 =?utf-8?B?WHNvVWQ3Zk4zQlEwcXB2ZXFmclZHYWtTUms3M0tvcEdGaVEwckdXbVRUOHVn?=
 =?utf-8?B?UVc4Q09FN09ESTNKdy92ZWd4b0lGVU9aVmI5cGZOUXFMclVGZmpoVVhubjQ0?=
 =?utf-8?B?N1BsNkhZNXF6TmIzNHNQdFErZS9scFJLYU1QZ1pWdDZJbU1yb2ZTeE53WVFv?=
 =?utf-8?B?aTFPUjVZdEtzQisraU1jZGk4STFNeGVPWVUxc2pVSHRjbnFDL2RCUzN1Y1Nx?=
 =?utf-8?B?eC9TOE80d01OUlZiMnFLVTF2NE5ibTlKamJCQmpiWExSQW43VjNxdkowNVo0?=
 =?utf-8?B?cjRld0t2YlFCQVRadFdvUkNBaE1nTzdhUDJBcXZRZld2Q0N6YWdOa3poM09Y?=
 =?utf-8?B?N1lhNjJsa3o1QnljRDRaRGVSckx5MGFYdDVlbGV0MXgrdlBHb1h2dW9GaFJL?=
 =?utf-8?B?NjF0UFdPeWNkQ2lKTlpVcVVlUCtBK1hnUjE2VW5KS0lpZmJkK0V2dWdxV1d2?=
 =?utf-8?B?UUZ2Q3dkcWtQbUVVOGE1aFc2VGVDMVF4RmlreU5JeFM2T0tVYkV3aVd0M1Ji?=
 =?utf-8?B?VGVIb29GeE1qb1lFUTdPbEpIL09JMVpjNmpxa0psS3JVeFYwWjdacVRIMWV6?=
 =?utf-8?B?SXhIaUpBalA3QmJXSGg2WDg0WkRuaHlkS05BOGhKSWVhcXRjUmpHU1RoYWhy?=
 =?utf-8?B?My96T0lnWC9wbzdzRG1rREdXb3pFaXo3THZUUkczK0hpd1psSER0cHl3TXFB?=
 =?utf-8?B?UEhvYllYZkpsakF4aFd3SzFMTGZONVRSNjd0L1U4ZllMMVFIZzZHMWRtWkJj?=
 =?utf-8?B?RnR3UDErd01qYi93MHBzWkdVbG9Wdm5zUTNCRnBQTlBnMHRIdkJKaDZ3eFNz?=
 =?utf-8?Q?kUZCzrSoKAbkX7L2gFheM5btDjObb55+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czhqTHkzWVNRZTF1SXFiYWhSaHRaVkFsekhIb21Yd3FtNGJpZTEwajdOanJv?=
 =?utf-8?B?MUtkWWdjWEdXMTk5T0dScjU4OHJjM1ZyTzREOVppUDNWRmN5clJ1MEt3K1dR?=
 =?utf-8?B?VFNDaFV2OVhpMEs2cUo0bXYva1NsRDBNM01MdnJZMDZ2ZUU4R01NN0d4bzE4?=
 =?utf-8?B?SzlHRVpTbnlXKzU5S3VBb1pXSXFHdGdzQVRGQitVejJHS1FEU0tlR3d6bnNP?=
 =?utf-8?B?S28zNW5sQWhYUGpNSENaT2IwTVpxWFlCR0xRTzJHNnNKQ2ZUMkpGOFRJS2Fz?=
 =?utf-8?B?WGJnR0gxcmRBNThVVGdYVmtxU3ptNVBjL3EraGV3aThZZjFGMHZRcXRmN3FN?=
 =?utf-8?B?WFptZmVJVXJuaktwS1pKQStoUWZRNkkwbmNXanJNajB4Tis4WW1aUFRIT1V0?=
 =?utf-8?B?R2xBenlFZEV2LzNZT296eTV3ZlRoZWlIQ3RpSXMyZzg0TGpkNmZ3SkJqUk1D?=
 =?utf-8?B?UlNhUjJSUGNkT2htRUFtb094MDBkNG5ha0RvQWh6MDRTYlI5RnpHNkFXMTFk?=
 =?utf-8?B?NkJuNUpURkRxM0VRczlrc2ljUWxRMlhBanZobFVYamw0Y1UwaFVQV0lpUm0y?=
 =?utf-8?B?a2J5WUs0SVI2VTlpdDdBM0tqN3dpOTdPbXBDU21mM1FQNnB6aGxSQUxRSGtw?=
 =?utf-8?B?QTBsTnJuU0hiVVY5b1k3TlVHSHRteXFKOXExbyswbnlBUTVzYXpVaEovUGxH?=
 =?utf-8?B?SitaMXBKcGwwZllTa1pnWVhvWEc0WkJTUUNEUFlJcnkxNUh6TGVxY3RtWFIx?=
 =?utf-8?B?a1oray84cnl2c0c4V2cyTjVPa3V5OU83WDIyTzh2aWJSQjNTeExtRUdzR0ZN?=
 =?utf-8?B?bmlKa0JQODI5dFZYL2pnN0xVNlJsM3hmTnI4MGpQRzFvL1RPbDJtc0xhRW9u?=
 =?utf-8?B?aUI0U3ZYeE1ocEs5UkdHeFFYRnJ2VFNyMVpkeTdSeWJrT0lWWDhmZm1WYTc4?=
 =?utf-8?B?K2JaTzkvRjN1UW5OYkFqSzVMVkhGdUsyL0RLTER4WVlwWnJSaTdNMFU2bDFY?=
 =?utf-8?B?VXZYRGZSVXVIbWZlalNpTFYxQTB4cysya24vWTdVZTE0RzRZUjFUcHc4K2NI?=
 =?utf-8?B?VmU5TXpVV2xLV0d0WFBtQ2ZzUzg1Z1RhUUF5ZUJPNEVIRVczQ0xDY3NSQThV?=
 =?utf-8?B?TENjM3l1R0hNdWEyZGJZNXVLRnhMWndwRkNRVTNKQUZ6MjF5d3NDdzN6WldP?=
 =?utf-8?B?UDdnbXl6N2RkdTh6ZWxvbmdtRkdYVTNKa1UwWVl3aTI3WDdhekxGVVp2V3Ez?=
 =?utf-8?B?YjZzRE12aktzRWRGclJyR2FpeUpOSUlvMlpOeVBEZVE4a0VreGJ5cnJyTXND?=
 =?utf-8?B?TWVDWHg1NGY4MGV5S1IrYkR4eDY0RUpuZzFzYVRveFF1R2dTd0NSanNuOTRX?=
 =?utf-8?B?T2p3RElFWHFEdXNrN1NUeElMTmlrMmRoRTg1SlcxV2Z3K2tWVFE0UWgwdkND?=
 =?utf-8?B?QkdNWXRITk1tNUczVGdrZWdMMWwrcTBwY0JlRXFXVEo4V3pHR3l6NmJwenBD?=
 =?utf-8?B?RVZpeGpwM2JTdmk2cWc0VlV2RExqbkdWb2F3RFpvdld2UEJ3Y2hKbjJrUTRB?=
 =?utf-8?B?OXFnTWRkSnJHZlFoWlo0OHBaQVJNN3NvMWJnOFQ0NlRTVG1ML0NnVkNuWmNE?=
 =?utf-8?B?OGlMNm9aZ3hLY0l1QUFCRlhCd0hFck5abkFNbGNhRlV4bUs0cUgzY1c0aHNJ?=
 =?utf-8?B?bWE3WmIyVWZtcDVacXJOczh4RkpJK1AwNkZENWxpUG5JN0NDUFIzN3lNaGNp?=
 =?utf-8?B?TmN2ZzZEL3YwazBqOGpwQnh2SncyTzkvSGNBaFBDaFhJQ2J5VUEzN1ZTWnlP?=
 =?utf-8?B?ZFl6eEQrZzdmV3h3UkI1ck5Xa2RPWDBTZ0ZkYjVuc25FNFlHbTZEOWxxSVZH?=
 =?utf-8?B?NUpnNm5wU1RpYzRDeS9kYWZJTk92bmxDY3FicGc1Q0N3c3VPQ1ljclpDN2Fp?=
 =?utf-8?B?Qlg2aFdlZ0dHS0puelA0TDAxem1aUkhtOHVHM1o1NzV5amxxRERkek5wVGoy?=
 =?utf-8?B?WlVFRldsSU9Xck9TWTh6Z3Fna0JzcWcySTNLYnBWdVUxdFo2THNCOU5NbVYy?=
 =?utf-8?B?Sk93ZlU2MStWSUhzL0xLZ1VXRFc4ckYzNzBCS3VpdFBOalFtVmFobVhLbjhZ?=
 =?utf-8?B?eU9vQmxkbXcrVzkvSUlqRlZ4SXVYcUFJMUlFUjZFcDhyTTJ5d2lvWG1NS3Jn?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE42B284AD1BB644A6A8527A82D7CCE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d376f1b-8d15-4970-6655-08dd30613d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 03:53:55.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DVSzfsSoDGwzRVW9Ljr3i9HotdY4viVWO0Q/xLzvjMMrPwe4DMzQG1f7jYAzRj2Bz2iaU+wBDxPNDNnfYgQkgidRoYJ7imDYjKAryst/eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563

T24gV2VkLCAyMDI1LTAxLTA4IGF0IDA3OjUyIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBXb29qdW5nIEh1
aCBzZWVtcyB0byBoYXZlIG9ubHkgcmVwbGllZCB0byB0aGUgbGlzdCAzNSB0aW1lcw0KPiBpbiB0
aGUgbGFzdCA1IHllYXJzLCBhbmQgZGlkbid0IHByb3ZpZGUgYW55IHJldmlld3MgaW4gMyB5ZWFy
cy4NCj4gVGhlIExBTjc4WFggZHJpdmVyIGhhcyBzZWVuIHF1aXRlIGEgYml0IG9mIGFjdGl2aXR5
IGxhdGVseS4NCj4gDQo+IGdpdGRtIG1pc3NpbmdtYWludHMgc2F5czoNCj4gDQo+IFN1YnN5c3Rl
bSBVU0IgTEFONzhYWCBFVEhFUk5FVCBEUklWRVINCj4gICBDaGFuZ2VzIDM1IC8gOTEgKDM4JSkN
Cj4gICAoTm8gYWN0aXZpdHkpDQo+ICAgVG9wIHJldmlld2VyczoNCj4gICAgIFsyM106IGFuZHJl
d0BsdW5uLmNoDQo+ICAgICBbM106IGhvcm1zQGtlcm5lbC5vcmcNCj4gICAgIFsyXTogbWF0ZXVz
ei5wb2xjaGxvcGVrQGludGVsLmNvbQ0KPiAgIElOQUNUSVZFIE1BSU5UQUlORVIgV29vanVuZyBI
dWggPHdvb2p1bmcuaHVoQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBNb3ZlIFdvb2p1bmcgdG8gQ1JF
RElUUyBhbmQgYWRkIG5ldyBtYWludGFpbmVycyB3aG8gYXJlIG1vcmUNCj4gbGlrZWx5IHRvIHJl
dmlldyBMQU43OHh4IHBhdGNoZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gdjI6DQo+ICAtIGFkZCBuZXcgbWFpbnRhaW5l
cnMgaW5zdGVhZCBvZiBPcnBoYW5pbmcNCj4gDQo+IGNjOiB3b29qdW5nLmh1aEBtaWNyb2NoaXAu
Y29tDQo+IGNjOiB0aGFuZ2FyYWouc0BtaWNyb2NoaXAuY29tDQo+IGNjOiByZW5nYXJhamFuLnNA
bWljcm9jaGlwLmNvbQ0KPiAtLS0NCj4gIENSRURJVFMgICAgIHwgNCArKysrDQo+ICBNQUlOVEFJ
TkVSUyB8IDMgKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0NSRURJVFMgYi9DUkVESVRTDQo+IGluZGV4IDJh
NWY1ZjQ5MjY5Zi4uN2E1MzMyOTA3ZWYwIDEwMDY0NA0KPiAtLS0gYS9DUkVESVRTDQo+ICsrKyBi
L0NSRURJVFMNCj4gQEAgLTE4MTYsNiArMTgxNiwxMCBAQCBEOiBBdXRob3IvbWFpbnRhaW5lciBv
ZiBtb3N0IERSTSBkcml2ZXJzDQo+IChlc3BlY2lhbGx5IEFUSSwgTUdBKQ0KPiAgRDogQ29yZSBE
Uk0gdGVtcGxhdGVzLCBnZW5lcmFsIERSTSBhbmQgM0QtcmVsYXRlZCBoYWNraW5nDQo+ICBTOiBO
byBmaXhlZCBhZGRyZXNzDQo+IA0KPiArTjogV29vanVuZyBIdWgNCj4gK0U6IHdvb2p1bmcuaHVo
QG1pY3JvY2hpcC5jb20NCj4gK0Q6IE1pY3JvY2hpcCBMQU43OFhYIFVTQiBFdGhlcm5ldCBkcml2
ZXINCj4gKw0KPiAgTjogS2VubiBIdW1ib3JnDQo+ICBFOiBrZW5uQHdvbWJhdC5pZQ0KPiAgRDog
TW9kcyB0byBsb29wIGRldmljZSB0byBzdXBwb3J0IHNwYXJzZSBiYWNraW5nIGZpbGVzDQo+IGRp
ZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDE4OGMwOGNkMTZk
ZS4uZjJjYWNlNzMxOTRlIDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlO
VEFJTkVSUw0KPiBAQCAtMjQyNjEsNyArMjQyNjEsOCBAQA0KPiBGOiAgICAgIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbnhwLGlzcDE3NjAueWFtbA0KPiAgRjogICAgIGRy
aXZlcnMvdXNiL2lzcDE3NjAvKg0KPiANCj4gIFVTQiBMQU43OFhYIEVUSEVSTkVUIERSSVZFUg0K
PiAtTTogICAgIFdvb2p1bmcgSHVoIDx3b29qdW5nLmh1aEBtaWNyb2NoaXAuY29tPg0KPiArTTog
ICAgIFRoYW5nYXJhaiBTYW15bmF0aGFuIDxUaGFuZ2FyYWouU0BtaWNyb2NoaXAuY29tPg0KPiAr
TTogICAgIFJlbmdhcmFqYW4gU3VuZGFyYXJhamFuIDxSZW5nYXJhamFuLlNAbWljcm9jaGlwLmNv
bT4NCj4gIE06ICAgICBVTkdMaW51eERyaXZlckBtaWNyb2NoaXAuY29tDQo+ICBMOiAgICAgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZw0KPiAgUzogICAgIE1haW50YWluZWQNCj4gLS0NCj4gMi40Ny4x
DQo+IA0KQWNrZWQtYnk6IFJlbmdhcmFqYW4gU3VuZGFyYXJhamFuIDxyZW5nYXJhamFuLnNAbWlj
cm9jaGlwLmNvbT4NCg==

