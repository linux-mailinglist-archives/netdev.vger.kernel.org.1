Return-Path: <netdev+bounces-177756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A3A719D1
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC873B58E8
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917835968;
	Wed, 26 Mar 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fy5KWDbo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFCA48
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001391; cv=fail; b=Um80kDa4KFuQXMDazs98onaHVtdpedldiGRxmcnrJTWYLH/6m03fmIvEc51el5sPBfskfYqAFah7D2sYTEuMZvnfEBTa7WK/jY67KhLezVZ6sZudzYK83pMgL/HjpDDTKCpzhLA/MGtPYE2IwNVWGAFnw+GhmD+Hd6zHbMZ63Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001391; c=relaxed/simple;
	bh=SCXolIexl6MzbV61hmfJcZ5o5TDxpz4ByPNPIPw1zJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NVertmaMvgyh5SWsY3ArwKXoZcKzw+KXPTZx1OsaYeGcnPZfSLohRZdwp9Z2ugP+eaM+s16+icoQIdMcKrk5THjQAu8gtpyTejSpTvsLzfD2Q/jkcxLbVRD6q9V1KIju5qE4pzWj93CYv8QJpfBjQFV+7OeR/NVpFAr+6CwOAnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fy5KWDbo; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf3/IM0Zxa16Ct/yvuvEdaEEd7hRurlN32eG3REy6yU0oXxCnXMyGv6+kEcIx6/omFrvlMgfd0S7aip7Wwe20w7X7unkG9IRHnHAzrZTLIljrVpDCfT4gi9JPpuvNmSolbRDb3F0tmM/074APpiz6XHFrhp/Wep5D1QAdWLKIEgCgCqybX2v2v+ImyhYEzfS4Ffrn0f9HFVtEEH8TltT/9RGwPXtoHlGfkiMQJHOSRpMWJuaNBt7Pv5LdSBbS7o8c8W8UY+i1UdOCda1VwT812qj/ZLUQ0jK+vBZnIuKhCP598KDe2u10Te8yW0bc0n6NZAtxjL42tf/GIQRn4DaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCXolIexl6MzbV61hmfJcZ5o5TDxpz4ByPNPIPw1zJU=;
 b=uRMyQlOwng9SeRvEJ1+Owooxgva7Bsk+2Zo5ToeYJ0qHW4yvO4XSgWDiBkGRzNrioc9ANdpoFNysyeIMNab9U0lRex58OODVHS+y/amhADC8XAXfYCRjLYtu7+HGQrnyJKNsW4qbq/QfDsyHDcvIssCV9CA+s5ElxcW1kX04r78P/Q7OcxXmsZyRb2ExD+/p4tzSyuJP+y0LxTwcasQP7HJei3KJL1NjnFVFlAXECdqQM+ZN1JxqDhd3oMgR0r8r4U5l0OqV+jkbKLlUoKX9LvG0viRmhBvdLRxI8x25p3yvOZIZ6bmaOq8/DyoKqYgi5FfqumeJ6qS5c76znvCQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCXolIexl6MzbV61hmfJcZ5o5TDxpz4ByPNPIPw1zJU=;
 b=fy5KWDbojm1/AgYBUUI0Z9QXH9HCzkJfidAzvQoDUZXQNDYIJjtPurekeP/LKVTkoy4/fvfK0OjmzDsmj36fOGURd16MqH7JPZKlkNd4LjmJqXrhPrJ9wN0Oob/AYXmrqAmgfYodIVRNfHNfTvZZ4cxDTFE/wjoLN6zAEEQQ+/+vUcNUYvjA4i1GOanGowKVltElzaqYM1u7FLD/ErZPx0XpmSxwUBVp+GlSYNG5EwUbtPL9iI9NLZWD3fD+Ufx0gVFyxlT096rC3PWcGhEVz7L6sqKBRFh3UQQK/VqWitDmmfGb9OBQQBw/xNRuYuGGCKk9IpOgZKYgfZUBnWneyA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 15:03:07 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:03:07 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>
CC: "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Topic: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Index: AQHbnc04GLropLE/UEietC5IV/U+Q7OFhLuA
Date: Wed, 26 Mar 2025 15:03:07 +0000
Message-ID: <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
References: <20250325213056.332902-1-sdf@fomichev.me>
	 <20250325213056.332902-3-sdf@fomichev.me>
In-Reply-To: <20250325213056.332902-3-sdf@fomichev.me>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SJ0PR12MB8089:EE_
x-ms-office365-filtering-correlation-id: 848bd9d8-616e-4535-8ad3-08dd6c775109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDRXcXVWcm13cXVhWnRtUmRBUUFCMDVEWnRTSFQzMWE3YzJnN1orRnhRTXVQ?=
 =?utf-8?B?bFNNMzJHSERoV2J3bmZDYkw1SUJ2b2kzVnVBeWVJZHl0dnVxcXRmN1FVb0N6?=
 =?utf-8?B?anJTelF2bTg0QUJxL3MyQllNNU1KL3F6Z2NmR05naFh2YzRzQVFtaHprVVpq?=
 =?utf-8?B?KzdGOWtHVTZuRVVtQzh0WUs3TXorenJPNkV1V1BSbWswblN4c0hEUlFpZlha?=
 =?utf-8?B?VVZSTG1PeUt0ZXVralpKMXNYb3RLdzJzMkphcngvdEF2TDBObVczenNQM1Zv?=
 =?utf-8?B?aDNONU9NYzY1ZnphMG5scHYxdDBKYS9sQjR0ZnVJK3I5bFFrU3lqdDcxaDJ1?=
 =?utf-8?B?QWV1ZFhvMWwrWERTVSt0Um1Zd3B4aG5DdmFPUzdLbW9abUNWSXdoaFRQWis3?=
 =?utf-8?B?OFQrdWY0UVBONHlyQi9PR0FsRFk4S2MvTEVVTm1nbG1xRUlFSGxoVllLL084?=
 =?utf-8?B?cm1pV3d3dGRxRG1nOGI5Q2J0WTEvZmFKbGh4NUJUb3F5MzZ0VnZETGVvQWVY?=
 =?utf-8?B?UExJVmhPa1V0TTdSRklZVEVjZnZteHlnbWZSMGpoYnBUUFhTOXhVSjBCRnU2?=
 =?utf-8?B?S3lwMlo5U1d6ZHFnaXV4bVE1Smx2bG8vaGtodE9jcG9kNGpJTkVpT0RqWEVp?=
 =?utf-8?B?aDIzc0VLWUdXRHptQ21Lb05LNFVFVHdJdFE2Mndob2dyUWhmUDNYZ2cxa2Zi?=
 =?utf-8?B?VC9zeHg5Y1E2a3pPb2FUL0d3TVRhRUxMYWJoaG5sWEhtUlo2djNiS0lwZE5S?=
 =?utf-8?B?eEVkdnM4eXZMTjRORDJPRkN1YzZlNlNhYS9IWEVaYmVIUU0yUmlnbzdtcWk1?=
 =?utf-8?B?dFhVV0ZDT1FBSUpwMzBiZ2hhUGpHMmw0cGt0WkZwS1lCcWtMT0dETUlhMml1?=
 =?utf-8?B?eEF4Z0RnSjBxd0IvNFZqL0lRelNiQi9hc09QWlFCVkJTTk5vUHJzeUliakhD?=
 =?utf-8?B?eDdtUzlQMllUcFZaWjdrejlYWnVITVh6VytkeTNWV1ozT0YwbFlKcDZUakIz?=
 =?utf-8?B?RXI5TTBuNk9LSW5mdHFpeXhMRks2Rlc0OXZLZjEyVUdodUdLU3pwZkpiYk9X?=
 =?utf-8?B?TUVMYmJEL3ZnUVUxRk02dXBkMUQ4b0RPRGNCcXE5bjVXcURJaFNCZjNJKzFQ?=
 =?utf-8?B?TmRLYXZwM3EyelloMkZ3YS92TzNVWUFEa1plQzRqQ05VMjZzTk05T2NSWVJx?=
 =?utf-8?B?ZWh2VUQ3OEhRRVFlVkpqSEhlcUJMV0xGR0kzQnFQUkE5QUVhbW9kYkJnd1Jx?=
 =?utf-8?B?Mk92TituWXBqWmJ4cGtGQmwrUTNRWm1tbkFZYmtkNUxjQmVyc1V4eTFDczBG?=
 =?utf-8?B?UlFUdU5QeUJkZlBBMGlLN3VSNzhYVEhjZ3VRZjdVYXJSUllFdFBWZ3lNSnc1?=
 =?utf-8?B?SWYzVGdsZTlScVl6ZVMydlpUd1Q1Lzc5V3ZCVUE3SmN6RlhkTjRZSGVCSlQ2?=
 =?utf-8?B?QkZWdmhRYjNVcit1TUFVUG5EUTU2RFJMeDdWUlZvc0VaT0ZWb3pJc083Q1BF?=
 =?utf-8?B?VmpLdFJxcStmRllqVWdac1JJU3BYRTdsSitnYWRubldZSGFZTlZ5TkR3N0dw?=
 =?utf-8?B?YzRseUREalBhNmh4L21RZGtwVzFWMEtYYmZ2SVlZTHYrT2ErZThqOC8rWFRx?=
 =?utf-8?B?QS84ZDVNSGpUSTZiWHcwdGlFMGdSeGtGZVRYOFMwL2FaS21GekVZbVlqTjVX?=
 =?utf-8?B?N1lUY0c2QjJNUHk0S1FhZnZ0VGt6alFWSlczSlgxVjFCMTZEUDVjWUY4K1Fm?=
 =?utf-8?B?eTMzOXRGNkYyMVZiWDJrRzZJRTdSRDl1SXc0Q29Ram95RktlU0NZTVltV3JN?=
 =?utf-8?B?SHV6cEI2UmNnanlZbklUVnhFSVc4SW1HMm9QdWcyejRFSFFycy9QdjA4NWZ2?=
 =?utf-8?B?d3hKN3JiQm1TMERqOGl5RUFPQWZoZWkwNlR0WGdYK0NMWjkzWksrVGZkMjlO?=
 =?utf-8?Q?0LTuRYccenDKjINfrVflmKYSyrR0WWUz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHFBOEtsRjg1RUZKdmJMaElqd0NodElrQURUNTRPejFoQTVOeUE5ckhKWlI0?=
 =?utf-8?B?bFR1STEwSWpVckhJby9BUHZERlRUSldyRXdBbUhTb1RnR2pMWHdIV0xHWmNW?=
 =?utf-8?B?eUZIbXFmbXpNdytJaTZya3JzdzFpQ1d1VU9MNTZGU3BBUHpkdHl3WjNtRU1O?=
 =?utf-8?B?c0RubTB6czJ0RmNXMjJQbnhrVEhzdExKcFhLZWdwY3dFVUxOaGh0YUY5U3Ru?=
 =?utf-8?B?QmVMN2xDMk1FZlhNZng5U2dIdlc2cmVrYW1adHptQlR0NzAyay9JTldFMzY1?=
 =?utf-8?B?MzFXSTh2akhHc2FCZWpFVDRnY1puVU5qNm85QUo3azlwblU5eGRJRkVRYlp2?=
 =?utf-8?B?cFZyc3BIZkVDTWJHWnorbWthZDRXWklqdTlWRFRVeTFZbzBxaDlNdGp1a21X?=
 =?utf-8?B?dDdxbm9mSnRlSXZjaWN4dmMxQXB4OHpTMU1xLzZjMlZERUlXejhCRnJSS1NK?=
 =?utf-8?B?bEh5aHpMM2Qxa2NUWmZ1RGEzMUJkT01HSW9kVXJzV3hZZVVwOS9qVGxqUkZW?=
 =?utf-8?B?c1BxQzFkVmxxbnRRWTRwaFBsanIvSVl6amVMQXVxRVJKVmpBTTBEcTBmUXBE?=
 =?utf-8?B?QmJWOStwZWdta2xGbzBMVGFib094b3piNng1K3NDcE13S3F3ck00WjhCeEZq?=
 =?utf-8?B?Sm1lc1krbkN5Y0ZYcEVIYlVFb0h6aStBT0pBN1M4eGhpQlFZRU16bllScXMz?=
 =?utf-8?B?eW9NUVpUcHBuSTNkbk9uZitlUHNhYUFwd1M1VGVtaTJDbnhnbjI1dHFTaCtC?=
 =?utf-8?B?WXI3MDF3eXJpRUVnajh3SGVzNEtGM3ZoR0ZVUWdxRUR6dElUV09NS05GN1J6?=
 =?utf-8?B?MGNGQTlFZlZiMUx6K2ppN0N5a0hwd01iTFU5bnYvL2R4UUViaWFyL3V3UHgr?=
 =?utf-8?B?M2F2S25ZbmtqRW5UNWRsdjNxRG5TZC9iTHUvcUdRTW5sUko0Z0hxWFlTNXdQ?=
 =?utf-8?B?TnN1MG1CcG5aejc4Ymgvd3ErY0gvNjNVTXFFSEdxVElETlZxWjN1TzBXZ29X?=
 =?utf-8?B?WklaZUhZSWI4SlF3OFpEWWU1Q3hrcUZoRUFITWpkaHRpZVBob1JBNUVtNnVv?=
 =?utf-8?B?Q1hKQlZ2eitSK25KQjNjTzBZTGl4YkdiSU9mNlBTSm1LYXoyb0lnc1hZT0Fv?=
 =?utf-8?B?dnRSVXZFWm85NHJNTFYwdm1DaHVHWjRGbXpYVnNkbThUZDVFWXlkbHE2Tkkx?=
 =?utf-8?B?a3RYNnRXbVh3elh3OHNQRmpXY1dGMEpSWkdIUkxaMUx3ODVTT1A3REtjSGZM?=
 =?utf-8?B?WFpUaEp6bU16NzE0akhrajBBR3hCdUsyY3VWVjNKZnBtUUFKWmhtRjJIV1dF?=
 =?utf-8?B?S2dRT3h2M1Q0NGozMytPTXVQTnBNRkp3bW1PVzlieWpaZFh0NTdoQ0V0Vmlo?=
 =?utf-8?B?ZWRHT0t0Qm85SDdpV1g4aURiMkoxTnNreGdxTGJzTTZRbE1Ja09BbzRscWxQ?=
 =?utf-8?B?dXZwK2JVQXhhMnE4MzZKSEJMaE93RHpqRnlKZDlCejlubjlxakIzNDR1bFFP?=
 =?utf-8?B?M0h1eUIxUnpxai90STZySko0SVJMYTBORUtCR0hSWXRSUk9TWnI0UmlGallX?=
 =?utf-8?B?RkRKQW5nYjlHdDNDTktFaVdWTitGL3hTcXhUaG9oaFpYWmV5SHZKVWI3djdR?=
 =?utf-8?B?UFlRWG1BUjhXditZNHovMXhpN3UvbWUxTm54N0Yra3RLbXFqM0RJWHFTTWRV?=
 =?utf-8?B?dHFTeEpLNUpnTEZJTW03K1B4OTBrWlRqU0JncTBmV2p4eXVrZ0dnU3hVOUVz?=
 =?utf-8?B?M2IyR2dkSXJ1MlJiSGlLWWQ3S0x5K0lOZmlxMzF0UzZKcTBhQ3A3SkVuYktQ?=
 =?utf-8?B?aTRaU2c1OFhwc0kwTGxrREtLTjBEaitZS0dEUklDWU8xbThtRHNsd2RLK0VL?=
 =?utf-8?B?MGJsYXZNZlIvN2w4aUlBMkNPbzllVGZTcTM3Wm1nL014Vm5PZUtMRHRFbzI1?=
 =?utf-8?B?QnlENUpJSU5CQk5hNE90M2lURnVpdE1KR3N5YXdCQm9ZTG1pNldIZDYyMTZK?=
 =?utf-8?B?UUtCcC82VjB2ZE9ST0ZZYTdqeWtJbFgweW1xMUt6MmxLWDBmTFlMZy8yd2sy?=
 =?utf-8?B?ZGJ5a1NhQk1acm5qcmFrRWZHSHpEdDdPQ2V2UXVWOUo2U0NsS1h1SnBYbUtw?=
 =?utf-8?Q?WPTqxkIP5vu5XoxQ8kTMY8VB2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5214CC56F930F479754E08CA2BFD8BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848bd9d8-616e-4535-8ad3-08dd6c775109
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:03:07.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pETUZ3MJnk9YJpO0YQ6zo29MDfA97R1w2gwp1hm8akdA4S2liM5TNIJlCl4aSIsFc8w0nzSB3tmEBs83XbXs0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089

T24gVHVlLCAyMDI1LTAzLTI1IGF0IDE0OjMwIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IEBAIC0yMDcyLDggKzIwODcsOCBAQCBzdGF0aWMgdm9pZA0KPiBfX21vdmVfbmV0ZGV2
aWNlX25vdGlmaWVyX25ldChzdHJ1Y3QgbmV0ICpzcmNfbmV0LA0KPiDCoAkJCQkJwqAgc3RydWN0
IG5ldCAqZHN0X25ldCwNCj4gwqAJCQkJCcKgIHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIpDQo+
IMKgew0KPiAtCV9fdW5yZWdpc3Rlcl9uZXRkZXZpY2Vfbm90aWZpZXJfbmV0KHNyY19uZXQsIG5i
KTsNCj4gLQlfX3JlZ2lzdGVyX25ldGRldmljZV9ub3RpZmllcl9uZXQoZHN0X25ldCwgbmIsIHRy
dWUpOw0KPiArCV9fdW5yZWdpc3Rlcl9uZXRkZXZpY2Vfbm90aWZpZXJfbmV0KHNyY19uZXQsIG5i
LCBmYWxzZSk7DQo+ICsJX19yZWdpc3Rlcl9uZXRkZXZpY2Vfbm90aWZpZXJfbmV0KGRzdF9uZXQs
IG5iLCB0cnVlLCBmYWxzZSk7DQo+IMKgfQ0KDQpJIHRlc3RlZCB3aXRoIHlvdXIgKGFuZCB0aGUg
cmVzdCBvZiBKYWt1YidzKSBwYXRjaGVzLg0KVGhlIHByb2JsZW0gd2l0aCB0aGlzIGFwcHJvYWNo
IGlzIHRoYXQgd2hlbiBhIG5ldGRldidzIG5ldCBpcyBjaGFuZ2VkLA0KaXRzIGxvY2sgd2lsbCBi
ZSBhY3F1aXJlZCwgYnV0IHRoZSBub3RpZmllcnMgZm9yIEFMTCBuZXRkZXZzIGluIHRoZSBvbGQN
CmFuZCB0aGUgbmV3IG5hbWVzcGFjZSB3aWxsIGJlIGNhbGxlZCwgd2hpY2ggd2lsbCByZXN1bHQg
aW4gY29ycmVjdA0KYmVoYXZpb3IgZm9yIHRoYXQgZGV2aWNlIGFuZCBsb2NrZGVwX2Fzc2VydF9o
ZWxkIGZhaWx1cmUgZm9yIGFsbA0Kb3RoZXJzLg0KDQpDb3NtaW4uDQo=

